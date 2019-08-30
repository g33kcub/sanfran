@@ #34


@@------------------------------------------------------------------------------
@@ General Functions and Insanity.
@@
@@ Functionlist                          - Stores the functions to be made global.
@@ hasrole(player,role)                  - A boolean check for roles. (Uses Role Concept)
@@ roles(player)                         - Lists all the roles of the player. (Uses role concept.)
@@ width(player)                         - Sets the system width based on player settings (Uses GUI Concept: @width)
@@                                         Defaults to 80
@@ ispowered(player)                     - Backend check if the player has a staff flag.
@@ gtm(list,item,Delim)                  - Checks to see if the list contains the item. Delimiter is optional.
@@ safepassword()                        - Generates a secure safe password for the system. It's backend only.
@@ caps(phrase)                          - Capitalizes every word in the phrase regardless of special characters.
@@ su(info)                              - Replaces spaces with _ and changes : to ", and vice versa. Used for attribute conversions.
@@ cnum(number)                          - Prettifies a number with the appropriate commas.
@@ numth(number)                         - Returns the correct ordinal of a number.
@@ strfirstof(data,data)                 - A wraparound to give pennmush's strfirstof.
@@ firstof(data,data)                    - A wraparound to give pennmush's firstof.
@@ gameconfig(config)                    - To get global config data for stuff for the game. (Uses GUI Concept: @gameconfig)
@@ line(text,type,dbref,text/width,text) - Generates a Line. (Uses GUI Concepts.)
@@------------------------------------------------------------------------------
@startup #34=@dolist [u(functionlist)]={@function/preserve/privilege ##=#34/##};

&functionlist #34=safepassword caps cnum numth gtm ispowered width su hasrole roles line firstof strfirstof gameconfig

&hasrole #34=[u(gtm,[get(%0/SYS`ROLES)],[ucstr(%1)])]

&roles #34=[sort([get(%0/SYS`ROLES)])]

&width #34=[default(%0/SYS`WIDTH,80)]

&ispowered #34=[gte([bittype(%0)],2)]

&gtm #34=[gte([match(%0,%1,%2)],1)]

&safepassword #34=[u(su,[squish([scramble(digest(md5,secs()))])])]

&caps #34=regeditalli(lcstr(%0),v(REG`CAPNAMES),capstr($1),v(REG`CAPNAMES3),lcstr($0),v(REG`CAPNAMES2),$1[capstr($2)])

&REG`CAPNAMES #34=(?:^|(?<=[_\/\-\|\s()\+]))([a-z]+)
&REG`CAPNAMES2 #34=(^|(?<=[(\|\/]))(of|the|a|and|in)
&REG`CAPNAMES3 #34=\b(of|the|a|and|in)\b

&SU #34=[u(su`[strmatch(%0,*_*)],%0)]
&SU`0 #34=[edit([edit(%0,%B,_)],:,")]
&SU`1 #34=[edit([edit(%0,_,%B)],",:)]

&CNUM #34=squish(flip(foreach(#lambda/if(mod(\%1,3),\%0,\\,\%0),flip(%0))),\,)
&numth #34=%0[switch(%0,11,th,12,th,13,th,switch(right(%0,1),1,st,2,nd,3,rd,th))]

&STRFIRSTOF #34=ofparse(5,%0,%1,%2,%3,%4,%5,%6,%7,%8,%9)

&FIRSTOF #34=ofparse(1,%0,%1,%2,%3,%4,%5,%6,%7,%8,%9)

&gameconfig #34=[get([u(Global`config)]/Config`%0)]
&global`config #34=#42

&line`prep #34=[setq(t1,firstof(%0,%!))][setq(fill,[u(gameconfig,LINE_FILL)])][setq(fillcolor,[u(gameconfig,LINE_COLOR)])][setq(filltext,[u(gameconfig,LINE_TEXT)])][setq(fillstar,[u(gameconfig,LINE_ACCENT)])][setq(fillwidth,[ifelse(isnum(%1),%1,[width(%#)])])]

&line #34=[u(line`prep,%2,%3)][u(line`[u(strfirstof,%1,center)],%0,%3,%4)]
&line`header #34=[printf($&^%q<fillwidth>:[ansi(%q<fillcolor>,%q<fill>)]:s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])][ansi(%q<fillstar>,:)]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillstar>,:)][ansi(%q<fillcolor>,[chr(93)])],)])]
&line`center #34=[printf($&^%q<fillwidth>:[ansi(%q<fillcolor>,%q<fill>)]:s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillcolor>,[chr(93)])],)])]
&line`left #34=[printf($5:[ansi(%q<fillcolor>,%q<fill>)]:s$&-[sub(%q<fillwidth>,5)]:[ansi(%q<fillcolor>,%q<fill>)]:s,,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillcolor>,[chr(93)])],)])]
&line`right #34=[printf($&[sub(%q<fillwidth>,5)]:[ansi(%q<fillcolor>,%q<fill>)]:s$5:[ansi(%q<fillcolor>,%q<fill>)]:s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillcolor>,[chr(93)])],)],)]
&line`cathead #34=[printf($&^%q<fillwidth>s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillcolor>,[chr(93)])],)])]
&line`linehead #34=[printf($&^%q<fillwidth>:[ansi(%q<fillcolor>,%q<fill>)]:s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillcolor>,[chr(93)])],)])]
