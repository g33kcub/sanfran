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
&account`alts #31=[default(%0/alts,[u([global(account)]/error`noalts,%0)])]


&error #43=udefault(%!/MSG,{%0},##,{%0},%1,u(Matrix`NAME))
&error`notaccount #43=[u(error,{'[name(%0)]' is not a valid account.})]
&error`noemail #43=[u(error,{'[name(%0)]' does not have an email set.})]
&error`nomembers #43=[u(error,{'[name(%0)]' does not have any members associated with it.})]
&error`nopasswordset #43=[u(error,{'[name(%0)]' does not have a password set.})]
&error`noalts #43=[u(error,{'[name(%0)]' does not have any alts set.})]

@@------------------------------------------------------------------------------
@@ Account system. Used to link various functions of the game together.
@@
@@  @account [<page>]                    - Displays your account.

@@ Reg: 0 = @account/switch account=item
@@ Reg: 1 = switch
@@ Reg: 2 = account
@@ Reg: 3 =
@@ Reg: 4 =
@@ Reg: 5 = item
@@ Reg: 6 =
@@ Reg: 7 =
@@ Reg: 8 =
@@ Reg: 9 =
@@ @attach %!/inc`regs=%0,%1,%2,%3,%4,%5,%6,%7,%8,%9

&cmd`account #43=$^@account(?\:/(\S+)?)?(?\: +(.+?))?(?\:/(.+?))?(?\:/(.+?))?(?\:=(.+?))?$:@attach %!/CMD`account`MAIN
@set #43/cmd`account=regexp
&cmd`account`main #43=@attach %!/inc`switches=%1;@attach %!/run`[strfirstof(%q<switch>,main)]=%2,%3,%4,%5,%6,%7,%8,%9

&run`main #43=@check [isstaff(%#)]={@attach %!/run`main`player};@attach %!/run`main`player

&run`main`player #43=th [setq(id,[getid(%#)])]@check [hasattr(%#,sys`account)]={@attach %!/inc`msg`error={You are not part of an account.}};@pemit %#=[line(banner,Account Summary - [hname(%q<id>)])]%R%B[align(15 [lmath(sub,[u(width,%#)] 15 1 1 1)],[ansi(gameconfig(columns),Handle)]:,[hname(%q<id>)])]%R%B[align(15 [lmath(sub,[u(width,%#)] 15 1 1 1)],[ansi(gameconfig(columns),E-Mail)]:,[get(%q<id>/email)])]%R%B[align(15 [lmath(sub,[u(width,%#)] 15 1 1 1)],[ansi(gameconfig(columns),Password)]:,[if(hasattr(%q<id>,password),Set. %([decrypt([get(%q<id>/password)],%q<id>)]%),Not Set.)])]%R%B[align(15 [lmath(sub,[u(width,%#)] 15 1 1 1)],[ansi(gameconfig(columns),Account XP)]:,[cnum([xp(%q<id>,accountavail)])]/[cnum(xp(%q<id>,accounttotal))])]%R[line(header,Account Members)]%R%B[ansi(gameconfig(columns),[align(25 7 3 3 4 15 15,Character Name,Type,Pri,Alt,Mail,Race,Template,.)])]%R[iter([sort([get(%q<id>/members)],name)],[u(run`main`player`fmt,##)],%B,%R)]%R[line(header,Notes)][if(gte(words(lattr(%q<id>/note`*)),1),%R)][iter([lattr(%q<id>/note`*)],[u(run`main`player`note`fmt,%q<id>,##,#@)],%B,%R)];@pemit %#=[line(banner,@account/viewnote <num>)]

&run`main`player`note`fmt #43=%B[align(>3 40 -3,%2,[get(%0/%1)],[if([default(%0/%1`approved,0)],[ansi(010,Y)],[ansi(009,N)])])]

&run`main`player`fmt #43=%B[align(25 7 -3 -3 -4 15 15,name(%0),[switch(1,[isstaff(%0)],Staff,[ispowered(%0)],Powered,[haspower(%0,Builder)],Builder,[hasflag(%0,NPC)],Player)],[u(get`priority,%q<id>,%0)],[if(u(get`isalt,%q<id>,%0),[ansi(010,Y)],[ansi(009,N)])],[extract(mail(%0),2,1)],[default(%0/besm`race,Unknown)],[default(%0/besm`template,Unknown)])]

&get`priority #43=[last([wildgrepi(%0,PRIORITY`*,%1)],`)]

&run`main`staff #43=@attach %!/inc`accountlist`db;th [setq(pg,strfirstof(%0,1))][setq(list,[sort(%q<actlist>,name)])][setq(pages,[u(get`pages,%q<list>,20)])][setq(sec,[u(get`page`count,%q<list>,%q<pg>,20)])];@attach %!/inc`partial=%q<pg>,[lnum(1,%q<pages>)],%B,pg,Page;@pemit %#=[line(banner,Account Master List)]%R%B[ansi(gameconfig(columns),[align(25 7 8 3 3 3 11 5,Account Name,Public?,Members,FZN,JLD,UNA,Staff Notes,Notes,.)])]%R[iter(%q<sec>,[u(run`main`staff`fmt,##)],%B,%R)]%R[line(banner,Page %q<pg> of %q<pages> -- @account <page> / @account/view <handle>)]

&run`main`staff`fmt #43=%B[align(25 -7 -8 -3 -3 -3 -11 -5,[hname(%0)],[if([default(%0/public,0)],[ansi(010,Y)],[ansi(009,N)])],[words([get(%0/members)])],[if([hasattr(%0,FROZEN)],[ansi(010,Y)],[ansi(009,N)])],[if([hasattr(%0,JAILED)],[ansi(010,Y)],[ansi(009,N)])],[if([hasattr(%0,UNAPP)],[ansi(010,Y)],[ansi(009,N)])],[words([lattr(%0/staffnote`*)])],[words(lattr(%0/note`*))])]

&switches`player #43=NEW|REGISTER|PASSWORD|ALT|PRIORITY|XP|UNREGISTER|PUBLIC|NOTES|VIEWNOTE|SETNOTE
&switches`staff #43=VIEW|SETSNOTE
&switches`admin #43=APPNOTE|AWARDXP|NEWPASSWORD|WIPE|REMCHAR
&switches`wizard #43=UNAPP|FREEZE|JAIL

@@ 0 = Account Name, 3 = Password.
&inc`accountlist #43=[setq(actlist,[iter([children([global(accpar)])],[name(##)],%B,|)])]
&inc`accountlist`db #43=[setq(actlist,[children([global(accpar)])])]

&run`new #43=@attach %!/inc`accountlist;@stop [gtm(%q<actlist>,%0,|)]={@attach %!/inc`msg`error={'%0' is already a valid account name. If you are supposed to be part of it. Please use [ansi(+white,@account/register %0=<password>)] to be added to it.}}

@@  @account/new <email>=<password>      - Generates an account in the system. Using the provided email.
@@  @account/register <email>=<password> - Registers a character with the account.
@@  @account/newpassword <old>=<new>     - Changes the Password On the account.
@@  @account/alt <character>             - Marks a character as a public alt. If used again, it will hide one. (Hidden is default.)
@@  @account/priority <character>=#      - Marks a character as a priority for chat and board notifications. The scale is 1 to 5.
@@                                         1 will always get, 2 to 5 will get only if a higher rating is not available and on the
@@                                         same channel or board.
@@  @account/xp [<page>]                 - Lists all the transactions that occurred with Account XP.
@@  @account/handle <handle>             - Creates an unique $Handle for your account.
@@  @account/unregister <character>      - Removes a character from an account.
@@  @account/public                      - Toggles whether or not the $handle is displayed on Channels for Alts.
@@  @account/notes [<page>]              - Shows all notes tied to your account, not specific characters.
@@  @account/viewnote <note #>           - Displays the contents of a note.
@@  @account/setnote <title>=<note>      - Sets a note on your account.
@@
@@--------------------------Staff Commands--------------------------------------
@@  @actmng [<pages>]                    - Lists all accounts in the system.
@@  @actmng/view <account#,$handle,Char> - Shows information for that account.
@@  @actmng/notes <id>[/<page>]          - Shows Player & Staff notes for the account.
@@  @actmng/viewnote <id>/<note id>      - Displays information about a note.
@@  @actmng/setnote <id>/<name>=<note>   - Sets a player viewable note on account.
@@  @actmng/setsnote <id>/<name>=<note>  - Sets a staff viewable note on account.
@@  @actmng/appnote <id>=<note id>       - Approves a Player set note.
@@  @actmng/awardxp <id>=<amount>/<reas> - Applies a given amount of account XP for reason.
@@  @actmng/xp <id>[/<page>]             - Shows the xp transactions for the account.
@@  @actmng/freeze <id>                  - Toggles Freezes all characters on the account.
@@  @actmng/jail <id>                    - Toggles Jail Status on all characters on account.
@@  @actmng/alert <id>=<msg>             - Sends a message to all characters on the account, that are online.
@@  @actmng/newpassword <id>             - Resets the account password and sends it to only the online characters.
@@  @actmng/wipe <id>                    - Wipes all the shared settings and read files for the account.
@@  @actmng/unapp <id>                   - Unapproves all characters on the account.
@@  @actmng/remchar <id>=<character>     - Forceably removes a character from the account (Roster Characters)
@@
@@-------------------------Functions--------------------------------------------
