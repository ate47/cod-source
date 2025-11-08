#using script_4c543f01345a2c04;
#using script_6de180c937bb3129;
#using script_7edf952f8921aa6b;
#using script_da0dce9d411d119;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\utility;

#namespace zombie_entity;

// Namespace zombie_entity / scripts\aitypes\zombie_entity\zombie_entity_metabones
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x10e
// Size: 0x20
function autoexec main()
{
    var_601bcee5d276f46d = "zombie_entity";
    function_d6736c5ef5ac2990( var_601bcee5d276f46d, &function_3d588dcd552b26db );
}

/#

    // Namespace zombie_entity / scripts\aitypes\zombie_entity\zombie_entity_metabones
    // Params 0
    // Checksum 0x0, Offset: 0x136
    // Size: 0x1d, Type: dev
    function init_metabones()
    {
        setdvarifuninitialized( @"hash_9dd191a7e11820fd", 0 );
        thread function_995a6309e572cf14();
    }

#/

// Namespace zombie_entity / scripts\aitypes\zombie_entity\zombie_entity_metabones
// Params 1
// Checksum 0x0, Offset: 0x15b
// Size: 0x129
function function_3d588dcd552b26db( params )
{
    metabone_name = params.metabone_name;
    index = function_f83b17b2b8d7a76d( metabone_name );
    
    if ( index == -1 )
    {
        return;
    }
    
    name = metabone_name + "_weakpoint";
    utility::function_3677f2be30fdd581( name, "destroyed" );
    self.entitydata.var_21544f0d5a3ef4d2 -= 1;
    self.entitydata.weakpoints[ index ].state = "destroyed";
    
    if ( self.entitydata.var_21544f0d5a3ef4d2 <= 0 )
    {
        if ( self.entitydata.phase != "phase2vul" )
        {
            function_f40c1634cd048cda( 2 );
        }
        else
        {
            function_f40c1634cd048cda( 3 );
        }
        
        if ( function_1017131041e2a7b() )
        {
            self.entitydata.desiredstate = 1;
            self.var_e198ad98b4845f29.reason = "weakpoint";
        }
    }
}

/#

    // Namespace zombie_entity / scripts\aitypes\zombie_entity\zombie_entity_metabones
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x28c
    // Size: 0x111, Type: dev
    function private function_995a6309e572cf14()
    {
        self endon( "<dev string:x1c>" );
        
        while ( true )
        {
            metabones_def = function_97fd256a244527b4( self.metabones.bundle_name );
            
            foreach ( metabone in metabones_def.metabones )
            {
                foreach ( tag in metabone.tags )
                {
                    is_active = function_6db512214e7e7009( metabone.name + "<dev string:x25>" );
                    draw_tag( tag.tagname, tag.radius, is_active );
                }
            }
            
            waitframe();
        }
    }

    // Namespace zombie_entity / scripts\aitypes\zombie_entity\zombie_entity_metabones
    // Params 3, eflags: 0x4
    // Checksum 0x0, Offset: 0x3a5
    // Size: 0x6d, Type: dev
    function private draw_tag( tagname, tag_radius, is_active )
    {
        TAG_ORIGIN = self gettagorigin( tagname );
        tag_angles = self gettagangles( tagname );
        function_ad6307798215e0be( tagname + "<dev string:x33>" + tag_angles[ 0 ] + "<dev string:x3a>" + tag_angles[ 1 ] + "<dev string:x3a>" + tag_angles[ 2 ], TAG_ORIGIN, tag_radius, is_active );
    }

    // Namespace zombie_entity / scripts\aitypes\zombie_entity\zombie_entity_metabones
    // Params 4, eflags: 0x4
    // Checksum 0x0, Offset: 0x41a
    // Size: 0xc3, Type: dev
    function private function_ad6307798215e0be( text, pos, radius, is_active )
    {
        debug_val = getdvarint( @"hash_9dd191a7e11820fd", 0 );
        
        if ( debug_val > 0 )
        {
            pos = default_to( pos, self.origin + ( 0, 0, 70 ) );
            color = ( 1, 0, 0 );
            
            if ( is_active )
            {
                color = ( 0, 1, 0 );
            }
            
            var_db334a0ef5cf7571 = debug_val == 1;
            
            if ( !var_db334a0ef5cf7571 )
            {
                var_db334a0ef5cf7571 = is_active;
            }
            
            if ( var_db334a0ef5cf7571 )
            {
                print3d( pos, "<dev string:x3f>" + text, color );
                sphere( pos, radius, color );
            }
        }
    }

#/
