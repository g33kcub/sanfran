@@ #54


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
&matrix`name #54=BSCFN
&matrix`active #54=1
&matrix`locked #54=1
&matrix`ignore #54=1
&matrix`credit #54=Mr. Black ($g33kcub) @ Here, Seamus@MSB, Matrix@Due Rewards/WORA
&matrix`desc #54=This is the object that enables the global functions.
&matrix`cmd #54=
&matrix`obj #54=#54:1567691674
&matrix`req #54=
@@------------------------------------------------------------------------------

&functionlist #54=safepassword caps cnum numth gtm ispowered width su hasrole roles line firstof strfirstof gameconfig myvalid wgrepi alert newfile itemize gamename

&gamename #54=[mudname()]: [gameconfig(season_tag)]
&gamename`min #54=0
&gamename`max #54=0

&newfile #54=[setr(new,[inc([default(#54/newfile`%0,0)])])][set(#54,newfile`%0:%q<new>,1)]
&newfile`min #54=1
&newfile`max #54=1

&itemize #54=elist(%0,%2,%1,%4,%3)
&itemize`min #54=3
&itemize`max #54=5

&alert #54=[u(amsg`%0,%1,%2,%3,%4,%5,%6,%7,%8,%9)]
&alert`min #54=1
&amsg`# #54=#-1
&amsg`a1 #54=#-A1 Incorrect Name or Handle formatting.
&amsg`S1 #54=#-S1 Invalid Switch for SYSTEM%(%) Function.

&wgrepi #54=[filter(wgrepi`fil,lattr(%0/%1,,,,,1),%B,%B,%0,%2)]
&wgrepi`fil #54=[strmatch([get(%1/%0)],%2)]
&wgrepi`min #54=3
&wgrepi`max #54=3

&myvalid #54=[ifelse(hasattr(#54,VALID`%0),[u(valid`%0,%1)],[valid(%0,%1)])]
&myvalid`min #54=2
&myvalid`max #54=2

&hasrole #54=[u(gtm,[u(roles,%0)],[ucstr(%1)])]
&hasrole`min #54=2
&hasrole`max #54=2

&roles #54=[setq(list,[wgrepi([u(global,config)],ROLE`*`LIST,[objid(%0)])])][sort([iter(%q<list>,[extract(##,2,1,`)])])]
&roles`min #54=1
&roles`max #54=1

&width #54=[default(%0/SYS`WIDTH,[gameconfig(width)])]
&width`min #54=1
&width`max #54=1

&ispowered #54=[gte([bittype(%0)],2)]
&ispowered`min #54=1
&ispowered`max #54=1

&gtm #54=[gte([match(%0,%1,%2)],1)]
&gtm`min #54=2
&gtm`max #54=3

&safepassword #54=[u(su,[squish([scramble(digest(md5,secs()))])])]
&safepassword`min #54=0
&safepassword`max #54=0

&caps #54=regeditalli(lcstr(%0),v(REG`CAPNAMES),capstr($1),v(REG`CAPNAMES3),lcstr($0),v(REG`CAPNAMES2),$1[capstr($2)])
&caps`min #54=1
&caps`max #54=1

&REG`CAPNAMES #54=(?:^|(?<=[_\/\-\|\s()\+]))([a-z]+)
&REG`CAPNAMES2 #54=(^|(?<=[(\|\/]))(of|the|a|and|in)
&REG`CAPNAMES3 #54=\b(of|the|a|and|in)\b

&SU #54=[u(su`[strmatch(%0,*_*)],%0)]
&su`max #54=1
&su`min #54=1
&SU`0 #54=[edit([edit(%0,%B,_)],:,")]
&SU`1 #54=[edit([edit(%0,_,%B)],",:)]

&CNUM #54=squish(flip(foreach(#lambda/if(mod(\%1,3),\%0,\\,\%0),flip(%0))),\,)
&cnum`min #54=1
&cnum`max #54=1
&numth #54=%0[switch(%0,11,th,12,th,13,th,switch(right(%0,1),1,st,2,nd,3,rd,th))]
&numth`max #54=1
&numth`min #54=1


&STRFIRSTOF #54=ofparse(5,%0,%1,%2,%3,%4,%5,%6,%7,%8,%9)
&strfirstof`min #54=2

&FIRSTOF #54=ofparse(1,%0,%1,%2,%3,%4,%5,%6,%7,%8,%9)
&firstof`min #54=1

&gameconfig #54=[get([u(global,config)]/Config`%0)]
&gameconfig`min #54=1
&gameconfig`max #54=1


&line`prep #54=[setq(t1,firstof(%0,%!))][setq(fill,[u(gameconfig,LINE_FILL)])][setq(fillcolor,[u(gameconfig,LINE_COLOR)])][setq(filltext,[u(gameconfig,LINE_TEXT)])][setq(fillstar,[u(gameconfig,LINE_ACCENT)])][setq(fillwidth,[ifelse(isnum(%1),%1,[width(%#)])])]

&line #54=[u(line`prep,%2,%3)][u(line`[u(strfirstof,%1,center)],%0,%3,%4)]
&line`min #54=0

&line`header #54=[printf($&^%q<fillwidth>:[ansi(%q<fillcolor>,%q<fill>)]:s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])][ansi(%q<fillstar>,:)]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillstar>,:)][ansi(%q<fillcolor>,[chr(93)])],)])]
&line`center #54=[printf($&^%q<fillwidth>:[ansi(%q<fillcolor>,%q<fill>)]:s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillcolor>,[chr(93)])],)])]
&line`left #54=[printf($5:[ansi(%q<fillcolor>,%q<fill>)]:s$&-[sub(%q<fillwidth>,5)]:[ansi(%q<fillcolor>,%q<fill>)]:s,,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillcolor>,[chr(93)])],)])]
&line`right #54=[printf($&[sub(%q<fillwidth>,5)]:[ansi(%q<fillcolor>,%q<fill>)]:s$5:[ansi(%q<fillcolor>,%q<fill>)]:s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillcolor>,[chr(93)])],)],)]
&line`cathead #54=[printf($&^%q<fillwidth>s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillcolor>,[chr(93)])],)])]
&line`linehead #54=[printf($&^%q<fillwidth>:[ansi(%q<fillcolor>,%q<fill>)]:s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillcolor>,[chr(93)])],)])]
&line`lefthead #54=[printf($5:[ansi(%q<fillcolor>,%q<fill>)]:s$&-[sub(%q<fillwidth>,5)]:[ansi(%q<fillcolor>,%q<fill>)]:s,,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])][ansi(%q<fillstar>,:)]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillstar>,:)][ansi(%q<fillcolor>,[chr(93)])],)])]
&line`righthead #54=[printf($&[sub(%q<fillwidth>,5)]:[ansi(%q<fillcolor>,%q<fill>)]:s$5:[ansi(%q<fillcolor>,%q<fill>)]:s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])][ansi(%q<fillstar>,:)]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillstar>,:)][ansi(%q<fillcolor>,[chr(93)])],)],)]
&line`2header #54=[line(%0,lefthead,%#,50)][line(%1,righthead,%#,[sub([width(%#)],50)])]
