#using script_5bc60484d17fa95c;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_twotwo_gulag;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\perk;

#namespace namespace_5224c1e851beffac;

// Namespace namespace_5224c1e851beffac / namespace_21b1a5889fd8d167
// Params 0
// Checksum 0x0, Offset: 0x294
// Size: 0xde
function function_1125faa6bc85e080()
{
    if ( getdvarint( @"hash_77e2efb75e6cc8ca", 0 ) )
    {
        return;
    }
    
    level.gulag.var_5294cceb5b0fa1fb = getdvarint( @"scr_br_fc_overtime_ascender", 1 );
    scripts\mp\gametypes\br::function_6315a065e5b1efa2( &function_ddc0c02aa77e9268 );
    scripts\mp\gametypes\br::function_80fc169a9ec33825( &function_71582b761a9132e7 );
    scripts\mp\gametypes\br_gulag::function_ed608478232fdeb2( "setupArena", &function_701bb5116db0b366 );
    
    if ( level.gulag.var_5294cceb5b0fa1fb )
    {
        scripts\mp\gametypes\br_gulag::function_ed608478232fdeb2( "beginNewFight", &function_6d7f8ac81d81ee2d );
        scripts\mp\gametypes\br_gulag::function_ed608478232fdeb2( "handleEndArena", &function_630d643e20b202a2 );
        scripts\mp\gametypes\br_gulag::function_ed608478232fdeb2( "respawnCleanup", &function_8ae33204ae68c976 );
        scripts\mp\gametypes\br_gulag::function_ed608478232fdeb2( "gulagWaittillOvertime", &function_57d827764e049f21 );
        scripts\mp\gametypes\br_gulag::function_c797c1f0977d41d1( "overtimeStart", &function_3fd1a99e2ac61cd1 );
        scripts\mp\gametypes\br_gulag::function_c797c1f0977d41d1( "overtimeWait", &function_f47d8fbd1e16f89a );
    }
}

// Namespace namespace_5224c1e851beffac / namespace_21b1a5889fd8d167
// Params 1
// Checksum 0x0, Offset: 0x37a
// Size: 0x27, Type: bool
function function_bbc309466ce88c71( arena )
{
    return isdefined( arena.ascenders ) && arena.ascenders.size;
}

// Namespace namespace_5224c1e851beffac / namespace_21b1a5889fd8d167
// Params 1
// Checksum 0x0, Offset: 0x3aa
// Size: 0xdb
function function_701bb5116db0b366( arena )
{
    arena.ascenders = [];
    var_46178736de007ecb = getentitylessscriptablearray( arena.target, "targetname" );
    
    foreach ( var_b42fd3a9b400e97a in var_46178736de007ecb )
    {
        switch ( var_b42fd3a9b400e97a.script_noteworthy )
        {
            case #"hash_32d233f7333dcec":
                var_b42fd3a9b400e97a.arena = arena;
                arena.ascenders[ arena.ascenders.size ] = var_b42fd3a9b400e97a;
                function_37302e9085f4d57f( var_b42fd3a9b400e97a );
                break;
            default:
                break;
        }
    }
}

// Namespace namespace_5224c1e851beffac / namespace_21b1a5889fd8d167
// Params 1
// Checksum 0x0, Offset: 0x48d
// Size: 0x119
function function_37302e9085f4d57f( instance )
{
    instance.var_ea780f20ab06e68a = 1;
    targets = getentarray( instance.target, "targetname" );
    
    foreach ( target in targets )
    {
        switch ( target.script_noteworthy )
        {
            case #"hash_4d993e901822ff8d":
                assert( !isdefined( instance.rope ) );
                rope = spawnscriptable( "jup_overtime_rope", target.origin );
                target hide();
                instance.rope = rope;
                function_64ec5377628be7e4( target, rope );
                break;
            default:
                break;
        }
    }
    
    instance.gulagstate = "down";
    thread function_2d90839b9225f69e( instance );
}

// Namespace namespace_5224c1e851beffac / namespace_21b1a5889fd8d167
// Params 2
// Checksum 0x0, Offset: 0x5ae
// Size: 0x148
function function_64ec5377628be7e4( staticrope, rope )
{
    rope.down_origin = rope.origin;
    targets = staticrope getstructarray( staticrope.target, "targetname" );
    
    foreach ( target in targets )
    {
        switch ( target.script_noteworthy )
        {
            case #"hash_f0c78255b6b37d51":
                rope.up_origin = target.origin;
                break;
            default:
                break;
        }
    }
    
    upvec = ( 0, 0, rope.up_origin[ 2 ] - rope.down_origin[ 2 ] );
    rope.origin += upvec;
    rope.angles = vectortoangles( upvec ) + ( 0, 0, 90 );
    rope.upvec = upvec;
}

// Namespace namespace_5224c1e851beffac / namespace_21b1a5889fd8d167
// Params 1
// Checksum 0x0, Offset: 0x6fe
// Size: 0x7a
function function_2d90839b9225f69e( instance )
{
    if ( instance.gulagstate == "up" || instance.gulagstate == "raising" )
    {
        return;
    }
    
    function_5d0f8563db57a967( instance );
    instance.gulagstate = "raising";
    instance.rope setscriptablepartstate( "rope", "up" );
    instance.gulagstate = "up";
}

// Namespace namespace_5224c1e851beffac / namespace_21b1a5889fd8d167
// Params 2
// Checksum 0x0, Offset: 0x780
// Size: 0x8f
function function_b21d67600134d787( arena, instance )
{
    arena endon( "matchEnded" );
    
    if ( instance.gulagstate == "down" || instance.gulagstate == "lowering" )
    {
        return;
    }
    
    instance.gulagstate = "lowering";
    instance.rope setscriptablepartstate( "rope", "down" );
    wait 1;
    function_5f46e3ff37d51924( instance );
    instance.gulagstate = "down";
}

// Namespace namespace_5224c1e851beffac / namespace_21b1a5889fd8d167
// Params 1
// Checksum 0x0, Offset: 0x817
// Size: 0x121
function function_5f46e3ff37d51924( instance )
{
    instance.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid();
    
    if ( instance.objidnum == -1 )
    {
        return;
    }
    
    scripts\mp\objidpoolmanager::objective_add_objective( instance.objidnum, "current", instance.rope.origin, "ui_map_icon_obj_ascender_rope" );
    scripts\mp\objidpoolmanager::update_objective_setbackground( instance.objidnum, 1 );
    scripts\mp\objidpoolmanager::update_objective_setzoffset( instance.objidnum, instance.rope.upvec[ 2 ] * -1 + 100 );
    scripts\mp\objidpoolmanager::function_9cad42ac02eff950( instance.objidnum );
    
    foreach ( player in instance.arena.arenaplayers )
    {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( instance.objidnum, player );
    }
}

// Namespace namespace_5224c1e851beffac / namespace_21b1a5889fd8d167
// Params 1
// Checksum 0x0, Offset: 0x940
// Size: 0x2b
function function_5d0f8563db57a967( instance )
{
    scripts\mp\objidpoolmanager::returnobjectiveid( instance.objidnum );
    instance.objidnum = -1;
}

// Namespace namespace_5224c1e851beffac / namespace_21b1a5889fd8d167
// Params 6
// Checksum 0x0, Offset: 0x973
// Size: 0x8d
function function_ddc0c02aa77e9268( instance, player, edgeindex, isvertical, isinverted, isgoingup )
{
    if ( istrue( instance.var_ea780f20ab06e68a ) && instance.gulagstate != "down" )
    {
        s = spawnstruct();
        s.type = "HINT_NOBUTTON";
        s.string = &"";
        return s;
    }
    
    return undefined;
}

// Namespace namespace_5224c1e851beffac / namespace_21b1a5889fd8d167
// Params 4
// Checksum 0x0, Offset: 0xa09
// Size: 0x4a
function function_71582b761a9132e7( instance, player, edgeindex, isinverted )
{
    if ( istrue( instance.var_ea780f20ab06e68a ) && instance.gulagstate != "down" )
    {
        return 0;
    }
    
    return undefined;
}

// Namespace namespace_5224c1e851beffac / namespace_21b1a5889fd8d167
// Params 1
// Checksum 0x0, Offset: 0xa5c
// Size: 0x74
function function_6d7f8ac81d81ee2d( arena )
{
    foreach ( ascender in arena.ascenders )
    {
        level thread function_2d90839b9225f69e( ascender );
        ascender setscriptablepartstate( "top", "use" );
    }
}

// Namespace namespace_5224c1e851beffac / namespace_21b1a5889fd8d167
// Params 1
// Checksum 0x0, Offset: 0xad8
// Size: 0x111
function function_630d643e20b202a2( arena )
{
    foreach ( ascender in arena.ascenders )
    {
        ascender setscriptablepartstate( "top", "off" );
        
        if ( ascender.gulagstate != "up" )
        {
            ascender.rope setscriptablepartstate( "rope", "end" );
        }
        
        function_5d0f8563db57a967( ascender );
    }
    
    foreach ( player in arena.arenaplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player scripts\mp\utility\perk::_hasperk( "specialty_ascender_scale" ) )
        {
            player scripts\mp\utility\perk::removeperk( "specialty_ascender_scale" );
        }
    }
}

// Namespace namespace_5224c1e851beffac / namespace_21b1a5889fd8d167
// Params 1
// Checksum 0x0, Offset: 0xbf1
// Size: 0x27
function function_8ae33204ae68c976( player )
{
    if ( player scripts\mp\utility\perk::_hasperk( "specialty_ascender_scale" ) )
    {
        player scripts\mp\utility\perk::removeperk( "specialty_ascender_scale" );
    }
}

// Namespace namespace_5224c1e851beffac / namespace_21b1a5889fd8d167
// Params 2
// Checksum 0x0, Offset: 0xc20
// Size: 0xa6
function function_57d827764e049f21( arena, overtimelength )
{
    if ( arena.var_9bceb84d333290f0 )
    {
        return;
    }
    
    foreach ( ascender in arena.ascenders )
    {
        if ( ascender.gulagstate == "up" && arena.time <= overtimelength + 1 )
        {
            level thread function_b21d67600134d787( arena, ascender );
        }
    }
}

// Namespace namespace_5224c1e851beffac / namespace_21b1a5889fd8d167
// Params 1
// Checksum 0x0, Offset: 0xcce
// Size: 0x97, Type: bool
function function_3fd1a99e2ac61cd1( arena )
{
    if ( !function_bbc309466ce88c71( arena ) || arena.var_9bceb84d333290f0 )
    {
        return false;
    }
    
    foreach ( player in arena.arenaplayers )
    {
        player scripts\mp\utility\perk::giveperk( "specialty_ascender_scale" );
        thread function_8e5385ed332adbd5( arena, player );
    }
    
    thread function_7ad3c045be29a1a2( arena );
    return true;
}

// Namespace namespace_5224c1e851beffac / namespace_21b1a5889fd8d167
// Params 1
// Checksum 0x0, Offset: 0xd6e
// Size: 0x91
function function_7ad3c045be29a1a2( arena )
{
    arena endon( "matchEnded" );
    
    while ( true )
    {
        if ( function_d58fea226bf50a8d( arena ) )
        {
            break;
        }
        
        waitframe();
    }
    
    foreach ( ascender in arena.ascenders )
    {
        ascender.rope setscriptablepartstate( "rope", "idle" );
    }
}

// Namespace namespace_5224c1e851beffac / namespace_21b1a5889fd8d167
// Params 1
// Checksum 0x0, Offset: 0xe07
// Size: 0x55, Type: bool
function function_f47d8fbd1e16f89a( arena )
{
    if ( !function_bbc309466ce88c71( arena ) || arena.var_9bceb84d333290f0 )
    {
        return false;
    }
    
    while ( true )
    {
        if ( function_d58fea226bf50a8d( arena ) )
        {
            waitframe();
            continue;
        }
        
        if ( istrue( arena.fightover ) )
        {
            waitframe();
            continue;
        }
        
        break;
    }
    
    return true;
}

// Namespace namespace_5224c1e851beffac / namespace_21b1a5889fd8d167
// Params 1
// Checksum 0x0, Offset: 0xe65
// Size: 0x66, Type: bool
function function_d58fea226bf50a8d( arena )
{
    foreach ( player in arena.arenaplayers )
    {
        if ( player isonascender() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_5224c1e851beffac / namespace_21b1a5889fd8d167
// Params 2
// Checksum 0x0, Offset: 0xed4
// Size: 0x48
function function_8e5385ed332adbd5( arena, player )
{
    arena endon( "matchEnded" );
    
    while ( true )
    {
        player waittill( "ascender_detached", jumpdetach );
        
        if ( !istrue( jumpdetach ) )
        {
            break;
        }
    }
    
    thread function_cb1b43cc32251f6f( arena, player );
}

// Namespace namespace_5224c1e851beffac / namespace_21b1a5889fd8d167
// Params 2
// Checksum 0x0, Offset: 0xf24
// Size: 0x12c
function function_cb1b43cc32251f6f( arena, winner )
{
    foreach ( player in arena.arenaplayers )
    {
        if ( isalive( player ) && player != winner )
        {
            if ( namespace_eb17b46cdcb98eea::function_1980065ce4dc067b() )
            {
                player thread scripts\mp\gametypes\br_gulag::gulagplayerlost( arena, "br_twotwo_gulag_lost_flag", 1 );
                continue;
            }
            
            player thread scripts\mp\gametypes\br_gulag::gulagplayerlost( arena );
        }
    }
    
    foreach ( ascender in arena.ascenders )
    {
        ascender setscriptablepartstate( "top", "off" );
    }
    
    arena notify( "matchEnded" );
    
    if ( namespace_eb17b46cdcb98eea::function_1980065ce4dc067b() )
    {
        winner scripts\mp\gametypes\br_twotwo_gulag::function_dc0a56e258889cb( arena, "br_twotwo_gulag_win_flag" );
    }
    
    scripts\mp\gametypes\br_gulag::handleendarena( arena );
    arena notify( "fight_over_early" );
}

