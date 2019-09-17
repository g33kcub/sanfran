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
&startup`functions #31=staffbit isstaff safepassword caps cnum numth gtm ispowered su hasrole roles line gameconfig myvalid wgrepi alert newfile itemize gamename sdesc hideidle statustag mplayers mthings mexits


&mexits #31=[setq(raw,lexits(%0))][setq(players,[iter(%q<raw>,if(hastype(##,exit),##))])][setq(seen,[iter(%q<players>,[if([isstaff(%1)],##,[if([hasflag(##,dark)],,##)])])])][setq(master,[setunion(%q<seen>,%q<seen>)])][setq(path,[filter(mexits`path,%q<master>)])][setq(build,[filter(mexits`build,%q<master>)])][setq(home,[filter(mexits`home,%q<master>)])][switch(strfirstof(%2,MASTER),MASTER,%q<master>,PATH,%q<path>,BUILD,%q<build>,HOME,%q<home>)]
&mexits`path #31=[gtm([get(%0/build`type)],PATH,|)]
&mexits`build #31=[gtm([get(%0/build`type)],BUILD,|)]
&mexits`home #31=[gtm([get(%0/build`type)],HOME,|)]

&mthings #31=[setq(raw,lcon(%0))][setq(players,[iter(%q<raw>,if(hastype(##,thing),##))])][setq(seen,[iter(%q<players>,[if([isstaff(%1)],##,[if([hasflag(##,dark)],,##)])])])][setunion(%q<seen>,%q<seen>)]
&mplayers #31=[setq(raw,lcon(%0))][setq(players,[iter(%q<raw>,if(and(hasflag(##,Connected),hastype(##,player)),##))])][setq(seen,[iter(%q<players>,[if([isstaff(%1)],##,[if([hasflag(##,dark)],,##)])])])][setunion(%q<seen>,%q<seen>)]

&statustag #31=[u(statustag`[strfirstof(%1,0)],%0)]
&statustag`0 #31=[switch(1,[hasflag(%0,Dark)],[ansi([gameconfig(tag_dark)],DRK)],[hidden(%0)],[ansi([gameconfig(tag_hide)],HDE)],[isstaff(%0)],[ansi([gameconfig(tag_staff)],STF)],[haspower(%0,Guest)],[ansi([gameconfig(tag_guest)],GST)],[hasrole(%0,Helper)],[ansi([gameconfig(tag_helper)],HLP)],[not([isapproved(%0)])],[ansi([gameconfig(tag_new)],NEW)],[isafk(%0)],[ansi([gameconfig(tag_afk)],AFK)])]
&statustag`1 #31=[switch(1,[hasflag(%0,Dark)],[ansi([gameconfig(tag_dark)],DRK)],[hidden(%0)],[ansi([gameconfig(tag_hide)],HDE)],[isstaff(%0)],[ansi([gameconfig(tag_staff)],STF)],[haspower(%0,Guest)],[ansi([gameconfig(tag_guest)],GST)],[hasrole(%0,Helper)],[ansi([gameconfig(tag_helper)],HLP)],[not([isapproved(%0)])],[ansi([gameconfig(tag_new)],NEW)],[isafk(%0)],[ansi([gameconfig(tag_afk)],AFK)],[isic(%0)],[ansi([gameconfig(tag_IC)],IC)],[ansi(gameconfig(tag_ooc),OOC)])]

&isstaff #31=[u(ispowered,%0)]

&staffbit #31=Coming Soon.

&hideidle #31=switch(objeval(%#,idle(%0)),-1,ansi(hx,Off),ansi(if(u(ishidden,%0),hx,u(ryg,round(mul(fdiv(bound(idle(%0),0,3600),3600),100),0))),u(smalltime,idle(%0),3)))
&RYG #29=<[if(gt(%0,50),255,round(mul(255,fdiv(mul(%0,2),100)),0))] [if(gte(%0,50),sub(mul(255,2),round(mul(255,fdiv(mul(%0,2),100)),0)),255)] 0>
&smalltime #29=etime(%0,3)

&sdesc #31=[default(%0/short-desc,Use '&short-desc me=' to set.)]

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

&ispowered #31=[orlflags(%0,Wizard Royalty Judge)]

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


&line`prep #31=[setq(t1,firstof(%0,%!))][setq(fill,[gameconfig(line_fill)])][setq(lbr,[gameconfig(bracket_left)])][setq(rbr,[gameconfig(bracket_right)])][setq(char,[gameconfig(line_char)])][setq(color,[gameconfig(line_color)])][setq(text,[gameconfig(line_text)])][setq(accent,[gameconfig(line_accent)])][setq(width,[u(width,%0)])][setq(color2,[gameconfig(line_color_alt)])]


&line #31=[u(line`prep,%#)][u(line`[strfirstof(%0,center)],%1,%2,%3,%4)]

&line`header #31=[ansi(%q<color>,[chr(40)])][center([ansi(%q<color>,[chr(%q<lbr>)])][ansi(%q<accent>,[chr(%q<char>)])]%B[ansi(%q<text>,%0)]%B[ansi(%q<accent>,[chr(%q<char>)])][ansi(%q<color>,[chr(%q<rbr>)])],[sub(%q<width>,2)],[ansi(%q<color>,[chr(%q<fill>)])])][ansi(%q<color>,[chr(41)])]

&line`center #31=[ansi(%q<color>,[chr(40)])][center([if(gte(words(%0),1),[ansi(%q<color>,[chr(%q<lbr>)])]%B[ansi(%q<text>,%0)]%B[ansi(%q<color>,[chr(%q<rbr>)])])],[sub(%q<width>,2)],[ansi(%q<color>,[chr(%q<fill>)])])][ansi(%q<color>,[chr(41)])]

&line`left #31=[ansi(%q<color>,[chr(40)])][ljust([repeat([ansi(%q<color>,[chr(%q<fill>)])],5)][ansi(%q<color>,[chr(%q<lbr>)])]%B[ansi(%q<text>,%0)]%B[ansi(%q<color>,[chr(%q<rbr>)])],[sub(%q<width>,2)],[ansi(%q<color>,[chr(%q<fill>)])])][ansi(%q<color>,[chr(41)])]

&line`bar #31=[center([if(gte(words(%0),1),[ansi(%q<color>,[chr(%q<lbr>)])]%B[ansi(%q<text>,%0)]%B[ansi(%q<color>,[chr(%q<rbr>)])])],%q<width>,[ansi(%q<color>,[chr(%q<fill>)])])]

&line`right #31=[ansi(%q<color>,[chr(40)])][rjust([ansi(%q<color>,[chr(%q<lbr>)])]%B[ansi(%q<text>,%0)]%B[ansi(%q<color>,[chr(%q<rbr>)])][repeat([ansi(%q<color>,[chr(%q<fill>)])],5)],[sub(%q<width>,2)],[ansi(%q<color>,[chr(%q<fill>)])])][ansi(%q<color>,[chr(41)])]

&line`2col #31=[setq(width,[div([sub(%q<width>,2)],2)])][ansi(%q<color>,[chr(40)])][u(line`bar,%0)][u(line`bar,%1)][ansi(%q<color>,[chr(41)])]

&line`banner #31=%B[ansi(%q<color>,[repeat(_,[sub(%q<width>,2)])])]%R[ansi(%q<color>,[chr(40)])]%B[ansi(%q<accent>,O)][center([if(gte(words(%0),1),[ansi(%q<color2>,[chr(%q<lbr>)])]%B[ansi(%q<text>,%0)]%B[ansi(%q<color2>,[chr(%q<rbr>)])])],[sub(%q<width>,6)],[ansi(%q<color2>,[chr(%q<fill>)])])][ansi(%q<accent>,O)]%B[ansi(%q<color>,[chr(41)])]%R%B[ansi(%q<color>,[repeat([chr(175)],[sub(%q<width>,2)])])]
