�GSC
       "  \�  ")  \�  Rz  T6  qP  qP     @( % v       maps/mp/_imcsx_gsc_studio.gsc maps/mp/gametypes/_hud maps/mp/gametypes/_hud_util maps/mp/gametypes/_hud_message maps/mp/_utility common_scripts/utility maps/mp/gametypes/_globallogic init onplayerconnect result modelsspawned playersalive lastdeath  lastkiller starttime deathbarrierheight firsthostspawned welcomemessagespawn player_spawns_avalanche skipcountdown registernumlives _a535 _k535 models strtok p6_shipping_boxes_02,p6_stainless_refrigerator,p6_industrial_tubing_01,collision_clip_wall_256x256x10,p6_metal_fence_gate,p6_metal_tank_set_01,p6_plastic_trash_can,p6_shipping_boxes_01,p6_shipping_boxes_02,p6_water_cooler_metal,p6_stainless_refrigerator,p_dest_ashtray,p_glo_fire_hose,p6_shipping_boxes_02,p_rus_chair_metal,p_rus_coffee_urn,p6_lunch_table,veh_t6_drone_tank_alt,veh_t6_civ_car_compact,veh_t6_civ_future_forklift,ny_harbor_buoy_red,p6_barrier_barrel_orange_a,com_barrel_biohazard_rust,t6_wpn_supply_drop_ally,t6_wpn_supply_drop_axis,t6_wpn_supply_drop_detect,p6_barrel_green,inventory_minigun_drop_mp,inventory_minigun_mp,chopper_minigun_mp,littlebird_guard_minigun_mp,minigun_drop_mp,minigun_mp,minigun_wager_mp,p6_dockside_container_lrg_white,p6_dockside_container_lrg_blue,p6_dockside_container_lrg_red,p6_dockside_container_lrg_orange , precachemodel _a535 _k535 item dsr50_mp,ballista_mp,minigun_wager_mp precacheitem _a535 _k535 shader gradient,extracam2d,circle,menu_mp_contract_expired,menu_mp_killstreak_select precacheshader gametype tdm var ui_errorTitle,ui_errorMessage,ui_errorMessageDebug txt Error:|Gametype Fatal Error
Avalanche was developed for Team Deathmath only
Please change the Gametype to Team Deathmatch|
Avalanche Developed By Extinct! | i setdvar exitlevel rankedmatch script mp_dockside Error:|Map Fatal Error
Avalanche has been developed for Cargo only
Please change the map to cargo and try again.|
Avalanche Developed By Extinct! Avalanche:|Thank you for playing Avalanche  hostname 
Follow Extinct's social medias they are the following
Snapchat: Extincts, Instagram: Extinctable, Youtube: Extinct, Kik: Extinct98|
Avalanche Developed By Extinct! connected player onplayerspawned disconnect game_ended menuresponse changeclass class_smg spawned_player setclientuivisibilityflag hud_visible freezecontrols ishost avalanche_antiquit iprintln ^2Go Prone & Press [{+actionslot 3}] To Enable Force Host! changingmap avalanche_changemap Cargo overflowfix start_avalanche avalanche_forcehost avalanche_increasedeath avlanche avalanche welcomemsg endmsg avalanche_deathbarrier avalanche_ending setmovespeedscale enableinvulnerability suicide Avalanche_Ready gotcustspawn think_avalanche choose_custom_spawns avalanche_class teamrandomize increaseentityspace spawn_avalanche guns_avalanche ext iprintlnbold Please Wait.. Players Are Still Connecting, Time Remaining:^2  _a371 _k371 extinct players avalanche_gui Welcome avalanche_stance_check startpos xpos ypos hpos x modelspawner p6_dockside_container_lrg_orange rotateyaw p6_dockside_container_lrg_red movez origin angles p6_metal_fence_gate collision_clip_wall_256x256x10 spawn_models_avalanche Models Spawned:  minigun snipers minigunpos -199.942;-345.319;-464.305;-600.993;-728.39 ; sniperspos -733.398;-599.718;-462.46;-337.585;-196.031 snipersmodel ballista_mp+vzoom+steadyaim+dualclip;dsr50_mp+vzoom+steadyaim+dualclip wnum spawn script_model float setmodel getweaponmodel minigun_wager_mp startspin createrandomgunstrigger Mini Gun snum randomize randomintrange gun name model trig trigger_radius setcursorhint HINT_NOICON sethintstring Hold [{+usereload}] To Pick Up  trigger who weaponinbound usebuttonpressed isalive takeweapon hide triggeroff giveweapon switchtoweapon show triggeron rotateto Avalanche_Spectator trace weapon_fired team axis adsbuttonpressed bullettrace gettagorigin j_head getplayerangles entity avalanche_models physics_avalanche modelmonitorplayers num com_barrel_biohazard_rust p6_barrier_barrel_orange_a rowtwo veh_t6_civ_future_forklift,veh_t6_civ_car_compact,veh_t6_civ_future_forklift veh_t6_drone_tank_alt rowfour p6_metal_tank_set_01,p6_plastic_trash_can,p6_metal_tank_set_01,p6_plastic_trash_can,p6_metal_tank_set_01,p6_plastic_trash_can rowfive p6_shipping_boxes_01,p6_water_cooler_metal,p6_shipping_boxes_01,p6_water_cooler_metal,p6_shipping_boxes_01,p6_water_cooler_metal rowsix p6_water_cooler_metal,p6_stainless_refrigerator,p6_water_cooler_metal,p6_stainless_refrigerator,p6_water_cooler_metal,p6_stainless_refrigerator rowseven p_dest_ashtray,p_glo_fire_hose,p_dest_ashtray,p_glo_fire_hose,p_dest_ashtray,p_glo_fire_hose roweight p6_shipping_boxes_02,p6_industrial_tubing_01,p6_shipping_boxes_02,p6_industrial_tubing_01,p6_shipping_boxes_02,p6_industrial_tubing_01 rownine p_rus_coffee_urn,p6_lunch_table,p_rus_coffee_urn,p6_lunch_table,p_rus_coffee_urn,p6_lunch_table teamcustspawn allies alliesNum alliesLookAt axisNum axisLookAt posallies -727.991|-595.513|-462.756|-331.885|-199.722|-464.917 posaxis -199.228|-333.219|-466.486|-600.355|-717.008|-466.486 setorigin Num setplayerangles LookAt geteye physicslaunch owner _a730 _k730 dude distance callbackplayerdamage health MOD_CRUSHED j_spine4 dodamage none MOD_HIT_BY_OBJECT supplydrop_mp playsound phy_impact_supply avalanche_spec Destroy Notification ents getentarray index issubstr classname trigger_hurt delete deathbarrier fixinfotext advertise_avalanche instructmoving instructionopen InfoSmall createstring Avalanche small BOTTOM titlechange ^1A^7valanche|A^1v^7alanche|Av^1a^7lanche|Ava^1l^7anche|Aval^1a^7nche|Avala^1n^7che|Avalan^1c^7he|Avalanc^1h^7e|Avalanch^1e^7|Avalanc^1h^7e|Avalan^1c^7he|Avala^1n^7che|Aval^1a^7nche|Ava^1l^7anche|Av^1a^7lanche|A^1v^7alanche settext [{+actionslot 1}] To Open   Instructions [{+actionslot 1}] To Close  action welcomemessage freezecontrolsallowlook setblur Text0 Welcome To Avalanche bigfixed CENTER TOP Text1 Developed By Extinct objective Text2 Attackers: Dodge the falling models and make it to the top to kill the defenders! Text3 Defenders: Shoot the levitating models to make them fall to kill the attackers! Text4 Goodluck, Hosted By  Text5 www.youtube.com/c/ExtinctMods Text6 Game Starting In: ^210 Background createrectangle white affectelement alpha Text setsafetext Game Starting In: ^2 welcomemove -150,150,-150,150,-150,150,-150 disableinvulnerability destroyall GUICreate LobbyNotify InfoBackground InfoText Dodge the falling models and make it to the top to try and kill the defenders! Shoot the levitating models to make them fall to kill the attackers before they reach to the top! NotifyBackground TOPRIGHT gradient NotifyTextTop RIGHT NotifyTextBottom actionslotonebuttonpressed instruct Active y notifys ^2  ^7Has Been Eliminated By  Number Of Attackers Remaining: ^2  clearperks takeallweapons knife_held_mp avalanche_perks specialty_fallheight,specialty_fastladderclimb,specialty_fastmantle,specialty_fastweaponswitch,specialty_longersprint,specialty_sprintrecovery,specialty_unlimitedsprint,specialty_armorpiercing,specialty_armorvest,specialty_bulletdamage,specialty_bulletpenetration,specialty_bulletflinch,specialty_scavenger,specialty_extraammo,specialty_fastads,specialty_fastequipmentuse,specialty_holdbreath,specialty_loudenemies,specialty_noname,specialty_twogrenades setperk getcurrentweapon maxhealth getstance prone setstance crouch actionslotthreebuttonpressed forcehost Force Host: ^2ON party_connectToOthers 0 partyMigrate_disabled 1 party_mergingEnabled Force Host: ^1OFF ^1Warning^7: Death Barrier Level Increased! mapname mapcode Avalanche: Map Isnt Supported.. Changing Map: ^2 map endmessage Avalanche Has Been Won! Thank you for staying in for the full game, I hope you have had fun playing! Winning Team Is Defenders Winning Team Is Attackers Thanks To   For Hosting The Lobby Snapchat: Extincts, Instagram: Extinctable, Kik: Extinct98 _a925 _k925 maps/mp/gametypes/_globallogic_ui closemenus avalanche_tele _a925 _k925 Not teleported All Bots Teleported to Crosshair avalanche_debugging jumpbuttonpressed X:   Y:   Z:  avalanche_freeze _a925 _k925 You're Host host_migration_begin test createserverfontstring default xTUL g_gametype sd a textset clearalltextafterhudelem _a925 _k925 saveposinfo text debugexit obj incentspace array arrayents script_model,script_brushmodel,script_origin Entity Space Increased By: ^2  ^7|^2  array_delete input font fontscale align relative color glowcolor glowalpha sort islevel isvalue hud createfontstring setvalue setpoint archived hidewheninmenu width height newclienthudelem newhudelem elemtype icon children setparent uiparent setshader type time value moveovertime fadeovertime keys getarraykeys temp e destroy prematchperiod    ^   u   �   �   �   � �����I����5�-4    �6! (!(!!(
8!.(
8!9(
! D(f!N(!a(!r(-0      �6-4      �6-.   �6-
 -
 �.   �'(p'(_;   '	(-	.      /6q'(?��-
-
 N.     �'(p'(_;   '(-.      t6q'(?��-
-
 �.     �'(p'(_;   '(-.      �6q'(?�� �
 �G; ]-
-
 .     �'(-
 �
 9.     �'(' ( SH; -  .      �6' A? ��-.      �  �9= 	 �
 �G; [-
-
 .   �'(-
 �
 	.     �'(' ( SH; -  .      �6' A? ��-.      �  �
 �F; V-
-
 .   �'(-
 �
 � �
 �NN.   �'(' ( SH; -  .      �6' A? ��  
 uU$ %- 4   �6?��  &
�W
 �WX
�
 �
 �V
 �U%-
�0    �6-0     	6  a9= 
-0     	;  �! r(-4    	6-
 	60      	-6  �=  	 �
 �G; !	q(-
 �
 	�4      	}6�+-2    	�6-4      	�6-4      �6-4      	�6-4      	�6! a(  	�_9=   	q_9;  _! 	�(!	�(!	�(-4      
6-4      
6-0    
,6-0      
>6  r;  -0     
T6! 	�(

\U%  
l_9;  +-4     
y6-0      
�6-0      
�6! 
l(?��  
�?EK
 �W! 
�(-4      
�6	  >L��+-4      
�6-4      
�6+'(I;  -
 N.    
�6+'B?��	 ?�ff+  S'(p'(_;  :' (-
i 4     [6- 0   
,6- 4     q6q'(?��  ������
 �W! 	�(� X['('('('('(H;  �' ( <H; b-�[
 ��P�P[N.     � 	�S! 	�(-	  <#�
Z 	�SO 	�0      �6'A'A	<#�
+' A? ���N'('('('A?�s'(�'('(' ( =H;  �-���[
 ��P�P[N.     � 	�S! 	�(-	  <#�
Z 	�SO 	�0      �6-	 ?333< 	�SO 	�0      �6'A'A	<#�
+' A? �s �'('('(' ( =H;  �-���[
 ��P�P[N.     � 	�S! 	�(-	  <#�
Z 	�SO 	�0      �6-	 ?333< 	�SO 	�0      �6'A'A	<#�
+' A? �s	   Fw� 	   �H,�	   Fgך[�  	�7! �(	Fw� 	   Å�3	   Fgך[- 	�7! �(Z��[� 	�7! (Z��[ - 	�7! (�'('('('(H; �' ( H; n-^ 
�; 	�7  �,[^P[NN.     � 	�S! 	�(-	  <#�
Z 	�SO 	�0      �6'A	   <#�
+' A? ���N'('('('A?�h�'('('('(H;  �' ( H; l-^ 
�; 	�7  �$[^P[NN.   � 	�S! 	�(-	  <#�
Z 	�SO 	�0      �6'A	   <#�
+' A? ���N'('('('A?�i�'('('('(H;  �' ( H; l-^ 
�  	�7  ���[^P[NN.   � 	�S! 	�(-	  <#�
Z 	�SO 	�0      �6'A	   <#�
+' A? ���N'('('('A?�i-Z[
 	   Fw�f �	   FsZ�[.    � 	�S! 	�(-Z[
  	 Fw�f �	   FsZ�[.    � 	�S! 	�(-4   ?6-
 V N0     	-6
+X

\V  gow��;��'('(-
�
 �.   �'(-
 �
 �.     �'(-
 �
 �.     �'('(H;  x-	  Fx�f-.   S	   Fr�f[
F.     @'(--
 q.     b0    Y6-4      �6-
�
 q4      �6'A? �'(H; �-.     �' (-	   Fx�f-.   S	   F�q�[
F.     @'(-- .    b0    Y6-4      �6-  4   �6'A? �p  ����>
 �W---7  �
 �.   @'(-
 �0     �6-
 N0      6
6U$ % 7!B(- 0   P=  - .      a;  Y- 0    i6-0     t6-0     y6- 0   �6- 0   �6+-0      �6-0     �6?�u  &_; 8-	  >���   ZN  [0      �6	  >���+?��  �
�f
 �W
 �W'(
 �U%  �
 �F= 
-0     �;  --
0    -0   c   B@PN-
0      .     �'(
(7  �_;�'(	H; P /
(F;  8'(	H; ,-  /4    @6-2  /4    R6'A? ��'A?��	'(H;  R /
(F;  :	'(H;  ,-  /4    @6-2  /4    R6'A? ��'A?��'(H;  R /
(F;  :'(H;  ,-  /4    @6-2  /4    R6'A? ��'A?��'(H;  @ /
(F;  -  /4      @6-x  /4    R6'A? ��' ( MH;  >  /
(F;  %-   /4    @6-(   /4    R6' A? ��? ��  
�  /S(! /(' ( H;  �-Z�Z[
 j; 	�7  � �d ,PN
[N.   � /S! /(-Z�Z[
 j; 	�7  � �d ,PN[N.     � /S! /(-Z�Z[
 j; 	�7  � d ,PN
[N.     � /S! /(' A?�?' ( H; �-Z�Z[
 jw 	�7  � �d ,PN
[N.   � /S! /(-Z�Z[
 jw 	�7  � �d ,PN[N.     � /S! /(-Z�Z[
 jw 	�7  � d ,PN
[N.     � /S! /(' A?�@' ( H; �-Z�Z[
 �; 	�7  � XF ,PN�[N.   � /S! /(-Z�Z[
 �; 	�7  � XF ,PNn[N.     � /S! /(-Z�Z[
 �; 	�7  � vF ,PN�[N.     � /S! /(' A?�@-
-
 �.   �!�(' ( H;  D-^    �;  	�7  � �
 �PN ,[N.     � /S! /(' A?��' ( H; <-^ 
�; 	�7  �  U UPN �[N.   � /S! /(' A?��-
-
 .   �!	(' ( H;  D-^    	;  	�7  � �U UPN &[N.     � /S! /(' A?��-
-
 �.   �!�(' ( H;  D-^    �;  	�7  � �U UPN �[N.     � /S! /(' A?��-
-
 .   �!(' ( H;  D-^    ;  	�7  � LU UPN �[N.     � /S! /(' A?��-
-
 �.   �!�(' ( H;  D-^    �;  	�7  � �U UPN R[N.     � /S! /(' A?��-
-
 .   �!(' ( H;  D-^    ;  	�7  � U UPN �[N.     � /S! /(' A?��-
-
 �.   �!�(' ( H;  D-^    �;  	�7  � xU UPN [N.     � /S! /(' A?��  L��! (
 !(
"!(	  C��1	   @_�@[
,!(
�!(
9!(	C�qH	   C��`[
A!(-
�
 V.   �'('(H;  0	   Df -.   S	   ��j[
!('A? ��	   Df 	   ��u`	   ç�)[
!(-
 �
 �.   �' ('(H;  0	   Fw�f- .   S	   F�38[
�!('A? ��	   Fw�f	   ��>5	   F���[
�!( &- �
 �N    � 0      �6- �
 �N  -0      �Oe0      �6  �
 �N! A  &_; - � '[c �P  �0    �6 
�

 �W
 �W!(_; S'(p'(_;  �' (- .    a=  - 7  � �.     H; � 7 �!.(  7 �!9(-
 L^ -
L 0   
@ 7  9N   $56-
 u
c
 ^  7  � 7 9N 0    U6-
 � 0     �6! !B 7! �(-
 � 4     [6X
 � VX
 �Vq'(? �	   =L��+?��  ��
 �W
 �W-.    �'(' ( SH; H-
� 7  �.   �;      ��[ 7!�(- 7  �0     �6' A? ��
 
\U%  �
 F; !!A  �  NJ=  _9;  9!(-0    
T6-
 �4      [6  �
 F; !!B!(	  =L��+?��  
�
 �W
 �W! .(!=(-^ ^*#
 t
 t	   ?���
 n
 d.     W
 M!	�(-
�
 �.   �!{(' (   {SH;  n .;  
	 =L��+?�� =9; $-
o  {
�NN
 M 	�0    g6? !-
�  {
�NN
 M 	�0    g6	  >���+' A? ��	   =L��+?�u  �
�
 �W
 �W
 iF;� �_9; �!r(! �(	=���+-
�0      �6-0    �6-0      �6-^ ^*2�
 
 	 ?�33
 
 �0    W
 �!	�(-^ ^*M�

 	 ?�33
 4
 0    W
 !	�(-^ ^*x�

 	 ?�ff
 4
 D0    W
 >!	�(-^ ^*��

 	 ?�ff
 4
 �0    W
 �!	�(-^ ^*��

 	 ?�ff
 4
 � �N0   W
 �!	�(-^ ^*��

 	 ?�ff
 4
 0    W
 !	�(-^ ^*��

 	 ?�ff
 4
 10    W
 +!	�(-
 c^  � �
 
 .   S
 H!	�(-	  >���
 w
 H 	�0    i6	  ?   +' ( H;  V-	   ?   
 �
 } N  	�0    i6-	   ?   
 w
 } N  	�0    i6	  ?��+' A? ��-0   	;  
!D(' ( H;  <-
� DN
+ 	�0    �6+-0   	;  !DB	  =L��+' A? ��-
-
 �.     �!�(' ( H;  b--  �.      S	   >���
 �
 } N  	�0    i6-	>���
 w
 } N  	�0    i6	  >���+' A? ��-	>L��
 w
 H 	�0    i6-0   �6!�(	>�  +-0     �6-0      �6- 	�0      �6-
 �4      [6-
 �4      [6-4      6
�F;�!(-
 c^ �(
t
 t.   S
 !	�(-
c^ 2 �d
t
 t.     S
 H!	�( �
 F; 4-^ ^*d
t
 t	 ?�33
 4
 0    W
 !	�( �
 �F; 4-^ ^*d
t
 t	 ?�33
 4
 n0    W
 !	�(-
�^ 2 J2 �
 �
 �0    S
 �!	�(-^ ^*C �
 �
 	 ?�33
 4
 80    W
 �!	�(-^ ^*S �
 �
 	 ?�33
 4
 80    W
 !	�(-0     ; G 3_9;  �
 <!3(! .(! =(-
	 >L��
 C
  	�0    i6-	   >L��
 C
 M 	�0    i6-7	   >#�

 C
 H 	�0    i6-	   >#�

 C
  	�0    i6? �! 3(! .(!=(-(	   >L��
 C
  	�0    i6-#	   >L��
 C
 M 	�0    i6-d	   >k�
 C
 H 	�0    i6-d	   >k�
 C
  	�0    i6	  >k�+!.(	=L��+?��
 �F;Z
 �U%  E_9; &
 <!E(-
 M .
 P
 M 9NNNN
 � 	�0      �6-
 k !N
 	�0      �6-(	   >L��
 �
 � 	�0    i6-2	   >L��
 �
 � 	�0    i6-2	   >L��
 �
  	�0    i6+-�	   >L��
 �
 � 	�0    i6- �	 >L��
 �
 � 	�0    i6- �	 >L��
 �
  	�0    i6	  >L��+!E(?  E_; -
80      	-6	  =L��+?��
 �F; -  	�0    �6 
�
 �W
 �W! B(-0      �6-0      �6-+
�0    �6-
 �0      �6	  ?   +-
 -
 �.   �!�(' (   �SH;  -   �0     �6' A? ��-0   P;  a-0   �
 �F=  B9; I--0      �0    i6	  =L��+-+
�0    �6-
 �0      �6	  >���+	  =L��+?��  &
�W
 �W �
 F; �!�(  �!9(-0    �
 �F; -
�0    �6  �
 �F=  9<K; <!�(  �!9(	  =L��+?��  &-0    �=  -0   �
 �F; � �_9;  J
 <!�(-
 �0    	-6-
 
 .   �6-
 6
  .   �6-
 
 8.   �6? E! �(-
 M0    	-6-
 6
 .   �6-
 
  .   �6-
 6
 8.   �6	  =L��+?�?  &<+ �!N(-
 _.     	-6 ��
�
 �W' ( I;  -
� N.    
�6+' B?��-.   �6 
�
 �W
 �U%  �_9; �!�(- 	�0      �6	  =���+-
�0      �6-0    �6-0      �6-^ ^*2�
 
 	 ?�33
 
 �0    W
 �!	�(-^ ^*M�

 	 ?�33
 4
 0    W
 !	�(-^ ^*x�

 	 ?�ff
 4
 �0    W
 >!	�( !J;  :-^ ^*��

 	   ?�ff
 4
 @0    W
 �!	�(?  4-^ ^*��

 	 ?�ff
 4
 Z0    W
 �!	�(-^ ^*��

 	 ?�ff
 4
 t �
 NN0      W
 �!	�(-^ ^*��

 	 ?�ff
 4
 0    W
 !	�(-^ ^*��

 	 ?�ff
 4
 �0    W
 +!	�(-
 c^  � �
 
 .   S
 H!	�(-	  >���
 w
 H 	�0    i6	  ?   +' ( H;  V-	   >���
 �
 } N  	�0    i6-	   >���
 w
 } N  	�0    i6	  >���+' A? ��	   @   +  !K;  -  	�0      �6-0   �6 ��K
 �W S'(p'(_;  4' (- 0      	;  ?  - 0      �6q'(?��	   =L��+?��  ��
 �W S'(p'(_;  T' ( 7 �
 �F; -
% 0     	-6? -  � 0     �6-
 40      
�6q'(?��  &
�W-0   P;  %-- 	�7  ��[N0    �6	  >���+-0      i;  -4   
6	  >���+--0     0    	-6-
 {  �
 �
� �NNNNN0      
�6	  >���+?�`  ��
�
 �W S'(p'(_;  @' (- 0      	;  -
� 0   	-6? - 0    �6q'(?��  ���
 �W-
�.     �!�(-
 � �0   g6 �7!w(
�h
�F; -'(? 7'(
  U%  K;-  �0    6!(  S'(p'(_; �' ( =9=  7 _=  7 �_9;  &-
o 7  -
 �NN
 M 7 	�0    g6? %-
� 7  -
 �NN
 M 7 	�0      g6
 7 	�_=   7 �_9;  M 7 �
 F; -

  7 	�0    �6 7  �
 �F; -
n
  7 	�0      �6
� 7 	�_;  �-
�
 � 	�0    �6-
 
  	�0      �6-
 �
 > 	�0      �6  !J;  -
@
 � 	�0    �6? -
Z
 � 	�0    �6-
 t �
 NN
 � 	�0    �6-
 
  	�0      �6-
 �
 + 	�0      �6 7  �_; �-
�
 � 7 	�0      �6-
 
  7 	�0    �6-
 D
 > 7 	�0    �6-
 �
 � 7 	�0    �6-
 � �N
� 7 	�0    �6-
 
  7 	�0    �6-
 � DN
+ 7 	�0    �6 7  E_=  7 �_9;  I-
M .
 P
 M 9NNNN
 � 7 	�0      �6-
 k !N
 7 	�0    �6q'(?�	   <#�
+?��   9 N! (X
   V- 0   g6 &-.    �6 �� H-
F.   @' (- 0     Y6_;  	 7!(! A    X ^
�  L_9;  �! L('(-
 -
  h.   �'(' ( SH; -
� .    � '(' A?��-
 �S
 �S
  �SNNNNN.    	-6' ( SH; - .      �6' A? ��   � � � � ��C �w � �!!!!_9;  -0     !' (? -0     �' (_9; - 0      �6? - 0    !06-	
 0     !96 7!  �( 7! w( 7!  �( 7!  �( 7! !( 7! w( 7!!B( 7! !K(    � ��C!Z!` ��!w!!_9;  -.     !g' (? -.      !x' (
!� 7!!�( 7!  �( 7! w( 7! !( 7!!�(- !� 0   !�6- 0   !�6-	
 0     !96 7!!B( 7! !K(   !�!�!�
 �F> 
 CF; -0     !�6? -0     !�6
�F;  !�(
CF;  !C(
wF;  !w(
 �F;  ! �(  X!��!�!�-.    !�'('(SH; T'(_;  ,' ( SH; - 0    !�6' A? ��?  -0   !�6'A? ��  &  "G;  ! "(	  =L��+?��  p%p�  ") �  ʤ�  $� �  d��f  $��  �J-�  &f	�  �T  '*
�  SE�G  ,$
�  <���  -�� �أ�  .r�  W9<
  .�
y  �%;  0�?  �,�  6X�  2j��  7�
�  ��g�  8@  �pS  82R �x �  9f
  h~��  :R  �t�  ;F[ 4��=  C�
�  ��:  D�q  ���r  E.	�  s	�A  E�	�  �\a  F	} ,��  FN
  Hp��  IZ	  3��S  I�
  X���  J6U  ��hc  J��  G�%�  KB	�  P�_  N�� e@��  N� >  q��`  N�� �Ũ  O,
�  %m�z  O�W *R*�  P�S ��"�  Qdi �	[�  Q�� 7��  RZ�   � >    "F� >    "�� >    "�  %�� >   "�� >   "�  "�  #8  #�  #�  #�  $  $^  $z  ,F  ,X  ,l  3Z  4  4j  4�  52  5�  5�  6�  7>  :�  >8  D  OR/ >   "�t >   #� >   #[� > 	  #�  $+  $�  Ev  E�  E�  E�  E�  E�� >   #�  $?  N�� >    $�� >   $�  ;�  F�	 >   $�	 >    %  =�  >  I�  K	 >    %%	- >   %3  ,  Co  Ee  E�  I�  J�  K	} >   %c	� >    %q	� >    %{	� >    %�	� >    %�
 >    %�
 >    %�
, >   %�  '

> >    %�
T >    &  :
y >    &8
� >    &C
� >    &O
� >    &
� >    &�
� >    &�
� >   &�  F1[ >   &�  94  :#  ?  ?'q >    '� >   '�  ($  (�  )�  *�  +>  +�  +�  1:  1t  1�  1�  28  2t  2�  2�  38  3�  3�  4H  4�  5  5t  5�  6<� >   '�  (O  (�  *  *�  +g� >   (o  )? >    +�S >   ,�  -&  6�  7b  >[@ >   ,�  -8  N�b >   ,�  -MY >   ,�  -Y  O� >    ,�  -g� >   ,�  -�� >   -@ >   -�� >   -� >   -�P >    -�  D:  J>a >   .  8ui >   .  Dit >    .$y >    .0� >   .>� >   .J  C�  D�� >    .W� >    .d� >   .�� >    .� >   .�  /  8� >    .�  J�� >   /@ >    /i  /�  0)  0{  0�R >   /}  /�  0=  0�  0�� >   7�  J  J]� >    7�� >   7�� >   8) >   8�U >   9� >   9� >    9y� >   9�� >    9�W >   :�g >   :�  ;!  Kn  L  L7  N�� >   ;�  >�  F�  K-� >   ;�  >�  F�  IRW >   ;�  <  <9  <m  <�  <�  =  ?�  @  @y  @�  F�  G  GA  G�  G�  G�  H-  HaS > 
  =:  ?f  ?�  H�i >   =a  =�  =�  >}  >�  >�  A	  A)  AI  Ai  A�  A�  A�  B  B�  B�  B�  C	  C)  CI  H�  H�  I� >   >  Bg  B�  Ly  L�  L�  L�  L�  M  M-  MM  Mc  M{  M�  M�  M�  M�  N  N  N9  N{  N�  P+� >    >�� >   ?  C�  Fw  IC >    ?3S > 
  @A >    @�� >    C�� >    C�� >   C�  D�� >   D(� >    DF  D_� >    D�  E>� >   D�� >    E1	- >   F  O�� >   FF��    I�
� >   J  J�i >    Jo
 >    J~� >   KX  >    K�� >   Oq � >   O�! >   P � >   P!0 >   P=!9 >   PP  QD!g >   P�!x >    P�!� >   Q"!� >   Q2!� >   Q�!� >   Q�!� >   Q�!� >    R1  RJ      �  ",  "2  "8�  ".  "4  ":�  "0I  "6�  "<  P��  ">5  "@�  "B  '6  6\  "R  K�  K�  N�  N�  "X  ,  O$!	  "^  9   9�  :<  Bx  GT  I4  M   N�8   "b  "j  @v  @�  Cl.  "f  8�  BL  N^9  "n  8�  BX  NjD  "v  =�  =�  >  N,N  "~  9�  E�a  "�  %  %�r  "�  %   &  ;p-   "�  "�  #2  #~  #�  $X  3T  4   4d  4�  5,  5�  5�  >2  C�  OL�   "�N   "��   #6�  #r�   #v   #�  #�  $\�   #�  $  $j  6�  78  :�9   #��  #�  %@�  #�  $L  %H�   #�  $P  %L  %\	   $�   $n�  $r  <�  G�  M<  M��   $v  $�  I�  KJu   $��   $�  &r  ':  .�  8@  9n  :X  ;N  C�  D�  F  FT  Id  I�  J8  J��   $�  -�  FZ�   $��   $��   $��   $��   $�  ;�  F�	6   %0	q  %V  %�	�   %`	�  %�  &"	�^  %�  'B  '�  '�  '�  '�  (.  (4  (D  (L  (d  (l  (�  (�  (�  (�  )  )  )J  )n  )�  )�  )�  )�  )�  *  *  *z  *�  *�  *�  *�  +"  +F  +L  +\  +d  +�  +�  +�  +�  1"  1\  1�  1�  2   2\  2�  2�  3   3�  3�  4.  4�  4�  5Z  5�  6"  :�  :�  ;  ?r  ?�  ?�  @  @N  @�  @�  A  A&  AF  Af  A�  A�  A�  A�  Bd  B�  B�  B�  B�  C  C&  CF  C�  Ft  JN  L  L4  LH  Lv  L�  Nx  N�	�  %�  ;�  <  <F  <z  <�  <�  =  =F  =^  =�  =�  >  >z  >�  >�  ?  M�  M�  M�  M�  N  N  N6	�  %�  F�  G  GN  G�  G�  H  H:  Hn  H�  H�  H�  I  I@  L�  L�  L�  L�  M  M*  MJ  M`  Mx
\   &&  ,  9�
l  &.  &^
�  &h  .�  0�  84  :T  ;J  C�  F  FP  J�  O2?  &jE  &lK  &n  I`
�  &z    &�S  &�  8X  Ij  I�  J�  K�i   &�  ;\�  ',�  '.�  '0�  '2�  '4  O�  P�  Q��   '~�   (  (�  )�  *t  +�#  )P  )t  )�  *�  +(  -�  1(  1b  1�  1�  2&  2b  2�  2�  3&  3�  3�  44  4�  4�  5`  5�  6(  8&  8�  8�  8�  9�  9�  J  JT  J�  J�  J�  N�  )�  )�  .�  .�  .�  N�  O   +�    +�V   ,g  ,&o  ,(w  ,*�  ,,�  ,.;  ,0�  ,2�  ,4�   ,@  ,R  ,f�   ,D�   ,V�   ,jF   ,�  -6  N�q   ,�  ,��   ,��  -��  -�  8�  8��  -�  /0  9�  N��  -�>  -��   -��   -�   -�6   -�B  -�  C�  DV�  .�f  .��   .�  8F  9@  9t  :^  ;T  C�  D��   .��  .�  7�  7�  7�  7�  9�  :0  ?�  ?�  D�  D�  I�  L`  L��   .�  6�  7t  7�  ?�  E   I�  L�   .�  /(   /(  /J  /�  0  0h  0�/3  /F  /f  /z  /�  /�  /�  0  0&  0:  0d  0x  0�  0�  0�  0�  0�  1  1B  1H  1~  1�  1�  1�  2  2  2B  2H  2~  2�  2�  2�  3  3  3B  3H  3�  3�  3�  3�  4R  4X  4�  4�  5  5   5~  5�  5�  5�  6F  6Lj   1  1V  1�  1�  2  2V�   2�  2�  3�   3X�  3b  3z�   3�   4	  4  4&�   4h�  4r  4�   4�  4�  4��   50�  5:  5R   5�  5�  5��   5��  6  6L  6Z�  6^  6d  6n  6x  6�  6�  6�  6�  7  70  7x  7�  7�  7�  7�  8   6j  7   7,  9�  :4  ?�  D�  Ld"   6t,   6�9   6�A   6�V   6��   7<�   7�  8 �   7�  86  8N  8�
  88  8:  8<L   8�  8�@   8�9  8�  8�  D�  E  E$  8�u   8�c   8�^   8��   9�  9*  K�  LT  NP�   90  :   C��   9H  B,�  9h�  9j�   9��  9�  :  :  :B  ?J  K�.  :f  :�  @�  A�  B=  :l  :�  @�  A�  K�t
   :~  :�  ?`  ?d  ?�  ?�  ?�  ?�  ?�  @ n   :�d   :�M   :�  :�  ;  A"  A�  L  L.�   :�{  :�  :�  :�  ;o   :�  K��   :�  ;  L  L(�   ;
  L�  ;H�  ;d  ;x  >�  M�   ;�  ;�  <$  <X  <�  <�  <�  F�  F�  G,  Gj  G�  G�  H  HL   ;�  ;�  <(  <\  <�  <�  <�  =4  =8  F�  F�  G0  Gn  G�  G�  H  HP  H�  H�   ;�  F��   ;�  M��   ;�  F�  L�  L�  M�4   ;�  <2  <f  <�  <�  =  ?�  @
  @r  @�  G  G:  Gz  G�  G�  H&  HZ   <  G
  L�  M�   <  G  L�  M�D   <6  M�>   <B  GJ  L�  M��   <j  M��   <v  G�  G�  M  M&  M��   <�  M��   <�  H  MF  M�   <�  H*  MX  N   <�  H6  M\  N1   =
+   =  =�  Hj  Mt  N0c   =$  ?T  ?|  HxH   =B  =Z  >�  ?�  AB  A�  H�  H�w   =V  =�  >�  >�  H�  I  Q��   =�  >n  B�  B�  B�  B�  C  C>  H�  Qp  Q�}   =�  =�  >r  >�  H�  I�   =�  N(�   >6�  >B  >X�   ?  ?@�   ?$  B$   ?n  A  A�   ?�  Ll   ?�  @  Ab  A�  LB  Lp  L�n   @  L��   @(�   @:  @>  @d  @��   @J  B�  C   @h  @��   @�  B`  B�  C"  Nr   @�  B|  B�  CB  N�3  @�  @�  Ax<   @�  B>  EXC
   @�  A  A>  A^  A�  A�  A�  A�  Qz  Q�E  B4  BB  C\  Cd  NFM   BH  BT  NZ  NfP   BP  Nbk   Bt  N��   C�  C�  DN  D�  D��   D �  D
  D  D$�  D�  D�  E  E�   D�  EF�   D��  EN  E\  E��   Eb   Ep  E�  E�   Et  E�6   E�  E�  E�    E�  E�8   E�  E�M   E�_   F�  F�  F�   F,�  Fb  Fn�   F�  L��   G>  L�@   G~  M
Z   G�  M"t   G�  M8   G�  M@�   H^  Mp�  I\  I�  J�  KF�  I^  I�  J�  KH%   I�4   J{   J�   J��   J��   K�  KD  Q��   KN�   KV�  Kb  Kl  Kx  K��   Khw  K|  O�  Pj  P�  P�  Q  Q��   K��   K�     K�  N� -  K�  L$ 9  N� H  N� X  O.  Q� ^  O0 L  O6  OB h   OP�   Oj �   O� �   O�  O� �  O� �  O� �  O� �  O�  P� �  O�  P�C  O�  P�  Q� �  O�  P`  P�  P�  Q� �  O�  Pt �  O�  P~!  O�  P�  P�  Q!  O�  P�!  O�!  O�  P�!B  P�  QR!K  P�  Q\!Z  P�!`  P�!�   P�!�  P�!�  Q!�  Q!�  Qf!�  Qh!�  Qj �   Q�!�  Q�!�  Q�!�  Q�"  R^  Rj