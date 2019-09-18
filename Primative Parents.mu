@dig/tel Primative Room
@create Primative Thing
@pcreate Primative Player=[safepassword()]
@open Primative Exit

&global`player #30=#34:1568660815
&global`thing #30=#33:1568660815
&global`exit #30=#35:1568660815
&global`room #30=#32:1568660814

@dolist #33 #34 #35 #32={@parent ##=#29}

@nameformat #32=[line(banner,[name(me)][if(or(ispowered(%#),controls(%#,%!)),[chr([gameconfig(bracket_left)])][num(%!)][flags(%!)][chr([gameconfig(bracket_right)])])])]


@conformat #32=[u(conformat`extra)][if(words([mplayers(%!,%#)] [mthings(%!,%#)] [mexits(%!,%#)]),[line()])][if(words([mplayers(%!,%#)]),udefault(PLAYERS`[u(system`players)],u(PLAYERS`DEFAULT)))][if(words([mthings(%!,%#)]),udefault(THINGS`[u(system`things)],u(Things`DEFAULT)))]

&players`default #32=%R%B[ansi([gameconfig(columns)],Players)]:%R[iter([sortby(sort`name,[mplayers(%!,%#)])],[u(players`default`fmt,##,%#)],%B,%R)]
&players`default`fmt #32=[align(>4 35 [lmath(sub,[u(width,%1)] 4 1 35 1 3 2)] >3,[statustag(%0)],[moniker(%0)][if(cor(ispowered(%1),controls(%1,%0),gtm(%1,%0)),[chr([gameconfig(bracket_left)])]%0[chr([gameconfig(bracket_right)])])],[if(isstaff(%0),[staffbit(%0)],[sdesc(%0)])],[hideidle(%0)])]

&things`default #32=%R%B[ansi([gameconfig(columns)],Things)]:%R[iter([sortby(sort`name,[mthings(%!,%#)])],[u(things`default`fmt,##,%#)],%B,%R)]
&things`default`fmt #32=[align(>4 [lmath(sub,[u(width,%1)] 4 2 )],,[moniker(%0)][if(cor(ispowered(%1),controls(%1,%0)),[chr([gameconfig(bracket_left)])]%0[chr([gameconfig(bracket_right)])])])]

@descformat #32=%B%0

&sort`idle #29=[comp(idle(%0),idle(%1))]
&sort`name #29=[comp(name(%0),name(%1))]

&build`type #35=PATH

@exitformat #32=[iter([if(gte(words([mexits(%!,%#,HOME)]),1),Home)] [if(gte(words([mexits(%!,%#,BUILD)]),1),BUILD)] [if(gte(words([mexits(%!,%#,PATH)]),1),PATH)],[udefault(exits`##`[u(system`exits`##)],u(exits`##`default))],%B,)][line(banner)]

&exits`home`default #32=%B[ansi([gameconfig(columns)],Residences)]: [itemize([iter([sortby(sort`name,[mexits(%!,%#,HOME)])],[u(exits`fmt,##)],%B,|)],|,&)]%R
&exits`build`default #32=%B[ansi([gameconfig(columns)],Buildings)]: [itemize([iter([sortby(sort`name,[mexits(%!,%#,Build)])],[u(exits`fmt,##)],%B,|)],|,&)]%R
&exits`path`default #32=%B[ansi([gameconfig(columns)],Paths)]: [itemize([iter([sortby(sort`name,[mexits(%!,%#,Path)])],[u(exits`fmt,##)],%B,|)],|,&)]%R

&exits`fmt #32=[ansi([gameconfig(exit_name)],[name(%0)])]%B[chr([gameconfig(bracket_left)])][ansi([gameconfig(exit_alias)],[ucstr([alias(%0)])])][chr([gameconfig(bracket_right)])][if(hasflag(%0,Dark),%B[ansi(+dimgrey,<DARK>)]

&ODROP #35=heads over from [fullname(home(me))].
&OSUCCESS #35=heads over to [fullname(loc(me))].
&SUCCESS #35=You head over to [fullname(loc(me))].
