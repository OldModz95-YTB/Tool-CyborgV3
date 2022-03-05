#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;
#include maps\mp\gametypes\_weapons;
 
init()
{
    level thread onplayerconnect();
	precacheVehicle("heli_guard_mp");
	precacheModel("veh_t6_drone_overwatch_light");
    precacheShader("line_horizontal");
    precacheModel("projectile_hellfire_missile");
    precacheModel("t6_wpn_supply_drop_ally");
    precacheModel("mp_flag_green");
    precacheModel("mp_flag_red");
    precacheShader("progress_bar_bg");
    level.icontest = "progress_bar_bg";
    level.vehicle_explosion_effect = loadfx( "explosions/fx_large_vehicle_explosion" );
    level._effect[ "flak20_fire_fx" ] = loadfx( "weapon/tracer/fx_tracer_flak_single_noExp" );
    precacheModel("german_shepherd");
}
 
onplayerconnect()
{
    for(;;)
    {
        level waittill( "connecting", player );
        if(player isHost())
                        player.status = "Host";
                else
                        player.status = "Unverified";
                       
        player thread onplayerspawned();
    }
}
 
onplayerspawned()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self freezecontrols(false);
    self.MenuInit = false;

    for(;;)
    {
                self waittill( "spawned_player" );
                initOverFlowFix();
                if( self.status == "Host" || self.status == "Co-Host" || self.status == "Admin" || self.status == "VIP" || self.status == "Verified")
                {
                self thread NewsbarON();
                
                        if (!self.MenuInit)
                        {
                                self.MenuInit = true;
                                self thread welcomeMessage();
                                self thread MenuInit();
                                self thread closeMenuOnDeath();
                                self playSound("vehicle_explo");
                self.swagtext = self createFontString( "objective", 2.8);
                self.swagtext setPoint( "right", "right", 20, -185 );
                self.swagtext.alpha = 0;
                self.swagtext.foreground = true;
                self.swagtext.archived = false;
                        }
                }
    }
}
 
drawText(text, font, fontScale, x, y, color, alpha, glowColor, glowAlpha, sort)
{
    hud = self createFontString(font, fontScale);
    hud setText(text);
    hud.x = x;
    hud.y = y;
    hud.color = color;
    hud.alpha = alpha;
    hud.glowColor = glowColor;
    hud.glowAlpha = glowAlpha;
    hud.sort = sort;
    hud.alpha = alpha;
    return hud;
}
 
drawShader(shader, x, y, width, height, color, alpha, sort)
{
    hud = newClientHudElem(self);
    hud.elemtype = "icon";
    hud.color = color;
    hud.alpha = alpha;
    hud.sort = sort;
    hud.children = [];
    hud setParent(level.uiParent);
    hud setShader(shader, width, height);
    hud.x = x;
    hud.y = y;
    return hud;
}
 
verificationToNum(status)
{
        if (status == "Host")
                return 5;
        if (status == "Co-Host")
                return 4;
        if (status == "Admin")
                return 3;
        if (status == "VIP")
                return 2;
        if (status == "Verified")
                return 1;
        else
                return 0;
}
 
verificationToColor(status)
{
        if (status == "Host")
                return "^2Host";
        if (status == "Co-Host")
                return "^5Co-Host";
        if (status == "Admin")
                return "^1Admin";
        if (status == "VIP")
                return "^4VIP";
        if (status == "Verified")
                return "^3Verified";
        else
                return "";
}
 
changeVerificationMenu(player, verlevel)
{
        if( player.status != verlevel && !player isHost())
        {              
                player.status = verlevel;
       
                self.menu.title destroy();
                self.menu.title = drawText("[" + verificationToColor(player.status) + "^7] " + getPlayerName(player), "objective", 2, -100, 30, (1, 1, 1), 0, (1, 0, 0), 1, 3);
                self.menu.title FadeOverTime(0.3);
                self.menu.title.alpha = 1;
               
                if(player.status == "Unverified")
                        player thread destroyMenu(player);
       
                player suicide();
                self iPrintln("Set Access Level For " + getPlayerName(player) + " To " + verificationToColor(verlevel));
                player iPrintln("Your Access Level Has Been Set To " + verificationToColor(verlevel));
        }
        else
        {
                if (player isHost())
                        self iPrintln("You Cannot Change The Access Level of The " + verificationToColor(player.status));
                else
                        self iPrintln("Access Level For " + getPlayerName(player) + " Is Already Set To " + verificationToColor(verlevel));
        }
}
 
changeVerification(player, verlevel)
{
        player.status = verlevel;
}
 
getPlayerName(player)
{
        playerName = getSubStr(player.name, 0, player.name.size);
        for(i=0; i < playerName.size; i++)
        {
                if(playerName[i] == "]")
                        break;
        }
        if(playerName.size != i)
                playerName = getSubStr(playerName, i + 1, playerName.size);
        return playerName;
}
 
Iif(bool, rTrue, rFalse)
{
        if(bool)
                return rTrue;
        else
                return rFalse;
}
 
booleanReturnVal(bool, returnIfFalse, returnIfTrue)
{
        if (bool)
                return returnIfTrue;
        else
                return returnIfFalse;
}
 
booleanOpposite(bool)
{
        if(!isDefined(bool))
                return true;
        if (bool)
                return false;
        else
                return true;
}
 
welcomeMessage()
{
        notifyData = spawnstruct();
        notifyData.titleText = "^7Welcome To ^4Project Ultimate V2";
        notifyData.notifyText = "^7Your Status Is " + verificationToColor(self.status);
        self iPrintln("Press [{+speed_throw}] and [{+melee}] To open ^4Project Ultimate V2");
        self iPrintln("Press [{+gostand}] To select an option and[{+usereload}] ^4To Go Back");
        notifyData.glowColor = (0, 0, 1); 
        notifyData.duration = 11;
        notifyData.font = "hudbig";
        notifyData.hideWhenInMenu = false;
        self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
}


 
CreateMenu()
{
        self add_menu("Project Ultimate V2", undefined, "Unverified");
        self add_option("Project Ultimate V2", "Main Menu", ::submenu, "MainMods", "Main Menu");
        self add_option("Project Ultimate V2", "Lobby Menu", ::submenu, "LobbyMenu", "Lobby Menu");
        self add_option("Project Ultimate V2", "Fun Menu", ::submenu, "FunMenu", "Fun Menu");
        self add_option("Project Ultimate V2", "Forge Menu", ::submenu, "ForgeMenu", "Forge Menu");
        self add_option("Project Ultimate V2", "Acount Menu", ::submenu, "AccountMenu", "Acount Menu");
        self add_option("Project Ultimate V2", "Aimbot Menu", ::submenu, "AimbotMenu", "Aimbot Menu");
        self add_option("Project Ultimate V2", "Flying Menu", ::submenu, "FlyingMenu", "Flying Menu");
        self add_option("Project Ultimate V2", "Weapon Menu", ::submenu, "weaponM", "Weapon Menu");
        self add_option("Project Ultimate V2", "Bullet Menu", ::submenu, "BulletM", "Bullet Menu");
        self add_option("Project Ultimate V2", "Map Menu", ::submenu, "MapsMenu", "Map Menu");
        self add_option("Project Ultimate V2", "Players Menu", ::submenu, "Players Menu", "Players Menu");
        self add_option("Project Ultimate V2", "Advertise Menu", ::submenu, "SpeakMenu", "Advertise Menu");
        self add_option("Project Ultimate V2", "Killstreak Menu", ::submenu, "streakMenu", "Killstreak Menu");
        self add_option("Project Ultimate V2", "All Players Menu", ::submenu, "AllMenu", "All Players Menu");
       
 
        self add_menu("MainMods", "Project Ultimate V2", "VIP");
        self add_option("MainMods", "God Mode", ::ToggleGod);
        self add_option("MainMods", "Infinite Ammo", ::InfiniteAmmo);
        self add_option("MainMods", "UFO Mode", ::UFOMode);
        self add_option("MainMods", "Third Person", ::ThirdPerson);
        self add_option("MainMods", "Change Class In Game", ::ChangeClass);
        self add_option("MainMods", "All Perks", ::giveAllPerks);
        self add_option("MainMods", "Visions", ::togglevision);
        self add_option("MainMods", "Pro Mod (host)", ::togglefovvvvv);
        self add_option("MainMods", "MultiJump", ::Toggle_Multijump);
        self add_option("MainMods", "Invisible", ::initInvisible);
        self add_option("MainMods", "Gun On Left Side (host)", ::ToggleLeft);
        self add_option("MainMods", "Clone Your Self", ::spawnClone);
        self add_option("MainMods", "Kill Your Self!", ::commitSuicide);
        self add_option("MainMods", "Speed x2", ::SpeedX2);
        self add_option("MainMods", "Hear everyone", ::hearallplayers);
        
        
        self add_menu("FunMenu", "Project Ultimate V2", "VIP");
        self add_option("FunMenu", "Health Bar", ::HealthBar);
        self add_option("FunMenu", "JetPack", ::doJetPack);
        self add_option("FunMenu", "Rocket Rain", ::ToggleRocketRain);
        self add_option("FunMenu", "kamikaze Attack", ::kamikaze);
        self add_option("FunMenu", "Teleport", ::Teleporter);
        self add_option("FunMenu", "No Clip", ::Noclip);
        self add_option("FunMenu", "Jericho Missiles", ::initJericho);
        self add_option("FunMenu", "Spawn Mine", ::spawnMine);
        self add_option("FunMenu", "Strafe Run", ::initStrafeRun);
        self add_option("FunMenu", "Spawn Bunker", ::bunkerthread);
        self add_option("FunMenu", "Spawn Sky Plaza", ::spawnskyplaza);
        self add_option("FunMenu", "Spawn Prison Break", ::Prison);
        self add_option("FunMenu", "Earthquake Mode", ::Quake);
        self add_option("FunMenu", "Fun Menu 2", ::submenu, "FunMenu2", "Fun Menu 2");
        
        
        self add_menu("FunMenu2", "FunMenu", "Admin");
        self add_option("FunMenu2", "MW3 IMS", ::IMSMW3);
        self add_option("FunMenu2", "Drivable Car", ::spawnDrivableCar);
        self add_option("FunMenu2", "Human Tank", ::Toggle_TankHuman);
        
        
        self add_menu("streakMenu", "Project Ultimate V2", "Admin");
        self add_option("streakMenu", "VSAT", ::GiveVSAT);
        self add_option("streakMenu", "Warthog", ::GiveWH);
        self add_option("streakMenu", "Lodestar", ::GiveLST);
        self add_option("streakMenu", "Guardian", ::GiveGaurd);
        self add_option("streakMenu", "VTOL Warship", ::GiveVW);
        self add_option("streakMenu", "Dogs", ::GiveDogs);
        self add_option("streakMenu", "Swarm", ::GiveSwarm);
        self add_option("streakMenu", "Spyplane", ::GiveUAV);
        self add_option("streakMenu", "Hellfire", ::GiveHell);
        self add_option("streakMenu", "Lightning Strike", ::GiveLS);
        self add_option("streakMenu", "Sentry Gun", ::GiveSG);
        self add_option("streakMenu", "AGR", ::GiveAG);
        self add_option("streakMenu", "Killstreaks Menu 2", ::submenu, "streakMenu2", "Killstreaks Menu 2");
        
	
        self add_menu("streakMenu2", "streakMenu", "Admin");
        self add_option("streakMenu2", "Stealth Chopper", ::GiveSC);
        self add_option("streakMenu2", "VSAT", ::GiveVSAT);
        self add_option("streakMenu2", "Escort Drone", ::GiveED);
        self add_option("streakMenu2", "EMP", ::GiveEMP);
        self add_option("streakMenu2", "RC-XD", ::GiveRC);
        self add_option("streakMenu2", "Hunter Killer", ::GiveHunt);
        self add_option("streakMenu2", "Care Package", ::GiveCare);
        self add_option("streakMenu2", "CounterUAV", ::GiveCUAV);
        self add_option("streakMenu2", "Warthog", ::GiveWH);
        self add_option("streakMenu2", "Lodestar", ::GiveLST);
        self add_option("streakMenu2", "VTOL Warship", ::GiveVW);
        self add_option("streakMenu2", "Dogs", ::GiveDogs);
        self add_option("streakMenu2", "Swarm", ::GiveSwarm);
    
        
        self add_menu("LobbyMenu", "Project Ultimate V2", "VIP");
        self add_option("LobbyMenu", "Anti Quit", ::ToggleRageQuit);
        self add_option("LobbyMenu", "Super Jump", ::ToggleSuperJump);
        self add_option("LobbyMenu", "Super Speed", ::superSpeed);
        self add_option("LobbyMenu", "Timescale", ::changeTimescale);
        self add_option("LobbyMenu", "Force Host", ::forceHost);
        self add_option("LobbyMenu", "Remove Death Barrier", ::toggledeathBarrier);
        self add_option("LobbyMenu", "Spawn A Bot", ::spawnBots, 1);
        self add_option("LobbyMenu", "Fast Restart", ::fastRestart);
        self add_option("LobbyMenu", "Unlimited Game", ::Inf_Game);
        self add_option("LobbyMenu", "End Game", ::endGame);
        self add_option("LobbyMenu", "Long Melee", ::meleerange);
        self add_option("LobbyMenu", "Ranked Game", ::ToggleRanked);
        self add_option("LobbyMenu", "TDM XP Lobby", ::bigxp);
        self add_option("LobbyMenu", "Flash Feeds", ::FlashFeed2);

        
        self add_menu("FlyingMenu", "Project Ultimate V2", "Co-Host");
        self add_option("FlyingMenu", "Spawn Helicopter", ::initPilotHeli);
        self add_option("FlyingMenu", "Overwatch", ::PHeliModellb);
        self add_option("FlyingMenu", "Attack Heli", ::PHeliModelah);
        self add_option("FlyingMenu", "A10 Thunderbolt", ::PHeliModela10);
        self add_option("FlyingMenu", "Pegasus", ::PHeliModelstlh);
        
        
        self add_menu("AccountMenu", "Project Ultimate V2", "Co-Host");
        self add_option("AccountMenu", "Unlock Trophies", ::unlockTrophies);
        self add_option("AccountMenu", "Unlock All Camo's", ::doAllUnlockCamos);
        self add_option("AccountMenu", "Level 55", ::doRank);
        self add_option("AccountMenu", "Prestige Master", ::doMaster);
     
     	
     	self add_menu("ForgeMenu", "Project Ultimate V2", "Admin");
        self add_option("ForgeMenu", "Pick Up Player", ::togglePickup);
		self add_option("ForgeMenu", "Forge Mode", ::ForgeON);
		self add_option("ForgeMenu", "Forge Ramp", ::ForgeRamp);
		self add_option("ForgeMenu", "Forge Wall", ::ForgeWall);
		self add_option("ForgeMenu", "Forge Grid", ::ForgeGrids);
		self add_option("ForgeMenu", "Forge Teleporter", ::ForgeTele);
		self add_option("ForgeMenu", "Forge Lifts", ::ForgeLifts);
		
		
		self add_menu("AllMenu", "Project Ultimate V2", "Co-Host");
        self add_option("AllMenu", "Kill All", ::killall);
        self add_option("AllMenu", "Kick All Unverified", ::kickall);
        self add_option("AllMenu", "Godmode All", ::godmodeall);
        self add_option("AllMenu", "Infinite Ammo All", ::infiniteammoall);
        self add_option("AllMenu", "Freeze/Unfreeze All", ::freezeall);
        self add_option("AllMenu", "Send All To Space", ::sendalltospace);
        self add_option("AllMenu", "Blind All", ::blindall);
        self add_option("AllMenu", "Teleport All", ::TeleportAll); //Just Added
        self add_option("AllMenu", "Unlock All Throphies", ::unlockAllThrophiesAllPlayers); //Just Added
	    self add_option("AllMenu", "LVL 55 All", ::LVL55All);
	    self add_option("AllMenu", "Prestige Master All", ::P15All);
	    self add_option("AllMenu", "Derank All", ::DerankAll);
        
        
        self add_menu("AimbotMenu", "Project Ultimate V2", "Admin");
        self add_option("AimbotMenu", "TrickShot Aimbot", ::initaimBot1);
        self add_option("AimbotMenu", "Aimbot", ::doAimbots);
        self add_option("AimbotMenu", "Unfair Aimbot", ::initaimBot2);
        
        
        self add_menu("SpeakMenu", "Project Ultimate V2", "Admin");
        self add_option("SpeakMenu", "How To Use Menu?", ::adverT);
        self add_option("SpeakMenu", "xDebugKiller", ::adverT1);
        self add_option("SpeakMenu", "TeamLogicModz", ::adverT2);
        self add_option("SpeakMenu", "Dont Ask For Menu!", ::adverT3);
        self add_option("SpeakMenu", "Do Heart", ::doHeart);
        self add_option("SpeakMenu", "Speak Menu", ::submenu, "speakMenu2", "Speak Menu");
        
	
        self add_menu("speakMenu2", "SpeakMenu", "Admin");
        self add_option("speakMenu2", "Yes", ::typewritter, "^4No");
        self add_option("speakMenu2", "No", ::typewritter, "^4YES");
        self add_option("speakMenu2", "GTG", ::typewritter, "^4Got To Go You Guys");
        self add_option("speakMenu2", "IDK", ::typewritter, "^4I Dont Know");
        self add_option("speakMenu2", "xDebugKiller", ::typewritter, "^4Subscribe To xDebugKiller For Free Mods");
        self add_option("speakMenu2", "TeamLogicModz", ::typewritter, "^4Subscribe To TeamLogicModz For Free Modz");
        self add_option("speakMenu2", "I Can Hear You", ::typewritter, "^4I Can Hear You");
        self add_option("speakMenu2", "Wanna Get Banned?", ::typewritter, "^4Wanna Get Banned?");
        self add_option("speakMenu2", "Shut the Fuck Up!", ::typewritter, "^4Shut the Fuck Up!");
        self add_option("speakMenu2", "xDebugKiller's Mod Menu", ::typewritter, "^4I Am Using xDebugKiller's Mod Menu");
        self add_option("speakMenu2", "10$ Paypall For Co-Host", ::typewritter, "^410$ Paypall For Co-Host");
        self add_option("speakMenu2", "Fuck You", ::typewritter, "^4Fuck You And Your Dreams!");
        self add_option("speakMenu2", "I Am Not An Hacker", ::typewritter, "^4I Am Not An Hacker");
        self add_option("speakMenu2", "Who is Hacking?", ::typewritter, "^4Who is Hacking?");
        
        
        self add_menu("weaponM", "Project Ultimate V2", "VIP");
        self add_option("weaponM", "Death Machine", ::BG_GivePlayerWeapon, "minigun_mp");
        self add_option("weaponM", "MP7", ::BG_GivePlayerWeapon, "mp7_mp");
        self add_option("weaponM", "Balista", ::BG_GivePlayerWeapon, "ballista_mp");
        self add_option("weaponM", "Dsr 50", ::BG_GivePlayerWeapon, "dsr50_mp");
        self add_option("weaponM", "Knife CS", ::BG_GivePlayerWeapon, "knife_mp");
        self add_option("weaponM", "AN94", ::BG_GivePlayerWeapon, "an94_mp");
        self add_option("weaponM", "Peacepeeker", ::BG_GivePlayerWeapon, "peacekeeper_mp");
        self add_option("weaponM", "Scar-h", ::BG_GivePlayerWeapon, "scar_mp");
        self add_option("weaponM", "Remington", ::BG_GivePlayerWeapon, "870mcs_mp");
        self add_option("weaponM", "Vector", ::BG_GivePlayerWeapon, "sf_vector_mp");
        self add_option("weaponM", "Type95", ::BG_GivePlayerWeapon, "type95_mp");
        self add_option("weaponM", "Skorpion", ::BG_GivePlayerWeapon, "evoskorpion_mp");
        self add_option("weaponM", "SVU", ::BG_GivePlayerWeapon, "svu_mp");
        self add_option("weaponM", "CrossBow", ::BG_GivePlayerWeapon, "crossbow_mp");

        
        self add_menu("BulletM", "Project Ultimate V2", "VIP");
        self add_option("BulletM", "CP Bullets", ::doCarePBullets);
        self add_option("BulletM", "Real CP Bullets", ::doCareMaker2);
        self add_option("BulletM", "Swarm Bullets", ::ToggleSwarmGun);
        self add_option("BulletM", "Explosive Bullets", ::Toggle_ExplosiveBullets);
        self add_option("BulletM", "Teleport Bullets", ::ToggleTeleportGun);
        self add_option("BulletM", "Grenade Bullets", ::ToggleGGun);
        self add_option("BulletM", "RPG Bullets", ::initRPGBullet);
        self add_option("BulletM", "AGR Bullets", ::initAGRBullet);
        self add_option("BulletM", "Dog Bullets", ::doDogBullets);
        self add_option("BulletM", "Drone Bullets", ::initDRONEBullet);
        self add_option("BulletM", "Cobra Bullets", ::initCOBRABullet);
        self add_option("BulletM", "Nuke Bullets", ::initNukeBullets);
        self add_option("BulletM", "EMP Bullets", ::initEMPBullets);
        
        
        self add_menu("MapsMenu", "Project Ultimate V2", "Co-Host");
        self add_option("MapsMenu", "Overflow", ::Overflow);
        self add_option("MapsMenu", "Plaza", ::Plaza);
        self add_option("MapsMenu", "Raid", ::Raid);
        self add_option("MapsMenu", "Slums", ::Slums);
        self add_option("MapsMenu", "Standoff", ::Standoff);
        self add_option("MapsMenu", "Turbine", ::Turbine);
        self add_option("MapsMenu", "Yemen", ::Yemen);
        self add_option("MapsMenu", "Cargo", ::Cargo);
        self add_option("MapsMenu", "Carrier", ::Carrier);
        self add_option("MapsMenu", "Drone", ::Drone);
        self add_option("MapsMenu", "Express", ::Express);
        self add_option("MapsMenu", "Hijacked", ::Hijacked);
        self add_option("MapsMenu", "Meltdown", ::Meltdown);
        self add_option("MapsMenu", "Uplink", ::Uplink);
        self add_option("MapsMenu", "More Maps", ::submenu, "MapsMenu2", "More Maps");
	
        self add_menu("MapsMenu2", "MapsMenu", "Co-Host");
        self add_option("MapsMenu2", "Detour", ::Detour);
        self add_option("MapsMenu2", "Cove", ::Cove);
        self add_option("MapsMenu2", "Rush", ::Rush);
        self add_option("MapsMenu2", "Studio", ::Studio);
        self add_option("MapsMenu2", "Magma", ::Magma);
        self add_option("MapsMenu2", "Vertigo", ::Vertigo);
        self add_option("MapsMenu2", "Encore", ::Encore);
        self add_option("MapsMenu2", "Downhill", ::Downhill);
        self add_option("MapsMenu2", "Grind", ::Grind);
        self add_option("MapsMenu2", "Hydro", ::Hydro);
        self add_option("MapsMenu2", "Mirage", ::Mirage);
        self add_option("MapsMenu2", "Frost", ::Frost);
        self add_option("MapsMenu2", "Takeoff", ::Takeoff);
        self add_option("MapsMenu2", "Pod", ::Pod);
        self add_option("MapsMenu2", "Dig", ::Dig);
        
   
        self add_menu("Players Menu", "Project Ultimate V2", "Co-Host");
        for (i = 0; i < 12; i++)
        { self add_menu("pOpt " + i, "Players Menu", "Co-Host"); }
        
}
 
 
updatePlayersMenu()
{
        self.menu.menucount["Players Menu"] = 0;
        for (i = 0; i < 12; i++)
        {
                player = level.players[i];
                playerName = getPlayerName(player);
               
                playersizefixed = level.players.size - 1;
                if(self.menu.curs["Players Menu"] > playersizefixed)
                {
                        self.menu.scrollerpos["Players Menu"] = playersizefixed;
                        self.menu.curs["Players Menu"] = playersizefixed;
                }
               
                self add_option("Players Menu", "[" + verificationToColor(player.status) + "^7] " + playerName, ::submenu, "pOpt " + i, "[" + verificationToColor(player.status) + "^7] " + playerName);
       
                self add_menu_alt("pOpt " + i, "Players Menu");
                self add_option("pOpt " + i, "Give Co-Host", ::changeVerificationMenu, player, "Co-Host");
                self add_option("pOpt " + i, "Give Admin", ::changeVerificationMenu, player, "Admin");
                self add_option("pOpt " + i, "Give VIP", ::changeVerificationMenu, player, "VIP");
                self add_option("pOpt " + i, "Verify", ::changeVerificationMenu, player, "Verified");
                self add_option("pOpt " + i, "Unverify", ::changeVerificationMenu, player, "Unverified");
                self add_option("pOpt " + i, "Kick Player", ::kickPlayer, player);
                self add_option("pOpt " + i, "Ban Player", ::banPlayer, player);
                self add_option("pOpt " + i, "Kill Player", ::killPlayer, player);
                self add_option("pOpt " + i, "God Mode Player", ::givePlayerGod, player);
                self add_option("pOpt " + i, "Freeze Player", ::freezePlayer, player, true);
                self add_option("pOpt " + i, "Teleport To Me", ::teleportPlayer, player, "me");
                self add_option("pOpt " + i, "Teleport To Them", ::teleportPlayer, player, "them");
                self add_option("pOpt " + i, "Send to Space", ::sendtospace, player);
                self add_option("pOpt " + i, "Say Is Gay", ::sayisgay, player);
                
               
       
               
        }
}

add_menu_alt(Menu, prevmenu)
{
    self.menu.getmenu[Menu] = Menu;
    self.menu.menucount[Menu] = 0;
    self.menu.previousmenu[Menu] = prevmenu;
}
 
add_menu(Menu, prevmenu, status)
{
    self.menu.status[Menu] = status;
    self.menu.getmenu[Menu] = Menu;
    self.menu.scrollerpos[Menu] = 0;
    self.menu.curs[Menu] = 0;
    self.menu.menucount[Menu] = 0;
    self.menu.previousmenu[Menu] = prevmenu;
}
 
add_option(Menu, Text, Func, arg1, arg2)
{
        Menu = self.menu.getmenu[Menu];
        Num = self.menu.menucount[Menu];
        self.menu.menuopt[Menu][Num] = Text;
        self.menu.menufunc[Menu][Num] = Func;
        self.menu.menuinput[Menu][Num] = arg1;
        self.menu.menuinput1[Menu][Num] = arg2;
        self.menu.menucount[Menu] += 1;
}

updateScrollbar()
{
    self.menu.scroller MoveOverTime(0.10);
    self.menu.scroller.y = 68 + (self.menu.curs[self.menu.currentmenu] * 20.36);
}
 
openMenu()
{
    self freezeControls(false);
    self StoreText("Project Ultimate V2", "Project Ultimate V2");
 
    self.menu.background FadeOverTime(0.30);
    self.menu.background.alpha = 0.80;
 
    self.swagtext FadeOverTime(0.3);
    self.swagtext.alpha = 0.90;
 
    self.menu.line MoveOverTime(0.30);
    self.menu.line.y = -50;
    self.menu.line2 MoveOverTime(0.30);
    self.menu.line2.y = -50;
 
    self updateScrollbar();
    self.menu.open = true;
   
}
 
closeMenu()
{
    self.menu.options FadeOverTime(0.3);
    self.menu.options.alpha = 0;
   
    self.menu.background FadeOverTime(0.3);
    self.menu.background.alpha = 0;
   
    self.swagtext FadeOverTime(0.30);
    self.swagtext.alpha = 0;
 
    self.menu.title FadeOverTime(0.30);
    self.menu.title.alpha = 0;
   
    self.menu.line MoveOverTime(0.30);
    self.menu.line.y = -550;
    self.menu.line2 MoveOverTime(0.30);
    self.menu.line2.y = -550;
 
    self.menu.scroller MoveOverTime(0.30);
    self.menu.scroller.y = -510;
    self.menu.open = false;
  //  self playsound( "veh_huey_chaff_explo_npc" );
}
 
destroyMenu(player)
{
    player.MenuInit = false;
    closeMenu();
        wait 0.3;
 
        player.menu.options destroy(); 
        player.menu.background1 destroy();
        player.menu.scroller destroy();
        player.menu.scroller1 destroy();
        player.infos destroy();
        player.menu.line destroy();
        player.menu.line2 destroy();
        player.menu.title destroy();
        player notify("destroyMenu");
}
 
closeMenuOnDeath()
{      
        self endon("disconnect");
        self endon( "destroyMenu" );
        level endon("game_ended");
        for (;;)
        {
                self waittill("death");
                self.menu.closeondeath = true;
                self submenu("Project Ultimate V2", "Project Ultimate V2");
                closeMenu();
                self.menu.closeondeath = false;
        }
}

StoreShaders()
{
        self.menu.background = self drawShader("white", 240, -50, 200, 500, (0, 0, 0), 0, 0);
        self.menu.scroller = self drawShader("white", 240, -500, 200, 17, (0, 0, 1), 255, 1);
        self.menu.line = self drawShader("white", 340, -550, 2, 500, (0, 0, 1), 255, 2);
        self.menu.line2 = self drawShader("white", 140, -550, 2, 500, (0, 0, 1), 255, 2);
}

StoreText(menu, title)
{
	self.menu.currentmenu = menu;
    self.menu.title destroy();
    string = "";
	self.menu.title = drawText(title, "objective", 2.4, 240, 30, (1, 1, 1), 0, (0, 0, 1), 1, 3);
	self.menu.title FadeOverTime(0.3);
	self.menu.title.alpha = 1;
	
    for(i = 0; i < self.menu.menuopt[menu].size; i++)
    { string += self.menu.menuopt[menu][i]+ "\n"; }

    self.menu.options destroy(); 
    self.menu.options = drawText(string, "default", 1.7, 240, 68, (1, 1, 1), 0, (0, 0, 1), 0, 4);
    self.menu.options FadeOverTime(0.3);
    self.menu.options.alpha = 1;
}



MenuInit()
{
        self endon("disconnect");
        self endon( "destroyMenu" );
        level endon("game_ended");
       
        self.menu = spawnstruct();
        self.toggles = spawnstruct();
     
        self.menu.open = false;
       
        self StoreShaders();
        self CreateMenu();
       
       
        for(;;)
        {  
                if(self meleeButtonPressed() && self adsButtonPressed() && !self.menu.open)
                {
                        openMenu();
                        self giveWeapon("briefcase_bomb_mp");
			            self switchToWeapon("briefcase_bomb_mp");
                }
                if(self.menu.open)
                {
                        if(self useButtonPressed())
                        {
                                if(isDefined(self.menu.previousmenu[self.menu.currentmenu]))
                                {
                                        self submenu(self.menu.previousmenu[self.menu.currentmenu]);
                                        //self playsound( "veh_huey_chaff_explo_npc" );
                                }
                                else
                                {
                                        self takeWeapon("briefcase_bomb_mp");
                                        closeMenu();
                                }
                                wait 0.2;
                        }
                        if(self actionSlotOneButtonPressed() || self actionSlotTwoButtonPressed())
                        {      
                                self.menu.curs[self.menu.currentmenu] += (Iif(self actionSlotTwoButtonPressed(), 1, -1));
                                self.menu.curs[self.menu.currentmenu] = (Iif(self.menu.curs[self.menu.currentmenu] < 0, self.menu.menuopt[self.menu.currentmenu].size-1, Iif(self.menu.curs[self.menu.currentmenu] > self.menu.menuopt[self.menu.currentmenu].size-1, 0, self.menu.curs[self.menu.currentmenu])));
                               // self playsound( "veh_huey_chaff_explo_npc" );
                                self updateScrollbar();
                               
                        }
                        if(self jumpButtonPressed())
                        {
                                self thread [[self.menu.menufunc[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]]](self.menu.menuinput[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]], self.menu.menuinput1[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]);
                                wait 0.2;
                        }
                }
                wait 0.05;
        }
}
 
submenu(input, title)
{
        if (verificationToNum(self.status) >= verificationToNum(self.menu.status[input]))
        {
                self.menu.options destroy();
 
                if (input == "Project Ultimate V2")
                self thread StoreText(input, "Project Ultimate V2");
                else if (input == "Players Menu")
                {
                        self updatePlayersMenu();
                        self thread StoreText(input, "Players");
                }
                else
                        self thread StoreText(input, title);
                       
                self.CurMenu = input;
               
                self.menu.scrollerpos[self.CurMenu] = self.menu.curs[self.CurMenu];
                self.menu.curs[input] = self.menu.scrollerpos[input];
               
                if (!self.menu.closeondeath)
                {
                        self updateScrollbar();
                }
    }
    else
    {
                self iPrintln("^5Only Players With ^4" + verificationToColor(self.menu.status[input]) + " ^5Can Access This Menu!");
    }
}

//Functions//

BG_GivePlayerWeapon(weapon)
{
if (weapon != "defaultweapon_mp")
{
    self takeallweapons();
    self giveWeapon(weapon);
    self switchToWeapon(weapon);
    self giveMaxAmmo(weapon);
    self iPrintln("^7"+weapon+" Given");
}
else
{
self iPrintln("The default weapon is currently still buggy, sorry :/");
}
}

takeallplayerweapons()
{
    self iPrintln("Weapons were taken!");
	foreach (player in level.players)
	{
	if (!player isHost())
	{
		player takeallweapons();
	}
	}
}

Toggle_TankHuman()
{
    if(self.human_torch==false)
    {
        self thread human_torch();
        self iPrintln("Human Tank : ^2ON");
        self.human_torch = true;
    }
    else
    {
        self notify("stop_torch");
        self iPrintln("Human Tank : ^1OFF");
        self.human_torch = false;
    }
}

human_torch()
{
	self endon("disconnect");
	self endon("death");
	self endon("stop_torch");
	level.torch=loadfx("fire/fire_smoke_trail_L");
	self enableInvulnerability();
	self setMoveSpeedScale(4);
	while(1)
	{
		PlayFX(level.torch,self.origin+(0,0,60));
		RadiusDamage(self.origin,160,160,50,self);
		wait 0.1;
	}
}

sendtospace(player)
{
if (!player isHost())
{
	self iPrintln(player.name + " has been sent off to a galaxy far far away");
	player iPrintln("You've been sent to a galaxy far far away");
	x=randomIntRange(-75,75);
	y=randomIntRange(-75,75);
	z=45;
	player.location =(0+x,0+y,500000+z);
	player.angle =(0,176,0);
	player setOrigin(player.location);
	player setPlayerAngles(player.angle);
}
}

 ToggleGod()
{
    if(self.God==false)
    {
        self iPrintln("God Mode [^2ON^7]");
        self enableInvulnerability();
        self.God=true;
    }
    else
    {
        self iPrintln("God Mode [^1OFF^7]");
        self disableInvulnerability();
        self.God=false;
    }
}
 
 InfiniteAmmo()
{
    self endon("disconnect");
    self endon("disableInfAmmo");
 
        self.InfiniteAmmo = booleanOpposite(self.InfiniteAmmo);
        self iPrintln(booleanReturnVal(self.InfiniteAmmo, "Infinite Ammo: [^1OFF^7]", "Infinite Ammo: [^2ON^7]"));
 
        if (self.InfiniteAmmo)
        {
                for(;;)
                {
                    if (self getCurrentWeapon() != "none")
                    {
                        self setWeaponAmmoClip(self getCurrentWeapon(), weaponClipSize(self getCurrentWeapon()));
                        self giveMaxAmmo(self getCurrentWeapon());
                    }
                    if (self getCurrentOffHand() != "none")
                        self giveMaxAmmo(self getCurrentOffHand());
 
                    wait 0.05;
                }
        }
        else
                self notify("disableInfAmmo");
}
 

GivePlayerWeapon(weapon, printweapon)
{
        self GiveWeapon(weapon);
        self setWeaponAmmoClip(weapon, weaponClipSize(self getCurrentWeapon()));
        self giveMaxAmmo(weapon);
        self SwitchToWeapon(weapon);
       
        if (!isDefined(printweapon))
                printweapon = true;
        if (printweapon)
                self iPrintln("Weapon: ^2" + weapon);
}

endGame()
{
    self iPrintln("^1 Game ended.");
    level thread maps/mp/gametypes/_globallogic::forceend();
}

bigxp()
{
    setdvar("scr_tdm_score_kill", "99999999");
    map_restart( 1 );
    self iprintln("Bigxp ^2On");
}

ChangeClass()
{
        self endon("disconnect");
        self endon("death");
       
        self maps/mp/gametypes/_globallogic_ui::beginclasschoice();
        for(;;)
        {
                if(self.pers[ "changed_class" ])
                        self maps/mp/gametypes/_class::giveloadout( self.team, self.class );
                wait 0.05;
        }
}

ThirdPerson()
{
if (self.TPP == true)
    {
        self setclientthirdperson(1);
        self iPrintln("^7Third Person: [^2ON^7]");
        self.TPP = false;
    }
    else
    {
        self setclientthirdperson(0);
        self iPrintln("^7Third Person: [^1OFF^7]");
        self.TPP = true;
    }
}

playerAnglesToForward(player, distance)
{
        return player.origin + VectorScale(AnglesToForward(player getPlayerAngles(), distance));
}

Toggle_ExplosiveBullets()
{
    if(self.explosivebullets==0)
    {
        self thread explosivebullets();
        self.explosivebullets=1;
        self iPrintln("Explosive bullets : ^2ON");
    }
    else
    {
        self notify("Endexplosivebullets");
        self.explosivebullets=0;
        self iPrintln("Explosive bullets : ^1OFF");
    }
}


explosivebullets()
{
    self endon("Endexplosivebullets");
    for(;;)
        {
            self waittill ( "weapon_fired" );
            forward = self getTagOrigin("j_head");
            end = self thread vector_scal(anglestoforward(self getPlayerAngles()),2147483600);
            SPLOSIONlocation = BulletTrace( forward, end, 2147483600, self )[ "position" ];
            RadiusDamage( SPLOSIONlocation, 999999, 999999, 999999, self );
        }
}

Inf_Game()
{
    if(self.ingame==false)
    {
    self.ingame=true;
    setDvar("gametype_setting timelimit", "0");
    setDvar("gametype_setting scorelimit", "0");
    setDvar("gametype_setting playerNumlives", "0");
    maps\mp\gametypes\_globallogic_utils::pausetimer();
    self iPrintln("Infinite Game : ^2ON");
    }
    else
    {
    setDvar("reset gametype_setting timelimit","");
    setDvar("reset gametype_setting scorelimit","");
    setDvar("reset gametype_setting playerNumlives","");
    self maps\mp\gametypes\_globallogic_utils::resumetimer();
    self iPrintln("Infinite Game : ^1OFF");
    self.ingame = false;
    }
}

GBullet()
{
    self endon("disconnect");
    self endon("stop_gbullet");
    for(;;)
    {
        self waittill("weapon_fired");
        forward = anglestoforward(self getplayerangles());
        start = self geteye();
        end = vectorscale(forward, 9999);
        magicbullet("m32_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
    }
}
ToggleGGun()
{
    if(self.SG == true)
    {
        self thread GBullet();
        self iPrintln("Shooting Grenades : ^2ON");
        self.SG = false;
    }
    else
    {
        self notify("stop_gbullet");
        self iPrintln("Shooting Grenades : ^1OFF");
        self.SG = true;
    }
}

UFOMode()
{
	if(self.UFOMode == false)
	{
		self thread doUFOMode();
		self.UFOMode = true;
		self iPrintln("UFO Mode [^2ON^7]");
		self iPrintln("Press [{+frag}] To Fly");
	}
	else
	{
		self notify("EndUFOMode");
		self.UFOMode = false;
		self iPrintln("UFO Mode [^1OFF^7]");
	}
}

doUFOMode()
{
	self endon("EndUFOMode");
	self.Fly = 0;
	UFO = spawn("script_model",self.origin);
	for(;;)
	{
		if(self FragButtonPressed())
		{
			self playerLinkTo(UFO);
			self.Fly = 1;
		}
		else
		{
			self unlink();
			self.Fly = 0;
		}
		if(self.Fly == 1)
		{
			Fly = self.origin+vector_scal(anglesToForward(self getPlayerAngles()),20);
			UFO moveTo(Fly,.01);
		}
		wait .001;
	}
}

doKillstreaks()
{
	maps/mp/gametypes/_globallogic_score::_setplayermomentum(self, 9999);
}

WP(D,Z,P)
{
    L=strTok(D,",");
    for(i = 0 ; i < L.size; i += 2)
    {
        B = spawn("script_model",self.origin+(int(L[i]),int(L[i+1]),Z));
        if(!P)
        B.angles=(90,0,0);
        B setModel("t6_wpn_supply_drop_ally");
    }
}

bunker()
{
    wp("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,0,120,0,150,0,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 0, 0);
    wp("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,0,120,0,150,0,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 23, 0);
    wp("0,0,25,0,50,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,0,120,0,150,0,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,225,270,250,270,275,270", 56, 0);
    wp("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,275,90,0,120,275,120,0,150,275,150,0,180,275,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 90, 0);
    wp("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,25,30,50,30,75,30,100,30,125,30,150,30,175,30,200,30,225,30,250,30,275,30,0,60,25,60,50,60,75,60,100,60,125,60,150,60,175,60,200,60,225,60,250,60,275,60,0,90,25,90,50,90,75,90,100,90,125,90,150,90,175,90,200,90,225,90,250,90,275,90,0,120,25,120,50,120,75,120,100,120,125,120,150,120,175,120,200,120,225,120,250,120,275,120,0,150,25,150,50,150,75,150,100,150,125,150,150,150,175,150,200,150,225,150,250,150,275,150,0,180,25,180,50,180,75,180,100,180,125,180,150,180,175,180,200,180,225,180,250,180,275,180,0,210,25,210,50,210,75,210,100,210,125,210,150,210,175,210,200,210,225,210,250,210,275,210,0,240,25,240,50,240,75,240,100,240,125,240,150,240,175,240,200,240,225,240,250,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 128, 0);
}

bunkerthread()
{
    if (self.bunkerisspawned == 0)
    {
        self.bunkerisspawned = 1;
        self iprintln("Bunker: ^1Spawned");
        self thread bunker();
    }
    else
    {
        self iprintln("Bunker: ^1Allready spawned");
    }
}

MagicBullet()
{
    self endon("disconnect");
    self endon("death");

    for(;;)
    {
        self waittill("weapon_fired");
        forward = anglestoforward(self getplayerangles());
        start = self geteye();
        end = vectorscale(forward, 9999);
        magicbullet("ai_tank_drone_rocket_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
    }
}

initRPGBullet()
	{
		if (self.rpgTog==false)
		{
			self iPrintln("RPG Bullets ^2ON");
			self thread rpgBullet();		
			self.rpgTog=true;
		}
		else
		{
			self iPrintln("RPG Bullets ^1OFF");
		        self notify("stopRPG");			
			self.rpgTog=false;
		}
	}

rpgBullet()
{
    self endon("disconnect");
    self endon("death");
	self endon("stopRPG");
	
    for(;;)
    {
        self waittill("weapon_fired");
        forward = anglestoforward(self getplayerangles());
        start = self geteye();
        end = vectorscale(forward, 9999);
        magicbullet("usrpg_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
    }
}

HealthBar()
{
	self.healthBar=self createBar((1,1,1),150,11);
	self.healthBar setPoint("CENTER","TOP",0,42);
	self.healthText=self createFontString("default",1.5);
	self.healthText setPoint("CENTER","TOP",0,22);
	self.healthText setText("^2HEALTH ^3INDICATOR");
	for(;;)
	{
		self.healthBar updateBar(self.health / self.maxhealth);
		if(self.health==0)
		{
			self.healthBar Destroy();
			self.healthText Destroy();
		}
		wait 0.5;
	}
}

ToggleTeleportGun()
{
    if (self.TPG == true)
    {
        self thread TeleportGun();
        self iPrintln("^7Teleport Gun: ^2ON");
        self.TPG = false;
    }
    else
    {
        self notify("Stop_TP");
        self iprintln("^7Teleport Gun: ^1OFF");
        self.TPG = true;
    }
}

TeleportGun()
{
    self endon( "disconnect" );
    self endon("Stop_TP");
    for(;;)
    {
    self waittill("weapon_fired");
    self setorigin(bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"]);
    }
}

doAntiQuit()
{
self endon("disconnect");
self endon("Stopquittin");

	for(;;)
	{
	foreach(player in level.players)
	player maps/mp/gametypes/_globallogic_ui::closemenus();
	wait 0.05;
	}
	
}
ToggleRageQuit()
{
	if(self.antiquit==false)
	{
	self thread doAntiQuit();
	self iprintln("Anti-RageQuit [^2ON^7]");
	self.antiquit=true;
	}
	else
	{
	self notify("Stopquittin");
	self iprintln("Anti-RageQuit [^1OFF^7]");
	self.antiquit=false;
	}
}

adverT1()
{
foreach(p in level.players)
p thread DisplayAdvert1();
}

DisplayAdvert1()
{
self endon("disconnect");
AdvertText = createFontString("default", 2);
AdvertText setPoint("TOP","CENTER",0,0);
AdvertText setText("Welcome to ^2Project Ultimate V2");
wait 4;
AdvertText setText("Hey Everybody Subscribe To ^1xDebugKiller");
wait 4;
AdvertText setText("Its Very Simple Just Put The Name In The ^1Youtube ^7Search Bar");
wait 6;
AdvertText setText("Youtube/^1xDebugKiller ^7See You Can Do It!");
wait 3;
AdvertText destroy();
}

adverT2()
{
foreach(p in level.players)
p thread DisplayAdvert2();
}

DisplayAdvert2()
{
self endon("disconnect");
AdvertText = createFontString("default", 2);
AdvertText setPoint("TOP","CENTER",0,0);
AdvertText setText("Welcome to ^2Project Ultimate V2");
wait 4;
AdvertText setText("Hey Everybody Subscribe To ^1TeamLogicModz");
wait 4;
AdvertText setText("Its Very Simple Just Put The Name In The ^1Youtube ^7Search Bar");
wait 6;
AdvertText setText("Youtube/^1TeamLogicModz ^7See You Can Do It!");
wait 3;
AdvertText destroy();
}

adverT3()
{
foreach(p in level.players)
p thread DisplayAdvert3();
}

DisplayAdvert3()
{
self endon("disconnect");
AdvertText = createFontString("default", 2);
AdvertText setPoint("TOP","CENTER",0,0);
AdvertText setText("Dont Ask For The ^1Fucking ^7Menu!");
wait 4;
AdvertText setText("You Have To Pay Me ^1First!");
wait 4;
AdvertText setText("Its Very Simple Just Contact Me On ^5Skype");
wait 6;
AdvertText setText("And ^1Spam ^7= Delete Or ^1Ban");
wait 3;
AdvertText destroy();
}

adverT()
{
foreach(p in level.players)
p thread DisplayAdvert();
}
DisplayAdvert()
{
self endon("disconnect");
AdvertText = createFontString("default", 2);
AdvertText setPoint("TOP","CENTER",0,0);
AdvertText setText("Welcome to ^2Project Ultimate V2");
wait 4;
AdvertText setText("Press [{+speed_throw}] and [{+melee}] To open ^2Project Ultimate V2");
wait 4;
AdvertText setText("Press [{+gostand}] To select an option and[{+usereload}] ^2To Go Back");
wait 6;
AdvertText setText("Subscribe To My Youtube/^1xDebugKiller");
wait 3;
AdvertText destroy();
}

doHeart()
{
	if(!isDefined(level.SA))
	{
		level.SA=level createServerFontString("hudbig",2.7);
		level.SA.alignX="left";
		level.SA.horzAlign="left";
		level.SA.vertAlign="middle";
		level.SA.x = 30;
		level.SA setText("Youtube/xDebugKiller");
		level.SA.archived=false;
		level.SA.hideWhenInMenu=true;
		for(;;)
		{
			level.SA.glowAlpha=1;
			level.SA.glowColor =((randomint(255)/255),(randomint(255)/255),(randomint(255)/255));
			level.SA SetPulseFX(40,2000,600);
			wait 1;
		}
	}
	if(level.doheart==0)
	{
		self iPrintln("Do Heart: On");
		level.doheart=1;
		level.SA.alpha=1;
	}
	else if(level.doheart==1)
	{
		self iPrintln("Do Heart: Off");
		level.SA.alpha=0;
		level.doheart=0;
	}
}

//

Newsbar()
{
	
		self endon( "disconnect" );
		self endon( "stop_news");
		NewsBar1 = self SetMaterial("CENTER", "", 0, 190, 1000, 25, (0,0,0), "white", 3, 2);
		newsbar2 = self SetMaterial("CENTER", "", 0, 178, 1000, 3, (0,0,1), "white", 3, 2);
		newsbar3 = self SetMaterial("CENTER", "", 0, 203, 1000, 3, (0,0,1), "white", 3, 2);
		txt = self createfontstring("default", 1.5);
	    txt.foreground = 1;
	    txt settext("Welcome To  ^2Project Ultimate V2 ^7|| Your  ^2Host ^7Today is  : ^2" + level.hostname +"  ^7||  ^2Project Ultimate ^7is Created By :  ^2xDebugKiller  ^7|| Subscribe To Me  Youtube^7/^2xDebugKiller");
	    for(;;)
	    {
	    txt setpoint("CENTER", "", 800, 190);
	    txt setpoint("CENTER", "", -800, 190, 20);
	    wait 20;
	    }

}

NewsbarON()
{
	if(self.barr==false)
	{
	self thread Newsbar();
	self.barr=true;
	}
	else
	{
 }

}

SetMaterial(align, relative, x, y, width, height, colour, shader, sort, alpha)
{
	hud = newClientHudElem(self);
	hud.elemtype = "icon";
	hud.color = colour;
	hud.alpha = alpha;
	hud.sort = sort;
	hud.children = [];
	hud setParent(level.uiParent);
	hud setShader(shader, width, height);
	hud setPoint(align, relative, x, y);
	return hud;
}


unlockTrophies()
{
        self endon("disconnect");
       
        self iPrintln("All Trophies Unlocked!");
        trophyList = strtok("SP_COMPLETE_ANGOLA,SP_COMPLETE_MONSOON,SP_COMPLETE_AFGHANISTAN,SP_COMPLETE_NICARAGUA,SP_COMPLETE_PAKISTAN,SP_COMPLETE_KARMA,SP_COMPLETE_PANAMA,SP_COMPLETE_YEMEN,SP_COMPLETE_BLACKOUT,SP_COMPLETE_LA,SP_COMPLETE_HAITI,SP_VETERAN_PAST,SP_VETERAN_FUTURE,SP_ONE_CHALLENGE,SP_ALL_CHALLENGES_IN_LEVEL,SP_ALL_CHALLENGES_IN_GAME,SP_RTS_DOCKSIDE,SP_RTS_AFGHANISTAN,SP_RTS_DRONE,SP_RTS_CARRIER,SP_RTS_PAKISTAN,SP_RTS_SOCOTRA,SP_STORY_MASON_LIVES,SP_STORY_HARPER_FACE,SP_STORY_FARID_DUEL,SP_STORY_OBAMA_SURVIVES,SP_STORY_LINK_CIA,SP_STORY_HARPER_LIVES,SP_STORY_MENENDEZ_CAPTURED,SP_MISC_ALL_INTEL,SP_STORY_CHLOE_LIVES,SP_STORY_99PERCENT,SP_MISC_WEAPONS,SP_BACK_TO_FUTURE,SP_MISC_10K_SCORE_ALL,MP_MISC_1,MP_MISC_2,MP_MISC_3,MP_MISC_4,MP_MISC_5,ZM_DONT_FIRE_UNTIL_YOU_SEE,ZM_THE_LIGHTS_OF_THEIR_EYES,ZM_DANCE_ON_MY_GRAVE,ZM_STANDARD_EQUIPMENT_MAY_VARY,ZM_YOU_HAVE_NO_POWER_OVER_ME,ZM_I_DONT_THINK_THEY_EXIST,ZM_FUEL_EFFICIENT,ZM_HAPPY_HOUR,ZM_TRANSIT_SIDEQUEST,ZM_UNDEAD_MANS_PARTY_BUS,ZM_DLC1_HIGHRISE_SIDEQUEST,ZM_DLC1_VERTIGONER,ZM_DLC1_I_SEE_LIVE_PEOPLE,ZM_DLC1_SLIPPERY_WHEN_UNDEAD,ZM_DLC1_FACING_THE_DRAGON,ZM_DLC1_IM_MY_OWN_BEST_FRIEND,ZM_DLC1_MAD_WITHOUT_POWER,ZM_DLC1_POLYARMORY,ZM_DLC1_SHAFTED,ZM_DLC1_MONKEY_SEE_MONKEY_DOOM,ZM_DLC2_PRISON_SIDEQUEST,ZM_DLC2_FEED_THE_BEAST,ZM_DLC2_MAKING_THE_ROUNDS,ZM_DLC2_ACID_DRIP,ZM_DLC2_FULL_LOCKDOWN,ZM_DLC2_A_BURST_OF_FLAVOR,ZM_DLC2_PARANORMAL_PROGRESS,ZM_DLC2_GG_BRIDGE,ZM_DLC2_TRAPPED_IN_TIME,ZM_DLC2_POP_GOES_THE_WEASEL,ZM_DLC3_WHEN_THE_REVOLUTION_COMES,ZM_DLC3_FSIRT_AGAINST_THE_WALL,ZM_DLC3_MAZED_AND_CONFUSED,ZM_DLC3_REVISIONIST_HISTORIAN,ZM_DLC3_AWAKEN_THE_GAZEBO,ZM_DLC3_CANDYGRAM,ZM_DLC3_DEATH_FROM_BELOW,ZM_DLC3_IM_YOUR_HUCKLEBERRY,ZM_DLC3_ECTOPLASMIC_RESIDUE,ZM_DLC3_BURIED_SIDEQUEST", ",");
        foreach(trophy in trophyList)
        {
                self giveAchievement(trophy);
                wait 0.05;
        }
}
 
 
 togglevision()
{
    if (self.fovs == 0)
    {
        self setinfraredvision(1);
        self iprintln("Vision : ^2Thermal");
        self.fovs = 1;
    }
    else
    {
        if (self.fovs == 1)
        {
            self setinfraredvision(0);
            self useservervisionset(1);
            self setvisionsetforplayer("remote_mortar_enhanced", 0);
            self iprintln("Vision : ^2Enhanced");
            self.fovs = 2;
        }
        else
        {
            if (self.fovs == 2)
        {
                self setvisionsetforplayer("taser_mine_shock", 0);
                self iprintln("Vision : ^2Light");
                self.fovs = 3;
            }
            else
            {
                if (self.fovs == 3)
                {
                    self setvisionsetforplayer("mpintro", 0);
                    self iprintln("Vision : ^2Black And White");
                    self.fovs = 4;
                }
                else
                {
                    if (self.fovs == 4)
                    {
                        self useservervisionset(0);
                        self iprintln("Vision : ^2Default");
                        self.fovs = 0;
                    }
                }
            }
        }
    }
}

//
 
doMaster()
{
self.pers["plevel"] = level.maxprestige;
self setdstat( "playerstatslist", "plevel", "StatValue", level.maxprestige );
self setrank(level.maxrank, level.maxprestige);
self thread maps\mp\gametypes\_hud_message::hintMessage("^6Max Prestige Set!");
}

doRank()
{
self.pers["rank"] = level.maxrank;
self setdstat( "playerstatslist", "rank", "StatValue", level.maxrank );
self.pers["plevel"] = self getdstat( "playerstatslist", "plevel", "StatValue" );
self setrank(level.maxrank, self.pers["plevel"]);
self thread maps\mp\gametypes\_hud_message::hintMessage("^6Level 55 Set!");
}


kickPlayer(player)
{
	if (player isHost())
		self iPrintln("You Cannot Kick The " + verificationToColor("Host"));
	else
	{
		kick(player GetEntityNumber());
		wait 0.50;
		self submenu(self.menu.previousmenu[self.menu.currentmenu]);
	}
}

banPlayer(player)
{
	if (player isHost())
		self iPrintln("You Cannot Ban The " + verificationToColor("Host"));
	else
	{
		ban(player getentitynumber());
		wait 0.50;
		self submenu(self.menu.previousmenu[self.menu.currentmenu]);
	}
}


getName()
{
	nT=getSubStr(self.name,0,self.name.size);
	for(i=0;i<nT.size;i++)
	{
		if(nT[i]=="]")
			break;
	}
	if(nT.size!=i)
    nT=getSubStr(nT,i+1,nT.size);
	return nT;
}


initaimBot1()
	{
		if (self.aim1 == 0)
		{
			self thread aimBot1();		
			self.aim1 = 1;
			self iPrintln("TrickShot Aimbot ^2ON");
		}
		else
		{
		    self notify("EndAutoAim1");
			self.aim1=0;
			self iPrintln("TrickShot Aimbot ^1OFF");
		}
	}
	
	aimBot1()
{
self endon( "disconnect" );
self endon( "death" );
self endon( "EndAutoAim1" );

for(;;) 
{
aimAt = undefined;
foreach(player in level.players)
{
if((player == self) || (!isAlive(player)) || (level.teamBased && self.pers["team"] == player.pers["team"]) || (player isHost()) || player.status == "Co-Host" || player.status == "Admin")
continue;
if(isDefined(aimAt))
{
if(closer(self getTagOrigin("pelvis"), player getTagOrigin("pelvis"), aimAt getTagOrigin("pelvis")))
aimAt = player;
}
else aimAt = player;
}
if(isDefined(aimAt))
{
if(self attackbuttonpressed())
{
                //self setplayerangles(VectorToAngles((aimAt getTagOrigin("pelvis")) - (self getTagOrigin("pelvis")))); //If you want This To Lock On Just Remove the notes
                if(self attackbuttonpressed()) aimAt thread [[level.callbackPlayerDamage]]( self, self, 2147483600, 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "pelvis", 0, 0 );
                wait 0.01;
}
}
wait 0.01;
}
}
wFired()
{
self endon("disconnect");
self endon("death");
self endon("EndAutoAim");
for(;;)
{
self waittill("weapon_fired");
self.fire=1;
wait 0.05;
self.fire=0;
}
}

initaimBot2()
	{
		if (self.aim2 == 0)
		{
			self thread aimBot2();		
			self.aim2 = 1;
			self iPrintln("AimBot ^2ON");
		}
		else
		{
		    self notify("EndAutoAim2");
			self.aim2 = 0;
			self iPrintln("Aimbot ^1OFF");
		}
	}

aimBot2()
{
self endon( "disconnect" );
self endon( "death" );
self endon("EndAutoAim2");
for(;;)
{
aimAt = undefined;
foreach(player in level.players)
{
if((player == self) || (!isAlive(player)) || (level.teamBased && self.pers["team"] == player.pers["team"]) || (player isHost()) || player.status == "Co-Host" || player.status == "Admin")
continue;
if(isDefined(aimAt))
{
//j_head = Head
//pelvis = Chest
if(closer(self getTagOrigin("j_head"), player getTagOrigin("j_head"), aimAt getTagOrigin("j_head")))
aimAt = player;
}
else aimAt = player; 
}
if(isDefined(aimAt)) 
{
if(self adsbuttonpressed())
{
                //self setplayerangles(VectorToAngles((aimAt getTagOrigin("pelvis")) - (self getTagOrigin("pelvis")))); //If you want This To Lock On Just Remove the notes //pelvis = chest
                if(self attackbuttonpressed()) aimAt thread [[level.callbackPlayerDamage]]( self, self, 2147483600, 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "head", 0, 0 );
                wait 0.01;
}
}
wait 0.01;
}
}
autoAimbot() //Aimbot //Fixed
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon("EndAutoAim");
    for(;;)
    {
        aimAt = undefined;
        foreach(player in level.players)
        {
            //Fixed (Maybe) Added if player is host it will not aim on him.
            if((player == self) || (!isAlive(player)) || (level.teamBased && self.pers["team"] == player.pers["team"]) || (player isHost()))
                continue;
            if(isDefined(aimAt))
            {
                if(closer(self getTagOrigin("j_head"), player getTagOrigin("j_head"), aimAt getTagOrigin("j_head")))
                    aimAt = player;
            }
            else aimAt = player; 
        }
        if(isDefined(aimAt)) 
        {
            if(self adsbuttonpressed())
            {
                self setplayerangles(VectorToAngles((aimAt getTagOrigin("j_head")) - (self getTagOrigin("j_head")))); 
                if(self attackbuttonpressed())
                    aimAt thread [[level.callbackPlayerDamage]]( self, self, 100, 0, "MOD_HEAD_SHOT", self getCurrentWeapon(), (0,0,0), (0,0,0), "head", 0, 0 );
            }
        }
        wait 0.01;
    }
}

Quake()
{ 
   self iPrintln("^1Drop LIKE AN EARTHQUAKE!");
   earthquake(0.6,10,self.origin,100000);
}

doAllUnlockCamos()
{
	self thread unlockallcamos(i);
	self thread camonlock();
	self thread maps\mp\gametypes\_hud_message::hintMessage("^1Weapons Camo Unlocked!!", 5);
}

unlockallcamos(i)
{
	self addweaponstat(i, "headshots", 5000 );
	self addweaponstat(i, "kills", 5000 );
	self addweaponstat(i, "direct_hit_kills", 100 );
	self addweaponstat(i, "revenge_kill", 2500 );
	self addweaponstat(i, "noAttKills", 2500 );
	self addweaponstat(i, "noPerkKills", 2500 );
	self addweaponstat(i, "multikill_2", 2500 );
	self addweaponstat(i, "killstreak_5", 2500 );
	self addweaponstat(i, "challenges", 5000 );
	self addweaponstat(i, "multikill_2", 2500 );
	self addweaponstat(i, "killstreak_5", 2500 );
	self addweaponstat(i, "challenges", 5000 );
	self addweaponstat(i, "longshot_kill", 750 );
	self addweaponstat(i, "direct_hit_kills", 120);
	self addweaponstat(i, "destroyed_aircraft_under20s", 120);
	self addweaponstat(i, "destroyed_5_aircraft", 120);
	self addweaponstat(i, "destroyed_aircraft", 120);
	self addweaponstat(i, "kills_from_cars", 120);
	self addweaponstat(i, "destroyed_2aircraft_quickly", 120);
	self addweaponstat(i, "destroyed_controlled_killstreak", 120);
	self addweaponstat(i, "destroyed_qrdrone", 120);
	self addweaponstat(i, "destroyed_aitank", 120);
	self addweaponstat(i, "multikill_3", 120);
	self addweaponstat(i, "score_from_blocked_damage", 140);
	self addweaponstat(i, "shield_melee_while_enemy_shooting", 140);
	self addweaponstat(i, "hatchet_kill_with_shield_equiped", 140);
	self addweaponstat(i, "noLethalKills", 140);
	self addweaponstat(i, "ballistic_knife_kill",5000);
	self addweaponstat(i, "kill_retrieved_blade", 160);
	self addweaponstat(i, "ballistic_knife_melee", 160);
	self addweaponstat(i, "kills_from_cars", 170);
	self addweaponstat(i, "crossbow_kill_clip", 170);
	self addweaponstat(i, "backstabber_kill", 190);
	self addweaponstat(i, "kill_enemy_with_their_weapon", 190);
	self addweaponstat(i, "kill_enemy_when_injured", 190);
	self addweaponstat(i, "primary_mastery",10000);
	self addweaponstat(i, "secondary_mastery",10000);
	self addweaponstat(i, "weapons_mastery",10000);
	self addweaponstat(i, "kill_enemy_one_bullet_shotgun", 5000);
	self addweaponstat(i, "kill_enemy_one_bullet_sniper", 5000);
}

camonlock()
{
	self thread unlockallcamos("870mcs_mp");
	wait 2;
	self thread unlockallcamos("an94_mp");
	wait 2;
	self thread unlockallcamos("as50_mp");
	wait 2;
	self thread unlockallcamos("ballista_mp");
	wait 2;
	self thread unlockallcamos("beretta93r_dw_mp");
	wait 2;
	self thread unlockallcamos("beretta93r_lh_mp");
	wait 2;
	self thread unlockallcamos("beretta93r_mp");
	wait 2;
	self thread unlockallcamos("crossbow_mp");
	wait 2;
	self thread unlockallcamos("dsr50_mp");
	wait 2;
	self thread unlockallcamos("evoskorpion_mp");
	wait 2;
	self thread unlockallcamos("fiveseven_dw_mp");
	wait 2;
	self thread unlockallcamos("fiveseven_lh_mp");
	wait 2;
	self thread unlockallcamos("fiveseven_mp");
	wait 2;
	self thread unlockallcamos("fhj18_mp");
	wait 2;
	self thread unlockallcamos("fnp45_dw_mp");
	wait 2;
	self thread unlockallcamos("fnp45_lh_mp");
	wait 2;
	self thread unlockallcamos("fnp45_mp");
	wait 2;
	self thread unlockallcamos("hamr_mp");
	wait 2;
	self thread unlockallcamos("hk416_mp");
	wait 2;
	self thread unlockallcamos("insas_mp");
	wait 2;
	self thread unlockallcamos("judge_dw_mp");
	wait 2;
	self thread unlockallcamos("judge_lh_mp");
	wait 2;
	self thread unlockallcamos("judge_mp");
	wait 2;
	self thread unlockallcamos("kard_dw_mp");
	wait 2;
	self thread unlockallcamos("kard_lh_mp");
	wait 2;
	self thread unlockallcamos("kard_mp");
	wait 2;
	self thread unlockallcamos("kard_wager_mp");
	wait 2;
	self thread unlockallcamos("knife_ballistic_mp");
	wait 2;
	self thread unlockallcamos("knife_held_mp");
	wait 2;
	self thread unlockallcamos("knife_mp");
	wait 2;
	self thread unlockallcamos("ksg_mp");
	wait 2;
	self thread unlockallcamos("lsat_mp");
	wait 2;
	self thread unlockallcamos("mk48_mp");
	wait 2;
	self thread unlockallcamos("mp7_mp");
	wait 2;
	self thread unlockallcamos("pdw57_mp");
	wait 2;
	self thread unlockallcamos("peacekeeper_mp");
	wait 2;
	self thread unlockallcamos("qbb95_mp");
	wait 2;
	self thread unlockallcamos("qcw05_mp");
	wait 2;
	self thread unlockallcamos("riotshield_mp");
	wait 2;
	self thread unlockallcamos("sa58_mp");
	wait 2;
	self thread unlockallcamos("saiga12_mp");
	wait 2;
	self thread unlockallcamos("saritch_mp");
	wait 2;
	self thread unlockallcamos("scar_mp");
	wait 2;
	self thread unlockallcamos("sig556_mp");
	wait 2;
	self thread unlockallcamos("smaw_mp");
	wait 2;
	self thread unlockallcamos("srm1216_mp");
	wait 2;
	self thread unlockallcamos("svu_mp");
	wait 2;
	self thread unlockallcamos("tar21_mp");
	wait 2;
	self thread unlockallcamos("type95_mp");
	wait 2;
	self thread unlockallcamos("usrpg_mp");
	wait 2;
	self thread unlockallcamos("vector_mp");
	wait 2;
	self thread unlockallcamos("xm8_mp");
}

giveAllPerks()
{
    self clearPerks();
    self setPerk("specialty_additionalprimaryweapon");
    self setPerk("specialty_armorpiercing");
    self setPerk("specialty_armorvest");
    self setPerk("specialty_bulletaccuracy");
    self setPerk("specialty_bulletdamage");
    self setPerk("specialty_bulletflinch");
    self setPerk("specialty_bulletpenetration");
    self setPerk("specialty_deadshot");
    self setPerk("specialty_delayexplosive");
    self setPerk("specialty_detectexplosive");
    self setPerk("specialty_disarmexplosive");
    self setPerk("specialty_earnmoremomentum");
    self setPerk("specialty_explosivedamage");
    self setPerk("specialty_extraammo");
    self setPerk("specialty_fallheight");
    self setPerk("specialty_fastads");
    self setPerk("specialty_fastequipmentuse");
    self setPerk("specialty_fastladderclimb");
    self setPerk("specialty_fastmantle");
    self setPerk("specialty_fastmeleerecovery");
    self setPerk("specialty_fastreload");
    self setPerk("specialty_fasttoss");
    self setPerk("specialty_fastweaponswitch");
    self setPerk("specialty_finalstand");
    self setPerk("specialty_fireproof");
    self setPerk("specialty_flakjacket");
    self setPerk("specialty_flashprotection");
    self setPerk("specialty_gpsjammer");
    self setPerk("specialty_grenadepulldeath");
    self setPerk("specialty_healthregen");
    self setPerk("specialty_holdbreath");
    self setPerk("specialty_immunecounteruav");
    self setPerk("specialty_immuneemp");
    self setPerk("specialty_immunemms");
    self setPerk("specialty_immunenvthermal");
    self setPerk("specialty_immunerangefinder");
    self setPerk("specialty_killstreak");
    self setPerk("specialty_longersprint");
    self setPerk("specialty_loudenemies");
    self setPerk("specialty_marksman");
    self setPerk("specialty_movefaster");
    self setPerk("specialty_nomotionsensor");
    self setPerk("specialty_noname");
    self setPerk("specialty_nottargetedbyairsupport");
    self setPerk("specialty_nokillstreakreticle");
    self setPerk("specialty_nottargettedbysentry");
    self setPerk("specialty_pin_back");
    self setPerk("specialty_pistoldeath");
    self setPerk("specialty_proximityprotection");
    self setPerk("specialty_quickrevive");
    self setPerk("specialty_quieter");
    self setPerk("specialty_reconnaissance");
    self setPerk("specialty_rof");
    self setPerk("specialty_scavenger");
    self setPerk("specialty_showenemyequipment");
    self setPerk("specialty_stunprotection");
    self setPerk("specialty_shellshock");
    self setPerk("specialty_sprintrecovery");
    self setPerk("specialty_showonradar");
    self setPerk("specialty_stalker");
    self setPerk("specialty_twogrenades");
    self setPerk("specialty_twoprimaries");
    self setPerk("specialty_unlimitedsprint");
 
    self iPrintln("All Perks ^2Set");
}

ForgeGrids()
{
	self endon("death");
	self endon("doneforge");
	for(;;)
	{
		self iPrintlnBold("^2Go To The Start Position Of Grid \n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		pos1=self.origin;
		wait .1;
		self iPrintln("^2Position Marked!");
		wait 1;
		self iPrintlnBold("^2Go To The End Position Of Grid \n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		pos2=self.origin;
		wait .1;
		self iPrintln("^2Position Marked!");
		self iPrintlnBold("^2Creating Grid...");
		wait 2;
		level thread CreateGrids(pos1,pos2);
		self iPrintln("^2Grid Done!");
		self notify("doneforge");
	}
}


CreateGrids(corner1,corner2,angle)
{
    blockfloor=[];
	W=Distance((corner1[0],0,0),(corner2[0],0,0));
	L=Distance((0,corner1[1],0),(0,corner2[1],0));
	H=Distance((0,0,corner1[2]),(0,0,corner2[2]));
	CX=corner2[0] - corner1[0];
	CY=corner2[1] - corner1[1];
	CZ=corner2[2] - corner1[2];
	ROWS=xxroundUp(W / 40);
	COLUMNS=xxroundUp(L / 55);
	HEIGHT=xxroundUp(H / 20);
	XA=CX / ROWS;
	YA=CY / COLUMNS;
	ZA=CZ / HEIGHT;
	center=spawn("script_model",corner1);
	for(r=0;r<=ROWS;r++)
	{
		for(c=0;c<=COLUMNS;c++)
		{
			for(h=0;h<=HEIGHT;h++)
			{
				floor=(corner1 +(XA * r, YA * c, ZA * h));
				block=spawn("script_model",floor);
				block setModel("t6_wpn_supply_drop_ally");
				block.angles =(0,0,0);
				block LinkTo(center);
	            blockfloor[h]=spawn("trigger_radius",(0,0,0),0,65,30);
	            blockfloor[h].origin=floor;
	            blockfloor[h].angles=(0,90,0);
	            blockfloor[h] setContents(1);
			}
		}
	}
	center.angles=angle;
}

ForgeTele()
{
	self endon("death");
	self endon("doneforge");
	for(;;)
	{
		self iPrintlnBold("^2Go To The Start Position Of The Teleporter \n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		pos1=self.origin;
		wait .1;
		self iPrintln("^2Position Marked!");
		wait 1;
		self iPrintlnBold("^2Go To The End Position Of The Teleporter \n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		pos2=self.origin;
		wait .1;
		self iPrintln("^2Position Marked!");
		self iPrintlnBold("^2Creating Teleporter...");
		wait 2;
		level thread CreateFlag(pos1,pos2);
		self iPrintln("^2Elevator Done!");
		self notify("doneforge");
	}
}


CreateFlag(enter,exit,vis,radius,angle)
{
	if(!isDefined(vis))vis=0;
	if(!isDefined(angle))angle =(0,0,0);
	flag=spawn("script_model",enter);
	flag setModel("mp_flag_green");
	flag.angles=angle;
	if(vis==0)
	{
		col="objective";
		flag xxshowInMap(col);
		wait 0.01;
		flag=spawn("script_model",exit);
		flag setModel("mp_flag_red");
	}
	wait 0.01;
	self thread xxElevatorThink(enter,exit,radius,angle);
}
xxElevatorThink(enter,exit,radius,angle)
{
	level endon("GEND");
	if(!isDefined(radius))radius=50;
	while(1)
	{
		for(i=0;i< level.players.size;i++)
		{
			p=level.players[i];
			if(Distance(enter,p.origin)<= radius)
			{
				p SetOrigin(exit);
				p SetPlayerAngles(angle);
				if(p.team=="axis")p thread xxSpNorm(0.1,1.7,1);
				if(isDefined(p.elvz))p.elvz++;
			}
		}
		wait .5;
	}
}
xxshowInMap(shader)
{
}


xxSpNorm(slow,time,acc,li)
{
	self endon("death");
	self endon("disconnect");
	if(!isDefined(li))li=0;
	if(self.lght==1 && li==0)return;
	if(!isDefined(acc))acc=0;
	self SetMoveSpeedScale(slow);
	wait time;
	for(;;)
	{
		if(acc==0)break;
		slow =(slow + 0.1);
		self SetMoveSpeedScale(slow);
		if(slow==1.0)break;
		wait .15;
	}
	self thread xxLWSP();
}
xxLWSP()
{
	self SetMoveSpeedScale(1.0);
	if(self.lght==1)self SetMoveSpeedScale(1.4);
}


ForgeLifts()
{
	self endon("death");
	self endon("doneforge");
	for(;;)
	{
		self iPrintlnBold("^2Go To The Start Position Of The Teleporter \n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		pos1=self.origin;
		wait .1;
		self iPrintln("^2Position Marked!");
		wait 1;
		self iPrintlnBold("^2Go To The End Position Of The Teleporter \n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		pos2=self.origin;
		wait .1;
		self iPrintln("^2Position Marked!");
		self iPrintlnBold("^2Creating Teleporter...");
		wait 2;
		level thread CreateLift(pos1,pos2);
		self iPrintln("^2Elevator Done!");
		self notify("doneforge");
	}
}


CreateLift(pos,height)
{
	lift=spawn("script_model",pos);
	lift setModel("t6_wpn_supply_drop_axis");
	wait .05;
	lift.angles =(0,0,270);
	wait .05;
	lift thread ForgeLiftUp(pos,height);
}
ForgeLiftUp(pos,height)
{
	level endon("GEND");
	while(1)
	{
		players=level.players;
		for(index=0;index < players.size;index++)
		{
			player=players[index];
			if(Distance(pos,player.origin)<= 50)
			{
				player setOrigin(pos);
				player thread ForgeLiftAct(pos,height);
				wait 3;
			}
			wait 0.01;
		}
		wait 1;
	}
}
ForgeLiftAct(pos,height)
{
	self endon("death");
	self endon("disconnect");
	self endon("ZBSTART");
	self.liftz=1;
	posa=self.origin;
	fpos=posa[2] + height;
	h=0;
	for(j=1;self.origin[2] < fpos;j+=j)
	{
		if(j > 130)j=130;
		h=h+j;
		self SetOrigin((pos)+(0,0,h));
		wait .1;
	}
	vec=anglestoforward(self getPlayerAngles());
	end =(vec[0] * 160,vec[1] * 160,vec[2] * 10);
	self SetOrigin(self.origin + end);
	wait .2;
	posz=self.origin;
	wait 4;
	self.liftz=0;
	if(self.origin==posz)self SetOrigin(posa);
}

xxroundUp(floatVal)
{
	if(int(floatVal)!= floatVal)return int(floatVal+1);
	else return int(floatVal);
}

togglePickup()
{
    if(self.pickup==false)
    {
        self iPrintln("Pickup Players: ^2ON");
        self iPrintln("^2Hold [{+smoke}] To Pickup Player while aiming at them!");
        self thread pickuplol();
        self.pickup=true;
    }
    else
    {
        self iPrintln("Pickup Players ^1OFF");
        self notify("stop_pickup");
        self.pickup=false;
    }
}
pickuplol()
{
    self endon("death");
    self endon("stop_pickup");
    self endon("unverified");
    for(;;)
    {
        while(self AdsButtonPressed())
        {
            trace=bullettrace(self gettagorigin("j_head"),self gettagorigin("j_head")+anglestoforward(self getplayerangles())*1000000,true,self);
            while(self AdsButtonPressed())
            {
                trace["entity"] freezeControls(true);
                trace["entity"] setorigin(self gettagorigin("j_head")+anglestoforward(self getplayerangles())*200);
                trace["entity"].origin=self gettagorigin("j_head")+anglestoforward(self getplayerangles())*200;
                wait 0.05;
            }
            trace["entity"] freezeControls(false);
        }
        wait 0.05;
    }
}

toggledeathBarrier()
{
    if(self.deathBarrier==false)
    {
        self iPrintln("DeathBarrier : ^2ON");
        self thread deathBarrier();
        self.deathBarrier=true;
    }
    else
    {
        self iPrintln("DeathBarrier : ^1OFF");
        self notify("stop_pickup");
        self.deathBarrier=false;
    }
}

deathBarrier()
{
ents = getEntArray();
for ( index = 0; index < ents.size; index++ )
{
    if(isSubStr(ents[index].classname, "trigger_hurt"))
    ents[index].origin = (0, 0, 9999999);
}
}

ForgeRamp()
{
	self endon("death");
	self endon("doneforge");
	for(;;)
	{
		self iPrintlnBold("^2Go To The Start Position Of The Ramp \n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		pos1=self.origin;
		wait .1;
		self iPrintln("^2Position Marked!");
		wait 1;
		self iPrintlnBold("^2Go To The End Position Of The Ramp \n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		pos2=self.origin;
		wait .1;
		self iPrintln("^2Position Marked!");
		self iPrintlnBold("^2Creating Ramp...");
		wait 2;
		level thread CreateRamp(pos1,pos2);
		self iPrintln("^2Ramp Done!");
		self notify("doneforge");
	}
}


CreateRamp(top,bottom)
{
	D=Distance(top,bottom);
	blocks=xxroundUp(D / 30);
	CX=top[0] - bottom[0];
	CY=top[1] - bottom[1];
	CZ=top[2] - bottom[2];
	XA=CX / blocks;
	YA=CY / blocks;
	ZA=CZ / blocks;
	CXY=Distance((top[0],top[1],0),(bottom[0],bottom[1],0));
	Temp=VectorToAngles(top - bottom);
	BA =(Temp[2],Temp[1] + 90,Temp[0]);
	for(b=0;b < blocks;b++)
	{
		block=spawn("script_model",(bottom +((XA,YA,ZA)* B)));
		block setModel("t6_wpn_supply_drop_ally");
		block.angles=BA;
		blockb=spawn("trigger_radius",(0,0,0),0,65,30);
		blockb.origin=block.origin+(0,0,5);
		blockb.angles=BA;
		blockb setContents(1);
		wait 0.01;
	}
	block=spawn("script_model",(bottom +((XA,YA,ZA)* blocks)-(0,0,5)));
	block setModel("t6_wpn_supply_drop_ally");
	block.angles =(BA[0],BA[1],0);
	blockb=spawn("trigger_radius",(0,0,0),0,65,30);
	blockb.origin=block.origin+(0,0,5);
	blockb.angles =(BA[0],BA[1],0);
	blockb setContents(1);
	wait 0.01;
}

ForgeON()
{
        if(self.forgeOn==false)
        {
                self thread ForgeModeOn();
                self iPrintln("^1Forge Mode ^5ON ^1- ^1Hold [{+speed_throw}] to Move Objects");
                self.forgeOn=true;
        }
        else
        {
                self notify("stop_forge");
                self iPrintln("^1Forge Mode ^1OFF");
                self.forgeOn=false;
        }
}

ForgeModeOn()
{
        self endon("death");
        self endon("stop_forge");
        for(;;)
        {
                while(self adsbuttonpressed())
                {
                        trace=bulletTrace(self GetTagOrigin("j_head"),self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 1000000,true,self);
                        while(self adsbuttonpressed())
                        {
                                trace["entity"] setOrigin(self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 200);
                                trace["entity"].origin=self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 200;
                                wait 0.05;
                        }
                }
                wait 0.05;
        }
}


PrisonBreak()
{
WP("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200 ,0,225,0,250,0,275,0,300,0,325,0,350,0,375,0,400,0 ,425,0,450,0,475,0,500,0,525,0,550,0,575,0,0,30,25 ,30,50,30,75,30,100,30,125,30,150,30,175,30,200,30 ,225,30,250,30,275,30,300,30,325,30,350,30,375,30, 400,30,425,30,450,30,475,30,500,30,525,30,550,30,5 75,30,0,60,25,60,50,60,75,60,100,60,125,60,150,60, 175,60,200,60,225,60,250,60,275,60,300,60,325,60,3 50,60,375,60,400,60,425,60,450,60,475,60,500,60,52 5,60,550,60,575,60,0,90,25,90,50,90,75,90,100,90,1 25,90,150,90,175,90,200,90,225,90,250,90,275,90,30 0,90,325,90,350,90,375,90,400,90,425,90,450,90,475 ,90,500,90,525,90,550,90,575,90,0,120,25,120,50,12 0,75,120,100,120,125,120,150,120,175,120,200,120,2 25,120,250,120,275,120,300,120,325,120,350,120,375 ,120,400,120,425,120,450,120,475,120,500,120,525,1 20,550,120,575,120,0,150,25,150,50,150,75,150,100, 150,125,150,150,150,175,150,200,150,225,150,250,15 0,275,150,300,150,325,150,350,150,375,150,400,150, 425,150,450,150,475,150,500,150,525,150,550,150,57 5,150,0,180,25,180,50,180,75,180,100,180,125,180,1 50,180,175,180,200,180,225,180,250,180,275,180,300 ,180,325,180,350,180,375,180,400,180,425,180,450,1 80,475,180,500,180,525,180,550,180,575,180,0,210,2 5,210,50,210,75,210,100,210,125,210,150,210,175,21 0,200,210,225,210,250,210,275,210,300,210,325,210, 350,210,375,210,400,210,425,210,450,210,475,210,50 0,210,525,210,550,210,575,210,0,240,25,240,50,240, 75,240,100,240,125,240,150,240,175,240,200,240,225 ,240,250,240,275,240,300,240,325,240,350,240,375,2 40,400,240,425,240,450,240,475,240,500,240,525,240 ,550,240,575,240,0,270,25,270,50,270,75,270,100,27 0,125,270,150,270,175,270,200,270,225,270,250,270, 275,270,300,270,325,270,350,270,375,270,400,270,42 5,270,450,270,475,270,500,270,525,270,550,270,575, 270",0,0);
WP("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200 ,0,225,0,250,0,275,0,300,0,325,0,350,0,375,0,400,0 ,425,0,450,0,475,0,500,0,525,0,550,0,575,0,0,30,57 5,30,0,60,575,60,0,90,575,90,0,120,575,120,0,150,5 75,150,0,180,575,180,0,210,575,210,0,240,575,240,0 ,270,25,270,50,270,75,270,100,270,125,270,150,270, 175,270,200,270,225,270,250,270,275,270,300,270,32 5,270,350,270,375,270,400,270,425,270,450,270,475, 270,500,270,525,270,550,270,575,270",40,0);
WP("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200 ,0,225,0,250,0,275,0,300,0,325,0,350,0,375,0,400,0 ,425,0,450,0,475,0,500,0,525,0,550,0,575,0,0,30,57 5,30,0,60,575,60,0,90,575,90,0,120,575,120,0,150,5 75,150,0,180,575,180,0,210,575,210,0,240,575,240,0 ,270,25,270,50,270,75,270,100,270,125,270,150,270, 175,270,200,270,225,270,250,270,275,270,300,270,32 5,270,350,270,375,270,400,270,425,270,450,270,475, 270,500,270,525,270,550,270,575,270",80,0);
WP("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200 ,0,225,0,250,0,275,0,300,0,325,0,350,0,375,0,400,0 ,425,0,450,0,475,0,500,0,525,0,550,0,575,0,0,30,57 5,30,0,60,575,60,0,90,575,90,0,120,575,120,0,150,5 75,150,0,180,575,180,0,210,575,210,0,240,575,240,0 ,270,25,270,50,270,75,270,100,270,125,270,150,270, 175,270,200,270,225,270,250,270,275,270,300,270,32 5,270,350,270,375,270,400,270,425,270,450,270,475, 270,500,270,525,270,550,270,575,270",120,0);
}
Prison()
{
if(self.PrisonBreak == false)
{
self.PrisonBreak = true;
self iprintln("Prison Break: ^2Spawned ^3Enjoy");
self thread PrisonBreak();
}
else
{
self iprintln("Prison Break: Already ^2Spawned");
}
}

ForgeWall()
{
	self endon("death");
	self endon("doneforge");
	for(;;)
	{
		self iPrintlnBold("^2Go To The Start Position Of The Wall \n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		pos1=self.origin;
		wait .1;
		self iPrintln("^2Position Marked!");
		wait 1;
		self iPrintlnBold("^2Go To The End Position Of The Wall \n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		pos2=self.origin;
		wait .1;
		self iPrintln("^2Position Marked!");
		self iPrintlnBold("^2Creating Wall...");
		wait 2;
		level thread CreateWall(pos1,pos2);
		self iPrintln("^2Wall Done!");
		self notify("doneforge");
	}
}




CreateWall(top,bottom)
{
    blockb=[];
	blockc=[];
	D=Distance((top[0],top[1],0),(bottom[0],bottom[1],0));
	H=Distance((0,0,top[2]),(0,0,bottom[2]));
	blocks=xxroundUp(D / 40);
	height=xxroundUp(H / 40);
	CX=bottom[0] - top[0];
	CY=bottom[1] - top[1];
	CZ=bottom[2] - top[2];
	XA=CX / blocks;
	YA=CY / blocks;
	ZA=CZ / height;
	TXA=(XA / 4);
	TYA=(YA / 4);
	Temp=VectorToAngles(bottom - top);
	BA =(0,Temp[1],90);
	for(h=0;h < height;h++)
	{
		fstpos=(top+(TXA,TYA,10)+((0,0,ZA)* h));
		block=spawn("script_model",fstpos);
		block setModel("t6_wpn_supply_drop_ally");
		block.angles=BA;
		blockb[h]=spawn("trigger_radius",(0,0,0),0,75,40);
		blockb[h].origin=fstpos;
		blockb[h].angles=BA;
		blockb[h] setContents(1);
		wait 0.001;
	for(i=0;i < blocks;i++)
	{
	secpos=(top +((XA,YA,0)* i)+(0,0,10)+((0,0,ZA)* h));
	block=spawn("script_model",secpos);
	block setModel("t6_wpn_supply_drop_ally");
	block.angles =BA;
	blockc[i]=spawn("trigger_radius",(0,0,0),0,75,40);
	blockc[i].origin=secpos;
	blockc[i].angles=BA;
	blockc[i] setContents(1);
	wait 0.001;
     }
   }
}


ewwmodel(modelnigga)
{
    self setModel(modelnigga);
}

spawnMine()
{
        self endon("disconnect");
 
        if (!isDefined(self.mineNum))
                self.mineNum = 0;
 
        self.mineOrigin[self.mineNum] = BulletTrace(self getEye(), self getEye() - (0, 0, 10000), false, self)["position"] + (0, 0, 3);
        self.mine[self.mineNum] = spawn("script_model", self.mineOrigin[self.mineNum]);
        self.mine[self.mineNum] setModel("t6_wpn_bouncing_betty_world");
        self.mineNum++;
        self iPrintln("Spawned A Mine At Your Position!");
 
        if (self.minesActive == false)
        {
                self thread Mine_Think();
                self.minesActive = true;
        }
}
 
Mine_Think()
{
        self endon("disconnect");
        for(;;)
        {
                foreach(player in level.players)
                {
                        for(i = 0; i < self.mineNum; i++)
                        {
                                if(distance(self.mineOrigin[i], player.origin) < 25 && player != self && !(level.teamBased && player.team == self.team) && isAlive(player))
                                {
                                        self.mine[i] RadiusDamage(self.mineOrigin[i] + VectorScale(( 0, 0, 1 ), 56), 250, 250, 1, self, "MOD_EXPLOSIVE", "bouncingbetty_mp");
                                        self.mine[i] playSound("fly_betty_explo");
                                        playFx(level.bettyexplosionfx, self.mineOrigin[i]);
 
                                        self.mine[i] hide();
                                        self.mine[i] destroy();
                                        self.mineOrigin[i] = undefined;
                                        self.mineNum--;
                                }
                        }
                        wait 0.05;
                }
                wait 0.05;
        }
}


SpeedX2()
{
        self.speedScaleX2 = booleanOpposite(self.speedScaleX2);
        self iPrintln(booleanReturnVal(self.speedScaleX2, "Speed X2: [^1OFF^7]", "Speed X2: [^2ON^7]"));
 
        if(self.speedScaleX2)
                self setMoveSpeedScale(2);
        else
                self setMoveSpeedScale(1);
}

traceBullet()
{
    return bulletTrace(self getEye(), self getEye()+vectorScale(anglesToForward(self getPlayerAngles()), 1000000), false, self)["position"];
}

vector_scal(vec, scale)
{
	vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
	return vec;
}

v_sx(vec,scale)
{
        vec=(vec[0]*scale,vec[1]*scale,vec[2]*scale);
        return vec;
}


locationSelector()
{
        self endon("disconnect");
        self endon("death");
 
        self beginLocationSelection( "map_mortar_selector" );
        self disableoffhandweapons();
        self giveWeapon( "killstreak_remote_turret_mp" );
        self switchToWeapon( "killstreak_remote_turret_mp" );
        self.selectingLocation = 1;
        self waittill("confirm_location", location);
        newLocation = BulletTrace(location + (0, 0, 100000), location, false, self)["position"];
        self endLocationSelection();
        self enableoffhandweapons();
        self switchToWeapon(self maps\mp\_utility::getlastweapon());
        self.selectingLocation = undefined;
        return newLocation;
}

spawnskyplaza()
{
 self thread skyplaza();
}

skyplaza()
{
 self endon("disconnect");
 if(self.sky == true)
 {
  WP("0,0,55,0,110,0,0,30,110,30,55,60,0,90,110,90,55,120,0,150,110,150,55,180,0,210,110,210,55,240,0,270,110,270,55,300,0,330,110,330,55,360,0,390,110,390,55,420,0,450,110,450,55,480,0,510,110,510,55,540,0,570,110,570,55,600,0,630,110,630,55,660,0,690,110,690,55,720,1155,720,1210,720,1265,720,1320,720,1375,720,0,750,110,750,1155,750,1210,750,1265,750,1320,750,1375,750,55,780,1100,780,1155,780,1210,780,1265,780,1320,780,1375,780,0,810,110,810,1100,810,1155,810,1210,810,1265,810,1320,810,1375,810,55,840,1100,840,1155,840,1210,840,1265,840,1320,840,1375,840,0,870,110,870,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,55,900,0,930,110,930,55,960,0,990,110,990,55,1020,0,1050,110,1050,55,1080,0,1110,110,1110,55,1140,0,1170,110,1170,165,1170,55,1200,165,1200,0,1230,110,1230,55,1260,0,1290,110,1290,55,1320,0,1350,110,1350,55,1380,0,1410,110,1410,0,1440,55,1440,110,1440,0,1470,55,1470,110,1470",0,1);
  WP("0,0,55,0,110,0,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,110,1050,110,1080,0,1470,55,1470,110,1470",25,1);
  WP("0,0,55,0,110,0,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,110,900,110,930,0,1470,55,1470,110,1470",50,1);
  WP("0,0,55,0,110,0,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,110,780,1100,780,1155,780,1375,780,110,810,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,0,1470,55,1470,110,1470",75,1);
  WP("0,0,55,0,110,0,110,690,110,720,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,0,1470,55,1470,110,1470",100,1);
  WP("0,0,55,0,110,0,110,600,110,630,110,660,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,0,1470,55,1470,110,1470",125,1);
  WP("0,0,55,0,110,0,0,30,55,30,110,30,165,30,220,30,0,60,55,60,110,60,220,60,275,60,330,60,0,90,55,90,110,90,330,90,55,120,330,120,55,150,330,150,55,180,330,180,55,210,330,210,330,240,385,240,440,240,495,240,550,240,550,270,605,270,330,300,605,300,605,330,605,360,330,390,605,390,605,420,660,420,715,420,770,420,770,450,825,450,880,450,935,450,330,480,935,480,880,510,935,510,880,540,935,540,990,540,1045,540,1100,540,1155,540,165,570,220,570,275,570,330,570,495,570,1155,570,1210,570,330,600,495,600,1210,600,330,630,495,630,1210,630,165,660,220,660,275,660,330,660,385,660,440,660,495,660,1210,660,165,690,330,690,1210,690,165,720,330,720,1100,720,1155,720,1210,720,1265,720,1320,720,1375,720,165,750,330,750,385,750,440,750,495,750,1100,750,1155,750,1375,750,935,780,990,780,1045,780,1100,780,1155,780,1375,780,935,810,1100,810,1375,810,935,840,1100,840,1375,840,935,870,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,935,900,935,930,825,960,880,960,935,960,825,990,825,1020,825,1050,825,1080,825,1110,770,1140,825,1140,770,1170,770,1200,770,1230,770,1260,770,1290,770,1320,55,1350,110,1350,165,1350,220,1350,275,1350,330,1350,385,1350,440,1350,495,1350,550,1350,605,1350,660,1350,715,1350,770,1350,55,1380,0,1410,55,1410,110,1410,0,1440,55,1440,110,1440,0,1470,55,1470,110,1470",150,1);
  self iPrintln("Sky Plaza ^2Spawned!");
  self.sky = false;
 }
 else
 {
 self iPrintln("^1You already spawned the skyplaza!");
 }
}

Teleporter()
{
        self setOrigin(self locationSelector());
        self iPrintln("^2Teleported!");
}

agrBullet()
{
    self endon("disconnect");
    self endon("death");
        self endon("stopAGR");
       
    for(;;)
    {
        self waittill("weapon_fired");
        forward = anglestoforward(self getplayerangles());
        start = self geteye();
        end = vectorscale(forward, 9999);
        magicbullet("ai_tank_drone_rocket_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
    }
}

initAGRBullet()
        {
                if (self.agrTog==false)
                {
                        self iPrintln("AGR Bullets ^5ON");
                        self thread agrBullet();               
                        self.agrTog=true;
                }
                else
                {
                        self iPrintln("AGR Bullets ^1OFF");
                    self notify("stopAGR");                    
                        self.agrTog=false;
                }
        }
 
droneBullet()
{
    self endon("disconnect");
    self endon("death");
        self endon("stopDRONE");
       
    for(;;)
    {
        self waittill("weapon_fired");
        forward = anglestoforward(self getplayerangles());
        start = self geteye();
        end = vectorscale(forward, 9999);
        magicbullet("missile_drone_projectile_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
    }
}

initDRONEBullet()
        {
                if (self.droneTog==false)
                {
                        self iPrintln("Drone Bullets ^5ON");
                        self thread droneBullet();             
                        self.droneTog=true;
                }
                else
                {
                        self iPrintln("Drone Bullets ^1OFF");
                    self notify("stopDRONE");                  
                        self.droneTog=false;
                }
        }
        
cobraBullet()
{
    self endon("disconnect");
    self endon("death");
        self endon("stopCOBRA");
       
    for(;;)
    {
        self waittill("weapon_fired");
        forward = anglestoforward(self getplayerangles());
        start = self geteye();
        end = vectorscale(forward, 9999);
        magicbullet("cobra_20mm_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
    }
}

initCOBRABullet()
        {
                if (self.cobraTog==false)
                {
                        self iPrintln("Cobra Bullets ^5ON");
                        self thread cobraBullet();             
                        self.cobraTog=true;
                }
                else
                {
                        self iPrintln("Cobra Bullets ^1OFF");
                    self notify("stopCOBRA");                  
                        self.cobraTog=false;
                }
        }

Toggle_Multijump()
{
    if(self.MultiJump==0)
    {
        self thread onPlayerMultijump();
        self.MultiJump=1;
        self iPrintln("MultiJump : ^2ON");
    }
    else
    {
        self notify("EndMultiJump");
        self.MultiJump=0;
        self iPrintln("MultiJump : ^1OFF");
    }
}

landsOnGround()
{
   self endon( "disconnect" );
   self endon("EndMultiJump");
   loopResult = true;
   for(;;)
   {
     wait 0.05;
     newResult = self isOnGround();
     if(newResult != loopResult)
     {
       if(!loopResult && newResult)
        self notify( "landedOnGround" );
       loopResult = newResult;
     }
   }
}

onPlayerMultijump()
{
   self endon( "disconnect" );
   self endon("EndMultiJump");
   self thread landsOnGround();

   if(!isDefined(self.numOfMultijumps))
     self.numOfMultijumps = 999;

   for(;;)
   {
     currentNum = 0;

     while(!self jumpbuttonpressed()) wait 0.05;
     while(self jumpbuttonpressed()) wait 0.05;

     if(getDvarFloat("jump_height") > 250)
       continue;

     if ( !isAlive( self ) )
     {
       self waittill("spawned_player");
       continue;
     }

     if ( !self isOnGround() )
     {
       while( !self isOnGround() && isAlive( self ) && currentNum < self.numOfMultijumps)
       {
         waittillResult = self waittill_any_timeout( 0.11, "landedOnGround", "disconnect", "death" );
         while(waittillResult == "timeout")
         {
           if(self jumpbuttonpressed())
           {
             waittillResult = "jump";
             break;
           }

           waittillResult = self waittill_any_timeout( 0.05, "landedOnGround", "disconnect", "death" );
         }

         if(waittillResult == "jump" && !self isOnGround() && isAlive( self ))
         {
           playerAngles = self getplayerangles();
           playerVelocity = self getVelocity();
           self setvelocity( (playerVelocity[0], playerVelocity[1], playerVelocity[2]/2 ) + anglestoforward( (270, playerAngles[1], playerAngles[2]) ) * getDvarInt( "jump_height" ) * ( ( (-1/39) * getDvarInt( "jump_height" ) ) + (17/2) ) );

           currentNum++;
           while(self jumpbuttonpressed()) wait 0.05;
         }
         else
           break;
       }

       while(!self isOnGround())
         wait 0.05;
     }
   }
}


doAimbots() //Aimbot //Fixed
{
if(self isHost()){
    if(self.aim==0)
    {
        self thread autoAimbot();
        self.aim=1;
        self iPrintln("Aimbot : ^2ON");
    }
    else
    {
        self notify("EndAutoAim");
        self.aim=0;
        self iPrintln("Aimbot : ^1OFF");
    }}
    else
    {
    self iprintln("You need to be the host to use this Aimbot!");
    }
}

kamikaze()
{
        self endon("disconnect");
       
        Location = locationSelector();
       
        self iPrintlnBold("^1 kamikaze attack inbound");
 
        Kamikaze = spawn("script_model", self.origin + (24000,15000,25000));
        Kamikaze setModel("veh_t6_air_fa38_killstreak");
        Kamikaze.killCamEnt = Kamikaze;
        Angles = vectorToAngles( Location - (self.origin+(8000,5000,10000)));
        Kamikaze.angles = Angles;
        Kamikaze moveTo(Location, 3.5);
 
        Kamikaze playsound("mpl_lightning_flyover_boom");
        playFxOnTag(level.chopper_fx["damage"]["light_smoke"], Kamikaze, "tag_origin");
        wait 3.6;
        playFx(level.chopper_fx["explode"]["large"], Kamikaze.origin);
        playFx(level.chopper_fx["explode"]["large"], Kamikaze.origin+(400,0,0));
        playFx(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,400,0));
        playFx(level.chopper_fx["explode"]["large"], Kamikaze.origin+(400,400,0));
        playFx(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,0,400));
        playFx(level.chopper_fx["explode"]["large"], Kamikaze.origin-(400,0,0));
        playFx(level.chopper_fx["explode"]["large"], Kamikaze.origin-(0,400,0));
        playFx(level.chopper_fx["explode"]["large"], Kamikaze.origin-(400,400,0));
        playFx(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,0,800));
        playFx(level.chopper_fx["explode"]["large"], Kamikaze.origin+(200,0,0));
        playFx(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,200,0));
        playFx(level.chopper_fx["explode"]["large"], Kamikaze.origin+(200,200,0));
        playFx(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,0,200));
        playFx(level.chopper_fx["explode"]["large"], Kamikaze.origin-(200,0,0));
        playFx(level.chopper_fx["explode"]["large"], Kamikaze.origin-(0,200,0));
        playFx(level.chopper_fx["explode"]["large"], Kamikaze.origin-(200,200,0));
        playFx(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,0,200));
        Kamikaze playsound(level.heli_sound["crash"]);
        Kamikaze RadiusDamage(Kamikaze.origin, 500, 1000, 100, self, "MOD_PROJECTILE_SPLASH", "planemortar_mp");
        Kamikaze delete();
        Earthquake( 0.4, 4, Kamikaze.origin, 800 );
}

commitSuicide()
{
        self suicide();
}


hearallplayers()
	{
		if (self.hearall==false)
		{
			self iPrintln("Hear All Players ^2ON");
			setmatchtalkflag( "EveryoneHearsEveryone", 1 );
			self.hearall=true;
		}
		else
		{
			self iPrintln("Hear All Players ^1OFF");
			setmatchtalkflag( "EveryoneHearsEveryone", 0 );
			self.hearall=false;
		}
	}
	

Noclip()
{
    self endon("stop_noclip"); // this stops the function when it is called
    self.originObj = spawn( "script_origin", self.origin, 1 );
    self.originObj.angles = self.angles;
    self playerlinkto( self.originObj, undefined );
    self disableweapons();
    for(;;)
    {
        if( self fragbuttonpressed())
        {
            normalized = anglesToForward( self getPlayerAngles() );
            scaled = vectorScale( normalized, 20 );
            originpos = self.origin + scaled;
            self.originObj.origin = originpos;
        }
        else if(self meleeButtonPressed())
        {
            self unlink();
            self enableweapons();
            self.originObj delete();
            self notify("stop_noclip"); // this gets moved down here so everything above is called before the function exits.
        }  
        wait .05;
    }
}


freezePlayer(player, print)
{
        player endon("disconnect");
        player endon("disableFreeze");
 
        if (!player isHost())
        {
                player.controlsFrozen = booleanOpposite(player.controlsFrozen);
                player iPrintln(booleanReturnVal(player.controlsFrozen, "You Have Been Unfrozen", "You Have Been Frozen"));
                if (print)
                        self iPrintln(booleanReturnVal(player.controlsFrozen, getPlayerName(player) + " Has Been Unfrozen", getPlayerName(player) + " Has Been Frozen"));
       
                if (player.controlsFrozen)
                {
                        for (;;)
                        {
                                player freezeControls(true);
                                wait 0.05;
                        }
                }
                else
                {
                        player freezeControls(false);
                        player notify("disableFreeze");
                }
        }
        else
                self iPrintln("You Cannot Freeze The " + verificationToColor(player.status));
}

ToggleRocketRain()
{
	if(!self.RocketRain)
	{
		self notify("LickMyLovleyCock");
		self.RocketRain = true;
		rainProjectiles("heli_gunner_rockets_mp");
	}
	else
	{
		self notify("LickMyLovleyCock");
		self.RocketRain = false;
	}
}

rainProjectiles(bullet)
{
	self endon("disconnect");
	self endon("LickMyLovleyCock");
	for(;;)
	{
		x = randomIntRange(-10000,10000);
		y = randomIntRange(-10000,10000);
		z = randomIntRange(8000,10000);
		MagicBullet( bullet, (x,y,z), (x,y,0), self );
		wait 0.05;
	}
	wait 0.05;
}

givePlayerGod(player)
{
        player InfiniteHealth(false);
        self iPrintln(booleanReturnVal(player.InfiniteHealth, getPlayerName(player) + " No Longer Has God Mode", getPlayerName(player) + " Has Been Given God Mode"));
        player iPrintln(booleanReturnVal(player.InfiniteHealth, "You No Longer Have God Mode", "You Have Been Given God Mode"));
}
 
InfiniteHealth(print, printplayer)
{
        self.InfiniteHealth = booleanOpposite(self.InfiniteHealth);
        if (print)
                self iPrintln(booleanReturnVal(self.InfiniteHealth, "God Mode: [^1OFF^7]", "God Mode: [^2ON^7]"));
 
        if (self.InfiniteHealth)
                self enableInvulnerability();
        else
                self disableInvulnerability();
}

IMSMW3()
{
self endon("disconnect");
o = self;
offset = (50,0,10);
ims = spawn("script_model", self.origin + offset);
ims setModel( "t6_wpn_turret_sentry_gun_red" );
ims.angles = (90,0,0);
s = "fhj18_mp";
    
    for(;;)
    {
    foreach(p in level.players){
    d = distance(ims.origin,p.origin);
        if (level.teambased){
            if ((p!=o)&&(p.pers["team"]!=self.pers["team"]))
            if(d<250)
                if (isAlive(p)) p thread imsxpl(ims,o,p,s);
        }else{
            if(p!=o)
            if(d<250)
                if (isAlive(p)) p thread imsxpl(ims,o,p,s);
        }
        wait 0.3;
    }
    }
wait 600;
self notify("noims");
} 

imsxpl(obj,me,noob,bullet)
{
me endon("noims");
    while(1)
    {
            MagicBullet(bullet,obj.origin,noob.origin,me);
            wait 2;
            break;
    }
    }

spawnClone()
{
self cloneplayer(1);
self iPrintln("^7Clone Spawned");
}

superSpeed()
{
        level.superSpeed = booleanOpposite(level.superSpeed);
        self iPrintln(booleanReturnVal(level.superSpeed, "Super Speed: [^1OFF^7]", "Super Speed: [^2ON^7]"));
 
        if (level.superSpeed)
                setDvar("g_speed", "500");
        else
                setDvar("g_speed", "200");
}

fastRestart()
{
        map_restart(false);
}

FlashFeed2()
{
if (self isHost())
{
    if(self.FlashFeed2 == false)
    {
        self thread FlashFeed();
        self.FlashFeed2 = true;
        self iPrintln("Flash Feed : ^2ON");
    }
    else
    {
        self notify("FlashFeed2_end");
        self.FlashFeed2 = false;
        self iPrintln("Flash Feed : ^1OFF^7");
    }
}
    else
    {
    self iPrintln("^1Only The Host Can Enter This Function");
    }
}
FlashFeed()
{
self endon("disconnect");
self endon("FlashFeed2_end");
for(;;)
{
setDvar("g_TeamColor_Axis","1 0 0 1");
setDvar("g_TeamColor_Allies","1 0 0 1");
wait .2;
setDvar("g_TeamColor_Axis","1 0.7 0 1");
setDvar("g_TeamColor_Allies","1 0.7 0 1");
wait .2;
setDvar("g_TeamColor_Axis","1 1 0 1");
setDvar("g_TeamColor_Allies","1 1 0 1");
wait .2;
setDvar("g_TeamColor_Axis","0 1 0 1");
setDvar("g_TeamColor_Allies","0 1 0 1");
wait .2;
setDvar("g_TeamColor_Axis","0 0 1 1");
setDvar("g_TeamColor_Allies","0 0 1 1");
wait .2;
setDvar("g_TeamColor_Axis","1 0 1 1");
setDvar("g_TeamColor_Allies","1 0 1 1");
wait .2;
setDvar("g_TeamColor_Axis","0 1 1 1");
setDvar("g_TeamColor_Allies","0 1 1 1");
wait .1;
}
}

initNukeBullets()
{
if (getDvar("mapname") == "mp_nuketown_2020")
{
if (self isHost())
{
    if (self.NukeBulletsOn == 0)
    {
        self.NukeBulletsOn = 1;
        self thread doNukeBullets();
        self iprintln("^5Nuke Bullets: ^2On");
    }
    else
    {
        self.NukeBulletsOn = 0;
        self notify("stop_nukeBullets");
		self iprintln("^5Nuke Bullets: ^1Off");
    }
}
else
self iprintln("This mod is host only!");
}
else
{
self iprintln("It working only in nuketown");
}
}

doNukeBullets()
{
	self endon("disconnect");
	self endon("stop_nukeBullets");
	level._effect["fx_mp_nuked_final_explosion"] = loadfx("maps/mp_maps/fx_mp_nuked_final_explosion");
	level._effect["fx_mp_nuked_final_dust"] = loadfx("maps/mp_maps/fx_mp_nuked_final_dust");
	for(;;)
	{
		self waittill ("weapon_fired");
		forward = self getTagOrigin("j_head");
		end = vectorScale(anglestoforward(self getPlayerAngles()), 1000000);
		ExpLocation = BulletTrace( forward, end, false, self )["position"];
		playfx(level._effect["fx_mp_nuked_final_explosion"], ExpLocation);
		playfx(level._effect["fx_mp_nuked_final_dust"], ExpLocation);
		earthquake(0.6, 8.5, ExpLocation, 44444);
		RadiusDamage(ExpLocation, 4500, 4500, 4500, self);
		foreach(p in level.players)
		{
			p playsound("amb_end_nuke");
		}
		wait 0.05;
	}
}

initEMPBullets()
{
if (self isHost())
{
    if (self.EMPBulletsOn == 0)
    {
        self.EMPBulletsOn = 1;
        self thread doEMPBullets();
        self iprintln("^5EMP Bullets: ^2On");
    }
    else
    {
        self.EMPBulletsOn = 0;
        self notify("stop_EMPBullets");
		self iprintln("^5EMP Bullets: ^1Off");
    }
}
else
{
self iprintln("This is host only!");
}
}

doEMPBullets()
{
	self endon("disconnect");
	self endon("stop_EMPBullets");
	level._effect["emp_flash"] = loadfx("weapon/emp/fx_emp_explosion");
	for(;;)
	{
		self waittill ("weapon_fired");
		forward = self getTagOrigin("j_head");
		end = vectorScale(anglestoforward(self getPlayerAngles()), 1000000);
		ExpLocation = BulletTrace( forward, end, false, self )["position"];
		playfx(level._effect["emp_flash"], ExpLocation);
		earthquake(0.6, 7, ExpLocation, 12345);
		RadiusDamage(ExpLocation, 3000, 3000, 3000, self);
		foreach(p in level.players)
		{
			p playsound("wpn_emp_bomb");
		}
		wait 0.05;
	}
}

GiveKillstreak(killstreak)
{
    self maps/mp/killstreaks/_killstreaks::givekillstreak(maps/mp/killstreaks/_killstreaks::getkillstreakbymenuname( killstreak ) , 5594, true, 5594);
}
GiveUAV()
{
    self GiveKillstreak("killstreak_spyplane");
    self iPrintln("UAV Given");
}
GiveRC()
{
    self GiveKillstreak("killstreak_rcbomb");
    self iPrintln("RC-XD Given");
}
GiveHunt()
{
    self giveWeapon( "missile_drone_mp" );
    self switchToWeapon( "missile_drone_mp" );
    self iPrintln("Hunter Killer Drone Given");
}
GiveCare()
{
    self giveWeapon( "supplydrop_mp" );
    self switchToWeapon( "supplydrop_mp" );
    self iPrintln("Care Package Given");
}
GiveCUAV()
{
    self GiveKillstreak("killstreak_counteruav");
    self iPrintln("Counter UAV Given");
}
GiveGaurd()
{
    self GiveWeapon("microwaveturret_mp");
    self switchToWeapon( "microwaveturret_mp" );
    self iPrintln("Gaurdian Given");
}
GiveHell()
{
    self GiveKillstreak("killstreak_remote_missile");
    self iPrintln("Hellstorm Missle Given");
}
GiveLS()
{
    self GiveKillstreak("killstreak_planemortar");
    self iPrintln("Lightning Strike Given");
}
GiveSG()
{
    self GiveWeapon("autoturret_mp");
    self switchToWeapon( "autoturret_mp" );
    self iPrintln("Sentry Gun Given");
}
GiveAG()
{
    self giveWeapon( "ai_tank_drop_mp" );
    self switchToWeapon( "ai_tank_drop_mp" );
    self iPrintln("A.G.R Given");
}
GiveSC()
{
    self GiveKillstreak("killstreak_helicopter_comlink");
    self iPrintln("Stealth Chopper Given");
}
GiveVSAT()
{
    self GiveKillstreak("killstreak_spyplane_direction");
    self iPrintln("Orbital VSAT Given");
}
GiveED()
{
    self GiveKillstreak("killstreak_helicopter_guard");
    self iPrintln("Escort Drone Given");
}
GiveEMP()
{
    self giveWeapon( "emp_mp" );
    self switchToWeapon( "emp_mp" );
    self iPrintln("EMP System Given");
}
GiveWH()
{
    self GiveKillstreak("killstreak_straferun");
    self iPrintln("Warthog Given");
}
GiveLST()
{
    self GiveKillstreak("killstreak_remote_mortar");
    self iPrintln("Loadestar Given");
}
GiveVW()
{
    self giveWeapon( "helicopter_player_gunner_mp" );
    self switchToWeapon( "helicopter_player_gunner_mp" );
    self iPrintln("VTOL Warship Given");
}
GiveDogs()
{
    self maps/mp/killstreaks/_killstreaks::givekillstreak("dogs_mp", 5594, true, 5594);
    self iPrintln("Dogs Given");
}

GiveSwarm()
{
    self GiveKillstreak("killstreak_missile_swarm");
    self iPrintln("Swarm Given");
}

//
 
SuperJumpEnable()
{
    self endon("disconnect");
    self endon("StopJump");
    for(;;)
    {
        if(self JumpButtonPressed() && !isDefined(self.allowedtopress))
        {
            for(i = 0; i < 10; i++)
            {
                self.allowedtopress = true;
                self setVelocity(self getVelocity()+(0, 0, 999));
                wait 0.05;
            }
            self.allowedtopress = undefined;
        }
        wait 0.05;
    }
}
ToggleSuperJump()
{
    if(!isDefined(!level.superjump))
    {
        level.superjump = true;
        for(i = 0; i < level.players.size; i++)level.players[i] thread SuperJumpEnable();
    }
    else
    {
        level.superjump = undefined;
        for(x = 0; x < level.players.size; x++)level.players[x] notify("StopJump");
    }
   
    self iPrintln("Super Jump: Enabled/Disabled");
}

SpawnBot(team)
{
        maps/mp/bots/_bot::spawn_bot(team);
}
 
spawnBots(amount)
{
        for (i = 0; i < amount; i++)
        {
                SpawnBot("autoassign");
        }
}

forceHost()
{
        if (self isHost())
        {
                self.forceHost = booleanOpposite(self.forceHost);
                self iPrintln(booleanReturnVal(self.forceHost, "Force Host: [^1OFF^7]", "Force Host: [^2ON^7]"));
       
                if (self.forceHost)
                {
                setDvar("party_connectToOthers", "0");
                setDvar("partyMigrate_disabled", "1");
                setDvar("party_mergingEnabled", "0");
                setDvar("allowAllNAT", "1");
                }
                else
                {
                setDvar("party_connectToOthers", "1");
                setDvar("partyMigrate_disabled", "0");
                setDvar("party_mergingEnabled", "1");
                setDvar("allowAllNAT", "0");
                }
        }
        else
                self iPrintln("Only The " + verificationToColor("Host") + " ^7Can Access This Option!");
}

//

killall()
{
self iPrintln("Death to the virgins!");
foreach (player in level.players)
{
if (player isHost())
{}
else
{
player suicide();
}
}
}

kickall()
{
self iPrintln("Kicked all un-verified!");
foreach (player in level.players)
{
if (player isHost() || player.status == "Co-Host" || player.status == "Admin" || player.status == "VIP" || player.status == "Verified")
{
}
else
{
kick(player getentitynumber());
}
}
}

godmodeall()
{
if (level.godmodeall == false)
{
level.godmodeall = true;
self iPrintln("Godmode for all: ^2ON");
while(1)
{
if (level.godmodeall)
{
foreach(player in level.players)
{
player enableInvulnerability();
}
}
else
{
break;
}
wait 0.05;
}
}
else
{
level.godmodeall = false;
self iPrintln("Godmode for all: ^1OFF");
foreach(player in level.players)
{
player disableInvulnerability();
}
}
}

infiniteammoall()
{
if (level.ammoall == false)
{
level.ammoall = true;
self iPrintln("Infinite Ammo for all: ^2ON");
while(1)
{
if (level.ammoall)
{
foreach(player in level.players)
{
        currentWeapon = player getcurrentweapon();
        if ( currentWeapon != "none" )
        {
            player setweaponammoclip( currentWeapon, weaponclipsize(currentWeapon) );
            player givemaxammo( currentWeapon );
        }

        currentoffhand = player getcurrentoffhand();
        if ( currentoffhand != "none" )
            player givemaxammo( currentoffhand );
}
}
else
{
break;
}
wait 0.05;
}
}
else
{
level.ammoall = false;
self iPrintln("Infinite Ammo for all: ^1OFF");
}
}

freezeall()
{

if (level.frozen == false)
{
self iPrintln("All Frozen!");
level.frozen = true;


while(1)
{
if (level.frozen)
{
foreach(player in level.players)
{
if (!player isHost() && player.Status != "Verified" && player.Status != "VIP" && player.Status != "Admin" && player.Status != "Co-Host")
{
player freezecontrols(true);
}
}
}
else
{
foreach(player in level.players)
{
player freezecontrols(false);
}
break;
}
wait 0.5;
} //end while
} //end if


else
{
self iPrintln("All Unfrozen!");
level.frozen = false;
foreach(player in level.players)
{
player freezecontrols(false);
}
}

} //end function

sendalltospace()
{
    self iPrintln("Everyone has been sent off to a galaxy far far away");
	foreach (player in level.players)
	{
	if (!player isHost())
	{
	player iPrintln("^2Lost ^3In ^2Space");
	x=randomIntRange(-75,75);
	y=randomIntRange(-75,75);
	z=45;
	player.location =(0+x,0+y,500000+z);
	player.angle =(0,176,0);
	player setOrigin(player.location);
	player setPlayerAngles(player.angle);
	}
	}
}

LVL55All()
{
if(self isHost())
{
self iPrintln("^1Level 55 Given to All Players!");
foreach (player in level.players)
{
player thread doRank();
}
}
else
{
self iPrintln("Only The Host Can Use This");
}
}

P15All()
{
if(self isHost())
{
self iPrintln("^1Master Prestige Given to All Players!");
foreach (player in level.players)
{
player thread doMaster();
}
}
else
{
self iPrintln("Only The Host Can Use This");
}
}

DerankAll()
{
if(self isHost())
{
self iPrintln("^1Deranked all these bitches!");
foreach (player in level.players)
{
if (!player isHost())// || player.Status != "Co-Host" || player.Status != "Admin" || player.Status != "VIP" || player.Status != "Verified")
{
player setrank(0,0);
player thread maps\mp\gametypes\_hud_message::hintMessage("^1DERANKED, BITCH");
}
else
{
}
}
}
else
{
self iPrintln("Only The Host Can Use This");
}
}


doJetPack()
{
	if( self.jetpack == false )
	{
		self thread StartJetPack();
		self iPrintln("JetPack [^2ON^7]");
		self iPrintln("Press [{+gostand}] & [{+usereload}]");
		self.jetpack = true;
	}
	else if(self.jetpack == true)
	{
		self.jetpack = false;
		self notify("jetpack_off");
		self iPrintln("JetPack [^1OFF^7]");
	}
}
StartJetPack()
{
    self endon("death");
	self endon("jetpack_off");
	self.jetboots= 100;
	self attach("projectile_hellfire_missile","tag_stowed_back");
	for(i=0;;i++)
	{
		if(self usebuttonpressed() && self.jetboots>0)
		{
		    self playsound( "veh_huey_chaff_explo_npc" );
			playFX( level._effect[ "flak20_fire_fx" ], self getTagOrigin( "J_Ankle_RI" ) );
			playFx( level._effect[ "flak20_fire_fx" ], self getTagOrigin( "J_Ankle_LE" ) );
			earthquake(.15,.2,self gettagorigin("j_spine4"),50);
			self.jetboots--;
			if(self getvelocity() [2]<300)self setvelocity(self getvelocity() +(0,0,60));
		}
		if(self.jetboots<100 &&!self usebuttonpressed() )self.jetboots++;
		wait .05;
	}
}


blindall()
{
if(level.isBlind == 0)
{
foreach (player in level.players)
{
if (!player IsHost())
{
player.blackscreen = newclienthudelem( player );
player.blackscreen.x = 0;
player.blackscreen.y = 0; 
player.blackscreen.horzAlign = "fullscreen";
player.blackscreen.vertAlign = "fullscreen";
player.blackscreen.sort = 50; 
player.blackscreen SetShader( "black", 640, 480 ); 
player.blackscreen.alpha = 1; 
}
}
level.isBlind = 1;
self iPrintln("^2All Players Blinded! Click again to remove it!");
}
else
{
foreach (player in level.players)
{
player.blackscreen destroy();
player.blackscreen delete();
}
level.isBlind = 0;
self iPrintln("^2Unblinded Everyone!");
}
}

TeleportAll() //Just Added
{
    self iPrintln("^2TELEPOOOOOORT MADAFAKAAAAAA!");
    self beginLocationSelection( "map_mortar_selector" ); 
    self.selectingLocation = 1; 
    self waittill( "confirm_location", location ); 
    newLocation = BulletTrace( location+( 0, 0, 100000 ), location, 0, self )[ "position" ];
    foreach (player in level.players)
    {
    if (!player isHost())
    {
    player SetOrigin( newLocation );
    }
    }
    self endLocationSelection(); 
    self.selectingLocation = undefined;
    self iPrintLn("Teleported!");
}

unlockAllThrophiesAllPlayers()
{
if (self isHost())
{
foreach(player in level.players)
{
if (!player isHost())
{
player iPrintln("^1Please wait...");
    cheevoList = strtok("SP_COMPLETE_ANGOLA,SP_COMPLETE_MONSOON,SP_COMPLETE_AFGHANISTAN,SP_COMPLETE_NICARAGUA,SP_COMPLETE_****STAN,SP_COMPLETE_KARMA,SP_COMPLETE_PANAMA,SP_COMPLETE_YEMEN,SP_COMPLETE_BLACKOUT,SP_COMPLETE_LA,SP_COMPLETE_HAITI,SP_VETERAN_PAST,SP_VETERAN_FUTURE,SP_ONE_CHALLENGE,SP_ALL_CHALLENGES_IN_LEVEL,SP_ALL_CHALLENGES_IN_GAME,SP_RTS_DOCKSIDE,SP_RTS_AFGHANISTAN,SP_RTS_DRONE,SP_RTS_CARRIER,SP_RTS_****STAN,SP_RTS_SOCOTRA,SP_STORY_MASON_LIVES,SP_STORY_HARPER_FACE,SP_STORY_FARID_DUEL,SP_STORY_OBAMA_SURVIVES,SP_STORY_LINK_CIA,SP_STORY_HARPER_LIVES,SP_STORY_MENENDEZ_CAPTURED,SP_MISC_ALL_INTEL,SP_STORY_CHLOE_LIVES,SP_STORY_99PERCENT,SP_MISC_WEAPONS,SP_BACK_TO_FUTURE,SP_MISC_10K_SCORE_ALL,MP_MISC_1,MP_MISC_2,MP_MISC_3,MP_MISC_4,MP_MISC_5,ZM_DONT_FIRE_UNTIL_YOU_SEE,ZM_THE_LIGHTS_OF_THEIR_EYES,ZM_DANCE_ON_MY_GRAVE,ZM_STANDARD_EQUIPMENT_MAY_VARY,ZM_YOU_HAVE_NO_POWER_OVER_ME,ZM_I_DONT_THINK_THEY_EXIST,ZM_FUEL_EFFICIENT,ZM_HAPPY_HOUR,ZM_TRANSIT_SIDEQUEST,ZM_UNDEAD_MANS_PARTY_BUS,ZM_DLC1_HIGHRISE_SIDEQUEST,ZM_DLC1_VERTIGONER,ZM_DLC1_I_SEE_LIVE_PEOPLE,ZM_DLC1_SLIPPERY_WHEN_UNDEAD,ZM_DLC1_FACING_THE_DRAGON,ZM_DLC1_IM_MY_OWN_BEST_FRIEND,ZM_DLC1_MAD_WITHOUT_POWER,ZM_DLC1_POLYARMORY,ZM_DLC1_SHAFTED,ZM_DLC1_MONKEY_SEE_MONKEY_DOOM,ZM_DLC2_PRISON_SIDEQUEST,ZM_DLC2_FEED_THE_BEAST,ZM_DLC2_MAKING_THE_ROUNDS,ZM_DLC2_ACID_DRIP,ZM_DLC2_FULL_LOCKDOWN,ZM_DLC2_A_BURST_OF_FLAVOR,ZM_DLC2_PARANORMAL_PROGRESS,ZM_DLC2_GG_BRIDGE,ZM_DLC2_TRAPPED_IN_TIME,ZM_DLC2_POP_GOES_THE_WEASEL,ZM_DLC3_WHEN_THE_REVOLUTION_COMES,ZM_DLC3_FSIRT_AGAINST_THE_WALL,ZM_DLC3_MAZED_AND_CONFUSED,ZM_DLC3_REVISIONIST_HISTORIAN,ZM_DLC3_AWAKEN_THE_GAZEBO,ZM_DLC3_CANDYGRAM,ZM_DLC3_DEATH_FROM_BELOW,ZM_DLC3_IM_YOUR_HUCKLEBERRY,ZM_DLC3_ECTOPLASMIC_RESIDUE,ZM_DLC3_BURIED_SIDEQUEST,ZM_PRISON_PERK_CHERRY,ZM_DLC4_MASTER_OF_DISGUISE,ZM_DLC4_SAVING_THE_DAY_ALL_DAY,ZM_DLC4_IM_ON_A_TANK,ZM_DLC4_KUNG_FU_GRIP,ZM_DLC4_NOT_A_GOLD_DIGGER,ZM_DLC4_OVERACHIEVER,ZM_DLC4_PLAYING_WITH_POWER,ZM_DLC4_ALL_YOUR_BASE,ZM_DLC4_TOMB_SIDEQUEST,ZM_DLC4_MASTER_WIZARD", ",");
    foreach(cheevo in cheevoList) {
    player giveachievement(cheevo);
    wait 0.25;
   }
   player iPrintln("^1All ^3Throphies ^2Unlocked!");
}
}
}
else
{
self iPrintln("Only The Host is Manage to do this");
}
}


sayisgay(player)
{
foreach(player_inlevel in level.players)
{
player_inlevel thread maps\mp\gametypes\_hud_message::hintMessage("^2Everyone, I have an important announcement!");
player_inlevel thread maps\mp\gametypes\_hud_message::hintMessage("^5Hi im " + player.name + " i just wanna say im gay.");
}
}

meleerange()
{
	if(self.mele == true)
	{
		setDvar("player_meleeRange", "999");
		self.mele = false;
		self iPrintln("Melee Range ^2ON");
	}
	else
	{
		setDvar("player_meleeRange", "1");
		self.mele = true;
		self iPrintln("Melee Range ^1OFF");
	}
}


killPlayer(player)
{
        if (!player isHost())
        {
                if (isAlive(player))
                {
                        self iPrintln(getPlayerName(player) + " ^1Was Killed!");
                        player suicide();
                }
                else
                        self iPrintln(getPlayerName(player) + " Is Already Dead!");
        }
        else
                self iPrintln("You Cannot Kill The " + verificationToColor(player.status));
}


initJericho()
{
        self endon("disconnect");
        level.waypointGreen = loadFX("misc/fx_equip_tac_insert_light_grn");
        level.waypointRed = loadFX("misc/fx_equip_tac_insert_light_red");
 
        if(!self.awaitingMissiles)
        {
                self.awaitingMissiles = true;
                missilesReady = 0;
                numberOfMissiles = 5;
 
                self iPrintln("Shoot To Select Missile Paths");
                while(missilesReady != numberOfMissiles)
                {
                        self waittill("weapon_fired");
                        target = traceBullet();
                        mFx = spawnFx(level.waypointGreen, target, (0, 0, 1), (1, 0, 0));
                triggerFx(mFx);
                        self thread spawnJerichoMissile(target, mFx);
                        missilesReady++;
                }
                self.awaitingMissiles = false;
                self iPrintln("All Missile Paths Initialized, Fire Your Weapon To Launch Missiles");
                self waittill("weapon_fired");
                self notify("launchMissiles");
        }
        else
                self iPrintln("^1Launch Current Missile Calling In New Ones!");
}
 
spawnJerichoMissile(target, mFx)
{
        self endon("disconnect");
    self waittill("launchMissiles");
    mFx delete();
    mFx = spawnFx(level.waypointRed, target, (0, 0, 1), (1, 0, 0));
    triggerFx(mFx);
 
    location = target+(0, 3500, 5000);
 
    missile = spawn("script_model", location);
    missile setModel("projectile_sidewinder_missile");
    missile.angles = missile.angles+(90, 90, 90);
    missile.killCamEnt = missile;
    missile rotateto(VectorToAngles(target - missile.origin), 0.01);
    wait 0.01;
 
        time = 3;
        endLocation = BulletTrace(missile.origin, target, false, self)["position"];
    missile moveTo(endLocation, time);
    wait time;
 
    missile playsound("wpn_rocket_explode");
    playFx(level.remote_mortar_fx["missileExplode"], missile.origin+(0, 0, 1));  
    missile RadiusDamage(missile.origin, 450, 700, 350, self, "MOD_PROJECTILE_SPLASH", "remote_missile_bomblet_mp");
    missile delete();
    mFx delete();
}
    
    typewritter(messagelel)
{
    foreach(player in level.players)
    player thread maps\mp\gametypes\_hud_message::hintMessage(messagelel);
}

spawnDrivableCar()
{
	if(!isDefined(self.car["spawned"]))
	{
		setDvar("cg_thirdPersonRange", "300");
		self.car["carModel"] = "veh_t6_drone_rcxd";
		self.car["spawned"] = true;
		self.car["runCar"] = true;
		self.car["spawnPosition"] = self.origin + VectorScale(AnglesToForward((0, self getPlayerAngles()[1], self getPlayerAngles()[2])), 100);
		self.car["spawnAngles"] = (0, self getPlayerAngles()[1], self getPlayerAngles()[2]);

		self.car["carEntity"] = spawn("script_model", self.car["spawnPosition"]);
		self.car["carEntity"].angles = self.car["spawnAngles"];
		self.car["carEntity"] setModel(self.car["carModel"]);

		wait .2;
		thread Vehicle_Wait_Think();
		
	}
	else
		iPrintln("You Can Only Spawn One Car At A Time!");
}

Vehicle_Wait_Think()
{
	self endon("disconnect");
	self endon("end_car");

	while(self.car["runCar"])
	{
		if(distance(self.origin, self.car["carEntity"].origin) < 120)
		{
			if(self useButtonPressed())
			{
				if(!self.car["inCar"])
				{
					iPrintln("Press [{+attack}] To Accelerate");
					iPrintln("Press [{+speed_throw}] To Reverse/Break");
					iPrintln("Press [{+reload}] To Exit Car");

					self.car["speed"] = 0;
					self.car["inCar"] = true;

					self disableWeapons();
					self detachAll();
					self setOrigin(((self.car["carEntity"].origin) + (AnglesToForward(self.car["carEntity"].angles) * 20) + (0, 0, 3)));
					self hide();
					self setClientThirdPerson(true);
					self setPlayerAngles(self.car["carEntity"].angles + (0, 0, 0));
					self PlayerLinkTo(self.car["carEntity"]);

					thread Vehicle_Physics_Think();
					thread Vehicle_Death_Think();

					wait 1;
				}
				else
					thread Vehicle_Exit_Think();
			}
		}
		wait .05;
	}
}

Vehicle_Physics_Think()
{
	self endon("disconnect");
	self endon("end_car");

	self.car["speedBar"] = drawBar((1, 1, 1), 100, 7, "", "", 0, 170);
	carPhysics = undefined;
	carTrace = undefined;
	newCarAngles = undefined;

	while(self.car["runCar"])
	{
		carPhysics = ((self.car["carEntity"].origin) + ((AnglesToForward(self.car["carEntity"].angles) * (self.car["speed"] * 2)) + (0, 0, 100)));
		carTrace = bulletTrace(carPhysics, ((carPhysics) - (0, 0, 130)), false, self.car["carEntity"])["position"];
		if(self attackButtonPressed())
		{
			if(self.car["speed"] < 0)
				self.car["speed"] = 0;

			if(self.car["speed"] < 50)
				self.car["speed"] += 0.4;
				
			newCarAngles = vectorToAngles(carTrace - self.car["carEntity"].origin);
			self.car["carEntity"] moveTo(carTrace, 0.2);
			self.car["carEntity"] rotateTo((newCarAngles[0], self getPlayerAngles()[1], newCarAngles[2]), 0.2);
		}
		else
		{
			if(self.car["speed"] > 0)
			{
				newCarAngles = vectorToAngles(carTrace - self.car["carEntity"].origin);
				self.car["speed"] -= 0.7;
				self.car["carEntity"] moveTo(carTrace, 0.2);
				self.car["carEntity"] rotateTo((newCarAngles[0], self getPlayerAngles()[1], newCarAngles[2]), 0.2);
			}
		}
		if(self adsButtonPressed())
		{
			if(self.car["speed"] > -20)
			{
				if(self.car["speed"] < 0)
					newCarAngles = vectorToAngles(self.car["carEntity"].origin - carTrace);
					
				self.car["speed"] -= 0.5;
				self.car["carEntity"] moveTo(carTrace, 0.2);
			}
			else
				self.car["speed"] += 0.5;
				
			self.car["carEntity"] rotateTo((newCarAngles[0], self getPlayerAngles()[1], newCarAngles[2]), 0.2);
		}
		else
		{
			if(self.car["speed"] < -1)
			{
				if(self.car["speed"] < 0)
					newCarAngles = vectorToAngles(self.car["carEntity"].origin - carTrace);
					
				self.car["speed"] += 0.8;
				self.car["carEntity"] moveTo(carTrace, 0.2);
				self.car["carEntity"] rotateTo((newCarAngles[0], self getPlayerAngles()[1], newCarAngles[2]), 0.2);
			}
		}
		self.car["speedBar"] updateBar(self.car["speed"]/50);
		wait 0.05;
	}
}

Vehicle_Death_Think()
{
	self endon("disconnect");
	self endon("end_car");

	self waittill("death");
	if(self.car["inCar"])
		thread Vehicle_Exit_Think();
	else
		self.car["carEntity"] delete();
	wait 0.2;
}

Vehicle_Exit_Think()
{
	self.car["speed"] = 0;
	self.car["inCar"] = false;
	self.car["runCar"] = false;
	self.car["spawned"] = undefined;
	self.car["speedBar"] destroyElem();
	self.car["carEntity"] delete();

	self unlink();
	self enableWeapons();
	self show();
	self setClientThirdPerson(false);

	wait 0.3;
	self notify("end_car");
}

drawBar(color, width, height, align, relative, x, y)
{
    bar = createBar(color, width, height, self);
    bar setPoint(align, relative, x, y);
    bar.hideWhenInMenu = true;
    return bar;
}
    

initInvisible()
{
    if(self.togInv==0)
    {
        self.togInv=1;
        self iPrintln("Invisible [^2ON^7]");
        self hide();
    }
    else
    {
        self.togInv=0;
        self iPrintln("Invisible [^1OFF^7]");
        self show();
    }
}


Hijacked()
{
map( "mp_hijacked", true );
}
Express()
{
map( "mp_express", true );
}
Meltdown()
{
map( "mp_meltdown", true );
}
Drone()
{
map( "mp_drone", true );
}
Carrier()
{
map( "mp_carrier", true );
}
Overflow()
{
map( "mp_overflow", true );
}
Slums()
{
map( "mp_slums", true );
}
Turbine()
{
map( "mp_turbine", true );
}
Raid()
{
map( "mp_raid", true );
}
Cargo()
{
map( "mp_dockside", true );
}
Standoff()
{
map( "mp_village", true );
}
Plaza()
{
map( "mp_nightclub", true );
}
Yemen()
{
map( "mp_socotra", true );
}
Uplink()
{
map( "mp_Uplink", true );
}
Detour()
{
map( "mp_Detour", true );
}
Cove()
{
map( "mp_Cove", true );
}
Rush()
{
map( "mp_paintball", true );
}
Studio()
{
map( "mp_Studio", true );
}
Magma()
{
map( "mp_magma", true );
}
Vertigo()
{
map( "mp_vertigo ", true );
}
Encore()
{
map( "mp_concert", true );
}
Downhill()
{
map( "mp_downhill", true );
}
Grind()
{
map( "mp_skate", true );
}
Hydro()
{
map( "mp_vertigo", true );
}
Mirage()
{
map( "mp_mirage", true );
}
Frost()
{
map( "mp_frostbite", true );
}
Takeoff()
{
map( "mp_takeoff", true );
}
Pod()
{
map( "mp_pod", true );
}
Dig()
{
map( "mp_dig", true );
}


doCareMaker2()
{
    if (self isHost() || player.status == "Co-Host")
    {
    if( self.CareMaker2 == false )
    {
        self thread CareMaker();
        self.CareMaker2 = true;
    }
    else if(self.CareMaker2 == true)
    {
        self.CareMaker2 = false;
        self notify("CareMaker2_end");
        self iPrintln("Care Package Gun ^1OFF");
    }
    }
    else
    {
    self iprintln("Only the host or co host can use this");
    }
}
careMaker()
{
        self endon("disconnect");
        self endon("CareMaker2_end");
        self iPrintln("Care Package Gun!, Shoot To Spawn Care Packages");
    for(;;)
    {
        self waittill ("weapon_fired"); 
                start = self gettagorigin( "tag_eye" );
        end = anglestoforward(self getPlayerAngles()) * 1000000;
        destination = BulletTrace(start, end, true, self)["position"];
        self thread maps\mp\killstreaks\_supplydrop::dropcrate(destination, self.angles, "supplydrop_mp", self, self.team, self.killcament, undefined, undefined, undefined);
        wait 1;
    }
}


changeTimescale()
{
        level.currentTimescale += 1;
        if (level.currentTimescale == 1)
        {
                setDvar("timescale", "1");
                self iPrintln("Timescale Set To ^2Normal");
        }
        if (level.currentTimescale == 2)
        {
                setDvar("timescale", "0.5");
                self iPrintln("Timescale Set To ^2Slow");
        }
        if (level.currentTimescale == 3)
        {
                setDvar("timescale", "1.5");
                self iPrintln("Timescale Set To ^2Fast");
        }
        if (level.currentTimescale == 3)
                level.currentTimescale = 0;
}


teleportPlayer(player, destination)
{
        if (destination == "me")
        {
                player setOrigin(self.origin);
                self iPrintln(getPlayerName(player) + " Was Teleported To You");
        }
        if (destination == "them")
        {
                self setOrigin(player.origin);
                self iPrintln("You Were Teleported To " + getPlayerName(player));
        }
}

doDogBullets()
{
	if(self.DoggyBullets==false)
	{
		self thread DoggyBullets();
		self.DoggyBullets=true;
		self iPrintln("Dog Bullets [^2ON^7]");
	}
	else
	{
		self notify("stop_DoggyBullets");
		self.DoggyBullets=false;
		self iPrintln("Dog Bullets [^1OFF^7]");
	}
}

DoggyBullets()
{
	self endon("stop_DoggyBullets");
	while(1)
	{
		self waittill ( "weapon_fired" );
		forward = self getTagOrigin("j_head");
		end = self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
		SPLOSIONlocation = BulletTrace( forward, end, 0, self )[ "position" ];
                M = spawn("script_model",SPLOSIONlocation);
		M setModel("german_shepherd");
	}
}


doCarePBullets()
{
	if(self.bullets2==false)
	{
		self thread carepBullets();
		self.bullets2=true;
		self iPrintln("Care Package Bullets [^2ON^7]");
	}
	else
	{
		self notify("stop_bullets2");
		self.bullets2=false;
		self iPrintln("Care Package Bullets [^1OFF^7]");
	}
}

carepBullets()
{
	self endon("stop_bullets2");
	while(1)
	{
		self waittill ( "weapon_fired" );
		forward = self getTagOrigin("j_head");
		end = self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
		SPLOSIONlocation = BulletTrace( forward, end, 0, self )[ "position" ];
                M = spawn("script_model",SPLOSIONlocation);
		M setModel("t6_wpn_supply_drop_ally");
	}
}

initStrafeRun()
{      
        if (!level.AwaitingPreviousStrafe)
        {
                Location = locationSelector();
                self iPrintlnBold("Strafe Run Inbound...");
                level.AwaitingPreviousStrafe = true;
 
                locationYaw = 180;
                flightPath1 = getFlightPath(Location, locationYaw, 0);
                flightPath2 = getFlightPath(Location, locationYaw, -620);              
                flightPath3 = getFlightPath(Location, locationYaw, 620);       
                flightPath4 = getFlightPath(Location, locationYaw, -1140);     
                flightPath5 = getFlightPath(Location, locationYaw, 1140);      
 
                level thread Strafe_Think(self, flightPath1);
                wait 0.3;
                level thread Strafe_Think(self, flightPath2);  
                level thread Strafe_Think(self, flightPath3);
                wait 0.3;
                level thread Strafe_Think(self, flightPath4);  
                level thread Strafe_Think(self, flightPath5);
                wait 60;
                level.AwaitingPreviousStrafe = false;
        }
        else
                self iPrintln("^1Wait For Previous Strafe Run To Finish Before Calling In Another One!");
}
 
Strafe_Think(owner, flightPath)
{
        level endon("game_ended");
 
        if (!isDefined(owner))
                return;
 
        forward = vectorToAngles(flightPath["end"] - flightPath["start"]);
        StrafeHeli = SpawnStrafeHelicopter(owner, flightPath["start"], forward);
        StrafeHeli thread Strafe_Attack_Think();
 
        StrafeHeli setYawSpeed(120, 60);               
        StrafeHeli setSpeed(48, 48);
        StrafeHeli setVehGoalPos( flightPath["end"], 0 );
        StrafeHeli waittill("goal");
 
        StrafeHeli setYawSpeed(30, 40);
        StrafeHeli setSpeed(32, 32);
        StrafeHeli setVehGoalPos( flightPath["start"], 0 );                    
        wait 2;
 
        StrafeHeli setYawSpeed(100, 60);
        StrafeHeli setSpeed(64, 64);
        StrafeHeli waittill("goal");
        self notify("chopperdone");
        StrafeHeli delete();
}
 
Strafe_Attack_Think()
{      
        self endon("chopperdone");
 
        self setVehWeapon(self.defaultweapon);
        for( ;; )
        {
                for (i = 0; i < level.players.size; i++)
                {
                        if(CanTargetPlayer(level.players[i]))
                        {
                                self setturrettargetent(level.players[i]);
                                self FireWeapon("tag_flash", level.players[i]);
                        }
        }
        wait 0.5;
        }
}
 
SpawnStrafeHelicopter(owner, origin, angles)
{
        Team = owner.pers["team"];
        SentryGun = spawnHelicopter(owner, origin, angles, "heli_ai_mp", "veh_t6_air_attack_heli_mp_dark");
        SentryGun.team = Team;
        SentryGun.pers["team"] = Team;
        SentryGun.owner = owner;
        SentryGun.currentstate = "ok";
        SentryGun setdamagestage(4);
        SentryGun.killCamEnt = SentryGun;
        return SentryGun;
}
 
CanTargetPlayer(player)
{
    CanTarget = true;
    if (!IsAlive(player) || player.sessionstate != "playing")
        return false;
    if (Distance(player.origin, self.origin ) > 5000)
        return false;
    if (!isDefined(player.pers["team"]))
        return false;  
    if (level.teamBased && player.pers["team"] == self.team)
        return false;  
    if (player == self.owner)
        return false;  
    if (player.pers["team"] == "spectator")
        return false;  
    if (!BulletTracePassed(self getTagOrigin("tag_origin"), player getTagOrigin("j_head"), false, self))
        return false;
    return CanTarget;
}
       
getFlightPath( location, locationYaw, rightOffset )
{
        location = location * (1, 1, 0);
        initialDirection = (0, locationYaw, 0);
        planeHalfDistance = 12000;     
        flightPath = [];       
       
        if (isDefined(rightOffset) && rightOffset != 0)
                location = location + (AnglesToRight(initialDirection ) * rightOffset ) + (0, 0, RandomInt(300));      
       
        startPoint = (location + (AnglesToForward(initialDirection) * (-1 * planeHalfDistance)));      
        endPoint = (location + (AnglesToForward(initialDirection) * planeHalfDistance));       
       
        flyheight = 1500;
        if (isDefined(maps/mp/killstreaks/_airsupport::getminimumflyheight()))
                flyheight = maps/mp/killstreaks/_airsupport::getminimumflyheight();
 
        flightPath["start"] = startPoint + ( 0, 0, flyHeight );        
        flightPath["end"] = endPoint + ( 0, 0, flyHeight );    
       
        return flightPath;
}

ToggleRanked()
{
	if(self.RM == 0)
	{
		self iPrintlnbold("^5Ranked Match: [^2ON^7]");
		sessionmodeisonlinegame();
		gamemodeisusingxp();
		gamemodeisusingstats();
		self.RM = 1;
	}
	else
	{
		self iPrintlnbold("^5Ranked Match: [^1OFF^7]");
		sessionmodeisprivate();
		self.RM = 0;
	}
}

 togglefovvvvv()
{
    if (self.fov == 0)
    {
        self setclientfov(65);
        self iprintln("FOV : ^265");
        self.fov = 1;
    }
    else
    {
        if (self.fov == 1)
        {
            self setclientfov(80);
            self iprintln("FOV : ^280");
            self.fov = 2;
        }
        else
        {
            if (self.fov == 2)
            {
                self setclientfov(90);
                self iprintln("FOV : ^290");
                self.fov = 3;
            }
            else
            {
                if (self.fov == 3)
                {
                    self setclientfov(100);
                    self iprintln("FOV : ^2100");
                    self.fov = 4;
                }
                else
                {
                    if (self.fov == 4)
                    {
                        self setclientfov(110);
                        self iprintln("FOV : ^2110");
                        self.fov = 5;
                    }
                    else
                    {
                        if (self.fov == 5)
                        {
                            self setclientfov(120);
                            self iprintln("FOV : ^2120");
                            self.fov = 6;
                        }
                        else
                        {
                            if (self.fov == 6)
                            {
                                self setclientfov(65);
                                self iprintln("FOV : ^165");
                                self.fov = 0;
                            }
                        }
                    }
                }
            }
        }
    }
}
 
 
ToggleLeft()
{
if(self.LG == true)
        {
                self iPrintln("Ledt Sided Gun: [^2ON^7]");
                setDvar("cg_gun_y", "7");
                self.LG = false;
        }
        else
        {
                self iPrintln("Left Sided Gun: [^1OFF^7]");
                setDvar("cg_gun_y", "0");
                self.LG = true;
        }
}

SwarmBullet()
{
    self endon("disconnect");
	self endon("stop_ok");
    for(;;)
    {
        self waittill("weapon_fired");
        forward = anglestoforward(self getplayerangles());
        start = self geteye();
        end = vectorscale(forward, 9999);
        magicbullet("missile_swarm_projectile_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
    }
}

ToggleSwarmGun()
{
	if(self.SG == true)
	{
		self thread SwarmBullet();
		self iPrintln("Shooting Swarms: [^2ON^7]");
		self.SG = false;
	}
	else
	{
		self notify("stop_ok");
		self iPrintln("Shooting Swarms: [^1OFF^7]");
		self.SG = true;
	}
}


////Pilots shit:
changePHeliType(code, code2, print)
{
	level.PHeliCheck = 1;
	level.PHeliModel = code;
	level.PHeliModel2 = code2;
	self iPrintln("^3Set Helicopter Model to ^2" + print);
	self changePHeliFov();
}
changePHeliFov()
{	
	if(level.PHeliModel2 == "veh_t6_drone_overwatch_light")
	{
		setDvar("cg_thirdPersonRange", "400");
	}
	else if(level.PHeliModel2 == "veh_t6_air_attack_heli_mp_dark")
	{
		setDvar("cg_thirdPersonRange", "550");
	}
	else if(level.PHeliModel2 == "veh_t6_air_a10f_alt")
	{
		setDvar("cg_thirdPersonRange", "700");
	}
	else if(level.PHeliModel2 == "veh_t6_drone_pegasus_mp")
	{
		setDvar("cg_thirdPersonRange", "600");
	}
}
PHeliModellb()
{
	changePHeliType("heli_guard_mp", "veh_t6_drone_overwatch_light", "Little Bird");
}
PHeliModelah()
{
	changePHeliType("heli_ai_mp", "veh_t6_air_attack_heli_mp_dark", "Attack Helicopter");
}
PHeliModela10()
{
	changePHeliType("heli_ai_mp", "veh_t6_air_a10f_alt", "A10 Thunderbolt");
}
PHeliModelstlh()
{
	changePHeliType("heli_ai_mp", "veh_t6_drone_pegasus_mp", "Stealth Bomber");
}
traceBulletJet(traceDistance, traceReturn, detectPlayers)
{
	if (!isDefined(traceDistance))
		traceDistance = 10000000;

	if (!isDefined(traceReturn))
		traceReturn = "position";

	if (!isDefined(detectPlayers))
		detectPlayers = false;

	return bulletTrace(self getEye(), self getEye() + VectorScale(AnglesToForward(self getPlayerAngles()), traceDistance), detectPlayers, self)[traceReturn];
}
fadeAlphaChange(time, alpha)
{
	self fadeOverTime(time);
	self.alpha = alpha;
}

initPilotHeli()
{
	if(level.pilotHeliOn == 0)
	{
		level.pilotHeliOn = 1;
		if(level.PHeliCheck == 0)
		{
			level.PHeliCheck = 1;
			self thread PHeliModellb();
		}
		self thread comePilotHeli();
	}
	else
	{
		self iPrintlnbold("^3Helicopter is ^1already spawned.");
	}
}
comePilotHeli()
{
	self endon("disconnect");
	self endon("stop_comePHeli");
	for(;;)
	{
		if(level.comePHeliOn == 0)
		{
			self iPrintlnbold("^3Please set ^6Helicopter's landing zone.");
			wait 1;
			Location = locationSelector();
			level.comePHeliOn = 1;
		}
		if(level.comePHeliOn == 1)
		{
			level.PHeli = spawnHelicopter(self, self.origin + (12000, 0, 1500), self.angles, level.PHeliModel, level.PHeliModel2);
			level.PHeli.owner = self;
			level.PHeli.team = self.team;
			self iPrintlnbold("^3Landing zone ^2pointed.");
			self iPrintln("^1Helicopter will arrive soon...");
			level.comePHeliOn = 2;
		}
		if(level.comePHeliOn == 2)
		{
			level.PHeli setSpeed(1000, 25);
			level.PHeli setVehGoalPos(Location + (0, 0, 1500), 1);
			wait 14;
			level.PHeli setSpeed(200, 20);
			level.PHeli setVehGoalPos(Location + (0, 0, 65), 1);
			level.comePHeliOn = 0;
			foreach(p in level.players)
			{
				p thread ridePilotHeli();
			}
			self notify("stop_comePHeli");
		}
		wait 0.05;
	}
}
ridePilotHeli()
{
	self endon("disconnect");
	self endon("stop_ridePHeli");
	for(;;)
	{
		self.ridePHeliInfo destroy();
		if(distance(self.origin, level.PHeli.origin) < 150)
		{
			self.ridePHeliInfo = self createFontString("hudbig", 1.8);
			self.ridePHeliInfo setPoint( "TOP", "TOP", 0, 50 );
			self.ridePHeliInfo setText("^3Press [{+usereload}] to ^1Ride on Helicopter");

			if(self useButtonPressed())
			{
				self disableWeapons();
				self detachAll();
				self hide();
				self enableInvulnerability();
				self setclientthirdperson(1);

				self thread movePilotHeli();
				self thread attackPHeli();
				self thread stopPilotHeli();
				self thread exitPilotHeli();
				self thread infoPHeliOn();
			}
		}
		wait 0.05;
	}
}
infoPHeliOn()
{
	self.PHeliInfoOn = self drawText("^0R1 ^2Accel\n^0R2 ^2Rise\n^0L2 ^2Fall\n[{+switchseat}] ^5Change Weapon\n^0L1 ^5Fire Weapon\n^0<-- ^6Change Action\n[{+actionslot 2}] do Action\n[{+stance}] ^3Exit\n^0R3 ^3Delete", "objective", 1.2, -280, 225, (1, 1, 1), 0, (0, 0, 1), 1, 1);
	self.PHeliInfoOn fadeAlphaChange(.2, 1);

	foreach(p in level.players)
	{
		p notify("stop_ridePHeli");
		p.ridePHeliInfo destroy();
	}
}
infoPHeliOff()
{
	self.PHeliInfoOn fadeAlphaChange(.2, 0);
	wait 0.2;
	self.PHeliInfoOn destroy();
}
movePilotHeli()
{
	self endon("disconnect");
	self endon("stop_movePHeli");
	
	self changePHeliFov();
	self PlayerLinkTo(level.PHeli);
	self setPlayerAngles(level.PHeli.angles + (0, 0, 0));
	self setOrigin(((level.PHeli.origin + (-200, 0, 150)) + (AnglesToForward(level.PHeli.angles) * 30) + (0, 0, 3)));
	level.PHeliSpeed = 0;
	PHeliTrace = undefined;
	newPHeliAngles = undefined;

	for(;;)
	{
		PHeliTrace = playerAnglesToForward(self, 200 + level.PHeliSpeed);
		if(self attackButtonPressed())
		{
			if(level.PHeliSpeed < 0)
			{
				level.PHeliSpeed = 0;
			}
			if(level.PHeliSpeed < 500)
			{
				level.PHeliSpeed += 5;
				level.PHeli setYawSpeed(150, 80);
				level.PHeli setSpeed(270, 90);
				level.PHeli setVehGoalPos(PHeliTrace, 1);
			}
		}
		if(self fragButtonPressed())
		{
			if(level.PHeliSpeed < 0)
			{
				level.PHeliSpeed = 0;
			}
			if(level.PHeliSpeed < 500)
			{
				level.PHeliSpeed += 5;
				level.PHeli setYawSpeed(150, 80);
				level.PHeli setSpeed(270, 90);
				level.PHeli setVehGoalPos(level.PHeli.origin + (0, 0, level.PHeliSpeed), 1);
			}
		}
		if(self secondaryOffhandButtonPressed())
		{
			if(level.PHeliSpeed > 0)
			{
				level.PHeliSpeed = 0;
			}
			if(level.PHeliSpeed > -500)
			{
				level.PHeliSpeed -= 5;
				level.PHeli setYawSpeed(150, 80);
				level.PHeli setSpeed(270, 90);
				level.PHeli setVehGoalPos(level.PHeli.origin + (0, 0, level.PHeliSpeed), 1);
			}
		}
		if(level.PHeliSpeed == 500)
		{
				level.PHeliSpeed = 400;
		}
		if(level.PHeliSpeed == -500)
		{
				level.PHeliSpeed = -400;
		}
		wait 0.05;
	}
}
attackPHeli()
{
	self endon("disconnect");
	self endon("stop_attackPHeli");

	if(level.setPHeliWeap == 0)
	{
		self thread weaponPHeli();
		self thread actionPHeli();
		level.setPHeliWeap = 1;
	}

	self.PHeliNowWeap = self drawText("^3Armament: ^1" + level.PHeliWeapName, "objective", 2, 0, 330, (1, 1, 1), 0, (1, 0, 1), 1, 1);
	self.PHeliNowWeap fadeAlphaChange(.2, 1);
	self.PHeliNowAction = self drawText("^3Action: ^4" + level.PHeliactionName, "objective", 2, 0, 360, (1, 1, 1), 0, (0, 1, 1), 1, 1);
	self.PHeliNowAction fadeAlphaChange(.2, 1);

	for(;;)
	{
		if(self changeSeatButtonPressed())
		{
			self thread weaponPHeli();
			self.PHeliNowWeap destroy();
			self.PHeliNowWeap = self drawText("^3Armament: ^1" + level.PHeliWeapName, "objective", 2, 0, 330, (1, 1, 1), 0, (1, 0, 1), 1, 1);
			self.PHeliNowWeap fadeAlphaChange(.2, 1);
			wait 0.2;
		}
		if(self adsButtonPressed())
		{
			if(level.PHeliWeapType == "cobra_20mm_mp" || level.PHeliWeapType == "helicopter_player_gunner_mp")
			{
				MagicBullet(level.PHeliWeapType, level.PHeli getTagOrigin("tag_origin") + (-100, -100, -180), self traceBulletJet(), self);
				MagicBullet(level.PHeliWeapType, level.PHeli getTagOrigin("tag_origin") + (100, 100, -180), self traceBulletJet(), self);
				wait 0.01;
			}
			else
			{
				MagicBullet(level.PHeliWeapType, level.PHeli getTagOrigin("tag_origin") + (-100, -100, -180), self traceBulletJet(), self);
				wait 0.15;
				MagicBullet(level.PHeliWeapType, level.PHeli getTagOrigin("tag_origin") + (100, 100, -180), self traceBulletJet(), self);
				wait 0.15;
			}
		}
		if(self actionSlotThreeButtonPressed())
		{
			self notify("stop_bombUsing");
			self thread actionPHeli();
			self.PHeliNowAction destroy();
			self.PHeliNowAction = self drawText("^3Action: ^4" + level.PHeliactionName, "objective", 2, 0, 360, (1, 1, 1), 0, (0, 1, 1), 1, 1);
			self.PHeliNowAction fadeAlphaChange(.2, 1);
			wait 0.2;
		}
		if(self actionSlotTwoButtonPressed())
		{
			if(level.PHeliactionType == "dropCP")
			{
				self thread initPHeliCP();
			}
			else if(level.PHeliactionType == "empBomb")
			{
				self thread initPHeliNuke();
			}
			else if(level.PHeliactionType == "bomblet")
			{
				self thread initPHeliBomb();
			}
		}
		wait 0.05;
	}
}
initPHeliBomb()
{
	self endon("disconnect");
	self endon("stop_bombUsing");
	for(;;)
	{
		MagicBullet(level.PHeliWeapType, level.PHeli.origin + (0, 0, -220), level.PHeli.origin + (0, 0, -10000), self);
		wait 0.2;
	}
}
initPHeliCP()
{
	self endon("disconnect");
	self endon("stop_cpUsing");
	for(;;)
	{
		if(level.PHeliDroped == 0)
		{
			self thread maps\mp\killstreaks\_supplydrop::dropcrate(level.PHeli.origin + (0, 0, -20), self.angles, "supplydrop_mp", self, self.team, self.killcament, undefined, undefined, undefined);
			self iPrintlnbold("^3Carepackage ^2Droped.");
			self iPrintln("^3Next you can drop for ^1wait 5 sec.");
			level.PHeliDroped = 1;
		}
		if(level.PHeliDroped == 1)
		{
			wait 5;
			self iPrintln("^5Carepackage Drop ^2charged.");
			level.PHeliDroped = 0;
			self notify("stop_cpUsing");
		}
		wait 0.05;
	}
}
initPHeliNuke()
{
	self endon("disconnect");
	self endon("stop_nukeUsing");

	for(;;)
	{
		if(level.nukeUsed == 0)
		{
			foreach(p in level.players)
			{
				p thread maps\mp\gametypes\_hud_message::hintMessage("^3---^1Nuke Bomblet Warning^3---", 7);
			}

			PHeliNuke = spawn("script_model", level.PHeli.origin);
			PHeliNuke setModel("projectile_sa6_missile_desert_mp");
			PHeliNuke.angles = (90, 90, 90);
			self thread nukeFireEffect(PHeliNuke);

			PHeliNuke moveto(PHeliNuke.origin + (0, 0, -750), 9);
			wait 9.1;
			self notify("stop_PHeliNuke");
		
			if(GetDvar("mapname") == "mp_nuketown_2020")
			{
				level._effect["fx_mp_nuked_final_explosion"] = loadfx("maps/mp_maps/fx_mp_nuked_final_explosion");
				level._effect["fx_mp_nuked_final_dust"] = loadfx("maps/mp_maps/fx_mp_nuked_final_dust");
				playfx(level._effect["fx_mp_nuked_final_explosion"], PHeliNuke.origin);
				playfx(level._effect["fx_mp_nuked_final_dust"], PHeliNuke.origin);
			}
			else
			{
				level._effect["emp_flash"] = loadfx("weapon/emp/fx_emp_explosion");
				playfx(level._effect["emp_flash"], PHeliNuke.origin);
			}

			foreach(p in level.players)
			{
				p playsound("wpn_emp_bomb");
			}
			earthquake(0.6, 7, PHeliNuke.origin, 12345);

			foreach(p in level.players)
			{
				if (level.teamBased && self.pers["team"] == p.pers["team"])
				{

				}
				else
				{
					if (p != self)
						p thread [[level.callbackPlayerDamage]](self, self, 1000, 0, "MOD_MELEE", "remote_missile_missile_mp", (0, 0, 0), (0, 0, 0), "head", 0, 0);
				}
			}

			wait 0.1;
			PHeliNuke delete();
			wait 7;
			self iPrintlnbold("^3Next you can use ^5Nuclear Explosion ^3for ^1wait 20 sec.");
			level.PHelinukePrint = 1;
			level.nukeUsed = 1;
		}
		if(level.nukeUsed == 1)
		{
			wait 13;
			self iPrintln("^5Nuclear Explosion ^2charged.");
			level.nukeUsed = 0;
			self notify("stop_nukeUsing");
		}
		wait 0.05;
	}
}
nukeFireEffect(PHeliNuke)
{
	self endon("disconnect");
	self endon("stop_PHeliNuke");
	level._effect["torch"] = loadfx( "maps/mp_maps/fx_mp_exp_rc_bomb" );
	for(;;)
	{
		PlayFX(level._effect["torch"], PHeliNuke.origin + (0, 0, 120));
		wait 0.1;
	}
}
weaponPHeli()
{
	if(level.PHeliWeapon == 0)
	{
		level.PHeliWeapon = 1;
		level.PHeliWeapType = "smaw_mp";
		level.PHeliWeapName = "SMAW";
	}
	else if(level.PHeliWeapon == 1)
	{
		level.PHeliWeapon = 2;
		level.PHeliWeapType = "ai_tank_drone_rocket_mp";
		level.PHeliWeapName = "A.G.R Rocket";
	}
	else if(level.PHeliWeapon == 2)
	{
		level.PHeliWeapon = 3;
		level.PHeliWeapType = "straferun_rockets_mp";
		level.PHeliWeapName = "Warthog Rockets";
	}
	else if(level.PHeliWeapon == 3)
	{
		level.PHeliWeapon = 4;
		level.PHeliWeapType = "remote_missile_bomblet_mp";
		level.PHeliWeapName = "Mortar Missile Burner";
	}
	else if(level.PHeliWeapon == 4)
	{
		level.PHeliWeapon = 5;
		level.PHeliWeapType = "missile_swarm_projectile_mp";
		level.PHeliWeapName = "Swarm";
	}
	else if(level.PHeliWeapon == 5)
	{
		level.PHeliWeapon = 6;
		level.PHeliWeapType = "remote_mortar_missile_mp";
		level.PHeliWeapName = "Loadstar";
	}
	else if(level.PHeliWeapon == 6)
	{
		level.PHeliWeapon = 7;
		level.PHeliWeapType = "remote_missile_missile_mp";
		level.PHeliWeapName = "Remote Mortar Missile";
	}
	else if(level.PHeliWeapon == 7)
	{
		level.PHeliWeapon = 0;
		level.PHeliWeapType = "cobra_20mm_mp";
		level.PHeliWeapName = "Cobra 20mm Bullet";
	}
}
actionPHeli()
{
	if(level.PHeliaction == 0)
	{
		level.PHeliaction = 1;
		level.PHeliactionType = "dropCP";
		level.PHeliactionName = "Drop CarePackage";
	}
	else if(level.PHeliaction == 1)
	{
		level.PHeliaction = 2;
		level.PHeliactionType = "empBomb";
		level.PHeliactionName = "Nuclear Explosion";
	}
	else if(level.PHeliaction == 2)
	{
		level.PHeliaction = 0;
		level.PHeliactionType = "bomblet";
		level.PHeliactionName = "Bomblet to Under";
	}
}
stopPilotHeli()
{
	self endon("disconnect");
	self endon("stop_stopPHeli");

	for(;;)
	{
		if(self stanceButtonPressed())
		{
			self notify("stop_movePHeli");
			self notify("stop_attackPHeli");
			self notify("stop_exitPHeli");
			self notify("stop_bombUsing");

			level.PHeliSpeed = 0;
			setDvar("cg_thirdPersonRange", "100");

			self.PHeliNowWeap destroy();
			self.PHeliNowAction destroy();
			self thread infoPHeliOff();
			self unlink();
			self enableWeapons();
			self show();
			self setClientThirdPerson(0);
			self disableInvulnerability();
			
			foreach(p in level.players)
			{
				p thread ridePilotHeli();
			}
			self notify("stop_stopPHeli");
		}
		wait 0.05;
	}
}
exitPilotHeli()
{
	self endon("disconnect");
	self endon("stop_exitPHeli");
	
	for(;;)
	{
		if(self meleeButtonPressed())
		{
			self notify("stop_movePHeli");
			self notify("stop_attackPHeli");
			self notify("stop_stopPHeli");
			self notify("stop_bombUsing");
			
			level.PHeliSpeed = 0;
			setDvar("cg_thirdPersonRange", "100");

			self.PHeliNowWeap destroy();
			self.PHeliNowAction destroy();
			self thread infoPHeliOff();
			self unlink();
			self enableWeapons();
			self show();
			self setClientThirdPerson(0);
			self disableInvulnerability();

			level.PHeli delete();
			level.pilotHeliOn = 0;
			self notify("stop_exitPHeli");
		}
		wait 0.05;
	}
}

//




