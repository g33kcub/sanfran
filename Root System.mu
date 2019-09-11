@@------------------------------System Information------------------------------
@@ DB: #29
@@ OBJID: #29:1568211773
&matrix`name #29=ROOT
&matrix`desc #29=The core system settings and files.
&matrix`obj #29=#29:1568211773 #30:1568212686 #31:1568212922
&matrix`sys #29=#29:1568211773
&matrix`cmd #29=
&matrix`credit #29=The Hope @ San Fransokyo MUSH, Volund @ VolundMUSH Suite @ Github
&matrix`hasfn #29=0
&matrix`hasstart #29=0
&matrix`hasconf #29=0
&matrix`hasfiles #29=0
@@ #30
&matrix`hasstart #30=1
&matrix`hasconf #30=1
@@ #31
&matrix`hasfn #31=1
@@----------------------------Configuration Options-----------------------------
@dolist #29 #30 #31={@set ##=inherit safe no_command}
@dolist #30 #31={@parent ##=#29}

&config`line_fill #30=-
&config`line_fill`category #30=COSMETIC
&config`line_fill`type #30=WORD

&config`line_color #30=+indianred3
&config`line_color`category #30=COSMETIC
&config`line_color`type #30=COLOR

&config`line_text #30=+white
&config`line_text`category #30=COSMETIC
&config`line_text`type #30=COLOR

&config`line_accent #30=+lightgoldenrod1
&config`line_accent`category #30=COSMETIC
&config`line_accent`type #30=COLOR

&config`line_char #30=58
&config`line_char`category #30=COSMETIC
&config`line_char`type #30=CHAR

&config`bracket_right #30=93
&config`bracket_right`category #30=COSMETIC
&config`bracket_right`type #30=CHAR

&config`bracket_left #30=91
&config`bracket_left`category #30=COSMETIC
&config`bracket_left`type #30=CHAR

@@------------------------------Command Break Down------------------------------
@@-------------------------------Global Functions-------------------------------
@@-------------------------------Local Functions--------------------------------
&global #29=[if(strfirstof(%1,0),[before([get(#30/global`%0)],:)],[get(#30/global`%0)])]
&system`name #29=[default(%0/matrix`name,SYSTEM)]
&width #29=[width(%0,80)]
&height #29=[height(%0,23)]
@@------------------------------------------------------------------------------
@@ Default Globals
&global`root #30=#29:1568211773
&global`data #30=#30:1568212686
&global`functions #30=#31:1568212922

@@ Global Startup For Functions
@startup #29=@dolist/inline [u(startup`makelist)]={@function %i0=[u(global,functions)],%i0};

&startup`makelist #29=[setq(list,[iter([filter(fil`hasfn,[children(#29)])],[get(##/startup`functions)],%B,%B)])][setunion(%q<list>,%q<list>)]

&fil`hasfn #29=[default(%0/matrix`hasfn,0)]

&validate`char #29=th [setq(value,chr(%0))][if(strmatch(%q<value>,#-1*),0,1)]
&validate`word #29=1
&validate`bool #29=[gtm(1 0,%0)]
&validate`int #29=[isint(%0)]
&validate`num #29=[isnum(%0)]
&validate`dbref #29=[isdbref(%0)]
&validate`list #29=1
&validate`timezone #29=[valid(timezone,%0)]
&validate`color #29=[valid(ansicodes,%0)]
&validate`channel #29=[valid(channel,%0)]
