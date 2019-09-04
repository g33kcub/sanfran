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
@@ myvalid(TYPE,item)                    - Returns 1 if the item is valid.
@@ alert(type,item..N)                   - Returns custom alert errors.
@@ itemize(list,delimit,conjun,punc,sep) - Itemizes a list. itemize(test|test,|,&,(comma),sep)
@@ newfile(system)                       - Generates an unique number for a file entry. (news/+help/+shelp/etc.)
@@
@@------------------------System Management Stuff-------------------------------
@@ Do not remove. Edit as needed.
&matrix`ignore #34=1
&matrix`name #34=SYSTEM
@@------------------------------------------------------------------------------
@startup #34=@dolist [u(makelist)]={@function/preserve/privilege ##=#34/##;@function/min ##=[default(#34/##`min,0)];@function/max ##=[default(#34/##`max,-1)]};

&makelist #34=[setq(list,[iter([lzone(#45)],[get(##/functionlist)],%B,%B)])][setunion(%q<list>,%q<list>)]

&functionlist #34=safepassword caps cnum numth gtm ispowered width su hasrole roles line firstof strfirstof gameconfig myvalid wgrepi alert newfile itemize gamename

&gamename #34=[mudname()]: [gameconfig(season_tag)]
&gamename`min #34=0
&gamename`max #34=0

&newfile #34=[setr(new,[inc([default(#34/newfile`%0,0)])])][set(#34,newfile`%0:%q<new>,1)]
&newfile`min #34=1
&newfile`max #34=1

&itemize #34=elist(%0,%2,%1,%4,%3)
&itemize`min #34=3
&itemize`max #34=5

&alert #34=[u(amsg`%0,%1,%2,%3,%4,%5,%6,%7,%8,%9)]
&alert`min #34=1
&amsg`# #34=#-1
&amsg`a1 #34=#-A1 Incorrect Name or Handle formatting.
&amsg`S1 #34=#-S1 Invalid Switch for SYSTEM%(%) Function.

&wgrepi #34=[filter(wgrepi`fil,lattr(%0/%1,,,,,1),%B,%B,%0,%2)]
&wgrepi`fil #34=[strmatch([get(%1/%0)],%2)]
&wgrepi`min #34=3
&wgrepi`max #34=3

&myvalid #34=[ifelse(hasattr(#34,VALID`%0),[u(valid`%0,%1)],[valid(%0,%1)])]
&myvalid`min #34=2
&myvalid`max #34=2

&hasrole #34=[u(gtm,[u(roles,%0)],[ucstr(%1)])]
&hasrole`min #34=2
&hasrole`max #34=2

&roles #34=[setq(list,[wgrepi(#47,ROLE`*`LIST,[objid(%0)])])][sort([iter(%q<list>,[extract(##,2,1,`)])])]
&roles`min #34=1
&roles`max #34=1

&width #34=[default(%0/SYS`WIDTH,80)]
&width`min #34=1
&width`max #34=1

&ispowered #34=[gte([bittype(%0)],2)]
&ispowered`min #34=1
&ispowered`max #34=1

&gtm #34=[gte([match(%0,%1,%2)],1)]
&gtm`min #34=2
&gtm`max #34=3

&safepassword #34=[u(su,[squish([scramble(digest(md5,secs()))])])]
&safepassword`min #34=0
&safepassword`max #34=0

&caps #34=regeditalli(lcstr(%0),v(REG`CAPNAMES),capstr($1),v(REG`CAPNAMES3),lcstr($0),v(REG`CAPNAMES2),$1[capstr($2)])
&caps`min #34=1
&caps`max #34=1

&REG`CAPNAMES #34=(?:^|(?<=[_\/\-\|\s()\+]))([a-z]+)
&REG`CAPNAMES2 #34=(^|(?<=[(\|\/]))(of|the|a|and|in)
&REG`CAPNAMES3 #34=\b(of|the|a|and|in)\b

&SU #34=[u(su`[strmatch(%0,*_*)],%0)]
&su`max #34=1
&su`min #34=1
&SU`0 #34=[edit([edit(%0,%B,_)],:,")]
&SU`1 #34=[edit([edit(%0,_,%B)],",:)]

&CNUM #34=squish(flip(foreach(#lambda/if(mod(\%1,3),\%0,\\,\%0),flip(%0))),\,)
&cnum`min #34=1
&cnum`max #34=1
&numth #34=%0[switch(%0,11,th,12,th,13,th,switch(right(%0,1),1,st,2,nd,3,rd,th))]
&numth`max #34=1
&numth`min #34=1


&STRFIRSTOF #34=ofparse(5,%0,%1,%2,%3,%4,%5,%6,%7,%8,%9)
&strfirstof`min #34=2

&FIRSTOF #34=ofparse(1,%0,%1,%2,%3,%4,%5,%6,%7,%8,%9)
&firstof`min #34=1

&gameconfig #34=[get([u(Global`config)]/Config`%0)]
&gameconfig`min #34=1
&gameconfig`max #34=1
&global`config #34=#42

&line`prep #34=[setq(t1,firstof(%0,%!))][setq(fill,[u(gameconfig,LINE_FILL)])][setq(fillcolor,[u(gameconfig,LINE_COLOR)])][setq(filltext,[u(gameconfig,LINE_TEXT)])][setq(fillstar,[u(gameconfig,LINE_ACCENT)])][setq(fillwidth,[ifelse(isnum(%1),%1,[width(%#)])])]

&line #34=[u(line`prep,%2,%3)][u(line`[u(strfirstof,%1,center)],%0,%3,%4)]
&line`min #34=0

&line`header #34=[printf($&^%q<fillwidth>:[ansi(%q<fillcolor>,%q<fill>)]:s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])][ansi(%q<fillstar>,:)]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillstar>,:)][ansi(%q<fillcolor>,[chr(93)])],)])]
&line`center #34=[printf($&^%q<fillwidth>:[ansi(%q<fillcolor>,%q<fill>)]:s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillcolor>,[chr(93)])],)])]
&line`left #34=[printf($5:[ansi(%q<fillcolor>,%q<fill>)]:s$&-[sub(%q<fillwidth>,5)]:[ansi(%q<fillcolor>,%q<fill>)]:s,,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillcolor>,[chr(93)])],)])]
&line`right #34=[printf($&[sub(%q<fillwidth>,5)]:[ansi(%q<fillcolor>,%q<fill>)]:s$5:[ansi(%q<fillcolor>,%q<fill>)]:s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillcolor>,[chr(93)])],)],)]
&line`cathead #34=[printf($&^%q<fillwidth>s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillcolor>,[chr(93)])],)])]
&line`linehead #34=[printf($&^%q<fillwidth>:[ansi(%q<fillcolor>,%q<fill>)]:s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillcolor>,[chr(93)])],)])]
&line`lefthead #34=[printf($5:[ansi(%q<fillcolor>,%q<fill>)]:s$&-[sub(%q<fillwidth>,5)]:[ansi(%q<fillcolor>,%q<fill>)]:s,,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])][ansi(%q<fillstar>,:)]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillstar>,:)][ansi(%q<fillcolor>,[chr(93)])],)])]
&line`righthead #34=[printf($&[sub(%q<fillwidth>,5)]:[ansi(%q<fillcolor>,%q<fill>)]:s$5:[ansi(%q<fillcolor>,%q<fill>)]:s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])][ansi(%q<fillstar>,:)]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillstar>,:)][ansi(%q<fillcolor>,[chr(93)])],)],)]
&line`2header #34=[line(%0,lefthead,%#,50)][line(%1,righthead,%#,[sub([width(%#)],50)])]
