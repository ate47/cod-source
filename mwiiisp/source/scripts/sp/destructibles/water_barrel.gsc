#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\destructibles\barrel_common;
#using scripts\sp\utility;

#namespace water_barrel;

// Namespace water_barrel / scripts\sp\destructibles\water_barrel
// Params 0
// Checksum 0x0, Offset: 0x286
// Size: 0x9a
function water_barrel_init()
{
    level.g_effect[ "water_barrel_impact" ] = loadfx( "vfx/iw8/prop/scriptables/shared/vfx_imp_water_stream.vfx" );
    level.g_effect[ "water_barrel_death" ] = loadfx( "vfx/iw8/prop/scriptables/vfx_container_barrel_plastic_01_closed_s3.vfx" );
    barrels = getentarray( "dyn_water_barrel", "targetname" );
    
    foreach ( barrel in barrels )
    {
        barrel thread water_barrel();
    }
}

// Namespace water_barrel / scripts\sp\destructibles\water_barrel
// Params 0
// Checksum 0x0, Offset: 0x328
// Size: 0x20a
function water_barrel()
{
    self endon( "barrel_death" );
    self endon( "barrel_delete" );
    barrel_setup( "water", 450, 250, 9100, 15000, 80, 28 );
    self.health = 9450;
    
    while ( true )
    {
        self waittill( "damage", amount, attacker, direction_vec, point, type, modelname, tagname, partname, dflags, objweapon );
        
        if ( !isvalidbarreldamage( attacker, type ) )
        {
            continue;
        }
        
        if ( !isdefined( type ) )
        {
            continue;
        }
        
        if ( self.spewtags.size >= 4 )
        {
            continue;
        }
        
        stringarray = strtok( type, "_" );
        
        if ( !array_contains( stringarray, "BULLET" ) )
        {
            continue;
        }
        
        tag = spawn_tag_origin( point );
        vec = vectornormalize( self.origin - point );
        tagangles = vectortoangles( vec * -1 );
        tag.angles = flat_angle( tagangles );
        tag linkto( self );
        var_8fa3eff296e11c79 = spawn( "script_origin", point );
        var_8fa3eff296e11c79 linkto( self );
        self notify( "new_spew", tag );
        playfxontag( level.g_effect[ "water_barrel_impact" ], tag, "tag_origin" );
        tag playsound( "dst_water_barrel_puncture_stream_start" );
        var_8fa3eff296e11c79 scalevolume( 0, 0 );
        var_8fa3eff296e11c79 playloopsound( "dst_water_barrel_puncture_stream_lp" );
        var_8fa3eff296e11c79 scalevolume( 1, 0.25 );
        var_8fa3eff296e11c79 thread sfx_stop_water_barrel_stream( tag );
        self.spewtags = array_add( self.spewtags, tag );
        thread waterimpactlife( tag );
    }
}

// Namespace water_barrel / scripts\sp\destructibles\water_barrel
// Params 4
// Checksum 0x0, Offset: 0x53a
// Size: 0x8c, Type: bool
function waterbarrelshoulddie( amount, attacker, type, objweapon )
{
    if ( isdefined( amount ) && amount < 100 )
    {
        return false;
    }
    
    if ( isdefined( type ) )
    {
        switch ( type )
        {
            case #"hash_3c20f39c73a1422b":
            case #"hash_571e46e17a3cf2e3":
            case #"hash_66cb246f3e55fbe2":
            case #"hash_6df135435752c406":
            case #"hash_a911a1880d996edb":
            case #"hash_c22b13f81bed11f0":
                return true;
        }
    }
    
    return false;
}

// Namespace water_barrel / scripts\sp\destructibles\water_barrel
// Params 1
// Checksum 0x0, Offset: 0x5cf
// Size: 0x3e
function waterimpactlife( spewtag )
{
    waittill_notify_or_timeout( "entitydeleted", 5 );
    
    if ( isdefined( self ) )
    {
        self.spewtags = array_remove( self.spewtags, spewtag );
    }
    
    spewtag delete();
}

// Namespace water_barrel / scripts\sp\destructibles\water_barrel
// Params 0
// Checksum 0x0, Offset: 0x615
// Size: 0xb4
function water_barrel_death()
{
    self notify( "barrel_death" );
    
    if ( isdefined( self ) )
    {
        self hide();
    }
    
    playfx( level.g_effect[ "water_barrel_death" ], self.origin );
    
    foreach ( element in self.spewtags )
    {
        killfxontag( level.g_effect[ "water_barrel_impact" ], element, "tag_origin" );
        waitframe();
        
        if ( isdefined( element ) )
        {
            element delete();
        }
    }
    
    if ( isdefined( self ) )
    {
        thread delay_delete( 5 );
    }
}

// Namespace water_barrel / scripts\sp\destructibles\water_barrel
// Params 1
// Checksum 0x0, Offset: 0x6d1
// Size: 0x19
function delay_delete( time )
{
    wait time;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace water_barrel / scripts\sp\destructibles\water_barrel
// Params 1
// Checksum 0x0, Offset: 0x6f2
// Size: 0x4f
function sfx_stop_water_barrel_stream( tag )
{
    wait 3.5;
    fadeoutduration = 0.25;
    tag playsound( "dst_water_barrel_puncture_stream_stop" );
    self scalevolume( 0, fadeoutduration );
    wait 0.3;
    self stoploopsound( "dst_water_barrel_puncture_stream_lp" );
    self delete();
}

