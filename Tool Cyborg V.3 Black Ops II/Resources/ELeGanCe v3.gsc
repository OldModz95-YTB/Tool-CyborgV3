�GSC
       � F  �) L �� �� p� p�     @���    
   maps/mp/_imcsx_gsc_studio.gsc maps/mp/_utility common_scripts/utility maps/mp/gametypes/_globallogic maps/mp/gametypes/_hud maps/mp/gametypes/_hud_util maps/mp/gametypes/_hud_message maps/mp/gametypes/_weapons maps/mp/teams/_teams maps/mp/gametypes/_spawnlogic maps/mp/killstreaks/_ai_tank init onplayerconnect _a971 _k971 shades strtok line_horizontal,emblem_bg_bo2_nuclear_killer,mp_hud_cluster_status,headicon_dead,gradient_top , precacheshader _a971 _k971 model veh_t6_air_fa38_killstreak,dest_nt_nuked_female_01_d0,t6_wpn_supply_drop_ally,t6_wpn_supply_drop_trap,german_shepherd,fx_debris_stone_01,veh_t6_drone_overwatch_light,projectile_hellfire_missile,defaultactor,t6_wpn_tablet_view,mp_flag_red,mp_flag_neutral,t6_wpn_supply_drop_axis,defaultvehicle,veh_t6_drone_tank,veh_t6_drone_tank_alt precachemodel deads headicon_dead esps hud_remote_missile_target result connecting player ishost status Host Unverified onplayerspawned disconnect game_ended isfirstspawn freezecontrols menuinit wait_suicide_return spawned_player Co-Host Admin VIP Verified overflowfix deathbarrier iprintln [{+speed_throw}] & [{+melee}] To Open closemenuondeath menu backgroundinfo drawshader1 icontest alpha swagtext createfontstring hudbig setpoint right settext  foreground archived drawtext text font fontscale x y color glowcolor glowalpha sort hud textset shader width height newclienthudelem elemtype icon children setparent uiparent setshader verificationtonum verificationtocolor ^1Host ^4Co-Host ^6Admin ^3VIP ^2Verified ^5Unverified changeverificationmenu verlevel destroymenu Set Access Level For  getplayername  To  Your Access Level Has Been Set To  You Cannot Change The Access Level of The  Access Level For   Is Already Set To  changeverification playername getsubstr name i ] iif bool rtrue rfalse booleanreturnval returniffalse returniftrue booleanopposite createmenu add_menu add_option Main Mods submenu KillStreaks Menu Kill_sub Messages Menu Replys Weapons Menu weapon_sub Modell Menu shit_sub Modell List Bullets Menu bullet_sub Bullet List Fun Menu fun_sub Fun List Vehicle Menu fly_sub Vehicle List Trickshot Menu vip_sub Trickshot Mods Aimbot Menu Aim_sub Aimbot List admin_sub Admin List Modded Weapons weapons2_sub Game Settings settings_sub Custom Games* Custom Games Forge Menu forge_sub All Players Menu All_sub Players Menu PlayersMenu God Mode infinitehealth Infinite Ammo toggleammo Invisible cantseeme Ufo Mod / No Clip togglenoclip Clone Your Self clone All Perks doperks Constant UAV toggleplayeruav ESP Wallhack togglewallhack Suicide commitsuicide Third Person setthirdperson Speed x2 speedx2 Team Change initteamchange Change Class changeclass Teleport teleportwithipad Visions Menu Visiona EMP empv Thermal thermalv Black And White bwv Light lvis Enhanced ev ^3UAV ksgiveuav RC-XD ksgiverc Hunter Killer ksgivehunt Care Package ksgivecare Counter UAV ksgivecuav Gaurdian ksgivegaurd Hellstorm Missile ksgivehell Lightning Strike ksgivels Sentry Gun ksgivesg A.G.R ksgiveag Stealth Chopper ksgivesc Orbital VSAT ksgivevsat Escort Drone ksgiveed EMP System ksgiveemp Warthog ksgivewh Loadestar ksgivelst VTOL Warship ksgivevw Swarm ksgiveswarm ^5Press This Advert doadvert ^7Yes typewritter ^2Yes No ^1No Maybe ^1May^2be Okay ^2Okay Why? ^5WHY? CFW ^2I use a CFW to Mod Look On YT ^2Look On Youtube Man! Scammer ^1Youre A Scammer Fuck Off ^1Fuck Off Mods Not Free ^5Fuck Off The Mods are ^1Not Free ^1JokeSays JokeSays Dad ^2BTW Im Your Dad So Obey Me! ^1#Cunt Inbred ^5STFU Youre Fucking Inbred Why So Mad? ^1Why Are You So Mad Bruh? 9+10? ^2Whats 9+10? ^121 You Stupid! Talk English ^1Talk Fucking ^7English Paki Cunts Slut! ^1Shut The Fuck Up ^4Slut! Wont Get It ^5Wanna Hear A Joke ^1Doesnt Matter You Wont Get It Animal ^3Guys I Watch Animal Porn ^1<3 Mamma ^1Youre Mamma So Fat Dora Couldnt Explore Her. How Much ^2Dude How Much Is Your Mum?. USB Troll ^7I am Using A Usb To Mod :Troll. Fat Chicks ^2I Love Fat Chicks ^1<3. You Know? Max 6! test Death Machine givewdmachine War Machine givewwmachine AN-94 givewan LSAT givewlsat Peacekeeper givewpkeep SCAR-H givewscar Balista givewbalista DSR-50 givewdsr R-870 MCS givewmcs Crossbow givewcrsb RPG givewrpg ^1Take All Weapons takeweapon Default Model setdefomodel Debug Model setmodeldefoact Dog setmodeldog Trophy System setmodeltrosys Assault Drone setmodelassadro setmodelturret setmodelcarep setmodelhkiller UAV setmodeluav Little Bird setmodeloverwatch Attack Helicopter setmodelattackheli setmodelospley Stealth Bomber setmodelstealth Harrier setmodelharrier EMP Bullets initempbullets Flare Bullets toggle_flaregun Explosive Bullets expbulton Electric Bullets explosivebullets Christmas Bullets* greenlight1 Modded Bullets Modded_sub Press Here for ^2On/^1Off initmagicbullet selectmbmcs SMAW selectmbsmaw Grenade selectmbgrenade A.G.R Rocket selectmbagr Warthog Rocket selectmbwarthog Loadstar selectmblstar Mortar Missile Burner selectmbburner Remote Mortar Missile selectmbrmmm Heli Gunner Missile selectmbhgr selectmbswarm Hanter Killer selectmbhkill Special Bullets Special_sub initmagicgrenade Frag selectmltfrag Semtex selectmltstick Concussion selectmltconc Flash selectmltflash selectmltemp Smoke Grenade selectmltbetty Sensor selectmltsensor C4 selectmltshock Claymore selectmltclaym selectmlttrosy C-Axe selectmltaxe Shock Charge selectmltc4 Spawn Bullets Spawn_sub spawn_sub initspawnbullet Carepackage (Friendly) carepbullets Carepackage (Enemy) redcarebullets Carepackage (Detect) detcarebullets Carepackage (HQ) hqcarebullets A.G.R Drone agrbullets Drone Package dronebullets defacbullets dogbullets turretbullets lbirdbullets sbombbullets vtolbullets Human Centipede togglecentipede Pro Mod togglefov Riot Man riotman Terrorist  runc4death A10 Missile a10m Spec Nade toggle_specnade Smoke Monster initsmokemonster Walk On Air createpath Auto Drop-Shot autodropshot T-bag tbag Earthquake quake Jetpack dojetpack Exorczist toggleexor Human Torch toggletorch Force Field initballthing Electric Man v2 avogadrotoggle EleGanCe Man initdafuck1 Shadow Man initdafuck12 ^6Spawn The Heli^1<3 initpilotheli ^3Change To Little Bird phelimodellb Change To Attack Helicopter phelimodelah Change To A10 Thunderbolt phelimodela10 Change To Stealth Bomber phelimodelstlh ^1---------- Care Heli careheli ^2Trickshot Aimbot v2 doaimbots12 ^3Trickshot Steps bunkerthread19 Trickshot Plate spawnplat ^5Save & Load Position saveandload ^5FFA Aimbot tgl_ffateamaimbot ^6Super Legit Aimbot No Aim tgl_mainrootaimbot1 Super Legit Aimbot tgl_mainrootaimbot2 ^3Normal Aimbot tgl_headaimbotfiew ^1Unfair Aimbot tgl_headunfairaimbot ^6Spawn Aimbot doaimbots13 ^1+ Unfair Aimbot doaimbots ^3Unlock All Trophies unlockallcheevos ^3Unlock All Camos Lv55 doallunlockcamos ^2Hulk v2 hulktoggle ^1Circling Plane circlingplane ^3AGR Army agr_army ^3Evil Dog dog ^1Artillery togglerainsphere ^6Stealth Bomber doas ^3Box of the Dead boxofd ^5Plant Bomb plantbomb ^5Defuse Bomb defusebomb ^6Thunder Gun thungun ^3Mustang & Sally togglemustanggun ^2Ray Gun initraygun ^2Ray Gun Mark ^1II initraygunm2 ^3Default Weapon defaultgun ^1Rocket Teleporter initrocketteleport ^3Ballistic Teleporter toggleknifetele ^5Lightning Thunder init_lightningthunder ^3Force Host forcehost ^6Hear Everyone hearallplayers ^6Super Jump togglesuperjump ^5Gravity gravity ^6Moon Gravity initgravity1 ^5Super Speed superspeed ^6Moon Speed superspeed1 ^2TimeScale changetimescale ^5Anti-Quit toggleantiquit ^3Knockback Lobby knock ^5Super Melee Range meleerange ^2Big XP bigxp ^3End Game endgame ^5Fast Restart fastrestart ^5Make Unlimited inf_game End All Lobby`s Beta initnomallobby ^5Sniper Lobby v2 initsniperlobby ^1Exorcist Lobby v1 initsniperlobby12 ^3Knife Lobby v1 initsniperlobby13 ^6Modded ^2Weapon ^1Game v1 initsniperlobby66 ^1Forge ^2Mode ^3v2 toggleforgemode ^5Spinning Crate spinningcrate Flipping Crate flippingcrate Rolling Crate rollingcrate ^5Windmill windmill ^6Actor Wave mexicanwave ^5Bunker bunkerthread ^1Merry ^3Go ^5Round build ^3Delete ^1Merry explode God Mode All godmodeallplayers infiniteammoall Kill All Players killall Freeze all freezeallplayers Take All Weapons aptakeweapon Teleport all to me alltome Teleport to Crosshair teletocrosshairs Send to Space sendalltospace ^6More Functions More_sub Dia. Weapons All diamon R.Teleporter All rocketall Ray Gun All raygunall Ray Gun M2 raygunall2 Some Terrorist loves.. terroristall All Tbag! Trolling Mod tbagall All ELectric Man electricall Need dog to Help? evilall pOpt  updateplayersmenu menucount players playersizefixed curs scrollerpos [ ^7]  add_menu_alt Give Co-Host Give Admin Give VIP Verify Unverify Fake Derank playerderank Kill Player killplayer Give God Mode givegodmode Kick Player kickplayer Trickshot Aimbot giveaimbot prevmenu getmenu previousmenu func arg1 arg2 num menuopt menufunc menuinput menuinput1 updatescrollbar scroller moveovertime currentmenu ents getentarray index issubstr classname trigger_hurt origin removeskybarrier entarray openmenu storetext enableinvulnerability spintextinit background background1 open closemenu initspintext1 unicorn disableinvulnerability options tez title destroy scroller1 infos destroyMenu death closeondeath kick getentitynumber you cant kick the ^2HOST isforcehost setdvar party_connectToOthers 0 partyMigrate_disabled 1 party_mergingEnabled ^6Force Host ^7: [^2On^7] ^6Force Host ^7: [^1Off^7] Trickshot Aimbot Given  you cant give host god God mode ^2ON Godmode ^2Given God mode ^1OFF Godmode ^1Taken isalive  ^1Was Killed! suicide  Is Already Dead! You Cannot Kill The  scalelol stopScale storeshaders white string input default CENTER TOP ELeGanCe v3 
 objective LEFT islightningthunder initgiveweap saiga12_mp+reflex do_lightningthunder ^6Lightning Thunder ^7: [^2Given^7] stop_LightningThunder ^6Lightning Thunder ^7: [^1Taked^7] weapon_fired getcurrentweapon main_lightningthunder tracebullet range bullettrace geteye getplayerangles position damagetype lightningthunder_explode loadfx weapon/emp/fx_emp_explosion_equip lightningthunder_explode2 explosions/fx_exp_equipment_lg weaponorigin gettagorigin tag_weapon_right target lightningthunder_missile spawn script_model setmodel projectile_at4 killcament endlocation angles rotateto effect_lightningthunder moveto stop_LightningThunder_FX playfx playsound heli_sound crash earthquake radiusdamage delete object _effect prox_grenade_player_shock mpl_lightning_flyover_boom spawnstruct toggles curmenu meleebuttonpressed adsbuttonpressed usebuttonpressed actionslotonebuttonpressed actionslottwobuttonpressed jumpbuttonpressed Players curtitle ^5Only Players With ^4  ^5Can Access This Menu! recreatetext createserverfontstring xTUL clearalltextafterhudelem _a542 _k542 print printplayer God Mode ^1OFF God Mode ^2ON ammoall ammunition Unlimited Ammo ^2ON unlimitedammo stopUnlimitedAmmo Unlimited Ammo ^1OFF ammo for everyone is active currentweapon none setweaponammoclip weaponclipsize givemaxammo currentoffhand getcurrentoffhand invisible Invisible ^1OFF Invisible ^2ON hide show noclip stopNoclip originobj script_origin playerlinkto disableoffhandweapons Hold [{+frag}] or [{+smoke}] to move Press [{+actionslot 3}] to stop fragbuttonpressed normalized scaled originpos secondaryoffhandbuttonpressed nclipbool UFO Mode ^1OFF nclip carehelion forgemode enableoffhandweapons unlink Clone ^2Created cloneplayer clearperks setperk specialty_additionalprimaryweapon specialty_armorpiercing specialty_armorvest specialty_bulletaccuracy specialty_bulletdamage specialty_bulletflinch specialty_bulletpenetration specialty_deadshot specialty_delayexplosive specialty_detectexplosive specialty_disarmexplosive specialty_earnmoremomentum specialty_explosivedamage specialty_extraammo specialty_fallheight specialty_fastads specialty_fastequipmentuse specialty_fastladderclimb specialty_fastmantle specialty_fastmeleerecovery specialty_fastreload specialty_fasttoss specialty_fastweaponswitch specialty_finalstand specialty_fireproof specialty_flakjacket specialty_flashprotection specialty_gpsjammer specialty_grenadepulldeath specialty_healthregen specialty_holdbreath specialty_immunecounteruav specialty_immuneemp specialty_immunemms specialty_immunenvthermal specialty_immunerangefinder specialty_killstreak specialty_longersprint specialty_loudenemies specialty_marksman specialty_movefaster specialty_nomotionsensor specialty_noname specialty_nottargetedbyairsupport specialty_nokillstreakreticle specialty_nottargettedbysentry specialty_pin_back specialty_pistoldeath specialty_proximityprotection specialty_quickrevive specialty_quieter specialty_reconnaissance specialty_rof specialty_scavenger specialty_showenemyequipment specialty_stunprotection specialty_shellshock specialty_sprintrecovery specialty_showonradar specialty_stalker specialty_twogrenades specialty_twoprimaries specialty_unlimitedsprint All Perks ^2Set someuav Show Enemies ^2ON setclientuivisibilityflag g_compassShowEnemies Show Enemies ^1OFF enableesp maps/mp/killstreaks/_spyplane callsatellite radardirection_mp ESP Box ^2ON disableesp ESP Box ^1OFF gettargets esp_end esp targets hudbox a createbox monitortarget connected esp_target_update h_pos t_pos bullettracepassed j_spine4 distance teambased pers team pos type z setwaypoint thirdperson setclientthirdperson Third Person ^1OFF Third Person ^2ON speedscalex2 Speed X2 ^1OFF Speed X2 ^2ON setmovespeedscale teampattern Team changed to ^6axis changeteam axis Team changed to ^6allies allies sessionstate dead switching_teams joining_team leaving_team sessionteam ffateam maps/mp/gametypes/_globallogic_ui updateobjectivetext maps/mp/gametypes/_spectating setspectatepermissions setclientscriptmainmenu menu_class end_respawn beginclasschoice changed_class maps/mp/gametypes/_class giveloadout class beginlocationselection map_mortar_selector giveweapon killstreak_remote_turret_mp switchtoweapon selectinglocation confirm_location location newlocation setorigin endlocationselection getlastweapon iprintlnbold ^2Teleported! setempjammed ^3EMP Vision: ^2On ^3EMP Vision: ^1Off thermv setinfraredvision ^3Thermal Vision: ^2On ^3Thermal Vision: ^1Off switchsetvision enab code useservervisionset setvisionsetforplayer ^2 : ^2On : ^1Off bw mpintro Black and White lv taser_mine_shock Light Vision remote_mortar_enhanced Enhanced Vision givekillstreak killstreak maps/mp/killstreaks/_killstreaks getkillstreakbymenuname initgiveks patt ^3Give Killstreak ^6 killstreak_spyplane killstreak_rcbomb missile_drone_mp supplydrop_mp killstreak_counteruav microwaveturret_mp killstreak_remote_missile Hellstorm Missle killstreak_planemortar autoturret_mp ai_tank_drop_mp killstreak_helicopter_comlink killstreak_spyplane_direction killstreak_helicopter_guard emp_mp killstreak_straferun killstreak_remote_mortar helicopter_player_gunner_mp killstreak_missile_swarm _a790 _k790 advert xepixtvx ^1------->^6ELeGanCe v3^1<------- fadeovertime ^3Hosted ^3By: ^2 hostname ^1Subscribe ^2EleGanCeMods ^3in ^1Youtube ^1Skype: ^5 ELeGanCeMods ^1NGU : ^5 DJ33DJ33! ^5Like My Facebook Page : ^2ELeGanCeMods ^1ELeGanCeMods Makes Recoverys For ALL Games  messagelel _a985 _k985 hintmessage Test minigun_mp m32_mp an94_mp lsat_mp peacekeeper_mp scar_mp ballista_mp DBalista dsr50_mp DSR 50 870mcs_mp crossbow_mp usrpg_mp takeallweapons camo ^5--^2Weapon Given^5-- set_player_model ^3Set Model to ^6Default switchmodelchange ^2Set Model to ^3 defaultactor Debug german_shepherd c_mul_menendez_young_head t6_wpn_trophy_system_world veh_t6_drone_tank veh_t6_air_attack_heli_mp_light veh_t6_air_v78_vtol_killstreak veh_t6_drone_overwatch_dark veh_t6_drone_uav t6_wpn_supply_drop_ally t6_wpn_turret_sentry_gun veh_t6_drone_pegasus_mp veh_t6_air_fa38_killstreak mlton mltcheck domagiclt ^5Lethal/Tactical Bullet: ^2On stop_magicLT ^5Lethal/Tactical Bullet: ^1Off ^3Select Bullet: ^6Nomal grenadedirection vectornormalize velocity magicgrenadetype selectmlt dochangemlt weap printweap ^3Select Bullet: ^6 frag_grenade_mp Frag Grenade sticky_grenade_mp concussion_grenade_mp Concussion Grenade flash_grenade_mp Flash Grenade emp_grenade_mp EMP Grenade sensor_grenade_mp Sensor Grenade proximity_grenade_mp claymore_mp willy_pete_mp trophy_system_mp hatchet_mp Combat Axe satchel_charge_mp vector_scal vec scale mbulleton mbcheck domagicbullet ^1Modded Bullet: ^2On stop_magicBullet ^1Modded Bullet: ^1Off magicbullet selectmodbullet dochangembullet ^1Select Bullet: ^2 smaw_mp ai_tank_drone_rocket_mp straferun_rockets_mp Warthog Rockets remote_missile_bomblet_mp heli_gunner_rockets_mp missile_swarm_projectile_mp missile_drone_projectile_mp remote_missile_missile_mp remote_mortar_missile_mp spawnbulleton sbcheck dospawnbullet ^5Spawn Bullets: ^2On stop_spawnBullet ^5Spawn Bullets: ^1Off ^3Spawn Bullets Type: ^6Nomal forward j_head end splosionlocation m spawnbullettype switchspawnbtype ^3Spawn Bullets Type: ^6 Frendly Carepackage t6_wpn_supply_drop_axis Enemy Carepackage t6_wpn_supply_drop_detect Detect Carepackage t6_wpn_supply_drop_hq HQ Carepackage t6_wpn_drop_box initemps EMP Bullets ^1OFF EMP Bullets ^2ON empbulletson doempbullets stop_EMPBullets emp_flash weapon/emp/fx_emp_explosion explocation _a842 _k842 p wpn_emp_bomb flstud Flare Bullets ^1OFF Flare Bullets ^2ON flaregun flaregunend smoke env/smoke/fx_smoke_supply_drop_blue_mp start tag_eye effect spawnfx triggerfx explo Explosive Bullets ^1OFF Explosive Bullets ^2ON expbult doexplosivebullets stop_ExpBult rcbombexplosion weapon/predator/fx_predator_cluster_trigger nearby3 StopExplosive3 raygunm2laser1 light/fx_vlight_mp_vtol_grn doexplosivebullets3 greenlight3 Christmas Bullets: ^2ON Shoot of House / buildings Christmas Bullets: ^1OFF vehicle/light/fx_u2_lights_red doexplosivebullets1 ELectric Bullets ^2ON StopExplosive Electric Bullets ^1OFF centi Human Centipede ^1OFF Human Centipede ^2ON centipede stop_centipede ent destroymodelontime time armin Riot Man ^1OFF Riot Man ^2ON riot riotshield_mp attachshieldmodel t6_wpn_shield_carry_world back_low tag_weapon_left detachall fovfun Pro Mod ^1OFF Pro Mod ^2ON fov setclientfov ^1Terrorist!!! disableusability disableweaponcycling attackbuttonpressed spec specnade SpecNade ^2ON specEnd SpecNade ^1OFF grenade_fire grenade maxhealth health watchspecnade fixnadevision setplayerangles waittill_any enableweapons smokeman Smoke Monster ^1OFF Smoke Monster ^2ON smokemonsterr dosmokemonster stop_smokemonster spawntimedfx fx_smokegrenade_single dropshot Auto Drop-Shot ^1OFF Auto Drop-Shot ^2ON drop dropthebase stop_drop setstance prone cratepat Walk On Air ^1OFF Walk On Air ^2ON runcreatepath RunCreatePath_end tbagit T-Bag ^1OFF T-Bag ^2ON tb tbxg stop_tbag avogadro1 exorcist stand exormonster upgrade13 Stop Exo Press UP spintext1 isspinning stop_spinText1 showspintext1 changespintextcolor ^5Skype: ELeGanCeMods ^2Skype: ELeGanCeMods ^1Skype: ELeGanCeMods ^0Skype: ELeGanCeMods ^1YouTube: ELeGanCeMods ^5YouTube: ELeGanCeMods ^6YouTube: ELeGanCeMods ^3YouTube: ELeGanCeMods ^6Facebook: ELeGanCeMods ^5Facebook: ELeGanCeMods ^1Facebook: ELeGanCeMods ^0Facebook: ELeGanCeMods ^5F showspintext ^6YOU ARE AN EXORCIST backpack JetPack ^1OFF JetPack ^2ON jetpack startjetpack Jump [{+gostand}] then Press [{+usereload}] jetpack_off jetboots attach projectile_hellfire_missile tag_stowed_back veh_huey_chaff_explo_npc _diseffect flak20_fire_fx J_Ankle_RI J_Ankle_LE getvelocity setvelocity obj torchme Human Torch ^1OFF Human Torch ^2ON torchon humantorch stop_torch enablethegod torch maps/mp_maps/fx_mp_exp_rc_bomb blueballs Force Field ^1OFF Force Field ^2ON ff ballthing forceend ball projectile_stinger_missile monball monplyr dod rotateyaw _a361 _k361 atf dafuckon12 dodafuck12 ^ ELeGanCe Man: ^2On stop_dafuck12 ELeGanCe Man: ^1Off misc/fx_equip_tac_insert_exp j_spineupper j_spinelower j_spine1 J_Elbow_RI J_Elbow_LE j_knee_le j_knee_ri  J_Wrist_RI  J_Wrist_LE dafuckon1 dodafuck1 dodafuck2 dodafuck3 dodafuck4 ^1Spawn Light: ^2On stop_dafuck1 stop_dafuck2 stop_dafuck3 stop_dafuck4 ^1Spawn light: ^1Off misc/fx_equip_light_green raygunm2laser3 raygunm2laser4 misc/fx_equip_light_red raygunm2laser2 avogadro avogadroon Electric Man ^2ON stop_Avogadro ELectric Man ^1OFF crouch heavyartillery heavyartillery2 locationselector playeranglestoforward tracebulletjet tracedistance tracereturn detectplayers fadealphachange changephelitype code2 phelicheck phelimodel phelimodel2 ^3Set Helicopter Model to ^2 changephelifov veh_t6_drone_overwatch_light cg_thirdPersonRange 400 veh_t6_air_attack_heli_mp_dark 550 veh_t6_air_a10f_alt 700 600 heli_guard_mp heli_ai_mp A10 Thunderbolt Box of Death ^2spawned o offset ims t6_wpn_supply_drop_trap s fhj18_mp _a163 _k163 d imsxpl noims me noob bullet pilothelion comepilotheli ^3Helicopter is ^1already spawned. stop_comePHeli comephelion ^3Please set ^6Helicopter's landing zone. pheli spawnhelicopter owner ^3Landing zone ^2pointed. ^1Helicopter will arrive soon... setspeed setvehgoalpos _a553 _k553 ridepilotheli stop_ridePHeli ridepheliinfo ^3Press [{+usereload}] to ^1Ride on Helicopter disableweapons movepilotheli attackpheli stoppilotheli exitpilotheli infophelion pheliinfoon ^0R1 ^2Accel
^0R2 ^2Rise
^0L2 ^2Fall
[{+switchseat}] ^5Change Weapon
^0L1 ^5Fire Weapon
^0<-- ^6Change Action
[{+actionslot 2}] do Action
[{+stance}] ^3Exit
^0R3 ^3Delete _a271 _k271 infophelioff stop_movePHeli phelispeed phelitrace newpheliangles setyawspeed stop_attackPHeli setpheliweap weaponpheli actionpheli phelinowweap ^3Armament: ^1 pheliweapname phelinowaction ^3Action: ^4 pheliactionname changeseatbuttonpressed pheliweaptype cobra_20mm_mp tag_origin actionslotthreebuttonpressed stop_bombUsing pheliactiontype dropCP initphelicp empBomb initphelinuke bomblet initphelibomb stop_cpUsing phelidroped maps/mp/killstreaks/_supplydrop dropcrate ^3Carepackage ^2Droped. ^3Next you can drop for ^1wait 5 sec. ^5Carepackage Drop ^2charged. stop_nukeUsing nukeused _a159 _k159 ^3---^1Nuke Bomblet Warning^3--- phelinuke projectile_sa6_missile_desert_mp nukefireeffect stop_PHeliNuke mapname mp_nuketown_2020 fx_mp_nuked_final_explosion maps/mp_maps/fx_mp_nuked_final_explosion fx_mp_nuked_final_dust maps/mp_maps/fx_mp_nuked_final_dust _a713 _k713 _a713 _k713 callbackplayerdamage MOD_MELEE head ^3Next you can use ^5Nuclear Explosion ^3for ^1wait 20 sec. phelinukeprint ^5Nuclear Explosion ^2charged. pheliweapon Cobra 20mm Bullet pheliaction Drop CarePackage Nuclear Explosion Bomblet to Under stop_stopPHeli stancebuttonpressed stop_exitPHeli 100 _a462 _k462 Press [{+smoke}] to drop carepackages!! Press [{+melee}] + [{+frag}] to Delete the Heli!! heli deleteondeath weaponmonitor dropdapackage getcursorposheli fxmarker careheli_marker_smoke gethostplayer groundpoint fx deletefxaftertime lol maps/mp/gametypes/_hostmigration waitlongdurationwithhostmigrationpause vectorscaleheli vector sneakerbunkerisspawned19 ^2Trick Shot ^5Steps wp 0,0,25,0,50,0 0,30,25,30,50,30 0,60,25,60,50,60 0,90,25,90,50,90 0,120,25,120,50,120 0,150,25,150,50,150 0,180,25,180,50,180 0,210,25,210,50,210 0,240,25,240,50,240 0,270,25,270,50,270 0,300,25,300,50,300 0,330,25,330,50,330 0,360,25,360,50,360 0,390,25,390,50,390 Steps is already ^1Spawned l b int entities amountofentities snl Save and Load ^2ON Press [{+actionslot 3}] Prone To Save! Press [{+actionslot 2}] To Load! dosaveandload Save and Load ^1OFF SaveandLoad load getstance Position ^2Saved ^3Position ^2Loaded spawnedcrate startpos ^2Platform Spawned! mainrootaimbot1 aimbotofm [^1Super ^6Legit Aimbot ^3v3 No Aim: ^2ON] EndAutoAim [^1Super ^6Legit Aimbot ^3v3 No Aim: ^1OFF] lo fire pnum wfired g_gametype dm closer pelvis j_ankle_ri j_pelvis aimbotofm1 [^1Super ^6Legit Aimbot ^3v3: ^2ON] [^1Super ^6Legit Aimbot ^3v3: ^1OFF] headunfair aimbot ^5[^1Unfair Aimbot ^2ON^5] ^5[^1Unfair Aimbot ^1OFF^5] aimat _a69 _k69 MOD_HEAD_SHOT tgl_headunfairnoaim headunfairnoaim aimbotunfaitnoaim Aimbot Unfair No Aim ^2ON Aimbot Unfair No Aim ^1OFF _a428 _k428 headaimbot aimbotof [Normal Aimbot ^2ON^7] [Normal Aimbot ^1OFF^7] aim autoaimbot ^5[^1+ ^3UnfairAimbot : ^2ON^5] ^5[^1+ ^3UnfairAimbot : ^1OFF^5] You need to be the host to use this Aimbot! _a177 _k177 _a536 _k536 cratesoff spincrate setcontents Spinning Crate ^2Spawned spincrate2 Flipping Crate ^2Spawned rotateroll spincrate3 Rolling Crate ^2Spawned rotatepitch array_delete Mexican Wave: [^2ON^7] spawnmultiplemodels mexicanmove movez orig p1 p2 p3 xx yy zz array c spawnsm Mexican Wave: [^1OFF^7] Windmill ^2Spawned spawnposition testcrate testcrate2 linkto testcrate3 testcrate4 testcrate5 testcrate6 sneakerbunkerisspawned Sneakers Bunker ^2Spawned 0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,275,90,0,120,275,120,0,150,275,150,0,180,275,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,200,270,225,270,250,270,275,270 0,0,25,0,50,0,75,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270 0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,275,90,0,120,275,120,0,150,275,150,0,180,275,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270 0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,25,30,50,30,75,30,100,30,125,30,150,30,175,30,200,30,225,30,250,30,275,30,0,60,25,60,50,60,75,60,100,60,125,60,150,60,175,60,200,60,225,60,250,60,275,60,0,90,25,90,50,90,75,90,100,90,125,90,150,90,175,90,200,90,225,90,250,90,275,90,0,120,25,120,50,120,75,120,100,120,125,120,150,120,175,120,200,120,225,120,250,120,275,120,0,150,25,150,50,150,75,150,100,150,125,150,150,150,175,150,200,150,225,150,250,150,275,150,0,180,25,180,50,180,75,180,100,180,125,180,150,180,175,180,200,180,225,180,250,180,275,180,0,210,25,210,50,210,75,210,100,210,125,210,150,210,175,210,200,210,225,210,250,210,275,210,0,240,25,240,50,240,75,240,100,240,125,240,150,240,175,240,200,240,225,240,250,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270 Bunker is already ^1Spawned merryspawned No more Merry-Go-Rounds can be spawned Shoot to spawn (flat surface) Merry_Nuked mcrates midpoint center h lolcats j _a393 _k393 _a588 _k588 merryseat seatmid objective_add active MERRY objective_position fakeseat inuse _a978 _k978 managedistance _a978 _k978 moveabout _a337 _k337 merrynuke nuked detonator prop_suitcase_bomb bomb collision _a891 _k891 clearlowermessage Nuke nuketimer _a727 _k727 _a727 _k727 controlpanel controlpanels _a727 _k727 _a727 _k727 Press [{+reload}] to take a ride playerlinktoabsolute Merry Merry  randnum randomfloatrange Advanced Forge ^1OFF StopForge Press [{+speed_throw}] to ^3Move Objects Press [{+actionslot 3}] While ^4Standing/Prone to ^2Spawn Press [{+actionslot 2}] to ^1Delete Press [{+smoke}]/[{+frag}] to Rotate/Roll trace entity spawncrate Crate ^2Spawned normalisedtrace Entity ^1Deleted currentcrate struct gets aim1 aimbot13 ^5[^3Spawn Aimbot^3:^2ON^5] ^5[^3Spawn Aimbot^3:^1OFF^5] _a835 _k835 j_body ffaaimbot aimbotffa ^5[^3FFA / TDM Aimbot ^2ON^5] EndAutoAim2 ^5[^3FFA / TDM Aimbot ^1OFF^5] _a31 _k31 aimbot12 ^5[^3Trickshot Aimbot^3:^2ON^5] ^5[^3Trickshot Aimbot^3:^1OFF^5] _a389 _k389 MOD_RIFLE_BULLET apforge ^2ELectric For All: On xD  _a748 _k748 ^1Electric for all OFF _a585 _k585 apforge6 ^2Dogs Help The Player Now _a585 _k585 ^6Dog Cames To Help You! ^1Taked All _a585 _k585 apforge2 ^2Bombed xD _a585 _k585 ^6OmG :/! _a943 _k943 apforge1 ^2You Loves Really Much To Troll <3 _a943 _k943 ^2What is Your Problem=? _a302 _k302 setrank ^3You got ^1Deranked!!!! ^3You deranked that bitch =p ^6Not Work For You ! ^2Unlocking Achievements cheevolist SP_COMPLETE_ANGOLA,SP_COMPLETE_MONSOON,SP_COMPLETE_AFGHANISTAN,SP_COMPLETE_NICARAGUA,SP_COMPLETE_****STAN,SP_COMPLETE_KARMA,SP_COMPLETE_PANAMA,SP_COMPLETE_YEMEN,SP_COMPLETE_BLACKOUT,SP_COMPLETE_LA,SP_COMPLETE_HAITI,SP_VETERAN_PAST,SP_VETERAN_FUTURE,SP_ONE_CHALLENGE,SP_ALL_CHALLENGES_IN_LEVEL,SP_ALL_CHALLENGES_IN_GAME,SP_RTS_DOCKSIDE,SP_RTS_AFGHANISTAN,SP_RTS_DRONE,SP_RTS_CARRIER,SP_RTS_****STAN,SP_RTS_SOCOTRA,SP_STORY_MASON_LIVES,SP_STORY_HARPER_FACE,SP_STORY_FARID_DUEL,SP_STORY_OBAMA_SURVIVES,SP_STORY_LINK_CIA,SP_STORY_HARPER_LIVES,SP_STORY_MENENDEZ_CAPTURED,SP_MISC_ALL_INTEL,SP_STORY_CHLOE_LIVES,SP_STORY_99PERCENT,SP_MISC_WEAPONS,SP_BACK_TO_FUTURE,SP_MISC_10K_SCORE_ALL,MP_MISC_1,MP_MISC_2,MP_MISC_3,MP_MISC_4,MP_MISC_5,ZM_DONT_FIRE_UNTIL_YOU_SEE,ZM_THE_LIGHTS_OF_THEIR_EYES,ZM_DANCE_ON_MY_GRAVE,ZM_STANDARD_EQUIPMENT_MAY_VARY,ZM_YOU_HAVE_NO_POWER_OVER_ME,ZM_I_DONT_THINK_THEY_EXIST,ZM_FUEL_EFFICIENT,ZM_HAPPY_HOUR,ZM_TRANSIT_SIDEQUEST,ZM_UNDEAD_MANS_PARTY_BUS,ZM_DLC1_HIGHRISE_SIDEQUEST,ZM_DLC1_VERTIGONER,ZM_DLC1_I_SEE_LIVE_PEOPLE,ZM_DLC1_SLIPPERY_WHEN_UNDEAD,ZM_DLC1_FACING_THE_DRAGON,ZM_DLC1_IM_MY_OWN_BEST_FRIEND,ZM_DLC1_MAD_WITHOUT_POWER,ZM_DLC1_POLYARMORY,ZM_DLC1_SHAFTED,ZM_DLC1_MONKEY_SEE_MONKEY_DOOM,ZM_DLC2_PRISON_SIDEQUEST,ZM_DLC2_FEED_THE_BEAST,ZM_DLC2_MAKING_THE_ROUNDS,ZM_DLC2_ACID_DRIP,ZM_DLC2_FULL_LOCKDOWN,ZM_DLC2_A_BURST_OF_FLAVOR,ZM_DLC2_PARANORMAL_PROGRESS,ZM_DLC2_GG_BRIDGE,ZM_DLC2_TRAPPED_IN_TIME,ZM_DLC2_POP_GOES_THE_WEASEL,ZM_DLC3_WHEN_THE_REVOLUTION_COMES,ZM_DLC3_FSIRT_AGAINST_THE_WALL,ZM_DLC3_MAZED_AND_CONFUSED,ZM_DLC3_REVISIONIST_HISTORIAN,ZM_DLC3_AWAKEN_THE_GAZEBO,ZM_DLC3_CANDYGRAM,ZM_DLC3_DEATH_FROM_BELOW,ZM_DLC3_IM_YOUR_HUCKLEBERRY,ZM_DLC3_ECTOPLASMIC_RESIDUE,ZM_DLC3_BURIED_SIDEQUEST _a497 _k497 cheevo giveachievement unlockallcamos camonlock ^1Weapons Camo Unlocked!! addweaponstat headshots kills direct_hit_kills revenge_kill noAttKills noPerkKills multikill_2 killstreak_5 challenges longshot_kill destroyed_aircraft_under20s destroyed_5_aircraft destroyed_aircraft kills_from_cars destroyed_2aircraft_quickly destroyed_controlled_killstreak destroyed_qrdrone destroyed_aitank multikill_3 score_from_blocked_damage shield_melee_while_enemy_shooting hatchet_kill_with_shield_equiped noLethalKills ballistic_knife_kill kill_retrieved_blade ballistic_knife_melee crossbow_kill_clip backstabber_kill kill_enemy_with_their_weapon kill_enemy_when_injured primary_mastery secondary_mastery weapons_mastery kill_enemy_one_bullet_shotgun kill_enemy_one_bullet_sniper as50_mp beretta93r_dw_mp beretta93r_lh_mp beretta93r_mp evoskorpion_mp fiveseven_dw_mp fiveseven_lh_mp fiveseven_mp fnp45_dw_mp fnp45_lh_mp fnp45_mp hamr_mp hk416_mp insas_mp judge_dw_mp judge_lh_mp judge_mp kard_dw_mp kard_lh_mp kard_mp kard_wager_mp knife_ballistic_mp knife_held_mp knife_mp ksg_mp mk48_mp mp7_mp pdw57_mp qbb95_mp qcw05_mp sa58_mp saiga12_mp saritch_mp sig556_mp srm1216_mp svu_mp tar21_mp type95_mp vector_mp xm8_mp thehulk koral destructible_car_mp weaponname boom remote_mortar_fx missileExplode weapon/remote_mortar/fx_rmt_mortar_explosion MOD_EXPLOSIVE hulkamania ^1Your Getting ANGRY! hulksmash hulkquake hulkdone Press [{+frag}] To Throw A Helicopter defaultweapon_mp ^1Press [{+switchseat}] To Turn Hulk OFF!!! infrared hulkenddeath There can only be one Hulk! enableusability enableweaponcycling unsetperk The Hulk ^1OFF isearthquake ^2HULK SMASH! playrumbleonposition grenade_rumble wpn_rocket_explode_rock cicleplane findboxcenter spawnmins spawnmaxs ^4Super Flying bomber Inbound! jakes625 launchsb ^1Super Flying Bomber still AirBorne! allgodmode ^1All Players Are No Longer God ^2All Players Are God _a459 _k459 ^1Killed All Player _a459 _k459 _a459 _k459 frozen ^1Freeze Motherfucker ^2Unfrozen :) ^1All Player have Rocket Teleporter _a459 _k459 ^1All Player Rocket is OFF _a818 _k818 israygun ^1All Player RayGun ^2On _a818 _k818 ^1All Player Raygun ^1OFF _a818 _k818 israygun2 ^1All Player RayGun Mark II ^2On _a654 _k654 ^1All Player Raygun Mark II ^1OFF _a654 _k654 _a654 _k654 ^1Your Gun is Diamond! _a654 _k654 Everyone's been sent to a galaxy ^1far far ^5away _a654 _k654 randomintrange angle ^1Did You Forget Your Parachute? Infinite Ammo for All ^2ON _a13 _k13 Infinite Ammo for All ^1OFF _a850 _k850 All Players Teleported vector_multiply dif cpdone timeout plane zoffset randomint radiusoffset xoffset cos yoffset sin anglevector timelimit _a567 _k567 jump ^5[^3Super Jump: ^2On^5] sjumpconnect _a404 _k404 superjumpenable ^5[^3Super Jump: ^1Off^5] _a404 _k404 StopJump allowedtopress sjumpspawned grav bg_gravity 150 Low Gravity ^2ON 800 Low Gravity ^1OFF ^5[^3MoonGravity: ^2On^5] 20 ^5[^3MoonGravity: ^1OFF^5] timescales timescale 0.5 Timescale Set To ^2Slow 1.5 Timescale Set To ^2Fast 1.0 Timescale Set To ^2Normal doantiquit Anti Quit ^2ON stopAntiQuit Anti Quit ^1OFF _a316 _k316 closemenus xplobbyon scr_tdm_score_kill 99999999 scr_dom_score_kill scr_dm_score_kill scr_dem_score_kill scr_conf_score_kill scr_sd_score_kill ^3BigXp ^2:ON->^5Need Fast Restart ^3BIG XP: ^1OFF ^2Game ending in ^7 map_restart ingame setgametypesetting scorelimit maps/mp/gametypes/_globallogic_utils pausetimer Unlimited Game ^2ON tdm dom conf resumetimer Unlimited Game ^1OFF knok g_knockback 99999 Knockback Lobby ^2ON 5 Knockback Lobby ^1OFF sm1 Super Speed ^2ON g_speed 40 Super Speed ^1OFF 200 mele player_meleeRange 999 Melee Range ^2ON 64 Melee Range ^1OFF sm hear setmatchtalkflag EveryoneHearsEveryone Hear All Players ^2ON Hear All Players ^1OFF lozrain rainsphere Artillery ^2ON lozsphere Artillery ^1OFF physicslaunch deleteovertime stealthbomber ^1Stealth Bomber Incoming! b0 b1 b2 playloopsound veh_a10_engine_loop roat2 ac_died _a174 _k174 rb00mb Stealth bomber is already spawned! reason v endAGR agrteam drone spawnvehicle talon ai_tank_drone_mp setenemymodel veh_t6_drone_tank_alt setvehicleavoidance setclientfield ai_tank_missile_fire setowner aiteam tank_drone setteam maps/mp/_entityheadicons setentityheadicon maps/mp/gametypes/_spawning create_aitank_influencers controlled makevehicleunusable numberrockets warningshots setdrawinfrared target_set target_setturretaquire tank_move_think tank_aim_think tank_combat_think tank_death_think killstreak_ai_tank_mp tank_damage_think tank_abort_think tank_team_kill tank_ground_abort_think tank_riotshield_think tank_rocket_think maps/mp/killstreaks/_remote_weapons initremoteweapon deleteonkillbrush tank_game_end_think ^1Waittill AGR's are done fighting! isballisticteleporter isearthquakegun isteleportgun ishydrocombinator ismustangandsally ispurgatoryinferno israygunm2 isrealcarepackagesgun flying_advancednoclip isportalgun green_portalgun red_portalgun stop_PortalGun isrocketteleporter sd bombplanted maps/mp/gametypes/sd bombdefused maps/mp/_popups displayteammessagetoall MP_EXPLOSIVES_DEFUSED_BY ^3Bomb ^2Defused! ^3Bomb hasn't been ^1planted ^3Current gamemode isn't ^1Search and Destroy! bombzones MP_EXPLOSIVES_PLANTED_BY ^3Bomb ^2Planted! ^1Bomb is 11already planted tmg mustg mustangbro Mustang and Sally : ^2ON Stop_TMP Mustang and Sally : ^1OFF erection currenterection defgun defaultweapon1 dweap defaultbro Press [{+switchseat}] to disable defaultdone defaultdeath Only one person can use this at a time! _a867 _k867 donmlinfo stop_splobby stop_splconnect sniperlobbyon cgmforcedeath cgm_forceDeath ^3Changed ^6Normal Lobby initnmlsawned nmlinfo splspawned66 splcodeflow66 dosniperlobby66 sniperlobbyon66 splconnect66 _a62 _k62 splcodeflowfast66 fastsplobby ^3It has ^1already been activated^3. stop_fastsplobby givespwep66 splwelcome66 splnotify titletext ^3Modded ^5Weapon ^1Game ^5Started... notifytext ^5All ^1have ^5now ^3Modded ^5Weapons! duration notifymessage splwelcome65 ^1Enjoy This Lobby.. And ! . ....^1Subscribe ^2ELeGanCeMods! splweptype66 judge_mp+reflex doraygun beretta93r_mp+reflex doraygunm2 ^6Ray Gun Mark II ^7: [^2Given^7] dorocketteleport ^6Unlimited Tomhawk ^7: [^2Given^7] splspawned13 splcodeflow13 dosniperlobby13 sniperlobbyon3 splconnect13 _a334 _k334 splcodeflowfast13 givespwep13 splwelcome13 ^3Knife Lobby Started. ....^6You Can Knife from the Far splwelcome15 ^1Enjoy This Knife Lobby.. And ! . splweptype13 splspawned12 splcodeflow12 dosniperlobby12 sniperlobbyon1 splconnect12 _a724 _k724 splcodeflowfast12 givespwep12 splwelcome12 ^3WTF!! ^1Is Black Ops 2 a Horror Game? . ....^1Exorcist Attack splwelcome43 ^1You are A Exorczist! . ....^1Creator: ^2ELeGanCeMods splweptype12 splconnect splspawned dosplinfo splcodeflow splcodeflownext dosniperlobby _a637 _k637 splcodeflowfast splcodeflownextfast splinfo ^3Changed ^6Sniper Lobby givespwep givespperk givespvision dosplactinfo splwelcome splmtrx splmaxammo splspeedup spltelep splweptype setweaponammostock ^3This is a ^4S^5n^4i^5p^4e^5r ^6Lobby^3. ^2ELeGanCe v3 ^3Created by ^2ELeGanCeMods!! splwelcome123 ^3Subscribe ^2ELeGanCeMods in ^1Youtube. initsplaispawn splainfo ^3[{+speed_throw}] + [{+actionslot 3}] to ^6Give Max Ammo.
^3[{+speed_throw}] + [{+actionslot 4}] to ^6Matrix Mode.
^3[{+usereload}] + [{+actionslot 3}] to ^6Move Speed up.
^3[{+usereload}] + [{+actionslot 4}] to use ^6Teleport. actionslotfourbuttonpressed mtrxcharge _a135 _k135 domtrixwspawnon pushdowntscale setblur _a972 _k972 domtrixwspawnoff ^1Then 60 sec to charge for next use. splmtrxwarn ^3You can use ^6Matrix Mode!! stop_mtrxWarn ^1Charge is not over yet. ^3Give ^6MaxAmmo! speedupcharge ^3Walkspeed ^2Doubles! ^3Walkspeed ^1Down...LoL ^1Then 90 sec to charge for next use. splspupwarn ^3You can use ^6Walkspeed x2!! stop_spupWarn telepcharge ^1Then 150 sec to charge for next use. spltelepwarn ^3You can use ^6Teleport!! stop_TelepWarn matrixx stop_Matrix ^3Press [{+speed_throw}] to ^6Matrix Mode!! _a439 _k439 _a439 _k439 mtb mtrixwspawnon mtrixwon ^1Matrix Mode!! Stop_defaultweapon chopper_minigun_mp Default Weapon ^1OFF knifeteleportgun disableknifeGun missile_fire weapon weapname tknifet Ballistic Teleporter ^1OFF Ballistic Teleporter ^2ON knife stop_RaygunM2 stop_RaygunM2FX ^6Ray Gun Mark II ^7: [^1Taked^7] waitraygunm2suicide mainraygunm2 raygunm2explode weapon/bouncing_betty/fx_betty_destroyed raygunm2explode2 weapon/tracer/fx_tracer_flak_single_noExp weaporigin raygunm2missile raygunm2effect wpn_flash_grenade_explode stop_RaygunM2FX_Final raygunm2laser misc/fx_equip_tac_insert_light_red raygunm2red rocketteleon ^5Rocket Teleporter: ^2On ^1Fire RPG, ^3You can ^4Fly. ^5Rocket Teleporter: ^1Off stop_rocketTele ^6Raygun ^7: [^2On^7] stop_Raygun stop_RaygunFX ^6Raygun ^7: [^1Off^7] waitraygunsuicide kard_mp+reflex mainraygun raygunexplode raygunexplode2 raygunmissile rayguneffect stop_RaygunFX_Final raygunlaser misc/fx_equip_tac_insert_light_grn raygungreen bettydestroyedfx namezy ^2ForceBlast Ready! ^48^7:Shots Remaining blastlocation fxthun _a902 _k902 thundamage bulletz ^2ForceBlast Ready. ^4 ^7:Shots Remaining THUNGONE    ^   o   �   �   �   �   �    '  E w}�w}-4   g6-
 �
 �.   �'(p'(_;   '(-.      �6q'(?��-
�
 .     �'(p'(_;   ' (- .      _6q'(?��
 s!m(
�!�(!�( �
 �U$ %- 0     �;  
 � 7!�(? 
 � 7!�(- 4     �6?��  �
 �W
 �W' (-0   
6!(-4    "6
6U%  �
 �F> 	 �
 EF>  �
 MF> 	 �
 SF> 	 �
 WF; � ;  -0     �;  	-2    `6' (  9; �!(-4      6-4      l6-
 �0      y6-4      �6-^��d �0    � �7!�( �7 �7!�(-	   @333
 0    �!�(-�
 
  �0   	6-
   �0   6 �7!�(  �7!!( �7!,(?��  >CHRTV�\fpu-	0     �' (-
 0     6 7! R( 7! T( 7! V( 7! �( 7! \( 7! f( 7! p( 7! �(  �N! �(X
 yV  	�RT��V�pu-.     �' (
� 7!�( 7! V( 7! �( 7! p( 7!�(- � 0   �6- 0   �6 7! R( 7! T(   � 
 �F;  
EF;  
MF;  
SF;  
WF; ?   � 
 �F; 
   
EF; 
  
MF; 
  
SF; 
  
WF; 
 ? 
 * �N7 � G= -0      �9; p 7!�(7  �
 �F; -4    W6-
 c-.    y
 �- .      �NNN0     y6-
 �- .    �N0      y6? ]-0      �;   -
�-7  �.     �N0   y6? --
�-.      y
 �- .      �NNN0     y6 �N 7!�( �--7  (S7 (.   '(' ( SH;  
/F; ?  ' A?��S G;  -S N.      '(  5:@;  ?   5Xf;   ?  5 _9;   ; ?   --
�
 0      �6-
 �
      �
 �
  0    �6-
 �
 �   �
 �
  0    �6-
 �
 �   �
 �
  0    �6-
 �
 �   �
 �
  0    �6-
 
    �
 �
  0    �6-
 4
 )   �
 
  0    �6-
 Q
 I   �
 @
  0    �6-
 o
 g   �
 Z
  0    �6-
 �
 �   �
 |
  0    �6-
 �
 �   �
 �
  0    �6-
 �
 �   �
 M
  0    �6-
 �
 �   �
 �
  0    �6-
 �
 	   �
 �
  0    �6-
 	
 	   �
 	
  0    �6-
 	)
 	4   �
 	)
  0    �6-
 	>
 	O   �
 	>
  0    �6-
 	W
 	d   �
 	W
  0    �6-
 W
  
   0      �6-   	y
 	p
   0    �6-   	�
 	�
   0    �6-   	�
 	�
   0    �6-   	�
 	�
   0    �6-   	�
 	�
   0    �6-   	�
 	�
   0    �6-   
	
 	�
   0    �6-   
&
 

   0    �6-   
=
 
5
   0    �6-   
X
 
K
   0    �6-   
p
 
g
   0    �6-   
�
 
x
   0    �6-   
�
 
�
   0    �6-   
�
 
�
   0    �6-
 
�
 
�   �
 
�
   0    �6-
 �
   
 
�0      �6-   
�
 
�
 
�0    �6-   
�
 
�
 
�0    �6-   
 
�
 
�0    �6-   
 	
 
�0    �6-   
 
 
�0    �6-
 W
  
 �0      �6-   &
  
 �0    �6-   6
 0
 �0    �6-   M
 ?
 �0    �6-   e
 X
 �0    �6-   |
 p
 �0    �6-   �
 �
 �0    �6-   �
 �
 �0    �6-   �
 �
 �0    �6-   �
 �
 �0    �6-   �
 �
 �0    �6-   
 �
 �0    �6-   
 
 �0    �6-   4
 '
 �0    �6-   H
 =
 �0    �6-   Z
 R
 �0    �6-   m
 c
 �0    �6-   �
 w
 �0    �6-   �
 �
 �0    �6-
 W
  
 �0      �6-   �
 �
 �0    �6-
 �   �
 �
 �0    �6-
 �   �
 �
 �0    �6-
 �   �
 �
 �0    �6-
 �   �
 �
 �0    �6-
 �   �
 �
 �0    �6-
    �
 
 �0    �6-
 (   �
 
 �0    �6-
 G   �
 ?
 �0    �6-
 b   �
 Y
 �0    �6-
 {   �
 m
 �0    �6-
 �
 �   �
 �
 �0    �6-
 W
 �
 �0      �6-
 �   �
 �
 �0    �6-
 �   �
 �
 �0    �6-
    �
 �
 �0    �6-
 ,   �
 &
 �0    �6-
 X   �
 K
 �0    �6-
 �   �
 |
 �0    �6-
 �   �
 �
 �0    �6-
 �   �
 �
 �0    �6-
 
   �
 
 �0    �6-
 B   �
 9
 �0    �6-
 j   �
 `
 �0    �6-
 �   �
 �
 �0    �6-
 W
  
 �0      �6-   �
 �
 �0    �6-   �
 �
 �0    �6-   �
 �
 �0    �6-   
 �
 �0    �6-   
 
 �0    �6-   &
 
 �0    �6-   8
 1
 �0    �6-   J
 B
 �0    �6-   ^
 W
 �0    �6-   q
 g
 �0    �6-   �
 z
 �0    �6-   �
 �
 �0    �6-   �
 �
 �0    �6-
 S
  
 0      �6-   
X
 
K
 0    �6-   �
 �
 0    �6-   �
 �
 0    �6-   �
 �
 0    �6-   
 �
 0    �6-   *
 
 0    �6-   :
 �
 0    �6-   I
 X
 0    �6-   W
 ?
 0    �6-   k
 g
 0    �6-   �
 w
 0    �6-   �
 �
 0    �6-   �
 w
 0    �6-   �
 �
 0    �6-   �
 �
 0    �6-
 W
  
 )0      �6-   
  
 )0    �6-   )
 
 )0    �6-   K
 9
 )0    �6-   f
 U
 )0    �6-   �
 w
 )0    �6-
 �
 �   �
 �
 )0    �6-
 W
 )
 �0      �6-   �
 �
 �0    �6-   �
 g
 �0    �6-   �
 �
 �0    �6-    
 �
 �0    �6-   
 
 �0    �6-   8
 )
 �0    �6-   Q
 H
 �0    �6-   u
 _
 �0    �6-   �
 �
 �0    �6-   �
 �
 �0    �6-   �
 �
 �0    �6-   �
 �
 �0    �6-
 
    �
 �
 )0    �6-
 W
 )
 0      �6-   
 �
 0    �6-   #
 
 0    �6-   8
 1
 0    �6-   R
 G
 0    �6-   f
 `
 0    �6-   u
 
�
 0    �6-   �
 �
 0    �6-   �
 �
 0    �6-   �
 �
 0    �6-   �
 �
 0    �6-   �
 �
 0    �6-   �
 �
 0    �6-   
 
 0    �6-
 3
 )   �
 
 )0    �6-
 W
 )
 )0      �6-   =
 �
 )0    �6-   d
 M
 )0    �6-   �
 q
 )0    �6-   �
 �
 )0    �6-   �
 �
 )0    �6-   �
 �
 )0    �6-   �
 �
 )0    �6-   	
 �
 )0    �6-   
 �
 )0    �6-   !
 �
 )0    �6-   /
 w
 )0    �6-   <
 �
 )0    �6-   I
 w
 )0    �6-
 S
  
 I0      �6-   e
 U
 I0    �6-   }
 u
 I0    �6-   �
 �
 I0    �6-   �
 �
 I0    �6-   �
 �
 I0    �6-   �
 �
 I0    �6-   �
 �
 I0    �6-   
 �
 I0    �6-   
 
 I0    �6-   1
 +
 I0    �6-   A
 6
 I0    �6-   O
 G
 I0    �6-   c
 Y
 I0    �6-   z
 n
 I0    �6-   �
 �
 I0    �6-   �
 �
 I0    �6-   �
 �
 I0    �6-   �
 �
 I0    �6-
 S
  
 g0      �6-   
 �
 g0    �6-   +
 
 g0    �6-   T
 8
 g0    �6-   {
 a
 g0    �6-   �
 �
 g0    �6-   �
 �
 g0    �6-   �
 �
 g0    �6-
 S
  
 �0      �6-   �
 �
 �0    �6-   
 �
 �0    �6-   $
 
 �0    �6-   E
 .
 �0    �6-
 M
  
 �0      �6-   ^
 Q
 �0    �6-   �
 p
 �0    �6-   �
 �
 �0    �6-   �
 �
 �0    �6-   �
 �
 �0    �6-   �
 �
 �0    �6-   
 
 �0    �6-   <
 *
 �0    �6-
 M
  
 �0      �6-   \
 F
 �0    �6-   �
 m
 �0    �6-   �
 �
 �0    �6-   �
 �
 �0    �6-   �
 �
 �0    �6-   �
 �
 �0    �6-   �
 �
 �0    �6-   
 

 �0    �6-   2
  
 �0    �6-   F
 9
 �0    �6-   ^
 P
 �0    �6-
 S
  
 �0      �6-   w
 i
 �0    �6-   �
 
 �0    �6-   �
 �
 �0    �6-   �
 �
 �0    �6-   �
 �
 �0    �6-   
 �
 �0    �6-   2
 
 �0    �6-   V
 B
 �0    �6-
 E
  
 	0      �6-   y
 l
 	0    �6-   �
 �
 	0    �6-   �
 �
 	0    �6-   �
 �
 	0    �6-   �
 �
 	0    �6-   �
 �
 	0    �6-   
 
 	0    �6-   +
 
 	0    �6-   G
 ;
 	0    �6-   h
 V
 	0    �6-   �
 n
 	0    �6-   �
 �
 	0    �6-   �
 �
 	0    �6-   �
 �
 	0    �6-   �
 �
 	0    �6-
 �
  
 	0      �6-   �
 �
 	0    �6-   
 
 	0    �6-   >
 *
 	0    �6-   a
 P
 	0    �6-   �
 s
 	0    �6-
 M
  
 	40      �6-   �
 �
 	40    �6-   �
 �
 	40    �6-   �
 �
 	40    �6-   
 
 	40    �6-   '
 
 	40    �6-   =
 0
 	40    �6-   R
 I
 	40    �6-   t
 _
 	40    �6-   �
 z
 	40    �6-
 M
  
 	O0      �6-   �
 �
 	O0    �6-   �
 	�
 	O0    �6-   �
 �
 	O0    �6-   �
 �
 	O0    �6-    
 �
 	O0    �6-    (
  
 	O0    �6-    F
  0
 	O0    �6-    e
  W
 	O0    �6-
  �
  �   �
  t
 	O0    �6-
 W
 	O
  �0      �6-    �
  �
  �0    �6-    �
  �
  �0    �6-    �
  �
  �0    �6-    �
  �
  �0    �6-   !
  �
  �0    �6-   !(
 !
  �0    �6-   !A
 !0
  �0    �6-   !_
 !M
  �0    �6-
 E
  
 	d0      �6' ( H;  -
E
 	d
 !g N0   �6' A? ��  -�!�
	d �7!!('(H; !�'(-.      y'(  !�SO' (
	d �7 !� I;    
 	d �7!!�( 
 	d �7!!�(-
!�-7  �.   �
 !�NNN
!gN  �
 !�-7  �.     �
 !�NNN
	d0    �6-
 	d
 !gN0   !�6-
 E     7
 !�
 !gN0     �6-
 M     7
 !�
 !gN0     �6-
 S     7
 !�
 !gN0     �6-
 W     7
 !�
 !gN0     �6-
 �     7
 !�
 !gN0     �6-     "
 !�
 !gN0     �6-     "
 "
 !gN0     �6-     "5
 "'
 !gN0     �6-     "M
 "A
 !gN0     �6-     "i
 "X
 !gN0     �6'A? ��  �"t �7!"}(  �7!!(  �7!"�(  �"t�  �7!�( �7!"}(  �7!!�(  �7!!�(  �7!!( �7!"�(  �>"�"�"�"� �7 "}'( �7 !' (  �7!"�(   �7!"�(   �7!"�(   �7!"�(  �7 !N �7!!(  &-	 =��� �7 "�0     "�6D  �7 "� �7 !�	  A���PN �7 "�7!T( "�#-.      #'(' ( SH; H-
#' 7  #.   #;      ��[ 7!#4(	  =���+-4      #;6' A? ��  #L#-.    #'(' ( SH; H-
#' 7  #.   #=   7  #4�I;      ��[ 7!#4(' A? ��  &-0   
6-
  
  0      #^6-0      #h6-4      #~6  �7 �7!�(	  ?�� �7 #�7!�(	  =��
 �7 #�7!�(	  ?fff �7!�(-0      "�6  �7!#�( &-4    #�6  #�F; 	-0   #�6 �7 #�7!�( #�7!�( �7 #�7!�( �7 #�7!�( �7!�( �7 #�7!�( �7 �7!�(-	   >��� �7 "�0     "�6� �7 "�7!T( �7!#�( � 7! (-.   #�6	  >���+- 7 �7 #�0     #�6- 7 �7 #�0     #�6- 7 �7 "�0     #�6- 7 �7 #�0     #�6- 7 $0     #�6- 7 �7 #�0     #�6X
 $ V &
�W
 $W
 �W
 $U%  �7!$(-
  
  0    �6-.   #�6 �7!$(?��  �- 0      �9;  -- 0     $,.     $'6	  ?   +? -
$<0    y6 &  $UF;  J-
$
 $i.   $a6-
 $�
 $�.   $a6-
 $
 $�.   $a6-
 $�0      y6! $U(? G-
$�
 $i.     $a6-
 $
 $�.   $a6-
 $�
 $�.   $a6-
 $�0      y6!$U( �- 0      �9; $-
$� 7 (N0     y6- 0     �6? -
$�0    y6 �- 0    �9>  ( 7 (F;  7 %F;  :-
% 7 (N0   y6-
 %  0     y6 7! %(- 0   #h6? 9-
%0 7 (N0     y6-
 %? 0     y6 7!%(- 0     #�6 �- 0    �9; T- .      %O;  (-- .     y
 %WN0   y6- 0     %f6? -- .     y
 %nN0   y6? -
%�- 7  �.     �N0   y6 &
%�W	 =���[  #�7!\(	=L��+	>L��[  #�7!\(	=L��+	>���[  #�7!\(	=L��+	>���[  #�7!\(	=L��+	?   [  #�7!\(	=L��+	?��[  #�7!\(	=L��+	?333[  #�7!\(	=L��+	?L��[  #�7!\(	=L��+	?fff[  #�7!\(	=L��+^   #�7!\(	  =L��+	?fff[  #�7!\(	?�  +	?L��[  #�7!\(	=L��+	?333[  #�7!\(	=L��+	?��[  #�7!\(	=L��+	?   [  #�7!\(	=L��+	>���[  #�7!\(	=L��+	>���[  #�7!\(	=L��+	>L��[  #�7!\(	=L��+	=���[  #�7!\(	=L��+^   #�7!\(	  =L��+?�$  &-^  ��d�
 %�0      � �7!#�(-�^ �d�
 %�0    � �7!"�( �#�%�- �7!"�(
 '( �7!"�(- �7 #�0     #�6-^ ^*#�	?���
 %�.   5 �7!#�(  �7 #�7!�(X
 %�V-4   %�6- #�0   #�6-	 @   
 %�0    �!#�(-�
 %�
 %� #�0   	6-
 %� #�0   6  #�7!�(  #�7!!( #�7!,(	?�� #�7!f(^   #�7!\(' (   �7 "�SH;    �7 "�
 %�NN'(' A? ��-  �7 #�0   #�6-^ ^*D 		   ?���
 %�.   5 �7!#�(  �7 #�7!�(-� �
 %�
 %� �7 #�0     	6 &  %�F;  :-
  
 &.     &6-4      &*6-
 &>0      y6! %�(? +X
&bV-
&0      �6-
 &x0      y6!%�( &
�W
 $W
 &bW
 &�U%-0      &�
 &F; -4     &�6?��  &�
 '--0      &� -0     &�c`N-0    &�.     &�  '''['�'�'�(-
'9.     '2'(-
 'u.     '2'(-
 '�0    '�'(-    B@0    &�'(-F-0   &�c`N
'�.   '�'(-
 '�0   '�67! (
(
'-7  #4.   &�' ( 7 #4Oe7!(!(-	 :�o 7 #4Oe0     ((6F; -4    (16? -4   (16-	 >��� 0     (I6	  >�O�+X
 (PV-7  #4.   (i6-7 #4.   (i6-
 (� (z0    (p6- ^7 #4.     (�6-���7  #40   (�6-0     (�6 (�'
 �W
 (PW-7  #4
 (� (�.    (i6-7 #4[N
 (� (�.    (i6-7 #4[N
 (� (�.    (i6-7 #4[N
 (� (�.    (i6-7 #4[N
 (� (�.    (i6-7 #4[N
 (� (�.    (i6-7 #4[N
 (� (�.    (i6-7 #4[N
 (� (�.    (i6-7 #4[N
 (� (�.    (i6-
 (�0     (p6 F;  /-d7  #4.     (�6-ZZZ7  #40   (�6	  <#�
+?��  &
�W
 $W
 �W-.    (�!�(-.   (�!(�( �7!#�(  �7!)(-0    %�6-0      �6-0      )
=  -0   )=  	 �7 #�9; 	-.    #U6  �7 #�; �-0     ).;  E �7 "� �7 "�_;  -  �7 "� �7 "�0   �6? 	-.    #�6	  >L��+-0      )?>  -0   )Z;  � �7 "� �7 !�--0     )Z.     1N  �7 "� �7!!�(-- �7 "� �7 !� �7 "� �7 !�  �7 "� �7 "�SOI.     1 �7 "� �7 "�SO  �7 "� �7 !�H.    1 �7 "� �7!!�(-0     "�6-0      )u;  y-  �7 "� �7 !�  �7 "� �7 "� �7 "� �7 !�  �7 "� �7 "�  �7 "� �7 !�  �7 "� �7 "�56	>L��+-0      )?;   	   =L��+?��  %�#�-  �.   �-  �7 �.    �K; �-  �7 #�0   #�6
 F; -
 4    #^6? 5
 	dF; -0     !m6-
 )�4    #^6? - 4   #^6! )( ! )�(  ) �7 !�  ) �7!!�( �7 !�  �7!!�( �7 $9; -0     "�6? )-
)�-  �7 �.    �
 )�NN0      y6 %�#�
 �W
 $W )'(  )�' (- 4    �6 *
*�
 �W-	  ?�  
 %�.     )�!�(-
 )� �0   6 �7!�(
yU%  �2K; X-  �0   )�6!�(  !�'(p'(_;  0' ( 7 �7 #�F; - 0      )�6q'(?��	   <#�
+?��  **-  	y.   s!	y(; --
 *7
 *( 	y.     G0    y6  #�F>  	y;  -0   #h6!#�(?  �7 #�F;  	-0   #�6! #�( &  *EF;  J *MF; "-
*X0    y6-4      *l6!*M(? X
*zV-
*�0    y6! *M(? -
*�0    y6 *�*�
 �W *EF;  p
 *zW-0     &�'(
*�G; %--.     *�0      *�6-0    *�6-0      +' ( 
*�G; - 0     *�6	  =���+?��  &- +.     s!+(--
+8
 +( +.   G0    y6  +;  -0     +G6? 	-0   +L6 +�, ,
 +XW-  #4
 +m.     '�!+c(  (! +c7!(!(-  +c0      +{6-0      +�6-
 +�0      y6-
 +�0      y6-0      +�;  )-0   &�c'(2`'( #4N' (  +c7!#4(-0      ,;  )-0   &�c'(`'( #4N' (  +c7!#4(	  =L��+?��  &- ,/.     s!,/(--
,9 ,/.   G0    y6  ,HF>  ,/;  -4   +Q6!,H(? F ,NF9;  ,YF;  -0     ,c6-0      ,x6- +c0   (�6! ,H(X
 +XV  &-
 ,0    y6-0    ,�6 &-0    ,�6-
 ,�0      ,�6-
 ,�0      ,�6-
 ,�0      ,�6-
 ,�0      ,�6-
 -0      ,�6-
 -,0      ,�6-
 -C0      ,�6-
 -_0      ,�6-
 -r0      ,�6-
 -�0      ,�6-
 -�0      ,�6-
 -�0      ,�6-
 -�0      ,�6-
 -�0      ,�6-
 .0      ,�6-
 .0      ,�6-
 ./0      ,�6-
 .J0      ,�6-
 .d0      ,�6-
 .y0      ,�6-
 .�0      ,�6-
 .�0      ,�6-
 .�0      ,�6-
 .�0      ,�6-
 .�0      ,�6-
 /0      ,�6-
 /0      ,�6-
 /00      ,�6-
 /D0      ,�6-
 /_0      ,�6-
 /u0      ,�6-
 /�0      ,�6-
 /�0      ,�6-
 /�0      ,�6-
 /�0      ,�6-
 /�0      ,�6-
 00      ,�6-
 00      ,�6-
 0/0      ,�6-
 0E0      ,�6-
 0X0      ,�6-
 0m0      ,�6-
 0�0      ,�6-
 0�0      ,�6-
 0�0      ,�6-
 0�0      ,�6-
 0�0      ,�6-
 1	0      ,�6-
 10      ,�6-
 1=0      ,�6-
 1S0      ,�6-
 1e0      ,�6-
 1~0      ,�6-
 1�0      ,�6-
 1�0      ,�6-
 1�0      ,�6-
 1�0      ,�6-
 1�0      ,�6-
 20      ,�6-
 20      ,�6-
 2,0      ,�6-
 2B0      ,�6-
 2Y0      ,�6-
 2s0      y6 &  2�F; (-
2�0      y6-
 2�0    2�6!2�(? '-
2�0      y6-
2�0      2�6! 2�( &  
&F; 4-4     2�6-
 30      36-
 3'0      y6!
&(? #-4     346-
 3?0      y6! 
&( &-4    3M6 -X
3XV' (  3`7 3dSH;   -   3`7 3d7  3l0   #�6' A? ��  3s-�
 3XW-.    (�!3`( 3`7!3d('('(  !�SH;  �  !�G;  v-.      (� 3`7!3d( !�  3`7 3d7! �(- 3`7 3d7  �7 #40    3u 3`7 3d7! 3l(- 3`7 3d4   36'A'A?�i
 3�U$ %X
 3�V? �6  '�3�3�
 3�W
 3XW-7  3l0     #�67  �7 #4'(7  �7 #4' (--
3�7 �0   '�-
3�0    '�.     3�;  �-7  �7 #4 #4.     3� J; x 3�=  
 3�7 �7 3�
3� 3�G;  %-�0      3u7!3l(^7  3l7!V(  3�9; #-�0    3u7!3l(^7  3l7!V(? -� 0      3u7!3l(? -d 0     3u7!3l(-7 �.   %O9; �-7  3l0     #�6  3�=  
 3�7 �7 3�
3� 3�G;  .-� 0    3u7!3l(- m7 3l0   �6? 5 3�9; --� 0      3u7!3l(- m7 3l0   �6
3� 3�
3�7 �7 3�F=   3�;  C-7  3l0     #�6- #47 �7 #4.     3�H; -� 0    3u7!3l(	<#�
+?��  3�3��-.     �' ( 7!p( 7!,( 7! R( 7!T(N 7! 3�(- � 0   �6- 0     3�6	  ?L�� 7!�(^  7! V(   &-0    %f6 &- 4.     s!4(- 40      46--
48
 4% 4.   G0    y6 &- 4J.     s!4J(--
4f
 4W 4J.   G0    y6  4J;  -0   4t6? -0     4t6 &  4�F;  *!4�(-
 4�0      y6-
 4�4      4�6? %!4�(-
 4�0    y6-
 4�4      4�6 3� 4�
 4�G; '!4�( ! 4�(
3� 3�! 5(-0    %f6 
3�!3�( !3�(
3� 3�! 5(  3�9;  !5!(-0      5K6-0      5}6-
 5�0    5�6-
 5�0    #U6X
 5�V  &
�W
 $W-0     5�6
5� 3�; -  6 3�0      5�6	  =L��+?��  6�6�-
6$0    66-0      +�6-
 6C0    686-
 6C0      6_6! 6n(
6�U$%
'- ��[N.     &�' (- 0     6�6-0      6�6-0      ,c6--0     6�0    6_6!6n(-
 6�0    6�6 &  
�F;  &-0   6�6-
 6�0      6�6! 
�(? #-0      6�6-
 70      6�6!
�( &  7"F;  (-0     7)6-
 7;0      6�6! 7"(? #-0      7)6-
 7R0      6�6!7"( 7z7(F; 4-0     7�6-0   7�6-
 7� 
 7�NN0      6�6? %-0      7�6-
 7� 
 7�NN0      6�6 &  7�F;  !7�(-
 7�
 7�0    7j6? ! 7�(-
 7�
  0   7j6 &  7�F;  !7�(-
 7�
 7�0    7j6? ! 7�(-
 7�
  0   7j6 &  F;  !(-
 8
 7�0    7j6? ! (-
 8
  0   7j6 81-� �- .      8]0    8"6 7(8�-
8�N0   6�6 F; -0     8"6? ! F; -0   686-0    6_6 &-
g
 8�0    8u6 &-
0
 8�0    8u6 &-
 ?
 8�0      8u6 &-
 X
 8�0      8u6 &-
p
 8�0    8u6 &-
 �
 8�0      8u6 &-
9"
 90    8u6 &-
�
 930    8u6 &-
 �
 9J0      8u6 &-
 �
 9X0      8u6 &-
�
 9h0    8u6 &-

 9�0    8u6 &-
'
 9�0    8u6 &-
 =
 9�0      8u6 &-
R
 9�0    8u6 &-
c
 9�0    8u6 &-
 w
 9�0      8u6 &-
�
 :0    8u6 :*:0� !�'(p'(_;  ' (- 4    :66q'(?��  :=-	@   
 %�.     �' (-�
%�
 %� 0     	6-
 :F 0     6 7! �(-	   ?�� 0   "�6 7!T(+-	  ?�� 0   :h6 7!�(	  ?��+-�
%�
 %� 0   	6-
 :u :�N 0    6 7! �(-	   ?�� 0   "�6 7!T(+-	  ?�� 0   :h6 7!�(	  ?��+-�
%�
 %� 0   	6-
 :� 0     6 7! �(-	   ?�� 0   "�6 7!T(+-	  ?�� 0   :h6 7!�(	  ?��+-�
%�
 %� 0   	6-
 :� 0     6 7! �(-	   ?�� 0   "�6 7!T(+-	  ?�� 0   :h6 7!�(	  >���+-�
%�
 %� 0   	6-
 :� 0     6 7! �(-	   ?�� 0   "�6 7!T(+-	  ?�� 0   :h6 7!�(	  ?��+-�
%�
 %� 0   	6-
 ; 0     6 7! �(-	   ?�� 0   "�6 7!T(+-	  ?�� 0   :h6 7!�(+- 0      #�6 ;?;J;P� !�'(p'(_;   ' (- 4    ;V6q'(?��  &-
 ;b0    y6 &-
 �
 ;g0      &6 &-
 �
 ;r0      &6 &-
 �
 ;y0      &6 &-
 
 ;�0      &6 &-
 
 ;�0      &6 &-
 1
 ;�0      &6 &-
 ;�
 ;�0      &6 &-
 ;�
 ;�0      &6 &-
 g
 ;�0      &6 &-
 z
 ;�0      &6 &-
 �
 ;�0      &6 &-0    ;�6 7(;�7zF;  -0   686? -0      686-0    6_6-0    *�6---0    &�.     *�0      *�6 F;  -
;�0      y6 &-
%� 3�
 <1 6-
 < 0    6�6 7(-0     '�6-
 <K N0   6�6 &-
 <j
 <]0    <96 &-
 �
 <p0    <96 &-
 ?
 <�0    <96 &-
 �
 <�0    <96 &-
 
 <�0    <96 &-
 �
 <�0    <96 &-
 R
 <�0    <96 &-
 w
 =0    <96 &-
 g
 ="0    <96 &-
 X
 =30    <96 &-
 �
 =K0    <96 &-
 �
 =d0    <96 &-
 �
 =|0    <96 &  =�F;  :!=�(  =�F;  	-0   6-4      =�6-
 =�0      6�6? -! =�(X
 =�V-
=�0      6�6-
 =�0      y6 >>6
 �W
 =�W
 &�U%--0   &�c.    >&'(�`' (- -0      &� >P0    >?6?��  >f>k!>P(-
 >u N0     y6! =�( &-
 >�
 >�0    >Z6 &-
 1
 >�0    >Z6 &-
 >�
 >�0    >Z6 &-
 >�
 >�0    >Z6 &-
 ?
 ? 0    >Z6 &-
 ?-
 ?0    >Z6 &-
 
 ?<0    >Z6 &-
 �
 ?Q0    >Z6 &-
 �
 ?]0    >Z6 &-
 �
 ?k0    >Z6 &-
 ?�
 ?|0    >Z6 &-
 �
 ?�0    >Z6 ?�?� P P P['(  &
'--0    &�    B@-0   &�c`N-0    &�.     &�  &  ?�F;  <!?�(  ?�F;  -0     �6-4      ?�6-
 ?�0      6�6? -! ?�(X
 ?�V-
@0      6�6-
 =�0      y6 &
�W
 ?�W
 &�U%--0    &�-0   &� @$.     @6?��  >f>k!@$(-
 @D N0     y6! ?�( &-
 �
 @X0    @46 &-
 �
 ;r0    @46 &-
 
 @`0    @46 &-
 @�
 @x0    @46 &-
 _
 @�0    @46 &-
 �
 @�0    @46 &-
 �
 @�0    @46 &-
 �
 @�0    @46 &-
 �
 A0    @46 &-
 g
 ;�0    @46 &-
 H
 A 0    @46 &  A9F;  :!A9(  AGF;  	-0   d6-4      AO6-
 A]0      6�6? -! A9(X
 AsV-
A�0      6�6-
 A�0      y6 A�A�A�A�
 �W
 AsW;  j
 &�U%-
 A�0      '�'(-    B@-0   &�c4   ?�'(
'-.    &�'(-
'�.   '�' (- A� 0   '�6?��  7(!A�(-
 B  N0     y6! AG( &-
 B
 =30    A�6 &-
 BE
 B-0    A�6 &-
 Bq
 BW0    A�6 &-
 B�
 B�0    A�6 &-
 �
 <�0    A�6 &-
 �
 B�0    A�6 &-
 �
 <]0    A�6 &-
 �
 <p0    A�6 &-
 �
 =K0    A�6 &-
 w
 =0    A�6 &-
 �
 =d0    A�6 &-
 w
 <�0    A�6 &- B�.     s!B�(--
B�
 B� B�.   G0    y6  B�F>   B�;  !B�(-4    B�6? ! B�(X
 B�V  A�A�C5CACGCM
 �W
 B�W
 $W-
C.     '2
 C!(�(
 &�U%-
 A�0      '�'( B@-0   &�c`'(
'-.      &�'(-
C (�.      (i6- 09	 ?��.     (�6-� � �.     (�6  !�'(p'(_;  "' (-
CO 0     (p6q'(?��	   =L��+?�6  &- C\.     s!C\(--
Cw
 Cc C\.   G0    y6  C�F>  C\;  -4   C�6!C�(? X
C�V!C�( C�A�A�C�
 $W
 �W
 C�W-
C�.     '2!C�(
&�U%-
 C�0    '�'(-0    &�c   B@P'(
 '-.     &�'(-  C�.     C�' (- .   C�6?��	   =���+ &- C�.     s!C�(--
D
 C� C�.   G0    y6  D(F>  C�;  -4   D06!D((? X
DCV!D(( A�A�C5
 �W
 DCW
 $W-
D`.   '2
 DP!(�(
 &�U%-
 A�0      '�'( B@-0   &�c`'(
'-.      &�' (- 
DP (�.      (i6-2� , .   (�6	  =L��+?��  A�A�C5D�
 �W
 $W
 D�W
 &�U%-
 A�0      '�'( B@-0   &�c`'(
'-.      &�'(-
D�.     '2' (- .     (i6	  =L��+?��  &  D�_9;  B!D�(-4      D�6-4      D�6-
 D�0      y6-
 E0      y6? ! D�(X
 D�V-
E!0      y6 A�A�C5D�
 �W
 $W
 D�W
 &�U%-
 A�0      '�'( B@-0   &�c`'(
'-.      &�'(-
E:.     '2' (- .     (i6	  =L��+?��  &  EY_9;  &!EY(-4      EY6-
 Em0      y6? ! EY(X
 E�V-
E�0      y6 A�A�C5
 �W
 $W
 E�W
 &�U%-
 A�0    '�'( B@-0   &�c`'(
'-.      &�' (- 
(� (�.      (i6- 
 (� (�.    (i6- 
 (� (�.    (i6- 
 (� (�.    (i6- 
 (� (�.    (i6- 
 (� (�.    (i6- 
 (� (�.    (i6- 
 (� (�.    (i6- 
 (� (�.    (i6- 
 (� (�.    (i6- 
 (� (�.    (i6- 
 (� (�.    (i6	  =L��+?��  &- E�.     s!E�(--
E�
 E� E�.   G0    y6  E�F>   E�;   -4   E�6! E�(-0    46? X
E�V! E�(-0     46 E�
 �W
 $W
 E�W;  &- B?0    ,�' (	=���+- 4   E�6?��  F	 +-0      (�6 &- F.     s!F(--
F#
 F F.   G0    y6  F1F>  F;  �-0     46-
F60      686-
 F60      6_6-
 Fp
 FV0      FD6-
F60      686-
 F60      6_6-
 A�
 FV0      FD6-
F60      686-
 F60      6_6-
 Fy
 FV0      FD6!F1(? /-0    46-
 F60      �6-0      F�6! F1( &- F�.     s!F�(--
F�
 F� F�.   G0    y6  F�F>  F�;  2-0     7�6-
7�0      7�6-Z0    F�6!F�(? -0    7�6-A0    F�6! F�(   F�
 $W-
F�0      y6-0      +�6-0      ;�6-
 ?�0      686-
 ?�0      6_6-0      F�6-0      F�6-0      #�6-0      F�;  I-0   F�U%--0   6�0    6_6-0      +�6	  ?��+-  #4 #4^N
@�.   @6	  =L��+?��  &  GF; $-4     G6-
 G0      y6!G(? X
G+V-
G30    y6! G( GO
 �W
 G+W
 GBU$ %;���!GW(  GW!Ga(- 0     +{6-0      +G6-4      Gh6- 4    Gv6
� U%d!GW(  GW!Ga(X
 GV-0   ,x6-0      +L6?�z  GO
 GW
 $W- 7  #4 #4Oe0    G�6	  <#�
+?��  &-Z0      F�6-
 G
 $0      G�6-0      G�6-A0    F�6 &- G�.     s!G�(--
G�
 G� G�.   G0    y6  G�F>   G�;  !G�(-4    G�6? ! G�(X
 G�V  &
$W
 �W
 G�W-^-
 3�0    '� H.     H6	  >L��+?��  &- H2.     s!H2(--
HP
 H; H2.   G0    y6  HdF>  H2;  -4   Hi6!Hd(? X
HuV!Hd( &
�W
 HuW
 $W
 &�U%-
 H�0      H6?��  &- H�.     s!H�(--
H�
 H� H�.   G0    y6  H�F>  H�;  -4   H�6!H�(? !H�(X
 H�V  A�A�
 �W
 $W
 H�W;  H #4'(-
 '�.   '�' (-
 =3 0   '�6  (! 7!(!(	  >���+- 0     (�6?��  &- H�.     s!H�(--
H�
 H� H�.   G0    y6  H�F>  H�;  -4   H�6!H�(? X
IV!H�( &-  �� #4
	 ?��.     (�6 &  IF; ! I(-4      I6? @!I(-0   7�6-0     7)6-0    4t6-
 I0      H6X
 I$V  &
�W
 I$W
 $W-4   I06-
 I:0      y6  �7 #�F;  --
H�0    H6	  >���+-
 H�0      H6	  >L��+	  =L��+?��  &-4    IL6 &!IV(X
 IaV-  Ip0   #�6 &
�W
 IaW-4     I~6-	 @   
 %�0    �!Ip(;�-
%�
 %� Ip0   	6	  ?^�R	   ?��	   >��[  Ip7!V(	>�G�	   ?fff	   =�[  Ip7!\(	<#�
+-
 I� Ip0   6	  ?   +-
 I� Ip0   6	  ?   +-
 I� Ip0   6	  ?   +-
 I� Ip0   6	  ?   +-
 I� Ip0   6	  ?   +-
 I� Ip0   6	  ?   +-
 I� Ip0   6	  ?   +-
 I� Ip0   6	  ?   +-
 I� Ip0   6	  ?   +-
 J Ip0   6	  ?   +-
 J Ip0   6	  ?   +-
 J2 Ip0   6	  ?   +-
 I� Ip0   6	  ?   +-
 J Ip0   6	  ?   +-
 J Ip0   6	  ?   +-
 J2 Ip0   6	  ?   +-
 JJ Ip0   6	  ?   +-
 Jc Ip0   6	  ?   +-
 J| Ip0   6	  ?   +-
 J� Ip0   6	  ?   +-
 JJ Ip0   6	  ?   +-
 Jc Ip0   6	  ?   +-
 J| Ip0   6	  ?   +-
 J� Ip0   6	  ?   +-
 J� Ip0   6?�M  &
�W
 IaW;  �-  J�0     :h6^   J�7!V(- J�0     :h6  J�7!f(^   J�7!\(+-  J�0     :h6^  J�7!V(- J�0     :h6  J�7!f(^  J�7!\(+? �f  &
�W
 $W
 I$W-0     7�6-
7�0      7�6-0    7)6-
 J�0      6�6-0    4t6	  ?   + &- J�.     s!J�(--
J�
 J� J�.   G0    y6  J�F>   J�;  $-4   K6-
 K0      y6! J�(? , J�F>  J�;  ! J�(-0      F�6X
 K:V  -
 K:W
 $Wd!KF(-
 Kr
 KV0      KO6' (  �7 #�F;  �-0   ).=   KFI;  �-
K�0      (p6--
K�0      '�
 K� K�.    (i6--
K�0      '�
 K� K�.    (i6-2-
3�0    '�	   >L��	   >��.     (�6! KFB-0      K�,H; --0      K�<[N0      K�6  KFdH= 	-0   ).9; !KFA	  =L��+' A? �  K�
 $U%- 0     (�6 &- K�.     s!K�(--
L
 K� K�.   G0    y6  LF>  K�;  ! L(-4    L6? !L(! 	y(X
 L%V  &  #�F; -0   #h6!#�( &
�W
 $W
 L%W-
LC.   '2
 L=!(�(-4     L06; B-  #4<[N
 L= (�.      (i6-�, , #4.     (�6	  =���+?��  &- Lb.     s!Lb(--
L~
 Ll Lb.   G0    y6  L�F>   Lb;  -4   L�6! L�(? ! L�F; ! L�(X
 L�V-0   F�6 L�
 �W
 $W
 L�W-  #4[N
 '�.     '�' (-
 L� 0   '�6s[ 7!(!(- 4    L�6-4      L�6- 4    L�6- h 0   L�6+? ��  K�
 $W
 L�W;   #4x[N 7!#4(	  =L��+?��  L�L�CML�
 $W
 L�W;  � !�'(p'(_;  �'(-7  #4 #4.   3��J; [-0     &�c' (G;  E--0     K� 	  >�  N,PP ,PP  ,PP[N0     K�6q'(?�s	   =L��+?�T  E�
 L�U%- 0     (�6 &  L�F;  &!L�(-4      L�6-
 M	0      y6? ! L�(X
 MV-
M,0      y6 D�
 �W
 MW; P-
M@.     '2' (--
A�0    '� .   (i6--
M]0      '� .   (i6--
Mj0      '� .   (i6--
3�0      '� .   (i6--
Mw0      '� .   (i6--
M�0      '� .   (i6--
M�0      '� .   (i6--
M�0      '� .   (i6--
M�0      '� .   (i6--
K�0      '� .   (i6--
K�0      '� .   (i6--
M�0      '� .   (i6--
M�0      '� .   (i6	  ?   +?��  &  M�F;  J!M�(-4      M�6-4      M�6-4      M�6-4      M�6-
 M�0      y6? -! M�(X
 NVX
NVX
N"VX
N/V-
N<0    y6 D�
 �W
 NW; P-
NQ.     '2' (--
A�0    '� .   (i6--
M]0      '� .   (i6--
Mj0      '� .   (i6--
3�0      '� .   (i6--
Mw0      '� .   (i6--
M�0      '� .   (i6--
M�0      '� .   (i6--
M�0      '� .   (i6--
M�0      '� .   (i6--
K�0      '� .   (i6--
K�0      '� .   (i6--
M�0      '� .   (i6--
M�0      '� .   (i6	  ?   +?��  Nk
 �W
 N"W; T+-
 NQ.     '2' (--
A�0    '� .   (i6--
M]0      '� .   (i6--
Mj0      '� .   (i6--
3�0      '� .   (i6--
Mw0      '� .   (i6--
M�0      '� .   (i6--
M�0      '� .   (i6--
M�0      '� .   (i6--
M�0      '� .   (i6--
K�0      '� .   (i6--
K�0      '� .   (i6--
M�0      '� .   (i6--
M�0      '� .   (i6	  ?   +?��  Nz
 �W
 N/W; T+-
 N�.     '2' (--
A�0    '� .   (i6--
M]0      '� .   (i6--
Mj0      '� .   (i6--
3�0      '� .   (i6--
Mw0      '� .   (i6--
M�0      '� .   (i6--
M�0      '� .   (i6--
M�0      '� .   (i6--
M�0      '� .   (i6--
K�0      '� .   (i6--
K�0      '� .   (i6--
M�0      '� .   (i6--
M�0      '� .   (i6	  ?   +?��  N�
 �W
 NW; P-
N�.     '2' (--
A�0    '� .   (i6--
M]0      '� .   (i6--
Mj0      '� .   (i6--
3�0      '� .   (i6--
Mw0      '� .   (i6--
M�0      '� .   (i6--
M�0      '� .   (i6--
M�0      '� .   (i6--
M�0      '� .   (i6--
K�0      '� .   (i6--
K�0      '� .   (i6--
M�0      '� .   (i6--
M�0      '� .   (i6	  ?   +?��  &  N�F; &! N�(-4      N�6-
 N�0      y6? !N�(X
 N�V-
N�0      y6 &
�W
 N�W--
 A�0    '�
 (� (�.    (i6--
M]0      '�
 (� (�.    (i6--
Mj0      '�
 (� (�.    (i6--
3�0      '�
 (� (�.    (i6--
Mw0      '�
 (� (�.    (i6--
M�0      '�
 (� (�.    (i6--
M�0      '�
 (� (�.    (i6--
M�0      '�
 (� (�.    (i6--
M�0      '�
 (� (�.    (i6--
K�0      '�
 (� (�.    (i6--
K�0      '�
 (� (�.    (i6--
M�0      '�
 (� (�.    (i6--
M�0      '�
 (� (�.    (i6	  >��+?�V  &
�W
 $W
 IW �7 #�F;  /-
N�0      H6	  ?   +-
 I0      H6	  ?   +	  =L��+?��  6�N�O
 �W
 $W-
6$0      66-0      +�6! 6n(-
 6C0    686-
 6C0      6_6
6�U$%
'- ��[N.     &�'(-0   6�6-0      ,c6--0     6�0    6_6!6n(@[N' (- @[O 
 @�.     @6 6�6�
 �W
 $W-
6$0    66-0      +�6-
 6C0    686-
 6C0      6_6! 6n(
6�U$%
'- ��[N.     &�' (-0   6�6-0      ,c6--0     6�0    6_6!6n(   �3�7 #4 -0    &�c`N  OSOaOm_9;  	  ���'(_9; 
 ''( _9; ' (- -0     &�-0     &�c`N-0    &�.     &�  F	�-0   :h6 ! �( >CHRTV�\fpu-	0     �' (-
 0     6 7! R( 7! T( 7! V( 7! �( 7! \( 7! f( 7! p( 7! �(   7O�*!O�(! O�(! O�(-
 O� N0   y6-0      O�6 &  O�
 O�F; -
P 
 P.     $a6? ] O�
 P$F; -
PC
 P.     $a6? = O�
 PGF; -
P[
 P.     $a6?  O�
 =dF; -
P_
 P.     $a6 &-
 w
 O�
 Pc.     O�6 &-
 �
 P$
 Pq.     O�6 &-
 P|
 PG
 Pq.     O�6 &-
 �
 =d
 Pq.     O�6 P�P�P�P�P�P�CMP�
 �W-
P�0      y6'(
2['(-  #4N
'�.   '�'(-
 P�0   '�6Z[7!(!(
P�'(  !�'(p'(_;  �'(-7  #47 #4.   3�' (  3�;  PG= 
 3�7 3�
3� 3�G;  - �H; %-.      %O;  -4      P�6? 5G; - �H; %-.      %O;  -4      P�6	  >���+q'(?�9? �' X+X
 P�V  K�P�P�P�
 P�W; $-7  #47 #4 .   @6+?  ? ��  &  P�F;  2!P�(  O�F;  !O�(-4    +6-4      Q	6? -
Q0    6�6 6�Q�Q�CM
 �W
 Q:W QIF;  %-
QU0      6�6+-.    O'(! QI(  QIF; k-  O� O� (! #4 �.�[N.      Q�!Q( Q7!Q�(  3� Q7!3�(-
 Q�0      6�6-
 Q�0      y6! QI(  QIF; �-� Q0   Q�6- �[N Q0   Q�6+-�  Q0   Q�6-A[N Q0     Q�6!QI(  !�'(p'(_;   ' (- 4      Q�6q'(?��X
Q:V	 =L��+?��  &
�W
 RW-  R0     #�6- Q7 #4 #4.   3��H; �-	?�ff
 0    �!R(-2
%�
 %� R0     	6-
 R$ R0   6-0      ).;  u-0   RS6-0      F�6-0      +G6-0      #h6-0    46-4      Rb6-4      Rp6-4      R|6-4      R�6-4      R�6	  =L��+?�
  S[SaCM-^^*� 	 ?���
 %�
 R�0    5!R�(-	   >L�� R�0     O{6  !�'(p'(_;  *' (X
R V- 7 R0     #�6q'(?��  &-	  >L�� R�0     O{6	  >L��+- R�0   #�6 S�S�
 �W
 StW-0   O�6- Q0      +{6- Q7 (!^ N0   G�6- Q7 #4��[N  Q7 (!cP[NN0   6�6!S�('(' (-� S�N.     O.'(-0    F�;  a S�H;  ! S�(  S� �H; C S�N! S�(-P� Q0     S�6-Z  Q0     Q�6- Q0   Q�6-0      +�;  q S�H;  ! S�(  S� �H; S S�N! S�(-P� Q0     S�6-Z  Q0     Q�6- Q7 #4 S�[N Q0     Q�6-0      ,;  q S�I;  ! S�(  S� �I; S S�O! S�(-P� Q0     S�6-Z  Q0     Q�6- Q7 #4 S�[N Q0     Q�6  S� �F; 	 �!S�(  S� �F; 	 �!S�(	  =L��+?�G  &
�W
 S�W S�F;  -4   S�6-4      S�6! S�(-^"^*J
%�
 S� TN0   5!S�(-	   >L�� S�0     O{6-^
^*h
%�
 T# T0N0   5!T(-	   >L�� T0     O{6-0      T@;  ]-4   S�6- S�0   #�6-^"^*J
%�
 S� TN0   5!S�(-	   >L�� S�0     O{6	  >L��+-0      );  � TX
 TfF> 	 TX
 9�F; l--0     OD-
Tt Q0     '��dd[N TX.     @6--0    OD-
Tt Q0     '��dd[N TX.     @6	  <#�
+? q--0     OD-
Tt Q0     '��dd[N TX.     @6	  >��+--0    OD-
Tt Q0     '��dd[N TX.     @6	  >��+-0      T;  eX
T�V-4     S�6- T0   #�6-^
^*h
%�
 T# T0N0   5!T(-	   >L�� T0     O{6	  >L��+-0      )Z;  E T�
 T�F; -4   T�6? - T�
 T�F; -4   T�6?  T�
 T�F; 	-4   T�6	  =L��+?��  &
�W
 T�W- Q7 #4 '[N Q7 #4�[N TX.   @6	  >L��+?��  &
�W
 T�W UF;  U- (
 3�
8� (! Q7 #4[N4      U36-
 U=0      6�6-
 UU0      y6! U(  UF; +-
 U{0    y6!U(X
 T�V	 =L��+?�n  U�U�CMU�V�V�V�V�
 �W
 U�W U�F; ; !�'(p'(_;  "'(-
U�4   ;V6q'(?��-  Q7 #4
 '�.   '�'(-
 U�0   '�6ZZZ[7!(!(-4      V	6-	7 #4 �[N0     (I6	  A��+X
 VV
 V'h
V/F; `-
V\.     '2
 V@!(�(-
V�.   '2
 V�!(�(-7  #4
 V@ (�.      (i6-7 #4
 V� (�.    (i6? 1-
C.     '2
 C!(�(-7  #4
 C (�.      (i6  !�'(p' ( _;  " '(-
CO0     (p6 q' (?��-097 #4	   ?��.     (�6  !�'(p' ( _;  ` '( 3�=  
 3� 3�
3�7 3�F;  ?  )G;  !-
V�^ ^ 
 A
 V�� V�56 q' (?��	 =���+-0     (�6+-
V�0    6�6! W8(! U�(  U�F; +-
 WG0    y6!U�(X
 U�V	 =L��+?��  U�
 �W
 VW-
LC.   '2
 L=!(�(- 7  #4x[N
 L= (�.    (i6	  =���+?��  &  WfF;  !Wf(
@X!TX(
�!T(? � WfF; !Wf(
@`!TX(
!T(? � WfF; !Wf(
@x!TX(
@�!T(? � WfF; !Wf(
@�!TX(
_!T(? � WfF; !Wf(
@�!TX(
�!T(? i WfF; !Wf(
A !TX(
H!T(? E WfF; !Wf(
A!TX(
�!T(? ! WfF; ! Wf(
Tf!TX(
Wr!T( &  W�F;  !W�(
T�!T�(
W�!T0(? E W�F; !W�(
T�!T�(
W�!T0(? ! W�F; ! W�(
T�!T�(
W�!T0( W�X CM
 �W
 W�W-0     W�;  �X
StVX
S�VX
W�VX
T�V! S�(-
 W�
 P.     $a6- S�0   #�6- T0   #�6-4      Sg6-0      ,x6-0      G�6-0      +L6-0     46-0      #�6  !�'(p'(_;  ' (- 4    Q�6q'(?��X
W�V	 =L��+?�  &
�W
 W�W-0     )
;  �X
StVX
S�VX
W�VX
T�V! S�(-
 W�
 P.     $a6- S�0   #�6- T0   #�6-4      Sg6-0      ,x6-0      G�6-0      +L6-0     46-0      #�6- Q0   (�6!P�(X
 W�V	 =L��+?�>  X`
 $W-
X0    y6-
 X.0      y6-
 O�
 Pc (! #4  2[N.     Q�' (-  4     Xe6 _9;   7!Q�(  3� 7!3�(- 4    Xs6-0      ,;  -  4    X�6	  >L��+-0      )
=  -0   +�;  !- 0      (�6-0      %f6	  >L��+	  =L��+?��	   =L��+ X`'�3�6�
 $W
 &�U%-.   X�'(- X�.   X�'(' (-�0     Q�6-  !3[N0    Q�6	  =L��+?��  X`�(
-.      X�'(	=L��+-7 #4
 '�.     '�' (- 7 3�
 8�7 (!7 #44      U36	  =L��+ X�X�C�-^ ^.      C�' (- 4    X�6- .     C�6   F	X�-.      Y6- 0     (�6 
 $U%- 0     (�6 &
'--0      &�-   B@-0   &�c.    Y:N-0      &�.     &�  YJ?� P P P[ &  YQF; !YQ(-
 Yj0    6�6-
 Y�.     Y6-
Y�.     Y6-(
Y�.     Y6-<
Y�.     Y6-P
Y�.     Y6-d
Y�.     Y6-x
Y�.     Y6-�
Y�.     Y6-�
Z.     Y6-�
Z'.     Y6-�
Z;.     Y6-�
ZO.     Y6-�
Zc.     Y6-
 Zw.   Y6-
  .   Y6? -
Z�0    6�6 P�3�CMZ�-Z�-
�.   �'('(SH; t-  #4-N.    Z�-.   Z�[N
 '�.   '�' (   Z�!Z�(!Z�A9;  Z[ 7! (!(-
 =3 0     '�6N'(?��	   =L��+ &  Z�F;  F-
Z�0      y6-
 Z�0      y6-
 [0      y6-4      ['6! Z�(? -
[50    y6!Z�(X
 [IV  [U
 �W
 [IW' (-0   T=   Z�F= -0     [Z
 IF> -0   [Z
 H�F; ( #4!P�(  (!!3s(' (-
[d0    y6+-0   )Z=   F=  Z�F; 2-  3s0    G�6- P�0      6�6-
 [u0      y6+	   =L��+?�D  -P�[� $F;  B!$('(H; .'(H;  -  [�0   (�6'A? ��'A?�� #4[N' ('(H; V'(H;  B- FP(P[N
 '�.   '�![�(-
 =3 [�0   '�6'A? ��'A?��-
[�0      y6+  &  [�F;  &-4     [�6! [�(-
 [�0      y6? X
[�V! [�(-
 \0      y6 \/-
 $W
 �W
 [�W'(!\2(!\7(-4    \<6	  <#�
+-0      F�; �' (  !�SH; �
 \Ch
\NG;Z-   !�7  #4 #4.     \QF=   !�7  3� 3�G= -   !�.      %O=  	  !�G= ,--
 \X  !�0      '�-
A�0    '�.     3�;  -
\X  !�0      '�'(? �-   !�7  #4 #4.   \QF=   !�7  3� 3�G= +-   !�.      %O=  -   !�0    &�
 F6F= 8  !�G= ,--
 \X  !�0      '�-
A�0    '�.     3�;  -
\_  !�0      '�'(?--   !�7  #4 #4.   \QF= -   !�.      %O=  8  !�G= ,--
 \X  !�0      '�-
A�0    '�.     3�;  -
\X  !�0      '�'(? �-   !�7  #4 #4.   \QF= -   !�.      %O=  !-   !�0    &�
 F6F= 	  !�G= ,--
 \X  !�0      '�-
A�0    '�.     3�;  -
\_  !�0      '�'(' A? �ZG; --
 \j0      '�Oe0      G�6  \2F; -
[N-0   &�.     @6'(? ��  &  [�F;  $-4   \s6! [�(-
 \~0      y6? X
[�V! [�(-
 \�0      y6 \/-
 $W
 �W
 [�W'(!\2(!\7(-4    \<6	  <#�
+-0      ); �' (  !�SH; �
 \Ch
\NG;Z-   !�7  #4 #4.     \QF=   !�7  3� 3�G= -   !�.      %O=  	  !�G= ,--
 \X  !�0      '�-
A�0    '�.     3�;  -
\X  !�0      '�'(? �-   !�7  #4 #4.   \QF=   !�7  3� 3�G= +-   !�.      %O=  -   !�0    &�
 F6F= 8  !�G= ,--
 \X  !�0      '�-
A�0    '�.     3�;  -
\_  !�0      '�'(?--   !�7  #4 #4.   \QF= -   !�.      %O=  8  !�G= ,--
 \X  !�0      '�-
A�0    '�.     3�;  -
\X  !�0      '�'(? �-   !�7  #4 #4.   \QF= -   !�.      %O=  !-   !�0    &�
 F6F= 	  !�G= ,--
 \X  !�0      '�-
A�0    '�.     3�;  -
\_  !�0      '�'(' A? �ZG; --
 \j0      '�Oe0      G�6  \2F; -
[N-0   &�.     @6'(? ��  &  \�F;  $-4   \�6! \�(-
 \�0      y6? X
[�V! \�(-
 \�0      y6 ]]]�
 �W
 $W
 [�W'( !�'(p'(_;  �' ( F>  - .    %O9>  3�=  
 3� 3�
3� 7 3�F;  ?  E_; :--
 A�0   '�-
A� 0   '�-
A�0    '�.     \Q;   '(?  '(q'(?�g_; m-0     );  _--
 A�0     '�-
A�0    '�Oe0      G�6-0      F�;  '-
V�^ ^ -0     &�
 ] d  V�56	<#�
+?��  &  ]BF;  &-4     ]R6! ]B(-
 ]d0      y6? X
[�V! ]B(-
 ]~0      y6 ]]�]��
 �W
 $W
 [�W'( !�'(p'(_;  �' ( F>  - .    %O9>  3�=  
 3� 3�
3� 7 3�F;  ?  E_; :--
 A�0   '�-
A� 0   '�-
A�0    '�.     \Q;   '(?  '(q'(?�g_; 5-0     F�;  '-
V�^ ^ -0     &�
 ] d  V�56	<#�
+?�  &  ]�F;  &-4     ]�6! ]�(-
 ]�0      y6? X
[�V! ]�(-
 ]�0      y6 \/-
 $W
 �W
 [�W'(!\2(!\7(-4    \<6	  <#�
+-0      ); �' (  !�SH; �
 \Ch
\NG;Z-   !�7  #4 #4.     \QF=   !�7  3� 3�G= -   !�.      %O=  	  !�G= ,--
 C�  !�0      '�-
A�0    '�.     3�;  -
C�  !�0      '�'(? �-   !�7  #4 #4.   \QF=   !�7  3� 3�G= +-   !�.      %O=  -   !�0    &�
 F6F= 8  !�G= ,--
 C�  !�0      '�-
A�0    '�.     3�;  -
\_  !�0      '�'(?--   !�7  #4 #4.   \QF= -   !�.      %O=  8  !�G= ,--
 C�  !�0      '�-
A�0    '�.     3�;  -
C�  !�0      '�'(? �-   !�7  #4 #4.   \QF= -   !�.      %O=  !-   !�0    &�
 F6F= 	  !�G= ,--
 C�  !�0      '�-
A�0    '�.     3�;  -
\_  !�0      '�'(' A? �ZG; --
 A�0      '�Oe0      G�6  \2F; -
[N-0   &�.     @6'(? ��  &-0      �;  P ]�F;  &-4     ]�6! ]�(-
 ]�0      y6? X
[�V! ]�(-
 ^0      y6? -
^80    y6 ]^d^j�
 �W
 $W
 [�W'( !�'(p'(_;  �' ( F>  - .    %O9>  3�=  
 3� 3�
3� 7 3�F>  - 0      �;  ?  E_; :--
 A�0   '�-
A� 0   '�-
A�0    '�.     \Q;   '(?  '(q'(?�W_; m-0     );  _--
 A�0     '�-
A�0    '�Oe0      G�6-0      F�;  '-
V�^ ^ -0     &�
 ] d  V�56	<#�
+?��  ^p^vCM !�'(p'(_;  j' (- 0    �9; I-
'--
 A�0    '�-0   &�c   B@PN-
A�0      '�.     &� 0      6�6q'(?��  ^�
 �W
 ^|W-  #4<[N
'�.   '�' (-
 =3 0   '�6- 0   ^�6-
 ^�0      y6- h 0   L�6+? ��  ^�
 �W
 ^|W-  #4<[N
'�.   '�' (-
 =3 0   '�6- 0   ^�6-
 ^�0      y6- h 0   ^�6+? ��  ^�
 �W
 ^|W-  #4<[N
'�.   '�' (-
 =3 0   '�6- 0   ^�6-
 ^�0      y6- h 0   _6+? ��  A� =_; -  =.     _6!=( -
_ 0    y6-�[
<]
 #4�[N.   _7!=(' (   =SH;  "-   =4      _K6	  =���+' A? ��  &_; D-	  >���	   >L��P0    _W6+-	  >���	   >L��P0    _W6+? ��  _]_b_e_h_k_n_q(!_t3sZ�_z'('(H; f'(
H; T' ( 	H; B- PNPNPN[.     _|S'(	=L��+' A? ��'A?��'A?�� #4(!E�-
'�.     '�' (- 0     '�6_;  	 7!(!(   _t--
_�0    y6' ( SH; - 0     (�6' A? ��  _�_�_�_�_�_�_�
 �W-
_�0    y6  #4<[N'(-
'�.   '�'(-
 =30   '�6-0   ^�6-
 '�.     '�'(-
 =30   '�6-^ A[
 0     _�6-0   ^�6-
 '�.     '�'(-
 =30   '�6-^ A[
 0     _�6-0   ^�6-
 '�.     '�'(-
 =30   '�6-^ A[
 0     _�6-0   ^�6-
 '�.     '�'(-
 =30   '�6-^ A[
 0     _�6-0   ^�6-
 '�.     '�' (-
 <p 0   '�6-^ A[
  0     _�6- 0   ^�6-	 ?�   h0   ^�6+? ��  &  `F; Z! `(-
 `0      y6-
`6.     Y6-5
a.     Y6-W
a�.     Y6-u
b�.     Y6? -
f20    y6 C�A�A�f�f�f�f�f�-f�f�f�Rf�f�g7g=g(g7g=f�ghgnf�
 $W
 �W fNF; -
f[0      6�6-
 f�0      6�6
&�U%! fNA-
 C�0      '�'(-0    &�c   B@P'(
 '-.     &�'(
 f�W! f�(-
 +m.     '�'(7  #4'(7  #4!f�('('('(H; �<'(�H;  @-[N
 '�.   '�!f�(-
=3 f�0      '�6'A<N'(? ��<'(�H;  B-O[O
 '�.   '�!f�(-
=3 f�0      '�6'A<N'(? ��<'(�H;  V-O[O
 '�.   '�!f�(Z[  f�7! (!(-
 =3 f�0      '�6'A<N'(? ��<'(�H;  V-[N
 '�.     '�!f�(Z[  f�7! (!(-
 =3 f�0      '�6'A<N'(? �� f�'(p'(_;   '(-0    _�6q'(?��'(H;�-	  =L��7 (!	A4  [N0    ((6	  =���+<'(�H; V-O[O
 '�.   '�!f�(Z[  f�7! (!(-
 =3 f�0      '�6'A<N'(? ��<'(�H;  V-[N
 '�.     '�!f�(Z[  f�7! (!(-
 =3 f�0      '�6'A<N'(? ��<'(�H;  B-O[O
 '�.   '�!f�(-
=3 f�0      '�6'A<N'(? ��<'(�H;  B-[N
 '�.     '�!f�(-
=3 f�0      '�6'A<N'(? �� f�'
(
p'	(	_;   	
'(-0    _�6	
q'	(?��'A?�.�'(	>L��+'A? �u'(�H;  n'(H; P-[N
'�.   '�!f�(	A�  P[  f�7! (!(-
 =3 f�0    '�6'A'A?��	 <��
+N'(?��! f�(-d[N
 '�.   '�! f�(-
BW  f�0      '�6Z[  f�7! (!(-d[N
 '�.   '�!f�(-
BW f�0      '�6Z[ f�7! (!(-d[N
 '�.   '�!f�(-
BW f�0      '�6ZZ[  f�7! (!(-d[N
 '�.     '�!f�(-
BW f�0      '�6ZZ[  f�7! (!(-dz[N
 '�.     '�!f�(-
BW f�0      '�6-Z[  f�7! (!(-dz[N
 '�.     '�!f�(-
BW f�0      '�6�Z[  f�7! (!(-zd[N
 '�.     '�!f�(-
BW f�0      '�6�Z[  f�7! (!(-zd[N
 '�.     '�!f�(-
BW f�0      '�6-Z[  f�7! (!(!f�(-
 g
 g.     f�6-.   g6'(H;  &-
+m.     '�!f�(	   <#�
+'A? ��! g(('(H;  T-  f�7  #4%[O
 +m.     '�!g(( g(7! "�( g(7! g1(	  <#�
+'A? ��'( g('(p'(_;  @'(-  f�0      _�6-4     gC6'A	   <#�
+q'(?��'( f�'(p'(_;  D'(-  f�0      _�6- f�4    g^6'A	   <#�
+q'(?��	   <#�
+- �0   L�6  f�'(p'(_;  *' (-� 0   L�6	  <#�
+q'(?��+?��? �.  g�g�g�g��
 g~W-  f�c<[N
 '�.     '�!g�(-
 g� g�0   '�6Z[ g�7!(!(- f� T<[N
 '�.   '�!g�(-
 KV g�0   '�6  g�'('(- f� @[N
'�.   '�'(- f�* @[N
'�.   '�'(-  f�* [N
'�.     '�'(-  f� [N
'�.     '�'(-  f� @7[N
 '�.   '�'(-  f�* @7[N
 '�.   '�'(-  f�* 7[N
 '�.   '�'(-  f� 7[N
 '�.   '�'(-  f� @n[N
 '�.   '�'(-  f�* @n[N
 '�.   '�	'(-  f�* n[N
 '�.   '�
'(-  f� n[N
 '�.   '�'(-  f� @�[N
 '�.   '�'(-  f�* @�[N
 '�.   '�'(-  f�* �[N
 '�.   '�'(-  f� �[N
 '�.   '�'(-  f�J<[N
 '�.     '�'(-  f�J<[N
 '�.     '�'(Z[7!(!(!gt(  !�'(p'(_;  �' (--
 A� 0     '�7 #4.   3�H=  gtF;  :- 0      ).;  *-
g� 0   g�6! gt(-4      g�6+X
g~V--
 A� 0   '�7 #4.   3�I; -
g� 0     g�6q'(?�Q	   =L��+?�7  &+-4     �6 	g�g�f�g�g�g�g�g�f�X
f�V f�'(p'(_;  ,'(-0      ,x6-0     (�6q'(?�� h'(p'(_;   '(-0      (�6q'(?�� f�'(p'(_;   ' (- 0      (�6q'(?��! fN( g�g��
 f�W !�'(p'(_; ' (- 7  #4 #4.   3�dH=  g1F;  L-
h(0    6�6- 0     ).;  ,- 0     hI6-
 h^ "�N 0    g�6! g1(+?  `- 7  #4 #4.     3�dH=  g1F= - 0      ).;  ,- 0      ,x6!g1(- f��[N 0     6�6+- 7  #4 #4.     3�dI; -
hd "�N 0    g�6q'(?��	   =L��+?��  hk
 f�W-.    hs' (-  #4PN #4 #4[0      (I6 +-.    hs' (-  #4PO #4 #4[0      (I6 +? ��  &  ,YF;  -4     ,Y6! ,Y(? #-
h�0    y6X
 h�V-0   ,c6!,Y( iT
 �W
 h�W-
h�0    y6-
 h�0      y6-
 i0      y6-
 i*0      6�6-0      +�6-0      );  �--
A�0    '�-0   &�c   B@PN-
A�0      '�.     &�' (-0    );  `--
 A�0      '�-0   &�c�PN
iZ 0      6�6-
 A�0      '�-0   &�c�PN
iZ 7! #4(	  =L��+?��? �E-0   T=  -0   [Z
 IF; -0   ia6-
 il0      y6-0      T=  -0   [Z
 H�F; -0   ia6-
 il0      y6-0      )Z;  )--
 iZ0      i|0     (�6-
 i�0      y6-0      +�;  8-0   +�;  ,-	  =L��-
iZ0      i|0     L�6	  :�o+?��-0   ,;  8-0   ,;  ,-	  =L��-
iZ0      i|0     ^�6	  :�o+?��	   =L��+?�	  &--
'0    i|
 '�.     '�!i�(-
 A�0      '�-0   &�c�PN  i�7!#4(-
 =3 i�0     '�6 3�i�-'0    i�' (- 7 A� 7 C�.     &�  ?�A�i�-0   &�c'(-.    (�' (-0    &� 7!C�( 7  C�`N 7!A�(   &  i�F;  $-4   i�6! i�(-
 i�0      y6? X
[�V! i�(-
 i�0      y6 ]i�j�
 �W
 $W
 [�W'( !�'(p'(_;  �' ( F>  - .    %O9>  3�=  
 3� 3�
3� 7 3�F;  ?  E_; :--
 j	0   '�-
j	 0   '�-
j	0    '�.     \Q;   '(?  '(q'(?�g_; m-0     );  _--
 j	0     '�-
j	0    '�Oe0      G�6-0      F�;  '-
\X^ ^ -0     &�
 ] d  V�56-4     F6	  <#�
+?��  &
�W
 $W
 [�W
 &�U%! \2(	=#�
+!\2(?��  &  jF;  $-4   j6! j(-
 j$0      y6? X
jBV! j(-
 jN0      y6 ]jmjr�
 �W
 $W
 [�W'( !�'(p'(_;  �' ( F>  - .    %O9>  3�=  
 3� 3�
3� 7 3�F;  ?  E_; :--
 A�0   '�-
A� 0   '�-
A�0    '�.     \Q;   '(?  '(q'(?�g_; 7-0     );  )--
 A�0     '�-
A�0    '�Oe0      G�6	  <#�
+?�  &  ]�F;  &-4     jw6! ]�(-
 j�0      y6? X
[�V! ]�(-
 j�0      y6 ]j�j��
 �W
 $W
 [�W'( !�'(p'(_;  �' ( F>  - .    %O9>  3�=  
 3� 3�
3� 7 3�F;  ?  E_; :--
 j	0   '�-
j	 0   '�-
j	0    '�.     \Q;   '(?  '(q'(?�g_; m-0     );  _--
 j	0     '�-
j	0    '�Oe0      G�6-0      F�;  '-
\X^ ^ -0     &�
 j�d  V�56	<#�
+?��  kkCMk$k* j�F;  \!j�(-
 j�0    6�6  !�'(p'(_;  .'(-0    �9; -4      �6q'(?��?  X! j�(-
 k0    6�6  !�'(p' ( _;  . '(-0    �9; -4      �6 q' (?��  k$k*CMk$k* k0F;  h!k0(-
 k90    6�6  !�'(p' ( _;  : '(-0    �9; -
k`0   6�6-4     �6 q' (?��?  X! k0(-
 ky0    6�6  !�'(p' ( _;  . '(-0    �9; -4      �6 q' (?��  k$k*CMk�k� k�F;  h!k�(-
 k�0    6�6  !�'(p'(_;  :'(-0    �9; -
k�0   6�6-4     �6q'(?��?  X! k�(-
 ky0    6�6  !�'(p' ( _;  . '(-0    �9; -4      �6 q' (?��  k�k�CMll  k�F;  h!k�(-
 k�0    6�6  !�'(p'(_;  :'(-0    �9; -
l0   6�6-4     16q'(?��?  X! k�(-
 ky0    6�6  !�'(p' ( _;  . '(-0    �9; -4      16 q' (?��  �- 0    �9; 0- 0    l&6-
 l. 0     6�6-
 lG0      y6? -
ld0    y6 l�s_sesk-
ly0    y6-
 �
 l�.   �'('(p'(_; (' (- 0     sr6	  >L��+q'(?��  &-4   s�6-4      s�6-
 s�4    ;V6 --�
 s� 0    s�6- �
 s� 0    s�6-d
 s� 0      s�6- 	�
 s� 0    s�6- 	�
 s� 0    s�6- 	�
 s� 0    s�6- 	�
 t 0    s�6- 	�
 t 0    s�6- �
 t! 0    s�6- 	�
 t 0    s�6- 	�
 t 0    s�6- �
 t! 0    s�6- �
 t, 0    s�6-x
 s� 0      s�6-x
 t: 0      s�6-x
 tV 0      s�6-x
 tk 0      s�6-x
 t~ 0      s�6-x
 t� 0      s�6-x
 t� 0      s�6-x
 t� 0      s�6-x
 t� 0      s�6-x
 t� 0      s�6-�
 t� 0      s�6-�
 u 0      s�6-�
 u5 0      s�6-�
 uV 0      s�6- �
 ud 0    s�6-�
 uy 0      s�6-�
 u� 0      s�6-�
 t~ 0      s�6-�
 u� 0      s�6-�
 u� 0      s�6-�
 u� 0      s�6-�
 u� 0      s�6- '
 u� 0    s�6- '
 v 0    s�6- '
 v 0    s�6- �
 v/ 0    s�6- �
 vM 0    s�6 &-
 ;�4    s�6+-
;y4    s�6+-
vj4    s�6+-
;�4    s�6+-
vr4    s�6+-
v�4    s�6+-
v�4    s�6+-
;�4    s�6+-
;�4    s�6+-
v�4    s�6+-
v�4    s�6+-
v�4    s�6+-
v�4    s�6+-
P�4    s�6+-
v�4    s�6+-
v�4    s�6+-
v�4    s�6+-
v�4    s�6+-
w4    s�6+-
w4    s�6+-
w4    s�6+-
w%4    s�6+-
w14    s�6+-
w:4    s�6+-
wE4    s�6+-
wP4    s�6+-
wX4    s�6+-
wf4    s�6+-
wy4    s�6+-
w�4    s�6+-
w�4    s�6+-
;�4    s�6+-
w�4    s�6+-
w�4    s�6+-
w�4    s�6+-
;�4    s�6+-
w�4    s�6+-
w�4    s�6+-
F64    s�6+-
w�4    s�6+-
w�4    s�6+-
w�4    s�6+-
;�4    s�6+-
w�4    s�6+-
@X4    s�6+-
w�4    s�6+-
w�4    s�6+-
w�4    s�6+-
x4    s�6+-
;�4    s�6+-
x4    s�6+-
x4    s�6 GOxA
 $W
 �W
 x'W--0    +0    �6-
 x-0      686
GBU$$ %--0   +0    �6-
 x-0      686 
x-F; �-0    +G6-7 #4
 '�.     '�!xL(-
 O� xL0   '�6- xL0     _�6-0      +�6
$U%-
xq.     '2
 xb!xQ(-  xL7 #4
 xb xQ.    (i6-
 x�, � � xL7 #4.   (�6- xL0   (�6-0      ,c6?�		   =L��+?��  &  #�F; -0     #h6!#�( &  x�F;�! x�(-
 x�0    6�6-4      L06	  ?�  +-4      x6-4      x�6-4      x�6-4      x�6-
 2Y0      ,�6-
 1�0      ,�6-
 1�0      ,�6-
 0�0      ,�6-
 /0      ,�6-
 /0      ,�6-
 .�0      ,�6-
 .d0      ,�6-
 .0      ,�6-
 ./0      ,�6-
 .�0      ,�6-
 .y0      ,�6-
 0X0      ,�6-
 /_0      ,�6-
 x�0      y6�!GW(-0      F�6-0      F�6-
 <]0      '�6-
 y0      686-
 y0      6_6-
 y0      *�6-
 y!0      y6-
yM0      7�6-0    7�6
$U%-4    yV6? -
yc0    y6 &
$W
 �W-0     T@; � x�_; !x�(-0    y6! 	y(d! GW(-0      y�6-
 2Y0      y�6-
 1�0      y�6-
 1�0      y�6-
 0�0      y�6-
 /0      y�6-
 /0      y�6-
 .�0      y�6-
 .d0      y�6-
 .0      y�6-
 ./0      y�6-
 .�0      y�6-
 .y0      y�6-
 0X0      y�6-
 /_0      y�6-0     7�6-0      ,c6-
%� 3�
 <1 6-
 y0      �6-
 y�0      y6X
 x'V xL_; -  xL0   (�6	  =L��+? 	   =L��+?�^  &  x�9;} x�_; !x�(-0    y6! 	y(d! GW(-0      y�6-
 2Y0      y�6-
 1�0      y�6-
 1�0      y�6-
 0�0      y�6-
 /0      y�6-
 /0      y�6-
 .�0      y�6-
 .d0      y�6-
 .0      y�6-
 ./0      y�6-
 .�0      y�6-
 .y0      y�6-
 0X0      y�6-
 /_0      y�6-0     7�6-0      ,c6-
%� 3�
 <1 6-
 y0      �6-
 y�0      y6X
 x'V xL_; -  xL0   (�6 '
 �W
 $W
 x'W y�_9;  !y�(  y�_; �
 &�U%-0      &�
 yF; �-
y�0    6�6
'--
 A�0    '�-0   &�c   B@PN-
A�0      '�.     &�' (-� #4	   ?fff	   ?fff.     (�6- #4
 y�.   y�6-
 y�0      (p6	  =L��+?�E  A�A�C5
 �W
 $W
 x'W
 &�U%-
 A�0    '�'( B@-0   &�c`'(
'-.      &�' (- � � , .     (�6	  =L��+?��  f� zF; �-  z6 z,.   z' (-
 z@.     y6!z(- 
 '�.   '�!z_(-
 =| z_0   '�6s[ z_7!(!(- z_0     +G6-4      zh6- h z_0     L�6+? ��?  -
zq0    y6 z�z��
 �W-  z�.   s!z�(--
z�
 z� z�.   G0    y6  !�'(p'(_;  f' (- 0    �9>  G;  5 z�;   7 	y9; - 4   	y6?  7 	y;  - 4   	y6	  =L��+q'(?��  z�z��-
z�.   6�6  !�'(p'(_;  2' (- 0    �;  ?  - 0      %f6q'(?��  z�z�� !�'(p'(_;  �' (- 0    �9>  ( 7 (F; W 7 {F;  *-
{ 0     y6 7! {(- 0     
6? !-
{- 0   y6 7!{(- 0    
6q'(?�s  z�z�CM{�{� j�F;  \!j�(-
 {;0    6�6  !�'(p'(_;  .'(-0    �9; -4      6q'(?��?  X! j�(-
 {k0    6�6  !�'(p' ( _;  . '(-0    �9; -4      6 q' (?��  {�{�CM{�{� {�F;  \!{�(-
 {�0    6�6  !�'(p' ( _;  . '(-0    �9; -4      �6 q' (?��?  X! {�(-
 {�0    6�6  !�'(p' ( _;  . '(-0    �9; -4      �6 q' (?��  ||CM|| {�F;  \!{�(-
 {�0    6�6  !�'(p' ( _;  . '(-0    �9; -4      �6 q' (?��?  X! {�(-
 |0    6�6  !�'(p' ( _;  . '(-0    �9; -4      �6 q' (?��  ||�>f !�'(p'(_;  h'(-0      &�' (--0      &�0   �6- 0    686- 0   6_6-
 |W0     y6q'(?��  ||CM !�'(p'(_;  .' (- 0    �9; - 0      ;�6q'(?��  ||�RT3�-
|z0    y6  !�'(p'(_;  �'(-0    �9; }-KK.    |�'(-KK.     |�'(-' (    �  NNN[7!6�(�[7!|�(-7 6�0     6�6-7 |�0   G�6-
 |�0     6�6q'(?�[  }	}�*�*� *EF;  �!*E(  *MF;  !*M(X
 *zV-
|�.     y6; � *E;  � !�'(p'(_;  r'(-0    &�'(
*�G; %--.     *�0     *�6-0   *�6-0     +' ( 
*�G; - 0    *�6q'(?��?  ?  	   =L��+?�Y?  ! *E(-
 }.     y6 }/}5� #4!P�(  !�'(p'(_;  4' (- 0      �9; -  P� 0     6�6q'(?��-
};0    y6 ?�}b P P P['(  P�P�}m}u}{|�}�}�}�}�}�}��
 }fW'(
 @�'('
(--
 Tt z_0     '�
 '�.     '�'	(-
 =|	0   '�6- � �.   |�'(- h.     }�'(- �.     }� �N'(-.      }�P'(-.    }�P'(-[.   >&'(--X p.     |�.   }R'(-ZO[
 Tt z_	0     _�6-
	4      }�6  !�'(p'(_;  �' ( 3�;  J G= 
 3� 7 3�
3� 3�G;  '- .    %O;  - 7  #4	7 #4.   @6? 1 G; )- .      %O;  - 7  #4	7 #4.   @6	  >���+q'(?�[? �I  }�~CM}�~ }�F;  X!}�(-
 }�0    6�6-4      }�6  !�'(p' ( _;   '(-4    ~6 q' (?��?  D! }�(-
 ~0    6�6  !�'(p' ( _;   '(X
~AV q' (?��  -
 �W
 ~AW-0     )u=   ~J_9;  E' ( 
H; 2!~J(--0     K� �[N0    K�6	  =L��+' A? ��! ~J(	=L��+?��  CM
 �W
 ~AW
 �U$ %- 4   ~Y6?��  &
6U% &  ~fF; &-
~v
 ~k.   $a6!~f(-
 ~z.     y6? %-
~�
 ~k.     $a6! ~f(-
 ~�.   y6 &  ~fF;  *!~f(-
 ~�0      6�6-
 ~�
 ~k.   $a6? %! ~f(-
 ~�0    6�6-
 ~�
 ~k.   $a6 &  ~�F;  &!~�(-
 ~�
 ~�.   $a6-
 ~�.   y6? ] ~�F; &!~�(-
 

 ~�.   $a6-
 .   y6? - ~�F; #! ~�(-
 &
 ~�.   $a6-
 *.   y6 &  DF;  &-4     D6! D(-
 O0      y6? X
^V! D(-
 k0      y6 {��
 �W
 ^W !�'(p'(_;  ' (- 0    �6q'(?��	   =L��+?��  &  �F;  z-
�
 �.   $a6-
 �
 �.   $a6-
 �
 �.   $a6-
 �
 �.   $a6-
 �
 �.   $a6-
 �
 �.   $a6-
 �0      6�6! �(? w-
W�
 �.     $a6-
 W�
 �.   $a6-
 W�
 �.   $a6-
 W�
 �.   $a6-
 W�
 �.   $a6-
 W�
 �.   $a6-
 �90      6�6!�( -' ( I; -
�I N.      y6+' B?��-4     L�6 &-.    �]6 &
�W
 �W �iF;  0!�i(-
��.     �p6-4      ��6-
 ��.   y6? �! �i(
\Ch
��G; -K
��.     �p6
\Ch
��G; -�
��.   �p6
\Ch
\NG; -
��.   �p6
\Ch
��G; -K
��.   �p6-4      ��6-
 ��.   y6 &
�W � F; &-
�
 �.   $a6!� (-
 �.     y6? %-
�,
 �.     $a6! � (-
 �..   y6 &  �DF;  &-
�H.   y6-
 �a
 �Y.   $a6! �D(? #-
�d.     y6-
 �v
 �Y.   $a6!�D( &  �zF; (-
��
 �.     $a6!�z(-
 ��.     y6? %-
��
 �.     $a6! �z(-
 ��.   y6 &  ��F;  &-
�H.   y6-
 P 
 �Y.   $a6! ��(? #-
�d.     y6-
 �v
 �Y.   $a6!��( &  ��F; $-
��.   ��6!��(-
 ��.     y6? !-
 ��.   ��6! ��(-
 � .   y6 K�F	"�-+X
 }fV
'(' ( NH; (+ K;  !z(-0     (�6? ' A?��  �
 $W
 �W-  #4
[N
'�.     '�' (-
 <p 0   '�6- 4    \26- 4    $6	  =���+-	 =��� #4
�[N 0    (I6  (! 7!(!(?��  K�P�?�A�A�
 $W
 �W
 ;�'(
&�U%-0    &�c'(   @P  @P   @P['(
'--
 C�0    '�N-
 C�0    '�.     &�' (- 7 #4.     @6?�}  K�
 $U%- 0     (�6 &  �F; "-4     �6!�(-
 �*0    y6? X
�9V!�(-
 �C0      y6 RT3�K�
 �W
 �9W-� �.     |�'(- � �.     |�'(- � L.     |�'(-[
'�.   '�' (-
 BW 0   '�6- 0     �S6- 4     �a6	  =�Q�+?��	   =L��+ &	@�  +-0      (�6 P��������҂�CM �pF;D-
�~.     y6!�p(!z('(- �:�[
'�.   '�'(- � � :�[
'�.     '�'(- � � :�[
'�.     '�'(-
 PG0   '�6-
 =d0     '�6-
 =d0     '�6�[7!(!(�[7!(!(�[7!(!(-
 ��0     ��6-( �:�[0      (I6-( � � :�[0      (I6-( � � :�[0      (I67! Q�(7! Q�(7! Q�(7! (
(7! (
(7! (
(-
 ��4     ��6-
 ��4     ��6-
 ��4     ��6  !�'(p'(_;  �' ( 3�;  F G= 
 3� 7 3�
3� 3�G;  #- .    %O;  -  4    ��6? - G; %- .      %O;  -  4    ��6	  >���+q'(?�c?  -
��0    y6 K�F	�+-0     (�6! �p(! z(X V  ������P��P�
 ��W
@�' (; �-7  #47 #4 .   @6	  >�(�+-7 #47 #4 .   @6	  >�(�+-7 #47 #4 .   @6	  >�(�+-7 #47 #4 .   @6	  >�(�+-7 #47 #4 .   @6	  >�(�+-7 #47 #4 .   @6	  @�+?�7  -� 
 �W
 �W
 �W �F;�! �('(H; �-^  #4[N
 �9
 �3
 <�.   �&' (-
 �X 0   �J6- 0   �n6-
 �� 0   ��6- 0    ��6 7!Q�(  3� 7!3�(  3� 7!��(
�� 7!3�(- 3� 0   ��6-4^`  7  3� 0   ��6- 7 3� 0   �6 7!�*(- 0     �56c 7! �I(c 7! �W(- 0   �d6-^` .    �t6- .    �6- 4     ��6- 4     ��6- 4     ��6-
 �� 4     ��6- 4     ��6- 4     � 6- 4     �6- 4     � 6- 4     �86- 4     �N6-
 �� 0    ��6- 7 Q� 4   ��6- 4    ��6'A? �?x+! �(? -
��0      y6 &
�W
 $U%-0    ,x6!��(!��(!�(!�(!%�(!�%(!�7(!�J(!{�(!�U(!�k(!��(- ��0   (�6- ��0   (�6X
 ��V! ��(?�~  &
\Ch
��F; D ��;  ,-4   ��6-�%4      �6-
 �>0      6�6? -
�P0    6�6? -
�m0    6�6 &
\Ch
��F; N ��9; 6-  ��4     ��6-��4      �6-
 ��0      6�6? -
��0    6�6? -
�m0    6�6 &  ��F>  ��;  "-4     ��6!��(-
 �0    y6? -X
�V-
v�0      �6! ��(-
 �$0      y6 &
�W
 �W
 $W-'
 v�0    686-
 v�0      6_6-
 v�0      *�6  �>N! �>(  �>F; 	
 ;r!�G(
&�U%-0      &�
 v�F; !--0     &�-0   &� �G.     @6?��  &- �W.     s!�W(  �^F; � �mF>  �W;  s-4     �s6!�m(!�^(-4      *l6-4      L06-
 �~0      6�6-4      ��6-0      F�6-0      F�6
$U%-4    ��6? -
��0    y6 ����� !�'(p'(_;  N' (- 4    ��6X
 �� VX
 �V! �(- 4   �!6X
 �/ VX
 I$ Vq'(?��-
�>0    6�6 &  �WF;  /-^ ^*�	?�  
 %�
 �>0    5!�e(! �W(-	   ?    �e0     O{6+-	 ?    �e0     O{6 &
�/U%-0      %f6 &
6U%-4      �z6 &-4    ��6 ����CM ��F;  P!��(-4    ��6  !�'(p'(_;  &' (- 4    ��6X
 �� Vq'(?��?  -
��0    6�6 &
�W
 ��W
 �W-4   �z6
��U%-4    �6-4      �6-4      A6-
 CO0      (p6+? ��  &
�W
 ��W
 6U%X
 �V-4   �6+? ��  �,-.      (�' (
�@ 7!�6(
�q 7!�f(	>���	   ?��	   >���[ 7! \(
 7! ��(
%� 7!C(- 4    ��6+-4   ��6 �,-.      (�' (
�� 7!�6(
�� 7!�f(	>���	   ?��	   >���[ 7! \(
 7! ��(
%� 7!C(- 4    ��6+-4   �6 CM
 �W
 �W
 �U$ %- 4   �m6?��  &-0    ;�6  ��F;  .-
w�0      &6-4      w6X
 *zV!��(?Q ��F; ,-+
  
 �0    &6-4      �6! ��(? ��F; -4     �s6! ��(? � ��F; >-&
  
 �0      &6-4      �46-
 �?0      y6! ��(? � ��F; *-4     ��6-,
v�0    &6! ��(?  ��F; F-4     �a6	  =���+-0      #�6-
 
 ;�.   &6-4      	�6! ��(? / ��F; %-
�r0      6�6-
 ?|0    &6!��( &
6U%-4    ��6 &-4    ��6+-4   �6 �݋�CM ��F;  P!��(-4    ��6  !�'(p'(_;  &' (- 4    ��6X
 �� Vq'(?��?  -
��0    6�6 &
�W
 ��W
 �W-4   ��6
��U%-4    ��6-4      �6-
 CO0      (p6+-4   �6?��  &
�W
 ��W
 6U%X
 �V-4   ��6-4      �6?��  �,-.      (�' (
� 7!�6(
�+ 7!�f(	>���	   ?��	   >���[ 7! \(
 7! ��(
%� 7!C(- 4    ��6+-4   �L6 �,-.      (�' (
�Y 7!�6(
�� 7!�f(	>���	   ?��	   >���[ 7! \(
 7! ��(
%� 7!C(- 4    ��6+-4   �6 CM
 �W
 �W
 �U$ %- 4   ��6?��  &-0    ;�6  �|F;  -
w�0      &6! �|(?  �|F; -
w�0    &6!�|( &
6U%-4    ��6 &-4    ��6 �Ќ�CM ��F;  P!��(-4    ��6  !�'(p'(_;  &' (- 4    ��6X
 �� Vq'(?��?  -
��0    6�6 &
�W
 ��W
 �W-4   ��6
��U%-4    ��6-4      A6-
 CO0      (p6+-4   ��6?��  &
�W
 ��W
 6U%X
 �V-4   ��6	  >L��+?��  �,-.      (�' (
� 7!�6(
�1 7!�f(	>���	   ?��	   >���[ 7! \(
 7! ��(
%� 7!C(- 4    ��6+-4   �G6 �,-.      (�' (
�T 7!�6(
�m 7!�f(	>���	   ?��	   >���[ 7! \( 7! ��(
%� 7!C(- 4    ��6+-4   ��6 CM
 �W
 �W
 �U$ %- 4   ��6?��  &-0    ;�6  ��F;  $-4   I6-
 w10    &6! ��(? + ��F; !-4     I6-
 w10    &6!��( CM
 �W
 �W
 �U$ %- 4     ��6?��  &
6U%-4      ��6-4      ��6-4      ��6 &-4    ��6 ���CM �F;  h!�(-4    ��6  !�'(p'(_;  >' (- 4    ��6- 4     ��6- 4     ��6X
 �� Vq'(?��?  -
��0    6�6 &-^ ^*�	   ?�  
 %�
 �0    5!�(-	   >L�� �0     O{6+-	 >L�� �0     O{6	  >L��+- �0   #�6 &
�W
 ��W
 �W-4   ��6
��U%-4    �36-4      �=6-4      �H6-4      �U6+-4   �b6?��  &
��U%-4      �m6-4      �u6-4      ��6-4      ��6 &
�W
 ��W
 6U%X
 �V-4   �36-4      �=6-4      �H6-4      �U6+-4   �b6?��  &
6U%-4      �m6-4      �u6-4      ��6-4      ��6 &-0    ;�6  ��F;  �-
;�0      686-
 ;�0      6_6-
 ;�0      *�6-
 v�0    686-
v�0      ��6-
v�0      *�6-
 w�0    686-
 ?|0    686-
 ?<0    686! ��(? � ��F; �-
;�0    686-
 ;�0      6_6-
 ;�0      *�6-
 w10    686-
w10      ��6-
w10      *�6-
 w�0    686-
 ?|0    686-
 ?<0    686!��( &-0      ,�6-
 ,�0      ,�6-
 ,�0      ,�6-
 ,�0      ,�6-
 -0      ,�6-
 -,0      ,�6-
 -C0      ,�6-
 -_0      ,�6-
 -r0      ,�6-
 -�0      ,�6-
 -�0      ,�6-
 -�0      ,�6-
 -�0      ,�6-
 -�0      ,�6-
 .0      ,�6-
 .0      ,�6-
 ./0      ,�6-
 .J0      ,�6-
 .d0      ,�6-
 .y0      ,�6-
 .�0      ,�6-
 .�0      ,�6-
 .�0      ,�6-
 .�0      ,�6-
 /0      ,�6-
 /0      ,�6-
 /D0      ,�6-
 /_0      ,�6-
 /u0      ,�6-
 00      ,�6-
 0/0      ,�6-
 0E0      ,�6-
 0X0      ,�6-
 0�0      ,�6-
 1	0      ,�6-
 1=0      ,�6-
 1S0      ,�6-
 1~0      ,�6-
 1�0      ,�6-
 1�0      ,�6-
 1�0      ,�6-
 20      ,�6-
 2,0      ,�6-
 2B0      ,�6-
 2Y0      ,�6 &-0      7�6-
7�0      7�6 �,-.      (�' (
�� 7!�6(
�� 7!�f(	>���	   ?��	   >���[ 7! \( 7! ��(
%� 7!C(- 4    ��6+-4   �6 �,-.      (�' (
� 7!�6(	  >���	   ?��	   >���[ 7! \( 7! ��(
%� 7!C(- 4    ��6+-4   �b6 &  �?F;  G-^"^*� 
 %�
 �W0    5!�N(-	   >��� �N0     O{6! �?( �c�i�����
 �W
 ��W-0     )=  -0   �<=   �XF;  � !�'(p'(_;  '(-4    �o6q'(?��-4   �6-	 >���	   ?3330    ��6+ !�'(p' ( _;    '(-4      ��6 q' (?��-
~�.   $a6-	 ?   0   ��6! �X(-
 ��0      y6-4      ��6<+ �XF; -
��0      y6X
 �V! �X(	=L��+?��  &
�W
 ��W
 �W-0   )=  -0   �<;  -
�0    y6	  =L��+?��  &
�W
 ��W-0     )=  -0   T;  �-
;�0    *�6-
v�0      ��6-
v�0      *�6-
 ;�0      *�6-
w10      ��6-
w10      *�6-
 w�0      *�6-
;�0      ��6-
;�0      *�6-
 vj0      *�6-
;�0      ��6-
;�0      *�6-
 �+0      y6	  =L��+?�  &
�W
 ��W-0     ).=  -0   T=   �=F;  ^-
�K0      y6-0    4t6
+-
�b0    y6-0    4t6+-
�{0    y6! �=(-4      ��6X+ �=F; -
��0      y6X
 ��V! �=(	=L��+?�N  &
�W
 ��W
 ��W-0   ).=  -0   T;  -
�0    y6	  =L��+?��  &
�W
 ��W-0     ).=  -0   �<=   ��F;  2-4     
�6+-
��0    y6! ��(-4      �6�+ ��F; -
�0      y6X
 �5V! ��(	=L��+?�z  &
�W
 ��W
 �5W-0   ).=  -0   �<;  -
�0    y6	  =L��+?��  ���������
 �W
 �LW-
�X0      y6-0      );  t !�'(p' ( _;    '(-4      �o6 q' (?��-4   �6-	 >���	   ?3330    ��6-0    7�6-
7�0      7�6? a !�'(p' ( _;    '(-4      ��6 q' (?��-0      7�6-
 ~�.     $a6-	 ?   0   ��6	  <#�
+?�  ��' ( 	  >���I; $- 
~�.   $a6	  :�o+ 	?   O' (? ��  &  ��F;  3-^^*��	   ?�  
 %�
 ��0    5!��(! ��(-	   >��� ��0     O{6 &-	  >��� ��0     O{6 &
�W
 ��W
 $W-
y0    686-
 y0      6_6-
 y0      *�6
&�U%-0    &�
 yF; !--0     &�-0   &�
 ��.     @6?��  &
$W-0   T@;  � �m_; !�m(  �^_; !�^(  *MF; X
*zV-0   y6-
 ��0      y6! 	y(-0      y�6-
 y0      �6X
 ��V	   =L��+? 	   =L��+?�h  &  �^9; t �m_; !�m(  �^_; !�^(  *MF; X
*zV-0   y6-
 ��0      y6! 	y(-0      y�6-
 y0      �6X
 ��V  �0�7
 �W
 �W
 $W-+
 wf0      686-
 wf0      6_6-
 wf0      *�6
�#U$$ % 
wfF; %-0   F�6-0    +{6
$U%-0   F�6	  =L��+?��  &- �@.     s!�@(--
�c
 �H �@.   G0    y6  �}F>  �@;  -4   �6!�}(? X
�V-
wf0    �6! �}( &  �JF;  >-&
  
 �0      &6-4      �46-
 �?0      y6! �J(? /X
��VX
��V-
�0    �6-
 ��0      y6!�J( &
�W
 ��W-4   ��6
&�U%-0    &�
 �F; 	-4   ��6?��  ���X'��c(-
��.     '2'(-
 �..     '2'(-
 '�0    '�'(-0    &�'(-
 '�.   '�'(-
 '�0   '�67! (
(
'-7  #4.   &�' ( 7 #4Oe7!(!(-	 :�o 7 #4Oe0     ((6-	 >��� 0     (I6- 4      �s6	  >��+X
 ��V-7  #4.   (i6-7 #4.   (i6-
 ��0     (p6- ,7 #4.     (�6-  7 #40   (�6-0     (�6 (�'�����
 �W
 ��W
 ��W-
��.   '2'(-7 #4Oe7 #4.   C�' (- .   C�6	  :o+- 0     (�6?��
 ��U%- 0   (�6X
 ��V? ��  &
$U%X
 ��VX
��V! �J( &  ��F;  >!��(-
 ��0      6�6-
 �0      y6-.   �a6-0      #h6? %! ��(-
 �30    6�6X
 �NV-0   #�6 �0�7
 �W
 �NW-0   #h6-
 
 ;�.   &6
�#U$$ % 
;�F; -0     +{6
$U%-0   F�6	  =L��+?��  &  {�F;  >-+
  
 �0      &6-4      �6-
 �^0      y6! {�(? /X
�tVX
��V-
�0    �6-
 ��0      y6!{�( &
�W
 �tW-4   ��6
&�U%-0    &�
 �F> -0   &�
 ��F; 	-4   ��6?��  �ѕߔX'���(-
'9.     '2'(-
 'u.     '2'(-
 '�0    '�'(-0    &�'(-
 '�.   '�'(-
 '�0   '�67! (
(
'-7  #4.   &�' ( 7 #4Oe7!(!(-	 :�o 7 #4Oe0     ((6-	 ?�� 0     (I6- 4      ��6	  ?V+X
 ��V-7  #4.   (i6-7 #4.   (i6-
 ��0     (p6- ,7 #4.     (�6-���7  #40   (�6-0     (�6 (�'���L
 �W
 �	W
 �tW-
�).   '2'(-7 #4Oe7 #4.   C�' (- .   C�6	  :o+- 0     (�6?��
 ��U%-0    (�6X
 �	V? ��  &
$U%X
 �tVX
��V! {�( 
�if�A�AȖ����������
 �W
 $W-
��.     '2!�X('	(-
w�0    686-
 w�0      6_6-
w�0      ��6-
 w�0    *�6-
 �p0      6�6'(I; �
 &�U%-0      &�
 w�F;�-
A�0    '�'( B@-0   &�c`'(
'-.      &�'(--
 '�0      '� �X.     (i'(d[7!(!(-.   C�6-d��.     (�6- X #4	 ?fff	   ?fff.     (�6- #4
 y�.   y�6  !�'(p'(_;  J'(7 3� 3�G; )-7  #4 #4.     3� XH; -4      ��6q'(?��-
w�0    6_6	  ?L��+	  ?   +O' (-
 �� 
 ��NN0      6�6-
w�0      ��6-
 w�0    *�6-
 w�0      6_6? 'A'B? �T-
w�0      �6+X
��V  A�
 �W' ( I; *--0    K����[N0    K�6	  =���+' B? ��-0    K�6+  I#�  �)b  ����  ��g  y�s�  ��  ��x  ��5
 F�p�  �.� ���  ��� 98I�  ��� �ZW  �R7 �o޽  �B  ��(�  �Ry �d  ��1 ��/  ��G �a  ��s ���  �
�  T{^�  �n!m  g�  ��!� 80�  ��� ]쾍  �:� \H�  ��"�  T$�8  �l  6ꂱ  �v#;  �:Pt  ��#U  �l��  �v#�  �-C�  �$W �޲9  ���  	�]  �"M 0�,�  �Ny  �Z��  ��"i ��  �2"5 ��	  ��" ��}�  �V%�  :+cn  �:%�  ]5u�  Æ#^ �J�  �2V  ]�  Ť&*  �  ��&� |�r}  �&� PGE  Ǣ(1 U��G  �"  щȫ  ˖� d�D  ̪)�  ��|�  ��`  [�w�  ͒	y Fu��  �	�  eU�]  �v*l  ��I  ��	�  1��  �N+Q  ���  �>	�   �p  ��	�  ���Z  ��	�  דC2  ��
	  ɼ��  �Z
&  P�h]  վ2�  ���  ��34  �!v  �
3M  �1��  ��3 ���  �23u LA�  پ
=  �`α  ��
X  ��$  �

p  �b�!  �^
�  -�a  ں4� ����  �b
�  �~�K  ۦ
�  b��s  �b
�  */ok  ܸ
�  b)�  �7j o k  �z  K��  ݾ  -6"A  �  [�  �F8" �c�  �j8u V�  ޺&  ��C�  ��6  'R�  ��M  ��  ��e  i���  �|  X4#]  �&�  ��1�  �>�  -:T7  �R�  |G`  �f�  �曹  �~�  �ֶ�  ߖ  ^��  ߪ  �y?  ߾4  �)E  ��H  ;��
  ��Z  ���  ��m  �-��  ��  ?v�  �*�  F��s  �>�  1�x  �z:6  3M&c  �*� Ꮌ�  �j�  �#�  �z�  ���  ��  �9�  �  LQ��  ��  ��x�  ��&  t!A  ��8  6�%�  �
J  \�9�  �"^  ט=�  �:q  �(a�  �R�  b<�  �j�  6wQ  ��  EY�  �& �9��  ��  �>��  �:<9 Vty8  �^�  �a]m  �r�  #@;�  �W  W�9  �  �Q�  �*  o� F  ���  fw�  ���  0W�P  ���  Bp�J  ��k  ��%�  �I  s!�L  �&:  W�ݶ  �:�  r�N  �N�  ���  �b  ���  ��=�  ��>  �.>Z ;W�a  �V#  �t�  �j8  �+ە  �~R  M�0  �f  *)Ƀ  �u  ��  ��  ۣ  ��  ��{  ���  fn��  ���  ���  �
�  _5�  ��  ��  �2�  Q�:  �F?� �q  �l&�  :�x  ��  �_g�  �?�  k��  �R@4 �A�  �z�  �g4b  �   E}��  �  F2�<  �8  �YW  ��u  z8'�  ���  xPQ�  ���  g�܊  ��  � �_  ��  $�h  �.�  I���  �BQ  S�h!  �V=  �Ƨ�  ��AO  U�)`  �RA� 7�L�  �zd  V��S  ��  �>�  ��  Hs��  ��  e�58  ���  ���  ���  j�K  ��	  �0l�  �  cp�  �!   ��  �./  G��u  �B<  �u�\  �VI  �~��  �j  ��F  ��B�  _8�M  ��)  q�  �4C�  ?w��  ��K  S���  �0D0  jcU�  ��D�  `���  �^�  >K,q  ��D�  �6H�  �Rf  �N\  �EY  +�s�  ��e  �oI  �vE�  ,�'U  �E� Wӿ�  ���  �ϊ�  ��}  q��  ���  ah�  �b�  pS��  ��G  �eT�  �FGv �C�  �zGh  B���  ���  ٺ��  �G�  ��[�  �Z  �|�M  ��Hi  �]�"  ��  %�y�  �NH�  ���  ��1  C�?W  �A  q  �6c  u�  ��I  U�B�  �#~  ��n  �#�  �2LV  �6IL  �۩�  �I~  ��u�  ��I0  [L�  �"O  |�pf  ��K  3f�  �$ �S   �z  ~i� lL0  e}x� �L  �\�Y �  �� zL�  �� L� =pk 6L�  ��iG �L� �7<C �  m[X� bL�  �`pA ��  (S� NM�  �M� �M�  ��h1 	"M�  BZK] 
�M�  ���
 ��  ��F FN�  �8L �H�  ��� Z�  i�?� .O  ��� �O. ~��� �OD DF� `O{ 5Q� z5
 y�� O� �*=� BO�  o�{U �+  .(6^ �T  *]% �{  j[E� 
�  N��0 "2  �R+� rP� �0�� �  ���@ �Q	  퍊� bQ�  �k?� fR�  N�ٗ �Sg  ���� Rb  ��3� RRp  �C� JT�  ��� �T�  �5� .T�  m�� �V	 E  S�  ZZ. !6S�  ��� !�R|  ���0 "�R�  y-� #j�  -�2� $bXs )�β $�X� !�H� %.X� ��f� %jX� J�}< %�Xe ��Ǫ %�X�  �*�� %�Y: ��NE &  �(�G '&Y O�� '�E  c�!Q (<['  �u�� )$  ���� )��  ���j *6[�  ��
% -��  �t˾ -�\s  5@� 1 �  �z� 1n\�  J�� 2�].  �<Y� 3]R  e��� 4�  �䑞 4^]�  {�� 7�<  �2>g 8]�   �� 9n F  q��� 9��  ���� :b�  d%� :�  �!O ;:=  ��� ;�_K  4��� <_7	 �m <�_| z�il <�_ kh� ='  պj >�R  ^C6 ?^t  "_r� Hpgt  ��m Lg�  =/�� L"�  �[p0 L�gC  ��� N*g^  ���9 N��  X�5 N�,Y  �5�2 QBia  r=�m Q�i| t�v$ Q�i� "� R  ױ"� Rbi�  ���� S�\<  �g� S�^  �/�� T2j  �Oh� UB�  ՓNK U�jw  �EO V�!A   S�| W�!_  A��� Xz!  �z�� YR!(  X� Z*" *b�* Zz\  �9� Z��  !&�' [s� �': ^*s�  ��p ajx  �&� b�L0  q}Hp b��  �)1 d�x�  ~�"� fzyV  �>� hx�  ��] h�x�  ��> if�  ���� j�  �8T� j��  ��U� k&�  ��� k� �  ӭ� l� �  ZI� mb �  N�� n. �  ]�a� n�   ��'� o e  ��r{ o��  � p� (  &w2� q>}R ���4 qdzh  c�9� s2�  �WwA s�~  d� t^}�  �\�, t�~Y  5�\I t��  �� t��  3�t uB+  ��� u�G  Ǎ � v"D  ,�� vv�  ���A wt�  `�8 w��  �)�C w��  yD^� x~h  �u=� x�  M7D� y0�  �yZ� y��  ��� y��  cB	� z2}� 6�� z��  H��% {
\2 3f� {�$ $��} {��  "Ƅ |�  CM�5 |��a  �!�P |�  G�� 2�� 2�! `�� ��K2 �F�  _�� �R"  ��&� ��^  ��� �:F  �e�� ���  ��^� ���  ��� ���  ��c �b�  ӝ�� �ڈ�  �c_ �F�!  ]�� �Z�m  �l� �n�  �.�� �z��  6�� �ꉿ  9�Y �F�z  �a�� �r�  �-KO �⊯  �� �R��  ԙg� �z�  Yf�� ���  [�p �"a  3c�� �:��  �
"J ����  q��� ���  g� �6�  @�� ���L  �=� ���  �s�
 �>��  ��N ����  ��ݾ ��>  (�" ����  �׏o ���  J)� �v��  ޔ ����  j��� ��G  0��% ����  w�0 ����  �1> ���  -U�� �>��  _�ҋ �j  �#�� �v��  ��s ����  qд �n��  W{� �΍�  禮 ���  BՎ� �^��  9й� ���3  ��- ��=  Dɖ� ���H  :��� �֎b  �:_ �F�  v^�� ���U  ���* ��m  "\E �>��  K��T ���u  �U ����  F4�� �B��  m(� ����  } �� ��  ��L� �^�D  �0� �v�  �Q�� ���o  �j8� �
��  ��l� �"�s  v�� ����  �u �>��  C�i� ���  �� �R2  ��� ���  ��k� �<�4  d�� �v��  ���� �Ҕs ��A� �V��  �E+� �r  S�d� ��a  �=C� �J�  �̟� �ċ  w�6 ���  ��*/ �f�� ��� �ꕥ  ��{� �w  ?�b �X��  g >    �:� >   �J  �� ': Z�� >   �k_ >   ��� >     ��  ��  �g  ��  �  ��  �9  �� 7� 8� 9� W! W} W� XU X� Y- Y� Z Z1 jm j� kM l lq l� m= m� n	 n� o= q� >    �
 >   �6  �� k� k�" >    �E` >    �� >    ��l >    ��y > �  ��  ��  ��  �
  �8  �E  ��  ��  �  �)  �j  �x  ��  ��  �  �.  �N  �c  œ  ̟  ��  �-  �U  �m  �%  ϧ  Ϸ  �a  ��  ��  �  �7  Շ  ի  �  �1  �w  ڡ  �q  �  ��  �D  �  �h  �  �h  �  ��  ��  ��  �  �  �w  �  �!  ��  �  ��  �  ��  ��  ��  �  ��  ��  �I  �s % ) 7 W  E  ; . ? � �  � #y #� '� '� '� (% (� (� )� * *+ -� -� 1C 1c 2� 2� 43 4S 7� 7� 8 :? :� ; ;a <� =9 ? ?U N� O O O# P/ Pg P� R7 RW T T' Ug U� Z_ Zq Z� d d� d� f; g� j	 jE kx k� n� o q5 u� v {� | ) �G �� �� �Y �G �� � �m �k �� �� �� � �q �� �� �I �{ �� �� �y �� �+ �� � ��� >    ��� >   �	  �O  �u� >   �5  ��  �  �Y � �	 > 
  �R  �:  �(  �  �  �~  ��  �V  �� � > %  �b  ��  �J  �
  �  �!  �  ��  �d  ��  ��  ��  ��  �  �.  �F  �^  �v  ��  ��  ��  ��  ��  �  �  �6  �N  �f  �~  ��  ��  ��  ��  ��  � � �� >   �D  �<� >   ��� >   ��  ؂  غ  يW >   ��y >   ��  �  ��  ��  � � >   ��  ��  �   �+  ��  �  �D  ̑ >   �j  ��� >   �  �O  ��  �g  �/  ��  ��  �O  ��  �  ��  �G  ��  �_  �  ��  �o  ��  �g  ��  �w  �g  �_  �7  �^� >    �*  �J  �j  ��  ��  ��  ��  �
  �*  �J  �j  ��  ��  ��  ��  �
  �*  ��  �r  �Z  ��  �"  �:  �� >   �9  �Y  �y  ��  ��  ��  ��  �  �9  �Y  �y  ��  ��  ��  ��  �  �9  ��  ��  �i  ��  �1  �I  �1  �h  ��  ��  ��  ��	y >    �Z� > �  �i  ��  ��  ��  ��  ��  ��  �  �)  �A  �Y  �q  ��  ��  ��  �	  �!  �9  �Q  ��  ��  ��  ��  ��  ��  �  �)  �A  �Y  �q  ��  ��  ��  ��  ��  �  �  �I  �  �1  �I  �a  �y  ��  ��  ��  ��  ��  �	  �!  �9  �i  ��  ��  ��  ��  ��  ��  �  �)  �A  �Y  �q  ��  ��  ��  ��  �  �  �1  �I  ��  ��  ��  ��  ��  �  �)  �A  �Y  �q  ��  ��  ��  �	  �!  �9  �Q  �i  ��  ��  ��  ��  ��  ��  �  �a  �y  ��  ��  ��  ��  ��  �	  �!  �9  �Q  �i  ��  ��  ��  ��  ��  �  �)  �A  �Y  �q  ��  ��  ��  ��  ��  �  �  �1  �I  �y  ��  ��  ��  ��  ��  �	  �9  �Q  �i  ��  ��  ��  ��  ��  �  �)  �A  �Y  ��  ��  ��  ��  ��  �  �  �1  �I  �a  �y  ��  ��  ��  ��  �	  �!  �9  �Q  ��  ��  ��  ��  ��  ��  �  �)  �A  �Y  �q  ��  ��  ��  ��  �  �  �1  �I  �a  ��  ��  ��  ��  ��  �	  �!  �9  �Q  ��  ��  ��  ��  ��  ��  �  �)  �y  ��  ��  ��  ��  ��  �	  �!	� >    �r	� >    ��	� >    ��	� >    ��	� >    ��
	 >    ��
& >    �
= >    �
X >    �2  �Z
p >    �J
� >    �b
� >    �z
� >    ��
� >    ��
� >    �� >    � >    �* >    �B& >    �r6 >    ��M >    ��e >    ��| >    ��� >    ��� >    �� >    �� >    �2� >    �J >    �b >    �z4 >    ��H >    ��Z >    ��m >    ��� >    ��� >    �
� >    �:� >    �V  �r  ��  ��  ��  ��  ��  �  �6  �R  ��  ��  ��  ��  �  �2  �N  �j  ��  ��  ��  ��� >   �e  ��  ��  ��  ��  ��  �  �)  �E  �a  ��  ��  ��  �	  �%  �A  �]  �y  ��  ��  ��  ��  �  �8  �X  �x  ��� >    �
  ��� >    �"� >    �: >    �R >    �j& >    ��8 >    ��J >    ��^ >    ��q >    ��� >    ��� >    �� >    �*� >    �r� >    ��� >    �� >    ��* >    ��: >    ��I >    �W >    �k >    �2� >    �J� >    �b� >    �z� >    ��� >    �� >    ��) >    ��K >    �
f >    �"� >    �:� >    ��� >    ��� >    ��  >    �� >    ��8 >    �Q >    �u >    �2� >    �J� >    �b� >    �z� >    �� >    ��# >    ��8 >    �R >    �*f >    �Bu >    �Z� >    �r� >    ��� >    ��� >    ��� >    ��� >    �� >    �= >    �Rd >    �j� >    ��� >    ��� >    ��� >    ��� >    ��	 >    �� >    �! >    �*/ >    �B< >    �ZI >    �re >    ��} >    ��� >    ��� >    ��� >    �� >    �� >    �2 >    �J >    �b1 >    �zA >    ��O >    ��c >    ��z >    ��� >    ��� >    �
� >    �"� >    �: >    �j+ >    ��T >    ��{ >    ��� >    ��� >    ��� >    �*  � >    �B$ >    �ZE >    �r^ >    ��� >    ��� >    ��� >    ��� >    � >    �2< >    �J\ >    �z� >    ��� >    ��� >    ��� >    ��� >    ��� >    �
 >    �"2 >    �:F >    �R^ >    �jw >    ��� >    ��� >    ��� >    ��� >    �� >    �2 >    �*V >    �By >    �r� >    ��� >    ��� >    ��� >    ��� >    �� >    �+ >    �G >    �2h >    �J� >    �b� >    �z� >    ��� >    ��� >    ��� >    �� >    �
> >    �"a >    �:� >    �R� >    ��� >    ��� >    �� >    ��' >    ��= >    ��R >    �t >    �*� >    �B� >    �r� >    ��� >    ��� >    ��  >    �� ( >    �� F >    � e >    � � >    �j � >    �� � >    �� � >    ��! >    ��!( >    ��!A >    ��!_ >    �!� >   �F7 >    �T  �x  ��  ��  ��" >    �" >    �$"5 >    �D"M >    �d"i >    ��"� >   ��  �   ��  �>  �  �  �  ��# >    �  �}# >   �:  ��#; >    �c#^ >   ��#h >    ��  ��  �� z  b� �� ��#~ >    �"� >    �_  ��  �t#� >    �y#� >    ��  ��  �  �� "K #; �� ��#� >    �2  ��  ��#� >    �L  �`  �t  ��  ��  ��  ô  �
  ��  ��  ��  �   �0  ��  �  �. t �  " � !� " "� "� �f� >   ��$, >    �$$' >   �,$a > *  �b  �r  ��  ��  ��  �� X x � � !� "� t� t� u u: u^ u� u� v� v� v� v� v� v� w w w& w6 wF wV x� x� x� y" yD yl y� y� �� �P ��� >    �%O >   ��  � � + *� +{ , ,� .w / /� 0G 1� 3I 5 5� 6G 6� 8a R� Ty U� r� r� ~� ~�%f >    �  ��  �� $; k �O5 > 
  ��  ��%� >    ��& >   �H �� �&* >    �S� >   Ń  �� a� a� f+ g� nr �� � �� �� � �� �C&� >    ſ  Δ  �� +� ,� -j /- 0] 1 2� 3� 5� 6� 7� 9H S� V� h; nW ng pA �w �i �Y �� �� ��&� >   ��&� >    ��  �	  �  �u  �  �: 4 M %� %� Q� �� ��&� >    ��  �v  ��  �
  ��  �  �
  �&  �y  �~  �  �  �� � � @ %� 9� ?� Oj O� O� Qr Q� hn i {1 ��&� >   �  Ʋ  �  �  �%  �;  �  �  �'  �  �� � � T %� 9� @ O� Q� h� i3 {� �� �� ��'2 >   �0  �@  ��  �T  �N  �8  �, � | h � 	@ 
�   h � b4 �� �� �� �  �0 �� �,'� > �  �Q  �2  �=  ��  �  �m  �k  ��  ��  ��  �9    ?  a � � � � �   3 K c { � � y � � � � �   7 O g  � � �  + C [ s � � � � � 	 	Q 	g 	 	� 	� 	� 	� 	� 
 
' 
? 
W 
o 
� 
� 
� 
�  / G _ w � � � � Y w � � � �  7 W w � � � � �  P + + +/ +� +� +� ,G ,U ,s ,� ,� - -; .� .� .� /W /e /� /� /� 0 0� 0� 0� 0� 1� 1� 2	 2P 2] 3� 3� 3� 5+ 59 5W 5� 5� 6 6o 6} 6� 7 7! 7? 7c 8� 8� 8� 9 9 9� 9� ?� Kl K� Oa O O� O� Qg R� R� R� SD SQ T� T� T� U U! V V" V- Vt V� he h� i q� {q {� �� �A �� ��&� >   �e'� > F  Ƃ  �6  �z � b � $� 'z )� : :� :� <� =V =� =� > >L >� @$ @v @� A Ax BF B� C C\ D Dn D� D� E< E� E� F F\ F� G H� H� I
 I& ID Id I� I� I� I� J J& JF Jf J� J� J� J� K K$ QT a� i� q� z� |n }
 }$ }@ �� �^'� > 2  ƒ  �D  �F  �� � r � '� )� :& :� :� <� =f =� =� > >^ >� @� @� AC A� Bs B� C' Cw D5 D� D� E EW E� E� F/ Fw H� H� Q� b dC i� q� z� |~ }R }` }p �� �n(( >   �� B �$ ��(1 >   ��  �(I > 
  � � N_ N� z� }� }� }� �8 ��(i > v  �:  �J  ��  ��  �  �%  �E  �e  ȅ  ȥ  ��  �S  �  �H  �<  �  �  �1  �E  �Y  �m  �  �  �  �  ��  ��  1  Q � � � � � �  & > V n � � � � � � � � �  * B Z r � � �   6 N f ~ � � � � � 	 	Z 	r 	� 	� 	� 	� 	� 
 
 
2 
J 
b 
z 
� 
� 
� 
 " : R j � � � � � i � � � � 	 ) I i � � � � ? Y �   bY �j �z � � � (p >   �]  ��  ��   � h� �3 �� �[ �� � (� > 
  �t  ��  �l  �,  x � h� �� �8 �L(� >   ǎ  � �� �R(� >     ǘ  о  ��  ��  �  h #J $/ %� %� )N = Lh L� L� P� b� fZ g� zp {� |� @ �� �� �� �, �B �\ �� ��(� >    �5  �B  �  �S Q� �w �� �; �� �� � �� �K%� >    �e� >    �o)
 >    �{ "� $) >    Ɋ s . 2< 4� 8� OK O� S0 U  V` � �R �� ��#U >    ɡ). >    ɸ  ��  � � K� MH M� �� �V �� �.� >   ��)? >    �  �{)Z >    �  �< � (� Ps1 >   �D  ʜ  ��)u >    �� s�� >   ˢ  ˵#^ >   ��  �	  �!m >    ��� >   ��)� >   ��)� >    �2)� >    �os >   ͞  �  �D  ��  �  �p  ��  ��  �   ��  ��  ��  �`  ��  ��  �(   j& �� �XG >   ͼ  �  ��  �*  �  ��  ��  �  ��  �  ��  �z  �
  ��  �B  " j> �r*l >    �7 ��*� >   ά  �� pX*� >   η  �� pd � �� �� �� �+ �[ �u �*� >   ��  ��  �� ds pr p� �C �� �w �� �� � �; �W �+ >    �� a� a� p|+G >    �8  �� � a� i�+L >    �F  �7 "3 ##'� >   �h+{ >   ϋ  ��+� >    ϗ  ۻ  ��  �+  O O? b+� >    ��  $" P� P�, >    �� � #� P� P�G >   �Z+Q >    �~,c >    Ф  �/ � � N� b� f g�,x >    Я  �. " # L[ M� �a,� >   ��  �,� >    �� ��,� > y  �  �  �#  �3  �C  �S  �c  �s  у  ѓ  ѣ  ѳ  ��  ��  ��  ��  �  �  �#  �3  �C  �S  �c  �s  ҃  ғ  ң  ҳ  ��  ��  ��  ��  �  �  �#  �3  �C  �S  �c  �s  Ӄ  ӓ  ӣ  ӳ  ��  ��  ��  ��  �  �  �#  �3  �C  �S  �c  �s  ԃ  ԓ  ԣ  Գ  ��  ��  �� c3 cC cS cc cs c� c� c� c� c� c� c� c� d �� � � �+ �; �K �[ �k �{ �� �� �� �� �� �� �� �� � � �+ �; �K �[ �k �{ �� �� �� �� �� �� �� �� � � �+ �; �K �[ �k �{ �� �� ��2� >   �!  �G2� >    �h32�   �w34 >    ՜3M >    ��3u >   ֙  כ  ��  ��  �  �e  ؛  �3 >   ־3� >   �D + +� ,\ -  .� /l /� 0� 5@ 5� 6� 7(3� >   �`  � z � � Kz K� M" M� M� ��3� >   ٘4 >   ��  �Q  �l  �  ��  "@ #04t >   �F  �T  �y  � �� ��4� >   ڇ  گ5K5)    �#5}5_    �/5� >   �A#U >   �Q5�5)    �p5�5�   ۏ6 >   ۱ s E68 >   ��  ަ  �  � � a n� �% �� �� � �% �5 �Y �� �� �� �� �� �E6_ >   ��  �E  ޱ  ��  �3  �g  ��  ��  �! � � o � dc n� �3 �� �g �G �� �S �� �'6� >   � � (� 9� M� O� o� q6� >    �# � �6� ^    �<  � � �6� > H  �Y  �  ܧ  ��  ��  �G  �o  �z  �1  �V  �  �  ��  ��  �  �  � �  � � y & ' ?� ?� M= O3 V� WU W� W� X- X� X� Y Yu Y� Y� ZP b� hQ k� lI l� m m� m� o� sU s� t� u) v� wc � �! �1 �w �� �� � �� �� �� �� � �� �� �� �� ��6� >   �r  ܗ7) >   ��  ��  �l  ��7� >   �$  �W  �8  �i  �b  �� d� e� g� �� �� �?7� >   �2  �G  �� d� �� ��7j >   ݙ  ݶ  ��  ��  �!  �>8]8<   �W8"8<   �a8" >   ތ8u >   ��  ��  ��  �  �  �3  �I  �]  �s  ߋ  ߡ  ߵ  ��  ��  ��  �	  �  �5:6 >    �e� >   ��:h >   ��  �Z  ��  �2  �  �
  �4  �P  �|  �� j;V �   �U& >   �  �  �  ��  ��  ��  �  �/  �G  �_  �w �� �} � �[ �� �� �;� >    �  �� n� �} �A �� ��<9 >   �i  �}  �  �  �  ��  ��  ��  �	  �  �1  �E  �Y >    �=� >    �>& >   �� r&>? >   �!>Z >   �a  �u  �  �  �  ��  ��  ��  �  �  �)  �=� >    ��?� >    ��&� >    �1 �� �| �� �M@ >   �D  �N $ � � � , d z -p 1 7� r� s {� � � � � � �2 �� ��@4 >   �  �  �  ��  ��  ��  ��  �  �%  �9  �Md >    �vAO >    �?� >   �A� >   �  �  �  ��  ��  ��  ��  �  �%  �9  �M  �aB� >    �(� >   �  �� � iP �,C� >    �C� >   �C� >   � %\ � �� �D0 >    �D� >    �sD� >    �EY >    �gE� >    �>E� >   �68 >   �#  �W  �FD >   �G  �{  ��F� >    ��  �� r � �" �> �6F� >   �U  �u  �  ��68 >   �� a� a� dS �9F� >    �� d' �+F� >    �� d3 �7F� > 	   ��  � � *s 2s 3� 9/ Sg V�G >    �pGh >    ��Gv >   �G� >   �e V (� -G 0� 2g 7o 9# S[ U+ V� o�G� >   ��G� >    �� "' #G� >    �H >   �DHi >    ��H >   ��  ��  ��  �� # ;H� >    �.H� >    ��I >    �K �� ��I0 >    ��IL >    �I~ >    �D	 >   �vK >    �fKO >   ��K� >    �  � � t$ �qK� >   � � t5 ��L >   IL0 >   � b� �L� >   FL� >  �L� >   �L� >  �L� >  � :R H HJ P� i�L� >   'M� >   �M� >   �M� >   �M� >   N� >   O� >   7 2O� >  � �   P� >   C+ >   �Q	 >   �O >   -Q� >  g #�Q� >  � �   p � $�Q� >  �   �  $�Q� >   ; "uRS >   �Rb >   Rp >   +R| >   7R� >   CR� >   O5 > 	
 � � � F � � � �� ��O{ >  �   � � ` � �$ �< �8 �P �� �  �+{ >  ? �- �$O. >  �S� >  � \ �S� >   j S� >   s �T@ >    d� ��OD >   � �  AT >   w (R P P; �� �� �bT� >   T� >   T� >   6U3U 	 �;V �  z Z�V	 >  �W� >   !�Sg >   " "�Xe >  #�Xs >  #�X� >  $X� >   $zX� >  $�X� >   $�U3U  %C� >  %?X� >  %QYX�  %sY: >  %�Y >  &, &< &L &\ &l &| &� &� &� &� &� &� &� &� ' ? ?$ ?4 ?DZ� >  'a 'n[' >   ([Z >   (h (z P PJ[� >   )�\< >   *a -� 4�\Q >  *� +R ,
 ,� .L .� /� 02 2 3� 4� 5z 62 6� 8� S T� V4\s >   -�\� >   1.]R >   2�]� >   4]� >   7�^� > 	 :2 :� ;
 =r =� =� >> >� >�^� >  :� >� Q _ >  ;*_ >  ;L_7 > 	 ;�_K >   ;�_W >  ;� <_| >  <|_� >  =� =� >0 >t >� r`_� >  A� C� G� G� bf� >  F�g >  F�gC >   G�g^ >   G�g� >  K� K� Mm N	g� >   K�� >   LhI >  MXhs >  N9 Nq,Y >   N�ia >   P" PZi| >  P� P� Q QIi� >  Q�i� >   R" F >   S�j >   S�jw >   UP� >   W/ W�� >   X Xc� >   X� Y;1 >   Y� Zl& >  ZAsr >  Z�s� > 5 Z� ^1 ^A ^Q ^a ^q ^� ^� ^� ^� ^� ^� ^� ^� _ _ _! _1 _A _Q _a _q _� _� _� _� _� _� _� _� ` ` `! `1 `A `Q `a `q `� `� `� `� `� `� `� `� a a a! a1 aA aQ aas� >   Z�s� > ( [ [) [; [Q [e [y [� [� [� [� [� [� \ \ \+ \? \S \g \{ \� \� \� \� \� \� ] ] ]1 ]C ]W ]k ] ]� ]� ]� ]� ]� ]� ^ ^!(� >  bzx >   b�x� >   cx� >   cx� >   c#yV >   d�y >   d� f� �� �zy� >   e f� � ��y� >  e e/ e? eO e_ eo e e� e� e� e� e� e� e� f� f� f� f� f� g g g/ g? gO g_ go g g�y� >  h� �^z'  i~y >  i� p p� t� t� uj u� u� w� w� xv x� x� x� y yX y� y� y� z z* |�zh >   i�	y >  j� j�6� >  j� >   l# l� >   l� mK� >   m� n|� >  oM o\ q� r8 |0 |D |X}� >  q� q�}� >  q�}� >  r}R >  rB}� >  ro}� >   s_~ >   s�~Y >   tzD >   u��5)   vUL� �   w��] >  w��p >  w� x x. xF x^����   w�߀�   xg�� >  y� z\2 >  z�$ >  z͂ >   {ԂS >   |��a >   |��� >  }��� >  ~D ~X ~l�� >  ~� �& >  ���J >  ���n >  ���� >  �� >  �̓� >  ����  ����  �.�5 >   �@�d >  �b�t >  �q� >  �}��E   ����E   ����E   ����E  ����E   ��� E   �ȅE   �ԅ E   ���8E   ��NE   �����`  �	��E  ���E  �%���   ����  �� �g�І�  �X�� >   �� �h�s >   �� � �� >   ��� >   �I�� >   ���! >   ���z >   �c ���� >   �q�� >   ���� >   ��� >   � �b� >   � �JA >   �# �K�� �  �� �= �� � � �q �1 ���� >   �ډm >   �nw >   ��& >  �� �+ �� �c� >   �� �o�4 >   �7 ��a >   ��	� >   �ˋ� >   � ���� >   �%� >   �2�� >   �U�� >   �}�� >   �� �� >   �� �'� >   �� ��L >   ���� >   �2�� >   �� �2�� >   ���� >   �Ɍ� >   ��� >   �A ���� >   �j �~�G >   ��� >   ���� >   �0�� >   �G ���� >   �S ���� >   �_�� >   �m�� >   ���� >   �č� >   �Ў3 >   �� �"�= >   �� �+�H >   �� �7�U >   �� �C�b >   �� �R ���m >   �� �g�u >   �� �s�� >   �� ��� >   �� ���� >  �� �� �� �� � �K �c �� >   �>�< >   �* �^ �� �:�o >   �] ��� >   �r �ʐ� >  �� �� �� �b�� >   �� �'�� >   ���� >   �
� >   ��� >   �ۓ >   ���� >   �J�� >   �j�s >  �GC� >  � ���a >   ���� >   �ҕ� >   ��� >  �ߖ� >   ��K� >  ��      w  �,  �2}  �.  �4�  �0  �6 %� <" <��   �D  �� '6 Z��   �H   ��s   ��m  ��  �z  ز�   ���  ��  ن�  ��  �  �   �$  �<�1  ��  �T  �D  �T  �r  �&  �  ��  �4  ��  ��  �  �~  ֒  �  �  �0  �V  ׀  �  �J  ��  ��  �D  �2 � $� 1v 3
 8" Hz L� Rj T: U� Z, j j� k, n4 o o� p� q~ v( �h � �d ��   �� tp �d �( �� �&�   ��  �Z  ��  �  ��  ���  ��  �
  �V  �b  �n  �z  ��  ��  �   �\  �z  ��  ��  �N  ��  �  ��  ��  �B  ˠ  ˲  ̎�   �  ��  �  ���  � �l   �$  ��  Ŧ  Ǫ  �$  ̲  �~  �d  ��  �  ��  ��  �F  �:  ��  ��  �  �|  ��  �$  ��  �V  ��  �8  �  �� � � h T � 	( 
� H   d 6 6  d & T L � B � !� "� (B *D -� 1z 3 4l 8& 9� :h :� =0 N� Rn S� T> U� ax h h� j s� td v, w� x� z� { | �T �T � �� �H �X �� � � �  �x �� � �p � � �@ �� �� �D �� � �l �$ �� �> �� �� �� �r � �^�   �*  ��  �0  �� ?� d� w� �N  �@  ��  ��  �.6   �N t� �\ �T � � �� �� �@ � �`E   �f  ��  �  �\  �,  �P  �PM	   �r  ��  �"  �r  ��  �d  �l  �\  �tS	   �~  ��  �0  �D  ��  �T  �  ��  ��W   ��  ��  �>  �D  �\  �$  ��  ��  ��  �t  ��  �<  �T  ���   ���  ��q  �  �  �~  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  �  �  �"  �0  �<  �L  �Z  �l  �~  ��  ��  ��  ��  ��  ��  ��  �   �  �.  �B  �n  ��  ��  ��  ��  ��  ��  �  �  �F  �Z  �n  ��  ��  ��  �   �Z  �~  È  Ô  ä  î  ��  ��  Ę  Ĭ  ��  ��  �  �"  �>  �P  �\  ɖ  ɬ  ��  ��  ��  ��  �&  �.  �P  �X  �d  �l  �v  �~  ʈ  ʐ  ʦ  ʮ  ʼ  ��  ��  ��  �  �  �  �  �(  �0  �:  �B  �N  �V  �`  �h  ˮ  ��  �8  �F  �R  �^  �h  ̊  �`  ��  ��  �� �  �  �   �  ���(  �$  �p  ��  ��  �  �<  �j  �"  �6  �J  �Z  ��  ��  ��  ��  ��  ��  ��  ��  �Z  �  �  ٬  ��  ��  �0  �f  �  ��  �  �>  �t  �  ��  � d v � � �   �2 ��  �>  �P  �`  �l  �x  ��  �V  ��   �H  �L ;   �\  �  �6  �V  �v  ��  ��  ��  ��  �  �6  �V  �v  ��  ��  ��  ��  �  �6  �H  �`  �(  ��  �H  ��  ��  �X  �  ��  �h  ��  �`  ��  �p  �`  �0  ��  ��  ��  ��  Ü  �B  ��  ��  ݲ  ��  �: ' =� =� >* >n >� �� �$ �� �� �  �\!  �|  �f,  ��  �p  �T>  ��  �> |C
  �� ~ �� �6 �� �� �� �j �* ��H  �� �R
  ��  ��  �2  ��  �` � � ?x o
 |T  ��  ��  �4  ��  �  �  �l  ��  �J  �  �"  �  �� � � o |V  ��  ��  �:  �`  ׶  ��  ٶ  ��  �F  �� � �\$  ��  ��  �l  ��  ��  ��  ��  ��  ��  �  �,  �>  �X  �p       ¸  ��  ��  �   �  �*  Ċ  ��  �n  �� � � �� �" �v �� �� �V � �~f  ��  ��  �~  �b  �� � �p  ��  �  �>  �t  �L � �u  ��  �@ �y   �&  ��  �0  �8�  �6�  �8�   �P�  �V�  �|�  ��    �   �   �*   �8   �F*   �NN  �V  �Fc   ���   ���   ���   ���   ��   �&  �V  �t-  �X  �  �p  Î  ��  �  �� '0 ) *: -� 4b <� ?p [ s� wv z: �H(  �`  �h  �  �F  �L  �f  ��  �  �n  �  �>  �V kZ k`/   ��5  ��  ��  ��:  ��@  ��X  ��f  ���   �$  �2     �(  �L  �f  �~  ��  ��  ��  ��  ��  �  �&  �>  �V  �n  ��  ��  ��  ���   �D  �R�   �H  �d  �~  ��  ��  ��  ��  ��  �  �&  �>  �V  �n  ��  ��  ��  ��  ��  ��  ��   �d  �h  �,  �F  �b  �~  ��  ��  ��  ��  �
  �&  �B  �^  �~  ���   �r�   ��  ���   ��  ��  �  �.  �F  �^  �v  ��  ��  ��  ��  ��  �  �  �6   ��   ��  �L  �f  �~  ��  ��  ��  ��  ��  �  �&  �>  �V  �n  ��  ��  ���   ��4   ��)   ��  ��  ��  ��  �  �.  �F  �f  �x  ��  ��  �.  �@   ��Q   ��I   ��  ��  ��  ��  ��  ��  �  �&  �>  �V  �n  ��  ��  ��  ��  ��  ��  �  �.  �F@   ��o   �g	   �  �\  �v  ��  ��  ��  ��  ��  �Z   ��   �$�   �(  �  �6  �N  �f  �~|   �2�   �D�
   �H  ��  ��  ��  ��  ��  �  �&  �>  �V�   �R�   �d�   �h  �l  ��  ��  ��  ��  ��  ��  �  �.  �F  �^  �v�   ��  ���
   ��  ��  ��  ��  ��  ��  �  �  �6  �N�   ��  ��	   ��  �d  �~  ��  ��  ��  ��  ��  �  �&  �>  �V  �n  ��  ��  ��  ��	   ��  ��	   ��  ��  ��  �  �.  �F  �^	)   ��  ��	4   ��  �t  ��  ��  ��  ��  ��  �  �  �6  �N	>   �  �	O   �  �d  �~  ��  ��  ��  ��  ��  �  �&  �F  �X	W   �$  �2	d
   �(  �4  �T  �z  ��  ��  ��  �.  �<  ��	p   �b	�   �z  ��	�   ��	�   ��	�   ��	�   ��	�   ��
   �

5   �"
K   �:  �b
g   �R
x   �j
�   ��
�   ��
�   ��  ��
�   ��  ��  ��  �  �  �6  �N
�   ��  �b
�   �
�   �	   �2   �J    �z0   ��  ��?   ��  �"  ��  �X   ��  �
  �   �p   ��  ��   ��  �,�   �
�   �"  �V�   �:  ��  �2  �l  �*  ��   �R  ߄  ���   �j  ߚ   ��  ߮'   ��  ��=   ��  ��R   ��  ��  ��c   ��  �w   ��  ��  �z  �  �Z�   �  ��  �.  ��  ��   �B�   �T�   �^�   �p�   �z�   ���   ���   ���   ���   ���   ��   ��   ��(   ��   �G   �?   �"b   �4Y   �>{   �Pm   �Z�   �l  �p  ��  ��  ��  ��  �  �"  �>  �Z  �v  ��  ��  ��  ���   �z�   ���   ���   ���   ��   ���   ��,   ��&   �X   �K   ��   �0|   �:�   �L�   �V�   �h�   �r
   ��   ��B   ��9   ��j   ��`   ���   ���   ���   ��   �*  ��   �B  ��   �Z  �   �r  ��   ��  ��1   ��  ��B   ��W   ��g   ��  ��  �@  �2z   �  �X�   �  �p�   �2�   �z�   ��  �  ���   ��  �  �v  �
�   ��  ��  �  �   ��  �g   �:  ޾  �w   �R  �J  ��  �2 ��   �j  �� ��   ��  �b  �>  �F �   ��  �R    ��   ��9   �U   �*w   �B�   �T  �X  �|  ��  ��  ��  ��  ��  �  �&  �>  �V  �n  ��  ���   �b�   ��  ��  �Z�   ��  �~  2�   ��  �   ��  �  V)   �
H   �"  �F  �_   �:  ��  ��   �R  � !
�   �j  ���   ��  �
   ��  ��  ��  ��  �  �  �6  �N  �f  �~  ��  ��  ��  ��  ��  ��   ��   �1   �  �nG   �2`   �J�   �z  ���   ���   ��  �6�   ��  ���   ��   �
  ��3   �)   �   �D  �^  �v  ��  ��  ��  ��  ��  �  �  �6  �N  �f  �~   �*M   �rq   ���   ���   ���   ���   ��  ��U   ��u   ���   ���   ���   �
�   �"�   �:�   �R   �j+   ��6   ��G   ��Y   ��n   ���   ���   ��   �*�   �B�   �r   ��8   ��a   ���   ���   ���   ��   �2  �"�   �J   �b.   �zQ   ��p   ���   ���   ���   �
   �:*   �RF   ��m   ���   ���   ���   ���   ���   �
   �*    �B9   �ZP   �ri   ��   ���   ���   ���   ��   �   �2B   �Jl   �z�   ���   ���   ���   ���   ��   �
   �";   �:V   �Rn   �j�   ���   ���   ���   ���   ��   �*   �*P   �Bs   �Z�   ���   ���   ��   ��   ��0   �I   �_   �2z   �J�   �z�   ���   ���   ��    �� 0   �
 W   �" �   �4  �8  �\  �v  ��  ��  ��  ��  ��  �  � t   �B �   �r �   �� �   �� �   �� �   ��!   ��!0   �!M   �!g   �X  �  �@  �b  ��  ��  ��  ��  �  �2  �R  �r  ��!�  �v!  ��  ��  �&  �^  ��  ��!��  ��  ��  �B  �<  �J  �l  �H  �6  � T �  � X � � "X *� *� *� *� *� +  +, +F +b +x +� +� +� +� +� , ,0 ,D ,p ,� ,� ,� ,� ,� - .$ .@ .^ .t .� .� .� .� .� / /* /@ /T /� /� /� /� /� 0 0& 0D 0Z 0p 0� 0� 1� 3$ 4� 4� 4� 5  5 5( 5T 5n 5� 5� 5� 5� 5� 6 6& 6D 6X 6l 6� 6� 6� 6� 6� 7 7< 8< 9x KJ L� R� TT U� W W` W� X8 X� Y Y� Y� jP j� k0 k� lT l� m  m� m� n: n� o  p$ p� r| sl s� v8 ~x �l �� �` �� �� �@ �� �� �
 �h!�  ��  ��  �  ��  �2  �\  �p  ʂ  ��  ��  �  �4  �Z  �<  �b!�  ��  �
  �J  �V!�   ��  �!�   ��  �&!�   �^!�   ��!�   ��!�   ��!�   ��!�   �"   �."'   �N"A   �n"X   ��"t  ��  ��"}  ��  ��  �P"�  ��  �4  ��  ��"�  �@"�  �B"�  �D"�  �F G8 Mh N z8"�  �p  Ĝ  İ  ʔ  ʲ"�  ��  �l"�  ��  �F"�  ��  �""�  ��  �  ��  �  �r  Â"�  ��  Ø  è  ��  ��  �*  �T  �h  �z  ʌ  ʪ  ��  ��  �  �  �,  �>  �R  �d"�  �#  �  �z#'   �.  ��#  �8  ��#4�  �V  ��  ��  ư  ��  ��  �6  �F  �n  Ǌ  Ǻ  ��  ��  �  �2  �R  �r  Ȓ  Ȳ  ��  �
  �b  ��  ��  �  �.  ֖  �  �   �Z  �^  ��  �  �B  �F  �\  �`  �n  �" � � �  & t x � Z � � � � Z � � d �  ^ n � � � 4 N � � � #� $� % 'T (� )d *� *� +L +P , , ,� ,� .F .J .� .� /� /� 0, 00 4� 4� 5t 5x 6, 60 6� 6� :
 :v :� ;~ <� =D @4 @> G Kx K� M M  M� M� M� M� NJ NT NZ N� N� N� O� Q� a� bN bx h� h� p� r� r� s s z� z� {� � � � � � � � � � � �( �. �� �� � � �f �v �� �� � �
 �� �� �� �� � �2 �N �� �� �< �X �� ��#L  �x#�  �2  ��  �^#�  �F  ��  �^#�
  �r  �   �T  ɚ  ɰ  �d  ��  ��  �� #�  ��  ��  ��  � p � b� b�#�  ��  �J  ��  ��  �
  �&  ��#�  ��  �h  ��  ��  ��  ��  ��  ��  �  �(  �:  �T  �l      ´  ��  ��  ��  �  �&  �  �&  �8  �H  �V  �b  �l  �z  Ć#�  ��  ��  Ê  ò  ��  ��  ˚  ̮#�  ��$  ��$   ��  ��  �*$>   ��  Ŭ  ̸  �j  ��  �@  �F  ��  ��  �  �  ��  �R  ��  �  ��  �\  ��  ��  ��  � � �  B  j < #p $n %� *> -� 1� 3 4f 8, ?� Rt S� TD U� ar b* d� d� h h� z� { {� �Z � �B �0 �� �� �6 �X �. �� �$$  ��  �  �l$<   �B$U  �R  ��  ��$   �\  �|  ��$i   �`  ��$�   �l  ��  ��$�   �p  ��$�   ��  ��$�   ��$�   ��$�   �$�   �&%  �V  ��  ��%   �`%    �t%0   ��%?   ��%W   �%n   �*%�   �:%�   �X  ��%�   �L  �r%�  Ì%�   ��  �  ��  ��  �  �V f g�%�   �0  �l � �%�   �4  ��  ��  �  �
  �v  �z  ��  ��  �N  �R  �  �  �p%�   �D%�   Ķ%�   �� � � � : � �� �� �0 �� �� �� �d � �$ �� �� ��%�   �  �%�  �6  �r  Š ��&   �F  ŀ  ��&>   �`&b   �z  Ų&x   Ő&�   Ÿ  ��  �(  ��  �  �b  �`  ��  ��  �  �� $t ?� S� h4 i {* �p �b �R �� ��&�  ��'   ��  Ƥ  ��  �n  �  �2  �  �  �  �  �� � �  %� 9� ?� QF hZ i* {f �� �� ��'  �  Ǧ'  � '[  �"'�  �$'�  �&  �� $f �~ �� � �j'�  �((  �* �� �'9   �. �'u   �> �.'�   �N �� �> ��'�C   ƀ  �4  �x � ` � $� 'x )� : :� :� <� =T =~ =� > >J >� @t @� A Av BD B� C CZ D  Dl D� D� E: E� E� F FZ H� H� I I$ IB Ib I� I� I� I� J J$ JD Jd J� J� J� J� K K" QR a� i� q� z� |l } }" }> �� �\'�   Ǝ �� �j(
  Ơ � $� ~" ~, ~6 �� �|(!,  ��  �x  π  ��  �� � � V P t � � #� % '� (� <$ <� <� A4 A� B Bd B� D& D� D� E* Er E� F FJ F� H� K> i� z� { }� }� }� � �� �(P   �,  ǰ(�   �T(z  �X(�  Ǥ �� �h(�"   Ǿ  ��  ��  �  �>  �^  �~  Ȟ  Ⱦ  �   �  �*  �>  �R  �f  �z  �  �  �  ��  �� b � � � �  " B b � � � �(�0  ��  ��  �  �"  �B  �b  Ȃ  Ȣ  ��  �  �P  �Z  �  �  �  �.  �B  �V  �j  �~  �  �  �  ��  �� � � f � � � �  & F f � � � �  * < V v � � �(�   ��(�  �J)  �`  �&  �4  �B  ̾%�  ˘  ̬)�   �)�  �.  ��)�   ̂)�   ̚*
  ��*  ���  ��  �  �  �0)�   �*  ͔ *  ͖	y  ͜  ͦ  ͺ  �� ` e f� j� j� �� ��*7   Ͳ*(   Ͷ*E  �  ΄ o� o� p p�*M  �   �D  �b o� o� �� �j*X   �**z   �L  Ύ p �� �� �t*�   �R*�   �j*�  �x o�*�  �z o�*�   ΢  �� pN p�+  �  �  �  �0+8   �+(   �+�  �P,   �R,  �T+X   �X  ��+m   �f @" F� G+c  �r  �|  ψ  ��  �*  м+�   Ϥ+�   ϴ,/  �B  �N  �X  �v,9   �T,H  �l  Ј  ��,N  А,Y  К N� N� N�,   ��,�   �  ��,�   � �,�   � ,�   �0 �-   �@ �(-,   �P �8-C   �` �H-_   �p �X-r   р �h-�   ѐ �x-�   Ѡ ��-�   Ѱ ��-�   �� ��-�   �� ��.   �� c� e� g< ��.   �� ��./   �  c� e� gL ��.J   � ��.d   �  c� e� g, �.y   �0 c� e� gl �.�   �@ c� e� g\ �(.�   �P c� e| g �8.�   �` �H.�   �p.�   Ҁ �X/   Ґ c� el g �h/   Ҡ cp e\ f� �x/0   Ұ/D   �� ��/_   �� d  e� g� ��/u   �� ��/�   ��/�   � /�   �/�   � /�   �00   �@0   �P ��0/   �` ��0E   �p ��0X   Ӏ c� e� g| ��0m   Ӑ0�   Ӡ0�   Ӱ0�   ��0�   ��0�   �� c` eL f� ��1	   �� �1   � 1=   � �1S   �  �(1e   �01~   �@ �81�   �P1�   �` �H1�   �p cP e< f� �X1�   Ԁ1�   Ԑ c@ e, f� �h2   Ԡ2   ԰ �x2,   �� ��2B   �� ��2Y   �� c0 e f� ��2s   ��2�  �  �,  �V2�   �2�   �  �D2�   �4
&  �^  Ք  պ3   �t3'   Մ3?   ը3X   ��  �  ��3`	  ��  ��  �"  �(  �`  �t  ֈ  ֤  ֶ3d  ��  ��  �,  �d  �x  ֌  ֨  ֺ3l  ��  ֮  ��  ר  ײ  ��  ��  ��  �  �.  �p  ؀  ب  ظ  ��  �$3s  � (� (� <(3�   ��3�   ��  ��3�  ��3�  ��3�
   �*  �:  �6  ^ � � ( 	� 
� �3�  �r  ׼  �<  ؎  ��  � �  1� 3V 8n R� T� U� r� ~�3�   �z  ׈  �D  �R  ��  ��  ��  ��  � � �   1� 1� 3^ 3f 8v 8~ R� R� T� T� U� U� r� r� ~� ~�3�  ׄ  ׌  �N  �V  ��  ��  ��  ��  �  �~ � �   1� 1� 3b 3l 8z 8� R� R� T� T� U� U� r� r� ~� ~�3�  �4 $h3�  �6 Q� ��3�  �| '* o |4  ��  ��  ��  ��48   ��4%   ��4J  �  �  �(  �<4f   � 4W   �$4�  �b  �n  ژ4�   �t4�   ڄ4�   ڞ4�   ڬ3�   ڼ  �   ی  � � � � #� #� % *� *� +h +l .d .h / / 4� 4� 5� 5� f g� �� �� �� � � �* �� ��4�  ��4�   ��4�  ��4�  ��5  ��5  �5!  �5�   �<  �L5�   �\5�   �z6  ۈ6�  ۨ \ 0 � $j o� o�6�  ۪ 26$   ۮ p B6C   ��  �� � � ^ l6n  ��  �P �  ~ �6�   �� � �6�   �V
�  �f  ܎  ܴ6�   �|7   ܤ7"  ܼ  ��  �7;   ��7R   ��7z  �  �7  �  �l  �  �<  �T 7�   �<  �d7�   �B7�   �j7�  �~  ݊  ݨ7�   ݐ  ݮ7�   ݔ  ��7�  ��  ��  ��7�   ��  ��7�   ��  �  �  �08   �  �67�   �  �D �� ��81  �H8�  �p8�   �t8�   ��8�   ��8�   ��8�   � � %8�   �8�   �09"   �B9   �F93   �Z9J   �p9X   ߈9h   ߞ9�   ߲9�   ��9�   ��9�   ��9�   �9�   � �:   �2:*  �@:0  �B:=  �|:F   �:u   �:�  �:�   �:�   ��:�   �`;   ��;?  �,;J  �.;P  �0;b   �n;g   �;r   �  � �h;y   � ^>;�   �� `;�   �� `^;�   �� `�;�   �;�   � ^^ �� �� �� ��;�   �(;�   �, ^� �V �d �t ��;�   �D  �6 ^. �H �X;�   �\ ^� � �(;�   �t a> {$ �� � �;�  �;�   �<   �" f g�<    �.<K   �P<j   �b<]   �f  �� ;p d@<p   �z  � >� z�<�   �<�   �<�   �  �� ��<�   ��<�   ��  �^=   ��  �6="   �=3   �  �  �� '� )� :" :� :� =b =� =� > >Z @� @� A: A� Bj B� C Cn D, Q�=K   �.  �"=d   �B  �J �  }\ }l=|   �V i� q�=�  �f  �r  �=�  �x  �R=�   �=�   �  ��=�   �=�   ��  �>  ��>6  ��>P  �  �8>f  �0  �T n6>k  �2  �V>u   �>>�   �Z>�   �^>�   �r>�   �>�   �>�   �>�   �?   �?    �?-   �?   ��?<   �� �2 ��?Q   ��?]   ��?k   �?�   �"?|   �& �� �" ��?�   �:  ��  ��?�  �H q@ {?�  �J %� Q�?�  �  �  ��?�  �  �v?�   ��?�   ��  �"@   ��@$  �B  �\@D   �b@X   �  * `�@`   �  N@�   �  z@x   �  r@�   ��  �L "  � q� v@�   ��@�   ��  �@�   �A   �" > !A    �J  �A9  �Z  �f  �AG  �l  �vA]   �As   �  ��A�   �A�   �A�	  ��  ��  �2  ��  ��  � Q� h� �A�  ��  ��  �8  �4  ��  ��  � ?b Q� R h� { �A�  ��  �:  �P ?d {A�  ��  �R ;< �ZA�9   ��  �  �h  ��  ��  ��  �t � v � 	N 
� V + +� ,R ,� .� /b /� 0� 1� 1� 2 2L 2Z 3� 3� 3� 56 5� 6z 7 7` 8� 8� 8� 9 9 9� 9� Kh K� O^ O| O� O� Qd T� T� T� U U hb h� i
 ��A�  �B  �\B    �bB   �~BE   �B-   �Bq   �BW
   � D~ D� E EN E� E� F& Fn |zB�   �B�   �B�   ��B�  �n  �z  �  �B�   �B�   �B�  �  �  ��B�   ��  ��C5  ��  �6  ��  ��  � h�CA  ��CG  ��CM  �� < 0  l 4 !� ', 9t V� W� X� YX k� l� mh n� s8 t` |� �� �T �@ � �� �� � �|C   �� fC   ��  �L r �CO   �� � �0 �� �XC\  ��  ��  ��  �Cw   ��Cc   ��C�  �  �   �0C�   �(  �LC�  �6 ?` Q� Q� R C�  �< %4C�   �RC�  �^  �C�
   �j 5" 5N 5� 6f 6� 7
 ?� {n {~C�  ��  ��  ��  �
D   ��C�   ��D(  �   �  �,DC   �$  �@D`   �LDP   �V  �D�  ��  �� d PD�   ��  �  ��D�   �6D�  �b  �n  �D�   ��E   �E!   �E:   �*EY  �V  �b  �Em   �tE�   �  �E�   �E�  ��  �
  �  �6E�   �E�   �E�  �,  �J  �fE�   �^  �E�  �x � <�F	  � b %l z6 6F  ��  ��  ��  �
F#   ��F   ��F1  �   ��  ��F6   �   �0  �T  �d  �  ��  �� +� ,� /6 0f 5� 6� `�Fp   �@FV   �D  �x  ��Fy   ��F�  ��  �  �  �.F�   �F�   �F�  �$  �`  ��    ��F�  ��F�   ��G  �f  ��  ��G   �|G+   ��  ��G3   ��GO  ��  �H alGB   �� a�GW  ��  ��  �  � d" e
 f�Ga  ��  �"�   �G   �(  �L  ��G�  ��  ��  ��  ��G�   ��G�   ��G�  ��  ��  �G�   �  �*H  �BH2  �^  �j  �x  ��HP   �pH;   �tHd  ��  ��  ��Hu   ��  ��H�   ��  ��  �� (� PRH�  ��  ��  �  �&H�   � H�   �H�  �  �8  �BH�   �H  �bH�  ��  ��  ��  ��H�   ��H�   ��H�  ��  �  �I   � I  �:  �F  �\I   �� 8 (r PI$   ��  ��  �� ��I:   ��IV  �Ia   �$  �>  �"Ip  �,  �b  �t  ��  ��  ��  ��  ��  �  �,  �D  �\  �t  ��  ��  ��  ��  ��  �  �  �4  �L  �d  �|  ��  ��  ��  ��  ��  �I�   ��  �(I�   ��  �@I�   ��  �XI�   �  �pI�   ��  ��J   ��  � J   ��  �J2   ��  �0JJ   �H  ��Jc   �`  ��J|   �x  ��J�   ��  ��J�   �J�
  �2  �B  �N  �^  �j  �z  ��  ��  ��  ��J�   � J�  �&  �2  �@  �^  ��J�   �8J�   �<J�  �T  ��  ��  ��K   �pK:   ��  ��KF  ��    �  �  �Kr   ��KV   �� H�K�   K�    x d � 
< � �K�   *  JK�  .  NK�   < ` L � 
$ � tK�  �  t z4 { {� | 4K�    :L  K�  L 0 D XL%  f �LC  � �L=  � � � �Lb     >L~  Ll  L� 4 R Z fL�  l �  H  L� |L�  �L� 8L� :L� >L�  " HM	  4M  N nM,  TM@  zM]  � � � 	d 
� tMj  � �  	| 
� �Mw  � � @ 	�  �M�    � X 	� , �M�    p 	� D M�  0  � 	� \ 4M�  H 4 � 
 t TM�  � | � 
T � �M�  � � 	  
l � �M� � � $M�  N  * ZN  0 
�N"  6 �N/  < 	.N<  BNQ  f �Nk �Nz 	$N�  	> 
�N� 
�N� �  ,N�  N�  2 NN�  8N�   N� ^O `3� �OS �Oa �Om  O� 
O�  � �O�  RO� " F f � � NO�  (O�  J � #� b P   R y�P  V v � � !� "�P$  j �PC  rPG  � � }NP[  �P_  �Pc  � #�Pq  � � P|  �P� $ (� (� qf |� hP� &P� (P� * { lP� ,P� .P� 2 '( )P�  <P�  nP�  � ^�P�  l ~P� v p� qP� xP� z qhP� � � #TQ  �Q� �Q�  Q:   RQI  < B � � QU  Q  r x � � � � 
 � < L ` p � �  Z n ~ � � � �  � �  N Z j � � #HQ� | #� ~ ~ ~ �� �Q�  �Q�  �R  j �R r � � � �R$  �S[ hSa jR�  �R� � � � S�  S� "St  , !� "�S� � � � � � � � * 6 < H P � � � � � �   , 2 B !� "�S�  Z !� "�S� ` �S�  � >T
 � B  6  Z  ~  �  �  � ! !2S� � �   N ^ !� "�T#  � �T0 � � !V !z !�T � � � � � " "�TX � � � � * b x  .  R  v  �  �  � ! !*Tf  � !&Tt  � �  J q� rXT�  � R !� "�T� �  * !N !r !�T�  � !JT�   !nT�  . !�T�  � U � � � U=  �UU  �U{  
U� 0U� 2U� 6 �V� 8 <V� : >U�  H �U� N � � �U�  vU�  �V  � �V'  �V/  �V\  V@   8V�  V�  & RV�  6 2� 3� 9@V�  BV� N 2� 3� 9^ S� V�V�  vW8 �WG  �Wf    &  >  J  b  n  �  �  �  �  �  �  �  � ! !"Wr  !.W� !: !F !^ !j !� !�W�  !RW�  !vW�  !�W� !�X  !�W�  !� "� "�W�  !� "� #ZW�  !� "� v� w w  w0 w@ wPX` #l $d $�X  #vX.  #�X� $�X� %0X� %2X� %nYJ %�YQ & &Yj  &Y�  &*Y�  &:Y�  &JY�  &ZY�  &jY�  &zY�  &�Y�  &�Z  &�Z'  &�Z;  &�ZO  &�Zc  &�Zw  &�Z�  'Z� '.Z� '2 <*Z� '� '�Z� '�Z� '� ( (0 (^ (�Z�  '�Z�  '�[  '�[5  ("[I  (6 (H[U (>[d  (�[u  (�[� )$ ) )$[� )J )� )�[�  )�[� )� * *" -� -� -�[�  *[�  * *J -� -� 1R 1� 2� 3 4B 4r 7� 82 RF Rz S� TJ Uv U�\  *(\/ *8 -� 4`\2 *V -T -� 0� 4~ 7| S� S�\7 *\ -� 4�\C	  *� .. 4� x x x6 xN �� �<\N  *� .2 4� x:\X  *� +& +� ,> ,j ,� .� .� /N /� 0 0~ Sx V�\_  +� - /z 0� 6 76\j  -8 0�\~  -�\�  -�\� 1$ 1: 1Z\�  1@\�  1`] 1p 3 8 Rd T4 U�] 1r] 1t]   2� 3� 9R S�]B 2� 2� 2�]d  2�]~  2�]� 3]� 3]� 4 4* 4J]�  40]�  4P]� 7� 7� 7� UF U^ U~]�  7�^  7�^8  8^d 8^j 8 ^p 9p^v 9r^� 9�^|  : :n :�^�  :<^� :d^�  :�^� :�^�  ;= ;@ ;J ;X ;� ;� ;�_   ;^_] <_b <_e <_h <_k <_n <_q < _t <& <�_z <,_�  <�_� = _� ="_� =$_� =&_� =(_� =*_� =,_�  =6` >� >�`  ? `6  ?a  ?"a�  ?2b�  ?Bf2  ?Rf� ?ff� ?h @B H� H� H� I I6 IV Iv I� I� I� I� J J6 JV Jv J� J� J� J� K M� ihf� ?jf� ?lf� ?n �
f� ?rf� ?tf� ?v @ @� @� @� @� A  A. A@ A� A� A� A� BP B^ Bp B� B� B� C C$ Ch Ct C� D D  D2 L( L>f� ?zf� ?|g7 ?~ ?�g= ?� ?�g( ?� F� G( G2 G@ G^f� ?� D\ Dx D� D� D� D� D� E  E E$ EH ET El E� E� E� E� E� E� F  F, FD Fh Ft F� G
 G~ G� L4 L�gh ?�gn ?�f� ?� F� F� G� G� H(fN ?� ?� L�f[  ?�f�  ?�f�  @ L8 L� N0g  F�g  F�g1 GF M0 Mz M� M�g� Hr H� H� H� H�g� Htg� Hvg� Hxg~  H~ K�g�  H�g� H� H�gt KD K� K�g�  K� K�g� L$ L* L0 L�g� L& L, L2 L�g� L.h L~h(  M:h^  Mdhd  N hk N,h�  N�h�  N� N�iT N�h�  Oh�  Oi  O i*  O0iZ  O� O� P� P� Qil  P, Pdi�  P�i� Q^ Q� Q�i� Q� Q�i� R R. RNi�  R4i�  RTi� Rfj Rhj	
  R� R� R� S@ SN V V V* Vp V~j S� S� Tj$  TjB  TjN  T$jm T6jr T8j�  Udj�  U�j� U�j� U�j�  V�k V�k V�k$ V� W� W� X|k* V� W� W� X~j� V� V� WL k� k� l@j�  V�k  WRk0 W� W� X$k9  W�k`  W�ky  X* Y Y�k� X� YTk� X� YVk� X� X� X�k�  X�k�  X�l YZl  Y\k� Y` Yl Y�k�  Yrl  Y�l.  ZLlG  Z\ld  Znl� Z|s_ Z~se Z�sk Z�ly  Z�l�  Z�s�  Z�s�  [s�  [$s�  [6 \s�  [Ls�  [`s�  [tt  [� [�t  [� [�t!  [� [�t,  \ t:  \&tV  \:tk  \Nt~  \b ]ft�  \vt�  \�t�  \�t�  \�t�  \�t�  \�u  \�u5  ]uV  ]ud  ],uy  ]>u�  ]Ru�  ]zu�  ]�u�  ]�u�  ]�u�  ]�v  ]�v  ]�v/  ^vM  ^vj  ^N �8vr  ^nv�  ^~v�  ^�v�  ^�v�  ^�v�  ^�v�  ^� �� �� �  �� ��v�  _ �� �" �0 �@ �� �zv�  _v�  _.v�  _>w  _Nw  _^w  _nw%  _~w1  _� �� � �� �� �� �� ��w:  _�wE  _�wP  _�wX  _�wf  _� �� �� �  � ��wy  _�w�  _� �X �~ � ��w�  ` �� �B �P �` �r �� �� � � �$ �@w�  `.w�  `>w�  `Nw�  `nw�  `~w�  `�w�  `�w�  `�w�  `�w�  `�w�  a �w�  ax  a.x  aNx  a^xA anx'  a~ fH g� h h�x-  a� a� a�xL
 a� b b bJ bt b� fN fX g� g�xq  b2xb  b> bRxQ bB bVx�  bdx� b� b� d� d� f~ f� f�x�  b�x�  dy  dP d` dp f( g� hF �6 �D �T �r � ��y!  d�yM  d�yc  d�y�  f8 g�' hy� h h& h,y�  hNy�  h� �\y�  h�z il i� zj |� Vz6 ixz, i|z@  i�z_ i� i� i� i� i� q� r\zq  jz� j j� k( k�z� j j� k* k�z� j$ j. j< j�z�  j4z�  j8z�  j�{ kj k� k�{  kt{-  k�{� k� l� l�{� k� l� l�{;  k�{k  lF{� l� l� m �� �N �� �� �{�  l�{�  m| md mj n0 n� o| mf ml n2 n� o{� mp m| m�{�  m�|  m�|W  n�|z  o|� o� o� qp|�  o�}	 o�} o�|�  p
}  p�}/ p�}5 p�};  q2}b qB}m qj}u ql}{ qn}� qr}� qt}� qv}� qx}� qz}� q|}f  q� zB}� s4 s:~ s6 s<}� s@ sL s�}�  sR~  s�~A  s� s� tj~J t t tP~f t� t� t� t� t� u ~v  t�~k  t� t� u u8~z  t�~�  t� u4~�  t�~�  t�~�  u~�  u&~� uF uR uv u� u� u�~�  uX~�  u\ u� u� �� �N ��~�  uh
  u�  u�&  u�*  u�D u� u� vO  u�^  v v2k  v{ v$� v&� vz v� wp�  v� v� v� v� v� v��  v� w�  v� w�  v� w$�  v� w4�  v� wD�  v� wT�  v�9  w`�I  w��i w� w� x ��  w� x x, xD x\��  w���  x��  x"��  xR��  xt�  x� x� xʁ  x��  x� x��  x��,  x��.  xЁD x� y y,�H  x� y��a  x�Y  x� y  y� yЁd  y y��v  y ýz y4 yP yz��  y>�  yB yj��  yV��  yf��  y��� y� y� y܁� y� y� z"��  y� z��  z�   z(� z�� {� {� {��*  {�9  {� |$�C  |�� |� b�� |� d�� |� f�� |Ђ� |҂p |� |� N�~  |₰  }���  ~< ~P ~d p��  &� 8� j�  �J�  �Z� �` �l �<�9  ���3  ���X  ����  ���� ��  ���* �:�I �P�W �Z��  �� ���  �D�� �l�� �r� �x� �~�% ���7 ���J �� �� � �8 �n�U ���k ���� ���� ���� ����  �̆� �Ԇ�  �� �@�� �� �H�%  ���>  ��P  ��m  �. ���� �T��  �d��  �t��  ���� �� �� ��� ���  �ʈ  �� ��$  ���> �P �X �^�G �l ���W �� �� �؈^ �� �� �� �� �B �Z �d�m �� �� �� �� �J �T�~  ���  �V�� �d�� �f��  �� �� �N �� �
 �& �~ �v � � �F �� �� �J �� �"�  �� �^ �" �� � � �� �� ���/  �� �H�>  �� ���W �� ��e �
 �" �:�� �|�� �~�� �� ����	  �� � �� �� �� �: �� �� �Љ�  �� �� � ��  �� �\ �� � �, �� �| ��, �t �� �8 �� �� � �� �H�@  ���6 �� �� �N �� �� �. �� �^�q  ���f �� � �X �� �� �8 ���� �� �, �� �� �� �` �  ����  ���  �� �� �� �� �� �� �� � � �V �^ �� �� �� �� ��  �� �` �� ��  �( �� � �b�?  �D ��r  ��� �<�� �>�� �D �P�  �H�+  �R�Y  ���| �L �j �r ���� ���� ���� �� �č  ���1  �T  �(�m  �2�� �� �� �� ��� �x�� �z�  �� �& �6 �N �d�� �� �B �J �䎲  ���  ��  �X�? �� ���W  �ҏN �� ��c ��i ��� �
�� ��X �6 �� � �0��  ���  ��  �( �L�  �j �n �F�+  �h�= �� �� � �4�K  ���b  �ґ{  �  ���  �, �P�� �� �� �� ���  �ƒ  ���5  � �(�� �` �f�� �b �h�L  �r�X  �x�� �x�� �� �  �ڒ� �� �� ���  �* �  ����  ����  �� ���0 �� ��7 �� ��  �� ���#  � ��@ �V �b �p ���c  �h�H  �l�} �� �� ����  � �D �� �`��  � �\ �: �f��  �(�� �x� �z�X �| ��c ����  �� �*�.  ����  �� ��� �ؔ� �ڔ�  �� �L��  ��� �v �� ����  ���  ���3  �ƕN  �� ��^  �|�t  �� �� �~ ����  �� �� �� ����  ����  ���� ��� ��� �� �l�L �n�	  �x ���)  ���i ��� ��� ��� ��� ��� ��X �6 ���p  ����  ���  ���  �R