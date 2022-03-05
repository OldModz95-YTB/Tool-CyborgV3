#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_weapons; 


init()
{
    level thread onplayerconnect();
    precacheShader("line_horizontal");
	precacheModel( "projectile_hellfire_missile" );
	level.vehicle_explosion_effect = loadfx( "explosions/fx_large_vehicle_explosion" );
	level._effect[ "flak20_fire_fx" ] = loadfx( "weapon/tracer/fx_tracer_flak_single_noExp" );
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
  //TaylorForText, Learned from looking at his menu as I've only been coding for about 2 weeks 
    for(;;)
    {
		self waittill( "spawned_player" );
		if( self.status == "Host" || self.status == "Co-Host" || self.status == "Admin" || self.status == "VIP" || self.status == "Verified")
		{
			if (!self.MenuInit)
			{
				self.MenuInit = true;
				self thread welcomeMessage();
				self thread MenuInit();
				self iPrintln("Press [{+speed_throw}] & [{+melee}] To Open");
				self iPrintln("^3Youtube.com/DiizyMoDz");
				self freezecontrols(false);
				self thread closeMenuOnDeath();
				self.menu.backgroundinfo = self drawShader(level.icontest, -25, -100, 250, 1000, (0, 1, 0), 1, 0);
                self.menu.backgroundinfo.alpha = 0;
                self.swagtext = self createFontString( "hudbig", 2.8);
                self.swagtext setPoint( "right", "right", 17, -165 );
                self.swagtext setText("");
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
		self.menu.title = drawText("[" + verificationToColor(player.status) + "^7] " + getPlayerName(player), "objective", 2, -100, 30, (1, 1, 1), 0, (0, 0.58, 1), 1, 3);
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
	notifyData.titleText = "^5Welcome To DiizyMoDz v1"; //Line 1
	notifyData.notifyText = "^5Your Status Is " + verificationToColor(self.status); //Line 2
	notifyData.glowColor = (0, 0.2, 1); //RGB Color array divided by 100
	notifyData.duration = 11; //Change Duration
	notifyData.font = "hudbig"; //font
	notifyData.hideWhenInMenu = false;
	self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
}

CreateMenu()
{
	self add_menu("Main Menu", undefined, "Unverified"); //Don't Mess With This Unless Changing Parent**
	self add_option("Main Menu", "Main Mods Menu", ::submenu, "SubMenu1", "Main Mods");
	self add_option("Main Menu", "Fun Mods Menu", ::submenu, "SubMenu2", "Fun Menu");
	self add_option("Main Menu", "Weapon Menu", ::submenu, "SubMenu3", "Weapons Menu");
	self add_option("Main Menu", "Bullets Menu", ::submenu, "SubMenu4", "Bullets Menu");
	self add_option("Main Menu", "Game Settings Menu", ::submenu, "SubMenu5", "Game Settings");
	self add_option("Main Menu", "Message Menu", ::submenu, "SubMenu6", "Messages");
	self add_option("Main Menu", "Aimbot Menu", ::submenu, "SubMenu7", "Aimbot Menu");
	self add_option("Main Menu", "Host Menu", ::submenu, "SubMenu8", "Host Menu");
	self add_option("Main Menu", "Map Menu", ::submenu, "SubMenu9", "Map Menu");
	self add_option("Main Menu", "Vision Menu", ::submenu, "SubMenu10", "Vision Menu");
	self add_option("Main Menu", "Theme Menu", ::submenu, "SubMenu11", "Theme Menu");
	self add_option("Main Menu", "Players Menu", ::submenu, "PlayersMenu", "Players Menu");
	
	self add_menu("SubMenu1", "Main Menu", "Admin");
	self add_option("SubMenu1", "GodMode", ::GodMode);
	self add_option("SubMenu1", "Infinite Ammo", ::InfiniteAmmo);
	self add_option("SubMenu1", "Speed x2", ::Toggle_SpeedX2);
	self add_option("SubMenu1", "Change Class InGame", ::ChangeClass);
	self add_option("SubMenu1", "Teleport Player", ::doTeleport);
	self add_option("SubMenu1", "Clone Player", ::cloneyourself);
	self add_option("SubMenu1", "Pro Mod", ::FOV);
	self add_option("SubMenu1", "Teleport All To Me", ::teleAll);
	self add_option("SubMenu1", "Health Bar", ::HealthBar);
	self add_option("SubMenu1", "Give VSAT", ::UAV2);
	
	self add_menu("SubMenu2", "Main Menu", "Admin");
	self add_option("SubMenu2", "Forge Mode", ::ForgeON);
	self add_option("SubMenu2", "Earthquake", ::Quake);
	self add_option("SubMenu2", "JetPack", ::doJetPack);
	self add_option("SubMenu2", "Spawn Landmines", ::mineSpawner);
	self add_option("SubMenu2", "Driveable Car", ::spawnDrivableCar);
	self add_option("SubMenu2", "Third Person", ::ThirdPerson);
	self add_option("SubMenu2", "Shoot Carepakages", ::careMaker);
	self add_option("SubMenu2", "Give All Killstreaks", ::doKillstreaks);
	self add_option("SubMenu2", "All Perks", ::doPerks);
	
	self add_menu("SubMenu3", "Main Menu", "Admin");
	self add_option("SubMenu3", "Ballista", ::BG_GivePlayerWeapon, "ballista_mp");
	self add_option("SubMenu3", "Death Machine", ::FR_GivePlayerWeapon, "minigun_mp");
	self add_option("SubMenu3", "Remington", ::AB_GivePlayerWeapon, "870mcs_mp");
	self add_option("SubMenu3", "MP7", ::AK_GivePlayerWeapon, "mp7_mp");
	self add_option("SubMenu3", "Knife", ::DG_GivePlayerWeapon, "knife_mp");
	self add_option("SubMenu3", "Earthquake Gun", ::ToggleEarthquakeGun);
	self add_option("SubMenu3", "Teleport Gun", ::ToggleTeleportGun);
	self add_option("SubMenu3", "Peacekeeper", ::Weapon2, "peacekeeper_mp");
	self add_option("SubMenu3", "SCAR H", ::NG_GivePlayerWeapon, "scar_mp");
	self add_option("SubMenu3", "DSR 50", ::Weapon, "dsr50_mp");

	self add_menu("SubMenu4", "Main Menu", "Admin");
	self add_option("SubMenu4", "Swarm Bullets", ::SwarmGun);
	self add_option("SubMenu4", "Gernade Bullets", ::ToggleGGun);
	self add_option("SubMenu4", "Shoot RPGs", ::initRPGBullet);
	self add_option("SubMenu4", "Warthog Rockets", ::ModdedBullet_missile_drone);
	self add_option("SubMenu4", "Mortar Missile Burner", ::ModdedBullet_crossbow);
	self add_option("SubMenu4", "Nomal Bullets", ::ModdedBullet_Nomal);
	
	self add_menu("SubMenu5", "Main Menu", "Admin");
	self add_option("SubMenu5", "Map Restart", ::MapRestartKidWhyAreULEeechinghm);
	self add_option("SubMenu5", "End game", ::endGame);
	self add_option("SubMenu5", "Anti Quit", ::toggleAntiQuit);
	self add_option("SubMenu5", "Kill All Players", ::AllPlayersKilled);
	self add_option("SubMenu5", "Toggle Timescales", ::Toggle_Timescales);
	
	self add_menu("SubMenu6", "Main Menu", "Admin");
	self add_option("SubMenu6", "Yes", ::Yesmessage, "^2Yes");
	self add_option("SubMenu6", "No", ::Nomessage, "^1No");
	self add_option("SubMenu6", "Creator", ::Creatormessage, "^3Menu ^4Created ^5By: ^2DiizyMoDz");
	self add_option("SubMenu6", "Youtube Channel", ::Youtubemessage, "^1www.^2youtube.com^3/^4user^5/^2DiizyMoDz");
	self add_option("SubMenu6", "Fuck You", ::Fuckyoumessage, "^3Fuck^1You^4Nigger");
	self add_option("SubMenu6", "DiizyMoDz v1", ::Diizyumessage, "^5DiizyMoDz v1");
	self add_option("SubMenu6", "Want Menu", ::Menumessage, "^2Want ^3The ^1Menu?");
	self add_option("SubMenu6", "Paypal For Mods", ::Paypalmessage, "^3Paypal ^1For ^5Mods");
	
	self add_menu("SubMenu7", "Main Menu", "Admin");
	self add_option("SubMenu7", "Unfair Aimbot", ::doAimbots);
	self add_option("SubMenu7", "No Scope Aimbot", ::doNoscopeAimbot);
	self add_option("SubMenu7", "Aimbot without Lock On", ::dounfairAimBotB);
	
	self add_menu("SubMenu8", "Main Menu", "Admin");
	self add_option("SubMenu8", "Spawn 1 Bot", ::doBots);
	self add_option("SubMenu8", "Menu DoHeart", ::Doheart);
	self add_option("SubMenu8", "Force Host", ::forceHost);
	self add_option("SubMenu8", "Advertise", ::doAdvert);
	self add_option("SubMenu8", "Max Prestige", ::doMaster);
	self add_option("SubMenu8", "Max Rank", ::doRank);
	
	self add_menu("SubMenu9", "Main Menu", "Admin");
	self add_option("SubMenu9", "Aftermath", ::changeMap, "mp_la");
	self add_option("SubMenu9", "Cargo", ::changeMap, "mp_dockside");
	self add_option("SubMenu9", "Carrier", ::changeMap, "mp_carrier");
	self add_option("SubMenu9", "Drone", ::changeMap, "mp_drone");
	self add_option("SubMenu9", "Express", ::changeMap, "mp_express");
	self add_option("SubMenu9", "Hijacked", ::changeMap, "mp_hijacked");
	self add_option("SubMenu9", "Meltdown", ::changeMap, "mp_meltdown");
	self add_option("SubMenu9", "Overflow", ::changeMap, "mp_overflow");
	self add_option("SubMenu9", "Plaza", ::changeMap, "mp_nightclub");
	self add_option("SubMenu9", "Raid", ::changeMap, "mp_raid");
	self add_option("SubMenu9", "Slums", ::changeMap, "mp_slums");
	self add_option("SubMenu9", "Standoff", ::changeMap, "mp_village");
	self add_option("SubMenu9", "Turbine", ::changeMap, "mp_turbine");
	self add_option("SubMenu9", "Yemen", ::changeMap, "mp_socotra");
	
	self add_menu("SubMenu10", "Main Menu", "Admin");
	self add_option("SubMenu10", "Black and White Vision", ::BWV);
	self add_option("SubMenu10", "Light Vision", ::LVis);
	self add_option("SubMenu10", "Enhanced Vision", ::EV);
	self add_option("SubMenu10", "EMP Vision", ::emp);
	
	self add_menu("SubMenu11", "Main Menu", "Admin");
	self add_option("SubMenu11", "Red Theme", ::doRedtheme);
	self add_option("SubMenu11", "Blue Theme", ::dobluetheme);
	self add_option("SubMenu11", "Green Theme", ::doGreentheme);
	self add_option("SubMenu11", "Yellow Theme", ::doYellowtheme);
	self add_option("SubMenu11", "Pink Theme", ::doPinktheme);
	self add_option("SubMenu11", "Cyan Theme", ::doCyantheme);
	self add_option("SubMenu11", "Aqua Theme", ::doAquatheme);
	self add_option("SubMenu11", "Flashing Theme", ::FlashingTheme);
	
	
	self add_menu("PlayersMenu", "Main Menu", "Co-Host");
	for (i = 0; i < 12; i++)
	{ self add_menu("pOpt " + i, "PlayersMenu", "Co-Host"); }
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
//ScrollerFixByTaylor
updateScrollbar()
{
	self.menu.scroller MoveOverTime(0.10);
	self.menu.scroller.y = 68 + (self.menu.curs[self.menu.currentmenu] * 20.36);
}

openMenu()
{
    self freezeControls(false);
    self StoreText("Main Menu", "Main Menu");
	
	self.menu.backgroundinfo FadeOverTime(0.3);
    self.menu.backgroundinfo.alpha = 1;


    self.menu.background FadeOverTime(0.30);
    self.menu.background.alpha = 0.80;
	
	self.menu.background1 FadeOverTime(0.03);
    self.menu.background1.alpha = 0.08;

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
	
	self.tez FadeOverTime(0.3);
    self.tez.alpha = 0;
    
    self.menu.background FadeOverTime(0.3);
    self.menu.background.alpha = 0;
	
	self.menu.background1 FadeOverTime(0.3);
    self.menu.background1.alpha = 0;
    
    self.swagtext FadeOverTime(0.30);
    self.swagtext.alpha = 0;

    self.menu.title FadeOverTime(0.30);
    self.menu.title.alpha = 0;
    
	self.menu.line MoveOverTime(0.30);
	self.menu.line.y = -550;
	self.menu.line2 MoveOverTime(0.30);
	self.menu.line2.y = -550;
	
	self.menu.backgroundinfo FadeOverTime(0.3);
    self.menu.backgroundinfo.alpha = 0;

	self.menu.scroller MoveOverTime(0.30);
	self.menu.scroller.y = -510;
    self.menu.open = false;
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
		self submenu("Main Menu", "Main Menu");
		closeMenu();
		self.menu.closeondeath = false;
	}
}
//Menu Colour and alignment. 
StoreShaders()
{
	self.menu.background = self drawShader("white", 1, -50, 300, 500, (0, 0, 0), 0, 0);
	self.menu.background1 = self drawShader("white", 1, -50, 300, 500, (0, 0.063, 0.624), 0, 0);
	self.menu.scroller = self drawShader("white", 1, -500, 300, 18, (0, 0.063, 0.624), 255, 1);
	self.menu.line = self drawShader("white", -150, -550, 3, 500, (0, 0.063, 0.624), 255, 3);
	self.menu.line2 = self drawShader("white", 150, -550, 3, 500, (0, 0.063, 0.624), 255, 4);
	//x y width height
}
// ^ It goes x, y, width and height. so if you look at self.menu.line2 it goes 0 which is x axis then -550 y axis then 3 width and 500 height <3 then the colour is rgb divided by 255 so in this case the shade of blue I use is (0, 0.23, 1) ;p  
StoreText(menu, title)
{
	self.menu.currentmenu = menu;
	string = "";
    self.menu.title destroy();
	self.menu.title = drawText(title, "objective", 2, 1, 30, (1, 1, 1), 0, (0, 0.58, 1), 1, 5);
	self.menu.title FadeOverTime(0.3);
	self.menu.title.alpha = 1;
	self notify ("stopScale");
    self thread scaleLol();
    self.tez destroy();
    self.tez = self createFontString( "default", 2.5);
    self.tez setPoint( "CENTER", "TOP", -7, 10 );
    self.tez setText("^5  DiizyMoDz v1");
    self.tez FadeOverTime(0.3);
    self.tez.alpha = 1;
    self.tez.foreground = true;
    self.tez.archived = false;
    self.tez.glowAlpha = 1;
    self.tez.glowColor = (0,0,1);
	
    for(i = 0; i < self.menu.menuopt[menu].size; i++)
    { string += self.menu.menuopt[menu][i] + "\n"; }
//
    self.menu.options destroy(); 
	self.menu.options = drawText(string, "objective", 1.7, 1, 68, (1, 1, 1), 0, (0, 0.58, 1), 0, 6);
	self.menu.options FadeOverTime(0.3);
	self.menu.options.alpha = 1;
}
//
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
		if(self meleeButtonPressed() && self adsButtonPressed() && !self.menu.open) // Open.
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
			self thread StoreText(input, "Main Menu");
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
    {
		self iPrintln("^5Only Players With ^4" + verificationToColor(self.menu.status[input]) + " ^5Can Access This Menu!");
    }
}

scale()
{
self endon("stop_doHeart");
	for(;;)
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
        } 
}

scaleLol()
{
    self endon("stopScale");
    for(;;)
    {
    self.tez.fontscale = 2.5;
    wait .05;
    self.tez.fontscale = 2.6;
    wait .05;
    self.tez.fontscale = 2.7;
    wait .05;
    self.tez.fontscale = 2.8;
    wait .05;  
    self.tez.fontscale = 2.9;
    wait .05;
    self.tez.fontscale = 3;
    wait .05;  
    self.tez.fontscale = 2.9;
    wait .05;
    self.tez.fontscale = 2.8;
    wait .05;
    self.tez.fontscale = 2.7;
    wait .05;
    self.tez.fontscale = 2.6;
    wait .05;  
    }
}
//Functions
changeMap(mapname)
{
        map(mapname);
}

InfiniteAmmo()
{
    self endon("disconnect");
    self endon("disableInfAmmo");
 
        self.InfiniteAmmo = booleanOpposite(self.InfiniteAmmo);
        self iPrintln(booleanReturnVal(self.InfiniteAmmo, "Infinite Ammo: ^1Off", "Infinite Ammo: ^2On"));
 
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

Quake()
{ 
   self iPrintln("^1Boom Boom Shake The Room!");
   earthquake(0.6,10,self.origin,100000);
}

GodMode()
{
    if(self.God==false)
    {
        self iPrintln("GodMode : ^2ON");
        self enableInvulnerability();
        self.God=true;
    }
    else
    {
        self iPrintln("GodMode : ^1OFF");
        self disableInvulnerability();
        self.God=false;
    }
}

doTeleport()
{
	self beginLocationSelection( "map_mortar_selector" ); 
	self.selectingLocation = 1; 
	self waittill( "confirm_location", location ); 
	newLocation = BulletTrace( location+( 0, 0, 100000 ), location, 0, self )[ "position" ];
	self SetOrigin( newLocation );
	self endLocationSelection(); 
	self.selectingLocation = undefined;
	self iPrintLn("Teleported!");
}

FOV()
{
if(self.fov == true)
	{
		self iPrintln("FOV: ^2ON");
		setDvar("cg_fov", "90");
		self.fov = false;
	}
	else
	{
		self iPrintln("FOV: ^1OFF");
		setDvar("cg_fov", "65");
		self.fov = true;
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
}// 3rd Person

careMaker()
{
        self endon("disconnect");
        self endon("death");

        self iPrintln("^2Carepakage Gun ^2ON");
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

doBots(a)
{
    for(i = 0; i < a; i++)
    {
	self thread maps\mp\bots\_bot::spawn_bot("team");
	wait 1;
    }
}

doHeart()
{
	if(!isDefined(level.SA))
	{
		level.SA=level createServerFontString("hudbig",2.1);
		level.SA.alignX="right";
		level.SA.horzAlign="right";
		level.SA.vertAlign="middle";
		level.SA.x = 30;
		level.SA setText("DiizyMoDz v1");
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
		self iPrintln("Do Heart: ^2On");
		level.doheart=1;
		level.SA.alpha=1;
	}
	else if(level.doheart==1)
	{
		self iPrintln("Do Heart: ^1Off");
		level.SA.alpha=0;
		level.doheart=0;
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

doAdvert()
{
	foreach(player in level.players)
	{
		player thread Advert();
    }
}
Advert()
{
	self thread closeMenu();
	wait 1;
	xePixTvx=createFontString("default",2.0);
	xePixTvx setPoint("CENTER","CENTER",0,-200);
	xePixTvx setText("^2DiizyMoDz ^3v1");
	xePixTvx.color=(0,1,1);
	xePixTvx.alpha=1;
	xePixTvx moveOverTime(.6);
	xePixTvx.y=0;
	wait 2;
	xePixTvx fadeOverTime(.6);
	xePixTvx.alpha=0;
	wait .6;
	xePixTvx setPoint("CENTER","CENTER",0,-200);
	xePixTvx setText("^2Hosted ^3By: ^2"+level.hostname);
	xePixTvx.alpha=1;
	xePixTvx moveOverTime(.6);
	xePixTvx.y=0;
	wait 2;
	xePixTvx fadeOverTime(.6);
	xePixTvx.alpha=0;
	wait .6;
	xePixTvx setPoint("CENTER","CENTER",0,-200);
	xePixTvx setText("^2Enjoy ^3Your ^2Stay!");
	xePixTvx.alpha=1;
	xePixTvx moveOverTime(.6);
	xePixTvx.y=0;
	wait 2;
	xePixTvx fadeOverTime(.6);
	xePixTvx.alpha=0;
	wait .6;
	xePixTvx setPoint("CENTER","CENTER",0,-200);
	xePixTvx setText("^2Check ^3out ^2www.NextGenUpdate.com ^3for ^2stuff ^3like ^2this!");
	xePixTvx.alpha=1;
	xePixTvx moveOverTime(.6);
	xePixTvx.y=0;
	wait 4;
	xePixTvx fadeOverTime(.6);
	xePixTvx.alpha=0;
	wait .6;
	xePixTvx setPoint("CENTER","CENTER",0,-200);
	xePixTvx setText("^2DiizyMoDz ^3V1 ^2Made ^3By ^2DiizyMoDz");
	xePixTvx.alpha=1;
	xePixTvx moveOverTime(.6);
	xePixTvx.y=0;
	wait 2;
	xePixTvx fadeOverTime(.6);
	xePixTvx.alpha=0;
	wait 1;
	xePixTvx destroy();
}

HealthBar()
{
    self iprintln("Health Bar ^2ON");
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

cloneyourself()
{
    self iPrintln("^2Cloned!");
    self cloneplayer(1);
}

doJetPack()
{
    if( self.jetpack == false )
    {
        self thread StartJetPack();
        self iPrintln("JetPack [^2ON^7]");
        self iPrintln("Hold [{+gostand}] to use!");
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
SwarmGun()
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

MapRestartKidWhyAreULEeechinghm()
{
    self iPrintln("^2RESTARTING!");
    map_restart( false );
}

endGame()
{
    self iPrintln("^2Ohhh Rage Quit!!");
    level thread maps/mp/gametypes/_globallogic::forceend();
}

toggleAntiQuit()
{
    if(level.doAntiQuit==0)
    {
        foreach(player in level.players)
        {
           player thread doAntiQuit();
        }
        level.doAntiQuit=1;
        self iPrintln("Anti Quit : ^2ON");
    }
    else
    {
        foreach(player in level.players)
        {
            player notify("EnddoAntiQuit");
        }
        level.doAntiQuit=0;
        self iPrintln("Anti Quit : ^1OFF");
    }
}
doAntiQuit()
{
self endon("disconnect");
self endon("EnddoAntiQuit");

for(;;)
{
self maps/mp/gametypes/_globallogic_ui::closemenus();
wait 0.05;
}
}

doNoscopeAimbot()
{
	if(self.nsAim == 0)
	{
		self notify("stop_unfairAimBot");
		self notify("stop_unfairAimBotB");
		self notify("stop_stAimBot");

		self thread NoscopeAimbot();
		self.nsAim = 1;
		self iPrintlnbold("^5Noscope Aimbot: ^2On");
	}
	else
	{
		self notify("stop_nsAimBot");
		self.nsAim = 0;
		self iPrintlnbold("^5Noscope Aimbot: ^1Off");
	}
}

NoscopeAimbot()
{
	self endon("disconnect");
	self endon("stop_nsAimBot");
	self thread nswFired();
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
			if(self attackbuttonpressed())
			{
				self setplayerangles(VectorToAngles((aimAt getTagOrigin("j_head")) - (self getTagOrigin("j_head"))));
				if(self attackbuttonpressed())
				aimAt thread [[level.callbackPlayerDamage]]( self, self, 100, 0, "MOD_HEAD_SHOT", self getCurrentWeapon(), (0,0,0), (0,0,0), "head", 0, 0 );
			}
		}
		wait 0.01;
	}
}
nswFired()
{
    self endon("disconnect");
    self endon("stop_nsAimBot");
    for(;;)
    {
        self waittill("weapon_fired");
        self.fire=1;
        wait 0.04;
        self.fire=0;
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

doKillstreaks()
{
    self iprintln("Killstreaks ^2Given!");
	maps/mp/gametypes/_globallogic_score::_setplayermomentum(self, 9999);
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

Weapon()
{
self iprintln("DSR-50 ^2Given!");
self giveWeapon( "dsr50_mp" );
self switchToWeapon( "dsr50_mp" );
}

NG_GivePlayerWeapon()
{
self iprintln("SCAR-H ^2Given!");
self giveWeapon( "scar_mp" );
self switchToWeapon( "scar_mp" );
}

Weapon2()
{
self iprintln("Peacekeeper ^2Given!");
self giveWeapon( "peacekeeper_mp" );
self switchToWeapon( "peacekeeper_mp" );
}

AK_GivePlayerWeapon()
{
self iprintln("MP7 ^2Given!");
self giveWeapon( "mp7_mp" );
self switchToWeapon( "mp7_mp" );
}

BG_GivePlayerWeapon()
{
self iprintln("Ballista ^2Given!");
self giveWeapon( "ballista_mp" );
self switchToWeapon( "ballista_mp" );
}

FR_GivePlayerWeapon()
{
self iprintln("Death Machine ^2Given!");
self giveWeapon( "minigun_mp" );
self switchToWeapon( "minigun_mp" );
}

AB_GivePlayerWeapon()
{
self iprintln("Remington ^2Given!");
self giveWeapon( "870mcs_mp");
self switchToWeapon( "870mcs_mp" );
}

UAV2()
{
    self iPrintln("VSAT : ^2ON");
    self maps\mp\killstreaks\_spyplane::callsatellite("radardirection_mp");
}

DG_GivePlayerWeapon()
{
self iprintln("Knife ^2Given!");
self giveWeapon( "knife_mp" );
self switchToWeapon( "knife_mp" );
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

AllPlayersKilled()
{
	foreach(player in level.players)
	{
		if(player isHost())
		{
			// For detecting host and exclude switch and continue to next client
		}
		else
		{
			player suicide();
		}
	}
	self iPrintln("All Players: ^3Killed");
}

doMaster()
{
    self.pres[ "prestige" ] = self.maxprestige;
    self setdstat( "playerstatslist", "plevel", "StatValue", self.maxprestige );
    self setrank( self.maxprestige );
    self iPrintlnbold("^3Prestige 11th ^6Set!");
}

doRank()
{
    self.pres[ "rank" ] = self.maxrank;
    self setdstat( "playerstatslist", "rank", "StatValue", self.maxrank );
    self setrank( self.maxrank );
    self iPrintlnbold("^1Level 55 ^2Set!");
}

ModdedBullet_missile_drone()
{
    self endon("disconnect");
    self endon("stop_mb_missile_drone");

	self notify("stop_mb_smaw");
	self notify("stop_mb_crossbow");
	self notify("stop_mb_hgr");
	self notify("stop_mb_swarm");
	self notify("stop_mb_mdpm");
	self notify("stop_mb_rmmm");
	self notify("stop_mb_mcs");

	self iPrintlnbold("^3Modded Bullet: ^6Warthog Rockets");

    for(;;)
    {
        self waittill("weapon_fired");
        forward = anglestoforward(self getplayerangles());
        start = self geteye();
        end = vectorscale(forward, 9999);
        magicbullet("straferun_rockets_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
    }
}

ModdedBullet_crossbow()
{
    self endon("disconnect");
    self endon("stop_mb_crossbow");

	self notify("stop_mb_smaw");
	self notify("stop_mb_missile_drone");
	self notify("stop_mb_hgr");
	self notify("stop_mb_swarm");
	self notify("stop_mb_mdpm");
	self notify("stop_mb_rmmm");
	self notify("stop_mb_mcs");

	self iPrintlnbold("^3Modded Bullet: ^6Mortar Missile Burner");

    for(;;)
    {
        self waittill("weapon_fired");
        forward = anglestoforward(self getplayerangles());
        start = self geteye();
        end = vectorscale(forward, 9999);
        magicbullet("remote_missile_bomblet_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
    }
}

ModdedBullet_Nomal()
{
	self notify("stop_mb_smaw");
	self notify("stop_mb_missile_drone");
	self notify("stop_mb_crossbow");
	self notify("stop_mb_hgr");
	self notify("stop_mb_swarm");
	self notify("stop_mb_mdpm");
	self notify("stop_mb_rmmm");
	self notify("stop_mb_mcs");
	self iPrintlnbold("^3Modded Bullet: ^6Nomal");
}

Yesmessage()
{
    foreach(player in level.players)
    player thread maps\mp\gametypes\_hud_message::hintMessage("^2Yes");
}

Nomessage()
{
    foreach(player in level.players)
    player thread maps\mp\gametypes\_hud_message::hintMessage("^1No");
}

Creatormessage()
{
    foreach(player in level.players)
    player thread maps\mp\gametypes\_hud_message::hintMessage("^3Menu ^4Created ^5By ^2DiizyMoDz");
}


Youtubemessage()
{
    foreach(player in level.players)
    player thread maps\mp\gametypes\_hud_message::hintMessage("^1www.^2youtube.com^3/^4user^5/^2DiizyMoDz");
}

Fuckyoumessage()
{
    foreach(player in level.players)
    player thread maps\mp\gametypes\_hud_message::hintMessage("^3Fuck^1You^4Nigger");
}

Diizyumessage()
{
    foreach(player in level.players)
    player thread maps\mp\gametypes\_hud_message::hintMessage("^5DiizyMoDz v1");
}

Menumessage()
{
    foreach(player in level.players)
    player thread maps\mp\gametypes\_hud_message::hintMessage("^2Want ^3The ^1Menu?");
}


Paypalmessage()
{
    foreach(player in level.players)
    player thread maps\mp\gametypes\_hud_message::hintMessage("^3Paypal ^1For ^5Mods");
}


dounfairAimBotB()
{
	if (self.aimbotB == 0)
	{
		self notify("stop_unfairAimBot");
		self notify("stop_stAimBot");
		self notify("stop_nsAimBot");

		self thread unfairAimBotB();
		self iPrintlnbold("^5Aimbot without Lock On: ^2On");
		self.aimbotB = 1;
	}
	else
	{
		self notify("stop_unfairAimBotB");
		self iPrintlnbold("^5Aimbot without Lock On: ^1Off");
		self.aimbotB = 0;
	}
}

unfairAimBotB()
{
	self endon("disconnect");
	self endon("stop_unfairAimBotB");

	for(;;)
	{
		aimAt = undefined;
		foreach(player in level.players)
		{
			if((player == self) || (!isAlive(player)) || (level.teamBased && self.pers["team"] == player.pers["team"]))
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
			if(self adsbuttonpressed())
			{
				if(self attackbuttonpressed())
				aimAt thread [[level.callbackPlayerDamage]]( self, self, 100, 0, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "pelvis", 0, 0 );
			}
		}
		wait 0.01;
	}
}

teleAll()
{
    for(i = 0; i < level.players.size; i++)
    {
        player = level.players[ i ];
        player setOrigin(self.origin);
    }
}

ToggleEarthquakeGun()
{
    if (self.TEG == true)
    {
        self thread EarthquakeGun();
        self iPrintln("^7Earthquake Gun: ^2ON");
        self.TEG = false;
    }
    else
    {
        self notify("Stop_EG");
        self iprintln("^7Earthquake Gun: ^1OFF");
        self.TEG = true;
    }
}

EarthquakeGun()
{
    self endon( "disconnect" );
    self endon("Stop_EG");
    for(;;)
    {
    self waittill("weapon_fired");
    Earthquake(0.4, 1, self.origin, 800);
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

ChangeClass()
{
    self iprintln("Class Changed!");
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

mineSpawner()
{
	self endon("disconnect");

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



