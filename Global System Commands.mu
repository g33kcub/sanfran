@@ Code: #49
@@ System Zone: #45

@@------------------------------------------------------------------------------
@@  @error <players>=<msg>                  - Sends a formatted message.
@@------------------------System Management Stuff-------------------------------
@@ Do not remove. Edit as needed.
&matrix`name #49=GSYSTEM
&matrix`ignore #49=1
@@
@@-------------------------Help Files-------------------------------------------
@@ &help`gsystem# Formatting
@@------------------------------------------------------------------------------

&cmd`error #49=$@error *=*/*/*:@pemit/list %0=[u(#46/build`head,%1)] [ansi(009,Error)]: %3
&cmd`msg #49=$@msg *=*/*/*:@pemit/list %0=[u(#46/build`head,%1)] %3
&CMD`CHARSET #49=$+charset:@pemit %#=[line(Character Set,header)];@pemit %#=wrap(iter(lnum(0,400),if(comp(first(chr(%i0)),#-1),ljust([ljust([ansi([gameconfig(line_text)],%i0)]:,4)] [ansi([gameconfig(line_accent)],chr(%i0))],7)),%B,),[width(%#)]);@pemit %#=[line()]
