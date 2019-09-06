
@@-------------------------Sysmng Information-----------------------------------
&matrix`name #40=ADMCONF
&matrix`active #40=1
&matrix`locked #40=1
&matrix`ignore #40=1
&matrix`credit #40=Mr. Black ($g33kcub) @ Here, Seamus@MSB, Matrix@Due Rewards/WORA
&matrix`desc #40=This is the object that sets the rhost_ingame.conf
&matrix`cmd #40=
&matrix`obj #40=#40:1567173705
&matrix`req #40=
@@------------------------------------------------------------------------------


@startup #40=@trigger me/build_lines;@wait 2={@admin/save};@wait 3={@admin/execute}
&build_lines #40=@dolist [lattr(#40/build`*)]=&_line[sub(#@,1)] #40=[u(##)]

&build`exit #40=global_parent_exit [u(global,exit,1)]
&build`player #40=global_parent_player [u(global,player,1)]
&build`thing #40=global_parent_thing [u(global,thing,1)]
&build`room #40=global_parent_room [u(global,room,1)]
&build`hook #40=hook_obj [u(global,hook,1)]
&build`select #40=alias @select @switch/first
&build`tree_character #40=`
&build`sys #40=atrperms SYS:6:6
&build`BESM #40=atrperms BESM:6:6
&build`org #40=atrperms ORG:6:6
&build`setq #40=penn_setq yes
&build`matrix #40=atrperms MATRIX:6:6
&build`trace #40=trace_output_limit 2000
