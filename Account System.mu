&matrix`name #43=ACCOUNT
&matrix`desc #43=The Player Account Management System.
&matrix`obj #43=#43:1568805805 #44:1568805811
&matrix`sys #43=#43:1568805805
&matrix`cmd #43=#43:1568805805
&matrix`credit #43=The Hope @ San Fransokyo MUSH, Volund @ VolundMUSH Suite @ Github
&matrix`hasfn #43=1
&matrix`hasstart #43=1
&matrix`hasconf #43=0
&matrix`hasfiles #43=1
@parent #43=#29
@parent #44=#43
&startup`functions #43=account getid
&global`aCCOUNT #30=#43:1568805805
&global`accpar #30=#44:1568805811

&getid #31=[u(getid`[strmatch(%0,$*)],%0)]
&getid`1 #31=[setq(loc,[locate(#44,%0,Ti)])][setq(bingo,first(%q<loc>))][[objid(%q<bingo>)]
&getid`0 #31=[default(%0/sys`account,[objid(%0)])]

&account #31=[setq(id,[u(getid,%0)])][if(hastype(%q<id>,Player),[u([global(account)]/error`notaccount,%q<id>)],[u(account`[strfirstof(%1,id)],%q<id>,%2)])]
&account`id #31=%0
&account`email #31=[default(%0/email,[u([global(account)]/error`noemail,%0)])]
&account`members #31=[default(%0/members,[u([global(account)]/error`nomembers,%0)])
&account`ismember #31=[gtm([u(account`members,%0)],[objid(%1)])]
&account`epass #31=[encrypt(%1,%0)]
&account`dpass #31=[if(hasattr(%0,password),[decrypt([get(%0/password)],%0)],[u([global(account)]/error`nopasswordset,%0)])]


&error #43=udefault(%!/MSG,{%0},##,{%0},%1,u(Matrix`NAME))
&error`notaccount #43=[u(error,{'[name(%0)]' is not a valid account.})]
&error`noemail #43=[u(error,{'[name(%0)]' does not have an email set.})]
&error`nomembers #43=[u(error,{'[name(%0)]' does not have any members associated with it.})]
&error`nopasswordset #43=[u(error,{'[name(%0)]' does not have a password set.})]
