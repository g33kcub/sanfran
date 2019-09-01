@@ Code: #48
@@ System Zone: #48

@@------------------------------------------------------------------------------
@@  @sys [<page>]                           - Shows a list of all systems.
@@  @sys/activate <system name>             - Activates a System.
@@  @sys/deactivate <system name>           - Deactivates a System.
@@  @sys/install <system name>=<dbref>      - Installs a system.
@@  @sys/uninstall <system name>            - Uninstalls a system and deactivates it. It also sets the command object inactive.
@@  @sys/lock <system name>                 - Locks a system as either active or deactivated. It is not able to be uninstalled.
@@  @sys/unlock <system name>               - Unlocks a system, making it changeable.
@@
@@------------------------Functions---------------------------------------------
@@  system(switch,sysname)                  - Triggers and checks based on switch.
@@
&functionlist #48=system

&system #34=[if(hasattr(#48/system`%0),[u(#48/system`%0,%1)],[alert(S1)])]
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
@@
@@-------------------------Help Files-------------------------------------------
@@ &help`sysmng# Formatting
@@------------------------------------------------------------------------------
