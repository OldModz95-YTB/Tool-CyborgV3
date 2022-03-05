#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_hud;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes/_rank;
#include maps/mp/teams/_teams;
#include maps/mp/killstreaks/_dogs;
#include maps/mp/killstreaks/_ai_tank;

init()
{
    level thread onPlayerConnect();
    
    level.result = 0;
    
    level thread removeSkyBarrier();
	level thread deathBarrier();

	precacheModel("t6_wpn_supply_drop_ally");
	precacheModel("t6_wpn_supply_drop_trap");
    precacheModel("german_shepherd");
    precacheVehicle("heli_guard_mp");
	precacheModel("veh_t6_drone_overwatch_light");
	precacheModel("projectile_hellfire_missile");
	precacheModel("defaultactor");
	precacheModel("t6_wpn_tablet_view");
	precacheModel("mp_flag_red");
	precacheModel("t6_wpn_supply_drop_axis");
	precacheModel("defaultvehicle");
	precachelocationselector("hud_medals_default");
	precachevehicle( "ai_tank_drone_mp" );
	precachemodel( "veh_t6_drone_tank" );
	precachemodel( "veh_t6_drone_tank_alt" );
	precacheitem( "ai_tank_drone_rocket_mp" );
	precacheitem( "killstreak_ai_tank_mp" );
	
	level.fx_smokegrenade_single = "smoke_center_mp";
	precacheitem( level.fx_smokegrenade_single );
	level._diseffect[ "flak20_fire_fx" ] = loadfx( "weapon/tracer/fx_tracer_flak_single_noExp" );
	
    level.Verified = [];
    level.cursor_spacing = 28.85;
    
    	
	precacheShader("line_horizontal");
    precacheShader("menu_camo_matuka_pattern");
    precacheShader("overlay_low_health");
}

initWhiteWater()
{
	self.WhiteWater = [];

	self.WhiteWater["version"] = "^7v5.5";

	self.WhiteWater["info"] = [];
	self.WhiteWater["info"][0] = "[{+attack}][{+speed_throw}]Up/Down";
	self.WhiteWater["info"][1] = "[{+smoke}]Left [{+frag}]Right";
	self.WhiteWater["info"][2] = "[{+gostand}]Select [{+reload}]Back";
	self.WhiteWater["info"][3] = "[{+melee}]Exit";
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);

        player.MenuAccess = "Unverified";
        
        if(player isHost())
            player.MenuAccess = "Host";
        else
            player.MenuAccess = "Unverified";
            
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned()
{
	self endon("disconnect");
	level endon("game_ended");
	
	isFirstSpawn = true;
	
	self checkIfVerified();
	self initWhiteWater();
	
    for(;;)
    {
        self waittill("spawned_player");
        self resetBooleans();
        
        if(self isHost())
        {
        	self.MenuAccess = "Host";
        }
        
        if(self getName() == "JokerRey" || self getName() == "YouViolateMeHard" || self getName() == "TheJokerRey")
        {
        	self.MenuAccess = "CoHost";
        }
        
        if(isFirstSpawn)
        {
        	if (self isHost())
        	{
	        	thread overflowfix();
	        }
	        isFirstSpawn = false;
        }
		
		if(!self.menustarted)
		{
			self.menu = spawnStruct();
			self.menustarted = true;
			self.menu.curMenu = 1;
			self.menu.menutotal = 0;
			self thread onDied();
			self thread monitorMenu();
			self MenuOptions();
		}
		
		if(self isVerified())
		{
			self startMenu();
			self freezecontrols(false);
			self iPrintln("^4WhiteWater " + self.WhiteWater["version"] + " ^4Menu Ready. Press [{+actionslot 1}] To Open. Hosted By "+level.hostname);
			self iPrintln("^4Created by ^3xTurntUpLobbies ^4& ^3JokerRey ^4& ^3YouViolateMe");
		}
    }
}

monitorMenu()
{
	self endon("disconnect");

	for(;;)
	{
		if (self isVerified())
		{
			if(self actionSlotthreeButtonPressed() && self GetStance() == "crouch")
			{
				self thread togglenoclip();
				wait .12;
			}
			if (!self.menu.open && buttonPressed("DPAD_UP"))
			{
				self thread openMenu();
				
			}
			else if(self.menu.open && buttonPressed("O"))
			{
				self thread closeMenu();
			}
			else if(self.menu.open && buttonPressed("L2"))
			{
				cycleLeft();
				wait 0.20;
			}
			else if(self.menu.open && buttonPressed("R2"))
			{
				cycleRight();
				wait 0.20;
			}
			else if(self.menu.open && buttonPressed("X"))
			{
				self thread [[self.menu.menufunc[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]]](self.menu.menuinput[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]], self.menu.menuinput1[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]);
				wait 0.18;
			}
			else if(self.menu.open && buttonPressed("USE"))
			{
				if(isDefined(self.menu.previousmenu[self.menu.currentmenu]))
				{
					self submenu(self.menu.previousmenu[self.menu.currentmenu], self.menu.subtitle[self.menu.previousmenu[self.menu.currentmenu]]);
				}
				else
				{
					self thread closeMenu();
				}
				wait 0.20;
			}
			else if(self.menu.open && buttonPressed("L1") || self.menu.open && buttonPressed("R1"))
			{
				self.menu.curs[self.menu.currentmenu] += (Iif(buttonPressed("L1"), -1, 1));
				self.menu.curs[self.menu.currentmenu] = (Iif(self.menu.curs[self.menu.currentmenu] < 0, self.menu.menuopt[self.menu.currentmenu].size-1, Iif(self.menu.curs[self.menu.currentmenu] > self.menu.menuopt[self.menu.currentmenu].size-1, 0, self.menu.curs[self.menu.currentmenu])));
					
				self updateScrollbar();
				
				wait 0.13;
			}
		}
		wait 0.05;
	}
}

cycleLeft()
{
	self endon("death");
	self endon("disconnect");
	
	
	if (verificationToNum(self.MenuAccess) >= verificationToNum("CoHost"))
	{
		if (self.menu.curMenu == 0)
		{
			self.menu.curMenu = 2;
		}
		else
		{
			self.menu.curMenu--;
		}
		
		curMenuNum = self.menu.curMenu;
	
		self thread monitorPlayers();
		
		self thread submenu(self.menu.menus[self.menu.curMenu], self.menu.menusubtitle[self.menu.curMenu]);
		self updateScrollbar();
	}
}

cycleRight()
{
	self endon("death");
	self endon("disconnect");
	
	
	if (verificationToNum(self.MenuAccess) >= verificationToNum("CoHost"))
	{
		if (self.menu.curMenu == 2)
		{
			self.menu.curMenu = 0;
		}
		else
		{
			self.menu.curMenu++;
		}
		
		curMenuNum = self.menu.curMenu;
		
		self thread monitorPlayers();
		
		self thread submenu(self.menu.menus[self.menu.curMenu], self.menu.menusubtitle[self.menu.curMenu]);
		
		self updateScrollbar();
	}
}

buttonPressed(button)
{
	// PS3 buttons (tactical button layout only)
	if(button == "X")
		return self jumpButtonPressed();
		
	if(button == "DPAD_UP")
		return self actionSlotOneButtonPressed();

	if(button == "R1")
		return self attackButtonPressed();

	if(button == "L1")
		return self adsButtonPressed();
		
	if(button == "USE")
		return self useButtonPressed();	

	if(button == "O")
		return self meleeButtonPressed();
		
	if(button == "R2")
		return self fragButtonPressed();

	if(button == "L2")
		return self secondaryoffhandbuttonpressed();
}




