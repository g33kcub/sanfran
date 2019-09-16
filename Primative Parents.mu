@dig/tel Primative Room
@create Primative Thing
@pcreate Primative Player=[safepassword()]
@open Primative Exit

&global`player #30=#34:1568660815
&global`thing #30=#33:1568660815
&global`exit #30=#35:1568660815
&global`room #30=#32:1568660814

@dolist #33 #34 #35 #32={@parent ##=#29}

@nameformat #32=[align(-80,[name(me)][if(or(ispowered(%#),controls(%#,%!)),[chr([gameconfig(bracket_left)])][num(%!)][flags(%!)][chr([gameconfig(bracket_right)])])])]%R[line()]


@conformat #32=[u(conformat`extra)][if(words([mplayers(%!,%#)] [mthings(%!,%#)] [mexits(%!,%#)]),[line()])][if(words([mplayers(%!,%#)]),udefault(PLAYERS`[u(system`players)],u(PLAYERS`DEFAULT)))][if(words([mthings(%!,%#)]),udefault(THINGS`[u(system`things)],u(Things`DEFAULT)))]

&players`default #32=%R[ansi([gameconfig(columns)],Players)]:%R[iter([sortby(sort`name,[mplayers(%!,%#)])],[u(players`default`fmt,##,%#)],%B,%R)]
&players`default`fmt #32=[align(>3 35 [lmath(sub,[u(width,%1)] 3 1 35 1 3 1)] >3,[statustag(%0)],[moniker(%0)][if(cor(ispowered(%1),controls(%1,%0),gtm(%1,%0)),%(%0%))],[if(isstaff(%0),[staffbit(%0)],[sdesc(%0)])],[hideidle(%0)])]

&things`default #32=%R[ansi([gameconfig(columns)],Things)]:%R[iter([sortby(sort`name,[mthings(%!,%#)])],[u(things`default`fmt,##,%#)],%B,%R)]
&things`default`fmt #32=[align(>3 [lmath(sub,[u(width,%1)] 3 1 )],,[moniker(%0)][if(cor(ispowered(%1),controls(%1,%0)),%(%0%))])]

&sort`idle #29=[comp(idle(%0),idle(%1))]
&sort`name #29=[comp(name(%0),name(%1))]
