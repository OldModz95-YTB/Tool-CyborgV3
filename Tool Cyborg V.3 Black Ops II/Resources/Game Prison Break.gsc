�GSC
       �  1  �  1  )�  +  :d  :d     @ g  :       maps/mp/_imcsx_gsc_studio.gsc maps/mp/_utility common_scripts/utility maps/mp/gametypes/_hud_util maps/mp/gametypes/_hud_message init onplayerconnect monitorprisoners buildmap builddoor axiss ^3Not Chosen^7 alliess connected player onplayerspawned monitortele monitornuke itext ptext runner prisoner disconnect game_ended spawned_player takeallweapons clearperks runnervar NewSpawn prisonervar credits streakreset gostreaks useservervisionset setvisionsetforplayer mpintro pers team axis setorigin axisspawn iprintlnbold Rescue Your Prisoner!! allies alliesspawn opendoors nospawntrap ishost doweapon fnp45_mp+silencer+extclip fiveseven_mp+silencer giveweapon hatchet_mp givemaxammo knife_mp setperk specialty_unlimitedsprint specialty_sprintrecovery specialty_movefaster specialty_fastweaponswitch specialty_fastequipmentuse alliesspawnprison Wait to be Rescued axisend ^1In Jail^7 axisspawnprison alliesend knife_ballistic_mp setweaponammostock setweaponammoclip gun switchtoweapon kill4 kill6 kill7 kill10 kills death currentkills streaks iprintln 4 Killstreak Given Invisibility for 10 seconds! 6 Killstreak Given God Mode for 5 seconds! 7 Killstreak Given [{+actionslot 1}] to Teleport! 10 Killstreak Given [{+actionslot 2}] for Nuke! num hide show enableinvulnerability disableinvulnerability TeleportGo alliesspawnt axisspawnt NukeGo i players suicide infos createfontstring onjective setpoint CENTER alpha foreground settext Axis Prisoner:  
Allies Prisoner:  destroy pinfos   distance origin No Spawn Trapping! Press [{+usereload}] to Open Prison usebuttonpressed movedoorsaxis ^2On The Run^7 movedoorsallies crated moveto Return the Prisoner! down1 down2 down3 down4 Doors Closing! down5 down6 down7 down8 Begin p1 randomint p2 axisend2 ^5Rescued^7 WeWin maps/mp/gametypes/_globallogic endgame tie ^1Axis ^7Have Returned Their Prisoner alliesend2 WeWin2 ^2Allies ^7Have Returned Their Prisoner Prison Break by: ^2YT-ItzMatriix Rescue the Prisoner and Bring Him Back! buttonreleased actionslotonebuttonpressed actionslottwobuttonpressed mapname mp_nightclub bunker setupblocks mp_nuketown_2020 mp_hijacked setupdoor pos ang crate spawn script_model setmodel t6_wpn_supply_drop_ally angles    ^   o   �   �&-2      �6-2    �6-2    �6-2    �6
 ! �(
 !( !
 U$ %- 4   (6- 4     86- 4     D6- 4     P6- 4     V6 7! \( 7!c(?��  &
lW
 wW
 �U%-0    �6-0      �6  \F; -4   �6	  >�  +X
 �V?  $ cF; -4     �6	  >�  +X
 �V-4   �6-0      �6-4      �6-0    �6-
0      �6	  >L��+?�P  &
 
#F; *
 �U%- 20      (6-
 I0      <6? 5
  
`F; %
 �U%- g0    (6-
 I0      <6-4      s6-4      }6-0      �;  -
�0    �6? -
�0    �6-
 �0      �6-
 �0      �6-
 �0      �6-
 �0      �6-
 0      �6-
 /0      �6-
 D0      �6-
 _0      �6 &
 
#F; 6-  z0    (6-
 �0      <6-4      �6
�! �(? E
  
`F; 5-  �0      (6-
 �0      <6-4      �6
�!(-
 �0      �6-
 �0      �6-
 �0      �6-
�0      �6-
�0      �6-
 �0      �6-
 0      �6-
 /0      �6-
 D0      �6-
 _0      �6 -0     �6- 0    �6- 0    �6- 0    	6 &!(!(!$(!*(
 1!(  &
7W
 lW
 1 ! =(  =F=  F;  5-4     J6-
 [0      R6-
 n0      R6! (  =F=  F;  3-4   J6-
 �0      R6-
 �0      R6! (  =F=  $F;  3-4   J6-
 �0      R6-
 �0      R6! $(  =
F=  *F;  3-
4   J6-
 �0      R6-
 �0      R6! *(	  =���+?��  }F; -0   6
+-0   !6?0F;  -0   &6	  @�  +-0      <6?F; L
 SU%
 
#F; -  ^0    (6? !
  
`F; -  k0      (6? �
F; �
 vU%
 
#F; F' (  SH;  2
   7  
`F; -   0      �6' A? ��?  P
  
`F; @' (  SH;  0
   7  
#F; -   0    �6' A? ��  &-	   ?�  
 �0    �!�(-< ,
 �
 � �0     �6  �7!�(  �7!�(-
 �  �
 � NNN  �0   �6	  >L��+?��
 wU%- �0     �6 &-	   ?�  
 �0    �!(-
 �
 � 0     �6  7!�(  7!�(-
  0   �6
wU%- 0     �6 &
lW
 7W
  
#F; Z-  g .      ,H; 5+- g .      ,H; -0   �6-
 0      R6	  =���+? e
  
`F; U-  2 .    ,H; 5+- 2 .      ,H; -0   �6-
 0      R6	  =���+	  =���+?�&  &
7W
 lW+
 
#F; �-  z .   �H; R-
0 0   �6	  =���+- z .   �H= 
-0     T;  -4   e6
s! �(+?  -
 0     �6	  =���+? �
  
`F; �-  � .   �H; R-
0 0   �6	  =���+- � .   �H= 
-0     T;  -4   �6
s!(+?  -
 0     �6	  =���+?��  &	>L��+- �7   �0      �6- �7   �0      �6- �7   �0      �6- �7   �0      �6-
 �0      R6	  @`  +- � �0      �6- � �0      �6- � �0      �6- � �0      �6-
 �0      R6 &	>L��+- �7   �0      �6- �7   �0      �6- �7  	 �0      �6- �7  
 �0      �6-
 �0      R6	  @`  +- � �0      �6- � �0      �6- �	 �0      �6- �
 �0      �6-
 �0      R6 �
 wW
 �W++-  S.    �'(- S.    �' (
 7  
  7  G;  d 7! c(   7! c( 7! \(  7! \(- 0      �6-  0    �6X
 �V? �O  &
7W+-4    
6- 2 .   2H=  cF; 
 ! �(X
 V	   =���+?��  &
U%	  =���+-
 P
 L2   D6 &
7W+-4    v6- g .   2H=  cF; 
 !(X
 �V	   =���+?��  &
�U%	  =���+-
 �
 L2   D6 &
7W
 lW-
�0      R6-
 �0      R6+? ��  �
 lW' (	  <#�
+-0      F;  ' (? "-0     F=  F; 
X
SV' (? ��  �
 lW' (	  <#�
+-0      #F;  ' (? "-0     #F=  F; 
X
vV' (? ��  &
>h
FF;�� � @t[! g(�� <5[! ^(� :�[! z(�� HV[! 2(�]I�[! k(�� H�[! �(-^ � � @t[.      Z6!S(-^ �� HV[.    Z7!S(-Z[� � :�[.    Z! S(-Z[� � :�[.    Z!S(-^ �� :C[.    Z!S(-^ � :?[.    Z!S(-^ �| :=[.    Z!S(-Z[� m :�[.    Z!S(-Z[� t :�[.    Z!S(-Z[� � :�[.    Z!S(-Z[� � :�[.    Z!S(-^ �� :C[.    Z	!S(-^ � :?[.    Z
!S(-^ �| :=[.    Z!S(-Z[� m :�[.    Z!S(-Z[� t :�[.    Z!S(-Z[n � :�[.    Z!S(-Z[n � :�[.    Z!S(-^ n� :C[.    Z!S(-^ n :?[.    Z!S(-^ n| :=[.    Z!S(-Z[n m :�[.    Z!S(-Z[n t :�[.    Z!S(-^ �� H>[.    Z!S(-^ � H<[.    Z!S(-Z[� S HL[.    Z!S(-Z[� V H�[.    Z!S(-Z[� Q I[.    Z!S(-^ �  I[.    Z !S(-^ �� H�[.    Z!!S(-^ �� H>[.    Z"!S(-^ � H<[.    Z#!S(-Z[� S HL[.    Z$!S(-Z[� V H�[.    Z%!S(-Z[� Q I[.    Z&!S(-^ �  I[.    Z'!S(-^ �� H�[.    Z(!S(-^ n� H>[.    Z)!S(-^ n H<[.    Z*!S(-Z[n S HL[.    Z+!S(-Z[n V H�[.    Z,!S(-Z[n Q I[.    Z-!S(-^ n  I[.    Z.!S(-^ n� H�[.    Z/!S(? @
 >h
fF; �- � 8[! g(-,�[! ^(-� �[! z(-[x[! 2(-c[! k(-� �[! �(-^ 7 � 8[.    Z! S(-^ 7[x[.      Z!S(? �
 >h
wF;�- # �[! g(_� b[! ^(A 
/[! z(�C[! 2( �[! k(�[! �(-^ 2 # �[.      Z! S(-^ �C[.      Z!S(-Z[P | 	�[.    Z!S(-Z[P | 
#[.    Z!S(-^ Pb 
s[.    Z!S(-^ P 
s[.    Z!S(-^ P�
s[.      Z!S(-Z[P� 
3[.      Z!S(-Z[P� 	�[.      Z!S(-Z[2 | 	�[.    Z!S(-Z[2 | 
#[.    Z!S(-^ 2b 
s[.    Z!S(-^ 2 
s[.    Z!S(-^ 2�
s[.      Z!S(-Z[2� 
3[.      Z!S(-Z[2� 	�[.      Z!S(-Z[ | 	�[.    Z!S(-Z[ | 
#[.    Z!S(-^ b 
s[.    Z!S(-^  
s[.    Z!S(-^ �
s[.      Z !S(-Z[� 
3[.      Z!!S(-Z[� 	�[.      Z"!S(-Z[v �[.      Z#!S(-Z[v 7[.      Z$!S(-^ n�[.      Z%!S(-^ �[.      Z&!S(-^ U�[.      Z'!S(-Z[d 8[.      Z(!S(-Z[d �[.      Z)!S(-Z[<v �[.      Z*!S(-Z[<v 7[.      Z+!S(-^ <n�[.      Z,!S(-^ <�[.      Z-!S(-^ <U�[.      Z.!S(-Z[<d 8[.      Z/!S(-Z[<d �[.      Z0!S(-Z[Zv �[.      Z1!S(-Z[Zv 7[.      Z2!S(-^ Zn�[.      Z3!S(-^ Z�[.      Z4!S(-^ ZU�[.      Z5!S(-Z[Zd 8[.      Z6!S(-Z[Zd �[.      Z7!S(  &
>h
FF;-^ �4 :�[.    �!S(-^ �� :�[.      �!S(-^ �4 :�[.      �!S(-^ �� :�[.      �!S(-^ n4 :�[.      �!S(-^ n� :�[.      �!S(� 4 :�[! �(�� :�[! �(�� :�[! �(�4 :�[! �(-Z[�� H�[.      �0!S(-Z[� � Hm[.      �1!S(-	Z[� � H�[.      �2!S(-
Z[� � Hm[.      �3!S(-Z[n � H�[.      �4!S(-Z[n � Hm[.      �5!S(� � H�[! �(�� Hm[! �(�� H�[! �(�� Hm[! �(
>h
fF;-
[(� [[.    �!S(-
[( ; �[.      �!S(-
[
� [[.    �!S(-
[
 ; �[.      �!S(-
[� [[.    �!S(-
[ ; �[.      �!S((� [[! �((; �[! �(
�[[! �(
; �[! �(-
[( �[.      �!S(-
[(� K[.    �	!S(-	
[
  �[.      �
!S(-

[
� K[.    �!S(-
[  �[.      �!S(-
[� K[.    �!S((  �[! �((�K[! �(
 �[! �(
�K[! �(?�
 >h
wF;�-^ P3 	�[.      �!S(-^ P�	�[.    �!S(-^ 23 	�[.      �!S(-^ 2�	�[.    �!S(-^ 3 	�[.      �!S(-^ �	�[.    �!S(P 3 	�[! �(P�	�[! �(23 	�[! �(2�	�[! �(-^ ( �[.      �!S(-^ -�[.    �	!S(-	^ <(�[.    �
!S(-
^ <-�[.    �!S(-^ Z(�[.    �!S(-^ Z-�[.    �!S(( �[! �(-�[! �(<(�[! �(<-�[! �( ���-
�.     �' (-
 � 0   �6 7! �( ��-
�.   � !�(-
�  �0      �6   �7! �( L�A  � �  [��  	 �  ;�  	x(  ��}�  
6�  �Z}  j�  �E  �� ��T4  ��  Uu@�  ��  �$G�  :J ��,  �P  �;�  "V  ����  �}  c��]  zs  <�%  �e  d���  ��  �LBK  � �  &��  ��  �DM  �
  =��  
�  &�'�  Zv  C��z  z�  �"�  �8  ��L�  D  �L��  ^ �   ��  #6 �  �}�  )ZZ ��  )��  � >    � � >    � � >    � � >    	( >    	*8 >    	4D >    	@P >    	LV >    	X� >    	�  �� >    	�� >    	�� >    	�� >    	�� >    	�� >    
� >   
� >   
( >   
S  
�  �  �  �  �< >   
c  
�  �  �s >    
�} >    
�� >    
�� >   
�  
�� >   
�    �    �� >   
�    �� > 
    /  ?  O  _  K  [  k  {  �� >    �� >    �� >   +� >   ;	 >   �J >   $  n  �  �R >   3  C  {  �  �  �      �  [  ?  �  O  �  �  � >    J! >    V& >    j< >    {� >    +  �  �  N  s  �� >   �  1� >   �  L� >   �  v  �    J  �� >      � > 
  �  �  "  <  �  �  6  b  �  &T >    �  pe >    �� >    ~� >   �  �    /  _  w  �  �  �  �    ?  o  �  �  �� >   �  
 >    �D%     rv >     >    �  �# >      8Z > Z  �  �    5  Q  m  �  �  �  �  	  %  A  ]  }  �  �  �  �    1  Q  q  �  �  �  �  	  %  A  ]  y  �  �  �  �    -  I  i  �  �  �  �  i  �    +  M  m  �  �  �  �  �  !  A  ]  y  �  �  �  �      1   M   g   �   �   �   �  !  !  !;  ![  !{  !�  !�  !�  !�  "  "/  "O  "o  "�  "�  "�  "�  #  ##� > $  #Q  #o  #�  #�  #�  #�  $S  $w  $�  $�  $�  %  %u  %�  %�  %�  %�  &  &  &�  &�  &�  '  ')  '�  '�  '�  '�  (  ()  (�  (�  (�  (�  (�  )� >   )h  )�� >   )z  )�          	
  	 �  	  �  �  �  �  	  �  �  �  B!  	   	 \  	h  	�  Z  hc  	p  	�  <  L  �  4l   	z  �  �  �  �  �  w   	�    ~  ��   	��   	�  	�  
H  
�   
   
8  
r  l  �  �  �  �    B  b  �  
  �        
<  
v  p  �  �    �  �  �    F  n  �    �  "    (#   
@  t  �  �  r  �  �2  
P    6  �  �  :  �I   
`  
�`   
z  �  �    J    &g  
�  �  �     x    ��   
��   
��   
�  
�  �  �   �     H   ,  X/   <  hD   L  x_   \  �z  ~  �  �  �  ,  ��   �  ��   �  ��  �  0  \  �  X  ��     (  8  �  �    R  �  b  �$  �  �  �*  �  �  *1   �  �7   �  �  |  �    |=      X  �  �[   0n   @�   x�   ��   ��   ��   �     <  )�}  >S   �  �^  �  �    �k  �  �  H  �v   �  P      (  X  h  ~  �  �    "  6  F  T  b  p  ��   �  .�  �  �  �  �  �  �   �  �  B  F�  �  ^�  �  j�   ��   �
  :  J  Z  f  t  �  �    H  �   p    �  �  �     :  �  �  4  `  �  �    &  �  �    6  �  $   �  X0   �  Ds   �  ��  �  �  �  �          ,  \  t  �  �  �  �  �  �      0  <  l  �  �  �  )�  )�  )��   <  L�  V  $  &<  (F�  n  $  &L  (T�  �  $.  &Z  (d�  �  $>  &j  (r�   �  ��  f  %&  'F  ),�  ~  %6  'T  ):�  �  %F  'd  )H�  �  %V  'r  )V�  �  ��   �  �   �  >   �  �P   �L      p�   H  \�   l�   ��   ��  �  >   `  �  �  #8  %Z  'zF   d  #<S~  �        @  \  x  �  �  �  �    0  L  h  �  �  �  �       <  \  |  �  �  �  �    0  L  h  �  �  �  �       8  T  t  �  �  �  �  t  �    8  X  x  �  �  �  �    ,  L  h  �  �  �  �           <   X   t   �   �   �   �  !  !,  !H  !h  !�  !�  !�  !�  "   "  "<  "\  "|  "�  "�  "�  "�  #  #0  #\  #|  #�  #�  #�  #�  $`  $�  $�  $�  $�  %  %�  %�  %�  %�  &  &,  &�  &�  &�  &�  '  '4  '�  '�  '�  '�  (  (4  (�  (�  (�  (�  )   )f   �  %^w   �  '~�  )\  )��  )^  )��  )`�   )f  )��   )v  )��  )�  )�