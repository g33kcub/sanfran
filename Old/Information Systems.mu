@@ Zone: Help #50
@@ Command: #51
@@ DB: #52

@@------------------------------------------------------------------------------
@@  +help                               - Shows the index of the help.
@@  +help <topic>                       - Shows the first level of a topic.
@@  +help <topic>/<sub>                 - Shows the subtopic of a topic.
@@  +help/add <file>=<desc>             - Adds a help file.
@@  +help/rem <file>                    - Removes a file and all subfiles.
@@  +help/addsub <root>/<file>=<desc>   - Adds a subfile.
@@  +help/remsub <root>/<file>          - Removes a subfile.
@@  +help/category <file>=<newcategory> - Changes the category.
@@
@@------------------------System Management Stuff-------------------------------
@@ Do not remove. Edit as needed.
&matrix`name #51=ISYS
&matrix`desc #51=The Information system. This is +help/news/+shelp.
&matrix`active #51=1
&matrix`credit #51=Mr. Black ($g33kcub) @ Here, Seamus@MSB, Matrix@Due Rewards/WORA
&matrix`locked #51=1
&matrix`obj #51=#51:1567621301 #50:1567551373
&matrix`cmd #51=#51:1567621301
&matrix`ignore #51=0
@zone/add #51=#45
@zone/add #51=#50
@@
@@-------------------------Help Files-------------------------------------------
@@ &help`sysmng# Formatting
@@------------------------------------------------------------------------------

&cmd`command #51=$^(?s)(?\:\+)?(book|rules|help|shelp|news)(?\:/(\\S+)?)?(?\: +(.+?))?(?\:/(.+?))?(?\:/(.+?))?(?\:=(.+?))?$:@attach %!/CMD`COMMAND`MAIN
@set #51/cmd`command=regexp
&cmd`command`main #51=


&get`files`help #51=[cluster_Lattr(#50/help`*,,,,,1)]
&get`files`shelp #51=[cluster_Lattr(#50/shelp`*,,,,,1)]
&get`files`news #51=[cluster_Lattr(#50/news`*,,,,,1)]
&get`files`book #51=[cluster_Lattr(#50/book`*,,,,,1)]
&get`files`Rules #51=[cluster_Lattr(#50/rules`*,,,,,1)]
&get`files`name #51=[cluster_get(#50/%0)]
