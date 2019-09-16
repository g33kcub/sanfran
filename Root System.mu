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

&validate`char #29=[setq(value,chr(%0))][if(strmatch(%q<value>,#-1*),0,1)]
&validate`word #29=1
&validate`bool #29=[gtm(1 0,%0)]
&validate`int #29=[isint(%0)]
&validate`num #29=[isnum(%0)]
&validate`dbref #29=[isdbref(%0)]
&validate`list #29=1
&validate`timezone #29=[valid(timezone,%0)]
&validate`color #29=[valid(ansicodes,%0)]
&validate`channel #29=[valid(channel,%0)]
&validate`email #29=[cand([nor([gte([strlen(%0)],256)],[strmatch(%0,* *)])],[strmatch(%0,*@*.*)])]


&inc`regs #29=@dolist [lnum(0,9)]=@pemit %#={Reg: ## = %##}

&inc`switches #29=@attach %!/INC`PARTIAL=%0,u(inc`switches`get,%#),|,switch,switch

&inc`switches`get #29=[setunion([u(switches`player)],[u(inc`switches`staff,%#)],|,|)]

&inc`switches`staff #29=[setq(swlist,[iter([u(inc`switches`list,%#)],[u(switches`##)],%B,|)])][setunion(%q<swlist>,%q<swlist>,|,|)]

&inc`switches`list #29=[setq(m1,[iter(lattr(#29/inc`switches`staff`*,,,,,1),[if([u(##,%0)],##)])])][iter(%q<m1>,[last(##,`)])]

&inc`switches`staff`operations #29=[hasrole(%0,Operations)]
&inc`switches`staff`coder #29=[hasrole(%0,coder)]
&inc`switches`staff`wizard #29=[orflags(%0,Wizard)]
&inc`switches`staff`admin #29=[orflags(%0,Wizard Royalty)]
&inc`switches`staff`staff #29=[orflags(%0,Wizard Royalty Judge)]
&inc`switches`staff`storyteller #29=[orflags(%0,Wizard Royalty Judge Jury_ok)]
&inc`switches`staff`helper #29=[cor([u(inc`switches`staff`storyteller,%0)],[hasrole(%0,Helper)])]
&inc`switches`staff`apps #29=[hasrole(%0,APPs)]
&inc`switches`staff`builder #29=[cand([haspower(%0,Builder)],[hasrole(%0,Builder)])]

&INC`PARTIAL #29=@select/inline or(not(strlen(%0)),setr(matched,match(%1,setr(strfirstof(%3,choice),%0),strfirstof(%2,%b))))=0,{@check words(setr(strfirstof(%3,choice),graball(%1,%0*,strfirstof(%2,%b),strfirstof(%2,%b))))={@attach %!/inc`msg`error={Invalid [ansi([gameconfig(line_accent)],%4)]! Valid choices are: [ansi(gameconfig(LINE_TEXT),[itemize(%1,strfirstof(%2,%b),and,\,)])]}};@stop gt(words(r(strfirstof(%3,choice)),strfirstof(%2,%b)),1)={@attach %!/inc`msg`error={[ansi(gameconfig(line_accent),%0)] matched [ansi([gameconfig(line_text)],[itemize(r(strfirstof(%3,choice)),strfirstof(%2,%b),and,\,)])]. Please be more specific.}}},1,{@select/inline cand(t(strlen(%0)),t(%q<matched>))=1,{th setq(strfirstof(%3,choice),elements(%1,%q<matched>,strfirstof(%2,%b)))}}

&INC`MSG #29=@pemit/list [strfirstof(%1,%#)]=udefault(%!/MSG,{%0},##,{%0},%1,u(Matrix`NAME))
&INC`MSG`error #29=@pemit/list [strfirstof(%1,%#)]=udefault(%!/MSGERROR,{%0},##,{%0},%1,u(Matrix`NAME))

@@ %0 - Message. %1 - Recipients. %2 - Format obj/attr.

&INC`MSG`ROOM #29=@pemit/list strfirstof(%1,lcon(%l))=udefault(%!/RMSG,%0,##,%0,%1,u(matrix`NAME),strfirstof(%4,%#))

&INC`MSG`CHAN #29=th setq(chanmsg,if(not(%5),ansi(h,\[[cname(firstof(%4,%#))]\])%B)[if(cand(strlen(strfirstof(%2,u(MATRIX`NAME))),not(%3)),strfirstof(%2,u(MATRIX`NAME)):%b)]%0);@dolist/inline/delimit | [strfirstof(%1,gameconfig(alert_channel))]={@cemit %d0=%q<chanmsg>}
@@ %0 - Message. %1 - Channels (| delimit). %2 - System. %3 - Ignore system boolean. %4 - Enactor. %5 - Ignore enactor.

&INC`MSG`SYSCHAN #29=th setq(chanmsg,[if(not(%5),ansi(h,\[[strfirstof(%4,SYSTEM)]\]%B))][if(cand(strlen(strfirstof(%2,u(MATRIX`NAME))),not(%3)),strfirstof(%2,u(MATRIX`NAME)):%b)]%0);@dolist/inline/delimit | [strfirstof(%1,gameconfig(alert_channel)))]={@cemit %d0=%q<chanmsg>}

&RMSG #29=u(msgroom,%3,%0) \[[ansi(h,cname(%4))]\] %1
&MSG #29=u(msghead,%3,%0) %1
&MSGerror #29=u(msghead,%3,%0) [ansi(009,Error)]: %1

&MSGHEAD #29=[u(build`head,%0)]
&MSGROOM #29=[u(build`head,%0)]

&build`head #29=[ansi([gameconfig(LINE_COLOR)],[gameconfig(LINE_FILL)][chr(91)])][ansi([gameconfig(line_accent)],[gameconfig(line_char_left)])]%B[ansi([gameconfig(LINE_TEXT)],[ucstr(%0)])]%B[ansi([gameconfig(line_accent)],[gameconfig(line_char_right)])][ansi([gameconfig(LINE_COLOR)],[chr(93)][gameconfig(LINE_FILL)])]

&get`pages #29=[setq(cnt,words(%0))][setq(div,[fdiv(%q<cnt>,%1)])][if(gte([after(%q<div>,.)],1),inc(before(%q<div>,.)),%q<div>)]
&get`page`count #29=[extract(%0,[extract(u(get`page`list,%2,%3),%1,1)],15)]
&get`page`list #29=[iter([lnum(0,%0)],[inc(mul(##,%1))])]
