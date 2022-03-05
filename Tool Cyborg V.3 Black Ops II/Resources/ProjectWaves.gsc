/*
*	 Black Ops 2 - GSC Studio by Metrifyy
*
*	 Creator : Metrifyy
*	 Project : Project Waves
*    Mode : Multiplayer
*	 Date : 2015/10/01 - 01:27:09	
*    Creator's Youtube : Youtube.com/Metrifyy
*/	

#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/_utility;

init( )
{
	level.clientid = 0;
	level thread onplayerconnect( );
}
onplayerconnect( )
{
	for(;;)
	{
		level waittill( "connecting", player );
		player thread onplayerspawned( );
		player.clientid = level.clientid;
		level.clientid++;
		player.MenuAccess = false;
		player.hatMenu = false;
		player.MyAccess = "^1N/A";
	}
}
onplayerspawned( )
{
	self endon( "disconnect" );
	level endon( "game_ended" );
	for(;;)
	{
		self waittill( "spawned_player" );
		if(self isHost())
		{
			self freezecontrols(false);
			self.MenuAccess = true;
			self.hatMenu = true;
			self.MyAccess = "^2Host";
			self thread MenuBenutzung();
			wait 1;
			self iprintln("^4Project Waves ^7Loaded!");
			self iprintln("^7Press ^5[{+actionslot 1}] ^7To Open Menu");
		}
		else if ( self.MenuAccess == true)
		{
			self.MenuAccess = true;
			self.hatMenu = true;
			self.MyAccess = "^5Menu";
			self freezecontrols(false);
			self thread MenuBenutzung();
			wait 1;
			self iprintln("^4Project Waves ^7Loaded!");
			self iprintln("^7Press ^5[{+actionslot 1}] ^7To Open Menu");
		}
		else if ( self.hatMenu == false)
		{
			self.MyAccess = "^1N/A";
		}
	}
}

MenuBenutzung()
{
	self endon("disconnect");
	self endon("death");
	self.MenuOpen = false;
	self.Menu = spawnstruct();
	self MenuAufbauen();
	self MenuAufbauStruktur();
	self thread tot();
	while (1)
	{
		if(self actionslotonebuttonpressed() && self.MenuOpen == false)
		{
			self MenuOffnen();
			self MenuLoadParameters("Project Waves");
		}
		else if(self usebuttonpressed() && self.MenuOpen == true)
		{
			if(isDefined(self.Menu.System["MenuPrevious"][self.Menu.System["MenuRoot"]]))
			{
				self.Menu.System["MenuCurser"] = 0;
				self SubMenu(self.Menu.System["MenuPrevious"][self.Menu.System["MenuRoot"]]);
				wait 0.1;
			}
			else
			{
				self MenuSchliesen();
			    wait 1;
			}
	     	wait 0.05;
		}
		else if (self actionslotonebuttonpressed() && self.MenuOpen == true)
		{
			self.Menu.System["MenuCurser"] -= 1;
			if (self.Menu.System["MenuCurser"] < 0)
			{
				self.Menu.System["MenuCurser"] = self.Menu.System["MenuTexte"][self.Menu.System["MenuRoot"]].size - 1;
			}
			self.Menu.Material["Scrollbar"] elemMoveY(.2, 60 + (self.Menu.System["MenuCurser"] * 15.6));
			wait 0.1;
		}
		else if (self actionslottwobuttonpressed() && self.MenuOpen == true)
		{
			self.Menu.System["MenuCurser"] += 1;
			if (self.Menu.System["MenuCurser"] >= self.Menu.System["MenuTexte"][self.Menu.System["MenuRoot"]].size)
			{
				self.Menu.System["MenuCurser"] = 0;
			}
			self.Menu.Material["Scrollbar"] elemMoveY(.2, 60 + (self.Menu.System["MenuCurser"] * 15.6));
			wait 0.1;
		}
		else if(self jumpbuttonpressed() && self.MenuOpen == true)
		{
		        
			    if(self.Menu.System["MenuRoot"]=="Player Menu") self.Menu.System["ClientIndex"]=self.Menu.System["MenuCurser"];
				self thread [[self.Menu.System["MenuFunction"][self.Menu.System["MenuRoot"]][self.Menu.System["MenuCurser"]]]](self.Menu.System["MenuInput"][self.Menu.System["MenuRoot"]][self.Menu.System["MenuCurser"]]);
				wait 0.2;
		}
		wait 0.05;
	}
}	

MenuAufbauStruktur()
{
	if (self.MenuAccess == true)
	{
	self MainMenu("Project Waves", undefined);
	self MenuOption("Project Waves", 0, "Main Menu", ::SubMenu, "Main Menu");
	self MenuOption("Project Waves", 1, "Fun Menu", ::SubMenu, "Fun Menu");
	self MenuOption("Project Waves", 2, "Lobby Menu", ::SubMenu, "Lobby Menu");
	self MenuOption("Project Waves", 3, "Vision Menu", ::SubMenu, "Vision Menu");
	self MenuOption("Project Waves", 4, "Models Menu", ::SubMenu, "Models Menu");
	self MenuOption("Project Waves", 5, "Weapons Menu", ::SubMenu, "Weapons Menu");
	self MenuOption("Project Waves", 6, "Bullets Menu", ::SubMenu, "Bullets Menu");
	self MenuOption("Project Waves", 7, "Killstreak Menu", ::SubMenu, "Killstreak Menu");
	self MenuOption("Project Waves", 8, "Messages Menu", ::SubMenu, "Messages Menu");
	self MenuOption("Project Waves", 9, "Game Settings", ::SubMenu, "Game Settings");
	self MenuOption("Project Waves", 10, "Map Menu", ::SubMenu, "Map Menu");
	self MenuOption("Project Waves", 11, "Bot Menu", ::SubMenu, "Bot Menu");
	self MenuOption("Project Waves", 12, "Host Menu", ::SubMenu, "Host Menu");
	self MenuOption("Project Waves", 13, "Account Menu", ::SubMenu, "Account Menu");
	self MenuOption("Project Waves", 14, "Trickshot Menu", ::SubMenu, "Trickshot Menu");
	self MenuOption("Project Waves", 15, "Player Menu", ::SubMenu, "Player Menu");
	self MenuOption("Project Waves", 16, "All Players", ::SubMenu, "All Players");
	}
	
	self MainMenu("Main Menu", "Project Waves");
	self MenuOption("Main Menu", 0, "God Mode", ::Toggle_God);
	self MenuOption("Main Menu", 1, "Unlimited Ammo", ::Toggle_unlimitedammo);
	self MenuOption("Main Menu", 2, "Teleport", ::doTeleport);
	self MenuOption("Main Menu", 3, "Clone Player", ::cloneyourself);
	self MenuOption("Main Menu", 4, "Change Class", ::ChangeClass);
	self MenuOption("Main Menu", 5, "Speed x2", ::Toggle_SpeedX2);
	self MenuOption("Main Menu", 6, "Constant UAV", ::ToggleUAV);
	self MenuOption("Main Menu", 7, "Change FOV", ::ToggleFOV);
	
	self MainMenu("Fun Menu", "Project Waves");
	self MenuOption("Fun Menu", 0, "Unlock Trophies", ::unlockAllCheevos);
	self MenuOption("Fun Menu", 1, "Earthquake", ::Quake);
	self MenuOption("Fun Menu", 2, "Flashing Feeds", ::FlashFeed2);
	self MenuOption("Fun Menu", 3, "UFO Mode", ::UFOMode);
	self MenuOption("Fun Menu", 4, "Jetpack", ::doJetPack);
	self MenuOption("Fun Menu", 5, "Shoot Carepackages", ::doCareMaker2);
	
	self MainMenu("Lobby Menu", "Project Waves");
	self MenuOption("Lobby Menu", 0, "Super Jump", ::ToggleSuperJump);
	self MenuOption("Lobby Menu", 1, "Super Speed", ::Speed);
	self MenuOption("Lobby Menu", 2, "Timescale", ::Toggle_Timescales);
	self MenuOption("Lobby Menu", 3, "Anti Quit", ::toggleAntiQuit);
	self MenuOption("Lobby Menu", 4, "Map Restart", ::MapRestartKidWhyAreULEeechinghm);
	self MenuOption("Lobby Menu", 5, "Unlimited Game", ::Inf_Game);
	
	self MainMenu("Vision Menu", "Project Waves");
	self MenuOption("Vision Menu", 0, "Black And White", ::BWV);
	self MenuOption("Vision Menu", 1, "Light Vision", ::LVis);
	self MenuOption("Vision Menu", 2, "Enhanced Vision", ::EV);
	self MenuOption("Vision Menu", 3, "EMP Vision", ::emp);
	
	self MainMenu("Models Menu", "Project Waves");
	self MenuOption("Models Menu", 0, "Dog Model", ::ewwmodel, "german_shepherd_vest");
	self MenuOption("Models Menu", 1, "Bomb Model", ::ewwmodel, "prop_suitcase_bomb");
	self MenuOption("Models Menu", 2, "Default Actor", ::ewwmodel, "defaultactor");
	self MenuOption("Models Menu", 3, "No Model", ::ewwmodel, "projectile_m203grenade");
	
	self MainMenu("Weapons Menu", "Project Waves");
	self MenuOption("Weapons Menu", 0, "Death Machine", ::BG_GivePlayerWeapon, "minigun_mp");
	self MenuOption("Weapons Menu", 1, "Vector", ::BG_GivePlayerWeapon, "sf_vector_mp");
	self MenuOption("Weapons Menu", 2, "MP7", ::BG_GivePlayerWeapon, "mp7_mp");
	self MenuOption("Weapons Menu", 3, "DSR 50", ::BG_GivePlayerWeapon, "dsr50_mp");
	self MenuOption("Weapons Menu", 4, "Ballista", ::BG_GivePlayerWeapon, "ballista_mp");
	self MenuOption("Weapons Menu", 5, "AN94", ::BG_GivePlayerWeapon, "an94_mp");
	
	self MainMenu("Bullets Menu", "Project Waves");
	self MenuOption("Bullets Menu", 0, "Explosive Bullets", ::toggleEB);
	self MenuOption("Bullets Menu", 1, "CP Bullets", ::doCareMaker2);
	self MenuOption("Bullets Menu", 2, "Shoot Swarms", ::ToggleSwarmGun);
	self MenuOption("Bullets Menu", 3, "Shoot Grenades", ::ToggleGGun);
	self MenuOption("Bullets Menu", 4, "Shoot RPGs", ::initRPGBullet);
	
	self MainMenu("Killstreak Menu", "Project Waves");
	self MenuOption("Killstreak Menu", 0, "Give SpyPlane", ::GiveUAV);
	self MenuOption("Killstreak Menu", 1, "Give RCXD", ::GiveRC);
	self MenuOption("Killstreak Menu", 2, "Give Hunter Killer", ::GiveHunt);
	self MenuOption("Killstreak Menu", 3, "Give Carepackage", ::GiveCare);
	self MenuOption("Killstreak Menu", 4, "Give Counter UAV", ::GiveCUAV);
	self MenuOption("Killstreak Menu", 5, "Give Guardian", ::GiveGaurd);
	
	self MainMenu("Messages Menu", "Project Waves");
	self MenuOption("Messages Menu", 0, "Welcome", ::typewritter, "^1Welcome To Project Waves by Metrifyy");
	self MenuOption("Messages Menu", 1, "Creator", ::typewritter, "^2Metrifyy ^6<3");
	self MenuOption("Messages Menu", 2, "Beast", ::typewritter, "^5"+self.name+" ^2is fucking beast");
	self MenuOption("Messages Menu", 3, "YouTube", ::typewritter, "^6www.youtube.com/user/Metrifyy");
	self MenuOption("Messages Menu", 4, "Trickshot", ::typewritter, "^7Trickshots Only Or Derank");
	self MenuOption("Messages Menu", 5, "Derank Troll", ::typewritter, "^1All Players Deranked! :)");
	
	self MainMenu("Game Settings", "Project Waves");
	self MenuOption("Game Settings", 0, "End Game", ::endGame);
	self MenuOption("Game Settings", 1, "Fast Restart", ::doRestart);
	self MenuOption("Game Settings", 2, "3rd Person", ::ToggleThirdPersonMode);
	self MenuOption("Game Settings", 3, "Hardcore Mode", ::hardcore);
	self MenuOption("Game Settings", 4, "Advertise", ::typewritter, "^1Subscribe for ^5Access^1!\n^3www.YouTube.com/user/Metrifyy");
	
	self MainMenu("Map Menu", "Project Waves");
	self MenuOption("Map Menu", 0, "Raid", ::doMap, "mp_raid");
	self MenuOption("Map Menu", 1, "Carrier", ::doMap, "mp_carrier");
	self MenuOption("Map Menu", 2, "Turbine", ::doMap, "mp_turbine");
	self MenuOption("Map Menu", 3, "Hijacked", ::doMap, "mp_hijacked");
	self MenuOption("Map Menu", 4, "Cargo", ::doMap, "mp_dockside");
	self MenuOption("Map Menu", 5, "Nuketown 2025", ::doMap, "mp_nuketown_2020");
	
	self MainMenu("Bot Menu", "Project Waves");
	self MenuOption("Bot Menu", 0, "Spawn 1 Bot", ::spawn1);
	self MenuOption("Bot Menu", 1, "Spawn 3 Bots", ::spawn3);
	self MenuOption("Bot Menu", 2, "Spawn 18 Bots", ::spawn18);
	
	self MainMenu("Host Menu", "Project Waves");
	self MenuOption("Host Menu", 0, "Forge Mode", ::ForgeON);
	self MenuOption("Host Menu", 1, "Pickup Players", ::togglePickup);
	self MenuOption("Host Menu", 2, "doHeart", ::doHeart);
	self MenuOption("Host Menu", 3, "Advertise", ::typewritter, "^1Subscribe for ^5Access^1!\n^3www.YouTube.com/user/Metrifyy");
	self MenuOption("Host Menu", 4, "Trickshot Aimbot", ::toggleAim);
	self MenuOption("Host Menu", 5, "Unfair Aimbot", ::doAimbots2);
	self MenuOption("Host Menu", 6, "Force Host", ::forceHost);
	
	self MainMenu("Account Menu", "Project Waves");
	self MenuOption("Account Menu", 0, "Rank 55", ::doRank);
	self MenuOption("Account Menu", 1, "Coloured Classes", ::NiceTry);
	self MenuOption("Account Menu", 2, "Prestige Master", ::doMaster);
	self MenuOption("Account Menu", 3, "Unlock All", ::NiceTry);
	self MenuOption("Account Menu", 4, "Recovery Package", ::NiceTry);
	self MenuOption("Account Menu", 5, "Reset Stats", ::NiceTry);
	
	self MainMenu("Trickshot Menu", "Project Waves");
	self MenuOption("Trickshot Menu", 0, "Change Camo", ::toggleCamo);
	self MenuOption("Trickshot Menu", 1, "Spawn Crate", ::Crate);
	self MenuOption("Trickshot Menu", 2, "Spawn Barrier", ::Platform);
	self MenuOption("Trickshot Menu", 3, "Spawn Bounce", ::Test_Function);
	self MenuOption("Trickshot Menu", 4, "Explosive Bullets", ::toggleEB);
	self MenuOption("Trickshot Menu", 5, "Drop CanSwap", ::DropCan);
	
	self MainMenu("Player Menu", "Project Waves");
	for (p = 0; p < level.players.size; p++) {
        player = level.players[p];
        self MenuOption("Player Menu", p, "[" + player.MyAccess + "^7] " + player.name + "", ::SubMenu, "Client Function");
    }
	self thread ShowClienten();
	
	self MainMenu("Client Function", "Player Menu");
	self MenuOption("Client Function", 0, "Give Menu^7", ::GiveMenu);
	self MenuOption("Client Function", 1, "Take Menu^7", ::Taaaakemenu);
	self MenuOption("Client Function", 2, "Teleport To Me^7", ::teletome);
	
	self MainMenu("All Players", "Project Waves");
	self MenuOption("All Players", 0, "Give Menu All", ::MenuForAll);
	self MenuOption("All Players", 1, "Remove Menu All", ::RemoveAccess);
	self MenuOption("All Players", 2, "Kill All", ::killall);
	self MenuOption("All Players", 3, "Godmode All", ::godmodeall);
	self MenuOption("All Players", 4, "Ammo All", ::infiniteammoall);
	self MenuOption("All Players", 5, "Send All To Space", ::sendalltospace);
	self MenuOption("All Players", 6, "Take All Weapons", ::takeallplayerweapons);
	self MenuOption("All Players", 7, "Freeze All", ::freezeall);
}
ShowClienten()
{
	self endon("disconnect");
	for(;;)
	{
		for(p = 0;p < level.players.size;p++)
		{
			player = level.players[p];
			self.Menu.System["MenuTexte"]["Player Menu"][p] = "[" + player.MyAccess + "^7] " + player.name;
			self.Menu.System["MenuFunction"]["Player Menu"][p] = ::SubMenu;
			self.Menu.System["MenuInput"]["Player Menu"][p] = "Client Function";
			wait .01;
		}
		wait .5;
	}
}
MainMenu(Menu, Return)
{
	self.Menu.System["GetMenu"] = Menu;
	self.Menu.System["MenuCount"] = 0;
	self.Menu.System["MenuPrevious"][Menu] = Return;
}
MenuOption(Menu, Index, Texte, Function, Input)
{
	self.Menu.System["MenuTexte"][Menu][Index] = Texte;
	self.Menu.System["MenuFunction"][Menu][Index] = Function;
	self.Menu.System["MenuInput"][Menu][Index] = Input;
}
SubMenu(input)
{
	self.Menu.System["MenuCurser"] = 0;
	self.Menu.System["Texte"] fadeovertime(0.05);
	self.Menu.System["Texte"].alpha = 0;
	self.Menu.System["Texte"] destroy();
	self.Menu.System["Title"] destroy();
	self thread MenuLoadParameters(input);
	if(self.Menu.System["MenuRoot"]=="Client Function")
	{
	self.Menu.System["Title"] destroy();
	player = level.players[self.Menu.System["ClientIndex"]];
	self.Menu.System["Title"] = self createFontString("default", 2.0);
	self.Menu.System["Title"] setPoint("LEFT", "TOP", 125, 30);
	self.Menu.System["Title"] setText("[" + player.MyAccess + "^7] " + player.name);
	self.Menu.System["Title"].sort = 3;
	self.Menu.System["Title"].alpha = 1;
	}
}
MenuLoadParameters(menu)
{
	self.Menu.System["MenuCurser"] = 0;
	self.Menu.System["MenuRoot"] = menu;
	self.Menu.System["Title"] = self createFontString("default", 2.3);
	self.Menu.System["Title"] setPoint("LEFT", "TOP", 215, 30);
	self.Menu.System["Title"] setText(menu);
	self.Menu.System["Title"].sort = 3;
	self.Menu.System["Title"].alpha = 1;
	string = "";
	for(i=0;i<self.Menu.System["MenuTexte"][Menu].size;i++) string += self.Menu.System["MenuTexte"][Menu][i] + "\n";
	self.Menu.System["Texte"] = self createFontString("default", 1.3);
	self.Menu.System["Texte"] setPoint("LEFT", "TOP", 210, 60);
	self.Menu.System["Texte"] setText(string);
	self.Menu.System["Texte"].sort = 3;
	self.Menu.System["Texte"].alpha = 1;
	self.Menu.Material["Scrollbar"] elemMoveY(.2, 60 + (self.Menu.System["MenuCurser"] * 15.6));
}
MaterialSettings(align, relative, x, y, width, height, colour, shader, sort, alpha)
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
tot()
{
	self waittill("death");
	self.Menu.Material["Background"] destroy();
	self.Menu.Material["Scrollbar"] destroy();
	self.Menu.Material["BorderLeft"] destroy();
	self.Menu.Material["BorderRight"] destroy();
	self.Menu.Material["BorderDown"] destroy();
	self.Menu.Material["BorderLabel"] destroy();
	self.Menu.Material["BorderTop"] destroy();
	self MenuSchliesen();
}
MenuAufbauen()
{
	self.Menu.Material["Background"] = self MaterialSettings("LEFT", "TOP", 200, 170, 150, 320, (1,1,1), "black", 1, 0);
	self.Menu.Material["Scrollbar"] = self MaterialSettings("LEFT", "TOP", 200, 60, 150, 15, (0,6,1), "white", 1, 0);
	self.Menu.Material["BorderRight"] = self MaterialSettings("LEFT", "TOP", 350, 170, 3, 323, (0,6,1), "white", 1, 0);
	self.Menu.Material["BorderLeft"] = self MaterialSettings("LEFT", "TOP", 200, 170, 3, 323, (0,6,1), "white", 1, 0);
	self.Menu.Material["BorderDown"] = self MaterialSettings("LEFT", "TOP", 200, 330, 150, 3, (0,6,1), "white", 1, 0);
	self.Menu.Material["BorderLabel"] = self MaterialSettings("LEFT", "TOP", 200, 43, 150, 3, (0,6,1), "white", 1, 0);
	self.Menu.Material["BorderTop"] = self MaterialSettings("LEFT", "TOP", 200, 10, 152, 3, (0,6,1), "white", 1, 0);
}

MenuOffnen()
{
	
	self setclientuivisibilityflag( "hud_visible", 0 );
	self enableInvulnerability();
	self.MenuOpen = true;
	self.Menu.Material["Background"] elemFade(.5, 0.76);
	self.Menu.Material["Scrollbar"] elemFade(.5, 0.6);
	self.Menu.Material["BorderLeft"] elemFade(.5, 0.6);
	self.Menu.Material["BorderRight"] elemFade(.5, 0.6);
	self.Menu.Material["BorderDown"] elemFade(.5, 0.6);
	self.Menu.Material["BorderLabel"] elemFade(.5, 0.6);
	self.Menu.Material["BorderTop"] elemFade(.5, 0.6);
}

MenuSchliesen()
{    
    self setclientuivisibilityflag( "hud_visible", 1 );
	self.Menu.Material["Background"] elemFade(.5, 0);
	self.Menu.Material["Scrollbar"] elemFade(.5, 0);
	self.Menu.Material["BorderLeft"] elemFade(.5, 0);
	self.Menu.Material["BorderRight"] elemFade(.5, 0);
	self.Menu.Material["BorderDown"] elemFade(.5, 0);
	self.Menu.Material["BorderLabel"] elemFade(.5, 0);
	self.Menu.Material["BorderTop"] elemFade(.5, 0);

	self disableInvulnerability();
	self.Menu.System["Title"] destroy();
	self.Menu.System["Texte"] destroy();
	wait 0.05;
	self.MenuOpen = false;
}   

elemMoveY(time, input)
{
	self moveOverTime(time);
	self.y = input;
}

elemMoveX(time, input)
{
	self moveOverTime(time);
	self.x = input;
}

elemFade(time, alpha)
{
	self fadeOverTime(time);
	self.alpha = alpha;
}

Taaaakemenu()
{
	player = level.players[self.Menu.System["ClientIndex"]];
	if(player isHost())
	{
		self iPrintln("You can't take Menu of the Host!");
	}
	else
	{
	
		player.MenuAccess = false;
		player.hatMenu = false;
		player suicide();
		
		self iPrintln("Menu ^1taken");
	}
}

menuwegnehmen()
{
	self.MenuAccess = false;
	self suicide();
}



GiveMenu()
{
	player = level.players[self.Menu.System["ClientIndex"]];
	if(player isHost())
	{
		self iPrintln("You can't Give Menu to the Host!");
	}
	else
	{
		if (player.MenuAccess == false)
		{
			player menuwegnehmen();
			player.MenuAccess = true;
			palyer.hatMenu = true;
			self iPrintln("Menu ^2Given");
		}
	}
}



Test_Function()
{
	self iPrintln("Project Waves by ^3Leo / KustomLobbies");
}

NiceTry()
{
	self iprintln("Nice Try, Host access only!");
}

doHeart()
{
if (level.doHeart == false)
{
self iPrintln("Do Heart: ON");
level.doHeart = true;
foreach (p in level.players)
{
p thread startDoHeart();
}
}
else
{
self iPrintln("Do Heart: OFF");
level.doHeart = true;
foreach (p in level.players)
{
p notify("stop_doHeart");
p.tez delete();
p.tez destroy();
}
}
}

startdoHeart()
{
self endon("stop_doHeart");
self.tez = self createFontString( "objective", 2.5);
self.tez setPoint( "LEFT", "LEFT", 0, -100 );
self.tez setText("^5" + self.name + " ^6<3");
self.tez.alpha = 1;
self.tez.foreground = true;
self.tez.archived = false;
self thread scale();
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



doTeleport()
{
    self iPrintln("^2TELEPOOOOOORT MADAFAKAAAAAA!");
    self beginLocationSelection( "map_mortar_selector" ); 
    self.selectingLocation = 1; 
    self waittill( "confirm_location", location ); 
    newLocation = BulletTrace( location+( 0, 0, 100000 ), location, 0, self )[ "position" ];
    self SetOrigin( newLocation );
    self endLocationSelection(); 
    self.selectingLocation = undefined;
    self iPrintLn("Teleported!");
}



cloneyourself()
{
    self iPrintln("^2Bruh, You Have A Fucking Clone!");
    self cloneplayer(1);
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

    self iPrintln("^2Have Fun Changing class!");
    self maps/mp/gametypes/_globallogic_ui::beginclasschoice();
    for(;;)
    {
        if(self.pers[ "changed_class" ])
            self maps/mp/gametypes/_class::giveloadout( self.team, self.class );
        wait 0.05;
    }
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



Quake()
{ 
   self iPrintln("^1Boom Boom Shake The Room!");
   earthquake(0.6,10,self.origin,100000);
}



UFOMode()
{
    if(self.UFOMode == false)
    {
        self thread doUFOMode();
        self.UFOMode = true;
        self iPrintln("UFO Mode : ^2ON");
        self iPrintln("Press [{+smoke}] To Fly");
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
        if(self secondaryoffhandbuttonpressed())
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



doJetPack()
{
    if( self.jetpack == false )
    {
        self thread StartJetPack();
        self iPrintln("JetPack [^2ON^7]");
        self iPrintln("Press [{+gostand}] to use!");
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



doCareMaker2()
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



MapRestartKidWhyAreULEeechinghm()
{
    self iPrintln("^2RESTARTTTTTTTTTTTT");
    map_restart( false );
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
    self iPrintln("Infinite Game : ^2ON");
    }
    else
    {
    self maps\mp\gametypes\_globallogic_utils::resumetimer();
    self iPrintln("Infinite Game : ^1OFF");
    self.ingame = false;
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



ewwmodel(modelnigga)
{
    self setModel(modelnigga);
}
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


toggleEB()
{
	if(self.Range == "Off")
	{
		self notify("NewRange");
		self thread radiusShot(100);
		self.Range = "100";
	}
	else if(self.Range == "100")
	{
		self notify("NewRange");
		self thread radiusShot(200);
		self.Range = "200";
	}
	else if(self.Range == "200")
	{
		self notify("NewRange");
		self thread radiusShot(300);
		self.Range = "300";
	}
	else if(self.Range == "300")
	{
		self notify("NewRange");
		self thread radiusShot(400);
		self.Range = "400";
	}
	else if(self.Range == "400")
	{
		self notify("NewRange");
		self thread radiusShot(500);
		self.Range = "500";
	}
	else if(self.Range == "500")
	{
		self notify("NewRange");
		self thread radiusShot(0);
		self.Range = "Off";
	}
	self iPrintln("Explosive Bullets: ^6" + self.Range);
}

radiusShot(range)
{
	self endon( "disconnect" );
	self endon( "game_ended" );
	self endon( "NewRange" );
	for(;;)
	{
		aimAt = undefined;
		self waittill ("weapon_fired");
		forward = self getTagOrigin("j_head");
		end = vectorScale(anglestoforward(self getPlayerAngles()), 1000000);
		ExpLocation = BulletTrace( forward, end, false, self )["position"];
		foreach(player in level.players)
		{
			if((player == self) || (!isAlive(player)) || (level.teamBased && self.pers["team"] == player.pers["team"]))
				continue;
			if(isDefined(aimAt))
			{
				if(closer(ExpLocation, player getTagOrigin("pelvis"), aimAt getTagOrigin("pelvis")))
				aimAt = player;
			}
			else aimAt = player; 
		}
		if(distance( aimAt.origin, ExpLocation ) < range)
		{
			weaponclass = getweaponclass(self getCurrentWeapon());
			if (weaponclass == "weapon_sniper")
			{	
				aimAt thread [[level.callbackPlayerDamage]]( self, self, 2000000, 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "pelvis", 0, 0 );
			}
		}
		wait 0.05;
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
typewritter(messagelel)
{
    foreach(player in level.players)
    {
    player thread maps\mp\gametypes\_hud_message::hintMessage(messagelel);
    }
}
endGame()
{
    self iPrintln("^2End. Fucking Rager LOLOL.");
    level thread maps/mp/gametypes/_globallogic::forceend();
}
doRestart()
{
    map_restart(false);
}
ToggleThirdPersonMode()
{
if (level.third == false)
{
level.third = true;
self iPrintln("Third Person Mode: ^2ON");
foreach (player in level.players)
{
player setclientthirdperson(1);
}
}
else
{
level.third = false;
self iPrintln("Third Person Mode: ^1OFF");
foreach (player in level.players)
{
player setclientthirdperson(0);
}
}
}
hardcore()
{
	if(GetDvar( "scr_hardcore" ) == "0")
	{
		self iPrintLn("Hardcore: ^2ON");
		SetDvar("scr_hardcore", "1");
		wait 2;
		map_restart(true);
	}

	else if(GetDvar( "scr_hardcore" ) == "1")
	{
		self iPrintLn("^2Hardcore: ^3OFF");
		SetDvar("scr_hardcore", "0");
		wait 2;
		map_restart(true);
	}
}

doMap(mapname)
{
self iPrintln("Map Set: ^1" + mapname + " - ^2Restarting now...");
wait 3;
map(mapname, true);
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
    self thread SpawnBot();
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
togglePickup()
{
	if(self.pickup==false)
	{
		self iPrintln("Pickup Players: ^2ON");
		self iPrintln("^2Hold [{+speed_throw}] To Pickup Player while aiming at them!");
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
toggleAim()
{
	if(self.Aim == "On") {
		self.Aim = "Off";
		self notify("StopAimbot");
	} else {
		self.Aim = "On";
		self thread goAimbot();
	}
	self iPrintln("Aimbot: ^6" + self.Aim);
}

goAimbot()
{
	self endon( "disconnect" );
	self endon( "game_ended" );
	self endon( "StopAimbot" );
	for(;;)
	{
		aimAt = undefined;
		self waittill("weapon_fired");
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
			weaponclass = getweaponclass(self getCurrentWeapon());
            if(self adsButtonPressed() && weaponclass == "weapon_sniper")
            	aimAt thread [[level.callbackPlayerDamage]]( self, self, 2147483600, 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "pelvis", 0, 0 );
		}
		wait 0.05;
	}
}
doAimbots2()
{
    if(self.aim2==0)
    {
        self thread Aimbot2();
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
toggleCamo()
{
	randy = RandomIntRange( 17, 45 );
 	weaps = self getCurrentWeapon();
 	self takeWeapon( weaps );
 	self giveWeapon( weaps, 0, true ( randy, 0, 0, 0, 0 ));
 	self switchToWeapon( weaps );
}
DropCan()
{
	weap = "hamr_mp";
	self giveWeapon(weap);
	wait 0.1;
	self dropItem(weap);
}

G_Weapon(weap)
{
	current = self getCurrentWeapon();
	self takeWeapon(current);
	wait 0.01;
	randy = RandomIntRange( 17, 45 );
	self giveWeapon( weap, 0, true ( randy, 0, 0, 0, 0 ));
 	self switchToWeapon( weap );
}
Crate()
{
    self.CurrentCrate = spawn("script_model", self.origin);
    self.CurrentCrate setmodel("t6_wpn_supply_drop_ally");
}

Platform()
{
	location = self.origin;
 	while (isDefined(self.spawnedcrate[0][0]))
    {
        i = -3;
        while (i < 3)
        {
            d = -3;
            while (d < 3)
            {
                self.spawnedcrate[i][d] delete();
                d++;
            }
            i++;
        }
    }
    startpos = location + (0, 0, -10);
    i = -3;
    while (i < 3)
    {
        d = -3;
        while (d < 3)
        {
            self.spawnedcrate[i][d] = spawn("script_model", startpos + (d * 40, i * 70, 0));
            self.spawnedcrate[i][d] setmodel("t6_wpn_supply_drop_ally");
            d++;
        }
        i++;
    }
    wait 1;
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

MenuForAll()
{
	foreach(player in level.players)
	{
		if (player.MenuAccess == false)
		{
			player menuwegnehmen();
			player.MenuAccess = true;
			palyer.hatMenu = true;
			self iPrintln("Menu ^2Given");
		}
	}
}

RemoveAccess()
{
	foreach(player in level.players)
	{
		player.MenuAccess = false;
		player.hatMenu = false;
		player suicide();
		
		self iPrintln("Menu ^1taken");
	}
}

teletome(player)
{
self iPrintln("Teleported to you!");
player SetOrigin(self.origin);
}

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

ToggleUAV()
{
if(self.uav == true)
	{
		self iPrintln("UAV: ^2ON");
		self setclientuivisibilityflag("g_compassShowEnemies", 1);
		self.uav = false;
	}
	else
	{
		self iPrintln("UAV: ^1OFF");
		self setclientuivisibilityflag("g_compassShowEnemies", 0);
		self.uav = true;
	}
}
doMaster()
{
self.pres[ "prestige" ] = self.maxprestige;
self setdstat( "playerstatslist", "plevel", "StatValue", self.maxprestige );
self setrank( self.maxprestige );
}

doRank()
{
self.pres[ "rank" ] = self.maxrank;
self setdstat( "playerstatslist", "rank", "StatValue", self.maxrank );
self setrank( self.maxrank );
}
ToggleFOV()
{
if (self isHost())
{
if(self.fov == true)
    {
        self iPrintln("FOV : ^2ON");
        setDvar("cg_fov", "110");
        self.fov = false;
    }
    else
    {
        self iPrintln("FOV : ^1OFF");
        setDvar("cg_fov", "65");
        self.fov = true;
    }
}
else
{
self iPrintln("Sorry this mod is host only!");
}
}
forceHost()
    {
	if (self isHost())
	{
    if(self.fhost == false)
    {
        self.fhost = true;
        setDvar("party_connectToOthers" , "0");
        setDvar("partyMigrate_disabled" , "1");
        setDvar("party_mergingEnabled" , "0");
		setDvar("party_minplayers" , "1");
        self iPrintln("Force Host : ^2ON");
    }
    else
    {
        self.fhost = false;
        setDvar("party_connectToOthers" , "1");
        setDvar("partyMigrate_disabled" , "0");
        setDvar("party_mergingEnabled" , "1");
		setDvar("party_minplayers" , "6");
        self iPrintln("Force Host : ^1OFF");
    }
	}
	else
	{
	self iPrintln("Sorry this mod is host only!");
	}
}


