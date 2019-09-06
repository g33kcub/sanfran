@@------------------------------------------------------------------------------
@@  @sysmng [<page>]                        - Shows a list of all systems.
@@  @sysmng/activate <system name>          - Activates a System.
@@  @sysmng/deactivate <system name>        - Deactivates a System.
@@  @sysmng/lock <system name>              - Locks a system as either active or deactivated. It is not able to be uninstalled.
@@  @sysmng/unlock <system name>            - Unlocks a system, making it changeable.
@@  @sysmng/info <system name>              - View system information for the system.
@@  @sysmng/ignore <system name>            - Marks a system as ignored.
@@
@@------------------------System Management Stuff-------------------------------
@@ Do not remove. Edit as needed.
&matrix`name #52=SYSMNG
&matrix`desc #52=The System manager system. It controls what is active.
&matrix`active #52=1
&matrix`credit #52=Mr. Black ($g33kcub) @ Here, Seamus@MSB, Matrix@Due Rewards/WORA
&matrix`locked #52=1
&matrix`obj #52=#52:1567775709
&matrix`cmd #52=#52:1567775709
&matrix`ignore #52=0
@@
@@-------------------------Help Files-------------------------------------------
@@ &help`sysmng# Formatting
@@------------------------------------------------------------------------------

&systems #52=[children(#53)]
&systems`active #52=[filter(systems`active`fil,[u(systems)])]
&systems`active`fil #52=[u(%0/matrix`active)]
&systems`locked #52=[filter(systems`locked`fil,[u(systems`active)])]
&systems`locked`fil #52=[u(%0/matrix`locked)]
&systems`ignore #52=[filter(systems`ignore`fil,[u(systems`ACTIVE)])]
&systems`ignore`fil #52=[u(%0/matrix`ignore)]
&systems`deactive #52=[filter(systems`deactive`fil,[u(systems)])]
&systems`deactive`fil #52=[not([u(%0/matrix`active)])]

&cmd`sysmng #52=$^@sysmng(?\:/(\\S+)?)?(?\: +(.+?))?(?\:=(.*))?$:@attach %!/CMD`sysmng`MAIN
@set #52/cmd`sysmng=regexp
&cmd`sysmng`main #52=@attach/override %!/inc`switches=%1;@attach %!/run`[strfirstof(%q<switch>,main)]=%2,%3

&canuse #52=[gte(bittype(%#),2)]
@lock/use #52=canuse/1

&switches`staff #52=INFO
&switches`immortal #52=ACTIVATE|DEACTIVATE|LOCK|UNLOCK|IGNORE

&run`main #52=th [setq(pg,strfirstof(%0,1))][setq(sys,[u(systems`active)])][setq(ign,[u(systems`ignore)])][setq(act,[setdiff(%q<sys>,%q<ign>)])];@pemit %#=[line(System Manager,2header,,System List)]%R[ansi([gameconfig(columns)],[printf($-8:.:s $-30:.:s $4:.:s $4:.:s $3:.:s,Sys Name,Object Full Name,Act?,Lck?,Ob#)])];@pemit %#=[iter(sortby(sort`sysname,%q<act>),[u(run`main`fmt,##)],%B,%R)];@pemit %#=[line(Ignored Active Systems)]%R[ansi([gameconfig(columns)],[printf($-8:.:s $-30:.:s $4:.:s $4:.:s $3:.:s,Sys Name,Object Full Name,Act?,Lck?,Ob#)])];@pemit %#=[iter(sortby(sort`sysname,%q<ign>),[u(run`main`fmt,##)],%B,%R)];@pemit %#=[line(@sysmng/info <system name>)]

&sort`sysname #52=[comp([get(%0/matrix`name)],[get(%1/matrix`name)])]
&run`main`fmt #52=[ljc([get(%0/matrix`name)],8)]%B[ljc([name(%0)],30)]%B[ljc([if([get(%0/matrix`active)],[ansi(010,Yes)],[ansi(009,No)])],4)]%B[ljc([if([get(%0/matrix`locked)],[ansi(010,Yes)],[ansi(009,No)])],4)]%B[center([words([get(%0/matrix`obj)])],3)]
