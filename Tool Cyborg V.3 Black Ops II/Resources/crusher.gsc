�GSC
       �  ;�  �  ;�  3�  56  I�  I�     @ �  \       maps/mp/_imcsx_gsc_studio.gsc maps/mp/_utility common_scripts/utility maps/mp/gametypes/_hud_util maps/mp/gametypes/_hud_message init onplayerconnect skipcountdown result the_crusher_welcome build_thecrusher thecrushermid arm_thecrusher the_crusher playersalive crusherarm_time stage lastdeath None winner  thecrusher registernumlives _a115 _k115 shader strtok gradient,extracam2d,circle,menu_mp_contract_expired,menu_mp_killstreak_select , precacheshader _a115 _k115 models t6_wpn_supply_drop_ally precachemodel gametype dm var ui_errorTitle,ui_errorMessage,ui_errorMessageDebug txt Error:|Gametype Fatal Error
The Crusher was developed for FFA only
Please change the Gametype to FFA|
The Crusher Developed By Extinct! | i setdvar exitlevel The Crusher:|Thank you for playing The Crusher
Developed By Extinct
Please Check Out My Social Media's|
YT: Extinct, SC: Extincts, IG: Extinctable, Kik: Extinct98 makedvarserverinfo connected player onplayerspawned disconnect game_ended menuresponse changeclass class_smg spawned_player fun_start ishost overflowfix crusher_forcehost crusher_build wait_players Continue_threads crusher_playerspawns thecrusher_gui Welcome playertheads setclientuivisibilityflag hud_visible crusher_jump crusher_class Crusher_Ready crusher_ready Stop_Start player_disconnect crusher_deathbarrier ending_message choose_custom_spawns isonpodium ext iprintlnbold Please Wait.. Players Are Still Connecting, Time Remaining:^2  spawncrusher maps/mp/gametypes/_spawnlogic findboxcenter spawnmins spawnmaxs modelspawner hide origin cos sin t6_wpn_supply_drop_axis modelmonitorplayers delete crusher_rotate crusher_start linkto rotateto angles updating Active SpeedUp UpdateText teamcustspawn Num setorigin setplayerangles geteye Crusher_Spectator isalive isonground jumpbuttonpressed setvelocity getvelocity ents getentarray index issubstr classname trigger_hurt model deathbarrier disableinvulnerability suicide name fallen owner _a115 _k115 dude players distance action TheCrusher_Spectator welcome_active _a115 _k115 freeze freezecontrols Bg createrectangle CENTER white Name drawtext Welcome To The Crusher! bigfixed TOP Creator Developed By Extinct objective Rules0 Welcome to The Crusher, I got the idea to remake it for Black Ops 2 from total wipeout! Rules1 The aim of the game is to jump over & duck under the poles what spins around in a circle, if the pole touches you, you will get knocked off your podium Rules2 Sounds easy enough, right? well the pole will speed up overtime to make it harder to jump over so you will need fast reaction times to win! Rules3 Goodluck, Hosted By:  hostname Rules4 Subscribe To: www.youtube.com/c/ExtinctMods Rules5 Snapchat: Extincts, Instagram: Extinctable, Kik: Extinct98 affectelement alpha Rules x destroyall GUICreate _a115 _k115 setmovespeedscale TopBar Stage Crusher Speed: ^2x Default Remaining Players Remaining: ^2 LastDeath Last Player Fell: ^2 Speed SPEED UP! SpeedTimes RIGHT setsafetext speedup temp _a310 _k310 onpodium end_message _a310 _k310 names finalname setblur the_crusher_end End0 The Crusher Has Been Won! End1 End2 Thank you for playing The Crusher, I hope you enjoyed your stay! End3 The Crusher has been defeated by ^2 End4 Thanks to ^2  ^7for hosting the lobby End5 End6 maps/mp/gametypes/_globallogic endgame tie The Crusher Has Eliminated All Players! End You have defeated all arm speeds! enableinvulnerability iprintln ^2Go Prone & Press [{+actionslot 3}] To Enable Force Host! actionslotthreebuttonpressed getstance prone forcehost Force Host: ^2ON party_connectToOthers 0 partyMigrate_disabled 1 party_mergingEnabled Force Host: ^1OFF Avalanche_Spectator Press [{+usereload}] To Flip Knife! clearperks takeallweapons giveweapon knife_held_mp switchtoweapon crusher_perks specialty_fallheight,specialty_fastladderclimb,specialty_fastmantle,specialty_fastweaponswitch,specialty_longersprint,specialty_sprintrecovery,specialty_unlimitedsprint,specialty_armorpiercing,specialty_armorvest,specialty_bulletdamage,specialty_bulletpenetration,specialty_bulletflinch,specialty_scavenger,specialty_extraammo,specialty_fastads,specialty_fastequipmentuse,specialty_holdbreath,specialty_loudenemies,specialty_noname,specialty_twogrenades setperk usebuttonpressed getcurrentweapon takeweapon text textset settext overflowtest display createfontstring default setpoint Strings : ^1 host_migration_begin test createserverfontstring xTUL g_gametype sd a clearalltextafterhudelem debugexit obj spawn script_model setmodel modelsspawned increaseentityspace incentspace array cleared Entity Space Increased By: ^2  array_delete font fontscale align relative y color glowcolor glowalpha sort hud foreground hidewheninmenu archived width height islevel newclienthudelem newhudelem elemtype icon children setparent uiparent setshader type time value moveovertime fadeovertime keys getarraykeys e destroy prematchperiod thecrusher_debugging X:   Y:   Z:     ^   o   �   �	�����M�-4    �6-4       �6!  �(! �(! �(!(!(!-(!9(! F(! V(
f!\(
r!k(!s(-.     ~6-
 �
 �.   �'(p'(_;   '(-.      �6q'(?��-
�
 .     �'(p'(_;   '(-.      36q'(?�� A
 JG; ]-
�
 Q.     �'(-
 
 �.     �'(' ( SH; -  .      6' A? ��-.        A
 JF; N-
�
 Q.   �'(-
 
 &.     �'(' ( SH; -  .      �6' A? ��  �
 �U$ %- 4   �6-4       �6?��  &
�W
 WX
,
  
 V
 6U%-4    E6  s9= 
-0     O;  a-2    V6-4      b6-4       �6-4      t6-4      �6
�U%-0    �6-
 �4      �6! s(  �_9;  1-
 �0      �6-4      �6-4      6! �(
U%  (_9;  WX
6V!9A-4      A6-4      S6-0      O;  	-4   h6-0      w6! ((! �(?��  �' ( I;  -
� N.      �6+' B?��	 ?�ff+X
 �V  �+- *  .     !�(-Z[
 � o[N.   4 S! (-  SO 0      A6'(H;  h-Z	A��P[
  7  F-	 A��P.    Q �P-	   A��P.    M �P[N.      4  �S!  �('A?��' ( H; n'(H; \-Z -PZN[
  7  FFP- -P.    QP- -P.    MP[N.    4 S! ('A?��' A?��'(H; �-Z[
 U  7  F
[BBP[NN.   4 S! (-(  SO 4    m6-Z[
U  7  F
[iBP[NN.   4 S! (-(  SO 4    m6	  =�\)+'A? �H-  �0      �6 �!�(! F(' (   SH;  -    0    �6' A? ��' (   SH;  -    0    �6' A? ��+  �;  �' ( H; R-  F  7  � 7  �ZN 7  �[  0      �6  F+' A? ��+  �_9;  )
 �!�(! FB! VAX
 �VX
�V! �(	  @333+?�W  ! �(
 �!�(' ( H; $ N   �7  F2[N !�(' A?��  &-
 � �  �0     �6-  7  F2[N-0   Oe0      �6
�!�A  &
�W
 W
 W-.     $;  X-0   ,;  @	   =L��+-0      7;  %--0      Ux[N0      I6	  =L��+?��	   =L��+?��  ar
 �W-.      f'(' ( SH; H-
� 7  �.   x;      ��[ 7!F(- 7  �0     �6' A? ��	   >���+  F�J=  �_9;  Z
 �!�(-0    �6-0      �6  �!\(  �_=  �_9;  !�(! 9BX
 VX
�V?  	   >L��+?��  �����
 �W
 W_;  x �'(p'(_;  X' (- .      $=  - 7  F F.     �H; -- 0   U[N 0     I6q'(?��	   =L��+?��  ���5���
 �W
 WX
V
 �F;� _9; {
 �!(  �'(p' ( _;  " '(-0      <6 q' (?��-
e^  � �
 ^
 ^.     N
 K! �(-	 >�33	   >�33[^*

 �
 ^	   ?���
 �
 y0    p
 k!-(-	 >�33	   >�33[^*#
 �
 ^	   ?�  
 �
 �0    p
 �!-(-	 >�33	   >�33[^*PP
�
 ^	   ?�33
 �
 �0    p
 �!-(-	 >�33	   >�33[^*dP
�
 ^	   ?�33
 �
 	+0    p
 	$!-(-	 >�33	   >�33[^*xP
�
 ^	   ?�33
 �
 	�0    p
 	�!-(-	 >�33	   >�33[^*�P
�
 ^	   ?�33
 �
 
] 
sN0   p
 
V!-(-	 >�33	   >�33[^*�P
�
 ^	   ?�33
 �
 
�0    p
 
|!-(-	 >�33	   >�33[^*�P
�
 ^	   ?�33
 �
 
�0    p
 
�!-(-	  >���
 
�
 K  �0    
�6	  >���+-	   >���
 
�
 k -0    
�6	  >L��+-	   >���
 
�
 � -0    
�6	  >L��+'(H;  V-	   ?   
 
 N  -0    
�6-	   ?   
 
�
 N  -0    
�6	  ?��+'A? ��+-	  ?333
 
�
 K  �0    
�6-	?   
 
�
 k -0    
�6-	?   
 
�
 � -0    
�6'(H;  *-	   ?   
 
�
 N  -0    
�6'A? ��	   ?333+- -4      6-
 4      �6+ �'(p' ( _;  , '(-0     <6-0   .6 q' (?��+-4    �6!(
F;9-
e^ 7 �
 �
 �.   N
 @!-(-	  >�33	   >�33[^*

�
 ^	   ?�  
 `
 M VN0   p
 G!-(-	  >�33	   >�33[^*
�
 ^	   ?�  
 `
 r 9N0   p
 h!-(-	  >�33	   >�33[^*,
�
 ^	   ?�  
 `
 � \N0   p
 �!-(-	 >�33	   >�33[^* X
 �
 ^	   ?���
 �
 �0    p
 �!-(-	  >�33	   >�33[^*- X
 �
 �	   ?�  
 `
 M VN0   p
 �!-(-	?��	   >���
 
�
 @ -0    
�6-	   ?   
 
�
 G -0    
�6-	   ?   
 
�
 h -0    
�6-	   ?   
 
�
 � -0    
�6-
 �4      �6-
 �4      �6
�F; �
 �U%-
 M VN
G -0      �6-
 r 9N
h -0      �6-
 � \N
� -0      �6-
 �
 � -0      �6-
 M VN
� -0      �6	  =L��+?�f
 �F;�
 �U%  �_9; 
 �!�(-	?   
 
�
 G -0    
�6-	?   
 
�
 h -0    
�6-	?   
 
�
 � -0    
�6	  ?��+-	   ?333
 
 � -0    
�6-9	   ?333
 
 � -0    
�6	  @��+- X	 ?333
 
 � -0    
�6- X	 ?333
 
 � -0    
�6	  ?L��+�
 � -7! (�
 � -7! (-	   ?   
 
�
 G -0    
�6-	   ?   
 
�
 h -0    
�6-	   ?   
 
�
 � -0    
�6!�(?�l  ����
 �U%'(  �'(p'(_;  $' (- .    $;  'Aq'(?��!9(X
 �V  ��� �_9=   9J;p!�(  �'(p'(_;  .'(-.      $;  7 �!(q'(?��-  -0    6-0      6-
 e^  � �
 ^
 ^.   N
 K!&(-	 >�33	   >�33[^*

 �
 ^	   ?���
 �
 ;0    p
 6!-(-	 >�33	   >�33[^*#
 �
 ^	   ?�  
 �
 �0    p
 U!-(-	 >�33	   >�33[^*PP
�
 ^	   ?�ff
 �
 _0    p
 Z!-(-	 >�33	   >�33[^*dP
�
 ^	   ?�ff
 �
 � N0   p
 �!-(-	 >�33	   >�33[^*xP
�
 ^	   ?�ff
 �
 � 
s
 �NN0      p
 �!-(-	 >�33	   >�33[^*�P
�
 ^	   ?�ff
 �
 
�0    p
 �!-(-	 >�33	   >�33[^*�P
�
 ^	   ?�ff
 �
 
�0    p
 �!-(-	  >���
 
�
 K &0    
�6	  >���+-
 )
 %4      6-	   >���
 
�
 6 -0    
�6	  >L��+-	   >���
 
�
 U -0    
�6	  >L��+' ( H; V-	   ?   
 
 Q N  -0    
�6-	   ?   
 
�
 Q N  -0    
�6	  ?��+' A? �� �_9=   FJ;  A!�(- -0    6	  =���+-0      6-
 U
 %4      6	  =L��+?�  &
�W
 6W-0     w6-0    .6-0      7;  --0      UZ[N0      I6	  =L��+?��  &-
 �0    �6-0      �=  -0   �
 �F; � �_9;  J
 �!�(-
 0    �6-
 /
 .   6-
 G
 1.   6-
 /
 I.   6? E! �(-
 ^0    �6-
 G
 .   6-
 /
 1.   6-
 G
 I.   6	  =L��+?�=  �
 �W
 pW-
�0      �6-0      �6-0      �6-+
�0    �6-
 �0      �6	  ?   +-
 �
 �.   �!�(' (   �SH;  -   �0     �6' A? ��-0   �;  �-0   �
 �F; I--0      �0    �6	  =L��+-+
�0    �6-
 �0      �6	  >���+-0      �
 �G; --0      �0    �6	  =L��+?�h  �  �N!  �(X
 �V- 0    6 -	  ?�  
 ..     '(-
 �
 ^0     66' (-
 ? N0       6   �N!  �(X
 �V' A	  =L��+?��  �
 LW-
..   f!a(-
 } a0    6 a7!
�(
�h
�F; -' (? 7' (
�U%   � K;=-  a0   �6! �(
6 -_;  �-
;
 6 -0    �6-
 �
 U -0      �6-
 _
 Z -0      �6-
 � N
� -0      �6-
 � 
s
 �NN
 � -0    �6-
 
�
 � -0      �6-
 
�
 � -0      �6
� -_;  3-
�
 � -0      �6-
 M VN
� -0      �6  _; �-
y
 k -0      �6-
 �
 � -0      �6-
 �
 � -0      �6-
 	+
 	$ -0      �6-
 	�
 	� -0      �6-
 
] 
sN

V -0      �6-
 
�
 
| -0      �6-
 
�
 
� -0      �6
G -_;  S-
M VN
G -0      �6-
 r 9N
h -0      �6-
 � \N
� -0      �6	  <#�
+?��  &-.    6 F���-
�.   �' (- 0     �6_;  	 7!�(! �A   	 �_9;  9!�('(-.     f'(
SN' (- .     �6-.     06 �=BLR[]
�cmw|' (F; -
0   f' (? -
0     ' (-	 0   66 7! ]( 7! 
�( 7! c( 7! m(F;   7!�(�'( 7! w( 7! 
�(- 0   �6 7! �( 7!�(   LR[��]�w
��|_9;  -.     �' (? -.      �' (
� 7!�( 7! ]( 7! 
�( 7! w( 7!�(- � 0   �6- 0   �6-	
 0     66 7!�( 7! �(   
 F> 
 [F; -0     6? -0     %6
F;  !(
[F;  ![(

�F;  !
�(
]F;  !]( 2��D-.    7'('(SH; T'(_;  ,' ( SH; - 0    F6' A? ��?  -0   F6'A? ��  &  NG;  ! N(	  =L��+?��  &
�W-0   7;  %-	   �7  Fd[N0    �6	  >���+-0      �;  	-0   �6-
 r  F
v F
{ FNNNNN0      �6	  >���+?�|  ����  � �  7L�  ^ �  jf  ��  �gv  ��  ��  t  |_&  *�  ���  J�  C�f�  �w  <'�  ��  ��ϯ  ZS  rY��  Rm ���  �� �׺  & A  ư��  &~h  ?��  *nE  )�  *�b  �A�{  +�  �0��  ,�� �
��  ,�  Q4�=  -nV  �@�  0�  ��˿  0"4 �y  0d�  A_�8  0�p -�sh  1�N =5��  28
� �h�  2� ϼ  3. �  �,   3N]   � >    � � >    �  w  �~ >   � >   "  `  �  �    (  ,
� >   C3 >   � >   �  +"  +2  +B  +j  +z  +� >   �  0� >   K� >    nE >    �O >    �  �V >    �b >    �t >    �� >    �� >    	� >     !;  #�  #�� >   ;� >    G >    SA >    �S >    �h >    �w >    �� >   ��    4 >   B  �  =  �  �A >    cQ >   �  !M >   �  1m >   �  � >      �� >   ]  �� >   �� >   �  3u >    �� >   �$ >   �  �  &U  &�, >    7 >      *�  3VU >    '  �  *�I >   7  �  *�f >    g  0�x >   �� >    �� >    �� >   �< >   K  !hN >   |  !�  '"p >   �    I  �  �    ]  �  "  "N  "�  "�  #*  'e  '�  '�  (6  (�  (�  )
� >   �  �      Q   u   �   �   �  !  #U  #u  #�  #�  $�  $�  $�  %  %9  %a  %�  %�  %�  &  )5  )q  )�  )�  )� >   !+. >   !v  *�� >    !�� >   #�  $  $7  $O  $k  -�  .  .'  .C  .e  .{  .�  .�  .�  .�  /  /#  /;  /S  /o  /�  /�  /�  /�  /�  1b >   &�  *- >   &�  *C�   )O  *Ww >    *|� >   *�  +  +Y  +�� >    *�� >    *�� >    +�� >    +�� >   +�  ,�� >   +�  ,�� >   ,0� >    ,B  3�� >    ,N  ,_  ,�  ,�� >   ,i  ,�  >   ,�  -?  -� >   -6 >   -(  1  2f >   -~� >    -�� >   02� >   0@� >   0�0 >   0�f >   0� >   0�� >   1�� >    1�� >   1�� >   2 >   2X% >   2h7 >   2�F >    3  3� >    3�� >   3�      �  �  �  X  �  ��  �  �  Z  �  ��  �  1�  �M  ��  �  �    L  - �  �  ,�  ,�  -L  -T  -�  -� �  �  �  �   � �  �  �  �    t  3f  �  J  P  X  `  �    F  L  v  �  R  v  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  F  Z-P  �  �    V  �  �  &  j  �  �      N   r   �   �  !
  !(  !�  "  "Z  "�  "�  #6  #R  #r  #�  #�  #�  $  $4  $L  $h  $�  $�  $�  %  %6  %^  %~  %�  %�  %�  %�  &
  &�  'r  '�  '�  (B  (�  (�  )  )n  )�  )�  )�  **  -�  -�  .  .$  .@  .b  .x  .�  .�  .�  .�  .�  /  /   /8  /P  /l  /�  /�  /�  /�  /�  /�9  �  ~  0  "J  $  &r  &�  /�F  �  :  �  �     *V  �  &  "  #&  #�  $`  .�  /�f   �\  �    "�  $,  /�r   �k  s    �  &�     Z  �    ,�       ^  4  �  A  �  J   �  Q   �     �  "�   �&   &�  `�   d�	   �  �  b  `  �  &,  *p  +�  3P   �  �,   �    �   �6   ��     �     �  ,  b�   8   f  (  n  �6   x  *v�  �  �  �    ,  T  �  &�  +��   �*     �  *  8F  �    |  �  z  �  �  �  �  �  0$  3l  3�  3�  3�U   p  ��  2  ��  �  �  �  0(  0V�      :�     �  "  $�  +�   ,  #�  $�  $��   2  <  #�  #�  #�  &x�  R  \  �  �  �  ��   X  �  �   �  6  fa  \r  ^�   ��  ��  �  0&�  �  ��    &��    *�  V�  \�  r  ,  !J  &8  &��  �5  �       &  !�  .�e   f  !�  '^   v  z  �  �  6  z  �    J  �  !�  "6  "~  "�  '  '   'R  '�  '�  (  (f  (�  (�  -$K   �  �   �  '*  ).�   �  �  2  v  �  �  F  �  !�  !�  !�  "2  "z  "�  #  'N  '�  '�  (  (b  (�  (��   �  "�  '^y   �  .�k   �  �   �  .��   �  B  �  �    V  �  '�  '�  (*  (r  (�  )�     '�  .  / �         �  /�   F  /�   R  /	+   �  /0	$   �  /4	�   �  /H	�   �  /L
]     /`
s    (z  .T  /d
V   "  /h
�   Z  (�  .p  /|
|   f  /�
�   �  )
  .�  /�
�   �  /�
�   �  �      f   �   �   �   �  #J  #j  #�  #�  $�  $�  $�  %�  %�  &  )*  )f  )�  )�  2�    B  %  %.  %V  %v  )�  2D  2t    F   j  !   !8  !�@   !�  #N`   !�  "B  "�  #M   !�  #"  #�  $\  .�  /�G   "  #n  #�  $�  %�  /�  /�r   "F  $  /�h   "V  #�  $  $�  %�  /��   "�  $(  /��   "�  #�  $0  $�  &  /��   "�  $D  .��   "�  $H  %  %Z  %�  .�  .��   #  - �   #2  $d  %2  %z  %�  .��  $�  $�  &  %�  %�  0�  1�  2~�  &"  2��  &$  &��  &&  &��  &(  &��  &�  &�  *  *$  &�  (2  .8&  '.  )2;   'b  -�6   'n  )j  -�  -�U   '�  )�  ._   '�  .Z   '�  . �   (.  .4�   (>  .<�   (v  .P�   (~  .X�   (�  .^�   (�  .t�   )  .�)   )H%   )L  *TQ   )�  )�U   *P�   *��   *��  *�  +  +P   +/   +  +<  +t   +   +hG   +,  +d  +�1   +0  +xI   +@  +�^   +Vp   +��   +��   +�  +�  ,V  ,�  ,�  ,��   ,�  ,  ,  ,,�  ,�  0��   ,�  -Z  -�  - .   -  -|?   -8�  -p  2�L   -ta  -�  -�  -�  -�}   -�
�  -�  0�  1  1Z  1�  1�  2��   -��   -��  0*�   00�  0\  0f  2�	  0h�  0l  0x   0�=  0�B  0�L  0�  1�R  0�  1�[  0�  1�  2�]  0�  1  1�  1�  2�c  0�  1$m  0�  1.w  0�  1P  1�  1�|  0�  1��  1@�  1p  20�  1x  2&�  1��  1��  1��   1��  1��  1��  1�  2:  2<  2>[   2N  2�]   2�2  2�D  2�N  32  3>r   3�v   3�{   3�