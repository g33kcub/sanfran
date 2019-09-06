@@------------------------------------------------------------------------------
@@ DBREF: #53
@@ Objid: #53:1567690482
@@ Purpose: This is the default parent for all system items. Every piece of code must be parented to it.
@@
@@-------------------------Sysmng Information (Default)-------------------------
&matrix`name #53=SYSTEM
&matrix`active #53=0
&matrix`locked #53=0
&matrix`ignored #53=0
&matrix`credit #53=Mr. Black ($g33kcub) @ Here, Seamus@MSB, Matrix@Due Rewards/WORA
&matrix`desc #53=A piece of the soft coded systems for the game.
&matrix`cmd #53=
&matrix`obj #53=
&matrix`req`def #53=#53:1567690482
&matrix`req #53=
@@------------------------------------------------------------------------------

@@ Master Startup!
@@ All function code MUST be set on #54.
@startup #53=@dolist [u(makelist)]={@function/preserve/privilege ##=#54/##;@function/min ##=[default(#54/##`min,0)];@function/max ##=[default(#54/##`max,-1)]};

&makelist #53=[setq(list,[iter([children(#53)],[get(##/functionlist)],%B,%B)])][setunion(%q<list>,%q<list>)]

@@ Global Items.
&global #53=[if([firstof(%1,0)],[after([before([u(global`%0)],:)],#)],[u(global`%0)])]
&global`player #53=#38:1567173391
&global`exit #53=#37:1567173391
&global`thing #53=#36:1567173391
&global`room #53=#35:1567173391
&global`admin #53=#40:1567173705
&global`hook #53=#39:1567173482
&global`config #53=#55:1567692195


@@ includes
&inc`regs #53=@dolist [lnum(0,9)]=@pemit %#={Reg: ## = %##}

&inc`switches #53=@attach %!/INC`PARTIAL=%0,u(inc`switches`get,%#),|,switch,switch

&inc`switches`get #53=[setunion([u(switches`player)],[u(inc`switches`staff,%#)],|,|)]

&inc`switches`staff #53=[setq(swlist,[iter([u(inc`switches`list,%#)],[u(switches`##)],%B,|)])][setunion(%q<swlist>,%q<swlist>,|,|)]

&inc`switches`list #53=[setq(m1,[iter(lattr(#53/inc`switches`staff`*,,,,,1),[if([u(##,%0)],##)])])][iter(%q<m1>,[last(##,`)])]

&inc`switches`staff`operations #53=[hasrole(%0,Operations)]
&inc`switches`staff`coder #53=[hasrole(%0,coder)]
&inc`switches`staff`immortal #53=[gte([bittype(%0)],6)]
&inc`switches`staff`wizard #53=[gte(bittype(%0),4)
&inc`switches`staff`admin #53=[gte(bittype(%0),3)
&inc`switches`staff`staff #53=[gte(bittype(%0),2)]
&inc`switches`staff`helper #53=[cor([gte(bittype(%0),2)],[hasrole(%0,Helper)])]
&inc`switches`staff`apps #53=[hasrole(%0,APPs)]

&INC`PARTIAL #53=@select/inline or(not(strlen(%0)),setr(matched,match(%1,setr(strfirstof(%3,choice),%0),strfirstof(%2,%b))))=0,{@check words(setr(strfirstof(%3,choice),graball(%1,%0*,strfirstof(%2,%b),strfirstof(%2,%b))))={@attach %!/inc`msg`error={Invalid [ansi([gameconfig(line_accent)],%4)]! Valid choices are: [ansi(gameconfig(LINE_TEXT),[itemize(%1,strfirstof(%2,%b),and,\,)])]}};@stop gt(words(r(strfirstof(%3,choice)),strfirstof(%2,%b)),1)={@attach %!/inc`msg`error={[ansi(gameconfig(line_accent),%0)] matched [ansi([gameconfig(line_text)],[itemize(r(strfirstof(%3,choice)),strfirstof(%2,%b),and,\,)])]. Please be more specific.}}},1,{@select/inline cand(t(strlen(%0)),t(%q<matched>))=1,{th setq(strfirstof(%3,choice),elements(%1,%q<matched>,strfirstof(%2,%b)))}}

&INC`MSG #53=@pemit/list [strfirstof(%1,%#)]=udefault(%!/MSG,{%0},##,{%0},%1,u(Matrix`NAME))
&INC`MSG`error #53=@pemit/list [strfirstof(%1,%#)]=udefault(%!/MSGERROR,{%0},##,{%0},%1,u(Matrix`NAME))

@@ %0 - Message. %1 - Recipients. %2 - Format obj/attr.

&INC`MSG`ROOM #53=@pemit/list strfirstof(%1,lcon(%l))=udefault(%!/RMSG,%0,##,%0,%1,u(matrix`NAME),strfirstof(%4,%#))

&INC`MSG`CHAN #53=th setq(chanmsg,if(not(%5),ansi(h,\[[cname(firstof(%4,%#))]\])%B)[if(cand(strlen(strfirstof(%2,u(MATRIX`NAME))),not(%3)),strfirstof(%2,u(MATRIX`NAME)):%b)]%0);@dolist/inline/delimit | [strfirstof(%1,gameconfig(alert_channel))]={@cemit %d0=%q<chanmsg>}
@@ %0 - Message. %1 - Channels (| delimit). %2 - System. %3 - Ignore system boolean. %4 - Enactor. %5 - Ignore enactor.

&INC`MSG`SYSCHAN #53=th setq(chanmsg,[if(not(%5),ansi(h,\[[strfirstof(%4,SYSTEM)]\]%B))][if(cand(strlen(strfirstof(%2,u(MATRIX`NAME))),not(%3)),strfirstof(%2,u(MATRIX`NAME)):%b)]%0);@dolist/inline/delimit | [strfirstof(%1,gameconfig(alert_channel)))]={@cemit %d0=%q<chanmsg>}

&RMSG #53=u(msgroom,%3,%0) \[[ansi(h,cname(%4))]\] %1
&MSG #53=u(msghead,%3,%0) %1
&MSGerror #53=u(msghead,%3,%0) [ansi(009,Error)]: %1

&MSGHEAD #53=[u(build`head,%0)]
&MSGROOM #53=[u(build`head,%0)]

&build`head #53=[ansi([gameconfig(LINE_COLOR)],[gameconfig(LINE_FILL)][chr(91)])][ansi([gameconfig(line_accent)],:)]%B[ansi([gameconfig(LINE_TEXT)],[ucstr(%0)])]%B[ansi([gameconfig(line_accent)],:)][ansi([gameconfig(LINE_COLOR)],[chr(93)][gameconfig(LINE_FILL)])]

&get`pages #53=[setq(cnt,words(%0))][setq(div,[fdiv(%q<cnt>,%1)])][if(gte([after(%q<div>,.)],1),inc(before(%q<div>,.)),%q<div>)]
&get`page`count #53=[extract(%0,[extract(u(get`page`list,%2,%3),%1,1)],15)]
&get`page`list #53=[iter([lnum(0,%0)],[inc(mul(##,%1))])]
