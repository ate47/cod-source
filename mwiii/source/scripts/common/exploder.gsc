#using scripts\common\createfx;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace exploder;

// Namespace exploder / scripts\common\exploder
// Params 1
// Checksum 0x0, Offset: 0x377
// Size: 0xd1
function setup_individual_exploder( ent )
{
    targetname = ent.targetname;
    
    if ( !isdefined( targetname ) )
    {
        targetname = "";
    }
    
    if ( exploder_starts_hidden( ent ) )
    {
        ent hide();
        return;
    }
    
    if ( exploder_is_damaged_model( ent ) )
    {
        ent hide();
        ent notsolid();
        
        if ( isdefined( ent.spawnflags ) && ent.spawnflags & 1 )
        {
            if ( isdefined( ent.script_disconnectpaths ) )
            {
                ent connectpaths();
            }
        }
        
        return;
    }
    
    if ( exploder_is_chunk( ent ) )
    {
        ent hide();
        ent notsolid();
        
        if ( isdefined( ent.spawnflags ) && ent.spawnflags & 1 )
        {
            ent connectpaths();
        }
        
        return;
    }
}

// Namespace exploder / scripts\common\exploder
// Params 1
// Checksum 0x0, Offset: 0x450
// Size: 0xef
function addinitexploders( potentialexploders )
{
    foreach ( ent in potentialexploders )
    {
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        if ( isdefined( ent.script_prefab_exploder ) )
        {
            ent.script_exploder = ent.script_prefab_exploder;
            level.init_exploders[ level.init_exploders.size ] = ent;
            continue;
        }
        
        if ( isdefined( ent.script_exploder ) )
        {
            isexploder = 1;
            
            if ( !isdefined( ent.angles ) )
            {
                ent.angles = ( 0, 0, 0 );
            }
            
            level.init_exploders[ level.init_exploders.size ] = ent;
        }
    }
}

// Namespace exploder / scripts\common\exploder
// Params 0
// Checksum 0x0, Offset: 0x547
// Size: 0x84a
function setupexploders()
{
    level.init_exploders = [];
    level.exploders = [];
    ents = getentarray( "script_brushmodel", "classname" );
    smodels = getentarray( "script_model", "classname" );
    
    foreach ( smodel in smodels )
    {
        ents[ ents.size ] = smodel;
    }
    
    foreach ( ent in ents )
    {
        if ( isdefined( ent.script_prefab_exploder ) )
        {
            ent.script_exploder = ent.script_prefab_exploder;
        }
        
        if ( isdefined( ent.masked_exploder ) )
        {
            continue;
        }
        
        if ( isdefined( ent.script_exploder ) )
        {
            setup_individual_exploder( ent );
        }
    }
    
    addinitexploders( getentarray( "script_brushmodel", "classname" ) );
    addinitexploders( getentarray( "script_model", "classname" ) );
    addinitexploders( level.struct_exploders );
    level.struct_exploders = undefined;
    
    if ( !isdefined( level.createfxent ) )
    {
        level.createfxent = [];
    }
    
    acceptabletargetnames = [];
    acceptabletargetnames[ "exploderchunk visible" ] = 1;
    acceptabletargetnames[ "exploderchunk" ] = 1;
    acceptabletargetnames[ "exploder" ] = 1;
    
    foreach ( exploder in level.init_exploders )
    {
        ent = createexploder( exploder.script_fxid, 1 );
        ent.v = [];
        ent.v[ "origin" ] = exploder.origin;
        ent.v[ "angles" ] = exploder.angles;
        ent.v[ "delay" ] = exploder.script_delay;
        ent.v[ "delay_post" ] = exploder.script_delay_post;
        ent.v[ "firefx" ] = exploder.script_firefx;
        ent.v[ "firefxdelay" ] = exploder.script_firefxdelay;
        ent.v[ "firefxsound" ] = exploder.script_firefxsound;
        ent.v[ "earthquake" ] = exploder.script_earthquake;
        ent.v[ "rumble" ] = exploder.script_rumble;
        ent.v[ "damage" ] = exploder.script_damage;
        ent.v[ "damage_radius" ] = exploder.script_radius;
        ent.v[ "soundalias" ] = exploder.script_soundalias;
        ent.v[ "repeat" ] = exploder.script_repeat;
        ent.v[ "delay_min" ] = exploder.script_delay_min;
        ent.v[ "delay_max" ] = exploder.script_delay_max;
        ent.v[ "target" ] = exploder.target;
        ent.v[ "ender" ] = exploder.script_ender;
        ent.v[ "physics" ] = exploder.script_physics;
        ent.v[ "type" ] = "exploder";
        ent.v[ "dotraces" ] = exploder.script_trace;
        ent.v[ "envonly" ] = exploder.script_envonly;
        ent.v[ "area_swap_index" ] = exploder.var_70fc63ef46137e97;
        ent.v[ "area_swap_state" ] = exploder.var_6d7dc2bcfc863ad2;
        
        if ( !isdefined( ent.v[ "angles" ] ) )
        {
            ent.v[ "angles" ] = ( 0, 0, 0 );
        }
        
        ent scripts\common\createfx::set_forward_and_up_vectors();
        
        if ( !isdefined( exploder.script_fxid ) )
        {
            ent.v[ "fxid" ] = "No FX";
        }
        else
        {
            ent.v[ "fxid" ] = exploder.script_fxid;
        }
        
        ent.v[ "exploder" ] = exploder.script_exploder;
        assertex( isdefined( exploder.script_exploder ), "<dev string:x1c>" + exploder.origin + "<dev string:x33>" );
        
        if ( !isdefined( ent.v[ "delay" ] ) )
        {
            ent.v[ "delay" ] = 0;
        }
        
        if ( isdefined( exploder.target ) )
        {
            get_ent = getentarray( ent.v[ "target" ], "targetname" )[ 0 ];
            
            if ( isdefined( get_ent ) )
            {
                org = get_ent.origin;
                ent.v[ "angles" ] = vectortoangles( org - ent.v[ "origin" ] );
            }
            else
            {
                get_ent = get_target_ent( ent.v[ "target" ] );
                
                if ( isdefined( get_ent ) )
                {
                    org = get_ent.origin;
                    ent.v[ "angles" ] = vectortoangles( org - ent.v[ "origin" ] );
                }
            }
        }
        
        if ( isstruct( exploder ) )
        {
            ent.model = exploder;
            
            if ( isdefined( ent.model.script_modelname ) )
            {
                precachemodel( ent.model.script_modelname );
            }
        }
        else if ( exploder.code_classname == "script_brushmodel" || isdefined( exploder.model ) )
        {
            ent.model = exploder;
            ent.model.disconnect_paths = exploder.script_disconnectpaths;
        }
        
        if ( isdefined( exploder.targetname ) && isdefined( acceptabletargetnames[ exploder.targetname ] ) )
        {
            ent.v[ "exploder_type" ] = exploder.targetname;
        }
        else
        {
            ent.v[ "exploder_type" ] = "normal";
        }
        
        if ( isdefined( exploder.masked_exploder ) )
        {
            ent.v[ "masked_exploder" ] = exploder.model;
            ent.v[ "masked_exploder_spawnflags" ] = exploder.spawnflags;
            ent.v[ "masked_exploder_script_disconnectpaths" ] = exploder.script_disconnectpaths;
            exploder delete();
        }
        
        ent scripts\common\createfx::post_entity_creation_function();
        explodername = ent.v[ "exploder" ];
        
        if ( !isdefined( level.exploders[ explodername ] ) )
        {
            level.exploders[ explodername ] = [];
        }
        
        level.exploders[ explodername ][ level.exploders[ explodername ].size ] = ent;
    }
    
    level.init_exploders = undefined;
    
    /#
        level thread function_6538f332fa49ccda();
    #/
}

// Namespace exploder / scripts\common\exploder
// Params 2
// Checksum 0x0, Offset: 0xd99
// Size: 0xc9
function exploder_flag_wait( msg, exploderarray )
{
    if ( !flag_exist( msg ) )
    {
        flag_init( msg );
    }
    
    flag_wait( msg );
    
    foreach ( exploderstr in exploderarray )
    {
        foreach ( ent in level.createfxexploders[ exploderstr ] )
        {
            ent activate_individual_exploder();
        }
    }
}

// Namespace exploder / scripts\common\exploder
// Params 1
// Checksum 0x0, Offset: 0xe6a
// Size: 0x2c, Type: bool
function exploder_is_damaged_model( ent )
{
    return isdefined( ent.targetname ) && ent.targetname == "exploder";
}

// Namespace exploder / scripts\common\exploder
// Params 1
// Checksum 0x0, Offset: 0xe9f
// Size: 0x42, Type: bool
function exploder_starts_hidden( ent )
{
    return ent.model == "fx" && ( !isdefined( ent.targetname ) || ent.targetname != "exploderchunk" );
}

// Namespace exploder / scripts\common\exploder
// Params 1
// Checksum 0x0, Offset: 0xeea
// Size: 0x2c, Type: bool
function exploder_is_chunk( ent )
{
    return isdefined( ent.targetname ) && ent.targetname == "exploderchunk";
}

// Namespace exploder / scripts\common\exploder
// Params 1
// Checksum 0x0, Offset: 0xf1f
// Size: 0xf3
function show_exploder_models_proc( num )
{
    num += "";
    exploders = get_exploders();
    
    if ( isdefined( exploders ) )
    {
        foreach ( ent in exploders )
        {
            if ( isstruct( ent.model ) )
            {
                continue;
            }
            
            if ( !exploder_starts_hidden( ent.model ) && !exploder_is_damaged_model( ent.model ) && !exploder_is_chunk( ent.model ) )
            {
                ent.model show();
            }
            
            if ( isdefined( ent.brush_shown ) )
            {
                ent.model show();
            }
        }
    }
}

// Namespace exploder / scripts\common\exploder
// Params 1
// Checksum 0x0, Offset: 0x101a
// Size: 0xae
function get_exploders( str )
{
    exploders = [];
    
    if ( level.createfx_enabled )
    {
        exploders = get_createfx_exploders( str );
    }
    else if ( isdefined( level.createfxexploders[ str ] ) )
    {
        exploders = level.createfxexploders[ str ];
    }
    
    if ( isdefined( level.exploders[ str ] ) )
    {
        foreach ( exploder in level.exploders[ str ] )
        {
            exploders[ exploders.size ] = exploder;
        }
    }
    
    return exploders;
}

// Namespace exploder / scripts\common\exploder
// Params 1
// Checksum 0x0, Offset: 0x10d1
// Size: 0xd9
function get_createfx_exploders( str )
{
    /#
        array = [];
        
        foreach ( ent in level.createfxent )
        {
            if ( !isdefined( ent ) )
            {
                continue;
            }
            
            if ( ent.v[ "<dev string:x4e>" ] != "<dev string:x56>" )
            {
                continue;
            }
            
            if ( !isdefined( ent.v[ "<dev string:x56>" ] ) )
            {
                continue;
            }
            
            if ( isdefined( str ) && ent.v[ "<dev string:x56>" ] + "<dev string:x62>" != str )
            {
                continue;
            }
            
            array[ array.size ] = ent;
        }
        
        if ( array.size == 0 )
        {
            array = undefined;
        }
        
        return array;
    #/
}

// Namespace exploder / scripts\common\exploder
// Params 3
// Checksum 0x0, Offset: 0x11b2
// Size: 0x107
function stop_exploder_proc( num, players, bkill )
{
    num += "";
    var_1c5e2f2d32a97f95 = 0;
    exploders = get_exploders( num );
    
    if ( isdefined( exploders ) )
    {
        foreach ( ent in exploders )
        {
            if ( !isdefined( ent.looper ) )
            {
                continue;
            }
            
            if ( isdefined( ent.loopsound_ent ) )
            {
                ent.loopsound_ent stoploopsound();
                ent.loopsound_ent delete();
            }
            
            ent.looper delete();
            var_1c5e2f2d32a97f95 = 1;
        }
    }
    
    if ( !shouldrunserversideeffects() && ( havemapentseffects() || !var_1c5e2f2d32a97f95 ) )
    {
        stop_clientside_exploder( num, players, bkill );
    }
}

// Namespace exploder / scripts\common\exploder
// Params 3
// Checksum 0x0, Offset: 0x12c1
// Size: 0x69
function stop_clientside_exploder( explodername, players, bkill )
{
    if ( havemapentseffects() )
    {
        stopclientexploder( explodername, players, bkill );
        return;
    }
    
    if ( !is_valid_clientside_exploder_name( explodername ) )
    {
        println( "<dev string:x66>" + explodername + "<dev string:x83>" );
        return;
    }
    
    exploder_num = int( explodername );
    stopclientexploder( exploder_num, players, bkill );
}

// Namespace exploder / scripts\common\exploder
// Params 1
// Checksum 0x0, Offset: 0x1332
// Size: 0x3b
function get_exploder_array_proc( msg )
{
    msg += "";
    array = [];
    exploders = get_exploders( msg );
    
    if ( isdefined( exploders ) )
    {
        array = exploders;
    }
    
    return array;
}

// Namespace exploder / scripts\common\exploder
// Params 1
// Checksum 0x0, Offset: 0x1376
// Size: 0xa4
function hide_exploder_models_proc( num )
{
    num += "";
    exploders = get_exploders( num );
    
    if ( isdefined( exploders ) )
    {
        foreach ( ent in exploders )
        {
            if ( isstruct( ent.model ) )
            {
                continue;
            }
            
            if ( isdefined( ent.model ) )
            {
                ent.model hide();
            }
        }
    }
}

// Namespace exploder / scripts\common\exploder
// Params 1
// Checksum 0x0, Offset: 0x1422
// Size: 0xae
function delete_exploder_proc( num )
{
    num += "";
    exploders = get_exploders( num );
    
    if ( isdefined( exploders ) )
    {
        foreach ( ent in exploders )
        {
            if ( isstruct( ent.model ) )
            {
                continue;
            }
            
            if ( isdefined( ent.model ) )
            {
                ent.model delete();
            }
        }
    }
    
    level notify( "killexplodertridgers" + num );
}

// Namespace exploder / scripts\common\exploder
// Params 0
// Checksum 0x0, Offset: 0x14d8
// Size: 0x115
function exploder_damage()
{
    if ( isdefined( self.v[ "delay" ] ) )
    {
        delay = self.v[ "delay" ];
    }
    else
    {
        delay = 0;
    }
    
    if ( isdefined( self.v[ "damage_radius" ] ) )
    {
        radius = self.v[ "damage_radius" ];
    }
    else
    {
        radius = 128;
    }
    
    damage = self.v[ "damage" ];
    origin = self.v[ "origin" ];
    
    if ( isdefined( self.v[ "envonly" ] ) )
    {
        envonly = self.v[ "envonly" ];
    }
    else
    {
        envonly = 0;
    }
    
    if ( isdefined( self.v[ "dotraces" ] ) )
    {
        dotraces = self.v[ "dotraces" ];
    }
    else
    {
        dotraces = 1;
    }
    
    wait delay;
    radiusdamage( origin, radius, damage, damage, undefined, "MOD_EXPLOSIVE", undefined, envonly, dotraces );
}

// Namespace exploder / scripts\common\exploder
// Params 0
// Checksum 0x0, Offset: 0x15f5
// Size: 0x174
function activate_individual_exploder_proc()
{
    if ( isdefined( self.v[ "firefx" ] ) )
    {
        thread fire_effect();
    }
    
    if ( isdefined( self.v[ "fxid" ] ) && self.v[ "fxid" ] != "No FX" )
    {
        thread cannon_effect();
    }
    else if ( isdefined( self.v[ "soundalias" ] ) && self.v[ "soundalias" ] != "nil" )
    {
        thread sound_effect();
    }
    
    if ( isdefined( self.v[ "loopsound" ] ) && self.v[ "loopsound" ] != "nil" )
    {
        thread effect_loopsound();
    }
    
    if ( isdefined( self.v[ "damage" ] ) )
    {
        thread exploder_damage();
    }
    
    if ( isdefined( self.v[ "earthquake" ] ) )
    {
        thread exploder_earthquake();
    }
    
    if ( isdefined( self.v[ "rumble" ] ) )
    {
        thread exploder_rumble();
    }
    
    if ( self.v[ "exploder_type" ] == "exploder" )
    {
        thread brush_show();
        return;
    }
    
    if ( self.v[ "exploder_type" ] == "exploderchunk" || self.v[ "exploder_type" ] == "exploderchunk visible" )
    {
        thread brush_throw();
        return;
    }
    
    thread brush_delete();
}

// Namespace exploder / scripts\common\exploder
// Params 0
// Checksum 0x0, Offset: 0x1771
// Size: 0x175
function brush_delete()
{
    num = self.v[ "exploder" ];
    
    if ( isdefined( self.v[ "delay" ] ) )
    {
        wait self.v[ "delay" ];
    }
    else
    {
        waitframe();
    }
    
    if ( !isdefined( self.model ) )
    {
        return;
    }
    
    if ( isstruct( self.model ) )
    {
        return;
    }
    
    if ( utility::issp() && isdefined( self.model.classname ) )
    {
        if ( self.model.spawnflags & 1 )
        {
            self.model builtin [[ level.func[ "connectPaths" ] ]]();
        }
    }
    
    if ( level.createfx_enabled )
    {
        if ( isdefined( self.exploded ) )
        {
            return;
        }
        
        self.exploded = 1;
        self.model hide();
        self.model notsolid();
        wait 3;
        self.exploded = undefined;
        self.model show();
        self.model solid();
        return;
    }
    
    if ( !isdefined( self.v[ "fxid" ] ) || self.v[ "fxid" ] == "No FX" )
    {
        self.v[ "exploder" ] = undefined;
    }
    
    waittillframeend();
    self.model delete();
}

// Namespace exploder / scripts\common\exploder
// Params 0
// Checksum 0x0, Offset: 0x18ee
// Size: 0x28a
function brush_throw()
{
    if ( isdefined( self.v[ "delay" ] ) )
    {
        wait self.v[ "delay" ];
    }
    
    ent = undefined;
    
    if ( isdefined( self.v[ "target" ] ) )
    {
        ent = get_target_ent( self.v[ "target" ] );
    }
    
    if ( !isdefined( ent ) )
    {
        self.model delete();
        return;
    }
    
    self.model show();
    
    if ( isdefined( self.v[ "delay_post" ] ) )
    {
        wait self.v[ "delay_post" ];
    }
    
    startorg = self.v[ "origin" ];
    startang = self.v[ "angles" ];
    org = ent.origin;
    physics = isdefined( self.v[ "physics" ] );
    
    if ( physics )
    {
        target = undefined;
        
        if ( isdefined( ent.target ) )
        {
            target = ent get_target_ent();
        }
        
        if ( isdefined( target ) )
        {
            contact_point = ent.origin;
            throw_vec = vectornormalize( target.origin - ent.origin );
        }
        else
        {
            contact_point = self.model.origin;
            throw_vec = vectornormalize( org - self.model.origin );
        }
        
        throw_vec *= self.v[ "physics" ];
        self.model physicslaunchserver( contact_point, throw_vec );
        return;
    }
    else
    {
        throw_vec = org - self.model.origin;
        self.model rotatevelocity( throw_vec, 12 );
        self.model movegravity( throw_vec, 12 );
    }
    
    if ( level.createfx_enabled )
    {
        if ( isdefined( self.exploded ) )
        {
            return;
        }
        
        self.exploded = 1;
        wait 3;
        self.exploded = undefined;
        self.v[ "origin" ] = startorg;
        self.v[ "angles" ] = startang;
        self.model hide();
        return;
    }
    
    self.v[ "exploder" ] = undefined;
    wait 6;
    self.model delete();
}

// Namespace exploder / scripts\common\exploder
// Params 0
// Checksum 0x0, Offset: 0x1b80
// Size: 0x1fe
function brush_show()
{
    if ( isdefined( self.v[ "delay" ] ) )
    {
        wait self.v[ "delay" ];
    }
    
    assert( isdefined( self.model ) );
    is_struct = 0;
    structmodel = undefined;
    
    if ( !isdefined( self.model.script_modelname ) )
    {
        self.model show();
        self.model solid();
    }
    else
    {
        is_struct = 1;
        structmodel = spawn( "script_model", self.model.origin );
        structmodel.angles = self.model.angles;
        structmodel setmodel( self.model.script_modelname );
        
        if ( isdefined( self.model.script_linkname ) )
        {
            structmodel.script_linkname = self.model.script_linkname;
        }
    }
    
    self.brush_shown = 1;
    
    if ( !is_struct && utility::issp() && self.model.spawnflags & 1 )
    {
        if ( !isdefined( self.model.disconnect_paths ) )
        {
            self.model builtin [[ level.func[ "connectPaths" ] ]]();
        }
        else
        {
            self.model builtin [[ level.func[ "disconnectPaths" ] ]]();
        }
    }
    
    if ( level.createfx_enabled )
    {
        if ( isdefined( self.exploded ) )
        {
            return;
        }
        
        self.exploded = 1;
        wait 3;
        self.exploded = undefined;
        
        if ( !is_struct )
        {
            self.model hide();
            self.model notsolid();
            return;
        }
        
        structmodel delete();
    }
}

// Namespace exploder / scripts\common\exploder
// Params 0
// Checksum 0x0, Offset: 0x1d86
// Size: 0x31
function exploder_rumble()
{
    if ( !issp() )
    {
        return;
    }
    
    exploder_delay();
    level.player playrumbleonentity( self.v[ "rumble" ] );
}

// Namespace exploder / scripts\common\exploder
// Params 0
// Checksum 0x0, Offset: 0x1dbf
// Size: 0xb6
function exploder_delay()
{
    if ( !isdefined( self.v[ "delay" ] ) )
    {
        self.v[ "delay" ] = 0;
    }
    
    min_delay = self.v[ "delay" ];
    max_delay = self.v[ "delay" ] + 0.001;
    
    if ( isdefined( self.v[ "delay_min" ] ) )
    {
        min_delay = self.v[ "delay_min" ];
    }
    
    if ( isdefined( self.v[ "delay_max" ] ) )
    {
        max_delay = self.v[ "delay_max" ];
    }
    
    if ( min_delay > 0 )
    {
        wait randomfloatrange( min_delay, max_delay );
    }
}

// Namespace exploder / scripts\common\exploder
// Params 0
// Checksum 0x0, Offset: 0x1e7d
// Size: 0x79
function effect_loopsound()
{
    if ( isdefined( self.loopsound_ent ) )
    {
        self.loopsound_ent stoploopsound();
        self.loopsound_ent delete();
    }
    
    origin = self.v[ "origin" ];
    alias = self.v[ "loopsound" ];
    exploder_delay();
    self.loopsound_ent = play_loopsound_in_space( alias, origin );
}

// Namespace exploder / scripts\common\exploder
// Params 0
// Checksum 0x0, Offset: 0x1efe
// Size: 0x9
function sound_effect()
{
    effect_soundalias();
}

// Namespace exploder / scripts\common\exploder
// Params 0
// Checksum 0x0, Offset: 0x1f0f
// Size: 0x46
function effect_soundalias()
{
    origin = self.v[ "origin" ];
    alias = self.v[ "soundalias" ];
    exploder_delay();
    play_sound_in_space( alias, origin );
}

// Namespace exploder / scripts\common\exploder
// Params 0
// Checksum 0x0, Offset: 0x1f5d
// Size: 0x2e
function exploder_earthquake()
{
    exploder_delay();
    do_earthquake( self.v[ "earthquake" ], self.v[ "origin" ] );
}

// Namespace exploder / scripts\common\exploder
// Params 0
// Checksum 0x0, Offset: 0x1f93
// Size: 0x55
function exploder_playsound()
{
    if ( !isdefined( self.v[ "soundalias" ] ) || self.v[ "soundalias" ] == "nil" )
    {
        return;
    }
    
    play_sound_in_space( self.v[ "soundalias" ], self.v[ "origin" ] );
}

// Namespace exploder / scripts\common\exploder
// Params 0
// Checksum 0x0, Offset: 0x1ff0
// Size: 0x120
function fire_effect()
{
    forward = self.v[ "forward" ];
    up = self.v[ "up" ];
    org = undefined;
    firefxsound = self.v[ "firefxsound" ];
    origin = self.v[ "origin" ];
    firefx = self.v[ "firefx" ];
    ender = self.v[ "ender" ];
    
    if ( !isdefined( ender ) )
    {
        ender = "createfx_effectStopper";
    }
    
    firefxdelay = 0.5;
    
    if ( isdefined( self.v[ "firefxdelay" ] ) )
    {
        firefxdelay = self.v[ "firefxdelay" ];
    }
    
    exploder_delay();
    
    if ( isdefined( firefxsound ) )
    {
        loop_fx_sound( firefxsound, origin, 1, ender );
    }
    
    playfx( level._effect[ firefx ], self.v[ "origin" ], forward, up );
}

// Namespace exploder / scripts\common\exploder
// Params 0
// Checksum 0x0, Offset: 0x2118
// Size: 0x121
function cannon_effect()
{
    if ( isdefined( self.v[ "repeat" ] ) )
    {
        thread exploder_playsound();
        
        for ( i = 0; i < self.v[ "repeat" ] ; i++ )
        {
            playfx( level._effect[ self.v[ "fxid" ] ], self.v[ "origin" ], self.v[ "forward" ], self.v[ "up" ] );
            exploder_delay();
        }
        
        return;
    }
    
    exploder_delay();
    
    if ( isdefined( self.looper ) )
    {
        self.looper delete();
    }
    
    self.looper = spawnfx( getfx( self.v[ "fxid" ] ), self.v[ "origin" ], self.v[ "forward" ], self.v[ "up" ] );
    triggerfx( self.looper );
    exploder_playsound();
}

/#

    // Namespace exploder / scripts\common\exploder
    // Params 0
    // Checksum 0x0, Offset: 0x2241
    // Size: 0x190, Type: dev
    function function_6538f332fa49ccda()
    {
        level endon( "<dev string:xab>" );
        
        while ( true )
        {
            level waittill( "<dev string:xb9>", origin, delay, damageamount, damageradius, dotraces, envonly, earthquakename, rumblename );
            ent = spawnstruct();
            ent.v = [];
            ent.v[ "<dev string:x56>" ] = 0;
            ent.v[ "<dev string:xc9>" ] = origin;
            ent.v[ "<dev string:xd3>" ] = ( 0, 0, 0 );
            ent.v[ "<dev string:xdd>" ] = delay;
            ent.v[ "<dev string:xea>" ] = damageamount;
            ent.v[ "<dev string:xf4>" ] = damageradius;
            ent.v[ "<dev string:x105>" ] = dotraces;
            ent.v[ "<dev string:x111>" ] = envonly;
            ent.v[ "<dev string:x11c>" ] = "<dev string:x12d>";
            
            if ( isdefined( earthquakename ) && earthquakename.size > 0 )
            {
                ent.v[ "<dev string:x137>" ] = earthquakename;
            }
            
            if ( isdefined( rumblename ) && rumblename.size > 0 )
            {
                ent.v[ "<dev string:x145>" ] = rumblename;
            }
            
            ent activate_individual_exploder_proc();
        }
    }

#/

// Namespace exploder / scripts\common\exploder
// Params 3
// Checksum 0x0, Offset: 0x23d9
// Size: 0xc6
function activate_exploder( num, players, starttime )
{
    num += "";
    level notify( "exploding_" + num );
    var_1c5e2f2d32a97f95 = 0;
    exploders = get_exploders( num );
    
    if ( isdefined( exploders ) )
    {
        foreach ( ent in exploders )
        {
            ent activate_individual_exploder();
            var_1c5e2f2d32a97f95 = 1;
        }
    }
    
    if ( !shouldrunserversideeffects() && ( havemapentseffects() || !var_1c5e2f2d32a97f95 ) )
    {
        activate_clientside_exploder( num, players, starttime );
    }
}

// Namespace exploder / scripts\common\exploder
// Params 3
// Checksum 0x0, Offset: 0x24a7
// Size: 0x69
function activate_clientside_exploder( explodername, players, starttime )
{
    if ( havemapentseffects() )
    {
        activateclientexploder( explodername, players, starttime );
        return;
    }
    
    if ( !is_valid_clientside_exploder_name( explodername ) )
    {
        println( "<dev string:x66>" + explodername + "<dev string:x83>" );
        return;
    }
    
    exploder_num = int( explodername );
    activateclientexploder( exploder_num, players, starttime );
}

// Namespace exploder / scripts\common\exploder
// Params 1
// Checksum 0x0, Offset: 0x2518
// Size: 0x46, Type: bool
function is_valid_clientside_exploder_name( explodername )
{
    if ( !isdefined( explodername ) )
    {
        return false;
    }
    
    exploder_num = explodername;
    
    if ( isstring( explodername ) )
    {
        exploder_num = int( explodername );
        
        if ( exploder_num == 0 && explodername != "0" )
        {
            return false;
        }
    }
    
    return exploder_num >= 0;
}

// Namespace exploder / scripts\common\exploder
// Params 0
// Checksum 0x0, Offset: 0x2567
// Size: 0x52
function shouldrunserversideeffects()
{
    if ( utility::issp() && !havemapentseffects() )
    {
        return 1;
    }
    
    if ( !isdefined( level.createfx_enabled ) )
    {
        set_createfx_enabled();
    }
    
    if ( level.createfx_enabled )
    {
        return 1;
    }
    
    return getdvar( @"clientsideeffects" ) != "1";
}

// Namespace exploder / scripts\common\exploder
// Params 3
// Checksum 0x0, Offset: 0x25c1
// Size: 0x27
function exploder_before_load( num, players, starttime )
{
    waittillframeend();
    waittillframeend();
    activate_exploder( num, players, starttime );
}

// Namespace exploder / scripts\common\exploder
// Params 3
// Checksum 0x0, Offset: 0x25f0
// Size: 0x25
function exploder_after_load( num, players, starttime )
{
    activate_exploder( num, players, starttime );
}

