@@ Code: #43
@@ Parent: #44

@@------------------------------------------------------------------------------
@@ Account system. Used to link various functions of the game together.
@@
@@  @account [<page>]                    - Displays your account.
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
@@  actid(<player,$handle>)              - Returns the account id.
@@  account(Function,<id,$handle,player>)- Returns some specific data about the account.
@@
@@-------------------------Structure--------------------------------------------
@@ &email                                - Stores the account's email address.
@@ &password                             - Stores the encoded password for the account.
@@ &alts                                 - Stores the list of public alt dbrefs.
@@ &handle                               - Stores the $handle for the account.
@@ &xp`avail                             - All available XP.
@@ &xp`total                             - Total amount of xp earned.
@@ &public                               - Whether or not channels could see handle.
@@ &note`#                               - Note name, ID.
@@ &note`#`type                          - Staff or Player.
@@ &note`#`app                           - Approved?
@@ &note`#`appby                         - DBREF of approver.
@@ &note`#`appsec                        - Seconds when approved.
@@ &note`#`text                          - Note text.
@@ &priority`#                           - 1 to 5, default for all is #1
@@
@@------------------------System Management Stuff-------------------------------
@@ Do not remove. Edit as needed.
&matrix`name #43=ACCOUNT
&matrix`desc #43=Player Account Management System.
&matrix`active #43=1
&matrix`credit #43=Mr. Black ($g33kcub) @ Here, Seamus@MSB, Matrix@Due Rewards/WORA
&matrix`locked #43=1
&matrix`obj #43=#43:1567186680 #44:1567186688
&matrix`cmd #43=#43:1567186680
@@
@@-------------------------Help Files-------------------------------------------
@@ &help`account# Formatting
@@------------------------------------------------------------------------------

@@ global functions
&functionlist #43=account actid

&actid #34=[setq(aid,[u(#43/get`id,%0)])][if(isdbref(%q<aid>),%q<aid>,[alert(#)])]
&actid`min #34=1
&actid`max #34=1

&account #34=BLAH
&account`min #34=2


@@ internal functions
&get`id #43=[if([u(matrix`active)],[u(get`id`[strmatch(%0,$*)],%0)],[u(get`id`inactive,%0)])]
&get`id`1 #43=[setq(db,[iter(children(#44),[if([gte([words([wgrepi(##,HANDLE,[after(%0,$)])])],1)],##)])])][setq(fdb,[trim([setunion(%q<db>,%q<db>)))][name(%q<fdb>)]
&get`id`0 #43=[setq(pid,[if(isdbref(%0),%0,[pfind(%0)])])][setq(db,iter(children(#44),[if([gtm(lzone(##),%q<pid>)],##)]))][setq(fdb,trim(setunion(%q<db>,%q<db>)))][name(%q<fdb>)]
&get`id`inactive #43=[pfind(%0)]

&showhandle #43=[ansi(010,$)][get([u(get`actdb,%0)]/handle)]
&is`act #43=[gtm([parent(%0)],#44)]
&is`onact #43=[gtm([lzone([u(get`actdb,%0)])],%1)]
&is`alt #43=[cand([u(is`onact,%0)],[gtm([get([u(get`actdb,%0)]/alts)],%0)])]
&get`actdb #43=[setq(adb,[u(git`id,%0)])]%q<fdb>
