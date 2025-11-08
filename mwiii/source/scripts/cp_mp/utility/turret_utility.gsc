#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace turret_utility;

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 11
// Checksum 0x0, Offset: 0x1bd
// Size: 0x27c
function function_770a14e56b03b067( turret, var_8826c6bc694729c5, var_f537b27c366f06c9, var_9c8dd41525b291d5, var_693b7b6938cb597e, var_9a5ffe4775714312, var_da50ab9753c3ae26, var_4a44b8ef4d9cba92, var_1833609413f67de7, ignoreplayerteam, var_a4bf19053a661fc5 )
{
    if ( !isdefined( turret ) )
    {
        assertmsg( "<dev string:x1c>" );
        return undefined;
    }
    
    validtargetsdata = function_e1424ac9314fd672( turret, var_8826c6bc694729c5, var_f537b27c366f06c9, var_9c8dd41525b291d5, var_693b7b6938cb597e, var_da50ab9753c3ae26, var_4a44b8ef4d9cba92, ignoreplayerteam, var_a4bf19053a661fc5 );
    bestyaw = undefined;
    besttargetdata = undefined;
    
    foreach ( targetdata in validtargetsdata )
    {
        targetplayer = function_70b8756e9fc03c44( targetdata );
        
        if ( !turret_isvalidtarget( turret, targetplayer, var_8826c6bc694729c5, var_f537b27c366f06c9, var_9c8dd41525b291d5, var_693b7b6938cb597e, var_da50ab9753c3ae26, var_4a44b8ef4d9cba92, ignoreplayerteam, var_a4bf19053a661fc5 ) )
        {
            continue;
        }
        
        targetvehicle = function_effebb9076efbdb( targetdata );
        sourceent = turret;
        var_4bacd07ac9b43431 = turret getlinkedparent();
        
        if ( isdefined( var_4bacd07ac9b43431 ) )
        {
            sourceent = var_4bacd07ac9b43431;
        }
        
        angle = abs( vectortoangles( targetplayer.origin - sourceent.origin )[ 1 ] );
        var_5859f08fc82143f7 = abs( sourceent gettagangles( "tag_origin" )[ 1 ] );
        angle = abs( angle - var_5859f08fc82143f7 );
        
        if ( !istrue( var_1833609413f67de7 ) )
        {
            weaponsarray = targetplayer getweaponslistitems();
            
            foreach ( weapon in weaponsarray )
            {
                weaponclassname = weaponclass( weapon );
                
                if ( weaponclassname == "rocketlauncher" )
                {
                    angle -= 40;
                }
            }
        }
        
        if ( isdefined( targetvehicle ) )
        {
            attackvehicle = 1;
            angle += 20;
        }
        
        if ( !isdefined( bestyaw ) || bestyaw > angle )
        {
            bestyaw = angle;
            besttargetdata = targetdata;
        }
    }
    
    if ( isdefined( besttargetdata ) && isdefined( var_9a5ffe4775714312 ) )
    {
        turret thread function_9598d2dcfc423f60( besttargetdata, var_9a5ffe4775714312 );
    }
    
    return besttargetdata;
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 2
// Checksum 0x0, Offset: 0x442
// Size: 0x3d
function turret_settarget( turret, targetdata )
{
    if ( !isdefined( turret ) )
    {
        assertmsg( "<dev string:x59>" );
        return;
    }
    
    turret.currenttarget = function_70b8756e9fc03c44( targetdata );
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 1
// Checksum 0x0, Offset: 0x487
// Size: 0x2d
function turret_cleartarget( turret )
{
    if ( !isdefined( turret ) )
    {
        assertmsg( "<dev string:x92>" );
        return;
    }
    
    turret.currenttarget = undefined;
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 2
// Checksum 0x0, Offset: 0x4bc
// Size: 0x37
function function_46c1ea4a69ad33d6( turret, targetstate )
{
    if ( !isdefined( turret ) )
    {
        assertmsg( "<dev string:xcf>" );
        return;
    }
    
    turret.targetstate = targetstate;
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 1
// Checksum 0x0, Offset: 0x4fb
// Size: 0x4d
function function_7e4458965893599a( turret )
{
    if ( !isdefined( turret ) )
    {
        assertmsg( "<dev string:x113>" );
        return;
    }
    
    if ( !isdefined( turret.targetstate ) )
    {
        assertmsg( "<dev string:x157>" );
    }
    
    return turret.targetstate;
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 1
// Checksum 0x0, Offset: 0x551
// Size: 0x1d, Type: bool
function turret_hastarget( turret )
{
    return isdefined( turret ) && isdefined( turret.currenttarget );
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 2
// Checksum 0x0, Offset: 0x577
// Size: 0x49
function function_bc2021c62b0d43cc( turret, target )
{
    activetarget = 0;
    
    if ( !isdefined( target ) )
    {
        return 0;
    }
    
    currenttarget = function_2adff40b591b5758( turret );
    
    if ( isdefined( currenttarget ) && currenttarget == target )
    {
        activetarget = 1;
    }
    
    return activetarget;
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 1
// Checksum 0x0, Offset: 0x5c9
// Size: 0x24
function function_2adff40b591b5758( turret )
{
    return ter_op( turret_hastarget( turret ), turret.currenttarget, undefined );
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 1
// Checksum 0x0, Offset: 0x5f6
// Size: 0x2d
function function_70b8756e9fc03c44( targetdata )
{
    if ( !isdefined( targetdata ) )
    {
        assertmsg( "<dev string:x1f3>" );
        return;
    }
    
    return targetdata.targetplayer;
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 1
// Checksum 0x0, Offset: 0x62c
// Size: 0x2d
function function_effebb9076efbdb( targetdata )
{
    if ( !isdefined( targetdata ) )
    {
        assertmsg( "<dev string:x273>" );
        return;
    }
    
    return targetdata.targetvehicle;
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 3
// Checksum 0x0, Offset: 0x662
// Size: 0x19d
function turret_canseetarget( turret, potentialtarget, var_935ba61e1c5c6320 )
{
    contentsoverride = function_72017fc448d5c9a0();
    var_b9d5783a4f34efbc = [ turret ];
    var_15c3c1d963654f89 = 0;
    
    if ( istrue( var_935ba61e1c5c6320 ) )
    {
        var_15c3c1d963654f89 = potentialtarget isinvehicle();
        
        if ( istrue( var_15c3c1d963654f89 ) )
        {
            occupiedvehicle = potentialtarget getvehicle();
            var_b9d5783a4f34efbc[ var_b9d5783a4f34efbc.size ] = occupiedvehicle;
            linkedmodels = occupiedvehicle getlinkedchildren();
            
            if ( isdefined( linkedmodels ) && linkedmodels.size > 0 )
            {
                var_b9d5783a4f34efbc = array_combine( var_b9d5783a4f34efbc, linkedmodels );
            }
        }
    }
    
    tracelist = [];
    
    if ( isplayer( potentialtarget ) || isagent( potentialtarget ) )
    {
        headpos = potentialtarget gettagorigin( "j_head" );
        
        if ( isdefined( headpos ) )
        {
            tracelist[ tracelist.size ] = headpos;
        }
        
        midpos = potentialtarget gettagorigin( "j_mainroot" );
        
        if ( isdefined( midpos ) )
        {
            tracelist[ tracelist.size ] = midpos;
        }
    }
    
    tracelist[ tracelist.size ] = potentialtarget.origin;
    canseetarget = 0;
    tracestartpos = turret gettagorigin( "tag_barrel" );
    
    foreach ( traceendpos in tracelist )
    {
        canseetarget = ray_trace_passed( tracestartpos, traceendpos, var_b9d5783a4f34efbc, contentsoverride );
        
        if ( istrue( canseetarget ) )
        {
            break;
        }
        
        wait 0.05;
    }
    
    return canseetarget;
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 1
// Checksum 0x0, Offset: 0x808
// Size: 0x17, Type: bool
function function_f6926785e402b9fe( targetdata )
{
    return istrue( targetdata.attackvehicle );
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 1
// Checksum 0x0, Offset: 0x828
// Size: 0x17, Type: bool
function function_d463678ccf4beeda( targetdata )
{
    return istrue( targetdata.attacklaststand );
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 1
// Checksum 0x0, Offset: 0x848
// Size: 0x17, Type: bool
function function_bebd2d48ca6c8a31( targetdata )
{
    return istrue( targetdata.attackparachute );
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 4
// Checksum 0x0, Offset: 0x868
// Size: 0xd3, Type: bool
function function_bb61346fda4278e5( turret, target, var_a545c521308d6b1e, attackanglethreshold )
{
    if ( !turret_hastarget( turret ) && !isdefined( target ) )
    {
        return false;
    }
    
    currenttarget = function_2adff40b591b5758( turret );
    
    if ( isdefined( target ) )
    {
        currenttarget = target;
    }
    
    targetlocation = currenttarget.origin;
    
    if ( isdefined( var_a545c521308d6b1e ) )
    {
        targetlocation = currenttarget gettagorigin( var_a545c521308d6b1e );
    }
    
    if ( !isdefined( attackanglethreshold ) )
    {
        attackanglethreshold = 10;
    }
    
    turretforward = anglestoforward( turret gettagangles( "tag_flash" ) );
    targetdisplace = targetlocation - turret gettagorigin( "tag_flash" );
    anglediff = math::anglebetweenvectors( turretforward, targetdisplace );
    
    if ( anglediff <= attackanglethreshold )
    {
        return true;
    }
    
    return false;
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 9, eflags: 0x4
// Checksum 0x0, Offset: 0x944
// Size: 0xd9
function private function_e1424ac9314fd672( turret, var_8826c6bc694729c5, var_f537b27c366f06c9, var_9c8dd41525b291d5, var_693b7b6938cb597e, var_da50ab9753c3ae26, var_4a44b8ef4d9cba92, ignoreplayerteam, var_a4bf19053a661fc5 )
{
    turret endon( "death" );
    level endon( "game_ended" );
    
    if ( !isdefined( var_8826c6bc694729c5 ) )
    {
        var_8826c6bc694729c5 = 5000;
    }
    
    alltargets = function_f28fd019a7657543( turret, var_8826c6bc694729c5 );
    finaltargets = [];
    
    for ( i = 0; i < alltargets.size ; i++ )
    {
        targetdata = function_c836479731703b1b( turret, alltargets[ i ], var_8826c6bc694729c5, var_f537b27c366f06c9, var_9c8dd41525b291d5, var_693b7b6938cb597e, var_da50ab9753c3ae26, var_4a44b8ef4d9cba92, ignoreplayerteam, var_a4bf19053a661fc5 );
        
        if ( isdefined( targetdata ) )
        {
            finaltargets[ finaltargets.size ] = targetdata;
        }
        else
        {
            continue;
        }
        
        wait 0.05;
    }
    
    return finaltargets;
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xa26
// Size: 0x81
function private function_f28fd019a7657543( turret, var_8826c6bc694729c5 )
{
    allpotentialtargets = [];
    
    if ( utility::iscp() )
    {
        allplayers = level.players;
        allai = [];
        
        if ( isdefined( level.agentarray ) )
        {
            allai = level.agentarray;
        }
        
        allpotentialtargets = array_combine( allai, allplayers );
    }
    else
    {
        allpotentialtargets = utility::function_2d7fd59d039fa69b( turret.origin, var_8826c6bc694729c5 );
    }
    
    return allpotentialtargets;
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xab0
// Size: 0x7e
function private function_72017fc448d5c9a0()
{
    character = 0;
    world = 1;
    glass = 0;
    shotclip = 1;
    item = 0;
    vehicle = 1;
    playerclip = 0;
    ainosight = 1;
    itemclip = 1;
    return create_contents( character, world, glass, shotclip, item, vehicle, playerclip, ainosight, itemclip );
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 10, eflags: 0x4
// Checksum 0x0, Offset: 0xb37
// Size: 0x138
function private function_c836479731703b1b( turret, potentialtarget, var_8826c6bc694729c5, var_f537b27c366f06c9, var_9c8dd41525b291d5, var_693b7b6938cb597e, var_da50ab9753c3ae26, var_4a44b8ef4d9cba92, ignoreplayerteam, var_a4bf19053a661fc5 )
{
    turret endon( "death" );
    
    if ( !turret_isvalidtarget( turret, potentialtarget, var_8826c6bc694729c5, var_f537b27c366f06c9, var_9c8dd41525b291d5, var_693b7b6938cb597e, var_da50ab9753c3ae26, var_4a44b8ef4d9cba92, ignoreplayerteam, var_a4bf19053a661fc5 ) )
    {
        return undefined;
    }
    
    targetdata = function_371b6c83926ff36();
    canseetarget = turret_canseetarget( turret, potentialtarget, var_f537b27c366f06c9 );
    var_15c3c1d963654f89 = undefined;
    occupiedvehicle = undefined;
    
    if ( istrue( var_f537b27c366f06c9 ) )
    {
        var_15c3c1d963654f89 = potentialtarget isinvehicle();
        
        if ( istrue( var_15c3c1d963654f89 ) )
        {
            occupiedvehicle = potentialtarget getvehicle();
        }
    }
    
    if ( istrue( canseetarget ) )
    {
        targetdata.targetplayer = potentialtarget;
        targetdata.targetvehicle = ter_op( isdefined( occupiedvehicle ), occupiedvehicle, undefined );
        targetdata.attackvehicle = istrue( var_f537b27c366f06c9 ) && istrue( var_15c3c1d963654f89 ) && isdefined( occupiedvehicle );
        targetdata.attacklaststand = istrue( var_9c8dd41525b291d5 );
        targetdata.attackparachute = istrue( var_693b7b6938cb597e );
    }
    
    return targetdata;
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 10, eflags: 0x4
// Checksum 0x0, Offset: 0xc78
// Size: 0x23e, Type: bool
function private turret_isvalidtarget( turret, potentialtarget, var_8826c6bc694729c5, var_f537b27c366f06c9, var_9c8dd41525b291d5, var_693b7b6938cb597e, var_da50ab9753c3ae26, var_4a44b8ef4d9cba92, ignoreplayerteam, var_a4bf19053a661fc5 )
{
    if ( !isdefined( potentialtarget ) )
    {
        return false;
    }
    
    turretteam = turret.team;
    
    if ( isdefined( var_4a44b8ef4d9cba92 ) )
    {
        turretteam = var_4a44b8ef4d9cba92;
    }
    
    if ( isplayer( potentialtarget ) )
    {
        if ( !function_52cda0abb7f78d63( potentialtarget ) )
        {
            return false;
        }
        
        if ( isdefined( self.owner ) && potentialtarget == self.owner )
        {
            /#
                if ( isdefined( var_da50ab9753c3ae26 ) && istrue( getdvarint( var_da50ab9753c3ae26, 0 ) ) )
                {
                    return true;
                }
            #/
            
            return false;
        }
        
        teamtocheck = potentialtarget.pers[ "team" ];
        
        if ( teamtocheck == "spectator" )
        {
            return false;
        }
        
        if ( isdefined( level.teambased ) )
        {
            if ( !isdefined( teamtocheck ) )
            {
                return false;
            }
            
            if ( isdefined( turretteam ) && !istrue( ignoreplayerteam ) )
            {
                if ( level.teambased && teamtocheck == turretteam )
                {
                    return false;
                }
            }
        }
    }
    
    if ( isagent( potentialtarget ) )
    {
        if ( !isalive( potentialtarget ) )
        {
            return false;
        }
        
        if ( isdefined( potentialtarget.agent_type ) && issubstr( potentialtarget.agent_type, "civilian" ) )
        {
            return false;
        }
        
        teamtocheck = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata( potentialtarget, "team" );
        
        if ( isdefined( turretteam ) && !istrue( var_a4bf19053a661fc5 ) )
        {
            if ( isdefined( teamtocheck ) && teamtocheck == turretteam )
            {
                return false;
            }
        }
    }
    
    if ( issharedfuncdefined( "perk", "hasPerk" ) )
    {
        if ( potentialtarget [[ getsharedfunc( "perk", "hasPerk" ) ]]( "specialty_blindeye" ) )
        {
            return false;
        }
    }
    
    if ( isdefined( var_8826c6bc694729c5 ) )
    {
        if ( distancesquared( turret.origin, potentialtarget.origin ) > var_8826c6bc694729c5 * var_8826c6bc694729c5 )
        {
            return false;
        }
    }
    
    if ( istrue( potentialtarget isinvehicle() ) && !istrue( var_f537b27c366f06c9 ) )
    {
        return false;
    }
    
    if ( istrue( potentialtarget.inlaststand ) && !istrue( var_9c8dd41525b291d5 ) )
    {
        return false;
    }
    
    if ( scripts\cp_mp\parachute::isparachutegametype() && ( potentialtarget isparachuting() || potentialtarget isskydiving() ) && !istrue( var_693b7b6938cb597e ) )
    {
        return false;
    }
    
    return true;
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xebf
// Size: 0x2d, Type: bool
function private function_52cda0abb7f78d63( player )
{
    return isdefined( player ) && player _isalive() && player.sessionstate == "playing";
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xef5
// Size: 0x51
function private function_371b6c83926ff36()
{
    targetdata = spawnstruct();
    targetdata.targetplayer = undefined;
    targetdata.targetvehicle = undefined;
    targetdata.attackvehicle = 0;
    targetdata.attacklaststand = 0;
    targetdata.attackparachute = 0;
    return targetdata;
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xf4f
// Size: 0x56
function private function_9598d2dcfc423f60( targetdata, var_9a5ffe4775714312 )
{
    self endon( "death" );
    turret_settarget( self, targetdata );
    thread function_7826e8e1bd494568( function_70b8756e9fc03c44( targetdata ), "death_or_disconnect" );
    
    if ( isdefined( var_9a5ffe4775714312 ) )
    {
        thread function_7826e8e1bd494568( self, var_9a5ffe4775714312 );
    }
    
    self waittill( "clear_turret_target" );
    turret_cleartarget( self );
}

// Namespace turret_utility / scripts\cp_mp\utility\turret_utility
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xfad
// Size: 0x2d
function private function_7826e8e1bd494568( ent, notifymsg )
{
    self endon( "death" );
    self endon( "clear_turret_target" );
    ent waittill( notifymsg );
    self notify( "clear_turret_target" );
}

