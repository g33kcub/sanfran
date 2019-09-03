@@ Code #46
@@ Role DB: #47

@@------------------------System Management Stuff-------------------------------
@@ Do not remove. Edit as needed.
@@------------------------------------------------------------------------------

&inc`regs #46=@dolist [lnum(0,9)]=@pemit %#={Reg: ## = %##}

&inc`switches #46=@attach #46/INC`PARTIAL=%0,u(inc`switches`get,%#),|,switch,switch

&inc`switches`get #46=[setunion([u(switches`player)],[u(inc`switches`staff,%#)],|,|)]

&inc`switches`staff #46=[setq(swlist,[iter([u(inc`switches`list,%#)],[u(switches`##)],%B,|)])][setunion(%q<swlist>,%q<swlist>,|,|)]

&inc`switches`list #46=[setq(m1,[iter(lattr(#46/inc`switches`staff`*,,,,,1),[if([u(##,%0)],##)])])][iter(%q<m1>,[last(##,`)])]

&inc`switches`staff`operations #46=[hasrole(%0,Operations)]
&inc`switches`staff`coder #46=[hasrole(%0,coder)]
&inc`switches`staff`immortal #46=[gte([bittype(%0)],6)]
&inc`switches`staff`wizard #46=[gte(bittype(%0),4)
&inc`switches`staff`admin #46=[gte(bittype(%0),3)
&inc`switches`staff`staff #46=[gte(bittype(%0),2)]
&inc`switches`staff`helper #46=[cor([gte(bittype(%0),2)],[hasrole(%0,Helper)])]
&inc`switches`staff`apps #46=[hasrole(%0,APPs)]

&role`apps #47=1
&role`apps`list #47=#2:1567167909
&role`operations #47=1
&role`operations`list #47=#2:1567167909
&role`coder #47=1
&role`coder`list #47=#2:1567167909
&role`helper #47=1

&matrix`name #46=SYSTEM

&INC`PARTIAL #46=@select/inline or(not(strlen(%0)),setr(matched,match(%1,setr(strfirstof(%3,choice),%0),strfirstof(%2,%b))))=0,{@check words(setr(strfirstof(%3,choice),graball(%1,%0*,strfirstof(%2,%b),strfirstof(%2,%b))))={@error %#=[get(%!/matrix`name)]/%#/{Invalid [ansi([gameconfig(line_accent)],%4)]! Valid choices are: [ansi(gameconfig(LINE_TEXT),[itemize(%1,strfirstof(%2,%b),and,\,)])]}};@stop gt(words(r(strfirstof(%3,choice)),strfirstof(%2,%b)),1)={@error %#=[get(%!/matrix`name)]/%#/{[ansi(gameconfig(line_accent),%0)] matched [ansi([gameconfig(line_text)],[itemize(r(strfirstof(%3,choice)),strfirstof(%2,%b),and,\,)])]. Please be more specific.}}},1,{@select/inline cand(t(strlen(%0)),t(%q<matched>))=1,{th setq(strfirstof(%3,choice),elements(%1,%q<matched>,strfirstof(%2,%b)))}}
@@ PARTIAL %0 = entry, %1 = choices, %2 = delimiter, %3 = register name, %4 = topic name


&build`head #46=[ansi([gameconfig(LINE_COLOR)],[gameconfig(LINE_FILL)][chr(91)])][ansi([gameconfig(line_accent)],:)]%B[ansi([gameconfig(LINE_TEXT)],[ucstr(%0)])]%B[ansi([gameconfig(line_accent)],:)][ansi([gameconfig(LINE_COLOR)],[chr(93)][gameconfig(LINE_FILL)])]
