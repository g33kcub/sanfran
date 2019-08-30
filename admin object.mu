@startup #40=@trigger me/build_lines;@wait 2={@admin/save};@wait 3={@admin/execute}
&build_lines #40=@dolist [lattr(#40/build`*)]=&_line[sub(#@,1)] #40=[u(##)]

&build`exit #40=global_parent_exit [after([u(#34/global`exit)],#)]
&build`player #40=global_parent_player [after([u(#34/global`player)],#)]
&build`thing #40=global_parent_thing [after([u(#34/global`thing)],#)]
&build`room #40=global_parent_room [after([u(#34/global`room)],#)]
&build`hook #40=hook_obj [after([u(#34/global`hook)],#)]
&build`attach #40=alias @attach @include/override
&build`stop #40=alias @stop @break/inline
&build`check #40=alias @check @assert/inline
&build`select #40=alias @select @switch/first
&build`tree_character #40=tree_character `
&build`sys #40=atrperms SYS:6:6
&build`wod #40=atrperms WOD:6:6
&build`org #40=atrperms ORG:6:6
&build`setq #40=penn_setq yes
