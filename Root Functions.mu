@@ #31


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
@parent #31=#29
&startup`functions #31=safepassword caps cnum numth gtm ispowered width su hasrole roles line gameconfig myvalid wgrepi alert newfile itemize gamename

&gamename #31=[mudname()]: [gameconfig(season_tag)]

&newfile #31=[setr(new,[inc([default(#30/newfile`%0,0)])])][set(#31,newfile`%0:%q<new>,1)]

&itemize #31=elist(%0,%2,%1,%4,%3)

&alert #31=[u(amsg`%0,%1,%2,%3,%4,%5,%6,%7,%8,%9)]
&amsg`# #31=#-1
&amsg`a1 #31=#-A1 Incorrect Name or Handle formatting.
&amsg`S1 #31=#-S1 Invalid Switch for SYSTEM%(%) Function.

&wgrepi #31=[filter(wgrepi`fil,lattr(%0/%1,,,,,1),%B,%B,%0,%2)]
&wgrepi`fil #31=[strmatch([get(%1/%0)],%2)]

&myvalid #31=[ifelse(hasattr(#31,VALID`%0),[u(valid`%0,%1)],[valid(%0,%1)])]

&hasrole #31=[u(gtm,[u(roles,%0)],[ucstr(%1)])]

&roles #31=[setq(list,[wgrepi(#30,ROLE`*`LIST,[objid(%0)])])][sort([iter(%q<list>,[extract(##,2,1,`)])])]

&width #31=[default(%0/SYS`WIDTH,[gameconfig(width)])]

&ispowered #31=[gte([bittype(%0)],2)]

&gtm #31=[gte([match(%0,%1,%2)],1)]

&safepassword #31=[u(su,[squish([scramble(digest(md5,secs()))])])]

&caps #31=regeditalli(lcstr(%0),v(REG`CAPNAMES),capstr($1),v(REG`CAPNAMES3),lcstr($0),v(REG`CAPNAMES2),$1[capstr($2)])

&REG`CAPNAMES #31=(?:^|(?<=[_\/\-\|\s()\+]))([a-z]+)
&REG`CAPNAMES2 #31=(^|(?<=[(\|\/]))(of|the|a|and|in)
&REG`CAPNAMES3 #31=\b(of|the|a|and|in)\b

&SU #31=[u(su`[strmatch(%0,*_*)],%0)]
&SU`0 #31=[edit([edit(%0,%B,_)],:,")]
&SU`1 #31=[edit([edit(%0,_,%B)],",:)]

&CNUM #31=squish(flip(foreach(#lambda/if(mod(\%1,3),\%0,\\,\%0),flip(%0))),\,)
&numth #31=%0[switch(%0,11,th,12,th,13,th,switch(right(%0,1),1,st,2,nd,3,rd,th))]



&gameconfig #31=[get(#30/Config`%0)]


&line`prep #31=[setq(t1,firstof(%0,%!))][setq(fill,[u(gameconfig,LINE_FILL)])][setq(fillcolor,[u(gameconfig,LINE_COLOR)])][setq(filltext,[u(gameconfig,LINE_TEXT)])][setq(fillstar,[u(gameconfig,LINE_ACCENT)])][setq(fillwidth,[ifelse(isnum(%1),%1,[width(%#)])])]

&line #31=[u(line`prep,%2,%3)][u(line`[strfirstof(%1,center)],%0,%3,%4)]

&line`header #31=[printf($&^%q<fillwidth>:[ansi(%q<fillcolor>,%q<fill>)]:s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])][ansi(%q<fillstar>,:)]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillstar>,:)][ansi(%q<fillcolor>,[chr(93)])],)])]
&line`center #31=[printf($&^%q<fillwidth>:[ansi(%q<fillcolor>,%q<fill>)]:s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillcolor>,[chr(93)])],)])]
&line`left #31=[printf($5:[ansi(%q<fillcolor>,%q<fill>)]:s$&-[sub(%q<fillwidth>,5)]:[ansi(%q<fillcolor>,%q<fill>)]:s,,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillcolor>,[chr(93)])],)])]
&line`right #31=[printf($&[sub(%q<fillwidth>,5)]:[ansi(%q<fillcolor>,%q<fill>)]:s$5:[ansi(%q<fillcolor>,%q<fill>)]:s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillcolor>,[chr(93)])],)],)]
&line`cathead #31=[printf($&^%q<fillwidth>s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillcolor>,[chr(93)])],)])]
&line`linehead #31=[printf($&^%q<fillwidth>:[ansi(%q<fillcolor>,%q<fill>)]:s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillcolor>,[chr(93)])],)])]
&line`lefthead #31=[printf($5:[ansi(%q<fillcolor>,%q<fill>)]:s$&-[sub(%q<fillwidth>,5)]:[ansi(%q<fillcolor>,%q<fill>)]:s,,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])][ansi(%q<fillstar>,:)]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillstar>,:)][ansi(%q<fillcolor>,[chr(93)])],)])]
&line`righthead #31=[printf($&[sub(%q<fillwidth>,5)]:[ansi(%q<fillcolor>,%q<fill>)]:s$5:[ansi(%q<fillcolor>,%q<fill>)]:s,[if(gte(words(%0),1),[ansi(%q<fillcolor>,[chr(91)])][ansi(%q<fillstar>,:)]%B[ansi(%q<filltext>,%0)]%B[ansi(%q<fillstar>,:)][ansi(%q<fillcolor>,[chr(93)])],)],)]
&line`2header #31=[line(%0,lefthead,%#,50)][line(%1,righthead,%#,[sub([width(%#)],50)])]
