#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_Weapon; 


init()
{
    level thread onplayerconnect();
    precacheShader("emblem_bg_breach");
    precacheShader("line_horizontal");
	precacheModel( "projectile_hellfire_missile");
	precacheModel("defaultactor");
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
				self iPrintln("^0Unknown Modding Menu Base!");
				self iPrintln("^0Press [{+speed_throw}] ^1& ^0[{+melee}] To Open");
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
		return "^0Host";
	if (status == "Co-Host")
		return "^0Co-Host";
	if (status == "Admin")
		return "^0Admin";
	if (status == "VIP")
		return "^0VIP";
	if (status == "Verified")
		return "^0Verified";
	else
		return "";
}

changeVerificationMenu(player, verlevel)
{
	if( player.status != verlevel && !player isHost())
	{		
		player.status = verlevel;
	
		self.menu.title destroy();
		self.menu.title = drawText("[" + verificationToColor(player.status) + "^1] " + getPlayerName(player), "objective", 2, 0, 30, (0, 0, 0), 0, (1, 0.349, 0), 1, 3);
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
	notifyData.titleText = "^0Welcome To Unknown Modding Menu Base!"; //Line 1
	notifyData.notifyText = "^0Your Status Is " + verificationToColor(self.status); //Line 2
	NotifyData.iconName = "rank_prestige10";
	notifyData.glowColor = (1, 0.349, 0); //RGB Color array divided by 100
	notifyData.duration = 11; //Change Duration
	notifyData.font = "hudbig"; //font
	notifyData.hideWhenInMenu = false;
	self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
}

CreateMenu()
{
	self add_menu("Main Menu", undefined, "Unverified"); //Don't Mess With This Unless Changing Parent**
	self add_option("Main Menu", "SubMenu", ::submenu, "SubMenu1", "SubMenu"); 
	self add_option("Main Menu", "SubMenu", ::submenu, "SubMenu2", "SubMenu");
	self add_option("Main Menu", "SubMenu", ::submenu, "SubMenu3", "SubMenu");
	self add_option("Main Menu", "SubMenu", ::submenu, "SubMenu4", "SubMenu");
	self add_option("Main Menu", "SubMenu", ::submenu, "SubMenu5", "SubMenu");
	self add_option("Main Menu", "SubMenu", ::submenu, "SubMenu6", "SubMenu");
	self add_option("Main Menu", "SubMenu", ::submenu, "SubMenu7", "SubMenu");
	self add_option("Main Menu", "SubMenu", ::submenu, "SubMenu8", "SubMenu");
	self add_option("Main Menu", "SubMenu", ::submenu, "SubMenu9", "SubMenu");
	self add_option("Main Menu", "SubMenu", ::submenu, "SubMenu10", "SubMenu");
	self add_option("Main Menu", "SubMenu", ::submenu, "SubMenu11", "SubMenu");
	self add_option("Main Menu", "SubMenu", ::submenu, "SubMenu12", "SubMenu");
	self add_option("Main Menu", " Players Menu", ::submenu, "PlayersMenu", "Players Menu");

	
	self add_menu("SubMenu1", "Main Menu", "Verified");
	self add_option("SubMenu1", "Option");
	
	self add_menu("SubMenu2", "Main Menu", "Verified");
	self add_option("SubMenu2", "Option");
	
	self add_menu("SubMenu3", "Main Menu", "Verified");
	self add_option("SubMenu3", "Option");
	
	self add_menu("SubMenu4", "Main Menu", "Verified");
	self add_option("SubMenu4", "Option");
	
	self add_menu("SubMenu5", "Main Menu", "Verified");
	self add_option("SubMenu5", "Option");
	
	self add_menu("SubMenu6", "Main Menu", "Verified");
	self add_option("SubMenu6", "Option");
	
	self add_menu("SubMenu7", "Main Menu", "Verified");
	self add_option("SubMenu7", "Option");
	
	self add_menu("SubMenu8", "Main Menu", "Verified");
	self add_option("SubMenu8", "Option");
	
	self add_menu("SubMenu9", "Main Menu", "Verified");
	self add_option("SubMenu9", "Option");
	
	self add_menu("SubMenu10", "Main Menu", "Verified");
	self add_option("SubMenu10", "Option");
	
	self add_menu("SubMenu11", "Main Menu", "Verified");
	self add_option("SubMenu11", "Option");
	
	self add_menu("SubMenu12", "Main Menu", "Verified");
	self add_option("SubMenu12", "Option");
	
	
	self add_menu("PlayersMenu", "Main Menu", "Verified");
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
		
		self add_option("PlayersMenu", "[" + verificationToColor(player.status) + "^1] " + playerName, ::submenu, "pOpt " + i, "[" + verificationToColor(player.status) + "^1] " + playerName);
	
		self add_menu_alt("pOpt " + i, "PlayersMenu");
		self add_option("pOpt " + i, "Host", ::changeVerificationMenu, player, "Host");
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
	self.menu.background = self drawShader("emblem_bg_breach", 0, -50, 200, 500, (1, 1, 1), 0, 0);
	self.menu.background1 = self drawShader("emblem_bg_breach", 0, -50, 200, 500, (1, 1, 1), 0, 0);
	self.menu.scroller = self drawShader("white", 0, -500, 200, 17, (1, 0.349, 0), 255, 1);
	self.menu.line = self drawShader("white", -100, -550, 2, 500, (1, 0.349, 0), 255, 3);
	self.menu.line2 = self drawShader("white", 100, -550, 2, 500, (1, 0.349, 0), 255, 4);
	//x y width height
}
// ^ It goes x, y, width and height. so if you look at self.menu.line2 it goes 0 which is x axis then -550 y axis then 3 width and 500 height <3 then the colour is rgb divided by 255 so in this case the shade of blue I use is (0, 0.23, 1) ;p  
StoreText(menu, title)
{
	self.menu.currentmenu = menu;
	string = "";
    self.menu.title destroy();
	self.menu.title = drawText(title, "objective", 2, 1, 30, (1, 1, 1), 0, (1, 0.349, 0), 1, 5);
	self.menu.title FadeOverTime(0.3);
	self.menu.title.alpha = 1;
	self notify ("stopScale");
    self thread scaleLol();
    self.tez destroy();
    self.tez = self createFontString( "default", 2.5);
    self.tez setPoint( "CENTER", "TOP", -7, 10 );
    self.tez setText("^1  Unknown Modding");
    self.tez FadeOverTime(0.3);
    self.tez.alpha = 1;
    self.tez.foreground = true;
    self.tez.archived = false;
    self.tez.glowAlpha = 1;
    self.tez.glowColor = (1, 0.349, 0);
	
    for(i = 0; i < self.menu.menuopt[menu].size; i++)
    { string += self.menu.menuopt[menu][i] + "\n"; }
//
    self.menu.options destroy(); 
	self.menu.options = drawText(string, "objective", 1.7, 1, 68, (1, 1, 1), 0, (0, 0, 0), 0, 6);
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

//codes
ToggleGodMode()
{
    if (!isDefined(self.god))
    {
        self iprintln("^0GodMode ^0[^2ON^0]");
        self.maxhealth = 999999999;
        self.health = self.maxhealth;
        if (self.health < self.maxhealth)
        {
            self.health = self.maxhealth;
        }
        self enableinvulnerability();
        self setperk("specialty_fallheight");
        self.god = true;
    }
    else
    {
        self iprintln("^0GodMode ^0[^1OFF^0]");
        self.maxhealth = 100;
        self.health = self.maxhealth;
        self disableinvulnerability();
        self.god = undefined;
    }
}

ToggleAmmo()
{
    if (!isDefined(self.unlammo))
    {
        self thread UnlimitedAmmo();
        self.unlammo = true;
        self iprintln("^0Unlimited Ammo ^0[^2ON^0]");
    }
    else
    {
        self notify("stop_ammo");
        self.unlammo = undefined;
        self iprintln("^0Unlimited Ammo ^0[^1OFF^0]");
    }
}

UnlimitedAmmo()
{
    self endon("stop_ammo");
    while (1)
    {
        weap = self getcurrentweapon();
        self setweaponammoclip(weap, 150);
        wait 0.02;
    }
}



