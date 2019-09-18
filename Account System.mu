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

&cmd`account #43=$^@account(?\:/(\\S+)?)?(?\: +(.+?))?(?\:=(.*))?$:@attach %!/CMD`account`MAIN
@set #43/cmd`account=regexp
&cmd`account`main #43=@attach %!/inc`regs=%0,%1,%2,%3,%4,%5,%6,%7,%8,%9


@attach %!/inc`switches=%1;@attach %!/run`account`[strfirstof(%q<switch>,main)]=%2,%3

&cmd`actmng #43=$^@actmng(?\:/(\\S+)?)?(?\: +(.+?))?(?\:=(.*))?$:@attach %!/CMD`actmng`MAIN
@set #43/cmd`actmng=regexp
&cmd`actmng`main #43=@attach %!/inc`switches=%1;@attach %!/run`actmng`[strfirstof(%q<switch>,main)]=%2,%3



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
