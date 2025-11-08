#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\stealth\callbacks;
#using scripts\stealth\debug;
#using scripts\stealth\manager;
#using scripts\stealth\utility;

#namespace friendly;

// Namespace friendly / scripts\stealth\friendly
// Params 0
// Checksum 0x0, Offset: 0x13b
// Size: 0x56
function main()
{
    if ( !isdefined( level.stealth ) )
    {
        scripts\stealth\manager::main();
    }
    
    init_settings();
    self.stealth_groupname = self.script_stealthgroup;
    thread spotted_thread();
    thread visibility_thread();
    self function_95d5375059c2a022( "mp_stealth" );
    
    /#
        thread debug_friendly();
    #/
}

// Namespace friendly / scripts\stealth\friendly
// Params 0
// Checksum 0x0, Offset: 0x199
// Size: 0x7f
function init_settings()
{
    assertex( !isdefined( self.stealth ), "Friendly is already initialized for stealth" );
    self.stealth = spawnstruct();
    self.stealth.funcs = [];
    ent_flag_init( "stealth_enabled" );
    ent_flag_set( "stealth_enabled" );
    ent_flag_init( "stealth_in_shadow" );
    scripts\stealth\utility::group_flag_init( "stealth_spotted" );
    scripts\stealth\utility::group_add();
    self.stealth_bsmstate = 0;
}

// Namespace friendly / scripts\stealth\friendly
// Params 0
// Checksum 0x0, Offset: 0x220
// Size: 0x94
function spotted_thread()
{
    self endon( "death" );
    self notify( "spotted_thread" );
    self endon( "spotted_thread" );
    
    while ( true )
    {
        ent_flag_wait( "stealth_enabled" );
        scripts\stealth\utility::group_flag_waitopen( "stealth_spotted" );
        
        if ( !ent_flag( "stealth_enabled" ) )
        {
            ent_flag_wait( "stealth_enabled" );
        }
        
        thread state_hidden();
        ent_flag_wait( "stealth_enabled" );
        scripts\stealth\utility::group_flag_wait( "stealth_spotted" );
        
        if ( !ent_flag( "stealth_enabled" ) )
        {
            ent_flag_wait( "stealth_enabled" );
        }
        
        thread state_spotted();
    }
}

// Namespace friendly / scripts\stealth\friendly
// Params 0
// Checksum 0x0, Offset: 0x2bc
// Size: 0x7b
function state_hidden()
{
    thread scripts\stealth\utility::setbattlechatter( 0 );
    self.stealth.oldgrenadeammo = self.grenadeammo;
    self.grenadeammo = 0;
    self.forcesidearm = 0;
    self.dontevershoot = 1;
    self.dontattackme = 1;
    
    if ( isdefined( self.stealth.funcs[ "hidden" ] ) )
    {
        stealth_call_thread( "hidden" );
    }
}

// Namespace friendly / scripts\stealth\friendly
// Params 0
// Checksum 0x0, Offset: 0x33f
// Size: 0xa2
function state_spotted()
{
    assert( !isplayer( self ) );
    thread scripts\stealth\utility::setbattlechatter( 1 );
    
    if ( isdefined( self.stealth.oldgrenadeammo ) )
    {
        self.grenadeammo = self.stealth.oldgrenadeammo;
    }
    else
    {
        self.grenadeammo = 3;
    }
    
    self.dontevershoot = 0;
    self.dontattackme = 0;
    self pushplayer( 0 );
    
    if ( isdefined( self.stealth.funcs[ "spotted" ] ) )
    {
        stealth_call_thread( "spotted" );
    }
}

// Namespace friendly / scripts\stealth\friendly
// Params 0
// Checksum 0x0, Offset: 0x3e9
// Size: 0x9
function getup_from_prone()
{
    self endon( "death" );
}

// Namespace friendly / scripts\stealth\friendly
// Params 0
// Checksum 0x0, Offset: 0x3fa
// Size: 0x50
function visibility_thread()
{
    self endon( "death" );
    self endon( "long_death" );
    
    while ( true )
    {
        ent_flag_wait( "stealth_enabled" );
        
        if ( !isdefined( self.stealth.ignore_visibility ) )
        {
            self.maxvisibledist = get_detect_range();
        }
        
        wait 0.05;
    }
}

// Namespace friendly / scripts\stealth\friendly
// Params 0
// Checksum 0x0, Offset: 0x452
// Size: 0x88
function get_detect_range()
{
    stance = self.currentpose;
    
    if ( stance == "back" )
    {
        stance = "prone";
    }
    
    if ( scripts\stealth\utility::group_spotted_flag() )
    {
        detection = "spotted";
    }
    else
    {
        detection = "hidden";
    }
    
    range = getstealthdetectrange( detection, stance );
    
    if ( ent_flag( "stealth_in_shadow" ) )
    {
        range = max( getstealthdetectrange( "hidden", "prone" ), range * 0.5 );
    }
    
    return range;
}

