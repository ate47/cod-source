#using script_5d813d45c6b1b1be;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_a5e891e44109f8db;

// Namespace namespace_a5e891e44109f8db / namespace_e9b0ed286e0145cc
// Params 1
// Checksum 0x0, Offset: 0x131
// Size: 0x10e
function init( var_5179c48492d1d2c2 )
{
    function_efabc5ae0422de9e( var_5179c48492d1d2c2 );
    var_5179c48492d1d2c2.triggers = [];
    var_5179c48492d1d2c2.participants = [];
    structs = getstructarray( var_5179c48492d1d2c2.target, "targetname" );
    
    foreach ( struct in structs )
    {
        var_5179c48492d1d2c2.triggers = array_add( var_5179c48492d1d2c2.triggers, namespace_8eedd8f6cf5d9f19::function_698513ab21b7913d( struct ) );
    }
    
    foreach ( trigger in var_5179c48492d1d2c2.triggers )
    {
        thread function_b8af89d13c8c2c23( var_5179c48492d1d2c2, trigger );
    }
}

// Namespace namespace_a5e891e44109f8db / namespace_e9b0ed286e0145cc
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x247
// Size: 0x17a
function private function_b8af89d13c8c2c23( var_5179c48492d1d2c2, trigger_ent )
{
    var_5179c48492d1d2c2 endon( "MRP_NUCLEAR_NOTIFY_SUCCESS" );
    
    while ( true )
    {
        trigger_ent waittill( "trigger", data );
        
        if ( isplayer( data ) && !data isonground() && data isparachuting() )
        {
            /#
                iprintlnbold( "<dev string:x1c>" );
            #/
            
            ent_num = data getentitynumber();
            
            if ( !isdefined( var_5179c48492d1d2c2.participants[ ent_num ] ) )
            {
                var_5179c48492d1d2c2.participants[ ent_num ] = [];
            }
            
            data thread function_6ac96bbbe4d24c6b( var_5179c48492d1d2c2 );
            
            if ( !array_contains( var_5179c48492d1d2c2.participants[ ent_num ], trigger_ent ) )
            {
                var_5179c48492d1d2c2.participants[ ent_num ] = array_add( var_5179c48492d1d2c2.participants[ ent_num ], trigger_ent );
                function_43c810b52ef4956b( data, var_5179c48492d1d2c2.participants[ ent_num ].size );
            }
            
            if ( var_5179c48492d1d2c2.participants[ ent_num ].size >= var_5179c48492d1d2c2.triggers.size )
            {
                function_568b8a57e0fa955f( var_5179c48492d1d2c2, data );
                data thread function_e91b33a3f6f80a68();
                
                foreach ( trigger in var_5179c48492d1d2c2.triggers )
                {
                    trigger delete();
                }
                
                var_5179c48492d1d2c2 notify( "MRP_NUCLEAR_NOTIFY_SUCCESS" );
                return;
            }
        }
    }
}

// Namespace namespace_a5e891e44109f8db / namespace_e9b0ed286e0145cc
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x3c9
// Size: 0x22
function private function_43c810b52ef4956b( player, sound_index )
{
    player playsoundtoplayer( "evt_ob_mrpeeks_stinger_progression_lvl_" + sound_index, player );
}

// Namespace namespace_a5e891e44109f8db / namespace_e9b0ed286e0145cc
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3f3
// Size: 0x30
function private function_6ac96bbbe4d24c6b( var_5179c48492d1d2c2 )
{
    while ( true )
    {
        if ( self isonground() )
        {
            var_5179c48492d1d2c2.participants[ self getentitynumber() ] = undefined;
            return;
        }
        
        waitframe();
    }
}

// Namespace namespace_a5e891e44109f8db / namespace_e9b0ed286e0145cc
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x42b
// Size: 0x1f
function private function_e91b33a3f6f80a68()
{
    while ( !self isonground() )
    {
        waitframe();
    }
    
    namespace_8eedd8f6cf5d9f19::function_a4dfabe55dd4a652( self, undefined, "ob_jup_items_activity_mrp_nuclear_precision", 1 );
}

