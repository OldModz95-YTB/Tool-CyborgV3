#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_weapons;

//BO2 GSC Menu Base By Shark

init()
{
    precacheShader("line_horizontal");
    level.icontest = "line_horizontal";
    precacheModel( "projectile_hellfire_missile" );
    level._effect[ "flak20_fire_fx" ] = loadfx( "weapon/tracer/fx_tracer_flak_single_noExp" );
    level.vehicle_explosion_effect = loadfx( "explosions/fx_large_vehicle_explosion" );
    level thread onplayerconnect();
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
onplayerspawned()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    self.MenuInit = false;
    
    for(;;)
    {

        self waittill( "spawned_player" );
        self welcomeMessage();
        if( self.status == "Host" || self.status == "Co-Host" || self.status == "Admin" || self.status == "VIP" || self.status == "Verified")
        {
            if (!self.MenuInit)
            {
                self freezecontrols(false);
                self iPrintlnBold("^2Welcome to Redemption's ^4Easter ^6Update!");
                wait 0;
                self iPrintln("^5Redemption V1.8 Menu is ready! - Enjoy Crouch and [{+frag}] to open.");
                self.MenuInit = true;
                self thread MenuInit();
                self thread closeMenuOnDeath();
                self freezecontrols(false);
                self.menu.backgroundinfo = self drawShader(level.icontest, -400, -100, 1000, 1000, (0.04, 0.66, 0.89), 1, 0);
                self.menu.backgroundinfo.alpha = 0;
                self.infos = self createFontString( "objective", 2);
                self.infos setPoint( "LEFT", "LEFT", 180, -150 );
                self.infos setText("^7''Redemption ^4V.1.8''\n        ^3by ^6ProfoundModz");
                self.infos.alpha = 0;
                self.infos.foreground = true;
                self.infos.archived = false;
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
        self.menu.title = drawText("[" + verificationToColor(player.status) + "^7] " + getPlayerName(player), "objective", 2, 280, 30, (1, 1, 1), 0, (0, 0.58, 1), 1, 3);
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
    notifyData.titleText = "^1Welcome " + self.name + " To ^4Redemption ^3V1.8"; //Line 1
    notifyData.notifyText = "Your Status Is " + verificationToColor(self.status); //Line 2
    notifyData.glowColor = (0.04, 0.66, 0.89); //RGB Color array divided by 100
    notifyData.duration = 10; //Change Duration
    notifyData.font = "objective"; //font
    notifyData.hideWhenInMenu = false;
    self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
}

CreateMenu()
{
    self add_menu("Main Menu", undefined, "Unverified");
    self add_option("Main Menu", "Main Mods Menu", ::submenu, "SubMenu1", "Sub Menu 1");
    self add_option("Main Menu", "Fun Mods Menu", ::submenu, "SubMenu2", "Sub Menu 2");
    self add_option("Main Menu", "Weapons Menu", ::submenu, "SubMenu3", "Sub Menu 3");
    self add_option("Main Menu", "Bullets Menu", ::submenu, "SubMenu4", "Sub Menu 4");
    self add_option("Main Menu", "Killstreaks Menu", ::submenu, "SubMenu5", "Sub Menu 5");
    self add_option("Main Menu", "Killstreaks Menu 2", ::submenu, "SubMenu5s", "Sub Menu 5s");
    self add_option("Main Menu", "Game Settings Menu", ::submenu, "SubMenu6", "Sub Menu 6");
    self add_option("Main Menu", "Bots Spawn Menu", ::submenu, "SubMenu7", "Sub Menu 7");
    self add_option("Main Menu", "Aimbot Menu", ::submenu, "SubMenu8", "Sub Menu 8");
    self add_option("Main Menu", "Messages Menu", ::submenu, "SubMenu9", "Sub Menu 9");
    self add_option("Main Menu", "Host Menu", ::submenu, "SubMenu10", "Sub Menu 10");
    self add_option("Main Menu", "Themes Menu", ::submenu, "SubMenu11", "Sub Menu 11");
    self add_option("Main Menu", "Visions Menu", ::submenu, "SubMenu12", "Sub Menu 12");
    self add_option("Main Menu", "Model Menu", ::submenu, "SubMenu13", "Sub Menu 13");
    self add_option("Main Menu", "Players", ::submenu, "PlayersMenu", "Players");
    self add_option("Main Menu", "All Players", ::submenu, "SubMenu15", "Sub Menu 15");
    self add_option("Main Menu", "Account", ::submenu, "SubMenu16", "Sub Menu 16");
       
    self add_menu("SubMenu1", "Main Menu", "VIP");
    self add_option("SubMenu1", "God Mod", ::Toggle_God);
    self add_option("SubMenu1", "Unlimited Ammo", ::Toggle_unlimitedammo);
    self add_option("SubMenu1", "Clean Perks", ::clearkperkslel);
    self add_option("SubMenu1", "Teleport", ::doTeleport);
    self add_option("SubMenu1", "Clone Player", ::cloneyourself);
    self add_option("SubMenu1", "Change Class InGame", ::ChangeClass);
    self add_option("SubMenu1", "Speed X2", ::Toggle_SpeedX2);
    self add_option("SubMenu1", "Give Adv Uav", ::ToggleUAV2);
    self add_option("SubMenu1", "Force Host", ::forceHost);
    self add_option("SubMenu1", "Pro mod", ::ToggleFOV);
    self add_option("SubMenu1", "Third Person", ::ThirdPerson);
    self add_option("SubMenu1", "Gun Left Side", ::ToggleLeft);
    self add_option("SubMenu1", "Invisible", ::Toggle_Hideeeeee);
    self add_option("SubMenu1", "All Perks", ::doPerks);

    self add_menu("SubMenu2", "Main Menu", "VIP");
    self add_option("SubMenu2", "Unlock All Trophy", ::unlockAllCheevos);
    self add_option("SubMenu2", "Earthquake Mode", ::Quake);
    self add_option("SubMenu2", "Flashing feeds", ::FlashFeed2);
    self add_option("SubMenu2", "Crouch UFO Mode", ::UFOMode);
    self add_option("SubMenu2", "JetPack", ::doJetPack);
    self add_option("SubMenu2", "Shoot Real Carepackages", ::doCareMaker2);
    self add_option("SubMenu2", "Drivable Car", ::spawnDrivableCar);
    self add_option("SubMenu2", "Save and Loads", ::saveandload);
    self add_option("SubMenu2", "Walking Loadestar", ::walkingloadestar);

    self add_menu("SubMenu3", "Main Menu", "Verified");
    self add_option("SubMenu3", "Default Weapons", ::BG_GivePlayerWeapon, "defaultweapon_mp");
    self add_option("SubMenu3", "MP7", ::BG_GivePlayerWeapon, "mp7_mp");
    self add_option("SubMenu3", "Balista", ::BG_GivePlayerWeapon, "ballista_mp");
    self add_option("SubMenu3", "Dsr 50", ::BG_GivePlayerWeapon, "dsr50_mp");
    self add_option("SubMenu3", "Counter Strike Knife", ::BG_GivePlayerWeapon, "knife_mp");
    self add_option("SubMenu3", "AN94", ::BG_GivePlayerWeapon, "an94_mp");
    self add_option("SubMenu3", "Peacepeeker", ::BG_GivePlayerWeapon, "peacekeeper_mp");
    self add_option("SubMenu3", "Scar-h", ::BG_GivePlayerWeapon, "scar_mp");
    self add_option("SubMenu3", "Remington", ::BG_GivePlayerWeapon, "870mcs_mp");
    self add_option("SubMenu3", "Vector", ::BG_GivePlayerWeapon, "sf_vector_mp");
    self add_option("SubMenu3", "Skorpion", ::BG_GivePlayerWeapon, "evoskorpion_mp");
    self add_option("SubMenu3", "MSMC", ::BG_GivePlayerWeapon, "insas_mp");
    self add_option("SubMenu3", "Minigun", ::BG_GivePlayerWeapon, "minigun_mp");
    self add_option("SubMenu3", "Ballistic Knife", ::BG_GivePlayerWeapon, "knife_ballistic_mp");
    
    self add_menu("SubMenu4", "Main Menu", "VIP");
    self add_option("SubMenu4", "Explosive Bullets", ::Toggle_ExplosiveBullets);
    self add_option("SubMenu4", "Care Package Bullets", ::doCarePBullets);
    self add_option("SubMenu4", "Shoot swarms", ::ToggleSwarmGun);
    self add_option("SubMenu4", "Shoot Grenades", ::ToggleGGun);

    self add_menu("SubMenu5", "Main Menu", "Admin");
    self add_option("SubMenu5", "Give Spyplane", ::GiveUAV);
    self add_option("SubMenu5", "Give Rc Car", ::GiveRC);
    self add_option("SubMenu5", "Give Hunter-Killer", ::GiveHunt);
    self add_option("SubMenu5", "Give Care Pakage", ::GiveCare);
    self add_option("SubMenu5", "Give CounterUAV", ::GiveCUAV);
    self add_option("SubMenu5", "Give Microwave Turret", ::GiveGaurd);
    self add_option("SubMenu5", "Give Hellstorm", ::GiveHell);
    self add_option("SubMenu5", "Give Planemortar", ::GiveLS);
    self add_option("SubMenu5", "Give Sentry", ::GiveSG);
    self add_option("SubMenu5", "Give AGR", ::GiveAG);
    self add_option("SubMenu5", "Give Stealth Heli", ::GiveSC);
    
    self add_menu("SubMenu5s", "Main Menu", "Admin");
    self add_option("SubMenu5s", "Give V-Sat", ::GiveVSAT);
    self add_option("SubMenu5s", "Give Assult Heli", ::GiveED);
    self add_option("SubMenu5s", "Give EMP", ::GiveEMP);
    self add_option("SubMenu5s", "Give straferun", ::GiveWH);
    self add_option("SubMenu5s", "Give Loderstar", ::GiveLST);
    self add_option("SubMenu5s", "Give Warthog", ::GiveVW);
    self add_option("SubMenu5s", "Give Swarm", ::GiveSwarm);

    self add_menu("SubMenu6", "Main Menu", "Co-Host");
    self add_option("SubMenu6", "Super Speed", ::Speed);
    self add_option("SubMenu6", "Super Jump", ::ToggleSuperJump);
    self add_option("SubMenu6", "Toggle Timescales", ::Toggle_Timescales);
    self add_option("SubMenu6", "Anti-Quit", ::doAntiQuit);
    self add_option("SubMenu6", "Map Restart", ::MapRestartKidWhyAreULEeechinghm);
    self add_option("SubMenu6", "End Game", ::endGame);
    self add_option("SubMenu6", "Unlimited Game", ::Inf_Game);
    self add_option("SubMenu6", "Fast Restart", ::doRestart);
    self add_option("SubMenu6", "All to Crosshairs", ::teleToCrosshairs);
    
    self add_menu("SubMenu7", "Main Menu", "Co-Host");
    self add_option("SubMenu7", "Spawn 1 Bot", ::spawn1);
    self add_option("SubMenu7", "Spawn 3 Bots", ::spawn3);
    self add_option("SubMenu7", "Spawn 16 Bots", ::spawn18);
    
    self add_menu("SubMenu8", "Main Menu", "Co-Host");
    self add_option("SubMenu8", "(Unfair) Aimbot", ::doAimbots2);
    
    self add_menu("SubMenu9", "Main Menu", "Admin");
    self add_option("SubMenu9", "Welcome", ::typewritter, "^1Welcome To Redemption V1");
    self add_option("SubMenu9", "Creator Name", ::typewritter, "^2PROFOUND IS DA GOD <3");
    self add_option("SubMenu9", "Redemption <3<3<3", ::typewritter, "^3Redemption <3 <3 <3");
    self add_option("SubMenu9", "Penis Joke", ::penisjk);
    self add_option("SubMenu9", "Pussy Joke", ::pussyjk);
    self add_option("SubMenu9", "Admin $20", ::typewritter, "^6Admin: ^1$20 ^4PayPal");
    self add_option("SubMenu9", "Trickshots", ::typewritter, "^7Trickshots Only Or Derank");
    self add_option("SubMenu9", "Derank", ::typewritter, "^1You Got Deranked.");
    
    self add_menu("SubMenu10", "Main Menu", "Co-Host");
    self add_option("SubMenu10", "Kamikaze Bomber", ::kamikaze);
    self add_option("SubMenu10", "Forge Mode", ::ForgeMode);
    self add_option("SubMenu10", "Jericho Missile", ::initJericho);
    self add_option("SubMenu10", "DoHeart", ::doHeart);
    self add_option("SubMenu10", "StrafeRun", ::initStrafeRun);
    self add_option("SubMenu10", "Skywriter", ::skytext);
    self add_option("SubMenu10", "Teleport Everyone To Me", ::doallplayerstome);

    self add_menu("SubMenu11", "Main Menu", "Verified");
    self add_option("SubMenu11", "Red Theme", ::doRedtheme);
    self add_option("SubMenu11", "Blue Theme", ::dobluetheme);
    self add_option("SubMenu11", "Green Theme", ::doGreentheme);
    self add_option("SubMenu11", "Yellow Theme", ::doYellowtheme);
    self add_option("SubMenu11", "Pink Theme", ::doPinktheme);
    self add_option("SubMenu11", "Cyan Theme", ::doCyantheme);
    self add_option("SubMenu11", "Aqua Theme", ::doAquatheme);
    self add_option("SubMenu11", "Flashing Theme.", ::FlashingTheme);

    self add_menu("SubMenu12", "Main Menu", "Verified");
    self add_option("SubMenu12", "Black and White Vision", ::BWV);
    self add_option("SubMenu12", "Light Vision", ::LVis);
    self add_option("SubMenu12", "Enhanced Vision", ::EV);
    self add_option("SubMenu12", "EMP Vision", ::emp);
    self add_option("SubMenu12", "Theme Vision", ::doRedtheme);

    self add_menu("SubMenu13", "Main Menu", "Verified");
    self add_option("SubMenu13", "Crazy Dogs", ::ewwmodel, "german_shepherd_vest");
    self add_option("SubMenu13", "SuiteCase Bomb", ::ewwmodel, "prop_suitcase_bomb");//work
    self add_option("SubMenu13", "No Model", ::ewwmodel, "projectile_m203grenade");

    self add_menu("PlayersMenu", "Main Menu", "Co-Host");
    for (i = 0; i < 12; i++)
    { self add_menu("pOpt " + i, "PlayersMenu", "Co-Host"); }
    
    
    self add_menu("SubMenu15", "Main Menu", "Co-Host");
    self add_option("SubMenu15", "All to Crosshairs", ::teleToCrosshairs);
    
    self add_menu("SubMenu16", "Main Menu", "Co-Host");
    self add_option("SubMenu16", "Random Camo", ::CamoChanger);
    self add_option("SubMenu16", "Random DLC Camo", ::DLCCamoChanger);
    self add_option("SubMenu16", "Diamond Camo", ::givediamond);
    self add_option("SubMenu16", "Gold Camo", ::givegold);
    self add_option("subMenu16", "All Camos", :: doAllUnlockcamos);
   
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

updatePlayersMenu()
{
    self.menu.menucount["PlayersMenu"] = 0;
    for (i = 0; i < 12; i++)
    {
        player = level.players[i];
        playerName = getPlayerName(player);
        
        playersizefixed = level.players.size - 1;
        if(self.menu.curs["PlayersMenu"] > playersizefixed)
        { 
            self.menu.scrollerpos["PlayersMenu"] = playersizefixed;
            self.menu.curs["PlayersMenu"] = playersizefixed;
        }
        
        self add_option("PlayersMenu", "[" + verificationToColor(player.status) + "^7] " + playerName, ::submenu, "pOpt " + i, "[" + verificationToColor(player.status) + "^7] " + playerName);
    
       self add_menu_alt("pOpt " + i, "PlayersMenu");
            self add_option("pOpt " + i, "Give Co-Host", ::changeVerificationMenu, player, "Co-Host");
            self add_option("pOpt " + i, "Give Admin", ::changeVerificationMenu, player, "Admin");
            self add_option("pOpt " + i, "Give VIP", ::changeVerificationMenu, player, "VIP");
            self add_option("pOpt " + i, "Verify", ::changeVerificationMenu, player, "Verified");
            self add_option("pOpt " + i, "Unverify", ::changeVerificationMenu, player, "Unverified");
            self add_option("pOpt " + i, "Kill", ::killplayer, player);
            self add_option("pOpt " + i, "Kick", ::kickplayer, player);
            self add_option("pOpt " + i, "Freeze/Unfreeze", ::freezeplayer, player);
            self add_option("pOpt " + i, "Blind", ::blindplayer, player);
            self add_option("pOpt " + i, "Send to Space", ::sendtospace, player);
            self add_option("pOpt " + i, "Take All Weapons", ::takewepsfromplayer, player);
    }
}
doallplayerstome()
{
 self.me = self.origin;
 foreach(player in level.players)
 {
  if(!(player isHost()))
  {
   player SetOrigin(self.me);
  }
 }
 self iPrintln("All Players ^2Teleported");
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


elemMoveY(time, input)
{
    self moveOverTime(time);
    self.y = 69 + input;
}


updateScrollbar()
{
    self.menu.scroller moveOverTime(0.15);
    self.menu.scroller.y = 69 + (self.menu.curs[self.menu.currentmenu] * 20.36);
}

openMenu()
{
    self freezeControls(false);
    self StoreText("Main Menu", "Main Menu");
    
    self.menu.backgroundinfo FadeOverTime(0.3);
    self.menu.backgroundinfo.alpha = 1;

    self.menu.background FadeOverTime(0.3);
    self.menu.background.alpha = 0.40;

    self.infos FadeOverTime(0.3);
    self.infos.alpha = 1;

    self.menu.line MoveOverTime(0.15);
    self.menu.line.y = -50;



    self updateScrollbar();
    self.menu.open = true;
}

closeMenu()
{
    self.menu.options FadeOverTime(0.3);
    self.menu.options.alpha = 0;
    
    self.menu.background FadeOverTime(0.3);
    self.menu.background.alpha = 0;
    
    self.infos FadeOverTime(0.3);
    self.infos.alpha = 0;

    self.menu.title FadeOverTime(0.3);
    self.menu.title.alpha = 0;
    
    self.menu.line MoveOverTime(0.15);
    self.menu.line.y = -550;

    self.menu.backgroundinfo FadeOverTime(0.3);
    self.menu.backgroundinfo.alpha = 0;

    self.menu.scroller MoveOverTime(0.15);
    self.menu.scroller.y = -500;    
    self.menu.open = false;
}

destroyMenu(player)
{
    player.MenuInit = false;
    closeMenu();
    wait 0.3;

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
        self waittill("death");
        self.menu.closeondeath = true;
        self submenu("Main Menu", "Main Menu");
        closeMenu();
        self.menu.closeondeath = false;
    }
}

StoreShaders()
{
    self.menu.background = self drawShader("white", 200, -50, 300, 500, (0, 0, 0), 0, 0);
    self.menu.scroller = self drawShader("white", 200, -1000, 300, 17, (0.04, 0.66, 0.89), 256, 0);
    self.menu.line = self drawShader(level.icontest, -3000, -50, 700, 500, (0.04, 0.66, 0.89), 0, 0);
}

StoreText(menu, title)
{
    self.menu.currentmenu = menu;
    string = "";
    self.menu.title destroy();
    //self.menu.title = drawText(title, "objective", 2, -1000, 30, (-1, 1, 1), 0, (0, 0.58, 1), 1, 3);
    self.menu.title FadeOverTime(0.3);
    self.menu.title.alpha = 1;
    
    for(i = 0; i < self.menu.menuopt[menu].size; i++)
    { string += self.menu.menuopt[menu][i] + "\n"; }

    self.menu.options destroy(); 
    self.menu.options = drawText(string, "objective", 1.7, 140, 68, (1, 1, 1), 0, (0, 0, 0), 3, 257);
    self.menu.options FadeOverTime(0.3);
    self.menu.options.alpha = 1;
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
FlashingTheme()
{
    for(;;)
    {
    self endon ("stopflash");
    self.menu.line elemcolor(1, (1, 0, 0));
    self.menu.backgroundinfo elemcolor(1, (1, 0, 0));
    wait 1;
    self.menu.line elemcolor(1, (0, 0, 1));
    self.menu.backgroundinfo elemcolor(1, (0, 0, 1));
    wait 1;
    self.menu.line elemcolor(1, (0, 1, 0));
    self.menu.backgroundinfo elemcolor(1, (0, 1, 0));
    wait 1;
    self.menu.line elemcolor(1, (1, 1, 0));
    self.menu.backgroundinfo elemcolor(1, (1, 1, 0));
    wait 1;
    self.menu.line elemcolor(1, (1, 0, 1));
    self.menu.backgroundinfo elemcolor(1, (1, 0, 1));
    wait 1;
    self.menu.line elemcolor(1, (0, 1, 1));
    self.menu.backgroundinfo elemcolor(1, (0, 1, 1));
    wait 1;
    self.menu.line elemcolor(1, (0.04, 0.66, 0.89));
    self.menu.backgroundinfo elemcolor(1, (0.04, 0.66, 0.89));
    wait 1;
    }
}
CamoChanger()
{
	rand = RandomIntRange( 0, 45 );
	weap = self getCurrentWeapon();
	self takeWeapon( weap );
	self giveWeapon( weap, 0, true ( rand, 0, 0, 0, 0 ) );
	self switchToWeapon( weap );
	self giveMaxAmmo(weap);
	self iPrintln("^5Random Camo Received");
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

givegold()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 15, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}
elemcolor(time, color)
{
    self fadeovertime(time);
    self.color = color;
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
        if(self getStance()=="crouch" && self FragButtonPressed() && !self.menu.open) // Open.
        {
            openMenu();
        }
        if(self.menu.open)
        {
            if(self useButtonPressed())
            {
                if(isDefined(self.menu.previousmenu[self.menu.currentmenu]))
                {
                    self submenu(self.menu.previousmenu[self.menu.currentmenu]);
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

        if (input == "Main Menu")
        {
            self thread StoreText(input, "Main Menu");
            self updateScrollbar();
        }
        else if (input == "PlayersMenu")
        {
            self updatePlayersMenu();
            self thread StoreText(input, "Players");
            self updateScrollbar();
        }
        else
        {
            self thread StoreText(input, title);
            self updateScrollbar();
        }
            
        self.CurMenu = input;
        
        self.menu.scrollerpos[self.CurMenu] = self.menu.curs[self.CurMenu];
        self.menu.curs[input] = self.menu.scrollerpos[input];
        self updateScrollbar();

        if (!self.menu.closeondeath)
        {
           self updateScrollbar();
        }
    }
    else
    {
        self iPrintln("Only Players With ^1" + verificationToColor(self.menu.status[input]) + " ^7Can Access This Menu!");
    }
}

killplayer(player)
    {
    if (!player isHost() || self.name == player.name)
    {
    self iPrintln("Virgin killed!");
    player suicide();
    }
    }
     
    kickplayer(player)
    {
    if (!player isHost())
    {
    kick(player getEntityNumber());
    self iPrintln("That bitch was kicked");
    }
    }
     
    freezeplayer(player)
    {
    if (!player isHost() || self.name == player.name)
    {
    if (player.frozen == false)
    {
    self iPrintln("Frozen: " + player.name);
    player iPrintln("Freeze Motherfucker");
    player.frozen = true;
    player freezecontrols(true);
    player enableInvulnerability();
    }
    else
    {
    self iPrintln("Unfrozen: " + player.name);
    player iPrintln("Carry on");
    player.frozen = false;
    player freezecontrols(false);
    player disableInvulnerability();
    }
    }
    }
     
    blindplayer(player)
    {
    if (!player isHost())
    {
    if (player.isBlind == false)
    {
    player.isBlind = true;
    player.blackscreen = newclienthudelem( player );
    player.blackscreen.x = 0;
    player.blackscreen.y = 0;
    player.blackscreen.horzAlign = "fullscreen";
    player.blackscreen.vertAlign = "fullscreen";
    player.blackscreen.sort = 50;
    player.blackscreen SetShader( "black", 640, 480 );
    player.blackscreen.alpha = 1;
    self iPrintln("^2Blinded: " + player.name);
    }
    else
    {
    player.blackscreen destroy();
    player.blackscreen delete();
    player.isBlind = false;
    self iPrintln("^1Unblinded: ^2" + player.name);
    }
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
     
    takewepsfromplayer(player)
    {
    self iPrintln("Weapons were taken from this annoying bitch");
    if (!player isHost() || self.name == player.name)
    {
    player iPrintln("Stop fucking shooting");
    player takeallweapons();
    }
    }
     
    sayisgay(player)
    {
    foreach(player_inlevel in level.players)
    {
    player_inlevel thread maps\mp\gametypes\_hud_message::hintMessage("^2Everyone, I have an important announcement!");
    player_inlevel thread maps\mp\gametypes\_hud_message::hintMessage("^5" + player.name + " is fucking gay.");
    }
    }
ewwmodel(modelnigga)
{
    self setModel(modelnigga);
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
Thermal()
{
    if(self.Thermal == true)
    {
        self setinfraredvision(1);
        self SetVisionSetforPlayer("remote_mortar_enhanced", 0);
        self iPrintln("^7Thermal Vision : ^2ON");
        self.Thermal = false;
    }
    else
    {
        self setinfraredvision(0);
        self iPrintln("^7Thermal Vision : ^1OFF");
        self.Thermal = true;
    }
}
walkingLoadestar()
{
	self endon("death");
	self GiveKillstreak("killstreak_remote_mortar");
	self iprintln("^1Walking Lodestar Given... Enjoy");
	self.Fly = 0;
	UFO = spawn("script_model",self.origin);
	for(;;)
	{
	     if(self.Fly == 1)
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
  doMap(mapname)
    {
    map( mapname, true );
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
}// 3rd Person
emp()
{
    if(self.emp == true)
    {
        self setempjammed(1);
        self SetVisionSetforPlayer("remote_mortar_enhanced", 0);
        self iPrintln("^7EMP Vision : ^2ON");
        self.emp = false;
    }
    else
    {
        self setempjammed(0);
        self iPrintln("^7EMP Vision : ^1OFF");
        self.emp = true;
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
doRedtheme()
{
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (1, 0, 0));
    self.menu.backgroundinfo elemcolor(1, (1, 0, 0));
}
dobluetheme()
{
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (0, 0, 1));
    self.menu.backgroundinfo elemcolor(1, (0, 0, 1));
}
doGreentheme()
{
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (0, 1, 0));
    self.menu.backgroundinfo elemcolor(1, (0, 1, 0));
}
doYellowtheme()
{
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (1, 1, 0));
    self.menu.backgroundinfo elemcolor(1, (1, 1, 0));
}
doPinktheme()
{
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (1, 0, 1));
    self.menu.backgroundinfo elemcolor(1, (1, 0, 1));
}
doCyantheme()
{
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (0, 1, 1));
    self.menu.backgroundinfo elemcolor(1, (0, 1, 1));
}
doAquatheme()
{
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (0.04, 0.66, 0.89));
    self.menu.backgroundinfo elemcolor(1, (0.04, 0.66, 0.89));
}
FlashingTheme()
{
    self endon ("stopflash");
    self.menu.scroller elemcolor(1, (1, 0, 0));
    self.menu.backgroundinfo elemcolor(1, (1, 0, 0));
    wait 5;
    self.menu.scroller elemcolor(1, (0, 0, 1));
    self.menu.backgroundinfo elemcolor(1, (0, 0, 1));
    wait 5;
    self.menu.scroller elemcolor(1, (0, 1, 0));
    self.menu.backgroundinfo elemcolor(1, (0, 1, 0));
    wait 5;
    self.menu.scroller elemcolor(1, (1, 1, 0));
    self.menu.backgroundinfo elemcolor(1, (1, 1, 0));
    wait 5;
    self.menu.scroller elemcolor(1, (1, 0, 1));
    self.menu.backgroundinfo elemcolor(1, (1, 0, 1));
    wait 5;
    self.menu.scroller elemcolor(1, (0, 1, 1));
    self.menu.backgroundinfo elemcolor(1, (0, 1, 1));
    wait 5;
    self.menu.scroller elemcolor(1, (0.04, 0.66, 0.89));
    self.menu.backgroundinfo elemcolor(1, (0.04, 0.66, 0.89));
    wait 5;
    self thread FlashingTheme();
}
elemcolor(time, color)
{
    self fadeovertime(time);
    self.color = color;
}
skytext()
{
    foreach(player in level.players)
    player thread maps\mp\gametypes\_hud_message::hintMessage("^5Look at the Sky !");
    WP("675,360,700,360,725,360,750,360,775,360,875,360,900,360,925,360,950,360,1075,360,1100,360,1125,360,1150,360,1250,360,1275,360,1300,360,1325,360,1350,360,1475,360,1500,360,1525,360,1550,360,675,390,700,390,750,390,775,390,925,390,950,390,1125,390,1150,390,1275,390,1300,390,1325,390,1350,390,1525,390,1550,390,675,420,700,420,750,420,775,420,925,420,950,420,1075,420,1100,420,1125,420,1150,420,1300,420,1325,420,1475,420,1500,420,1525,420,1550,420,675,450,700,450,750,450,775,450,925,450,950,450,1125,450,1150,450,1275,450,1300,450,1325,450,1350,450,1525,450,1550,450,675,480,700,480,725,480,750,480,775,480,925,480,950,480,1075,480,1100,480,1125,480,1150,480,1275,480,1300,480,1325,480,1350,480,1475,480,1500,480,1525,480,1550,480",2000,0);
}
saveandload()
{
    if (self.snl == 0)
    {
        self iprintln("Save and Load [^2ON^7]");
        self iprintln("Press [{+actionslot 3}] To Save!");
        self iprintln("Press [{+actionslot 4}] To Load!");
        self thread dosaveandload();
        self.snl = 1;
    }
    else
    {
        self iprintln("Save and Load [^1OFF^7]");
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
        self iprintln("Position ^2Saved");
        wait 2;
    }
    if (self actionslotfourbuttonpressed() && load == 1 && self.snl == 1)
    {
        self setplayerangles(self.a);
        self setorigin(self.o);
        self iprintln("Position ^2Loaded");
        wait 2;
    }
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
doHeart()
{
        self.tez = self createFontString( "objective", 2.5);
        self.tez setPoint( "LEFT", "LEFT", -50, -100 );
        self.tez setText("^5ProfoundModz ^7Is ^6Boss");
        self.tez.alpha = 1;
        self.tez.foreground = true;
        self.tez.archived = false;
        self thread scale();
}

scale()
{
        self.tez.fontscale = 2.5;
        wait .05;
        self.tez.fontscale = 2.4;
        wait .05; 
        self.tez.fontscale = 2.3;
        wait .05;
        self.tez.fontscale = 2.2;
        wait .05;  
        self.tez.fontscale = 2.1;
        wait .05;
        self.tez.fontscale = 2.0;
        wait .05;  
        self.tez.fontscale = 2.1;
        wait .05;
        self.tez.fontscale = 2.2;
        wait .05; 
        self.tez.fontscale = 2.3;
        wait .05;
        self.tez.fontscale = 2.4;
        wait .05;   
        self thread scale();   
}
//self thread initJericho()
traceBullet()
{
    return bulletTrace(self getEye(), self getEye()+vectorScale(anglesToForward(self getPlayerAngles()), 1000000), false, self)["position"];
}

initJericho()
{
    level.waypointGreen = loadFX("misc/fx_equip_tac_insert_light_grn");
    level.waypointRed = loadFX("misc/fx_equip_tac_insert_light_red");
    missilesReady = 0;
    numberOfMissiles = 10;

    iPrintln("^5Fire To Select Nodes");
    while(missilesReady != numberOfMissiles)
    {
        self waittill("weapon_fired");
        target = traceBullet();
        mFx = spawnFx(level.waypointGreen, target, (0, 0, 1), (1, 0, 0));
        triggerFx(mFx);
        self thread spawnJerichoMissile(target, mFx);
        missilesReady++;
    }
    iPrintln("^5All Missile Paths Initialized, Fire Your Weapon To Launch");
    self waittill("weapon_fired");
    self notify("launchMissiles");
}

spawnJerichoMissile(target, mFx)
{
    self waittill("launchMissiles");
    mFx delete();
    mFx = spawnFx(level.waypointRed, target, (0, 0, 1), (1, 0, 0));
    triggerFx(mFx);

    location = target+(0, 3500, 5000);

    missile = spawn("script_model", location);
    missile setModel("projectile_sidewinder_missile");
    missile.angles = missile.angles+(90, 90, 90);
    missile.killcament = missile;
    missile rotateto(VectorToAngles(target - missile.origin), 0.01);
    wait 0.01;

    time = 3;
    endLocation = BulletTrace(missile.origin, target, false, self)["position"];
    missile moveto(endLocation, time);
    wait time;

    self playsound("wpn_rocket_explode");
    playFx(level.remote_mortar_fx["missileExplode"], missile.origin+(0, 0, 1));  
    RadiusDamage(missile.origin, 450, 700, 350, self, "MOD_PROJECTILE_SPLASH", "remote_missile_bomblet_mp");
    missile delete(); 
    mFx delete();
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
ForgeMode()
{
    self endon("disconnect");
    self endon("ForgeRekt");
    if(!isDefined(self.Forge)) self.Forge = false;
    self.Forge = !self.Forge;
    self iPrintln("Forge Mode - Enabled/Disable");
    self iPrintln("^2[{+actionslot 1}] to Spawn");
    self iPrintln("^2[{+actionslot 2}] to drop/pick");
    self iPrintln("^2[{+actionslot 4}] to delete");
    if(!self.Forge) self notify("ForgeRekt");
    else self thread MoveCrate();
    while(self.Forge)
    {
        if(self actionslotonebuttonpressed())
        {
            self SpawnCrate();
            self iprintln("SpawnCrate");
        }
        if(self actionslottwobuttonpressed())
        {
            if(isdefined(self.CurrentCrate))
            {
                self.CurrentCrate = undefined;
                self iprintln("Drop Crate");
            }
            else
            {
                self.CurrentCrate = self NormalisedTrace("entity");
                self iprintln("Pickup Crate");
            }
        }
        if(self actionslotfourbuttonpressed())
        {
            if(isdefined(self.CurrentCrate))
            {
                self.CurrentCrate delete();
                self.CurrentCrate = undefined;
            }
            else
            {
                self NormalisedTrace("entity") delete();
            }
            self iprintln("Delete Crate");
        }
        wait 0.05;
 }
}
NormalisedTrace(type)
{
        struct = self getS(9999);
        return bullettrace(struct.start, struct.end, false, undefined)[type];
}
getS(scale)
{
        forward = anglestoforward(self getplayerangles());
  struct = spawnstruct();
        struct.start = self geteye();
        struct.end = struct.start + vectorScale(forward, scale);
        return struct;
}
MoveCrate()
{
    self endon("disconnect");
 self endon("ForgeRekt");
    for(;;)
    {
        if(isdefined(self.CurrentCrate))
        {
            self.CurrentCrate.origin = self getS(100).end;
            self.CurrentCrate.angles = (0, self.angles[1], self.angles[2]);
        }
        wait 0.05;
    }
}
SpawnCrate()
{
    self.CurrentCrate = spawn("script_model", self NormalisedTrace("position"));
    self.CurrentCrate setmodel("t6_wpn_supply_drop_ally");
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
penisjk()
{
    foreach(player in level.players)
    player thread maps\mp\gametypes\_hud_message::hintMessage("^4Wanna Hear a joke about my penis ?");
    wait .5;
    player thread maps\mp\gametypes\_hud_message::hintMessage("^4Nvm, it's too long.");

}
pussyjk()
{
    foreach(player in level.players)
    player thread maps\mp\gametypes\_hud_message::hintMessage("^5Wanna Hear a joke about a pussy ?");
    wait .5;
    player thread maps\mp\gametypes\_hud_message::hintMessage("^5Nvm, You won't get it.");

}
typewritter(messagelel)
{
    foreach(player in level.players)
    player thread maps\mp\gametypes\_hud_message::hintMessage(messagelel);
}
doAimbots2()
{
    if(self.aim2==0)
    {
        self thread Aimbot();
        self.aim2=1;
        self iPrintln("Aimbot : ^2ON");
    }
    else
    {
        self notify("EndAutoAim2");
        self.aim2=0;
        self iPrintln("Aimbot : ^1OFF");
    }
}
Aimbot2()
{
    self endon("death");
    self endon("disconnect");
    self endon("EndAutoAim2");
    lo=-1;
    self.fire=0;
    self.PNum=0;
    self thread WeapFire();
    for(;;)
    {
        wait 0.01;
        if(self AdsButtonPressed())
        {
            for(i=0;i<level.players.size;i++)
            {
                if(getdvar("g_gametype")!="dm")
                {
                    if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("tag_eye"),0,self))lo=level.players[i] gettagorigin("tag_eye");
                    else if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("tag_eye"),0,self))lo=level.players[i] gettagorigin("j_ankle_ri");
                }
                else
                {
                    if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("tag_eye"),0,self))lo=level.players[i] gettagorigin("tag_eye");
                    else if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("tag_eye"),0,self))lo=level.players[i] gettagorigin("j_ankle_ri");
                }
            }
            if(lo!=-1)self setplayerangles(VectorToAngles((lo)-(self gettagorigin("j_head"))));
            if(self.fire==1)
            {
                MagicBullet(self getcurrentweapon(),lo+(0,0,10),lo,self);
            }
        }
        lo=-1;
    }
}
WeapFire()
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

doAimbots()
{
    if(self.aim==0)
    {
        self thread Aimbot();
        self.aim=1;
        self iPrintln("Aimbot : ^2ON");
    }
    else
    {
        self notify("EndAutoAim");
        self.aim=0;
        self iPrintln("Aimbot : ^1OFF");
    }
}
aimBot()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon("EndAutoAim");
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

spawn1()
{
    self thread Spawnbot();
    self iprintln("^2Bot Spawned");
}
spawn3()
{
    self thread Spawnbot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    self iprintln("^2Bots Spawned");
}
spawn18()
{
    self thread Spawnbot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread Spawnbot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread Spawnbot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread Spawnbot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread Spawnbot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread Spawnbot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    self iprintln("^2Bots Spawned");
}
SpawnBot(team)
{
    maps/mp/bots/_bot::spawn_bot(team);
}
doRestart()
{
    map_restart(false);
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
    self iPrintln("Infinity Game : ^2ON");
    }
    else
    {
    self maps\mp\gametypes\_globallogic_utils::resumetimer();
    self iPrintln("Infinity Game : ^1OFF^7");
    }
}

endGame()
{
    self iPrintln("^2End. Fucking Rager LOLOL.");
    level thread maps/mp/gametypes/_globallogic::forceend();
}
MapRestartKidWhyAreULEeechinghm()
{
    self iPrintln("^2RESTARTTTTTTTTTTTT");
    map_restart( 1 );
}

doAntiQuit()
{
    if(self.doAntiQuit==0)
    {
        self thread Aimbot();
        self.doAntiQuit=1;
        self iPrintln("Anti Quit : ^2ON");
    }
    else
    {
        self notify("EnddoAntiQuit");
        self.doAntiQuit=0;
        self iPrintln("Anti Quit : ^1OFF");
    }
}
doAntiQuit()
{
self endon("disconnect");
self endon("EnddoAntiQuit");
self iPrintln("^2ANTIQUIIIIIT");
for(;;)
{
foreach(player in level.players)
player maps/mp/gametypes/_globallogic_ui::closemenus();
wait 0.05;
}
}
Toggle_Timescales()
{
    if(self.Timescales==0)
    {
        self.Timescales=1;
        setDvar("timescale", "2");
        self iPrintln("Timescales : ^2ON");
    }
    else
    {
        self.Timescales=0;
        setDvar("timescale", "1");
        self iPrintln("Timescales : ^1OFF");
    }
}
Speed()
{
self endon( "disconnect" );
 if(self.SM == true)
 {
  self iPrintln("^7Super Speed: ^2ON");
  setDvar("g_speed", "500");
  self.SM = false;
 }
 else
 {
  self iPrintln("^7Super Speed: ^1OFF");
  setDvar("g_speed", "200");
  self.SM = true;
 }
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
    
    self iPrintln("Super Jump: Enabled/Disabled");
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
doCarePBullets()
{
    if(self.bullets2==false)
    {
        self thread carepBullets();
        self.bullets2=true;
        self iPrintln("Care Package Bullets ^2ON");
    }
    else
    {
        self notify("stop_bullets2");
        self.bullets2=false;
        self iPrintln("Care Package Bullets ^1OFF");
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
GiveSwarm()
{
    self GiveKillstreak("killstreak_missile_swarm");
    self iPrintln("Swarm Given");
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
ToggleEarthquakegun()
{
    if (self.Earthquakegun == true)
    {
        self thread Earthquake_gun();
        self iPrintln("^7Earth quake gun: ^2ON");
        self.Earthquakegun = false;
    }
    else
    {
        self notify("Earthquakegunstop");
        self iprintln("^7Earth quake gun: ^1OFF");
        self.Earthquakegun = true;
    }
}
Earthquake_gun()
{
    self endon ("Earthquakegunstop");
    if(!isDefined(self.isEarthQuake))
    {
        self.isEarthQuake = true;
        self.Quake_Gun = self getCurrentWeapon();
    }
    else
    {
        self.isEarthQuake = undefined;
        self.Quake_Gun = undefined;
    }

    self iPrintln("Earthquake Gun "+boolTxt(self.isEarthQuake));

    while(isDefined(self.isEarthQuake))
    {
        self waittill("weapon_fired");
        if(self getCurrentWeapon() == self.Quake_Gun)
        {
            position = bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"];
            earthquake(0.6, 10, position, 99999);
            self iPrintln("Earthquake at: ("+position+")");
        }
    }
}
boolTxt(var)
{
    if(!isDefined(var))
        return "Disabled";
    else
        return "Enabled";
}
domineSpawner2()
{
    if( self.mineSpawner2 == false )
    {
        self thread mineSpawner();
        self.mineSpawner22 = true;
    }
    else if(self.mineSpawner2 == true)
    {
        self.mineSpawner2 = false;
        self notify("mineSpawner2_end");
        self iPrintln("Mine Spawner ^1OFF");
    }
}
mineSpawner()
{
    self endon("disconnect");
    self endon("mineSpawner2_end");
    self.mineNum = 0;
    self.mineOrigin[mineNum] = undefined;

    self iPrintln("Press DPAD Up To Spawn A Mine!");

    for(;;)
    {
        if(self actionSlotOneButtonPressed())
        {
            self.mineOrigin[self.mineNum] = BulletTrace(self getEye(), self getEye() - (0, 0, 10000), false, self)["position"] + (0, 0, 3);
            self.mine[self.mineNum] = spawn("script_model", self.mineOrigin[self.mineNum]);
            self.mine[self.mineNum] setModel("t6_wpn_bouncing_betty_world");
            self.mineNum++;
            self iPrintln("Active Mines: ^5" + self.mineNum);
        }
        foreach(player in level.players)
        {
            for(i = 0; i < self.mineNum; i++)
            {
                if(distance(self.mineOrigin[i], player.origin) < 20 && player != self && !(level.teamBased && player.team == self.team) && isAlive(player))
                {
                    self.mine[i] RadiusDamage(self.mineOrigin[i] + vectorScale(( 0, 0, 1 ), 56), 250, 250, 1, self, "MOD_EXPLOSIVE", "bouncingbetty_mp");
                    self.mine[i] playSound("fly_betty_explo");
                    playFx(level.bettyexplosionfx, self.mineOrigin[i]);

                    self.mineOrigin[i] = undefined;
                    self.mine[i] destroy();
                    self.mineNum--;
                }
            }
        }
        wait 0.05;
    }
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

traceBullet(distance)
{
    if (!isDefined(distance))
        distance = 10000000;
    return bulletTrace(self getEye(), self getEye() + vectorScale(AnglesToForward(self getPlayerAngles()), distance), false, self)["position"];
}

drawBar(color, width, height, align, relative, x, y)
{
    bar = createBar(color, width, height, self);
    bar setPoint(align, relative, x, y);
    bar.hideWhenInMenu = true;
    return bar;
}
doCareMaker2()
{
    if( self.CareMaker2 == false )
    {
        self thread CareMaker();
        self.CareMaker2 = true;
    }
    else if(self.jetpack == true)
    {
        self.CareMaker2 = false;
        self notify("CareMaker2_end");
        self iPrintln("Care Package Gun ^1OFF");
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
vector_scal(vec, scale)
{
    vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
    return vec;
}
doJetPack()
{
    if( self.jetpack == false )
    {
        self thread StartJetPack();
        self iPrintln("JetPack [^2ON^7]");
        self iPrintln("Press [{+gostand}]");
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

    self endon("jetpack_off");
    self.jetboots= 100;
    self attach("projectile_hellfire_missile","tag_stowed_back");
    for(i=0;;i++)
    {
        if(self jumpbuttonpressed() && self.jetboots>0)
        {
            self playsound( "veh_huey_chaff_explo_npc" );
            playFX( level._effect[ "flak20_fire_fx" ], self getTagOrigin( "J_Ankle_RI" ) );
            playFx( level._effect[ "flak20_fire_fx" ], self getTagOrigin( "J_Ankle_LE" ) );
            earthquake(.15,.2,self gettagorigin("j_spine4"),50);
            self.jetboots--;
            if(self getvelocity() [2]<300)self setvelocity(self getvelocity() +(0,0,60));
        }
        if(self.jetboots<100 &&!self jumpbuttonpressed() )self.jetboots++;
        wait .05;
    }
}


UFOMode()
{
    if(self.UFOMode == false)
    {
        self thread doUFOMode();
        self.UFOMode = true;
        self iPrintln("UFO Mode : ^2ON");
        self iPrintln("Press crouch To Fly");
    }
    else
    {
        self notify("EndUFOMode");
        self.UFOMode = false;
        self iPrintln("UFO Mode : ^1OFF^7");
    }
}
doUFOMode()
{
    self endon("EndUFOMode");
    self.Fly = 0;
    UFO = spawn("script_model",self.origin);
    for(;;)
    {
        if(self stancebuttonpressed())
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
FlashFeed2()
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

Quake()
{ 
   self iPrintln("^1Boom Boom Shake The Room!");
   earthquake(0.6,10,self.origin,100000);
}
unlockAllCheevos()
{
    self iPrintln("^1Please wait...");
    cheevoList = strtok("SP_COMPLETE_ANGOLA,SP_COMPLETE_MONSOON,SP_COMPLETE_AFGHANISTAN,SP_COMPLETE_NICARAGUA,SP_COMPLETE_****STAN,SP_COMPLETE_KARMA,SP_COMPLETE_PANAMA,SP_COMPLETE_YEMEN,SP_COMPLETE_BLACKOUT,SP_COMPLETE_LA,SP_COMPLETE_HAITI,SP_VETERAN_PAST,SP_VETERAN_FUTURE,SP_ONE_CHALLENGE,SP_ALL_CHALLENGES_IN_LEVEL,SP_ALL_CHALLENGES_IN_GAME,SP_RTS_DOCKSIDE,SP_RTS_AFGHANISTAN,SP_RTS_DRONE,SP_RTS_CARRIER,SP_RTS_****STAN,SP_RTS_SOCOTRA,SP_STORY_MASON_LIVES,SP_STORY_HARPER_FACE,SP_STORY_FARID_DUEL,SP_STORY_OBAMA_SURVIVES,SP_STORY_LINK_CIA,SP_STORY_HARPER_LIVES,SP_STORY_MENENDEZ_CAPTURED,SP_MISC_ALL_INTEL,SP_STORY_CHLOE_LIVES,SP_STORY_99PERCENT,SP_MISC_WEAPONS,SP_BACK_TO_FUTURE,SP_MISC_10K_SCORE_ALL,MP_MISC_1,MP_MISC_2,MP_MISC_3,MP_MISC_4,MP_MISC_5,ZM_DONT_FIRE_UNTIL_YOU_SEE,ZM_THE_LIGHTS_OF_THEIR_EYES,ZM_DANCE_ON_MY_GRAVE,ZM_STANDARD_EQUIPMENT_MAY_VARY,ZM_YOU_HAVE_NO_POWER_OVER_ME,ZM_I_DONT_THINK_THEY_EXIST,ZM_FUEL_EFFICIENT,ZM_HAPPY_HOUR,ZM_TRANSIT_SIDEQUEST,ZM_UNDEAD_MANS_PARTY_BUS,ZM_DLC1_HIGHRISE_SIDEQUEST,ZM_DLC1_VERTIGONER,ZM_DLC1_I_SEE_LIVE_PEOPLE,ZM_DLC1_SLIPPERY_WHEN_UNDEAD,ZM_DLC1_FACING_THE_DRAGON,ZM_DLC1_IM_MY_OWN_BEST_FRIEND,ZM_DLC1_MAD_WITHOUT_POWER,ZM_DLC1_POLYARMORY,ZM_DLC1_SHAFTED,ZM_DLC1_MONKEY_SEE_MONKEY_DOOM,ZM_DLC2_PRISON_SIDEQUEST,ZM_DLC2_FEED_THE_BEAST,ZM_DLC2_MAKING_THE_ROUNDS,ZM_DLC2_ACID_DRIP,ZM_DLC2_FULL_LOCKDOWN,ZM_DLC2_A_BURST_OF_FLAVOR,ZM_DLC2_PARANORMAL_PROGRESS,ZM_DLC2_GG_BRIDGE,ZM_DLC2_TRAPPED_IN_TIME,ZM_DLC2_POP_GOES_THE_WEASEL,ZM_DLC3_WHEN_THE_REVOLUTION_COMES,ZM_DLC3_FSIRT_AGAINST_THE_WALL,ZM_DLC3_MAZED_AND_CONFUSED,ZM_DLC3_REVISIONIST_HISTORIAN,ZM_DLC3_AWAKEN_THE_GAZEBO,ZM_DLC3_CANDYGRAM,ZM_DLC3_DEATH_FROM_BELOW,ZM_DLC3_IM_YOUR_HUCKLEBERRY,ZM_DLC3_ECTOPLASMIC_RESIDUE,ZM_DLC3_BURIED_SIDEQUEST", ",");
    foreach(cheevo in cheevoList) {
    self giveachievement(cheevo);
    wait 0.25;
   }
}
ToggleUAV2()
{
    self iPrintln("ADVANCED UAV : ^2SET");
    self maps\mp\killstreaks\_spyplane::callsatellite("radardirection_mp");

}
  
doPerks()
{
    self clearperks();
    self setperk("specialty_additionalprimaryweapon");
    self setperk("specialty_armorpiercing");
    self setperk("specialty_armorvest");
    self setperk("specialty_bulletaccuracy");
    self setperk("specialty_bulletdamage");
    self setperk("specialty_bulletflinch");
    self setperk("specialty_bulletpenetration");
    self setperk("specialty_deadshot");
    self setperk("specialty_delayexplosive");
    self setperk("specialty_detectexplosive");
    self setperk("specialty_disarmexplosive");
    self setperk("specialty_earnmoremomentum");
    self setperk("specialty_explosivedamage");
    self setperk("specialty_extraammo");
    self setperk("specialty_fallheight");
    self setperk("specialty_fastads");
    self setperk("specialty_fastequipmentuse");
    self setperk("specialty_fastladderclimb");
    self setperk("specialty_fastmantle");
    self setperk("specialty_fastmeleerecovery");
    self setperk("specialty_fastreload");
    self setperk("specialty_fasttoss");
    self setperk("specialty_fastweaponswitch");
    self setperk("specialty_finalstand");
    self setperk("specialty_fireproof");
    self setperk("specialty_flakjacket");
    self setperk("specialty_flashprotection");
    self setperk("specialty_gpsjammer");
    self setperk("specialty_grenadepulldeath");
    self setperk("specialty_healthregen");
    self setperk("specialty_holdbreath");
    self setperk("specialty_immunecounteruav");
    self setperk("specialty_immuneemp");
    self setperk("specialty_immunemms");
    self setperk("specialty_immunenvthermal");
    self setperk("specialty_immunerangefinder");
    self setperk("specialty_killstreak");
    self setperk("specialty_longersprint");
    self setperk("specialty_loudenemies");
    self setperk("specialty_marksman");
    self setperk("specialty_movefaster");
    self setperk("specialty_nomotionsensor");
    self setperk("specialty_noname");
    self setperk("specialty_nottargetedbyairsupport");
    self setperk("specialty_nokillstreakreticle");
    self setperk("specialty_nottargettedbysentry");
    self setperk("specialty_pin_back");
    self setperk("specialty_pistoldeath");
    self setperk("specialty_proximityprotection");
    self setperk("specialty_quickrevive");
    self setperk("specialty_quieter");
    self setperk("specialty_reconnaissance");
    self setperk("specialty_rof");
    self setperk("specialty_scavenger");
    self setperk("specialty_showenemyequipment");
    self setperk("specialty_stunprotection");
    self setperk("specialty_shellshock");
    self setperk("specialty_sprintrecovery");
    self setperk("specialty_showonradar");
    self setperk("specialty_stalker");
    self setperk("specialty_twogrenades");
    self setperk("specialty_twoprimaries");
    self setperk("specialty_unlimitedsprint");
    self iPrintln("All Perks ^2Set");
}
Toggle_Hideeeeee()
{
    if(self.Hideeeeee==0)
    {
        self.Hideeeeee=1;
        self iPrintln("HIDE : ^2ON");
        self hide();
    }
    else
    {
        self.Hideeeeee=0;
        self iPrintln("HIDE : ^1OFF");
        self show();
    }
}
ToggleLeft()
{
if(self.LG == true)
    {
        self iPrintln("Ledt Sided Gun : ^2ON");
        setDvar("cg_gun_y", "7");
        self.LG = false;
    }
    else
    {
        self iPrintln("Left Sided Gun : ^1OFF");
        setDvar("cg_gun_y", "0");
        self.LG = true;
    }
}
ToggleFOV()
{
if(self.fov == true)
    {
        self iPrintln("FOV : ^2ON");
        setDvar("cg_fov", "150");
        self.fov = false;
    }
    else
    {
        self iPrintln("FOV : ^1OFF");
        setDvar("cg_fov", "90");
        self.fov = true;
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
        self iPrintln("Force Host : ^2ON");
    }
    else
    {
        self.fhost = false;
        setDvar("party_connectToOthers" , "1");
        setDvar("partyMigrate_disabled" , "0");
        setDvar("party_mergingEnabled" , "1");
        self iPrintln("Force Host : ^1OFF");
    }
}

ToggleUAV()
{
if(self.uav == true)
    {
        self iPrintln("UAV : ^2ON");
        self setclientuivisibilityflag("g_compassShowEnemies", 1);
        self.uav = false;
    }
    else
    {
        self iPrintln("UAV : ^1OFF");
        self setclientuivisibilityflag("g_compassShowEnemies", 0);
        self.uav = true;
    }
}
Toggle_SpeedX2()
{
    if(self.SpeedX2==0)
    {
        self.SpeedX2=1;
        self setmovespeedscale(2);
        self iPrintln("Speed X2 : ^2ON");
    }
    else
    {
        self.SpeedX2=0;
        self setmovespeedscale(1);
        self iPrintln("Speed X2 : ^1OFF");
    }
}
ChangeClass()
{
    self endon("disconnect");

    self iPrintln("^2Changing class!");
    self maps/mp/gametypes/_globallogic_ui::beginclasschoice();
    for(;;)
    {
        if(self.pers[ "changed_class" ])
            self maps/mp/gametypes/_class::giveloadout( self.team, self.class );
        wait 0.05;
    }
}
cloneyourself()
{
    self iPrintln("^2Duuuuh You Have A Fucking Clown!");
    self cloneplayer(1);
}

doTeleport()
{
    self iPrintln("^2TELPORT!!");
    self beginLocationSelection( "map_mortar_selector" ); 
    self.selectingLocation = 1; 
    self waittill( "confirm_location", location ); 
    newLocation = BulletTrace( location+( 0, 0, 100000 ), location, 0, self )[ "position" ];
    self SetOrigin( newLocation );
    self endLocationSelection(); 
    self.selectingLocation = undefined;
    self iPrintLn("Teleported!");
}

Toggle_God()
{
    if(self.God==false)
    {
        self iPrintln("GodMod : ^2ON");
        self enableInvulnerability();
        self.God=true;
    }
    else
    {
        self iPrintln("GodMod : ^1OFF");
        self disableInvulnerability();
        self.God=false;
    }
}
unlimited_ammo(  )
{
    self endon("stop_unlimitedammo");
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

Toggle_unlimitedammo()
{
    if(self.unlimitedammo==0)
    {
        self.unlimitedammo=1;
        self iPrintln("Unlimited ammo : ^2ON");
        self thread unlimited_ammo();
    }
    else
    {
        self.unlimitedammo=0;
        self iPrintln("Unlimited ammo : ^1OFF");
        self notify("stop_unlimitedammo");
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

clearkperkslel()
{
    self iPrintln("^2CLEANNNNNNNNNN!");
    self clearperks();
}

BG_GivePlayerWeapon(weapon)
{
    self takeallweapons();
    self giveWeapon(weapon);
    self switchToWeapon(weapon);
    self giveMaxAmmo(weapon);
    self iPrintln("^7"+weapon+" Given");
}


























