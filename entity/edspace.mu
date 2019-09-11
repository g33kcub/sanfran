
@@ Entity Dynamic Space (#31)
@create Entity Dynamic Space
@link Entity Dynamic Space = #0
@parent Entity Dynamic Space=#3
@set Entity Dynamic Space = WIZARD
@power Entity Dynamic Space = No_Pay
&CMD Entity Dynamic Space=
&CMD`EDSPACE Entity Dynamic Space=
&CMD`EDSPACE`ADMIN Entity Dynamic Space=
&CMD`EDSPACE`ADMIN`BLOCK Entity Dynamic Space=$+edspace/block *:@assert match(iter(lattr(me/data`edspace`*`Fullname),u(%i0),,;),%0,;)=@inc %vl=ERROR,That is not a valid direction.;  @inc %wi`block=%l,%0; @inc %wi`save=%l; @inc %vl=SUCCESS,Blocked %q<Exit>!
&CMD`EDSPACE`ADMIN`CONNECT Entity Dynamic Space=$+edspace/connect *=* * * *: @break setr(Exit,locate(#85,%0,E))=@inc %vl=ERROR,Invalid Direction - that is a standard Entity Dynamic Space exit. ; @assert setr(Exit,locate(%l,%0,E))=@inc %vl=ERROR,Could not find exit. ; @link %q<Exit>=VARIABLE; @assert u(fn`edspace`get`roominfo`atcoordinates,%1,%2,%3,%4)=@inc %vl=ERROR,No such room coordinates. ; &destination %q<Exit>=u\(#31/fn`edspace`room,%1,%2,%3,%4\); @chown/preserve %q<Exit>=owner(%!); @set %q<Exit>=!halt wizard; &destination %q<Exit>=u\(#31/fn`edspace`room,%1,%2,%3,%4\); @inc %vl=SUCCESS,Connected!
&CMD`EDSPACE`ADMIN`DIG Entity Dynamic Space=$+edspace/dig/copy *: @assert setr(Exit,locate(#85,%0,E))=@inc %vl=ERROR,Invalid Direction.; @break u(%q<Exit>/destination)=@inc %vl=ERROR,Room already exists!; @inc %wi`createroom=add(get(%l/x),get(%q<Exit>/mod`x)),add(get(%l/y),get(%q<Exit>/mod`y)),add(get(%l/z),get(%q<Exit>/mod`z)),json_query(get(%l/region),unescape); @inc %wi`copy=u(fn`get`entity_by_objid,Dynamic Room,objid(%l)),%q<EntityID>
&CMD`EDSPACE`ADMIN`ID Entity Dynamic Space=$+edspace/id: @assert setr(Result,u(fn`get`entity_by_objid,Dynamic Room,objid(%l)))=@inc %vl=ERROR,Not a Dynamic Room. ; @inc %vl=SUCCESS,%q<Result>
&CMD`EDSPACE`ADMIN`REGION Entity Dynamic Space=
&CMD`EDSPACE`ADMIN`REGION`ADD Entity Dynamic Space=$+edspace/create *:@assert valid(playername,%0)=@inc %vl=ERROR,Not a valid name for a region. ; @inc %wi`region`add=%0
&CMD`EDSPACE`ADMIN`SAVE Entity Dynamic Space=$+edspace/save:@inc %wi`save=%l
&CMD`EDSPACE`ADMIN`TRAIT Entity Dynamic Space=
&CMD`EDSPACE`ADMIN`TRAIT`SET Entity Dynamic Space=$+edspace/trait/set *:@assert strmatch(%0,*:*)=@inc %vl=ERROR,Wrong format. Expected 'Trait:Subtrait'. ; @assert hasattr(setr(Legend,locate(%!,EDSpace Map Legend,T)),setr(Attr,map`[first(%0,:)]`[rest(%0,:)]))=@inc %vl=ERROR,No such Trait found. ;  @assert setr(Result,u(fn`get`entity_by_objid,Dynamic Room,objid(%l)))=@inc %vl=ERROR,Not a Dynamic Room. ; @inc %vl=INFO,Setting trait '%0' -> [u(%q<Legend>/%q<Attr>)]. ; @inc %wi`trait`set=%:,%q<Result>,%l,%0
&CMD`EDSPACE`ADMIN`UNBLOCK Entity Dynamic Space=$+edspace/unblock *:@assert match(iter(lattr(me/data`edspace`*`Fullname),u(%i0),,;),%0,;)=@inc %vl=ERROR,That is not a valid direction.;  @inc %wi`unblock=%l,%0; @inc %wi`save=%l; @inc %vl=SUCCESS,Unblocked %q<Exit>!
&CMD`EDSPACE`FEATURES Entity Dynamic Space=$+edspace/features:@inc %wi`features;
&CMD`EDSPACE`MAP Entity Dynamic Space=$+map: @inc %wi`showmap=get(%l/x),get(%l/y),get(%l/z),firstof(json_query(get(%l/region),unescape),v(data`edspace`dspace`defaultregion)),dec(div(width(%#),2)),dec(div(height(%#),2))
&CMD`EDSPACE`PALETTE Entity Dynamic Space=$+edspace/traits:@inc %wi`palette;
&CMD`EDSPACE`TEL Entity Dynamic Space=$+tel *:@tel %#=%0
&DATA Entity Dynamic Space=
&DATA`EDSPACE Entity Dynamic Space=
&DATA`EDSPACE`COMPASS Entity Dynamic Space=NW%b%bN%b%bNE%r%b%bNW1 N1 NE1%r%b%b%bNW2N2NE2%b%b%rWW1W2U1 D1E2E1E%r%b%b%bSW2S2SE2%b%b%r%b%bSW1 S1 SE1%rSW%b%bS%b%bSE
&DATA`EDSPACE`COMPASS`E1 Entity Dynamic Space=·
&DATA`EDSPACE`COMPASS`E2 Entity Dynamic Space=-
&DATA`EDSPACE`COMPASS`N1 Entity Dynamic Space=.
&DATA`EDSPACE`COMPASS`N2 Entity Dynamic Space=|
&DATA`EDSPACE`COMPASS`NE1 Entity Dynamic Space=.
&DATA`EDSPACE`COMPASS`NE2 Entity Dynamic Space=/
&DATA`EDSPACE`COMPASS`NW1 Entity Dynamic Space=.
&DATA`EDSPACE`COMPASS`NW2 Entity Dynamic Space=\
&DATA`EDSPACE`COMPASS`S1 Entity Dynamic Space='
&DATA`EDSPACE`COMPASS`S2 Entity Dynamic Space=|
&DATA`EDSPACE`COMPASS`SE1 Entity Dynamic Space='
&DATA`EDSPACE`COMPASS`SE2 Entity Dynamic Space=\
&DATA`EDSPACE`COMPASS`SW1 Entity Dynamic Space='
&DATA`EDSPACE`COMPASS`SW2 Entity Dynamic Space=/
&DATA`EDSPACE`COMPASS`W1 Entity Dynamic Space=·
&DATA`EDSPACE`COMPASS`W2 Entity Dynamic Space=-
&DATA`EDSPACE`DOWN Entity Dynamic Space=
&DATA`EDSPACE`DOWN`FULLNAME Entity Dynamic Space=Down;D;dow;do
&DATA`EDSPACE`DOWN`XYZMOD Entity Dynamic Space=0 0 1
&DATA`EDSPACE`DSPACE Entity Dynamic Space=
&DATA`EDSPACE`DSPACE`DEFAULTREGION Entity Dynamic Space=Overworld
&DATA`EDSPACE`DSPACE`REGIONS Entity Dynamic Space=
&DATA`EDSPACE`DSPACE`REGIONS`OVERWORLD Entity Dynamic Space=Overworld
&DATA`EDSPACE`EAST Entity Dynamic Space=
&DATA`EDSPACE`EAST`FULLNAME Entity Dynamic Space=East;E;eas;ea
&DATA`EDSPACE`EAST`XYZMOD Entity Dynamic Space=1 0 0
&DATA`EDSPACE`META Entity Dynamic Space=edspace.
&DATA`EDSPACE`META`BLOCKED Entity Dynamic Space=array
&DATA`EDSPACE`META`REGION Entity Dynamic Space=string
&DATA`EDSPACE`META`SEED Entity Dynamic Space=number
&DATA`EDSPACE`META`TRAITS Entity Dynamic Space=array
&DATA`EDSPACE`META`X Entity Dynamic Space=number
&DATA`EDSPACE`META`Y Entity Dynamic Space=number
&DATA`EDSPACE`META`Z Entity Dynamic Space=number
&DATA`EDSPACE`NORTH Entity Dynamic Space=
&DATA`EDSPACE`NORTHEAST Entity Dynamic Space=
&DATA`EDSPACE`NORTHEAST`FULLNAME Entity Dynamic Space=Northeast;NE;Northeas;northeas;northea;northe
&DATA`EDSPACE`NORTHEAST`XYZMOD Entity Dynamic Space=1 1 0
&DATA`EDSPACE`NORTHWEST Entity Dynamic Space=
&DATA`EDSPACE`NORTHWEST`FULLNAME Entity Dynamic Space=Northwest;NW;Northwes;northwe;northw
&DATA`EDSPACE`NORTHWEST`XYZMOD Entity Dynamic Space=-1 1 0
&DATA`EDSPACE`NORTH`FULLNAME Entity Dynamic Space=North;N;nort;nor;no
&DATA`EDSPACE`NORTH`XYZMOD Entity Dynamic Space=0 1 0
&DATA`EDSPACE`SOUTH Entity Dynamic Space=
&DATA`EDSPACE`SOUTHEAST Entity Dynamic Space=
&DATA`EDSPACE`SOUTHEAST`FULLNAME Entity Dynamic Space=Southeast;SE;Southeas;southeas;southea;southe
&DATA`EDSPACE`SOUTHEAST`XYZMOD Entity Dynamic Space=1 -1 0
&DATA`EDSPACE`SOUTHWEST Entity Dynamic Space=
&DATA`EDSPACE`SOUTHWEST`FULLNAME Entity Dynamic Space=Southwest;SW;Southwes;Southwe;Southw
&DATA`EDSPACE`SOUTHWEST`XYZMOD Entity Dynamic Space=-1 -1 0
&DATA`EDSPACE`SOUTH`FULLNAME Entity Dynamic Space=South;S;sout;sou;so
&DATA`EDSPACE`SOUTH`XYZMOD Entity Dynamic Space=0 -1 0
&DATA`EDSPACE`UP Entity Dynamic Space=
&DATA`EDSPACE`UP`FULLNAME Entity Dynamic Space=Up;U;up
&DATA`EDSPACE`UP`XYZMOD Entity Dynamic Space=-0 0 -1
&DATA`EDSPACE`WEST Entity Dynamic Space=
&DATA`EDSPACE`WEST`FULLNAME Entity Dynamic Space=West;W;wes;we
&DATA`EDSPACE`WEST`XYZMOD Entity Dynamic Space=-1 0 0
&FN Entity Dynamic Space=
&FN`EDSPACE Entity Dynamic Space=
&FN`EDSPACE`DISPLAY Entity Dynamic Space=
&FN`EDSPACE`DISPLAY`COMPASS Entity Dynamic Space=@@(fold(%=`fold,U D NE NW SE SW N E S W,u(#31/data`edspace`compass)))
@set Entity Dynamic Space/FN`EDSPACE`DISPLAY`COMPASS=public
&FN`EDSPACE`DISPLAY`COMPASS`FOLD Entity Dynamic Space=edit(%0,%11,if(setr(CanGo,u(locate(u(fn`edspace`get`parent),%1,E)/cango)) ,v(data`edspace`compass`%11),%b),%12,if(%q<CanGo>,v(data`edspace`compass`%12),%b) )
&FN`EDSPACE`DISPLAY`FEATURELIST Entity Dynamic Space=[midline(ansi(scolor(primary,1),capstr(lcstr(last(%1,`)))))]%r[iter(%1 [lattr(%0/%1`)],u(%=`map,%0,%1,%i0),,%r)]
&FN`EDSPACE`DISPLAY`FEATURELIST`MAP Entity Dynamic Space=[ansi(scolor(primary,1),last(%2,`))]: [u(%0/%2)]
&FN`EDSPACE`DISPLAY`MAPLINE Entity Dynamic Space=[setq(x,json_query(%4,extract,$.[u(fn`meta`key,x)]))][setq(CurX,if(strlen(%q<CurX>),%q<CurX>,%q<MinX>))][repeat(%b,sub(%q<X>,%q<CurX>))][if(isobjid(%3),ccmdtag(@tel %3,ansi(u(legend/fn`traitcolor,setr(Traits,json_query(%4,extract,$.[u(fn`meta`key,traits)]\[0\]))),u(legend/fn`traitsymbol,%q<Traits>,%3,%#))),ansi(u(legend/fn`traitcolor,setr(Traits,json_query(%4,extract,$.[u(fn`meta`key,traits)]\[0\]))),u(legend/fn`traitsymbol,%q<Traits>,%3,%#)))][setq(CurX,inc(%q<X>))]
&FN`EDSPACE`DISPLAY`MAPRECT Entity Dynamic Space=[iter(lnum(-3,3),strfirstof(localize(mapsql(%!/fn`edspace`display`mapline,u(fn`edspace`get`roominfo`incoordinatesline_prepare,-3,3,%i0,0),)),%b),,%r)]
&FN`EDSPACE`DISPLAY`MINIMAP Entity Dynamic Space=[setq(Size,u(fn`edspace`get`minimapsize))][setq(minx,sub(get(%0/x),%q<Size>),maxx,add(get(%0/x),%q<Size>),miny,sub(get(%0/y),%q<Size>),maxy,add(get(%0/y),%q<Size>),region,json_query(get(%0/region),unescape))][iter(lnum(%q<maxy>,%q<miny>),strfirstof(localize(mapsql(me/fn`edspace`display`mapline,u(fn`edspace`get`roominfo`incoordinatesline_prepare,%q<minx>,%q<maxx>,%i0,get(%0/z),%q<region>),)),%b),,%r)]
@set Entity Dynamic Space/FN`EDSPACE`DISPLAY`MINIMAP=visual public
&FN`EDSPACE`DISPLAY`TRAITLIST Entity Dynamic Space=[midline(ansi(scolor(primary,1),capstr(lcstr(last(%1,`)))) \[[left(u(%=`map,%0,%1,%1),1)]\] )]%r[iter(reglattr(%0/^%1`\(\(?!color|symbol|features\).\)*$),u(%=`map,%0,%1,%i0),,%r)]
&FN`EDSPACE`DISPLAY`TRAITLIST`MAP Entity Dynamic Space=[ansi(u(%0/[extract(%2,1,2,`)]`color,last(%2,`)),u(%0/[extract(%2,1,2,`)]`symbol,last(%2,`)))] \[[ansi(hw,[extract(%2,2,1,`)]:[extract(%2,3,1,`)])]\]: [u(%0/%2)]%r> Features: [u(%0/%2`features)]
&FN`EDSPACE`DO Entity Dynamic Space=
&FN`EDSPACE`DO`EXIT Entity Dynamic Space=
&FN`EDSPACE`DO`EXIT`OPEN Entity Dynamic Space=[attrib_set(open(u(fn`edspace`get`exit`FullName,%0),variable,%1)/DESTINATION,u(GoDynamic,[u(fn`edspace`get`Exit`calculatetargetcoordinates,X,Y,Z,%0)]))]
&FN`EDSPACE`DO`GO Entity Dynamic Space=[firstof(u(fn`edspace`get`room,u(fn`edspace`get`Exit`calculatetargetcoordinates,X,Y,Z,%0)),[setr(DynamicRoom,dig(Dynamic Room))][null([parent(%q<DynamicRoom>,Dynamic Room Parent)][iter(North NorthEast East SouthEast South SouthWest West NorthWest Up Down,u(fn`edspace`do`exit`open,%q<DynamicRoom>,%i0))])])]
&FN`EDSPACE`DO`GO`CC Entity Dynamic Space=CurrentX:CurrentY:CurrentZ:*:Direction r:dbref:CreatedOrExistingRoom sfx qreg
&FN`EDSPACE`DO`GO`DOC Entity Dynamic Space=Given CURRENTX, CURRENTY, CURRENTZ coordinates, and an optional DIRECTION; returns the room number that has been created, or found, based on the target of travel.
&FN`EDSPACE`GET Entity Dynamic Space=
&FN`EDSPACE`GET`BLOCKED Entity Dynamic Space=%0
&FN`EDSPACE`GET`BLOCKED`FROMCONTENT Entity Dynamic Space=json_map(#lambda/%%1,json_query(%0,get,blocked))
&FN`EDSPACE`GET`DIRECTION Entity Dynamic Space=
&FN`EDSPACE`GET`DIRECTION`BYALIAS Entity Dynamic Space=regrepi(%!,data`*`fullname,\[;^\]%0\[;$\])
&FN`EDSPACE`GET`EMPTYROOMS Entity Dynamic Space=lsearch(all,zone,u(fn`edspace`get`parent),eroom,\[not(words(lcon(##)))\])
&FN`EDSPACE`GET`EXIT Entity Dynamic Space=
&FN`EDSPACE`GET`EXIT`CALCULATETARGETCOORDINATES Entity Dynamic Space=vadd(%0 %1 %2,v(data`%3`xyzmod))
&FN`EDSPACE`GET`EXIT`CALCULATETARGETCOORDINATES`CC Entity Dynamic Space=CurrentX:CurrentY:CurrentZ:*:Direction r:list:TargetCoordinates func
&FN`EDSPACE`GET`EXIT`CALCULATETARGETCOORDINATES`DOC Entity Dynamic Space=Given CURRENTX, CURRENTY, CURRENTZ coordinates, and an optional DIRECTION; returns the resulting coordinates of the calculation in list format.
&FN`EDSPACE`GET`EXIT`FULLNAME Entity Dynamic Space=v(data`%0`fullname)
&FN`EDSPACE`GET`EXIT`FULLNAME`CC Entity Dynamic Space=direction r:list:fullname
&FN`EDSPACE`GET`EXIT`FULLNAME`DOC Entity Dynamic Space=Given a Direction: North, South, East, West, Northeast, Northwest, Southeast or Southwest, returns the semicolon-seperated list used for exits.
&FN`EDSPACE`GET`LOCATION Entity Dynamic Space=0 0 0
&FN`EDSPACE`GET`MINIMAPSIZE Entity Dynamic Space=3
&FN`EDSPACE`GET`PARENT Entity Dynamic Space=first(lsearch(all,name,EDSpace Parent,type,room))
&FN`EDSPACE`GET`REGIONS Entity Dynamic Space=iter(data`dspace`regions`,u(%i0))
&FN`EDSPACE`GET`ROOMINFO Entity Dynamic Space=
&FN`EDSPACE`GET`ROOMINFO`ATCOORDINATES Entity Dynamic Space=u(w`query,get`entity_info`from_typeandselector::%t,Dynamic Room,u(%xb`and,u(%xb`equals,u(%xb`column_content,region),u(%xb`string,%3)),u(%xb`and,u(%xb`equals, u(%xb`column_content,x), u(%xb`int,%0)),u(%xb`and,u(%xb`equals, u(%xb`column_content,y), u(%xb`int,%1)),u( %xb`equals, u(%xb`column_content,z), u(%xb`int,%2) )))))
&FN`EDSPACE`GET`ROOMINFO`ATDB Entity Dynamic Space=localize(setr(EntityId,u(fn`get`entity_by_objid,Dynamic Room,objid(%0)))%t[u(fn`get`attr,%q<EntityId>,edspace)])
&FN`EDSPACE`GET`ROOMINFO`INCOORDINATESLINE_PREPARE Entity Dynamic Space=u(w`prepare,get`roominfo`incoordinatesline,%4,%0,%1,%2,%3)
&FN`EDSPACE`GET`ROOMINFO`INCOORDINATESRANGE Entity Dynamic Space=u(w`query,get`entity_info`from_typeandselector:%r:%t,Dynamic Room,u(%xb`and,u(%xb`equals,u(%xb`column_content,region),u(%xb`string,%6)),u(%xb`and,u(%xb`between_int, u(%xb`column_content,x), u(%xb`int,%0), u(%xb`int,%1)),u(%xb`and,u(%xb`between_int, u(%xb`column_content,y), u(%xb`int,%2), u(%xb`int,%3)),u( %xb`between_int, u(%xb`column_content,z), u(%xb`int,%4), u(%xb`int,%5) )))),ORDER BY [u(%xb`column_content,x)] ASC)
&FN`EDSPACE`GET`ROOMINFO`INCOORDINATESRANGE_PREPARE Entity Dynamic Space=u(w`prepare,get`entity_info`from_typeandselector:%r:%t,Dynamic Room,u(%xb`and,u(%xb`equals,u(%xb`column_content,region),u(%xb`string,%6)),u(%xb`and,u(%xb`between_int, u(%xb`column_content,x), u(%xb`int,%0), u(%xb`int,%1)),u(%xb`and,u(%xb`between_int, u(%xb`column_content,y), u(%xb`int,%2), u(%xb`int,%3)),u( %xb`between_int, u(%xb`column_content,z), u(%xb`int,%4), u(%xb`int,%5) )))),ORDER BY [u(%xb`column_content,x)] ASC)
&FN`EDSPACE`GET`ROOMJSON Entity Dynamic Space=
&FN`EDSPACE`GET`ROOMJSON`ATCOORDINATES Entity Dynamic Space=extract(u(fn`edspace`get`roominfo`atcoordinates,%0,%1,%2,%3),4,1,%t)
&FN`EDSPACE`GET`ROOMJSON`INCOORDINATESRANGE Entity Dynamic Space=iter(u(fn`edspace`get`roominfo`incoordinatesrange,%0,%1,%2,%3,%4,%5,%6),extract(%i0,5,1,%t),%r,%r)
&FN`EDSPACE`GET`ROOMOBJID Entity Dynamic Space=
&FN`EDSPACE`GET`ROOMOBJID`ATCOORDINATES Entity Dynamic Space=extract(u(fn`edspace`get`roominfo`atcoordinates,%0,%1,%2,%3),3,1,%t)
&FN`EDSPACE`GET`TRAITS Entity Dynamic Space=json_map(#lambda/%%1,get(%0/traits))
&FN`EDSPACE`ROOM Entity Dynamic Space=if(isobjid(setr(Objid,extract(setr(RoomInfo,u(fn`edspace`get`roominfo`atcoordinates,%0,%1,%2,%3)),3,1,%t))),%q<Objid>,u(%=`setup,%q<RoomInfo>,u(%=`dig,%q<RoomInfo>)))[@@(TODO: #-1 if there is no room there.)]
&FN`EDSPACE`ROOM`DIG Entity Dynamic Space=null(u(fn`set`objid,first(%0,%t),setr(Result,objid(dig(localize(json_query(json_query(setr(Json,json_query(extract(%0,4,1,%t),get,edspace)),get,region),unescape) - [json_query(%q<Json>,get,x)] - [json_query(%q<Json>,get,y)] - [json_query(%q<Json>,get,z)]))))))%q<Result>
&FN`EDSPACE`ROOM`SETUP Entity Dynamic Space=[setq(Json,json_query(extract(%0,4,1,%t),get,edspace))][null([iter(x y z region traits blocked seed,attrib_set(%1/%i0,json_query(%q<Json>,get,%i0)))][zone(%1,u(fn`edspace`get`parent))][parent(%1,Parent: [json_query(%q<Json>,extract,$.region)])])][set(%1,wizard)]%1
&GFN Entity Dynamic Space=
&GFN`EDSPACE Entity Dynamic Space=
&GFN`EDSPACE`GODYNAMIC Entity Dynamic Space=[switch(loc(%@),#-2,localize(u(fn`edspace`do`go,X,Y,Z,name(%@))),$1)]
&GFN`EDSPACE`GODYNAMIC`CC Entity Dynamic Space=r:dbref:DestinationRoomForExit
&GFN`EDSPACE`GODYNAMIC`DOC Entity Dynamic Space=If the caller, which must be an exit, calls this function, it will evaluate where to go. Either using the exit's static coordinates, or the dspace coordinates.
&INCLUDE Entity Dynamic Space=
&INCLUDE`EDSPACE Entity Dynamic Space=
&INCLUDE`EDSPACE`BLOCK Entity Dynamic Space=th setr(Exit,extract(fullname(locate(#85,%1,E)),2,1,;)); &blocked %0=[json_list(setunion(json_map(#lambda/json(%%0\,%%1),get(%0/blocked)),"%q<Exit>"))]
&INCLUDE`EDSPACE`COPY Entity Dynamic Space=@@ %0: Copy From Entity ID, %1: Copy To Entity ID; th setr(json,u(fn`get`attr,%0,edspace)); @inc %ve`attribute_set=%1,u(fn`meta`key,traits),json_query(%q<json>,get,traits);  th setr(json,u(fn`get`attr,%0,edspace)); @inc %ve`attribute_set=%1,u(fn`meta`key,blocked),json_query(%q<json>,get,blocked);
&INCLUDE`EDSPACE`CREATEROOM Entity Dynamic Space=@@ %0: X, %1: Y, %2: Z, %3: Region; @inc %ve`add=Dynamic Room,setr(Name,Room [sql(SELECT UUID\(\))]); th setr(EntityID,u(fn`get`entity,Dynamic Room,%q<Name>)); @inc %ve`attribute_set=%q<EntityID>,u(fn`meta`key,x),u(fn`meta`value,x,%0); @inc %ve`attribute_set=%q<EntityID>,u(fn`meta`key,y),u(fn`meta`value,y,%1); @inc %ve`attribute_set=%q<EntityID>,u(fn`meta`key,z),u(fn`meta`value,z,%2); @inc %ve`attribute_set=%q<EntityId>,u(fn`meta`key,region),u(fn`meta`value,region,%3);  @inc %ve`attribute_set=%q<EntityId>,u(fn`meta`key,seed),u(fn`meta`value,seed,rand(1,power(2,30)));
&INCLUDE`EDSPACE`FEATURES Entity Dynamic Space=@dol lattr(locate(%!,EDSpace Map Legend,T)/features`)=@nspemit %:=u(fn`edspace`display`featurelist,locate(%!,EDSpace Map Legend,T),%iL)
&INCLUDE`EDSPACE`MAKEROOM Entity Dynamic Space=@@ %0: X, %1: Y, %2: Z, %3: Region ; th u(fn`edspace`room,%0,%1,%2,%3)
&INCLUDE`EDSPACE`MINIMAP Entity Dynamic Space=th setr(minx,-2,maxx,2,region,v(data`edspace`dspace`defaultregion)); @dol lnum(2,-2)={th [setr(rowd,udefault(me/mapcache`%q<region>`%q<minx>_%q<maxx>`%i0,attrib_set(me/mapcache`%q<region>`%q<minx>_%q<maxx>`%i0,strfirstof(setr(row,localize(mapsql(%!/fn`edspace`display`mapline,u(fn`edspace`get`roominfo`incoordinatesline_prepare,%q<minx>,%q<maxx>,%i0,0,%q<region>),))),%b))))]; @pemit %#=firstof(%q<rowd>,%q<Row>) }
&INCLUDE`EDSPACE`PALETTE Entity Dynamic Space=@dol lattr(locate(%!,EDSpace Map Legend,T)/map`)=@nspemit %:=u(fn`edspace`display`traitlist,locate(%!,EDSpace Map Legend,T),%iL)
&INCLUDE`EDSPACE`REGION Entity Dynamic Space=
&INCLUDE`EDSPACE`REGION`ADD Entity Dynamic Space=@@ %0: Region Name; th setr(Parent,create(Parent: %0)); @tel %q<Parent>=%!; @parent %q<Parent>=u(fn`edspace`get`parent); @inc %wi`createroom=0,0,0,%0; @inc %wi`makeroom=0,0,0,%0;
&INCLUDE`EDSPACE`SAVE Entity Dynamic Space=@@ %0: Room Objid; @assert setr(EntityID,u(w`query,get`entity_id`from_objid,objid(%0),Dynamic Room)); @dol/inline blocked region seed traits=@inc %ve`attribute_set=%q<EntityID>,u(fn`meta`key,%iL),strfirstof(get(%0/%iL),null),No Output; @inc %ve`description`set=%q<EntityID>,u(%0/desc)
&INCLUDE`EDSPACE`SHOWMAP Entity Dynamic Space=@@ %0: x center, %1: y center, %2: z level, %3: Region, %4: half width, %5: half height; th setr(minx,sub(%0,%4),maxx,add(%0,%4),region,%3); @dol lnum(add(%1,%5),sub(%1,%5))={th strfirstof(setr(row,localize(mapsql(%!/fn`edspace`display`mapline,u(fn`edspace`get`roominfo`incoordinatesline_prepare,%q<minx>,%q<maxx>,%i0,%2,%q<region>),))),%b); @pemit %#=firstof(%q<rowd>,%q<Row>) }
&INCLUDE`EDSPACE`TRAIT Entity Dynamic Space=
&INCLUDE`EDSPACE`TRAIT`SET Entity Dynamic Space=@@ %0: Enactor, %1: Room Entity ID, %2: Room Objid, %3: Trait; &traits %2=\["%3"\]; @inc %wi`save=%l;
&INCLUDE`EDSPACE`UNBLOCK Entity Dynamic Space=th setr(Exit,extract(fullname(locate(#85,%1,E)),2,1,;)); &blocked %0=[json_list(setdiff(json_map(#lambda/json(%%0\,%%1),get(%0/blocked)),"%q<Exit>"))]
&SQL Entity Dynamic Space=
&SQL`GET Entity Dynamic Space=
&SQL`GET`ROOMINFO Entity Dynamic Space=
&SQL`GET`ROOMINFO`INCOORDINATESLINE Entity Dynamic Space=SELECT `ent`.`NodeId`, `ent`.`NodeName`, `ent`.`Objid`, `attr`.`Contents` FROM `inception`.`entity_attributesjson` as attr INNER JOIN `inception`.`entity_entities` as ent ON `attr`.`NodeID`=`ent`.`NodeId` AND `Type` = "Dynamic Room" WHERE (`region` = ? AND (`x` BETWEEN i? AND i? AND (`y` = i? AND `z` = i?))) ORDER BY `x` ASC
&SYSCODE Entity Dynamic Space=EDSPACE
&WI Entity Dynamic Space=me/include`edspace




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




@@ EDSpace Parent (#85)
@dig/teleport EDSpace Parent
@parent here=#31
@lock/Zone here==#85
@lset here/Zone=no_inherit
@set here = LINK_OK
@set here = WIZARD
@set here = SAFE
@set here = NO_COMMAND
@set here = FLOATING
&ALEAVE here=@break lcon(%!); @inc me/include`edspace`save=%!; @nuke %!; @nuke %!
@set here/ALEAVE=no_command prefixmatch
&CANGO here=
&CANGO`REASON here=reswitchalli(%0,Water:Deep|Water:Mid,You can't swim that,Air(:.+)?,You can't fly,Hill:*,You can't climb that)
&DESCFORMAT here=[inner([align(sub(width(%#),26) 9` 7`,switch(%0,?*,%r%0,%r[u(#38/featuresdescribe,%!)]%r),%r[align(9([scolor(primary,1)]/[scolor(secondary,3)]),u(#31/fn`edspace`display`compass))]%r%b,%r[u(#31/fn`edspace`display`minimap,%!)]%r%b)]%r%r[innersep()])]
@set here/DESCFORMAT=no_command prefixmatch
&DESCRIBE here=
@set here/DESCRIBE=no_command visual prefixmatch public nearby
&EXITFORMAT here=inner(table(linsert(u(%=`paths),-1,u(%=`exits,%0),|),div(sub(width(%#),10),2),sub(width(%#),10),|))%r[outerfooter()]
@set here/EXITFORMAT=no_command prefixmatch
&EXITFORMAT`EXITS here=iter(%0,[ansi(scolor(primary,1),name(%i0))] \[[cmdtag(go %i0,extract(fullname(%i0),2,1,;))]\],,|)
&EXITFORMAT`PATHS here=iter(setdiff(N E W S D U NW NE SE SW,json_map(#lambda/%%1,v(blocked))),first(get(#31/[grep(#31,data`edspace`*`fullname,;%i0;)]),;) \[[cmdtag(go %i0,%i0)]\],,|)
&EXITFORMAT`PATHS`LOCKCHECK here=elock(locate(me,%0,E)/basic,%#)
&NAMEFORMAT here=[endtag(a)][header(if(hasflag(%0,SAFE),%1 \[[v(x)]\,[v(y)]\,[v(z)]\],json_query(v(Region),unescape) \[[v(x)]\,[v(y)]\,[v(z)]\] ))]
@set here/NAMEFORMAT=no_command prefixmatch




@@ Up (#96), in EDSpace Parent (#85)
@open Up
@link Up = VARIABLE
@lock/Basic Up=CANGO/1
@lset Up/Basic=visual no_inherit
@set Up = WIZARD
&ALIAS Up=U
@set Up/ALIAS=no_command visual prefixmatch
&CANGO Up=cor(hasflag(%#,Transparent),not(cor(u(cango`blocked),u(cango`reason))))
&CANGO`BLOCKED Up=match(u(#31/fn`edspace`get`blocked,json_map(#lambda/%%1,get(%l/blocked))),extract(fullname(%!),2,1,;))
&CANGO`REASON Up=u(%l/cango`reason,json_map(#lambda/%%1,json_query(setr(Entity,extract(u(destination`entity),4,1,%t)),extract,$.[u(#31/fn`meta`key,traits)])),json_map(#lambda/%%1,json_query(%q<Entity>,extract,$.[u(#31/fn`meta`key,blocked)])))
&DESTINATION Up=[u(#31/fn`edspace`room,add(get(%l/x),v(mod`x)),add(get(%l/y),v(mod`y)),add(get(%l/z),v(mod`z)),json_query(get(%l/region),unescape))]
@set Up/DESTINATION=no_command
&DESTINATION`ENTITY Up=u(#31/fn`edspace`get`roominfo`atcoordinates,add(get(%l/x),v(mod`x)),add(get(%l/y),v(mod`y)),add(get(%l/z),v(mod`z)),json_query(get(%l/region),unescape))
&FAILURE Up=strfirstof(u(cango`reason),You can't go that way)
@set Up/FAILURE=no_command prefixmatch
&MOD Up=
&MOD`X Up=0
&MOD`Y Up=0
&MOD`Z Up=1
@@ Down (#95), in EDSpace Parent (#85)
@open Down
@link Down = VARIABLE
@lock/Basic Down=CANGO/1
@lset Down/Basic=visual no_inherit
@set Down = WIZARD
&ALIAS Down=D;dow;do
@set Down/ALIAS=no_command visual prefixmatch
&CANGO Down=cor(hasflag(%#,Transparent),not(cor(u(cango`blocked),u(cango`reason))))
&CANGO`BLOCKED Down=match(u(#31/fn`edspace`get`blocked,json_map(#lambda/%%1,get(%l/blocked))),extract(fullname(%!),2,1,;))
&CANGO`REASON Down=u(%l/cango`reason,json_map(#lambda/%%1,json_query(setr(Entity,extract(u(destination`entity),4,1,%t)),extract,$.[u(#31/fn`meta`key,traits)])),json_map(#lambda/%%1,json_query(%q<Entity>,extract,$.[u(#31/fn`meta`key,blocked)])))
&DESTINATION Down=u(#31/fn`edspace`room,add(get(%l/x),v(mod`x)),add(get(%l/y),v(mod`y)),add(get(%l/z),v(mod`z)),json_query(get(%l/region),unescape))
@set Down/DESTINATION=no_command
&DESTINATION`ENTITY Down=u(#31/fn`edspace`get`roominfo`atcoordinates,add(get(%l/x),v(mod`x)),add(get(%l/y),v(mod`y)),add(get(%l/z),v(mod`z)),json_query(get(%l/region),unescape))
&FAILURE Down=strfirstof(u(cango`reason),You can't go that way)
@set Down/FAILURE=no_command prefixmatch
&MOD Down=
&MOD`X Down=0
&MOD`Y Down=0
&MOD`Z Down=-1
@@ Southwest (#94), in EDSpace Parent (#85)
@open Southwest
@link Southwest = VARIABLE
@lock/Basic Southwest=CANGO/1
@lset Southwest/Basic=visual no_inherit
@set Southwest = WIZARD
&ALIAS Southwest=SW;Southwes;Southwe;Southw
@set Southwest/ALIAS=no_command visual prefixmatch
&CANGO Southwest=cor(hasflag(%#,Transparent),not(cor(u(cango`blocked),u(cango`reason))))
&CANGO`BLOCKED Southwest=match(u(#31/fn`edspace`get`blocked,json_map(#lambda/%%1,get(%l/blocked))),extract(fullname(%!),2,1,;))
&CANGO`REASON Southwest=u(%l/cango`reason,json_map(#lambda/%%1,json_query(setr(Entity,extract(u(destination`entity),4,1,%t)),extract,$.[u(#31/fn`meta`key,traits)])),json_map(#lambda/%%1,json_query(%q<Entity>,extract,$.[u(#31/fn`meta`key,blocked)])))
&DESTINATION Southwest=u(#31/fn`edspace`room,add(get(%l/x),v(mod`x)),add(get(%l/y),v(mod`y)),add(get(%l/z),v(mod`z)),json_query(get(%l/region),unescape))
@set Southwest/DESTINATION=no_command
&DESTINATION`ENTITY Southwest=u(#31/fn`edspace`get`roominfo`atcoordinates,add(get(%l/x),v(mod`x)),add(get(%l/y),v(mod`y)),add(get(%l/z),v(mod`z)),json_query(get(%l/region),unescape))
&FAILURE Southwest=strfirstof(u(cango`reason),You can't go that way)
@set Southwest/FAILURE=no_command prefixmatch
&MOD Southwest=
&MOD`X Southwest=-1
&MOD`Y Southwest=-1
&MOD`Z Southwest=0
@@ Southeast (#93), in EDSpace Parent (#85)
@open Southeast
@link Southeast = VARIABLE
@lock/Basic Southeast=CANGO/1
@lset Southeast/Basic=visual no_inherit
@set Southeast = WIZARD
&ALIAS Southeast=SE;Southeas;southeas;southea;southe
@set Southeast/ALIAS=no_command visual prefixmatch
&CANGO Southeast=cor(hasflag(%#,Transparent),not(cor(u(cango`blocked),u(cango`reason))))
&CANGO`BLOCKED Southeast=match(u(#31/fn`edspace`get`blocked,json_map(#lambda/%%1,get(%l/blocked))),extract(fullname(%!),2,1,;))
&CANGO`REASON Southeast=u(%l/cango`reason,json_map(#lambda/%%1,json_query(setr(Entity,extract(u(destination`entity),4,1,%t)),extract,$.[u(#31/fn`meta`key,traits)])),json_map(#lambda/%%1,json_query(%q<Entity>,extract,$.[u(#31/fn`meta`key,blocked)])))
&DESTINATION Southeast=u(#31/fn`edspace`room,add(get(%l/x),v(mod`x)),add(get(%l/y),v(mod`y)),add(get(%l/z),v(mod`z)),json_query(get(%l/region),unescape))
@set Southeast/DESTINATION=no_command
&DESTINATION`ENTITY Southeast=u(#31/fn`edspace`get`roominfo`atcoordinates,add(get(%l/x),v(mod`x)),add(get(%l/y),v(mod`y)),add(get(%l/z),v(mod`z)),json_query(get(%l/region),unescape))
&FAILURE Southeast=strfirstof(u(cango`reason),You can't go that way)
@set Southeast/FAILURE=no_command prefixmatch
&MOD Southeast=
&MOD`X Southeast=1
&MOD`Y Southeast=-1
&MOD`Z Southeast=0
@@ Northwest (#92), in EDSpace Parent (#85)
@open Northwest
@link Northwest = VARIABLE
@lock/Basic Northwest=CANGO/1
@lset Northwest/Basic=visual no_inherit
@set Northwest = WIZARD
&ALIAS Northwest=NW;Northwes;northwe;northw
@set Northwest/ALIAS=no_command visual prefixmatch
&CANGO Northwest=cor(hasflag(%#,Transparent),not(cor(u(cango`blocked),u(cango`reason))))
&CANGO`BLOCKED Northwest=match(u(#31/fn`edspace`get`blocked,json_map(#lambda/%%1,get(%l/blocked))),extract(fullname(%!),2,1,;))
&CANGO`REASON Northwest=u(%l/cango`reason,json_map(#lambda/%%1,json_query(setr(Entity,extract(u(destination`entity),4,1,%t)),extract,$.[u(#31/fn`meta`key,traits)])),json_map(#lambda/%%1,json_query(%q<Entity>,extract,$.[u(#31/fn`meta`key,blocked)])))
&DESTINATION Northwest=u(#31/fn`edspace`room,add(get(%l/x),v(mod`x)),add(get(%l/y),v(mod`y)),add(get(%l/z),v(mod`z)),json_query(get(%l/region),unescape))
@set Northwest/DESTINATION=no_command
&DESTINATION`ENTITY Northwest=u(#31/fn`edspace`get`roominfo`atcoordinates,add(get(%l/x),v(mod`x)),add(get(%l/y),v(mod`y)),add(get(%l/z),v(mod`z)),json_query(get(%l/region),unescape))
&FAILURE Northwest=strfirstof(u(cango`reason),You can't go that way)
@set Northwest/FAILURE=no_command prefixmatch
&MOD Northwest=
&MOD`X Northwest=-1
&MOD`Y Northwest=1
&MOD`Z Northwest=0
@@ Northeast (#91), in EDSpace Parent (#85)
@open Northeast
@link Northeast = VARIABLE
@lock/Basic Northeast=CANGO/1
@lset Northeast/Basic=visual no_inherit
@set Northeast = WIZARD
&ALIAS Northeast=NE;Northeas;northeas;northea;northe
@set Northeast/ALIAS=no_command visual prefixmatch
&CANGO Northeast=cor(hasflag(%#,Transparent),not(cor(u(cango`blocked),u(cango`reason))))
&CANGO`BLOCKED Northeast=match(u(#31/fn`edspace`get`blocked,json_map(#lambda/%%1,get(%l/blocked))),extract(fullname(%!),2,1,;))
&CANGO`REASON Northeast=u(%l/cango`reason,json_map(#lambda/%%1,json_query(setr(Entity,extract(u(destination`entity),4,1,%t)),extract,$.[u(#31/fn`meta`key,traits)])),json_map(#lambda/%%1,json_query(%q<Entity>,extract,$.[u(#31/fn`meta`key,blocked)])))
&DESTINATION Northeast=u(#31/fn`edspace`room,add(get(%l/x),v(mod`x)),add(get(%l/y),v(mod`y)),add(get(%l/z),v(mod`z)),json_query(get(%l/region),unescape))
@set Northeast/DESTINATION=no_command
&DESTINATION`ENTITY Northeast=u(#31/fn`edspace`get`roominfo`atcoordinates,add(get(%l/x),v(mod`x)),add(get(%l/y),v(mod`y)),add(get(%l/z),v(mod`z)),json_query(get(%l/region),unescape))
&FAILURE Northeast=strfirstof(u(cango`reason),You can't go that way)
@set Northeast/FAILURE=no_command prefixmatch
&MOD Northeast=
&MOD`X Northeast=1
&MOD`Y Northeast=1
&MOD`Z Northeast=0
@@ South (#90), in EDSpace Parent (#85)
@open South
@link South = VARIABLE
@lock/Basic South=CANGO/1
@lset South/Basic=visual no_inherit
@set South = WIZARD
&ALIAS South=S;sout;sou;so
@set South/ALIAS=no_command visual prefixmatch
&CANGO South=cor(hasflag(%#,Transparent),not(cor(u(cango`blocked),u(cango`reason))))
&CANGO`BLOCKED South=match(u(#31/fn`edspace`get`blocked,json_map(#lambda/%%1,get(%l/blocked))),extract(fullname(%!),2,1,;))
&CANGO`REASON South=u(%l/cango`reason,json_map(#lambda/%%1,json_query(setr(Entity,extract(u(destination`entity),4,1,%t)),extract,$.[u(#31/fn`meta`key,traits)])),json_map(#lambda/%%1,json_query(%q<Entity>,extract,$.[u(#31/fn`meta`key,blocked)])))
&DESTINATION South=u(#31/fn`edspace`room,add(get(%l/x),v(mod`x)),add(get(%l/y),v(mod`y)),add(get(%l/z),v(mod`z)),json_query(get(%l/region),unescape))
@set South/DESTINATION=no_command
&DESTINATION`ENTITY South=u(#31/fn`edspace`get`roominfo`atcoordinates,add(get(%l/x),v(mod`x)),add(get(%l/y),v(mod`y)),add(get(%l/z),v(mod`z)),json_query(get(%l/region),unescape))
&FAILURE South=strfirstof(u(cango`reason),You can't go that way)
@set South/FAILURE=no_command prefixmatch
&MOD South=
&MOD`X South=0
&MOD`Y South=-1
&MOD`Z South=0
@@ North (#89), in EDSpace Parent (#85)
@open North
@link North = VARIABLE
@lock/Basic North=CANGO/1
@lset North/Basic=visual no_inherit
@set North = WIZARD
&ALIAS North=N;nort;nor;no
@set North/ALIAS=no_command visual prefixmatch
&CANGO North=cor(hasflag(%#,Transparent),not(cor(u(cango`blocked),u(cango`reason))))
&CANGO`BLOCKED North=match(u(#31/fn`edspace`get`blocked,json_map(#lambda/%%1,get(%l/blocked))),extract(fullname(%!),2,1,;))
&CANGO`REASON North=u(%l/cango`reason,json_map(#lambda/%%1,json_query(setr(Entity,extract(u(destination`entity),4,1,%t)),extract,$.[u(#31/fn`meta`key,traits)])),json_map(#lambda/%%1,json_query(%q<Entity>,extract,$.[u(#31/fn`meta`key,blocked)])))
&DESTINATION North=u(#31/fn`edspace`room,add(get(%l/x),v(mod`x)),add(get(%l/y),v(mod`y)),add(get(%l/z),v(mod`z)),json_query(get(%l/region),unescape))
@set North/DESTINATION=no_command
&DESTINATION`ENTITY North=u(#31/fn`edspace`get`roominfo`atcoordinates,add(get(%l/x),v(mod`x)),add(get(%l/y),v(mod`y)),add(get(%l/z),v(mod`z)),json_query(get(%l/region),unescape))
&FAILURE North=strfirstof(u(cango`reason),You can't go that way)
@set North/FAILURE=no_command prefixmatch
&MOD North=
&MOD`X North=0
&MOD`Y North=1
&MOD`Z North=0
@@ West (#88), in EDSpace Parent (#85)
@open West
@link West = VARIABLE
@lock/Basic West=CANGO/1
@lset West/Basic=visual no_inherit
@set West = WIZARD
&ALIAS West=W;wes;we
@set West/ALIAS=no_command visual prefixmatch
&CANGO West=cor(hasflag(%#,Transparent),not(cor(u(cango`blocked),u(cango`reason))))
&CANGO`BLOCKED West=match(u(#31/fn`edspace`get`blocked,json_map(#lambda/%%1,get(%l/blocked))),extract(fullname(%!),2,1,;))
&CANGO`REASON West=u(%l/cango`reason,json_map(#lambda/%%1,json_query(setr(Entity,extract(u(destination`entity),4,1,%t)),extract,$.[u(#31/fn`meta`key,traits)])),json_map(#lambda/%%1,json_query(%q<Entity>,extract,$.[u(#31/fn`meta`key,blocked)])))
&DESTINATION West=u(#31/fn`edspace`room,add(get(%l/x),v(mod`x)),add(get(%l/y),v(mod`y)),add(get(%l/z),v(mod`z)),json_query(get(%l/region),unescape))
@set West/DESTINATION=no_command
&DESTINATION`ENTITY West=u(#31/fn`edspace`get`roominfo`atcoordinates,add(get(%l/x),v(mod`x)),add(get(%l/y),v(mod`y)),add(get(%l/z),v(mod`z)),json_query(get(%l/region),unescape))
&FAILURE West=strfirstof(u(cango`reason),You can't go that way)
@set West/FAILURE=no_command prefixmatch
&MOD West=
&MOD`X West=-1
&MOD`Y West=0
&MOD`Z West=0
@@ East (#87), in EDSpace Parent (#85)
@open East
@link East = VARIABLE
@lock/Basic East=CANGO/1
@lset East/Basic=visual no_inherit
@set East = WIZARD
&ALIAS East=E;eas;ea
@set East/ALIAS=no_command visual prefixmatch
&CANGO East=cor(hasflag(%#,Transparent),not(cor(u(cango`blocked),u(cango`reason))))
&CANGO`BLOCKED East=match(u(#31/fn`edspace`get`blocked,json_map(#lambda/%%1,get(%l/blocked))),extract(fullname(%!),2,1,;))
&CANGO`REASON East=u(%l/cango`reason,json_map(#lambda/%%1,json_query(setr(Entity,extract(u(destination`entity),4,1,%t)),extract,$.[u(#31/fn`meta`key,traits)])),json_map(#lambda/%%1,json_query(%q<Entity>,extract,$.[u(#31/fn`meta`key,blocked)])))
&DESTINATION East=u(#31/fn`edspace`room,add(get(%l/x),v(mod`x)),add(get(%l/y),v(mod`y)),add(get(%l/z),v(mod`z)),json_query(get(%l/region),unescape))
@set East/DESTINATION=no_command
&DESTINATION`ENTITY East=u(#31/fn`edspace`get`roominfo`atcoordinates,add(get(%l/x),v(mod`x)),add(get(%l/y),v(mod`y)),add(get(%l/z),v(mod`z)),json_query(get(%l/region),unescape))
&FAILURE East=strfirstof(u(cango`reason),You can't go that way)
@set East/FAILURE=no_command prefixmatch
&MOD East=
&MOD`X East=1
&MOD`Y East=0
&MOD`Z East=0
