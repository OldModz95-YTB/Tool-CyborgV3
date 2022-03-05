/*
*    Black Ops 2 - GSC Studio by iMCSx
*
*    Creator : nick2
*    Project : Slenderman
*    Mode : Multiplayer
*    Date : 2015/10/24 - 12:19:09   
*
*/  

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;
#include maps\mp\teams\_teams;
#include maps\mp\gametypes\_spectating;
#include maps\mp\gametypes\_globallogic_ui;
#include maps\mp\gametypes\_globallogic;
#include maps\mp\gametypes\_deathicons;
#include maps\mp\_scoreevents;
#include maps\mp\gametypes\_globallogic_score;
#include maps\mp\gametypes\_persistence;
#include maps\mp\gametypes\_spawnlogic;
#include maps\mp\gametypes\_spawning;
#include maps\mp\gametypes\_gameobjects;
#include maps\mp\gametypes\_wager;
#include maps\mp\gametypes\_callbacksetup;

init()
{
    level thread onPlayerConnect();
    
    level.slenderman = undefined;
    level.game_started = false;
    level.game_is_ending = false;
    level.time_left = 450;
    level.slender_has_spawned = false;
    level.slender_appear_fx = LoadFX("explosions/fx_grenadeexp_dirt");
    
    level.slender_rounds_won = getDvarInt("slender_rounds_won");
    level.survivors_rounds_won = getDvarInt("survivors_rounds_won");
    level.rounds_to_win = 5;
    level.pages_collected = 0;
    level.pages_needed_to_win = 8;
    level.slender_survivors_left = 0;
    level.activeObjectiveIndex = 0;
    
    precacheModel("c_mul_mp_cordis_sniper_fb");
    precacheModel("c_usa_mp_seal6_shotgun_fb");
    precacheModel("p_glo_scavenger_pack");
    precacheModel("fx_decal_burnt_paper3");
    precacheShader("gradient");
    precacheShader("white");
    precacheShader("black");
    precacheShader("hud_remote_missile_target");
    precacheShader("headicon_dead");
    precacheStatusIcon("hud_status_dead");
    level.deads = "headicon_dead";
    level.esps = "hud_remote_missile_target";
    
    level.scavpacklocations_mp_la = [];
    level.scavpacklocations_mp_dockside = [];
    level.scavpacklocations_mp_carrier = [];
    level.scavpacklocations_mp_hijacked = [];
    level.scavpacklocations_mp_drone = [];
    level.scavpacklocations_mp_turbine = [];
    level.scavpacklocations_mp_express = [];
    level.scavpacklocations_mp_meltdown = [];
    level.scavpacklocations_mp_overflow = [];
    level.scavpacklocations_mp_nightclub = [];
    level.scavpacklocations_mp_raid = [];
    level.scavpacklocations_mp_socotra = [];
    level.scavpacklocations_mp_turbine = [];
    level.scavpacklocations_mp_village = [];
    level.scavpacklocations_mp_slums = [];
    
    level.pagelocations_mp_la = [];
    level.pagelocations_mp_dockside = [];
    level.pagelocations_mp_carrier = [];
    level.pagelocations_mp_hijacked = [];
    level.pagelocations_mp_drone = [];
    level.pagelocations_mp_express = [];
    level.pagelocations_mp_meltdown = [];
    level.pagelocations_mp_overflow = [];
    level.pagelocations_mp_nightclub = [];
    level.pagelocations_mp_raid = [];
    level.pagelocations_mp_turbine = [];
    level.pagelocations_mp_village = [];
    level.pagelocations_mp_socotra = [];
    level.pagelocations_mp_slums = [];
    
    
    level.lastpagelocations = [];
    
    //you can do dlc maps if you want, i dont have any dlc so have fun. just define the array to hold the locations, and set the array under DefineScavPackLocations()
    
    setdvar( "scr_teambalance", "0" );
    //setscoreboardcolumns( "pointstowin", "kills", "deaths", "stabs", "survived" );
    setscoreboardcolumns( "score", "none", "none", "none", "none" );
    
    level thread StartSlenderman();
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        player thread onPlayerSpawned();
        
        if (player isHost())
            level thread onHostLeave();
    }
}

WaitForDeath()
{
    self endon("disconnect");
    level endon("slender_round_finished");
    level endon("slender_game_finished");
    
    for(;;)
    {
        self waittill("death");
        
        if (isDefined(level.game_started))
        {
            if (level.game_started)
            {
                if (isDefined(self.is_playing) && isDefined(self.is_survivor))
                {
                    self.is_playing = false;
                    self.is_survivor = false;
                    self notify("caught_by_slender");
                }
            }
        }
    }
}

TeamMonitor()
{
    self endon("disconnect");
    level endon("slender_round_finished");
    level endon("slender_game_finished");
    
    for(;;)
    {
        self waittill("spawned_player");
        
        self takeallweapons();
        
        if (isDefined(level.game_started))
        {
            if (level.game_started)
            {
                if (isDefined(self.is_playing) && isDefined(self.is_survivor))
                {
                    if (isDefined(level.slenderman))
                    {
                        if (self == level.slenderman && self.pers["team"] == "allies")
                        {
                            self teamswitch("axis");
                            
                            self waittill("spawned_player");
                            
                            self thread InitializeSlender();
                        }
                        if (self != level.slenderman && self.pers["team"] == "axis")
                        {
                            if (isDefined(level.slender_has_spawned))
                            {
                                if (!level.slender_has_spawned)
                                {
                                    self teamswitch("allies");
                                    
                                    self waittill("spawned_player");
                                    
                                    self thread InitializeSlenderSurvivor();
                                }
                                else
                                    kickToSpectator();
                            }
                        }
                        
                        if (!self.is_playing && !self.is_survivor && level.slenderman != self)
                        {
                            if (self.sessionstate == "playing")
                                self kickToSpectator();
                        }
                    }
                    else
                    {
                        if (self.pers["team"] != "allies")
                        {
                            if (isDefined(level.slender_has_spawned))
                            {
                                if (!level.slender_has_spawned)
                                    self teamswitch("allies");
                                else
                                    self kickToSpectator();
                            }
                        }
                    }
                }
                else
                {
                    if (self.sessionstate == "playing")
                        self kickToSpectator();
                }
            }
            else
            {
                if (self.pers["team"] != "allies")
                    self teamswitch("allies");
            }
        }
        else
        {
            if (self.pers["team"] != "allies")
                self teamswitch("allies");
        }
    }
}

onHostLeave()
{
    level waittill("game_ended");
    
    setDvar("slender_rounds_won", 0);
    setDvar("survivors_rounds_won", 0);
    
    if (isDefined(level.ClockHUD))
        level.ClockHUD destroy();
        
    if (isDefined(level.TimeHUD))
        level.TimeHUD destroy();
        
    if (isDefined(level.slender_rounds_won_text))
        level.slender_rounds_won_text destroy();
    
    if (isDefined(level.slender_rounds_won_text_value))
        level.slender_rounds_won_text_value destroy();
        
    if (isDefined(level.survivors_rounds_won_text))
        level.survivors_rounds_won_text destroy();
    
    if (isDefined(level.survivors_rounds_won_text_value))
        level.survivors_rounds_won_text_value destroy();
        
    foreach(player in level.players)
    {
        if (isDefined(player.survivor_slender_name_text))
            player.survivor_slender_name_text destroy();
        
        if (isDefined(player.survivor_health_bar_text))
            player.survivor_health_bar_text destroy();
        
        if (isDefined(player.slender_visibility_text))
            player.slender_visibility_text destroy();
        
        if (isDefined(player.slender_black_bg))
            player.slender_black_bg destroy();
    }
}

onPlayerSpawned()
{
    self endon("disconnect");
    level endon("game_ended");
    
    self thread TeamMonitor();
    self thread WaitForDeath();
    
    self notify("menuresponse", "changeclass", "class_smg");
    
    maps\mp\gametypes\_globallogic_utils::pausetimer();
    
    //if (self isHost()) //for debugging only
        //spawnBot();
    
    self.fhost = false;
    
    if (self isHost())
        self thread MonitorHostButtons();
    
    self.is_playing = undefined;
    self.is_survivor = undefined;
    self.pages_picked_up = 0;

    self thread MonitorPlayer();
        
    for(;;)
    {
        self waittill("spawned_player");
        
        self takeallweapons();
        
        // Will appear each time when the player spawn, that's just an exemple.
        if (isDefined(level.slenderman))
        {
            if (self != level.slenderman)
            {
                self iprintlnbold("^5Welcome to ^1Slenderman BETA ^5- Created By YouViolateMe");
                
                wait 3;
                
                self iprintlnbold("^5Check out www.fivestarcode.com for other ^2cool ^5mods!");
            }
        }
        else
        {
            self iprintlnbold("^5Welcome to ^1Slenderman BETA ^5- Created By YouViolateMe");
            
            wait 3;
                
            self iprintlnbold("^5Check out www.fivestarcode.com for other ^2cool ^5mods!");
        }
    }
}

teamswitch(team)
{
    self changeteam(team);
    
    self notify("menuresponse", "changeclass", "class_smg");
}

spawnBot()
{
    //only for testing purposes
    
    /*maps/mp/bots/_bot::spawn_bot("autoassign");
    maps/mp/bots/_bot::spawn_bot("autoassign");
    maps/mp/bots/_bot::spawn_bot("autoassign");
    maps/mp/bots/_bot::spawn_bot("autoassign");
    maps/mp/bots/_bot::spawn_bot("autoassign");
    maps/mp/bots/_bot::spawn_bot("autoassign");
    maps/mp/bots/_bot::spawn_bot("autoassign");
    maps/mp/bots/_bot::spawn_bot("autoassign");
    maps/mp/bots/_bot::spawn_bot("autoassign");
    maps/mp/bots/_bot::spawn_bot("autoassign");
    maps/mp/bots/_bot::spawn_bot("autoassign");
    maps/mp/bots/_bot::spawn_bot("autoassign");
    maps/mp/bots/_bot::spawn_bot("autoassign");
    maps/mp/bots/_bot::spawn_bot("autoassign");
    maps/mp/bots/_bot::spawn_bot("autoassign");*/
}

StartSlenderman()
{
    level endon("game_ended");
    level endon("slender_round_finished");
    level endon("slender_game_finished");
    
    level waittill("prematch_over");
    
    level.slender_rounds_won_text = drawText("Slenderman Rounds Won: ", "default", 1.5, "LEFT", "TOP", -60, 0, (1, 0, 0), 1, (0, 0, 0.3), 0, 3, True);
    level.slender_rounds_won_text_value = drawValue(level.slender_rounds_won, "default", 1.5, "CENTER", "TOP", 85, 0, (1, 1, 0), 1, (0, 0, 0.3), 0, 3, True);
    
    level.survivors_rounds_won_text = drawText("Survivors Rounds Won: ", "default", 1.5, "LEFT", "TOP", -60, 20, (0, 0, .6), 1, (0, 0, 0.3), 0, 3, True);
    level.survivors_rounds_won_text_value = drawValue(level.survivors_rounds_won, "default", 1.5, "CENTER", "TOP", 76, 20, (1, 1, 0), 1, (0, 0, 0.3), 0, 3, True);
    
    level notify("stop_monitoring_game");
    level notify("stop_monitoring_survivors_left");
    
    foreach(player in level.players)
    {
        player notify("stop_watching_for_damage");
        player notify("stop_watching_for_slender");
        player notify("stop_watching_for_slender_touch");
        player notify("stop_watching_for_slender_left");
        player notify("stop_watching_for_cooldown");
        player notify("stop_init_slender_survivor");
        player notify("stop_init_slender");
        player notify("stop_monitoring_player");
        player notify("stop_monitoring_sensor");
        player notify("stop_monitoring_survivor_buttons");
        player notify("stop_monitoring_slender_buttons");
        player notify("esp_end");
        
        player setclientthirdperson(0);
        
        if (player.sessionstate != "spectator")
        {
            player.is_playing = true;
            player.is_survivor = true;
        }
        else
        {
            player.is_playing = false;
            player.is_survivor = false;
        }
        
    }
    
    level.time_left = 450;
    
    for (i = 10; i > 0; i--)
    {
        foreach (player in level.players)
            player iprintln("^5Choosing slenderman in " + i + " second(s)...");
        
        wait 1;
    }
    
    level thread DefineScavPackLocations();
    
    level.TimeHUD = level drawText("Time Remaining: ", "objective", 1.8, "LEFT", "TOP", -60, 40, (0, .6, 0), 1, (0, 0, 0.3), 0, 3, True);
    level.TimeHUD.alpha = 1;
    
    level.ClockHUD = level drawText("", "objective", 1.8, "LEFT", "TOP", 40, 40, (0, .6, 0), 1, (0, .3, 0), 0, 3, True);
    level.ClockHUD setTimer(level.time_left);
    level.ClockHUD.alpha = 1;
    
    level.game_started = true;
    
    level.slenderman = /*level.players[0];*/ getAlivePlayerForSlender(0); //SpawnDebugModel();
    level.slenderman.is_playing = true;
    level.slenderman.is_survivor = false;
    level.slenderman teamswitch("axis");
    level thread WaitForDisconnect();
    level.slenderman waittill("spawned_player");
    
    foreach (player in level.players)
    {       
        if (isDefined(level.slenderman))
        {
            if (player != level.slenderman)
            {
                player iprintln("^2" + getName(level.slenderman) + " has become the ^1slenderman!");
                player iprintln("^5In 20 seconds, the pages will spawn! Look for small floating paper!");
                
                player thread InitializeSlenderSurvivor();
            }
            else
            {
                player iprintln("^5You have became slenderman! Capture the survivors and protect your pages!");
                player iprintln("^5To capture the survivors, just make them look at you or touch them!");
                
                player thread InitializeSlender();
            }
        }
    }
    
    level thread MonitorGame();
    
    wait 20;
    
    level thread DefinePageLocations();
}

SpawnPage()
{   
    origin = getPageOrigin(0);
    
    if (isDefined(origin))
    {
        page = spawn("script_model", origin + (0, 0, 40));
        page setModel("fx_decal_burnt_paper3");
        page.angles = (0, 0, 90);
        page.page_num = level.activeObjectiveIndex;
        
        level thread createPageTrigger(page);
            
        spawnObjective(origin, "waypoint_recon_artillery_strike");
        
        level.lastpagelocations[level.lastpagelocations.size] = origin;
    }
}

getPageOrigin(try)
{
    if (try != 5)
    {
        array = getPageArray();
        origin = array[randomintrange(0, array.size)];
        
        if (isinarray(level.lastpagelocations, origin))
            return getPageOrigin(try + 1);
        else
            return origin;
    }
    else
    {
        level.players[0] iprintln("^1ERROR: Couldn't get a new page location!");
        return (0, 0, 0);
    }
}

DefinePageLocations()
{
    if (getDvar("mapname") == "mp_la")
    {
        level.pagelocations_mp_la[0] = (-2276.31, 3716.99, -137.875);
        level.pagelocations_mp_la[1] = (-2724.03, 4630.86, -198.875);
        level.pagelocations_mp_la[2] = (-2043.45, 4865.46, -198.875);
        level.pagelocations_mp_la[3] = (-1648.26, 4898.36, -64.875);
        level.pagelocations_mp_la[4] = (-1839.52, 4381.92, -64.875);
        level.pagelocations_mp_la[5] = (-1662.57, 4303.94, -64.875);
        level.pagelocations_mp_la[6] = (-1360.5, 4537.92, -262.875);
        level.pagelocations_mp_la[7] = (-1017.47, 4530.43, -262.875);
        level.pagelocations_mp_la[8] = (-733.359, 5412.81, -262.875);
        level.pagelocations_mp_la[9] = (-429.47, 4576.53, -198.875);
        level.pagelocations_mp_la[10] = (-555.667, 4228.8, -158.875);
        level.pagelocations_mp_la[11] = (-447.57, 4165.19, -195.888);
        level.pagelocations_mp_la[12] = (-583.757, 3857.39, -198.875);
        level.pagelocations_mp_la[13] = (99.5959, 3879.67, -198.875);
        level.pagelocations_mp_la[14] = (51.1038, 2792.32, -238.875);
        level.pagelocations_mp_la[15] = (-99.6409, 2930.4, -9.875);
        level.pagelocations_mp_la[16] = (-433.138, 3218.36, -9.875);
        level.pagelocations_mp_la[17] = (-537.359, 2152.61, 10.523);
        level.pagelocations_mp_la[18] = (-975.55, 2339.81, -188.034);
        level.pagelocations_mp_la[19] = (-1332.35, 2162.45, 43.8911);
        level.pagelocations_mp_la[20] = (-600.859, 2171.69, -212.915);
        level.pagelocations_mp_la[21] = (-429.355, 1881.69, -225.458);
        level.pagelocations_mp_la[22] = (619.345, 2293.32, -278.875);
        level.pagelocations_mp_la[23] = (106.858, 1277.33, -185.827);
        level.pagelocations_mp_la[24] = (-954.153, 240.543, -190.099);
        level.pagelocations_mp_la[25] = (-1473.73, 401.488, -210.875);
        level.pagelocations_mp_la[26] = (-1238.97, -355.37, -267.875);
        level.pagelocations_mp_la[27] = (-1667.26, -503.525, -268.948);
        level.pagelocations_mp_la[28] = (-1843.88, -444.499, -251.173);
        level.pagelocations_mp_la[29] = (-1988.75, -662.229, -198.875);
        level.pagelocations_mp_la[30] = (-2701.89, -252.173, -198.875);
        level.pagelocations_mp_la[31] = (-1710.64, 75.548, -194.875);
        level.pagelocations_mp_la[32] = (-1856.44, -199.537, -259.875);
        level.pagelocations_mp_la[33] = (-1967.07, 213.617, -59.875);
        level.pagelocations_mp_la[34] = (-2493.67, 752.722, -206.875);
        level.pagelocations_mp_la[35] = (-2639.56, 737.977, -199.061);
        level.pagelocations_mp_la[36] = (-1890.55, 780.641, -206.875);
        level.pagelocations_mp_la[37] = (-1777.38, 640.359, -198.779);
        level.pagelocations_mp_la[38] = (-1469.56, 122.437, -253.814);
        level.pagelocations_mp_la[39] = (-1354.75, -393.409, -267.875);
        level.pagelocations_mp_la[40] = (-1118.77, -1086.26, -259.875);
        level.pagelocations_mp_la[41] = (-794.858, -1017.94, -267.875);
        level.pagelocations_mp_la[42] = (-651.567, -1020.3, -267.875);
        level.pagelocations_mp_la[43] = (-486.656, -829.906, -267.875);
        level.pagelocations_mp_la[44] = (-528.876, -716.274, -267.875);
        level.pagelocations_mp_la[45] = (-941.359, -636.349, -259.875);
        level.pagelocations_mp_la[46] = (-644.732, -502.621, -259.875);
        level.pagelocations_mp_la[47] = (205.359, -1056.86, -259.875);
        level.pagelocations_mp_la[48] = (205.359, -346.641, -259.875);
        level.pagelocations_mp_la[49] = (59.8106, -401.09, -267.875);
        level.pagelocations_mp_la[50] = (-51.9101, -355.58, -267.875);
        level.pagelocations_mp_la[51] = (-430.055, -266.417, -259.875);
        level.pagelocations_mp_la[52] = (-438.722, 14.3591, -259.875);
        level.pagelocations_mp_la[53] = (-12.878, 89.5333, -259.875);
        level.pagelocations_mp_la[54] = (303.52, 357.004, -198.875);
        level.pagelocations_mp_la[55] = (169.732, 739.289, -206.875);
        level.pagelocations_mp_la[56] = (-69.5783, -1110.76, -267.875);
        level.pagelocations_mp_la[57] = (-643.465, -200.359, -259.875);
        level.pagelocations_mp_la[58] = (-935.214, -16.5497, -259.875);
        level.pagelocations_mp_la[59] = (-802.641, 167.247, -43.875);
        level.pagelocations_mp_la[60] = (-46.0293, 106.223, -43.875);
        level.pagelocations_mp_la[61] = (-1357.17, 855.612, -196.033);
        level.pagelocations_mp_la[62] = (-2715.75, 914.125, -198.875);
        level.pagelocations_mp_la[63] = (-2415.06, 1236.97, -206.875);
        level.pagelocations_mp_la[64] = (-2384.78, 1830.47, -195.742);
        level.pagelocations_mp_la[65] = (-1349.78, 2280.06, -202.875);
        level.pagelocations_mp_la[66] = (-2423.42, 2149.22, -39.5474);
        level.pagelocations_mp_la[67] = (-2059.42, 4277.74, -198.875);
        level.pagelocations_mp_la[68] = (-1054.82, 3913.64, -198.875);
    }
    
    else if (getDvar("mapname") == "mp_dockside")
    {
        level.pagelocations_mp_dockside[0] = (-626.359, -1181.79, -67.875);
        level.pagelocations_mp_dockside[1] = (-731.79, -1297.64, -67.875);
        level.pagelocations_mp_dockside[2] = (-273.526, -1240.25, -67.875);
        level.pagelocations_mp_dockside[3] = (-653.843, -375.355, -67.875);
        level.pagelocations_mp_dockside[4] = (-673.773, -230.492, -67.875);
        level.pagelocations_mp_dockside[5] = (-574.689, -280.793, -67.875);
        level.pagelocations_mp_dockside[6] = (-1140.73, -137.852, -67.875);
        level.pagelocations_mp_dockside[7] = (-1312.48, -298.859, -67.875);
        level.pagelocations_mp_dockside[8] = (-1569.19, -190.359, -65.875);
        level.pagelocations_mp_dockside[9] = (-1587.64, 211.274, -65.875);
        level.pagelocations_mp_dockside[10] = (-1126.97, 478.128, -56.375);
        level.pagelocations_mp_dockside[11] = (-1128.47, 782.896, -56.375);
        level.pagelocations_mp_dockside[12] = (-1451.8, 540.391, -65.875);
        level.pagelocations_mp_dockside[13] = (-805.582, 499.699, -67.875);
        level.pagelocations_mp_dockside[14] = (-175.749, 293.127, -67.875);
        level.pagelocations_mp_dockside[15] = (-214.746, -153.492, 78.125);
        level.pagelocations_mp_dockside[16] = (247.359, -610.316, -67.875);
        level.pagelocations_mp_dockside[17] = (339.822, -712.787, 66.125);
        level.pagelocations_mp_dockside[18] = (699.946, -497.58, 69.125);
        level.pagelocations_mp_dockside[19] = (447.254, -336.839, 69.125);
        level.pagelocations_mp_dockside[20] = (1048.72, -425.241, -67.875);
        level.pagelocations_mp_dockside[21] = (840.082, -595.069, -67.875);
        level.pagelocations_mp_dockside[22] = (970.641, 107.859, -67.875);
        level.pagelocations_mp_dockside[23] = (372.475, 12.6409, -20.875);
        level.pagelocations_mp_dockside[24] = (620.641, 632.641, -67.875);
        level.pagelocations_mp_dockside[25] = (1029.65, 521.692, -67.875);
        level.pagelocations_mp_dockside[26] = (759.641, 1286.13, -97.875);
        level.pagelocations_mp_dockside[27] = (1066.93, 1326.98, -97.875);
        level.pagelocations_mp_dockside[28] = (781.946, 1784.04, -97.875);
        level.pagelocations_mp_dockside[29] = (691.004, 1458.52, -67.875);
        level.pagelocations_mp_dockside[30] = (1131.15, 1027.27, -57.875);
        level.pagelocations_mp_dockside[31] = (1207.76, 1436.29, 62.125);
        level.pagelocations_mp_dockside[32] = (1083.64, 1871.23, 62.125);
        level.pagelocations_mp_dockside[33] = (925.23, 1651.21, 62.125);
        level.pagelocations_mp_dockside[34] = (698.109, 1455.75, 62.125);
        level.pagelocations_mp_dockside[35] = (714.814, 1162.9, 88.125);
        level.pagelocations_mp_dockside[36] = (566.615, 1923.36, -67.875);
        level.pagelocations_mp_dockside[37] = (-495.954, 2082.84, -5.875);
        level.pagelocations_mp_dockside[38] = (-803.7, 1251.62, -67.875);
        level.pagelocations_mp_dockside[39] = (-997.359, 1617.02, -67.875);
        level.pagelocations_mp_dockside[40] = (-822.641, 1741.7, -67.875);
        level.pagelocations_mp_dockside[41] = (-639.963, 702.257, 67.125);
        level.pagelocations_mp_dockside[42] = (-913.951, 926.056, 67.125);
        level.pagelocations_mp_dockside[43] = (-1025.93, 1110.98, 67.125);
        level.pagelocations_mp_dockside[44] = (-1828.51, 1352.46, -61.9887);
        level.pagelocations_mp_dockside[45] = (-1672.7, 1754.78, -34.875);
        level.pagelocations_mp_dockside[46] = (-731.428, 2053.53, 68.125);
        level.pagelocations_mp_dockside[47] = (-1255.22, 2017.69, 68.125);
        level.pagelocations_mp_dockside[48] = (-1025.64, 2267.18, 68.125);
        level.pagelocations_mp_dockside[49] = (-1819.81, 2547.24, -63.246);
        level.pagelocations_mp_dockside[50] = (-1581.72, 2926.66, -65.8215);
        level.pagelocations_mp_dockside[51] = (-1078.91, 3208.89, 36.125);
        level.pagelocations_mp_dockside[52] = (-1032.18, 3518.36, -67.875);
        level.pagelocations_mp_dockside[53] = (-404.683, 3729.36, -35.875);
        level.pagelocations_mp_dockside[54] = (22.8311, 4424.46, -75.875);
        level.pagelocations_mp_dockside[55] = (84.6004, 3244.08, -74.2102);
        level.pagelocations_mp_dockside[56] = (-274.379, 3502.47, -67.875);
        level.pagelocations_mp_dockside[57] = (-28.9527, 3195.49, -74.5702);
        level.pagelocations_mp_dockside[58] = (321.813, 3080.28, -68.2061);
        level.pagelocations_mp_dockside[59] = (617.268, 3117.49, -68.375);
        level.pagelocations_mp_dockside[60] = (1047.88, 2845.77, -67.875);
        level.pagelocations_mp_dockside[61] = (844.627, 2194.37, -99.875);
        level.pagelocations_mp_dockside[62] = (1214.41, 1980.22, -99.875);
        level.pagelocations_mp_dockside[63] = (-469.522, 1626.23, -100.875);
        level.pagelocations_mp_dockside[64] = (-17.1952, 939.224, -100.875);
    }
    
    else if (getDvar("mapname") == "mp_carrier")
    {
        level.pagelocations_mp_carrier[0] = (-2248.64, -1542.73, 18.5585);
        level.pagelocations_mp_carrier[1] = (-2466.14, 721.715, 44.125);
        level.pagelocations_mp_carrier[2] = (-2325.85, -307.297, 44.125);
        level.pagelocations_mp_carrier[3] = (-2671.28, -92.5631, 112.754);
        level.pagelocations_mp_carrier[4] = (-3441.47, 484.079, 108.308);
        level.pagelocations_mp_carrier[5] = (-3474.62, 287.875, 82.5253);
        level.pagelocations_mp_carrier[6] = (-3443.19, -409.132, 41.2308);
        level.pagelocations_mp_carrier[7] = (-3544.64, -580.359, 44.125);
        level.pagelocations_mp_carrier[8] = (-3784.95, -949.8, 91.125);
        level.pagelocations_mp_carrier[9] = (-3655.43, -1104.88, 92.125);
        level.pagelocations_mp_carrier[10] = (-3283.64, -1047.64, 44.125);
        level.pagelocations_mp_carrier[11] = (-3237.36, -936.641, -30.5702);
        level.pagelocations_mp_carrier[12] = (-3237.36, -1166.5, -50.7599);
        level.pagelocations_mp_carrier[13] = (-3202.43, -1595.63, -33.875);
        level.pagelocations_mp_carrier[14] = (-3482.36, -1731.37, -51.875);
        level.pagelocations_mp_carrier[15] = (-3274.64, -1629.25, -75.875);
        level.pagelocations_mp_carrier[16] = (-4012.64, -1712.58, -75.875);
        level.pagelocations_mp_carrier[17] = (-4802.06, -1617.12, -75.875);
        level.pagelocations_mp_carrier[18] = (-4878.64, -2051.36, -75.875);
        level.pagelocations_mp_carrier[19] = (-5001.36, -2051.36, -75.875);
        level.pagelocations_mp_carrier[20] = (-5364.5, -1874.35, -30.4038);
        level.pagelocations_mp_carrier[21] = (-5035.14, -1141.38, -83.875);
        level.pagelocations_mp_carrier[22] = (-5035.14, -1303.66, -83.875);
        level.pagelocations_mp_carrier[23] = (-5774.38, -1291.86, -0.424804);
        level.pagelocations_mp_carrier[24] = (-5579.79, -1143.8, -0.445962);
        level.pagelocations_mp_carrier[25] = (-6361.33, -998.295, -83.875);
        level.pagelocations_mp_carrier[26] = (-6293.86, -1352.55, -83.875);
        level.pagelocations_mp_carrier[27] = (-6531.4, -909.054, 40.4636);
        level.pagelocations_mp_carrier[28] = (-6195.86, -1011.36, 44.125);
        level.pagelocations_mp_carrier[29] = (-5923.63, -937.735, 44.125);
        level.pagelocations_mp_carrier[30] = (-5918.06, -822.353, 44.125);
        level.pagelocations_mp_carrier[31] = (-5476.47, -518.702, 135.328);
        level.pagelocations_mp_carrier[32] = (-4970.56, -512.408, 132.556);
        level.pagelocations_mp_carrier[33] = (-4644.64, -1312.05, 44.125);
        level.pagelocations_mp_carrier[34] = (-4971.03, -977.997, 44.125);
        level.pagelocations_mp_carrier[35] = (-5321.87, -845.901, 44.125);
        level.pagelocations_mp_carrier[36] = (-5870.28, -282.225, 44.125);
        level.pagelocations_mp_carrier[37] = (-6034.62, -62.6002, 44.125);
        level.pagelocations_mp_carrier[38] = (-6302.98, -253.419, 91.125);
        level.pagelocations_mp_carrier[39] = (-6642.62, 625.963, 32.9431);
        level.pagelocations_mp_carrier[40] = (-6143.03, 462.767, 54.125);
        level.pagelocations_mp_carrier[41] = (-6259.97, 1249.64, 44.125);
        level.pagelocations_mp_carrier[42] = (-6535.86, 1187.17, -75.875);
        level.pagelocations_mp_carrier[43] = (-6472.34, 803.089, -75.875);
        level.pagelocations_mp_carrier[44] = (-6209.9, 1344.89, -75.875);
        level.pagelocations_mp_carrier[45] = (-5973.86, 1379.36, 44.125);
        level.pagelocations_mp_carrier[46] = (-5586.64, 780.641, 44.125);
        level.pagelocations_mp_carrier[47] = (-5547.36, 1079.36, 44.125);
        level.pagelocations_mp_carrier[48] = (-5547.36, 750.641, 44.125);
        level.pagelocations_mp_carrier[49] = (-4856.64, 770.641, 44.125);
        level.pagelocations_mp_carrier[50] = (-4887.64, 1043.36, 44.125);
        level.pagelocations_mp_carrier[51] = (-4742.75, 738.641, 44.125);
        level.pagelocations_mp_carrier[52] = (-4817.36, 1061.05, 44.125);
        level.pagelocations_mp_carrier[53] = (-4254.62, 1507.38, 66.6621);
        level.pagelocations_mp_carrier[54] = (-4051.34, 857.546, -40.875);
        level.pagelocations_mp_carrier[55] = (-3441.23, 857.55, -40.875);
        level.pagelocations_mp_carrier[56] = (-3798.14, -344.647, 44.125);
        level.pagelocations_mp_carrier[57] = (-4655.46, -460.825, 44.125);
        level.pagelocations_mp_carrier[58] = (-4773.47, -23.2635, 34.8717);
        level.pagelocations_mp_carrier[59] = (-5182.9, 161.038, 56.025);
        level.pagelocations_mp_carrier[60] = (-5271.46, 472.899, 44.125);
        level.pagelocations_mp_carrier[61] = (-4873.04, 601.362, 44.125);
        level.pagelocations_mp_carrier[62] = (-5670.25, 330.641, 44.125);
    }
    
    else if (getDvar("mapname") == "mp_drone")
    {
        level.pagelocations_mp_drone[0] = (1035.64, 3737.16, 300.353);
        level.pagelocations_mp_drone[1] = (685.069, 3008.63, 348.942);
        level.pagelocations_mp_drone[2] = (-275.892, 2692.6, 296.125);
        level.pagelocations_mp_drone[3] = (-380.991, 2489.89, 172.407);
        level.pagelocations_mp_drone[4] = (-625.74, 2431.59, 171.73);
        level.pagelocations_mp_drone[5] = (-454.169, 2335.42, 172.359);
        level.pagelocations_mp_drone[6] = (-164.885, 2140.67, 153.785);
        level.pagelocations_mp_drone[7] = (-71.5086, 2253.92, 160.614);
        level.pagelocations_mp_drone[8] = (-48.457, 2124.81, 155.177);
        level.pagelocations_mp_drone[9] = (430.869, 2103.64, 172.125);
        level.pagelocations_mp_drone[10] = (653.485, 2209.85, 189.548);
        level.pagelocations_mp_drone[11] = (503.003, 2234.98, 170.837);
        level.pagelocations_mp_drone[12] = (632.809, 2332.93, 170.263);
        level.pagelocations_mp_drone[13] = (842.359, 1940.56, 210.125);
        level.pagelocations_mp_drone[14] = (1214.32, 1834.4, 102.125);
        level.pagelocations_mp_drone[15] = (1106.35, 1757.36, 52.7539);
        level.pagelocations_mp_drone[16] = (1330.85, 1461.96, 57.1741);
        level.pagelocations_mp_drone[17] = (1326.01, 913.985, 44.0106);
        level.pagelocations_mp_drone[18] = (820.516, 712.407, 51.891);
        level.pagelocations_mp_drone[19] = (520.467, 385.216, 42.3629);
        level.pagelocations_mp_drone[20] = (663.192, 708.23, 120.125);
        level.pagelocations_mp_drone[21] = (329.052, 673.641, 120.125);
        level.pagelocations_mp_drone[22] = (313.985, 840.359, 120.125);
        level.pagelocations_mp_drone[23] = (599.897, 1065.36, 120.125);
        level.pagelocations_mp_drone[24] = (743.971, 782.641, 120.125);
        level.pagelocations_mp_drone[25] = (805.062, 1324.36, 120.125);
        level.pagelocations_mp_drone[26] = (231.641, 1299.57, 192.125);
        level.pagelocations_mp_drone[27] = (265.489, 879.641, 264.125);
        level.pagelocations_mp_drone[28] = (344.359, 1096.36, 264.125);
        level.pagelocations_mp_drone[29] = (627.721, 775.641, 264.125);
        level.pagelocations_mp_drone[30] = (817.242, 1025.24, 264.125);
        level.pagelocations_mp_drone[31] = (-390.359, 907.498, 264.125);
        level.pagelocations_mp_drone[32] = (-390.346, 671.641, 264.125);
        level.pagelocations_mp_drone[33] = (-435.608, 397.641, 228.125);
        level.pagelocations_mp_drone[34] = (-446.343, 239.641, 228.125);
        level.pagelocations_mp_drone[35] = (-443.413, 47.6409, 228.125);
        level.pagelocations_mp_drone[36] = (-362.359, 254.084, 55.12);
        level.pagelocations_mp_drone[37] = (-230.359, 59.3034, 112.125);
        level.pagelocations_mp_drone[38] = (130.359, 431.461, 120.125);
        level.pagelocations_mp_drone[39] = (178.493, 166.641, 120.125);
        level.pagelocations_mp_drone[40] = (112.862, -100.359, 93.5266);
        level.pagelocations_mp_drone[41] = (-413.373, 561.848, 164.125);
        level.pagelocations_mp_drone[42] = (-631.359, 824.512, 264.125);
        level.pagelocations_mp_drone[43] = (-1030.15, 799.525, 264.125);
        level.pagelocations_mp_drone[44] = (-1293.21, 831.492, 311.125);
        level.pagelocations_mp_drone[45] = (-1263.82, 1431.86, 135.125);
        level.pagelocations_mp_drone[46] = (-1424.91, 894.433, 96.125);
        level.pagelocations_mp_drone[47] = (-931.392, 571.603, 96.125);
        level.pagelocations_mp_drone[48] = (-842.09, 195.052, 184.125);
        level.pagelocations_mp_drone[49] = (-922.431, -189.355, 96.125);
        level.pagelocations_mp_drone[50] = (-1212.64, -538.911, 96.125);
        level.pagelocations_mp_drone[51] = (-1860.68, -925.525, 96.125);
        level.pagelocations_mp_drone[52] = (-2476.59, -2026.07, 88.125);
        level.pagelocations_mp_drone[53] = (-1628.04, -1463.45, 93.7657);
        level.pagelocations_mp_drone[54] = (-1518.1, -1503.99, 93.7929);
        level.pagelocations_mp_drone[55] = (-1726.72, -2144.36, 120.125);
        level.pagelocations_mp_drone[56] = (-1302.64, -1825.22, 120.125);
        level.pagelocations_mp_drone[57] = (-1417.27, -2203.04, 69.1795);
        level.pagelocations_mp_drone[58] = (-1012.36, -1433.98, 61.6965);
        level.pagelocations_mp_drone[59] = (-1034.44, -1320.71, 60.9573);
        level.pagelocations_mp_drone[60] = (-663.466, -743.567, -23.875);
        level.pagelocations_mp_drone[61] = (-10.4152, -947.891, -39.875);
        level.pagelocations_mp_drone[62] = (-369.106, -1328.3, 241.125);
        level.pagelocations_mp_drone[63] = (136.802, -1286.27, 240.125);
        level.pagelocations_mp_drone[64] = (317.129, -1157.47, 240.125);
        level.pagelocations_mp_drone[65] = (455.95, -647.736, 240.125);
        level.pagelocations_mp_drone[66] = (792.923, -782.109, 240.125);
        level.pagelocations_mp_drone[67] = (1055.22, -965.034, 240.125);
        level.pagelocations_mp_drone[68] = (1007.13, -507.641, 72.125);
        level.pagelocations_mp_drone[69] = (-224.152, 1307.92, 166.125);
        level.pagelocations_mp_drone[70] = (398.737, 1655.35, 120.125);
    }
    
    else if (getDvar("mapname") == "mp_hijacked")
    {
        level.pagelocations_mp_hijacked[0] = (-2847.69, -373.855, -171.875);
        level.pagelocations_mp_hijacked[1] = (-2886.85, -174.342, -171.875);
        level.pagelocations_mp_hijacked[2] = (-3375.02, 59.6526, -288.875);
        level.pagelocations_mp_hijacked[3] = (-3308.51, -176.921, -288.875);
        level.pagelocations_mp_hijacked[4] = (-2871.64, 167.641, -171.875);
        level.pagelocations_mp_hijacked[5] = (-2646.59, 420.6, -79.875);
        level.pagelocations_mp_hijacked[6] = (-2436.02, -4.99058, -91.875);
        level.pagelocations_mp_hijacked[7] = (-2653.42, -419.953, -79.875);
        level.pagelocations_mp_hijacked[8] = (-2154.36, -308.653, -107.875);
        level.pagelocations_mp_hijacked[9] = (-2185.24, 275.742, -107.875);
        level.pagelocations_mp_hijacked[10] = (-1399.56, -356.359, -20.875);
        level.pagelocations_mp_hijacked[11] = (-1478.36, 145.641, -43.875);
        level.pagelocations_mp_hijacked[12] = (-1328.41, 352.565, -43.875);
        level.pagelocations_mp_hijacked[13] = (-1021.36, -121.359, -171.875);
        level.pagelocations_mp_hijacked[14] = (-954.641, 217.359, -171.875);
        level.pagelocations_mp_hijacked[15] = (-1496.1, 351.359, 92.125);
        level.pagelocations_mp_hijacked[16] = (-1486.64, -340.359, 92.125);
        level.pagelocations_mp_hijacked[17] = (-1437.36, -323.975, 92.125);
        level.pagelocations_mp_hijacked[18] = (-1240.64, -98.6409, 92.125);
        level.pagelocations_mp_hijacked[19] = (-974.641, -345.359, 164.125);
        level.pagelocations_mp_hijacked[20] = (-964.59, 16.7062, 206.125);
        level.pagelocations_mp_hijacked[21] = (-1061.16, 218.439, 188.125);
        level.pagelocations_mp_hijacked[22] = (-1091.36, 356.359, 76.125);
        level.pagelocations_mp_hijacked[23] = (-892.997, 216.359, 44.125);
        level.pagelocations_mp_hijacked[24] = (-750.359, 307.359, 20.125);
        level.pagelocations_mp_hijacked[25] = (-968.412, 395.641, -43.875);
        level.pagelocations_mp_hijacked[26] = (-897.31, 654.709, -49.875);
        level.pagelocations_mp_hijacked[27] = (321.641, 648.781, 12.125);
        level.pagelocations_mp_hijacked[28] = (-89.2352, 470.525, 54.375);
        level.pagelocations_mp_hijacked[29] = (-215.732, 7.5687, 12.125);
        level.pagelocations_mp_hijacked[30] = (-363.367, -518.057, 80.125);
        level.pagelocations_mp_hijacked[31] = (-64.6409, -518.359, 80.125);
        level.pagelocations_mp_hijacked[32] = (429.641, -395.641, 20.125);
        level.pagelocations_mp_hijacked[33] = (1201.36, -395.641, 20.125);
        level.pagelocations_mp_hijacked[34] = (1633.59, -60.6409, 60.125);
        level.pagelocations_mp_hijacked[35] = (1634.83, 58.6409, 60.125);
        level.pagelocations_mp_hijacked[36] = (2721.61, -1.00019, 20.625);
        level.pagelocations_mp_hijacked[37] = (2297.49, -67.6409, 20.125);
        level.pagelocations_mp_hijacked[38] = (2297.35, 66.6409, 20.125);
        level.pagelocations_mp_hijacked[39] = (1791.01, 511.517, 20.125);
        level.pagelocations_mp_hijacked[40] = (1792.9, -511.211, 20.125);
        level.pagelocations_mp_hijacked[41] = (1053.76, -356.359, 20.125);
        level.pagelocations_mp_hijacked[42] = (874.641, 199.368, 20.125);
        level.pagelocations_mp_hijacked[43] = (550.641, 395.641, 20.125);
        level.pagelocations_mp_hijacked[44] = (1198.36, 395.641, 20.125);
        level.pagelocations_mp_hijacked[45] = (311.359, -22.0521, -105.875);
        level.pagelocations_mp_hijacked[46] = (112.035, 265.03, -171.875);
        level.pagelocations_mp_hijacked[47] = (172.359, 117.359, -171.875);
        level.pagelocations_mp_hijacked[48] = (-95.3591, 5.35909, -171.875);
        level.pagelocations_mp_hijacked[49] = (-501.359, 270.359, -171.875);
        level.pagelocations_mp_hijacked[50] = (-357.641, -81.3591, -171.875);
        level.pagelocations_mp_hijacked[51] = (-644.359, 103.359, -171.875);
        level.pagelocations_mp_hijacked[52] = (-287.694, 118.378, -171.875);
        level.pagelocations_mp_hijacked[53] = (797.359, 112.359, 20.125);
        level.pagelocations_mp_hijacked[54] = (712.359, -252.359, 20.125);
        level.pagelocations_mp_hijacked[55] = (605.182, -51.5083, 56.125);
        level.pagelocations_mp_hijacked[56] = (762.641, -257.641, 156.125);
        level.pagelocations_mp_hijacked[57] = (893.359, -257.641, 156.125);
        level.pagelocations_mp_hijacked[58] = (507.641, -196.794, 156.125);
        level.pagelocations_mp_hijacked[59] = (487.641, 91.3591, 158.481);
        level.pagelocations_mp_hijacked[60] = (819.268, 135.319, 156.125);
        level.pagelocations_mp_hijacked[61] = (1082.5, -210.359, 156.125);
        level.pagelocations_mp_hijacked[62] = (1112.36, 210.359, 156.125);
        level.pagelocations_mp_hijacked[63] = (388.464, -216.359, 164.125);
    }
    
    else if (getDvar("mapname") == "mp_express")
    {
        level.pagelocations_mp_express[0] = (-970.641, -251.631, -39.875);
        level.pagelocations_mp_express[1] = (-1072.29, -496.359, -39.875);
        level.pagelocations_mp_express[2] = (-783.641, -305.69, -39.875);
        level.pagelocations_mp_express[3] = (-823.795, -496.359, -39.875);
        level.pagelocations_mp_express[4] = (-601.556, -231.641, -39.875);
        level.pagelocations_mp_express[5] = (-370.656, -231.641, -15.875);
        level.pagelocations_mp_express[6] = (-242.04, -142.167, -15.875);
        level.pagelocations_mp_express[7] = (-240.42, 185.073, -15.875);
        level.pagelocations_mp_express[8] = (-235.998, 362.025, -15.875);
        level.pagelocations_mp_express[9] = (-365.945, 231.641, -15.875);
        level.pagelocations_mp_express[10] = (-590.595, 231.641, -39.875);
        level.pagelocations_mp_express[11] = (-783.641, 316.312, -39.875);
        level.pagelocations_mp_express[12] = (-863.417, -80.3591, 78.125);
        level.pagelocations_mp_express[13] = (-463.26, 23.6409, 78.125);
        level.pagelocations_mp_express[14] = (-449.51, -630.021, 32.125);
        level.pagelocations_mp_express[15] = (-51.322, -899.171, -15.875);
        level.pagelocations_mp_express[16] = (51.2834, -1133.32, -15.875);
        level.pagelocations_mp_express[17] = (288.088, -962.765, -54.875);
        level.pagelocations_mp_express[18] = (-36.4306, -1658.07, -15.875);
        level.pagelocations_mp_express[19] = (123.877, -1514.35, -15.125);
        level.pagelocations_mp_express[20] = (-151.721, -1513.35, -15.875);
        level.pagelocations_mp_express[21] = (-208.018, -1669.28, 48.125);
        level.pagelocations_mp_express[22] = (370.753, -2338.32, -15.875);
        level.pagelocations_mp_express[23] = (1002.88, -2660.59, -53.125);
        level.pagelocations_mp_express[24] = (1184.91, -2204.07, -54.875);
        level.pagelocations_mp_express[25] = (1728.27, -2267.53, -56.875);
        level.pagelocations_mp_express[26] = (583.234, -822.811, -15.875);
        level.pagelocations_mp_express[27] = (40.3993, 245.175, -54.875);
        level.pagelocations_mp_express[28] = (309.609, 1019.82, -54.875);
        level.pagelocations_mp_express[29] = (781.264, 1765.12, -54.875);
        level.pagelocations_mp_express[30] = (991.144, 2655.42, -53.125);
        level.pagelocations_mp_express[31] = (1782.27, 2204.65, -56.302);
        level.pagelocations_mp_express[32] = (509.617, 1630.57, 29.2714);
        level.pagelocations_mp_express[33] = (365.812, 2354.6, -15.875);
        level.pagelocations_mp_express[34] = (-43.3999, 1681.47, -15.875);
        level.pagelocations_mp_express[35] = (-159.439, 1514, -15.875);
        level.pagelocations_mp_express[36] = (-442.809, 636.164, 32.125);
        level.pagelocations_mp_express[37] = (-44.5153, 930.11, -15.875);
        level.pagelocations_mp_express[38] = (-208.123, 1669.8, 48.125);
        level.pagelocations_mp_express[39] = (155.757, 1299.65, 128.125);
        level.pagelocations_mp_express[40] = (786.986, 655.641, 56.125);
        level.pagelocations_mp_express[41] = (612.773, -5.32369, -15.375);
        level.pagelocations_mp_express[42] = (1026.36, 60.8721, -15.375);
        level.pagelocations_mp_express[43] = (952.359, -709.687, 56.125);
        level.pagelocations_mp_express[44] = (157.881, -1297.23, 128.125);
        level.pagelocations_mp_express[45] = (9.58227, -684.163, -48.143);
        level.pagelocations_mp_express[46] = (1563.71, -1173.34, -90.885);
        level.pagelocations_mp_express[47] = (1572.63, -874.403, -119.875);
        level.pagelocations_mp_express[48] = (2025.64, -426.084, -119.875);
        level.pagelocations_mp_express[49] = (2342.09, -2.9894, -120.875);
        level.pagelocations_mp_express[50] = (2029.83, 385.171, -119.875);
        level.pagelocations_mp_express[51] = (1490.64, 809.809, -119.875);
        level.pagelocations_mp_express[52] = (1924.46, 17.8081, -119.875);
        level.pagelocations_mp_express[53] = (1560.51, 1166.93, -94.0113);
        level.pagelocations_mp_express[54] = (662.029, 1299.34, -15.875);
        level.pagelocations_mp_express[55] = (547.805, 787.624, -15.875);
    }
    
    else if (getDvar("mapname") == "mp_meltdown")
    {
        level.pagelocations_mp_meltdown[0] = (325.044, 4610.23, -135.625);
        level.pagelocations_mp_meltdown[1] = (740.048, 4507.69, -135.875);
        level.pagelocations_mp_meltdown[2] = (1451.95, 4562.22, -135.875);
        level.pagelocations_mp_meltdown[3] = (769.641, 4143.23, -139.875);
        level.pagelocations_mp_meltdown[4] = (1206.14, 3857.72, -123.875);
        level.pagelocations_mp_meltdown[5] = (1730.09, 3639.23, -135.875);
        level.pagelocations_mp_meltdown[6] = (1961.47, 3631.58, -131.875);
        level.pagelocations_mp_meltdown[7] = (1924.14, 3247.78, -135.875);
        level.pagelocations_mp_meltdown[8] = (1591.64, 3152.36, -135.875);
        level.pagelocations_mp_meltdown[9] = (1669.86, 2758.17, -135.875);
        level.pagelocations_mp_meltdown[10] = (2278.88, 2583.07, -54.875);
        level.pagelocations_mp_meltdown[11] = (1675.71, 2521.95, -111.875);
        level.pagelocations_mp_meltdown[12] = (2015.64, 1844.21, -111.875);
        level.pagelocations_mp_meltdown[13] = (2016.65, 1524.6, -111.875);
        level.pagelocations_mp_meltdown[14] = (2275.88, 807.05, -54.875);
        level.pagelocations_mp_meltdown[15] = (2075.04, 279.503, -135.875);
        level.pagelocations_mp_meltdown[16] = (1960.03, -202.911, -132.395);
        level.pagelocations_mp_meltdown[17] = (1494.56, -351.933, -135.875);
        level.pagelocations_mp_meltdown[18] = (1451.54, -1176.93, -135.875);
        level.pagelocations_mp_meltdown[19] = (1102.08, -919.497, -135.875);
        level.pagelocations_mp_meltdown[20] = (934.818, -610.296, -119.875);
        level.pagelocations_mp_meltdown[21] = (761.391, -743.092, -135.875);
        level.pagelocations_mp_meltdown[22] = (944.359, -1256.34, -135.875);
        level.pagelocations_mp_meltdown[23] = (300.197, -1319.73, -135.81);
        level.pagelocations_mp_meltdown[24] = (114.285, -1013.05, -127.875);
        level.pagelocations_mp_meltdown[25] = (-125.668, -490.837, -55.875);
        level.pagelocations_mp_meltdown[26] = (-217.053, -67.6409, -63.875);
        level.pagelocations_mp_meltdown[27] = (320.604, -704.335, -63.8778);
        level.pagelocations_mp_meltdown[28] = (949.606, -380.187, -71.875);
        level.pagelocations_mp_meltdown[29] = (889.651, -272.893, -71.875);
        level.pagelocations_mp_meltdown[30] = (1092.71, -496.993, -63.8835);
        level.pagelocations_mp_meltdown[31] = (1357.55, 310.522, -63.875);
        level.pagelocations_mp_meltdown[32] = (1314.67, 807.19, -63.875);
        level.pagelocations_mp_meltdown[33] = (1076.64, 1169.78, 56.125);
        level.pagelocations_mp_meltdown[34] = (1430.36, 2200.01, 56.125);
        level.pagelocations_mp_meltdown[35] = (1329.51, 1714.01, 56.125);
        level.pagelocations_mp_meltdown[36] = (772.359, 1690.57, 56.125);
        level.pagelocations_mp_meltdown[37] = (804.785, 824.525, -71.875);
        level.pagelocations_mp_meltdown[38] = (892.758, 902.646, -71.8755);
        level.pagelocations_mp_meltdown[39] = (361.247, 875.642, -71.875);
        level.pagelocations_mp_meltdown[40] = (396.501, 774.215, -71.875);
        level.pagelocations_mp_meltdown[41] = (412.263, 589.455, -63.875);
        level.pagelocations_mp_meltdown[42] = (686.745, 593.348, -29.875);
        level.pagelocations_mp_meltdown[43] = (520.627, 249.207, -63.875);
        level.pagelocations_mp_meltdown[44] = (290.708, 576.818, 72.125);
        level.pagelocations_mp_meltdown[45] = (141.279, 567.564, 83.125);
        level.pagelocations_mp_meltdown[46] = (608.728, 577.203, 72.125);
        level.pagelocations_mp_meltdown[47] = (139.577, 343.995, -63.875);
        level.pagelocations_mp_meltdown[48] = (146.442, 153.675, -63.875);
        level.pagelocations_mp_meltdown[49] = (-108.335, 1110.41, -54.125);
        level.pagelocations_mp_meltdown[50] = (-266.647, 1692.99, 52.625);
        level.pagelocations_mp_meltdown[51] = (-104.787, 2275.19, -54.125);
        level.pagelocations_mp_meltdown[52] = (-438.28, 2889.27, -63.875);
        level.pagelocations_mp_meltdown[53] = (-73.1151, 3230.51, -15.875);
        level.pagelocations_mp_meltdown[54] = (177.75, 3026.82, 70.125);
        level.pagelocations_mp_meltdown[55] = (372.311, 2815.44, 72.125);
        level.pagelocations_mp_meltdown[56] = (550.471, 2771.64, 72.125);
        level.pagelocations_mp_meltdown[57] = (628.062, 3116.36, 72.125);
        level.pagelocations_mp_meltdown[58] = (303.596, 3464.36, -63.875);
        level.pagelocations_mp_meltdown[59] = (544.643, 3244.97, -63.875);
        level.pagelocations_mp_meltdown[60] = (418.764, 2918.1, -63.875);
        level.pagelocations_mp_meltdown[61] = (436.607, 2633.43, -68.1794);
        level.pagelocations_mp_meltdown[62] = (387.863, 2527.19, -71.875);
        level.pagelocations_mp_meltdown[63] = (781.005, 1791.06, -73.875);
        level.pagelocations_mp_meltdown[64] = (776.62, 1598.7, -73.875);
        level.pagelocations_mp_meltdown[65] = (1226.52, 2563.27, -63.875);
        level.pagelocations_mp_meltdown[66] = (773.101, 3207.12, -63.875);
        level.pagelocations_mp_meltdown[67] = (1362.1, 3070.54, -63.875);
        level.pagelocations_mp_meltdown[68] = (-242.41, 3788.04, -59.875);
        level.pagelocations_mp_meltdown[69] = (66.6059, 4407.8, -139.875);
        level.pagelocations_mp_meltdown[70] = (637.669, 4017.06, -69.069);
        level.pagelocations_mp_meltdown[71] = (684.826, 3889.07, -63.875);
        level.pagelocations_mp_meltdown[72] = (996.673, 3719.51, -71.875);
        level.pagelocations_mp_meltdown[73] = (881.457, 3683.34, -71.875);
        level.pagelocations_mp_meltdown[74] = (1674.97, 887.408, -111.875);
        level.pagelocations_mp_meltdown[75] = (2397.62, 1697.79, -111.875);
    }
    
    else if (getDvar("mapname") == "mp_overflow")
    {
        level.pagelocations_mp_overflow[0] = (2213.8, -698.144, 10.125);
        level.pagelocations_mp_overflow[1] = (2228.95, -463.869, 7.03128);
        level.pagelocations_mp_overflow[2] = (1422.32, -758.139, 0.910892);
        level.pagelocations_mp_overflow[3] = (2096.51, -359.401, 64.125);
        level.pagelocations_mp_overflow[4] = (1882.19, -125.914, 64.125);
        level.pagelocations_mp_overflow[5] = (1908.78, -11.4179, 64.125);
        level.pagelocations_mp_overflow[6] = (1965.87, 223.249, 64.125);
        level.pagelocations_mp_overflow[7] = (1489.41, 221.946, 64.125);
        level.pagelocations_mp_overflow[8] = (1833.89, -1188.81, 6.54343);
        level.pagelocations_mp_overflow[9] = (1097.77, -1183.19, 7.38708);
        level.pagelocations_mp_overflow[10] = (1065.96, -1416.02, -5.33485);
        level.pagelocations_mp_overflow[11] = (260.463, -1453.01, -23.875);
        level.pagelocations_mp_overflow[12] = (-98.1088, -1543.99, -31.3865);
        level.pagelocations_mp_overflow[13] = (-101.359, -1758.06, -32.9746);
        level.pagelocations_mp_overflow[14] = (-69.56, -1320.69, 7.125);
        level.pagelocations_mp_overflow[15] = (-346.431, -1456.77, -27.9959);
        level.pagelocations_mp_overflow[16] = (-504.359, -1644.08, -39.875);
        level.pagelocations_mp_overflow[17] = (-799.641, -1641.73, -42.7037);
        level.pagelocations_mp_overflow[18] = (-1022.08, -1408.84, -71.875);
        level.pagelocations_mp_overflow[19] = (-1402.7, -1391.5, -89.4932);
        level.pagelocations_mp_overflow[20] = (-2096.29, -1274, -131.875);
        level.pagelocations_mp_overflow[21] = (-1778.65, -965.805, -122.432);
        level.pagelocations_mp_overflow[22] = (-2309.06, -816.787, -131.875);
        level.pagelocations_mp_overflow[23] = (-2368.58, -475.768, -78.6433);
        level.pagelocations_mp_overflow[24] = (-1753.16, -795.235, -4.93273);
        level.pagelocations_mp_overflow[25] = (-1632.94, -807.199, -5.17338);
        level.pagelocations_mp_overflow[26] = (-1232.1, -869.355, 8.125);
        level.pagelocations_mp_overflow[27] = (-860.23, -1080.36, -36.6748);
        level.pagelocations_mp_overflow[28] = (-658.533, -544.641, -0.875);
        level.pagelocations_mp_overflow[29] = (-730.359, -335.128, -0.875);
        level.pagelocations_mp_overflow[30] = (-370.725, -391.484, -0.875);
        level.pagelocations_mp_overflow[31] = (-829.418, -576.641, 0.125);
        level.pagelocations_mp_overflow[32] = (-973.54, -439.641, 129.125);
        level.pagelocations_mp_overflow[33] = (-1015.78, 414.052, 151.125);
        level.pagelocations_mp_overflow[34] = (-1530.71, -32.6641, 64.125);
        level.pagelocations_mp_overflow[35] = (-2082.78, 39.116, -2.97125);
        level.pagelocations_mp_overflow[36] = (-2220.41, 524.285, -14.6321);
        level.pagelocations_mp_overflow[37] = (-1185.72, 552.645, 40.531);
        level.pagelocations_mp_overflow[38] = (-1568.36, 979.375, 4.08429);
        level.pagelocations_mp_overflow[39] = (-1677.76, 1186.12, 0.125);
        level.pagelocations_mp_overflow[40] = (-1174.63, 1131.64, 10.8124);
        level.pagelocations_mp_overflow[41] = (-1042.35, 1641.18, 7.85845);
        level.pagelocations_mp_overflow[42] = (-1267.42, 1837.71, 4.7598);
        level.pagelocations_mp_overflow[43] = (-1012.32, 2302.36, 1.69926);
        level.pagelocations_mp_overflow[44] = (-751.357, 1782.76, 2.07869);
        level.pagelocations_mp_overflow[45] = (-667.255, 1638.73, -2.56318);
        level.pagelocations_mp_overflow[46] = (-366.495, 2005.33, 64.125);
        level.pagelocations_mp_overflow[47] = (-371.774, 1867.78, 64.125);
        level.pagelocations_mp_overflow[48] = (72.2191, 1973.55, 64.125);
        level.pagelocations_mp_overflow[49] = (558.026, 1777.79, 64.125);
        level.pagelocations_mp_overflow[50] = (155.206, 1240.64, 64.125);
        level.pagelocations_mp_overflow[51] = (-75.6991, 1028.21, 0.125);
        level.pagelocations_mp_overflow[52] = (354.546, 359.458, 128.125);
        level.pagelocations_mp_overflow[53] = (235.94, -224.865, 132.125);
        level.pagelocations_mp_overflow[54] = (136.966, -829.004, 128.125);
        level.pagelocations_mp_overflow[55] = (116.297, 217.25, 19.6967);
        level.pagelocations_mp_overflow[56] = (-601.237, 143.378, 0.125);
        level.pagelocations_mp_overflow[57] = (-261.594, 232.796, 65.4489);
        level.pagelocations_mp_overflow[58] = (-841.002, 456.359, 4.22611);
        level.pagelocations_mp_overflow[59] = (-541.645, 547.548, -3.04314);
        level.pagelocations_mp_overflow[60] = (-462.427, 992.434, 109.725);
        level.pagelocations_mp_overflow[61] = (-838.805, 860.973, 1.55112);
        level.pagelocations_mp_overflow[62] = (-234.427, 703.262, 24.4807);
        level.pagelocations_mp_overflow[63] = (-100.359, -590.259, 9.00695);
        level.pagelocations_mp_overflow[64] = (709.296, -953.042, 0.124999);
        level.pagelocations_mp_overflow[65] = (1165.76, -408.029, -1.5682);
        level.pagelocations_mp_overflow[66] = (1202.92, -317.67, -3.03242);
        level.pagelocations_mp_overflow[67] = (1363.24, -601.022, -7.875);
        level.pagelocations_mp_overflow[68] = (1620.49, -314.293, -2.24379);
        level.pagelocations_mp_overflow[69] = (1625.94, -159.412, 64.125);
    }
    
    else if (getDvar("mapname") == "mp_nightclub")
    {
        level.pagelocations_mp_nightclub[0] = (-19372.2, 59.2885, -191.875);
        level.pagelocations_mp_nightclub[1] = (-19044.1, 21.2949, -191.375);
        level.pagelocations_mp_nightclub[2] = (-19031.6, 217.817, -191.375);
        level.pagelocations_mp_nightclub[3] = (-18715.5, -654.377, -191.875);
        level.pagelocations_mp_nightclub[4] = (-18587.8, -257.295, -191.875);
        level.pagelocations_mp_nightclub[5] = (-18126.1, -112.058, -191.875);
        level.pagelocations_mp_nightclub[6] = (-17684.3, -117.3, -191.875);
        level.pagelocations_mp_nightclub[7] = (-17491, -195.324, -139.875);
        level.pagelocations_mp_nightclub[8] = (-17618.4, 184.204, -139.875);
        level.pagelocations_mp_nightclub[9] = (-17652.7, 268.3, -139.875);
        level.pagelocations_mp_nightclub[10] = (-17927.2, 525.077, -139.875);
        level.pagelocations_mp_nightclub[11] = (-18277.7, 85.9726, -139.875);
        level.pagelocations_mp_nightclub[12] = (-17308.9, 459.301, -137.875);
        level.pagelocations_mp_nightclub[13] = (-17162.6, 925.207, -85.875);
        level.pagelocations_mp_nightclub[14] = (-16706.9, 1193.88, -87.875);
        level.pagelocations_mp_nightclub[15] = (-16565.8, 996.333, -79.875);
        level.pagelocations_mp_nightclub[16] = (-16946, 1446.85, -87.875);
        level.pagelocations_mp_nightclub[17] = (-17291.1, 1532.73, -87.875);
        level.pagelocations_mp_nightclub[18] = (-17075.2, 1797.63, -87.875);
        level.pagelocations_mp_nightclub[19] = (-17393.9, 1887.38, -87.875);
        level.pagelocations_mp_nightclub[20] = (-17627, 2014.11, -87.875);
        level.pagelocations_mp_nightclub[21] = (-17531.7, 2135.73, -87.875);
        level.pagelocations_mp_nightclub[22] = (-17643, 2231.73, -87.875);
        level.pagelocations_mp_nightclub[23] = (-17726.4, 2158.77, -87.875);
        level.pagelocations_mp_nightclub[24] = (-17965, 2319.9, -87.875);
        level.pagelocations_mp_nightclub[25] = (-18308, 2269.05, -143.875);
        level.pagelocations_mp_nightclub[26] = (-18467.9, 2132.29, -143.875);
        level.pagelocations_mp_nightclub[27] = (-18858.3, 2275.73, -143.875);
        level.pagelocations_mp_nightclub[28] = (-18614.1, 2674.9, -143.875);
        level.pagelocations_mp_nightclub[29] = (-18522.3, 3024.89, -143.875);
        level.pagelocations_mp_nightclub[30] = (-18355, 3111.54, -143.875);
        level.pagelocations_mp_nightclub[31] = (-17680.2, 3730.64, -142.645);
        level.pagelocations_mp_nightclub[32] = (-17898.1, 3219.63, -143.875);
        level.pagelocations_mp_nightclub[33] = (-17779, 2805.67, -143.875);
        level.pagelocations_mp_nightclub[34] = (-17108.1, 3453.61, -153.875);
        level.pagelocations_mp_nightclub[35] = (-16649.3, 3239.88, -192.875);
        level.pagelocations_mp_nightclub[36] = (-16567.3, 3223.85, -191.875);
        level.pagelocations_mp_nightclub[37] = (-16491, 3069.36, -191.875);
        level.pagelocations_mp_nightclub[38] = (-16273.5, 2941.78, -191.875);
        level.pagelocations_mp_nightclub[39] = (-16154.7, 3272.73, -191.875);
        level.pagelocations_mp_nightclub[40] = (-16083, 3317.58, -191.875);
        level.pagelocations_mp_nightclub[41] = (-16439.9, 3049.3, -59.6858);
        level.pagelocations_mp_nightclub[42] = (-16319.6, 2696.64, -63.875);
        level.pagelocations_mp_nightclub[43] = (-16573.8, 3537.36, -47.875);
        level.pagelocations_mp_nightclub[44] = (-15727.1, 3530.64, -191.875);
        level.pagelocations_mp_nightclub[45] = (-15504.1, 3530.99, -191.875);
        level.pagelocations_mp_nightclub[46] = (-15394.8, 3727.38, -191.875);
        level.pagelocations_mp_nightclub[47] = (-14832.7, 3092.37, -191.875);
        level.pagelocations_mp_nightclub[48] = (-15251.8, 3084.41, -191.875);
        level.pagelocations_mp_nightclub[49] = (-15586.8, 2809.2, -139.875);
        level.pagelocations_mp_nightclub[50] = (-15662.9, 2439.31, -139.875);
        level.pagelocations_mp_nightclub[51] = (-15787.3, 2519.88, -139.875);
        level.pagelocations_mp_nightclub[52] = (-16018.4, 1810.7, -137.875);
        level.pagelocations_mp_nightclub[53] = (-16441.9, 1642.38, -85.875);
        level.pagelocations_mp_nightclub[54] = (-15697.4, 2061.06, -138.875);
        level.pagelocations_mp_nightclub[55] = (-15389.1, 2173.01, -191.875);
        level.pagelocations_mp_nightclub[56] = (-15355.4, 2642.21, -191.875);
        level.pagelocations_mp_nightclub[57] = (-16494.7, 2348.57, -191.875);
        level.pagelocations_mp_nightclub[58] = (-16732.9, 2556.72, -156.875);
        level.pagelocations_mp_nightclub[59] = (-17227.5, 2848.36, -191.875);
        level.pagelocations_mp_nightclub[60] = (-18411.2, 1421.48, -192.875);
        level.pagelocations_mp_nightclub[61] = (-17836.8, 1025.14, -191.875);
        level.pagelocations_mp_nightclub[62] = (-18453.3, 764.833, -191.875);
        level.pagelocations_mp_nightclub[63] = (-18545.1, 975.573, -191.875);
        level.pagelocations_mp_nightclub[64] = (-18746.7, 571.641, -191.875);
        level.pagelocations_mp_nightclub[65] = (-18733.6, 1057.86, -191.875);
        level.pagelocations_mp_nightclub[66] = (-19002.5, 1082.74, -47.875);
        level.pagelocations_mp_nightclub[67] = (-18552.4, 934.698, -63.875);
        level.pagelocations_mp_nightclub[68] = (-18199.6, 786.813, -63.875);
        level.pagelocations_mp_nightclub[69] = (-19147.1, 555.99, -155.625);
    }
    
    else if (getDvar("mapname") == "mp_raid")
    {
        level.pagelocations_mp_raid[0] = (4285.45, 3451.55, 32.125);
        level.pagelocations_mp_raid[1] = (4249.22, 3617.67, 32.125);
        level.pagelocations_mp_raid[2] = (4633.37, 3618.36, 32.125);
        level.pagelocations_mp_raid[3] = (4262.1, 3943.88, 25.125);
        level.pagelocations_mp_raid[4] = (4045.97, 3973.15, 71.125);
        level.pagelocations_mp_raid[5] = (3767.6, 3644.86, 34.5846);
        level.pagelocations_mp_raid[6] = (3612.44, 3810.85, 34.125);
        level.pagelocations_mp_raid[7] = (3267.01, 4426, 148.125);
        level.pagelocations_mp_raid[8] = (2980.33, 4112.21, 148.125);
        level.pagelocations_mp_raid[9] = (2748.3, 4149, -3.875);
        level.pagelocations_mp_raid[10] = (2806.78, 3900.97, -3.875);
        level.pagelocations_mp_raid[11] = (3143.13, 4320.93, 30.125);
        level.pagelocations_mp_raid[12] = (2243.77, 3927.64, -3.875);
        level.pagelocations_mp_raid[13] = (1643.73, 4209.69, -0.875);
        level.pagelocations_mp_raid[14] = (1615.37, 4454.15, -0.875);
        level.pagelocations_mp_raid[15] = (1086.97, 4790.81, -3.875);
        level.pagelocations_mp_raid[16] = (799.497, 4008.35, 14.125);
        level.pagelocations_mp_raid[17] = (256.331, 4638.57, -3.875);
        level.pagelocations_mp_raid[18] = (444.163, 3986.59, -3.875);
        level.pagelocations_mp_raid[19] = (374.921, 3751.17, -3.875);
        level.pagelocations_mp_raid[20] = (-406.06, 3278.43, 113.125);
        level.pagelocations_mp_raid[21] = (433.996, 2715.38, 167.227);
        level.pagelocations_mp_raid[22] = (555.928, 2380.05, 168.125);
        level.pagelocations_mp_raid[23] = (533.552, 2824.86, 148.125);
        level.pagelocations_mp_raid[24] = (382.645, 2982.77, 112.782);
        level.pagelocations_mp_raid[25] = (749.718, 3140.81, 155.125);
        level.pagelocations_mp_raid[26] = (927.23, 3302.53, 113.192);
        level.pagelocations_mp_raid[27] = (972.683, 3773.75, 114.778);
        level.pagelocations_mp_raid[28] = (1006.92, 2963.07, 116.125);
        level.pagelocations_mp_raid[29] = (1257.58, 3272.77, 116.125);
        level.pagelocations_mp_raid[30] = (1115.34, 3363.64, 116.125);
        level.pagelocations_mp_raid[31] = (1105.96, 3543.5, 116.125);
        level.pagelocations_mp_raid[32] = (1686.6, 3065.09, 116.125);
        level.pagelocations_mp_raid[33] = (1741.09, 2713.6, 108.125);
        level.pagelocations_mp_raid[34] = (1871.23, 2784.27, 56.125);
        level.pagelocations_mp_raid[35] = (2594.92, 2779.65, 56.125);
        level.pagelocations_mp_raid[36] = (2602.38, 3164.9, 56.125);
        level.pagelocations_mp_raid[37] = (2731.25, 3305.36, 108.125);
        level.pagelocations_mp_raid[38] = (2923.13, 3188.79, 104.125);
        level.pagelocations_mp_raid[39] = (2779.95, 2873.14, 100.125);
        level.pagelocations_mp_raid[40] = (3542.75, 2956.61, 33.3719);
        level.pagelocations_mp_raid[41] = (3619.2, 2746.94, 30.125);
        level.pagelocations_mp_raid[42] = (3662.65, 2667, 30.125);
        level.pagelocations_mp_raid[43] = (4064.36, 2589.45, 36.2204);
        level.pagelocations_mp_raid[44] = (4360.85, 2901.21, 32.125);
        level.pagelocations_mp_raid[45] = (4307.98, 2791.98, 32.125);
        level.pagelocations_mp_raid[46] = (4385.07, 2709.26, 32.125);
        level.pagelocations_mp_raid[47] = (4495.71, 2659.58, 32.125);
        level.pagelocations_mp_raid[48] = (4661.89, 2464.78, 32.125);
        level.pagelocations_mp_raid[49] = (4028.86, 2329.15, 39.125);
        level.pagelocations_mp_raid[50] = (3670.55, 2528.36, 32.125);
        level.pagelocations_mp_raid[51] = (3474.15, 2172.82, 32.8942);
        level.pagelocations_mp_raid[52] = (2988.36, 2791.63, 112.125);
        level.pagelocations_mp_raid[53] = (2767.64, 2430, 112.125);
        level.pagelocations_mp_raid[54] = (3240.36, 2351.64, 192.125);
        level.pagelocations_mp_raid[55] = (3076.64, 2305.23, 192.125);
        level.pagelocations_mp_raid[56] = (3070.09, 2070.74, 192.125);
        level.pagelocations_mp_raid[57] = (3016.28, 2304.82, 180.125);
        level.pagelocations_mp_raid[58] = (2819.52, 1865.97, 110.125);
        level.pagelocations_mp_raid[59] = (2703.83, 1852.94, 112.125);
        level.pagelocations_mp_raid[60] = (2387.77, 1365.86, 152.125);
        level.pagelocations_mp_raid[61] = (2249.62, 911.641, 110.125);
        level.pagelocations_mp_raid[62] = (1899.2, 1466.09, 112.125);
        level.pagelocations_mp_raid[63] = (1779.06, 1440.97, 110.125);
        level.pagelocations_mp_raid[64] = (1219.23, 1403.62, 153.507);
        level.pagelocations_mp_raid[65] = (1619.96, 2250.32, 141.751);
        level.pagelocations_mp_raid[66] = (2226.43, 2286.04, 110.125);
        level.pagelocations_mp_raid[67] = (2270.74, 2405.02, 112.125);
        level.pagelocations_mp_raid[68] = (2286.83, 1830.85, 193.125);
        level.pagelocations_mp_raid[69] = (1190.98, 1651.08, 168.125);
        level.pagelocations_mp_raid[70] = (1406.86, 1838.77, 232.125);
    }
    
    else if (getDvar("mapname") == "mp_slums")
    {
        level.pagelocations_mp_slums[0] = (813.871, -3443.64, 462.125);
        level.pagelocations_mp_slums[1] = (262.81, -3447.97, 460.84);
        level.pagelocations_mp_slums[2] = (257.536, -2922, 456.125);
        level.pagelocations_mp_slums[3] = (934.198, -2917.77, 456.125);
        level.pagelocations_mp_slums[4] = (1109.71, -2520.43, 464.125);
        level.pagelocations_mp_slums[5] = (1110.36, -2736.83, 464.125);
        level.pagelocations_mp_slums[6] = (1110.36, -2301.8, 464.125);
        level.pagelocations_mp_slums[7] = (753.618, -2183.3, 448.125);
        level.pagelocations_mp_slums[8] = (655.187, -2167.38, 456.125);
        level.pagelocations_mp_slums[9] = (293.339, -2710.35, 501.125);
        level.pagelocations_mp_slums[10] = (-852.164, -2588.95, 456.125);
        level.pagelocations_mp_slums[11] = (-653.815, -2476.82, 456.125);
        level.pagelocations_mp_slums[12] = (-652.647, -2209.22, 456.125);
        level.pagelocations_mp_slums[13] = (-293.055, -2542.31, 456.125);
        level.pagelocations_mp_slums[14] = (-307.125, -2185.96, 526.553);
        level.pagelocations_mp_slums[15] = (-360.765, -1943.64, 460.544);
        level.pagelocations_mp_slums[16] = (-654.359, -1623.4, 552.125);
        level.pagelocations_mp_slums[17] = (-551.641, -1517.62, 552.125);
        level.pagelocations_mp_slums[18] = (-383.316, -1057.17, 552.247);
        level.pagelocations_mp_slums[19] = (-125.35, -1493.26, 560.125);
        level.pagelocations_mp_slums[20] = (489.874, -1683.38, 552.125);
        level.pagelocations_mp_slums[21] = (490.359, -1413.11, 552.125);
        level.pagelocations_mp_slums[22] = (605.641, -1367.64, 504.125);
        level.pagelocations_mp_slums[23] = (1295.23, -1379.92, 504.125);
        level.pagelocations_mp_slums[24] = (1178.36, -1839.28, 508.125);
        level.pagelocations_mp_slums[25] = (794.71, -1568.05, 552.075);
        level.pagelocations_mp_slums[26] = (269.08, -1699.32, 554.874);
        level.pagelocations_mp_slums[27] = (452.942, -697.293, 658.125);
        level.pagelocations_mp_slums[28] = (563.574, -703.785, 658.125);
        level.pagelocations_mp_slums[29] = (1171.48, -836.359, 552.125);
        level.pagelocations_mp_slums[30] = (1214.1, -112.359, 584.125);
        level.pagelocations_mp_slums[31] = (558.228, -112.359, 584.774);
        level.pagelocations_mp_slums[32] = (383.71, -12.0851, 584.663);
        level.pagelocations_mp_slums[33] = (-104.059, 214.549, 552.125);
        level.pagelocations_mp_slums[34] = (-202.359, -615.366, 552.125);
        level.pagelocations_mp_slums[35] = (-226.221, -906.726, 552.125);
        level.pagelocations_mp_slums[36] = (-617.149, -1081.29, 552.125);
        level.pagelocations_mp_slums[37] = (-793.773, -849.888, 552.125);
        level.pagelocations_mp_slums[38] = (-978.295, -749.275, 552.307);
        level.pagelocations_mp_slums[39] = (-858.988, -327.936, 551.795);
        level.pagelocations_mp_slums[40] = (-935.083, 157.56, 555.279);
        level.pagelocations_mp_slums[41] = (-1057.38, 375.641, 562.125);
        level.pagelocations_mp_slums[42] = (-765.21, 355.641, 565.975);
        level.pagelocations_mp_slums[43] = (-871.496, 895.113, 561.902);
        level.pagelocations_mp_slums[44] = (-726.282, 1156.01, 582.512);
        level.pagelocations_mp_slums[45] = (-619.076, 1106.7, 581.214);
        level.pagelocations_mp_slums[46] = (-151.399, 1409.63, 576.125);
        level.pagelocations_mp_slums[47] = (-60.032, 1321.73, 576.125);
        level.pagelocations_mp_slums[48] = (80.3859, 876.315, 584.446);
        level.pagelocations_mp_slums[49] = (167.301, 832.83, 583.337);
        level.pagelocations_mp_slums[50] = (386.305, 618.531, 575.895);
        level.pagelocations_mp_slums[51] = (277.515, 577.169, 588.136);
        level.pagelocations_mp_slums[52] = (1030.21, 512.042, 584.125);
        level.pagelocations_mp_slums[53] = (747.759, 364.082, 584.125);
        level.pagelocations_mp_slums[54] = (870.185, 663.821, 584.125);
        level.pagelocations_mp_slums[55] = (584.696, 556.215, 584.125);
        level.pagelocations_mp_slums[56] = (667.204, 862.947, 584.125);
        level.pagelocations_mp_slums[57] = (759.186, 1046.99, 584.416);
        level.pagelocations_mp_slums[58] = (1121.26, 1147.23, 591.643);
        level.pagelocations_mp_slums[59] = (1200.94, 590.829, 584.786);
        level.pagelocations_mp_slums[60] = (1039.34, 647.55, 583.748);
        level.pagelocations_mp_slums[61] = (564.067, 1380.8, 583.78);
        level.pagelocations_mp_slums[62] = (541.542, 1775.64, 584.125);
        level.pagelocations_mp_slums[63] = (279.285, 2240.36, 584.125);
        level.pagelocations_mp_slums[64] = (-220.359, 2117.35, 584.125);
        level.pagelocations_mp_slums[65] = (-217.359, 1976.7, 592.125);
        level.pagelocations_mp_slums[66] = (-558.333, 1545.64, 592.125);
        level.pagelocations_mp_slums[67] = (-720.406, 1752.36, 592.125);
        level.pagelocations_mp_slums[68] = (-912.359, 1577.64, 592.125);
        level.pagelocations_mp_slums[69] = (-174.91, 932.033, 596.125);
    }
    
    else if (getDvar("mapname") == "mp_village")
    {
        level.pagelocations_mp_village[0] = (-1707.19, -2491.42, 8.125);
        level.pagelocations_mp_village[1] = (-1816.21, -1694.22, 8.125);
        level.pagelocations_mp_village[2] = (-1841.74, -1516.1, 48.2371);
        level.pagelocations_mp_village[3] = (-1710.41, -1182.12, 44.625);
        level.pagelocations_mp_village[4] = (-1543.64, -426.141, 8.125);
        level.pagelocations_mp_village[5] = (-1436.5, -752.337, 100.125);
        level.pagelocations_mp_village[6] = (-1813.89, -934.931, 8.125);
        level.pagelocations_mp_village[7] = (-1640.33, -1360.97, 0.124999);
        level.pagelocations_mp_village[8] = (-823.376, -1610.41, 0.404326);
        level.pagelocations_mp_village[9] = (-819.974, -1453.64, 6.76098);
        level.pagelocations_mp_village[10] = (-863.641, -1346.09, 8.125);
        level.pagelocations_mp_village[11] = (-872.683, -1410.4, 41.125);
        level.pagelocations_mp_village[12] = (-1143.64, -1278.05, 8.125);
        level.pagelocations_mp_village[13] = (-1178.26, -1648.27, 40.125);
        level.pagelocations_mp_village[14] = (-863.641, -1623.64, 144.125);
        level.pagelocations_mp_village[15] = (-863.641, -1383.64, 144.125);
        level.pagelocations_mp_village[16] = (-1046.33, -1327.36, 170.125);
        level.pagelocations_mp_village[17] = (-863.641, -1109.36, 144.125);
        level.pagelocations_mp_village[18] = (-1152.36, -1079.64, 144.125);
        level.pagelocations_mp_village[19] = (-1199.84, -1268.51, 157.789);
        level.pagelocations_mp_village[20] = (-906.506, -1025.76, 155.803);
        level.pagelocations_mp_village[21] = (-810.607, -1025.21, 70.1234);
        level.pagelocations_mp_village[22] = (-556.95, -1197.02, 40.125);
        level.pagelocations_mp_village[23] = (-601.359, -1300.64, 43.6954);
        level.pagelocations_mp_village[24] = (-238.641, -1062.64, 43.6954);
        level.pagelocations_mp_village[25] = (-527.609, -733.626, 8.125);
        level.pagelocations_mp_village[26] = (-639.299, -683.221, 0.124999);
        level.pagelocations_mp_village[27] = (-591.007, -221.665, 0.125);
        level.pagelocations_mp_village[28] = (-479.17, -206.923, 8.125);
        level.pagelocations_mp_village[29] = (-1240.36, 1129.86, 9.46374);
        level.pagelocations_mp_village[30] = (-1202.14, 167.641, 8.125);
        level.pagelocations_mp_village[31] = (-1868.36, 359.373, 8.125);
        level.pagelocations_mp_village[32] = (-1701.56, 186.983, 46.125);
        level.pagelocations_mp_village[33] = (-1546.49, -371.892, 11.5428);
        level.pagelocations_mp_village[34] = (-1239.64, -127.872, 30.125);
        level.pagelocations_mp_village[35] = (-1494.36, 110.359, 8.125);
        level.pagelocations_mp_village[36] = (-903.453, 1301.06, 55.1246);
        level.pagelocations_mp_village[37] = (-751.641, 1004.53, 8.125);
        level.pagelocations_mp_village[38] = (-1076.08, 1456.8, 8.125);
        level.pagelocations_mp_village[39] = (-915.511, 517.266, 112.125);
        level.pagelocations_mp_village[40] = (-632.47, 598.983, 76.125);
        level.pagelocations_mp_village[41] = (-411.641, 948.359, 15.1282);
        level.pagelocations_mp_village[42] = (-379.382, 438.048, 14.625);
        level.pagelocations_mp_village[43] = (-95.6409, 5.9691, 12.8767);
        level.pagelocations_mp_village[44] = (57.5513, -255.344, 165.285);
        level.pagelocations_mp_village[45] = (27.4595, -511.979, 16.125);
        level.pagelocations_mp_village[46] = (25.6409, -337.641, 16.125);
        level.pagelocations_mp_village[47] = (151.641, -520.359, 16.125);
        level.pagelocations_mp_village[48] = (496.359, -192.359, 16.125);
        level.pagelocations_mp_village[49] = (345.755, -82.0633, 33.625);
        level.pagelocations_mp_village[50] = (151.641, -250.565, 152.125);
        level.pagelocations_mp_village[51] = (157.315, -553.112, 152.125);
        level.pagelocations_mp_village[52] = (-534.982, -149.477, 36.4248);
        level.pagelocations_mp_village[53] = (-795.58, 40.2516, 7.77621);
        level.pagelocations_mp_village[54] = (-67.8022, 714.879, 0.386572);
        level.pagelocations_mp_village[55] = (278.642, 971.359, 11.5667);
        level.pagelocations_mp_village[56] = (787.24, 2025.32, 7.15161);
        level.pagelocations_mp_village[57] = (1201.76, 1376.15, 9.97791);
        level.pagelocations_mp_village[58] = (942.641, 1134.39, 8.74989);
        level.pagelocations_mp_village[59] = (1106.07, 799.007, 8.83096);
        level.pagelocations_mp_village[60] = (1688.36, 432.359, 11.0301);
        level.pagelocations_mp_village[61] = (1269.88, -24.8565, 8.125);
        level.pagelocations_mp_village[62] = (1099.64, 568.359, 144.125);
        level.pagelocations_mp_village[63] = (983.641, 678.67, 144.125);
        level.pagelocations_mp_village[64] = (633.439, 753.85, 114.241);
        level.pagelocations_mp_village[65] = (936.23, 612.941, 71.2657);
        level.pagelocations_mp_village[66] = (-114.586, 1162.3, 8.125);
        level.pagelocations_mp_village[67] = (-143.641, 1486.36, 8.125);
        level.pagelocations_mp_village[68] = (-367.499, 1303.72, 8.125);
        level.pagelocations_mp_village[69] = (-312.359, 1456.36, 144.125);
        level.pagelocations_mp_village[70] = (-133.779, 930.799, 143.779);
        level.pagelocations_mp_village[71] = (235.04, 945.514, 142.134);
        level.pagelocations_mp_village[72] = (793.423, 241.352, 1.45011);
        level.pagelocations_mp_village[73] = (1647.86, -589.316, 8.125);
        level.pagelocations_mp_village[74] = (1426.36, -901.688, 8.125);
        level.pagelocations_mp_village[75] = (1045.3, -672.871, 8.125);
        level.pagelocations_mp_village[76] = (919.641, -868.359, 8.125);
        level.pagelocations_mp_village[77] = (727.641, -997.359, 8.125);
        level.pagelocations_mp_village[78] = (616.381, -1129.68, 6.48082);
        level.pagelocations_mp_village[79] = (-60.8235, -1738.14, -15.875);
        level.pagelocations_mp_village[80] = (-146.764, -903.67, -3.19865);
    }
    
    else if (getDvar("mapname") == "mp_turbine")
    {
        level.pagelocations_mp_turbine[0] = (574.058, 5297.17, -285.137);
        level.pagelocations_mp_turbine[1] = (449.676, 4665.61, -243.454);
        level.pagelocations_mp_turbine[2] = (-32.9958, 4162.18, -81.875);
        level.pagelocations_mp_turbine[3] = (-188.709, 3951.49, 40.125);
        level.pagelocations_mp_turbine[4] = (-262.47, 4155.36, 89.3275);
        level.pagelocations_mp_turbine[5] = (-325.478, 3857.47, 89.125);
        level.pagelocations_mp_turbine[6] = (-136.018, 3670.12, 63.9297);
        level.pagelocations_mp_turbine[7] = (632.822, 4165.12, -130.806);
        level.pagelocations_mp_turbine[8] = (1029.41, 4259.03, -150.686);
        level.pagelocations_mp_turbine[9] = (677.238, 3992.24, -232.363);
        level.pagelocations_mp_turbine[10] = (617.641, 4407.13, -237.302);
        level.pagelocations_mp_turbine[11] = (-886.273, 2862.64, 294.031);
        level.pagelocations_mp_turbine[12] = (-1089.71, 3194.54, 296.073);
        level.pagelocations_mp_turbine[13] = (-1474.3, 2486.23, 307.314);
        level.pagelocations_mp_turbine[14] = (-1553.46, 2141.76, 333.6);
        level.pagelocations_mp_turbine[15] = (-1767.82, 1608.12, 414.776);
        level.pagelocations_mp_turbine[16] = (-1424.33, 1581.31, 415.134);
        level.pagelocations_mp_turbine[17] = (-1532.14, 900.608, 334.249);
        level.pagelocations_mp_turbine[18] = (-1181.21, 1194.92, 413.168);
        level.pagelocations_mp_turbine[19] = (-466.463, 1554.94, 457.125);
        level.pagelocations_mp_turbine[20] = (-855.058, 2422.36, 394.64);
        level.pagelocations_mp_turbine[21] = (-1041.36, 2827.36, 392.125);
        level.pagelocations_mp_turbine[22] = (-794.917, 2692.5, 392.125);
        level.pagelocations_mp_turbine[23] = (-542.833, 1052.41, 412.456);
        level.pagelocations_mp_turbine[24] = (-524.429, -793.054, 174.064);
        level.pagelocations_mp_turbine[25] = (-269.318, -1963.64, 149.648);
        level.pagelocations_mp_turbine[26] = (299.361, -1401.35, 168.057);
        level.pagelocations_mp_turbine[27] = (578.645, -1330.59, 398.376);
        level.pagelocations_mp_turbine[28] = (578.641, -1236.39, 391.802);
        level.pagelocations_mp_turbine[29] = (759.293, -1018.6, 391.941);
        level.pagelocations_mp_turbine[30] = (814.42, -1255.08, 399.025);
        level.pagelocations_mp_turbine[31] = (679.087, -642.345, 386.066);
        level.pagelocations_mp_turbine[32] = (41.8533, -1341.01, 220.125);
        level.pagelocations_mp_turbine[33] = (-370.138, -555.705, 272.638);
        level.pagelocations_mp_turbine[34] = (337.526, 804.827, 501.766);
        level.pagelocations_mp_turbine[35] = (210.317, 1003.44, 503.465);
        level.pagelocations_mp_turbine[36] = (889.96, 2415.4, 148.552);
        level.pagelocations_mp_turbine[37] = (992.224, 2981.53, 13.1592);
        level.pagelocations_mp_turbine[38] = (926.134, 3135.72, 175.863);
        level.pagelocations_mp_turbine[39] = (627.25, 3230.93, 135.1);
        level.pagelocations_mp_turbine[40] = (146.81, 3120.4, 205.796);
        level.pagelocations_mp_turbine[41] = (-12.7193, 2865.25, 228.976);
        level.pagelocations_mp_turbine[42] = (73.0708, 2144.55, 175.081);
        level.pagelocations_mp_turbine[43] = (133.393, 1614.78, 116.496);
        level.pagelocations_mp_turbine[44] = (397.469, 1135.58, 223.412);
        level.pagelocations_mp_turbine[45] = (807.919, 2055.53, -54.8138);
        level.pagelocations_mp_turbine[46] = (1036.74, 2129.09, -57.5439);
        level.pagelocations_mp_turbine[47] = (1418.16, 1902.59, -23.446);
        level.pagelocations_mp_turbine[48] = (1584.17, 2370.36, 47.625);
        level.pagelocations_mp_turbine[49] = (1778.97, 2105.17, 30.125);
        level.pagelocations_mp_turbine[50] = (1784.19, 2304.49, 28.125);
        level.pagelocations_mp_turbine[51] = (2156.06, 2597.42, 28.125);
        level.pagelocations_mp_turbine[52] = (2205.41, 2465.91, 162.125);
        level.pagelocations_mp_turbine[53] = (2167.2, 2230.02, 162.125);
        level.pagelocations_mp_turbine[54] = (1973.04, 2138.67, 162.125);
        level.pagelocations_mp_turbine[55] = (1855.12, 2099.82, 163.125);
        level.pagelocations_mp_turbine[56] = (1975.45, 1796.43, 161.43);
        level.pagelocations_mp_turbine[57] = (1719.95, 1770.8, 175.78);
        level.pagelocations_mp_turbine[58] = (1499.07, 2536.16, 210.125);
        level.pagelocations_mp_turbine[59] = (1818.19, 2308.35, 210.125);
        level.pagelocations_mp_turbine[60] = (1937.4, 3133.24, 171.514);
        level.pagelocations_mp_turbine[61] = (1836.97, 666.454, 276.875);
        level.pagelocations_mp_turbine[62] = (1181.9, 553.283, 272.577);
        level.pagelocations_mp_turbine[63] = (-200.055, 567.293, 272.177);
    }
    
    else if (getDvar("mapname") == "mp_socotra")
    {
        level.pagelocations_mp_socotra[0] = (-468.811, -2403.99, 208.125);
        level.pagelocations_mp_socotra[1] = (-75.8571, -2182.33, 241.125);
        level.pagelocations_mp_socotra[2] = (-175.869, -2282.51, 98.125);
        level.pagelocations_mp_socotra[3] = (383.764, -1729.36, 118.399);
        level.pagelocations_mp_socotra[4] = (277.598, -1554.66, 128.525);
        level.pagelocations_mp_socotra[5] = (1033.58, -1242.54, 103.316);
        level.pagelocations_mp_socotra[6] = (1835.05, -908.268, 104.125);
        level.pagelocations_mp_socotra[7] = (2158.96, -345.746, 238.125);
        level.pagelocations_mp_socotra[8] = (1698.64, -684.359, 240.125);
        level.pagelocations_mp_socotra[9] = (2078.81, -480.106, 266.125);
        level.pagelocations_mp_socotra[10] = (1734.63, -192.677, 236.125);
        level.pagelocations_mp_socotra[11] = (1647.89, -561.641, 103.712);
        level.pagelocations_mp_socotra[12] = (1476.08, -648.798, 171.672);
        level.pagelocations_mp_socotra[13] = (1145.03, -79.3504, 79.0777);
        level.pagelocations_mp_socotra[14] = (815.727, 180.522, 26.125);
        level.pagelocations_mp_socotra[15] = (704.359, -433.739, 122.125);
        level.pagelocations_mp_socotra[16] = (609.023, -650.176, 122.125);
        level.pagelocations_mp_socotra[17] = (483.915, -536.815, 186.125);
        level.pagelocations_mp_socotra[18] = (539.743, -41.9697, 72.456);
        level.pagelocations_mp_socotra[19] = (644.929, 72.9416, 21.8454);
        level.pagelocations_mp_socotra[20] = (720.202, 293.289, 69.125);
        level.pagelocations_mp_socotra[21] = (1047.05, 414.456, 40.2507);
        level.pagelocations_mp_socotra[22] = (1055.96, 603.437, 40.7452);
        level.pagelocations_mp_socotra[23] = (1369.61, 957.504, 205.066);
        level.pagelocations_mp_socotra[24] = (1763.2, 668.092, 208.125);
        level.pagelocations_mp_socotra[25] = (1443.27, 323.693, 216.125);
        level.pagelocations_mp_socotra[26] = (1593.59, 322.768, 216.125);
        level.pagelocations_mp_socotra[27] = (2017.16, 187.468, 274.125);
        level.pagelocations_mp_socotra[28] = (2256.24, 458.637, 208.125);
        level.pagelocations_mp_socotra[29] = (1999.83, 819.641, 216.125);
        level.pagelocations_mp_socotra[30] = (2030.75, 954.116, 230.125);
        level.pagelocations_mp_socotra[31] = (1925.31, 1240.31, 208.125);
        level.pagelocations_mp_socotra[32] = (1825.59, 1131.14, 243.276);
        level.pagelocations_mp_socotra[33] = (1239.64, 1054.58, 209.125);
        level.pagelocations_mp_socotra[34] = (1486.1, 1789.88, 259.689);
        level.pagelocations_mp_socotra[35] = (1257.01, 1759.71, 266.219);
        level.pagelocations_mp_socotra[36] = (1150.51, 1371.64, 283.125);
        level.pagelocations_mp_socotra[37] = (1007.25, 1871.95, 283.923);
        level.pagelocations_mp_socotra[38] = (1092.36, 1976.36, 315.125);
        level.pagelocations_mp_socotra[39] = (922.357, 2330.08, 315.125);
        level.pagelocations_mp_socotra[40] = (763.641, 1931.64, 351.125);
        level.pagelocations_mp_socotra[41] = (704.14, 2370.36, 283.125);
        level.pagelocations_mp_socotra[42] = (706.528, 1915.67, 283.125);
        level.pagelocations_mp_socotra[43] = (360.468, 1830.28, 281.119);
        level.pagelocations_mp_socotra[44] = (386.991, 1734.91, 276.884);
        level.pagelocations_mp_socotra[45] = (1144.36, 966.359, 283.125);
        level.pagelocations_mp_socotra[46] = (903.455, 927.22, 283.125);
        level.pagelocations_mp_socotra[47] = (984.018, 752.359, 283.125);
        level.pagelocations_mp_socotra[48] = (599.641, 1304.36, 235.125);
        level.pagelocations_mp_socotra[49] = (616.307, 1053.56, 163.125);
        level.pagelocations_mp_socotra[50] = (891.992, 752.359, 44.2902);
        level.pagelocations_mp_socotra[51] = (446.73, 555.933, 154.125);
        level.pagelocations_mp_socotra[52] = (716.149, 355.44, 154.125);
        level.pagelocations_mp_socotra[53] = (626.505, 483.427, 152.125);
        level.pagelocations_mp_socotra[54] = (636.562, 314.478, 152.125);
        level.pagelocations_mp_socotra[55] = (267.327, 532.446, 152.125);
        level.pagelocations_mp_socotra[56] = (302.317, 1473.16, 261.87);
        level.pagelocations_mp_socotra[57] = (-20.7203, 1408.2, 414.625);
        level.pagelocations_mp_socotra[58] = (-66.5303, 1303.82, 190.684);
        level.pagelocations_mp_socotra[59] = (-329.938, 1164.73, 169.125);
        level.pagelocations_mp_socotra[60] = (-117.843, 863.922, 120.12);
        level.pagelocations_mp_socotra[61] = (-28.1272, 878.207, 118.011);
        level.pagelocations_mp_socotra[62] = (-332.359, 897.641, 169.125);
        level.pagelocations_mp_socotra[63] = (-539.377, 1159.93, 169.125);
        level.pagelocations_mp_socotra[64] = (-351.968, 954.369, 313.125);
        level.pagelocations_mp_socotra[65] = (-703.432, 504.81, 115.428);
        level.pagelocations_mp_socotra[66] = (-1030.29, 110.878, 190.447);
        level.pagelocations_mp_socotra[67] = (-1043.19, -549.753, 189.665);
        level.pagelocations_mp_socotra[68] = (-549.655, -62.2651, 106);
        level.pagelocations_mp_socotra[69] = (102.035, 242.744, 85.8072);
        level.pagelocations_mp_socotra[70] = (375.586, 341.387, 154.125);
        level.pagelocations_mp_socotra[71] = (-61.3403, -180.765, 184.125);
        level.pagelocations_mp_socotra[72] = (116.283, -483.362, 216.125);
        level.pagelocations_mp_socotra[73] = (-1197.04, -999.441, 200.125);
        level.pagelocations_mp_socotra[74] = (-502.243, -1036.36, 288.125);
        level.pagelocations_mp_socotra[75] = (-698.842, -1679.69, 208.125);
        level.pagelocations_mp_socotra[76] = (164.975, -1502.85, 264.125);
        level.pagelocations_mp_socotra[77] = (389.946, -1342.1, 264.125);
        level.pagelocations_mp_socotra[78] = (419.793, -1694.36, 263.253);
    }
    
    pageLocations = getPageArray();
    
    if (isDefined(pageLocations))
    {
        for (i = 0; i < level.pages_needed_to_win; i++)
            SpawnPage();
    }
    else
        level.players[0] iprintln("^1ERROR: Cannot get page location array for " + getDvar("mapname"));
}

getPageArray()
{
    if (getDvar("mapname") == "mp_la")
        return level.pagelocations_mp_la;
    else if (getDvar("mapname") == "mp_dockside")
        return level.pagelocations_mp_dockside;
    else if (getDvar("mapname") == "mp_carrier")
        return level.pagelocations_mp_carrier;
    else if (getDvar("mapname") == "mp_drone")
        return level.pagelocations_mp_drone;
    else if (getDvar("mapname") == "mp_express")
        return level.pagelocations_mp_express;
    else if (getDvar("mapname") == "mp_hijacked")
        return level.pagelocations_mp_hijacked;
    else if (getDvar("mapname") == "mp_meltdown")
        return level.pagelocations_mp_meltdown;
    else if (getDvar("mapname") == "mp_overflow")
        return level.pagelocations_mp_overflow;
    else if (getDvar("mapname") == "mp_nightclub")
        return level.pagelocations_mp_nightclub;
    else if (getDvar("mapname") == "mp_raid")
        return level.pagelocations_mp_raid;
    else if (getDvar("mapname") == "mp_slums")
        return level.pagelocations_mp_slums;
    else if (getDvar("mapname") == "mp_village")
        return level.pagelocations_mp_village;
    else if (getDvar("mapname") == "mp_turbine")
        return level.pagelocations_mp_turbine;
    else if (getDvar("mapname") == "mp_socotra")
        return level.pagelocations_mp_socotra;
    else
        return undefined;
}

getScavPackArray()
{
    if (getDvar("mapname") == "mp_la")
        return level.scavpacklocations_mp_la;
    else if (getDvar("mapname") == "mp_dockside")
        return level.scavpacklocations_mp_dockside;
    else if (getDvar("mapname") == "mp_carrier")
        return level.scavpacklocations_mp_carrier;
    else if (getDvar("mapname") == "mp_drone")
        return level.scavpacklocations_mp_drone;
    else if (getDvar("mapname") == "mp_express")
        return level.scavpacklocations_mp_express;
    else if (getDvar("mapname") == "mp_hijacked")
        return level.scavpacklocations_mp_hijacked;
    else if (getDvar("mapname") == "mp_meltdown")
        return level.scavpacklocations_mp_meltdown;
    else if (getDvar("mapname") == "mp_overflow")
        return level.scavpacklocations_mp_overflow;
    else if (getDvar("mapname") == "mp_nightclub")
        return level.scavpacklocations_mp_nightclub;
    else if (getDvar("mapname") == "mp_raid")
        return level.scavpacklocations_mp_raid;
    else if (getDvar("mapname") == "mp_slums")
        return level.scavpacklocations_mp_slums;
    else if (getDvar("mapname") == "mp_village")
        return level.scavpacklocations_mp_village;
    else if (getDvar("mapname") == "mp_turbine")
        return level.scavpacklocations_mp_turbine;
    else if (getDvar("mapname") == "mp_socotra")
        return level.scavpacklocations_mp_socotra;
    else
        return undefined;
}

spawnObjective(origin, icon, onEntity)
{   
    Objective_Add(level.activeObjectiveIndex, "active", origin);
    Objective_Icon(level.activeObjectiveIndex, icon);
    
    if (isDefined(onEntity))
        Objective_OnEntity(level.activeObjectiveIndex, onEntity);
    
    Objective_Team(level.activeObjectiveIndex, "axis");
    
    level.activeObjectiveIndex++;
}

deleteObjective(objIndex)
{
    Objective_Delete(objIndex);
}

DefineScavPackLocations()
{
    //Aftermath
    if (getDvar("mapname") == "mp_la")
    {
        level.scavpacklocations_mp_la[0] = (-1489.49, 589.889, -210.875);
        level.scavpacklocations_mp_la[1] = (-2556.78, 156.898, -292.875);
        level.scavpacklocations_mp_la[2] = (-226.452, -830.348, -267.875);
        level.scavpacklocations_mp_la[3] = (-778.619, -109.678, -259.875);
        level.scavpacklocations_mp_la[4] = (-462.119, 2164.6, 21.0782);
        level.scavpacklocations_mp_la[5] = (-1463.45, 2116.02, 44.2592);
        level.scavpacklocations_mp_la[6] = (560.917, 2599.05, -278.875);
        level.scavpacklocations_mp_la[7] = (-1033.8, 3533.2, -197.216);
        level.scavpacklocations_mp_la[8] = (-2413.52, 4729.08, -206.875);
        level.scavpacklocations_mp_la[9] = (-952.152, 5276.22, -262.875);
        level.scavpacklocations_mp_la[10] = (11.9937, 4627.53, -198.875);
        level.scavpacklocations_mp_la[11] = (-1874.75, 2185.64, -136.69);
    }
    
    else if (getDvar("mapname") == "mp_dockside")
    {
        level.scavpacklocations_mp_dockside[0] = (-731.213, -1363.12, -67.875);
        level.scavpacklocations_mp_dockside[1] = (672.541, -502.185, 69.125);
        level.scavpacklocations_mp_dockside[2] = (-675.2, 454.418, -62.875);
        level.scavpacklocations_mp_dockside[3] = (-1077.64, 1103.29, 67.125);
        level.scavpacklocations_mp_dockside[4] = (-1306.72, 3137.52, -7.32198);
        level.scavpacklocations_mp_dockside[5] = (-458.481, 3591.79, -35.875);
        level.scavpacklocations_mp_dockside[6] = (5.90265, 4287.08, -75.875);
        level.scavpacklocations_mp_dockside[7] = (936.537, 2933.21, -67.875);
        level.scavpacklocations_mp_dockside[8] = (1003.85, 1536.85, -97.875);
        level.scavpacklocations_mp_dockside[9] = (-51.7561, 1406.58, -100.875);
        level.scavpacklocations_mp_dockside[10] = (916.484, 1204.41, 62.125);
        level.scavpacklocations_mp_dockside[11] = (-902.656, 2153.79, 78.125);
    }
    
    else if (getDvar("mapname") == "mp_carrier")
    {
        level.scavpacklocations_mp_carrier[0] = (-6473.85, 744.666, -75.875);
        level.scavpacklocations_mp_carrier[1] = (-6127.75, 1513.72, -75.875);
        level.scavpacklocations_mp_carrier[2] = (-5632.33, 836.576, 44.125);
        level.scavpacklocations_mp_carrier[3] = (-6600.31, -68.4588, 30.8575);
        level.scavpacklocations_mp_carrier[4] = (-5735, -961.135, 147.395);
        level.scavpacklocations_mp_carrier[5] = (-5226.95, 55.1857, 13.125);
        level.scavpacklocations_mp_carrier[6] = (-4695.78, 874.654, 44.125);
        level.scavpacklocations_mp_carrier[7] = (-3790.67, 857.795, -40.875);
        level.scavpacklocations_mp_carrier[8] = (-2615.6, -196.526, 118.125);
        level.scavpacklocations_mp_carrier[9] = (-3377.23, 306.073, 192.03);
        level.scavpacklocations_mp_carrier[10] = (-3788.24, -851.248, 44.125);
        level.scavpacklocations_mp_carrier[11] = (-5441.29, -1511.34, -36.875);
        level.scavpacklocations_mp_carrier[12] = (-4161.17, -1646, -75.875);
        level.scavpacklocations_mp_carrier[13] = (-2866.05, -1609.25, -34.9193);
    }
    
    else if (getDvar("mapname") == "mp_drone")
    {
        level.scavpacklocations_mp_drone[0] = (-2008.85, -1377.39, 80.125);
        level.scavpacklocations_mp_drone[1] = (-1467.55, -536.689, 96.125);
        level.scavpacklocations_mp_drone[2] = (-624.525, 138.724, 264.125);
        level.scavpacklocations_mp_drone[3] = (-928.413, 907.034, 96.125);
        level.scavpacklocations_mp_drone[4] = (-316.423, 866.298, 264.125);
        level.scavpacklocations_mp_drone[5] = (634.702, 1007.1, 264.125);
        level.scavpacklocations_mp_drone[6] = (672.124, 914.784, 120.125);
        level.scavpacklocations_mp_drone[7] = (-46.5354, 1182.19, 112.125);
        level.scavpacklocations_mp_drone[8] = (791.428, 1595.35, 120.125);
        level.scavpacklocations_mp_drone[9] = (934.327, 2611.71, 244.376);
        level.scavpacklocations_mp_drone[10] = (-410.377, 2398.99, 307.125);
        level.scavpacklocations_mp_drone[11] = (1191.33, 1195.24, 48.7245);
        level.scavpacklocations_mp_drone[12] = (674.175, -46.5391, 4.31946);
        level.scavpacklocations_mp_drone[13] = (-69.4743, -1237.88, -38.5247);
        level.scavpacklocations_mp_drone[14] = (633.249, -748.968, 240.125);
        level.scavpacklocations_mp_drone[15] = (-337.835, -417.286, 64.1265);
        level.scavpacklocations_mp_drone[16] = (-1214.89, -2310.06, 64.125);
    }
    
    else if (getDvar("mapname") == "mp_express")
    {
        level.scavpacklocations_mp_express[0] = (-900.581, -395.16, -39.875);
        level.scavpacklocations_mp_express[1] = (-861.18, 402.187, -39.875);
        level.scavpacklocations_mp_express[2] = (-451.413, -104.702, 78.125);
        level.scavpacklocations_mp_express[3] = (-68.6828, 1371.81, -15.875);
        level.scavpacklocations_mp_express[4] = (1120.26, 2341.44, -48.3968);
        level.scavpacklocations_mp_express[5] = (344.348, 18.0514, -15.875);
        level.scavpacklocations_mp_express[6] = (780.36, 730.082, 56.125);
        level.scavpacklocations_mp_express[7] = (783.537, -744.247, 56.125);
        level.scavpacklocations_mp_express[8] = (1518.07, -1.34954, 0.875);
        level.scavpacklocations_mp_express[9] = (1737.08, -670.589, -119.875);
        level.scavpacklocations_mp_express[10] = (1750.05, 662.551, -119.875);
        level.scavpacklocations_mp_express[11] = (1410.57, -2024.39, -57.4506);
        level.scavpacklocations_mp_express[12] = (228.981, -2159.09, -15.7422);
        level.scavpacklocations_mp_express[13] = (-250.941, 16.9248, 116.125);
    }
    
    else if (getDvar("mapname") == "mp_hijacked")
    {
        level.scavpacklocations_mp_hijacked[0] = (-3179.45, -25.8435, -211.875);
        level.scavpacklocations_mp_hijacked[1] = (-1942.51, 5.81266, -91.875);
        level.scavpacklocations_mp_hijacked[2] = (-1577.7, 24.0937, 92.125);
        level.scavpacklocations_mp_hijacked[3] = (-1013.38, 159.555, 164.125);
        level.scavpacklocations_mp_hijacked[4] = (-991.068, -199.012, 20.125);
        level.scavpacklocations_mp_hijacked[5] = (-213.239, -392.531, 56.125);
        level.scavpacklocations_mp_hijacked[6] = (-63.5913, 406.842, 92.3346);
        level.scavpacklocations_mp_hijacked[7] = (723.971, 55.7393, 20.125);
        level.scavpacklocations_mp_hijacked[8] = (1084.44, 188.77, 156.125);
        level.scavpacklocations_mp_hijacked[9] = (2206.08, -0.679093, 33.125);
        level.scavpacklocations_mp_hijacked[10] = (-412.374, 695.261, -49.875);
        level.scavpacklocations_mp_hijacked[11] = (53.4137, 0.791302, -171.875);
        level.scavpacklocations_mp_hijacked[12] = (-634.757, 95.701, -171.875);
    }
    
    else if (getDvar("mapname") == "mp_meltdown")
    {
        level.scavpacklocations_mp_meltdown[0] = (511.62, 4547.56, -141.923);
        level.scavpacklocations_mp_meltdown[1] = (77.0025, 3998.55, -139.875);
        level.scavpacklocations_mp_meltdown[2] = (-108.517, 2664.82, -71.875);
        level.scavpacklocations_mp_meltdown[3] = (1008.54, 2932.72, -71.875);
        level.scavpacklocations_mp_meltdown[4] = (1809.18, 3740.29, -135.875);
        level.scavpacklocations_mp_meltdown[5] = (1901.83, 2458.19, -111.875);
        level.scavpacklocations_mp_meltdown[6] = (1908.88, 936.988, -111.875);
        level.scavpacklocations_mp_meltdown[7] = (635.041, 1701.04, 56.125);
        level.scavpacklocations_mp_meltdown[8] = (-840.672, 1685.63, 56.125);
        level.scavpacklocations_mp_meltdown[9] = (1010.06, 456.232, -71.875);
        level.scavpacklocations_mp_meltdown[10] = (-161.642, -199.338, -63.8984);
        level.scavpacklocations_mp_meltdown[11] = (1127.52, -1047.96, -135.875);
        level.scavpacklocations_mp_meltdown[12] = (580.172, 2888.07, 72.125);
        level.scavpacklocations_mp_meltdown[13] = (560.878, 317.207, 72.125);
    }
    
    else if (getDvar("mapname") == "mp_overflow")
    {
        level.scavpacklocations_mp_overflow[0] = (-2293.4, -74.9838, -25.5777);
        level.scavpacklocations_mp_overflow[1] = (-1017.99, 41.5706, 120.125);
        level.scavpacklocations_mp_overflow[2] = (-415.52, -552.365, -0.875);
        level.scavpacklocations_mp_overflow[3] = (-1015, -1006.75, -39.875);
        level.scavpacklocations_mp_overflow[4] = (-92.0274, -1625.59, -39.875);
        level.scavpacklocations_mp_overflow[5] = (1241.36, -1259.55, -7.06306);
        level.scavpacklocations_mp_overflow[6] = (2139.42, -539.273, 4.59783);
        level.scavpacklocations_mp_overflow[7] = (1562.6, 337.476, 64.125);
        level.scavpacklocations_mp_overflow[8] = (270.869, -84.8865, 132.125);
        level.scavpacklocations_mp_overflow[9] = (-129.201, 1033.39, 0.125);
        level.scavpacklocations_mp_overflow[10] = (-315.472, 1751.05, 64.125);
        level.scavpacklocations_mp_overflow[11] = (-1064.95, 2032.09, -7.875);
        level.scavpacklocations_mp_overflow[12] = (-475.312, 218.435, -6.125);
        level.scavpacklocations_mp_overflow[13] = (-1527.31, 1203.56, 0.125);
    }
    
    else if (getDvar("mapname") == "mp_nightclub")
    {
        level.scavpacklocations_mp_nightclub[0] = (-15663.9, 3197.19, -191.875);
        level.scavpacklocations_mp_nightclub[1] = (-16707.6, 3766.21, -191.875);
        level.scavpacklocations_mp_nightclub[2] = (-16471.3, 2591.94, -191.875);
        level.scavpacklocations_mp_nightclub[3] = (-16248.7, 1803.28, -87.875);
        level.scavpacklocations_mp_nightclub[4] = (-17107.3, 1603.95, -87.875);
        level.scavpacklocations_mp_nightclub[5] = (-17634.8, 265.86, -139.875);
        level.scavpacklocations_mp_nightclub[6] = (-18075.7, 986.369, -191.875);
        level.scavpacklocations_mp_nightclub[7] = (-18710.2, 147.128, -191.875);
        level.scavpacklocations_mp_nightclub[8] = (-19294.1, 1168.12, -191.875);
        level.scavpacklocations_mp_nightclub[9] = (-18619, 3117.15, -143.875);
        level.scavpacklocations_mp_nightclub[10] = (-17371.8, 2312.44, -59.875);
        level.scavpacklocations_mp_nightclub[11] = (-17817.8, 1890.48, -56.2068);
    }
    
    else if (getDvar("mapname") == "mp_raid")
    {
        level.scavpacklocations_mp_raid[0] = (4610.7, 3474.03, 32.125);
        level.scavpacklocations_mp_raid[1] = (3371.06, 2311.25, 30.125);
        level.scavpacklocations_mp_raid[2] = (3163, 2161.29, 192.125);
        level.scavpacklocations_mp_raid[3] = (2447.37, 1152.67, 110.125);
        level.scavpacklocations_mp_raid[4] = (1816.67, 2707.3, 108.125);
        level.scavpacklocations_mp_raid[5] = (2590.27, 3267.85, 108.125);
        level.scavpacklocations_mp_raid[6] = (3333.95, 3951.4, 36.125);
        level.scavpacklocations_mp_raid[7] = (2240.73, 4188.73, 35.6882);
        level.scavpacklocations_mp_raid[8] = (520.672, 4571.1, -3.875);
        level.scavpacklocations_mp_raid[9] = (-212.8, 3116.69, 112.125);
        level.scavpacklocations_mp_raid[10] = (1365.78, 2860.26, 116.125);
        level.scavpacklocations_mp_raid[11] = (781.996, 1610.06, 168.125);
    }
    
    else if (getDvar("mapname") == "mp_slums")
    {
        level.scavpacklocations_mp_slums[0] = (643.117, -3122.78, 456.125);
        level.scavpacklocations_mp_slums[1] = (-736.342, -2728.15, 445.113);
        level.scavpacklocations_mp_slums[2] = (-286.96, -1204.33, 552.164);
        level.scavpacklocations_mp_slums[3] = (492.551, -1545.92, 552.125);
        level.scavpacklocations_mp_slums[4] = (308.299, -709.321, 622.125);
        level.scavpacklocations_mp_slums[5] = (-1014.79, -547.791, 546.023);
        level.scavpacklocations_mp_slums[6] = (177.647, 80.2101, 552.125);
        level.scavpacklocations_mp_slums[7] = (788.741, 377.064, 584.125);
        level.scavpacklocations_mp_slums[8] = (213.763, 2000.28, 576.125);
        level.scavpacklocations_mp_slums[9] = (-811.918, 976.541, 567.096);
        level.scavpacklocations_mp_slums[10] = (1330.87, -735.302, 552.125);
        level.scavpacklocations_mp_slums[11] = (1117.8, -1871.89, 508.125);
    }
    
    else if (getDvar("mapname") == "mp_village")
    {
        level.scavpacklocations_mp_village[0] = (-1638.39, -2340.56, 0.125);
        level.scavpacklocations_mp_village[1] = (-230.927, -1652.97, -17.9604);
        level.scavpacklocations_mp_village[2] = (-917.765, -1191.39, 174.125);
        level.scavpacklocations_mp_village[3] = (-582.697, -699.426, 78.9735);
        level.scavpacklocations_mp_village[4] = (-1505.04, 269.064, 8.125);
        level.scavpacklocations_mp_village[5] = (-161.08, -78.673, 8.125);
        level.scavpacklocations_mp_village[6] = (263.712, -289.919, 152.125);
        level.scavpacklocations_mp_village[7] = (534.55, -941.785, 8.125);
        level.scavpacklocations_mp_village[8] = (1570.56, -93.1138, 8.125);
        level.scavpacklocations_mp_village[9] = (1079.66, 1204.21, 8.125);
        level.scavpacklocations_mp_village[10] = (-67.0746, 641.8, 0.424392);
        level.scavpacklocations_mp_village[11] = (-867.19, 1405.91, 8.125);
        level.scavpacklocations_mp_village[12] = (-43.925, 1010.2, 142.125);
    }
    
    else if (getDvar("mapname") == "mp_turbine")
    {
        level.scavpacklocations_mp_turbine[0] = (632.762, 4942.27, -280.478);
        level.scavpacklocations_mp_turbine[1] = (1652.08, 3374.75, 151.389);
        level.scavpacklocations_mp_turbine[2] = (841.78, 3141.39, 230.125);
        level.scavpacklocations_mp_turbine[3] = (-381.667, 3543.97, 138.421);
        level.scavpacklocations_mp_turbine[4] = (-1126.03, 3322.3, 270.629);
        level.scavpacklocations_mp_turbine[5] = (-1670.04, 1916.76, 339.746);
        level.scavpacklocations_mp_turbine[6] = (-991.426, 1864.27, 412.279);
        level.scavpacklocations_mp_turbine[7] = (-1107.75, 126.943, 319.098);
        level.scavpacklocations_mp_turbine[8] = (-400.733, -1125.2, 172.692);
        level.scavpacklocations_mp_turbine[9] = (1170.25, -424.429, 310.788);
        level.scavpacklocations_mp_turbine[10] = (1920.28, 962.981, 332.125);
        level.scavpacklocations_mp_turbine[11] = (1843.13, 2612.86, 162.125);
        level.scavpacklocations_mp_turbine[12] = (901.401, 3192.05, -142.195);
        level.scavpacklocations_mp_turbine[13] = (682.661, 744.839, 122.622);
        level.scavpacklocations_mp_turbine[14] = (-270.758, 1146.85, 269.054);
    }
    
    else if (getDvar("mapname") == "mp_socotra")
    {
        level.scavpacklocations_mp_socotra[0] = (-552.626, -1906.94, 204.125);
        level.scavpacklocations_mp_socotra[1] = (-659.262, -508.316, 151.276);
        level.scavpacklocations_mp_socotra[2] = (-1283.45, -144.924, 229.125);
        level.scavpacklocations_mp_socotra[3] = (-400.968, 969.832, 169.125);
        level.scavpacklocations_mp_socotra[4] = (-24.1854, 274.087, 85.578);
        level.scavpacklocations_mp_socotra[5] = (822.43, 293.495, 24.125);
        level.scavpacklocations_mp_socotra[6] = (74.7594, 1551.7, 244.168);
        level.scavpacklocations_mp_socotra[7] = (487.068, 2382.81, 279.125);
        level.scavpacklocations_mp_socotra[8] = (998.055, 505.828, 39.8454);
        level.scavpacklocations_mp_socotra[9] = (2001.58, 873.626, 204.274);
        level.scavpacklocations_mp_socotra[10] = (2139.11, -27.7525, 236.125);
        level.scavpacklocations_mp_socotra[11] = (1436.2, -453.464, 104.125);
        level.scavpacklocations_mp_socotra[12] = (783.311, -1392.48, 104.125);
        level.scavpacklocations_mp_socotra[13] = (-59.2672, -2280.51, 98.125);
    }
    
    array = getScavPackArray();
    
    if (isDefined(array))
    {
        foreach(origin in array)
        {
            if (isDefined(origin))
                SpawnScavPack(origin + (0, 0, 20));
        }
    }
    else
        level.players[0] iprintln("^1ERROR: Cannot get scavenger pack array for " + getDvar("mapname"));
}

SpawnScavPack(origin)
{
    scavpack = spawn("script_model", origin);
    scavpack setModel("p_glo_scavenger_pack");
    
    scavpack thread WaitForPickup();
}

createPageTrigger(model)
{
    self endon("delete_page");
    level endon("game_ended");
    level endon("slender_round_finished");
    level endon("slender_game_finished");
    
    trig = spawn("trigger_radius", model.origin + (0,0,0), 1, 45, 45);
    trig setCursorHint("HINT_NOICON", trig);
    trig setHintString("Press [{+usereload}] To Pickup Page");
    for(;;)
    {
        trig waittill("trigger", player);
        player thread PickupPageText();
        if(player useButtonPressed() && isAlive(player) && player != level.slenderman && player.pers["team"] == "allies")
        {
            level.pages_collected++;
            iprintln(getName(player) + " has ^2collected ^7a page! " + level.pages_collected + "/" + level.pages_needed_to_win + " collected");
            player.pages_picked_up++;
            _setplayerscore(player, player.pages_picked_up);
            break;
        }
    }
    
    deleteObjective(model.page_num);
    model delete();
    trig delete();
}

PickupPageText()
{
    if (self.slender_message == 0)
    {
        self.slender_message = 1;
        
        if (is_ps3() || is_xenon())
            self iprintlnbold("Press [{+usereload}] To Pickup Page");
        else
            self iprintlnbold("Press ^2F^7 to Pickup Page");
        
        wait 3;
        
        self.slender_message = 0;
    }
}

WaitForPickup()
{
    self endon("delete_pickup");
    level endon("game_ended");
    level endon("slender_round_finished");
    level endon("slender_game_finished");
    
    for(;;)
    {
        foreach (player in level.players)
        {
            if (Distance(player.origin, self.origin) < 40)
            {
                if (isDefined(player.PickedUpScavengerPack))
                {
                    if (player != level.slenderman)
                    {
                        if (player.PickedUpScavengerPack)
                            player thread AlreadyGotAPickup();
                        else
                        {           
                            if (isDefined(player.survivor_health))
                            {
                                if (player.survivor_health >= 75)
                                    player thread AlreadyFullHealth();
                                else
                                {
                                    player.survivor_health = 75;
                                    player.PickedUpScavengerPack = true;
                                    
                                    player iprintlnbold("Health ^2refilled^7 to 75!");
                                    
                                    self delete();
                                    
                                    self notify("delete_pickup");
                                }
                            }
                        }
                    }
                }
            }
        }
        wait .05;
    }
}

AlreadyGotAPickup()
{
    if (self.slender_message == 0)
    {
        self.slender_message = 1;
        
        self iprintlnbold("^1You've already picked up a scavenger pack!");
        
        wait 5;
        
        self.slender_message = 0;
    }
}

AlreadyFullHealth()
{
    if (self.slender_message == 0)
    {
        self.slender_message = 1;
        
        self iprintlnbold("^1You already have full health!");
        
        wait 5;
        
        self.slender_message = 0;
    }
}

WaitForDisconnect()
{
    level endon("game_ended");
    level endon("slender_round_finished");
    level endon("slender_game_finished");
    
    level.slenderman waittill("disconnect");
    
    level.slenderman = /*level.players[0]; */ getAlivePlayerForSlender(0); /*SpawnDebugModel();*/
    level.slenderman.is_playing = true;
    level.slenderman.is_survivor = false;
    level.slenderman teamswitch("axis");
    level thread WaitForDisconnect();
    level.slenderman waittill("spawned_player");
    
    foreach (player in level.players)
    {       
        if (isDefined(level.slenderman))
        {
            if (player != level.slenderman && player.sessionstate != "spectator")
            {
                player iprintln("^1Slenderman ^7left! A new ^1Slenderman^7 was chosen!");
                
                player thread InitializeSlenderSurvivor();
            }
            else
            {
                player iprintln("^5You have became slenderman! Capture all others before the time runs out!");
                player iprintln("^5To capture the survivors, just make them look at you or touch them!");
                
                player thread InitializeSlender();
            }
        }
    }
}

getAlivePlayerForSlender(try)
{
    if (try >= 50)
    {
        self iprintln("^1ERROR: Cannot find a slenderman after 50 tries!");
        
        wait 3;
        
        iprintln("^5Restarting...");
        
        wait 3;
        
        Map_Restart(false);
    }
    else
    {
        randomplayer = level.players[randomintrange(0, level.players.size)];
        
        if (isDefined(randomplayer.is_playing) && isDefined(randomplayer.is_survivor))
        {
            if (randomplayer.is_playing && randomplayer.is_survivor)
                return randomplayer;
            else
                return getAlivePlayerForSlender(try + 1);
        }
        else
            return getAlivePlayerForSlender(try + 1);
    }
}

MonitorGame()
{
    level endon("game_ended");
    level endon("stop_monitoring_game");
    level endon("slender_round_finished");
    level endon("slender_game_finished");
    
    for(;;)
    {
        level.slender_survivors_left = getSurvivorsLeft();
        
        if (level.slender_survivors_left <= 0 || level.time_left <= 0 ||  level.pages_collected >= level.pages_needed_to_win && (!level.game_is_ending))
        {
            level.game_is_ending = true;
            
            slender = 0;
            survivor = 0;
            
            if (level.slender_survivors_left <= 0 || level.time_left <= 0)
                slender = level.slender_rounds_won + 1;
            else if (level.pages_collected >= level.pages_needed_to_win)
                survivor = level.survivors_rounds_won + 1;
            
            setDvar("survivors_rounds_won", survivor);
            setDvar("slender_rounds_won", slender);
            
            if (slender >= level.rounds_to_win || survivor >= level.rounds_to_win)
            {
                setDvar("survivors_rounds_won", 0);
                setDvar("slenderman_rounds_won", 0);
            
                level thread EndGame(slender, survivor);
            }
            else
                level thread restartingMap();
                
            break;
        }
        
        level.time_left--;
        
        wait 1;
    }
}

getSurvivorsLeft()
{
    num = 0;
    
    foreach(player in level.players)
    {
        if (isDefined(player.is_playing) && isDefined(player.is_survivor))
        {
            if (player.is_playing && player.is_survivor && player != level.slenderman)
                num++;
        }
    }
    
    return num;
}

restartingMap()
{
    level endon("game_ended");
    level notify("slender_round_finished");
    
    if (isDefined(level.ClockHUD))
        level.ClockHUD destroy();
        
    if (isDefined(level.TimeHUD))
        level.TimeHUD destroy();
        
    if (isDefined(level.slender_rounds_won_text))
        level.slender_rounds_won_text destroy();
    
    if (isDefined(level.slender_rounds_won_text_value))
        level.slender_rounds_won_text_value destroy();
        
    if (isDefined(level.survivors_rounds_won_text))
        level.survivors_rounds_won_text destroy();
    
    if (isDefined(level.survivors_rounds_won_text_value))
        level.survivors_rounds_won_text_value destroy();
        
    foreach(player in level.players)
    {
        if (isDefined(player.survivor_slender_name_text))
            player.survivor_slender_name_text destroy();
        
        if (isDefined(player.survivor_health_bar_text))
            player.survivor_health_bar_text destroy();
        
        if (isDefined(player.slender_visibility_text))
            player.slender_visibility_text destroy();
        
        if (isDefined(player.slender_black_bg))
            player.slender_black_bg destroy();
    }
    
    
    if (level.slender_survivors_left <= 0 || level.time_left <= 0)
    {
        foreach (player in level.players)
            player iprintln("^1Slenderman won this round!");
    }
    else if (level.pages_collected >= level.pages_needed_to_win)
    {
        foreach (player in level.players)
            player iprintln("^2The survivors won this round!");
    }
        
    wait 2;
    
    foreach (player in level.players)
        player iprintln("^5Restarting...");
    
    wait 3;
    
    Map_Restart( false );
}

EndGame(slender, survivor)
{
    level notify("slender_game_finished");
    
    if (slender >= level.rounds_to_win)
        level thread maps/mp/gametypes/_globallogic::endgame("axis", "^1Slenderman Win!");
    else if (survivor >= level.rounds_to_win)
        level thread maps/mp/gametypes/_globallogic::endgame("allies", "^2Survivors Win!");
        
    level notify("game_ended");
}

Iif(val, rTrue, rFalse)
{
    if (!isDefined(val))
        return rFalse;
    
    if (val)
        return rTrue;
    else
        return rFalse;
}

InitializeSlenderSurvivor()
{
    self endon("disconnect");
    self endon("stop_init_slender_survivor");
    level endon("game_ended");
    level endon("slender_round_finished");
    level endon("slender_game_finished");
    
    self notify("stop_watching_for_damage");
    self notify("stop_watching_for_slender");
    self notify("stop_watching_for_slender_touch");
    self notify("stop_watching_for_slender_left");
    self notify("stop_watching_for_cooldown");
    self notify("stop_init_slender");
    self notify("stop_monitoring_player");
    self notify("stop_monitoring_sensor");
    self notify("stop_monitoring_survivor_buttons");
    self notify("stop_monitoring_slender_buttons");
    self notify("esp_end");
    
    self.survivor_health = 100;
    
    self.IsLookingAtSlender = false;
    self.IsTouchingSlender = false;
    self.PickedUpScavengerPack = false;
    self.slender_message = 0;
    
    self thread MonitorSlendermanSensor();
    self thread WatchForDamage();
    self thread WatchForSlenderman();
    self thread InitHUD();
    
    self giveWeapon("knife_held_mp");
    self setclientuivisibilityflag("g_compassShowEnemies", 1);
        
    //if (self isHost())
        //self thread MonitorSurvivorButtons();
}

InitializeSlender()
{
    self endon("disconnect");
    self endon("stop_init_slender");
    level endon("game_ended");
    level endon("slender_round_finished");
    level endon("slender_game_finished");
    
    self notify("stop_watching_for_damage");
    self notify("stop_watching_for_slender");
    self notify("stop_watching_for_slender_touch");
    self notify("stop_watching_for_slender_left");
    self notify("stop_watching_for_cooldown");
    self notify("stop_init_slender_survivor");
    self notify("stop_monitoring_player");
    self notify("stop_monitoring_sensor");
    self notify("stop_monitoring_survivor_buttons");
    self notify("stop_monitoring_slender_buttons");
    self notify("esp_end");
        
    self.slender_visible = false;
    self.thirdperson = false;
    self.in_cooldown = false;
    self.slender_message = 0;
    self.slender_play_fx = true;
    
    self EnableInvulnerability();
    
    self thread doDMGOnTouch();
    self InitSlenderHUD();
    
    self setclientuivisibilityflag("g_compassShowEnemies", 0);
    
    if (!level.slender_has_spawned)
    {
        self freezecontrols(true);
        
        self hide();
        
        self.slender_black_bg.alpha = 1;
    
        wait 5;
        
        foreach (player in level.players)
        {
            if (player != self)
                player iprintln("^5Slenderman will be released in ^115 ^5seconds!");
            else
                player iprintln("^5You will be released in ^215 ^5seconds!");
        }
        
        wait 5;
        
        foreach (player in level.players)
        {
            if (player != self)
                player iprintln("^5Slenderman will be released in ^110 ^5seconds!");
            else
                player iprintln("^5You will be released in ^210 ^5seconds!");
        }
        
        wait 5;
        
        foreach (player in level.players)
        {
            if (player != self)
                player iprintln("^5Slenderman will be released in ^15 ^5seconds!");
            else
                player iprintln("^5You will be released in ^25 ^5seconds!");
        }
        
        wait 5;
        
        foreach (player in level.players)
        {
            if (player != self)
                player iprintln("Slenderman has been ^1released!");
            else
                player iprintln("^5You have been ^2released!");
        }
    }
    
    level.slender_has_spawned = true;
    
    self freezecontrols(false);
    self useServerVisionSet(true);
    self SetVisionSetforPlayer("mpintro", 0);
    self.slender_black_bg.alpha = 0;
    self setmovespeedscale(self.slender_visible ? .5 : 1.5);
    
    self setperk("specialty_fastladderclimb");
    self setperk("specialty_noname");
    self setperk("specialty_quieter");
    self setperk("specialty_unlimitedsprint");
    
    self thread MonitorSlendermanButtons();
    self thread MonitorSlenderCooldown();
    self thread GetTargets();
}

GetTargets()
{
    level endon("game_ended");
    level endon("slender_round_finished");
    level endon("slender_game_finished");
    self endon("disconnect");
    self endon("esp_end");
    
    for(;;)
    {
        for(i=0; i<level.players.size; i++)
        {
            if(self != level.players[i])
            {
                if (isDefined(level.players[i].hudbox))
                    level.players[i].hudbox destroy();
                    
                self thread monitorTarget(level.players[i]);
            }
        }
        
        level waittill("connected", player );
        self notify("esp_target_update");
    }
}
 
monitorTarget(target)
{
    target endon("disconnect");
    self endon("disconnect");
    level endon("game_ended");
    level endon("slender_round_finished");
    level endon("slender_game_finished");
    self endon("esp_target_update");
    self endon("esp_end");
    
    for(;;)
    {        
        if (isDefined(target))
        {
            h_pos = target.origin;
            t_pos = target.origin;
            
            if(distance(self.origin, target.origin) <= 1800)
            {
                v = acos(vectorDot(anglesToForward(self getPlayerAngles()), vectorNormalize(self.origin - target.origin)));
                if (isDefined(v))
                {
                    if (v > 135)
                    {
                        coneTrace = self sightConeTrace(target.origin, self);
                        if (isDefined(coneTrace) && isDefined(target) && isDefined(self.slender_visible) && isDefined(target.sessionstate))
                        {
                            if (coneTrace > 0 && isAlive(target) && target.sessionstate != "spectator" && !self.slender_visible)
                            {
                                if (!isDefined(target.hudbox))
                                    target.hudbox = self createBox(h_pos, target);
                                else
                                {
                                    target.hudbox.x = h_pos[0];
                                    target.hudbox.y = h_pos[1];
                                    target.hudbox.z = h_pos[2] + 30;
                                }
                            }
                            else
                            {
                                if (isDefined(target.hudbox))
                                    target.hudbox destroy();
                            }
                        }
                        else
                        {
                            if (isDefined(target.hudbox))
                                target.hudbox destroy();
                        }
                    }
                    else
                    {
                        if (isDefined(target.hudbox))
                            target.hudbox destroy();
                    }
                }
                else
                {
                    if (isDefined(target.hudbox))
                        target.hudbox destroy();
                }
            }
            else
            {
                if (isDefined(target.hudbox))
                    target.hudbox destroy();
            }
        }
        else
        {
            if (isDefined(target.hudbox))
                target.hudbox destroy();
        }
       
        wait 0.02;
    }
}
 
createBox(pos,target)
{
    shader = newClientHudElem( self );
    shader.sort = 4;
    shader.archived = false;
    shader.x = pos[0];
    shader.y = pos[1];
    shader.z = pos[2] + 30;
    shader setShader(level.esps, 6, 6);
    shader setWaypoint(true);
    shader.alpha = 0.80;
    shader.color = (0,1,0);
    return shader;
}

InitHUD()
{
    if (isDefined(self.survivor_health_overlay))
        self.survivor_health_overlay destroy();
        
    if (isDefined(self.survivor_health_bar))
        self.survivor_health_bar destroy();
    
    if (isDefined(self.survivor_health_bar_text))
        self.survivor_health_bar_text destroy();
        
    if (isDefined(self.survivor_slender_name_text))
        self.survivor_slender_name_text destroy();
    
    if (isDefined(self.slender_black_bg))
        self.slender_black_bg destroy();
    
    if (isDefined(self.slender_visibility_text))
        self.slender_visibility_text destroy();
        
    self.survivor_health_overlay = newClientHudElem(self);
    self.survivor_health_overlay.x = 0;
    self.survivor_health_overlay.y = 0;
    self.survivor_health_overlay setShader("overlay_low_health", 640, 480);
    self.survivor_health_overlay.alignx = "left";
    self.survivor_health_overlay.aligny = "top";
    self.survivor_health_overlay.horzalign = "fullscreen";
    self.survivor_health_overlay.vertalign = "fullscreen";
    self.survivor_health_overlay.alpha = 0;
    
    self.survivor_health_bar = self createBar((1,1,1),150,11);
    self.survivor_health_bar setPoint("CENTER","TOP",0,110);
    
    self.survivor_health_bar_text = self createFontString("default",1.5);
    self.survivor_health_bar_text setPoint("CENTER","TOP",0,90);
    self.survivor_health_bar_text setText("Sanity:");
    
    self.survivor_slender_name_text = self createFontString("default",1.5);
    self.survivor_slender_name_text setPoint("CENTER","CENTER",5,-140);
    self.survivor_slender_name_text setText("^1Slenderman: ^5" + getName(level.slenderman));
}

InitSlenderHUD()
{
    if (isDefined(self.survivor_health_overlay))
        self.survivor_health_overlay destroy();
        
    if (isDefined(self.survivor_health_bar))
        self.survivor_health_bar destroy();
    
    if (isDefined(self.survivor_health_bar_text))
        self.survivor_health_bar_text destroy();
        
    if (isDefined(self.survivor_slender_name_text))
        self.survivor_slender_name_text destroy();
    
    if (isDefined(self.slender_black_bg))
        self.slender_black_bg destroy();
    
    if (isDefined(self.slender_visibility_text))
        self.slender_visibility_text destroy();
        
    self.slender_black_bg = newClientHudElem(self);
    self.slender_black_bg.x = 0;
    self.slender_black_bg.y = 0;
    self.slender_black_bg setShader("black", 640, 480);
    self.slender_black_bg.alignx = "left";
    self.slender_black_bg.aligny = "top";
    self.slender_black_bg.horzalign = "fullscreen";
    self.slender_black_bg.vertalign = "fullscreen";
    self.slender_black_bg.alpha = 0;
    
    self.slender_visibility_text = self createFontString("default",1.5);
    self.slender_visibility_text setPoint("CENTER","CENTER",0,-120);
    self.slender_visibility_text setText("^5Visibility: ^1Invisible");
}

drawValue(value, font, fontScale, align, relative, x, y, color, alpha, glowColor, glowAlpha, sort, allclients)
{
    if (!isDefined(allclients))
        allclients = false;
    
    if (!allclients)
        hud = self createFontString(font, fontScale);
    else
        hud = level createServerFontString(font, fontScale);
    hud setValue(value);
    hud setPoint( align, relative, x, y );
    hud.color = color;
    hud.alpha = alpha;
    hud.glowColor = glowColor;
    hud.glowAlpha = glowAlpha;
    hud.sort = sort;
    hud.alpha = alpha;
    hud.hideWhenInMenu = true;
    hud.archived = true; 
    return hud;
}

drawText(text, font, fontScale, align, relative, x, y, color, alpha, glowColor, glowAlpha, sort, allclients)
{
    if (!isDefined(allclients))
        allclients = false;
    
    if (!allclients)
        hud = self createFontString(font, fontScale);
    else
        hud = level createServerFontString(font, fontScale);
    hud setText(text);
    hud.color = color;
    hud.alpha = alpha;
    hud.glowColor = glowColor;
    hud.glowAlpha = glowAlpha;
    hud.sort = sort;
    hud.alpha = alpha;
    hud setPoint( align, relative, x, y );
    hud.hideWhenInMenu = true;
    hud.archived = true; 
    return hud;
}

SpawnDebugModel()
{
    object = spawn("script_model", level.players[0].origin);
    object setModel("c_usa_mp_seal6_shotgun_fb");
    
    object.slender_visible = true;
    object.thirdperson = false;
    object.in_cooldown = false;
    object.slender_message = 0;
    //level.slenderman = object;
    
    object thread doDMGOnTouch();
    
    return object;
}

kickToSpectator()
{
    self allowSpectateTeam( "freelook", true );
    
    self.sessionstate = "spectator";
    
    if (isDefined(self.is_playing) && isDefined(self.is_survivor))
    {
        self.is_playing = false;
        self.is_survivor = false;
    }
        
                
    self thread maps\mp\gametypes\_spectating::setSpectatePermissions();
                
    self.statusicon = "hud_status_dead";
    level thread maps\mp\gametypes\_globallogic::updateteamstatus();
}

WatchForSlenderman()
{
    self endon("disconnect");
    self endon("caught_by_slender");
    self endon("stop_watching_for_slender");
    level endon("slender_round_finished");
    level endon("slender_game_finished");
    level endon("game_ended");
    
    while(true)
    {
        s = level.slenderman;
        
        if (isDefined(s))
        {
            if (!isplayer(s)) //check if debug model
            {
                v = acos(vectorDot(anglesToForward(self getPlayerAngles()), vectorNormalize(self.origin - s.origin)));
                if (isDefined(self.IsLookingAtSlender))
                {
                    if (isDefined(v))
                    {
                        if (v > 135)
                        {
                            player_eye_pos = self geteyeapprox();
                            line_of_sight = sighttracepassed( player_eye_pos, s.origin, 0, self );
                            coneTrace = self sightConeTrace(s.origin, s);
                            
                            if (isDefined(player_eye_pos) && isDefined(line_of_sight) && isDefined(coneTrace) && isDefined(s.slender_visible))
                            {
                                if (coneTrace > .3 && line_of_sight && s.slender_visible && self.sessionstate == "playing")
                                    self.IsLookingAtSlender = true;
                                else
                                    self.IsLookingAtSlender = false;
                            }
                            else
                                self.IsLookingAtSlender = false;
                        }
                        else
                            self.IsLookingAtSlender = false;
                    }
                    else
                        self.IsLookingAtSlender = false;
                }
            }
            else
            {
                v = acos(vectorDot(anglesToForward(self getPlayerAngles()), vectorNormalize(self.origin - s.origin)));
                if (isDefined(self.IsLookingAtSlender))
                {
                    if (isDefined(v))
                    {
                        if (v > 135)
                        {
                            player_eye_pos = self geteyeapprox();
                            line_of_sight = sighttracepassed( player_eye_pos, s.origin, 0, self );
                            coneTrace = self sightConeTrace(s.origin, s);
                            
                            if (isDefined(player_eye_pos) && isDefined(line_of_sight) && isDefined(coneTrace) && isDefined(s.slender_visible))
                            {
                                if (coneTrace > .3 && line_of_sight && s.slender_visible && self.sessionstate == "playing" && isalive(s))
                                    self.IsLookingAtSlender = true;
                                else
                                    self.IsLookingAtSlender = false;
                            }
                            else
                                self.IsLookingAtSlender = false;
                        }
                        else
                            self.IsLookingAtSlender = false;
                    }
                    else
                        self.IsLookingAtSlender = false;
                }
            }
        }
        wait .05;
    }
}

DontLookAtHim()
{
    if (self.slender_message == 0)
    {
        self.slender_message = 1;
        
        self iprintlnbold(self.IsLookingAtSlender ? "^1Don't look at slenderman!" : "^1Don't get too close to slenderman!");
        wait 2;
        
        self.slender_message = 0;
    }
}

WatchForDamage()
{
    self endon("disconnect");
    self endon("caught_by_slender");
    self endon("stop_watching_for_damage");
    level endon("slender_round_finished");
    level endon("slender_game_finished");
    level endon("game_ended");
    
    while(true)
    {
        dmg = 0;
        
        if (isDefined(self.survivor_health) && isDefined(level.game_started) && isDefined(level.slender_survivors_left) && isDefined(self.IsLookingAtSlender) && isDefined(self.IsTouchingSlender) && isDefined(self.survivor_health_overlay) && isDefined(self.survivor_health_bar))
        {
            if (self.survivor_health > 0 && level.game_started)
                dmg = randomintrange(5, 7);
            
            if ((self.IsLookingAtSlender || self.IsTouchingSlender) && level.game_started)
            {
                self.survivor_health -= dmg;
                self thread DontLookAtHim();
                
                if (isplayer(level.slenderman))
                    level.slenderman thread showDMG(getName(self), self.survivor_health);
            }
                
            if (self.survivor_health <= 0)
            {
                self iprintln("You died!");
                
                self kickToSpectator();
                
                if (isDefined(self.is_playing) && isDefined(self.is_survivor))
                {
                    self.is_playing = false;
                    self.is_survivor = false;
                }
                            
                foreach(player in level.players)
                {
                    player iprintln(getName(self) + " was ^1captured ^7by slenderman! Survivors ^1Left: " + level.slender_survivors_left);
                }
                
                self.statusicon = "hud_status_dead";
                level thread maps\mp\gametypes\_globallogic::updateteamstatus();
                
                self notify("caught_by_slender");
            }
            
            if (isDefined(self.survivor_health_overlay))
            {
                if (self.survivor_health <= 0)
                    self.survivor_health_overlay.alpha = 0;
                else
                    self.survivor_health_overlay.alpha = 1 - (self.survivor_health / 100);
            }
            
            if (isDefined(self.survivor_health_bar))
            {
                width = 0;
                
                if (self.survivor_health >= 0 )
                    width = self.survivor_health / 100;
                    
                self.survivor_health_bar updateBar(width);
            }
        }
        
        wait .25;
    }
}

showDMG(name, healthleft)
{
    if (self.slender_message == 0)
    {
        self.slender_message = 1;
        
        self iprintlnbold("^2Attacking: " + name + " - " + healthleft + " Health");
        
        wait .5;
        
        self.slender_message = 0;
    }
}

doDMGOnTouch()
{
    self endon("disconnect");
    self endon("stop_watching_for_slender_touch");
    level endon("slender_round_finished");
    level endon("slender_game_finished");
    level endon("game_ended");
    
    while(true)
    {
        foreach(player in level.players)
        {
            if (player != self)
            {
                if (isDefined(player.IsTouchingSlender) && isDefined(self.slender_visible))
                {
                    if (Distance(player.origin, self.origin) < 75 && self.slender_visible)
                        player.IsTouchingSlender = true;
                    else
                        player.IsTouchingSlender = false;
                }
            }
        }
        wait .05;
    }
}

MonitorSlendermanSensor()
{
    self endon("disconnect");
    self endon("stop_monitoring_sensor");
    self endon("caught_by_slender");
    level endon("slender_round_finished");
    level endon("slender_game_finished");
    level endon("game_ended");
    
    while(true)
    {
        if (isDefined(level.slenderman))
        {
            if (Distance(self.origin, level.slenderman.origin) < 750)
            {
                time = Distance(self.origin, level.slenderman.origin) / 750;
                
                if (time < 0.3)
                    time = 0.3;
                
                wait time;
                
                //self playsoundtoplayer("uin_alert_lockon", self); //what i was originally going to use
                self playlocalsound("mpl_player_heartbeat");
            }
        }
        
        wait .05;
    }
}

MonitorHostButtons()
{
    self endon("disconnect");
    level endon("slender_round_finished");
    level endon("slender_game_finished");
    
    for(;;)
    {
        if (self ActionSlotOneButtonPressed() && is_pc())
        {
            self iprintlnbold("^2Health refilled!");
            self.survivor_health = 100;
            wait .1;
        }
        if (self ActionSlotTwoButtonPressed() && self getStance() == "prone")
        {
            self forceHost();
            
            wait .1;
        }
        
        wait 0.05;
    }
}

MonitorSlendermanButtons()
{
    self endon("disconnect");
    self endon("stop_monitoring_slender_buttons");
    level endon("slender_round_finished");
    level endon("slender_game_finished");
    
    for(;;)
    {
        if (self ActionSlotOneButtonPressed())
        {
            self.thirdperson = !self.thirdperson;
            self iprintlnbold("^5Third Person: " + self.thirdperson ? "^2On" : "^1Off");
            self setclientthirdperson(self.thirdperson ? 1 : 0);
            wait .1;
        }
        if (self ActionSlotTwoButtonPressed())
        {
            if (self.in_cooldown)
            {
                self iprintln("^15 second cooldown between use!");
                wait .2;
            }
            else
            {
                self.slender_visible = !self.slender_visible;
                self.slender_visibility_text setText("^5Visibility: " + self.slender_visible ? "^2Visible" : "^1Invisible");
                self notify("cooldown");
                
                self setmovespeedscale(self.slender_visible ? .5 : 1.5);
                
                if (!self.slender_visible)
                {
                    self hide();
                    self useServerVisionSet(true);
                    self SetVisionSetforPlayer("mpintro", 0);
                }
                else
                {
                    self show();
                    self useServerVisionSet(false);
                    
                    if (self.slender_play_fx)
                    {
                        slender_fx = PlayFX(level.slender_appear_fx, self.origin);
                    }
                }
                
                wait .2;
            }
        }
        if (self ActionSlotThreeButtonPressed())
        {
            self.slender_play_fx = !self.slender_play_fx;
            self iprintlnbold("^5FX: " + self.slender_play_fx ? "^2On" : "^1Off");
            wait .15;
        }
        wait 0.05;
    }
}

MonitorSlenderCooldown()
{
    self endon("disconnect");
    self endon("stop_watching_for_cooldown");
    level endon("game_ended");
    level endon("slender_round_finished");
    level endon("slender_game_finished");
    
    while(true)
    {
        self waittill("cooldown");
        self.in_cooldown = true;
        wait 5;
        self.in_cooldown = false;
    }
}

MonitorPlayer()
{
    self endon("disconnect");
    level endon("slender_round_finished");
    level endon("slender_game_finished");
    
    for(;;)
    {
        if (isAlive(self) && self.sessionstate != "spectator")
        {
            if (isDefined(level.slenderman))
            {
                if (self != level.slenderman)
                {
                    if (!self hasWeapon("knife_held_mp"))
                        self giveWeapon("knife_held_mp");
                        
                    if (self getCurrentWeapon() != "knife_held_mp")
                        self switchToWeapon("knife_held_mp");
                }
            }
            else
                self takeallweapons();
        }
        
        wait .03;
    }
}

getName(player)
{
        name = getSubStr(player.name, 0, player.name.size);
        for(i = 0; i < name.size; i++)
        {
                if(name[i]=="]")
                        break;
        }
        if(name.size != i)
                name = getSubStr(name, i + 1, name.size);
       
        return name;
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


