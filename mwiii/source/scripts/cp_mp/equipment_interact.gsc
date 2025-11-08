#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;

#namespace equipment_interact;

// Namespace equipment_interact / scripts\cp_mp\equipment_interact
// Params 0
// Checksum 0x0, Offset: 0x3de
// Size: 0x47
function equipmentinteract_init()
{
    level.useobjs = [];
    flag_init( "equipment_interact" );
    scripts\engine\utility::registersharedfunc( "equipment", "deployHackTablet", &deployhacktablet );
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "hack_usable", &equipmentscriptableused );
    thread _updateuseobjs();
}

// Namespace equipment_interact / scripts\cp_mp\equipment_interact
// Params 6
// Checksum 0x0, Offset: 0x42d
// Size: 0x56
function equipmentscriptableused( instance, part, state, player, bautouse, usestring )
{
    assert( part == "<dev string:x1c>" );
    equipmentuse( instance.entity, player );
}

// Namespace equipment_interact / scripts\cp_mp\equipment_interact
// Params 2
// Checksum 0x0, Offset: 0x48b
// Size: 0xaf
function equipmentuse( instance, player )
{
    equipment = instance;
    
    if ( iscp() && istrue( equipment.isbeingused ) )
    {
        return;
    }
    
    equipment.isbeingused = 1;
    
    if ( isdefined( player ) )
    {
        if ( iscp() )
        {
            equipment disablescriptableplayeruse( player );
        }
        
        player.iscapturingcrate = 0;
        player.ishacking = 1;
        streakinfo = player scripts\cp_mp\utility\killstreak_utility::createstreakinfo( "", player );
        streakinfo.interactstate = 0;
        player thread deployhacktablet( function_be0c3a067da1e72d( equipment ), equipment, streakinfo );
    }
}

// Namespace equipment_interact / scripts\cp_mp\equipment_interact
// Params 0
// Checksum 0x0, Offset: 0x542
// Size: 0x15b
function _updateuseobjs()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        wait 0.2;
        
        foreach ( useobj in level.useobjs )
        {
            if ( !isdefined( useobj ) )
            {
                continue;
            }
            
            nearplayers = utility::playersnear( useobj.origin, 300 );
            
            foreach ( player in nearplayers )
            {
                if ( !istrue( scripts\cp_mp\utility\player_utility::playersareenemies( player, useobj.owner ) ) || istrue( useobj.isbeingused ) || issharedfuncdefined( "perk", "hasPerk" ) && !player [[ getsharedfunc( "perk", "hasPerk" ) ]]( "specialty_hack" ) || player scripts\cp_mp\emp_debuff::is_empd() || player namespace_53fc9ddbb516e6e1::isjuggernautsharedfunc() || level.gameended )
                {
                    useobj disablescriptableplayeruse( player );
                    continue;
                }
                
                useobj enablescriptableplayeruse( player );
            }
        }
    }
}

// Namespace equipment_interact / scripts\cp_mp\equipment_interact
// Params 3
// Checksum 0x0, Offset: 0x6a5
// Size: 0x2e
function remoteinteractsetup( var_3012ab4936b3fdec, allowdefuse, allowhack )
{
    if ( isdefined( allowhack ) || allowhack )
    {
        thread _hacksetup( var_3012ab4936b3fdec );
    }
}

// Namespace equipment_interact / scripts\cp_mp\equipment_interact
// Params 1
// Checksum 0x0, Offset: 0x6db
// Size: 0x82
function _hacksetup( remotedefusecallback )
{
    level.useobjs[ self getentitynumber() ] = self;
    self setscriptablepartstate( "hack_usable", "on" );
    
    foreach ( player in level.players )
    {
        self disablescriptableplayeruse( player );
    }
}

// Namespace equipment_interact / scripts\cp_mp\equipment_interact
// Params 1
// Checksum 0x0, Offset: 0x765
// Size: 0x13b, Type: bool
function _processusethink( equipment )
{
    level endon( "game_ended" );
    
    if ( isdefined( equipment ) )
    {
        equipment endon( "death" );
        equipment endon( "mine_triggered" );
    }
    
    self endon( "death_or_disconnect" );
    self endon( "emp_started" );
    var_25979fcd6ca24291 = getdvarfloat( @"hash_b22bb1a48299003b", 3 );
    
    if ( isdefined( equipment.var_c9f381a81d2b42ed ) )
    {
        var_25979fcd6ca24291 = equipment.var_c9f381a81d2b42ed;
    }
    
    if ( isdefined( equipment.var_bf11ca1f75257311 ) )
    {
        var_25979fcd6ca24291 = equipment.var_bf11ca1f75257311;
    }
    
    var_6daefc1a691b701d = getdvarfloat( @"hash_f1b36a05bc8c07af", 0.5 );
    
    if ( isdefined( equipment.var_58dec9951efefbed ) )
    {
        var_6daefc1a691b701d = equipment.var_58dec9951efefbed;
    }
    
    if ( isdefined( equipment.var_f980def4500c0769 ) )
    {
        var_6daefc1a691b701d = equipment.var_f980def4500c0769;
    }
    
    interactduration = ( var_25979fcd6ca24291 - var_6daefc1a691b701d ) * 1000;
    var_b8cf204dd62d457f = gettime() + interactduration;
    
    if ( isdefined( equipment.var_2c080d51c26d0785 ) )
    {
        self thread [[ equipment.var_2c080d51c26d0785 ]]();
    }
    
    while ( var_b8cf204dd62d457f > gettime() )
    {
        if ( !self usebuttonpressed() )
        {
            return false;
        }
        
        waitframe();
    }
    
    return true;
}

// Namespace equipment_interact / scripts\cp_mp\equipment_interact
// Params 2
// Checksum 0x0, Offset: 0x8a9
// Size: 0x136
function _startusethink( equipment, streakinfo )
{
    if ( isdefined( equipment ) )
    {
        equipment.isbeingused = 1;
    }
    
    self.iscapturingcrate = 1;
    self.ishacking = 1;
    streakinfo.interactstate = 0;
    self notify( "interact_started" );
    result = istrue( _processusethink( equipment ) );
    
    if ( result )
    {
        streakinfo.interactstate = 2;
    }
    else
    {
        self notify( "interact_cancelled" );
        flag_clear( "equipment_interact" );
    }
    
    if ( isdefined( equipment.var_3b863b2cb4c0df2e ) )
    {
        self thread [[ equipment.var_3b863b2cb4c0df2e ]]();
    }
    
    self notify( "interact_finished" );
    flag_clear( "equipment_interact" );
    
    if ( isdefined( equipment ) )
    {
        equipment.isbeingused = 0;
    }
    
    if ( isdefined( self ) )
    {
        self.iscapturingcrate = 0;
        self.ishacking = undefined;
        
        if ( !istrue( result ) )
        {
            if ( iscp() && isdefined( equipment ) )
            {
                equipment enablescriptableplayeruse( self );
            }
            
            return;
        }
        
        if ( isdefined( equipment ) )
        {
            if ( issharedfuncdefined( "equipment", "hackEquipment" ) )
            {
                equipment [[ getsharedfunc( "equipment", "hackEquipment" ) ]]( self );
            }
        }
    }
}

// Namespace equipment_interact / scripts\cp_mp\equipment_interact
// Params 1
// Checksum 0x0, Offset: 0x9e7
// Size: 0xe2
function function_be0c3a067da1e72d( equipment )
{
    index = -1;
    
    if ( isdefined( equipment.equipmentref ) )
    {
        if ( issharedfuncdefined( "equipment", "getEquipmentTableInfo" ) )
        {
            index = [[ getsharedfunc( "equipment", "getEquipmentTableInfo" ) ]]( equipment.equipmentref ).id;
        }
    }
    
    if ( is_equal( equipment.classname, "misc_turret" ) )
    {
        if ( issharedfuncdefined( "killstreak", "getKillstreakIndex" ) )
        {
            index = 100 + [[ getsharedfunc( "killstreak", "getKillstreakIndex" ) ]]( "sentry_gun" );
        }
        else
        {
            index = 109;
        }
    }
    
    if ( isdefined( equipment.var_1f6c1f17ced6df4b ) )
    {
        index = equipment.var_1f6c1f17ced6df4b;
    }
    
    assert( index != -1, "<dev string:x2b>" );
    return index;
}

// Namespace equipment_interact / scripts\cp_mp\equipment_interact
// Params 3
// Checksum 0x0, Offset: 0xad2
// Size: 0x1b4
function deployhacktablet( index, equipment, streakinfo )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    flag_set( "equipment_interact" );
    weaponobj = makeweapon( "ks_remote_hack_mp" );
    
    if ( isdefined( equipment.var_ad414715a4dbed05 ) )
    {
        weaponobj = equipment.var_ad414715a4dbed05;
    }
    
    if ( isdefined( equipment.var_c9f381a81d2b42ed ) )
    {
        var_c9f381a81d2b42ed = equipment.var_c9f381a81d2b42ed;
    }
    
    if ( isdefined( equipment.var_58dec9951efefbed ) )
    {
        var_58dec9951efefbed = equipment.var_58dec9951efefbed;
    }
    
    cleanupwaitfunc = &_waituntilinteractfinished;
    
    if ( isdefined( equipment.var_af6b61c84f019e58 ) )
    {
        cleanupwaitfunc = equipment.var_af6b61c84f019e58;
    }
    
    var_28801f64e1d308be = undefined;
    
    if ( isdefined( equipment.var_28801f64e1d308be ) )
    {
        var_28801f64e1d308be = equipment.var_28801f64e1d308be;
    }
    
    childthread function_60fbd6e6fc195e7b( equipment );
    thread function_c9ada01dc3eac7f3( index, var_c9f381a81d2b42ed, var_58dec9951efefbed, var_28801f64e1d308be );
    self playlocalsound( "iw9_ks_tablet_foly_raise_plr" );
    switchresult = scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon( weaponobj, streakinfo, cleanupwaitfunc, &_ontabletgiven, undefined, undefined, &_ontabletputaway );
    
    if ( istrue( switchresult ) )
    {
        thread _startusethink( equipment, streakinfo );
        return;
    }
    
    self notify( "interact_cancelled" );
    flag_clear( "equipment_interact" );
    
    if ( iscp() )
    {
        self setclientomnvar( "ui_hack_index", 0 );
        self setclientomnvar( "ui_hack_progress", 0 );
    }
    
    if ( isdefined( equipment ) )
    {
        equipment.isbeingused = 0;
        
        if ( iscp() )
        {
            equipment enablescriptableplayeruse( self );
        }
    }
}

// Namespace equipment_interact / scripts\cp_mp\equipment_interact
// Params 1
// Checksum 0x0, Offset: 0xc8e
// Size: 0x33
function function_60fbd6e6fc195e7b( equipment )
{
    self endon( "interact_cancelled" );
    self endon( "interact_finished" );
    equipment scripts\engine\utility::waittill_any_2( "death", "makeExplosiveUnusable" );
    self notify( "cancel_all_killstreak_deployments" );
}

// Namespace equipment_interact / scripts\cp_mp\equipment_interact
// Params 4
// Checksum 0x0, Offset: 0xcc9
// Size: 0x89
function function_c9ada01dc3eac7f3( hackindex, var_c9f381a81d2b42ed, var_58dec9951efefbed, var_28801f64e1d308be )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self setclientomnvar( "ui_hack_index", hackindex );
    self playlocalsound( "iw9_spotter_perk_tablet_ui" );
    _updatehackprogressomnvar( var_c9f381a81d2b42ed, var_58dec9951efefbed );
    
    if ( isdefined( var_28801f64e1d308be ) )
    {
        self [[ var_28801f64e1d308be ]]();
    }
    
    self stoplocalsound( "iw9_spotter_perk_tablet_ui" );
    self setclientomnvar( "ui_hack_progress", 0 );
    wait 0.1;
    self setclientomnvar( "ui_hack_index", 0 );
}

// Namespace equipment_interact / scripts\cp_mp\equipment_interact
// Params 2
// Checksum 0x0, Offset: 0xd5a
// Size: 0x12b
function _updatehackprogressomnvar( var_c9f381a81d2b42ed, var_58dec9951efefbed )
{
    self endon( "interact_cancelled" );
    self notify( "update_hack_omnvar" );
    self endon( "update_hack_omnvar" );
    self waittill( "interact_started" );
    var_2646e75e629259a6 = 1000;
    var_137d951e4d233a68 = 500;
    var_84fdeec8cd47b94c = getdvarfloat( @"hash_b22bb1a48299003b", 3 ) * 1000;
    
    if ( isdefined( var_c9f381a81d2b42ed ) )
    {
        var_84fdeec8cd47b94c = var_c9f381a81d2b42ed * 1000;
    }
    
    successduration = getdvarfloat( @"hash_f1b36a05bc8c07af", 0.5 ) * 1000;
    
    if ( isdefined( var_58dec9951efefbed ) )
    {
        successduration = var_58dec9951efefbed * 1000;
    }
    
    barduration = var_84fdeec8cd47b94c - var_2646e75e629259a6 - successduration;
    var_b8cf204dd62d457f = gettime() + var_84fdeec8cd47b94c + var_137d951e4d233a68;
    var_b7eb0c292517d42d = gettime() + var_2646e75e629259a6;
    
    while ( true )
    {
        barprogress = ( gettime() - var_b7eb0c292517d42d ) / barduration;
        barprogress = clamp( barprogress, 0, 1 );
        self setclientomnvar( "ui_hack_progress", barprogress );
        wait 0.05;
        
        if ( gettime() > var_b8cf204dd62d457f )
        {
            break;
        }
    }
}

// Namespace equipment_interact / scripts\cp_mp\equipment_interact
// Params 2
// Checksum 0x0, Offset: 0xe8d
// Size: 0x26, Type: bool
function _ontabletgiven( streakinfo, switchresult )
{
    _toggletabletallows( 1 );
    thread _cleanuptabletallows();
    return true;
}

// Namespace equipment_interact / scripts\cp_mp\equipment_interact
// Params 1
// Checksum 0x0, Offset: 0xebc
// Size: 0x3d
function _cancelputawayonuseend( streakinfo )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    streakinfo endon( "deploy_weapon_switch_ended" );
    
    while ( true )
    {
        if ( !self usebuttonpressed() )
        {
            break;
        }
        
        waitframe();
    }
    
    self notify( "cancel_all_killstreak_deployments" );
}

// Namespace equipment_interact / scripts\cp_mp\equipment_interact
// Params 1
// Checksum 0x0, Offset: 0xf01
// Size: 0x1f
function _ontabletputaway( streakinfo )
{
    self notify( "tabletPutAway" );
    self playlocalsound( "iw9_ks_tablet_foly_lower_plr" );
}

// Namespace equipment_interact / scripts\cp_mp\equipment_interact
// Params 1
// Checksum 0x0, Offset: 0xf28
// Size: 0x77
function _waituntilinteractfinished( streakinfo )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "interact_cancelled" );
    
    if ( streakinfo.interactstate != 0 )
    {
        return;
    }
    
    self waittill( "interact_finished" );
    flag_clear( "equipment_interact" );
    
    if ( streakinfo.interactstate == 2 )
    {
        successtime = getdvarfloat( @"hash_f1b36a05bc8c07af", 0.5 );
        wait successtime;
    }
}

// Namespace equipment_interact / scripts\cp_mp\equipment_interact
// Params 0
// Checksum 0x0, Offset: 0xfa7
// Size: 0x2e
function _cleanuptabletallows()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    waittill_any_3( "death", "tabletPutAway", "interact_cancelled" );
    _toggletabletallows( 0 );
}

// Namespace equipment_interact / scripts\cp_mp\equipment_interact
// Params 1
// Checksum 0x0, Offset: 0xfdd
// Size: 0xa6
function _toggletabletallows( var_da3010af8f6be463 )
{
    if ( isalive( self ) )
    {
        if ( var_da3010af8f6be463 )
        {
            val::set( "tablet", "allow_movement", 0 );
            val::set( "tablet", "allow_jump", 0 );
            val::set( "tablet", "usability", 0 );
            val::set( "tablet", "melee", 0 );
            val::set( "tablet", "offhand_weapons", 0 );
            val::set( "tablet", "fire", 0 );
            val::set( "tablet", "freezecontrols_allowlook", 1 );
            return;
        }
        
        val::reset_all( "tablet" );
    }
}

