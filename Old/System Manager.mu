@@ Code: #48
@@ System Zone: #45

@@------------------------------------------------------------------------------
@@  @sysmng [<page>]                        - Shows a list of all systems.
@@  @sysmng/activate <system name>          - Activates a System.
@@  @sysmng/deactivate <system name>        - Deactivates a System.
@@  @sysmng/install <system name>=<dbref>   - Installs a system.
@@  @sysmng/uninstall <system name>         - Uninstalls a system and deactivates it. It also sets the command object inactive.
@@  @sysmng/lock <system name>              - Locks a system as either active or deactivated. It is not able to be uninstalled.
@@  @sysmng/unlock <system name>            - Unlocks a system, making it changeable.
@@  @sysmng/info <system name>              - View system information for the system.
@@  @sysmng/ignore <system name>            - Marks a system as ignored.
@@  @sysmng/addobj <system name>=<dbref>    - Adds an object to the system.
@@  @sysmng/remobj <system name>=<dbref>    - Removes an object from the system.
@@  @sysmng/addcmd <system name>=<dbref>    - Adds an object as a command object.
@@  @sysmng/remcmd <system name>=<dbref>    - Removes an object as a command object.
@@  @sysmng/desc <system name>=<desc>       - Describes the system.
@@  @sysmng/credit <system name>=<credit>   - Assign credits if needed.
@@
@@------------------------System Management Stuff-------------------------------
@@ Do not remove. Edit as needed.
&matrix`name #48=SYSMNG
&matrix`desc #48=The System manager system. It controls what is active.
&matrix`active #48=1
&matrix`credit #48=Mr. Black ($g33kcub) @ Here, Seamus@MSB, Matrix@Due Rewards/WORA
&matrix`locked #48=1
&matrix`obj #48=#48:1567376801 #45:1567353361
&matrix`cmd #48=#48:1567376801
&matrix`ignore #48=0
@@
@@-------------------------Help Files-------------------------------------------
@@ &help`sysmng# Formatting
@@------------------------------------------------------------------------------

&canuse #48=[cand([gte(bittype(%#),6)],[hasrole(%#,Operations)],[hasrole(%#,Coder)])]
@@------REG CHECKLIST-----------------------------------------------------------
@@  Reg: 0 = @sysmng/switch system name=dbref
@@  Reg: 1 = switch
@@  Reg: 2 = system name
@@  Reg: 3 = dbref
@@  Reg: 4 =
@@  Reg: 5 =
@@  Reg: 6 =
@@  Reg: 7 =
@@  Reg: 8 =
@@  Reg: 9 =
@@------------------------------------------------------------------------------
&cmd`sysmng #48=$^@sysmng(?\:/(\\S+)?)?(?\: +(.+?))?(?\:=(.*))?$:@attach %!/CMD`sysmng`MAIN
&cmd`sysmng`main #48=@attach %!/inc`switches=%1;@attach %!/run`[strfirstof(%q<switch>,main)]=%2,%3

@lock/use #48=canuse/1


&switches`immortal #48=ACTIVATE|DEACTIVATE|INSTALL|UNINSTALL|LOCK|UNLOCK|INFO|IGNORE|ADDCMD|ADDOBJ|REMCMD|REMOBJ

&run`addobj #48=th [setq(list,[iter([lzone(#45)],[get(##/matrix`name)]~##,%B,|)])][setq(grab,[graball(%q<list>,[caps(%0)]~*,|,|)])][setq(dlist,[iter(%q<grab>,[after(##,~)],|,%B)])][setq(obj,[objid(%1)])];@stop [gte(words(%q<dlist>),2)]={@error %#=[u(matrix`name)]/%#/'[ansi(gameconfig(line_accent),%0)]' matches multiple items please be more specific!};@stop [not([isdbref(%q<dlist>)])]={@error %#=[u(matrix`name)]/%#/That is not a valid System.};@check [isdbref(%1)]={@error %#=[u(matrix`name)]/%#/That is not a valid DBREF.};@check [not([gtm([get(%q<obj>/matrix`obj)],%q<obj>)])]={@error %#=[u(matrix`name)]/%#/That object is already associated with '[ucstr(%0)]'.};&matrix`obj %q<dlist>=[setunion([get(%q<dlist>/matrix`obj)],%q<obj>)];@msg %#=[u(matrix`name)]/%#/Added. '[name(%q<obj>)]' has been added to the '[ucstr(%0)]' system.

&run`remobj #48=th [setq(list,[iter([lzone(#45)],[get(##/matrix`name)]~##,%B,|)])][setq(grab,[graball(%q<list>,[caps(%0)]~*,|,|)])][setq(dlist,[iter(%q<grab>,[after(##,~)],|,%B)])][setq(obj,[objid(%1)])];@stop [gte(words(%q<dlist>),2)]={@error %#=[u(matrix`name)]/%#/'[ansi(gameconfig(line_accent),%0)]' matches multiple items please be more specific!};@stop [not([isdbref(%q<dlist>)])]={@error %#=[u(matrix`name)]/%#/That is not a valid System.};@check [isdbref(%1)]={@error %#=[u(matrix`name)]/%#/That is not a valid DBREF.};@check [gtm([get(%q<obj>/matrix`obj)],%q<obj>)]={@error %#=[u(matrix`name)]/%#/That object is not listed as an object with the '[ucstr(%0)]' system.};&matrix`cmd %q<dlist>=[setdiff([get(%q<dlist>/matrix`cmd)],%q<obj>)];&matrix`obj %q<dlist>=[setdiff([get(%q<dlist>/matrix`obj)],%q<obj>)];@set %q<obj>=!commands;@zone/del %q<obj>=#45;@zone/del %q<obj>=#50;@msg %#=[u(matrix`name)]/%#/Removed. '[name(%q<obj>)]' has been removed from the '[ucstr(%0)]' system.

&run`addcmd #48=th [setq(list,[iter([lzone(#45)],[get(##/matrix`name)]~##,%B,|)])][setq(grab,[graball(%q<list>,[caps(%0)]~*,|,|)])][setq(dlist,[iter(%q<grab>,[after(##,~)],|,%B)])][setq(obj,[objid(%1)])];@stop [gte(words(%q<dlist>),2)]={@error %#=[u(matrix`name)]/%#/'[ansi(gameconfig(line_accent),%0)]' matches multiple items please be more specific!};@stop [not([isdbref(%q<dlist>)])]={@error %#=[u(matrix`name)]/%#/That is not a valid System.};@check [isdbref(%1)]={@error %#=[u(matrix`name)]/%#/That is not a valid DBREF.};@check [gtm([get(%q<obj>/matrix`obj)],%q<obj>)]={@error %#=[u(matrix`name)]/%#/That object is not associated with '[ucstr(%0)]' please add the object first.};&matrix`cmd %q<dlist>=[setunion([get(%q<dlist>/matrix`cmd)],%q<obj>)];@set %q<obj>=commands;@zone/add %q<obj>=#45;@zone/add %q<obj>=#50;@cluster/add #50=%q<obj>;@msg %#=[u(matrix`name)]/%#/Added. '[name(%q<obj>)]' has been added to the '[ucstr(%0)]' system as a command & help object.

&run`remcmd #48=th [setq(list,[iter([lzone(#45)],[get(##/matrix`name)]~##,%B,|)])][setq(grab,[graball(%q<list>,[caps(%0)]~*,|,|)])][setq(dlist,[iter(%q<grab>,[after(##,~)],|,%B)])][setq(obj,[objid(%1)])];@stop [gte(words(%q<dlist>),2)]={@error %#=[u(matrix`name)]/%#/'[ansi(gameconfig(line_accent),%0)]' matches multiple items please be more specific!};@stop [not([isdbref(%q<dlist>)])]={@error %#=[u(matrix`name)]/%#/That is not a valid System.};@check [isdbref(%1)]={@error %#=[u(matrix`name)]/%#/That is not a valid DBREF.};@check [gtm([get(%q<obj>/matrix`cmd)],%q<obj>)]={@error %#=[u(matrix`name)]/%#/That object is not listed as a command object with the '[ucstr(%0)]' system.};&matrix`cmd %q<dlist>=[setdiff([get(%q<dlist>/matrix`cmd)],%q<obj>)];@set %q<obj>=!commands;@zone/del %q<obj>=#45;@cluster/del #50=%q<obj>;@zone/del %q<obj>=#50;@msg %#=[u(matrix`name)]/%#/Removed. '[name(%q<obj>)]' has been removed from the '[ucstr(%0)]' system as a command & help object.

&run`unlock #48=th [setq(list,[iter([lzone(#45)],[get(##/matrix`name)]~##,%B,|)])][setq(grab,[graball(%q<list>,[caps(%0)]~*,|,|)])][setq(dlist,[iter(%q<grab>,[after(##,~)],|,%B)])];@stop [gte(words(%q<dlist>),2)]={@error %#=[u(matrix`name)]/%#/'[ansi(gameconfig(line_accent),%0)]' matches multiple items please be more specific!};@stop [not([isdbref(%q<dlist>)])]={@error %#=[u(matrix`name)]/%#/That is not a valid System.};@check [get(%q<dlist>/matrix`locked)]={@error %#=[u(matrix`name)]/%#/'[name(%q<dlist>)]' is currently unlocked.};&matrix`locked %q<dlist>=0;@msg %#=[u(matrix`name)]/%#/Unlocked. '[name(%q<dlist>)]' is now unlocked.


&run`lock #48=th [setq(list,[iter([lzone(#45)],[get(##/matrix`name)]~##,%B,|)])][setq(grab,[graball(%q<list>,[caps(%0)]~*,|,|)])][setq(dlist,[iter(%q<grab>,[after(##,~)],|,%B)])];@stop [gte(words(%q<dlist>),2)]={@error %#=[u(matrix`name)]/%#/'[ansi(gameconfig(line_accent),%0)]' matches multiple items please be more specific!};@stop [not([isdbref(%q<dlist>)])]={@error %#=[u(matrix`name)]/%#/That is not a valid System.};@stop [get(%q<dlist>/matrix`locked)]={@error %#=[u(matrix`name)]/%#/'[name(%q<dlist>)]' is currently locked.};&matrix`locked %q<dlist>=1;@msg %#=[u(matrix`name)]/%#/Locked. '[name(%q<dlist>)]' is now locked.

&run`uninstall #48=th [setq(list,[iter([lzone(#45)],[get(##/matrix`name)]~##,%B,|)])][setq(grab,[graball(%q<list>,[caps(%0)]~*,|,|)])][setq(dlist,[iter(%q<grab>,[after(##,~)],|,%B)])];@stop [gte(words(%q<dlist>),2)]={@error %#=[u(matrix`name)]/%#/'[ansi(gameconfig(line_accent),%0)]' matches multiple items please be more specific!};@stop [not([isdbref(%q<dlist>)])]={@error %#=[u(matrix`name)]/%#/That is not a valid System.};@zone/del %q<dlist>=#45;@zone/del %q<dlist>=#50;@dolist [get(%q<dlist>/matrix`cmd)]={@set ##=!commands};&matrix`active %q<dlist>=0;&matrix`locked %q<dlist>=0;@msg %#=[u(matrix`name)]/%#/'[ucstr(%0)]' has now been uninstalled from the system.

&run`install #48=th [setq(ins,iter([lzone(#45)],[get(##/matrix`name)],%B,|))];@stop [gtm(%q<ins>,%0,|)]={@error %#=[U(matrix`name)]/%#/'[ucstr(%0)]' is already an installed system.};@check [isdbref(%1)]={@error %#=[u(matrix`name)]/%#/Not a valid DBREF.};@stop [gtm([lzone(#45)],%1)]={@error %#=[u(matrix`name)]/%#/That object already belongs to '[u(%1/matrix`name)]'.};&matrix`name %1=[ucstr(%0)];&matrix`obj %1=[objid(%1)];@msg %#=[u(matrix`name)]/%#/'[name(%1)]' has been installed as '[ucstr(%0)]';@zone/add %1=#45;@zone/add %1=#50;&matrix`obj %q<dlist>=[objid(%q<dlist>)]

&run`deactivate #48=th [setq(list,[iter([lzone(#45)],[get(##/matrix`name)]~##,%B,|)])][setq(grab,[graball(%q<list>,[caps(%0)]~*,|,|)])][setq(dlist,[iter(%q<grab>,[after(##,~)],|,%B)])];@stop [gte(words(%q<dlist>),2)]={@error %#=[u(matrix`name)]/%#/'[ansi(gameconfig(line_accent),%0)]' matches multiple items please be more specific!};@stop [not([isdbref(%q<dlist>)])]={@error %#=[u(matrix`name)]/%#/That is not a valid System.};@stop [get(%q<dlist>/matrix`locked)]={@error %#=[u(matrix`name)]/%#/'[name(%q<dlist>)]' is locked. No changes will not be allowed.};@stop [not([u(matrix`active)])]={@error %#=[u(matrix`name)]/%#/'[name(%q<dlist>)]' is not currently listed as active.};@dolist [get(%q<dlist>/matrix`cmd)]={@set ##=!COMMANDS};&matrix`active %q<dlist>=0;@msg %#=[u(matrix`name)]/%#/Set. [name(%q<dlist>)] has been deactivated.

&run`activate #48=th [setq(list,[iter([lzone(#45)],[get(##/matrix`name)]~##,%B,|)])][setq(grab,[graball(%q<list>,[caps(%0)]~*,|,|)])][setq(dlist,[iter(%q<grab>,[after(##,~)],|,%B)])];@stop [gte(words(%q<dlist>),2)]={@error %#=[u(matrix`name)]/%#/'[ansi(gameconfig(line_accent),%0)]' matches multiple items please be more specific!};@stop [not([isdbref(%q<dlist>)])]={@error %#=[u(matrix`name)]/%#/That is not a valid System.};@stop [get(%q<dlist>/matrix`locked)]={@error %#=[u(matrix`name)]/%#/'[name(%q<dlist>)]' is locked. No changes will not be allowed.};@stop [u(matrix`active)]={@error %#=[u(matrix`name)]/%#/'[name(%q<dlist>)]' is already activated.};@dolist [get(%q<dlist>/matrix`cmd)]={@set ##=COMMANDS};&matrix`active %q<dlist>=1;@msg %#=[u(matrix`name)]/%#/Set. [name(%q<dlist>)] has been activated.

&fil_issystem #48=[not([get(%0/matrix`ignore)])]

&run`main #48=th [setq(pg,strfirstof(%0,1))][setq(sys,[filter(#48/fil_issystem,[lzone(#45)])])][setq(pages,u(get`pages,%q<sys>))];@attach %!/inc`partial=%q<pg>,[lnum(1,%q<pages>)],%B,page,page;@pemit %#=[line(System Manager,2header,,System List)]%R[ansi([gameconfig(columns)],[printf($-8:.:s $-30:.:s $4:.:s $4:.:s $3:.:s,Sys Name,Object Full Name,Act?,Lck?,Ob#)])];@pemit %#=[iter(sortby(sort`sysname,%q<sys>),[u(run`main`fmt,##)],%B,%R)];@pemit %#=[line(Page %q<pg> of %q<pages>,,,40)][line(@sysmng/info <system name>,,,40)]

&sort`sysname #48=[comp([get(%0/matrix`name)],[get(%1/matrix`name)])]
&run`main`fmt #48=[ljc([get(%0/matrix`name)],8)]%B[ljc([name(%0)],30)]%B[ljc([if([get(%0/matrix`active)],[ansi(010,Yes)],[ansi(009,No)])],4)]%B[ljc([if([get(%0/matrix`locked)],[ansi(010,Yes)],[ansi(009,No)])],4)]%B[center([words([get(%0/matrix`obj)])],3)]

&get`pages #48=[setq(cnt,words(%0))][setq(div,[fdiv(%q<cnt>,15)])][if(gte([after(%q<div>,.)],1),inc(before(%q<div>,.)),%q<div>)]
&get`page`count #48=[extract(%0,[extract(u(get`page`list),%1,1)],15)]
&get`page`list #48=[iter([lnum(0,40)],[inc(mul(##,15))])]

&run`info #48=th [setq(list,[iter([lzone(#45)],[get(##/matrix`name)]~##,%B,|)])][setq(grab,[graball(%q<list>,[caps(%0)]~*,|,|)])][setq(dlist,[iter(%q<grab>,[after(##,~)],|,%B)])];@stop [gte(words(%q<dlist>),2)]={@error %#=[u(matrix`name)]/%#/'[ansi(gameconfig(line_accent),%0)]' matches multiple items please be more specific.};@stop [not([isdbref(%q<dlist>)])]={@error %#=[u(matrix`name)]/%#/That is not a valid System.};@pemit %#=[line(System Manager,2header,,[name(%q<dlist>)])]%R[ljc([ansi([gameconfig(line_text)],System Name)]:,15)]%B[get(%q<dlist>/matrix`name)]%R[ljc([ansi(gameconfig(line_text),System Desc)]:,15)]%B[wrap([get(%q<dlist>/matrix`desc)],[sub([width(%#)],16)],left,,,16)]%R[ljc([ansi(gameconfig(line_text),System Credits)]:,15)]%B[get(%q<dlist>/matrix`credit)]%R[ljc([ansi(gameconfig(line_text),System Flags)]:,15)]%B[itemize([if(get(%q<dlist>/matrix`active),Active)] [if(get(%q<dlist>/matrix`locked),Locked)] [if(get(%q<dlist>/matrix`ignored),Ignored)],%B,&)]%R[line(Objects Associated With System)][step(run`info`step,sortby(sort`dname,[get(%q<dlist>/matrix`obj)]),2,%B,)];@pemit %#=[line()]

&run`info`step #48=%R[printf($-39s %B$-39s,[u(run`info`fmt,%0)],[u(run`info`fmt,%1)])]
&sort`dname #48=[comp(name(%0),name(%1))]
&run`info`fmt #48=[ljc([before(%0,:)],6,.)]%B[center([if([gtm([get(%q<dlist>/matrix`cmd)],%0)],[ansi(010,$)])],3,.)]%B[ljc([name(%0)],28,.)]

&run`ignore #48=th [setq(list,[iter([lzone(#45)],[get(##/matrix`name)]~##,%B,|)])][setq(grab,[graball(%q<list>,[caps(%0)]~*,|,|)])][setq(dlist,[iter(%q<grab>,[after(##,~)],|,%B)])];@stop [gte(words(%q<dlist>),2)]={@error %#=[u(matrix`name)]/%#/'[ansi(gameconfig(line_accent),%0)]' matches multiple items please be more specific!};@stop [not([isdbref(%q<dlist>)])]={@error %#=[u(matrix`name)]/%#/That is not a valid System.};@switch [get(%q<dlist>/matrix`ignore)]=0,{&matrix`ignore %q<dlist>=1;@msg %#=[u(matrix`Name)]/%#/Set. [name(%q<dlist>)] is now set to be ignored by @sysmng.},1,{&matrix`ignore %q<dlist>=0;@msg %#=[u(matrix`name)]/%#/Set. [name(%q<dlist>)] is no longer ignored by @sysmng.}
