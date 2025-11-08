#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace killstreak_shared;

// Namespace killstreak_shared / scripts\killstreaks\killstreak_shared
// Params 2
// Checksum 0x0, Offset: 0x2dc
// Size: 0x52
function registerkillstreakinitfunction( bundlenamexhash, initfunc )
{
    if ( !isdefined( level.var_7233e8ba4d09f124 ) )
    {
        level.var_7233e8ba4d09f124 = [];
    }
    
    assertex( !isdefined( level.var_7233e8ba4d09f124[ bundlenamexhash ] ), "Killstreak Init function redefinition." );
    level.var_7233e8ba4d09f124[ bundlenamexhash ] = initfunc;
}

// Namespace killstreak_shared / scripts\killstreaks\killstreak_shared
// Params 1
// Checksum 0x0, Offset: 0x336
// Size: 0x3a
function initializekillstreak( streakrefxhash )
{
    if ( !isdefined( level.var_7233e8ba4d09f124 ) )
    {
        return;
    }
    
    initfunc = level.var_7233e8ba4d09f124[ streakrefxhash ];
    
    if ( !isdefined( initfunc ) )
    {
        return;
    }
    
    level [[ initfunc ]]();
}

// Namespace killstreak_shared / scripts\killstreaks\killstreak_shared
// Params 1
// Checksum 0x0, Offset: 0x378
// Size: 0x2b6, Type: bool
function parsestreakbundles( killstreaklistname )
{
    if ( !isdefined( killstreaklistname ) )
    {
        return false;
    }
    
    globals = level.streakglobals;
    
    if ( isdefined( globals.streakbundles ) )
    {
        return false;
    }
    
    globals.streakbundles = [];
    globals.var_2150da9328528bb9 = [];
    killstreaklistbundle = getscriptbundle( killstreaklistname );
    
    if ( !isdefined( killstreaklistbundle ) )
    {
        return false;
    }
    
    foreach ( index, killstreaklistentry in killstreaklistbundle.killstreak_list )
    {
        if ( !isnumber( index ) )
        {
            continue;
        }
        
        if ( !isdefined( killstreaklistentry ) )
        {
            continue;
        }
        
        killstreakbundlename = killstreaklistentry.bundle;
        
        if ( !isdefined( killstreakbundlename ) )
        {
            continue;
        }
        
        assert( isxhashasset( killstreakbundlename ) );
        
        if ( killstreakbundlename == %"killstreak:killstreak_none" )
        {
            continue;
        }
        
        if ( killstreakbundlename == %"hash_40daaf59ab8992e5" )
        {
            continue;
        }
        
        bundle = getscriptbundle( killstreakbundlename );
        
        if ( !isdefined( bundle ) )
        {
            continue;
        }
        
        streakref = bundle.killstreakref;
        
        if ( !isdefined( streakref ) || streakref == "none" )
        {
            assert( isdefined( streakref ) );
            continue;
        }
        
        bundle.var_19fb085453713468 = killstreakbundlename;
        function_2ff74098fad17213( killstreaklistentry, streakref );
        globals.streakbundles[ streakref ] = bundle;
        globals.var_2150da9328528bb9[ streakref ] = index;
        assert( isstring( streakref ) );
        streakrefxhash = getxhash( streakref );
        game[ "dialog" ][ streakrefxhash ] = "killstreak_team_leader" + "_earned";
        game[ "dialog" ][ streakref + "_teamleader_friendly_inbound" ] = "killstreak_team_leader" + "_ally_callout";
        game[ "dialog" ][ streakref + "_teamleader_enemy_inbound" ] = "killstreak_team_leader" + "_enemy_callout";
        game[ "dialog" ][ streakref + "_teamleader_destroyed" ] = "killstreak_team_leader" + "_crash";
        game[ "dialog" ][ streakref + "_teamleader_timeout" ] = "killstreak_team_leader" + "_timeout";
        streakpoints = bundle.score;
        
        if ( isdefined( streakpoints ) && streakpoints > 0 )
        {
            registerscoreinfosharedfunc( hashcat( #"killstreak_", streakref ), #"value", streakpoints );
        }
        
        initializekillstreak( getxhash( streakref ) );
        
        if ( istrue( level.var_63121fffa39a5238 ) )
        {
            [[ level.var_b8057c65baf0784a.var_d9f305202f6f3913 ]]( bundle );
        }
    }
    
    return true;
}

// Namespace killstreak_shared / scripts\killstreaks\killstreak_shared
// Params 2
// Checksum 0x0, Offset: 0x637
// Size: 0x59
function function_2ff74098fad17213( killstreaklistentry, var_acde90128b823518 )
{
    if ( !isdefined( killstreaklistentry.ref ) )
    {
        assert( isdefined( killstreaklistentry.ref ) );
        return;
    }
    
    if ( var_acde90128b823518 == "replace_me" )
    {
        return;
    }
    
    assert( var_acde90128b823518 == killstreaklistentry.ref );
}

// Namespace killstreak_shared / scripts\killstreaks\killstreak_shared
// Params 0
// Checksum 0x0, Offset: 0x698
// Size: 0x71
function killstreak_savenvgstate()
{
    if ( !isdefined( self.pers[ "useNVG" ] ) )
    {
        return;
    }
    
    if ( self isnightvisionon() )
    {
        self.pers[ "useNVG" ] = 1;
        self.pers[ "killstreak_forcedNVGOff" ] = 1;
        self nightvisionviewoff( 1 );
        return;
    }
    
    self.pers[ "useNVG" ] = 0;
    self.pers[ "killstreak_forcedNVGOff" ] = 0;
}

// Namespace killstreak_shared / scripts\killstreaks\killstreak_shared
// Params 0
// Checksum 0x0, Offset: 0x711
// Size: 0x43
function killstreak_restorenvgstate()
{
    if ( !isdefined( self.pers[ "useNVG" ] ) )
    {
        return;
    }
    
    if ( istrue( self.pers[ "useNVG" ] ) )
    {
        self nightvisionviewon( 1 );
        self.pers[ "killstreak_forcedNVGOff" ] = 0;
    }
}

// Namespace killstreak_shared / scripts\killstreaks\killstreak_shared
// Params 0
// Checksum 0x0, Offset: 0x75c
// Size: 0x10c
function function_aa5200593ca327d2()
{
    if ( isdefined( level.killstreakthermalvisionset ) )
    {
        function_c0b0a582ff9e4d57( level.killstreakthermalvisionset );
    }
    
    function_c0b0a582ff9e4d57( "killstreak_thermal" );
    function_c0b0a582ff9e4d57( "killstreak_thermal_fog" );
    function_c0b0a582ff9e4d57( "killstreak_flash", 0.1 );
    function_c0b0a582ff9e4d57( "killstreak_static", 0.1 );
    function_c0b0a582ff9e4d57( "killstreak_slamzoom", 0.1 );
    function_c0b0a582ff9e4d57( "killstreak_color_light_damage", 0.1, 0.1, 0.3 );
    function_c0b0a582ff9e4d57( "killstreak_color_heavy_damage", 0.1, 0.2, 0.5 );
    function_c0b0a582ff9e4d57( "killstreak_thermal_light_damage", 0.1, 0.1, 0.3 );
    function_c0b0a582ff9e4d57( "killstreak_thermal_heavy_damage", 0.1, 0.2, 0.5 );
    function_c0b0a582ff9e4d57( "killstreak_ads_shutter", 0.25, 0.1, 0.25 );
    function_c0b0a582ff9e4d57( "killstreak_weapon_change_shutter", 0.025, 0.08, 0.15 );
}

// Namespace killstreak_shared / scripts\killstreaks\killstreak_shared
// Params 4
// Checksum 0x0, Offset: 0x870
// Size: 0xc9
function function_c0b0a582ff9e4d57( visionsetname, fadeintime, fadewait, fadeouttime )
{
    if ( !isdefined( level.killstreakvisionsets ) )
    {
        level.killstreakvisionsets = [];
    }
    else if ( isdefined( level.killstreakvisionsets[ visionsetname ] ) )
    {
        return;
    }
    
    visionsetinfo = spawnstruct();
    visionsetinfo.name = visionsetname;
    visionsetinfo.type = function_a8f5c03158446d60( visionsetname );
    
    if ( !isdefined( fadeintime ) )
    {
        fadeintime = 0;
    }
    
    visionsetinfo.fadeintime = fadeintime;
    
    if ( !isdefined( fadewait ) )
    {
        fadewait = 0;
    }
    
    visionsetinfo.fadewait = fadewait;
    
    if ( !isdefined( fadeouttime ) )
    {
        fadeouttime = 0;
    }
    
    visionsetinfo.fadeouttime = fadeouttime;
    level.killstreakvisionsets[ visionsetname ] = visionsetinfo;
}

// Namespace killstreak_shared / scripts\killstreaks\killstreak_shared
// Params 1
// Checksum 0x0, Offset: 0x941
// Size: 0x45
function function_a8f5c03158446d60( visionsetname )
{
    visionsetformat = undefined;
    
    if ( issubstr( visionsetname, "thermal" ) )
    {
        visionsetformat = "thermal";
    }
    else if ( issubstr( visionsetname, "color" ) )
    {
        visionsetformat = "color";
    }
    
    return visionsetformat;
}

// Namespace killstreak_shared / scripts\killstreaks\killstreak_shared
// Params 1
// Checksum 0x0, Offset: 0x98f
// Size: 0x2c
function function_58707ddfdd9744fa( visionsetname )
{
    visionsetinfo = function_3de44eb7cdde2614( visionsetname );
    
    if ( !isdefined( visionsetinfo ) )
    {
        return;
    }
    
    thread function_a271c8ce1dd6c1b1( visionsetinfo );
}

// Namespace killstreak_shared / scripts\killstreaks\killstreak_shared
// Params 2
// Checksum 0x0, Offset: 0x9c3
// Size: 0x59
function function_c144de677d9b9175( visionsetname, visionsetstrength )
{
    visionsettype = function_a8f5c03158446d60( visionsetname );
    
    if ( !isdefined( visionsetstrength ) )
    {
        visionsetstrength = "light";
    }
    
    damagevisionset = "killstreak_" + visionsettype + "_" + visionsetstrength + "_damage";
    function_58707ddfdd9744fa( damagevisionset );
}

// Namespace killstreak_shared / scripts\killstreaks\killstreak_shared
// Params 1
// Checksum 0x0, Offset: 0xa24
// Size: 0x4d
function function_3de44eb7cdde2614( visionsetname )
{
    if ( !isdefined( level.killstreakvisionsets ) || !isdefined( visionsetname ) || !isdefined( level.killstreakvisionsets[ visionsetname ] ) )
    {
        assertmsg( "<dev string:x1c>" );
        return undefined;
    }
    
    return level.killstreakvisionsets[ visionsetname ];
}

// Namespace killstreak_shared / scripts\killstreaks\killstreak_shared
// Params 6
// Checksum 0x0, Offset: 0xa7a
// Size: 0x1ae
function killstreak_waittillexplode( var_e127af0eab592c1a, var_e127ae0eab5929e7, var_e127ad0eab5927b4, var_e127ac0eab592581, var_e127ab0eab59234e, var_e127aa0eab59211b )
{
    ent = spawnstruct();
    
    if ( isdefined( var_e127af0eab592c1a ) )
    {
        thread function_e91e598bf5bb2ee5( var_e127af0eab592c1a, ent );
    }
    
    if ( isdefined( var_e127ae0eab5929e7 ) )
    {
        thread function_e91e598bf5bb2ee5( var_e127ae0eab5929e7, ent );
    }
    
    if ( isdefined( var_e127ad0eab5927b4 ) )
    {
        thread function_e91e598bf5bb2ee5( var_e127ad0eab5927b4, ent );
    }
    
    if ( isdefined( var_e127ac0eab592581 ) )
    {
        thread function_e91e598bf5bb2ee5( var_e127ac0eab592581, ent );
    }
    
    if ( isdefined( var_e127ab0eab59234e ) )
    {
        thread function_e91e598bf5bb2ee5( var_e127ab0eab59234e, ent );
    }
    
    if ( isdefined( var_e127aa0eab59211b ) )
    {
        thread function_e91e598bf5bb2ee5( var_e127aa0eab59211b, ent );
    }
    
    ent waittill( "returned", msg, param1, param2, param3, param4, param5, param6, param7, param8 );
    ent notify( "die" );
    explodeinfo = spawnstruct();
    explodeinfo.msg = msg;
    explodeinfo.param1 = param1;
    explodeinfo.param2 = param2;
    explodeinfo.param3 = param3;
    explodeinfo.param4 = param4;
    explodeinfo.param5 = param5;
    explodeinfo.param6 = param6;
    explodeinfo.param7 = param7;
    explodeinfo.param8 = param8;
    return explodeinfo;
}

// Namespace killstreak_shared / scripts\killstreaks\killstreak_shared
// Params 2
// Checksum 0x0, Offset: 0xc31
// Size: 0x7a
function function_e91e598bf5bb2ee5( msg, ent )
{
    self endon( "death" );
    ent endon( "die" );
    self waittill( msg, param1, param2, param3, param4, param5, param6 );
    ent notify( "returned", msg, param1, param2, param3, param4, param5, param6 );
}

