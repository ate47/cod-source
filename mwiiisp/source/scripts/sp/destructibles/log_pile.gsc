#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\destructibles\barrel_common;
#using scripts\sp\utility;

#namespace log_pile;

// Namespace log_pile / scripts\sp\destructibles\log_pile
// Params 0
// Checksum 0x0, Offset: 0x127
// Size: 0x7c
function function_51b91752c24c4995()
{
    piles = getentarray( "dyn_log_pile", "targetname" );
    
    if ( piles.size <= 0 )
    {
        return;
    }
    
    level.g_effect[ "log_pile_impact" ] = loadfx( "vfx/jup/prop/scriptables/vfx_jup_log_shrapnel_01.vfx" );
    
    for ( i = 0; i < piles.size ; i++ )
    {
        piles[ i ] setcandamage( 1 );
        piles[ i ].spewtags = [];
        piles[ i ] thread log_pile();
    }
}

// Namespace log_pile / scripts\sp\destructibles\log_pile
// Params 0
// Checksum 0x0, Offset: 0x1ab
// Size: 0x17e
function log_pile()
{
    self endon( "entitydeleted" );
    
    while ( true )
    {
        self waittill( "damage", amount, attacker, direction_vec, point, type, modelname, tagname, partname, dflags, objweapon );
        
        if ( !isdefined( type ) )
        {
            continue;
        }
        
        if ( ismeleedamage( type ) )
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
        self notify( "new_spew", tag );
        playfxontag( level.g_effect[ "log_pile_impact" ], tag, "tag_origin" );
        self.spewtags = array_add( self.spewtags, tag );
        thread function_3289f7ed667e369c( tag );
    }
}

// Namespace log_pile / scripts\sp\destructibles\log_pile
// Params 1
// Checksum 0x0, Offset: 0x331
// Size: 0x3e
function function_3289f7ed667e369c( spewtag )
{
    waittill_notify_or_timeout( "entitydeleted", 5 );
    
    if ( isdefined( self ) )
    {
        self.spewtags = array_remove( self.spewtags, spewtag );
    }
    
    spewtag delete();
}

