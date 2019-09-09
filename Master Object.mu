@@------------------------------------------------------------------------------
@@ DBREF: #28
@@ Objid: #28:1567795784
@@ Purpose: This is the default parent for all system items. Every piece of code must be parented to it.
@@
@@-------------------------Sysmng Information (Default)-------------------------
&matrix`name #28=SYSTEM
&matrix`active #28=0
&matrix`locked #28=0
&matrix`ignored #28=0
&matrix`credit #28=Mr. Black ($g33kcub) @ Here, Seamus@MSB, Matrix@Due Rewards/WORA
&matrix`desc #28=A piece of the soft coded systems for the game.
&matrix`cmd #28=
&matrix`obj #28=
&matrix`req`def #28=#28:1567795784
&matrix`req #28=
@@------------------------------------------------------------------------------

@startup #28=@dolist [u(makelist)]={@function/preserve/privilege ##=#28/##;@function/min ##=[default(#28/##`min,0)];@function/max ##=[default(#28/##`max,-1)]};

&makelist #28=[setq(list,[iter([children(#28)],[get(##/functionlist)],%B,%B)])][setunion(%q<list>,%q<list>)]
