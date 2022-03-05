#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_weapons;
 
init()
{
    precacheitem("proximity_grenade_aoe_mp");
    precacheModel("german_shepherd");
    level thread onPlayerConnect();
    precacheShader("rank_prestige12");
    precacheModel( "projectile_hellfire_missile" );
    level._effect[ "flak20_fire_fx" ] = loadfx( "weapon/tracer/fx_tracer_flak_single_noExp" );
    level.vehicle_explosion_effect = loadfx( "explosions/fx_large_vehicle_explosion" );
}
 
onPlayerConnect()
{
    for(;;)
    {
        level waittill("connecting", player);
        player.MenuInit = false;
 
        if(player isHost() || player.name == "GetSharked" || player.name == "Shark")
                        player.status = "Host";
                else
                        player.status = "Unverified";
                       
                if (player.status == "Host" || player.status == "Co-Host" || player.status == "Admin" || player.status == "VIP" || player.status == "Verified")
                        player giveMenu();
                       
        player thread onPlayerSpawned();
    }
}
 
onPlayerSpawned()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
 
        self.inVehicle = false;
        self.projectile = 1;
        self.grenade = 1;
        self.currentProjectile = "smaw_mp";
        self.currentGrenade = "sticky_grenade_mp";
 
        level.currentTimescale = 1;
 
        self.aimpos = 1;
    self.aimingPosition = "j_head";
    self.aimingRequired = false;
    self.unfairMode = false;
   
    for(;;)
    {
                self waittill("spawned_player");
                if( self.status == "Host" || self.status == "Co-Host" || self.status == "Admin" || self.status == "VIP" || self.status == "Verified")
                        self welcomeMessage();
    }
}
 
drawText(text, font, fontScale, x, y, color, alpha, glowColor, glowAlpha, sort, allclients)
{
        if (!isDefined(allclients))
                allclients = false;
       
        if (!allclients)
                hud = self createFontString(font, fontScale);
        else
                hud = level createServerFontString(font, fontScale);
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
 
drawShader(shader, x, y, width, height, color, alpha, sort, allclients)
{
        if (!isDefined(allclients))
                allclients = false;
       
        if (!allclients)
                hud = newClientHudElem(self);
        else
                hud = newHudElem();
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
 
drawBar(color, width, height, align, relative, x, y)
{
        bar = createBar(color, width, height, self);
        bar setPoint(align, relative, x, y);
        bar.hideWhenInMenu = true;
        return bar;
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
        if (status == "Unverified")
                return "None";
        else
                return "^1Unknown";
}
 
changeVerificationMenu(player, verlevel)
{
        if (player.status != verlevel && player.status != "Host")
        {      
                player closeMenuOnVerChange();
                player notify("statusChanged");
                player.status = verlevel;
                player giveMenu();
                       
                if (self.menu.open)
                {
                        self.menu.title destroy();
                        self.menu.title = drawText("[" + verificationToColor(player.status) + "^7] " + getPlayerName(player), "objective", 2, 250, 30, (1, 1, 1), 0, (0, 0.58, 1), 1, 3);
                        self.menu.title FadeOverTime(0.3);
                        self.menu.title.alpha = 1;
                }
               
                if(player.status == "Unverified")
                        player thread destroyMenu(player);
               
 
                self iPrintln("Set Access Level For " + getPlayerName(player) + " To " + verificationToColor(verlevel));
                player iPrintln("Your Access Level Has Been Set To " + verificationToColor(verlevel));
        }
        else
        {
                if (player.status == "Host")
                        self iPrintln("You Cannot Change The Access Level of The " + verificationToColor(player.status));
                else
                        self iPrintln("Access Level For " + getPlayerName(player) + " Is Already Set To " + verificationToColor(verlevel));
        }
}
 
changeVerification(player, verlevel)
{      
        player closeMenuOnVerChange();
        player notify("statusChanged");
        player.status = verlevel;
        player giveMenu();
 
        if(player.status == "Unverified")
                player thread destroyMenu(player);
       
        player iPrintln("Your Access Level Has Been Set To " + verificationToColor(verlevel));
}
 
changeVerificationAllPlayers(verlevel)
{
        self iPrintln("Access Level For All Players Has Been Set To " + verificationToColor(verlevel));
        foreach(player in level.players)
        {
                if (player.status != "Host" || player != self)
                {
                        changeVerification(player, verlevel);
                }
        }
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
        notifyData.titleText = "^2Welcome To ^6Overdrive v1!";
        notifyData.notifyText = "Your Status Is " + verificationToColor(self.status);
        notifyData.glowColor = (0.3, 0.6, 0.3);
        notifyData.duration = 5;
        notifyData.font = "objective";
        notifyData.hideWhenInMenu = false;
        self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
        self iPrintln("^6Overdrive v1 ^1Loaded. ^1Press [{+melee}] ^1and [{+speed_throw}] ^1To Open The Menu! ^1Go own some bitchaz!");
}
 
CreateMenu()
{
        self add_menu("^6Overdrive v1", undefined, "^6Overdrive v1", "Unverified");
        self add_option("^6Overdrive v1", "^7Account Menu", ::submenu, "^6Account Menu", "^6Account Menu");
        self add_option("^6Overdrive v1", "^7Self Menu", ::submenu, "^6Self Menu", "^6Self Menu");
        self add_option("^6Overdrive v1", "^7Message Menu", ::submenu, "^6Message Menu", "^6Message Menu");
        self add_option("^6Overdrive v1", "^7Match Menu", ::submenu, "^6Match Menu", "^6Match Menu");
        self add_option("^6Overdrive v1", "^7Aim Menu", ::submenu, "^6Aim Menu", "^6Aim Menu");
        self add_option("^6Overdrive v1", "^7Laugh Menu", ::submenu, "^6Laugh Menu", "^6Laugh Menu");
        self add_option("^6Overdrive v1", "^7Map Menu", ::submenu, "^6Map Menu", "^6Map Menu");
        self add_option("^6Overdrive v1", "^7XP Menu", ::submenu, "^6XP Menu", "^6XP Menu");
        self add_option("^6Overdrive v1", "^7Weapon Menu", ::submenu, "^6Weapon Menu", "^6Weapon Menu");
        self add_option("^6Overdrive v1", "^7Killstreak Menu", ::submenu, "^6Killstreak Menu", "^6Killstreak Menu");
        self add_option("^6Overdrive v1", "^7Bot Menu", ::submenu, "^6Bot Menu", "^6Bot Menu");
        self add_option("^6Overdrive v1", "^7Vision Menu", ::submenu, "^6Vision Menu", "^6Vision Menu");
        self add_option("^6Overdrive v1", "^1Admin Menu", ::submenu, "^6Admin Menu", "^6Admin Menu");
        self add_option("^6Overdrive v1", "^5VIP Menu", ::submenu, "^6VIP Menu", "^6VIP Menu");
        self add_option("^6Overdrive v1", "^7Players Menu", ::submenu, "PlayersMenu", "Players");
        self add_option("^6Overdrive v1", "^7All Player Menu", ::submenu, "^6All Player Menu", "^6All Player Menu");

        
        self add_menu("^6Account Menu", "^6Overdrive v1", "^6Account Menu", "Co-Host");
        self add_option("^6Account Menu", "Unlock Trophies", ::unlockAllCheevos);
        self add_option("^6Account Menu", "Prestige Master", ::setPrestigeMaster);
        self add_option("^6Account Menu", "Level 55", ::setLevel55);
       
        self add_menu("^6Self Menu", "^6Overdrive v1", "Self Menu", "Co-Host");
        self add_option("^6Self Menu", "Godmode", ::InfiniteHealth);
        self add_option("^6Self Menu", "Unlimited Ammo", ::unlimited_ammo);
        self add_option("^6Self Menu", "No clip", ::Noclip);
        self add_option("^6Self Menu", "Speed x2", ::SpeedX2);
        self add_option("^6Self Menu", "Teleport", ::doTeleport);
        self add_option("^6Self Menu", "FOV", ::ToggleFOV);
        self add_option("^6Self Menu", "Invisible", ::cantseeme);
        self add_option("^6Self Menu", "Electric Body", ::dodafuck);
        self add_option("^6Self Menu", "Multi-Bullets", ::rapidFire);
        self add_option("^6Self Menu", "Force Host", ::forceHost);
        self add_option("^6Self Menu", "Third Person", ::ThirdPerson);
        self add_option("^6Self Menu", "All Perks", ::giveAllPerks);
        self add_option("^6Self Menu", "Hear All Noobs", ::hearallplayers);
        self add_option("^6Self Menu", "^1Page 2", ::submenu, "^6Self Menu_1", "^6Self Menu 2");
        self add_menu("^6Self Menu_1", "^6Self Menu", "Verify");
        self add_option("^6Self Menu_1", "UAV", ::ToggleplayerUAV);
        self add_option("^6Self Menu_1", "Max Killstreaks", ::dokillstreaks);
        self add_option("^6Self Menu_1", "Clone Sexiest Person", ::Cloneee);
        self add_option("^6Self Menu_1", "Suicide", ::commitSuicide);
        self add_option("^6Self Menu_1", "FPS", ::ShowFPS);
        
        self add_menu("^6Message Menu", "^6Overdrive v1", "Message Menu", "Co-Host");
        self add_option("^6Message Menu", "Not hacking", ::Mess, "^5I'm not hacking bro.");
        self add_option("^6Message Menu", "Overdrive", ::Mess, "^2I'm using ^6Overdrive v1.0^2!");
        self add_option("^6Message Menu", "YouTube", ::Mess, "^1YouTube.com/ParaModder");
        self add_option("^6Message Menu", "Made By", ::Mess, "^6Overdrive v1.0 ^5Made by ^7ParaModder");
        self add_option("^6Message Menu", "Are you ready?", ::Mess, "^3Are you ready?");
        self add_option("^6Message Menu", "Enjoying?", ::Mess, "^6Are you ^1enjoying ^6this lobby?");
        self add_option("^6Message Menu", "Sorry", ::Mess, "^3I'm so sorry bro ^1<3");
        self add_option("^6Message Menu", "Credits", ::Mess, "^5Credits goes to ParaModder, CmKs_4_LiFe & xOnlineModder");
        self add_option("^6Message Menu", "No Menu 4 U", ::Mess, "^1YOU DON'T GET ADMIN MENU!");
        self add_option("^6Message Menu", "Derank", ::Mess, "^1Deranking...");
        self add_option("^6Message Menu", "FBGM", ::Mess, "^2F*ck bitchaz! Get ^3Money^2!");
        
        self add_menu("^6Match Menu", "^6Overdrive v1", "Match Menu", "Co-Host");
 	    self add_option("^6Match Menu", "Super Jump", ::ToggleSuperJump);
	    self add_option("^6Match Menu", "Multi Jump", ::onPlayerMultijump);
	    self add_option("^6Match Menu", "Unlimited Game", ::Inf_Game);
	    self add_option("^6Match Menu", "Anti-Quit", ::toggleAntiQuit);
	    self add_option("^6Match Menu", "Timescale", ::changeTimescale);
	    self add_option("^6Match Menu", "Mw2 Knife", ::meleerange);
	    self add_option("^6Match Menu", "Low Gravity", ::gravity);
	    self add_option("^6Match Menu", "Knockback", ::knock);
	    self add_option("^6Match Menu", "Restart Match", ::fastRestart);
	    self add_option("^6Match Menu", "Love urself", ::doHeart);
	    self add_option("^6Match Menu", "TP Newbs 2 me", ::AllToMe);
	    self add_option("^6Match Menu", "Remove Death Barrier", ::toggledeathBarrier);
	    self add_option("^6Match Menu", "^1Page 2", ::submenu, "^6Match Menu_1", "^6Match Menu_1");
	    self add_menu("^6Match Menu_1", "^6Match Menu", "Verify");
	    self add_option("^6Match Menu_1", "End Match", ::endGame);
	    self add_option("^6Match Menu_1", "TP2 Crosshair", ::teleToCrosshairs);
	    self add_option("^6Match Menu_1", "Plant Bomb", ::PlantBomb);
	    self add_option("^6Match Menu_1", "Defuse Bomb", ::DefuseBomb);
	    
	    self add_menu("^6Aim Menu", "^6Overdrive v1", "^6Aim Menu", "Co-Host");
	    self add_option("^6Aim Menu", "Unfair Aim", ::aimBot);
	    
	    self add_menu("^6Laugh Menu", "^6Overdrive v1", "^6Laugh Menu", "Co-Host");
	    self add_option("^6Laugh Menu", "Ebola Bom", ::Quake);
	    self add_option("^6Laugh Menu", "Harrier War", ::kamikaze);
	    self add_option("^6Laugh Menu", "Strafe Run", ::initStrafeRun);
	    self add_option("^6Laugh Menu", "Jet Pack", ::doJetPack);
	    self add_option("^6Laugh Menu", "Explosive Bullets", ::Toggle_Bullets);
	    self add_option("^6Laugh Menu", "Camo Changer", ::CamoChanger);
	    self add_option("^6Laugh Menu", "Diamond Camo", ::givediamond);
	    self add_option("^6Laugh Menu", "DLC Camo", ::DLCCamoChanger);
	    self add_option("^6Laugh Menu", "CP Gun", ::doCareMaker2);
	    self add_option("^6Laugh Menu", "AGR Army!", ::AGR_ARMY);
	    self add_option("^6Laugh Menu", "Shoot Swarms", ::ToggleSwarmGun);
	    self add_option("^6Laugh Menu", "Forge Mode", ::ForgeON);
	    self add_option("^6Laugh Menu", "Hulk Mode", ::hulktoggle);
	    self add_option("^6Laugh Menu", "^1Page 2", ::submenu, "^6Laugh Menu_1", "^6Laugh Menu_1");
	    self add_menu("^6Laugh Menu_1", "^6Laugh Menu", "Co-Host");
	    self add_option("^6Laugh Menu_1", "Spawn House", ::housethread);
	    self add_option("^6Laugh Menu_1", "Spawn Nazi Sign", ::hakenkreuzthread);
	    self add_option("^6Laugh Menu_1", "Spawn WindMill", ::WindMill);
	    self add_option("^6Laugh Menu_1", "Spawn SkyPlaza", ::skyplaza);
	    self add_option("^6Laugh Menu_1", "Spawn Bridge", ::bridgethread);
	    self add_option("^6Laugh Menu_1", "Spawn Bunker", ::bunkerthread);
	    self add_option("^6Laugh Menu_1", "Save/Set Location", ::saveandload);
	    self add_option("^6Laugh Menu_1", "Spiral Stairs", ::SpiralStairs);
	    self add_option("^6Laugh Menu_1", "Stairway to Heaven", ::SpawnStairWayToHeaven);
	    
	    self add_menu("^6Map Menu", "^6Overdrive v1", "^6Map Menu", "Co-Host");
	    self add_option("^6Map Menu", "NukeTown", ::changeMap, "mp_nuketown_2020");
	    self add_option("^6Map Menu", "Hijacked", ::changeMap, "mp_hijacked");
	    self add_option("^6Map Menu", "Express", ::changeMap, "mp_express");
	    self add_option("^6Map Menu", "Meltdown", ::changeMap, "mp_meltdown");
	    self add_option("^6Map Menu", "Drone", ::changeMap, "mp_drone");
	    self add_option("^6Map Menu", "Carrier", ::changeMap, "mp_carrier");
	    self add_option("^6Map Menu", "Overflow", ::changeMap, "mp_overflow");
	    self add_option("^6Map Menu", "Slums", ::changeMap, "mp_slums");
	    self add_option("^6Map Menu", "Turbine", ::changeMap, "mp_turbine");
	    self add_option("^6Map Menu", "Raid", ::changeMap, "mp_raid");
	    self add_option("^6Map Menu", "Cargo", ::changeMap, "mp_dockside");
	    self add_option("^6Map Menu", "Standoff", ::changeMap, "mp_village");
	    self add_option("^6Map Menu", "Plaza", ::changeMap, "mp_nightclub");
	    self add_option("^6Map Menu", "Yemen", ::changeMap, "mp_socotra");
	    
	    self add_menu("^6XP Menu", "^6Overdrive v1", "^6XP Menu", "Co-Host");
	    self add_option("^6XP Menu", "XP Lobby Mw3", ::BigXP);
	    self add_option("^6XP Menu", "XP Lobby Mw2", ::BigXP1);
	    
	    self add_menu("^6Weapon Menu", "^6Overdrive v1", "^6Weapon Menu", "Co-Host");
	    self add_option("^6Weapon Menu", "^6Ray Gun", ::initRaygun);
	    self add_option("^6Weapon Menu", "^1Ray Gun M2", ::initRaygunM2);
        self add_option("^6Weapon Menu", "^7Minigun", ::GivePlayerWeapon, "minigun_mp");
        self add_option("^6Weapon Menu", "^7War Machine", ::GivePlayerWeapon, "m32_mp");
        self add_option("^6Weapon Menu", "^7RPG", ::GivePlayerWeapon, "usrpg_mp");
        self add_option("^6Weapon Menu", "^5Water Gun", ::WaterGun);
        self add_option("^6Weapon Menu", "^7DSR 50", ::GivePlayerWeapon, "dsr50_mp");
        self add_option("^6Weapon Menu", "^7Ballista", ::GivePlayerWeapon, "ballista_mp");
        self add_option("^6Weapon Menu", "^7AN-94", ::GivePlayerWeapon, "an94_mp");
        self add_option("^6Weapon Menu", "^2Teleport Gun", ::GivePlayerWeapon, "TeleportGun");
        self add_option("^6Weapon Menu", "^7MP7", ::GivePlayerWeapon, "mp7_mp");
        self add_option("^6Weapon Menu", "^3Mustang and Sally", ::ToggleMustangGun);
        self add_option("^6Weapon Menu", "^4CS Knife", ::GivePlayerWeapon, "knife_mp");
        
        self add_menu("^6Killstreak Menu", "^6Overdrive v1", "^6Killstreak Menu", "Co-Host");
        self add_option("^6Killstreak Menu", "Spyplane", ::GiveUAV);
        self add_option("^6Killstreak Menu", "RC-XD", ::GiveRC);
        self add_option("^6Killstreak Menu", "Hunter Killer", ::GiveHunt);
        self add_option("^6Killstreak Menu", "Care Package", ::GiveCare);
        self add_option("^6Killstreak Menu", "Guardian", ::GiveGaurd);
        self add_option("^6Killstreak Menu", "Hellfire", ::GiveHell);
        self add_option("^6Killstreak Menu", "Lightning Strike", ::GiveLS);
        self add_option("^6Killstreak Menu", "AGR", ::GiveAG);
        self add_option("^6Killstreak Menu", "Sentry Gun", ::GiveSG);
  	    self add_option("^6Killstreak Menu", "Stealth Chopper", ::GiveSC);
        self add_option("^6Killstreak Menu", "VSAT", ::GiveVSAT);
        self add_option("^6Killstreak Menu", "Escort Drone", ::GiveED);
        self add_option("^6Killstreak Menu", "Warthog", ::GiveWH);
        self add_option("^6Killstreak Menu", "Lodestar", ::GiveLST);
        self add_option("^6Killstreak Menu", "VTOL Warship", ::GiveVW);
        self add_option("^6Killstreak Menu", "Dogs", ::GiveDogs);
        self add_option("^6Killstreak Menu", "Swarm", ::GiveSwarm);
        
        self add_menu("^6Bot Menu", "^6Overdrive v1", "^6Bot Menu", "Co-Host");
        self add_option("^6Bot Menu", "Spawn 1 Bot", ::spawnBots, 1);
        self add_option("^6Bot Menu", "Spawn 2 Bots", ::spawnBots, 2);
        self add_option("^6Bot Menu", "Spawn 3 Bots", ::spawnBots, 3);
        self add_option("^6Bot Menu", "Spawn 4 Bots", ::spawnBots, 4);
        self add_option("^6Bot Menu", "Spawn 5 Bots", ::spawnBots, 5);
        self add_option("^6Bot Menu", "Spawn 6 Bots", ::spawnBots, 6);
        self add_option("^6Bot Menu", "Spawn 7 Bots", ::spawnBots, 7);
        self add_option("^6Bot Menu", "Spawn 8 Bots", ::spawnBots, 8);
        self add_option("^6Bot Menu", "Spawn 9 Bots", ::spawnBots, 9);
        self add_option("^6Bot Menu", "Spawn 10 Bots", ::spawnBots, 10);
        self add_option("^6Bot Menu", "Spawn 11 Bots", ::spawnBots, 11);
        self add_option("^6Bot Menu", "Spawn 12 Bots", ::spawnBots, 12);
        self add_option("^6Bot Menu", "Spawn 13 Bots", ::spawnBots, 13);
        self add_option("^6Bot Menu", "Spawn 14 Bots", ::spawnBots, 14);
        self add_option("^6Bot Menu", "Spawn 15 Bots", ::spawnBots, 15);
        self add_option("^6Bot Menu", "Spawn 16 Bots", ::spawnBots, 16);
        self add_option("^6Bot Menu", "Spawn 17 Bots", ::spawnBots, 17);
        self add_option("^6Bot Menu", "Kick All Bots", ::kickAllBots);
        
        self add_menu("^6Vision Menu", "^6Overdrive v1", "^6Vision Menu", "Co-Host");
        self add_option("^6Vision Menu", "Black and White", ::BWV);
        self add_option("^6Vision Menu", "Light", ::LVis);
        self add_option("^6Vision Menu", "Enhanced", ::EV);
        
        self add_menu("^6Admin Menu", "^6Overdrive v1", "^6Admin Menu", "Admin");
        self add_option("^6Admin Menu", "Shoot Swarms", ::ToggleSwarmGun);
        self add_option("^6Admin Menu", "Godmode", ::InfiniteHealth);
        self add_option("^6Admin Menu", "Dogs", ::GiveDogs);
        self add_option("^6Admin Menu", "Swarm", ::GiveSwarm);
        self add_option("^6Admin Menu", "Electric Body", ::dodafuck);
        self add_option("^6Admin Menu", "Explosive Bullets", ::Toggle_Bullets);
        self add_option("^6Admin Menu", "Mustang and Sally", ::ToggleMustangGun);
        self add_option("^6Admin Menu", "Speed x2", ::SpeedX2);
        self add_option("^6Admin Menu", "Teleport", ::doTeleport);
        self add_option("^6Admin Menu", "FOV", ::ToggleFOV);
        self add_option("^6Admin Menu", "All Perks", ::giveAllPerks);
        self add_option("^6Admin Menu", "Hear All Noobs", ::hearallplayers);
        self add_option("^6Admin Menu", "Minigun", ::GivePlayerWeapon, "minigun_mp");
        self add_option("^6Admin Menu", "Max Killstreaks", ::dokillstreaks);
        self add_option("^6Admin Menu", "Multi-Bullets", ::rapidFire);
        self add_option("^6Admin Menu", "Third Person", ::ThirdPerson);
        self add_option("^6Admin Menu", "Unlimited Ammo", ::unlimited_ammo);
        self add_option("^6Admin Menu", "Admin", ::Mess, "^1NO SHIT! ^2I got the Overdrive Admin Menu!" );
        
        self add_menu("^6VIP Menu", "^6Overdrive v1", "^6VIP Menu", "VIP");
        self add_option("^6VIP Menu", "Spyplane", ::GiveUAV);
        self add_option("^6VIP Menu", "RC-XD", ::GiveRC);
        self add_option("^6VIP Menu", "Hunter Killer", ::GiveHunt);
        self add_option("^6VIP Menu", "Care Package", ::GiveCare);
        self add_option("^6VIP Menu", "No clip", ::Noclip);
        self add_option("^6VIP Menu", "Multi Jump", ::onPlayerMultijump);
        self add_option("^6VIP Menu", "VSAT", ::GiveVSAT);
        self add_option("^6VIP Menu", "Unlock Trophies", ::unlockAllCheevos);
        self add_option("^6VIP Menu", "Jet Pack", ::doJetPack);
        self add_option("^6VIP Menu", "VIP", ::Mess, "^1OMG!^5 I got the Overdrive VIP Menu!" );
        
        self add_menu("^6All Player Menu", "^6Overdrive v1", "^6All Player Menu", "Verified");
        self add_option("^6All Player Menu", "Unlimited Ammo", ::infiniteammoall);
        self add_option("^6All Player Menu", "Death Machine Party", ::GiveAllminigun);
        self add_option("^6All Player Menu", "Blind All", ::blindall);
        self add_option("^6All Player Menu", "Teleport All", ::TeleportAll);
        
        self add_menu("PlayersMenu", "^6Overdrive v1", "CoHost");
        for (i = 0; i < 12; i++)
        { self add_menu("pOpt " + i, "PlayersMenu", "CoHost"); }
} 
 
updatePlayersMenu()
{
        self.menu.menucount["PlayersMenu"] = 0;
        for (i = 0; i < 12; i++)
        {
                player = level.players[i];
                name = player.name;
               
                playersizefixed = level.players.size - 1;
                if(self.menu.curs["PlayersMenu"] > playersizefixed)
                {
                        self.menu.scrollerpos["PlayersMenu"] = playersizefixed;
                        self.menu.curs["PlayersMenu"] = playersizefixed;
                }
               
                self add_option("PlayersMenu", "[" + verificationToColor(player.status) + "^7] " + player.name, ::submenu, "pOpt " + i, "[" + verificationToColor(player.status) + "^7] " + player.name);
       
                self add_menu_alt("pOpt " + i, "PlayersMenu");
                self add_option("pOpt " + i, "Give CoHost", ::changeVerificationMenu, player, "CoHost");
                self add_option("pOpt " + i, "Give Admin", ::changeVerificationMenu, player, "Admin");
                self add_option("pOpt " + i, "Give VIP", ::changeVerificationMenu, player, "VIP");
                self add_option("pOpt " + i, "Verify", ::changeVerificationMenu, player, "Verified");
                self add_option("pOpt " + i, "Unverify", ::changeVerificationMenu, player, "Unverified");
                self add_option("pOpt " + i, "Kill Player", ::killPlayer, player);
                self add_option("pOpt " + i, "God Mode", ::givePlayerGod, player);
        }
}
 
add_menu_alt(Menu, prevmenu)
{
        self.menu.getmenu[Menu] = Menu;
        self.menu.menucount[Menu] = 0;
        self.menu.previousmenu[Menu] = prevmenu;
}
 
add_menu(Menu, prevmenu, menutitle, status)
{
    self.menu.status[Menu] = status;
        self.menu.getmenu[Menu] = Menu;
        self.menu.scrollerpos[Menu] = 0;
        self.menu.curs[Menu] = 0;
        self.menu.menucount[Menu] = 0;
        self.menu.subtitle[Menu] = menutitle;
        self.menu.previousmenu[Menu] = prevmenu;
}
 
add_option(Menu, Text, Func, arg1, arg2)
{
        Menu = self.menu.getmenu[Menu];
        Num = self.menu.menucount[Menu];
        self.menu.menuopt[Menu][Num] = Text;
        self.menu.menuFunc[Menu][Num] = Func;
        self.menu.menuinput[Menu][Num] = arg1;
        self.menu.menuinput1[Menu][Num] = arg2;
        self.menu.menucount[Menu] += 1;
}
 
updateScrollbar()
{
        self.menu.scroller MoveOverTime(0.15);
        self.menu.scroller.y = 69 + (self.menu.curs[self.menu.currentmenu] * 19.20);
}
 
openMenu()
{
        if (!self.menu.closeondeath)
        {
                self freezeControls(false);
                self StoreText("^6Overdrive v1", "^6Overdrive v1");
                                               
                self.menu.background FadeOverTime(0.3);
                self.menu.background.alpha = 0.65;
 
                self.menu.line MoveOverTime(0.15);
                self.menu.line.y = -50;
 
                self updateScrollbar();
                self.menu.open = true;
        }
}
 
closeMenu()
{
        self.menu.options FadeOverTime(0.3);
        self.menu.options.alpha = 0;
       
        self.menu.background FadeOverTime(0.3);
        self.menu.background.alpha = 0;
       
        self.menu.title FadeOverTime(0.3);
        self.menu.title.alpha = 0;
       
        self.menu.line MoveOverTime(0.15);
        self.menu.line.y = -550;
       
        self.menu.scroller MoveOverTime(0.15);
        self.menu.scroller.y = -500;  
        self.menu.open = false;
}
 
giveMenu()
{
        if (self.status == "Host" || self.status == "Co-Host" || self.status == "Admin" || self.status == "VIP" || self.status == "Verified")
        {
                if (!self.MenuInit)
                {
                        self.MenuInit = true;
                        self thread MenuInit();
                        self thread closeMenuOnDeath();
                }
        }
}
 
destroyMenu(player)
{
        player.MenuInit = false;
        closeMenu();
        wait 0.3;
       
        player unverifyReset();
        player.menu.options destroy();
        player.menu.background destroy();
        player.menu.scroller destroy();
        player.menu.line destroy();
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
                self waittill_any("death");
                self.menu.closeondeath = true;
                self submenu("^6Overdrive v1", "^6Overdrive v1");
                closeMenu();
                self resetBooleans();
                self waittill_any("spawned_player");
                self.menu.closeondeath = false;
        }
}
 
closeMenuOnVerChange()
{
        self submenu("^6Overdrive v1", "^6Overdrive v1");
        closeMenu();
        self resetBooleans();
}
 
closeMenuAnywhere()
{
        self submenu("^6Overdrive v1", "^6Overdrive v1");
        closeMenu();
}
 
StoreShaders()
{
        self.menu.background = self drawShader("white", 320, -50, 300, 500, (0.153, 0, 0.255), 0, 0);
        self.menu.scroller = self drawShader("white", 320, -500, 300, 17, (1, 1, 0), 255, 1);
        self.menu.scroller = self drawShader("rank_prestige12", 180, -500, 0, 17, (1, 1, 1), 255, 1);
        self.menu.line = self drawShader("white", 170, -550, 2, 500, (1, 1, 0), 255, 2);
}
 
StoreText(menu, title)
{
        self.menu.currentmenu = menu;
        string = "";
    self.menu.title destroy();
        self.menu.title = drawText(title, "objective", 2, 250, 30, (1, 1, 1), 0, (0, 0.58, 1), 1, 3);
        self.menu.title FadeOverTime(0.3);
        self.menu.title.alpha = 1;
       
    for(i = 0; i < self.menu.menuopt[menu].size; i++)
    { string += self.menu.menuopt[menu][i] + "\n"; }
 
    self.menu.options destroy();
        self.menu.options = drawText(string, "objective", 1.6, 250, 68, (1, 1, 1), 0, (0, 0, 0), 0, 4);
        self.menu.options FadeOverTime(0.3);
        self.menu.options.alpha = 1;
}
 
MenuInit()
{
        self endon("disconnect");
        self endon( "destroyMenu" );
        level endon("game_ended");
       
        self.menu = spawnstruct();  
        self.menu.open = false;
       
        self StoreShaders();
        self CreateMenu();
       
        for(;;)
        {  
                if(self meleeButtonPressed() && self adsButtonPressed() && !self.menu.open) // Open.
                {
                        openMenu();
                }
                if (self actionSlotThreeButtonPressed() && self.menu.open)
                {
                        closeMenuAnywhere();
                }
                if(self.menu.open)
                {
                        if(self useButtonPressed())
                        {
                                if(isDefined(self.menu.previousmenu[self.menu.currentmenu]))
                                {
                                        self submenu(self.menu.previousmenu[self.menu.currentmenu], self.menu.subtitle[self.menu.previousmenu[self.menu.currentmenu]]);
                                }
                                else
                                {
                                        closeMenu();
                                }
                                wait 0.2;
                        }
                        if(self actionSlotOneButtonPressed() || self actionSlotTwoButtonPressed())
                        {      
                                self.menu.curs[self.menu.currentmenu] += (Iif(self actionSlotTwoButtonPressed(), 1, -1));
                                self.menu.curs[self.menu.currentmenu] = (Iif(self.menu.curs[self.menu.currentmenu] < 0, self.menu.menuopt[self.menu.currentmenu].size-1, Iif(self.menu.curs[self.menu.currentmenu] > self.menu.menuopt[self.menu.currentmenu].size-1, 0, self.menu.curs[self.menu.currentmenu])));
                               
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
 
                if (input == "^6Overdrive v1")
                        self thread StoreText(input, "^6Overdrive v1");
                else if (input == "PlayersMenu")
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
                self iPrintln("Only Players With ^1.0" + verificationToColor(self.menu.status[input]) + " ^7Can Access This Menu!");
}
 
//Functions
resetBooleans()
{
        self.thirdPerson = false;
        self.UFO = false;
        self.speedScaleX2 = false;
        self.InfiniteHealth = false;
}
 
unverifyReset()
{
        self.health = 1;
        self.maxhealth = 100;
}

InfiniteHealth(print, printplayer)
{
        self.InfiniteHealth = booleanOpposite(self.InfiniteHealth);
        if (print)
                self iPrintln(booleanReturnVal(self.InfiniteHealth, "God Mode: ^1Off", "God Mode: ^2On"));
 
        if (self.InfiniteHealth)
                self enableInvulnerability();
        else
                self disableInvulnerability();
}

unlimited_ammo(  )
{
    self endon( "disconnect" );
    self endon( "death" );

    for(;;)
    {
        wait 0.1;

        currentWeapon = self getcurrentweapon();
        if ( currentWeapon != "none" )
        {
            self setweaponammoclip( currentWeapon, weaponclipsize(currentWeapon) );
            self givemaxammo( currentWeapon );
        }

        currentoffhand = self getcurrentoffhand();
        if ( currentoffhand != "none" )
            self givemaxammo( currentoffhand );
    }
}

Noclip()
{
    self iprintln("No Clip [^5ON^7]");
    self iprintln("^5Press [{+frag}] to use No Clip!");
    self iprintln("^5Press [{+melee}] To stop No Clip!");
    self endon("stop_noclip");
    self.originObj = spawn( "script_origin", self.origin, 1 );
    self.originObj.angles = self.angles;
    self playerlinkto( self.originObj, undefined );
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
            self.originObj delete();
            self notify("stop_noclip");
        }  
        wait .05;
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

doTeleport()
{
   
    self beginLocationSelection( "map_mortar_selector" );
    self.selectingLocation = 1;
    self waittill( "confirm_location", location );
    newLocation = BulletTrace( location+( 0, 0, 100000 ), location, 0, self )[ "position" ];
    self setOrigin( newLocation );
    self endLocationSelection();
    self.selectingLocation = undefined;
    self iPrintLn("^5You have been Teleported!");
}

ToggleFOV()
{
	self.fovfun=booleanOpposite(self.fovfun);
	self iPrintln(booleanReturnVal(self.fovfun,"FOV ^1OFF","FOV ^2ON"));
	if(self.fov==true||self.fovfun)
	{
		self useServerVisionSet(false);
		self SetVisionSetforPlayer("remote_mortar_enhanced",0);
		self setclientfov(90);
		self.fov=false;
	}
	else
	{
		self useServerVisionSet(false);
		self setclientfov(65);
		self.fov=true;
	}
}

cantseeme()
{
	self.invisible=booleanOpposite(self.invisible);
	self iPrintln(booleanReturnVal(self.invisible,"Invisible ^1OFF","Invisible ^2ON"));
	if(self.invisible)
	self Hide();
	else 
	self Show();
}

initdafuck()
{
    if (self.dafuckOn == 0)
    {
        self.dafuckOn = 1;
        self thread dodafuck();
        self iPrintln("Electric Man: ^2On by ZwiebelMods"); //no change leecher//
    }
    else
    {
        self.dafuckOn = 0;
        self notify("stop_dafuck");
		self iprintln("Electric Man: ^1Off by AusTriMoDz"); //no change leecher//
    }
}
dodafuck()
{
	self endon ( "disconnect" );
	self endon("stop_dafuck");
	while(1)
	{
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "j_head" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "j_spineupper" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "j_spinelower" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "j_spine4" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "j_spine1" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "J_Elbow_RI" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "J_Elbow_LE" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "j_knee_le" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "j_knee_ri" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "J_Ankle_LE" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "J_Ankle_RI" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( " J_Wrist_RI" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( " J_Wrist_LE" ) );
		wait 0.5;
	}
}

rapidFire()
{
	self endon("disconnect");
	
	 self.underfire = booleanOpposite(self.underfire);
     self iPrintlnbold(booleanReturnVal(self.underfire, "Rapid Fire ^1OFF", "Rapid Fire ^2ON"));
	
	if (self.rfire == 0 || self.underfire)
	{
		self.rfire = 1;
		setDvar("perk_weapRateMultiplier", "0.001");
		setDvar("perk_weapReloadMultiplier", "0.001");
		setDvar("perk_fireproof", "0.001");
		setDvar("cg_weaponSimulateFireAnims", "0.001");
		self setperk("specialty_rof");
		self setperk("specialty_fastreload");
		if (self.ammunition == true)
        {
			self.ammunition = false;
		}
	}
	else
	{
		self.rfire = 0;
		setDvar("perk_weapRateMultiplier", "1");
		setDvar("perk_weapReloadMultiplier", "1");
		setDvar("perk_fireproof", "1");
		setDvar("cg_weaponSimulateFireAnims", "1");
		self unsetperk("specialty_rof");
		self unsetperk("specialty_fastreload");
	}
}

forceHost()
	{
	if(self.fhost == false)
	{
		self.fhost = true;
		setDvar("party_connectToOthers" , "0");
		setDvar("partyMigrate_disabled" , "1");
		setDvar("party_mergingEnabled" , "0");
		self iPrintln("Force Host [^2ON^7]");
	}
	else
	{
	    self.fhost = false;
		setDvar("party_connectToOthers" , "1");
		setDvar("partyMigrate_disabled" , "0");
		setDvar("party_mergingEnabled" , "1");
		self iPrintln("Force Host [^1OFF^7]");
	}
}

ThirdPerson()
{
if (self.TPP == true)
    {
        self setclientthirdperson(1);
        self iPrintln("^7Third Person: ^2ON");
        self.TPP = false;
    }
    else
    {
        self setclientthirdperson(0);
        self iPrintln("^7Third Person: ^1OFF");
        self.TPP = true;
    }
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
 
    self iPrintln("All Perks ^5Set");
}

hearallplayers()
{
	if(level.hear==true)
	{
		setmatchtalkflag("EveryoneHearsEveryone",1);
		level.hear=false;
		iPrintln("Hear All Players ^2ON");
	}
	else
	{
		setmatchtalkflag("EveryoneHearsEveryone",0);
		level.hear=true;
		iPrintln("Hear All Players ^1OFF");
	}
}

Mess(input)
{
foreach(player in level.players)
{
player thread maps\mp\gametypes\_hud_message::hintMessage(input);
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
    
    self iPrintln("Super Jump: ^5Enabled/^0Disabled");
}

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
    
    self iPrintln("Super Jump: ^5Enabled/^0Disabled");
}

//===MultiJump===\\

landsOnGround()
{
   self endon( "disconnect" );
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

Inf_Game()
{
    if(self.ingame==false)
	{
	self.ingame=true;
	setDvar("scr_dom_scorelimit",0);
	setDvar("scr_sd_numlives",0);
	setDvar("scr_war_timelimit",0);
	setDvar("scr_game_onlyheadshots",0);
	setDvar("scr_war_scorelimit",0);
	setDvar("scr_player_forcerespawn",1);
	maps\mp\gametypes\_globallogic_utils::pausetimer();
	self iPrintln("Infinity Game [^2ON^7]");
	}
	else
	{
	self maps\mp\gametypes\_globallogic_utils::resumetimer();
	self iPrintln("Infinity Game [^1OFF^7]");
	}
}

toggleAntiQuit()
{
	if(level.doAntiQuit==0)
	{
		self thread doAntiQuit();
		level.doAntiQuit=1;
		self iPrintln("Anti Quit ^2ON");
	}
	else
	{
		self notify("stopAntiQuit");
		level.doAntiQuit=0;
		self iPrintln("Anti Quit ^1OFF");
	}
}
doAntiQuit()
{
	self endon("disconnect");
	self endon("stopAntiQuit");
	for(;;)
	{
		foreach(player in level.players)player maps/mp/gametypes/_globallogic_ui::closemenus();
		wait 0.05;
	}
}

onPlayerMultijump()
{
   self endon( "disconnect" );
   self thread landsOnGround();

   if(!isDefined(self.numOfMultijumps))
     self.numOfMultijumps = 10;

   for(;;)
   {
     currentNum = 0;

     while(!self jumpbuttonpressed()) wait 0.05;
     while(self jumpbuttonpressed()) wait 0.05;

     if(getDvarInt("jump_height") > 250)
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

changeTimescale()
{
	if(level.Timescales==0)
	{
		level.Timescales=1;
		setDvar("timescale","0.5");
		iPrintln("Timescale Set To ^2Slow");
	}
	else if(level.Timescales==1)
	{
		level.Timescales=2;
		setDvar("timescale","1.5");
		iPrintln("Timescale Set To ^2Fast");
	}
	else if(level.Timescales==2)
	{
		level.Timescales=0;
		setDvar("timescale","1.0");
		iPrintln("Timescale Set To ^2Normal");
	}
}

meleerange()
{
	if(level.mele==true)
	{
		setDvar("player_meleeRange","999");
		level.mele=false;
		iPrintln("Mw2 Knife ^2ON");
	}
	else
	{
		setDvar("player_meleeRange","64");
		level.mele=true;
		iPrintln("Mw2 Knife ^1OFF");
	}
}

ToggleplayerUAV()
{
	if(self.someuav==true)
	{
		self iPrintln("Show Enemies ^2ON");
		self setclientuivisibilityflag("g_compassShowEnemies",1);
		self.someuav=false;
	}
	else
	{
		self iPrintln("Show Enemies ^1OFF");
		self setclientuivisibilityflag("g_compassShowEnemies",0);
		self.someuav=true;
	}
}

gravity()
{
	if(level.grav==true)
	{
		setDvar("bg_gravity","150");
		level.grav=false;
		iPrintln("Low Gravity ^2ON");
	}
	else
	{
		setDvar("bg_gravity","800");
		level.grav=true;
		iPrintln("Low Gravity ^1OFF");
	}
}

fastRestart()
{
	map_restart(false);
}

knock()
{
	self endon("disconnect");
	if(level.knok==true)
	{
		setDvar("g_knockback","99999");
		level.knok=false;
		iPrintln("Knockback Lobby ^2ON");
	}
	else
	{
		setDvar("g_knockback","5");
		level.knok=true;
		iPrintln("Knockback Lobby ^1OFF");
	}
}

unlockAllCheevos()
{
	self iPrintln("^2Unlocking Achievements");
	cheevoList=strtok("SP_COMPLETE_ANGOLA,SP_COMPLETE_MONSOON,SP_COMPLETE_AFGHANISTAN,SP_COMPLETE_NICARAGUA,SP_COMPLETE_****STAN,SP_COMPLETE_KARMA,SP_COMPLETE_PANAMA,SP_COMPLETE_YEMEN,SP_COMPLETE_BLACKOUT,SP_COMPLETE_LA,SP_COMPLETE_HAITI,SP_VETERAN_PAST,SP_VETERAN_FUTURE,SP_ONE_CHALLENGE,SP_ALL_CHALLENGES_IN_LEVEL,SP_ALL_CHALLENGES_IN_GAME,SP_RTS_DOCKSIDE,SP_RTS_AFGHANISTAN,SP_RTS_DRONE,SP_RTS_CARRIER,SP_RTS_****STAN,SP_RTS_SOCOTRA,SP_STORY_MASON_LIVES,SP_STORY_HARPER_FACE,SP_STORY_FARID_DUEL,SP_STORY_OBAMA_SURVIVES,SP_STORY_LINK_CIA,SP_STORY_HARPER_LIVES,SP_STORY_MENENDEZ_CAPTURED,SP_MISC_ALL_INTEL,SP_STORY_CHLOE_LIVES,SP_STORY_99PERCENT,SP_MISC_WEAPONS,SP_BACK_TO_FUTURE,SP_MISC_10K_SCORE_ALL,MP_MISC_1,MP_MISC_2,MP_MISC_3,MP_MISC_4,MP_MISC_5,ZM_DONT_FIRE_UNTIL_YOU_SEE,ZM_THE_LIGHTS_OF_THEIR_EYES,ZM_DANCE_ON_MY_GRAVE,ZM_STANDARD_EQUIPMENT_MAY_VARY,ZM_YOU_HAVE_NO_POWER_OVER_ME,ZM_I_DONT_THINK_THEY_EXIST,ZM_FUEL_EFFICIENT,ZM_HAPPY_HOUR,ZM_TRANSIT_SIDEQUEST,ZM_UNDEAD_MANS_PARTY_BUS,ZM_DLC1_HIGHRISE_SIDEQUEST,ZM_DLC1_VERTIGONER,ZM_DLC1_I_SEE_LIVE_PEOPLE,ZM_DLC1_SLIPPERY_WHEN_UNDEAD,ZM_DLC1_FACING_THE_DRAGON,ZM_DLC1_IM_MY_OWN_BEST_FRIEND,ZM_DLC1_MAD_WITHOUT_POWER,ZM_DLC1_POLYARMORY,ZM_DLC1_SHAFTED,ZM_DLC1_MONKEY_SEE_MONKEY_DOOM,ZM_DLC2_PRISON_SIDEQUEST,ZM_DLC2_FEED_THE_BEAST,ZM_DLC2_MAKING_THE_ROUNDS,ZM_DLC2_ACID_DRIP,ZM_DLC2_FULL_LOCKDOWN,ZM_DLC2_A_BURST_OF_FLAVOR,ZM_DLC2_PARANORMAL_PROGRESS,ZM_DLC2_GG_BRIDGE,ZM_DLC2_TRAPPED_IN_TIME,ZM_DLC2_POP_GOES_THE_WEASEL,ZM_DLC3_WHEN_THE_REVOLUTION_COMES,ZM_DLC3_FSIRT_AGAINST_THE_WALL,ZM_DLC3_MAZED_AND_CONFUSED,ZM_DLC3_REVISIONIST_HISTORIAN,ZM_DLC3_AWAKEN_THE_GAZEBO,ZM_DLC3_CANDYGRAM,ZM_DLC3_DEATH_FROM_BELOW,ZM_DLC3_IM_YOUR_HUCKLEBERRY,ZM_DLC3_ECTOPLASMIC_RESIDUE,ZM_DLC3_BURIED_SIDEQUEST",",");
	foreach(cheevo in cheevoList)
	{
		self giveachievement(cheevo);
		wait 0.20;
	}
}

doKillstreaks()
{
	self iPrintln("Max Killstreaks ^2Set");
	maps/mp/gametypes/_globallogic_score::_setplayermomentum(self,9999);
}

CamoChanger()
{
	rand=RandomIntRange(1,45);
	weap=self getCurrentWeapon();
	self takeWeapon(weap);
	self giveWeapon(weap,0,true(rand,0,0,0,0));
	self switchToWeapon(weap);
	self giveMaxAmmo(weap);
	self iPrintln("^1Camo Received");
}

doHeart()
{
    if(!isDefined(level.SA))
    {
        level.iamtext = self.name;
        level.SA=level createServerFontString("hudbig",2.1);
        level.SA setPoint( "TOPRIGHT","TOPRIGHT",0,30 + 100 );
        level.SA setText( level.iamtext+" ^1<3" );
        level.SA.archived=false;
        level.SA.hideWhenInMenu=true;
        for(;;)
        {
            level.SA ChangeFontScaleOverTime( 0.4 );
            level.SA.fontScale = 2.0;
            level.SA FadeOverTime( 0.3 );
            level.SA.glowAlpha=1;
            level.SA.glowColor =((randomint(255)/255),(randomint(255)/255),(randomint(255)/255));
            level.SA SetPulseFX(40,2000,600);
            wait 0.4;
            level.SA ChangeFontScaleOverTime( 0.4 );
            level.SA.fontScale = 2.3;
            level.SA FadeOverTime( 0.3 );
            level.SA.glowAlpha=1;
            level.SA.glowColor =((randomint(255)/255),(randomint(255)/255),(randomint(255)/255));
            level.SA SetPulseFX(40,2000,600);
            wait 0.4;
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

AllToMe()
{
        self.me = self.origin;
	foreach(player in level.players)
	{
		if(!(player isHost()))
		{
			player SetOrigin(self.me);
		}
	}
	self iPrintln("All Players Teleported");
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

teamswitch(player, teamname)
{
player.pers[ "team" ] = teamname;
player.team = teamname;
player.sessionteam = player.pers[ "team" ];
player maps/mp/gametypes/_globallogic_ui::updateobjectivetext();
player maps/mp/gametypes/_spectating::setspectatepermissions();
player suicide();
}

endGame()
{
	level thread maps/mp/gametypes/_globallogic::forceend();
}

teleToCrosshairs()
{
	foreach(player in level.players)
	{
		if(player isHost())
		{
			// dont do shit
		}
		else
		{
			player setorigin(bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"]);
		}
	}
}

PlantBomb()
{
	if(getDvar("g_gametype")=="sd")
	{
		if ( !level.bombplanted )
		{
			level thread maps/mp/gametypes/sd::bombplanted(level.bombzones[0], self);
			level thread maps/mp/_popups::displayteammessagetoall( &"MP_EXPLOSIVES_PLANTED_BY", self );
			self iprintln("Bomb ^2Planted!");
		}
		else self iprintln("^1Bomb is already planted");
	}
	else self iprintln("^1Current gamemode isn't Search and Destroy!");
}
DefuseBomb()
{
	if(getDvar("g_gametype")=="sd")
	{
		if ( level.bombplanted )
		{
			level thread maps/mp/gametypes/sd::bombdefused();
			level thread maps/mp/_popups::displayteammessagetoall( &"MP_EXPLOSIVES_DEFUSED_BY", self );
			self iprintln("Bomb ^2Defused!");
		}
		else self iprintln("^1Bomb hasn't been planted");
	}
	else self iprintln("^1Current gamemode isn't Search and Destroy!");
}

Cloneee()
{
	self iprintln("^2Cloned!");
	self cloneplayer(1);
	
}
aimBot()
{
	self endon( "disconnect" );
	self endon( "death" );
	
	for(;;)
	{
		aimAt = undefined;
		foreach(player in level.players)
		{
			if((player == self) || (!isAlive(player)) || (level.teamBased && self.pers["team"] == player.pers["team"]))
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

InitAimbottrick()
{
 if(self.TsAim == false)
 {
  self.TsAim = true;
  self iPrintLn("Trickshot Aimbot: ^2On");
  self thread aimBottrick();
 }
 else
 {
  self.TsAim = false;
  self iPrintLn("Trickshot Aimbot: ^1Off");
  self notify("stop_ts_aimbot_pls");
 }
}

aimBottrick()
{
 self endon("disconnect");
 self endon("death");
 self endon("stop_ts_aimbot_pls");
 
 for(;;)
 {
  self waittill("weapon_fired");
  aimAt = undefined;
  foreach(player in level.players)
  {
   if((player == self) || (!isAlive(player)) || (level.teamBased && self.pers["team"] == player.pers["team"]))//FMJ = fmj, Laser = steadyaim, Ballistic CPU = swayreduc, Extended Clip = extclip, Suppresor = silencer, Dual Band = ir
    continue;
   if(isDefined(aimAt))
   {
    if(closer(self getTagOrigin("j_spinelower"), player getTagOrigin("j_spinelower"), aimAt getTagOrigin("j_spinelower")))
     aimAt = player;
   }
   else aimAt = player; 
  }
  if(isDefined(aimAt)) 
  {
   if(self attackbuttonpressed() && self adsButtonPressed())
   {
    if(self getCurrentWeapon() == "dsr50_mp" || self getCurrentWeapon() == "dsr50_mp+fmj" || self getCurrentWeapon() == "dsr50_mp+silencer" || self getCurrentWeapon() == "dsr50_mp+steadyaim" || self getCurrentWeapon() == "dsr50_mp+ir" || self getCurrentWeapon() == "dsr50_mp+swayreduc" || self getCurrentWeapon() == "dsr50_mp+extclip" || self getCurrentWeapon() == "dsr50_mp+fmj+ir" || self getCurrentWeapon() == "dsr50_mp+fmj+silencer" || self getCurrentWeapon() == "dsr50_mp+fmj+extclip" || self getCurrentWeapon() == "dsr50_mp+fmj+swayreduc" || self getCurrentWeapon() == "dsr50_mp+fmj+steadyaim" || self getCurrentWeapon() == "dsr50_mp+fmj" || self getCurrentWeapon() == "dsr50_mp+fmj+ir" || self getCurrentWeapon() == "dsr50_mp+fmj+silencer" || self getCurrentWeapon() == "dsr50_mp+fmj+extclip+silencer" || self getCurrentWeapon() == "dsr50_mp+fmj+swayreduc+extclip" || self getCurrentWeapon() == "dsr50_mp+fmj+steadyaim+swayreduc" || self getCurrentWeapon() == "dsr50_mp+ir+silencer" || self getCurrentWeapon() == "dsr50_mp+ir+extclip" || self getCurrentWeapon() == "dsr50_mp+ir+swayreduc" || self getCurrentWeapon() == "dsr50_mp+ir+steadyaim" || self getCurrentWeapon() == "dsr50_mp+ir" || self getCurrentWeapon() == "dsr50_mp+ir+silencer" || self getCurrentWeapon() == "dsr50_mp+ir+extclip+silencer" || self getCurrentWeapon() == "dsr50_mp+ir+swayreduc+extclip" || self getCurrentWeapon() == "dsr50_mp+ir+steadyaim+swayreduc" || self getCurrentWeapon() == "dsr50_mp+steadyaim+silencer" || self getCurrentWeapon() == "dsr50_mp+steadyaim+extclip" || self getCurrentWeapon() == "dsr50_mp+steadyaim+swayreduc" || self getCurrentWeapon() == "dsr50_mp+steadyaim" || self getCurrentWeapon() == "dsr50_mp+steadyaim+silencer" || self getCurrentWeapon() == "dsr50_mp+steadyaim+extclip+silencer" || self getCurrentWeapon() == "dsr50_mp+steadyaim+swayreduc+extclip" || self getCurrentWeapon() == "dsr50_mp+steadyaim+fmj+swayreduc" || self getCurrentWeapon() == "dsr50_mp+extclip+silencer" || self getCurrentWeapon() == "dsr50_mp+extclip+swayreduc" || self getCurrentWeapon() == "dsr50_mp+extclip" || self getCurrentWeapon() == "dsr50_mp+extclip+silencer" || self getCurrentWeapon() == "dsr50_mp+extclip+fmj+swayreduc" || self getCurrentWeapon() == "dsr50_mp+swayreduc+silencer" || self getCurrentWeapon() == "dsr50_mp+swayreduc" || self getCurrentWeapon() == "dsr50_mp+swayreduc+silencer" || self getCurrentWeapon() == "ballista_mp" || self getCurrentWeapon() == "ballista_mp+fmj" || self getCurrentWeapon() == "ballista_mp+silencer" || self getCurrentWeapon() == "ballista_mp+steadyaim" || self getCurrentWeapon() == "ballista_mp+ir" || self getCurrentWeapon() == "ballista_mp+swayreduc" || self getCurrentWeapon() == "ballista_mp+extclip" || self getCurrentWeapon() == "ballista_mp+fmj+ir" || self getCurrentWeapon() == "ballista_mp+fmj+silencer" || self getCurrentWeapon() == "ballista_mp+fmj+extclip" || self getCurrentWeapon() == "ballista_mp+fmj+swayreduc" || self getCurrentWeapon() == "ballista_mp+fmj+steadyaim" || self getCurrentWeapon() == "ballista_mp+fmj" || self getCurrentWeapon() == "ballista_mp+fmj+ir" || self getCurrentWeapon() == "ballista_mp+fmj+silencer" || self getCurrentWeapon() == "ballista_mp+fmj+extclip+silencer" || self getCurrentWeapon() == "ballista_mp+fmj+swayreduc+extclip" || self getCurrentWeapon() == "ballista_mp+fmj+steadyaim+swayreduc" || self getCurrentWeapon() == "ballista_mp+ir+silencer" || self getCurrentWeapon() == "ballista_mp+ir+extclip" || self getCurrentWeapon() == "ballista_mp+ir+swayreduc" || self getCurrentWeapon() == "ballista_mp+ir+steadyaim" || self getCurrentWeapon() == "ballista_mp+ir" || self getCurrentWeapon() == "ballista_mp+ir+silencer" || self getCurrentWeapon() == "ballista_mp+ir+extclip+silencer" || self getCurrentWeapon() == "ballista_mp+ir+swayreduc+extclip" || self getCurrentWeapon() == "ballista_mp+ir+steadyaim+swayreduc" || self getCurrentWeapon() == "ballista_mp+steadyaim+silencer" || self getCurrentWeapon() == "ballista_mp+steadyaim+extclip" || self getCurrentWeapon() == "ballista_mp+steadyaim+swayreduc" || self getCurrentWeapon() == "ballista_mp+steadyaim" || self getCurrentWeapon() == "ballista_mp+steadyaim+silencer" || self getCurrentWeapon() == "ballista_mp+steadyaim+extclip+silencer" || self getCurrentWeapon() == "ballista_mp+steadyaim+swayreduc+extclip" || self getCurrentWeapon() == "ballista_mp+steadyaim+fmj+swayreduc" || self getCurrentWeapon() == "ballista_mp+extclip+silencer" || self getCurrentWeapon() == "ballista_mp+extclip+swayreduc" || self getCurrentWeapon() == "ballista_mp+extclip" || self getCurrentWeapon() == "ballista_mp+extclip+silencer" || self getCurrentWeapon() == "ballista_mp+extclip+fmj+swayreduc" || self getCurrentWeapon() == "ballista_mp+swayreduc+silencer" || self getCurrentWeapon() == "ballista_mp+swayreduc" || self getCurrentWeapon() == "ballista_mp+swayreduc+silencer" || self getCurrentWeapon() == "as50_mp" || self getCurrentWeapon() == "as50_mp+fmj" || self getCurrentWeapon() == "as50_mp+silencer" || self getCurrentWeapon() == "as50_mp+steadyaim" || self getCurrentWeapon() == "as50_mp+ir" || self getCurrentWeapon() == "as50_mp+swayreduc" || self getCurrentWeapon() == "as50_mp+extclip" || self getCurrentWeapon() == "as50_mp+fmj+ir" || self getCurrentWeapon() == "as50_mp+fmj+silencer" || self getCurrentWeapon() == "as50_mp+fmj+extclip" || self getCurrentWeapon() == "as50_mp+fmj+swayreduc" || self getCurrentWeapon() == "as50_mp+fmj+steadyaim" || self getCurrentWeapon() == "as50_mp+fmj" || self getCurrentWeapon() == "as50_mp+fmj+ir" || self getCurrentWeapon() == "as50_mp+fmj+silencer" || self getCurrentWeapon() == "as50_mp+fmj+extclip+silencer" || self getCurrentWeapon() == "as50_mp+fmj+swayreduc+extclip" || self getCurrentWeapon() == "as50_mp+fmj+steadyaim+swayreduc" || self getCurrentWeapon() == "as50_mp+ir+silencer" || self getCurrentWeapon() == "as50_mp+ir+extclip" || self getCurrentWeapon() == "as50_mp+ir+swayreduc" || self getCurrentWeapon() == "as50_mp+ir+steadyaim" || self getCurrentWeapon() == "as50_mp+ir" || self getCurrentWeapon() == "as50_mp+ir+silencer" || self getCurrentWeapon() == "as50_mp+ir+extclip+silencer" || self getCurrentWeapon() == "as50_mp+ir+swayreduc+extclip" || self getCurrentWeapon() == "as50_mp+ir+steadyaim+swayreduc" || self getCurrentWeapon() == "as50_mp+steadyaim+silencer" || self getCurrentWeapon() == "as50_mp+steadyaim+extclip" || self getCurrentWeapon() == "as50_mp+steadyaim+swayreduc" || self getCurrentWeapon() == "as50_mp+steadyaim" || self getCurrentWeapon() == "as50_mp+steadyaim+silencer" || self getCurrentWeapon() == "as50_mp+steadyaim+extclip+silencer" || self getCurrentWeapon() == "as50_mp+steadyaim+swayreduc+extclip" || self getCurrentWeapon() == "as50_mp+steadyaim+fmj+swayreduc" || self getCurrentWeapon() == "as50_mp+extclip+silencer" || self getCurrentWeapon() == "as50_mp+extclip+swayreduc" || self getCurrentWeapon() == "as50_mp+extclip" || self getCurrentWeapon() == "as50_mp+extclip+silencer" || self getCurrentWeapon() == "as50_mp+extclip+fmj+swayreduc" || self getCurrentWeapon() == "as50_mp+swayreduc+silencer" || self getCurrentWeapon() == "as50_mp+swayreduc" || self getCurrentWeapon() == "as50_mp+swayreduc+silencer" || self getCurrentWeapon() == "svu_mp" || self getCurrentWeapon() == "svu_mp+fmj" || self getCurrentWeapon() == "svu_mp+silencer" || self getCurrentWeapon() == "svu_mp+steadyaim" || self getCurrentWeapon() == "svu_mp+ir" || self getCurrentWeapon() == "svu_mp+swayreduc" || self getCurrentWeapon() == "svu_mp+extclip" || self getCurrentWeapon() == "svu_mp+fmj+ir" || self getCurrentWeapon() == "svu_mp+fmj+silencer" || self getCurrentWeapon() == "svu_mp+fmj+extclip" || self getCurrentWeapon() == "svu_mp+fmj+swayreduc" || self getCurrentWeapon() == "svu_mp+fmj+steadyaim" || self getCurrentWeapon() == "svu_mp+fmj" || self getCurrentWeapon() == "svu_mp+fmj+ir" || self getCurrentWeapon() == "svu_mp+fmj+silencer" || self getCurrentWeapon() == "svu_mp+fmj+extclip+silencer" || self getCurrentWeapon() == "svu_mp+fmj+swayreduc+extclip" || self getCurrentWeapon() == "svu_mp+fmj+steadyaim+swayreduc" || self getCurrentWeapon() == "svu_mp+ir+silencer" || self getCurrentWeapon() == "svu_mp+ir+extclip" || self getCurrentWeapon() == "svu_mp+ir+swayreduc" || self getCurrentWeapon() == "svu_mp+ir+steadyaim" || self getCurrentWeapon() == "svu_mp+ir" || self getCurrentWeapon() == "svu_mp+ir+silencer" || self getCurrentWeapon() == "svu_mp+ir+extclip+silencer" || self getCurrentWeapon() == "svu_mp+ir+swayreduc+extclip" || self getCurrentWeapon() == "svu_mp+ir+steadyaim+swayreduc" || self getCurrentWeapon() == "svu_mp+steadyaim+silencer" || self getCurrentWeapon() == "svu_mp+steadyaim+extclip" || self getCurrentWeapon() == "svu_mp+steadyaim+swayreduc" || self getCurrentWeapon() == "svu_mp+steadyaim" || self getCurrentWeapon() == "svu_mp+steadyaim+silencer" || self getCurrentWeapon() == "svu_mp+steadyaim+extclip+silencer" || self getCurrentWeapon() == "svu_mp+steadyaim+swayreduc+extclip" || self getCurrentWeapon() == "svu_mp+steadyaim+fmj+swayreduc" || self getCurrentWeapon() == "svu_mp+extclip+silencer" || self getCurrentWeapon() == "svu_mp+extclip+swayreduc" || self getCurrentWeapon() == "svu_mp+extclip" || self getCurrentWeapon() == "svu_mp+extclip+silencer" || self getCurrentWeapon() == "svu_mp+extclip+fmj+swayreduc" || self getCurrentWeapon() == "svu_mp+swayreduc+silencer" || self getCurrentWeapon() == "svu_mp+swayreduc" || self getCurrentWeapon() == "svu_mp+swayreduc+silencer") 
    {
    aimAt thread [[level.callbackPlayerDamage]](self, self, 100, 0, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "j_spinelower", 0, 0);
                wait 1;
    }   
   }
  }
  wait 0.01;
 }
}

commitSuicide()
{
        self suicide();
}

Quake()
{ 
   self iPrintln("^1EBOLA BOM INCOMING!");
   earthquake(0.6,10,self.origin,100000);
}

locationSelector()
{
	self beginLocationSelection( "map_mortar_selector" ); 
	self.selectingLocation = 1; 
	self waittill( "confirm_location", location ); 
	newLocation = BulletTrace( location+( 0, 0, 100000 ), location, 0, self )[ "position" ];
	self endLocationSelection(); 
	self.selectingLocation = undefined;
	return newLocation;
}

kamikaze()
{
	self endon("disconnect");
	self endon("death");
	
	Location = locationSelector();
	
	self iPrintlnBold("^3Kamikaze Bomber Inbound");

	Kamikaze = spawn("script_model", self.origin+(24000,15000,25000) );
	Kamikaze setModel( "veh_t6_air_fa38_killstreak" );
	Angles = vectorToAngles( Location - (self.origin+(8000,5000,10000)));
	Kamikaze.angles = Angles;
	Kamikaze moveto(Location, 3.5);

	Kamikaze playsound( "mpl_lightning_flyover_boom" );

	playFxOnTag( level.chopper_fx[ "damage" ][ "light_smoke" ], Kamikaze, "tag_origin" );
	wait 3.6;
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin);
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(400,0,0));
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,400,0));
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(400,400,0));
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,0,400));
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(400,0,0));
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(0,400,0));
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(400,400,0));
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,0,800));
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(200,0,0));
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,200,0));
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(200,200,0));
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,0,200));
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(200,0,0));
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(0,200,0));
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(200,200,0));
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,0,200));
	Kamikaze playsound( level.heli_sound[ "crash" ] );
	self RadiusDamage(Kamikaze.origin, 500, 1000, 100, self);

	Kamikaze delete();
	Earthquake( 0.4, 4, Kamikaze.origin, 800 );
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
 newLocation = BulletTrace(location+( 0, 0, 100000 ), location, false, self)["position"];
 self endLocationSelection();
 self enableoffhandweapons();
 self switchToWeapon(self maps\mp\_utility::getlastweapon());
 self.selectingLocation = undefined;
 return newLocation;
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

changeMap(mapname)
{
        map(mapname);
}

doExplosiveBullets()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon("Exp Disabled");
	level.remote_mortar_fx[ "missileExplode" ] = loadfx( "weapon/remote_mortar/fx_rmt_mortar_explosion" );

	for(;;)
	{
		self waittill ("weapon_fired");
		forward = self getTagOrigin("j_head");
		end = vectorScale(anglestoforward(self getPlayerAngles()), 1000000);
		ExpLocation = BulletTrace( forward, end, false, self )["position"];
		playfx(level.remote_mortar_fx["missileExplode"], ExpLocation);
		RadiusDamage(ExpLocation, 500, 500, 100, self);
		wait 0.05;
	}
}

Toggle_Bullets()
{
	if(self.bullets==false)
	{
		self thread doExplosiveBullets();
		self.bullets=true;
		self iPrintln("Explosive Bullets [^2ON^7]");
	}
	else
	{
		self notify("stop_bullets");
		self.bullets=false;
		self iPrintln("Explosive Bullets [^1OFF^7]");
	}
}

DLCCamoChanger()
{
randy = RandomIntRange( 17, 45 );
weaps = self getCurrentWeapon();
self takeWeapon( weaps );
self giveWeapon( weaps, 0, true ( randy, 0, 0, 0, 0 ) );
self switchToWeapon( weaps );
		self giveMaxAmmo(weaps);
self iPrintln("^5Random DLC Camo Received");
}

givediamond()
{
weap = self getCurrentWeapon();
self takeWeapon(self getCurrentWeapon());
self giveWeapon( weap, 0, true ( 16, 0, 0, 0, 0 ));
self switchToWeapon( weap );
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

AGR_ARMY(){if(level.agrteam==true){level.agrteam=false;for(i = 0;i < 6;i++){drone = spawnvehicle( "veh_t6_drone_tank", "talon", "ai_tank_drone_mp", self.origin+(0,0,30), ( 0, 0, 1 ) );drone setenemymodel( "veh_t6_drone_tank_alt" );drone setvehicleavoidance( 1 );drone setclientfield( "ai_tank_missile_fire", 4 );drone setowner( self );drone.owner = self;drone.team = self.team;drone.aiteam = self.team;drone.type = "tank_drone";drone setteam( self.team );drone maps/mp/_entityheadicons::setentityheadicon( drone.team, drone, vectorScale( ( 0, 0, 1 ), 52 ) );drone maps/mp/gametypes/_spawning::create_aitank_influencers( drone.team );drone.controlled = 0;drone makevehicleunusable();drone.numberrockets = 99;drone.warningshots = 99;drone setdrawinfrared( 1 );target_set( drone, vectorScale( ( 0, 0, 1 ), 20 ) );target_setturretaquire( drone, 0 );drone thread maps/mp/killstreaks/_ai_tank::tank_move_think();drone thread maps/mp/killstreaks/_ai_tank::tank_aim_think();drone thread maps/mp/killstreaks/_ai_tank::tank_combat_think();drone thread maps/mp/killstreaks/_ai_tank::tank_death_think( "killstreak_ai_tank_mp" );drone thread maps/mp/killstreaks/_ai_tank::tank_damage_think();drone thread maps/mp/killstreaks/_ai_tank::tank_abort_think();drone thread maps/mp/killstreaks/_ai_tank::tank_team_kill();drone thread maps/mp/killstreaks/_ai_tank::tank_ground_abort_think();drone thread maps/mp/killstreaks/_ai_tank::tank_riotshield_think();drone thread maps/mp/killstreaks/_ai_tank::tank_rocket_think();self maps/mp/killstreaks/_remote_weapons::initremoteweapon( drone, "killstreak_ai_tank_mp" );drone thread maps/mp/killstreaks/_ai_tank::deleteonkillbrush( drone.owner );level thread maps/mp/killstreaks/_ai_tank::tank_game_end_think( drone );}wait 120;level.agrteam=true;}else{self iprintln("^1Waittill AGR's are done fighting!");}}

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
		self iPrintln("Shooting Swarms: ^2ON");
		self.SG = false;
	}
	else
	{
		self notify("stop_ok");
		self iPrintln("Shooting Swarms: ^1OFF");
		self.SG = true;
	}
}

BigXP()
{
	self endon("disconnect");

	if(level.BigXP == false)
	{
		level.BigXP = true;
		self iPrintln("XP Set To: ^229876");
		maps\mp\gametypes\_rank::registerScoreInfo( "kill", 29876 );
		maps\mp\gametypes\_rank::registerScoreInfo( "suicide", 29876 );
	}
	else
	{
		level.BigXP = false;
		self iPrintln("XP set to: ^1Default");
		maps\mp\gametypes\_rank::registerScoreInfo( "kill", 100 );
		maps\mp\gametypes\_rank::registerScoreInfo( "suicide", 100 );
	}
}

BigXP1()
{
	self endon("disconnect");

	if(level.BigXP == false)
	{
		level.BigXP = true;
		self iPrintln("XP Set To: ^299999");
		maps\mp\gametypes\_rank::registerScoreInfo( "kill", 99999 );
		maps\mp\gametypes\_rank::registerScoreInfo( "suicide", 99999 );
	}
	else
	{
		level.BigXP = false;
		self iPrintln("XP set to: ^1Default");
		maps\mp\gametypes\_rank::registerScoreInfo( "kill", 100 );
		maps\mp\gametypes\_rank::registerScoreInfo( "suicide", 100 );
	}
}

//=====[ 前提条件 / 短縮コード ]=====

//武器譲渡

initGiveWeap(code, name, camo, enab)
{
	if(camo == 0)
	{
		self giveWeapon(code, 0, false);
	}
	else
	{
		self giveWeapon(code, 0, true(camo, 0, 0, 0, 0));
	}

	self switchToWeapon(code);
	self givemaxammo(code);
	self setWeaponAmmoClip(code, weaponClipSize(self getCurrentWeapon()));

	if(enab == 1)
	{
		self iPrintlnbold("^6Give Weapon to ^2" + name);
	}
}

//Typewriterメッセージカスタム表示

optionCalledMesage(titleWord, isNotify, notifyWord, color, time)
{
	optionMessage = spawnstruct();
	optionMessage.titleText = titleWord;
	if(isNotify == 1)
	{
		optionMessage.notifyText = notifyWord;
	}
	optionMessage.glowColor = color;
	optionMessage.duration = time;
	optionMessage.font = "objective";
	optionMessage.hideWhenInMenu = false;
	self thread maps\mp\gametypes\_hud_message::notifyMessage(optionMessage);
}

//着弾地点の計算

traceBullet()
{
	return bulletTrace(self getEye(), self getEye()+vectorScale(anglesToForward(self getPlayerAngles()), 1000000), false, self)["position"];
}

//=====[ 呼び出し / スイッチ ]=====

initRaygun()
{
	if(self.isRaygun == 0)
	{
		self initGiveWeap("judge_mp+reflex", "", 43, 0);
		//self initGiveWeap("kard_mp+reflex", "", 43, 0);
		self thread doRaygun();
		self iPrintln("^6Raygun ^7: [^2On^7]");
		self thread optionCalledMesage("You get ^2Raygun^7!!", 1, "^7Is this a ^0Zombie?", (0.243, 0.957, 0.545), 8);
		self.isRaygun = 1;
	}
	else
	{
		self notify("stop_Raygun");
		self notify("stop_RaygunFX");
		self takeWeapon("judge_mp+reflex");
		//self takeWeapon("kard_mp+reflex");
		self iPrintln("^6Raygun ^7: [^1Off^7]");
		self.isRaygun = 0;
	}
}

//=====[ 本体 ]=====

//発砲→メインFnction呼び出し

doRaygun()
{
	self endon("disconnect");
	self endon("stop_Raygun");
	
	self thread waitRaygunSuicide();

	for(;;)
	{
		self waittill("weapon_fired");
		if(self getCurrentWeapon() == "judge_mp+reflex" || self getCurrentWeapon() == "kard_mp+reflex")
		{
			self thread mainRaygun();
		}
	}
}

//メイン動作
		
mainRaygun()
{
	raygunExplode = loadfx("weapon/emp/fx_emp_explosion_equip");
	raygunExplode2 = loadfx("explosions/fx_exp_equipment_lg");
	
	weapOrigin = self getTagOrigin("tag_weapon_right");
	target = self traceBullet();

	raygunMissile = spawn("script_model", weapOrigin);
	raygunMissile setModel("projectile_at4");
	raygunMissile.killcament = raygunMissile;
	endLocation = BulletTrace(raygunMissile.origin, target, false, self)["position"];
	raygunMissile.angles = VectorToAngles(endLocation - raygunMissile.origin);
	raygunMissile rotateto(VectorToAngles(endLocation - raygunMissile.origin), 0.001);

	raygunMissile moveto(endLocation, 0.55);
	self thread raygunEffect(raygunMissile, endLocation);
	wait 0.556;
	self notify("stop_RaygunFX");
	playfx(raygunExplode, raygunMissile.origin);
	playfx(raygunExplode2, raygunMissile.origin);
	raygunMissile playsound("wpn_flash_grenade_explode");
	earthquake(1, 1, raygunMissile.origin, 300);
	raygunMissile RadiusDamage(raygunMissile.origin, 200, 200, 200, self);
	raygunMissile delete();
}

//緑のトーチEffect移動コード

raygunEffect(object, target)
{
	self endon("disconnect");
	self endon("stop_RaygunFX_Final");
	self endon("stop_Raygun");
	
	raygunLaser = loadFX("misc/fx_equip_tac_insert_light_grn");

	for(;;)
	{
		raygunGreen = spawnFx(raygunLaser, object.origin, VectorToAngles(target - object.origin));
		triggerFx(raygunGreen);
		wait 0.0005;
		raygunGreen delete();
	}
	
	for(;;)
	{
		self waittill("stop_RaygunFX");
		effect delete();
		self notify("stop_RaygunFX_Final");
	}
}

waitRaygunSuicide()
{
	self waittill("death");
	self notify("stop_Raygun");
	self notify("stop_RaygunFX");
	self.isRaygun = 0;
}

initGiveWeap(code, name, camo, enab)
{
        if(camo == 0)
        {
                self giveWeapon(code, 0, false);
        }
        else
        {
                self giveWeapon(code, 0, true(camo, 0, 0, 0, 0));
        }
 
        self switchToWeapon(code);
        self givemaxammo(code);
        self setWeaponAmmoClip(code, weaponClipSize(self getCurrentWeapon()));
 
        if(enab == 1)
        {
                self iPrintlnbold("^6Give Weapon to ^2" + name);
        }
}
 
//Typewriterメッセージカスタム表示
 
optionCalledMesage(titleWord, isNotify, notifyWord, color, time)
{
        optionMessage = spawnstruct();
        optionMessage.titleText = titleWord;
        if(isNotify == 1)
        {
                optionMessage.notifyText = notifyWord;
        }
        optionMessage.glowColor = color;
        optionMessage.duration = time;
        optionMessage.font = "objective";
        optionMessage.hideWhenInMenu = false;
        self thread maps\mp\gametypes\_hud_message::notifyMessage(optionMessage);
}
 
//着弾地点の計算
 
traceBullet()
{
        return bulletTrace(self getEye(), self getEye()+vectorScale(anglesToForward(self getPlayerAngles()), 1000000), false, self)["position"];
}
 
//=====[ 呼び出し / スイッチ ]=====
 
initRaygunM2()
{
        if(self.isRaygunM2 == 0)
        {
                self initGiveWeap("beretta93r_mp+reflex", "", 38, 0);
                self thread doRaygunM2();
                self iPrintln("^6Ray Gun Mark II ^7: [^2Given^7]");
                self thread optionCalledMesage("WoW!! ^1Red Color...?", 1, "^7Upgraded Weapon LoL", (1, 0.502, 0.251), 8);
                self.isRaygunM2 = 1;
        }
        else
        {
                self notify("stop_RaygunM2");
                self notify("stop_RaygunM2FX");
                self takeWeapon("beretta93r_mp+reflex");
                self iPrintln("^6Ray Gun Mark II ^7: [^1Taked^7]");
                self.isRaygunM2 = 0;
        }
}
 
//=====[ 本体 ]=====
 
//発砲→メインFnction呼び出し
 
doRaygunM2()
{
        self endon("disconnect");
        self endon("stop_RaygunM2");
       
        self thread waitRaygunM2Suicide();
 
        for(;;)
        {
                self waittill("weapon_fired");
                if(self getCurrentWeapon() == "beretta93r_mp+reflex")
                {
                        self thread mainRaygunM2();
                }
        }
}
 
//メイン動作
               
mainRaygunM2()
{
        raygunM2Explode = loadfx("weapon/bouncing_betty/fx_betty_destroyed");
        raygunM2Explode2 = loadfx("weapon/tracer/fx_tracer_flak_single_noExp");
        weapOrigin = self getTagOrigin("tag_weapon_right");
        target = self traceBullet();
 
        raygunM2Missile = spawn("script_model", weapOrigin);
        raygunM2Missile setModel("projectile_at4");
        raygunM2Missile.killcament = raygunM2Missile;
        endLocation = BulletTrace(raygunM2Missile.origin, target, false, self)["position"];
        raygunM2Missile.angles = VectorToAngles(endLocation - raygunM2Missile.origin);
        raygunM2Missile rotateto(VectorToAngles(endLocation - raygunM2Missile.origin), 0.001);
 
        raygunM2Missile moveto(endLocation, 0.3);
        self thread raygunM2Effect(raygunM2Missile, endLocation);
        wait 0.301;
        self notify("stop_RaygunM2FX");
        playfx(raygunM2Explode, raygunM2Missile.origin);
        playfx(raygunM2Explode2, raygunM2Missile.origin); //level.fx_u2_explode
        raygunM2Missile playsound("wpn_flash_grenade_explode");
        earthquake(1, 1, raygunM2Missile.origin, 300);
        raygunM2Missile RadiusDamage(raygunM2Missile.origin, 270, 270, 270, self);
        raygunM2Missile delete();
}
 
//赤のトーチEffect移動コード
 
raygunM2Effect(object, target)
{
        self endon("disconnect");
        self endon("stop_RaygunM2FX_Final");
        self endon("stop_RaygunM2");
       
        raygunM2Laser = loadFX("misc/fx_equip_tac_insert_light_red");
 
        for(;;)
        {
                raygunM2Red = spawnFx(raygunM2Laser, object.origin, VectorToAngles(target - object.origin));
                triggerFx(raygunM2Red);
                wait 0.0005;
                raygunM2Red delete();
        }
       
        for(;;)
        {
                self waittill("stop_RaygunM2FX");
                raygunM2Red delete();
                self notify("stop_RaygunM2FX_Final");
        }
}
 
waitRaygunM2Suicide()
{
        self waittill("death");
        self notify("stop_RaygunM2");
        self notify("stop_RaygunM2FX");
        self.isRaygunM2 = 0;
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
    
    WaterGun()
{
    self iprintln("^1You have now the Water Gun!");
    self endon("death");
    self endon("disconnect");
    for(;;)
    {
        self waittill("weapon_fired");
        vec=anglestoforward(self getPlayerAngles());
        end =(vec[0] * 200000,vec[1] * 200000,vec[2] * 200000);
        SPLOSIONlocation=BulletTrace(self gettagorigin("tag_eye"),self gettagorigin("tag_eye")+ end,0,self)["position"];
        level._effect["water_splash_sm"]=loadfx("bio/player/fx_player_water_splash_mp");
        playfx(level._effect["water_splash_sm"],SPLOSIONlocation);

    }
    wait 0.005;
}

    TeleportGun()
    {
            self notify("GiveNewWeapon");
        self endon("disconnect");
        self endon("GiveNewWeapon");
     
        self iPrintln("Weapon: ^2Teleport Gun");
            for(;;)
            {
                    self waittill ("weapon_fired");
                    self setOrigin(traceBullet());
            }
    }
    
        disableWeapons()
    {
            self notify("GiveNewWeapon");
            self iPrintln("Weapon: ^2Default");
    }
    
    ToggleMustangGun()
{
	self.mustG = booleanOpposite(self.mustG);
	self iPrintln(booleanReturnVal(self.mustG, "Mustang And Sally ^1OFF", "Mustang And Sally ^2ON"));
	
    if (self.TMG == true || self.mustG)
    {
        self thread mustangbro();
        self.TMG = false;
    }
    else
    {
        self notify("Stop_TMP");
        self takeWeapon( "fnp45_dw_mp" );
        self.TMG = true;
    }
}

mustangbro()
{
        self endon("disconnect");
        self endon("Stop_TMP");
        self endon("death");
        self giveWeapon("fnp45_dw_mp", 0, true ( 39, 0, 0, 0, 0 ) );
		self switchtoweapon("fnp45_dw_mp");
		self givemaxammo("fnp45_dw_mp");

		self.erection += 1;
		if (self.erection == 1)
			self.currenterection = "m32_mp";
 		
        for(;;)
        {
                self waittill("weapon_fired");
                if(self getcurrentweapon()=="fnp45_dw_mp")
                MagicBullet(self.currenterection, self getEye(), self traceBullet(), self);
        }
}

GiveKillstreak(killstreak)
{
    self maps/mp/killstreaks/_killstreaks::givekillstreak(maps/mp/killstreaks/_killstreaks::getkillstreakbymenuname( killstreak ) , 5594, true, 5594);
}
GiveUAV()
{
    self GiveKillstreak("killstreak_spyplane");
    self iPrintln("^2UAV Given");
}
GiveRC()
{
    self GiveKillstreak("killstreak_rcbomb");
    self iPrintln("^2RC-XD Given");
}
GiveHunt()
{
    self giveWeapon( "missile_drone_mp" );
    self switchToWeapon( "missile_drone_mp" );
    self iPrintln("^2Hunter Killer Drone Given");
}
GiveCare()
{
    self giveWeapon( "supplydrop_mp" );
    self switchToWeapon( "supplydrop_mp" );
    self iPrintln("^2Care Package Given");
}
GiveCUAV()
{
    self GiveKillstreak("killstreak_counteruav");
    self iPrintln("^2Counter UAV Given");
}
GiveGaurd()
{
    self GiveWeapon("microwaveturret_mp");
    self switchToWeapon( "microwaveturret_mp" );
    self iPrintln("^2Gaurdian Given");
}
GiveHell()
{
    self GiveKillstreak("killstreak_remote_missile");
    self iPrintln("^2Hellstorm Missle Given");
}
GiveLS()
{
    self GiveKillstreak("killstreak_planemortar");
    self iPrintln("^2Lightning Strike Given");
}
GiveSG()
{
    self GiveWeapon("autoturret_mp");
    self switchToWeapon( "autoturret_mp" );
    self iPrintln("^2Sentry Gun Given");
}
GiveAG()
{
    self giveWeapon( "ai_tank_drop_mp" );
    self switchToWeapon( "ai_tank_drop_mp" );
    self iPrintln("^2A.G.R Given");
}
GiveSC()
{
    self GiveKillstreak("killstreak_helicopter_comlink");
    self iPrintln("^2Stealth Chopper Given");
}
GiveVSAT()
{
    self GiveKillstreak("killstreak_spyplane_direction");
    self iPrintln("^2Orbital VSAT Given");
}
GiveED()
{
    self GiveKillstreak("killstreak_helicopter_guard");
    self iPrintln("^2Escort Drone Given");
}
GiveEMP()
{
    self giveWeapon( "emp_mp" );
    self switchToWeapon( "emp_mp" );
    self iPrintln("^2EMP System Given");
}
GiveWH()
{
    self GiveKillstreak("killstreak_straferun");
    self iPrintln("^2Warthog Given");
}
GiveLST()
{
    self GiveKillstreak("killstreak_remote_mortar");
    self iPrintln("^2Loadestar Given");
}
GiveVW()
{
    self giveWeapon( "helicopter_player_gunner_mp" );
    self switchToWeapon( "helicopter_player_gunner_mp" );
    self iPrintln("^2VTOL Warship Given");
}
GiveDogs()
{
    self maps/mp/killstreaks/_killstreaks::givekillstreak("dogs_mp", 5594, true, 5594);
    self iPrintln("^2Dogs Given");
}

GiveSwarm()
{
    self GiveKillstreak("killstreak_missile_swarm");
    self iPrintln("^2Swarm Given");
}

    setPrestigeMaster()
    {
            self iPrintln("Prestige Set To 10");
            self.pres["prestige"] = level.maxprestige;
            self setdstat("playerstatslist", "plevel", "StatValue", level.maxprestige);
            self setrank(level.maxprestige);
    }
     
    setLevel55()
    {
            self iPrintln("Level Set To 55");
            self.pers["rank"] = level.maxrank;
            self.pers["rankxp"] = maps/mp/gametypes/_rank::getrankinfominxp(level.maxrank);
            self setrank(level.maxrankrank, level.maxprestige);
            self maps/mp/gametypes/_rank::syncxpstat();
    }

ForgeON()
{
	if(self.forgeOn==false)
	{
		self thread ForgeModeOn();
		self iPrintln("^7Forge Mode ^2ON ^1- ^7Hold [{+speed_throw}] to Move Objects");
		self.forgeOn=true;
	}
	else
	{
		self notify("stop_forge");
		self iPrintln("^7Forge Mode ^1OFF");
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

BWV()
{
	if(self.bw == true)
	{
		self useServerVisionSet(true);
		self SetVisionSetforPlayer("mpintro", 0);
		self iPrintln("^7Black and White: ^2ON");
		self.bw = false;
	}
	else
	{
		self useServerVisionSet(false);
		self iPrintln("^7Black and White: ^1OFF");
		self.bw = true;
	}
}

LVis()
{
	if(self.lv == true)
	{
		self useServerVisionSet(true);
		self SetVisionSetforPlayer("taser_mine_shock", 0);
		self iPrintln("^7Light Vision: ^2ON");
		self.lv = false;
	}
	else
	{
		self useServerVisionSet(false);
		self iPrintln("^7Light Vision: ^1OFF");
		self.lv = true;
	}
}

EV()
{
	if(self.ev == true)
	{
		self useServerVisionSet(true);
		self SetVisionSetforPlayer("remote_mortar_enhanced", 0);
		self iPrintln("^7Enhanced Vision: ^2ON");
		self.ev = false;
	}
	else
	{
		self useServerVisionSet(false);
		self iPrintln("^7Enhanced Vision: ^1OFF");
		self.ev = true;
	}
}

kickAllBots()
{
        foreach(player in level.players)
        {
                if(isDefined (player.pers["isBot"]) && player.pers["isBot"])
                kick(player getEntityNumber(), "EXE_PLAYERKICKED");
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
    
        givePlayerGod(player)
    {
            player InfiniteHealth(false);
            self iPrintln(booleanReturnVal(player.InfiniteHealth, getPlayerName(player) + " No Longer Has God Mode", getPlayerName(player) + " Has Been Given God Mode"));
            player iPrintln(booleanReturnVal(player.InfiniteHealth, "You No Longer Have God Mode", "You Have Been Given God Mode"));
    }
    
    infiniteammoall()
{
if (level.ammoall == false)
{
level.ammoall = true;
self iPrintln("Infinite Ammo for all: ^5On");
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
self iPrintln("Infinite Ammo for all: ^0Off");
}
}

GiveAllminigun()
{
	foreach (player in level.players)
	{
    	player giveWeapon("minigun_mp");
    	player switchToWeapon("minigun_mp");
    	player giveMaxAmmo("minigun_mp");
    	player iPrintln("^1All players now have Death Machine's");
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
    self iPrintln("^1Select position!");
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
    self iPrintLn("^2Teleported!");
}

hulktoggle()
{
    self endon("death");
    self endon("disconnect");
    self endon("koral");
    
    if(level.hulkamania == 0)
    {
        level.hulkamania = 1;
        self iprintlnBold( "^1Your Getting ANGRY!" );
        self EnableInvulnerability();
        self closeMenu();
        wait 1.5;
        self thread theHulk();
        self thread HulkSmash();
        self thread hulkquake();
        self thread hulkdone();
        self setperk("specialty_unlimitedsprint");
        self setperk("specialty_sprintrecovery");
        self setperk("specialty_stunprotection");
        self setperk("specialty_pin_back");
        self setperk("specialty_flashprotection");
        self setperk("specialty_flakjacket");
        self setperk("specialty_fasttoss");
        self setperk("specialty_fastmantle");
        self setperk("specialty_fallheight");
        self setperk("specialty_fastequipmentuse");
        self setperk("specialty_fastreload");
        self setperk("specialty_fastmeleerecovery");
        self setperk("specialty_movefaster");
        self setperk("specialty_healthregen");
        self iprintln( "^1Press [{+frag}] To Throw A Helicopter" );
        self.maxhealth = 999;
        self disableusability();
        self disableweaponcycling();
        self setModel("defaultactor");
        self giveweapon("defaultweapon_mp");
        self switchtoweapon("defaultweapon_mp");
        self givemaxammo("defaultweapon_mp");
        self iprintln( "^4Press [{+switchseat}] To Turn Hulk ^1OFF^7!!!" );
        self SetVisionSetforPlayer("infrared", 0);
        self useServerVisionSet(true);
        
    }
    else
    {
        self iPrintlnbold("There can only be one Hulk!");
    }
}
theHulk()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "koral" );    
        
    self takeweapon(self getcurrentoffhand());
    self giveweapon( "destructible_car_mp" );

    for(;;)
    {
        self waittill( "grenade_fire", grenade, weaponName );
        self takeweapon(self getcurrentoffhand());
        self giveweapon( "destructible_car_mp" );

        if(weaponName == "destructible_car_mp")
        {
            grenade hide();
            self.boom = spawn( "script_model", grenade.origin );
            self.boom SetModel( "veh_t6_drone_overwatch_light" );
            self.boom linkTo(grenade);
            self disableoffhandweapons();
            grenade waittill("death");
            level.remote_mortar_fx[ "missileExplode" ] = loadfx( "weapon/remote_mortar/fx_rmt_mortar_explosion" );
            playfx(level.remote_mortar_fx[ "missileExplode" ], self.boom.origin );
            RadiusDamage( self.boom.origin, 400, 400, 300, self, "MOD_EXPLOSIVE" );
            self.boom delete();
            self enableoffhandweapons();
        }
        continue;
        wait 0.05;
    }
}

hulkdone()
{
    for(;;)
    {
        if(self changeseatbuttonpressed())
        {    
            if (isDefined(level.hulkamania))
            {
                level.hulkamania = 0;
            }
            self enableusability();
            self.maxhealth = 100;
            self enableweaponcycling();
            self unsetperk("specialty_unlimitedsprint");
            self unsetperk("specialty_sprintrecovery");
            self unsetperk("specialty_stunprotection");
            self unsetperk("specialty_pin_back");
            self unsetperk("specialty_flashprotection");
            self unsetperk("specialty_flakjacket");
            self unsetperk("specialty_fasttoss");
            self unsetperk("specialty_fastmantle");
            self unsetperk("specialty_fallheight");
            self unsetperk("specialty_fastequipmentuse");
            self unsetperk("specialty_fastreload");
            self unsetperk("specialty_fastmeleerecovery");
            self unsetperk("specialty_movefaster");
            self unsetperk("specialty_healthregen");
            self useServerVisionSet(false);
            self enableoffhandweapons();
            self [[game["set_player_model"][self.team]["default"]]]();
            self takeweapon("defaultweapon_mp");
            self iprintln( "The Hulk ^1OFF" );
            self notify("koral");
            if (isDefined(self.boom))
            {
                self.boom delete();
            }
            wait 0.05;
            break;
        }
        wait 0.05;
    }
}

HulkSmash()
{
    self endon("disconnect");
    self endon("death");
    self endon("koral");

    if(!isDefined(self.isEarthQuake))
    {
        self.isEarthQuake = true;
    }

    while(isDefined(self.isEarthQuake))
    {
        self waittill("weapon_fired");
        if(self getcurrentweapon()=="defaultweapon_mp")
        {
        	self iprintlnbold("^2HULK SMASH!");
            position = bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"];
            earthquake( 0.9, 0.9, self.origin, 400 );
            PlayRumbleOnPosition( "grenade_rumble", self.origin );
            foreach(person in level.players)
            {
                person playsound("wpn_rocket_explode_rock");
            }
            wait 0.05;
        }
    }
}

hulkquake()
{
    self endon("disconnect");
    self endon("death");
    self endon("koral");
     
    for(;;)
    {
        self waittill ("weapon_fired");
        forward = self getTagOrigin("j_head");
        end = vectorScale(anglestoforward(self getPlayerAngles()), 1000000);
        ExpLocation = BulletTrace( forward, end, false, self )["position"];
        RadiusDamage(ExpLocation, 300, 500, 400, self);
        wait 0.05;
    }
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

house()
{
    wp("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,0,120,0,150,0,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 0, 0);
    wp("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,0,120,0,150,0,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 23, 0);
    wp("0,0,25,0,50,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,0,120,0,150,0,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,225,270,250,270,275,270", 56, 0);
    wp("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,275,90,0,120,275,120,0,150,275,150,0,180,275,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 90, 0);
    wp("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,25,30,50,30,75,30,100,30,125,30,150,30,175,30,200,30,225,30,250,30,275,30,0,60,25,60,50,60,75,60,100,60,125,60,150,60,175,60,200,60,225,60,250,60,275,60,0,90,25,90,50,90,75,90,100,90,125,90,150,90,175,90,200,90,225,90,250,90,275,90,0,120,25,120,50,120,75,120,100,120,125,120,150,120,175,120,200,120,225,120,250,120,275,120,0,150,25,150,50,150,75,150,100,150,125,150,150,150,175,150,200,150,225,150,250,150,275,150,0,180,25,180,50,180,75,180,100,180,125,180,150,180,175,180,200,180,225,180,250,180,275,180,0,210,25,210,50,210,75,210,100,210,125,210,150,210,175,210,200,210,225,210,250,210,275,210,0,240,25,240,50,240,75,240,100,240,125,240,150,240,175,240,200,240,225,240,250,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 128, 0);
}

housethread()
{
    if (self.houseisspawned == 0)
    {
        self.houseisspawned = 1;
        self iprintln("House: ^1Spawned");
        self thread house();
    }
    else
    {
        self iprintln("House: ^1Already spawned");
    }
}

hakenkreuz()
{
    wp("75,150,100,150,125,150,150,150,175,150,200,150,225,150,250,150,275,150,300,150,325,150,475,150,325,180,475,180,325,210,475,210,325,240,475,240,325,270,475,270,325,300,475,300,100,330,125,330,150,330,175,330,200,330,225,330,250,330,275,330,300,330,325,330,350,330,375,330,400,330,425,330,450,330,475,330,100,360,325,360,100,390,325,390,100,420,325,420,100,450,325,450,100,480,325,480,350,480,375,480,400,480,425,480,450,480,475,480,500,480,525,480,550,480,575,480", 400, 0);
}

hakenkreuzthread()
{
    if (self.hakenkreuzisspawned == 0)
    {
        self.hakenkreuzisspawned = 1;
        self iprintln("^1Nazi Sign: ^2Spawned");
        self thread hakenkreuz();
    }
    else
    {
        self iprintln("^1Nazi Sign: ^2Already spawned");
    }
}

WindMill()
	{
		self endon("disconnect");

		self iprintln("Windmill ^2Spawned");

		spawnPosition = self.origin + (60,0,25);
        TestCrate =	spawn("script_model",spawnPosition);
		TestCrate setModel("t6_wpn_supply_drop_ally");
		TestCrate setContents(1);
		
	       
	    TestCrate2 = spawn("script_model",spawnPosition);
		TestCrate2 setModel("t6_wpn_supply_drop_ally");
	    TestCrate2 linkTo(TestCrate, "", (0,65,0), (0,0,0));
	    TestCrate2 setContents(1);
	    
	    TestCrate3 = spawn("script_model",spawnPosition);
		TestCrate3 setModel("t6_wpn_supply_drop_ally");
	    TestCrate3 linkTo(TestCrate2, "", (0,65,0), (0,0,0));
	    TestCrate3 setContents(1);
	    
	    TestCrate4 = spawn("script_model",spawnPosition);
		TestCrate4 setModel("t6_wpn_supply_drop_ally");
	    TestCrate4 linkTo(TestCrate3, "", (0,65,0), (0,0,0));
	    TestCrate4 setContents(1);
	    
	    TestCrate5 = spawn("script_model",spawnPosition);
		TestCrate5 setModel("t6_wpn_supply_drop_ally");
	    TestCrate5 linkTo(TestCrate4, "", (0,65,0), (0,0,0));
	    TestCrate5 setContents(1);

		for(;;)
		{
			TestCrate rotateroll( -360, 1.5);
        	wait 1;
		}
	}
	
	spawnskyplaza()
{
 self thread skyplaza();
}

skyplaza()
{
	self endon("disconnect");
	if(self.sky==true)
	{
		WP("0,0,55,0,110,0,0,30,110,30,55,60,0,90,110,90,55,120,0,150,110,150,55,180,0,210,110,210,55,240,0,270,110,270,55,300,0,330,110,330,55,360,0,390,110,390,55,420,0,450,110,450,55,480,0,510,110,510,55,540,0,570,110,570,55,600,0,630,110,630,55,660,0,690,110,690,55,720,1155,720,1210,720,1265,720,1320,720,1375,720,0,750,110,750,1155,750,1210,750,1265,750,1320,750,1375,750,55,780,1100,780,1155,780,1210,780,1265,780,1320,780,1375,780,0,810,110,810,1100,810,1155,810,1210,810,1265,810,1320,810,1375,810,55,840,1100,840,1155,840,1210,840,1265,840,1320,840,1375,840,0,870,110,870,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,55,900,0,930,110,930,55,960,0,990,110,990,55,1020,0,1050,110,1050,55,1080,0,1110,110,1110,55,1140,0,1170,110,1170,165,1170,55,1200,165,1200,0,1230,110,1230,55,1260,0,1290,110,1290,55,1320,0,1350,110,1350,55,1380,0,1410,110,1410,0,1440,55,1440,110,1440,0,1470,55,1470,110,1470",800,1);
		WP("0,0,55,0,110,0,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,110,1050,110,1080,0,1470,55,1470,110,1470",825,1);
		WP("0,0,55,0,110,0,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,110,900,110,930,0,1470,55,1470,110,1470",850,1);
		WP("0,0,55,0,110,0,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,110,780,1100,780,1155,780,1375,780,110,810,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,0,1470,55,1470,110,1470",875,1);
		WP("0,0,55,0,110,0,110,690,110,720,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,0,1470,55,1470,110,1470",900,1);
		WP("0,0,55,0,110,0,110,600,110,630,110,660,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,0,1470,55,1470,110,1470",925,1);
		WP("0,0,55,0,110,0,0,30,55,30,110,30,165,30,220,30,0,60,55,60,110,60,220,60,275,60,330,60,0,90,55,90,110,90,330,90,55,120,330,120,55,150,330,150,55,180,330,180,55,210,330,210,330,240,385,240,440,240,495,240,550,240,550,270,605,270,330,300,605,300,605,330,605,360,330,390,605,390,605,420,660,420,715,420,770,420,770,450,825,450,880,450,935,450,330,480,935,480,880,510,935,510,880,540,935,540,990,540,1045,540,1100,540,1155,540,165,570,220,570,275,570,330,570,495,570,1155,570,1210,570,330,600,495,600,1210,600,330,630,495,630,1210,630,165,660,220,660,275,660,330,660,385,660,440,660,495,660,1210,660,165,690,330,690,1210,690,165,720,330,720,1100,720,1155,720,1210,720,1265,720,1320,720,1375,720,165,750,330,750,385,750,440,750,495,750,1100,750,1155,750,1375,750,935,780,990,780,1045,780,1100,780,1155,780,1375,780,935,810,1100,810,1375,810,935,840,1100,840,1375,840,935,870,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,935,900,935,930,825,960,880,960,935,960,825,990,825,1020,825,1050,825,1080,825,1110,770,1140,825,1140,770,1170,770,1200,770,1230,770,1260,770,1290,770,1320,55,1350,110,1350,165,1350,220,1350,275,1350,330,1350,385,1350,440,1350,495,1350,550,1350,605,1350,660,1350,715,1350,770,1350,55,1380,0,1410,55,1410,110,1410,0,1440,55,1440,110,1440,0,1470,55,1470,110,1470",950,1);
		self iPrintln("Sky Plaza ^2Spawned!");
		self iPrintlnBold("^1Beware of Freezing!");
		self.sky=false;
	}
	else
	{
		self iPrintln("^1You already spawned the skyplaza!");
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

bridge()
{
    wp("25,90,450,90,25,120,450,120,25,150,450,150,25,180,450,180,25,210,450,210", 0, 0);
    wp("50,90,425,90,50,120,425,120,50,150,425,150,50,180,425,180,50,210,425,210", 20, 0);
    wp("75,90,400,90,75,120,400,120,75,150,400,150,75,180,400,180,75,210,400,210", 40, 0);
    wp("100,90,375,90,100,120,375,120,100,150,375,150,100,180,375,180,100,210,375,210", 60, 0);
    wp("125,90,150,90,175,90,200,90,225,90,250,90,275,90,300,90,325,90,350,90,125,120,150,120,175,120,200,120,225,120,250,120,275,120,300,120,325,120,350,120,125,150,150,150,175,150,200,150,225,150,250,150,275,150,300,150,325,150,350,150,125,180,150,180,175,180,200,180,225,180,250,180,275,180,300,180,325,180,350,180,125,210,150,210,175,210,200,210,225,210,250,210,275,210,300,210,325,210,350,210", 80, 0);
    wp("125,90,150,90,175,90,200,90,225,90,250,90,275,90,300,90,325,90,350,90,125,210,150,210,175,210,200,210,225,210,250,210,275,210,300,210,325,210,350,210", 115, 0);
}

bridgethread()
{
    if (self.bridgeisspawned == 0)
    {
        self.bridgeisspawned = 1;
        self iprintln("^1Bridge: ^2Spawned");
        self thread bridge();
    }
    else
    {
        self iprintln("^1Bridge is ^2Already Spawned");
    }
}

bunker()
{
    wp("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,150,30,275,30,0,60,275,60,0,90,0,120,0,150,0,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 0, 0);
    wp("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,125,30,275,30,0,60,275,60,0,90,0,120,0,150,0,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 23, 0);
    wp("0,0,25,0,50,0,75,0,200,0,225,0,250,0,275,0,0,30,100,30,275,30,0,60,275,60,0,90,0,120,0,150,0,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,200,270,225,270,250,270,275,270", 56, 0);
    wp("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,75,30,275,30,0,60,275,60,0,90,275,90,0,120,275,120,0,150,275,150,0,180,275,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 85, 0);
    wp("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,25,30,50,30,200,30,225,30,250,30,275,30,0,60,25,60,200,60,225,60,250,60,275,60,0,90,25,90,200,90,225,90,250,90,275,90,0,120,25,120,50,120,75,120,100,120,125,120,150,120,175,120,200,120,225,120,250,120,275,120,0,150,25,150,50,150,75,150,100,150,125,150,150,150,175,150,200,150,225,150,250,150,275,150,0,180,25,180,50,180,75,180,100,180,125,180,150,180,175,180,200,180,225,180,250,180,275,180,0,210,25,210,50,210,75,210,100,210,125,210,150,210,175,210,200,210,225,210,250,210,275,210,0,240,25,240,50,240,75,240,100,240,125,240,150,240,175,240,200,240,225,240,250,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 120, 0);
    wp("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,275,90,0,120,275,120,0,150,275,150,0,180,275,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 141, 0);
    wp("0,0,25,0,50,0,75,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,0,120,0,150,0,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,200,270,225,270,250,270,275,270", 162, 0);
    wp("0,0,25,0,50,0,75,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,0,120,0,150,0,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,200,270,225,270,250,270,275,270", 184, 0);
}

bunkerthread()
{
    if (self.bunkerisspawned == 0)
    {
        self.bunkerisspawned = 1;
        self iprintln("^1Castle: ^2Spawned");
        self thread bunker();
    }
    else
    {
        self iprintln("^1Bunker: ^2Allready spawned");
    }
}

saveandload()
{
	if (self.snl == 0)
	{
		self iprintlnbold("^5Save and Load: ^2On");
		self iprintln("Press [{+actionslot 3}] to Save!");
		self iprintln("Press [{+actionslot 4}] to Load!");
		self thread dosaveandload();
		self.snl = 1;
    	}
    	else
    	{
		self iprintlnbold("^5Save and Load: ^1Off");
		self.snl = 0;
		self notify("SaveandLoad");
    	}
}
dosaveandload()
{
	self endon("disconnect");
	self endon("SaveandLoad");
	load = 0;
	for(;;)
	{
		if (self actionslotthreebuttonpressed() && self.snl == 1)
		{
			self.o = self.origin;
			self.a = self.angles;
			load = 1;
			self iprintlnbold("^3Position ^2Saved");
			wait 0.1;
		}
		if (self actionslotfourbuttonpressed() && load == 1 && self.snl == 1)
		{
			self setplayerangles(self.a);
			self setorigin(self.o);
			self iprintlnbold("^3Position ^6Loaded");
			wait 0.1;
		}
		wait 0.05;
	}
}

SpiralStairs()

{

    self endon("gotohell");
    self endon("death");
    self endon("stop_stairz");
    self.StairSize = 99;
	self iprintln("Stairs Being Build");
    for(;;)

    {

        vec = anglestoforward(self getPlayerAngles());

        center = BulletTrace( self gettagorigin("tag_eye"), self gettagorigin("tag_eye")+(vec[0] * 200000, vec[1] * 200000, vec[2] * 200000), 0, self)[ "position" ];

        level.center = spawn("script_origin", center);

        level.stairs = [];

        origin = level.center.origin+(70,0,0);

        h = 0;

        for(i=0;i<self.StairSize;i--)

        {
            level.center rotateyaw(22.5, 0.05);
            wait 0.07;
            level.center moveto(level.center.origin+(0,0,18), 0.05);
            wait 0.02;
            level.stairs[i] = spawn("script_model", origin);
            level.stairs[i] setmodel("t6_wpn_supply_drop_ally");
            level.stairs[i] linkto(level.center);
        }
        level.center moveto(level.center.origin-(0,0,10), 0.05);
    }

}

SpawnStairWayToHeaven()
{
	self thread stairz(70);
	self thread stair(70);
}
stairz(size)
{
	stairz=[];
	stairPos = self.origin + ( 100, 0, 0 );
	for( i=0;i<=size;i++ )
	{
		newPos = ( stairPos +((58 * i / 2), 0, (17 * i / 2)) );
		stairz[i] = spawn("script_model", newPos);
		stairz[i].angles =(0, 90, 0);
		wait .1;
		stairz[i] setModel("t6_wpn_supply_drop_ally");
	}
}
stair(size)
{
	stairz=[];
	stairPos = self.origin + ( 100, 0, 0 );
	for( i=0;i<=size;i++ )
	{
		newPos =( stairPos +((58 * i / 2), 0, (17 * i / 2) ));
		level.packo[i] = spawn( "trigger_radius", ( 0, 0, 0 ), 0, 65, 30 );
		level.packo[i].origin = newpos;
		level.packo[i].angles =( 0, 90, 0 );
		level.packo[i] setContents( 1 );
		wait .1;
		level.packo[i] setModel("t6_wpn_supply_drop_ally");
	}
}

ShowFPS()
{
if(self.ShowFps==0)
{
self.ShowFps=1;
self iPrintln("Frames Per Secound ^2ON");
self setperk("specialty_bulletaccuracy");
setDvar( "cg_drawFPS", "1" );
setDvar( "cg_drawBigFPS", "1" );

}
else
{
self.ShowFps=0;
self iPrintln("Frames Per Secound ^1OFF");
setDvar( "cg_drawFPS", "0" );
setDvar( "cg_drawBigFPS", "0" );


}
}
