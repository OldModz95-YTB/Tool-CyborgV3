#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_weapons;
#include maps/mp/gametypes/_hud_message;
#include maps/mp/gametypes/_hud;
#include maps/mp/gametypes/_rank;
#include maps/mp/gametypes/_challenges;
#include maps/mp/gametypes/_fxanim;


init()
{
    level thread onplayerconnect();
    level.activesky1 = 0;
    level.firstspawn1 = true;
    level.merrySpawned = 0;
	level.supplyDropModelAxis = "t6_wpn_supply_drop_axis";
	level.supplyDropModelTrap = "t6_wpn_supply_drop_trap";
	level.activeDoors = 0;
precacheShader("hud_remote_missile_target");
precacheShader("headicon_dead");
PrecacheModel("defaultactor");
PrecacheModel("veh_t6_nuketown_2020_car02_whole");
PrecacheModel("dest_nt_nuked_female_03_d0");
	PrecacheModel("mp_flag_neutral");
	PrecacheModel("defaultvehicle");
	PrecacheModel("veh_t6_drone_tank");
	PrecacheModel("veh_t6_drone_rcxd");
	PrecacheModel("veh_t6_drone_cuav");
	PrecacheModel("veh_t6_drone_quad_rotor_mp");
	PrecacheModel("auto_gun_turret_mp");
	PrecacheModel("heli_gunner_rockets_mp");
	PrecacheModel("straferun_rockets_mp");
	PrecacheModel("chopper_minigun_mp");
	PrecacheModel("mounted_turret_stand");
	PrecacheModel("german_shepherd");
	PrecacheModel("mp_flag_green");
	PrecacheModel("mp_flag_allies_1");
	PrecacheModel("mp_flag_red");
	PrecacheModel("p6_dogtags");

   	precacheModel("german_shepherd");
	precacheModel("vehicle_mi24p_hind_desert_d_piece02");
	precacheModel("t6_wpn_supply_drop_ally");
	precacheModel("mp_flag_green");
	precacheModel("mp_flag_red");
	precacheModel("t6_wpn_supply_drop_axis");
	precacheModel("veh_t6_drone_uav");
	precacheModel("veh_t6_air_fa38_killstreak");
	precacheModel("veh_t6_drone_tank");
	precacheModel("veh_t6_drone_overwatch_dark");
	precacheModel("veh_t6_drone_pegasus_mp");
	precacheModel("prop_suitcase_bomb");
    precacheModel("t6_wpn_supply_drop_trap");
    precacheModel("projectile_hellfire_missile");
	precacheVehicle("heli_guard_mp");
	precacheModel("veh_t6_drone_overwatch_light");
	precachemodel( "c_chn_mp_pla_sniper_w_fb" );
	precachemodel( "c_chn_mp_pla_longsleeve_w_viewhands" );
	 precacheShader("line_horizontal");
	precacheShader("menu_camo_tiger_blue_pattern");
precacheShader("menu_camo_mtx_massacre_32");
precacheShader("menu_camo_mtx_ghost_32");
precacheShader("menu_camo_gold_pattern");
precacheShader("menu_camo_mtx_dragon_32");
precacheShader("menu_camo_mtx_afterlife_32");
precacheShader("mtl_weapon_camo_roxann");
precacheShader("menu_camo_carbon_pattern");
precacheShader("menu_camo_mtx_pap_32");
precacheShader("mtl_weapon_camo_wanted");
precacheShader("menu_camo_blossom_pattern");
precacheShader("menu_camo_diamond_pattern");
precacheShader("emblem_bg_movie_star");
precacheShader("emblem_bg_partyrock");
precacheShader("emblem_bg_dayofdead");
precacheShader("em_bg_prestige_11");
precacheShader("em_bg_flag_netherlands");
precacheShader("em_bg_flag_macedonia");
precacheShader("em_bg_flag_wales");
precacheShader("em_bg_flag_united_kingdom");
precacheShader("em_bg_flag_bhutan");
precacheShader("em_bg_flag_south_korea");
precacheShader("em_bg_flag_isle_of_man");
precacheShader("em_bg_flag_albania");
precacheShader("em_bg_flag_seychelles");
precacheShader("em_bg_flag_guyana");
	
    level.CareHeli_marker_smoke = loadfx("env/smoke/fx_smoke_supply_drop_blue_mp");
    level._diseffect[ "flak20_fire_fx" ] = loadfx( "weapon/tracer/fx_tracer_flak_single_noExp" );
    level._effect[ "rcbombexplosion" ] = loadfx( "maps/mp_maps/fx_mp_exp_rc_bomb" );
    level.waypointGreen=loadFX("misc/fx_equip_tac_insert_light_grn");
    level.waypointRed=loadFX("misc/fx_equip_tac_insert_light_red");
    level._effect["torch"] = loadfx( "maps/mp_maps/fx_mp_exp_rc_bomb" );
    level._effect["satchel_charge_enemy_light"] = loadfx( "weapon/c4/fx_c4_light_red" );
	level._effect["satchel_charge_friendly_light"] = loadfx( "weapon/c4/fx_c4_light_green" );
    level.supplyDropModel = "t6_wpn_supply_drop_ally";
    level.deads = "headicon_dead";
    level.esps = "hud_remote_missile_target";
    level.B = 0; //DONT CHANGE
    level.BounceLimit = 5; //You Can Change
        level.result = 0;

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
        player thread monitorBounce();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self freezecontrols(false);
    self.MenuInit = false;
    isFirstSpawn = true;
    self.CurMenu = "Main Menu";
	self.CurTitle = "Main Menu";
	self.Typewriter = false;
    for(;;)
    {
		self waittill( "spawned_player" );
		        if(isFirstSpawn)
        	{
	        	thread overflowfix();
	        	isFirstSpawn = false;
	        }
		if( self.status == "Host" || self.status == "Co-Host" || self.status == "Admin" || self.status == "VIP" || self.status == "Verified")
		{
			if (!self.MenuInit)
			{
				self.MenuInit = true; 
				self thread MenuInit();
				self freezecontrols(false);
				self thread closeMenuOnDeath();
				self.menu.backgroundinfo = self drawShader(level.icontest, -25, -100, 250, 1000, (0, 1, 0), 1, 0);
                self.menu.backgroundinfo.alpha = 0;
                self.swagtext = self createFontString( "hudbig", 2.8);
                self.swagtext setPoint( "right", "right", 17, -165 );
                self.swagtext setText("");
                self notify("textset");
                level.result += 1;
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
    self notify("textset");
    level.result += 1;
    hud.x = x;
    hud.y = y;
    hud.color = color;
    hud.alpha = alpha;
    hud.glowColor = glowColor;
    hud.glowAlpha = glowAlpha;
    hud.sort = sort;
    hud.alpha = alpha;
    hud.archived = false;
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
    hud.archived = false;
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

closeMenuOnVerChange()
{
	self submenu("Main Menu", "Main Menu");
	closeMenu();
	self resetBooleans();
}

resetBooleans()
{
	self.thirdPerson = false;
	self.UFO = false;
	self.speedScaleX2 = false;
	self.InfiniteHealth = false;
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


welcomeMessage(text, text1, icon, glow)
{
 hmb=spawnstruct();
 hmb.titleText= "^1Welcome To ^2KissMyAimbot- ^1Menu.";
 hmb.notifyText= "Your Status Is: " + verificationToColor(self.status);
 hmb.glowColor= (9, 0.2, 1);
 hmb.hideWhenInMenu=true;
 hmb.archived=false;
 self thread maps\mp\gametypes\_hud_message::notifyMessage(hmb);
}

CreateMenu()
{
	self add_menu("Main Menu", undefined, "Unverified");
	self add_option("Main Menu", "Main Modz", ::submenu, "Main Modz", "Main Modz");
	self add_option("Main Menu", "Trickshotz", ::submenu, "Trickshotz", "Trickshotz");
	self add_option("Main Menu", "Model Menu", ::submenu, "Model Menu", "Model Menu");
	self add_option("Main Menu", "Host", ::submenu, "Host", "Host");
	self add_option("Main Menu", "Acount", ::submenu, "Acount", "Acount");
	self add_option("Main Menu", "Weapon Menu", ::submenu, "Weapon Menu", "Weapon Menu");
	self add_option("Main Menu", "Lobby Settings", ::submenu, "Lobby Settings", "Lobby Settings");
	self add_option("Main Menu", "Killstreaks Menu", ::submenu, "Killstreaks Menu", "Killstreaks Menu");
	self add_option("Main Menu", "Messages Menu", ::submenu, "Messages Menu", "Messages Menu");
	self add_option("Main Menu", "Change Map", ::submenu, "Change Map", "Change Map");
	self add_option("Main Menu", "Bullets Type", ::submenu, "Bullets Type", "Bullets Type");
	self add_option("Main Menu", "Visions", ::submenu, "Visions", "Visions");
	self add_option("Main Menu", "Camo Changer", ::submenu, "Camo Changer", "Camo Changer");
	self add_option("Main Menu", "Fun Zone", ::submenu, "Fun Zone", "Fun Zone");
	self add_option("Main Menu", "Page 2", ::submenu, "Page 2", "Page 2");
	

	self add_menu("Main Modz", "Main Menu", "VIP");
	self add_option("Main Modz", "God Mode", ::Toggle_God);
	self add_option("Main Modz", "unlimited Ammo", ::infiniteammo);
	self add_option("Main Modz", "unlimited grenades", ::unlimited_ammo);
	self add_option("Main Modz", "Teleport", ::doTeleport);
	self add_option("Main Modz", "Advanced No Clip", ::doNoClip);
	self add_option("Main Modz", "Give Scorestreaks", ::GiveScorestreaks);
	self add_option("Main Modz", "Kill Your Self", ::doSuicide);
	self add_option("Main Modz", "Orbital Vsat", ::ToggleUAV2);
	self add_option("Main Modz", "UAV Hack", ::GiveUAVhack);
	self add_option("Main Modz", "Invisable", ::Toggle_Hideeeeee);
	self add_option("Main Modz", "Speed 2x", ::Toggle_SpeedX2);
	self add_option("Main Modz", "All Perkz", ::doPerks);
	self add_option("Main Modz", "Clone Your self", ::cloneyourself);
    self add_option("Main Modz", "Third Person", ::ThirdPerson);
	self add_option("Main Modz", "Change Class In Game", ::ChangeClass);
	self add_option("Main Modz", "Wallhack / Redboxes", ::ToggleWallhack);
	self add_option("Main Modz", "Save and load", ::saveandload);
	
	self add_menu("Trickshotz", "Main Menu", "Co-Host");
	self add_option("Trickshotz", "Explosive Bullets", ::toggleEB);
	self add_option("Trickshotz", "Trickshot Aimbot", ::doTrickshotBinds);
	self add_option("Trickshotz", "Drop Can Swap (MP7)", ::DropCan,"mp7_mp");
	self add_option("Trickshotz", "Drop Can Swap (DSR)", ::DropCan,"dsr50_mp+steadyaim");
	self add_option("Trickshotz", "Drop Can Swap (Remington)", ::DropCan,"870mcs_mp+reflex");
	self add_option("Trickshotz", "Drop Can Swap (Ballistic Knife)", ::DropCan,"knife_ballistic_mp");
	self add_option("Trickshotz", "Auto Nac Swap", ::AutoNac);
	self add_option("Trickshotz", "Auto Infinite Fade", ::AutoInfiniteFade);
	
	self add_menu("Model Menu", "Main Menu", "Admin");
	self add_option("Model Menu", "Change Model Dog", ::SetSelfModel,"german_shepherd",2);
	self add_option("Model Menu", "Change Model Car", ::SetSelfModel,"defaultvehicle",2);
	self add_option("Model Menu", "Change Model Flag", ::SetSelfModel,"mp_flag_red",2);
    self add_option("Model Menu", "Change Model UAV", ::SetSelfModel,"veh_t6_drone_uav",2);
	self add_option("Model Menu", "Change Model FA38", ::SetSelfModel,"veh_t6_air_fa38_killstreak",2);
	self add_option("Model Menu", "Change Model Overwatch", ::SetSelfModel,"veh_t6_drone_overwatch_dark",2);
	self add_option("Model Menu", "Change Model Lodestar", ::SetSelfModel,"veh_t6_drone_pegasus_mp",2);
    self add_option("Model Menu", "Change Model Bomb", ::SetSelfModel,"prop_suitcase_bomb",2);
    self add_option("Model Menu", "Change Model Box", ::SetSelfModel,"t6_wpn_drop_box",2);
    self add_option("Model Menu", "Change Model VTOL", ::SetSelfModel,"veh_t6_air_v78_vtol_killstreak",2);
    self add_option("Model Menu", "Change Model Heli", ::SetSelfModel,"veh_t6_drone_supply",2);
    self add_option("Model Menu", "Nuketown Models", ::submenu, "Nuketown Models", "Nuketown Models");
    self add_option("Model Menu", "Raid Only Models", ::submenu, "Raid Models", "Raid Models");
	self add_option("Model Menu", "Change Model Normal", ::SetSelfNormal);
	
	self add_menu("Nuketown Models", "Model Menu", "Admin");
	self add_option("Nuketown Models", "Manequin", ::SetSelfModel,"dest_nt_nuked_female_03_d0",2);
    self add_option("Nuketown Models", "Manequin 2", ::SetSelfModel,"dest_nt_nuked_male_01_d0",2);
    self add_option("Nuketown Models", "Manequin 3", ::SetSelfModel,"dest_nt_nuked_female_05_d0",2);
    self add_option("Nuketown Models", "Car 1", ::SetSelfModel, "veh_t6_nuketown_2020_car02_whole",2);
    self add_option("Nuketown Models", "Car 2", ::SetSelfModel, "veh_t6_nuketown_2020_car01_whole",2);
    
    self add_menu("Raid Models", "Model Menu", "Admin");
	self add_option("Raid Models", "Van", ::SetSelfModel,"veh_t6_v_van_whole",2);
	self add_option("Raid Models", "Van 2", ::SetSelfModel,"veh_t6_civ_van_sprinter_whole",2);
	self add_option("Raid Models", "Sports Car", ::SetSelfModel,"veh_t6_civ_sportscar_whole_yellow",2);
	self add_option("Raid Models", "Sedan", ::SetSelfModel,"veh_t6_luxury_sedan_clean_whole",2);
	
    self add_menu("Acount", "Main Menu", "Co-Host");
	self add_option("Acount", "Unlock all Camos", ::camonlock);
	self add_option("Acount", "Unlock all Tropies", ::unlockAllCheevos);
	self add_option("Acount", "Prestige Master", ::setPrestigeMaster);
	self add_option("Acount", "Set Level 55", ::doRank);
	self add_option("Account", "Derank Yourself", ::selfDerank);
	self add_option("Acount", "^6Co^2lored ^1Clas^2ses", ::ColoredClass);
    
	self add_menu("Weapon Menu", "Main Menu", "VIP");
	self add_option("Weapon Menu", "Death Machine", ::BG_GivePlayerWeapon, "minigun_mp");
	self add_option("Weapon Menu", "MP7", ::BG_GivePlayerWeapon, "mp7_mp");
	self add_option("Weapon Menu", "Balista", ::BG_GivePlayerWeapon, "ballista_mp");
	self add_option("Weapon Menu", "Dsr 50", ::BG_GivePlayerWeapon, "dsr50_mp");
	self add_option("Weapon Menu", "Knife CS", ::BG_GivePlayerWeapon, "knife_mp");
	self add_option("Weapon Menu", "AN94", ::BG_GivePlayerWeapon, "an94_mp");
	self add_option("Weapon Menu", "Concussion", ::BG_GivePlayerWeapon, "concussion_grenade_mp");
	self add_option("Weapon Menu", "Tomahawk", ::BG_GivePlayerWeapon, "hatchet_mp");
	self add_option("Weapon Menu", "Remington", ::BG_GivePlayerWeapon, "870mcs_mp");
	self add_option("Weapon Menu", "Vector", ::BG_GivePlayerWeapon, "sf_vector_mp");
	self add_option("Weapon Menu", "C4", ::BG_GivePlayerWeapon, "satchel_charge_mp");
	self add_option("Weapon Menu", "SVU-AS", ::BG_GivePlayerWeapon, "svu_mp");
	self add_option("Weapon Menu", "Hamr", ::BG_GivePlayerWeapon, "hamr_mp");
	self add_option("Weapon Menu", "PDW--57", ::BG_GivePlayerWeapon, "pdw57_mp");
	self add_option("Weapon Menu", "War Machine", ::BG_GivePlayerWeapon, "m32_mp");
	self add_option("Weapon Menu", "Give Some Weapons", ::AllWeps);
	self add_option("Weapon Menu", "^2Teleport Gun", ::ToggleTeleportGun);

    self add_menu("Killstreaks Menu", "Main Menu", "Admin");
	self add_option("Killstreaks Menu", "Spyplane", ::GiveUAV);
	self add_option("Killstreaks Menu", "RC-XD", ::GiveRC);
	self add_option("Killstreaks Menu", "Hunter Killer", ::GiveHunt);
	self add_option("Killstreaks Menu", "Care Package", ::GiveCare);
	self add_option("Killstreaks Menu", "CounterUAV", ::GiveCUAV);
	self add_option("Killstreaks Menu", "Guardian", ::GiveGaurd);
	self add_option("Killstreaks Menu", "Hellfire", ::GiveHell);
	self add_option("Killstreaks Menu", "Lightning Strike", ::GiveLS);
	self add_option("Killstreaks Menu", "Sentry Gun", ::GiveSG);
	self add_option("Killstreaks Menu", "AGR", ::GiveAG);
	self add_option("Killstreaks Menu", "^2Killstreaks Menu 2", ::submenu, "Killstreak Menu1", "Killstreak Menu1");

	self add_menu("Killstreak Menu1", "Main Menu", "Admin");
    self add_option("Killstreak Menu1", "Stealth Chopper", ::GiveSC);
    self add_option("Killstreak Menu1", "VSAT", ::GiveVSAT);
    self add_option("Killstreak Menu1", "Escort Drone", ::GiveED);
    self add_option("Killstreak Menu1", "Give EMP", ::GiveEMP);
    self add_option("Killstreak Menu1", "Warthog", ::GiveWH);
    self add_option("Killstreak Menu1", "Lodestar", ::GiveLST);
    self add_option("Killstreak Menu1", "VTOL Warship", ::GiveVW);
    self add_option("Killstreak Menu1", "Dogs", ::GiveDogs);
    self add_option("Killstreak Menu1", "Swarm", ::GiveSwarm);

	self add_menu("Messages Menu", "Main Menu", "Admin");
	self add_option("Messages Menu", "Welcome", ::typewritter, "^1Welcome To Purple Dragon Mod Menu");
	self add_option("Messages Menu", "Creator Name", ::typewritter, "^2Created By CM|T");
	self add_option("Messages Menu", "Your Name", ::typewritter, "^5"+self.name+" is fucking beast");
	self add_option("Messages Menu", "Joke 1", ::penisjk);
	self add_option("Messages Menu", "Joke 2", ::pussyjk);
	self add_option("Messages Menu", "CapoModdingTeam", ::typewritter, "^6Capo Clan are the best!");
	self add_option("Messages Menu", "Trickshots", ::typewritter, "^7Trickshots Only Or Derank");
	self add_option("Messages Menu", "One<3", ::typewritter, "^2£5 Psn or paypal for modded account!");
	self add_option("Messages Menu", "Turn Your Mic Off", ::typewritter, "^2Kid turn your fucking mic off.");
	self add_option("Messages Menu", "How To Turn On Mod Menu", ::typewritter, "^1L1 + Knife To Open Menu!");
	self add_option("Messages Menu", "Get the fuck out", ::typewritter, "^2Get the ^3fuck ^2out");
	self add_option("Messages Menu", "Mods troll", ::trollMessage);
    self add_option("Messages Menu", "^2Messages Page 2 -->", ::submenu, "Messages Menu1", "Messages Menu1");

	self add_menu("Messages Menu1", "Main Menu", "Admin");
    self add_option("Messages Menu1", "Yes", ::typewritter, "^2Yes");
    self add_option("Messages Menu1", "No", ::typewritter, "^1No");
    self add_option("Messages Menu1", "DDOS", ::typewritter, "^3Keep being annouying and get booted!");
    self add_option("Messages Menu1", "Fun Time", ::typewritter, "^5Time to have some fun >:D");
    self add_option("Messages Menu1", "Camping", ::typewritter, "^1Fucking ^5campers");
    self add_option("Messages Menu1", "Tryhards", ::typewritter, "^1Fucking ^5tryhards");
    self add_option("Messages Menu1", "Noobs", ::typewritter, "^1Fucking ^5noobs");
    self add_option("Messages Menu1", "Hacking and Modding", ::typewritter, "^5Hacking and modding are 2 VERY different things");
    self add_option("Messages Menu1", "Your IQ", ::typewritter, "^5You have a fucking IQ of 0, dumbass");
    self add_option("Messages Menu1", "Fascinated", ::typewritter, "^5Are you fascinated by these mods bruh?");
    self add_option("Messages Menu1", "How to use the menu", ::howtouse);
    self add_option("Messages Menu1", "Jij Weet Niet", ::typewritter, "^2Jij Weet Niet Wie Ik Ben !!");

    self add_menu("Change Map", "Main Menu", "Host");
	self add_option("Change Map", "Aftermath", ::doMap, "mp_la");
	self add_option("Change Map", "Carrier", ::doMap, "mp_carrier");
	self add_option("Change Map", "Cargo", ::doMap, "mp_dockside");
	self add_option("Change Map", "Drone", ::doMap, "mp_drone");
	self add_option("Change Map", "Express", ::doMap, "mp_express");
	self add_option("Change Map", "Hijacked", ::doMap, "mp_hijacked");
	self add_option("Change Map", "Meltdown", ::doMap, "mp_meltdown");
	self add_option("Change Map", "Nuketown", ::doMap, "mp_nuketown_2020");
	self add_option("Change Map", "Overflow", ::doMap, "mp_overflow");
	self add_option("Change Map", "Plaza", ::doMap, "mp_nightclub");
	self add_option("Change Map", "Raid", ::doMap, "mp_raid");
    self add_option("Change Map", "Slums", ::doMap, "mp_slums");
    self add_option("Change Map", "Standoff", ::doMap, "mp_village");
    self add_option("Change Map", "Turbine", ::doMap, "mp_turbine");
    self add_option("Change Map", "Yemen", ::doMap, "mp_socotra");

	self add_menu("Bullets Type", "Main Menu", "Co-Host");
	self add_option("Bullets Type", "Nuke Bullet", ::initNukeBullets);
	self add_option("Bullets Type", "EMP Bullet", ::initEMPBullets);
	self add_option("Bullets Type", "Rockets", ::initRPGBullet);
	self add_option("Bullets Type", "WaterGun", ::WaterGun);
	self add_option("Bullets Type", "Flare Gun", ::toggle_FlareGun);

	self add_menu("Visions", "Main Menu", "VIP");
    self add_option("Visions", "Black and White Vision", ::BWV);
    self add_option("Visions", "Light Vision", ::LVis);
    self add_option("Visions", "Enhanced Vision", ::EV);
    self add_option("Visions", "EMP Vision", ::emp);
    self add_option("Visions", "Outro", ::mpoutro);
    self add_option("Visions", "Intro", ::mpintro);
    self add_option("Visions", "Infrared", ::infrared);
    self add_option("Visions", "Infrared Snow",  ::infrared_snow);
    self add_option("Visions", "Mortal Infrared", ::remote_mortar_infrared);
    self add_option("Visions", "Taser", ::taser_mine_shock);
    self add_option("Visions", "Toggle Visions", ::Dovisions);
    self add_option("Visions", "WaterFall", ::waterfall);
    self add_option("Visions", "Blur", ::DoBur);
    self add_option("Visions", "Hold ipad", ::iPad);
    self add_option("Visions", "KissMyAimbot- Crosshair", ::crosshaifrmodz);
    self add_option("Visions", "Default", ::defaultVision);


	self add_menu("Camo Changer", "Main Menu", "VIP");
	self add_option("Camo Changer", "Camo Changer", ::CamoChanger);
	self add_option("Camo Changer", "^2DLC Camo -->", ::submenu, "DLC Camo", "DLC Camo");
	self add_option("Camo Changer", "^2Elite Camo -->", ::submenu, "DLC Camo 4", "DLC Camo 4");
	self add_option("Camo Changer", "^2Normal Camo -->", ::submenu, "DLC Camo 3", "DLC Camo 3");
	self add_option("Camo Changer", "^2More DLC -->", ::submenu, "DLC Camo 2", "DLC Camo 2");

	self add_menu("DLC Camo", "Main Menu", "VIP");
	self add_option("DLC Camo", "Jungle Warfare", ::giveJungle);
	self add_option("DLC Camo", "Benjamins", ::giveBenj);
	self add_option("DLC Camo", "Dia De Muertos", ::giveDia);
	self add_option("DLC Camo", "Graffiti", ::giveGraffiti);
	self add_option("DLC Camo", "Kawaii", ::giveKawaii);
	self add_option("DLC Camo", "Party Rock", ::giveParty);
	self add_option("DLC Camo", "Zombies", ::giveZombies);
	self add_option("DLC Camo", "Viper", ::giveViper);
	self add_option("DLC Camo", "Bacon", ::giveBacon);
	self add_option("DLC Camo", "Cyborg", ::giveCyborg);
	self add_option("DLC Camo", "Dragon", ::giveDragon);
	self add_option("DLC Camo", "Aqua", ::giveAqua);
	self add_option("DLC Camo", "Breach", ::giveBreach);
	self add_option("DLC Camo", "Coyote", ::giveCoyote);

	self add_menu("DLC Camo 4", "Main Menu", "VIP");
	self add_option("DLC Camo 4", "Ghost", ::giveGhost);
	self add_option("DLC Camo 4", "Elite", ::giveElite);
	self add_option("DLC Camo 4", "CE Digital", ::giveCED);

	self add_menu("DLC Camo 3", "Main Menu", "VIP");
	self add_option("DLC Camo 3", "DevGru", ::giveDevGru);
	self add_option("DLC Camo 3", "A-Tac AU", ::giveAtac);
	self add_option("DLC Camo 3", "EROL", ::giveErol);
	self add_option("DLC Camo 3", "Siberia", ::giveSiberia);
	self add_option("DLC Camo 3", "Choco", ::giveChoco);
	self add_option("DLC Camo 3", "Blue Tiger", ::giveBlueT);
	self add_option("DLC Camo 3", "Bloodshot", ::giveBloodS);
	self add_option("DLC Camo 3", "Ghostex", ::giveGhostex);
	self add_option("DLC Camo 3", "Krytek", ::giveKryptek);
	self add_option("DLC Camo 3", "Carbon Fiber", ::giveCarbonF);
	self add_option("DLC Camo 3", "Cherry Blossom", ::giveCherryB);
	self add_option("DLC Camo 3", "Art of War", ::giveArtW);
	self add_option("DLC Camo 3", "Ronin", ::giveRonin);
	self add_option("DLC Camo 3", "Skulls", ::giveSkull);
	self add_option("DLC Camo 3", "Gold", ::giveGold);
	self add_option("DLC Camo 3", "Diamond", ::giveDiamond);

	self add_menu("DLC Camo 2", "Main Menu", "VIP");
	self add_option("DLC Camo 2", "UK Punk", ::giveUK);
	self add_option("DLC Camo 2", "Comic", ::giveComic);
	self add_option("DLC Camo 2", "Paladin", ::givePaladin);
	self add_option("DLC Camo 2", "Afterlife", ::giveAfterlife);
	self add_option("DLC Camo 2", "Dead Mans Hand", ::giveDeadM);
	self add_option("DLC Camo 2", "Beast", ::giveBeast);
	self add_option("DLC Camo 2", "Octane", ::giveOctane);
	self add_option("DLC Camo 2", "Weaponized 115", ::giveWeapon115);
	self add_option("DLC Camo 2", "Pack a Punch", ::givePacka);

    self add_menu("Fun Zone", "Main Menu", "Admin");
	self add_option("Fun Zone", "Long Melee Range", ::meleerange);
	self add_option("Fun Zone", "Auto Drop-Shot", ::AutoDropshot);
	self add_option("Fun Zone", "T-Bag", ::Tbag);
	self add_option("Fun Zone", "Riot Man", ::RiotMan);
	self add_option("Fun Zone", "Kamikaza", ::kamikaze);
	self add_option("Fun Zone", "Jericho Missles", ::initJericho);
	self add_option("Fun Zone", "Strafe Run", ::initStrafeRun);
	self add_option("Fun Zone", "Long Arm", ::ToggleLeft);
	self add_option("Fun Zone", "Matrix Aiming", ::Matrixx);
	self add_option("Fun Zone", "ThirdPerson", ::thirdperson);
	self add_option("Fun Zone", "Hulk Mode", ::doTheHulk);
	self add_option("Fun Zone", "Rapid Fire", ::rapidFire);
	self add_option("Fun Zone", "Smoke Monster", ::initSmokeMonster);
	self add_option("Fun Zone", "Centipede", ::Centipede);
	self add_option("Fun Zone", "^2Fun Zone Page 2 -->", ::submenu, "Fun Zone 2", "Fun Zone 2");

	self add_menu("Fun Zone 2", "Fun Zone", "Admin");
	self add_option("Fun Zone 2", "Human Torch", ::initHTorch);
	self add_option("Fun Zone 2", "Crosshair +", ::crosshair);
	self add_option("Fun Zone 2", "CrazyMan", ::CrazyMan);
	self add_option("Fun Zone 2", "Stunt Plane", ::StuntRun);
	self add_option("Fun Zone 2", "Pet Plane", ::SSH);
	self add_option("Fun Zone 2", "Fire Balls", ::fireballstoggle);
	self add_option("Fun Zone 2", "Force Field", ::ballThing);
	self add_option("Fun Zone 2", "Electric Man", ::initdafuck);
	self add_option("Fun Zone 2", "Mexican Wave", ::mexicanWave);
	self add_option("Fun Zone 2", "PHD Flopper", ::Toggle_PHDFLOPPER);
	self add_option("Fun Zone 2", "Model Changer", ::ChangeDaModel);
	self add_option("Fun Zone 2", "The Tanim Mod", ::TanimMod);
	self add_option("Fun Zone 2", "No head", ::NoHead);
	self add_option("Fun Zone 2", "No Legs Or Arms", ::NoLegsOrArms);
	self add_option("Fun Zone 2", "Light Man", ::initELeGanCe1);
	self add_option("Fun Zone 2", "Test", ::DickMod);

	self add_menu("Forge", "Page 2", "Co-Host");
    self add_option("Forge", "WindMill", ::WindMill);
    self add_option("Forge", "Forge Floor", ::ForgeGrids);
    self add_option("Forge", "Forge Wall", ::ForgeWall);
    self add_option("Forge", "Forge Ramp", ::ForgeRamp);
    self add_option("Forge", "Forge Bridge", ::ForgeBridge);
    self add_option("Forge", "Zipline", ::ForgeZips);
    self add_option("Forge", "Teleport", ::ForgeTele);
    self add_option("Forge", "Elevator", ::ForgeElevator);
    self add_option("Forge", "Create Bounce", ::createBounce);
    self add_option("Forge", "Delete Bounces", ::DeleteAll);
    self add_option("Forge", "Forge Mode", ::ForgeON);
    self add_option("Forge", "Forge Mode 2", ::doForgeMode2);
    self add_option("Forge", "Entity Namer", ::CopyObjectsOn);
    self add_option("Forge", "Spawn Objects", ::submenu, "Spawn Objects","Spawn Objects");
    self add_option("Forge", "Spawn Built Stuff", ::submenu, "Spawn Built Stuff","Spawn Built Stuff");
    
    self add_menu("Spawn Built Stuff", "Forge", "Admin");
    self add_option("Spawn Built Stuff", "Spawn Platform", ::Platform);
    self add_option("Spawn Built Stuff", "Stairway To Heaven", ::stairwayTH);
    self add_option("Spawn Built Stuff", "Sky Base", ::skybasetoggle);
    self add_option("Spawn Built Stuff", "Delete Merry", ::Explode);
    self add_option("Spawn Built Stuff", "MerryGoRound", ::build);
    self add_option("Spawn Built Stuff", "Spawn Bunker", ::BunkerThread);
    self add_option("Spawn Built Stuff", "MerryGoRound", ::build);
    self add_option("Spawn Built Stuff", "Delete Merry", ::Explode);
    
    self add_menu("Spawn Objects", "Forge", "Admin");
	self add_option("Spawn Objects", "Care Package", ::spawnEntityPlayer, "t6_wpn_supply_drop_ally");
	self add_option("Spawn Objects", "VTOL", ::spawnEntityPlayer, "veh_t6_air_v78_vtol_killstreak");
	self add_option("Spawn Objects", "Dragon Fire", ::spawnEntityPlayer, "veh_t6_drone_quad_rotor_mp");
	self add_option("Spawn Objects", "AGR", ::spawnEntityPlayer, "veh_t6_drone_tank");
	self add_option("Spawn Objects", "Heli", ::spawnEntityPlayer, "veh_t6_air_attack_heli_mp_dark");
	self add_option("Spawn Objects", "Escort Drone", ::spawnEntityPlayer, "veh_t6_drone_overwatch_dark");
	self add_option("Spawn Objects", "Supply Drone", ::spawnEntityPlayer, "veh_t6_drone_supply");
	self add_option("Spawn Objects", "Pegasus Drone", ::spawnEntityPlayer, "veh_t6_drone_pegasus_mp");
	self add_option("Spawn Objects", "UAV Drone", ::spawnEntityPlayer, "veh_t6_drone_uav");
	self add_option("Spawn Objects", "FA38", ::spawnEntityPlayer, "veh_t6_air_fa38_killstreak");
	self add_option("Spawn Objects", "A10", ::spawnEntityPlayer, "veh_t6_air_a10f");
	self add_option("Spawn Objects", "Dog", ::spawnEntityPlayer, "german_shepherd_vest");
	self add_option("Spawn Objects", "Black Dog", ::spawnEntityPlayer, "german_shepherd_vest_black");
	self add_option("Spawn Objects", "Care Package Trap", ::spawnEntityPlayer, "t6_wpn_supply_drop_trap");
	self add_option("Spawn Objects", "Care Package Enemy", ::spawnEntityPlayer,"t6_wpn_supply_drop_axis");
    self add_option("Spawn Objects", "Spawn Nuketown Entity", ::submenu, "Spawn Nuketown Entity", "Spawn Nuketown Entity");
    self add_option("Spawn Objects", "Spawn Raid Entity", ::submenu, "Spawn Raid Entity", "Spawn Raid Entity");
	self add_option("Spawn Objects", "Turret", ::submenu, "Spawn Turret", "Spawn Turret");
	
	self add_menu("Spawn Nuketown Entity", "Spawn Objects", "Admin");
	self add_option("Spawn Nuketown Entity", "Manequin", ::spawnEntityPlayer,"dest_nt_nuked_female_03_d0",2);
    self add_option("Spawn Nuketown Entity", "Manequin 2", ::spawnEntityPlayer,"dest_nt_nuked_male_01_d0",2);
    self add_option("Spawn Nuketown Entity", "Manequin 3", ::spawnEntityPlayer,"dest_nt_nuked_female_05_d0",2);
    self add_option("Spawn Nuketown Entity", "Car 1", ::spawnEntityPlayer, "veh_t6_nuketown_2020_car02_whole",2);
    self add_option("Spawn Nuketown Entity", "Car 2", ::spawnEntityPlayer, "veh_t6_nuketown_2020_car01_whole",2);
    
    self add_menu("Spawn Raid Entity", "Spawn Objects", "Admin");
	self add_option("Spawn Raid Entity", "Van", ::spawnEntityPlayer,"veh_t6_v_van_whole",2);
	self add_option("Spawn Raid Entity", "Van 2", ::spawnEntityPlayer,"veh_t6_civ_van_sprinter_whole",2);
	self add_option("Spawn Raid Entity", "Sports Car", ::spawnEntityPlayer,"veh_t6_civ_sportscar_whole_yellow",2);
	self add_option("Spawn Raid Entity", "Sedan", ::spawnEntityPlayer,"veh_t6_luxury_sedan_clean_whole",2);

	self add_menu("Spawn Turret", "Spawn Objects","Admin");
	self add_option("Spawn Turret", "Auto Turret", ::spawnTurretPlayer, "auto_gun_turret_mp");
	self add_option("Spawn Turret", "Heli Rockets", ::spawnTurretPlayer, "heli_gunner_rockets_mp");
	self add_option("Spawn Turret", "Strafe Rockets", ::spawnTurretPlayer, "straferun_rockets_mp");
	self add_option("Spawn Turret", "Chopper Minigun", ::spawnTurretPlayer, "chopper_minigun_mp");
    
    self add_menu("All Player", "Page 2", "Host");
	self add_option("All Player", "Send all to Space", ::sendalltospace);
	self add_option("All Player", "Take all Weapons", ::takeallplayerweapons);
	self add_option("All Player", "Infinite Ammo all", ::infiniteammoall);
	self add_option("All Player", "All Diamond", ::diamon);
	self add_option("All Player", "Custom Teleport All", ::teleportAllPlayers, "locationSelector");
	self add_option("All Player", "Give all MiniGun", ::GiveAllminigun);
	self add_option("All Player", "Freeze All", ::freezeall);
	self add_option("All Player", "Prone All", ::ProneAll);

	self add_menu("Aimbot Menu", "Page 2", "Admin");
	self add_option("Aimbot Menu", "Aimbot", ::Aimbot);
	self add_option("Aimbot Menu", "Aiming Required", ::aimingMethod);
	self add_option("Aimbot Menu", "Aiming Position", ::changeAimingPos);
	self add_option("Aimbot Menu", "Unfair Mode", ::unfairAimbot);
	self add_option("Aimbot Menu", "Noscope Aimbot", ::initNSaimbot);
	self add_option("Aimbot Menu", "Aimbot 2", ::doAimbots);

	self add_menu("Lobby Settings", "Main Menu", "Co-Host");
	self add_option("Lobby Settings", "Super Jump", ::ToggleSuperJump);
	self add_option("Lobby Settings", "Super Speed", ::superspeed);
	self add_option("Lobby Settings", "AntiQuit ", ::toggleAntiQuit);
	self add_option("Lobby Settings", "Gravity", ::gravity);
	self add_option("Lobby Settings", "Knockback", ::knock);
	self add_option("Lobby Settings", "Timescale", ::changeTimescale);
	self add_option("Lobby Settings", "Force Host", ::forceHost);
	self add_option("Lobby Settings", "doHeart Text", ::DoTypeWriter);
	self add_option("Lobby Settings", "Spin Text", ::SpinText);
	self add_option("Lobby Settings", "Rocket Rain", ::ToggleRocketRain);
	self add_option("Lobby Settings", "Plant Bomb S&D", ::PlantBomb);
	self add_option("Lobby Settings", "Defuse Bomb S&D", ::DefuseBomb);
	self add_option("Lobby Settings", "Spawn Bots", ::submenu, "Bots", "Bots");
	self add_option("Lobby Settings", "^2 Next Page -->", ::submenu, "Lobby Settings 2", "Lobby Settings 2");

	self add_menu("Lobby Settings 2", "Lobby Settings", "Co-Host");
	self add_option("Lobby Settings 2", "Easter Egg(Nuketown)", ::do_vcs);
	self add_option("Lobby Settings 2", "NewsBars", ::NewsBarsLol);
	self add_option("Lobby Settings 2", "Fast ReStart", ::doRestart);
	self add_option("Lobby Settings 2", "End Game", ::endGame);
	self add_option("Lobby Settings 2", "Inf Game", ::Inf_Game);

	self add_menu("Bots", "Main Menu", "Co-Host");
	self add_option("Bots", "Spawn 1 Bot", ::spawn1);
	self add_option("Bots", "Spawn 3 Bots", ::spawn3);
	self add_option("Bots", "Spawn 16 Bots", ::spawn18);
	self add_option("Bots", "Kick All Bots", ::kickAllBots);
	self add_option("Bots", "Spawn Zombie", ::Supply);

	self add_menu("Modded Weapons", "Page 2", "Co-Host");
	self add_option("Modded Weapons", "Glitch Fiveseven", ::BG_GivePlayerWeapon, "fiveseven_lh_mp");
	self add_option("Modded Weapons", "Thunder Gun", ::ThunGun);
	self add_option("Modded Weapons", "**Ray Gun**", ::initRaygun);
	self add_option("Modded Weapons", "Mustang And Sally", ::ToggleMustangGun);
	self add_option("Modded Weapons", "Rocket Teleport", ::initRocketTeleport);
	self add_option("Modded Weapons", "Ballistic Teleport", ::toggleknifetele);
	self add_option("Modded Weapons", "Bomb", ::BG_GivePlayerWeapon, "briefcase_bomb_mp");
	self add_option("Modded Weapons", "Default Weapon", ::BG_GivePlayerWeapon, "defaultweapon_mp");
	self add_option("Modded Weapons", "Shoot Carepackages", ::careMaker);

    self add_menu("Custom XP", "Page 2", "Co-Host");
    self add_option("Custom XP", "420 XP", ::BigXP4);
    self add_option("Custom XP", "1337 XP", ::BigXP7);
	self add_option("Custom XP", "10000 XP", ::BigXP5);
    self add_option("Custom XP", "50000 XP", ::BigXP8);
    self add_option("Custom XP", "BIG XP", ::BigXP3);
    
    self add_menu("Host", "Main Menu", "Host");
    self add_option("Host", "PRO Mode", ::ToggleFOV);
    self add_option("Host", "Show FPS", ::ShowFPS);
    self add_option("Host", "Big Names", ::dobig);
    self add_option("Host", "Meleerange", ::meleerange);
	self add_option("Host", "Health Bar", ::HealthBar);
	self add_option("Host", "Trickshot Aimbot", ::doTrickshotBinds);
	self add_option("Host", "Colour Correction", ::ColourCorrection);
	self add_option("Host", "Bouncy Grenades", ::BouncyGrenades);
	self add_option("Host", "All dvars", ::doDvars);
	self add_option("Host", "Remove death barrier", ::deathBarrier);
	self add_option("Host", "Remove Sky Barrier", ::removeSkyBarrier);
	self add_option("Host", "Specnade", ::SpecNade);
	self add_option("Host", "Floater", ::Floaters);
	self add_option("Host", "Give Verify Menu", ::GiveVerifyMenu);
	self add_option("Host", "Kill Godmode", ::KillGodModePlayers);
	self add_option("Host", "Red Sun", ::RedSun);
	
	self add_menu("Themes", "Page 2", "VIP");
    self add_option("Themes", "Red Tiger", ::setBackgroundShader,"menu_camo_tiger_blue_pattern", (1,0,0), 0);
    self add_option("Themes", "Massacre", ::setBackgroundShader,"menu_camo_mtx_massacre_32", (1,1,1), 0);
    self add_option("Themes", "Ghosts", ::setBackgroundShader,"menu_camo_mtx_ghost_32", (1,1,1), 1);
    self add_option("Themes", "Gold", ::setBackgroundShader,"menu_camo_gold_pattern", (1,1,0), 1);
    self add_option("Themes", "Purple Dragon", ::setBackgroundShader,"menu_camo_mtx_dragon_32", (0.72,0.14,1), 0);
    self add_option("Themes", "After Life", ::setBackgroundShader,"menu_camo_mtx_afterlife_32", (0.9,0.9,1),0);
    self add_option("Themes", "Advanced Warfare", ::setBackgroundShader,"mtl_weapon_camo_roxann", (1,1,1),1);
    self add_option("Themes", "Dark Carbon", ::setBackgroundShader,"menu_camo_carbon_pattern", (0.8,0.8,0.8),1);
    self add_option("Themes", "Pack a Punch", ::setBackgroundShader,"menu_camo_mtx_pap_32", (1,1,1),1);
    self add_option("Themes", "Wanted", ::setBackgroundShader,"mtl_weapon_camo_wanted", (1,1,1),0);
    self add_option("Themes", "Blossom", ::setBackgroundShader,"menu_camo_blossom_pattern", (1,1,1),0);
    self add_option("Themes", "Rainbow", ::ToggleRainbowShader);
    self add_option("Themes", "Themes 2", ::submenu, "Themes 2", "Themes 2");
    
    self add_menu("Themes 2", "Themes", "VIP");
    self add_option("Themes 2", "Pink Diamond", ::setBackgroundShader,"menu_camo_diamond_pattern", (0.94, 0.26, 0.8),0);
    self add_option("Themes 2", "Red Diamond", ::setBackgroundShader,"menu_camo_diamond_pattern", (1, 0, 0),0);
    self add_option("Themes 2", "Green Diamond", ::setBackgroundShader,"menu_camo_diamond_pattern", (0, 1, 0),0);
    self add_option("Themes 2", "Blue Diamond", ::setBackgroundShader,"menu_camo_diamond_pattern", (0, 0, 1),0);
    self add_option("Themes 2", "Diamond", ::setBackgroundShader,"menu_camo_diamond_pattern", (1, 1, 1),0);
    self add_option("Themes 2", "Red Grafiti", ::setBackgroundShader,"emblem_bg_movie_star", (1, 0, 0),1);
    self add_option("Themes 2", "Party Rock", ::setBackgroundShader,"emblem_bg_partyrock", (1, 1, 1),1);
    self add_option("Themes 2", "Dia De Muertos", ::setBackgroundShader,"emblem_bg_dayofdead", (1, 1, 1),1);
    self add_option("Themes 2", "Master Prestige", ::setBackgroundShader,"em_bg_prestige_11", (1, 1, 1),1);
    self add_option("Themes 2", "Flags", ::submenu, "Flags", "Flags");
    
    self add_menu("Flags", "Themes", "VIP");
    self add_option("Flags", "Netherlands", ::setBackgroundShader,"em_bg_flag_netherlands", (1, 1,1),1);
    self add_option("Flags", "Macedonia", ::setBackgroundShader,"em_bg_flag_macedonia", (1, 1,1),1);
    self add_option("Flags", "Wales", ::setBackgroundShader,"em_bg_flag_wales", (1, 1,1),1);
    self add_option("Flags", "United Kingdom", ::setBackgroundShader,"em_bg_flag_netherlands", (1, 1,1),1);
    self add_option("Flags", "Bhutan", ::setBackgroundShader,"em_bg_flag_bhutan", (1, 1,1),1);
    self add_option("Flags", "South Korea", ::setBackgroundShader,"em_bg_flag_south_korea", (1, 1,1),1);
    self add_option("Flags", "Isle Of Man", ::setBackgroundShader,"em_bg_flag_isle_of_man", (1, 1,1),1);
    self add_option("Flags", "Albania", ::setBackgroundShader,"em_bg_flag_albania", (1, 1,1),1);
    self add_option("Flags", "Seychelles", ::setBackgroundShader,"em_bg_flag_seychelles", (1, 1,1),1);
    self add_option("Flags", "Guyana", ::setBackgroundShader,"em_bg_flag_guyana", (1, 1,1),1);
   

    
	self add_menu("Page 2", "Main Menu", "VIP");
	self add_option("Page 2", "Modded Weapons", ::submenu, "Modded Weapons", "Modded Weapons");
	self add_option("Page 2", "Forge", ::submenu, "Forge", "Forge");
	self add_option("Page 2", "Aimbot Menu", ::submenu, "Aimbot Menu", "Aimbot Menu");
	self add_option("Page 2", "Custom XP", ::submenu, "Custom XP", "Custom XP");
	self add_option("Page 2", "Themes", ::submenu, "Themes", "Themes");
	self add_option("Page 2", "Option Text Colours", ::submenu, "Option Text Colours", "Option Text Colours");
	self add_option("Page 2", "Title Text Colours", ::submenu, "Title Text Colours", "Title Text Colours");
	self add_option("Page 2", "Scroller Colours", ::submenu, "Scroller Colours", "Scroller Colours");
	self add_option("Page 2", "Jets", ::submenu, "Jets", "Jets");
	self add_option("Page 2", "Helis", ::submenu, "Helis", "Helis");
	self add_option("Page 2", "All Player", ::submenu, "All Player", "All Player");
	self add_option("Page 2", "Players Menu", ::submenu, "PlayersMenu", "Players Menu");
	
	self add_menu("Option Text Colours", "Page 2", "VIP");
    self add_option("Option Text Colours", "Yellow", ::setOptionsColor, (1, 1,0));
    self add_option("Option Text Colours", "Black", ::setOptionsColor, (0,0,0));
    self add_option("Option Text Colours", "Pink", ::setOptionsColor, (1, 0,1));
    self add_option("Option Text Colours", "Green", ::setOptionsColor, (0, 1,0));
    self add_option("Option Text Colours", "Red", ::setOptionsColor, (1, 0,0));
    self add_option("Option Text Colours", "White", ::setOptionsColor, (1, 1,1));
    
    self add_menu("Title Text Colours", "Page 2", "VIP");
    self add_option("Title Text Colours", "Yellow", ::setTitleColor, (1, 1,0));
    self add_option("Title Text Colours", "Black", ::setTitleColor, (0,0,0));
    self add_option("Title Text Colours", "Pink", ::setTitleColor, (1, 0,1));
    self add_option("Title Text Colours", "Green", ::setTitleColor, (0, 1,0));
    self add_option("Title Text Colours", "Red", ::setTitleColor, (1, 0,0));
    self add_option("Title Text Colours", "White", ::setTitleColor, (1, 1,1));
	
	self add_menu("Scroller Colours", "Page 2", "VIP");
    self add_option("Scroller Colours", "Yellow", ::setScrollerColor, (1, 1,0),"white",1);
    self add_option("Scroller Colours", "Black", ::setScrollerColor, (0,0,0),"white",1);
    self add_option("Scroller Colours", "Pink", ::setScrollerColor, (1, 0,1),"white",1);
    self add_option("Scroller Colours", "Green", ::setScrollerColor, (0, 1,0),"white",1);
    self add_option("Scroller Colours", "Red", ::setScrollerColor, (1, 0,0),"white",1);
    self add_option("Scroller Colours", "White", ::setScrollerColor, (1, 1,1),"white",1);
	
	self add_menu("Jets", "Page 2", "Co-Host");
    self add_option("Jets", "Spawn Flyable Jet", ::initFlyableJet);
    self add_option("Jets", "A10 Thunderbolt", ::setFJetMatb);
    self add_option("Jets", "Lightning Strike", ::setFJetMharr);
    self add_option("Jets", "Stealth Bomber", ::setFJetMstb);
    self add_option("Jets", "UAV", ::setFJetMuav);
    self add_option("Jets", "VTOL", ::setFJetMvtol);
    
    self add_menu("Helis", "Page 2", "Co-Host");
    self add_option("Helis", "Spawn Helicopter", ::initPilotHeli);
    self add_option("Helis", "Overwatch", ::PHeliModellb);
    self add_option("Helis", "Attack Heli", ::PHeliModelah);
    self add_option("Helis","A10 Thunderbolt", ::PHeliModela10);
    self add_option("Helis", "Pegasus", ::PHeliModelstlh);
    self add_option("Helis", "Bo1 Chopper Gunner", ::initchoppergunner);
    
    self add_menu("PlayersMenu", "Main Menu", "Co-Host");
	for (i = 0; i < 12; i++)
	{ self add_menu("pOpt " + i, "PlayersMenu", "Co-Host"); }
}


HealthBar()
{
	self.healthBar=self createBar((1,1,1),150,11);
	self.healthBar setPoint("CENTER","TOP",0,42);
	self.healthText=self createFontString("default",1.5);
	self.healthText setPoint("CENTER","TOP",0,22);
	self.healthText setText("^3Your ^2Health");
	self notify("textset");
	level.result += 1;
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

meleerange()
{
	if(self.mele == true)
	{
		setDvar("player_meleeRange", "999");
		self.mele = false;
		self iPrintlnbold("Melee Range ^2ON");
	}
	else
	{
		setDvar("player_meleeRange", "1");
		self.mele = true;
		self iPrintlnbold("Melee Range ^1OFF");
	}
}

dobig()
{
if(self.BG == true)
    {
        self iPrintlnbold("Big Names ^2ON");
        setDvar("cg_overheadnamessize", "2.0");
        self.BG = false;
    }
    else
    {
        self iPrintlnbold("Big Names ^1OFF");
        setDvar("cg_overheadnamessize", "0.65");
        self.BG = true;
    }
}

NoSpread()
{
    if(self.NoSpread==0)
    {
        self.NoSpread=1;
        self iPrintlnbold("No Spread ^2ON");
        self setperk("specialty_bulletaccuracy");
        setDvar("perk_weapSpreadMultiplier", 0);

      
    }
    else
    {
        self.NoSpread=0;
        self iPrintlnbold("No Spread ^1OFF");
        self notify("stop_unlimitedammo");
        setDvar("perk_weapSpreadMultiplier", 0.65);
    }
}

Spinner()
{
self endon("disconnect");
	spawnPosition = self.origin+(200,0,60);
	spawnPosition2 = self.origin+(200,0,2);
		Spinner =spawn("script_model",spawnPosition);
		Spinner setModel("t6_wpn_supply_drop_ally");
	    Spinner setContents(1);
		
	       
	       Spinner2 =	spawn("script_model",spawnPosition);
		Spinner2 setModel("t6_wpn_supply_drop_ally");
	    Spinner2 linkTo(Spinner, "", (0,65,0), (0,0,0));
	    Spinner2 setContents(1);
	    
	    	       Spinner3 =	spawn("script_model",spawnPosition);
		Spinner3 setModel("t6_wpn_supply_drop_ally");
	    Spinner3 linkTo(Spinner2, "", (0,65,0), (0,0,0));
	    Spinner3 setContents(1);
	    
	    	       Spinner4 =	spawn("script_model",spawnPosition);
		Spinner4 setModel("t6_wpn_supply_drop_ally");
	    Spinner4 linkTo(Spinner3, "", (0,65,0), (0,0,0));
	    Spinner4 setContents(1);
	    
	    SpinnerN2 =spawn("script_model",spawnPosition2);
		SpinnerN2 setModel("t6_wpn_supply_drop_ally");
	    SpinnerN2 setContents(1);
	    
	    
	    Spinner5 =spawn("script_model",spawnPosition2);
		Spinner5 setModel("t6_wpn_supply_drop_ally");
		Spinner5 linkTo(SpinnerN2, "", (0,65,0), (0,0,0));
	    Spinner5 setContents(1);
		
	       
	       Spinner6 =	spawn("script_model",spawnPosition2);
		Spinner6 setModel("t6_wpn_supply_drop_ally");
	    Spinner6 linkTo(Spinner5, "", (0,65,0), (0,0,0));
	    Spinner6 setContents(1);
	    
	    	       Spinner7 =	spawn("script_model",spawnPosition2);
		Spinner7 setModel("t6_wpn_supply_drop_ally");
	    Spinner7 linkTo(Spinner6, "", (0,65,0), (0,0,0));
	    Spinner7 setContents(1);
	    
	    	       Spinner8 =	spawn("script_model",spawnPosition2);
		Spinner8 setModel("t6_wpn_supply_drop_ally");
	    Spinner8 linkTo(Spinner7, "", (0,65,0), (0,0,0));
	    Spinner8 setContents(1);
	    

		for(;;)
		{
Spinner rotateyaw( -360, 1);
wait 1;
SpinnerN2 rotateyaw( 360, 3);
        wait 0.5;
	}
}

fireballstoggle()
{
    if(!level.fireballs)
    {
        self iPrintln("^1Fireballs Activeted");
        currentoffhand = self getcurrentoffhand();
        if ( currentoffhand != "none" )
            self givemaxammo( currentoffhand );
        self thread Fireballs();
        level.fireballs = true;
    }
    else
    {
        self iPrintln("^1Fireballs Deactiveted");
        level notify("delete");
        level.fireballs = false;
    }
}

play_remote_fx(grenade)
{   
    self.exhaustFX = Spawn( "script_model", grenade.origin );
    self.exhaustFX SetModel( "tag_origin" );
    self.exhaustFX LinkTo(grenade);
    wait 0.01;
    PlayFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self.exhaustFX, "tag_origin" );  
   // playfxontag( level.chopper_fx["smoke"]["trail"], self.exhaustFX, "tag_origin" );
    grenade waittill("death");
    playfx(level.chopper_fx["explode"]["large"], self.origin);
    RadiusDamage(Bawz.origin,300,300,300,self);
    Bawz delete();
    self.exhaustFX delete();
}

Fireballs()
{
    self endon("disconnect");
     level endon( "game_ended" );
     level endon( "delete" );

    self thread unlimited_ammo();   
    self thread maps\mp\gametypes\_hud_message::hintMessage("Press [{+Frag}] To Use Fireballs",3);
    while(true)
    {
        self waittill("grenade_fire",grenade,weapname);
        if(weapname=="frag_grenade_mp")
        {
            Bawz = spawn("script_model",grenade.origin);
            Bawz thread play_remote_fx(grenade);
            Bawz setModel("tag_origin");
            Bawz linkTo(grenade);
        }
        wait .001;
    }
}
unlimited_ammo(  )
{
    self endon( "disconnect" );   
    level endon( "delete" );
    level endon( "game_ended" );

    for(;;)
    {
        self waittill("grenade_fire");
       
        currentoffhand = self getcurrentoffhand();
        if ( currentoffhand != "none" )
        self givemaxammo( currentoffhand );
    }
    wait 0.05;
}

forceHost()
{
	if (self isHost())
	{
		self.forceHost = booleanOpposite(self.forceHost);
		self iPrintln(booleanReturnVal(self.forceHost, "Force Host: ^1Off", "Force Host: ^2On"));
	
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

SSH()
{
    level endon("game_ended");
    self endon("disconnect");
    level endon("endheli");
   
    owner = self;
    lb = spawnHelicopter(self, self.origin + (5000, 5000, 5000), self.angles, "heli_guard_mp", "veh_t6_drone_overwatch_light");    
    lb.owner = self;
    lb.team = self.team;
    wait 0.01;
    lb thread ASH(owner);
    // lb thread CA(owner);//call this to end chopper after a certin time else will stop on gameend
    for (;;)
    {
        lb setYawSpeed(90, 80);
        lb SetSpeed(1000, 16);
        lb setVehGoalPos(self.origin + (51, 0, 1000), 1);
        wait 0.05;
    }
}
ASH(owner)
{
    self endon("disconnect");
    self endon("helicopter_done");
    level endon("game_ended");
 
    for (;;)
    {
        aimAt = owner maps\mp\gametypes\_battlechatter_mp::get_Closest_Player_Enemy();
        owner iPrintln("^5 isDefined^1 " + aimAt.name);
        MagicBullet("minigun_mp",self getTagOrigin("tag_origin")-(0,0,180),aimAt getTagOrigin("j_spineupper"),owner);
        wait .1;
        MagicBullet("minigun_mp",self getTagOrigin("tag_origin")-(0,0,180),aimAt getTagOrigin("j_spineupper"),owner);
        wait .1;
        MagicBullet("minigun_mp",self getTagOrigin("tag_origin")-(0,0,180),aimAt getTagOrigin("j_spineupper"),owner);
        wait .1;
        MagicBullet("minigun_mp",self getTagOrigin("tag_origin")-(0,0,180),aimAt getTagOrigin("j_spineupper"),owner);
        wait .1;
        MagicBullet("minigun_mp",self getTagOrigin("tag_origin")-(0,0,180),aimAt getTagOrigin("j_spineupper"),owner);
        wait .1;
        MagicBullet("minigun_mp",self getTagOrigin("tag_origin")-(0,0,180),aimAt getTagOrigin("j_spineupper"),owner);
        wait .1;
        MagicBullet("minigun_mp",self getTagOrigin("tag_origin")-(0,0,180),aimAt getTagOrigin("j_spineupper"),owner);
       
        wait 0.05;
    }
    wait 0.01;
}
 
CA(owner)
{
   
    level endon("game_ended");
    self endon("helicopter_done");
    owner iPrintln("^1Super Chopper spawned for 30sec!");
    wait 30; //can change tie to anything or leave alone22
    owner iPrintln("^1Super Chopper Over!");
    self delete();
    self notify("endheli");
    self notify("helicopter_done");
}

BigXP3()
{
	self endon("disconnect");

	if(level.BigXP3 == false)
	{
		level.BigXP3 = true;
		self iPrintlnbold("XP Insane ^2ON");
		maps\mp\gametypes\_rank::registerScoreInfo( "kill", 99999 );
		maps\mp\gametypes\_rank::registerScoreInfo( "suicide", 99999 );
	}
	else
	{
		level.BigXP3 = false;
		self iPrintlnbold("XP Insane ^1OFF");
		maps\mp\gametypes\_rank::registerScoreInfo( "kill", 100 );
		maps\mp\gametypes\_rank::registerScoreInfo( "suicide", 100 );
	}
}

BigXP8()
{
	self endon("disconnect");

	if(level.BigXP8 == false)
	{
		level.BigXP8 = true;
		self iPrintlnbold("XP 50000 ^2ON");
		maps\mp\gametypes\_rank::registerScoreInfo( "kill", 50000 );
		maps\mp\gametypes\_rank::registerScoreInfo( "suicide", 50000 );
	}
	else
	{
		level.BigXP8 = false;
		self iPrintlnbold("XP 50000 ^1OFF");
		maps\mp\gametypes\_rank::registerScoreInfo( "kill", 100 );
		maps\mp\gametypes\_rank::registerScoreInfo( "suicide", 100 );
	}
}

BigXP5()
{
	self endon("disconnect");

	if(level.BigXP5 == false)
	{
		level.BigXP5 = true;
		self iPrintlnbold("XP 1000 ^2ON");
		maps\mp\gametypes\_rank::registerScoreInfo( "kill", 10000 );
		maps\mp\gametypes\_rank::registerScoreInfo( "suicide", 10000 );
	}
	else
	{
		level.BigXP5 = false;
		self iPrintlnbold("XP 1000 ^1OFF");
		maps\mp\gametypes\_rank::registerScoreInfo( "kill", 100 );
		maps\mp\gametypes\_rank::registerScoreInfo( "suicide", 100 );
	}
}

BigXP7()
{
	self endon("disconnect");

	if(level.BigXP7 == false)
	{
		level.BigXP7 = true;
		self iPrintlnbold("XP 1337 ^2ON");
		maps\mp\gametypes\_rank::registerScoreInfo( "kill", 1337 );
		maps\mp\gametypes\_rank::registerScoreInfo( "suicide", 1337 );
	}
	else
	{
		level.BigXP7 = false;
		self iPrintlnbold("XP 1337 ^1OFF");
		maps\mp\gametypes\_rank::registerScoreInfo( "kill", 100 );
		maps\mp\gametypes\_rank::registerScoreInfo( "suicide", 100 );
	}
}

BigXP4()
{
	self endon("disconnect");

	if(level.BigXP4 == false)
	{
		level.BigXP4 = true;
		self iPrintlnbold("XP 420 ^2ON");
		maps\mp\gametypes\_rank::registerScoreInfo( "kill", 420 );
		maps\mp\gametypes\_rank::registerScoreInfo( "suicide", 420 );
	}
	else
	{
		level.BigXP4 = false;
		self iPrintlnbold("XP 420 ^1OFF");
		maps\mp\gametypes\_rank::registerScoreInfo( "kill", 100 );
		maps\mp\gametypes\_rank::registerScoreInfo( "suicide", 100 );
	}
}

toggle_FlareGun()
{
	self.FLstud = booleanOpposite(self.FLstud);
    self iPrintlnbold(booleanReturnVal(self.FLstud, "Flare Bullets ^1OFF", "Flare Bullets ^2ON"));
		
	if (self.flaregun == true || self.FLstud)
	{
	
		self thread FlareGun();
		self.flaregun = false;
	}
	else
	{
		self notify("flaregunend");
		self.flaregun = true;
	}
}
FlareGun()
{
	self endon("death");
	self endon("disconnect");
	self endon("flaregunend");
	level.Smoke = loadfx("env/smoke/fx_smoke_supply_drop_blue_mp");
	
	for(;;)
	{
		self waittill("weapon_fired");
        
		start = self gettagorigin( "tag_eye" );
		end = anglestoforward(self getPlayerAngles()) * 1000000;
		SPLOSIONlocation = BulletTrace(start, end, true, self)["position"];
		effect = spawnFx(level.Smoke, SPLOSIONlocation);
		triggerFx(effect);
	}
	wait 0.1;
}

selfDerank()
{
	self.pres["prestige"] = self.minprestige;
	self setdstat("playerstatslist", "plevel", "StatValue", self.minprestige);
	self setrank(self.minprestige);
	self.pres["rank"] = self.minrank;
	self setdstat("playerstatslist", "rank", "StatValue", self.minrank);
	self setrank(self.minrank);

	self iPrintlnbold("^3You are ^6Deranked!!");
}

ballistic()
{
self takeallweapons();
self giveWeapon( "knife_ballistic_mp", 0, true ( 16, 0, 0, 0, 0 ));
self switchToWeapon( "knife_ballistic_mp" );
}

CrazyMan()
{
self takeallweapons();
self thread ballistic();
self thread initRPGBullet();
self thread infrared();
self iPrintlnbold("^2 Go Ham for 20 seconds!");
self thread unlimited_ammo();
self thread Toggle_SpeedX2();
wait 20;
self thread doSuicide();
self thread defaultVision();
self thread Toggle_SpeedX2();
}

iPad()
{
if(self.ipad1 == true)
    {
        self iPrintlnbold("ipad: ^2ON");
        self disableoffhandweapons();
	    self giveWeapon("killstreak_remote_turret_mp");
	    self switchToWeapon("killstreak_remote_turret_mp");
        self.ipad1 = false;
    }
    else
    {

        self iPrintlnbold("ipad: ^1OFF");
        self enableoffhandweapons();
	    self switchToWeapon(self maps\mp\_utility::getlastweapon());
        self.ipad1 = true;
    }
}

DoBur()
{
    if(self.retard==0)
    {
        self iPrintlnbold("^2Blur: 1");
         if(self.ishost)
	{ setDvar("r_blur", "1"); }
        self.retard=1;
    }
    else
        if(self.retard==1)
        {
            self iPrintlnbold("^2Blur: 2");
            if(self.ishost)
	{ setDvar("r_blur", "2"); }
            self.retard=2;
        }
        else
            if(self.retard==2)
            {
            self iPrintlnbold("^2Blur: 3");
            if(self.ishost)
	{ setDvar("r_blur", "3"); }
                self.retard=3;
            }
            else
                if(self.retard==3)
                {
                	self iPrintlnbold("^2Blur: 4");
                    if(self.ishost)
	{ setDvar("r_blur", "4"); }
                    self.retard=4;
                }
                else
                if(self.retard==4)
                {
                	self iPrintlnbold("^2Blur: 5");
                    if(self.ishost)
	{ setDvar("r_blur", "5"); }
                    self.retard=5;
                }
				else
                if(self.retard==5)
                {
                	self iPrintlnbold("^2Blur: 6");
                    if(self.ishost)
	{ setDvar("r_blur", "6"); }
                    self.retard=6;
                }
				else
                if(self.retard==6)
                {
                	self iPrintlnbold("^2Blur: 7");
                    if(self.ishost)
	{ setDvar("r_blur", "7"); }
                    self.retard=7;
                }
				else
                if(self.retard==7)
                {
                	self iPrintlnbold("^2Blur: 8");
                    if(self.ishost)
	{ setDvar("r_blur", "8"); }
                    self.retard=8;
                }
				else
                if(self.retard==8)
                {
                	self iPrintlnbold("^2Blur: 9");
                    if(self.ishost)
	{ setDvar("r_blur", "9"); }
                    self.retard=9;
                }
				else
                if(self.retard==9)
                {
                	self iPrintlnbold("^2Blur: 10");
                    if(self.ishost)
	{ setDvar("r_blur", "10"); }
                    self.retard=10;
                }
				else
                if(self.retard==10)
                {
                	self iPrintlnbold("^2Blur: Default");
                    if(self.ishost)
	{ setDvar("r_blur", "0"); }
                    self.retard=0;
                }
}

waterfall()
{
if(self.ipad12 == true)
    {
        self iPrintlnbold("WaterFall: ^2ON");
        if(self.ishost)
	{ setDvar("r_blur", "0"); setDvar("r_waterSheetingFX_enable", "1"); }
        self.ipad12 = false;
    }
    else
    {

        self iPrintlnbold("WaterFall: ^1OFF");
        if(self.ishost)
	{ setDvar("r_blur", "0"); setDvar("r_waterSheetingFX_enable", "0"); }
        self.ipad12 = true;
    }
}

knifeTeleportGun()
{
	self endon("disconnect");
	self endon("disableknifeGun");
	self endon("death");

	self giveWeapon("knife_ballistic_mp", 0, true ( 16, 0, 0, 0, 0 ));
    self switchToWeapon("knife_ballistic_mp");
    self givemaxammo("knife_ballistic_mp");
	for (;;)
	{
		self waittill("missile_fire", weapon, weapname);
		if (weapname == "knife_ballistic_mp")
        {
        	self detachAll();
        	self PlayerLinkTo(weapon);

        	weapon waittill("death");
        	self detachAll();
        }
        wait 0.05;
	}

}


toggleknifetele()
{
	self.tknifet = booleanOpposite(self.tknifet);
	self iPrintln(booleanReturnVal(self.tknifet, "Ballistic Teleporter ^1OFF", "Ballistic Teleporter ^2ON"));

	if(self.knife == true || self.tknifet)
	{
		self thread knifeTeleportGun();
		self.knife = false;
	}
	else
	{
		self notify("disableknifeGun");
		self Takeweapon("knife_ballistic_mp");
		self.knife = true;
	}
}

initRocketTeleport()
{
	if(self.rocketTeleOn == 0)
	{
		self.rocketTeleOn = 1;
		self iPrintlnbold("^5Rocket Teleporter: ^2On");
		self iPrintln("^1Fire RPG, ^3You can ^4Fly.");
		doRocketTeleport();
	}
	else
	{
		self.rocketTeleOn = 0;
		self iPrintlnbold("^5Rocket Teleporter: ^1Off");
		self notify("stop_rocketTele");
		self disableInvulnerability();
	}
}
doRocketTeleport()
{
	self endon("disconnect");
	self endon("stop_rocketTele");
	self enableInvulnerability();
	initGiveWeap("usrpg_mp", "", 0);
	for (;;)
	{
		self waittill("missile_fire", weapon, weapname);
		if (weapname == "usrpg_mp")
		{
			self PlayerLinkTo(weapon);
			weapon waittill("death");
			self detachAll();
		}
		wait 0.05;
	}
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

ThunGun()
{
    self endon("disconnect");
    self endon ("death");
    level.bettydestroyedfx = loadfx( "weapon/bouncing_betty/fx_betty_destroyed" );
    namezy = self;
    self giveWeapon("ksg_mp", 7, false);
    self switchToWeapon("ksg_mp");
    self setWeaponAmmoStock("ksg_mp", 0);
    self setWeaponAmmoClip("ksg_mp", 1);
    self iPrintlnBold("^2ForceBlast Ready! ^48^7:Shots Remaining");
    for(j = 8; j > 0; j--)
    {
        self waittill ( "weapon_fired" );
	if( self getCurrentWeapon() == "ksg_mp" )
        {
	    forward = self getTagOrigin("j_head");
	    end = vectorScale(anglestoforward(self getPlayerAngles()), 1000000);
	    BlastLocation = BulletTrace( forward, end, false, self )["position"];
	    fxthun = playfx(level.bettydestroyedfx, self getTagOrigin("tag_weapon_right"));
	    fxthun.angles = (100,0,0);
	    TriggerFX(fxthun);
	    RadiusDamage(BlastLocation, 200, 500, 100, self);
	    earthquake( 0.9, 0.9, self.origin, 600 );
	    PlayRumbleOnPosition( "grenade_rumble", self.origin );
	    foreach(player in level.players)
	    {
                if(player.team != self.team)
                {
                    if(Distance(self.origin, player.origin) < 600)
		    {
		        player thread ThunDamage();
		    }
                 }
             }
	     self switchToWeapon("ksg_mp");
	     wait 0.8;
	     wait .5;
	     bulletz = (j - 1);
	     self iPrintlnBold("^2ForceBlast Ready. ^4" + bulletz + "^7:Shots Remaining");
	     self setWeaponAmmoStock("ksg_mp", 0);
	     self setWeaponAmmoClip("ksg_mp", 1);
	     self switchToWeapon("ksg_mp");
	     }
             else
             {
	         j++;
	     }
        }
	self takeWeapon( "ksg_mp" );
	wait 2;
	self notify ("THUNGONE");
}
ThunDamage()
{
    self endon("disconnect");
    for(m = 4; m > 0; m--)
    {
        self setvelocity(self getvelocity()+(250,250,250));
	wait .1;
    }
    self setvelocity(0,0,0);
    wait 7;
}

crosshair()
{
    if(self.crosshair == false)
    {
            xePixTvx=createFontString("default",2.0);
    xePixTvx setPoint("CENTER","CENTER",0,-200);
    xePixTvx setText("^6+");
    self notify("textset");
    level.result += 1;
    xePixTvx.alpha=1;
    xePixTvx.y=0;
        self iprintlnbold ("Crosshair : + ^2Given");
        self.crosshair = true;
    }
    else
    {
        self iprintln("^1Off");
    }
}

initHTorch()
{
	if(self.torchOn == 0)
	{
		self.torchOn = 1;
		self thread humanTorch();
		self iPrintlnbold("Human Torch: ^2On");
	}
	else
	{
		self.torchOn = 0;
		self notify("stop_torch");
		self disableInvulnerability();
		self iPrintlnbold("Human Torch: ^1Off");
	}
}
humanTorch()
{
	self endon("disconnect");
	self endon("death");
	self endon("stop_torch");

	level._effect["torch"] = loadfx( "maps/mp_maps/fx_mp_exp_rc_bomb" );
	self enableInvulnerability();
	while(1)
	{
		PlayFX(level._effect["torch"],self.origin+(0,0,60));
		RadiusDamage(self.origin, 300, 300, 200, self);
		wait 0.1;
	}
}

WaterGun()
{
	wait 2;
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
Centipede()
{
	self endon("stop_centipede");
	self endon("disconnect");
	self endon("death");
	while(1)
	{
		ent=self ClonePlayer(9999999);
		wait 0.1;
		ent thread destroyModelOnTime(2);
	}
}

destroyModelOnTime(time)
{
	wait(time);
	self delete();
}

initSmokeMonster()
{
	if(self.smokemonsterr == 0)
	{
		self.smokemonsterr = 1;
		self iPrintlnbold("Smoke Monster: ^2On");
		self thread doSmokeMonster();
	}
	else
	{
		self.smokemonsterr = 0;
		self iPrintlnbold("Smoke Monster: ^1Off");
		self notify("stop_smokemonster");
	}
}
doSmokeMonster()
{
	self endon( "disconnect" );
	self endon( "stop_smokemonster" );
	for(;;)
	{
		spawntimedfx(level.fx_smokegrenade_single, self getTagOrigin("j_spine4"), ( 0, 0, 1 ), 6 );
		wait 0.2;
	}
}

doTheHulk()
{
	self endon("death");
    self endon("disconnect");
    self endon("koral");

    if(level.hulkamania == 0)
    {
        level.hulkamania = 1;
        self iprintlnBold( "^1Your Getting ANGRY!" );
        self thread enablethegod();
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

enablethegod()
{
    if (self.unicorn == true)
    {
            self enableInvulnerability();
            self.unicorn = false;
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
            self.InfiniteHealth = true;
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

    self iPrintlnbold("Super Jump: Enabled/Disabled");
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
skybasetoggle()
{
    if(!level.base)
    {
        if (!isDefined(level.firstspawn) && level.firstspawn1)
        {
            deathBarrier();
            level.firstspawn = true;
            self iprintln("Death Barrier Removed");
        }

        self iprintlnbold("Aim At Position And Shoot To Spawn SkyBase");
        level.base = true;
        self waittill("weapon_fired");
        self toggle();

    }
    else
    {
        self iprintlnbold("Deleted");
        self toggledelete();
        level.base = false;
    }
}
toggle()
{
        level endon("game_ended");
        level endon("delete");
        self endon("death");
          level thread deleteonleave();
        vec = anglestoforward(self getPlayerAngles());
        center = BulletTrace( self gettagorigin("tag_eye"), self gettagorigin("tag_eye")+(vec[0] * 200000, vec[1] * 200000, vec[2] * 200000), 0, self)[ "position" ];
        level.center = spawn("script_origin", center);
        level.lift = [];
        h=0;
        k=0;
        origin = level.center.origin;
        for(i=0;i<204;i++)
        {
            if(i<=50)
                level.lift[k] = spawn("script_model", origin+(-52,52,h));
            else if(i<=101 && i>50)
                level.lift[k] = spawn("script_model", origin+(52,52,h-1402.5*2));
            else if(i<=152 && i>101)
                level.lift[k] = spawn("script_model", origin+(-52,-52,h-2805*2));
            else if(i<=204 && i>152)
                level.lift[k] = spawn("script_model", origin+(52,-52,h-8415));
            level.lift[i].angles = (0,0,90);
            h+=55;
            k++;
        }
        level.center moveto(level.center.origin+(0,0,15), 0.05);
        wait 0.05;
        level.elevator = [];
        level.elevator[0] = spawn("script_model", origin+(0,52,-15));
        level.elevator[0].angles = (0,90,0);
        level.elevator[1] = spawn("script_model", origin+(0,-52,-15));
        level.elevator[1].angles = (0,90,0);
        level.elevator[2] = spawn("script_model", origin+(42,0,-15));
        level.elevator[3] = spawn("script_model", origin+(-42,0,-15));
        level.elevator[3].angles = (0,0,0);
        level.elevator[4] = spawn("script_model", origin+(0,0,-15));
        base = level.center.origin+(-110,182,2750);
        level.elevatorcontrol = [];
        level.elevatorcontrol[0] = spawn("script_model", origin+(0,-52,13.75));
        level.elevatorcontrol[0] setModel( "t6_wpn_supply_drop_ally" );
        level.elevatorcontrol[0].angles = (0,-90,0);
        level.elevatorcontrol[0] linkto(level.center);

        level.elevatorcontrol[1] = spawn("script_model", origin+(0,-52,28.75));
        level.elevatorcontrol[1] setModel( "prop_suitcase_bomb" );
        level.elevatorcontrol[1].angles = (0,180,0);
        level.elevatorcontrol[1] linkto(level.center);
        level.elevatorcontrol[1].type = "control";

        level.elevatorcontrol[2] = spawn("script_model", base+(-40,20,28));
        level.elevatorcontrol[2] setModel( "t6_wpn_supply_drop_ally" );
        level.elevatorcontrol[2].angles = (0,180,0);

        level.elevatorcontrol[3] = spawn("script_model", base+(-40,20,42));
        level.elevatorcontrol[3] setModel( "prop_suitcase_bomb" );
        level.elevatorcontrol[3].angles = (0,90,0);
        level.elevatorcontrol[3].type = "control";

        level.elevatorcontrol[4] = spawn("script_model", origin+(85,84,30));
        level.elevatorcontrol[4] setModel( "prop_suitcase_bomb" );
        level.elevatorcontrol[4].angles = (0,135,0);
        level.elevatorcontrol[4].type = "control";

        level.elevatorcontrol[5] = spawn("script_model", base+(0,224,28));
        level.elevatorcontrol[5] setModel( "t6_wpn_supply_drop_ally" );
        level.elevatorcontrol[5].angles = (0,135,0);

        level.elevatorcontrol[6] = spawn("script_model", base+(205,224,28));
        level.elevatorcontrol[6] setModel( "t6_wpn_supply_drop_ally" );
        level.elevatorcontrol[6].angles = (0,405,0);

        level.elevatorcontrol[7] = spawn("script_model", base+(100,252,28));
        level.elevatorcontrol[7] setModel( "t6_wpn_supply_drop_ally" );
        level.elevatorcontrol[7].angles = (0,90,0);

        level.elevatorcontrol[8] = spawn("script_model", base+(0,224,42));
        level.elevatorcontrol[8] setModel( "prop_suitcase_bomb" );
        level.elevatorcontrol[8].angles = (0,405,0);
        level.elevatorcontrol[8].type = "right";

        level.elevatorcontrol[9] = spawn("script_model", base+(205,224,42));
        level.elevatorcontrol[9] setModel( "prop_suitcase_bomb" );
        level.elevatorcontrol[9].angles = (0,-405,0);
        level.elevatorcontrol[9].type = "left";

        level.elevatorcontrol[10] = spawn("script_model", base+(100,252,42));
        level.elevatorcontrol[10] setModel( "prop_suitcase_bomb" );
        level.elevatorcontrol[10].angles = (0,0,0);
        level.elevatorcontrol[10].type = "forward";

        level.elevatorcontrol[11] = spawn("script_model", base+(240,20,42));
        level.elevatorcontrol[11] setModel( "prop_suitcase_bomb" );
        level.elevatorcontrol[11].angles = (0,-90,0);
        level.elevatorcontrol[11].type = "dock";

        level.elevatorcontrol[12] = spawn("script_model", base+(240,20,28));
        level.elevatorcontrol[12] setModel( "t6_wpn_supply_drop_ally" );

        level.elevatorcontrol[13] = spawn("script_model", base+(240,110,28));
        level.elevatorcontrol[13] setModel( "t6_wpn_supply_drop_ally" );
        level.elevatorcontrol[13].angles = (0,0,0);

        level.elevatorcontrol[14] = spawn("script_model", base+(240,110,42));
        level.elevatorcontrol[14] setModel( "prop_suitcase_bomb" );
        level.elevatorcontrol[14].angles = (0,-90,0);
        level.elevatorcontrol[14].type = "up";

        level.elevatorcontrol[15] = spawn("script_model", base+(-40,110,28));
        level.elevatorcontrol[15] setModel( "t6_wpn_supply_drop_ally" );
        level.elevatorcontrol[15].angles = (0,180,0);

        level.elevatorcontrol[16] = spawn("script_model", base+(-40,110,42));
        level.elevatorcontrol[16] setModel( "prop_suitcase_bomb" );
        level.elevatorcontrol[16].type = "down";
        level.elevatorcontrol[16].angles = (0,90,0);

        level.elevatorcontrol[17] = spawn("script_model", origin+(-85,84,13.75));
        level.elevatorcontrol[17] setModel( "t6_wpn_supply_drop_ally" );
        level.elevatorcontrol[17].angles = (0,-45,0);

        level.elevatorcontrol[18] = spawn("script_model", origin+(-85,84,28.75));
        level.elevatorcontrol[18] setModel( "prop_suitcase_bomb" );
        level.elevatorcontrol[18].angles = (0,-135,0);
        level.elevatorcontrol[18].type = "forcedock";

        level.elevatorcontrol[19] = spawn("script_model", base+(175,-45,28));
        level.elevatorcontrol[19] setModel( "t6_wpn_supply_drop_ally" );
        level.elevatorcontrol[19].angles = (0,-90,0);

        level.elevatorcontrol[20] = spawn("script_model", base+(175,-45,42));
        level.elevatorcontrol[20] setModel( "prop_suitcase_bomb" );
        level.elevatorcontrol[20].angles = (0,180,0);
        level.elevatorcontrol[20].type = "destroy";

        level.elevatorcontrol[21] = spawn("script_model", base+(30,-45,28));
        level.elevatorcontrol[21] setModel( "t6_wpn_supply_drop_ally" );
        level.elevatorcontrol[21].angles = (0,-90,0);
        level.elevatorcontrol[21].type = "mystery";

        level.elevatorcontrol[22] = spawn("script_model", origin+(85,84,13.75));
        level.elevatorcontrol[22] setModel( "t6_wpn_supply_drop_ally" );
        level.elevatorcontrol[22].angles = (0,225,0);

        level.center2 = spawn("script_origin", level.center.origin);
        level.center2 linkto(level.center);
        level.elevatorPlatform = [];
        level.elevatorPlatform[0] = spawn("script_model", origin+(0,-40,-15));
        level.elevatorPlatform[0].angles = (0,90,0);
        level.elevatorPlatform[1] = spawn("script_model", origin+(0,0,-15));
        level.elevatorPlatform[1].angles = (0,90,0);
        //level.elevatorPlatform[2] = spawn("script_model", origin+(0,14,-15));
        level.elevatorPlatform[2] = spawn("script_model", origin+(0,40,-15));
        level.elevatorPlatform[2].angles = (0,90,0);
        level.elevatorBase = [];
        j = 0;
        w = 0;
        for(x=0;x<4;x++)
        {
            for(i=0;i<6;i++)
            {
                level.elevatorBase[j] = spawn("script_model", base+(i*40,w,0));
                j++;
            }
            w+= 70;
        }
        level.BaseCenter = spawn("script_origin", base+(110,126,0));
        level.BaseCenterOrigAng = level.BaseCenter.angles;
        level.BaseCenterOrigOrigin = level.BaseCenter.origin;
        for(i=5;i<=level.elevatorcontrol.size;i++)
                level.elevatorcontrol[i] linkto(level.BaseCenter);
        level.elevatorcontrol[17] unlink();
        level.elevatorcontrol[18] unlink();
        level.elevatorcontrol[2] linkto(level.BaseCenter);
        level.elevatorcontrol[3] linkto(level.BaseCenter);
        foreach(elevatorbase in level.elevatorBase)
        {
                elevatorbase setModel( "t6_wpn_supply_drop_ally" );
                elevatorbase linkto(level.BaseCenter);
        }
        foreach(platform in level.elevatorPlatform)
        {
                platform linkto(level.center2);
                platform setModel( "t6_wpn_supply_drop_ally" );

        }
        foreach(elevator in level.elevator)
        {
                elevator setmodel("t6_wpn_supply_drop_ally");
                elevator linkto(level.center);
        }
        foreach(lift in level.lift)
        {
                lift setmodel("t6_wpn_supply_drop_ally");
        }
        level.elevatorcontrol[1] thread Sky_Player_Think1(level.activesky1);
        level.elevatorcontrol[1] thread Sky_Think1();
        level.elevatorcontrol[3] thread Sky_Player_Think1(level.activesky1);
        level.elevatorcontrol[3] thread Sky_Think1();
        level.elevatorcontrol[4] thread Sky_Player_Think1(level.activesky1);
        level.elevatorcontrol[4] thread Sky_Think1();
        level.elevatorcontrol[8] thread Sky_Player_Think1(level.activesky1);
        level.elevatorcontrol[8] thread Sky_Think1();
        level.elevatorcontrol[9] thread Sky_Player_Think1(level.activesky1);
        level.elevatorcontrol[9] thread Sky_Think1();
        level.elevatorcontrol[10] thread Sky_Player_Think1(level.activesky1);
        level.elevatorcontrol[10] thread Sky_Think1();
        level.elevatorcontrol[11] thread Sky_Player_Think1(level.activesky1);
        level.elevatorcontrol[11] thread Sky_Think1();
        level.elevatorcontrol[14] thread Sky_Player_Think1(level.activesky1);
        level.elevatorcontrol[14] thread Sky_Think1();
        level.elevatorcontrol[16] thread Sky_Player_Think1(level.activesky1);
        level.elevatorcontrol[16] thread Sky_Think1();
        level.elevatorcontrol[18] thread Sky_Player_Think1(level.activesky1);
        level.elevatorcontrol[18] thread Sky_Think1();
        level.elevatorcontrol[20] thread Sky_Player_Think1(level.activesky1);
        level.elevatorcontrol[20] thread Sky_Think1();
        level.elevatorcontrol[21] thread Sky_Think1();
        level.elevatorcontrol[21] thread MysteryBox_Think();
        level.elevatorcontrol[21] thread Sky_Player_Think1(level.activesky1);
}


 Sky_Think1()
{
    level endon("game_ended");
     level endon("delete");
    localskybaseNumber1 = level.activesky1;
    level.SkybaseInUse[localskybaseNumber1] = false;
    level.activesky1++;

    for(;;)
    {

        self waittill ("triggeruse" , player, localskybaseNumber1);


            level.SkybaseInUse[localskybaseNumber1] = true;
        if(self.type == "left" || self.type == "right")
        {
            while(player Usebuttonpressed())
            {
                if(self.type == "left")
                {
                    foreach(player in level.players)
	                {
	                    player.fakelink = spawn("script_origin", player.origin);
	                    player playerlinkto(player.fakelink);
	                    player.fakelink linkto(self);

                    level.BaseCenter rotateyaw(-2, 0.05);
                    wait 0.05;

	                    player unlink();
	                    player.fakelink delete();
                    }

                }
                else
                {
                    foreach(player in level.players)
					{
	                    player.fakelink = spawn("script_origin", player.origin);
	                    player playerlinkto(player.fakelink);
	                    player.fakelink linkto(self);

                    level.BaseCenter rotateyaw(2, 0.05);
                    wait 0.05;

	                    player unlink();
	                    player.fakelink delete();
	                }
                }
            }
        }
        if(self.type == "forward")
        {
            while(player Usebuttonpressed())
            {
                foreach(player in level.players)
				{
	                player.fakelink = spawn("script_origin", player.origin);
	                player playerlinkto(player.fakelink);
	                player.fakelink linkto(self);

                vec = anglestoright(level.BaseCenter.angles);
                center = BulletTrace( level.BaseCenter.origin, level.BaseCenter.origin+(vec[0] * -100, vec[1] * -100, vec[2] * -100), 0, self)[ "position" ];
                level.BaseCenter moveto(center, 0.05);
                wait 0.05;

	                player unlink();
	                player.fakelink delete();
                }
            }
        }
        if(self.type == "dock" || self.type == "forcedock")
        {
            while(player Usebuttonpressed())
            {
                if(self.type == "dock")
                {
                   foreach(player in level.players)
				   {
	                    player.fakelink = spawn("script_origin", player.origin);
	                    player playerlinkto(player.fakelink);
	                    player.fakelink linkto(self);
	                }
                    speed = distance(level.BaseCenter.origin, level.BaseCenterOrigOrigin)/1000;
                    level.BaseCenter moveto(level.BaseCenterOrigOrigin, speed, speed*0.8, speed*0.2);
                    level.BaseCenter rotateto(level.BaseCenterOrigAng, 3, 2, 1);
                    while(level.BaseCenter.origin != level.BaseCenterOrigOrigin)
                    wait 0.05;
                    wait 0.05;
                    foreach(player in level.players)
					{
	                    player unlink();
	                    player.fakelink delete();
	                }

                }
                if(player isHost() && self.type == "forcedock")
                {

                    speed = distance(level.BaseCenter.origin, level.BaseCenterOrigOrigin)/1000;
                    level.BaseCenter moveto(level.BaseCenterOrigOrigin, speed, speed*0.8, speed*0.2);
                    level.BaseCenter rotateto(level.BaseCenterOrigAng, 3, 2, 1);

                    wait 0.05;
                }
                else if(self.type == "forcedock" && !player ishost())
                player iprintlnbold("^1You must be host");
                wait 0.05;
            }
        }
        if(self.type == "up" || self.type == "down")
        {
            while(player Usebuttonpressed())
            {
                if(self.type == "up")
                {
                   foreach(player in level.players)
					{
	                    player.fakelink = spawn("script_origin", player.origin);
	                    player playerlinkto(player.fakelink);
	                    player.fakelink linkto(self);
	                    level.BaseCenter moveto(level.BaseCenter.origin+(0,0,10), 0.05);
	                    wait 0.05;
	                    player unlink();
	                    player.fakelink delete();
                    }
                }
                else
                {
                   foreach(player in level.players)
					{
	                    player.fakelink = spawn("script_origin", player.origin);
	                    player playerlinkto(player.fakelink);
	                    player.fakelink linkto(self);
	                    level.BaseCenter moveto(level.BaseCenter.origin-(0,0,10), 0.05);
	                    wait 0.05;
	                    player unlink();
	                    player.fakelink delete();
	                }
	            }
            }
        }
        if(self.type == "destroy")
        {
            if(player Usebuttonpressed())
            {
                self endon("endNuke");

                level.elevatorcontrol[2] setmodel("t6_wpn_supply_drop_axis");
                level.elevatorcontrol[19] setmodel("t6_wpn_supply_drop_axis");
                plane = spawn("script_model", level.center.origin+(30000,0,5000));
                plane setmodel("veh_t6_drone_overwatch_light");
                plane.angles = (0,-180,0);
                plane moveto(level.center.origin, 5); //-(0,0,200)
                wait 5;
                level._effect["emp_flash"] = loadfx("weapon/emp/fx_emp_explosion");
                playfx(level._effect["emp_flash"], plane.origin);
                self playsound("wpn_rocket_explode");
                player playlocalsound( "nuke_explosion" );
                player playlocalsound( "nuke_wave" );
                plane hide();

                for(i=0;i<=level.lift.size;i++)
                {
                    level.lift[i] unlink();
                    level.lift[i] PhysicsLaunch( plane.origin, (i*-10,0,randomint(1000)) );
                }
                foreach(elevator in level.elevator)
                {
                    elevator unlink();
                    elevator PhysicsLaunch( plane.origin, (i*-10,0,1000) );
                }
                foreach(platform in level.elevatorPlatform)
                {
                    platform unlink();
                    platform PhysicsLaunch( plane.origin, (1000,1000,1000) );
                }
                level.elevatorcontrol[0] unlink();
                level.elevatorcontrol[1] unlink();
                level.elevatorcontrol[4] unlink();
                level.elevatorcontrol[17] unlink();
                level.elevatorcontrol[18] unlink();
                level.elevatorcontrol[0] PhysicsLaunch( plane.origin, (1000,1000,1000) );
                level.elevatorcontrol[1] PhysicsLaunch( plane.origin, (1000,1000,1000) );
                level.elevatorcontrol[4] PhysicsLaunch( plane.origin, (1000,1000,1000) );
                level.elevatorcontrol[17] PhysicsLaunch( plane.origin, (1000,1000,1000) );
                level.elevatorcontrol[18] PhysicsLaunch( plane.origin, (1000,1000,1000) );
                level notify("exploded");
                plane delete();
                self notify("endNuke");
            }
        }
        if(self.type == "mystery")
        {
            if (player UseButtonPressed())
            {
                 level.SkybaseInUse[localskybaseNumber1] = false;
                 if(!level.SkybaseInUse[localskybaseNumber1] && !self.mysteryBoxInUse )//&& !player.mysteryBoxWeaponReady[localskybaseNumber1])
                {
                    level.SkybaseInUse[localskybaseNumber1] = true;
                    wait 0.10;
                    player.currentskybaseHint1 = "";
                    player.isUsingMysteryBox = true;
                    self.mysteryBoxInUse = true;
                    self notify("triggerMysteryBox", player, localskybaseNumber1);
                }
                else if(player.mysteryBoxWeaponReady)
                {
                    wait 0.10;
                    self notify("tookMysteryBoxWeapon");
                    level.SkybaseInUse[localskybaseNumber1] = false;
                }
                wait 0.10;
            }
        }
        if(self.type == "control")
        {
            if (player UseButtonPressed())
            {

                 if(distance(level.elevatorcontrol[1].origin, player.origin) <60)
                    place = "elevator";
                else
                    place = "";
				 foreach(player in level.players)
				 {
	                if(place == "elevator")
	                    player PlayerLinkTo(level.center);
                 }

                if(level.elevatorDirection == "up")
                {
                    level.SkybaseInUse1[localskybaseNumber] = true;

                    level.elevatorDirection = "down";
                    level.center moveto(level.center.origin+(0,0,2750), 5, 3, 2);
                }
                else
                {
                    level.center2 unlink();
                    foreach(platform in level.elevatorPlatform)
                        platform linkto(level.center2);
                    level.center2 moveto(level.center2.origin-(0,112,0), 3);
                    wait 3.1;
                    level.center2 linkto(level.center);
                    level.center moveto(level.center.origin-(0,0,2750), 5, 3, 2);
                    level.elevatorDirection = "up";
                }
                wait 5.5;
				foreach(player in level.players)
				{
                	if(place == "elevator")
                    	player unlink();
				}
                if(level.elevatorDirection == "down")
                {
                    level.center2 unlink();
                    foreach(platform in level.elevatorPlatform)
                    platform linkto(level.center2);
                    level.center2 moveto(level.center2.origin+(0,112,0), 3);
                    wait 3.5;
                }

                level.SkybaseInUse[localskybaseNumber1] = false;
            }
        }
    }
}

Sky_Player_Think1(localskybaseNumber1)
{
    level endon("game_ended");
    self endon("disconnect");
    level endon("delete");
    level.elevatorDirection = "up";

    for(;;)
    {
        foreach(player in level.players)
        {
            if (!isDefined(player.doorStringCreated1[localskybaseNumber1]))
            {
                player.skybaserHintString1[localskybaseNumber1] = player drawText(player.currentskybaseHint1, "objective", 1.5, 0, -50, (1, 1, 1), 0, (0, 0, 0), 0, 8);
                player.skybaserHintString1[localskybaseNumber1].alpha = 0;
                player.skybaserHintString1[localskybaseNumber1].alignX = "center";
                player.skybaserHintString1[localskybaseNumber1].alignY = "bottom";
                player.skybaserHintString1[localskybaseNumber1].horzAlign = "center";
                player.skybaserHintString1[localskybaseNumber1].vertAlign = "bottom";
                player.doorStringCreated1[localskybaseNumber1] = true;
                player.nearsky[localskybaseNumber1] = false;
            }
            if (player.nearsky[localskybaseNumber1] && !level.SkybaseInUse[localskybaseNumber1] )
            {
                player.skybaserHintString1[localskybaseNumber1] setText(player.currentskybaseHint1);
                self notify("textset");
                level.result += 1;
                player.skybaserHintString1[localskybaseNumber1].alpha = 1;
            }
            else
                player.skybaserHintString1[localskybaseNumber1].alpha = 0;

            if(Distance(self.origin, player.origin) <= 50)
            {
                if(self.type == "left" || self.type == "right")
                {
                    if(self.type == "right")
                    {
                        player.currentskybaseHint1 = "MoveLeft Hold ^3[{+activate}]^7 to go left";
                        player.nearsky[localskybaseNumber1] = true;
                    }
                    else
                    {
                        player.currentskybaseHint1 = "MoveRight Hold ^3[{+activate}]^7 to go right";
                        player.nearsky[localskybaseNumber1] = true;
                    }
                }
                if(self.type == "forward")
                {
                    player.currentskybaseHint1 = "MoveForward Hold ^3[{+activate}]^7 to go forward";
                    player.nearsky[localskybaseNumber1] = true;
                }

                if(self.type == "dock" || self.type == "forcedock")
                {
                    if(self.type == "dock")
                    {
                        player.currentskybaseHint1 = "Redock Press ^3[{+activate}]^7 to redock";
                        player.nearsky[localskybaseNumber1] = true;
                    }
                    else
                    {
                        player.currentskybaseHint1 = "forcedock Press ^3[{+activate}]^7 to force redock [Host Only]";
                        player.nearsky[localskybaseNumber1] = true;
                    }
                }
                if(self.type == "up" || self.type == "down")
                {
                    if(self.type == "up")
                    {
                        player.currentskybaseHint1 = "Moveup Hold ^3[{+activate}]^7 to go up";
                        player.nearsky[localskybaseNumber1] = true;
                    }
                    else
                    {
                        player.currentskybaseHint1 = "Movedown Hold ^3[{+activate}]^7 to go down";
                        player.nearsky[localskybaseNumber1] = true;
                    }
                }
                if(self.type == "destroy")
                {
                    self endon("endNuke");
                    player.currentskybaseHint1 = "destroy Press ^3[{+activate}]^7 to remove access";
                    player.nearsky[localskybaseNumber1] = true;
                }
                if(self.type == "mystery")
                {
                    if ( !self.mysteryBoxInUse )
                    {
                        player.currentskybaseHint1 = "Press [{+usereload}] To Use Mystery Box";
                            player.nearsky[localskybaseNumber1] = true;
                    }
                    else if ( self.mysteryBoxInUse &&  player.mysteryBoxWeaponReady )
                    {
                       player.currentskybaseHint1 = "Press [{+usereload}] To Take Weapon";
                    }
                }
                if(self.type == "control")
                {
                    if(level.elevatorDirection == "up")
                        player.currentskybaseHint1 = "ControlElevator Press ^3[{+activate}]^7 to go up";
                    if(level.elevatorDirection == "down")
                        player.currentskybaseHint1 = "ControlElevator Press ^3[{+activate}]^7 to go down";
                }
                if(player UseButtonPressed() && isAlive(player))
                {
                   self notify("triggeruse" , player, localskybaseNumber1);
                    wait 0.05;
                }
                player.nearsky[localskybaseNumber1] = true;
            }
            else
                player.nearsky[localskybaseNumber1] = false;
        }
        wait 0.1;
    }
}
MysteryBox_Think()
{
    level endon("game_ended");

    for (;;)
    {
        self waittill("triggerMysteryBox", player, localskybaseNumber1);
        currentWeapon = spawn("script_model", self.origin + (0,0,20));
        currentWeapon.angles = self.angles + (0, 90, 0);
        self thread MysteryBox_WeaponMover_Think(currentWeapon);

        self waittill("mysteryBoxWeaponMoverFinished");
        level.SkybaseInUse[localskybaseNumber1] = false;
        self thread MysteryBox_Timeout_Think();
        player.mysteryBoxWeaponReady = true;

        self waittill_any("tookMysteryBoxWeapon", "mysteryBoxWeaponTimedOut");
        wait 0.50;
        if (!self.timedOut)
            player replaceWeaponWorld(self.currentWeaponReturn, "All");
            currentWeapon delete();
            player.isUsingMysteryBox = false;
            player.mysteryBoxWeaponReady = false;
            self.mysteryBoxInUse = false;
            self.timedOut = false;
            level.SkybaseInUse[localskybaseNumber1] = false;
            wait 0.01;
    }
}

MysteryBox_Timeout_Think()
{
    level endon("game_ended");
    self endon("tookMysteryBoxWeapon");

    wait 12;
    self.timedOut = true;
    self notify("mysteryBoxWeaponTimedOut");
}

MysteryBox_WeaponMover_Think(currentWeapon)
{
    level endon("game_ended");

    self.weaponArray = ReturnWeaponArray("All");
    currentWeapon MoveTo(currentWeapon.origin + (0, 0, 20), 10, 2, 2);
    for (i = 0; i < 30; i++)
    {
        tempRandomWeapon = self.weaponArray[randomint(self.weaponArray.size)];
        currentWeapon SetModel(GetWeaponModel(tempRandomWeapon));
        self.currentWeaponReturn = tempRandomWeapon;
        wait 0.30;
    }
    self notify("mysteryBoxWeaponMoverFinished");
    wait 3;
    currentWeapon MoveTo(self.origin, 10, 2, 2);
}
toggledelete()
{
    foreach(elevatorbase in level.elevatorBase)
    {
        elevatorbase delete();
    }
    foreach(platform in level.elevatorPlatform)
    {
        platform delete();
    }
    foreach(elevator in level.elevator)
    {
        elevator delete();
    }
    foreach(lift in level.lift)
    {
        lift delete();
    }
    foreach(elevatorcontrol in level.elevatorcontrol)
    {
        elevatorcontrol delete();
    }
    foreach(player in level.players)
    {
       for (j = 0; j < level.activesky1 + 10; j++)
       {
           player.skybaserHintString1[j].alpha = 0;
       }
    }
    level.activesky1 = 0;
    level.base = false;
    level notify("delete");
}
deleteonleave()
{
    for(;;)
    {
        level waittill("game_ended");
        foreach(player in level.players)
        {

           for (i = 0; i < level.activesky1; i++)
           {
                player.skybaserHintString1[i] destroyElem();
                player.skybaserHintString1[i] destroy();
           }
        }
    }
}

ReturnWeaponArray(category)
{

    level.WeaponArray["All"][0] = "mp7_mp";
    level.WeaponArray["All"][1] = "pdw57_mp";
    level.WeaponArray["All"][2] = "vector_mp";
    level.WeaponArray["All"][3] = "insas_mp";
    level.WeaponArray["All"][4] = "qcw05_mp";
    level.WeaponArray["All"][5] = "evoskorpion_mp";
    level.WeaponArray["All"][6] = "peacekeeper_mp";
    level.WeaponArray["All"][7] = "tar21_mp";
    level.WeaponArray["All"][8] = "type95_mp";
    level.WeaponArray["All"][9] = "sig556_mp";
    level.WeaponArray["All"][10] = "sa58_mp";
    level.WeaponArray["All"][11] = "hk416_mp";
    level.WeaponArray["All"][12] = "scar_mp";
    level.WeaponArray["All"][13] = "saritch_mp";
    level.WeaponArray["All"][14] = "xm8_mp";
    level.WeaponArray["All"][15] = "an94_mp";
    level.WeaponArray["All"][16] = "870mcs_mp";
    level.WeaponArray["All"][17] = "saiga12_mp";
    level.WeaponArray["All"][18] = "ksg_mp";
    level.WeaponArray["All"][19] = "srm1216_mp";
    level.WeaponArray["All"][20] = "mk48_mp";
    level.WeaponArray["All"][21] = "qbb95_mp";
    level.WeaponArray["All"][22] = "lsat_mp";
    level.WeaponArray["All"][23] = "hamr_mp";
    level.WeaponArray["All"][24] = "svu_mp";
    level.WeaponArray["All"][25] = "dsr50_mp";
    level.WeaponArray["All"][26] = "ballista_mp";
    level.WeaponArray["All"][27] = "as50_mp";
    level.WeaponArray["All"][28] = "fiveseven_mp";
    level.WeaponArray["All"][29] = "fnp45_mp";
    level.WeaponArray["All"][30] = "beretta93r_mp";
    level.WeaponArray["All"][31] = "judge_mp";
    level.WeaponArray["All"][32] = "kard_mp";
    level.WeaponArray["All"][33] = "smaw_mp";
    level.WeaponArray["All"][34] = "usrpg_mp";
    level.WeaponArray["All"][35] = "fhj18_mp";
    level.WeaponArray["All"][36] = "minigun_wager_mp";
    level.WeaponArray["All"][37] = "m32_wager_mp";
    level.WeaponArray["All"][38] = "riotshield_mp";
    level.WeaponArray["All"][39] = "crossbow_mp";
    level.WeaponArray["All"][40] = "knife_ballistic_mp";
    level.WeaponArray["All"][41] = "knife_held_mp";

    if (category == "All")
        return level.WeaponArray["All"];
}

isValidWeapon(WeaponRef)
{
    if (StrTok(WeaponRef, "_")[1] != "dw")
        WeaponRef = StrTok(WeaponRef, "+")[0];
    else
        WeaponRef = StrTok(WeaponRef, "_")[0] + "_mp";
        self.validReturn = WeaponRef;
        self.TempWeaponArray = ReturnWeaponArray("All");
    for (i = 0; i < self.TempWeaponArray.size; i++)
    {
        if (self.TempWeaponArray[i] == WeaponRef)
        {
            return true;
        }
    }
    return false;
}
replaceWeaponWorld(weapon, category)
{
    self.currentWeapon = self GetCurrentWeapon();
    if (isValidWeapon(self.currentWeapon))
    {
        self.currentWeaponNew = self.validReturn;
        if (weapon != self.currentWeapon )
        {
            self TakeWeapon(self.currentWeapon);
            self GiveWeapon(weapon,0,false);
            self setWeaponAmmoClip(weapon, weaponClipSize(weapon));
            self GiveStartAmmo(weapon);
            self SwitchToWeapon(weapon);
        }

    }

}

ThirdPerson()
{
if (self.TPP == true)
    {
        self setclientthirdperson(1);
        self iPrintlnbold("Third Person: ^2ON");
        self.TPP = false;
    }
    else
    {
        self setclientthirdperson(0);
        self iPrintlnbold("Third Person: ^1OFF");
        self.TPP = true;
    }
}


ShowFPS()
{
    if(self.ShowFps==0)
    {
        self.ShowFps=1;
        self iPrintlnbold("FPS ^2ON");
        self setperk("specialty_bulletaccuracy");
setDvar( "cg_drawFPS", "1" );
setDvar( "cg_drawBigFPS", "1" );

    }
    else
    {
        self.ShowFps=0;
        self iPrintlnbold("FPS ^1OFF");
setDvar( "cg_drawFPS", "0" );
setDvar( "cg_drawBigFPS", "0" );


    }
}

NoRecooil()
{
    if(self.norecoil==0)
    {
        self.norecoil=1;
        self iPrintlnbold("No Recoil ^2ON");
        setDvar("player_recoilScaleOn",0);

    }
    else
    {
        self.norecoil=0;
        self iPrintlnbold("No Recoil ^1OFF");
        setDvar("player_recoilScaleOn",1);
    }
}

followGuy( )
{
self endon("disconnect");
self endon("death");
	for(;;)
	{
		Distancee = 999999999;
		LuckyGuy = undefined;

		foreach( player in level.players )
		{
			if(distancesquared(self.origin, player.origin) < TmpDist)
			{
				Distancee = distancesquared(self.origin, player.origin);
				LuckyGuy = player;
			}
		}

		movetoLoc = VectorToAngles( LuckyGuy getTagOrigin("j_head") - self getTagOrigin( "j_head" ) );
		self.angles = (0, movetoLoc[1], 0);
		self MoveTo(LuckyGuy.origin, (distance(self.origin, LuckyGuy.origin) / 150));

	wait 0.08;
	}

}

SupplyFuncion(owner,origin,angles)
{
self endon("disconnect");
self endon("death");
self endon("zomboz");
self iPrintln("^2Shoot^7 to spawn a Rapist");
for(;;)
{
self waittill ("weapon_fired");
start = self gettagorigin( "tag_eye" );
end = anglestoforward(self getPlayerAngles()) * 1000000;
destination = BulletTrace(start, end, true, self)["position"];
M = spawn("script_model",destination,1);
M.angles = self.angles;
M setModel("c_usa_mp_seal6_smg_fb");
P = spawn("script_model",M.origin,1);
P setModel("t6_wpn_supply_drop_ally");
P.angles = (90,0,0);
P Hide();
P.script_noteworthy = "care_package";
P linkto( M );
M thread followGuy();
self notify("zomboz");
wait 1;
}
}

Supply()
{
	if (self.Supply == true)
	{
		self thread SupplyFuncion();
		self iPrintlnbold("Rapist ^2ON");
		self.Supply = false;
		}
		else
		{
		self notify("zomboz");
		self iPrintlnbold("Rapist ^1OFF");
		self.Supply = true;
	}
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
    self iPrintlnbold("Infinite Game : ^2ON");
    }
    else
    {
    self maps\mp\gametypes\_globallogic_utils::resumetimer();
    self iPrintlnbold("Infinite Game : ^1OFF");
    }
}

endGame()
{
    self freezecontrols(false);
    self iPrintlnbold("^2End. Fucking Rager LOLOL.");
    level thread maps/mp/gametypes/_globallogic::forceend();
}
MapRestartKidWhyAreULEeechinghm()
{
    self iPrintlnbold("^2RESTARTTTTTTTTTTTT");
    map_restart( false );
}

defaultVision()
{
visionsetnaked("default", 1);
wait 0.01;
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
        self iPrintlnbold("Anti Quit : ^2ON");
    }
    else
    {
        foreach(player in level.players)
        {
            player notify("EnddoAntiQuit");
        }
        level.doAntiQuit=0;
        self iPrintlnbold("Anti Quit : ^1OFF");
    }
}
doAntiQuit()
{
self endon("disconnect");
self endon("EnddoAntiQuit");

for(;;)
{
self maps/mp/gametypes/_globallogic_ui::closeMenus();
wait 0.05;
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
	self iPrintlnbold("^5Random Camo Received ^7#"+ rand);
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



build(){
    self endon("death");
    self endon("game_ended");
    for(;;){
        if(level.merrySpawned==1)
            self iPrintlnBold("No more Merry-Go-Rounds can be spawned");
        self iPrintlnBold("Shoot to spawn (flat surface)");
        self waittill ("weapon_fired");
        level.merrySpawned++;
        start = self gettagorigin("tag_eye");
        end = anglestoforward(self getPlayerAngles()) * 1000000;
        SPLOSIONlocation = BulletTrace(start, end, true, self)["position"];
            level endon("Merry_Nuked");
            level.Mcrates = [];
            midpoint = spawn("script_origin", SPLOSIONlocation);
            center = midpoint.origin;
            level.center = midpoint.origin;
            h = 0;
                LOLCATS = 0;
                for(j=0;j<2;j++){
                   for(i=60;i<240;i+=60){
                           level.Mcrates[h] = spawn("script_model", center+(i,0,LOLCATS));
                           level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
                           h++;}
                   for(i=60;i<240;i+=60){
                           level.Mcrates[h] = spawn("script_model", center-(i,0,0-LOLCATS));
                           level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
                           h++;}
                   for(i=60;i<240;i+=60){
                           level.Mcrates[h] = spawn("script_model", center-(0,i,0-LOLCATS));
                           level.Mcrates[h].angles = (0,90,0);
                           level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
                           h++;}
                   for(i=60;i<240;i+=60){
                           level.Mcrates[h] = spawn("script_model", center+(0,i,LOLCATS));
                           level.Mcrates[h].angles = (0,90,0);
                           level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
                           h++; }
                   foreach(Mcrates in level.Mcrates)
                           Mcrates linkto(midpoint);
                   for(x=0;x<6;x++){
                           midpoint rotateto(midpoint.angles+(0,11.25,0),0.05);
                           wait 0.1;
                           for(i=60;i<240;i+=60){
                                   level.Mcrates[h] = spawn("script_model", center-(0,i,0-LOLCATS));
                                   level.Mcrates[h].angles = (0,90,0);
                                   level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
                                   h++;}
                           for(i=60;i<240;i+=60){
                                   level.Mcrates[h] = spawn("script_model", center+(0,i,LOLCATS));
                                   level.Mcrates[h].angles = (0,90,0);
                                   level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
                                   h++;}
                           for(i=60;i<240;i+=60){
                                   level.Mcrates[h] = spawn("script_model", center-(i,0,0-LOLCATS));
                                   level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
                                   h++;}
                           for(i=60;i<240;i+=60){
                                   level.Mcrates[h] = spawn("script_model", center+(i,0,LOLCATS));
                                   level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
                                   h++;}
                           foreach(Mcrates in level.Mcrates){
                                   Mcrates linkto(midpoint);}}
                LOLCATS=180;
                wait 0.2;}
        for(x=30;x<180;x+=30){
                for(i=0;i<6;i++){
                        level.Mcrates[h] = spawn("script_model", center+(0,0,x));
                        level.Mcrates[h].angles = (0,i*22.5,0);
                        level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
                        h++;}
                wait 0.02;}
        level.MerrySeat = [];
        level.MerrySeat[0] = spawn("script_model", center+(-22,100,30));
        level.MerrySeat[0] setmodel("t6_wpn_supply_drop_trap");
        level.MerrySeat[0].angles = (90,0,0);
        level.MerrySeat[1] = spawn("script_model", center+(-22,-100,30));
        level.MerrySeat[1] setmodel("t6_wpn_supply_drop_trap");
        level.MerrySeat[1].angles = (90,0,0);
        level.MerrySeat[2] = spawn("script_model", center+(-100,-22,30));
        level.MerrySeat[2] setmodel("t6_wpn_supply_drop_trap");
        level.MerrySeat[2].angles = (90,90,0);
        level.MerrySeat[3] = spawn("script_model", center+(100,-22,30));
        level.MerrySeat[3] setmodel("t6_wpn_supply_drop_trap");
        level.MerrySeat[3].angles = (90,90,0);
        level.MerrySeat[4] = spawn("script_model", center+(-122,100,30));
        level.MerrySeat[4] setmodel("t6_wpn_supply_drop_trap");
        level.MerrySeat[4].angles = (90,45,0);
        level.MerrySeat[5] = spawn("script_model", center+(122,-100,30));
        level.MerrySeat[5] setmodel("t6_wpn_supply_drop_trap");
        level.MerrySeat[5].angles = (90,-135,0);
        level.MerrySeat[6] = spawn("script_model", center+(-100,-122,30));
        level.MerrySeat[6] setmodel("t6_wpn_supply_drop_trap");
        level.MerrySeat[6].angles = (90,135,0);
        level.MerrySeat[7] = spawn("script_model", center+(100,122,30));
        level.MerrySeat[7] setmodel("t6_wpn_supply_drop_trap");
        level.MerrySeat[7].angles = (90,-45,0);
        level.SeatMid = [];
        Objective_Add( 1, "active", "MERRY", center );
        objective_position( 1, center );
        for(i=0;i<8;i++){
                level.SeatMid[i] = spawn("script_origin", SPLOSIONlocation);
                wait 0.01;}
        level.FakeSeat = [];
        for(i=0;i<8;i++){
                level.FakeSeat[i] = spawn("script_origin", level.MerrySeat[i].origin-(0,0,37));
                level.FakeSeat[i].num = i;
                level.FakeSeat[i].InUse = false;
                wait 0.01;}
        i = 0;
        foreach(FakeSeat in level.FakeSeat){
                FakeSeat linkto(level.MerrySeat[i]);
                FakeSeat thread ManageDistance();
                i++;
                wait 0.01;}
        i = 0;
        foreach(MerrySeat in level.MerrySeat){
                MerrySeat linkto(level.SeatMid[i]);
                level.SeatMid[i] thread MoveAbout();
                i++;
                wait 0.01;}
        wait 0.01;
        for(;;){
                midpoint rotateyaw(-720, 8);
                foreach(SeatMid in level.SeatMid){
                        SeatMid rotateyaw(-720, 8);
                       wait 0.01;}
                wait 7;}}}
MerryNuke(){
        level endon("nuked");
        level.Detonator = spawn("script_model", level.center+(60,-355,0));
        level.Detonator setmodel("prop_suitcase_bomb");
        level.Detonator.angles = (0,90,0);
        level.Bomb = spawn("script_model", level.center+(60,-340,6));
        level.Bomb setmodel("projectile_hellfire_missile");
        Detonator = level.Detonator;
        Collision = [];
        Collision[0] = spawn("script_model", level.center+(0,-320,14));
        Collision[1] = spawn("script_model", level.center+(0,-320,42));
        Collision[2] = spawn("script_model", level.center+(0,-280,42));
        Collision[3] = spawn("script_model", level.center+(0,-280,14));
        Collision[4] = spawn("script_model", level.center+(55,-320,14));
        Collision[5] = spawn("script_model", level.center+(55,-320,42));
        Collision[6] = spawn("script_model", level.center+(55,-280,42));
        Collision[7] = spawn("script_model", level.center+(55,-280,14));
        Collision[8] = spawn("script_model", level.center+(110,-320,14));
        Collision[9] = spawn("script_model", level.center+(110,-320,42));
        Collision[10] = spawn("script_model", level.center+(110,-280,42));
        Collision[11] = spawn("script_model", level.center+(110,-280,14));
        Collision[12] = spawn("script_model", level.center+(145,-320,14));
        Collision[13] = spawn("script_model", level.center+(145,-320,42));
        Collision[14] = spawn("script_model", level.center+(145,-280,42));
        Collision[15] = spawn("script_model", level.center+(145,-280,14));
        Collision[16] = spawn("script_model", level.center+(60,-330,0));
        Collision[17] = spawn("script_model", level.center+(60,-330,0));
        Collision[17].angles = (0,90,0);
        level.MerryNuke = false;
        for(;;){
                foreach(player in level.players){
                        if(distance(Detonator.origin, player gettagorigin("j_head")) <30 && level.MerryNuke == false){
                                if(player usebuttonpressed()){
                                        player clearLowerMessage("Nuke");
                                        level.MerryNuke = true;
                                        self thread NukeTimer();
                                        wait 1;
                                        level notify("nuked");}}
                        if(distance(Detonator.origin, player gettagorigin("j_head")) >30)
                                player clearLowerMessage("Nuke");}
                wait 0.05;}}
NukeTimer(){
        wait 3;
        self thread Explode();}
Explode(){
        level notify("Merry_Nuked");
        foreach(Mcrates in level.Mcrates){
                Mcrates unlink();
                Mcrates delete();}
        foreach(ControlPanel in level.ControlPanels)
                ControlPanel delete();
        foreach(MerrySeat in level.MerrySeat)
                MerrySeat delete();
        level.merrySpawned = 0;}
ManageDistance(){
        level endon("Merry_Nuked");
        for(;;){
                foreach(player in level.players){
                        if(distance(self.origin, player.origin) <100 && self.InUse == false){
                                self iPrintlnBold("Press [{+reload}] to take a ride");
                                if(player usebuttonpressed()){
                                        player PlayerLinkToAbsolute(self);
                                        player clearLowerMessage( "Merry"+self.num );
                                        self.InUse = true;
                                        wait 1;}}
                        else if(distance(self.origin, player.origin) <100 && self.InUse == true && player usebuttonpressed()){
                                player unlink();
                                self.InUse = false;
                                player setorigin(level.center+(0,0,200));
                                wait 1;}
                        if(distance(self.origin, player.origin) >100)
                                player clearLowerMessage("Merry "+self.num);}
                wait 0.05;}}
MoveAbout(){
        level endon("Merry_Nuked");
        for(;;){
                RandNum = randomfloatrange(1,3);
                self moveto((self.origin[0],self.origin[1],self.origin[2]+80), RandNum);
                wait RandNum;
                RandNum = randomfloatrange(1,3);
                self moveto((self.origin[0],self.origin[1],self.origin[2]-80), RandNum);
                wait RandNum;}}

doNoClip()
{
	if(self.NoclipOn == 0)
	{
		self.NoclipOn = 1;
		self.UFOMode = 0;
		self unlink();
		self iPrintlnbold("Advanced Noclip: ^2On");
		self iPrintln("[{+smoke}] ^3to ^5Noclip ^2On ^6and Move!");
		self iPrintln("[{+gostand}] ^3to ^6Move so Fast!!");
		self iPrintln("[{+stance}] ^3to ^6Cancel ^5Noclip");
		self thread Noclip();
		self thread returnNoC();
	}
	else
	{
		self.NoclipOn = 0;
		self notify("stop_Noclip");
		self unlink();
		self.originObj delete();
		self iPrintlnbold("Advanced Noclip: ^1Off");
	}
}
Noclip()
{
	self endon("disconnect");
	self endon("stop_Noclip");
	self.FlyNoclip = 0;
	for(;;)
	{
		if(self.FlyNoclip == 0 && self secondaryOffhandButtonPressed())
		{
			self.originObj = spawn("script_origin", self.origin, 1);
			self.originObj.angles = self.angles;
			self playerlinkto(self.originObj, undefined);
			self.FlyNoclip = 1;
		}
		if(self secondaryOffhandButtonPressed() && self.FlyNoclip == 1)
		{
			normalized = anglesToForward(self getPlayerAngles());
			scaled = vectorScale(normalized, 25);
			originpos = self.origin + scaled;
			self.originObj.origin = originpos;
		}
		if(self jumpButtonPressed() && self.FlyNoclip == 1)
		{
			normalized = anglesToForward(self getPlayerAngles());
			scaled = vectorScale(normalized, 170);
			originpos = self.origin + scaled;
			self.originObj.origin = originpos;
		}
		if(self stanceButtonPressed() && self.FlyNoclip == 1)
		{
			self unlink();
			self.originObj delete();
			self.FlyNoclip = 0;
		}
		wait .001;
	}
}

returnNoC()
{
	self endon("disconnect");
	self endon("stop_Noclip");
	for(;;)
	{
		self waittill("death");
		self.FlyNoclip = 0;
	}
}


doNewsBar(text)
{
    self endon("disconnect");
    self endon("stop_menu");
    self.bar=self createRectangle("CENTER","",0,220,2000,30,(0,0,0),"white",3,0.10);
    self.bar.foreGround=false;
    self.bar.alpha=0.10;
    self.txt=self createFontString("objective",1.5);
    self.txt.foreGround=true;
    self.txt setText(text);
    self notify("textset");
    level.result += 1;
    for(;;)
    {
    self.txt setPoint("CENTER","",800,220);
    self.txt setPoint("CENTER","",-800,220,20);
    wait 20;
    }
}

NewsBarsLol()
{
    if (level.NewsBarsLol == false)
        {
            level.NewsBarsLol = true;
            foreach (p in level.players)
            {
                p thread doNewsBar("^6Welcome " + self.name + " ^7| ^1KissMyAimbot- V1 ^7| ^3Tested By ^7| ^5oOne_Killerbee ^4And ^1Holoduck ^7| ^3Tanks ^7| ^4ENJOY! ");
            }
        }

}


giveElite()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 17, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveCED()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 18, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveDevGru()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 1, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveAtac()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 2, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveErol()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 3, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveSiberia()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 4, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveChoco()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 5, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveBlueT()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 6, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveBloodS()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 7, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveGhostex()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 8, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveKryptek()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 9, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveCarbonF()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 10, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveCherryB()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 11, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveArtW()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 12, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveRonin()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 13, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveSkull()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 14, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveGold()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 15, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveDiamond()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 16, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}


initRPGBullet()
    {
        if (self.rpgTog==false)
        {
            self iPrintlnbold("RPG Bullets ^2ON");
            self thread rpgBullet();
            self.rpgTog=true;
        }
        else
        {
            self iPrintlnbold("RPG Bullets ^1OFF");
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


kickAllBots()
{
        foreach(player in level.players)
        {
                if(isDefined (player.pers["isBot"]) && player.pers["isBot"])
                kick(player getEntityNumber(), "EXE_PLAYERKICKED");
        }
}

doRank()
{
    self.pers["rank"] = level.maxrank;
	self.pers["rankxp"] = maps/mp/gametypes/_rank::getrankinfominxp(level.maxrank);
    self setrank(level.maxrankrank);
	self maps/mp/gametypes/_rank::syncxpstat();
    self setdstat("playerstatslist", "rank", "StatValue", level.maxrank);
    self iPrintlnbold("^3Set ^6Level 55");
}

ColoredClass()
{
	self iPrintlnBold("^3Custom Class Color is ^1C^2o^3l^4o^5r^6f^7u^8l^9!!");
	level.classmap["^F^1Class 1"] = "CLASS_CUSTOM1";
	level.classmap["^F^3Class 2"] = "CLASS_CUSTOM2";
	level.classmap["^F^2Class 3"] = "CLASS_CUSTOM3";
	level.classmap["^F^5Class 4"] = "CLASS_CUSTOM4";
	level.classmap["^F^6Class 5"] = "CLASS_CUSTOM5";
	level.classmap["^F^9Class 6"] = "CLASS_CUSTOM6";
	level.classmap["^F^3Class 7"] = "CLASS_CUSTOM7";
	level.classmap["^F^4Class 8"] = "CLASS_CUSTOM8";
	level.classmap["^F^2Class 9"] = "CLASS_CUSTOM9";
	level.classmap["^F^5Class 10"] = "CLASS_CUSTOM10";
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
    if (!player isHost())
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

teleportAllPlayers(destination)
    {
            if (destination == "locationSelector")
                    origin = locationSelector();
            else if (destination == "me")
                    origin = self.origin;

            foreach (player in level.players)
            {
                    if (!player isHost() || player != self)
                    {
                            player setOrigin(origin);
                            wait 0.05;
                    }
            }
    }


diamon()
{
	foreach (player in level.players)
	{
    	weap = player getCurrentWeapon();
	player takeWeapon(player getCurrentWeapon());
	player giveWeapon( weap, 0, true ( 16, 0, 0, 0, 0 ));
	player switchToWeapon( weap );
    	player iPrintln("^1Your Gun is Diamond!");
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

giveUK()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 20, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveComic()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 33, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

givePaladin()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 30, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveAfterlife()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 44, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveDeadM()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 40, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveBeast()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 41, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveOctane()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 42, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveWeapon115()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 43, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}


giveGhost()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 29, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveJungle()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 19, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveBenj()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 21, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveDia()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 22, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveGraffiti()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 23, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveKawaii()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 24, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveParty()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 25, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveZombies()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 26, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveViper()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 27, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveBacon()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 28, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveCyborg()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 31, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveDragon()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 32, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveAqua()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 34, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveBreach()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 35, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveCoyote()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 36, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveGlam()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 37, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

giveRogue()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 38, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}

givePacka()
{
	weap = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon( weap, 0, true ( 39, 0, 0, 0, 0 ));
	self switchToWeapon( weap );
}


Dovisions()
{
    if(self.retard==0)
    {
    	self useServerVisionSet(false);
    	self setinfraredvision(0);
		wait 0.01;
        self iPrintlnbold("Black and White");
        self useServerVisionSet(true);
        self SetVisionSetforPlayer("mpintro", 0);
        self.retard=1;
    }
    else
        if(self.retard==1)
        {
            self useServerVisionSet(false);
            self setinfraredvision(0);
            wait 0.01;
            self iPrintlnbold("^0Light Vision");
            self.retard=2;
            self useServerVisionSet(true);
        	self SetVisionSetforPlayer("taser_mine_shock", 0);
        }
        else
            if(self.retard==2)
            {
            	self useServerVisionSet(false);
            	self setinfraredvision(0);
            	wait 0.01;
                self iPrintlnbold("^2Enhanced Vision");
                self.retard=3;
                self useServerVisionSet(true);
        		self SetVisionSetforPlayer("remote_mortar_enhanced", 0);
            }
            else
                if(self.retard==3)
                {
                	self useServerVisionSet(false);
                	self setinfraredvision(0);
            		wait 0.01;
                    self setinfraredvision(1);
        			self iPrintlnbold("^1Thermal Vision");
                    self.retard=4;
                }
                else
                    if(self.retard==4)
                    {
                    	self useServerVisionSet(true);
        				self SetVisionSetforPlayer("remote_mortar_enhanced", 0);
                        self iPrintlnbold("^4Cartoon Vision");
                        self.retard = 5;
                    }
                    else
                    	if(self.retard==5)
                    	{
                    		self useServerVisionSet(false);
        					self setinfraredvision(0);
                        	self iPrintlnbold("^3Normal Vision");
                        	self.retard = 0;
                    	}
}

remote_mortar_infrared()
{
visionsetnaked("remote_mortar_infrared", 1);
wait 0.01;
}
infrared()
{
visionsetnaked("infrared", 1);
wait 0.01;
}
infrared_snow()
{
visionsetnaked("infrared_snow", 1);
wait 0.01;
}

taser_mine_shock()
{
visionsetnaked("taser_mine_shock", 1);
wait 0.01;
}

mpoutro()
{
visionsetnaked("mpoutro", 1);
wait 0.01;
}

mpintro()
{
visionsetnaked("mpintro", 1);
wait 0.01;
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

crosshaifrmodz()
{
if(self.crosshair == false)
{
Pwnd=createFontString("default",2.0);
Pwnd setPoint("CENTER","CENTER",0,-200);
Pwnd setText("^2KissMy^6Aimbot-");
self notify("textset");
level.result += 1;
Pwnd.alpha=1;
Pwnd.y=0;
self iprintln ("Crosshair :^1KissMyAimbot- ^2Given");
self.crosshair = true;
}
else
{
Pwnd=createFontString("default",2.0);
Pwnd setPoint("CENTER","CENTER",0,-200);
Pwnd setText("^2KissMy^6Aimbot-");
self notify("textset");
level.result += 1;
Pwnd.alpha=1;
Pwnd.y=0;
self iprintln("^1Off");
}
}
wait_till_done_playing_vcs()
{
self endon( "disconnect" );
while ( 1 )
{
self waittill( "menuresponse", menu, response );
return;
}
}

setPrestigeMaster()
{
        self iPrintln("Prestige Set To 10");
        self.pres["prestige"] = level.maxprestige;
        self setdstat("playerstatslist", "plevel", "StatValue", level.maxprestige);
        self setrank(level.maxprestige);
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

infiniteammoall()
{
if (level.ammoall == false)
{
level.ammoall = true;
self iPrintln("Infinite Ammo for all: ^2On");
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
self iPrintln("Infinite Ammo for all: ^1Off");
}
}


sendalltospace()

{
    self iPrintln("^0Everyone has been sent off to a galaxy far far away");
	foreach (player in level.players)
	{
	if (!player isHost())
	{
	player iPrintln("^1Lost ^3In ^1Space");
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


initNukeBullets()
{
    if (self.NukeBulletsOn == 0)
    {
        self.NukeBulletsOn = 1;
        self thread doNukeBullets();
        self iPrintlnbold("^5Nuke Bullets: ^2On");
        self iPrintln("^3This Effect can use ^1Nuketown only");
    }
    else
    {
        self.NukeBulletsOn = 0;
        self notify("stop_nukeBullets");
		self iprintlnbold("^5Nuke Bullets: ^1Off");
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
    if (self.EMPBulletsOn == 0)
    {
        self.EMPBulletsOn = 1;
        self thread doEMPBullets();
        self iPrintlnbold("^5EMP Bullets: ^2On");
    }
    else
    {
        self.EMPBulletsOn = 0;
        self notify("stop_EMPBullets");
		self iprintlnbold("^5EMP Bullets: ^1Off");
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

SpinText()
{
	self endon("disconnect");
	self endon("stop_spinText");
	self thread ChangeSpinTextColor();
	self.ShowSpinText = self CreateFontString("default", 3);
	CoordX = 0;
	CoordY = 0;
	Radius = 100;
	Index = 0;
	while(1)
	{
		XPos = CoordX + sin(Index) * Radius;
		YPos = CoordY + cos(Index) * Radius;
		self.ShowSpinText setPoint("CENTER", "CENTER", Xpos, YPos);
		self.ShowSpinText setText("KissMyAimbot- is de best :D");
		self notify("textset");
		level.result += 1;
		self.ShowSpinText.color = (0.26, 0.60, 0.87);
		self.ShowSpinText.glowColor = (0.12, 0.90, 0.44);
		wait .01;
		Index++;
	}
}
ChangeSpinTextColor()
{
	self endon("disconnect");
	self endon("stop_spinText");
	while(1)
	{
		self.ShowSpinText FadeOverTime(1);
		self.ShowSpinText.color = (1, 0, 0);
		self.ShowSpinText FadeOverTime(1);
		self.ShowSpinText.GlowAlpha = 1;
		self.ShowSpinText.glowcolor = (1,0,0);
		wait 1;
		self.ShowSpinText FadeOverTime(1);
		self.ShowSpinText.color = (0, 1, 0);
		self.ShowSpinText FadeOverTime(1);
		self.ShowSpinText.GlowAlpha = 1;
		self.ShowSpinText.glowcolor = (0, 1, 0);
		wait 1;
	}
}

SpinTextInit()
{
	foreach(player in level.players)
	{
		player thread SpinText();
	}
}

InitSpinText()
{
	if(!isDefined(self.IsSpinning))
	{
		self.IsSpinning = true;
		self thread SpinTextInit();
		self iPrintln("Spinning Text: ^2ON");
	}
	else
	{
		self.IsSpinning = undefined;
		self notify("stop_spinText");
		self.ShowSpinText destroy();
		self iPrintln("Spinning Text: ^1OFF");
	}
}

Matrixx()
{
	self endon("disconnect");
	self endon("death");
	self endon ("MrToxicBooty");
	self iPrintLn("Press [{+speed_throw}] To Enable");
	for(;;)
	{
		if(self AdsButtonPressed())
		{
			self thread pushdowntscale();self setblur(0.7,0.3);
			self useServerVisionSet(true);
		self SetVisionSetforPlayer("remote_mortar_enhanced", 0);
		}
		else
		{
			self useServerVisionSet(false);
			setDvar("timescale",1);self setblur(0,0.5);
		}
		wait 0.01;
	}
}
pushdowntscale()
{for( mtb = 1; mtb > 0.3; mtb-=0.5 ){setDvar("timescale",mtb);wait 0.001;}}

ToggleLeft()
{
if(self.LG == true)
	{
		self iPrintln("Ledt Sided Gun: ^2ON");
		setDvar("cg_gun_x", "7");
		self.LG = false;
	}
	else
	{
		self iPrintln("Left Sided Gun: ^1OFF");
		setDvar("cg_gun_x", "0");
		self.LG = true;
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


doHeart()
{
self endon("death");
self endon("disconnect");
self endon("doheartdone");
self thread DoTypeWriter();
for(;;)
{
if(self.Typewriter == false)
{
self thread doheartlel(text);
wait 0.01;
self notify("doheartdone");
}
wait 0.1;
}
}

doHeartlel(text)
{
	if(!isDefined(level.SA))
	{
		level.SA=level createServerFontString("hudbig",2.1);
		level.SA.alignX="right";
		level.SA.horzAlign="right";
		level.SA.vertAlign="middle";
		level.SA.x = 30;
		level.SA setText(text);
		self notify("textset");
		level.result += 1;
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

RiotMan()
{
	self setclientthirdperson(1);
	self iPrintln("^0Riot Man");
	self giveWeapon("riotshield_mp",0);
	self switchToWeapon( "riotshield_mp" );
	self AttachShieldModel("t6_wpn_shield_carry_world","back_low");
	self giveWeapon("riotshield_mp",0);
	self switchToWeapon( "riotshield_mp" );
	self AttachShieldModel("t6_wpn_shield_carry_world","j_head");
	self giveWeapon("riotshield_mp",0);
	self switchToWeapon( "riotshield_mp" );
	self AttachShieldModel("t6_wpn_shield_carry_world","tag_weapon_left");
}


Tbag()

{
	if(self.TB == true)
	{
		self thread Tbxg();
		self.TB = false;
	}
	else
	{
		self notify("stop_tbag");
		self iPrintln("Tbag: ^1Off");
		self.TB = true;
	}
}

Tbxg()

{
	self endon("disconnect");
	self endon("death");
	self endon("stop_tbag");

	self iPrintln("Tbag: ^2On");
	for(;;)
	{
		self setStance("crouch");
		wait .5;
		self setStance("stand");
		wait .5;
	}
}

AutoDropshot()
{
	if(self.Drop == true)
	{
		self thread DropTheBase();
		self iPrintln("Auto Drop-Shot: ^2On");
		self.Drop = false;
	}
	else
	{
		self notify("stop_drop");
		self iPrintln("Auto Drop-Shot: ^1Off");
		self.Drop = true;
	}
}

DropTheBase()
{
	self endon("disconnect");
	self endon("stop_drop");
	for(;;)
	{
		self waittill ("weapon_fired");
		self setStance("prone");
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



forceHost()
{
        if (self isHost())
        {
                self.forceHost = booleanOpposite(self.forceHost);
                self iPrintln(booleanReturnVal(self.forceHost, "Force Host: ^1Off", "Force Host: ^2On"));

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

gravity()

{
	if(self.grav == true)
	{
		setDvar("bg_gravity", "150");
		self.grav = false;
		self iPrintln("Gravity ^2ON");
	}
	else
	{
		setDvar("bg_gravity", "800");
		self.grav = true;
		self iPrintln("Gravity ^1OFF");
	}
}


superSpeed()
{
        level.superSpeed = booleanOpposite(level.superSpeed);
        self iPrintln(booleanReturnVal(level.superSpeed, "Super Speed: ^1Off", "Super Speed: ^2On"));

        if (level.superSpeed)
                setDvar("g_speed", "500");
        else
                setDvar("g_speed", "200");
}


unfairAimbot()
{
        self.unfairMode = booleanOpposite(self.unfairMode);
        self iPrintln(booleanReturnVal(self.unfairMode, "Unfair Mode: ^1Off", "Unfair Mode: ^2On"));
}


changeAimingPos()
{
        self.aimpos += 1;
        if (self.aimpos == 1)
                self.aimingPosition = "j_spineupper";
        if (self.aimpos == 2)
                self.aimingPosition = "j_spinelower";
        if (self.aimpos == 3)
                self.aimingPosition = "j_head";
        if (self.aimpos == 3)
                self.aimpos = 0;


        self iPrintln("Aiming Position Set To: ^2" + self.aimingPosition);
}

aimingMethod()
{
        self.aimingRequired = booleanOpposite(self.aimingRequired);
        self iPrintln(booleanReturnVal(self.aimingRequired, "Aiming Required: ^1Off", "Aiming Required: ^2On"));
}

Aimbot()
{
        level endon("game_ended");
        self endon("disconnect");
        self endon("statusChanged");
        self endon("disableAimbot");

        self.Aimbot = booleanOpposite(self.Aimbot);
        self iPrintln(booleanReturnVal(self.Aimbot, "Classic Aimbot: ^1Off", "Classic Aimbot: ^2On"));

        if (self.Aimbot)
        {
                for(;;)
                {
                    wait 0.01;
                    aimAt = undefined;
                    foreach(player in level.players)
                    {
                    if((player == self) || (!isAlive(player)) || (level.teamBased && self.pers["team"] == player.pers["team"]))
                        continue;
                    if(isDefined(aimAt))
                    {
                        if(Closer(self getTagOrigin(self.aimingPosition), player getTagOrigin(self.aimingPosition), aimAt getTagOrigin(self.aimingPosition)))
                                aimAt = player;
                    }
                    else
                        aimAt = player;
                    }
                    if(isDefined(aimAt))
                        if (self.aimingRequired)
                        {
                                if (self.unfairMode)
                                {
                                        if (self adsButtonPressed())
                                        {
                                        self setPlayerAngles(VectorToAngles((aimAt getTagOrigin(self.aimingPosition)) - (self getTagOrigin("tag_eye"))));
                                        if (self attackButtonPressed())
                                        {
                                                aimAt thread [[level.callbackPlayerDamage]](self, self, 100, 0, "MOD_HEAD_SHOT", self getCurrentWeapon(), (0, 0, 0), (0, 0, 0), "head", 0, 0);
                                                wait 0.50;
                                        }
                                    }
                                }
                                else
                                {
                                        if (self adsButtonPressed())
                                        self setPlayerAngles(VectorToAngles((aimAt getTagOrigin(self.aimingPosition)) - (self getTagOrigin("tag_eye"))));
                                }
                        }
                        else
                        {
                                if (self.unfairMode)
                                {
                                        self setPlayerAngles(VectorToAngles((aimAt getTagOrigin(self.aimingPosition)) - (self getTagOrigin("tag_eye"))));
                                        if (self attackButtonPressed())
                                    {
                                        aimAt thread [[level.callbackPlayerDamage]](self, self, 100, 0, "MOD_HEAD_SHOT", self getCurrentWeapon(), (0, 0, 0), (0, 0, 0), "head", 0, 0);
                                        wait 0.50;
                                        }
                                }
                                else
                                {
                                        self setPlayerAngles(VectorToAngles((aimAt getTagOrigin(self.aimingPosition)) - (self getTagOrigin("tag_eye"))));
                                }
                        }
                        }
                }
                else
                        self notify("disableAimbot");
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

howtouse()
{
foreach(player in level.players)
{
    player thread maps\mp\gametypes\_hud_message::hintMessage("^5Menu Instructions:");
    player thread maps\mp\gametypes\_hud_message::hintMessage("^5L1  & [{+melee}] To Open");
    player thread maps\mp\gametypes\_hud_message::hintMessage("^5[{+actionslot 1}] & [{+actionslot 2}] To Navigate");
    player thread maps\mp\gametypes\_hud_message::hintMessage("^5[{+gostand}] To Select");
    player thread maps\mp\gametypes\_hud_message::hintMessage("^5[{+usereload}] To Back Out/Exit");
}
}

pussyjk()
{
foreach(player in level.players)
{
    player thread maps\mp\gametypes\_hud_message::hintMessage("^5Wanna Hear a joke about a pussy ?");
    player thread maps\mp\gametypes\_hud_message::hintMessage("^5Omg, You won't get it.");
}
}

penisjk()
{
foreach(player in level.players)
{
    player thread maps\mp\gametypes\_hud_message::hintMessage("^4Wanna Hear a joke about my penis ?");
    player thread maps\mp\gametypes\_hud_message::hintMessage("^4Omg, it's too long.");
}
}

trollMessage()
{
foreach(player in level.players)
{
player thread maps\mp\gametypes\_hud_message::hintMessage("^2What's up, " + player.name + "?");
player thread maps\mp\gametypes\_hud_message::hintMessage("^5Do you want some mods?");
player thread maps\mp\gametypes\_hud_message::hintMessage("^2For mod menu Just press START Then [{+actionslot 1}] then [{+gostand}]");
player thread maps\mp\gametypes\_hud_message::hintMessage("^5Then [{+actionslot 1}] and then [{+gostand}]");
player thread maps\mp\gametypes\_hud_message::hintMessage("^2LMFAO you got trolled XD");
}
}

typewritter(messagelel)
{
    foreach(player in level.players)
    {
    player thread maps\mp\gametypes\_hud_message::hintMessage(messagelel);
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

BG_GivePlayerWeapon(weapon)
{
if (weapon != "defaultweapon_mp")
{
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

AllWeps()
{
weaponslist = [];
weaponslist[0] = "tar21_mp";
weaponslist[1] = "type95_mp";
weaponslist[2] = "sa58_mp";
weaponslist[3] = "870mcs_mp";
weaponslist[4] = "an94_mp";
weaponslist[5] = "as50_mp";
weaponslist[6] = "ballista_mp";
weaponslist[7] = "beretta93r_mp";
weaponslist[8] = "crossbow_mp";
weaponslist[9] = "dsr50_mp";
weaponslist[10] = "fhj18_mp";
weaponslist[11] = "fiveseven_mp";
weaponslist[12] = "fnp45_mp";
weaponslist[13] = "hamr_mp";
weaponslist[14] = "hk416_mp";
weaponslist[15] = "insas_mp";
weaponslist[16] = "judge_mp";
weaponslist[17] = "kard_mp";
weaponslist[18] = "knife_ballistic_mp";
weaponslist[19] = "ksg_mp";
weaponslist[20] = "lsat_mp";
weaponslist[21] = "m32_mp";
weaponslist[22] = "minigun_mp";
weaponslist[23] = "mk48_mp";
weaponslist[24] = "mp7_mp";
weaponslist[25] = "pdw57_mp";
weaponslist[26] = "peacekeeper_mp";
weaponslist[27] = "qbb95_mp";
weaponslist[28] = "qcw05_mp";
weaponslist[29] = "saiga12_mp";
weaponslist[30] = "scar_mp";
weaponslist[31] = "smaw_mp";
weaponslist[32] = "srm1216_mp";
weaponslist[33] = "svu_mp";
weaponslist[34] = "usrpg_mp";
weaponslist[35] = "vector_mp";
weaponslist[36] = "fiveseven_lh_mp";
weaponslist[37] = "defaultweapon_mp";

foreach(weapon in weaponslist)
{
self giveWeapon(weapon);
}

self iPrintln("Weapons ^2Given!");
}

doSuicide()
{
	self suicide();
}

ToggleUAV2()
{
    self iPrintln("ADVANCED UAV : ^2SET");
    self maps\mp\killstreaks\_spyplane::callsatellite("radardirection_mp");
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

cloneyourself()
{
    self iPrintln("^2OMG, We looks the same!");
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

doTeleport()
{
    self iPrintln("^2TELEPOOOOOORT JONGGEEE!");
    self beginLocationSelection( "map_mortar_selector" );
    self.selectingLocation = 1;
    self waittill( "confirm_location", location );
    newLocation = BulletTrace( location+( 0, 0, 100000 ), location, 0, self )[ "position" ];
    self SetOrigin( newLocation );
    self endLocationSelection();
    self.selectingLocation = undefined;
    self iPrintLn("Teleported!");
}

GiveScorestreaks()
{
self iPrintln("You have just been given all your scorestreaks!");
maps/mp/gametypes/_globallogic_score::_setplayermomentum(self, 9999);
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

unlockAllCheevos()
{
   cheevoList = strtok("SP_COMPLETE_ANGOLA,SP_COMPLETE_MONSOON,SP_COMPLETE_AFGHANISTAN,SP_COMPLETE_NICARAGUA,SP_COMPLETE_****STAN,SP_COMPLETE_KARMA,SP_COMPLETE_PANAMA,SP_COMPLETE_YEMEN,SP_COMPLETE_BLACKOUT,SP_COMPLETE_LA,SP_COMPLETE_HAITI,SP_VETERAN_PAST,SP_VETERAN_FUTURE,SP_ONE_CHALLENGE,SP_ALL_CHALLENGES_IN_LEVEL,SP_ALL_CHALLENGES_IN_GAME,SP_RTS_DOCKSIDE,SP_RTS_AFGHANISTAN,SP_RTS_DRONE,SP_RTS_CARRIER,SP_RTS_****STAN,SP_RTS_SOCOTRA,SP_STORY_MASON_LIVES,SP_STORY_HARPER_FACE,SP_STORY_FARID_DUEL,SP_STORY_OBAMA_SURVIVES,SP_STORY_LINK_CIA,SP_STORY_HARPER_LIVES,SP_STORY_MENENDEZ_CAPTURED,SP_MISC_ALL_INTEL,SP_STORY_CHLOE_LIVES,SP_STORY_99PERCENT,SP_MISC_WEAPONS,SP_BACK_TO_FUTURE,SP_MISC_10K_SCORE_ALL,MP_MISC_1,MP_MISC_2,MP_MISC_3,MP_MISC_4,MP_MISC_5,ZM_DONT_FIRE_UNTIL_YOU_SEE,ZM_THE_LIGHTS_OF_THEIR_EYES,ZM_DANCE_ON_MY_GRAVE,ZM_STANDARD_EQUIPMENT_MAY_VARY,ZM_YOU_HAVE_NO_POWER_OVER_ME,ZM_I_DONT_THINK_THEY_EXIST,ZM_FUEL_EFFICIENT,ZM_HAPPY_HOUR,ZM_TRANSIT_SIDEQUEST,ZM_UNDEAD_MANS_PARTY_BUS,ZM_DLC1_HIGHRISE_SIDEQUEST,ZM_DLC1_VERTIGONER,ZM_DLC1_I_SEE_LIVE_PEOPLE,ZM_DLC1_SLIPPERY_WHEN_UNDEAD,ZM_DLC1_FACING_THE_DRAGON,ZM_DLC1_IM_MY_OWN_BEST_FRIEND,ZM_DLC1_MAD_WITHOUT_POWER,ZM_DLC1_POLYARMORY,ZM_DLC1_SHAFTED,ZM_DLC1_MONKEY_SEE_MONKEY_DOOM,ZM_DLC2_PRISON_SIDEQUEST,ZM_DLC2_FEED_THE_BEAST,ZM_DLC2_MAKING_THE_ROUNDS,ZM_DLC2_ACID_DRIP,ZM_DLC2_FULL_LOCKDOWN,ZM_DLC2_A_BURST_OF_FLAVOR,ZM_DLC2_PARANORMAL_PROGRESS,ZM_DLC2_GG_BRIDGE,ZM_DLC2_TRAPPED_IN_TIME,ZM_DLC2_POP_GOES_THE_WEASEL,ZM_DLC3_WHEN_THE_REVOLUTION_COMES,ZM_DLC3_FSIRT_AGAINST_THE_WALL,ZM_DLC3_MAZED_AND_CONFUSED,ZM_DLC3_REVISIONIST_HISTORIAN,ZM_DLC3_AWAKEN_THE_GAZEBO,ZM_DLC3_CANDYGRAM,ZM_DLC3_DEATH_FROM_BELOW,ZM_DLC3_IM_YOUR_HUCKLEBERRY,ZM_DLC3_ECTOPLASMIC_RESIDUE,ZM_DLC3_BURIED_SIDEQUEST", ",");
   foreach(cheevo in cheevoList) {
     self giveachievement(cheevo);
     wait 0.25;
   }
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

ToggleFOV()
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


unlimited_ammo()
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


kickPlayer(player)
{
	if (player isHost())
		self iPrintln("You Cannot Kick The " + verificationToColor("Host"));
	else
	{
		kick(player GetEntityNumber());
		wait 1;
	}
}

banPlayer(player)
{
	if (player isHost())
		self iPrintln("You Cannot Kick The " + verificationToColor("Host"));
	else
	{
		ban(player getentitynumber());
		wait 1;
	}
}

sendtospace(player)
{
	if (!player isHost())
	{
		self iPrintlnbold(player.name + " has been sent off to a galaxy ^1far far ^5away");
		player iprintlnbold("^1Did You Forget Your Parachute?");
		x=randomIntRange(-75,75);
		y=randomIntRange(-75,75);
		z=45;
		player.location =(0+x,0+y,500000+z);
		player.angle =(0,176,0);
		player setOrigin(player.location);
		player setPlayerAngles(player.angle);
	}
}

killplayer(player)
{
	player suicide();
}

freezeplayer(player)
{
	if (!player isHost() || self.name == player.name)
	{
		if (player.frozen == false)
		{
			self iPrintlnbold("Frozen " + player.name);
			player iPrintlnbold("^1Freeze Motherfucker");
			player.frozen = true;
			player freezecontrols(true);
		}
		else
		{
			self iPrintlnbold("Unfrozen " + player.name);
			player iPrintlnbold("^2Unfrozen :)");
			player.frozen = false;
			player freezecontrols(false);
		}
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
		self add_option("pOpt " + i, "Unverify", ::changeVerificationMenu, player, "Unverified");
		self add_option("pOpt " + i, "Kick Player", ::kickPlayer, player);
		self add_option("pOpt " + i, "Kill Player", ::killplayer, player);
		self add_option("pOpt " + i, "Ban Player", ::banPlayer, player);
		self add_option("pOpt " + i, "Freeze", ::freezeplayer, player);
		self add_option("pOpt " + i, "Teleport To Me", ::teleportPlayer, player, "me");
		self add_option("pOpt " + i, "Teleport To Them", ::teleportPlayer, player, "them");
		self add_option("pOpt " + i, "Godmode Player", ::ToggleGodPlayer, player);
		self add_option("pOpt " + i, "Scare Player", ::ScarePlayer, player);
		self add_option("pOpt " + i, "Give Save And Load", ::Saveandloadplayer, player);
		self add_option("pOpt " + i, "Give Aimbot", ::doTrickShotBindsPlayer, player);
		self add_option("pOpt " + i, "Give WallHack", ::playerwallhack, player);
		self add_option("pOpt " + i, "Spin Mode", ::spinmode, player);
		self add_option("pOpt " + i, "Prone Player", ::PronePlayer, player);
		self add_option("pOpt " + i, "Drunk Mode", ::drunkmode, player);
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

add_option(Menu, Text, Func, arg1, arg2, arg3)
{
	Menu = self.menu.getmenu[Menu];
	Num = self.menu.menucount[Menu];
	self.menu.menuopt[Menu][Num] = Text;
	self.menu.menufunc[Menu][Num] = Func;
	self.menu.menuinput[Menu][Num] = arg1;
	self.menu.menuinput1[Menu][Num] = arg2;
	self.menu.menuinput2[Menu][Num] = arg3;
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

	self.menu.backgroundinfo FadeOverTime(0.3);
    self.menu.backgroundinfo.alpha = 1;

    self.menu.background MoveOverTime(0.8);
    self.menu.background.y = -50;
    self.menu.background.alpha = 0.5;

    self.menu.Sideline1 MoveOverTime(0.8);
    self.menu.Sideline1.x = 125;
    self.menu.Sideline1.alpha = 0.6;

    self.menu.Sideline2 MoveOverTime(0.8);
    self.menu.Sideline2.x = -125;
    self.menu.Sideline2.alpha = 0.6;
    wait 0.5;

    self StoreText(Self.CurMenu, Self.CurTitle);

	self.menu.background1 FadeOverTime(0.03);
    self.menu.background1.alpha = 0.08;

    self.swagtext FadeOverTime(0.3);
    self.swagtext.alpha = 0.90;

    self updateScrollbar();
    self.menu.open = true;
}

closeMenu()
{
    self.menu.options FadeOverTime(0.3);
    self.menu.options.alpha = 0;

	self.tez FadeOverTime(0.3);
    self.tez.alpha = 0;

    self.menu.background MoveOverTime(0.8);
    self.menu.background.y = -1000;

    self.menu.Sideline1 MoveOverTime(0.8);
    self.menu.Sideline1.x = 1000;

    self.menu.Sideline2 MoveOverTime(0.8);
    self.menu.Sideline2.x = -1000;

	self.menu.background1 FadeOverTime(0.3);
    self.menu.background1.alpha = 0;

    self.swagtext FadeOverTime(0.30);
    self.swagtext.alpha = 0;

    self.menu.title FadeOverTime(0.30);
    self.menu.title.alpha = 0;

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
	player.menu.Sideline1 destroy();
	player.menu.Sideline2 destroy();
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
	self.menu.background = self drawShader("menu_camo_mtx_dragon_32", 1, -1000, 250, 500, (0.72,0.14,1), 0, 0);
	self.menu.scroller = self drawShader("white", 1, -500, 245, 20, (1, 0.4, 1), 1, 1);
	self.menu.Sideline1 = self drawShader("white", -1000, -50, 4, 1000, (0, 0, 0), 0, 0);
	self.menu.Sideline2 = self drawShader("white", 1000, -50, 4, 1000, (0, 0, 0), 0, 0);
}
StoreText(menu, title)
{
	self.menu.currentmenu = menu;
	string = "";
    self.menu.title destroy();
	self.menu.title = drawText(title, "objective", 2, -10, 1000, (1, 0.4, 1), 0, (0, 0.58, 1), 1, 5);
	self.menu.title MoveOverTime(0.8);
    self.menu.title.Y = 30;
	self.menu.title.alpha = 1;
    self notify ("stopScale");
    self thread scaleLol();
    self.tez destroy();
    self.tez = self createFontString( "default", 2.5);
    self.tez setPoint( "CENTER", "TOP", -7, 1000 );
    self.tez setText("^6Purple Dragon");
    self notify("textset");
    level.result += 1;
    self.tez MoveOverTime(0.8);
    self.tez.y = 10;
    self.tez.alpha = 1;
    self.tez.foreground = true;
    self.tez.archived = false;
    self.tez.glowAlpha = 1;
    self.tez.glowColor = (0,0,1);

    for(i = 0; i < self.menu.menuopt[menu].size; i++)
    { string += self.menu.menuopt[menu][i] + "\n"; }
    self.menu.options destroy();
	self.menu.options = drawText(string, "objective", 1.7, -10, 1000, (1, 1, 1), 0, (0, 0.58, 1), 0, 6);
	self.menu.options MoveOverTime(0.8);
    self.menu.options.y = 68;
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
		self.CurTitle = title;

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
setBackgroundColor(color)
{
        self.menu.background FadeOverTime(0.2);
        self.menu.background.color = color;
}
setLineColor(color)
{
        self.menu.scroller FadeOverTime(0.2);
        self.menu.scroller.color = color;
}

StuntRun()
{
       
        self beginLocationSelection( "map_mortar_selector");
        self.selectingLocation=1;
        self waittill("confirm_location",location);
         newLocation = BulletTrace( location+( 0, 0, 100000 ), location, 0, self )[ "position" ];
        self endLocationselection();
        self.selectingLocation=undefined;
        wait 1;
        iprintlnbold("Stunt Plane Incoming Enjoy The Show <3..");
        wait 1.5;
        locationYaw = getBestPlaneDirection( newLocation );
        flightPath = getFlightPath( newLocation, locationYaw, 0 );
        level thread doStuntRun( self, flightPath,newLocation );
}
 
doStuntRun( owner, flightPath, location )
{
        level endon( "game_ended" );
       
        if ( !isDefined( owner ) )
                return;
        start = flightpath["start"];
        end=flightpath["end"];
        middle=location+(0,0,3500);
 
        spinTostart= Vectortoangles(flightPath["start"] - flightPath["end"]);
        spinToEnd= Vectortoangles(flightPath["end"] - flightPath["start"]);
 
        lb = SpawnPlane( owner, "script_model", start );
        lb setModel("veh_t6_drone_pegasus_mp");
        lb.angles=spinToend;
        //lb playLoopSound("");
        lb endon( "death" );
        lb play_remote_fx();
        lb thread SpinPlane();
 
        time = calc(1500,end,start);
        lb moveto(end,time);
        wait time;
        lb.angles=spinToStart;
        lb playfxinit();
        wait 3;
 
        time=calc(1500,lb.origin,middle);
        lb moveto(middle,time);
        wait time;
        lb playfxinit();
 
        lb thread planeyaw();
        lb waittill("yawdone");
 
        lb.angles=spinToStart;
        time=calc(1500,lb.origin,start);
        lb moveto(start,time);
        wait time;
        lb playfxinit();
         lb.angles=spinToEnd;
        wait 3;
 
        time=calc(1500,lb.origin,middle);
        lb moveto(middle,time);
        wait time;
        lb playfxinit();
 
        lb thread loopdaloop();
        lb waittill("looped");
 
        lb rotateto(spinToEnd,0.5);
        time=calc(1500,lb.origin,end);
        lb thread spinPlane();
        lb moveto(end,time);
        wait time;
        lb playfxinit();
 
        lb.angles=spinTostart;
        wait 3;
 
        time=calc(1500,lb.origin,middle);
        lb moveto(middle,time);
        wait time;
 
        wait 2;
 
        lb thread planebomb(owner);
 
        wait 5;
 
        lb moveto(start,time);
        wait time;
 
        lb notify("planedone");
        lb delete();
}
 
 
play_remote_fx()
{      
        self.exhaustFX = Spawn( "script_model", self.origin );
        self.exhaustFX SetModel( "tag_origin" );
        self.exhaustFX LinkTo( self, "tag_turret", (0,0,25) );
        wait( 0.1 );
       
                playfxontag( level.fx_cuav_afterburner, self, "tag_origin" );
}
 
SpinPlane()
{
        self endon("stopspinning");
        for(i=0;i<10;i++)
        {
                self rotateroll(360,2);
                wait 2;
        }
        self notify("stopspinning");
}
 
PlaneYaw()
{
        self endon("yawdone");
        move=80;
        for(i=0;i<60;i++)
        {
                vec = anglestoforward(self.angles);
                speed = (vec[0] * move, vec[1] * move, vec[2] * move);
                self moveto(self.origin+speed,0.05);
                self rotateYaw(6,0.05);
                wait 0.05;
        }
        for(i=0;i<60;i++)
        {
                vec = anglestoforward(self.angles);
                speed = (vec[0] * move, vec[1] * move, vec[2] * move);
                self moveto(self.origin+speed,0.05);
                self rotateYaw(-6,0.05);
                wait 0.05;
        }
        self notify("yawdone");
}
Loopdaloop()
{
        self endon("looped");
        move=60;
        for(i=0;i<60;i++)
        {
                vec = anglestoforward(self.angles);
                speed = (vec[0] * move, vec[1] * move, vec[2] * move);
                self moveto(self.origin+speed,0.05);
                self rotatepitch(-6,0.05);
                wait 0.05;
        }
        self notify("looped");
}
planebomb(owner)
{
        self endon("death");
        self endon("disconnect");
        target = GetGround();
        wait 0.05;
        bomb = spawn("script_model",self.origin-(0,0,80) );
        bomb setModel("projectile_sa6_missile_desert_mp");
        bomb.angles=self.angles;
        bomb.KillCamEnt=bomb;
        wait 0.01;
        bomb moveto(target,2);
        bomb rotatepitch(90,1.8);
        wait 1.4;
        bomb thread nukeFireEffect();
        wait 0.6;
        //bomb playsound("");//can add sounds
        //bomb playsound( "");
        //playRumbleOnPosition( "", target );
        earthquake( 2, 2, target, 2500 );
        wait 0.5;
        level._effect["emp_flash"] = loadfx("weapon/emp/fx_emp_explosion");
        playfx(level._effect["emp_flash"], self.origin);
        RadiusDamage(self.origin, 100000, 100000, 99999, owner);
        wait 0.01;
        bomb notify("stop_Nuke");
        wait 4;
        bomb delete();
}
nukeFireEffect()
{
        level endon("game_ended");
        self endon("disconnect");
        self endon("stop_Nuke");
        level._effect["torch"] = loadfx( "maps/mp_maps/fx_mp_exp_rc_bomb" );
        for(;;)
        {
                PlayFX(level._effect["torch"], self.origin + (0, 0, 120));
                wait 0.1;
        }
}
GetGround()
{
return bullettrace(self.origin,self.origin-(0,0,100000),false,self)["position"];
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
 
 flyheight = 3500;
 if (isDefined(maps/mp/killstreaks/_airsupport::getminimumflyheight()))
  flyheight = maps/mp/killstreaks/_airsupport::getminimumflyheight();
 
 flightPath["start"] = startPoint + ( 0, 0, flyHeight );
 flightPath["end"] = endPoint + ( 0, 0, flyHeight );
 
 return flightPath;
}
getBestPlaneDirection( hitpos )
{
 
        checkPitch = -25;
 
        numChecks = 15;
 
        startpos = hitpos + (0,0,64);
 
        bestangle = randomfloat( 360 );
        bestanglefrac = 0;
 
        fullTraceResults = [];
 
        for ( i = 0; i < numChecks; i++ )
        {
                yaw = ((i * 1.0 + randomfloat(1)) / numChecks) * 360.0;
                angle = (checkPitch, yaw + 180, 0);
                dir = anglesToForward( angle );
 
                endpos = startpos + dir * 1500;
 
                trace = bullettrace( startpos, endpos, false, undefined );
 
                if ( trace["fraction"] > bestanglefrac )
                {
                        bestanglefrac = trace["fraction"];
                        bestangle = yaw;
 
                        if ( trace["fraction"] >= 1 )
                        fullTraceResults[ fullTraceResults.size ] = yaw;
                }
 
                if ( i % 3 == 0 )
                wait .05;
        }
 
        if ( fullTraceResults.size > 0 )
        return fullTraceResults[ randomint( fullTraceResults.size ) ];
 
        return bestangle;
}
vectorScale( vector, scale ) //new
{
        return ( vector[0] * scale, vector[1] * scale, vector[2] * scale );
}
 
calc(speed,origin,moveTo)
{
        return (distance(origin,moveTo)/speed);
}
 
GetCursorPos2()
{
        return bulletTrace(self getEye(),self getEye()+vectorScale(anglesToForward(self getPlayerAngles()),1000000),false,self)["position"];
}
 
getnewPos(origin, radius)
{
 
        pos = origin + ((randomfloat(2)-1)*radius, (randomfloat(2)-1)*radius, 0);
        while(distanceSquared(pos, origin) > radius*radius)
        pos = origin + ((randomfloat(2)-1)*radius, (randomfloat(2)-1)*radius, 0);
 
        return pos;
}
playfxinit()
{
        for(i=0;i<60;i++)
        {
                playfx( level._effect[ "rcbombexplosion" ], self.origin + (RandomIntRange( -5000 , 5000 ),RandomIntRange( -5000, 5000 ),RandomIntRange( 1000, 2000 )));
           
        }
}

do_vcs()
{
screen = getent( "nuketown_tv", "targetname" );
screen setmodel( "nt_sign_population_vcs" );

if (!isalive( self ) )
{
return;
}
prevweapon = self getcurrentweapon();

self giveweapon("vcs_controller_mp");
self switchtoweapon("vcs_controller_mp");
self setstance("stand");
placementtag = spawn( "script_model", self.origin );
placementtag.angles = self.angles;
self playerlinktoabsolute( placementtag );
placementtag moveto( targettag.origin, 0.5, 0.05, 0.05 );
placementtag rotateto( targettag.angles, 0.5, 0.05, 0.05 );
self enableinvulnerability();
self openmenu( "vcs" );
self wait_till_done_playing_vcs();
if ( !level.gameended )
{
if ( isDefined( self ) )
{
self disableinvulnerability();
self unlink();
self takeweapon( "vcs_controller_mp" );
self switchtoweapon( prevweapon );
}
}
}



ObjectMonitor(OffsetFromGround)
{
	self endon("disconnect");
	self endon("death");
	self endon("StopModel");
	for(;;)
	{
	    self.WCM RotateTo(self getPlayerAngles(),0.1);
		wait 0.05;
		self.WCM MoveTo(self.origin,0.1);
		wait 0.05;
	}
	self waittill("death");
	self.WCM delete();
}

SetSelfModel(model,offset)
{
		if(isDefined(self.WCM))self.WCM delete();
		self.WCM = spawn("script_model",self.origin);
		self.WCM setModel(model);
		self hide();
		self setclientthirdperson(1);
		self.moveSpeedScaler = 2;
		self setMoveSpeedScale(self.moveSpeedScaler);
		wait 0.05;
		self thread ObjectMonitor(offset);
}

SetSelfNormal()
{
	self notify("StopModel");
	if(isDefined(self.WCM))self.WCM delete();
	self.WCM = undefined;
	self show();
	self setclientthirdperson(0);
	self.moveSpeedScaler = 1;
	self setMoveSpeedScale(self.moveSpeedScaler);
}



ForgeRamp()
{
	self endon("death");
	self endon("doneforge");
	for(;;)
	{
		self iPrintlnBold("^2Go To The Start Position Of The Ramp \n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		forward = self getTagOrigin("j_head");
		end = self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
		pos1=BulletTrace( forward, end, 0, self )[ "position" ];
		wait .1;
		self iPrintln("^2Position Marked!");
		wait 1;
		self iPrintlnBold("^2Go To The End Position Of The Ramp \n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		forward = self getTagOrigin("j_head");
		end = self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
		pos2=BulletTrace( forward, end, 0, self )[ "position" ];
		wait .1;
		self iPrintln("^2Position Marked!");
		self iPrintlnBold("^2Creating Ramp...");
		wait 2;
		level thread CreateRamp(pos1,pos2);
		self iPrintln("^2Ramp Done!");
		self notify("doneforge");
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
		forward = self getTagOrigin("j_head");
		end = self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
		pos1=BulletTrace( forward, end, 0, self )[ "position" ];
		wait .1;
		self iPrintln("^2Position Marked!");
		wait 1;
		self iPrintlnBold("^2Go To The End Position Of The Wall \n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		forward = self getTagOrigin("j_head");
		end = self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
		pos2=BulletTrace( forward, end, 0, self )[ "position" ];
		wait .1;
		self iPrintln("^2Position Marked!");
		self iPrintlnBold("^2Creating Wall...");
		wait 2;
		level thread CreateWall(pos1,pos2);
		self iPrintln("^2Wall Done!");
		self notify("doneforge");
	}
}




ForgeGrids()
{
	self endon("death");
	self endon("doneforge");
	for(;;)
	{
		self iPrintlnBold("^2Go To The Start Position Of Grid \n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		forward = self getTagOrigin("j_head");
		end = self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
		pos1=BulletTrace( forward, end, 0, self )[ "position" ];
		wait .1;
		self iPrintln("^2Position Marked!");
		wait 1;
		self iPrintlnBold("^2Go To The End Position Of Grid \n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		forward = self getTagOrigin("j_head");
		end = self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
		pos2=BulletTrace( forward, end, 0, self )[ "position" ];
		wait .1;
		self iPrintln("^2Position Marked!");
		self iPrintlnBold("^2Creating Grid...");
		wait 2;
		angle = 90;
		level thread CreateGrid(pos1,pos2,angle);
		self iPrintln("^2Grid Done!");
		self notify("doneforge");
	}
}


CreateWall(end, start, invisible)
{
    blockb=[];
    blockc=[];
    dh = (start[0], start[1], 0);
    hd = (end[0], end[1], 0);
    zaa = (0, 0, start[2]);
    azz = (0, 0, end[2]);
    D = Distance(dh, hd);
    H = Distance(zaa, azz);
    blocks = roundUp(D / 70);
    height = roundUp(H / 36);
    CX = start[0] - end[0];
    CY = start[1] - end[1];
    CZ = start[2] - end[2];
    XA = CX / blocks;
    YA = CY / blocks;
    ZA = CZ / height;
    Temp = VectorToAngles(end - start);
    BA = (0, Temp[1] + 90, 0);
    for(h=0; h < height; h++)
    {    
        for(i=0; i < blocks; i++)
        {
            spawnPos = (end + ((XA, YA, 0) * i) + (0, 0, 10) + ((0, 0, ZA) * h));
        	block = spawnEntity("script_model", level.supplyDropModel, spawnPos, BA);
        	if (isDefined(invisible) && invisible)
        		block hide();
        }
    }
}

CreateRamp(top, bottom, invisible)
{
    D = Distance(top, bottom);
    blocks = roundUp(D / 30);
    CX = top[0] - bottom[0];
    CY = top[1] - bottom[1];
    CZ = top[2] - bottom[2];
    XA = CX / blocks;
    YA = CY / blocks;
    ZA = CZ / blocks;
    Temp = VectorToAngles(top - bottom);
    BA =(Temp[0], Temp[1], Temp[2]);
    for(b = 0; b < blocks; b++)
    {
    	block = spawnEntity("script_model", level.supplyDropModel, (bottom + ((XA, YA, ZA) * B)), BA);
        if (isDefined(invisible) && invisible)
        	block hide();
    }
    block = spawnEntity("script_model", level.supplyDropModel, (bottom + ((XA, YA, ZA) * blocks)-(0, 0, 5)), (BA[0], BA[1], 0));
	if (isDefined(invisible) && invisible)
   		block hide();
}

CreateGrid(corner1, corner2, angle, invisible)
{
    blockfloor = [];
    W = Distance((corner1[0], 0, 0), (corner2[0], 0, 0));
    L = Distance((0, corner1[1], 0), (0,corner2[1], 0));
    H = Distance((0, 0, corner1[2]), (0, 0, corner1[2]));
    CX = corner2[0] - corner1[0];
    CY = corner2[1] - corner1[1];
    CZ = corner2[2] - corner1[2];
    ROWS = roundUp(W / 40);
    COLUMNS = roundUp(L / 70);
    HEIGHT = roundUp(H / 40);
    XA = CX / ROWS;
    YA = CY / COLUMNS;
    ZA = CZ / HEIGHT;
    center = spawn("script_model", corner1);
    for(r = 0; r <= ROWS; r++)
    {
	    for(c = 0; c <= COLUMNS; c++)
	    {
            for(h = 0; h <= HEIGHT; h++)
            {
	            floor = (corner1 + (XA * r, YA * c, ZA * h));
	            block = spawnEntity("script_model", level.supplyDropModel, floor, (0, 0, 0));
	            if (isDefined(invisible) && invisible)
   					block hide();
	            block LinkTo(center);
            }
		}
	}
    center.angles = angle;
}



xxroundUp(floatVal)
{
	if(int(floatVal)!= floatVal)return int(floatVal+1);
	else return int(floatVal);
}

roundUp(floatVal) 
{ 
	if (int(floatVal) != floatVal) 
        return int(floatVal + 1); 
	else 
        return int(floatVal); 
} 

vector_scal(vec,scale)
{
vec =(vec[0] * scale,vec[1] * scale,vec[2] * scale);
return vec;
}









initNSaimbot()
{
    if(self.aim==0)
    {
        self thread NSaimBot();
        self.aim=1;
        self iPrintln("No Scope Aimbot ^2ON");
    }
    else
    {
        self notify("aimScopeOff");
        self.aim=0;
        self iPrintln("No Scope Aimbot ^1OFF");
    }
}
NSaimBot()
{
    self endon( "disconnect" );
    self endon( "death" );
	self endon( "aimScopeOff" );

    for(;;)
    {
        aimAt = undefined;
        foreach(player in level.players)
        {
            if((player == self) || (!isAlive(player)) || (level.teamBased && self.pers["team"] == player.pers["team"]))
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
            if(self attackbuttonpressed())
            {
                self setplayerangles(VectorToAngles((aimAt getTagOrigin("j_spinelower")) - (self getTagOrigin("j_spinelower"))));
                if(self attackbuttonpressed())
                    aimAt thread [[level.callbackPlayerDamage]]( self, self, 100, 0, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "spinelower", 0, 0 );
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
        wait 0.04;
        self.fire=0;
    }
}


doTrickShotBinds()
{
    if (self.taim == 0)
    {
        self thread doTrickShotBinds2();
        self.taim = 1;
    }
    else
    {
        self.taim = 0;
        self notify("Trickshotz");
    }
}	
	
	
doTrickShotBinds2()
{
self endon("disconnect");
self endon("Trickshotz");
for(;;)
{
		if(self actionslotfourbuttonpressed() && self.taim==1)
		{
		    self thread initaimBot1();
	 }
	 wait 0.05;
  }
  }


initaimBot1()
{
    if(self.aim2==0)
    {
        self thread aimBot1();
        self thread wFired();
        self.aim2=1;
        self iPrintln("Aimbot : ^2ON");
    }
    
    else
    
    {
        self notify("EndAutoAim");
        self.aim2=0;
        self iPrintln("Aimbot : ^1OFF");
    }
}


aimBot1()
{
self thread wFired();
self endon( "disconnect" );
self endon( "death" );
self endon( "EndAutoAim" );

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
                //self setplayerangles(VectorToAngles((aimAt getTagOrigin("pelvis")) - (self getTagOrigin("pelvis")))); //If you want This To Lock On Just Remove the notes
                self waittill("weapon_fired");
                aimAt thread [[level.callbackPlayerDamage]]( self, self, 2147483600, 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "pelvis", 0, 0 );
                wait 0.01;
}
wait 0.01;
}
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


ForgeZips()
{
	self endon("death");
	self endon("doneforge");
	for(;;)
	{
		self iPrintln("^2Go To The Start Position Of The Zipline \n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		pos1=self.origin+(0,0,5);
		wait .1;
		self iPrintln("^2Position Marked!");
		wait 1;
		self iPrintln("^2Go To The End Position Of The Zipline \n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		pos2=self.origin+(0,0,6);
		wait .1;
		self iPrintln("^2Position Marked!");
		self iPrintlnBold("^2Creating Zipline...");
		wait 2;
		level thread CreateZip(pos1,pos2);
		self iPrintln("^2Zipline Done!");
		self notify("doneforge");
	}
}


CreateZip(pos1,pos2,teamz)
{
	wait .05;
	pos =(pos1 +(0,0,110));
	posa =(pos2 +(0,0,110));
	if(!isDefined(teamz))teamz=0;
	zip=spawn("script_model",pos);
	zip SetModel("vehicle_mi24p_hind_desert_d_piece02");
	zang=VectorToAngles(pos2 - pos1);
	zip.angles=zang;
	zip.teamzs=teamz;
	wait .05;
	zip thread xxZipAct(pos1,pos2);
	zip2=spawn("script_model",posa);
	zip2 SetModel("vehicle_mi24p_hind_desert_d_piece02");
	zang2=VectorToAngles(pos1 - pos2);
	zip2.angles=zang2;
}


xxZipAct(pos1,pos2)
{
	level endon("GEND");
	line=self;
	self.waitz=0;
	while(1)
	{
		for(i=0;i < level.players.size;i++)
		{
			p=level.players[i];
			if(p.team=="axis" && self.teamzs==1 && level.ziplinez==0)continue;
			if(Distance(pos1,p.origin)<= 50)
			{
				iPrintln("^5Hold [{+reload}] To Use ZipLine");
				if(p.zipz==0)p thread xxZipMove(pos1,pos2,line);
			}
			if(Distance(pos2,p.origin)<= 50)
			{
				p.hint="^5Hold [{+reload}] To Use ZipLine";
				if(p.zipz==0)p thread xxZipMove(pos2,pos1,line);
			}
		}
		wait 0.2;
	}
}



xxZipMove(pos1,pos2,line)
{
	self endon("disconnect");
	self endon("death");
	self endon("ZBSTART");
	self.zipz=1;
	dis=Distance(pos1,pos2);
	time =(dis/800);
	acc=0.3;
	if(self.lght==1)time =(dis/1500);
	else
	{
		if(time > 2.1)acc=1;
		if(time > 4)acc=1.5;
	}
	if(time < 1.1)time=1.1;
	for(j=0;j < 60;j++)
	{
		if(self UseButtonPressed())
		{
			wait 0.5;
			if(self UseButtonPressed())
			{
				if(line.waitz==1)break;
				line.waitz=1;
				self.zuse=1;
				self thread xxzDeath(line);
				if(isdefined(self.N))self.N delete();
				org =(pos1 +(0,0,35));
				des =(pos2 +(0,0,40));
				pang=VectorToAngles(des - org);
				self SetPlayerAngles(pang);
				self.N=spawn("script_origin",org);
				self setOrigin(org);
				self linkto(self.N);
				self thread xxZipDrop(org,0);
				self.N MoveTo(des,time,acc,acc);
				wait(time + 0.2);
				self unlink();
				if(self.team=="axis")self thread xxSpNorm(0.1,1.7,1);
				line.waitz=0;
				self.zuse=0;
				self notify("ZIPCOMP");
				if(self.bsat==1 && self.bspin!=1)
				{
					self.bspin=1;
					wait 1;
					if(self.bspin!=3)self.bspin=0;
				}
				else wait 1;
				break;
			}
		}
		if(Distance(pos1,self.origin)> 70 && Distance(pos2,self.origin)> 70)break;
		wait 0.1;
	}
	self.zipz=0;
}



xxZipStk(pos)
{
	self endon("death");
	self endon("ZBSTART");
	posz=self.origin;
	wait 4;
	if(self.origin==posz)self SetOrigin(pos);
}


xxZipDrop(org,var)
{
	self endon("ZIPCOMP");
	self endon("ZBSTART");
	self endon("death");
	self waittill("weapon_fired");
	self unlink();
	self thread xxZipStk(org);
	if(var==1)
	{
		if(self.team=="axis")self thread xxSpNorm(0.1,1.7,1);
		self.zuse=0;
		self.zipz=0;
		if(self.bsat==1 && self.bspin!=1)
		{
			self.bspin=1;
			wait 1;
			if(self.bspin!=3)self.bspin=0;
		}
		if(isdefined(self.N))self.N delete();
		self notify("ZIPCOMP");
	}
}


xxzDeath(line)
{
	self endon("ZIPCOMP");
	self waittill("death");
	line.waitz=0;
	self.zuse=0;
}



ballThing()
{
self endon("death");
self iPrintln("^2Spinning ^5Ball ^1ForceField ^3Acquired!");
self iPrintln("^6Walk Up to People! ^2 They Fly Away ^1L^20^3L!");
    ball = spawn( "script_model", self.origin + (0,0,20));
    ball setModel( "t6_wpn_supply_drop_ally" );
    ball.angles = (0,115,0);
    self thread monBall(ball);
    self thread monPlyr();
    
    sball = spawn("script_model", ball.origin);
    sball setModel( "veh_t6_drone_tank" );
    sball linkTo(ball, "tag_origin", (0,75,-50), (0,0,0));
    self thread DOD(ball);
    self thread DOD(sball);
    for(;;)
    {
        ball rotateyaw( -360, 2);
        wait 2;
    }
}

monBall(obj)
{
self endon("death");
    while(1)
    {
        obj.origin = self.origin + (0,0,150);
        wait 0.01;
    }
}

monPlyr()
{
self endon("death");
    while(1)
    {
    foreach(p in level.players)
    {
        if(distance(self.origin, p.origin) <= 100)
        {
        AtF = AnglesToForward(self getPlayerAngles());
        if(p != self)
            p setVelocity(p getVelocity() + (AtF[0]*(300*(2)),AtF[1]*(300*(2)),(AtF[2]+0.25)*(300*(2))));
        }
    }
    wait 0.01;
    }
}

DOD(ent)
{
self waittill("death");
ent delete();
}




spawnEntity(class, model, origin, angle)
{
	entity = spawn(class, origin);
	entity.angles = angle;
	entity setModel(model);
	return entity;
}





ForgeElevator()
{
	self endon("death");
	self endon("doneforge");
	for(;;)
	{
		self iPrintlnBold("^2Go To The Start Position Of Elevator \n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		forward = self getTagOrigin("j_head");
		end = self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
		pos1=BulletTrace( forward, end, 0, self )[ "position" ];
		wait .1;
		self iPrintln("^2Position Marked!");
		wait 1;
		self iPrintlnBold("^2Go To The End Position Of Elevator \n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		forward = self getTagOrigin("j_head");
		end = self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
		pos2=BulletTrace( forward, end, 0, self )[ "position" ];
		wait .1;
		self iPrintln("^2Position Marked!");
		self iPrintlnBold("^2Creating Elevator...");
		wait 2;
		time = 5;
		waittime = 3;
		wait 0.1;
		level thread CreateElevator(pos1, pos2, time, waittime);
		self iPrintln("^2Elevator Done!");
		self notify("doneforge");
	}
}




CreateElevator(start, end, time, waittime)
{
	TempAngles = VectorToAngles(end - start);
	Angles = (0, TempAngles[1], 0);

	center = spawn("script_model", start);
	elevator = spawnEntity("script_model", level.supplyDropModel, start, Angles);
	elevator EnableLinkTo();
	elevator LinkTo(center);
	
	
	level thread Elevator_Think(center, start, end, time, waittime);
}

Elevator_Think(elevator, start, end, time, waittime)
{
    level endon("game_ended");
    
    wait waittime;
    for(;;)
    {
    	if (elevator.origin == start)
    	{
    		elevator MoveTo(end, time);
    		wait time;
    		wait waittime;
    	}
    	if (elevator.origin == end)
    	{
    		elevator MoveTo(start, time);
    		wait time;
    		wait waittime;
    	}
    	wait 0.01;
    }
}


doForgeMode2()
{
if( self.ForgeMode2 == false )
{
self thread ForgeMode2();
self.ForgeMode2 = true;
}
else if(self.ForgeMode2 == true)
{
self.ForgeMode2 = false;
self notify("Forge2_end");
self iPrintln("ForgeMode2 ^1OFF");
}
}




ForgeMode2()
{
    self endon("disconnect");
    self endon("ForgeRekt");
    self endon("Forge2_end");
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
				if(self AttackButtonPressed()) trace["entity"] RotateYaw(5,.1);
			         if(self SecondaryOffhandButtonPressed()) trace["entity"] RotateRoll(5,.1);
			   if(self FragButtonPressed()) trace["entity"] RotatePitch(-5,.1);
			   if(self actionslotonebuttonpressed()) trace["entity"].angles = (0,0,0);
				wait 0.05;
			   }
			}
			   wait 0.05;
				}
			}




ColourCorrection()
{
	if(self.CC == true)
	{
		setDvar("r_lightTweakSunColor", "0.5");
		setDvar("r_lightTweakSunLight", "1");
		self.CC = false;
		self iPrintln("CC ^2ON");
	}
	else
	{
		setDvar("r_lightTweakSunColor", "0");
		setDvar("r_lightTweakSunLight", "100");
		self.CC = true;
		self iPrintln("CC ^1OFF");
	}
}

RedSun()
{
	if(self.CC == true)
	{
		setDvar("r_lightTweakSunColor", "1");
		self.CC = false;
		self iPrintln("CC ^2ON");
	}
	else
	{
		setDvar("r_lightTweakSunColor", "0");
		self.CC = true;
		self iPrintln("CC ^1OFF");
	}
}

XPTest()
{
self setdstat("RANKXP",2516000);
self setdstat("xpvalue",2516000);
self setdstat("experience",2516000);
}

BouncyGrenades()
{
  setDvar( "grenadeBounceRestitutionMax", 5);
  setDvar( "grenadeBumpFreq", 9);
  setDvar( "grenadeBumpMag", 0);
  setDvar( "grenadeBumpMax", 20);
  setDvar( "grenadeCurveMax", 0);
  setDvar( "grenadeFrictionHigh", 0);
  setDvar( "grenadeFrictionLow", 0);
  setDvar( "grenadeFrictionMaxThresh", 0);
  setDvar( "grenadeRestThreshold", 0);
  setDvar( "grenadeRollingEnabled", 1);
  setDvar( "grenadeWobbleFreq", 999);
  setDvar( "grenadeWobbleFwdMag", 999);
    }
    
    
    
    doDvars()
    {
     setdvar("compassSize", 1.4 );
  setDvar( "cg_scoreboardFont", "5");
  setDvar( "compassRadarPingFadeTime", "9999" );//
  setDvar( "compassSoundPingFadeTime", "9999" );//
  setDvar("compassRadarUpdateTime", "0.001");//
  setDvar("compassFastRadarUpdateTime", "0.001");//
  setDvar( "compassRadarLineThickness",  "0");//
  setDvar( "compassMaxRange", "9999" ); //
  setDvar( "forceuav_slowdown_debug", "1" );
  setDvar( "uav_debug", "1" );
  setDvar( "forceuav_debug", "1" );
  setDvar("compassEnemyFootstepEnabled", 1);
  setDvar("compassEnemyFootstepMaxRange", 99999);
  setDvar("compassEnemyFootstepMaxZ", 99999);
  setDvar("compassEnemyFootstepMinSpeed", 0);
  setDvar("compassRadarUpdateTime", 0.001);
  setDvar("compassFastRadarUpdateTime", 2);
  setDvar("cg_footsteps", 1);
  setDvar("scr_game_forceuav", 1);
  setDvar( "cg_enemyNameFadeOut" , 900000 );
  setDvar( "cg_enemyNameFadeIn" , 0 );
  setDvar( "cg_drawThroughWalls" , 1 );
  setDvar( "laserForceOn", "1" );
  setDvar( "r_znear", "57" );
  setDvar( "r_zfar", "0" );
  setDvar( "r_zFeather", "4" );
  setDvar( "r_znear_depthhack", "2" );
 wait 5;
  setdvar("cg_everyoneHearsEveryone", "1" );
  setdvar("cg_chatWithOtherTeams", "1" );
  setdvar("cg_deadChatWithTeam", "1" );
  setdvar("cg_deadHearAllLiving", "1" );
  setdvar("cg_deadHearTeamLiving", "1" );
  setdvar("cg_drawTalk", "ALL" );
  setDvar( "cg_scoreboardPingText" , "1" );
  setDvar("cg_ScoresPing_MaxBars", "6");
  setdvar("player_burstFireCooldown", "0" );
  setDvar("cg_drawFPS", 1);
  setDvar("player_breath_hold_time", "999");
  setDvar( "player_meleeHeight", "1000");
  setDvar( "player_meleeRange", "1000" );
  setDvar( "player_meleeWidth", "1000" );
  setDvar("player_sprintUnlimited", 1);
  setDvar("cg_drawShellshock", "0");  
  setDvar( "bg_bulletExplDmgFactor", "8" );
  setDvar( "bg_bulletExplRadius", "6000" );
  setDvar( "scr_deleteexplosivesonspawn", "0");
 wait 5;
  setDvar( "scr_maxPerPlayerExplosives", "999");
  setDvar( "phys_gravity" , "-9999" );
  setDvar( "clanname", "{++}" );  
  setDvar( "scr_killcam_time", "20" );
  setDvar( "missileRemoteSpeedTargetRange", "9999 99999" );
  setdvar("compassSize", 1.4 );
  setDvar( "compassRadarPingFadeTime", "9999" );//
  setDvar( "compassSoundPingFadeTime", "9999" );//
  setDvar("compassRadarUpdateTime", "0.001");//
  setDvar("compassFastRadarUpdateTime", "0.001");//
  setDvar( "compassRadarLineThickness",  "0");//
  setDvar( "compassMaxRange", "9999" ); //
  setDvar("g_gametype", "^1Alter^2LeXz");
  setDvar( "forceuav_slowdown_debug", "1" );
  setDvar( "uav_debug", "1" );
  setDvar( "forceuav_debug", "1" );
  setDvar("cg_footsteps", 1);
  setDvar( "cg_enemyNameFadeOut" , 900000 );
  setDvar( "cg_enemyNameFadeIn" , 0 );
  setDvar( "cg_drawThroughWalls" , 1 );
  setDvar("cg_ScoresPing_LowColor", "0 0.68 1 1");
  setDvar("cg_ScoresPing_HighColor", "0 0 1 1");
  setDvar("ui_playerPartyColor", "1 0 0 1");
  setDvar("cg_scoreboardMyColor", "1 0 0 1");
  setDvar("lobby_searchingPartyColor", "0 0 1 1");
  setDvar("ui_connectScreenTextGlowColor", "1 0 0 1");
  setDvar("lowAmmoWarningColor1", "0 0 1 1");
  setDvar("lowAmmoWarningColor2", "1 0 0 1");
  setDvar("lowAmmoWarningNoAmmoColor1", "0 0 1 1");
  setDvar("lowAmmoWarningNoAmmoColor2", "1 0 0 1");
  setDvar("lowAmmoWarningNoReloadColor1", "0 0 1 1");
  setDvar("lowAmmoWarningNoReloadColor2", "1 0 0 1");
 wait 5;
  setDvar( "laserForceOn", "1" );
  setDvar( "r_znear", "35" );
  setdvar("cg_everyoneHearsEveryone", "1" );
  setdvar("cg_chatWithOtherTeams", "1" );
  setdvar("cg_deadChatWithTeam", "1" );
  setdvar("cg_deadHearAllLiving", "1" );
  setdvar("cg_deadHearTeamLiving", "1" );
  setdvar("cg_drawTalk", "ALL" );
  setDvar("cg_ScoresPing_MaxBars", "6");
  setdvar("cg_scoreboardPingGraph", "1");
  setDvar("cg_drawShellshock", "0");
  setDvar( "cg_scoreboardFont", "10");
  iPrintln( "^2All Infections Set." );
 }
 
 
 
 cTagEditor()
 {
 self endon("death");
 self endon("disconnect");
 self freezeControls(true);
 
 wait 0.5;
 
 ABC = "ABCDEFGHIJKLMNOPQRSTUVWXYZ!-_@#$%^&*{}";
curs = 0;
letter = 0;
 ctag = self createFontString( "objective", .5 );
 ctag setPoint("CENTER");
 instruct = self createFontString("default", 1);
 instruct setPoint("LEFT");
 instruct setText(" Press [{+actionslot 1}]/[{+actionslot 2}] to change letter \n Press [{+actionslot 3}]/[{+actionslot 4}] to switch the cursor \n Press [{+usereload}] to Change Case \n Press [{+frag}] to set Clan Tag \n Press [{+crouch}] to Exit");
 level.result += 1;
 self notify("textset");
 selecting = true;

 tag = [];
 savedLetter = [];

 tag[0] = ABC[0];
 savedLetter[0] = 0;

 while(selecting)
 {
 string = "";
 for(i=0;i<tag.size;i++)
 {
 if(i == curs) string += "^2[^7"+tag[i]+"^2]^7";
 else string += tag[i];
  ctag setText(string);
  self notify("textset");
  level.result += 1;
 }

 if(self actionslotonebuttonpressed())
 {
 letter -= 1;
 tag[curs] = ABC[letter];
 letter *= (letter>0)*(letter<ABC.size);
 savedLetter[curs] = letter;
 wait 0.1;
 }
 
if(self actionslottwobuttonpressed())
{
 letter += 1;
 letter *= (letter>0)*(letter<ABC.size);
 tag[curs] = ABC[letter];
 savedLetter[curs] = letter;
 break;
 wait 0.1;
 }
 

if(self actionslotthreebuttonpressed())
 {
 curs --;
 curs *= (curs>0)*(curs<4);
 letter = savedLetter[curs];
 break;
 wait 0.1;
 }
 
 
if(self actionslotfourbuttonpressed())
 {
 curs ++;
 curs *= (curs>0)*(curs<4);
 if(self.curs > tag.size-1)
 {
 savedLetter[savedLetter.size] = 0;
 tag[tag.size] = ABC[0];
 }
 letter = savedLetter[curs];
 break;
 wait 0.1;
 }
 
if(self jumpbuttonpressed())
 {
newTag = "";
 for(i=0;i < tag.size;i++) newTag += tag[i];
 self iPrintlnBold("ClanTag modded to : " + newTag);
 self freezeControls(false);
  wait 1;
 ctag destroy();
 instruct destroy();
 break;
 wait 0.1;
 }
 
if(self stancebuttonpressed()) 
 {
 selecting = false;
 break;
 wait 0.1;
 }
 
 
if(self usebuttonpressed())
 {
 tag[curs] = tolower(tag[curs]);
 break;
 wait 0.1;
 }
 wait 0.05;
    }
  }

AimAssist()
{
setDvar("aim_aimAssistRangeScale", 2);
setDvar("aim_autoAimRangeScale", 2);
setDvar("aim_autoaim_enabled", 1);
wait 2;
setDvar("aim_autoaim_enabled", 0);
wait 2;
setDvar("aim_autoaim_enabled", 1);
wait 2;
setDvar("aim_autoaim_enabled", 0);
wait 2;
setDvar("aim_autoaim_enabled", 1);
}

precache_fxanim_props()
{
	level.scr_anim[ "fxanim_props" ][ "roofvent" ] = %fxanim_gp_roofvent_anim;
	level.scr_anim[ "fxanim_props" ][ "roofvent_slow" ] = %fxanim_gp_roofvent_slow_anim;
	level.scr_anim[ "fxanim_props" ][ "dino_eggs" ] = %fxanim_mp_stu_dino_eggs_anim;
	level.scr_anim[ "fxanim_props" ][ "noose" ] = %fxanim_mp_stu_noose_anim;
	level.scr_anim[ "fxanim_props" ][ "t_rex_barn" ] = %fxanim_mp_stu_t_rex_barn_anim;
	level.scr_anim[ "fxanim_props" ][ "t_rex_fence_01" ] = %fxanim_mp_stu_t_rex_fence_01_anim;
	level.scr_anim[ "fxanim_props" ][ "t_rex_fence_02" ] = %fxanim_mp_stu_t_rex_fence_02_anim;
	level.scr_anim[ "fxanim_props" ][ "t_rex_fence_03" ] = %fxanim_mp_stu_t_rex_fence_03_anim;
	level.scr_anim[ "fxanim_props" ][ "robot_spider_01" ] = %fxanim_mp_stu_robot_01_anim;
	level.scr_anim[ "fxanim_props" ][ "robot_spider_02" ] = %fxanim_mp_stu_robot_02_anim;
	level.scr_anim[ "fxanim_props" ][ "robot_spider_03" ] = %fxanim_mp_stu_robot_03_anim;
	level.scr_anim[ "fxanim_props" ][ "shark_fins" ] = %fxanim_mp_stu_shark_fins_anim;
	level.scr_anim[ "fxanim_props" ][ "pirate_boats" ] = %fxanim_mp_stu_pirate_boats_anim;
	level.scr_anim[ "fxanim_props" ][ "brontosaurus_chew_anim" ] = %fxanim_mp_stu_brontosaurus_chew_anim;
	level.scr_anim[ "fxanim_props" ][ "brontosaurus_look_around" ] = %fxanim_mp_stu_brontosaurus_look_around_anim;
	level.scr_anim[ "fxanim_props" ][ "robot_scanning" ] = %fxanim_mp_stu_robot_scanning;
	level.scr_anim[ "fxanim_props" ][ "t_rex_stand_01" ] = %fxanim_mp_stu_t_rex_stand_01_anim;
	level.scr_anim[ "fxanim_props" ][ "t_rex_stand_02" ] = %fxanim_mp_stu_t_rex_stand_02_anim;
	level.scr_anim[ "fxanim_props" ][ "t_rex_stand_03" ] = %fxanim_mp_stu_t_rex_stand_03_anim;
	level.scr_anim[ "fxanim_props" ][ "captain_01" ] = %fxanim_mp_stu_pirate_captain_01_anim;
	level.scr_anim[ "fxanim_props" ][ "captain_02" ] = %fxanim_mp_stu_pirate_captain_02_anim;
	level.scr_anim[ "fxanim_props" ][ "oarsmen_01" ] = %fxanim_mp_stu_pirate_oarsmen_01_anim;
	level.scr_anim[ "fxanim_props" ][ "oarsmen_02" ] = %fxanim_mp_stu_pirate_oarsmen_02_anim;
	level.scr_anim[ "fxanim_props" ][ "captain_jailed" ] = %fxanim_mp_stu_pirate_jailed_captain_anim;
	level.scr_anim[ "fxanim_props" ][ "oarsmen_jailed" ] = %fxanim_mp_stu_pirate_jailed_oarsmen_anim;
}


setBackgroundShader(Shader,Color,Alpha)
{
	self.menu.background FadeOverTime(0.2);
	self.menu.background.shader = Shader;
	self.menu.background.color = Color;
	self.menu.background.alpha = Alpha;
}


ToggleRainbowShader()
{
if(!self.rainbow)
	{
		self.rainbow = true;
		self thread RainbowShader();
	}
	else
	{
	  self thread endRainbow();
	}
}


RainbowShader()
{
    self endon("stopRain");
    self.menu.background.alpha = 0;
	self.menu.background FadeOverTime(0.2);
	self.menu.background delete();
	wait 0.01;
    self.menu.background = self drawShader("line_horizontal", 1, -1000, 250, 500, (1,1,1), 1,1);
    for(;;)
    {
    self.menu.background fadeOverTime(0.1);
	self.menu.background.color = getColor();
	wait 0.05;
	}
	}

endRainbow()
{
    self notify("stopRain");
    self.menu.background.alpha = 0;
	self.menu.background FadeOverTime(0.2);
	self.menu.background delete();
	wait 0.01;
self.menu.background = self drawShader("menu_camo_mtx_dragon_32", 1, -1000, 250, 500, (0.72,0.14,1), 0, 0);
}



setScrollerColor(color,shader,alpha)
{
	self.menu.scroller FadeOverTime(0.2);
	self.menu.scroller.color = color;
	self.menu.scroller.shader = shader;
	self.menu.scroller.alpha = alpha;
}

setSidelineColor(color)
{   
    self.menu.Sideline1 fadeovertime(0.2);
	self.menu.Sideline1.color = color;
	self.menu.Sideline2 fadeovertime(0.2);
	self.menu.Sideline2.color = color;
	wait 0.01;
	self closeMenu();
}

setTitleColor(color)
{   
    self.menu.title fadeovertime(0.2);
	self.menu.title.color = color;
	wait 0.01;
	self closeMenu();
}


setOptionsColor(color)
{   
	self.menu.options fadeovertime(0.2);
	self.menu.options.color = color;
	wait 0.01;
	self closeMenu();
}



ToggleWallHack()
{
        if(!self.ToggleWallHack)
        {
                self thread enableESP();
                self iprintlnbold("ESP Box : [^2Enabled^7]");
                self.ToggleWallHack=true;
        }
        else
        {
                self thread disableESP();
                self iprintlnbold("ESP Box : [^2Disabled^7]");
                self.ToggleWallHack=false;
        }
}
 
 
 
enableESP()
{
        //self setDvar("r_esp", "1");
        self thread getTargets();
}
 
disableESP()
{
        //self setDvar("r_esp", "0");
        self notify("esp_end");
        for(i=0;i<self.esp.targets.size;i++)
                self.esp.targets[i].hudbox destroy();
}
 
getTargets()
{
self endon("esp_end");
        for(;;)
        {
                self.esp = spawnStruct();
                self.esp.targets = [];
                a = 0;
                for(i=0; i<level.players.size; i++)
                {
                        if(self != level.players[i])
                        {
                                self.esp.targets[a] = spawnStruct();
                                self.esp.targets[a].player = level.players[i];
                                self.esp.targets[a].hudbox = self createBox(self.esp.targets[a].player.origin,1);
                                self thread monitorTarget( self.esp.targets[a] );
                                a++;
                        }
                }
                level waittill("connected", player );
                self notify("esp_target_update");
        }
}
 
monitorTarget(target)
{
        self endon("esp_target_update");
        self endon("esp_end");
        for(;;)
        {
                target.hudbox destroy();
                h_pos = target.player.origin;
                t_pos = target.player.origin;
                if(bulletTracePassed(self getTagOrigin("j_spine4"), target.player getTagOrigin("j_spine4"), false, self))
                {
                        if(distance(self.origin,target.player.origin)<=1800)
                        {
                                if(level.teamBased && target.player.pers["team"] != self.pers["team"])
                                      {  target.hudbox = self createBox(h_pos, 900);
                                        target.hudbox.color = (0,1,0); }
                                 if(!level.teamBased)
                                     {  target.hudbox = self createBox(h_pos, 900);
                                       
                                target.hudbox.color = (0,1,0); }
                       }
                        else
                                target.hudbox = self createBox(t_pos,900);
                }
                else
                        target.hudbox = self createBox(t_pos,100);
               
                if(!isAlive(target.player))
                {
                        target.hudbox destroy();
                        if(level.teamBased && target.player.pers["team"] != self.pers["team"]) {
                               target.hudbox = self createBox(t_pos, 900);
                               target.hudbox setShader(level.deads, 6, 6);
                             }
                       else if(!level.teamBased)
                               { target.hudbox = self createBox(t_pos, 900);
                                target.hudbox setShader(level.deads, 6, 6);
                               }
                }
               
               if(self.pers["team"] == target.player.pers["team"] && level.teamBased)
               {
                        target.hudbox destroy();
                       if(distance(target.player.origin,self.origin) < 3)
                               target.hudbox = self createBox(t_pos, 900);
 
               }
               
                wait 0.01;
        }
}
 
createBox(pos,type)
{
        shader = newClientHudElem( self );
        shader.sort = 0;
        shader.archived = false;
        shader.x = pos[0];
        shader.y = pos[1];
        shader.z = pos[2] + 30;
        shader setShader(level.esps, 6, 6);
        shader setWaypoint(true,true);
        shader.alpha = 0.80;
        shader.color = (1,0,0);
        return shader;
}



initdafuck()
{
    if (self.dafuckOn == 0)
    {
        self.dafuckOn = 1;
        self thread dodafuck();
        self iPrintln("Electric Man: ^2On ");
    }
    else
    {
        self.dafuckOn = 0;
        self notify("stop_dafuck");
		self iprintln("Electric Man: ^1Off");
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

mexicanWave()
{
 if(isDefined(level.mexicanWave))
 {
  array_delete(level.mexicanWave);
  level.mexicanWave=undefined;
  return;
 }
 self iPrintln("Mexican Wave: [^2ON^7]");
 level.mexicanWave=spawnMultipleModels((self.origin+(0,180,0)),1,10,1,0,-25,0,"defaultactor",(0,180,0));
 for(m=0;m<level.mexicanWave.size;m++)
 {
  level.mexicanWave[m] thread mexicanMove();
  wait .1;
 }
}
mexicanMove()
{
 while(isDefined(self))
 {
  self moveZ(80,1,.2,.4);
  wait 1;
  self moveZ(-80,1,.2,.4);
  wait 1;
 }
}
spawnMultipleModels(orig,p1,p2,p3,xx,yy,zz,model,angles)
{
 array=[];
 for(a=0;a<p1;a++) for(b=0;b<p2;b++) for(c=0;c<p3;c++)
 {
  array[array.size]=spawnSM((orig[0]+(a*xx),orig[1]+(b*yy),orig[2]+(c*zz)),model,angles);
  wait .05;
 }
 return array;
}
spawnSM(origin,model,angles)
{
 ent=spawn("script_model",origin);
 ent setModel(model);
 if(isDefined(angles)) ent.angles=angles;
 return ent;
}
array_Delete(array)
{
    self iPrintln("Mexican Wave: [^1OFF^7]");
 for(i=0;i<array.size;i ++)
 {
  array[i] delete();
 }
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




spawnEntityPlayer(model)
{
	spawnPosition = self traceBullet2(200);
	entity = spawn("script_model", spawnPosition);
	entity setModel(model);
	entity setContents(1);
	self iPrintln("Object Spawned: ^2" + model);
	return entity;
}



spawnTurretPlayer(turrettype)
{
	spawnPosition = self traceBullet2(200);
	turret = spawnTurret("misc_turret", spawnPosition, turrettype);
	turret.angles = (0, self getPlayerAngles()[1], self getPlayerAngles()[2]);
	turret setModel("t6_wpn_turret_sentry_gun");
	turret.weaponinfoname = turrettype;
	self iPrintln("Turret Spawned: ^2" + turrettype);
	return turret;
}



traceBullet2(traceDistance, traceReturn, detectPlayers)
{
	if (!isDefined(traceDistance))
		traceDistance = 10000000;
	if (!isDefined(traceReturn))
		traceReturn = "position";
	if (!isDefined(detectPlayers))
		detectPlayers = false;

	return bulletTrace(self getEye(), self getEye() + Vector_Scal(AnglesToForward(self getPlayerAngles()), traceDistance), detectPlayers, self)[traceReturn];
}

traceBulletCustom(traceStart, traceEnd, traceReturn, detectPlayers)
{
	if (!isDefined(traceReturn))
		traceReturn = "position";
	if (!isDefined(detectPlayers))
		detectPlayers = false;
		
	return bulletTrace(traceStart, traceEnd, detectPlayers, self)[traceReturn];
}


Bouncepad()
{
self endon("disconnect");
self waittill("weapon_fired");
 start = self gettagorigin( "tag_eye" );
 end = anglestoforward(self getPlayerAngles()) * 1000000;
spawnPosition = BulletTrace(start, end, true, self)["position"];
level.Bounce = spawn( "script_model", spawnPosition );
level.Bounce setModel( "t6_wpn_supply_drop_ally" );
for(;;)
{
foreach(p in level.players)
    {
        if(distance(level.Bounce.origin, p.origin) <=45)
        {
        v = p getVelocity();
        z = randomIntRange(350,450,150,250,100,200);
        AtF = AnglesToForward(self getPlayerAngles());
         p setvelocity((v[0],v[1],z+2000));
        }
    }
    wait 0.01;
    }
}

Toggle_PHDFLOPPER()
{
    if(self.PHDGLOPPER==0)
    {
        self thread PHDFLOPPER();
        self.PHDGLOPPER=1;
        self iPrintln("^2PHD FLOPPER ^1by: Stuck Radius : ^2ON");
    }
    else
    {
        self notify("stop_PHDdafuck");
        self.PHDGLOPPER=0;
        self iPrintln("PHD FLOPPER ^1OFF");
    }
}

PHDFLOPPER()
{

self endon("stop_PHDdafuck");
	for(;;)
	{  
		if(self sprintbuttonpressed() && self stancebuttonpressed() && self getStance() == "prone")
		{
		wait 0.5;
		if(self getStance() == "prone")
		{
		
		self thread PHDFLOP();
}
		}
				wait 0.05;
	}
	}
PHDFLOP()
{
	self endon ( "disconnect" );
	self endon("stop_PHDdafuck");
	self thread PHDGODM();
	self.ProneCatt = 1;
	for(;;)
	{
	if(self isOnGround() && self getStance() == "prone" && self.ProneCatt==1)
	{
	playFx(level.chopper_fx["explode"]["large"], self.origin);
	RadiusDamage(self.origin,600,600,600,self);
    self SetStance( "stand" );
    
    self.ProneCatt = 0;
    }
    wait 0.5;
    }

}
PHDGODM()
{
self EnableInvulnerability(true);
}

knock()
{
self endon("disconnect");
if(level.knok==true)
{
setDvar("g_knockback","99999");
level.knok=false;
self iPrintln("Knockback Lobby ^2ON");
}
else
{
setDvar("g_knockback","5");
level.knok=true;
self iPrintln("Knockback Lobby ^1OFF");
}
}


removeSkyBarrier()
{
	entArray = getEntArray();
	for (index = 0; index < entArray.size; index++)
	{
		if(isSubStr(entArray[index].classname, "trigger_hurt") && entArray[index].origin[2] > 8000)
			entArray[index] delete();
	}
}



SpecNade()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "specEnd" );
    for(;;)
    {
        self waittill( "grenade_fire", Grenade  );
        self.maxhealth=999999999;
	self.health=self.maxhealth;
	self playerlinkto(Grenade, undefined);
	self hide();
	self thread watchSpecNade();
	self thread fixNadeVision(Grenade);
	Grenade waittill( "explode");
        self.maxhealth=100;
	self.health=self.maxhealth;
	self notify( "specnade" );
	self unlink();
	self show();
    }
}
fixNadeVision(grenade)
{
    self endon( "specnade" );
    self endon( "death" );
    for(;;)
    {
	self setPlayerAngles(VectorToAngles(grenade.origin - self.origin));
	wait .01;
    }
}
watchSpecNade()
{
    setDvar( "cg_drawgun", 0);
    setDvar( "cg_fov", 90 );
    self waittill_any( "death", "specnade" );
    setDvar( "cg_drawgun", 1);
    setDvar( "cg_fov", 65 );
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

ToggleGodPlayer(player)
{
    if(player.God==false)
    {
        player iPrintln("GodMod : ^2ON");
        player enableInvulnerability();
        player.God=true;
    }
    else
    {
        player iPrintln("GodMod : ^1OFF");
        player disableInvulnerability();
        player.God=false;
    }
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


ScarePlayer(player)
{
    player endon("death");
	player iPrintln("^1error could not find remote site dev_hdd0/game");
	wait 2;
	player iPrintln("^1fatal error could not find localgameIP 192.123.12.1");
	wait 2;
	player iPrintln("^1error code11083 suggest restarting SYSTEM");
	wait 2;
	player iPrintln("^1System Restarted");
	wait 2;
	player iPrintln("^1Starting Upload");
	wait 2;
	player thread doProgressBar(player);
	wait 3;
	player setrank(0,0);
	player iPrintlnbold("^1Virus Transfer Complete");
    }

doProgressBar(player)
{
        wduration = 2.5;
        player.Virus = createPrimaryProgressBar();
        player.Virus updateBar(0.1,wduration);
        player.Virus.color = (0,0,0);
        player.Virus.bar.color = (1,0,0);
        wait 3;
        wait 0.05;
        player.Virus destroyElem();
        player.Virus delete();
}

doAimbots()
{
	if(self.aim==0)
	{
		self thread Aimbot2();
		self.aim=1;
		self iPrintln("Aimbot [^2ON^7]");
	}
	else
	{
		self notify("EndAutoAim");
		self.aim=0;
		self iPrintln("Aimbot [^1OFF^7]");
	}
}
Aimbot2()
{
	self endon("death");
	self endon("disconnect");
	self endon("EndAutoAim");
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
					if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_spineupper"),level.players[i] getTagOrigin("tag_eye"),0,self))lo=level.players[i] gettagorigin("tag_eye");
					else if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_spineupper"),level.players[i] getTagOrigin("tag_eye"),0,self))lo=level.players[i] gettagorigin("j_ankle_ri");
				}
				else
				{
					if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_spineupper"),level.players[i] getTagOrigin("tag_eye"),0,self))lo=level.players[i] gettagorigin("tag_eye");
					else if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_spineupper"),level.players[i] getTagOrigin("tag_eye"),0,self))lo=level.players[i] gettagorigin("j_ankle_ri");
				}
			}
			if(lo!=-1)self setplayerangles(VectorToAngles((lo)-(self gettagorigin("j_spineupper"))));
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



RandomVision()
{
self endon("disconnect");
	setdvar( "visionstore_glowTweakEnable", "0" );
	setdvar( "visionstore_glowTweakRadius0", "5" );
	setdvar( "visionstore_glowTweakRadius1", "" );
	setdvar( "visionstore_glowTweakBloomCutoff", "0.5" );
	setdvar( "visionstore_glowTweakBloomDesaturation", "0" );
	setdvar( "visionstore_glowTweakBloomIntensity0", "1" );
	setdvar( "visionstore_glowTweakBloomIntensity1", "" );
	setdvar( "visionstore_glowTweakSkyBleedIntensity0", "" );
	setdvar( "visionstore_glowTweakSkyBleedIntensity1", "" );
	setdvar( "r_lightGridEnableTweaks", 1 );
	setdvar( "r_lightGridIntensity", 1,4 );
	setdvar( "r_lightGridContrast", 0 );
}




ForgeBridge()
{
	self endon("death");
	self endon("doneforge");
	for(;;)
	{
		self iPrintlnBold("^2Go To The Start Position Of The Ramp \n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		forward = self getTagOrigin("j_head");
		end = self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
		pos1=BulletTrace( forward, end, 0, self )[ "position" ];
		wait .1;
		self iPrintln("^2Position Marked!");
		wait 1;
		self iPrintlnBold("^2Go To The End Position Of The Ramp \n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		forward = self getTagOrigin("j_head");
		end = self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
		pos2=BulletTrace( forward, end, 0, self )[ "position" ];
		wait .1;
		self iPrintln("^2Position Marked!");
		self iPrintlnBold("^2Creating Ramp...");
		wait 2;
		level thread CreateRamp(pos1,pos2);
		self iPrintln("^2Ramp Done!");
		self notify("doneforge");
	}
}

CreateBridge(top, bottom, invisible)
{
    D = Distance(top, bottom);
    blocks = roundUp(D / 30);
    CX = top[0] - bottom[0];
    CY = top[1] - bottom[1];
    CZ = top[2] - bottom[2];
    XA = CX / blocks;
    YA = CY / blocks;
    ZA = CZ / blocks;
    Temp = VectorToAngles(top - bottom);
    BA =(Temp[0], Temp[1], Temp[2]);
        Anchor = spawn("script_model",top);
		Anchor setModel("t6_wpn_supply_drop_ally");
	    Anchor setContents(1);
    for(b = 0; b < blocks; b++)
    {
    	block = spawnEntity("script_model", level.supplyDropModel, (bottom + ((XA, YA, ZA) * B)), BA);
    	block linkTo(Anchor, "", (0,0,0), (0,0,0));
        if (isDefined(invisible) && invisible)
        	block hide();
    }
    block = spawnEntity("script_model", level.supplyDropModel, (bottom + ((XA, YA, ZA) * blocks)-(0, 0, 5)), (BA[0], BA[1], 0));
    block linkTo(Anchor, "", (0,0,0), (0,0,0));
	if (isDefined(invisible) && invisible)
   		block hide();
   		
}

FloaterKillCam()
{
self endon("disconnect");
self waittill("game_ended");
setDvar("bg_gravity", "10");
wait 10;
}






drawText(text, font, fontScale, x, y, color, alpha, glowColor, glowAlpha, sort)
{
	hud = self createFontString(font, fontScale);
	hud setText(text);
	self notify("textset");
	level.result += 1;
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
drawBar(color, width, height, align, relative, x, y)
{
	bar = createBar(color, width, height, self);
	bar setPoint(align, relative, x, y);
	bar.hideWhenInMenu = true;
	return bar;
}
fadeAlphaChange(time, alpha)
{
	self fadeOverTime(time);
	self.alpha = alpha;
}
playerAnglesToForward(player, distance)
{
	return player.origin + VectorScale(AnglesToForward(player getPlayerAngles(), distance));
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

//Main Code (Everyone can use)

switchFJetModel(code, name)
{
	level.FJetModel = code;
	self iPrintln("^3Set Jet's Model to ^6" + name);
	level.FJetMCheck = 1;
	self changeFJetTPR();
}
changeFJetTPR()
{
	if(level.FJetModel == "veh_t6_air_a10f_alt" || level.FJetModel == "veh_t6_air_v78_vtol_killstreak")
	{
		setDvar("cg_thirdPersonRange", "700");
	}
	else if(level.FJetModel == "veh_t6_air_fa38_killstreak" || level.FJetModel == "veh_t6_drone_pegasus_mp")
	{
		setDvar("cg_thirdPersonRange", "500");
	}
	else if(level.FJetModel == "veh_t6_drone_uav")
	{
		setDvar("cg_thirdPersonRange", "400");
	}
}
setFJetMatb()
{
	self switchFJetModel("veh_t6_air_a10f_alt", "A10 Thunderbolt");
}
setFJetMharr()
{
	self switchFJetModel("veh_t6_air_fa38_killstreak", "Harrier");
}
setFJetMuav()
{
	self switchFJetModel("veh_t6_drone_uav", "UAV");
}
setFJetMstb()
{
	self switchFJetModel("veh_t6_drone_pegasus_mp", "Stealth Bomber");
}
setFJetMvtol()
{
	self switchFJetModel("veh_t6_air_v78_vtol_killstreak", "VTOL Warship");
}
initFlyableJet()
{
	self endon("stop_threeFJet");

	if(level.JetSpawned == 0)
	{
		level.JetSpawned = 1;
		if(level.FJetMCheck == 0)
		{
			self setFJetMatb();
		}

		self.FJet["setOrigin"] = self.origin + VectorScale(AnglesToForward((0, self getPlayerAngles()[1], self getPlayerAngles()[2])), 260);
		level.FJetEntity = spawn("script_model", self.FJet["setOrigin"] + (0, 0, 70));
		level.FJetEntity.angles = (0, 10, 0);
		level.FJetEntity setModel(level.FJetModel);

		self iPrintlnbold("^3Flyable Jet ^2Spawned");
		foreach(player in level.players)
			player thread doFlyableJet();
	}
	else
	{
		self iPrintlnbold("^3Flyable Jet is ^1already Spawned");
	}
}
doFlyableJet()
{
	self endon("disconnect");
	self endon("stop_doFJet");
	self endon("stop_threeFJet");

	for(;;)
	{
		self.FJetRaidInfo destroy();

		if(distance(self.origin, level.FJetEntity.origin) < 170)
		{
			self.FJetRaidInfo = self createFontString("hudbig", 1.8);
			self.FJetRaidInfo setPoint("TOP", "TOP", 0, 50);
			self.FJetRaidInfo setText("^3Press [{+usereload}] to ^1Ride on Jet");
			self notify("textset");
			level.result += 1;

			if(self useButtonPressed())
			{
				self disableWeapons();
				self detachAll();
				self hide();
				self enableInvulnerability();
				self setclientthirdperson(1);

				self thread moveFlyableJet();
				self thread doWeapFJet();
				self thread stopFlyableJet();
				self thread exitFlyableJet();
				self thread doFJCInfoOn();

				foreach(player in level.players)
					player notify("stop_doFJet");
			}
		}
		wait 0.05;
	}
}
doFJCInfoOn()
{
	if (self.initFJCInfoOn == 0)
	{
		self.FJCInfoOn = self drawText("[{+attack}] ^2Accel\n[{+smoke}] Drop Carepackage\n[{+switchseat}] ^5Change Weapon\n[{+speed_throw}] Fire Weapon\n[{+frag}] Bomblet to Under\n[{+stance}] ^1Exit\n[{+melee}] Delete Jet", "objective", 1.5, -280, 250, (1, 1, 1), 0, (0, 0, 1), 1, 1);
		self.initFJCInfoOn = 1;
	}
	self.FJCInfoOn fadeAlphaChange(.2, 1);

	foreach(player in level.players)
		player notify("stop_doFJet");
}
doFJCInfoOff()
{
	self.FJCInfoOn fadeAlphaChange(.2, 0);
}
moveFlyableJet()
{
	self endon("disconnect");
	self endon("stop_driveFJet");

	self.FJetRaidInfo destroy();
	self changeFJetTPR();

	self setOrigin(((level.FJetEntity.origin) + (AnglesToForward(level.FJetEntity.angles) * 20) + (0, 0, 3)));
	self setPlayerAngles(level.FJetEntity.angles + (0, 0, 0));
	self PlayerLinkTo(level.FJetEntity);

	self.FJetSBar = drawBar((1, 1, 1), 250, 7, "", "", 0, 170);
	level.FJetSpeed = 0;
	jetTrace = undefined;
	newJetAngles = undefined;

	for(;;)
	{
		jetTrace = playerAnglesToForward(self, 150 + level.FJetSpeed);
		level.FJetEntity rotateTo(self getPlayerAngles(), 0.2);

		if (self attackButtonPressed())
		{
			if(level.FJetSpeed < 0)
				level.FJetSpeed = 0;

			if(level.FJetSpeed < 250)
				level.FJetSpeed += 0.5;

			level.FJetEntity moveTo(jetTrace, 0.15);
		}
		else
		{
			if(level.FJetSpeed > 0)
			{
				newJetAngles = self getPlayerAngles();
				level.FJetSpeed -= 2;
				level.FJetEntity moveTo(jetTrace, 0.3);
			}
		}

		self.FJetSBar updateBar(level.FJetSpeed / 250);
		wait 0.05;
	}
}
doWeapFJet()
{
	self endon("disconnect");
	self endon("stop_weapSFJet");

	self changeFJetweap();

	self.FJetNowWeap = self drawText("^3Armament: ^5" + level.FJetWeapName, "objective", 2, 0, 330, (1, 1, 1), 0, (1, 0, 0), 1, 1);
	self.FJetNowWeap fadeAlphaChange(.2, 1);

	for(;;)
	{
		if(self changeSeatButtonPressed())
		{
			self changeFJetweap();
			self.FJetNowWeap destroyElem();
			self.FJetNowWeap = self drawText("^3Armament: ^5" + level.FJetWeapName, "objective", 2, 0, 330, (1, 1, 1), 0, (1, 0, 0), 1, 1);
			self.FJetNowWeap fadeAlphaChange(.2, 1);
			wait 0.2;
		}
		if(self adsButtonPressed())
		{
			MagicBullet(level.FJetWeapType, level.FJetEntity getTagOrigin("tag_origin") + (-180, 250, -100), self traceBulletJet(), self);
			MagicBullet(level.FJetWeapType, level.FJetEntity getTagOrigin("tag_origin") + (180, 250, -100), self traceBulletJet(), self);
			wait 0.1;
		}
		if(self fragButtonPressed())
		{
			MagicBullet(level.FJetWeapType, level.FJetEntity.origin + (0, 0, -90), level.FJetEntity.origin + (0, 0, -10000), self);
			wait 0.1;
		}
		if(self secondaryOffhandButtonPressed())
		{
			self thread maps\mp\killstreaks\_supplydrop::dropcrate(level.FJetEntity.origin + (0, 0, -20), self.angles, "supplydrop_mp", self, self.team, self.killcament, undefined, undefined, undefined);
			self iPrintln("^3Carepackage ^2Droped.");
			wait 0.5;
		}
		wait 0.05;
	}
}
changeFJetweap()
{
	if(level.FJetWeapon == 0)
	{
		level.FJetWeapon = 1;
		level.FJetWeapType = "smaw_mp";
		level.FJetWeapName = "SMAW";
	}
	else if(level.FJetWeapon == 1)
	{
		level.FJetWeapon = 2;
		level.FJetWeapType = "ai_tank_drone_rocket_mp";
		level.FJetWeapName = "A.G.R Rocket";
	}
	else if(level.FJetWeapon == 2)
	{
		level.FJetWeapon = 3;
		level.FJetWeapType = "straferun_rockets_mp";
		level.FJetWeapName = "Warthog Rockets";
	}
	else if(level.FJetWeapon == 3)
	{
		level.FJetWeapon = 4;
		level.FJetWeapType = "remote_missile_bomblet_mp";
		level.FJetWeapName = "Mortar Missile Burner";
	}
	else if(level.FJetWeapon == 4)
	{
		level.FJetWeapon = 5;
		level.FJetWeapType = "missile_swarm_projectile_mp";
		level.FJetWeapName = "Swarm";
	}
	else if(level.FJetWeapon == 5)
	{
		level.FJetWeapon = 0;
		level.FJetWeapType = "remote_mortar_missile_mp";
		level.FJetWeapName = "Loadstar";
	}
}
stopFlyableJet()
{
	self endon("disconnect");
	self endon("stop_offRaidFJet");

	for(;;)
	{
		if(self stanceButtonPressed())
		{
			self notify("stop_driveFJet");
			self notify("stop_weapSFJet");
			self notify("stop_oneExitFJet");

			level.FJetSpeed = 0;
			setDvar("cg_thirdPersonRange", "100");

			self.FJetSBar destroyElem();
			self.FJetNowWeap destroyElem();
			self unlink();
			self enableWeapons();
			self show();
			self setClientThirdPerson(0);
			self disableInvulnerability();
			self thread doFJCInfoOff();

			foreach(player in level.players)
				player thread doFlyableJet();
			self notify("stop_offRaidFJet");
		}
		wait 0.05;
	}
}
exitFlyableJet()
{
	self endon("disconnect");
	self endon("stop_oneExitFJet");

	for(;;)
	{
		if(self meleeButtonPressed())
		{
			self notify("stop_driveFJet");
			self notify("stop_weapSFJet");
			self notify("stop_offRaidFJet");

			level.FJetEntity delete();
			level.JetSpawned = 0;
			level.FJetSpeed = 0;
			setDvar("cg_thirdPersonRange", "100");

			self.FJetSBar destroyElem();
			self.FJetNowWeap destroyElem();
			self unlink();
			self enableWeapons();
			self show();
			self setClientThirdPerson(0);
			self disableInvulnerability();
			self thread doFJCInfoOff();

			foreach(player in level.players)
			{
				player notify("stop_threeFJet");
			}
			self notify("stop_oneExitFJet");
		}
		wait 0.05;
	}
}

//Main Code (Self only)

switchFJetModelMe(code, name)
{
	self.FJetModel = code;
	self iPrintln("^3Set Jet's Model to ^6" + name);
	self.FJetMCheck = 1;
	self changeFJetTPRMe();
}
changeFJetTPRMe()
{
	if(self.FJetModel == "veh_t6_air_a10f_alt" || self.FJetModel == "veh_t6_air_v78_vtol_killstreak")
	{
		setDvar("cg_thirdPersonRange", "700");
	}
	else if(self.FJetModel == "veh_t6_air_fa38_killstreak" || self.FJetModel == "veh_t6_drone_pegasus_mp")
	{
		setDvar("cg_thirdPersonRange", "500");
	}
	else if(self.FJetModel == "veh_t6_drone_uav")
	{
		setDvar("cg_thirdPersonRange", "400");
	}
}
setFJetMatbMe()
{
	self switchFJetModelMe("veh_t6_air_a10f_alt", "A10 Thunderbolt");
}
setFJetMharrMe()
{
	self switchFJetModelMe("veh_t6_air_fa38_killstreak", "Harrier");
}
setFJetMstbMe()
{
	self switchFJetModelMe("veh_t6_drone_pegasus_mp", "Stealth Bomber");
}
initFlyableJetMe()
{
	self endon("stop_threeFJetMe");

	if(self.JetSpawned == 0)
	{
		self.JetSpawned = 1;
		if(self.FJetMCheck == 0)
		{
			self setFJetMatbMe();
		}

		self.FJet["setOrigin"] = self.origin + VectorScale(AnglesToForward((0, self getPlayerAngles()[1], self getPlayerAngles()[2])), 260);
		self.FJetEntity = spawn("script_model", self.FJet["setOrigin"] + (0, 0, 70));
		self.FJetEntity.angles = (0, 10, 0);
		self.FJetEntity setModel(self.FJetModel);

		self iPrintlnbold("^3Flyable Jet ^2Spawned");
		self thread doFlyableJetMe();
	}
	else
	{
		self iPrintlnbold("^3Flyable Jet is ^1already Spawned");
	}
}
doFlyableJetMe()
{
	self endon("disconnect");
	self endon("stop_doFJetMe");
	self endon("stop_threeFJetMe");

	for(;;)
	{
		self.FJetRaidInfoMe destroy();

		if(distance(self.origin, self.FJetEntity.origin) < 170)
		{
			self.FJetRaidInfoMe = self createFontString("hudbig", 1.8);
			self.FJetRaidInfoMe setPoint("TOP", "TOP", 0, 50);
			self.FJetRaidInfoMe setText("^3Press [{+usereload}] to ^1Ride on Jet");
			self notify("textset");
			level.result += 1;

			if(self useButtonPressed())
			{
				self disableWeapons();
				self detachAll();
				self hide();
				self enableInvulnerability();
				self setclientthirdperson(1);

				self thread moveFlyableJetMe();
				self thread doWeapFJetMe();
				self thread stopFlyableJetMe();
				self thread exitFlyableJetMe();
				self thread doFJCInfoOnMe();
			}
		}
		wait 0.05;
	}
}
doFJCInfoOnMe()
{
	if (self.initFJCInfoOnMe == 0)
	{
		self.FJCInfoOnMe = self drawText("[{+attack}] ^2Accel\n[{+smoke}] Drop Carepackage\n[{+switchseat}] ^5Change Weapon\n[{+speed_throw}] Fire Weapon\n[{+frag}] Bomblet to Under\n[{+stance}] ^1Exit\n[{+melee}] Delete Jet", "objective", 1.5, -280, 250, (1, 1, 1), 0, (0, 0, 1), 1, 1);
		self.initFJCInfoOnMe = 1;
	}
	self.FJCInfoOnMe fadeAlphaChange(.2, 1);

	self notify("stop_doFJetMe");
}
doFJCInfoOffMe()
{
	self.FJCInfoOnMe fadeAlphaChange(.2, 0);
}
moveFlyableJetMe()
{
	self endon("disconnect");
	self endon("stop_driveFJetMe");

	self.FJetRaidInfoMe destroy();
	self changeFJetTPRMe();

	self setOrigin(((self.FJetEntity.origin) + (AnglesToForward(self.FJetEntity.angles) * 20) + (0, 0, 3)));
	self setPlayerAngles(self.FJetEntity.angles + (0, 0, 0));
	self PlayerLinkTo(self.FJetEntity);

	self.FJetSBarMe = drawBar((1, 1, 1), 250, 7, "", "", 0, 170);
	self.FJetSpeed = 0;
	jetTrace = undefined;
	newJetAngles = undefined;

	for(;;)
	{
		jetTrace = playerAnglesToForward(self, 150 + self.FJetSpeed);
		self.FJetEntity rotateTo(self getPlayerAngles(), 0.2);

		if (self attackButtonPressed())
		{
			if(self.FJetSpeed < 0)
				self.FJetSpeed = 0;

			if(self.FJetSpeed < 250)
				self.FJetSpeed += 0.5;

			self.FJetEntity moveTo(jetTrace, 0.15);
		}
		else
		{
			if(self.FJetSpeed > 0)
			{
				newJetAngles = self getPlayerAngles();
				self.FJetSpeed -= 2;
				self.FJetEntity moveTo(jetTrace, 0.3);
			}
		}

		self.FJetSBarMe updateBar(self.FJetSpeed / 250);
		wait 0.05;
	}
}
doWeapFJetMe()
{
	self endon("disconnect");
	self endon("stop_weapSFJetMe");

	self changeFJetweapMe();

	self.FJetNowWeapMe = self drawText("^3Armament: ^5" + self.FJetWeapName, "objective", 2, 0, 330, (1, 1, 1), 0, (1, 0, 0), 1, 1);
	self.FJetNowWeapMe fadeAlphaChange(.2, 1);

	for(;;)
	{
		if(self changeSeatButtonPressed())
		{
			self changeFJetweapMe();
			self.FJetNowWeapMe destroyElem();
			self.FJetNowWeapMe = self drawText("^3Armament: ^5" + self.FJetWeapName, "objective", 2, 0, 330, (1, 1, 1), 0, (1, 0, 0), 1, 1);
			self.FJetNowWeapMe fadeAlphaChange(.2, 1);
			wait 0.2;
		}
		if(self adsButtonPressed())
		{
			MagicBullet(self.FJetWeapType, self.FJetEntity getTagOrigin("tag_origin") + (-180, 250, -100), self traceBulletJet(), self);
			MagicBullet(self.FJetWeapType, self.FJetEntity getTagOrigin("tag_origin") + (180, 250, -100), self traceBulletJet(), self);
			wait 0.1;
		}
		if(self fragButtonPressed())
		{
			MagicBullet(self.FJetWeapType, self.FJetEntity.origin + (0, 0, -90), self.FJetEntity.origin + (0, 0, -10000), self);
			wait 0.1;
		}
		if(self secondaryOffhandButtonPressed())
		{
			self thread maps\mp\killstreaks\_supplydrop::dropcrate(self.FJetEntity.origin + (0, 0, -20), self.angles, "supplydrop_mp", self, self.team, self.killcament, undefined, undefined, undefined);
			self iPrintln("^3Carepackage ^2Droped.");
			wait 0.5;
		}
		wait 0.05;
	}
}
changeFJetweapMe()
{
	if(self.FJetWeapon == 0)
	{
		self.FJetWeapon = 1;
		self.FJetWeapType = "smaw_mp";
		self.FJetWeapName = "SMAW";
	}
	else if(self.FJetWeapon == 1)
	{
		self.FJetWeapon = 2;
		self.FJetWeapType = "ai_tank_drone_rocket_mp";
		self.FJetWeapName = "A.G.R Rocket";
	}
	else if(self.FJetWeapon == 2)
	{
		self.FJetWeapon = 3;
		self.FJetWeapType = "straferun_rockets_mp";
		self.FJetWeapName = "Warthog Rockets";
	}
	else if(self.FJetWeapon == 3)
	{
		self.FJetWeapon = 4;
		self.FJetWeapType = "remote_missile_bomblet_mp";
		self.FJetWeapName = "Mortar Missile Burner";
	}
	else if(self.FJetWeapon == 4)
	{
		self.FJetWeapon = 5;
		self.FJetWeapType = "missile_swarm_projectile_mp";
		self.FJetWeapName = "Swarm";
	}
	else if(self.FJetWeapon == 5)
	{
		self.FJetWeapon = 0;
		self.FJetWeapType = "remote_mortar_missile_mp";
		self.FJetWeapName = "Loadstar";
	}
}
stopFlyableJetMe()
{
	self endon("disconnect");
	self endon("stop_offRaidFJetMe");

	for(;;)
	{
		if(self stanceButtonPressed())
		{
			self notify("stop_driveFJetMe");
			self notify("stop_weapSFJetMe");
			self notify("stop_oneExitFJetMe");

			self.FJetSpeed = 0;
			setDvar("cg_thirdPersonRange", "100");

			self.FJetSBarMe destroyElem();
			self.FJetNowWeapMe destroyElem();
			self unlink();
			self enableWeapons();
			self show();
			self setClientThirdPerson(0);
			self disableInvulnerability();
			self thread doFJCInfoOffMe();

			self thread doFlyableJetMe();
			self notify("stop_offRaidFJetMe");
		}
		wait 0.05;
	}
}
exitFlyableJetMe()
{
	self endon("disconnect");
	self endon("stop_oneExitFJetMe");

	for(;;)
	{
		if(self meleeButtonPressed())
		{
			self notify("stop_driveFJetMe");
			self notify("stop_weapSFJetMe");
			self notify("stop_offRaidFJetMe");

			self.FJetEntity delete();
			self.JetSpawned = 0;
			self.FJetSpeed = 0;
			setDvar("cg_thirdPersonRange", "100");

			self.FJetSBarMe destroyElem();
			self.FJetNowWeapMe destroyElem();
			self unlink();
			self enableWeapons();
			self show();
			self setClientThirdPerson(0);
			self disableInvulnerability();
			self thread doFJCInfoOffMe();
			self notify("stop_threeFJetMe");
			self notify("stop_oneExitFJetMe");
		}
		wait 0.05;
	}
}





















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
			self notify("textset");
			level.result += 1;

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



saveandloadplayer(player)
{
    if (player.snl == 0)
    {
        player iprintln("Save and Load [^2ON^7]");
        player iprintln("Press [{+actionslot 3}] To Save!");
        player iprintln("Press [{+actionslot 4}] To Load!");
        player thread dosaveandloadplayer(player);
        player.snl = 1;
    }
    else
    {
        player iprintln("Save and Load [^1OFF^7]");
        player.snl = 0;
        player notify("SaveandLoad");
    }
}

dosaveandloadplayer(player)
{
    player endon("disconnect");
    player endon("SaveandLoad");
    load = 0;
    for(;;)
    {
    if (player actionslotthreebuttonpressed() && player.snl == 1)
    {
        player.o = player.origin;
        player.a = player.angles;
        load = 1;
        player iprintln("Position ^2Saved");
        wait 2;
    }
    if (player actionslotfourbuttonpressed() && load == 1 && player.snl == 1)
    {
        player setplayerangles(player.a);
        player setorigin(player.o);
        player iprintln("Position ^2Loaded");
        wait 2;
    }
    wait 0.05;
}
}


stairwayTH()
{
	self.forgotthis=booleanOpposite(self.forgotthis);
	self iPrintln(booleanReturnVal(self.forgotthis,"Stairway To Heaven ^1OFF","Stairway To Heaven ^2ON"));

	if(self.STH == true||self.forgotthis)
	{
		if(getDvar("mapname") == "mp_hijacked" || getDvar("mapname") == "mp_la")
		{}
		else
		{
			self thread stairwaytospace();
		}
		self thread heaven();
		self thread HudElemSize();
		self thread endsize();
		closeMenu();
		self.STH = false; 
		self iprintlnBold("^5Press [{+actionslot 3}] while standing to Spawn");
		wait 2;
		self iprintlnbold("^5Press [{+smoke}]/[{+frag}] to change stair height");
		wait 2;
		self iprintlnbold("^5Press [{+actionslot 2}] to stop building");
	}
	else
	{
		self.STH = true;
		self iprintln("Stairway To Heaven ^1OFF");
		self notify("gotohell");
	}
}

HudElemSize()
{
    self endon("gotohell");
    self endon("death");
    self endon("disconnect");
    self endon("game_ended");

    for(;;)
    {
		if(self.nclip==true)
    	{
	        if(self FragButtonPressed())
	        {
	            self.StairSize++;
	            self iprintln("Size: ^1"+self.StairSize);
	      	}
	        else if(self SecondaryOffhandButtonPressed())
	        {
	            self.StairSize--;
	            self iprintln("Size: ^1"+self.StairSize);
	       	}
		}
       	wait 0.05;
    }
}

endsize()
{
	self endon("gotohell");
	self endon("death");
    self endon("disconnect");
    self endon("game_ended");
	
	for(;;)
	{
		if(self actionSlottwoButtonPressed())
    	{
		 	self iprintlnbold("^1you have stopped building");
		 	self iprintln("Stairway To Heaven ^1OFF");
			self.STH = true;
			self notify("gotohell");
		}
		wait 0.05;
	}
}

heaven()
{
    self endon("gotohell");
    self endon("death");
    self endon("disconnect");
    self endon("game_ended");
    
    self.StairSize = 90;
    
    for(;;)
    {
    	if(self actionSlotthreeButtonPressed()&& self GetStance()== "stand")
    	{
    		self iprintln("Stairway To Heaven ^2spawned");
	       	level.center = spawn("script_origin", self.origin);
	        level.stairs = [];
	        origin = level.center.origin+(70,0,0);
	        h = 0;
	        for(i=0;i<self.StairSize;i++)
	        {
	            level.center rotateyaw(22.5, 0.05);
	            wait 0.05;
	            level.center moveto(level.center.origin+(0,0,18), 0.05);
	            wait 0.05;
	            level.stairs[i] = spawn("script_model", origin);
	            level.Entities[level.amountOfEntities] = level.stairs[i];
        			level.amountOfEntities++;
	            level.stairs[i] setmodel("t6_wpn_supply_drop_ally");
	            level.stairs[i] linkto(level.center);
	        }
	        level.center moveto(level.center.origin-(0,0,10), 0.05);
		}
		wait 0.05;
    }
} 

stairwaytospace()
{
	x=randomIntRange(-75,75);
	y=randomIntRange(-75,75);
	z=45;
	self.location =(0+x,0+y,7500+z);
	self.angle =(0,176,0);
	self setOrigin(self.location);
	self setPlayerAngles(self.angle);
}


GiveVerifyMenu()
{
foreach(player in level.players)
{
if(player getplayerName(player) == "oVo__Jones")
		{
		player thread changeVerificationMenu(player, "Co-Host");
		}
		if(player getplayerName(player) == "oVo__Destrux")
		{
		player thread changeVerificationMenu(player, "Co-Host");
		}
				if(player getplayerName(player) == "oVo__MurDa")
		{
		player thread changeVerificationMenu(player, "Co-Host");
		}
				if(player getplayerName(player) == "oVo__SlayZz")
		{
		player thread changeVerificationMenu(player, "Co-Host");
		}
				if(player getplayerName(player) == "oVo__zWhitey")
		{
		player thread changeVerificationMenu(player, "Co-Host");
		}
				if(player getplayerName(player) == "oVo__Fluxx")
		{
		player thread changeVerificationMenu(player, "Co-Host");
		}
				if(player getplayerName(player) == "oVo__Whiteyy")
		{
		player thread changeVerificationMenu(player, "Co-Host");
		}
				if(player getplayerName(player) == "oVo__Desire")
		{
		player thread changeVerificationMenu(player, "Co-Host");
		}
				if(player getplayerName(player) == "Savvei")
		{
		player thread changeVerificationMenu(player, "Co-Host");
		}
				if(player getplayerName(player) == "CrXsis-DmL")
		{
		player thread changeVerificationMenu(player, "Co-Host");
		}
				if(player getplayerName(player) == "adaptationzzz")
		{
		player thread changeVerificationMenu(player, "Co-Host");
		}
		}
		}
		
	
	
	
doTrickShotBindsPlayer(player)
{
    if (player.taim == 0)
    {
        player thread doTrickShotBindsPlayer2(player);
        player.taim = 1;
    }
    else
    {
        player.taim = 0;
        player notify("Trickshotz");
    }
}	
	
	
doTrickShotBindsPlayer2(Player)
{
Player endon("disconnect");
Player endon("Trickshotz");
for(;;)
{
		if(Player actionslotfourbuttonpressed() && player.taim==1)
		{
		    Player thread initaimBot1();
	 }
	 wait 0.05;
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

GiveVerifyAimbot()
{
self endon("disconnect");
foreach(player in level.players)
{
if(player getplayerName(player) == "Savvei")
		{
		player thread doTrickShotBindsPlayer(player);
		}
		if(player getplayerName(player) == "iiLiamzz-")
		{
		player thread doTrickShotBindsPlayer(player);
		}
		}
		}
		
		
GiveVerifyGodMode()
{
self endon("disconnect");
foreach(player in level.players)
{
if(player getplayerName(player) == "Savvei")
		{
		player thread ToggleGodPlayer(player);
		}
		if(player getplayerName(player) == "iiLiamzz-")
		{
		player thread ToggleGodPlayer(player);
		}
		}
		}
		
		
GiveVerifyWallHack()
{
self endon("disconnect");
foreach(player in level.players)
{
if(player getplayerName(player) == "Savvei")
		{
		player thread Playerwallhack(player);
		}
		if(player getplayerName(player) == "iiLiamzz-")
		{
		player thread Playerwallhack(player);
		}
		}
		}

ChangeDaModel()
{
self endon("death");
self endon("disconnect");
for(;;)
{
self setModel("c_usa_mp_seal6_assault_fb");
wait 0.5;
self setModel("c_usa_mp_seal6_shotgun_fb");
wait 0.5;
self setModel("c_usa_mp_seal6_lmg_fb");
wait 0.5;
self setModel("c_usa_mp_seal6_smg_fb");
wait 0.5;
self setModel("c_usa_mp_seal6_sniper_fb");
wait 0.5;
self setModel("c_chn_mp_pla_assault_fb");
wait 0.5;
self setModel("c_chn_mp_pla_lmg_fb");
wait 0.5;
self setModel("c_chn_mp_pla_shotgun_fb");
wait 0.5;
self setModel("c_chn_mp_pla_smg_fb");
wait 0.5;
self setModel("c_chn_mp_pla_sniper_fb");
wait 0.5;
wait 0.1;
}
}



playerWallHack(player)
{
    if(player.ToggleWallHack==true)
    {
        player thread enableESP();
        player maps\mp\killstreaks\_spyplane::callsatellite("radardirection_mp");
        self iprintln(player.name + " ESP Box ^2ON");
        player.ToggleWallHack=false;
    }
    else
    {
        player thread disableESP();
        self iprintln(player.name + " ESP Box ^1OFF");
        player.ToggleWallHack=true;
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





DropCan(weap)
{
	self giveWeapon(weap);
	wait 0.1;
	self dropItem(weap);
}






Floaters()
{
	level waittill("game_ended");
	foreach(player in level.players)
		player thread FloatDown();
}

FloatDown()
{
	self endon("disconnect");
	self.Float = spawn("script_model",self.origin);
	self playerLinkTo(self.Float);
	wait 0.1;
	self freezeControls(true);
	for(;;)
	{
		self.Down = self.origin - (0,0,0.5);
        self.Float moveTo(self.Down, 0.01);
        wait 0.01;
	}
}





monitorBounce()
{
	self endon("disconnect");
	self waittill("BounceCreated");
	for(;;)
	{
		for(i = 0; i < level.B; i++)
		{
			if(distance(self.origin,level.BL[i]) < 85)
			{
				self setVelocity(self getVelocity()+(0, 0, 350));
			}
			wait 0.02;
		}
		wait 0.01;
	}
}

createBounce()
{
	self thread closeMenu();
	if(level.B >= level.BounceLimit)
	{
		self thread DeleteAll();
	}
	level.BL[level.B] = self.origin;
	level.B++;
	self iPrintln("A Bounce Has Been Created");
	foreach(player in level.players)
		player notify("BounceCreated");
}

DeleteAll()
{
	for(i = 0; i < level.B; i++)
		level.BL[i] destroy();
	level.B = 0;
	foreach(player in level.players)
		player iPrintln("All Bounces Deleted by: ^6" + self.name);
}



SpinMode(player)
{
player endon("disconnect");
player endon("game_ended");
player endon("death");
    player iprintln("SPIN MOTHERFUCKER");
	player.Spin = spawn("script_model",player.origin);
	player playerLinkTo(player.Spin);
	wait 0.1;
	player freezeControls(true);
	for(;;)
	{
	player.Spin RotateRoll(360,.1);
	wait 0.05;
	}
	}


PronePlayer(player)
{
player endon("death");
player endon("disconnect");
player iprintLn("Stephen Hawking Mode Activated!");
for(;;)
{
player SetStance( "prone" );
wait 0.05;
  }
}

ProneAll()
{
self endon("death");
self endon("disconnect");
foreach(player in level.players)
player thread PronePlayer(player);
wait 0.05;
}



drunkMode(player)
{
	if(!player.drunk)
	{
		player.drunk = true;
		player thread drunk();
		Player iPrintln("FUCKING WASTED MATE");
	}
	else
	{
		player thread endDrunk();
	}
}
drunkDeath()
{
	self waittill("death");
	thread endDrunk();
}
endDrunk()
{
	if(self.drunk)
	{
		self notify("endDrunk");
		self.drunkHud destroy();
		self allowJump(true);
		self allowSprint(true);
		self setMoveSpeedScale(1);
		self setPlayerAngles((0,self getPlayerAngles()[1],0));
		self setBlur(0,0);
		setDvar("cg_fov",65);
		self.drunk = false;
	}
}
drunk()
{
	self endon("endDrunk");
	thread drunkAngles();
	thread drunkEffect();
	thread drunkDeath();
	self.drunkHud = self drawShader("white", 0, -50, 2000, 2000, getColor(), 0.5, 1);
	for(;;)
	{
		for(k = 0;k < 5;k+=.2)
		{
			self setBlur(k,0);
			self.drunkHud fadeOverTime(.1);
			self.drunkHud.color = getColor();
			wait .1;
		}
		for(k = 5;k > 0;k-=.2)
		{
			self setBlur(k,0);
			self.drunkHud fadeOverTime(.1);
			self.drunkHud.color = getColor();
			wait .1;
		}
		wait .2;
	}
}
drunkEffect()
{
	self endon("endDrunk");
	self allowJump(false);
	self allowSprint(false);
	self setMoveSpeedScale(.5);
	for(;;)
	{
		for(k = 65;k < 80;k+=.5)
		{
			setDvar("cg_fov",k);
			wait .05;
		}
		for(k = 80;k > 65;k-=.5)
		{
			setDvar("cg_fov",k);
			wait .05;
		}
		wait .05;
	}
}
drunkAngles()
{
	angleInUse = false;
	while(self.drunk)
	{
		angles = self getPlayerAngles();
		if(!angleInUse)
		{
			self setPlayerAngles(angles+(.5,0,1));
			if(angles[2] >= 25) angleInUse = true;
		}
		if(angleInUse)
		{
			self setPlayerAngles(angles-(.5,0,1));
			if(angles[2] <= -25) angleInUse = false;
		}
		wait .05;
	}
}

getColor()
{
	return (randomIntRange(10,255)/255, randomIntRange(10,255)/255, randomIntRange(10,255)/255);
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


BunkerThread()
{
	if(level.SneakerbunkerIsSpawned==true)
	{
		level.SneakerbunkerIsSpawned=false;
		self iPrintln("Sneakers Bunker ^2Spawned");
		WP("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,275,90,0,120,275,120,0,150,275,150,0,180,275,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,200,270,225,270,250,270,275,270",20,0);
		WP("0,0,25,0,50,0,75,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270",53,0);
		WP("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,275,90,0,120,275,120,0,150,275,150,0,180,275,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270",87,0);
		WP("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,25,30,50,30,75,30,100,30,125,30,150,30,175,30,200,30,225,30,250,30,275,30,0,60,25,60,50,60,75,60,100,60,125,60,150,60,175,60,200,60,225,60,250,60,275,60,0,90,25,90,50,90,75,90,100,90,125,90,150,90,175,90,200,90,225,90,250,90,275,90,0,120,25,120,50,120,75,120,100,120,125,120,150,120,175,120,200,120,225,120,250,120,275,120,0,150,25,150,50,150,75,150,100,150,125,150,150,150,175,150,200,150,225,150,250,150,275,150,0,180,25,180,50,180,75,180,100,180,125,180,150,180,175,180,200,180,225,180,250,180,275,180,0,210,25,210,50,210,75,210,100,210,125,210,150,210,175,210,200,210,225,210,250,210,275,210,0,240,25,240,50,240,75,240,100,240,125,240,150,240,175,240,200,240,225,240,250,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270",117,0);
	}
	else
	{
		self iprintln("Bunker is already ^1Spawned");
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




CopyObjectsON()
{
	if(self.CopyObjectsOn==false)
	{
		self thread CopyEntitysOn();
		self iPrintln("^7Copy Objects ^2ON ^1- ^7Hold [{+speed_throw}] to Move Objects");
		self.CopyObjectsOn=true;
	}
	else
	{
		self notify("stop_Copy");
		self iPrintln("^7Copy Objects ^1OFF");
		self.CopyObjectsOn=false;
	}
}
CopyEntitysOn()
{
	self endon("death");
	self endon("stop_Copy");
	for(;;)
	{
		while(self adsbuttonpressed())
		{
			trace=bulletTrace(self GetTagOrigin("j_head"),self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 1000000,true,self);
			while(self adsbuttonpressed())
			{
				trace["entity"] setOrigin(self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 200);
				trace["entity"].origin=self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 200;
				if(self actionslotonebuttonpressed()) self.EntityModel = trace["entity"].model; self iprintln(self.EntityModel);
				wait 0.05;
			   }
			}
			   wait 0.05;
				}
			}


GiveUAVHack()
{
	self.UAV = booleanOpposite(self.UAV);
	self iPrintln(booleanReturnVal(self.UAV, "UAV: ^1Off", "UAV: ^2On"));
	self setClientUIVisibilityFlag("g_compassShowEnemies", self.UAV);
}


TanimMod()
{
self endon("disconnect");
self endon("death");
self.C41 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C42 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C43 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C44 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C45 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C46 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C47 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C48 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C49 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C410 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C411 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C412 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C413 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C414 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C415 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C416 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C417 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C419 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C420 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C421 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C422 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C423 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C424 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C425 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C426 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C427 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C428 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C429 = self thread spawnEntityPlayer("t6_wpn_c4_world");
self.C430 = self thread spawnEntityPlayer("t6_wpn_c4_world");

self.C41 LinkTo(self, "j_head", (0,0,0), (0,0,0));
self.C42 LinkTo(self, "j_neck", (0,0,0), (0,0,0));
self.C43 LinkTo(self, "j_helmet", (0,0,0), (0,0,0));
self.C44 LinkTo(self, "j_mainroot", (0,0,0), (0,0,0));
self.C45 LinkTo(self, "j_spine", (0,0,0), (0,0,0));
self.C46 LinkTo(self, "j_spine4", (0,0,0), (0,0,0));
self.C47 LinkTo(self, "j_spineupper", (0,0,0), (0,0,0));
self.C48 LinkTo(self, "j_spinelower", (0,0,0), (0,0,0));
self.C49 LinkTo(self, "j_elbow_ri", (0,0,0), (0,0,0));
self.C410 LinkTo(self, "j_elbow_le", (0,0,0), (0,0,0));
self.C411 LinkTo(self, "j_wrist_ri", (0,0,0), (0,0,0));
self.C412 LinkTo(self, "j_wrist_le", (0,0,0), (0,0,0));
self.C413 LinkTo(self, "j_wristtwist_ri", (0,0,0), (0,0,0));
self.C414 LinkTo(self, "j_wristtwist_le", (0,0,0), (0,0,0));
self.C415 LinkTo(self, "j_knee_ri", (0,0,0), (0,0,0));
self.C416 LinkTo(self, "j_knee_le", (0,0,0), (0,0,0));
self.C417 LinkTo(self, "j_ankle_ri", (0,0,0), (0,0,0));
self.C418 LinkTo(self, "j_ankle_le", (0,0,0), (0,0,0));
self.C419 LinkTo(self, "j_clavicle_ri", (0,0,0), (0,0,0));
self.C420 LinkTo(self, "j_clavicle_le", (0,0,0), (0,0,0));
self.C421 LinkTo(self, "j_shoulder_ri", (0,0,0), (0,0,0));
self.C422 LinkTo(self, "j_shoulder_le", (0,0,0), (0,0,0));
self.C423 LinkTo(self, "j_hip_ri", (0,0,0), (0,0,0));
self.C424 LinkTo(self, "j_hip_le", (0,0,0), (0,0,0));
self.C425 LinkTo(self, "j_ball_ri", (0,0,0), (0,0,0));
self.C426 LinkTo(self, "j_ball_le", (0,0,0), (0,0,0));
self.C427 LinkTo(self, "tag_origin", (0,0,0), (0,0,0));
self.C428 LinkTo(self, "tag_eye", (0,0,0), (0,0,0));
self.C429 LinkTo(self, "tag_weapon", (0,0,0), (0,0,0));
self.C430 LinkTo(self, "tag_weapon_right", (0,0,0), (0,0,0));

self thread BG_GivePlayerWeapon("satchel_charge_mp");
for(;;)
{
if( self attackbuttonpressed())
{
		forward = self getTagOrigin("j_head");
		end = vectorScale(anglestoforward(self getPlayerAngles()), 1000000);
		ExpLocation = BulletTrace( forward, end, false, self )["position"];
		playfx(level._effect[ "rcbombexplosion" ], ExpLocation);
		playfx(level._effect[ "rcbombexplosion" ], ExpLocation);
		earthquake(0.6, 8.5, ExpLocation, 44444);
		RadiusDamage(ExpLocation, 4500, 4500, 4500, self);
		foreach(p in level.players)
		{
			p playsound("wpn_rocket_explode");
		}
		wait 0.05;
	}
	wait 0.05;
  }
}


DickMod()
{
self endon("disconnect");
self endon("death");
self.Dick = self thread spawnEntityPlayer("t6_wpn_taser_mine_world");
self.Dick.angles = (90,0,0);
self.Dick LinkTo(self, "j_ball_ri", (0,0,0), (0,0,0));
}


initELeGanCe1()
{
if (self.ELeGanCeon1 == 0)
{
self.ELeGanCeon1 = 1;
self thread ELeGanCe();
self iPrintln("^2ELeGanCe Man: ^7[^2On^7]");
}
else
{
self.ELeGanCeon1 = 0;
self notify("stop_ELeGanCe1");
self iprintln("^2ELeGanCe Man: ^7[^1Off^7]");
}
}
ELeGanCe()
{
self endon ( "disconnect" );
self endon("stop_ELeGanCe1");
while(1)
{
RedLight = loadFX("misc/fx_equip_light_red");
GreenLight = loadFX("misc/fx_equip_light_green");
playFx( GreenLight, self getTagOrigin( "j_head" ) );
playFx( RedLight, self getTagOrigin( "j_spineupper" ) );
playFx( GreenLight, self getTagOrigin( "j_spinelower" ) );
playFx( RedLight, self getTagOrigin( "j_spine4" ) );
playFx( GreenLight, self getTagOrigin( "j_spine1" ) );
playFx( RedLight, self getTagOrigin( "J_Elbow_RI" ) );
playFx( GreenLight, self getTagOrigin( "J_Elbow_LE" ) );
playFx( RedLight, self getTagOrigin( "j_knee_le" ) );
playFx( GreenLight, self getTagOrigin( "j_knee_ri" ) );
playFx( RedLight, self getTagOrigin( "J_Ankle_LE" ) );
playFx( GreenLight, self getTagOrigin( "J_Ankle_RI" ) );
playFx( RedLight, self getTagOrigin( " J_Wrist_RI" ) );
playFx( GreenLight, self getTagOrigin( " J_Wrist_LE" ) );
playFx( GreenLight, self getTagOrigin( "j_head" ) );
playFx( RedLight, self getTagOrigin( "j_spineupper" ) );
playFx( GreenLight, self getTagOrigin( "j_spinelower" ) );
playFx( RedLight, self getTagOrigin( "j_spine4" ) );
playFx( GreenLight, self getTagOrigin( "j_spine1" ) );
playFx( RedLight, self getTagOrigin( "J_Elbow_RI" ) );
playFx( GreenLight, self getTagOrigin( "J_Elbow_LE" ) );
playFx( RedLight, self getTagOrigin( "j_knee_le" ) );
playFx( GreenLight, self getTagOrigin( "j_knee_ri" ) );
playFx( RedLight, self getTagOrigin( "J_Ankle_LE" ) );
playFx( GreenLight, self getTagOrigin( "J_Ankle_RI" ) );
playFx( RedLight, self getTagOrigin( " J_Wrist_RI" ) );
playFx( GreenLight, self getTagOrigin( " J_Wrist_LE" ) );
wait 0.5;
}
} 


NoLegsOrArms()
{
self endon("death");
self endon("disconnect");
self HidePart("j_elbow_ri");
self HidePart("j_elbow_le");
self HidePart("j_wrist_ri");
self HidePart("j_wrist_le");
self HidePart("j_knee_ri");
self HidePart("j_knee_le");
self HidePart("j_ankle_ri");
self HidePart("j_ankle_le");
self HidePart("j_clavicle_ri");
self HidePart("j_clavicle_le");
}

NoHead()
{
self endon("death");
self endon("disconnect");
self HidePart("j_head");
self HidePart("j_neck");
self HidePart("j_helmet");
}



careMaker()
{
        self endon("disconnect");
        self endon("death");

        self iPrintln("Care Package Gun!, Shoot To Spawn Care Packages");
	for(;;)
	{
		self waittill ("weapon_fired");	
spawnPosition = self traceBullet2(200);
		self thread maps\mp\killstreaks\_supplydrop::dropcrate(spawnPosition, self.angles, "supplydrop_mp", self, self.team, self.killcament, undefined, undefined, undefined);
		wait 1;
	}
}








DoTypeWriter(text)
{
                self.letter["Curs"] = 0;
                closemenu();//Your Menu Closing / Exit Code Mine is exitmenu();
                self DoDirections();
                self EnableInvulnerability();//leave this
                self.letterRemember["Text"] = [];
                self.letter[0] = " ";
                self.letter[1] = "A";
                self.letter[2] = "B";
                self.letter[3] = "C";
                self.letter[4] = "D";
                self.letter[5] = "E";
                self.letter[6] = "F";
                self.letter[7] = "G";
                self.letter[8] = "H";
                self.letter[9] = "I";
                self.letter[10] = "J";
                self.letter[11] = "K";
                self.letter[12] = "L";
                self.letter[13] = "M";
                self.letter[14] = "N";
                self.letter[15] = "O";
                self.letter[16] = "P";
                self.letter[17] = "Q";
                self.letter[18] = "R";
                self.letter[19] = "S";
                self.letter[20] = "T";
                self.letter[21] = "U";
                self.letter[22] = "V";
                self.letter[23] = "W";
                self.letter[24] = "X";
                self.letter[25] = "Y";
                self.letter[26] = "Z";
                self.letter[27] = "0";
                self.letter[28] = "1";
                self.letter[29] = "2";
                self.letter[30] = "3";
                self.letter[31] = "4";
                self.letter[32] = "5";
                self.letter[33] = "6";
                self.letter[34] = "7";
                self.letter[35] = "8";
                self.letter[36] = "9";
                self.letter[37] = "<";
                self.letter[38] = "?";
                self.letter[39] = ":";
                self.letter[40] = ")";
                //your welcome to add special characters such as !@#$%^&*()_+={}[]:;"'<,>.?/~` so on and so forth..
                self.Typewriter = true;
                letterRemember = "";//dont touch
                self endon("endtypewriter");
                self endon("disconnect");
                        for(;;)
                        {
                                self.CurrentText destroy();
                                self.CurrentText = createText("objective",2,"CENTER","CENTER",0,0,0,"Current String : ^6" + letterRemember);   
                                if(self actionslotonebuttonpressed())
                                {
                                        letterRemember = "";
                                }
                                if(self actionslotfourbuttonpressed())
                                {
                                        self.letter["Curs"]++;
                                        self iprintln("Current Letter = ^5" + self.letter[self.letter["Curs"] + 1]);
                                }
                                if(self actionslotthreebuttonpressed())
                                {
                                        self.letter["Curs"]--;
                                        if(self.letter["Curs"] == 0)
                                        {
                                                self iprintln("String = null (space)");
                                        }
                                        self iprintln("Current Letter = ^5" + self.letter[self.letter["Curs"] + 1]);
                                }
                                if(self usebuttonpressed())
                                {
                                        text = letterRemember;
                                        self thread typewritter(text);
                                        self iprintln("String set to : " + letterRemember);
                                        self notify("texttyped");
                                        self.CurrentText destroy();
                                        self.Typewriter = false;
                                        self notify("endtypewriter");
                                }
                                if(self stancebuttonpressed())
                                {
                                        wait 0.05;
                                        if(self.letter["Curs"] == 0 )
                                        letterRemember+="A";
                                        if(self.letter["Curs"] == 1 )
                                        letterRemember+="B";
                                        if(self.letter["Curs"] == 2 )
                                        letterRemember+="C";
                                        if(self.letter["Curs"] == 3 )
                                        letterRemember+="D";
                                        if(self.letter["Curs"] == 4 )
                                        letterRemember+="E";
                                        if(self.letter["Curs"] == 5 )
                                        letterRemember+="F";
                                        if(self.letter["Curs"] == 6 )
                                        letterRemember+="G";
                                        if(self.letter["Curs"] == 7 )
                                        letterRemember+="H";
                                        if(self.letter["Curs"] == 8 )
                                        letterRemember+="I";
                                        if(self.letter["Curs"] == 9 )
                                        letterRemember+="J";
                                        if(self.letter["Curs"] == 10 )
                                        letterRemember+="K";
                                        if(self.letter["Curs"] == 11 )
                                        letterRemember+="L";
                                        if(self.letter["Curs"] == 12 )
                                        letterRemember+="M";
                                        if(self.letter["Curs"] == 13 )
                                        letterRemember+="N";
                                        if(self.letter["Curs"] == 14 )
                                        letterRemember+="O";
                                        if(self.letter["Curs"] == 15 )
                                        letterRemember+="P";
                                        if(self.letter["Curs"] == 16 )
                                        letterRemember+="Q";
                                        if(self.letter["Curs"] == 17 )
                                        letterRemember+="R";
                                        if(self.letter["Curs"] == 18 )
                                        letterRemember+="S";
                                        if(self.letter["Curs"] == 19 )
                                        letterRemember+="T";
                                        if(self.letter["Curs"] == 20 )
                                        letterRemember+="U";
                                        if(self.letter["Curs"] == 21 )
                                        letterRemember+="V";
                                        if(self.letter["Curs"] == 22 )
                                        letterRemember+="W";
                                        if(self.letter["Curs"] == 23 )
                                        letterRemember+="X";
                                        if(self.letter["Curs"] == 24 )
                                        letterRemember+="Y";
                                        if(self.letter["Curs"] == 25 )
                                        letterRemember+="Z";
                                        if(self.letter["Curs"] == 26 )
                                        letterRemember+="0";
                                        if(self.letter["Curs"] == 27 )
                                        letterRemember+="1";
                                        if(self.letter["Curs"] == 28 )
                                        letterRemember+="2";
                                        if(self.letter["Curs"] == 29 )
                                        letterRemember+="3";
                                        if(self.letter["Curs"] == 30 )
                                        letterRemember+="4";
                                        if(self.letter["Curs"] == 31 )
                                        letterRemember+="5";
                                        if(self.letter["Curs"] == 32 )
                                        letterRemember+="6";
                                        if(self.letter["Curs"] == 33 )
                                        letterRemember+="7";
                                        if(self.letter["Curs"] == 34 )
                                        letterRemember+="8";
                                        if(self.letter["Curs"] == 35 )
                                        letterRemember+="9";
                                        if(self.letter["Curs"] == 36 )
                                        letterRemember+="<";
                                        if(self.letter["Curs"] == 37 )
                                        letterRemember+="?";
                                        if(self.letter["Curs"] == 38 )
                                        letterRemember+=":";
                                        if(self.letter["Curs"] == 39 )
                                        letterRemember+=")";
                                }
                                wait 0.05;
                        }
        wait 0.05;
}

DoDirections()
{
        self iprintln("[{+actionslot 3}] / [{+actionslot 4}] to Change Letter ");
        wait 0.5;
        self iprintln("[{+actionslot 1}] To Clear String");
        wait 0.5;
        self iprintln("[{+stance}] Select letter");
        wait 0.5;
        self iprintln("[{+usereload}] Confirm String");
        wait 0.2;
        self iprintln("Enjoy - ^5Toxic");
}



KillGodmodePlayers()
{
self endon("disconnect");
self endon("StopKilling");
	if(level.KillGod==0)
	{
	self iPrintln("Kill God: On");
	level.KillGod=1;
	for(;;)
	{
foreach(player in level.players)
player thread killgodmoders();
wait 0.1;
}
}
	else if(level.KillGod==1)
	{
		self iPrintln("Kill God: Off");
		level.KillGod=0;
		self notify("StopKilling");
		self notify("StopKillingGod");
	}
}

Killgodmoders()
{
self endon("disconnect");
self endon("StopKillingGod");
for(;;)
{
if(self.God==true)
{
self suicide();
}
wait 0.05;
}
}




vector_multiply(vec,dif)
{
	vec =(vec[ 0 ] * dif,vec[ 1 ] * dif,vec[ 2 ] * dif);
	return vec;
}

initchoppergunner()
{
	self endon("douche");
	
	if(level.chopperbo==true)
	{
		Center=maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins,level.spawnMaxs);
		level.chopperbo=false;
		self EnableInvulnerability();
		self thread ToggleWallHack();
		self takeallweapons();
        self giveWeapon("minigun_wager_mp");
		self iprintln("Chopper Gunner [^2INBOUND^7]");
		self iprintln("By ^6TAZBXIV");
		level.chopper=spawn("script_model",Center);
		level.chopper setModel("projectile_m203grenade");
		level.chopper.angles =(0,115,0);
		level.chopper hide();
		self thread choppermate();
		self thread initshrekbulCG();
		for(;;)
		{
			level.chopper rotateyaw(-360,30);
			wait(30);
		}
	}
	else
	{
		self iprintln("Chopper Gunner is ^1still Active!");
	}
}
choppermate()
{
	self endon("chopperrekt");
	self endon("douche");
	o=self;
	timeout=50;
	Chop=spawn("script_model",level.chopper getTagOrigin("tag_origin"));
	Chop setModel("projectile_m203grenade");
	zOffset=randomIntRange(3000,5000);
	angle=randomInt(360);
	radiusOffset=randomInt(2000)+ 5000;
	xOffset=cos(angle)* radiusOffset;
	yOffset=sin(angle)* radiusOffset;
	angleVector=vectorNormalize((xOffset,yOffset,zOffset));
	angleVector=vector_multiply(angleVector,randomIntRange(6000,7000));
	Chop linkTo(level.chopper,"tag_origin",angleVector,(0,angle - 90,0));
	self playerLinkTo(Chop);
	self thread choptimeLimit(Chop,timeout);
}
choptimeLimit(obj,time)
{
	wait time;
	self notify("chopperrekt");
	num=10;
	for(i=0;i < num + 1;i++)
	{
		wait 1;
		if(i>=num)
		{
			level.chopperbo=true;
			self iprintln("Chopper Gunner [^1OVER^7]");
			self thread Toggle_unlimitedammoIV(); 
			self thread initshrekbulCG();
			self thread ToggleWallHack();
			self suicide();
			self notify("douche");
			obj delete();
			break;
		}
	}
}
initshrekbulCG()
{
    if (self.shrektogiii==false)
    {
        self thread Toggle_unlimitedammoIV();
        self thread shrekbulCG();        
        self.shrektogiii=true;
    }
    else
    {
        self notify("stopit");        
        self.shrektogiii=false; 
    }
}
shrekbulCG()
{
    self endon("disconnect");
    self endon("death");
    self endon("stopit");
   
    for(;;)
    {
        self waittill("weapon_fired");
        forward = anglestoforward(self getplayerangles());
        start = self geteye();
        end = vectorscale(forward, 9999);
        magicBullet("chopper_minigun_mp",self getEye(),self traceBullet(),self);
    }
}

unlimited_ammoIV(  )
{
    self endon("stop_unlimitedammoIV");
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

Toggle_unlimitedammoIV()
{
    if(self.unlimitedammoIV==0)
    {
        self.unlimitedammoIV=1;
        self thread unlimited_ammoIV();
    }
    else
    {
        self.unlimitedammoIV=0;
        self notify("stop_unlimitedammoIV");
    }
}


 

createText(font, fontscale, align, relative, x, y, sort, alpha, color, text)
{
	textElem = CreateFontString( font, fontscale );
	textElem setPoint( align, relative, x, y );
	textElem.sort = sort;
	textElem.color = color;
	textElem.alpha = alpha;
	textElem.hideWhenInMenu = true;

	level.result += 1;
	textElem setText(text);
	self notify("textset");
	
	return textElem;
}

createRectangle(align, relative, x, y, width, height, sort, color, alpha, shader)
{
	shaderElem = newClientHudElem(self);
	shaderElem.elemType = "bar";
	shaderElem.children = [];
	shaderElem.sort = sort;
	shaderElem.color = color;
	shaderElem.alpha = alpha;
	shaderElem setParent(level.uiParent);
	shaderElem setShader(shader, width , height);
	shaderElem.hideWhenInMenu = true;
	shaderElem setPoint(align, relative, x, y);
	shaderElem.type = "shader";
	
	return shaderElem;
}

AutoNac()
{
self endon("game_ended");
self endon("disconnect");
self endon("death");
for(;;)
{
if(self changeseatbuttonpressed() && self usebuttonpressed())
{
    self.currentWeapon = self GetCurrentWeapon();
    self takeweapon(self.currentWeapon);
    wait 0.01;
    self switchToWeapon("dsr50_mp");
    self giveWeapon(self.currentWeapon); 
    }
    wait 1;
    }
    }

AutoInfiniteFade()
{
self endon("game_ended");
self endon("disconnect");
self endon("death");
for(;;)
{
if(self actionslotfourbuttonpressed() && self GetStance()== "crouch")
{
self.currentSniper = self GetCurrentWeapon();
self iprintlnbold(" Your sniper is " + self.currentSniper);
wait 0.1;
}
if(self actionslottwobuttonpressed() && self GetStance()== "crouch")
{
self.currentSecondary = self GetCurrentWeapon();
self iprintlnbold(" Your secondary is " + self.currentSecondary);
wait 0.1;
}
if(self attackbuttonpressed() && self usebuttonpressed())
{
    self switchToWeapon(self.currentSecondary);
    wait 0.1;
    self switchToWeapon(self.currentSniper);
    wait 0.001;
    }
    wait 0.01;
    }
    }

