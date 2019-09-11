@@ Standard System (#39)
@create Standard System
@link Standard System = #0
@set Standard System = NO_COMMAND
&DESCRIBE Standard System=Declares some standard behavior found in most code.
@set Standard System/DESCRIBE=no_command visual prefixmatch public nearby
&FN Standard System=
&FN`DISPLAY Standard System=
&FN`DISPLAY`FOOTER Standard System=footer(%0,%1)
&FN`DISPLAY`HEADER Standard System=header(%0,%1)
&FN`DISPLAY`MIDLINE Standard System=midline(%0,%1)
&FN`DISPLAY`OUTERFOOTER Standard System=outerfooter(%0,%1)
&FN`DISPLAY`OUTERHEADER Standard System=outerheader(%0,%1)
&FN`META Standard System=[v(data`scene`meta)]owner
&FN`META`KEY Standard System=if(hasattrp(%!/data`[v(syscode)]`meta`[edit(%0,.,`)]),lcstr(v(data`[v(SYSCODE)]`meta)[edit(%0,`,.)]),#-1 Bad Key)
&FN`META`VALUE Standard System=switch(strlen(%1),0,null,switch(v(data`[v(SYSCODE)]`meta`[edit(%0,%b,_,.,`)]),array,'[render(%1,ansi)]',json(v(data`[v(SYSCODE)]`meta`[edit(%0,%b,_,.,`)]),render(%1,ansi)) ) )
&FN`TIMESTAMP Standard System=sql(SELECT UTC_TIMESTAMP())
&INCLUDE Standard System=
&INCLUDE`FOOTER Standard System=@pemit firstof(%1,%#)=u(fn`display`footer,%0,%1)
&INCLUDE`HEADER Standard System=@pemit firstof(%1,%#)=u(fn`display`header,%0,%1)
&INCLUDE`LOG Standard System=@nspemit strfirstof(%2,%:)=\[[ansi(hw,udefault(syscode,name(%!)))] - [switch(%0,warn,ansi(hy,WARN),error,ansi(hr,ERROR),success,ansi(hg,SUCCESS),info,ansi(hw,INFO),ansi(hw,INFO))]\]: %1
&INCLUDE`MIDLINE Standard System=@pemit firstof(%1,%#)=u(fn`display`midline,%0,%1)
&INCLUDE`OUTERFOOTER Standard System=@pemit firstof(%1,%#)=u(fn`display`outerfooter,%0,%1)
&INCLUDE`OUTERHEADER Standard System=@pemit firstof(%1,%#)=u(fn`display`outerheader,%0,%1)
&VE Standard System=me/include`entity
&VF Standard System=me/include`footer
&VH Standard System=me/include`header
&VL Standard System=me/include`log
&VM Standard System=me/include`midline
&VR Standard System=me/include`relationship
&VZ Standard System=me/include`log
