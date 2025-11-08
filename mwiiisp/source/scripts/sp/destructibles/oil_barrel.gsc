#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\destructibles\barrel_common;
#using scripts\sp\utility;

#namespace oil_barrel;

// Namespace oil_barrel / scripts\sp\destructibles\oil_barrel
// Params 0
// Checksum 0x0, Offset: 0x263
// Size: 0x91
function oil_barrel_init()
{
    level.g_effect[ "oil_barrel_impact" ] = loadfx( "vfx/iw8/prop/scriptables/shared/vfx_imp_oil_stream.vfx" );
    level.g_effect[ "oil_barrel_death" ] = loadfx( "vfx/iw8/prop/scriptables/vfx_oil_drum_big_01_s3.vfx" );
    barrels = oil_get_barrels();
    
    foreach ( barrel in barrels )
    {
        barrel thread oil_barrel();
    }
}

// Namespace oil_barrel / scripts\sp\destructibles\oil_barrel
// Params 0
// Checksum 0x0, Offset: 0x2fc
// Size: 0x11
function oil_get_barrels()
{
    return getentarray( "dyn_oil_barrel", "targetname" );
}

// Namespace oil_barrel / scripts\sp\destructibles\oil_barrel
// Params 0
// Checksum 0x0, Offset: 0x316
// Size: 0x209
function oil_barrel()
{
    self endon( "barrel_death" );
    self endon( "barrel_delete" );
    barrel_setup( "oil", 450, 250, 9100, 15000, 80, 28 );
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
        var_b9bb95fbc1d74650 = spawn( "script_origin", point );
        var_b9bb95fbc1d74650 linkto( self );
        self notify( "new_spew", tag );
        playfxontag( level.g_effect[ "oil_barrel_impact" ], tag, "tag_origin" );
        tag playsound( "dst_oil_barrel_puncture_stream_start" );
        var_b9bb95fbc1d74650 scalevolume( 0, 0 );
        var_b9bb95fbc1d74650 playloopsound( "dst_oil_barrel_puncture_stream_lp" );
        var_b9bb95fbc1d74650 scalevolume( 1, 0.25 );
        var_b9bb95fbc1d74650 thread sfx_stop_oil_barrel_stream();
        self.spewtags = array_add( self.spewtags, tag );
        thread oilimpactlife( tag );
    }
}

// Namespace oil_barrel / scripts\sp\destructibles\oil_barrel
// Params 4
// Checksum 0x0, Offset: 0x527
// Size: 0x8c, Type: bool
function oilbarrelshoulddie( amount, attacker, type, objweapon )
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

// Namespace oil_barrel / scripts\sp\destructibles\oil_barrel
// Params 1
// Checksum 0x0, Offset: 0x5bc
// Size: 0x3e
function oilimpactlife( spewtag )
{
    waittill_notify_or_timeout( "entitydeleted", 5 );
    
    if ( isdefined( self ) )
    {
        self.spewtags = array_remove( self.spewtags, spewtag );
    }
    
    spewtag delete();
}

// Namespace oil_barrel / scripts\sp\destructibles\oil_barrel
// Params 0
// Checksum 0x0, Offset: 0x602
// Size: 0xb4
function oil_barrel_death()
{
    self notify( "barrel_death" );
    
    if ( isdefined( self ) )
    {
        self hide();
    }
    
    playfx( level.g_effect[ "oil_barrel_death" ], self.origin );
    
    foreach ( element in self.spewtags )
    {
        killfxontag( level.g_effect[ "oil_barrel_impact" ], element, "tag_origin" );
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

// Namespace oil_barrel / scripts\sp\destructibles\oil_barrel
// Params 1
// Checksum 0x0, Offset: 0x6be
// Size: 0x19
function delay_delete( time )
{
    wait time;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace oil_barrel / scripts\sp\destructibles\oil_barrel
// Params 0
// Checksum 0x0, Offset: 0x6df
// Size: 0x46
function sfx_stop_oil_barrel_stream()
{
    wait 3.3;
    fadeoutduration = 0.25;
    self playsound( "dst_oil_barrel_puncture_stream_stop" );
    self scalevolume( 0, fadeoutduration );
    wait 0.3;
    self stoploopsound( "dst_oil_barrel_puncture_stream_lp" );
    self delete();
}

