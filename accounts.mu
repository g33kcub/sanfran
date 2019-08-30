@@ Code: #43
@@ Parent: #44

@@------------------------------------------------------------------------------
@@ Account system. Used to link various functions of the game together.
@@
@@  @account [<page>]                     - Displays your account.
@@  @account/new <email>=<password>      - Generates an account in the system. Using the provided email.
@@  @account/register <email>=<password> - Registers a character with the account.
@@  @account/alt <character>             - Marks a character as a public alt. If used again, it will hide one. (Hidden is default.)
@@  @account/priority <character>=#      - Marks a character as a priority for chat and board notifications. The scale is 1 to 5.
@@                                         1 will always get, 2 to 5 will get only if a higher rating is not available and on the
@@                                         same channel or board.
@@  @account/xp [<page>]                 - Lists all the transactions that occurred with Account XP.
@@  @account/handle <handle>             - Creates an unique $Handle for your account.
@@------------------------------------------------------------------------------
