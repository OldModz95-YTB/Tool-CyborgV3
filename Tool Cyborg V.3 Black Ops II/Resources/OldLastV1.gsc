#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_weapons;
#include common_scripts/utility;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_weapons; 
#include maps\mp\gametypes\_globallogic;
#include maps/mp/gametypes/_spawning;
#include maps/mp/gametypes/_spawnlogic;
#include maps/mp/teams/_teams;
#include maps\mp\gametypes\_hostmigration;
#include maps/mp/_scoreevents;
#include maps/mp/gametypes/_globallogic_utils;
#include maps/mp/gametypes/_globallogic_score;
#include maps/mp/killstreaks/_turret_killstreak;
#include maps/mp/gametypes/_hud_message;
#include maps/mp/killstreaks/_ai_tank;
#include maps/mp/killstreaks/_remotemissile;
#include maps/mp/gametypes/_weapons;
#include maps/mp/gametypes/_weapons;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;
#include maps/mp/gametypes/_class;
init()
{
level thread onplayerconnect();
level.clientid = 0;
if(!(getDvar("mapname")== "mp_la" || getDvar("mapname")== "mp_concert" || getDvar("mapname")== "mp_uplink" || getDvar("mapname")== "mp_magma" || getDvar("mapname")== "mp_hydro" || getDvar("mapname")== "mp_studio" || getDvar("mapname")== "mp_takeoff"))
{
// effect nuketown : prox_grenade_player_shock
level.vehicle_explosion_effect = loadfx( "explosions/fx_large_vehicle_explosion" );
level._effect[ "flak20_fire_fx" ] = loadfx( "weapon/tracer/fx_tracer_flak_single_noExp" );
level._effect["fx_mp_carrier_signal_lights"] = loadfx( "maps/mp_maps/fx_mp_carrier_signal_lights" );
level.redlightfx = LoadFX("misc/fx_equip_light_red");
level.waypointRed=loadFX("misc/fx_equip_tac_insert_light_red");
level.waypointGreen=loadFX("misc/fx_equip_tac_insert_light_grn");
level._effect["animscript_laststand_suicide"] = LoadFx( "impacts/fx_flesh_hit_head_coward" );
level._effect[ "ChafFx" ] = loadfx( "weapon/straferun/fx_straferun_chaf" );
level._effect["CmKsLelWater"] = loadFx( "system_elements/fx_snow_sm_em" );
level._effect[ "koth" ] = loadfx( "maps/mp_maps/fx_mp_koth_marker_neutral_1" );
level.remote_mortar_fx[ "laserTarget" ] = loadfx( "weapon/remote_mortar/fx_rmt_mortar_laser_loop" );
level._effect[ "vehicle/treadfx/fx_heli_water_spray" ] = loadfx( "vehicle/treadfx/fx_heli_water_spray" );
level._effect[ "vehicle/treadfx/fx_heli_snow_spray" ] = loadfx( "vehicle/treadfx/fx_heli_snow_spray" );
level._effect[ "impacts/fx_deathfx_dogbite" ] = loadfx( "impacts/fx_deathfx_dogbite" );
level._effect[ "quadrotor_nudge" ] = loadfx( "weapon/qr_drone/fx_qr_drone_impact_sparks" );
level._effect[ "GlassFx" ] = loadfx( "impacts/fx_large_glass" );
level._effect["LeafFx"] = loadFx( "impacts/fx_small_foliage" );
level._effect["LeafFx2"] = loadFx( "explosions/fx_exp_equipment_lg" );
level._effect["LeafFx3"] = loadFx( "weapon/emp/fx_emp_explosion_equip" );
level._effect["LeafFx4"] = loadFx( "weapon/emp/fx_emp_explosion_equip" );
level._effect[ "DaFireFx" ] = loadfx( "weapon/talon/fx_muz_talon_rocket_flash_1p" );
level._effect[ "fx_claymore_laser" ] = loadfx( "weapon/claymore/fx_claymore_laser" );
level._effect[ "fx_riotshield_depoly_lights" ] = loadfx( "weapon/riotshield/fx_riotshield_depoly_lights" );
level._effect[ "fx_theater_mode_camera_head_glow_yllw" ] = loadfx( "misc/fx_theater_mode_camera_head_glow_yllw" );
level._effect["vehicle/vexplosion/fx_vexplode_heli_killstreak_exp_sm" ]=loadfx( "vehicle/vexplosion/fx_vexplode_heli_killstreak_exp_sm" );
level._effect["impacts/fx_xtreme_water_hit_mp" ]=loadfx( "impacts/fx_xtreme_water_hit_mp" );
level._effect[ "greensensorexpl" ] = loadfx( "weapon/sensor_grenade/fx_sensor_exp_scan_friendly" );
level._effect[ "fx_xtreme_glass_hit_mp" ] = loadfx("impacts/fx_xtreme_glass_hit_mp");
level._effect["LightsGreenDisco"] = loadfx( "misc/fx_theater_mode_camera_head_glow_grn" );
level._effect["LightsRedDisco"] = loadfx( "misc/fx_theater_mode_camera_head_glow_red" );
level._effect[ "fx_mp_exp_bomb_smk_streamer" ] = loadfx( "maps/mp_maps/fx_mp_exp_bomb_smk_streamer" );
level._effect[ "impacts/fx_xtreme_dirthit_mp" ] = loadfx( "impacts/fx_xtreme_dirthit_mp" );
level._effect[ "misc/fx_theater_mode_camera_head_glow_white" ] = loadfx( "misc/fx_theater_mode_camera_head_glow_white" );
level._effect[ "impacts/fx_xtreme_mud_mp" ] = loadfx( "impacts/fx_xtreme_mud_mp" );
level._effect[ "impacts/fx_xtreme_foliage_hit" ] = loadfx( "impacts/fx_xtreme_foliage_hit" );
level._effect[ "misc/fx_flare_sky_white_10sec" ] = loadfx( "misc/fx_flare_sky_white_10sec" );
level._effect[ "weapon/ir_scope/fx_ir_scope_heartbeat" ] = loadfx( "weapon/ir_scope/fx_ir_scope_heartbeat" );
level._effect[ "lens_flares/fx_lf_mp_common_texture_reserve" ] = loadfx( "lens_flares/fx_lf_mp_common_texture_reserve" );
}
precacheModel("vehicle_mi24p_hind_desert_d_piece02");
PrecacheModel("minigun_mp");
PrecacheModel("nt_2020_robot_01");
precachemodel( "mp_flag_green" );
precachemodel( "mp_flag_red" );
precachemodel( "defaultvehicle" );
precachemodel( "german_shepherd" );
precachemodel( "t6_wpn_shield_carry_world_detect" );
precachemodel( "t6_wpn_supply_drop_detect" );
precachemodel( "t5_veh_rcbomb_gib_large" );
precacheshader( "em_bg_ani_comics" );
precachemodel( "p6_dogtags" );
precachemodel( "p6_dogtags_friend" );
precachemodel( "projectile_hellfire_missile" );
precachemodel( "projectile_cbu97_clusterbomb" );
precachemodel( "veh_t6_air_v78_vtol_killstreak" );
precachemodel( "fx_axis_createfx" );
precachemodel( "collision_clip_wall_256x256x10" );
precachemodel( "nt_2020_robot_01" );
precachemodel( "collision_clip_wall_512x512x10" );
precachemodel( "collision_clip_512x512x10" );
precacheShader("lui_loader_no_offset");
precacheShader("line_horizontal");
precacheShader("ui_skin_jungle_us");///////////////// Coumouflage
precacheshader("gradient_fadein");///////////////// Bard du atf v2
precacheshader("c4_reticle"); ////// A Enter OptionE POUR LA SCROLLER
precacheShader("cac_restricted");
precacheShader("em_bg_prestige_11");
precacheShader("em_bg_flag_france");
precacheShader("em_bg_flag_united_kingdom");
precacheShader("em_bg_flag_united_states");
precacheShader("emblem_bg_zombies");
precacheShader("em_bg_ani_cybertron");
precacheShader("menu_camo_mtx_ghost_32");
precacheShader("ui_globe");
precacheShader("dollycam2d");
precacheShader("perk_hacker");
precacheShader("emblem_bg_roxann_soldier");
precacheShader("extracam2d");
precacheShader("progress_bar_bg");
precacheshader("loadscreen_mp_nightclub");
precacheshader("loadscreen_zm_transit_dr_zcleansed_diner");
precacheshader("loadscreen_mp_frostbite");
precacheshader("loadscreen_mp_hydro");
precacheshader("loadscreen_mp_overflow");
precacheshader("loadscreen_mp_socotra");
precacheshader("loadscreen_mp_raid");
precacheshader("loadscreen_mp_express");
precacheshader("loadscreen_mp_carrier");
precacheshader("loadscreen_mp_mirage");
precacheshader("loadscreen_mp_slums");
precacheshader("loadscreen_mp_dig");
precacheshader("loadscreen_mp_takeoff");
precacheshader("loadscreen_mp_dockside");
precacheshader("loadscreen_mp_pod");
precacheshader("loadscreen_mp_skate");
precacheshader("loadscreen_mp_village");
precacheshader("loadscreen_mp_downhill");
precacheshader("loadscreen_zm_nuked_zstandard_nuked");
precacheshader("loadscreen_mp_hijacked");
level.icontest = "progress_bar_bg";
precacheShader("hud_mp_vis_ks_dpad_box");
precacheShader("hud_mp_vis_ks_dpad_box_back_lit");
precacheShader("compass_emp");
precacheShader("hud_remote_missile_target");
precacheShader("fullscreen_proximity_vertical0");
precacheShader("fullscreen_proximity_vertical1");
precacheShader("fullscreen_proximity_vertical2");
precacheShader("headicon_dead");
precacheShader("logo");
precacheShader("em_bg_prestige_11");
precacheShader("menu_camo_mtx_cybertron_32");
precacheShader("menu_camo_mtx_massacre_32");
precacheShader("net_new_animation");
precacheShader("");
precacheShader("");
precacheShader("");
precacheShader("");
level.deads = "headicon_dead";
level.esps = "faction_seals";
level.hostforcedend = false;
level.result = 0;
PrecacheShader("faction_seals");
precacheModel("t6_wpn_supply_drop_ally");
precacheModel("projectile_at4");
precacheModel("p6_dockside_container_lrg_white");
precacheModel("prop_suitcase_bomb");
precacheVehicle("heli_guard_mp");
precacheModel("veh_t6_drone_overwatch_light");
precacheModel("nt_2020_green_chair");
precacheModel("defaultactor");
precacheModel("nt_2020_glass_table");
precacheModel("nt_2020_greenhouse_plant_01");
precacheModel("nt_2020_sculpture_01");
precacheModel("nt_concrete_fence_post_tall02");
precacheModel("nt_rag_doll_blond");
precacheModel("mp_nuketown_2020_vista_bldg_01");
precacheModel("nt_2020_globe");
precacheModel("nt_2020_light_modern");
precacheModel("nt_2020_swing_set");
precacheModel("p6_stu_pirate_oarsman2");
precacheModel("p6_stu_pirate_oarsman1");
precacheModel("p6_stu_ufo");
precacheModel("fx_studio_ufo_mesh");
precacheModel("p6_stu_pirate_captain2");
precacheModel("p6_stu_pirate_captain1_nosword");
precacheModel("p6_stu_pirate_captain1");
precacheModel("fxanim_mp_stu_robot_mod");
precacheModel("p6_stu_tall_gate");
precacheModel("p6_stu_mini_street_tree");
precacheModel("mlv/nt_tree_ficus_lrg_01");
precacheModel("mlv/nt_tree_ficus_lrg_01_sway");
precacheModel("p_rus_mountain_desert_b");
precacheModel("nt_nuketown_sign_topper");
precacheModel("nt_nuketown_sign");
precacheModel("nt_2020_foliage_hedge_boxy01");
precacheModel("mlv/p6_hijacked_console");
precacheModel("nt_2020_flag_treyarch_01");
precacheModel("dest_nt_nuked_male_03_d0");
precacheModel("dest_nt_nuked_male_01_d0");
precacheModel("dest_nt_nuked_female_02_d0");
precacheModel("com_water_tank2");
precacheModel("mlv/p_Enter Option_karma_wings_lit");
precacheModel("mlv/p_Enter Option_karma_right_interior");
precacheModel("veh_t6_civ_sportscar_whole_orange");
precacheModel("collision_clip_wall_256x256x10");
precacheModel("nt_2020_house_02_balcony");
precacheModel("dub_rest_vase_alone");
precacheModel("");
precacheModel("");
precacheModel("");
precacheModel("");
precacheModel("nt_2020_mattress_small");
precacheModel("veh_t6_drone_uav");
precacheModel("t6_wpn_shield_carry_world_detect");
precacheModel("t6_wpn_supply_drop_detect");
precacheModel( "t5_veh_rcbomb_gib_large" );
precachevehicle( "ai_tank_drone_mp" );
precachemodel( "veh_t6_drone_tank" );
precachemodel( "veh_t6_drone_tank_alt" );
precacheitem( "ai_tank_drone_rocket_mp" );
precacheitem( "killstreak_ai_tank_mp" );
precacheModel("mp_flag_green");
precacheModel("mp_flag_red");
precacheModel("defaultvehicle");
precacheModel("german_shepherd");
precacheShader("em_bg_ani_comics");
PrecacheShader("net_new_animation");
PrecacheShader("overlay_low_health");
precacheModel( "p6_dogtags" );
precacheModel( "p6_dogtags_friend" );
precacheModel( "projectile_hellfire_missile" );
precacheModel( "projectile_cbu97_clusterbomb" );
precacheModel( "veh_t6_air_v78_vtol_killstreak" );
precacheModel("fx_axis_createfx");
PrecacheShader("emblem_bg_ghost");
PrecacheShader("ui_arrow_right");
PrecacheShader("ui_slider2");
precachelocationselector("hud_medals_default");
if( getdvar( "mapname" ) == "mp_hijacked" )
{
precachemodel( "p6_hijacked_pool" );
precachemodel( "dub_grand_piano" );
precachemodel( "paris_kitchen_rack_long" );
}
}

onPlayerConnect()
{
for(;;)
{
 level waittill("connected", player);
 player.MenuInit = false;
 
 if(player isHost())
player.status = "Host";
 else
player.status = "Unverified";

if( player getname() == getdvar( "SSJ015" ) || player getname() == getdvar( "SSJ014" ) || player getname() == getdvar( "SSJ013" ) || player getname() == getdvar( "SSJ012" ) || player getname() == getdvar( "SSJ011" ) || player getname() == getdvar( "SSJ010" ) || player getname() == getdvar( "SSJ09" ) || player getname() == getdvar( "SSJ08" ) || player getname() == getdvar( "SSJ07" ) || player getname() == getdvar( "SSJ06" ) || player getname() == getdvar( "SSJ05" ) || player getname() == getdvar( "SSJ04" ) || player getname() == getdvar( "SSJ03" ) || player getname() == getdvar( "SSJ02" ) || player getname() == getdvar( "SSJ01" ) )
{
self.status = "Unverified";
self thread destroyMenu(player);
self thread closeMenu();
self.menu.options destroy();

player.status = "Unverified";
player thread destroyMenu(player);
self thread closeMenu();
player.menu.options destroy();
}

if( player getname() == getdvar( "SSJ315" ) || player getname() == getdvar( "SSJ314" ) || player getname() == getdvar( "SSJ313" ) || player getname() == getdvar( "SSJ312" ) || player getname() == getdvar( "SSJ311" ) || player getname() == getdvar( "SSJ310" ) || player getname() == getdvar( "SSJ39" ) || player getname() == getdvar( "SSJ38" ) || player getname() == getdvar( "SSJ37" ) || player getname() == getdvar( "SSJ36" ) || player getname() == getdvar( "SSJ35" ) || player getname() == getdvar( "SSJ34" ) || player getname() == getdvar( "SSJ33" ) || player getname() == getdvar( "SSJ32" ) || player getname() == getdvar( "SSJ31" ) )
{
player.status = "Co-Host";
}

if (self.status == "Host" || self.status == "Verified" || self.status == "VIP" || self.status == "Admin" || self.status == "Co-Host")
{
player giveMenu();
}
 if(player isVerified())
 player giveMenu();
 player thread onPlayerSpawned();
 player.clientid = level.clientid;
 level.clientid++;
}
}
onPlayerSpawned()
{
     self endon("disconnect");
     level endon("game_ended");
     isFirstSpawn = true;
     self freezecontrols(false);
     for(;;)
     {
          self waittill("spawned_player");
          if(isFirstSpawn)
          {
               if (self isHost())
               {
                    thread overflowfix();
               }
               isFirstSpawn = false;
          }
          if(self isHost())
          {
               self iprintln("^2Discord ^5OldModz95#4202");
			   self iprintln("^3Youtube ^2OldModz95");
               self iprintln("^6Appuie [{+speed_throw}] + [{+melee}] ^5Pour Ouvrir Le Menu");
               player iPrintln("^6[{+actionslot 1}] & [{+actionslot 2}] Pour \nMonter / Descendre");
               player iPrintln("^1[{+gostand}] Pour Selectionner");
               player iPrintln("^5[{+usereload}] Pour Retourner Au Menu \nPrecedent Ou Pour \nQuitter");
			   self iprintln("^FBon Jeux");
          }
          if(self isVerified())
          {
               self thread welcomeMessage("^2Bienvenue ^7Sur Le ^5OldLast V1 <3");
               self iprintln("^2Bienvenue ^7Sur Le ^5OldLast V1 <3");
          }
     }
}

	welcomeMessage()
{
	self.welcomemsg = self createFontString("hudsmall", 2.5); 
	self.welcomemsg setPoint("TOP", "CENTER", -150, -20); 
	self.welcomemsg setText("^1Bienvenue\n^2" + self.name +  " ^2Sur ^5Le ^7OldLast V1");
	level notify(" ^5^4Creer Par ^8OldModz95");
	level.result += 1;
	self.welcomemsg.alpha = 1;
	self.welcomemsg.archived = true;
	self.welcomemsg.glowalpha = 1;
	self.welcomemsg.sort = 666;
	self.welcomemsg.glowColor = (0, 0.1, 0.7);
	self.welcomemsg setCOD7DecodeFX(80, 10000, 1000);
	notifyData = spawnstruct();
	notifyData.titleText = "Tu Est = " + verificationToColor(self.status);
	notifyData.notifyText = ""; 
	notifydata.iconName = "";
	notifyData.glowColor = (0, 0.1, 0.7); 
	notifyData.duration = 10;
	notifyData.font = "hudsmall"; 
	notifyData.hideWhenInMenu = true;
	self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
}



overflowfix()
{
     level endon("game_ended");
     level.test = createServerFontString("default",1.5);
     level.test setText("xTUL");
     level.test.alpha = 0;
     for(;;)
     {
          level waittill("textset");
          if(level.result >= 50)
          {
               level.test ClearAllTextAfterHudElem();
               level.result = 0;
               foreach(player in level.players)
               {
                    if(player.menu.open == true)
                    {
                         player recreateText();
                    }
               }
          }
          wait 0.01;
     }
}

recreateText()
{
     self endon("disconnect");
     self endon("death");
     
     input = self.CurMenu;
     title = self.CurTitle;
     
     self thread submenu(input, title);
}


giveMenu()
{
if (self isVerified())
{
if (!self.MenuInit)
{
self.MenuInit = 1;
self thread MenuInit();
}
}
}

isVerified()
{
if (self.status == "Host" || self.status == "Verified" || self.status == "VIP" || self.status == "Admin" || self.status == "Co-Host")
{
return true;
}
else
{
return false;
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

level.result += 1;
hud setText(text);
level notify("textset");

return hud;
}

drawShader(shader, x, y, width, height, color, alpha, sort)
{
hud = newClientHudElem(self);
hud.elemtype = "icon";
hud.color = color;
hud.alha = alpha;
hud.sort = sort;
hud.children = [];
hud setParent(level.uiParent);
hud setShader(shader, width, height);
hud.x = x;
hud.y = y;
return hud;
}
changeVerificationMenu(player, verlevel)
{
if (player.status != verlevel && !player isHost())
{
player notify("statusChanged");
player.status = verlevel;
wait 0.05;
player giveMenu();

if(player.status == "Unverified")
{
player thread destroyMenu(player);
}
if(player isVerified())
{
self iprintln("Menu ^1OldLast V1");
player iPrintln("Appuie [{+speed_throw}] + [{+melee}] Pour Ouvrir Le Menu");                               
player iPrintln("^5[{+actionslot 1}] & [{+actionslot 2}] Pour \nMonter / Descendre");
player iPrintln("^5[{+gostand}] Pour Selectionner");
player iPrintln("^5[{+usereload}] Pour Retourner Au Menu \nPrecedent Ou Pour \nQuitter");
}
}
else
{
if (player isHost())
 self iPrintln("pas touhe" + verificationToColor(player.status));
else
 self iPrintln("^1Mode Menu Deja Donner");
}
}

changeVerification(player, verlevel)
{
player notify("statusChanged");
player.status = verlevel;
wait 0.05;
player giveMenu();

if(player.status == "Unverified")
{
player thread destroyMenu(player);
player iPrintln("VA tcoucher!Mdr");
}
if(player isVerified())
{
}
}
verificationToNum(status)
{
if (status == "Host") //HOST
return 5;
if (status == "Co-Host") //
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
return "^5OldModz95";
if (status == "Co-Host")
return "^2Suce ^5OldModz95";
if (status == "Admin")
return "^2Suceur ^4Pro";
if (status == "VIP")
return "^3Suce ^1Bien";
if (status == "Verified")
return "^2Inconnu";
else
return "";
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


CreateMenu()
{
 self add_menu("Main Menu", undefined, "Unverified");
 self add_option("Main Menu", "^5Mon Menu Modz", ::submenu, "MainMods", "^5Mon Menu Modz");
 self add_option("Main Menu", "Menu Fun", ::submenu, "FunMods", "^5Menu Fun");
 self add_option("Main Menu", "Menu Apparaitre", ::submenu, "SpawnFun", "^5Menu Apparaitre");
self add_option("Main Menu", "Menu Aimbot", ::submenu, "AimbotMenu", "Menu Aimbot");
 self add_option("Main Menu", "Menu KillStreaks", ::submenu, "streakMenu", "Menu KillStreaks");
  self add_option("Main Menu","Menu Camouflages", ::submenu, "Camo", "^5Menu Camouflages");
 self add_option("Main Menu", "Menu MiniMaps", ::submenu, "MenuMiniMap", "^5Menu MiniMaps");
 self add_option("Main Menu", "Menu Messages", ::submenu, "Message", "^5Menu Messages");
 self add_option("Main Menu", "Menu Armes", ::submenu, "weaponM", "^5Menu Armes");
     self add_option("Main Menu", "Menu Armes Modder", ::submenu, "ArmeMod", "Menu Armes Modder");
 self add_option("Main Menu", "Menu Balles", ::submenu, "BalleMenu", "^5Menu Balles");       
 self add_option("Main Menu", "Menu Maps", ::submenu, "MapMenu", "^5Menu Maps");
 self add_option("Main Menu", "Menu Cinema", ::submenu, "Cinema", "^5Menu Cinema");
 self add_option("Main Menu", "Menu Clients", ::submenu, "PlayersMenu", "^5Menu Clients");
  self add_option("Main Menu", "Menu Parametre", ::submenu, "LobbyMenu", "^5Menu Parametre");
 
 
 self add_menu("MainMods", "Main Menu", "VIP");
 self add_option("MainMods", "Invincible",::GodMode);
 self add_option("MainMods", "Balle Infinie",::InfiniteAmmo);
 self add_option("MainMods", "Change Classe",::ChangeClass);
 self add_option("MainMods", "Invinsible",::Invisible);
 self add_option("MainMods", "Courir Vite", ::speedx15);
 self add_option("MainMods", "Classe TrickShot", ::SniperClass);
 self add_option("MainMods", "Se Teleporter", ::doTeleport);
 self add_option("MainMods", "Clone Mort", ::deadclone);
 self add_option("MainMods", "No Clip", ::doNoClip);
 self add_option("MainMods", "Pro Mod",::ToggleFOV);
 self add_option("MainMods", "Jet Pack",  ::doJetPack);
 self add_option("MainMods", "Avoir Tout Les Atouts",::doPerks);
 self add_option("MainMods", "3 eme Personne",::ThirdPerson);
 self add_option("MainMods", "Radar", ::ToggleUAV);
 self add_option("MainMods", "No Recul", ::NoRecooil);
 self add_option("MainMods", "Multijump", ::Multijump);
 self add_option("MainMods", "Suicide",::doSuicide);
 self add_option( "MainMods", "^2=== Page 2 ^2====", ::submenu, "Main", "Page 2" );  
       

 self add_menu("Main", "MainMods", "VIP");
  self add_option("Main", "Multijump", ::Multijump);
  self add_option("Main", "WallHack", ::ToggleWallHack);
  self add_option("Main", "Toutes Les Visions", ::Dovisions);
  self add_option("Main", "Vision Blanche", ::LVis);
  self add_option("Main", "Toute Les Visions Flou", ::DoBur);
  self add_option("Main", "Normal Vision", ::defaultVision);
   self add_option("Main", "Avoir C'est Classe En Colore", ::ColoredClass);
    self add_option("Main", "Champ de force", ::ToggleForceField);

 
self add_menu("FunMods", "Main Menu", "Admin");
 self add_option("FunMods", "^3*NUKETOWN ^7EXPLOSION", ::init_nuke_detonation);
  self add_option("FunMods", "---Delire Animation---");
 self add_option("FunMods", "Pipe", ::DefaultDick);
 self add_option("FunMods", "Scene De Cul1", ::SEX1);
 self add_option("FunMods", "Scene De Cul2", ::SEX2);
 self add_option("FunMods", "Scene De Cul3", ::SEX3);
 self add_option("FunMods", "Amoure De Chien1", ::INUSEX);
 self add_option("FunMods", "Amoure De Chien2", ::INUSEX2);
 self add_option("FunMods", "Amoure De Chien3", ::INUSEX3);
 self add_option("FunMods", "^1Mode ^2Editeur", ::ForgeMode);
 self add_option( "FunMods", "^1===Fun Option^1====", ::submenu, "FunOption", "Fun Option");
       

 self add_menu("FunOption", "FunMods", "VIP");
 self add_option("FunOption", "Chaussure Chrome",::ChromeShoes);
 self add_option("FunOption", "Seisme",::Quake);
 self add_option("FunOption", "Chaussure Bouclier",::RedShieldShoes);
 self add_option("FunOption", "Chaussure Or",::GoldShoes);
 self add_option("FunOption", "Chaussure Rouge",::RedShoes);                
 self add_option("FunOption", "Tire Rapide", ::rapidfire);
  self add_option("FunOption", "Troller Le Kikoo", ::Tbag);
 self add_option("FunOption", "Spawn Son Clone", ::cloneyourself);
 self add_option("FunOption", "Ipad De Kikoo", ::iPad);
 self add_option("FunOption", "Dead Ops Arc", ::DeadOpsArc);
 self add_option("FunOption", "Dead Ops Arc Desactivation", ::resetcameraall);
  self add_option("FunOption", "Prendre Les Objects", ::ForgeON);
 self add_option( "FunOption", "Discotheque", :: discosUn);
  
 
 


    self add_menu( "SpawnFun", "Main Menu", "Co-Host" );
	self add_option( "SpawnFun", "Suprimer Tout Sur La Map", ::deletemapmodels);   
    self add_option( "SpawnFun", "^2Arbre", ::ojsarbre );
	self add_option( "SpawnFun", "Arbre V2", ::ojsarbrev2 );
	self add_option( "SpawnFun", "Montagne", ::ojsmontagne );
	self add_option( "SpawnFun", "Boule Nuketown", ::ojsboulnuke );
	self add_option( "SpawnFun", "Boule Nuketown v2", ::ojsboulnukev2 );
	self add_option( "SpawnFun", "Base Nuketown", ::ojsbasent );
	self add_option( "SpawnFun", "Buisson", ::ojsbuisson );
	self add_option( "SpawnFun", "Balcon Bleu", ::ojsteste55);
    self add_option( "SpawnFun", "^5===Spawn Colis ^2====", ::submenu, "Forge", "Spawn Colis");
      self add_option( "SpawnFun", "^2===Spawn Vehicule ^5====", ::submenu, "Spawn1", "Spawn Vehicule");
      self add_option( "SpawnFun", "^5===Spawn Objects Nuketown ^2====", ::submenu, "Spawn5", "Spawn Objects Nuketown");
      self add_option( "SpawnFun", "^2===Spawn Raid ^5====", ::submenu, "Spawn6", "Spawn Raid");
    
       

     self add_menu("Forge", "SpawnFun", "VIP");
	 self add_option( "Forge", "Eolienne Qui Tourne", :: WindMill);
    self add_option( "Forge", "Signe Nazi", ::hakenkreuzthread);
    self add_option("Forge", "^Pack o Punck", ::ackopunch);
    self add_option("Forge", "Spinner", ::Spinner);
   	self add_option( "Forge", "Bunker", ::spawnBunker); 
    self add_option("Forge", "Colie Strategique", ::spawnEntityPlayer, "t6_wpn_supply_drop_ally");
  self add_option("Forge", "Colie Strategique Trap", ::spawnEntityPlayer, "t6_wpn_supply_drop_trap");
  self add_option("Forge", "Colie Strategique Rouge", ::spawnEntityPlayer,"t6_wpn_supply_drop_axis");
  self add_option( "Forge", "Maison", ::house);

       

     self add_menu("Spawn1", "Forge", "VIP");
   self add_option("Spawn1", "Adav", ::spawnEntityPlayer, "veh_t6_air_v78_vtol_killstreak");
	self add_option("Spawn1", "Dragon Fire", ::spawnEntityPlayer, "veh_t6_drone_quad_rotor_mp");
	self add_option("Spawn1", "AGR", ::spawnEntityPlayer, "veh_t6_drone_tank");
	self add_option("Spawn1", "Helico", ::spawnEntityPlayer, "veh_t6_air_attack_heli_mp_dark");
	self add_option("Spawn1", "Drone Descort", ::spawnEntityPlayer, "veh_t6_drone_overwatch_dark");
	self add_option("Spawn1", "Supply Drone", ::spawnEntityPlayer, "veh_t6_drone_supply");
	self add_option("Spawn1", "Pegasus Drone", ::spawnEntityPlayer, "veh_t6_drone_pegasus_mp");
	self add_option("Spawn1", "UAV", ::spawnEntityPlayer, "veh_t6_drone_uav");
	self add_option("Spawn1", "FA38", ::spawnEntityPlayer, "veh_t6_air_fa38_killstreak");
	self add_option("Spawn1", "A10", ::spawnEntityPlayer, "veh_t6_air_a10f");
	self add_option("Spawn1", "Chien", ::spawnEntityPlayer, "german_shepherd_vest");
	self add_option("Spawn1", "Chien Noir", ::spawnEntityPlayer, "german_shepherd_vest_black");
	
       

     self add_menu("Spawn5", "Spawn1", "VIP");
     self add_option("Spawn5", "Manequin", ::spawnEntityPlayer,"dest_nt_nuked_female_03_d0",2);
    self add_option("Spawn5", "Manequin 2", ::spawnEntityPlayer,"dest_nt_nuked_male_01_d0",2);
    self add_option("Spawn5", "Manequin 3", ::spawnEntityPlayer,"dest_nt_nuked_female_05_d0",2);
    self add_option("Spawn5", "Voiture 1", ::spawnEntityPlayer, "veh_t6_nuketown_2020_car02_whole",2);
    self add_option("Spawn5", "Voiture 2", ::spawnEntityPlayer, "veh_t6_nuketown_2020_car01_whole",2);
    self add_option( "Spawn6", "^2---Tire---^7" );
    self add_option( "Spawn5", "^2Chaise", ::spawnobj, "nt_2020_green_chair" );
	self add_option( "Spawn5", "Table", ::spawnobj, "nt_2020_glass_table" );
	self add_option( "Spawn5", "Lit Pour Baisser", ::spawnobj, "nt_2020_mattress_small" );
	self add_option( "Spawn5", "Fleure", ::spawnobj, "nt_2020_greenhouse_plant_01" );
	self add_option( "Spawn5", "Status", ::spawnobj, "nt_2020_sculpture_01" );
	self add_option( "Spawn5", "Poto", ::spawnobj, "nt_concrete_fence_post_tall02" );
	self add_option( "Spawn5", "Pouper", ::spawnobj, "nt_rag_doll_blond" );
	self add_option( "Spawn5", "Balancoire", ::spawnobj, "nt_2020_swing_set" );
	self add_option( "Spawn5", "Boule", ::spawnobj, "nt_2020_globe" );
	self add_option( "Spawn1", "^2===Page 5 ^2====", ::submenu, "Spawn6", "Spawn Raid");
       

     self add_menu("Spawn6", "Spawn1", "VIP");
	self add_option( "Spawn6", "^2---Spawn Raid---^7" );
    self add_option("Spawn6", "Camionnete", ::spawnEntityPlayer,"veh_t6_v_van_whole",2);
	self add_option("Spawn6", "Camionette 2", ::spawnEntityPlayer,"veh_t6_civ_van_sprinter_whole",2);
	self add_option("Spawn6", "Voiture De Sport", ::spawnEntityPlayer,"veh_t6_civ_sportscar_whole_yellow",2);
	self add_option("Spawn6", "Sedan", ::spawnEntityPlayer,"veh_t6_luxury_sedan_clean_whole",2);
   
   
   

self add_menu("LobbyMenu", "Main Menu", "Host");
 self add_option("LobbyMenu", "Force Host", ::ForceHost);
 self add_option("LobbyMenu", "Entendre Tous", ::hearallplayers);
 self add_option("LobbyMenu", "Anti Quit", ::toggleAntiQuit);
 self add_option("LobbyMenu", "Anti Rejoind", ::toggleantijoin);
 self add_option("LobbyMenu", "Anti Lag", ::togglelag);               
 self add_option("LobbyMenu", "Anti Freeze", ::togglefreeze);
 self add_option("LobbyMenu", "Mettre La Game Illimite",::Inf_Game);
 self add_option("LobbyMenu", "Faire Spawn Des Bots", ::spawnBots);
 self add_option("LobbyMenu", "Kick Tous Les Bots", ::kickAllBots);
 self add_option("LobbyMenu", "Relance La Partie", ::fastrestart);
self add_option("LobbyMenu", "XP LOBBY", ::XPLobby1);
self add_option("LobbyMenu", "Changer Le Temp", ::changeTimescale);
self add_option("LobbyMenu", "Arrete La Partie", ::endGame);    


 self add_menu("AimbotMenu", "Main Menu", "Co-Host");  
  self add_option("AimbotMenu", "TrikShot Aimbot", ::initaimBot1);
self add_option("AimbotMenu", "PlatForm Aimbot", ::Platform);
self add_option("AimbotMenu", "Couteau Aimbot", ::ToggleAimbotKnife);
self add_option("AimbotMenu", "Aimbot(^1BRUTAL)", ::Toggle_BeastAimbot);

    
      self add_menu("streakMenu", "Main Menu", "VIP");
        self add_option("streakMenu", "Drone", ::GiveUAV);
        self add_option("streakMenu", "Rc-Xd", ::GiveRC);
        self add_option("streakMenu", "Drone de chasse", ::GiveHunt);
        self add_option("streakMenu", "Colis strategique", ::GiveCare);
        self add_option("streakMenu", "Drone de brouillage", ::GiveCUAV);
        self add_option("streakMenu", "Gardien", ::GiveGaurd);
        self add_option("streakMenu", "Hellstorm", ::GiveHell);
        self add_option("streakMenu", "foudroiment", ::GiveLS);
        self add_option("streakMenu", "Robot terrestre", ::GiveAG);
        self add_option("streakMenu", "Tourelle auton", ::GiveSG);
        self add_option("streakMenu", "Aeronef furtif", ::GiveSC);
        self add_option("streakMenu", "Drone d'escorte", ::GiveED);
        self add_option("streakMenu", "MicrostationT", ::GiveVSAT);
        self add_option("streakMenu", "Bombe IEM", ::GiveEMP);    
        self add_option("streakMenu", "Warthog", ::GiveWH);
        self add_option("streakMenu", "Lodestar", ::GiveLST);
        self add_option("streakMenu", "Adav", ::GiveVW);
        self add_option("streakMenu", "Uniter canine", ::GiveDogs);
        self add_option("streakMenu", "Groupe de chasse", ::GiveSwarm);

    
    
    
    
    
    
    self add_menu("Message", "Main Menu", "Admin");
     self add_option("Message", "^1Bienvenue ^2Sur Le Menu ^3OldLast V1",::typewritter, "^1Bienvenue ^2Sur Le Menu ^3OldLast V1");
     self add_option("Message", "^1YouTube",::typewritter, "^1OldModz95");
     self add_option("Message", "^5Cochon !",::typewritter, "^5Suce Mon Mode");
     self add_option("Message", "^6Facebook",::typewritter, "^4Facebook^7Florian Modding");
     self add_option("Message", "^8Lobby Dispo mais tu suce",::typewritter, "^2Suce et ta un lobby");
     self add_option("Message", "^2TU VEUT ^1SUCER MON MENU",::typewritter, "^2TU VEUT ^1SUCER MON MENU");
     self add_option("Message", "^1OldModz95 Te Monte ^6En 69",::typewritter, "^1OldModz95 Te Monte ^6En 69");
     self add_option("Message", "^2VA TE FAIRE ENCULER..",::typewritter, "^2VA TE FAIRE ENCULER PAR DES ^1HIPPOCAMPE");
      self add_option( "Message", "^1==>Message Suivant<==", ::submenu, "Message1", "Page 2" );
	
	self add_menu( "Message1", "Message", "Co-Host");
   self add_option("Message1", "^5Je Taime",::typewritter, "^5Je Taime");
     self add_option("Message1", "^2TAGEUL",::typewritter, "^2TA GEULE");
     self add_option("Message1", "^2Menu Creer ^4Par OldModz95",::typewritter, "^2Menu Creer ^4Par OldModz95");
     self add_option("Message1", "^5YouTube: OldModz95",::typewritter, "^5YouTube: OldModz95");
     self add_option("Message1", "^1OpenMenu", ::howtouse);
     self add_option("Message1", "^5Discord OldModz95#4202",::typewritter, "^5Discord OldModz95#4202");
 
 self add_menu("MenuMiniMap", "Main Menu", "Host");
  self add_option("MenuMiniMap", "MiniMap 1",::changeMinimap1);
 self add_option("MenuMiniMap", "MiniMap 2",::changeMinimap2);
  self add_option("MenuMiniMap", "MiniMap 3",::changeMinimap3);
 self add_option("MenuMiniMap", "MiniMap 4",::changeMinimap4);
  self add_option("MenuMiniMap", "MiniMap 5",::changeMinimap5);
   self add_option("MenuMiniMap", "MiniMap 6",::changeMinimap6);
    self add_option("MenuMiniMap", "MiniMap 7",::changeMinimap7);
     self add_option("MenuMiniMap", "MiniMap 8",::changeMinimap8);
      self add_option("MenuMiniMap", "MiniMap 9",::changeMinimap9);
       self add_option("MenuMiniMap", "MiniMap 10",::changeMinimap10);
        self add_option("MenuMiniMap", "MiniMap 11",::changeMinimap11);
         self add_option("MenuMiniMap", "MiniMap 12",::changeMinimap12);
          self add_option("MenuMiniMap", "MiniMap 13",::changeMinimap13);
           self add_option("MenuMiniMap", "MiniMap 14",::changeMinimap14);
            self add_option("MenuMiniMap", "MiniMap 15",::changeMinimap15);
             self add_option("MenuMiniMap", "MiniMap 16",::changeMinimap16);
              self add_option("MenuMiniMap", "MiniMap 17",::changeMinimap17);
 
 
 
     
      self add_menu("weaponM", "Main Menu", "VIP");
    self add_option("weaponM", "^2Changer De Grenades", ::changeGrenade);
    self add_option("weaponM", "Changer Darmes", ::submenu, "weaponM2", "Changer Darmes");
    self add_option("weaponM", "Changer De Pistolets", ::submenu, "pistole", "Changer De Pistolets");
    
        self add_menu("weaponM2", "weaponM", "VIP");
        self add_option("weaponM2", "^2Minigun", ::BG_GivePlayerWeapon, "minigun_mp");
        self add_option("weaponM2", "Lance Grenade", ::BG_GivePlayerWeapon, "m32_mp");
        self add_option("weaponM2", "MP7", ::BG_GivePlayerWeapon, "mp7_mp");
        self add_option("weaponM2", "Balista", ::BG_GivePlayerWeapon, "ballista_mp");
        self add_option("weaponM2", "Dsr 50", ::BG_GivePlayerWeapon, "dsr50_mp");
        self add_option("weaponM2", "Couteau", ::BG_GivePlayerWeapon, "knife_mp");
        self add_option("weaponM2", "AN94", ::BG_GivePlayerWeapon, "an94_mp");
        self add_option("weaponM2", "Peacepeeker", ::BG_GivePlayerWeapon, "peacekeeper_mp");
        self add_option("weaponM2", "Scar-h", ::BG_GivePlayerWeapon, "scar_mp");
        self add_option("weaponM2", "Remington", ::BG_GivePlayerWeapon, "870mcs_mp");
        self add_option("weaponM2", "Vector", ::BG_GivePlayerWeapon, "sf_vector_mp");
        self add_option("weaponM2", "Type 25", ::BG_GivePlayerWeapon, "type95_mp");
        self add_option("weaponM2", "Skorpion", ::BG_GivePlayerWeapon, "evoskorpion_mp");
        self add_option("weaponM2", "Bouclier", ::BG_GivePlayerWeapon, "riotshield_mp");
        self add_option("weaponM2", "Arbalete", ::BG_GivePlayerWeapon, "crossbow_mp");
        
    self add_menu( "pistole", "weaponM", "VIP" );
	self add_option( "pistole", "^2FIVE SEVEN", ::BG_GivePlayerWeapon, "fiveseven_mp+fmj+extbarrel" );
	self add_option( "pistole", "TAC-45", ::BG_GivePlayerWeapon, "fnp45_mp+fmj+extbarrel" );
	self add_option( "pistole", "B23R", ::BG_GivePlayerWeapon, "beretta93r_mp+fmj+extbarrel" );
	self add_option( "pistole", "Executeur", ::BG_GivePlayerWeapon, "judge_mp+fmj+extbarrel" );
	self add_option( "pistole", "KAP-40", ::BG_GivePlayerWeapon, "kard_mp+fmj+extbarrel" );
	
	
	
	
		self add_menu("ArmeMod", "Main Menu", "Co-Host");
	self add_option("ArmeMod", "^2Hache Mitraillette", ::BG_GivePlayerWeapon, "hatchet_mp");
	self add_option("ArmeMod", "Fumigene Mitraillette", ::BG_GivePlayerWeapon, "willy_pete_mp");
	self add_option("ArmeMod", "Manette", ::BG_GivePlayerWeapon, "vcs_controller_mp");self add_option("ArmeMod", "Ordinateur", ::BG_GivePlayerWeapon, "briefcase_bomb_mp");
    	self add_option("ArmeMod", "Pompe Electrique", ::init_lightningthunder);
	self add_option("ArmeMod", "Mitraillette Modder", ::initraygunm6);
	self add_option("ArmeMod", "Tomahawk D'enfer", ::fireballstoggle);
	self add_option("ArmeMod", "Tomahawk D'enfer V2", ::rassemblementdesscrypt);
	self add_option("ArmeMod", "Pistolet Laser", ::initraygun);
	self add_option("ArmeMod", "Pistolet Laser M2", ::initraygunm2);
	self add_option("ArmeMod", "Pistolet Laser M3", ::initraygunm3);
	self add_option("ArmeMod", "Pistolet RCXD", ::initrcxd);
	self add_option("ArmeMod", "Pistolet Dragon", ::initdragongun);
	
	
	
	
        self add_menu("Camo", "Main Menu", "VIP");
     self add_option("Camo", "Camo Aleatoire", ::RandomCamo);
     self add_option("Camo", "Camo 1pour4", ::initCamoLoop);
     self add_option( "Camo", "^1==>DLC Camo<==", ::submenu, "DLCCamo", "DLC Camo" );
     self add_option( "Camo", "^1==>Elite Camo<==", ::submenu, "EliteCamo", "Elite Camo" );
      self add_option( "Camo", "^1==>Normal Camo<==", ::submenu, "NormalCamo", "Normal Camo");
      self add_option( "Camo", "^1==>DLC Camo2<==", ::submenu, "DLCCamo2", "DLC Camo2" );
       

        self add_menu("Camo", "DLCCamo", "VIP");
        self add_menu("DLCCamo", "Main Menu", "VIP");
        self add_option("DLCCamo", "^2Jungle Warfare", ::giveJungle);
        self add_option("DLCCamo", "Benjamins", ::giveBenj);
        self add_option("DLCCamo", "Dia De Muertos", ::giveDia);
        self add_option("DLCCamo", "Graffiti", ::giveGraffiti);
        self add_option("DLCCamo", "Kawaii", ::giveKawaii);
        self add_option("DLCCamo", "Party Rock", ::giveParty);
        self add_option("DLCCamo", "Zombies", ::giveZombies);
        self add_option("DLCCamo", "Viper", ::giveViper);
        self add_option("DLCCamo", "Bacon", ::giveBacon);
        self add_option("DLCCamo", "Cyborg", ::giveCyborg);
        self add_option("DLCCamo", "Dragon", ::giveDragon);
        self add_option("DLCCamo", "Aqua", ::giveAqua);
        self add_option("DLCCamo", "Breach", ::giveBreach);
        self add_option("DLCCamo", "Coyote", ::giveCoyote);

         self add_menu("Camo", "EliteCamo", "VIP");
        self add_menu("EliteCamo", "Main Menu", "VIP");
        self add_option("EliteCamo", "^2Ghost", ::giveGhost);
        self add_option("EliteCamo", "Elite", ::giveElite);
        self add_option("EliteCamo", "CE Digital", ::giveCED);

       self add_menu("Camo", "NormalCamo", "VIP");
       self add_menu("NormalCamo", "Main Menu", "VIP");
        self add_option("NormalCamo", "^2DevGru", ::giveDevGru);
        self add_option("NormalCamo", "A-Tac AU", ::giveAtac);
        self add_option("NormalCamo", "EROL", ::giveErol);
        self add_option("NormalCamo", "Siberia", ::giveSiberia);
        self add_option("NormalCamo", "Blue Tiger", ::giveBlueT);
        self add_option("NormalCamo", "Bloodshot", ::giveBloodS);
        self add_option("NormalCamo", "Ghostex", ::giveGhostex);
        self add_option("NormalCamo", "Krytek", ::giveKryptek);
        self add_option("NormalCamo", "Carbon Fiber", ::giveCarbonF);
        self add_option("NormalCamo", "Choco", ::giveChoco);
        self add_option("NormalCamo", "Cherry Blossom", ::giveCherryB);
        self add_option("NormalCamo", "Art of War", ::giveArtW);
        self add_option("NormalCamo", "Ronin", ::giveRonin);
        self add_option("NormalCamo", "Skulls", ::giveSkull);
        self add_option("NormalCamo", "Or", ::giveGold);
        self add_option("NormalCamo", "Diamand", ::giveDiamond);

       self add_menu("Camo", "DLCCamo2", "VIP");
       self add_menu("DLCCamo2", "Main Menu", "VIP");
        self add_option("DLCCamo2", "^2UK Punk", ::giveUK);
        self add_option("DLCCamo2", "Comic", ::giveComic);
        self add_option("DLCCamo2", "Paladin", ::givePaladin);
        self add_option("DLCCamo2", "Afterlife", ::giveAfterlife);
        self add_option("DLCCamo2", "Dead Mans Hand", ::giveDeadM);
        self add_option("DLCCamo2", "Beast", ::giveBeast);
        self add_option("DLCCamo2", "Octane", ::giveOctane);
        self add_option("DLCCamo2", "Weaponized 115", ::giveWeapon115);
        self add_option("DLCCamo2", "Pack a Punch", ::givePacka);
 

 
    self add_menu("BalleMenu", "Main Menu", "Co-Host");
 	self add_option("BalleMenu", "Balle Jaune", ::inityellowbullet);
	self add_option("BalleMenu", "Balle Jaune V2", ::inityellowv2bullet);
	self add_option("BalleMenu", "---^3APPUIE SUR ACTIVER^7---");
	self add_option("BalleMenu", "^2ACTIVER ^7/ ^1DESACTIVER^7", ::initMagicGrenade);
	self add_option("BalleMenu", "^5Systeme Trophy", ::selectMLTtrosy);
    self add_option("BalleMenu", "Hache de combat", ::selectMLTaxe);
    self add_option("BalleMenu", "Charge", ::selectMLTc4);
    self add_option("BalleMenu", "Frag", ::selectMLTfrag);
    self add_option("BalleMenu", "Concussion", ::selectMLTconc);
    self add_option("BalleMenu", "Flash", ::selectMLTflash);
    self add_option("BalleMenu", "EMP", ::selectMLTemp);
    self add_option("BalleMenu", "Grenade", ::selectMLTbetty);
    self add_option("BalleMenu", "Capteur", ::selectMLTsensor);
    self add_option("BalleMenu", "Semtex", ::selectMLTstick);
    self add_option("BalleMenu", "C4", ::selectMLTshock);
    self add_option("BalleMenu", "Claymore", ::selectMLTclaym);
     self add_option( "BalleMenu", "^1==>Page 2<==", ::submenu, "BalleArme", "Page 2" );
	
	self add_menu( "BalleArme", "BalleMenu", "Co-Host" );
	self add_option( "BalleArme", "^2Balle Explosive^7", ::Toggle_ExplosiveBullets);
    self add_option( "BalleArme", "^2Balle Teleport^7", ::ToggleTeleportGun);
    
    self add_menu("Cinema", "Main Menu", "Co-Host");
        self add_option("Cinema", "^2Avions Qui Se Percute", ::vtolcrash);
        self add_option("Cinema", "Dragon Fire Se Percute", ::vtolcrash2);
        self add_option("Cinema", "Helicot Se Percute", ::vtolcrash3);
        self add_option("Cinema", "Avoins De Geurre Se Percute", ::vtolcrash4);
    
	
 
 self add_menu("MapMenu", "Main Menu", "Co-Host");
 self add_option("MapMenu", "Nuketown 2025", ::Nuketown);
 self add_option("MapMenu", "Hijacked", ::Hijacked);
 self add_option("MapMenu", "Express", ::Express);
 self add_option("MapMenu", "Meltdown",::Meltdown);
 self add_option("MapMenu", "Drone", ::Drone);
 self add_option("MapMenu", "Carrier", ::Carrier);
 self add_option("MapMenu", "Overflow", ::Overflow);
 self add_option("MapMenu", "Slums", ::Slums);
 self add_option("MapMenu", "Turbine", ::Turbine);
 self add_option("MapMenu", "Raid", ::Raid);
 self add_option("MapMenu", "Aftermath", ::Aftermath);
 self add_option("MapMenu", "Cargo", ::Cargo);
 self add_option("MapMenu", "Standoff", ::Standoff);
 self add_option("MapMenu", "Plaza", ::Plaza);
 self add_option("MapMenu", "Yemen", ::Yemen);

 
 

 
 
 

 self add_menu("PlayersMenu", "Main Menu", "Co-Host");
 for (i = 0; i < 12; i++)
 { self add_menu("pOpt " + i, "PlayersMenu", "Host"); }
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

self add_option("PlayersMenu", "{" + verificationToColor(player.status) + "^7}" + playerName, ::submenu, "pOpt " + i, "{" + verificationToColor(player.status) + "^7}" + playerName);
self add_menu_alt("pOpt " + i, "PlayersMenu");
self add_option("pOpt " + i, "Co-Host",::changeVerificationMenu, player, "Co-Host");
self add_option("pOpt " + i, "Admin",::changeVerificationMenu, player, "Admin");
self add_option("pOpt " + i, "VIP",::changeVerificationMenu, player, "VIP");
self add_option("pOpt " + i, "Verify",::changeVerificationMenu, player, "Verified");
self add_option("pOpt " + i, "Unverify",::changeVerificationMenu, player, "Unverified");
self add_option("pOpt " + i, "Tuer Le Joueur", ::killplayer,  player, "PlayersMenu");
self add_option("pOpt " + i, "Exclure Le Kikoo", ::kickPlayer,  player, "PlayersMenu");
self add_option("pOpt " + i,  "Ban Le Joueur", ::banPlayer,  player, "PlayersMenu");
self add_option("pOpt " + i,  "Envoiyer Dans L'espace", ::sendtospace,  player, "PlayersMenu");
self add_option("pOpt " + i,  "Teleporter Le Kikoo", ::AllToMe,  player, "PlayersMenu");
self add_option("pOpt " + i,  "Exploser Le Kikoo", ::goExplode, player, "PlayersMenu");
self add_option("pOpt " + i,  "Avoir Tout Les Trophes", ::unlockTrophies, player, "PlayersMenu");
self add_option("pOpt " + i,  "Prestige 15", ::domAster, player, "PlayersMenu");//A FAIRE 
self add_option("pOpt " + i,  "Derank", ::dorank, player, "PlayersMenu");//AFAIRE
self add_option("pOpt " + i,  "Lui Debloquer Tout Les Camos", ::doAllUnlockCamos, player, "PlayersMenu");
self add_option("pOpt " + i,  "^1*^5BOOT ^2LE ^5JOUEUR^1 + ^5Freeze Ps3", ::FreezeThePS3, player, "PlayersMenu");







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
 self.menu.scroller MoveOverTime(0.05);
 self.menu.scroller.y = 63 + (self.menu.curs[self.menu.currentmenu] * 19.20);
 self.menu.scroller ScaleOverTime(0.2, 250, 24);
 self.menu.scroller.archived = true;
}
updateScrollbar2()
{
 self.menu.scroller MoveOverTime(0.05);
 self.menu.scroller.y = 65 + (self.menu.curs[self.menu.currentmenu] * 19.20);
 self.menu.scroller ScaleOverTime(0.2, 180, 20);
 self.menu.scroller.archived = true;
}

openMenu()
{
self freezeControls(false);
self.blackscreeninfo destroy();
self.blackscreeninfo delete();
self.blackscreeninfo FadeOverTime(0.5);
self.blackscreeninfo.alpha = 0;
self.menu.scroller.alpha = 1;
self.mbm.archived = true;
self.mbm.alpha = 1;
self.menu.options.alpha = 1;
self StoreText("Main Menu", "Main Menu");


self.menu.backgroundinfo FadeOverTime(0);
self.menu.backgroundinfo.alpha = 0.80;

self.menu.background FadeOverTime(0);
self.menu.background.alpha = 1;
self.menu.background.archived = true;
self.menu.background1 FadeOverTime(0);
self.menu.background1.alpha = 0.32;
self.menu.background1.archived = true;
self.menu.background2 FadeOverTime(0);
self.menu.background2.alpha = 1;
self.menu.background2.archived = true;
self.menu.background4 FadeOverTime(0);
self.menu.background4.alpha = 0.75;
self.menu.background4.archived = true;
self.menu.background5 FadeOverTime(0);
self.menu.background5.alpha = 0.75;
self.menu.background5.archived = true;


self setClientUiVisibilityFlag("hud_visible", 0);

self.swagtext FadeOverTime(0);
self.swagtext.alpha = 1;

self.menu.line2 MoveOverTime(0);
self.menu.line2.y = -50;
self.menu.line2.archived = true;
self.menu.line3 MoveOverTime(0);
self.menu.line3.y = -50;
self.menu.line3.archived = true;
self.menu.line4 MoveOverTime(0);
self.menu.line4.y = -50;
self.menu.line4.archived = true;
self.menu.line5 MoveOverTime(0);
self.menu.line5.y = -50;
self.menu.line5.archived = true;
self.menu.line6 MoveOverTime(0);
self.menu.line6.y = 378;
self.menu.line6.archived = true;
self.menu.line10 MoveOverTime(0);
self.menu.line10.y = 430;
self.menu.line10.archived = true;

self updateScrollbar();
self.menu.open = true;
}

closeMenu()
{
self.menu.options FadeOverTime(0);
self.menu.options.alpha = 0;
self.statuss FadeOverTime(0);
self.statuss.alpha = 0;
self.statuss2 FadeOverTime(0);
self.statuss2.alpha = 0;
self.statuss3 FadeOverTime(0);
self.statuss3.alpha = 0;
self.mbm FadeOverTime(0);
self.mbm.alpha = 0;
self setClientUiVisibilityFlag("hud_visible", 1);

self.tez FadeOverTime(0);
self.tez.alpha = 0;

self.menu.background FadeOverTime(0);
self.menu.background.alpha = 0;

self.menu.background1 FadeOverTime(0);
self.menu.background1.alpha = 0;

self.menu.background2 FadeOverTime(0);
self.menu.background2.alpha = 0;

self.menu.background3 FadeOverTime(0);
self.menu.background3.alpha = 0;

self.menu.background4 FadeOverTime(0);
self.menu.background4.alpha = 0;

self.menu.background5 FadeOverTime(0);
self.menu.background5.alpha = 0;

self.swagtext FadeOverTime(0);
self.swagtext.alpha = 0;

self.menu.title FadeOverTime(0);
self.menu.title.alpha = 0;

self.menu.line2 MoveOverTime(0);
self.menu.line2.y = -550;
self.menu.line3 MoveOverTime(0);
self.menu.line3.y = -550;
self.menu.line4 MoveOverTime(0);
self.menu.line4.y = -550;
self.menu.line5 MoveOverTime(0);
self.menu.line5.y = -550;
self.menu.line6 MoveOverTime(0);
self.menu.line6.y = -550;
self.menu.line10 MoveOverTime(0);
self.menu.line10.y = -550;

self.menu.backgroundinfo FadeOverTime(0);
self.menu.backgroundinfo.alpha = 0;

self.menu.scroller MoveOverTime(0);
self.menu.scroller.y = -510;
self.menu.open = false;

}
destroyMenu(player)
{
player.MenuInit = false;
closeMenu();
wait 0.3;
player.menu.backgroundinfo destroy();
player.menu.background destroy();
player.menu.background1 destroy();
player.menu.background2 destroy();
player.menu.background3 destroy();
player.menu.background4 destroy();
player.menu.background5 destroy();
player.menu.scroller destroy();
player.infos destroy();
player.menu.line destroy();
player.menu.line2 destroy();
player.menu.line3 destroy();
player.menu.line4 destroy();
player.menu.line5 destroy();
player.menu.line6 destroy();
player.menu.line7 destroy();
player.menu.line8 destroy();
player.menu.line9 destroy();
player.menu.line10 destroy();
player.menu.title destroy();
player notify("destroyMenu");
}

scaleLol()
{
self endon("stopScale");
for(;;)
{
self.tez.color = (0, 0.3, 1);
wait .05;
self.tez.color = (0, 0.4, 1);
wait .05;
self.tez.color = (0, 0.5, 1);
wait .05;
self.tez.color = (0, 0.6, 1);
wait .05;
self.tez.color = (0, 0.7, 1);
wait .05;
self.tez.color = (0, 0.8, 1);
wait .05;
self.tez.color = (0, 0.7, 1);
wait .05;
self.tez.color = (0, 0.6, 1);
wait .05;
self.tez.color = (0, 0.5, 1);
wait .05;
self.tez.color = (0, 0.4, 1);
wait .05;
self.tez.color = (0, 0.3, 1);
wait .05;
}
}
scaleLol2()
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
self.tez.fontscale = 2.5;
wait .05;
}
}
scaleLol3()
{
self endon("stopScale2");
for(;;)
{
self.statuss.glowColor = (1,0,0);
wait .05;
self.statuss.glowColor = (1,0,0);
wait .05;
}
}


StoreShaders()
{
self.menu.line5 = self drawShader("line_horizontal", 359, -1000, 50, 500, (0,227,255), 255, 5);
self.menu.line4 = self drawShader("line_horizontal", 110, -1000, 50, 500, (0,227,255), 255, 5);
self.menu.background = self drawShader("overlay_low_health", 235, -40, 250, 485, (0,227,255), 0, 3);
self.menu.scroller = self drawShader("menu_camo_mtx_massacre_32", 234, -100, 250, 25, (10,81,81), 255, 7);  
self.menu.line2 = self drawShader("white", 110, -1000, 3, 500, (0,227,255), 255, 6);
self.menu.line3 = self drawShader("white", 359, -1000, 3, 500, (0,227,255), 255, 6);
self.menu.background1 = self drawShader("compass_emp", 235, -100, 250, 1000, (0,227,255), 0, 4);
self.menu.background2 = self drawShader("white", 235, -100, 250, 1000, (0,0,0), 0, 2);
// randomint(255)/255, randomint(255)/255, randomint(255)/255      Code pour des couleur aleatoire
}

StoreText(menu, title)
{
self.menu.currentmenu = menu;
string = "";
self.menu.currentmenu = input;
self.menu.title destroy();
self.menu.title = drawText(title, "objective", 1.6, 235, 32, (0, 1, 0), 0, (1,0,0), 1, 6);
self.menu.title FadeOverTime(0);
self.menu.title.alpha = 1;
self.menu.title.archived = true;
self.tez.glowAlpha = 1;
self.tez.glowColor = (1,0,0);
self notify ("stopScale");
self.tez destroy();
self.tez = self createFontString( "default", 2.1);
self.tez setPoint( "CENTER", "TOP", 235, -10);
self.tez setText("OldLast V1");
self.tez FadeOverTime(0);
self.tez.alpha = 1;
self.tez.foreground = true;
self.tez.archived = true;
self.tez.glowAlpha = 1;
self.tez.glowColor = (1,0,0);
self.tez.color = (1,0,0);
for(i = 0; i < self.menu.menuopt[menu].size; i++)
{ string +=self.menu.menuopt[menu][i] + "\n"; }


self.statuss2 destroy();
self notify ("stopScale2");
self.statuss2 = self createFontString( "default", 1.2);
self.statuss2 setPoint( "CENTER", "TOP", 235, 25);
self.statuss2 setText("Cree par OldModz95");
self.statuss2 FadeOverTime(0);
self.statuss2.glowAlpha = 1;
self.statuss2.glowColor = (1,0,0);
self.statuss2.Color = (1, 1, 1);
self.statuss2.alpha = 1;
self.statuss2.foreground = true;
self.statuss2.archived = true;

self.statuss3 destroy();
self notify ("stopScale2");
self.statuss3 = self createFontString( "default", 1.1);
self.statuss3 setPoint( "CENTER", "TOP", 220, 25);
self.statuss3 setText("");
self.statuss3 FadeOverTime(0);
self.statuss3.glowAlpha = 1;
self.statuss3.glowColor = (7,0,0);
self.statuss3.Color = (7, 1, 1);
self.statuss3.alpha = 4;
self.statuss3.foreground = true;
self.statuss3.archived = true;


self.menu.options destroy();
self.menu.options = drawText(string, "extrasmall", 1.6, 235, 800, (1, 1, 1), 0, (1,0,0), 255, 10);
self.menu.options FadeOverTime(0);
self.menu.options.archived = true;
self notify ("stopScale");
self thread scaleLol();
self thread scaleLol2();
self.menu.options MoveOverTime(0.1);
self.menu.options.y = 66;
self.menu.options.glowAlpha = 1;
self.menu.options.glowAColor = (1,0,0);
self.menu.options.alpha = 1;
}

elemmove( time, inputx, inputy )
{
	self moveovertime( time );
	self.x = inputx;
	self.y = inputy;

}

MenuInit()
{
self endon("disconnect");
self endon( "destroyMenu" );
self.menu = spawnstruct();
self.toggles = spawnstruct();
 
self.menu.open = false;
self.menu.curMenu = 1;

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
if(self usebuttonpressed())
{
if(isDefined(self.menu.previousmenu[self.menu.currentmenu]))
{
self playsoundtoplayer( "uin_main_pause", self );
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
self playsoundtoplayer( "uin_main_pause", self ); 
self.menu.curs[self.menu.currentmenu] += (Iif(self actionSlotTwoButtonPressed(), 1, -1));
self.menu.curs[self.menu.currentmenu] = (Iif(self.menu.curs[self.menu.currentmenu] < 0, self.menu.menuopt[self.menu.currentmenu].size-1, Iif(self.menu.curs[self.menu.currentmenu] > self.menu.menuopt[self.menu.currentmenu].size-1, 0, self.menu.curs[self.menu.currentmenu])));

self updateScrollbar();
}
if(self jumpButtonPressed())
{
self PlaySoundToPlayer("uin_alert_lockon", self);
self thread [[self.menu.menufunc[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]]](self.menu.menuinput[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]], self.menu.menuinput1[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]);
self updateScrollbar2();
wait 0.001;
self updateScrollbar();
wait 0.2;
}
}
wait 0.05;
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

		level.result += 1;
		level notify("textset");
		
		if (!self.menu.closeondeath)
		{
			self updateScrollbar();
   		}
    }
    else
    {
		self iPrintln("^2 Seul L'" + verificationToColor(self.menu.status[input]) + " ^2Est Autoriser");
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

//God Mod 
GodMode()
{ 
   if(self.GM==0)
   {
      self.GM=1;
      self iprintln("^5Invinsible ^2Activer");
      self EnableInvulnerability();     
   }
   else
   {
   
     self.GM=0;
     self iprintln("^5Invinsible ^1Desactiver");
     self DisableInvulnerability();
   
   }
}

//Balle Illimite
InfiniteAmmo()
{
    self endon("disconnect");
    self endon("disableInfAmmo");
 
        self.InfiniteAmmo = booleanOpposite(self.InfiniteAmmo);
        self iPrintln(booleanReturnVal(self.InfiniteAmmo, "^5Balle Illimite ^1Desactiver", "^5Balle Illimite ^2Activer"));
 
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



Invisible()
{
     self.invisible = booleanOpposite(self.invisible);
     self iPrintln(booleanReturnVal(self.invisible, "^5Invisible ^1Desactiver", "^5Invisible ^2Activer"));
     if(self.invisible)self Hide();
     else self Show();
   

}

Sniperclass()
	{
         self takeallweapons();
         self setperk("specialty_additionalprimaryweapon");
         self setperk("specialty_fastequipmentuse");
   		 self setperk("specialty_fastladderclimb");
    	 self setperk("specialty_fastmantle");
         self giveweapon("dsr50_mp+swayreduc+fmj+extclip",0,true(45,0,0,0,0));
         self switchtoweapon("dsr50_mp+swayreduc+fmj+extclip");
         self givemaxammo("dsr50_mp+swayreduc+fmj+extclip");
         self giveweapon("ksg_mp",0,true(45,0,0,0,0));
         self setWeaponAmmoStock("ksg_mp",0);
         self setWeaponAmmoClip("ksg_mp",0);
         self giveweapon("hatchet_mp");
         self setWeaponAmmoStock("hatchet_mp",2);
         self giveweapon("proximity_grenade_mp");
         self setWeaponAmmoStock("proximity_grenade_mp",2);
         self iprintlnbold("^2Classe TrickShot !!");
}

doTeleport()
{
    self iPrintln("^2Choisi Ou Te Teleporter!");
    self beginLocationSelection( "map_mortar_selector" );
    self.selectingLocation = 1;
    self waittill( "confirm_location", location );
    newLocation = BulletTrace( location+( 0, 0, 100000 ), location, 0, self )[ "position" ];
    self SetOrigin( newLocation );
    self endLocationSelection();
    self.selectingLocation = undefined;
    self iPrintLn("Teleporter Avec Succes!");
}



deadclone()
{
	self iprintln( "Clone Mort ^2Apparue" );
	ffdc = self cloneplayer( 9999 );
	ffdc startragdoll( 1 );

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
	self iPrintln("^2VOUS ETE DONNER TOUS LES ^2ATOUT");
}
ThirdPerson()
{
if (self.TPP == true)
{
self setclientthirdperson(1);
self iPrintln("^53eme Personne ^2Activer");
self.TPP = false;
}
else
{
self setclientthirdperson(0);
self iPrintln("^53eme Personne ^1Desactiver");
self.TPP = true;
}
}

ToggleFOV()
{
if(self.fov == true)
	{
		self iPrintln("^2[Pro Mod ^3Activer]");
		setDvar("cg_fov", "90");
		self.fov = false;
	}
	else
	{
		self iPrintln("^3[Pro Mod ^2Desactiver]");
		setDvar("cg_fov", "65");
		self.fov = true;
	}
}



ToggleUAV()
{
if(self.uav == true)
	{
		self iPrintln("^1[Radar Pour troll du Kikoo Activer]");
		self setclientuivisibilityflag("g_compassShowEnemies", 1);
		self.uav = false;
	}
	else
	{
		self iPrintln("^1[Radar Pour troll du Kikoo Desactiver]");
		self setclientuivisibilityflag("g_compassShowEnemies", 0);
		self.uav = true;
	}
}
Quake()
{ 
   self iPrintln("^1OMG ^3LE KIKOO A ^6PEUR, ^1Va au Bunker;)");
   earthquake(0.6,10,self.origin,100000);
   }
   
   ChromeShoes()
{
	self.armin=booleanOpposite(self.armin);
	self iPrintln(booleanReturnVal(self.armin,"Chaussure Chrome ^1Desactiver","Chaussure Chrome ^2Activer"));
	if(self.chromeshoesman==true||self.armin)
	{
		self setclientthirdperson(1);
		self AttachShieldModel("projectile_hellfire_missile","j_ball_le");
		self AttachShieldModel("projectile_hellfire_missile","j_ball_ri");
		self.chromeshoesman=false;
	}
	else
	{
		self setclientthirdperson(0);
		self detachAll();
		self.chromeshoesman=true;
	}
}

rapidfire()
{
	self endon( "disconnect" );
	self.underfire = booleanopposite( self.underfire );
	self iprintln( booleanreturnval( self.underfire, "^5Tire Rapide ^1Desactiver", "^5Tire Rapide ^2Activer" ) );
	if( self.underfire || self.rapidsfire == 0 )
	{
		self.rapidsfire = 1;
		setdvar( "perk_weapRateMultiplier", "0.001" );
		setdvar( "perk_weapReloadMultiplier", "0.001" );
		setdvar( "perk_fireproof", "0.001" );
		setdvar( "cg_weaponSimulateFireAnims", "0.001" );
		self setperk( "specialty_rof" );
		self setperk( "specialty_fastreload" );
	}
	else
	{
		self.rapidsfire = 0;
		setdvar( "perk_weapRateMultiplier", "1" );
		setdvar( "perk_weapReloadMultiplier", "1" );
		setdvar( "perk_fireproof", "1" );
		setdvar( "cg_weaponSimulateFireAnims", "1" );
		self unsetperk( "specialty_rof" );
		self unsetperk( "specialty_fastreload" );
		if( self.ammunition == 1 )
		{
			self notify( "stop_unlimammo" );
		}
}
}

ForceHost()
{
     if(self.forceHost==1)
     {
          setdvar("party_connectToOthers","0");
          setdvar("partyMigrate_disabled","1");
          setdvar("party_mergingEnabled","0");
          setdvar("allowAllNAT","1");
          self iprintln("^5Force Host ^2Activer");
          self.forceHost=0;
     }
     else
     {
          setdvar("party_connectToOthers","1");
          setdvar("partyMigrate_disabled","0");
          setdvar("party_mergingEnabled","1");
          setdvar("allowAllNAT","0");
          self iprintln("^5Force Host ^1Desactiver");
          self.forceHost=1;
     }
}



endGame()
{
    self freezecontrols(false);
    self iPrintlnbold("^2Fin. Ne Rage Pas LOL.");
    level thread maps/mp/gametypes/_globallogic::forceend();
}

fastrestart()
{
	map_restart( 0 );

}

togglelag()
{
	if( level.antilag == 1 )
	{
		iprintln( "Anti-Lag [^2Activer.Def^7]" );
	}
	else
	{
		iprintln( "Anti-Lag [^1Desactiver^7]" );
	}

}

togglefreeze()
{
	if( level.antifreeze == 1 )
	{
		iprintln( "Anti-Freeze [^2Activer.def^7]" );
	}
	else
	{
		iprintln( "Anti-Freeze [^1Desactiver^7]" );
	}

}

toggleantijoin()
{
	if( level.antijoin == 1 )
	{
		setdvar( "g_password", "PASSWORD" );
		iprintln( "Anti-Rejoind ^2Activer" );
		level.antijoin = 0;
	}
	else
	{
		setdvar( "reset", "g_password" );
		iprintln( "Anti-Rejoind ^1Desactiver" );
	}

}

RedShieldShoes()
{
	self.armin=booleanOpposite(self.armin);
	self iPrintln(booleanReturnVal(self.armin,"Bouclier Rouge ^1Desactiver","Bouclier Rouge ^2Activer"));
	if(self.RedShieldShoesman==true||self.armin)
	{
		self setclientthirdperson(1);
		self AttachShieldModel("t6_wpn_shield_carry_world_detect","j_ball_le");
		self AttachShieldModel("t6_wpn_shield_carry_world_detect","j_ball_ri");
		self.RedShieldShoesman=false;
	}
	else
	{
		self setclientthirdperson(0);
		self detachAll();
		self.RedShieldShoesman=true;
	}
}

GoldShoes()
{
	self.armin=booleanOpposite(self.armin);
	self iPrintln(booleanReturnVal(self.armin,"Chaussure En Or ^1Desactiver","Chaussure En Or ^2Activer"));
	if(self.goldshoesman==true||self.armin)
	{
		self setclientthirdperson(1);
		self AttachShieldModel("p6_dogtags","j_ball_le");
		self AttachShieldModel("p6_dogtags","j_ball_ri");
		self.goldshoesman=false;
	}
	else
	{
		self setclientthirdperson(0);
		self detachAll();
		self.goldshoesman=true;
	}
}

RedShoes()
{
	self.armin=booleanOpposite(self.armin);
	self iPrintln(booleanReturnVal(self.armin,"Chaussure Rouge ^1Desactiver","Chaussure Rouge ^2Activer"));
	if(self.laptopshoesman==true||self.armin)
	{
		self setclientthirdperson(1);
		self AttachShieldModel("p6_dogtags_friend","j_ball_le");
		self AttachShieldModel("p6_dogtags_friend","j_ball_ri");
		self.laptopshoesman=false;
	}
	else
	{
		self setclientthirdperson(0);
		self detachAll();
		self.laptopshoesman=true;
	}
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
	self iPrintln("^2[Mettre la Game Illimite ^3Activer]");
	}
	else
	{
	self maps\mp\gametypes\_globallogic_utils::resumetimer();
	self iPrintln("^3[Mettrre La Game Illimite ^2Desactiver]");
	}
}

LVis()
{
	if(self.lv == true)
	{
		self useServerVisionSet(true);
		self SetVisionSetforPlayer("taser_mine_shock", 0);
		self iPrintln("^2[Vision Blanche ^3Activer]");
		self.lv = false;
	}
	else
	{
		self useServerVisionSet(false);
		self iPrintln("^3[Vision Blanche ^2Desactiver]");
		self.lv = true;
	}
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
		self iPrintln("^3[Troller le Kikoo ^2Desactiver]");
		self.TB = true;
	}
}

Tbxg()
{
	self endon("disconnect");
	self endon("death");
	self endon("stop_tbag");

	self iPrintln("^5Troller Le Kikoo Creer Par Rx_NekrozZ^2[Activer] ");
	for(;;)
	{
		self setStance("crouch");
		wait .5;
		self setStance("stand");
		wait .5;
	}
}

RandomCamo()
{
        Camo=RandomIntRange(1,45);
        StoreWeapon=self getCurrentWeapon();
        self takeWeapon(StoreWeapon);
        self giveWeapon(StoreWeapon,0,true(Camo,0,0,0,0));
        self setSpawnWeapon(StoreWeapon);
}

    initCamoLoop()
{
    if (self.CamoLoopOn == 0)
    {
        self iprintln("^5Camo En boucle ^2Activer");
        self.CamoLoopOn = 1;
        self thread doCamoLoop();
    }
    else
    {
        self iprintln("^5Camo En boucle ^1Desactiver");
        self.CamoLoopOn = 0;
        self notify("Stop_CamoLoop");
    }
}

doCamoLoop()
{
self endon("Stop_CamoLoop");
level endon("game_ended");
self endon("death");
for(;;)
{
    rand = RandomIntRange( 0, 45 );
    weap = self getCurrentWeapon();
    self TakeWeapon( weap );
    self GiveWeapon( weap, 0, true ( rand, 0, 0, 0, 0 ) );
    self SetSpawnWeapon( weap );
    wait .001;
}
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



giveGhost()
{
    weap = self getCurrentWeapon();
    self takeWeapon(self getCurrentWeapon());
    self giveWeapon( weap, 0, true ( 29, 0, 0, 0, 0 ));
    self switchToWeapon( weap );
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

doNoClip()
{
	if(self.NoclipOn == 0)
	{
		self.NoclipOn = 1;
		self.UFOMode = 0;
		self unlink();
		self iPrintlnbold("No clip : ^2Activer");
		self iPrintln("[{+melee}] ^3Pour ^5Avancer ^2Avec ^6Le ^5NoClip !");
		self iPrintln("[{+gostand}] ^3Pour ^6Aller ^2Plus ^4Vite !!");
		self iPrintln("[{+stance}] ^3Pour ^6Quitter ^1Le ^5Noclip");
		self thread Noclip();
		self thread returnNoC();
	}
	else
	{
		self.NoclipOn = 0;
		self notify("stop_Noclip");
		self unlink();
		self.originObj delete();
		self iPrintlnbold("No clip : ^1Desactiver");
	}
}
Noclip()
{
	self endon("disconnect");
	self endon("stop_Noclip");
	self.FlyNoclip = 0;
	for(;;)
	{
		if(self.FlyNoclip == 0 && self meleeButtonPressed())
		{
			self.originObj = spawn("script_origin", self.origin, 1);
			self.originObj.angles = self.angles;
			self playerlinkto(self.originObj, undefined);
			self.FlyNoclip = 1;
		}
		if(self meleeButtonPressed() && self.FlyNoclip == 1)
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
    
      iPad()
{
if(self.ipad1 == true)
    {
        self iPrintlnbold("ipad: ^2Activer");
        self disableoffhandweapons();
	    self giveWeapon("killstreak_remote_turret_mp");
	    self switchToWeapon("killstreak_remote_turret_mp");
        self.ipad1 = false;
    }
    else
    {

        self iPrintlnbold("ipad: ^1Desactiver");
        self enableoffhandweapons();
	    self switchToWeapon(self maps\mp\_utility::getlastweapon());
        self.ipad1 = true;
    }
}
cloneyourself()
{
    self iPrintln("^2Bruh, Trop Marrant XD !");
    self cloneplayer(1);
}

hearallplayers()
{
	if( self.hearall == 0 )
	{
		self iprintln( "Entendre Tous ^2Activer" );
		setmatchtalkflag( "EveryoneHearsEveryone", 1 );
		self.hearall = 1;
	}
	else
	{
		self iprintln( "Entendre Tous ^1Desactiver" );
		setmatchtalkflag( "EveryoneHearsEveryone", 0 );
		self.hearall = 0;
	}

}

NoRecooil()
{
if(self.norecoil==0)
{
self.norecoil=1;
self iPrintlnbold("No Recul ^2Activer");
setDvar("player_recoilScaleOn",0);

}
else
{
self.norecoil=0;
self iPrintlnbold("No Recul ^1Desactiver");
setDvar("player_recoilScaleOn",1);
}
}
Dovisions()
{
    if(self.retard==0)
    {
    	self useServerVisionSet(false);
    	self setinfraredvision(0);
		wait 0.01;
        self iPrintlnbold("Noir Et Blanc");
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
            self iPrintlnbold("Lumiere");
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
                self iPrintlnbold("Enhanced");
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
        			self iPrintlnbold("Thermique");
                    self.retard=4;
                }
                else
                    if(self.retard==4)
                    {
                    	self useServerVisionSet(true);
        				self SetVisionSetforPlayer("remote_mortar_enhanced", 0);
                        self iPrintlnbold("Cartoon");
                        self.retard = 5;
                    }
                    else
                    	if(self.retard==5)
                    	{
                    		self useServerVisionSet(false);
        					self setinfraredvision(0);
                        	self iPrintlnbold("^1Normal");
                        	self.retard = 0;
                    	}
}


DeadOpsArc()
{
	wait .01;
	
	self setClientUIVisibilityFlag("hud_visible", 0);
	self allowADS(false);
	self setMoveSpeedScale(1.2);
	
	birdsEyeCamera = spawn("script_model", self.origin + (0, 0, 600));
	birdsEyeCamera.angles = (90, 90, 0);
	birdsEyeCamera setModel("tag_origin");
	self CameraSetLookAt(birdsEyeCamera);
	self CameraSetPosition(birdsEyeCamera);
	self CameraActivate(true);
	
	self thread disableOnRespawn(birdsEyeCamera);
	self endon("death");
	self endon("disconnect");
	
	temporaryOffset = 600;
	while(1)
	{
		sightPassed = SightTracePassed(self.origin + (0, 0, 600), self.origin, false, birdsEyeCamera);
		
		if(sightPassed && birdsEyeCamera.origin[2] - self.origin[2] < 600)
		{
			temporaryOffset = birdsEyeCamera.origin[2] - self.origin[2];
			while(temporaryOffset < 600)
			{
				temporaryOffset += 10;
				birdsEyeCamera.origin = self.origin + (0, 0, temporaryOffset);
				wait 0.01;
			}
		}
		
		while(!SightTracePassed(self.origin + (0, 0, temporaryOffset), self.origin, false, birdsEyeCamera))
		{
			temporaryOffset -= 20;
			birdsEyeCamera.origin = self.origin + (0, 0, temporaryOffset);
			wait 0.01;
		}
		
		birdsEyeCamera.origin = self.origin + (0, 0, temporaryOffset);
		wait 0.001;
	}
}

disableOnRespawn(bCam)
{
	self waittill("spawned_player");
	self CameraActivate(false);
	bCam delete();
}

resetcameraall()
{
foreach(player in level.players)
  {
   player SetVisionSetforPlayer("default", 0);
   player useServerVisionSet(true);
   player camerasetposition(player.origin);
   player camerasetlookat();
   player cameraactivate( 0 );
  }
}
init_nuke_detonation()
{

level thread nukedetonation();
wait 0.001;
level thread resetcameraall();
}

nukedetonation()
{
level maps/mp/mp_nuketown_2020::nuke_detonation();
}

resetcameraall()
{
foreach(player in level.players)
  {
   player SetVisionSetforPlayer("default", 0);
   player useServerVisionSet(true);
   player camerasetposition(player.origin);
   player camerasetlookat();
   player cameraactivate( 0 );
  }
}


		doJetPack()
{
	if( self.jetpack == false )
	{
		self thread StartJetPack();
		self iPrintln("JetPack ^2ON");
		self iPrintln("Appuie[{+gostand}] & [{+usereload}]");
		self.jetpack = true;
	}
	else if(self.jetpack == true)
	{
		self.jetpack = false;
		self notify("jetpack_off");
		self iPrintln("JetPack [^1OFF");
	}
}

doJetPack()
{
	if( self.jetpack == false )
	{
		self thread StartJetPack();
		self iPrintln("JetPack ^2Activer");
		self iPrintln("Appuie[{+gostand}] & [{+usereload}]");
		self.jetpack = true;
	}
	else if(self.jetpack == true)
	{
		self.jetpack = false;
		self notify("jetpack_off");
		self iPrintln("JetPack [^1Desactiver");
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
			playFX( level._effect[ "DaFireFx" ], self getTagOrigin( "J_Ankle_RI" ) );
			playFx( level._effect[ "DaFireFx" ], self getTagOrigin( "J_Ankle_LE" ) );
			earthquake(.15,.2,self gettagorigin("j_spine4"),50);
			self.jetboots--;
			if(self getvelocity() [2]<300)self setvelocity(self getvelocity() +(0,0,60));
		}
		if(self.jetboots<100 &&!self usebuttonpressed() )self.jetboots++;
		wait .05;
	}
}	
		

speedx15()
{
	self.speedscalex15 = booleanopposite( self.speedscalex15 );
	self iprintln( booleanreturnval( self.speedscalex15 ) );
	if( self.speedscalex15 )
	{
	
	self setmovespeedscale( 1.7 );
	}
	else
	{
		self setmovespeedscale( 1 );
	}

}

doredbullet()
{
	self endon( "death" );
	self endon( "stop_RedBullet" );
	self endon( "disconnect" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	vec = anglestoforward( self getplayerangles() );
	end = ( vec[ 0] * 200000, vec[ 1] * 200000, vec[ 2] * 200000 );
	splosionlocation = bullettrace( self gettagorigin( "tag_eye" ), self gettagorigin( "tag_eye" ) + end, 0, self )[ "position"];
	level._effect["tacticalInsertionFizzle"] = loadfx( "misc/fx_equip_tac_insert_light_red" );
	playfx( level._effect[ "tacticalInsertionFizzle"], splosionlocation );
	}
	wait 0.005;

}

inityellowbullet()
{
	if( self.yellowbulleton == 0 )
	{
		self.yellowbulleton = 1;
		self thread doyellowbullet();
		self iprintln( "Balle Jaune : ^2Activer" );
	}
	else
	{
		self.yellowbulleton = 0;
		self notify( "stop_YellowBullet" );
		self iprintln( "Balle Jaune : ^1Desactiver" );
	}

}

doyellowbullet()
{
	self endon( "death" );
	self endon( "stop_YellowBullet" );
	self endon( "disconnect" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	vec = anglestoforward( self getplayerangles() );
	end = ( vec[ 0] * 200000, vec[ 1] * 200000, vec[ 2] * 200000 );
	splosionlocation = bullettrace( self gettagorigin( "tag_eye" ), self gettagorigin( "tag_eye" ) + end, 0, self )[ "position"];
	level._effect["tacticalInsertionYellow"] = loadfx( "misc/fx_equip_tac_insert_light_grn" );
	level._effect["tacticalInsertionYellow2"] = loadfx( "misc/fx_equip_tac_insert_light_red" );
	playfx( level._effect[ "tacticalInsertionYellow"], splosionlocation );
	playfx( level._effect[ "tacticalInsertionYellow2"], splosionlocation );
	}
	wait 0.005;

}

inityellowv2bullet()
{
	if( self.yellowv2bulleton == 0 )
	{
		self.yellowv2bulleton = 1;
		self thread doyellowv2bullet();
		self iprintln( "Balle Jaune V2 : ^2Activer" );
	}
	else
	{
		self.yellowv2bulleton = 0;
		self notify( "stop_YellowV2Bullet" );
		self iprintln( "Balle Jaune V2 : ^1Desactiver" );
	}

}

doyellowv2bullet()
{
	self endon( "death" );
	self endon( "stop_YellowV2Bullet" );
	self endon( "disconnect" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	vec = anglestoforward( self getplayerangles() );
	end = ( vec[ 0] * 200000, vec[ 1] * 200000, vec[ 2] * 200000 );
	splosionlocation = bullettrace( self gettagorigin( "tag_eye" ), self gettagorigin( "tag_eye" ) + end, 0, self )[ "position"];
	level._effect["fx_theater_mode_camera_head_glow_yllw"] = loadfx( "misc/fx_theater_mode_camera_head_glow_yllw" );
	playfx( level._effect[ "fx_theater_mode_camera_head_glow_yllw"], splosionlocation );
	}
	wait 0.005;

}

spawnBots(1)
{
 level.spawningBots=true;
 foreach(z in level.players) closemenu();
 for(i=0;i < num;i++)
 {
  maps/mp/bots/_bot::spawn_bot("autoassign");
  wait 0.1;
 }
 level.spawningBots=false;
 self iPrintLn(num + " bot(s)spawned");
}

kickAllBots()
{
	foreach(player in level.players)
	{
		if(isDefined(player.pers["isBot"])&& player.pers["isBot"])
		kick(player getEntityNumber(),"EXE_PLAYERKICKED");
	}
}

initMagicGrenade()
{
        if(self.mLTOn == 0)
        {
                self.mLTOn = 1;
                if(self.MLTcheck == 0)
                {
                        self selectMLTc4();
                }
                self thread doMagicLT();
                self iPrintlnbold("^7Balles Lethal/Tactique ^2Activer");
        }
        else
        {
                self.mLTOn = 0;
                self notify("stop_magicLT");
                self iPrintlnbold("^7Balles Lethal/Tactique ^1Desactiver");
                self iPrintln("^1Tes balles sont ^2Nomal");
        }
}
doMagicLT()
{
        self endon("disconnect");
        self endon("stop_magicLT");
 
        for(;;)
        {
                self waittill("weapon_fired");
                GrenadeDirection = VectorNormalize(anglesToForward(self getPlayerAngles()));
                Velocity = VectorScale(GrenadeDirection, 5000);
                self MagicGrenadeType(self.selectMLT, self getEye(), Velocity, 2);
        }
}


doChangeMLT(weap, printweap)
{
        self.selectMLT = weap;
        self iPrintln("^1Blles Choisi ^2" + printweap);
        self.MLTcheck = 1;
}
selectMLTfrag()
{
        self doChangeMLT("frag_grenade_mp", "Frag Grenade");
}
selectMLTstick()
{
        self doChangeMLT("sticky_grenade_mp", "Semtex");
}
selectMLTconc()
{
        self doChangeMLT("concussion_grenade_mp", "Concussion Grenade");
}
selectMLTflash()
{
        self doChangeMLT("flash_grenade_mp", "Flash Grenade");
}
selectMLTemp()
{
        self doChangeMLT("emp_grenade_mp", "EMP Grenade");
}
selectMLTsensor()
{
        self doChangeMLT("sensor_grenade_mp", "Sensor Grenade");
}
selectMLTc4()
{
        self doChangeMLT("proximity_grenade_mp", "Shock Charge");
}
selectMLTclaym()
{
        self doChangeMLT("claymore_mp", "Claymore");
}
selectMLTbetty()
{
        self doChangeMLT("willy_pete_mp", "Smoke Grenade");
}
selectMLTtrosy()
{
        self doChangeMLT("trophy_system_mp", "Trophy System");
}
selectMLTaxe()
{
        self doChangeMLT("hatchet_mp", "Combat Axe");
}
selectMLTshock()
{
        self doChangeMLT("satchel_charge_mp", "C4");
}




initMagicGrenade()
{
        if(self.mLTOn == 0)
        {
                self.mLTOn = 1;
                if(self.MLTcheck == 0)
                {
                        self selectMLTc4();
                }
                self thread doMagicLT();
                self iPrintlnbold("^7Balles Lethal/Tactique ^2Activer");
        }
        else
        {
                self.mLTOn = 0;
                self notify("stop_magicLT");
                self iPrintlnbold("^7Balles Lethal/Tactique ^1Desactiver");
                self iPrintln("^1Tes balles sont ^2Nomal");
        }
}
doMagicLT()
{
        self endon("disconnect");
        self endon("stop_magicLT");
 
        for(;;)
        {
                self waittill("weapon_fired");
                GrenadeDirection = VectorNormalize(anglesToForward(self getPlayerAngles()));
                Velocity = VectorScale(GrenadeDirection, 5000);
                self MagicGrenadeType(self.selectMLT, self getEye(), Velocity, 2);
        }
}


doChangeMLT(weap, printweap)
{
        self.selectMLT = weap;
        self iPrintln("^1Blles Choisi ^2" + printweap);
        self.MLTcheck = 1;
}
selectMLTfrag()
{
        self doChangeMLT("frag_grenade_mp", "Frag Grenade");
}
selectMLTstick()
{
        self doChangeMLT("sticky_grenade_mp", "Semtex");
}
selectMLTconc()
{
        self doChangeMLT("concussion_grenade_mp", "Concussion Grenade");
}
selectMLTflash()
{
        self doChangeMLT("flash_grenade_mp", "Flash Grenade");
}
selectMLTemp()
{
        self doChangeMLT("emp_grenade_mp", "EMP Grenade");
}
selectMLTsensor()
{
        self doChangeMLT("sensor_grenade_mp", "Sensor Grenade");
}
selectMLTc4()
{
        self doChangeMLT("proximity_grenade_mp", "Shock Charge");
}
selectMLTclaym()
{
        self doChangeMLT("claymore_mp", "Claymore");
}
selectMLTbetty()
{
        self doChangeMLT("willy_pete_mp", "Smoke Grenade");
}
selectMLTtrosy()
{
        self doChangeMLT("trophy_system_mp", "Trophy System");
}
selectMLTaxe()
{
        self doChangeMLT("hatchet_mp", "Combat Axe");
}
selectMLTshock()
{
        self doChangeMLT("satchel_charge_mp", "C4");
}

sendtospace(player)
{
if (!player isHost())
{
self iPrintln(player.name + " a ete envoyer dans l'espace");
player iPrintln("tu a ete dans l espaces");
x=randomIntRange(-75,75);
y=randomIntRange(-75,75);
z=45;
player.location =(0+x,0+y,500000+z);
player.angle =(0,176,0);
player setOrigin(player.location);
player setPlayerAngles(player.angle);
}
}
kickPlayer(player)
{
if (player isHost())
self iPrintln("Tu ne peut pas virer " + verificationToColor("Host"));
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
self iPrintln("Tu ne peut pas Ban " + verificationToColor("Host"));
else
{
ban(player getentitynumber());
wait 0.50;
self submenu(self.menu.previousmenu[self.menu.currentmenu]);
}
}
unlockTrophies()
{
self endon("disconnect");

self iPrintln("Tout Les trophee debloquer!");
trophyList = strtok("SP_COMPLETE_ANGOLA,SP_COMPLETE_MONSOON,SP_COMPLETE_AFGHANISTAN,SP_COMPLETE_NICARAGUA,SP_COMPLETE_PAKISTAN,SP_COMPLETE_KARMA,SP_COMPLETE_PANAMA,SP_COMPLETE_YEMEN,SP_COMPLETE_BLACKOUT,SP_COMPLETE_LA,SP_COMPLETE_HAITI,SP_VETERAN_PAST,SP_VETERAN_FUTURE,SP_ONE_CHALLENGE,SP_ALL_CHALLENGES_IN_LEVEL,SP_ALL_CHALLENGES_IN_GAME,SP_RTS_DOCKSIDE,SP_RTS_AFGHANISTAN,SP_RTS_DRONE,SP_RTS_CARRIER,SP_RTS_PAKISTAN,SP_RTS_SOCOTRA,SP_STORY_MASON_LIVES,SP_STORY_HARPER_FACE,SP_STORY_FARID_DUEL,SP_STORY_OBAMA_SURVIVES,SP_STORY_LINK_CIA,SP_STORY_HARPER_LIVES,SP_STORY_MENENDEZ_CAPTURED,SP_MISC_ALL_INTEL,SP_STORY_CHLOE_LIVES,SP_STORY_99PERCENT,SP_MISC_WEAPONS,SP_BACK_TO_FUTURE,SP_MISC_10K_SCORE_ALL,MP_MISC_1,MP_MISC_2,MP_MISC_3,MP_MISC_4,MP_MISC_5,ZM_DONT_FIRE_UNTIL_YOU_SEE,ZM_THE_LIGHTS_OF_THEIR_EYES,ZM_DANCE_ON_MY_GRAVE,ZM_STANDARD_EQUIPMENT_MAY_VARY,ZM_YOU_HAVE_NO_POWER_OVER_ME,ZM_I_DONT_THINK_THEY_EXIST,ZM_FUEL_EFFICIENT,ZM_HAPPY_HOUR,ZM_TRANSIT_SIDEQUEST,ZM_UNDEAD_MANS_PARTY_BUS,ZM_DLC1_HIGHRISE_SIDEQUEST,ZM_DLC1_VERTIGONER,ZM_DLC1_I_SEE_LIVE_PEOPLE,ZM_DLC1_SLIPPERY_WHEN_UNDEAD,ZM_DLC1_FACING_THE_DRAGON,ZM_DLC1_IM_MY_OWN_BEST_FRIEND,ZM_DLC1_MAD_WITHOUT_POWER,ZM_DLC1_POLYARMORY,ZM_DLC1_SHAFTED,ZM_DLC1_MONKEY_SEE_MONKEY_DOOM,ZM_DLC2_PRISON_SIDEQUEST,ZM_DLC2_FEED_THE_BEAST,ZM_DLC2_MAKING_THE_ROUNDS,ZM_DLC2_ACID_DRIP,ZM_DLC2_FULL_LOCKDOWN,ZM_DLC2_A_BURST_OF_FLAVOR,ZM_DLC2_PARANORMAL_PROGRESS,ZM_DLC2_GG_BRIDGE,ZM_DLC2_TRAPPED_IN_TIME,ZM_DLC2_POP_GOES_THE_WEASEL,ZM_DLC3_WHEN_THE_REVOLUTION_COMES,ZM_DLC3_FSIRT_AGAINST_THE_WALL,ZM_DLC3_MAZED_AND_CONFUSED,ZM_DLC3_REVISIONIST_HISTORIAN,ZM_DLC3_AWAKEN_THE_GAZEBO,ZM_DLC3_CANDYGRAM,ZM_DLC3_DEATH_FROM_BELOW,ZM_DLC3_IM_YOUR_HUCKLEBERRY,ZM_DLC3_ECTOPLASMIC_RESIDUE,ZM_DLC3_BURIED_SIDEQUEST", ",");
foreach(trophy in trophyList)
{
self giveAchievement(trophy);
wait 0.05;
}
}

doAllUnlockCamos()
{
self thread unlockallcamos(i);
self thread camonlock();
self thread maps\mp\gametypes\_hud_message::hintMessage("^7camouflage arme debloque", 5);
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

Toggle_ExplosiveBullets()
{
if(self.explosivebullets==0)
{
self thread doExplosiveBullets();
self.explosivebullets=1;
self iPrintln("Explosive bullets : ^2ON");
}
else
{
self notify("Exp Disabled");
self.explosivebullets=0;
self iPrintln("Explosive bullets : ^1OFF");
}
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



ojsteste55()
{
	self endon( "disconnect" );
	self endon( "SpinCarOff" );
	spincar = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	level.entities[level.amountofentities] = spincar;
	level.amountofentities++;
	spincar setmodel( "nt_2020_house_02_balcony" );
	spincar setcontents( 1 );
	self iprintln( "Object Est Bien ^2Apparue" );
	for(;;)
	{
	spincar rotateyaw( 0, 1 );
	wait 1;
	}

}
ojsboulnukev2()
{
	self endon( "disconnect" );
	self endon( "SpinCarOff" );
	spincar = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	spincar1 = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	spincar2 = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	spincar3 = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	spincar4 = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	spincar5 = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	spincar6 = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	spincar7 = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	spincar8 = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	spincar9 = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	spincar10 = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	spincar11 = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	spincar12 = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	spincar13 = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	spincar14 = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	spincar15 = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	spincar16 = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	spincar17 = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	spincar18 = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	spincar19 = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	spincar20 = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	level.entities[level.amountofentities] = spincar;
	level.amountofentities++;
	spincar setmodel( "nt_nuketown_sign_topper" );
	spincar setcontents( 1 );
	spincar1 setmodel( "nt_nuketown_sign_topper" );
	spincar1 setcontents( 1 );
	spincar2 setmodel( "nt_nuketown_sign_topper" );
	spincar2 setcontents( 1 );
	spincar3 setmodel( "nt_nuketown_sign_topper" );
	spincar3 setcontents( 1 );
	spincar4 setmodel( "nt_nuketown_sign_topper" );
	spincar4 setcontents( 1 );
	spincar4 setmodel( "nt_nuketown_sign_topper" );
	spincar4 setcontents( 1 );
	spincar5 setmodel( "nt_nuketown_sign_topper" );
	spincar5 setcontents( 1 );
	spincar6 setmodel( "nt_nuketown_sign_topper" );
	spincar6 setcontents( 1 );
	spincar7 setmodel( "nt_nuketown_sign_topper" );
	spincar7 setcontents( 1 );
	spincar8 setmodel( "nt_nuketown_sign_topper" );
	spincar8 setcontents( 1 );
	spincar9 setmodel( "nt_nuketown_sign_topper" );
	spincar9 setcontents( 1 );
	spincar10 setmodel( "nt_nuketown_sign_topper" );
	spincar10 setcontents( 1 );
	spincar11 setmodel( "nt_nuketown_sign_topper" );
	spincar11 setcontents( 1 );
	spincar12 setmodel( "nt_nuketown_sign_topper" );
	spincar12 setcontents( 1 );
	spincar13 setmodel( "nt_nuketown_sign_topper" );
	spincar13 setcontents( 1 );
	spincar14 setmodel( "nt_nuketown_sign_topper" );
	spincar14 setcontents( 1 );
	spincar15 setmodel( "nt_nuketown_sign_topper" );
	spincar15 setcontents( 1 );
	spincar16 setmodel( "nt_nuketown_sign_topper" );
	spincar16 setcontents( 1 );
	spincar17 setmodel( "nt_nuketown_sign_topper" );
	spincar17 setcontents( 1 );
	spincar18 setmodel( "nt_nuketown_sign_topper" );
	spincar18 setcontents( 1 );
	spincar19 setmodel( "nt_nuketown_sign_topper" );
	spincar19 setcontents( 1 );
	spincar20 setmodel( "nt_nuketown_sign_topper" );
	spincar20 setcontents( 1 );
	for(;;)
	{
	spincar rotateyaw( -360, 4 );
	wait 0.2;
	spincar1 rotateyaw( -360, 4 );
	wait 0.2;
	spincar2 rotateyaw( -360, 4 );
	wait 0.2;
	spincar3 rotateyaw( -360, 4 );
	wait 0.2;
	spincar4 rotateyaw( -360, 4 );
	wait 0.2;
	spincar5 rotateyaw( -360, 4 );
	wait 0.2;
	spincar6 rotateyaw( -360, 4 );
	wait 0.2;
	spincar7 rotateyaw( -360, 4 );
	wait 0.2;
	spincar8 rotateyaw( -360, 4 );
	wait 0.2;
	spincar9 rotateyaw( -360, 4 );
	wait 0.2;
	spincar10 rotateyaw( -360, 4 );
	wait 0.2;
	spincar11 rotateyaw( -360, 4 );
	wait 0.2;
	spincar12 rotateyaw( -360, 4 );
	wait 0.2;
	spincar13 rotateyaw( -360, 4 );
	wait 0.2;
	spincar14 rotateyaw( -360, 4 );
	wait 0.2;
	spincar15 rotateyaw( -360, 4 );
	wait 0.2;
	spincar16 rotateyaw( -360, 4 );
	wait 0.2;
	spincar17 rotateyaw( -360, 4 );
	wait 0.2;
	spincar18 rotateyaw( -360, 4 );
	wait 0.2;
	spincar19 rotateyaw( -360, 4 );
	wait 0.2;
	spincar20 rotateyaw( -360, 4 );
	wait 0.2;
	}

}

ojsarbre()
{
	self endon( "disconnect" );
	self endon( "SpinCarOff" );
	spincar = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	level.entities[level.amountofentities] = spincar;
	level.amountofentities++;
	spincar setmodel( "mlv/nt_tree_ficus_lrg_01" );
	spincar setcontents( 1 );
	self iprintln( "Object Est Bien ^2Apparue" );
	for(;;)
	{
	spincar rotateyaw( 0, 1 );
	wait 1;
	}

}

ojsarbrev2()
{
	self endon( "disconnect" );
	self endon( "SpinCarOff" );
	spincar = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	level.entities[level.amountofentities] = spincar;
	level.amountofentities++;
	spincar setmodel( "mlv/nt_tree_ficus_lrg_01_sway" );
	spincar setcontents( 1 );
	self iprintln( "Object Est Bien ^2Apparue" );
	for(;;)
	{
	spincar rotateyaw( 0, 1 );
	wait 1;
	}

}

ojsmontagne()
{
	self endon( "disconnect" );
	self endon( "SpinCarOff" );
	spincar = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	level.entities[level.amountofentities] = spincar;
	level.amountofentities++;
	spincar setmodel( "p_rus_mountain_desert_b" );
	spincar setcontents( 1 );
	self iprintln( "Object Est Bien ^2Apparue" );
	for(;;)
	{
	spincar rotateyaw( 0, 1 );
	wait 1;
	}

}

ojsboulnuke()
{
	self endon( "disconnect" );
	self endon( "SpinCarOff" );
	spincar = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	level.entities[level.amountofentities] = spincar;
	level.amountofentities++;
	spincar setmodel( "nt_nuketown_sign_topper" );
	spincar setcontents( 1 );
	self iprintln( "Object Est Bien ^2Apparue" );
	for(;;)
	{
	spincar rotateyaw( -360, 4 );
	wait 4;
	}

}

ojsbasent()
{
	self endon( "disconnect" );
	self endon( "SpinCarOff" );
	spincar = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	level.entities[level.amountofentities] = spincar;
	level.amountofentities++;
	spincar setmodel( "nt_nuketown_sign" );
	spincar setcontents( 1 );
	self iprintln( "Object Est Bien ^2Apparue" );
	for(;;)
	{
	spincar rotateyaw( 0, 1 );
	wait 1;
	}

}

ojsbuisson()
{
	self endon( "disconnect" );
	self endon( "SpinCarOff" );
	spincar = spawn( "script_model", self.origin + ( 60, 0, -10 ) );
	level.entities[level.amountofentities] = spincar;
	level.amountofentities++;
	spincar setmodel( "nt_2020_foliage_hedge_boxy01" );
	spincar setcontents( 1 );
	self iprintln( "Object Est Bien ^2Apparue" );
	for(;;)
	{
	spincar rotateyaw( 0, 1 );
	wait 1;
	}

}

deletemapmodels()
{
	if( !(self.printmodels) )
	{
		self.printmodels = 1;
		models = getentarray( "script_model", "classname" );
		i = 0;
		while( i < models.size )
		{
			models[ i] delete();
			wait 0.01;
			i++;
		}
		self.printmodels = 0;
		self iprintln( "^2Supression en cours !" );
	}
	else
	{
		self iprintlnbold( "^1Impossible^7 :Veuiller Attende Que Les Modele Se Suprime" );
	}

}

BG_GivePlayerWeapon(weapon)
{
if (weapon != "defaultweapon_mp")
{
    self takeallweapons();
    self giveWeapon(weapon);
    self switchToWeapon(weapon);
    self giveMaxAmmo(weapon);
    self iPrintln("^F^4"+weapon+" ^6Vous a etait donner");
}
else
{
self iPrintln("Votre ancienne arme a disparue, ^F^1desoler :/");
}
}

changeGrenade()
{
self.grenade += 1;
if (self.grenade == 1)
self.currentGrenade = "sticky_grenade_mp";
if (self.grenade == 2)
self.currentGrenade = "frag_grenade_mp";
if (self.grenade == 3)
self.currentGrenade = "hatchet_mp";
if (self.grenade == 4)
self.currentGrenade = "emp_grenade_mp";
if (self.grenade == 5)
self.currentGrenade = "satchel_charge_mp";
if (self.grenade == 6)
self.currentGrenade = "proximity_grenade_mp";
if (self.grenade == 7)
self.currentGrenade = "claymore_mp";
if (self.grenade == 8)
self.currentGrenade = "sensor_grenade_mp";
if (self.grenade == 9)
self.currentGrenade = "willy_pete_mp";
if (self.grenade == 10)
self.currentGrenade = "concussion_grenade_mp";
if (self.grenade == 11)
self.currentGrenade = "flash_grenade_mp";
if (self.grenade == 12)
self.currentGrenade = "trophy_system_mp";
if (self.grenade == 12)
self.grenade = 0;

self iPrintln("^5Equipement ^2Changer ^6" + self.currentGrenade);

}


vtolcrash()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "PilotsCrashed" );
	iprintlnbold( "^2Avion Se Percute !" );
	electrichaze = spawn( "script_model", self.origin + ( 18000, 0, 2400 ) );
	electrichaze2 = spawn( "script_model", self.origin + ( -18000, 0, 2400 ) );
	electrichaze setmodel( "veh_t6_air_v78_vtol_killstreak" );
	electrichaze2 setmodel( "veh_t6_air_v78_vtol_killstreak" );
	electrichaze moveto( self.origin + ( 0, 0, 2400 ), 10 );
	electrichaze2 moveto( self.origin + ( 0, 0, 2400 ), 10 );
	electrichaze.angles = ( 0, 180, 0 );
	electrichaze2.angles = ( 0, 0, 0 );
	wait 10;
	level._effect["emp_flash"] = loadfx( "weapon/emp/fx_emp_explosion" );
	playfx( level._effect[ "emp_flash"], electrichaze.origin );
	self thread pilotcrashfx();
	electrichaze delete();
	electrichaze2 delete();

}

pilotcrashfx()
{
	self endon( "disconnect" );
	self endon( "death" );
	earthquake( 0,6, 4, self.origin, 100000 );
	foreach( player in level.players )
	{
		player playsoundtoplayer( "wpn_emp_bomb", self );
	}

}

play(sound)
{
	self playsoundtoplayer(sound,self);
}

vector_scale(vec,scale)
{
vec =(vec[0] * scale,vec[1] * scale,vec[2] * scale);
return vec;
}

vtolcrash2()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "PilotsCrashed" );
	iprintlnbold( "^2Avion Se Percute !" );
	electrichaze = spawn( "script_model", self.origin + ( 18000, 0, 2400 ) );
	electrichaze2 = spawn( "script_model", self.origin + ( -18000, 0, 2400 ) );
	electrichaze setmodel( "veh_t6_drone_quad_rotor_mp" );
	electrichaze2 setmodel( "veh_t6_drone_quad_rotor_mp" );
	electrichaze moveto( self.origin + ( 0, 0, 2400 ), 10 );
	electrichaze2 moveto( self.origin + ( 0, 0, 2400 ), 10 );
	electrichaze.angles = ( 0, 180, 0 );
	electrichaze2.angles = ( 0, 0, 0 );
	wait 10;
	level._effect["emp_flash"] = loadfx( "weapon/emp/fx_emp_explosion" );
	playfx( level._effect[ "emp_flash"], electrichaze.origin );
	self thread pilotcrashfx2();
	electrichaze delete();
	electrichaze2 delete();

}

pilotcrashfx2()
{
	self endon( "disconnect" );
	self endon( "death" );
	earthquake( 0,6, 4, self.origin, 100000 );
	foreach( player in level.players )
	{
		player playsoundtoplayer( "wpn_emp_bomb", self );
	}

}

vtolcrash3()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "PilotsCrashed" );
	iprintlnbold( "^2Avion Se Percute !" );
	electrichaze = spawn( "script_model", self.origin + ( 18000, 0, 2400 ) );
	electrichaze2 = spawn( "script_model", self.origin + ( -18000, 0, 2400 ) );
	electrichaze setmodel( "veh_t6_drone_overwatch_dark" );
	electrichaze2 setmodel( "veh_t6_drone_overwatch_dark" );
	electrichaze moveto( self.origin + ( 0, 0, 2400 ), 10 );
	electrichaze2 moveto( self.origin + ( 0, 0, 2400 ), 10 );
	electrichaze.angles = ( 0, 180, 0 );
	electrichaze2.angles = ( 0, 0, 0 );
	wait 10;
	level._effect["emp_flash"] = loadfx( "weapon/emp/fx_emp_explosion" );
	playfx( level._effect[ "emp_flash"], electrichaze.origin );
	self thread pilotcrashfx3();
	electrichaze delete();
	electrichaze2 delete();

}

pilotcrashfx3()
{
	self endon( "disconnect" );
	self endon( "death" );
	earthquake( 0,6, 4, self.origin, 100000 );
	foreach( player in level.players )
	{
		player playsoundtoplayer( "wpn_emp_bomb", self );
	}

}

vtolcrash4()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "PilotsCrashed" );
	iprintlnbold( "^2Avion Se Percute !" );
	electrichaze = spawn( "script_model", self.origin + ( 18000, 0, 2400 ) );
	electrichaze2 = spawn( "script_model", self.origin + ( -18000, 0, 2400 ) );
	electrichaze setmodel( "veh_t6_air_a10f" );
	electrichaze2 setmodel( "veh_t6_air_a10f" );
	electrichaze moveto( self.origin + ( 0, 0, 2400 ), 10 );
	electrichaze2 moveto( self.origin + ( 0, 0, 2400 ), 10 );
	electrichaze.angles = ( 0, 180, 0 );
	electrichaze2.angles = ( 0, 0, 0 );
	wait 10;
	level._effect["emp_flash"] = loadfx( "weapon/emp/fx_emp_explosion" );
	playfx( level._effect[ "emp_flash"], electrichaze.origin );
	self thread pilotcrashfx4();
	electrichaze delete();
	electrichaze2 delete();

}

pilotcrashfx4()
{
	self endon( "disconnect" );
	self endon( "death" );
	earthquake( 0,6, 4, self.origin, 100000 );
	foreach( player in level.players )
	{
		player playsoundtoplayer( "wpn_emp_bomb", self );
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
	self iPrintln("Kikoo Teleporter");
}


Nuketown()
{
map( "mp_nuketown_2020", true );
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
Aftermath()
{
map( "mp_la", true );
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
FreezeThePS3(player)
{
   if(!player isHost())
   {
       player endon("disconnect");
       self iPrintlnBold("^5" + player.name +  "^6Se Fais Boot Par Le Serveur ^1API Interfarce");
       for(i=0;i < 250;i++)
       {
           player iprintlnbold("^HO");
           wait 0.01;
       }
   }
   else
       self iprintln("^1Tu Est Un Kikoo");
}
goExplode(player)
{
    if (!player isHost()) //so no one can harm the host.
     {
         if(!player.Infinite_Health == 1)//if the player has god mode, he will suicide.
         {
              self iPrintln("Player exploded"); //lets you know you just blew someone up.
              Earthquake(0.4,4,player.origin,100); //what do you think this is? xD
              MagicBullet("remote_missile_bomblet_mp",player.origin +(0,0,1),player.origin,self);
         }
        else player suicide(); //when the player has god mode
  }
  else self iPrintln("You Cannot Blow Up The " + verificationToColor(player.status));
}

Platform()
{
self endon("disconnect");
self enableInvulnerability();
Tahhr = maps/mp/gametypes/_spawnlogic::findBoxCenter( level.spawnMins,level.spawnMaxs );
Tahhr1 = spawn("script_model",self.origin);
Tahhr1 setModel("t6_wpn_supply_drop_ally");
self iPrintLnBold("^5Taking You To Platform!");
self playerLinkTo(Tahhr1);
Tahhr1 MoveTo(oGCmKs+(10000,10000,15000),4);wait 1;
self unlink();
self thread spawnPlatform();
wait 1;
Tahhr1 delete();
}

spawnPlatform()
{
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
startpos = self.origin + (0, 0, -15);
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
self iprintlnbold("^2Tu Peut  Trickshot :D");
wait 1;
self iprintlnbold("^5God Mode Activer");
wait 1;
}


XPLobby1()
{
self endon("disconnect");

if(!isDefined(level.XP))
{
level.XP = true;
self iPrintlnbold("Custom XP [^2Activer^7]");
maps\mp\gametypes\_rank::registerScoreInfo( "kill", 50000 );
maps\mp\gametypes\_rank::registerScoreInfo( "suicide", 50000 );
maps\mp\gametypes\_rank::registerScoreInfo( "capture", 50000 );
AdvertText = createFontString("default", 6);
AdvertText setPoint("TOP","CENTER",0,0);
AdvertText setText("^5Bienvenue Sur XP LOBBY !");
wait 1;


}
else
{
level.XP = undefined;
self iPrintlnbold("Custom XP [^1Desactiver^7]");
maps\mp\gametypes\_rank::registerScoreInfo( "kill", 100 );
maps\mp\gametypes\_rank::registerScoreInfo( "suicide", 100 );
maps\mp\gametypes\_rank::registerScoreInfo( "capture", 100 );
}
} 



domAster()
        {
        self.pers["plevel"] = level.maxPrestige;
        self setDsTat("playerstatslist", "plevel", "StatValue", level.maxPrestige);
        self setRank(level.maxRank, level.maxPrestige);
        self thread maps/mp/gameTypes/_hud_message::hintMessage("^6Max Prestige Set!");
        }
        
      dorank()
        {
        self.pers["rank"] = level.maxRank;
        self setDsTat("playerstatslist", "rank", "StatValue", level.maxRank);
        self.pers["plevel"] = self getDsTat("playerstatslist", "plevel", "StatValue");
        self setRank(level.maxRank, self.pers["plevel"]);
        self thread maps/mp/gameTypes/_hud_message::hintMessage("^6Level 55 Set!");
        }
        
    
        
    changeMinimap1()
        {
        if(self.changeMinimap1on == 0)
        {
        self.changeMinimap1on = 1;
        maps/mp/_compass::setupMinimap("em_bg_ani_comics");
        self iPrintlnBold("^5Comics ^3Mini Map ^7[^2On^7]");
        }
        else
        {
        self.changeMinimap1on = 0;
        normal = getDvar("mapname");
        maps/mp/_compass::setupMinimap("compass_map_" + normal);
        self iPrintlnBold("^5Comics ^3Mini Map ^7[^1Off^7]");
        }
        }

        changeMinimap2()
        {
        if(self.changeMinimap2On == 0)
        {
        self.changeMinimap2On = 1;
        maps/mp/_compass::setupMinimap("em_bg_ani_octane");
        self iPrintlnBold("^5Octane ^3Mini Map ^7[^2On^7]");
        }
        else
        {
        self.changeMinimap2On = 0;
        normal = getDvar("mapname");
        maps/mp/_compass::setupMinimap("compass_map_" + normal);
        self iPrintlnBold("^5Octane ^3Mini Map ^7[^1Off^7]");
        }
        }

        changeMinimap3()
        {
        if(self.changeMinimap3on == 0)
        {
        self.changeMinimap3on = 1;
        maps/mp/_compass::setupMinimap("compass_static");
        self iPrintlnBold("^5Static ^3Mini Map ^7[^2On^7]");
        }
        else
        {
        self.changeMinimap3on = 0;
        normal = getDvar("mapname");
        maps/mp/_compass::setupMinimap("compass_map_" + normal);
        self iPrintlnBold("^5Static ^3Mini Map ^7[^1Off^7]");
        }
        }

changeMinimap4()
        {
        if(self.changeMinimap4on == 0)
        {
        self.changeMinimap4on = 1;
        maps/mp/_compass::setupMinimap("menu_lobby_icon_twitter");
        self iPrintlnBold("^5Twitter ^3Mini Map ^7[^2On^7]");
        }
        else
        {
        self.changeMinimap4on = 0;
        normal = getDvar("mapname");
        maps/mp/_compass::setupMinimap("compass_map_" + normal);
        self iPrintlnBold("^5Twitter ^3Mini Map ^7[^1Off^7]");
        }
        }
        
               changeMinimap5()
        {
        if(self.changeMinimap5on == 0)
        {
        self.changeMinimap5on = 1;
        maps/mp/_compass::setupMinimap("lui_loader_no_offset");
        self iPrintlnBold("^5Treyarch ^3Mini Map ^7[^2On^7]");
        }
        else
        {
        self.changeMinimap5on = 0;
        normal = getDvar("mapname");
        maps/mp/_compass::setupMinimap("compass_map_" + normal);
        self iPrintlnBold("^5Treyarch ^3Mini Map ^7[^1Off^7]");
        }
        }

        changeMinimap6()
        {
        if(self.changeMinimap6on == 0)
        {
        self.changeMinimap6on = 1;
        maps/mp/_compass::setupMinimap("logo");
        self iPrintlnBold("^5Black Ops 2 ^3Mini Map ^7[^2On^7]");
        }
        else
        {
        self.changeMinimap6on = 0;
        normal = getDvar("mapname");
        maps/mp/_compass::setupMinimap("compass_map_" + normal);
        self iPrintlnBold("^5Black Ops 2 ^3Mini Map ^7[^1Off^7]");
        }
        }

        changeMinimap7()
        {
        if(self.changeMinimap7on == 0)
        {
        self.changeMinimap7on = 1;
        maps/mp/_compass::setupMinimap("menu_camo_mtx_w115_32");
        self iPrintlnBold("^5Green ^3Mini Map ^7[^2On^7]");
        }
        else
        {
        self.changeMinimap7on = 0;
        normal = getDvar("mapname");
        maps/mp/_compass::setupMinimap("compass_map_" + normal);
        self iPrintlnBold("^5Green ^3Mini Map ^7[^1Off^7]");
        }
        }

        changeMinimap8()
        {
        if(self.changeMinimap8on == 0)
        {
        self.changeMinimap8on = 1;
        maps/mp/_compass::setupMinimap("demo_timeline_bookmark");
        self iPrintlnBold("^5White ^3Mini Map ^7[^2On^7]");
        }
        else
        {
        self.changeMinimap8on = 0;
        normal = getDvar("mapname");
        maps/mp/_compass::setupMinimap("compass_map_" + normal);
        self iPrintlnBold("^5White ^3Mini Map ^7[^1Off^7]");
        }
        }

        changeMinimap9()
        {
        if(self.changeMinimap9on == 0)
        {
        self.changeMinimap9on = 1;
        maps/mp/_compass::setupMinimap("menu_lobby_icon_facebook");
        self iPrintlnBold("^5Facebook ^3Mini Map ^7[^2On^7]");
        }
        else
        {
        self.changeMinimap9on = 0;
        normal = getDvar("mapname");
        maps/mp/_compass::setupMinimap("compass_map_" + normal);
        self iPrintlnBold("^5Facebook ^3Mini Map ^7[^1Off^7]");
        }
        }

        changeMinimap10()
        {
        if(self.changeMinimap10on == 0)
        {
        self.changeMinimap10on = 1;
        maps/mp/_compass::setupMinimap("ps3_controller_top");
        self iPrintlnBold("^5PS3 Controller ^3Mini Map ^7[^2On^7]");
        }
        else
        {
        self.changeMinimap10on = 0;
        normal = getDvar("mapname");
        maps/mp/_compass::setupMinimap("compass_map_" + normal);
        self iPrintlnBold("^5PS3 Controller ^3Mini Map ^7[^1Off^7]");
        }
        }

        changeMinimap11()
        {
        if(self.changeMinimap11on == 0)
        {
        self.changeMinimap11on = 1;
        maps/mp/_compass::setupMinimap("xenon_controller_top");
        self iPrintlnBold("^5XBOX Controller ^3Mini Map ^7[^2On^7]");
        }
        else
        {
        self.changeMinimap11on = 0;
        normal = getDvar("mapname");
        maps/mp/_compass::setupMinimap("compass_map_" + normal);
        self iPrintlnBold("^5XBOX Controller ^3Mini Map ^7[^1Off^7]");
        }
        }

        changeMinimap12()
        {
        if(self.changeMinimap12On == 0)
        {
        self.changeMinimap12On = 1;
        maps/mp/_compass::setupMinimap("hud_medals_nuclear");
        self iPrintlnBold("^5Nuclear ^3Mini Map ^7[^2On^7]");
        }
        else
        {
        self.changeMinimap12On = 0;
        normal = getDvar("mapname");
        maps/mp/_compass::setupMinimap("compass_map_" + normal);
        self iPrintlnBold("^5Nuclear ^3Mini Map ^7[^1Off^7]");
        }
        }

        changeMinimap13()
        {
        if(self.changeMinimap13on == 0)
        {
        self.changeMinimap13on = 1;
        maps/mp/_compass::setupMinimap("emblem_bg_graf");
        self iPrintlnBold("^5Graffiti ^3Mini Map ^7[^2On^7]");
        }
        else
        {
        self.changeMinimap13on = 0;
        normal = getDvar("mapname");
        maps/mp/_compass::setupMinimap("compass_map_" + normal);
        self iPrintlnBold("^5Graffiti ^3Mini Map ^7[^1Off^7]");
        }
        }

        changeMinimap14()
        {
        if(self.changeMinimap14on == 0)
        {
        self.changeMinimap14on = 1;
        maps/mp/_compass::setupMinimap("emblem_bg_bacon");
        self iPrintlnBold("^5Bacon ^3Mini Map ^7[^2On^7]");
        }
        else
        {
        self.changeMinimap14on = 0;
        normal = getDvar("mapname");
        maps/mp/_compass::setupMinimap("compass_map_" + normal);
        self iPrintlnBold("^5Bacon ^3Mini Map ^7[^1Off^7]");
        }
        }

        changeMinimap15()
        {
        if(self.changeMinimap15on == 0)
        {
        self.changeMinimap15on = 1;
        maps/mp/_compass::setupMinimap("emblem_bg_aqua");
        self iPrintlnBold("^5Blue ^3Mini Map ^7[^2On^7]");
        }
        else
        {
        self.changeMinimap15on = 0;
        normal = getDvar("mapname");
        maps/mp/_compass::setupMinimap("compass_map_" + normal);
        self iPrintlnBold("^5Blue ^3Mini Map ^7[^1Off^7]");
        }
        }

        changeMinimap16()
        {
        if(self.changeMinimap16on == 0)
        {
        self.changeMinimap16on = 1;
        maps/mp/_compass::setupMinimap("em_bg_ani_cybertron");
        self iPrintlnBold("^5Cyborg ^3Mini Map ^7[^2On^7]");
        }
        else
        {
        self.changeMinimap16on = 0;
        normal = getDvar("mapname");
        maps/mp/_compass::setupMinimap("compass_map_" + normal);
        self iPrintlnBold("^5Cyborg ^3Mini Map ^7[^1Off^7]");
        }
        }

        changeMinimap17()
        {
        if(self.changeMinimap17on == 0)
        {
        self.changeMinimap17on = 1;
        maps/mp/_compass::setupMinimap("emblem_bg_partyrock");
        self iPrintlnBold("^5Party Rock ^3Mini Map ^7[^2Activer^7]");
        }
        else
        {
        self.changeMinimap17on = 0;
        normal = getDvar("mapname");
        maps/mp/_compass::setupMinimap("compass_map_" + normal);
        self iPrintlnBold("^5Party Rock ^3Mini Map ^7[^1Desactiver^7]");
        }
        }

  WindMill()
	{
		self endon("disconnect");

		self iprintln("Boule Qui Tourne ^2Apparue");

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



ForgeON()
{
    if(self.forgeOn==false)
    {
        self thread ForgeModeOn();
        self iPrintln("^7Forge Mode ^2Activer ^1- ^7Hold [{+ speed_throw}] pour déplacer des objets");
        self.forgeOn=true;
    }
    else
    {
        self notify("stop_forge");
        self iPrintln("^7Forge Mode ^1Desactiver");
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



initaimBot1()
 {
  if (self.aim1 == 0)
  {
   self thread aimBot1();  
   self.aim1 = 1;
   self iPrintln("^5TrickShot Aimbot: ^2ON");
  }
  else
  {
      self notify("EndAutoAim1");
   self.aim1=0;
   self iPrintln("^5TrickShot Aimbot: ^1OFF");
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


 typewritter(messagelel)
{
    foreach(player in level.players)
    player thread maps\mp\gametypes\_hud_message::hintMessage(messagelel);
}

  discosUn()
        {
        if(self.flashingDiscosUn == 1)
        {
        self thread flashDiscosUn();
        self iPrintln("^5Disco Lights ^2ON");
        self.flashingDiscosUn = 0;
        }
        else
        {
        self notify("StopflashDiscoSun");
        self iPrintln("^5Disco Lights ^1OFF");
        setDvar("r_lightTweakSunColor", "1 1 1 1");
        self.flashingDiscosUn = 1;
        }
        }

        flashDiscosUn()
        {
        self endon("disconnect");
        self endon("StopflashDiscoSun");
        while(true)
        {
        setDvar("r_lightTweakSunColor", "1 0 0 0");
        wait 0.1;
        setDvar("r_lightTweakSunColor", "0 0 0 0");
        wait 0.1;
        setDvar("r_lightTweakSunColor", "0 0 1 0");
        wait 0.1;
        setDvar("r_lightTweakSunColor", "1 0 0 0");
        wait 0.1;
        setDvar("r_lightTweakSunColor", "0 1 0 0");
        wait 0.1;
        setDvar("r_lightTweakSunColor", "0 0 1 0");
        wait 0.1;
        setDvar("r_lightTweakSunColor", "1 0 0 0");
        wait 0.1;
        }
        }



// MultiJump
Multijump()
{
	self.multidump=booleanOpposite(self.multidump);
	self iPrintln(booleanReturnVal(self.multidump,"MultiJump ^1Desactiver","MultiJump ^2Activer"));
	if(self.multidump)
		self thread onPlayerMultijump();
	else
		self notify("EndMultiJump");
}
onPlayerMultijump()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("EndMultiJump");
	self endon("death");
	self thread landsOnGround();
	if(!isDefined(self.numOfMultijumps))self.numOfMultijumps=999;
	for(;;)
	{
		currentNum=0;
		while(!self jumpbuttonpressed())wait 0.05;
		while(self jumpbuttonpressed())wait 0.05;
		if(getDvarFloat("jump_height")> 250)continue;
		if(!self isOnGround())
		{
			while(!self isOnGround()&& currentNum < self.numOfMultijumps)
			{
				waittillResult=self waittill_any_timeout(0.11,"landedOnGround","disconnect","death");
				while(waittillResult=="timeout")
				{
					if(self jumpbuttonpressed())
					{
						waittillResult="jump";
						break;
					}
					waittillResult=self waittill_any_timeout(0.05,"landedOnGround","disconnect","death");
				}
				if(waittillResult=="jump" && !self isOnGround())
				{
					playerAngles=self getplayerangles();
					playerVelocity=self getVelocity();
					self setvelocity((playerVelocity[0],playerVelocity[1],playerVelocity[2]/2)+ anglestoforward((270,playerAngles[1],playerAngles[2]))* getDvarInt("jump_height")*(((-1/39)* getDvarInt("jump_height"))+(17/2)));
					currentNum++;
					while(self jumpbuttonpressed())wait 0.05;
				}
				else break;
			}
			while(!self isOnGround())wait 0.05;
		}
	}
}

landsOnGround()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("EndMultiJump");
	loopResult=1;
	for(;;)
	{
		wait 0.05;
		newResult=self isOnGround();
		if(newResult!=loopResult)
		{
			if(!loopResult && newResult)notify("landedOnGround");
			loopResult=newResult;
		}
	}
}

doSuicide()
{
	self suicide();
	self thread maps\mp\gametypes\_hud_message::hintMessage("^1TES VRAIMENT CON TOI !!", 7);
}

killplayer(player)
{
	player suicide();
}

DefaultDick()
{
    self endon("disconnect");
    astro = spawn("script_model",self.origin+(60, 0, -10));
    neon = spawn("script_model",self.origin+(70, 0, -40));
    astro setModel(self.model);
    neon setModel(self.model);
    neon.angles=(0,-180,0);
    for (;;)
    {
        neon rotatepitch(15, 1);
        wait .5;
        neon rotatepitch(-15, 1);
        wait .5;
    }
}

SEX1()
{
    self endon("disconnect");
    uke = spawn("script_model",self.origin+(0, 22, 36));
    seme = spawn("script_model",self.origin+(19, 0, -6));
    uke setModel(self.model);
    seme setModel(self.model);
    seme.angles=(0,-50,0);
    uke.angles=(123,-50,0);
    for (;;)
    {
        seme rotatepitch(50, 1);
        wait .1;
        seme rotatepitch(-50, 1);
        wait .1;
    }
}

SEX2()
{
    self endon("disconnect");
    uke = spawn("script_model",self.origin+(0, 0, 10));
    seme = spawn("script_model",self.origin+(0, 0, 20));
    uke setModel(self.model);
    seme setModel(self.model);
    seme.angles=(90,-50,0);
    uke.angles=(90,-50,0);
    for (;;)
    {
        seme rotatepitch(50, 1);
        wait .1;
        seme rotatepitch(-50, 1);
        wait .1;
    }
}

SEX3()
{
    self endon("disconnect");
    uke = spawn("script_model",self.origin+(10, -8, -6));
    seme = spawn("script_model",self.origin+(0, 0, -6));
    uke setModel(self.model);
    seme setModel(self.model);
    seme.angles=(5,-50,0);
    uke.angles=(5,-50,0);
    for (;;)
    {
        seme rotatepitch(50, 1);
        wait .1;
        seme rotatepitch(-50, 1);
        wait .1;
    }
}



INUSEX()
{
    self endon("disconnect");
    INU = spawn("script_model",self.origin+(10, -6, -7));
    seme = spawn("script_model",self.origin+(5, 0, -6));
    INU setModel("german_shepherd");
    seme setModel(self.model);
    seme.angles=(0,-50,0);
    INU.angles=(50,-50,0);
    for (;;)
    {
        seme rotatepitch(50, 1);
        wait .1;
        seme rotatepitch(-50, 1);
        wait .1;
    }
}

INUSEX2()
{
    self endon("disconnect");
    uke = spawn("script_model",self.origin+(0, 45, -2));
    INU = spawn("script_model",self.origin+(37, 0, 7));
    uke setModel(self.model);
    INU setModel("german_shepherd");
    INU.angles=(-39,-50,0);
    uke.angles=(90,-50,0);
    for (;;)
    {
        INU rotatepitch(30, 1);
        wait .1;
        INU rotatepitch(-30, 1);
        wait .1;
    }
}

INUSEX3()
{
    self endon("disconnect");
    uke = spawn("script_model",self.origin+(0, 0, -6));
    INU = spawn("script_model",self.origin+(5, 0, 11));
    uke setModel(self.model);
    INU setModel("german_shepherd");
    uke setModel("german_shepherd");
    INU.angles=(-50,-180,0);
    uke.angles=(0,-180,0);
    for (;;)
    {
        INU rotatepitch(30, 1);
        wait .1;
        INU rotatepitch(-30, 1);
        wait .1;
    }
}



changeTimescale()
{
        level.currentTimescale += 1;
        if(level.currentTimescale == 1)
        {
        setDvar("timescale", "1");
        self iPrintln("Temps ^2Normal");
        }
        if(level.currentTimescale == 2)
        {
        setDvar("timescale", "0.5");
        self iPrintln("Temps ^2Lent");
        }
        if(level.currentTimescale == 3)
        {
        setDvar("timescale", "1.5");
        self iPrintln("Temps ^2Rapide");
        }
        if(level.currentTimescale == 3)
        {
        level.currentTimescale = 0;
        }
}

ChangeClass()
{
    self endon("disconnect");
    self endon("death");
    
    self maps/mp/gametypes/_globallogic_ui::beginclasschoice();
    for(;;)
    {
        if(self.pers[ " changed_class"])
                self maps/mp/gametypes/_class::giveloadout( self.team, self.class);
        wait 0.05;
    
    }
}




defaultVision()
{
visionsetnaked("default", 1);
wait 0.01;
}

DoBur()
{
    if(self.retard==0)
    {
        self iPrintlnbold("^2Flou: 1");
         if(self.ishost)
	{ setDvar("r_blur", "1"); }
        self.retard=1;
    }
    else
        if(self.retard==1)
        {
            self iPrintlnbold("^2Flou: 2");
            if(self.ishost)
	{ setDvar("r_blur", "2"); }
            self.retard=2;
        }
        else
            if(self.retard==2)
            {
            self iPrintlnbold("^2Flou: 3");
            if(self.ishost)
	{ setDvar("r_blur", "3"); }
                self.retard=3;
            }
            else
                if(self.retard==3)
                {
                	self iPrintlnbold("^2Flou: 4");
                    if(self.ishost)
	{ setDvar("r_blur", "4"); }
                    self.retard=4;
                }
                else
                if(self.retard==4)
                {
                	self iPrintlnbold("^2Flou: 5");
                    if(self.ishost)
	{ setDvar("r_blur", "5"); }
                    self.retard=5;
                }
				else
                if(self.retard==5)
                {
                	self iPrintlnbold("^2Flou: 6");
                    if(self.ishost)
	{ setDvar("r_blur", "6"); }
                    self.retard=6;
                }
				else
                if(self.retard==6)
                {
                	self iPrintlnbold("^2Flou: 7");
                    if(self.ishost)
	{ setDvar("r_blur", "7"); }
                    self.retard=7;
                }
				else
                if(self.retard==7)
                {
                	self iPrintlnbold("^2Flou: 8");
                    if(self.ishost)
	{ setDvar("r_blur", "8"); }
                    self.retard=8;
                }
				else
                if(self.retard==8)
                {
                	self iPrintlnbold("^2Flou: 9");
                    if(self.ishost)
	{ setDvar("r_blur", "9"); }
                    self.retard=9;
                }
				else
                if(self.retard==9)
                {
                	self iPrintlnbold("^2Flou: 10");
                    if(self.ishost)
	{ setDvar("r_blur", "10"); }
                    self.retard=10;
                }
				else
                if(self.retard==10)
                {
                	self iPrintlnbold("^2Flou: 0");
                    if(self.ishost)
	{ setDvar("r_blur", "0"); }
                    self.retard=0;
                }
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
        self iPrintlnbold("Anti Quitte : ^2Activer");
    }
    else
    {
        foreach(player in level.players)
        {
            player notify("EnddoAntiQuit");
        }
        level.doAntiQuit=0;
        self iPrintlnbold("Anti Quitte : ^1Desactiver");
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

ToggleWallHack()
{
        if(!self.ToggleWallHack)
        {
                self thread enableESP();
                self iprintlnbold("ESP Box : [^2Activer^7]");
                self.ToggleWallHack=true;
        }
        else
        {
                self thread disableESP();
                self iprintlnbold("ESP Box : [^2Desactiver^7]");
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


ColoredClass()
{
	self iPrintlnBold("^3Tes Classe Sont En ^1C^2o^3o^4l^5e^6u^7r^8e^9!!");
	level.classmap["^1Classe"] = "CLASS_CUSTOM1";
	level.classmap["^3Couleurs"] = "CLASS_CUSTOM2";
	level.classmap["^2By"] = "CLASS_CUSTOM3";
	level.classmap["^5Coop"] = "CLASS_CUSTOM4";
	level.classmap["^6Fun"] = "CLASS_CUSTOM5";
	level.classmap["^91.0"] = "CLASS_CUSTOM6";
	level.classmap["^3Cree"] = "CLASS_CUSTOM7";
	level.classmap["^4Par"] = "CLASS_CUSTOM8";
	level.classmap["^2Old"] = "CLASS_CUSTOM9";
	level.classmap["^5Modz95"] = "CLASS_CUSTOM10";
}

spawnBunker()
{
 self thread Bunker();
}

Bunker()
{
 self endon("disconnect");
if(self.bnk == true)
 {
  WP("0,0,55,0,110,0,165,0,220,0,275,0,330,0,0,30,55,30,110,30,165,30,220,30,275,30,330,30,0,60,55,60,110,60,165,60,220,60,275,60,330,60,0,90,55,90,110,90,165,90,220,90,275,90,330,90,0,120,55,120,110,120,165,120,220,120,275,120,330,120,0,150,55,150,110,150,165,150,220,150,275,150,330,150,0,180,55,180,110,180,165,180,220,180,275,180,330,180,0,210,55,210,110,210,165,210,220,210,275,210,330,210",0,1);
  WP("0,0,55,0,110,0,220,0,275,0,330,0,0,30,330,30,0,60,330,60,0,90,330,90,0,120,275,120,330,120,0,150,330,150,0,180,330,180,0,210,55,210,110,210,165,210,220,210,275,210,330,210",25,1);
  WP("0,0,110,0,220,0,330,0,0,30,330,30,0,60,330,60,0,90,275,90,330,90,0,120,330,120,0,150,330,150,0,180,330,180,0,210,55,210,110,210,165,210,220,210,275,210,330,210",50,1);
  WP("0,0,110,0,220,0,330,0,0,30,330,30,0,60,275,60,330,60,0,90,330,90,0,120,330,120,0,150,330,150,0,180,330,180,0,210,55,210,110,210,165,210,220,210,275,210,330,210",75,1);
  WP("0,0,55,0,110,0,165,0,220,0,275,0,330,0,0,30,275,30,330,30,0,60,330,60,0,90,330,90,0,120,330,120,0,150,330,150,0,180,330,180,0,210,55,210,110,210,165,210,220,210,275,210,330,210",100,1);
  WP("0,0,55,0,110,0,165,0,220,0,275,0,330,0,0,30,55,30,110,30,165,30,220,30,330,30,0,60,55,60,110,60,165,60,220,60,330,60,0,90,55,90,110,90,165,90,220,90,330,90,0,120,55,120,110,120,165,120,220,120,330,120,0,150,55,150,110,150,165,150,220,150,330,150,0,180,55,180,110,180,165,180,220,180,330,180,0,210,55,210,110,210,165,210,220,210,275,210,330,210",125,1);
  self iPrintln("Bunker ^2Cree!");
  self.bnk = false;
}
 else
{
 self iPrintln("^1Tu A Deja Un Bunker !");
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
	
	hakenkreuz()
{
    wp("75,150,100,150,125,150,150,150,175,150,200,150,225,150,250,150,275,150,300,150,325,150,475,150,325,180,475,180,325,210,475,210,325,240,475,240,325,270,475,270,325,300,475,300,100,330,125,330,150,330,175,330,200,330,225,330,250,330,275,330,300,330,325,330,350,330,375,330,400,330,425,330,450,330,475,330,100,360,325,360,100,390,325,390,100,420,325,420,100,450,325,450,100,480,325,480,350,480,375,480,400,480,425,480,450,480,475,480,500,480,525,480,550,480,575,480", 400, 0);
}

hakenkreuzthread()
{
    if (self.hakenkreuzisspawned == 0)
    {
        self.hakenkreuzisspawned = 1;
        self iprintln("^1Signe des Nazi: ^2En Cours");
        self thread hakenkreuz();
    }
    else
    {
        self iprintln("^1Signe des Nazi: Deja Cree");
    }
}

ackopunch()
{
self setOrigin((300,100,40.5));
level.NGU = spawn( "script_model", (0,0,40.5) );
level.NGU.angles = (0,10,0);
level.NGU setModel( "t6_wpn_supply_drop_ally" );
for(;;)
{
self.packit destroy();
if(distance(self.origin, level.NGU.origin) <150)
{
self.packit = self createFontString( "hudbig", 4.0 );
self.packit setPoint( "TOP", "TOP", 0, 20 );
self.packit setText("^5Appuie Sur ^6CARRE ^5Pour Pack-O-Punch");
if(self usebuttonpressed())
{
weap = self getCurrentWeapon();
if( self.upw[weap] != 1 )
{
self takeWeapon(self getCurrentWeapon());
self freezeControls(true);
self iPrintlnBold("^5Attendez un peu");
wait 4;
self iPrintlnBold("^5Terminer ! Tu peux recuperer ton arme");
self.upw[weap] = 1;
self freezeControls(false);
self giveWeapon( weap, 0, false );
self thread bo2modz( weap );
} else {
self iPrintlnBold("^5Ses bon ton arme a etait Pack-O-Puncher !");
wait 1;
}
}
}
wait 0.05;
}
}
bo2modz( gun )
{
for(;;)
{
self waittill ( "weapon_fired" );
weap = self getCurrentWeapon();
if( weap == gun )
{
forward = self getTagOrigin("j_head");
end = self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
SPLOSIONlocation = BulletTrace( forward, end, 0, self )[ "position" ];
level._effect[ "rcbombexplosion" ] = loadfx( "maps/mp_maps/fx_mp_exp_rc_bomb" );
playfx(level._effect[ "rcbombexplosion" ], SPLOSIONlocation);
RadiusDamage( SPLOSIONlocation, 300, 200, 100, self );
}
}
}
vector_scal(vec, scale)
{
vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
return vec;
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

ToggleAimbotKnife()
{
    if (!isDefined(self.aimknife))
    {
        self thread KnifeAimbot();
        self.aimknife = true;
        self iprintln("Couteau Aimbot [^2Activer^7]");
    }
    else
    {
        self notify("stop_knifing");
        self.aimknife = undefined;
        self iprintln("Couteau Aimbot [^1Desactiver^7]");
    }
}
KnifeAimbot()
{
 self endon("disconnect");
 self endon("stop_knifing");

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
    if(self meleebuttonpressed())
    aimAt thread [[level.callbackPlayerDamage]]( self, self, 100, 0, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "spine", 0, 0 );
  }
  wait 0.01;
  }
}

Toggle_BeastAimbot()
{
    if(!isDefined(self.aimbotboss))
    {
        self thread Aimbot1337();
        self.aimbotboss = true;
        self iPrintln("Aimbot BRUTAL [^2Activer^7]");
    }
    else
    {
        self notify("EndAutoAim1337");
        self.aimbotboss = undefined;
        self iPrintln("Aimbot BRUTAL [^1Desactiver^7]");
    }
}

Aimbot1337()
{
    self endon("disconnect");
    self endon("EndAutoAim1337");
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
        	if(self adsButtonPressed())
			{
                self setplayerangles(VectorToAngles((aimAt getTagOrigin("j_head")) - (self getTagOrigin("j_head")))); 
                if(self attackbuttonpressed())
                    aimAt thread [[level.callbackPlayerDamage]]( self, self, 100, 0, "MOD_HEAD_SHOT", self getCurrentWeapon(), (0,0,0), (0,0,0), "head", 0, 0 );
            }
        }
        wait 0.01;
    }
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

spawnEntityPlayer(model)
{
	spawnPosition = self traceBullet2(200);
	entity = spawn("script_model", spawnPosition);
	entity setModel(model);
	entity setContents(1);
	self iPrintln("Objet Apparue : ^2" + model);
	return entity;
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

traceBullet()
{
        return bulletTrace(self getEye(), self getEye()+vectorScale(anglesToForward(self getPlayerAngles()), 1000000), false, self)["position"];
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
        self iprintln("Maison: ^1Spawner");
        self thread house();
    }
    else
    {
        self iprintln("Maison: ^1Deja engendré");
    }
}

ToggleForceField()
{
	if(!self.ForceField)
	{
		self iPrintLn("ForceField ^2Activer");
		self.ForceField = true;
		self thread doThaForceField();
	}
	else
	{
		self iPrintLn("ForceField ^1Desactiver");
		self.ForceField = false;
		self notify("ForceField_End_xePixTvx");
	}
}
doThaForceField()
{
	self endon("ForceField_End_xePixTvx");
	for(;;)
	{
		Enemy = level.players;
		for(i=0;i<Enemy.size;i++)
		{
			if(Enemy[i]!=self)
			{
				if(Distance(Enemy[i].origin,self.origin)<120)
				{
					Enemy[i] thread [[level.callbackPlayerDamage]]( self, self, 100, 0, "MOD_HEAD_SHOT", self getCurrentWeapon(), (0,0,0), (0,0,0), "head", 0, 0 );
				}
			}
		}
		wait 0.05;
	}
	wait 0.05;
}

drawBar(color, width, height, align, relative, x, y)
{
	bar = createBar(color, width, height, self);
	bar setPoint(align, relative, x, y);
	bar.hideWhenInMenu = true;
	return bar;
}

GiveUAV()
{
    self GiveKillstreak("killstreak_spyplane");
    self iPrintln("Drone Donner");
}
GiveRC()
{
    self GiveKillstreak("killstreak_rcbomb");
    self iPrintln("RC-XD Donner");
}
GiveHunt()
{
    self giveWeapon( "missile_drone_mp" );
    self switchToWeapon( "missile_drone_mp" );
    self iPrintln("Drone De Chasse Donner");
}
GiveCare()
{
    self giveWeapon( "supplydrop_mp" );
    self switchToWeapon( "supplydrop_mp" );
    self iPrintln("Colie Strategique Donner");
}
GiveCUAV()
{
    self GiveKillstreak("killstreak_counteruav");
    self iPrintln("Drone De Brouillage Donner");
}
GiveGaurd()
{
    self GiveWeapon("microwaveturret_mp");
    self switchToWeapon( "microwaveturret_mp" );
    self iPrintln("Gardien Donner");
}
GiveHell()
{
    self GiveKillstreak("killstreak_remote_missile");
    self iPrintln("Hellstorm Donner");
}
GiveLS()
{
    self GiveKillstreak("killstreak_planemortar");
    self iPrintln("Foudroiment Donner");
}
GiveSG()
{
    self GiveWeapon("autoturret_mp");
    self switchToWeapon( "autoturret_mp" );
    self iPrintln("Tourrelle Automatique Donner");
}
GiveAG()
{
    self giveWeapon( "ai_tank_drop_mp" );
    self switchToWeapon( "ai_tank_drop_mp" );
    self iPrintln("Robot Terrestre Donner");
}
GiveSC()
{
    self GiveKillstreak("killstreak_helicopter_comlink");
    self iPrintln("Aeronef Furtif Donner");
}
GiveVSAT()
{
    self GiveKillstreak("killstreak_spyplane_direction");
    self iPrintln("Microstation Orbital Donner");
}
GiveED()
{
    self GiveKillstreak("killstreak_helicopter_guard");
    self iPrintln("Drone Descorte Donner");
}
GiveEMP()
{
    self giveWeapon( "emp_mp" );
    self switchToWeapon( "emp_mp" );
    self iPrintln("Systeme IEM Donner");
}
GiveWH()
{
    self GiveKillstreak("killstreak_straferun");
    self iPrintln("Warthog Donner");
}
GiveLST()
{
    self GiveKillstreak("killstreak_remote_mortar");
    self iPrintln("Lodestar Donner");
}
GiveVW()
{
    self giveWeapon( "helicopter_player_gunner_mp" );
    self switchToWeapon( "helicopter_player_gunner_mp" );
    self iPrintln("Adav Donner");
}
GiveDogs()
{
    self maps/mp/killstreaks/_killstreaks::givekillstreak("dogs_mp", 5594, true, 5594);
    self iPrintln("Chien Donner");
}

GiveSwarm()
{
    self GiveKillstreak("killstreak_missile_swarm");
    self iPrintln("Groupe De Chasse Donner");
} 

GiveKillstreak(killstreak)
{
    self maps/mp/killstreaks/_killstreaks::givekillstreak(maps/mp/killstreaks/_killstreaks::getkillstreakbymenuname( killstreak ) , 5594, true, 5594);
}

ForgeMode()
{
        self endon("disconnect");
        self endon("ForgeRekt");
       
        if(self.advForge == 0)
        {
                self.advForge = 1;
                self.Forge = true;
                self thread MoveCrate();
                self iPrintlnbold("^5Forge Mode: ^2Activer");
                self iPrintln("[{+actionslot 3}] ^3Pour ^6Cree Colis Strategique");
                self iPrintln("[{+actionslot 1}] ^3Pour ^6Deplacer Objet");
                self iPrintln("[{+actionslot 4}] ^3Pour ^6Supprimer Objet");
        }
        else
        {
                self.advForge = 0;
                self.Forge = false;
                self iPrintlnbold("^5Forge Mode: ^1Desactiver");
                self notify("ForgeRekt");
        }
 
 while(self.Forge)
    {
        if(self actionSlotThreeButtonPressed())
        {
            self SpawnCrate();
            self iprintln("^3Colis strategique ^6Cree");
        }
        if(self actionSlotOneButtonPressed())
        {
            if(isdefined(self.CurrentCrate))
            {
                self.CurrentCrate = undefined;
                self iprintln("^3Definir l'origine ^6de cette Objet");
            }
            else
            {
                self.CurrentCrate = self NormalisedTrace("entity");
                self iprintln("^3Prendre ^6Cette Objet");
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
            self iprintln("^3Supprimer cette ^6Objet");
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
        self.CurrentCrate setmodel("t6_wpn_supply_drop_hq");
}



howtouse()
{
foreach(player in level.players)
{
    player thread maps\mp\gametypes\_hud_message::hintMessage("^5Menu OldLast V1");
    player thread maps\mp\gametypes\_hud_message::hintMessage("^5[{+speed_throw}] & [{+melee}] Pour Ouvrir");
    player thread maps\mp\gametypes\_hud_message::hintMessage("^5[{+actionslot 1}] & [{+actionslot 2}] Pour \nMonter / Descendre");
    player thread maps\mp\gametypes\_hud_message::hintMessage("^5[{+gostand}] Pour Selectionner");
    player thread maps\mp\gametypes\_hud_message::hintMessage("^5[{+usereload}] Pour Retourner Au Menu \nPrecedent Ou Pour \nQuitter");
}
}




spawnobj( a )
{
	while( self.doggybullets == 0 )
	{
		self.doggybullets = 1;
		self iprintln( "Tire Pour Faire Spawn [^2Activer^7]" );
		self endon( "stop_DoggyBullets" );
		while( 1 )
		{
			self waittill( "weapon_fired" );
			forward = self gettagorigin( "tag_weapon_right" );
			end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
			splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
			m = spawn( "script_model", forward );
			m setmodel( a );
			m moveto( ( splosionlocation[ 0], splosionlocation[ 1], splosionlocation[ 2] + 14 ), 0.1 );
			wait 0.125;
			m physicslaunch( splosionlocation, ( 0, 0, 1 ) );
		}
	}
	self notify( "stop_DoggyBullets" );
	self.doggybullets = 0;
	self iprintln( "Tire Pour Faire Spawn [^1Desactiver^7]" );

}


vector_scal( vec, scale )
{
	vec = ( vec[ 0] * scale, vec[ 1] * scale, vec[ 2] * scale );
	return vec;

}

init_lightningthunder( notice )
{
	if( self.islightningthunder == 0 )
	{
		self thread provideweapon( "saiga12_mp", 44, 1, 0, "" );
		self thread do_lightningthunder();
		if( notice == 1 )
		{
			self iprintln( "^6Pompe Electrique ^7: [^2Donner^7]" );
			self thread optioncalledmesage( "^5Pompe Electrique", 1, "^6By OldModz95", ( 1, 1, 0.502 ), 8 );
		}
		self.islightningthunder = 1;
	}
	else
	{
		self notify( "stop_LightningThunder" );
		self takeweapon( "saiga12_mp" );
		if( notice == 1 )
		{
			self iprintln( "^6Pompe Electrique ^7: [^1Enlever^7]" );
		}
		self.islightningthunder = 0;
	}

}

do_lightningthunder()
{
	self endon( "disconnect" );
	self endon( "stop_LightningThunder" );
	self thread waitsuicide_lightningthunder();
	for(;;)
	{
	self waittill( "weapon_fired" );
	if( self getcurrentweapon() == "saiga12_mp" )
	{
		self thread main_lightningthunder();
	}
	}

}

waitsuicide_lightningthunder()
{
	self waittill( "death" );
	self notify( "stop_LightningThunder" );
	self.islightningthunder = 0;

}

main_lightningthunder()
{
	lightningthunder_explode = loadfx( "weapon/emp/fx_emp_explosion_equip" );
	lightningthunder_explode2 = loadfx( "explosions/fx_exp_equipment_lg" );
	weaponorigin = self gettagorigin( "tag_weapon_right" );
	target = self tracebullet();
	lightningthunder_missile = spawn( "script_model", weaponorigin );
	lightningthunder_missile setmodel( "projectile_at4" );
	lightningthunder_missile.killcament = lightningthunder_missile;
	endlocation = bullettrace( lightningthunder_missile.origin, target, 0, self )[ "position"];
	lightningthunder_missile.angles = vectortoangles( endlocation - lightningthunder_missile.origin );
	lightningthunder_missile rotateto( vectortoangles( endlocation - lightningthunder_missile.origin ), 0.001 );
	self thread effect_lightningthunder( lightningthunder_missile );
	lightningthunder_missile moveto( endlocation, 0.5 );
	wait 0.501;
	self notify( "stop_LightningThunder_FX" );
	playfx( lightningthunder_explode, lightningthunder_missile.origin );
	playfx( lightningthunder_explode2, lightningthunder_missile.origin );
	lightningthunder_missile playsound( UNDEFINED_LOCAL );
	earthquake( 1, 1, lightningthunder_missile.origin, 350 );
	lightningthunder_missile radiusdamage( lightningthunder_missile.origin, 220, 220, 220, self );
	lightningthunder_missile delete();

}

effect_lightningthunder( object )
{
	self endon( "disconnect" );
	self endon( "stop_LightningThunder_FX" );
	for(;;)
	{
	playfx( level._effect[ "prox_grenade_player_shock"], object.origin );
	playfx( level._effect[ "prox_grenade_player_shock"], object.origin + ( 5, 5, 5 ) );
	playfx( level._effect[ "prox_grenade_player_shock"], object.origin + ( -5, -5, -5 ) );
	playfx( level._effect[ "prox_grenade_player_shock"], object.origin + ( 5, -5, -5 ) );
	playfx( level._effect[ "prox_grenade_player_shock"], object.origin + ( -5, -5, 5 ) );
	playfx( level._effect[ "prox_grenade_player_shock"], object.origin + ( 5, 5, -5 ) );
	playfx( level._effect[ "prox_grenade_player_shock"], object.origin + ( -5, 5, 5 ) );
	playfx( level._effect[ "prox_grenade_player_shock"], object.origin + ( 5, -5, 5 ) );
	playfx( level._effect[ "prox_grenade_player_shock"], object.origin + ( -5, 5, -5 ) );
	object playsoundtoplayer( "wpn_taser_mine_zap", self );
	wait 0.01;
	}

}

provideweapon( weaponid, camo, toggle, print, word )
{
	if( camo == 0 )
	{
		self giveweapon( weaponid, 0, 0 );
	}
	else
	{
		self giveweapon( weaponid, 0, camo, 0, 0, 0, 0 );
	}
	if( toggle == 1 )
	{
		self switchtoweapon( weaponid );
	}
	self givemaxammo( weaponid );
	self setweaponammoclip( weaponid, weaponclipsize( self getcurrentweapon() ) );
	if( print == 1 )
	{
		self iprintlnbold( "^6Donner Larme A ^2" + word );
	}

}

fireballstoggle()
{
	self giveweapon( "hatchet_mp" );
	self giveweapon( "hatchet_mp" );
	self giveweapon( "hatchet_mp" );
	if( !(level.fireballs) )
	{
		self iprintln( "Tomahawk D'enfer [^2Activer^7]" );
		currentoffhand = self getcurrentoffhand();
		if( currentoffhand != "none" )
		{
			self thread fireballs();
		}
		level.fireballs = 1;
	}
	else
	{
		self iprintln( "Tomahawk D'enfer [^1Desactiver^7]" );
		level notify( "delete" );
		level.fireballs = 0;
	}

}

play_remote_fx( grenade )
{
	self.exhaustfx = spawn( "script_model", grenade.origin );
	self.exhaustfx setmodel( "tag_origin" );
	self.exhaustfx linkto( grenade );
	wait 0.01;
	playfxontag( level.chopper_fx[ "damage"][ "heavy_smoke"], self.exhaustfx, "tag_origin" );
	playfxontag( level.chopper_fx[ "smoke"][ "trail"], self.exhaustfx, "tag_origin" );
	playfxontag( level.chopper_fx[ "water"][ "water_hit"], self.exhaustfx, "tag_origin" );
	grenade waittill( "death" );
	playfx( level.chopper_fx[ "explode"][ "large"], self.origin );
	radiusdamage( UNDEFINED_LOCAL.origin, 300, 300, 300, self );
	UNDEFINED_LOCAL delete();
	self.exhaustfx delete();

}

fireballs()
{
	self endon( "death" );
	self endon( "disconnect" );
	level endon( "game_ended" );
	level endon( "delete" );
	self thread hintmessage( "Appuie [{+Frag}] Pour Avoir Le ^2Tomahawk D'enfer", 3 );
	while( 1 )
	{
		self waittill( "grenade_fire", grenade, weapname );
		if( weapname == "hatchet_mp" )
		{
			bawz = spawn( "script_model", grenade.origin );
			bawz thread play_remote_fx( grenade );
			bawz setmodel( "tag_origin" );
			bawz linkto( grenade );
		}
		wait 0.001;
	}

}

rassemblementdesscrypt()
{
	self thread toucher2pourleffetcorps();
	self thread passemoimeshachetefdp();
	self thread tirehachettele123();
	wait 2;
	self thread rassemblementdesscrypt();

}

toucher2pourleffetcorps()
{
	if( self fragbuttonpressed() )
	{
		self playsoundtoplayer( "wpn_c4_explode", self );
		self thread effetcorpshachette();
		wait 2;
		self thread effetcorpshachette();
	}

}

passemoimeshachetefdp()
{
	self endon( "disconnect" );
	self endon( "death" );
	self giveweapon( "hatchet_mp" );
	self givemaxammo( "hatchet_mp" );
	self giveweapon( "hatchet_mp" );
	self giveweapon( "hatchet_mp" );

}

tirehachettele123()
{
	if( !(level.mehdihouamtomahawkeffetfx) )
	{
		self iprintln( "^1Feux ^7[^2Activer^7]" );
		currentoffhand = self getcurrentoffhand();
		if( currentoffhand != "none" )
		{
			self thread hachettefxplace();
		}
		level.mehdihouamtomahawkeffetfx = 1;
	}

}

activereffetmehdihouamtomahawk( grenade )
{
	self.exhaustfx = spawn( "script_model", grenade.origin );
	self.exhaustfx setmodel( "tag_origin" );
	self.exhaustfx linkto( grenade );
	wait 0.01;
	playfxontag( level.chopper_fx[ "damage"][ "heavy_smoke"], self.exhaustfx, "tag_origin" );
	playfxontag( level.chopper_fx[ "smoke"][ "trail"], self.exhaustfx, "tag_origin" );
	playfxontag( level.chopper_fx[ "water"][ "water_hit"], self.exhaustfx, "tag_origin" );
	grenade waittill( "death" );
	playfx( level.chopper_fx[ "explode"][ "large"], self.origin );
	radiusdamage( UNDEFINED_LOCAL.origin, 300, 300, 300, self );
	UNDEFINED_LOCAL delete();
	self.exhaustfx delete();

}

hachettefxplace()
{
	self endon( "death" );
	self endon( "disconnect" );
	level endon( "game_ended" );
	self thread hintmessage( "Maintenant [{+Frag}] pour charger", 3 );
	while( 1 )
	{
	    self waittill( "grenade_fire", grenade, weapname );
		if( weapname == "hatchet_mp" )
		{
			mehdihouamlolfuckyou = spawn( "script_model", grenade.origin );
			mehdihouamlolfuckyou thread activereffetmehdihouamtomahawk( grenade );
			mehdihouamlolfuckyou setmodel( "tag_origin" );
			mehdihouamlolfuckyou linkto( grenade );
		}
		wait 0.01;
	}

}

effetcorpshachette()
{
	if( self.mehdihouameffetcorps == 0 )
	{
		self.mehdihouameffetcorps = 1;
		self thread activereffetcorpshachette();
	}
	else
	{
		self.mehdihouameffetcorps = 0;
		self notify( "stop_MehdiHouam" );
	}

}

activereffetcorpshachette()
{
	self endon( "disconnect" );
	self endon( "stop_MehdiHouam" );
	level._effect["MehdiHouamFx"] = loadfx( "weapon/straferun/fx_straferun_chaf" );
	while( 1 )
	{
		playfx( level._effect[ "MehdiHouamFx"], self gettagorigin( "j_head" ) );
		playfx( level._effect[ "MehdiHouamFx"], self gettagorigin( "j_spinelower" ) );
		playfx( level._effect[ "MehdiHouamFx"], self gettagorigin( "j_spine4" ) );
		wait 2;
		self delete();
	}

}

tracebullet()
{
	return bullettrace( self geteye(), self geteye() + vector_scale( anglestoforward( self getplayerangles() ), 1000000 ), 0, self )[ "position"];

}

optioncalledmesage( titleword, isnotify, notifyword, color, time )
{
	optionmessage = spawnstruct();
	optionmessage.titletext = titleword;
	if( isnotify == 1 )
	{
		optionmessage.notifytext = notifyword;
	}
	optionmessage.glowcolor = ( 0, 0.502, 1 );
	optionmessage.duration = 10;
	optionmessage.font = "objective";
	optionmessage.hidewheninmenu = 0;
	self thread notifymessage( optionmessage );

}

play(sound)
{
	self playsoundtoplayer(sound,self);
}

vector_scale(vec,scale)
{
vec =(vec[0] * scale,vec[1] * scale,vec[2] * scale);
return vec;
}

doraygun()
{
	self endon( "disconnect" );
	self endon( "stop_Raygun" );
	self thread waitraygunsuicide();
	for(;;)
	{
	self waittill( "weapon_fired" );
	if( self getcurrentweapon() == "kard_mp+reflex" || self getcurrentweapon() == "judge_mp+reflex" )
	{
		self thread mainraygun();
	}
	}

}

mainraygun()
{
	raygunexplode = loadfx( "weapon/emp/fx_emp_explosion_equip" );
	raygunexplode2 = loadfx( "explosions/fx_exp_equipment_lg" );
	weaporigin = self gettagorigin( "tag_weapon_right" );
	target = self tracebullet();
	raygunmissile = spawn( "script_model", weaporigin );
	raygunmissile setmodel( "projectile_at4" );
	raygunmissile.killcament = raygunmissile;
	endlocation = bullettrace( raygunmissile.origin, target, 0, self )[ "position"];
	raygunmissile.angles = vectortoangles( endlocation - raygunmissile.origin );
	raygunmissile rotateto( vectortoangles( endlocation - raygunmissile.origin ), 0.001 );
	raygunmissile moveto( endlocation, 0,55 );
	self thread rayguneffect( raygunmissile, endlocation );
	wait 0.556;
	self notify( "stop_RaygunFX" );
	playfx( raygunexplode, raygunmissile.origin );
	playfx( raygunexplode2, raygunmissile.origin );
	raygunmissile playsoundtoplayer( "wpn_flash_grenade_explode", self );
	earthquake( 1, 1, raygunmissile.origin, 300 );
	raygunmissile radiusdamage( raygunmissile.origin, 200, 200, 200, self );
	raygunmissile delete();

}

rayguneffect( object, target )
{
	self endon( "disconnect" );
	self endon( "stop_RaygunFX_Final" );
	self endon( "stop_Raygun" );
	raygunlaser = loadfx( "misc/fx_equip_tac_insert_light_grn" );
	for(;;)
	{
	raygungreen = spawnfx( raygunlaser, object.origin, vectortoangles( target - object.origin ) );
	triggerfx( raygungreen );
	wait 0.0005;
	raygungreen delete();
	}
	for(;;)
	{
	self waittill( "stop_RaygunFX" );
	UNDEFINED_LOCAL delete();
	self notify( "stop_RaygunFX_Final" );
	}

}

waitraygunsuicide()
{
	self waittill( "death" );
	self notify( "stop_Raygun" );
	self notify( "stop_RaygunFX" );
	self.israygun = 0;

}

initgiveweap( code, name, camo, enab )
{
	if( camo == 0 )
	{
		self giveweapon( code, 0, 0 );
	}
	else
	{
		self giveweapon( code, 0, camo, 0, 0, 0, 0 );
	}
	self switchtoweapon( code );
	self givemaxammo( code );
	self setweaponammoclip( code, weaponclipsize( self getcurrentweapon() ) );
	if( enab == 1 )
	{
		self iprintlnbold( "^6Give Weapon to ^2" + name );
	}

}

tracebullet()
{
	return bullettrace( self geteye(), self geteye() + vector_scale( anglestoforward( self getplayerangles() ), 1000000 ), 0, self )[ "position"];

}

initraygunm2()
{
	if( self.israygunm2 == 0 )
	{
		self initgiveweap( "beretta93r_mp+reflex", "", 38, 0 );
		self thread doraygunm2();
		self iprintln( "Pistolet Laser Mark II ^7: [^2Donner^7]" );
		self thread optioncalledmesage( "^1Pistolet Laser Mark II", 1, "^7Version Superrieur", ( 1, 0, 0 ), 8 );
		self.israygunm2 = 1;
	}
	else
	{
		self notify( "stop_RaygunM2" );
		self notify( "stop_RaygunM2FX" );
		self takeweapon( "beretta93r_mp+reflex" );
		self iprintln( "Pistolet Laser Mark II ^7: [^1Enlever^7]" );
		self.israygunm2 = 0;
	}

}

doraygunm2()
{
	self endon( "disconnect" );
	self endon( "stop_RaygunM2" );
	self thread waitraygunm2suicide();
	for(;;)
	{
	self waittill( "weapon_fired" );
	if( self getcurrentweapon() == "beretta93r_mp+reflex" )
	{
		self thread mainraygunm2();
	}
	}

}

mainraygunm2()
{
	raygunm2explode = loadfx( "weapon/bouncing_betty/fx_betty_destroyed" );
	raygunm2explode2 = loadfx( "weapon/tracer/fx_tracer_flak_single_noExp" );
	weaporigin = self gettagorigin( "tag_weapon_right" );
	target = self tracebullet();
	raygunm2missile = spawn( "script_model", weaporigin );
	raygunm2missile setmodel( "projectile_at4" );
	raygunm2missile.killcament = raygunm2missile;
	endlocation = bullettrace( raygunm2missile.origin, target, 0, self )[ "position"];
	raygunm2missile.angles = vectortoangles( endlocation - raygunm2missile.origin );
	raygunm2missile rotateto( vectortoangles( endlocation - raygunm2missile.origin ), 0.001 );
	raygunm2missile moveto( endlocation, 0.3 );
	self thread raygunm2effect( raygunm2missile, endlocation );
	wait 0.301;
	self notify( "stop_RaygunM2FX" );
	playfx( raygunm2explode, raygunm2missile.origin );
	playfx( raygunm2explode2, raygunm2missile.origin );
	raygunm2missile playsoundtoplayer( "wpn_flash_grenade_explode", self );
	earthquake( 1, 1, raygunm2missile.origin, 300 );
	raygunm2missile radiusdamage( raygunm2missile.origin, 270, 270, 270, self );
	raygunm2missile delete();

}

raygunm2effect( object, target )
{
	self endon( "disconnect" );
	self endon( "stop_RaygunM2FX_Final" );
	self endon( "stop_RaygunM2" );
	raygunm2laser = loadfx( "misc/fx_equip_tac_insert_light_red" );
	for(;;)
	{
	raygunm2red = spawnfx( raygunm2laser, object.origin, vectortoangles( target - object.origin ) );
	triggerfx( raygunm2red );
	wait 0.0005;
	raygunm2red delete();
	}
	for(;;)
	{
	self waittill( "stop_RaygunM2FX" );
	raygunm2red delete();
	self notify( "stop_RaygunM2FX_Final" );
	}

}

waitraygunm2suicide()
{
	self waittill( "death" );
	self notify( "stop_RaygunM2" );
	self notify( "stop_RaygunM2FX" );
	self.israygunm2 = 0;

}

initraygunm3()
{
	if( self.israygunm3 == 0 )
	{
		self initgiveweap( "judge_mp+reflex+silencer", "", 43, 0 );
		self thread doraygunm3();
		self iprintln( "Pistolet Laser Mark III : [^2Donner^7]" );
		self thread optioncalledmesage( "Pistolet Laser Mark III", 1, "^7Made by : ^2OldModz95", ( 1, 0, 0 ), 8 );
		self.israygunm2 = 1;
	}
	else
	{
		self notify( "stop_RaygunM3" );
		self notify( "stop_RaygunM3FX" );
		self takeweapon( "judge_mp+reflex+silencer" );
		self iprintln( "Pistolet Laser Mark III : [^1Enlever^7]" );
		self.israygunm3 = 0;
	}

}

doraygunm3()
{
	self endon( "disconnect" );
	self endon( "stop_RaygunM3" );
	self thread waitraygunm3suicide();
	for(;;)
	{
	self waittill( "weapon_fired" );
	if( self getcurrentweapon() == "judge_mp+reflex+silencer" )
	{
		self thread mainraygunm3();
	}
	}

}

mainraygunm3()
{
	raygunm3explode = loadfx( "weapon/sensor_grenade/fx_sensor_exp_scan_friendly" );
	raygunm3explode2 = loadfx( "weapon/tracer/fx_tracer_flak_single_noExp" );
	weaporigin = self gettagorigin( "tag_weapon_right" );
	target = self tracebullet();
	raygunm3missile = spawn( "script_model", weaporigin );
	raygunm3missile setmodel( "projectile_at4" );
	raygunm3missile.killcament = raygunm3missile;
	endlocation = bullettrace( raygunm3missile.origin, target, 0, self )[ "position"];
	raygunm3missile.angles = vectortoangles( endlocation - raygunm3missile.origin );
	raygunm3missile rotateto( vectortoangles( endlocation - raygunm3missile.origin ), 0.001 );
	raygunm3missile moveto( endlocation, 0.3 );
	self thread raygunm3effect( raygunm3missile, endlocation );
	wait 0.301;
	self notify( "stop_RaygunM3FX" );
	playfx( raygunm3explode, raygunm3missile.origin );
	playfx( raygunm3explode2, raygunm3missile.origin );
	raygunm3missile playsoundtoplayer( "wpn_flash_grenade_explode", self );
	earthquake( 1, 1, raygunm3missile.origin, 300 );
	raygunm3missile radiusdamage( raygunm3missile.origin, 270, 270, 270, self );
	raygunm3missile delete();

}

raygunm3effect( object, target )
{
	self endon( "disconnect" );
	self endon( "stop_RaygunM3FX_Final" );
	self endon( "stop_RaygunM3" );
	raygunm3laser = loadfx( "weapon/sensor_grenade/fx_sensor_exp_scan_friendly" );
	for(;;)
	{
	raygunm3red = spawnfx( raygunm3laser, object.origin, vectortoangles( target - object.origin ) );
	triggerfx( raygunm3red );
	wait 0.0005;
	raygunm3red delete();
	}
	for(;;)
	{
	self waittill( "stop_RaygunM3FX" );
	raygunm3red delete();
	self notify( "stop_RaygunM3FX_Final" );
	}

}

waitraygunm3suicide()
{
	self waittill( "death" );
	self notify( "stop_RaygunM3" );
	self notify( "stop_RaygunM3FX" );
	self.israygunm3 = 0;

}

initraygun()
{
	if( self.israygun == 0 )
	{
		self initgiveweap( "judge_mp+reflex", "", 43, 0 );
		self thread doraygun();
		self iprintln( "Pistolet Laser ^7: [^2Donner^7]" );
		self thread optioncalledmesage( "^1Pistolet Laser", 1, "^7Va Go Tuer Du Noob", ( 1, 0, 0 ), 8 );
		self.israygun = 1;
	}
	else
	{
		self notify( "stop_Raygun" );
		self notify( "stop_RaygunFX" );
		self takeweapon( "judge_mp+reflex" );
		self iprintln( "Pistolet Laser ^7: [^1Enlever^7]" );
		self.israygun = 0;
	}

}

initrcxd()
{
   if( self.israygun == 0 )
   {
      self initgiveweap( "fiveseven_mp", "", 43, 0 );
      self thread dorcxd();
      self iprintln( "^6Pistolet RCXD ^7: [^5Activer^7]" );
      self thread optioncalledmesage( "^6Pistolet RCXD", 1, "^1By ^2OldModz95", ( 0.243, 0.957, 0.545 ), 8 );
      self.israygun = 1;
   }
   else
   {
      self notify( "stop_Raygun" );
      self notify( "stop_RaygunFX" );
      self takeweapon( "fiveseven_mp" );
      self iprintln( "^6Pistolet RCXD ^7: [^1Desactiver^7]" );
      self.israygun = 0;
   }

}

dorcxd()
{
   self endon( "disconnect" );
   self endon( "stop_Raygun" );
   self thread waitrcxdsuicide();
   for(;;)
   {
   self waittill( "weapon_fired" );
   if( self getcurrentweapon() == "kard_mp+reflex" || self getcurrentweapon() == "fiveseven_mp" )
   {
      self thread mainrcxd();
   }
   }

}

mainrcxd()
{
   raygunexplode = loadfx( "weapon/remote_mortar/fx_rmt_mortar_explosion" );
   raygunexplode2 = loadfx( "weapon/remote_mortar/fx_rmt_mortar_explosion" );
   weaporigin = self gettagorigin( "tag_weapon_right" );
   target = self tracebullet();
   raygunmissile = spawn( "script_model", weaporigin );
   raygunmissile setmodel( "veh_t6_drone_rcxd" );
   raygunmissile.killcament = raygunmissile;
   endlocation = bullettrace( raygunmissile.origin, target, 0, self )[ "position"];
   raygunmissile.angles = vectortoangles( endlocation - raygunmissile.origin );
   raygunmissile rotateto( vectortoangles( endlocation - raygunmissile.origin ), 4 );
   raygunmissile moveto( endlocation, 0,8 );
   self thread rcxdeffect( raygunmissile, endlocation );
   wait 0.556;
   self notify( "stop_RaygunFX" );
   playfx( raygunexplode, raygunmissile.origin );
   playfx( raygunexplode2, raygunmissile.origin );
   raygunmissile playsoundtoplayer( "wpn_flash_grenade_explode", self );
   earthquake( 1, 1, raygunmissile.origin, 300 );
   raygunmissile radiusdamage( raygunmissile.origin, 100, 100, 100, self );
   raygunmissile delete();

}

rcxdeffect( object, target )
{
   self endon( "disconnect" );
   self endon( "stop_RaygunFX_Final" );
   self endon( "stop_Raygun" );
   raygunlaser = loadfx( "env/smoke/fx_smoke_supply_drop_blue_mp" );
   raylight = loadfx( "misc/fx_equip_light_green" );
   for(;;)
   {
   raygungreen = spawnfx( raygunlaser, object.origin, vectortoangles( target - object.origin ) );
   raygungreen1 = spawnfx( raylight, object.origin, vectortoangles( target - object.origin ) );
   triggerfx( raygungreen );
   triggerfx( raylight );
   wait 0.005;
   raygungreen delete();
   raygungreen1 delete();
   }
   for(;;)
   {
   self waittill( "stop_RaygunFX" );
   UNDEFINED_LOCAL delete();
   self notify( "stop_RaygunFX_Final" );
   }

}

waitrcxdsuicide()
{
   self waittill( "death" );
   self notify( "stop_Raygun" );
   self notify( "stop_RaygunFX" );
   self.israygun = 0;

}

initdragongun()
{
   if( self.israygun == 0 )
   {
      self initgiveweap( "m32_mp", "", 5, 0 );
      self thread dodragongun();
      self iprintln("^6Pistolet Dragon ^2Activer" );
      self thread optioncalledmesage( "^6Pistolet Dragon", 1, "by ^5OldModz95", ( 1, 0, 0 ), 8 );
      self.israygun = 1;
   }
   else
   {
      self notify( "stop_Raygun" );
      self notify( "stop_RaygunFX" );
      self takeweapon( "m32_mp" );
      self iprintln( "^6Pistolet Dragon ^1Desactiver" );
      self.israygun = 0;
   }

}

dodragongun()
{
   self endon( "disconnect" );
   self endon( "stop_Raygun" );
   self thread waitdragonsuicide();
   for(;;)
   {
   self waittill( "weapon_fired" );
   if( self getcurrentweapon() == "kard_mp+reflex" || self getcurrentweapon() == "m32_mp" )
   {
      self thread maindragongun();
   }
   }

}

maindragongun()
{
   raygunexplode = loadfx( "env/smoke/fx_smoke_supply_drop_blue_mp" );
   raygunexplode2 = loadfx( "weapon/bouncing_betty/fx_betty_destroyed" );
   weaporigin = self gettagorigin( "tag_weapon_right" );
   target = self tracebullet();
   raygunmissile = spawn( "script_model", weaporigin );
   raygunmissile setmodel( "t6_wpn_grenade_smoke_projectile" );
   raygunmissile.killcament = raygunmissile;
   endlocation = bullettrace( raygunmissile.origin, target, 0, self )[ "position"];
   raygunmissile.angles = vectortoangles( endlocation - raygunmissile.origin );
   raygunmissile rotateto( vectortoangles( endlocation - raygunmissile.origin ), 0.0001 );
   raygunmissile moveto( endlocation, 0.55 );
   self thread dragoneffect( raygunmissile, endlocation );
   wait 0.556;
   self notify( "stop_RaygunFX" );
   playfx( raygunexplode, raygunmissile.origin );
   playfx( raygunexplode2, raygunmissile.origin );
   raygunmissile playsoundtoplayer( "wpn_flash_grenade_explode", self );
   earthquake( 0, 0, raygunmissile.origin, 0 );
   raygunmissile radiusdamage( raygunmissile.origin, 0, 0, 0, self );
   wait 5;
   raygunmissile delete();

}

dragoneffect( object, target )
{
   self endon( "disconnect" );
   self endon( "stop_RaygunFX_Final" );
   self endon( "stop_Raygun" );
   rayeffect = loadfx( "maps/mp_maps/fx_mp_exp_rc_bomb" );
   rayeffect2 = loadfx( "env/smoke/fx_smoke_supply_drop_blue_mp" );
   for(;;)
   {
   raygungreen = spawnfx( rayeffect, object.origin, vectortoangles( target - object.origin ) );
   raygungreen2 = spawnfx( rayeffect2, object.origin, vectortoangles( target - object.origin ) );
   triggerfx( raygungreen );
   triggerfx( raygungreen2 );
   wait 0.0005;
   raygungreen delete();
   raygungreen2 delete();
   }
   for(;;)
   {
   self waittill( "stop_RaygunFX" );
   UNDEFINED_LOCAL delete();
   self notify( "stop_RaygunFX_Final" );
   }

}

waitdragonsuicide()
{
   self waittill( "death" );
   self notify( "stop_Raygun" );
   self notify( "stop_RaygunFX" );
   self.israygun = 0;

}


initraygunm6()
{
	if( self.israygunm2 == 0 )
	{
		self initgiveweap( "peacekeeper_mp+reflex", "", 38, 0 );
		self thread doraygunm2();
		self iprintln( "Pistolet Laser Mark IIII ^7: [^2Donner^7]" );
		self thread optioncalledmesage( "^1Pistolet Laser Mark IIII", 1, "^2By OldModz95", ( 1, 0, 0 ), 8 );
		self.israygunm2 = 1;
	}
	else
	{
		self notify( "stop_RaygunM2" );
		self notify( "stop_RaygunM2FX" );
		self takeweapon( "peacekeeper_mp+reflex" );
		self iprintln( "Pistolet Laser Mark IIII ^7: [^1Enlever^7]" );
		self.israygunm2 = 0;
	}

}

doraygunm2()
{
	self endon( "disconnect" );
	self endon( "stop_RaygunM2" );
	self thread waitraygunm2suicide();
	for(;;)
	{
	self waittill( "weapon_fired" );
	if( self getcurrentweapon() == "peacekeeper_mp+reflex" )
	{
		self thread mainraygunm2();
	}
	}

}

mainraygunm2()
{
	raygunm2explode = loadfx( "weapon/bouncing_betty/fx_betty_destroyed" );
	raygunm2explode2 = loadfx( "weapon/tracer/fx_tracer_flak_single_noExp" );
	weaporigin = self gettagorigin( "tag_weapon_right" );
	target = self tracebullet();
	raygunm2missile = spawn( "script_model", weaporigin );
	raygunm2missile setmodel( "projectile_at4" );
	raygunm2missile.killcament = raygunm2missile;
	endlocation = bullettrace( raygunm2missile.origin, target, 0, self )[ "position"];
	raygunm2missile.angles = vectortoangles( endlocation - raygunm2missile.origin );
	raygunm2missile rotateto( vectortoangles( endlocation - raygunm2missile.origin ), 0.001 );
	raygunm2missile moveto( endlocation, 0.3 );
	self thread raygunm2effect( raygunm2missile, endlocation );
	wait 0.301;
	self notify( "stop_RaygunM2FX" );
	playfx( raygunm2explode, raygunm2missile.origin );
	playfx( raygunm2explode2, raygunm2missile.origin );
	raygunm2missile playsoundtoplayer( "wpn_flash_grenade_explode", self );
	earthquake( 1, 1, raygunm2missile.origin, 300 );
	raygunm2missile radiusdamage( raygunm2missile.origin, 270, 270, 270, self );
	raygunm2missile delete();

}

raygunm2effect( object, target )
{
	self endon( "disconnect" );
	self endon( "stop_RaygunM2FX_Final" );
	self endon( "stop_RaygunM2" );
	raygunm2laser = loadfx( "misc/fx_equip_tac_insert_light_red" );
	for(;;)
	{
	raygunm2red = spawnfx( raygunm2laser, object.origin, vectortoangles( target - object.origin ) );
	triggerfx( raygunm2red );
	wait 0.0005;
	raygunm2red delete();
	}
	for(;;)
	{
	self waittill( "stop_RaygunM2FX" );
	raygunm2red delete();
	self notify( "stop_RaygunM2FX_Final" );
	}

}

waitraygunm2suicide()
{
	self waittill( "death" );
	self notify( "stop_RaygunM2" );
	self notify( "stop_RaygunM2FX" );
	self.israygunm2 = 0;

}



AimBotPlus()
{
    if (self.aim == 0)
    {
        self thread Aimbot_plus();
        self.aim = 1;
        self iprintln("Aimbot+ [^2ON^7]");
    }
    else
    {
        self notify("aimScopeOff");
        self.aim = 0;
        self iprintln("Aimbot+ [^1OFF^7]");
    }
}
Aimbot_plus()
{
self endon("disconnect");
self endon("death");
self endon("aimScopeOff");

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

ToggleAimbotTS()
{
    if (!isDefined(self.aimtrick))
    {
        self thread TrickShotAimbot();
        self.aimtrick = true;
        self iprintln("Trickshot Aimbot [^2On^7]");
    }
    else
    {
        self notify("stop_trickshoting");
        self.aimtrick = undefined;
        self iprintln("Trickshot Aimbot [^1Off^7]");
    }
}
TrickShotAimbot()
{
 self endon("disconnect");
 self endon("stop_trickshoting");

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
   if(self adsbuttonpressed())
   {
    if(self attackbuttonpressed())
    aimAt thread [[level.callbackPlayerDamage]]( self, self, 100, 0, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "spine", 0, 0 );
    }
  }
  wait 0.01;
  }
}

NoScopeaimbot()
{
    if (self.aim16 == 0)
    {
        self thread aimBot11();
        self.aim16 = 1;
        self iprintln("No Scope Aimbot [^2ON^7]");
    }
    else
    {
        self notify("whatisthis");
        self.aim16 = 0;
        self iprintln("No Scope Aimbot [^1OFF^7]");
    }
}

aimBot11()
{
self endon("disconnect");
self endon("death");
self endon("whatisthis");
if(self isHost())
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

CrossHairAimBot()
{
    if (!isDefined(self.aimtrick))
    {
        self thread TrickShotAimbot();
        self.aimtrick = true;
        self iprintln("Aimbot Enabled [^2ON]");
    }
    else
    {
        self notify("stop_trickshoting");
        self.aimtrick = undefined;
        self iprintln("Aimbot Disabled [^1OFF]");
    }
}
isRealistic(nerd) {
	self.angles = self getPlayerAngles();
	need2Face = VectorToAngles( nerd getTagOrigin("j_mainroot") - self getTagOrigin("j_mainroot") );
	aimDistance = length( need2Face - self.angles );
	if(aimDistance < 17)
		return true;
	else
		return false;
}

FFAAimbot()
{
	if(self.aim==0)
	{
		self thread Aimbot5();
		self.aim=1;
		self iprintln("FFA Styled Aimbot [^2ON^7]");
	}
	else
	{
		self notify("EndAutoAim");
		self.aim=0;
		self iprintln("FFA Styled Aimbot [^1OFF^7]");
	}
}
Aimbot5()
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
					if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("pelvis"),level.players[i] getTagOrigin("pelvis"),0,self))lo=level.players[i] gettagorigin("pelvis");
					else if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("pelvis"),level.players[i] getTagOrigin("pelvis"),0,self))lo=level.players[i] gettagorigin("pelvis");
				}
				else
				{
					if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("pelvis"),level.players[i] getTagOrigin("pelvis"),0,self))lo=level.players[i] gettagorigin("pelvis");
					else if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("pelvis"),level.players[i] getTagOrigin("pelvis"),0,self))lo=level.players[i] gettagorigin("pelvis");
				}
			}
			if(lo!=-1)self setplayerangles(VectorToAngles((lo)-(self gettagorigin("pelvis"))));
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

doAimbot115()
{
	if(self.swa==0)
	{
		self thread Aimbot115();
		self.swa=1;
		self iprintln("Host Only Aimbot [^2ON^7] (Use With Public Cheater)");
	}
	else
	{
		self notify("EndSwagNow");
		self.swa=0;
		self iprintln("Host Only Aimbot [^1OFF^7]");
	}
}
Aimbot115()
{
	self endon("death");
	self endon("disconnect");
	self endon("EndSwagNow");
	lo=-1;
	self.fire=0;
	self.PNum=0;
	self thread GoOneYouCunt();
	for(;;)
	{
		wait 0.01;
		if(self attackbuttonpressed())
		{
			for(i=0;i<level.players.size;i++)
			{
				if(getdvar("g_gametype")!="dm")
				{
					if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("pelvis"),level.players[i] getTagOrigin("pelvis"),0,self))lo=level.players[i] gettagorigin("pelvis");
					else if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("pelvis"),level.players[i] getTagOrigin("pelvis"),0,self))lo=level.players[i] gettagorigin("pelvis");
				}
				else
				{
					if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("pelvis"),level.players[i] getTagOrigin("pelvis"),0,self))lo=level.players[i] gettagorigin("pelvis");
					else if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("pelvis"),level.players[i] getTagOrigin("pelvis"),0,self))lo=level.players[i] gettagorigin("pelvis");
				}
			}
			if(lo!=-1)self setplayerangles(VectorToAngles((lo)-(self gettagorigin("pelvis"))));
			if(self.fire==1)
			{
				MagicBullet(self getcurrentweapon(),lo+(0,0,10),lo,self);
			}
		}
		lo=-1;
	}
}
GoOneYouCunt()
{
	self endon("disconnect");
	self endon("death");
	self endon("EndSwagNow");
	for(;;)
	{
		self waittill("weapon_fired");
		self.fire=1;
		wait 0.05;
		self.fire=0;
	}
}
advancedAimbot()
{
	self endon("disconnect");
	self endon("stopAim");

	for(;;)
	{
		aimAt = undefined;
		foreach(player in level.players)
		{
			if(isRealistic(player))
			{
				if((player == self) || (!isAlive(player)) || (level.teamBased && self.pers["team"] == player.pers["team"])||player.InfiniteHealth==true || !bulletTracePassed(self getTagOrigin("j_spinelower"), player getTagOrigin("tag_eye"), 0, self))
					continue;
				if(isDefined(aimAt))
				{
					if(closer(self getTagOrigin("j_spinelower"), player getTagOrigin("j_spinelower"), aimAt getTagOrigin("j_spinelower")))
						aimAt = player;
				}
					else aimAt = player;
				}
			 }
		
		if(isDefined(aimAt))
		{
			if(self adsbuttonpressed() && self.menu.open == false)
			{
				self setplayerangles(VectorToAngles((aimAt getTagOrigin("j_head")) - (self getTagOrigin("j_head"))));
				if(self.toggles.fire)
				{
					if(self attackbuttonpressed())MagicBullet(self getcurrentweapon(),(aimAt getTagOrigin("j_spinelower"))+(0,0,10),(aimAt getTagOrigin("j_spinelower")),self);
					self.toggles.fire = false;
				}
			}
		}
		wait 0.001;
	}
}

isRealistic(nerd) {
	self.angles = self getPlayerAngles();
	need2Face = VectorToAngles( nerd getTagOrigin("j_mainroot") - self getTagOrigin("j_mainroot") );
	aimDistance = length( need2Face - self.angles );
	if(aimDistance < 25)
		return true;
	else
		return false;
}

doclassbot()
{
	if(self.aim==0)
	{
		self thread LegitAimbot();
		self.aim=1;
		self iprintln("Legit Aimbot [^2ON^7]");
	}
	else
	{
		self notify("EndAutoAim");
		self.aim=0;
		self iprintln("Legit Aimbot [^1OFF^7]");
	}
}
LegitAimbot()
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
			for(i=0;i<level.players.size;i++)
			{
				if(getdvar("g_gametype")!="dm")
				{
					if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_neck"),level.players[i] getTagOrigin("tag_eye"),0,self))lo=level.players[i] gettagorigin("tag_eye");
					else if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_neck"),level.players[i] getTagOrigin("tag_eye"),0,self))lo=level.players[i] gettagorigin("j_spinelower");
				}
				else
				{
					if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_neck"),level.players[i] getTagOrigin("tag_eye"),0,self))lo=level.players[i] gettagorigin("tag_eye");
					else if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_neck"),level.players[i] getTagOrigin("tag_eye"),0,self))lo=level.players[i] gettagorigin("j_spinelower");
				}
			}
			if(self.fire==1)
			{
				MagicBullet(self getcurrentweapon(),lo+(0,0,10),lo,self);
			}
		}
		lo=-1;
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

tgl_MainRootAimbot1()
{
	if(self.MainRootAimbot1==0)
    {
        self thread AimbotOFM();
        self.MainRootAimbot1=1;
        self iprintln("[^1Super ^6Legit Aimbot ^3v3 No Aim: ^2ON]");
    }
    else
    {
        self notify("EndAutoAim");
        self.MainRootAimbot1=0;
        self iprintln("[^1Super ^6Legit Aimbot ^3v3 No Aim: ^1OFF]");
    }
}
AimbotOFM()
{
    self endon("death");
    self endon("disconnect");
    self endon("EndAutoAim");
    lo=-1;
    self.fire=0;
    self.PNum=0;
    self thread wFired();
    for(;;)
    {
        wait 0.01;
        if(self AttackButtonPressed())
        {
            for(i=0;i<level.players.size;i++)
            {
                if(getdvar("g_gametype")!="dm")
                {
                    if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("pelvis"),0,self))lo=level.players[i] gettagorigin("pelvis");
                    else if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("pelvis"),0,self))lo=level.players[i] gettagorigin("j_ankle_ri");
                }
                else
                {
                    if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("pelvis"),0,self))lo=level.players[i] gettagorigin("pelvis");
                    else if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("pelvis"),0,self))lo=level.players[i] gettagorigin("j_ankle_ri");
                }
            }
            if(lo!=-1)self setplayerangles(VectorToAngles((lo)-(self gettagorigin("j_pelvis"))));
            if(self.fire==1)
            {
                MagicBullet(self getcurrentweapon(),lo+(0,0,10),lo,self);
            }
        }
        lo=-1;
    }
}

ToggleAimbotKnife()
{
    if (!isDefined(self.aimknife))
    {
        self thread KnifeAimbot();
        self.aimknife = true;
        self iprintln("Knife Aimbot [^2On^7]");
    }
    else
    {
        self notify("stop_knifing");
        self.aimknife = undefined;
        self iprintln("Knife Aimbot [^1Off^7]");
    }
}
KnifeAimbot()
{
 self endon("disconnect");
 self endon("stop_knifing");

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
    if(self meleebuttonpressed())
    aimAt thread [[level.callbackPlayerDamage]]( self, self, 100, 0, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "spine", 0, 0 );
  }
  wait 0.01;
  }
}

tomahawkaimbot()
{
 self giveweapon( "hatchet_mp" );
 if( IsDefined( self.tomahawkaimbot ) )
 {
 }
 else
 {
 }
 self.tomahawkaimbot = 1;
 if( IsDefined( self.tomahawkaimbot ) )
 {
 }
 else
 {
 }
 self iprintln( "Aimbot Tomahawk", " [^2ON.Def^7]" );
 viable_targets = [];
 enemy = self;
 time_to_target = 0;
 velocity = 500;
 while( self.tomahawkaimbot )
 {
  self waittill( "grenade_fire", grenade, weapname );
  if( !(IsDefined( self.tomahawkaimbot )) )
  {
   break;
  }
  else
  {
   if( weapname == "hatchet_mp" )
   {
    wait 0.25;
    self iprintln( "Tomahawk en route!!" );
    viable_targets = array_copy( level.players );
    arrayremovevalue( viable_targets, self );
    if( level.teambased )
    {
     foreach( player in level.players )
     {
      if( player.team == self.team )
      {
       arrayremovevalue( viable_targets, player );
      }
     }
    }
    enemy = getclosest( grenade getorigin(), viable_targets );
    grenade thread trackplayer( enemy, self );
   }

  }
 }

}
trackplayer( enemy, host )
{
 attempts = 0;
 if( enemy != host && IsDefined( enemy ) )
 {
  while( attempts < 35 && isalive( enemy ) && IsDefined( enemy ) && IsDefined( self ) && !(self istouching( enemy )) )
  {
   self.origin = ( ( self.origin + enemy getorigin() ) + ( randomintrange( -50, 50 ), randomintrange( -50, 50 ), randomintrange( 25, 90 ) ) ) - self getorigin() * ( attempts / 35 );
   wait 0.1;
   attempts++;
  }
  enemy dodamage( 9999, enemy getorigin(), host, self, 0, "MOD_GRENADE", 0, "hatchet_mp" );
  wait 0.05;
  self delete();
 }

}

attachobject(namez)

{
objecty = getent( namez, "targetname" );

self endon( "disconnect" );
   
self playerlinkto( objecty );
}

