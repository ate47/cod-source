#using script_7edf952f8921aa6b;
#using scripts\asm\asm;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\engine\math;
#using scripts\engine\utility;

#namespace zombie_deathworm;

// Namespace zombie_deathworm / namespace_f0730cef8234f036
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x237
// Size: 0x20
function autoexec main()
{
    var_601bcee5d276f46d = "zombie_deathworm";
    function_d6736c5ef5ac2990( var_601bcee5d276f46d, &function_b9f4b7206d76e7ce );
}

// Namespace zombie_deathworm / namespace_f0730cef8234f036
// Params 0
// Checksum 0x0, Offset: 0x25f
// Size: 0x19b
function init_metabones()
{
    function_691c50069ed7c2f7( &function_a826442ad2416fe0 );
    metabones_def = function_97fd256a244527b4( self.metabones.bundle_name );
    function_3d2728c0e2252a1d( "gill_bottom_le", "open" );
    function_3d2728c0e2252a1d( "gill_middle_le", "open" );
    function_3d2728c0e2252a1d( "gill_top_le", "open" );
    function_3d2728c0e2252a1d( "gill_bottom_ri", "open" );
    function_3d2728c0e2252a1d( "gill_middle_ri", "open" );
    function_3d2728c0e2252a1d( "gill_top_ri", "open" );
    self.var_90cec1dffd2daa94 = metabone::function_58b8812944c3f7e8( "gill_bottom_le", "open" );
    self.var_d661c3818c8896d7 = [];
    self.var_d661c3818c8896d7[ 0 ] = metabones_def.var_5840b90f4e873441[ "gill_bottom_le" ].tags[ 0 ].tagname;
    self.var_d661c3818c8896d7[ 1 ] = metabones_def.var_5840b90f4e873441[ "gill_middle_le" ].tags[ 0 ].tagname;
    self.var_d661c3818c8896d7[ 2 ] = metabones_def.var_5840b90f4e873441[ "gill_top_le" ].tags[ 0 ].tagname;
    self.var_68e442281a31d4a2 = [ "bottom", "middle", "top" ];
    self function_3e89eb3d8e3f1811( "can_gill_destroyed_end_time", 0 );
    
    /#
        function_f9d648a2240fdc83();
        thread function_1dbaaec5b9b3ec48();
    #/
}

// Namespace zombie_deathworm / namespace_f0730cef8234f036
// Params 0
// Checksum 0x0, Offset: 0x402
// Size: 0xa3
function function_2af099045fef3cc9()
{
    gills = [ "gill_bottom_le", "gill_middle_le", "gill_top_le", "gill_bottom_ri", "gill_middle_ri", "gill_top_ri" ];
    var_da3d4c1d61ad8198 = [];
    
    foreach ( gill in gills )
    {
        if ( !function_cec565632b7fc419( gill ) )
        {
            var_da3d4c1d61ad8198[ var_da3d4c1d61ad8198.size ] = gill;
        }
    }
    
    return var_da3d4c1d61ad8198;
}

// Namespace zombie_deathworm / namespace_f0730cef8234f036
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4ae
// Size: 0x46c
function private function_a826442ad2416fe0( dmgstruct )
{
    var_4266d23631e69398 = undefined;
    
    if ( dmgstruct.shitloc == "soft" )
    {
        tag_positions = [ self gettagorigin( self.var_d661c3818c8896d7[ 0 ] ), self gettagorigin( self.var_d661c3818c8896d7[ 1 ] ), self gettagorigin( self.var_d661c3818c8896d7[ 2 ] ) ];
        damage_pos = dmgstruct.vpoint;
        var_39033f9289f86348 = 0;
        var_25ca3721a710ca8d = -1;
        
        for ( tag_index = 0; tag_index < tag_positions.size ; tag_index++ )
        {
            dist_sq = distancesquared( damage_pos, tag_positions[ tag_index ] );
            
            if ( var_25ca3721a710ca8d == -1 || dist_sq < var_25ca3721a710ca8d )
            {
                var_39033f9289f86348 = tag_index;
                var_25ca3721a710ca8d = dist_sq;
            }
        }
        
        tag_angles = self gettagangles( self.var_d661c3818c8896d7[ var_39033f9289f86348 ] );
        tag_forward = anglestoforward( tag_angles );
        v_right = anglestoright( tag_angles );
        tag_positions[ var_39033f9289f86348 ] -= tag_forward * getdvarfloat( @"hash_19d1b5077a7fb997", 50 );
        var_2d41c56bfded2945 = damage_pos - tag_positions[ var_39033f9289f86348 ];
        var_8a3284c7a40fe130 = vectordot( tag_forward, var_2d41c56bfded2945 );
        var_52729c4793f5c462 = vectordot( v_right, var_2d41c56bfded2945 );
        var_54327d15562bd3a1 = undefined;
        var_6b6ac322c0340936 = 90;
        
        switch ( var_39033f9289f86348 )
        {
            case 0:
                var_54327d15562bd3a1 = 27;
                break;
            case 1:
                var_54327d15562bd3a1 = 50;
                break;
            case 2:
                var_54327d15562bd3a1 = 85;
                break;
        }
        
        var_e2df91899d6bf44e = 0;
        
        if ( isdefined( dmgstruct.eattacker ) )
        {
            var_e2df91899d6bf44e = distance2d( dmgstruct.eattacker.origin, tag_positions[ var_39033f9289f86348 ] );
            distance_perc = 0;
            var_54327d15562bd3a1 *= 1 - clamp( distance_perc, 0, 1 ) * 0.8;
        }
        
        var_42af6cd244301807 = abs( var_52729c4793f5c462 ) > var_6b6ac322c0340936;
        
        if ( var_42af6cd244301807 )
        {
            var_5b26e71b0c8a7d6 = utility::sign( var_52729c4793f5c462 ) > 0;
            hit_armor = 0;
            var_30fd53b88d65ec90 = self.var_68e442281a31d4a2[ var_39033f9289f86348 ];
            var_efcc55fa67abaded = "gill_" + var_30fd53b88d65ec90 + ( var_5b26e71b0c8a7d6 ? "_ri" : "_le" );
            var_5aafe18394733126 = "plate_" + var_30fd53b88d65ec90 + "_armor" + ( var_5b26e71b0c8a7d6 ? "_ri" : "_le" );
            
            if ( !function_cec565632b7fc419( var_5aafe18394733126 ) )
            {
                if ( var_8a3284c7a40fe130 > var_54327d15562bd3a1 )
                {
                    hit_armor = 1;
                }
            }
            
            if ( function_cec565632b7fc419( var_efcc55fa67abaded ) )
            {
                var_efcc55fa67abaded = undefined;
            }
            
            var_4266d23631e69398 = hit_armor ? var_5aafe18394733126 : var_efcc55fa67abaded;
        }
        
        /#
            if ( function_41e6ad038b005511() )
            {
                projected_color = isdefined( var_4266d23631e69398 ) ? ( 0.5, 0.5, 0 ) : ( 0.2, 0.5, 0.5 );
                projected_pos = tag_positions[ var_39033f9289f86348 ] + tag_forward * var_8a3284c7a40fe130;
                sphere( projected_pos, 10, projected_color );
                line( projected_pos, tag_positions[ var_39033f9289f86348 ], projected_color, 1 );
                print3d( projected_pos, "<dev string:x1c>" + var_8a3284c7a40fe130 + "<dev string:x34>" + var_54327d15562bd3a1, projected_color );
                print3d( projected_pos + ( 0, 0, 20 ), "<dev string:x43>" + var_52729c4793f5c462 + "<dev string:x51>" + var_6b6ac322c0340936, projected_color );
            }
        #/
    }
    else if ( dmgstruct.shitloc == "head" )
    {
        var_4266d23631e69398 = "inner_jaw";
    }
    
    /#
        if ( function_41e6ad038b005511() )
        {
            if ( isdefined( dmgstruct.vpoint ) && isdefined( dmgstruct.vdir ) )
            {
                sphere( dmgstruct.vpoint, 10, ( 1, 0, 0 ) );
                line( dmgstruct.vpoint - dmgstruct.vdir * 100, dmgstruct.vpoint, ( 1, 0, 0 ), 1 );
                function_ad6307798215e0be( "<dev string:x63>" + dmgstruct.shitloc, dmgstruct.vpoint );
            }
        }
    #/
    
    return var_4266d23631e69398;
}

// Namespace zombie_deathworm / namespace_f0730cef8234f036
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x923
// Size: 0x1d
function private function_b9f4b7206d76e7ce( params )
{
    function_ebb83c1efeaae2c7( params.metabone_name );
}

// Namespace zombie_deathworm / namespace_f0730cef8234f036
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x948
// Size: 0x37
function private function_ebb83c1efeaae2c7( metabone_name )
{
    if ( self getscriptablehaspart( metabone_name ) )
    {
        self setscriptablepartstate( metabone_name, "off" );
        self function_3e89eb3d8e3f1811( "can_gill_destroyed_end_time", gettime() + 2000 );
    }
}

// Namespace zombie_deathworm / namespace_f0730cef8234f036
// Params 1
// Checksum 0x0, Offset: 0x987
// Size: 0x146
function function_6671940a6e85ff8a( scriptable )
{
    gills = [ "gill_bottom_le", "gill_middle_le", "gill_top_le", "gill_bottom_ri", "gill_middle_ri", "gill_top_ri" ];
    
    foreach ( gill in gills )
    {
        if ( function_cec565632b7fc419( gill ) )
        {
            scriptable setscriptablepartstate( gill, "off" );
        }
    }
    
    plates = [ "plate_bottom_le", "plate_middle_le", "plate_top_le", "plate_bottom_ri", "plate_middle_ri", "plate_top_ri" ];
    
    foreach ( plate in plates )
    {
        if ( function_cec565632b7fc419( plate ) )
        {
            scriptable setscriptablepartstate( plate, "off" );
        }
    }
}

/#

    // Namespace zombie_deathworm / namespace_f0730cef8234f036
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0xad5
    // Size: 0x2e, Type: dev
    function private function_f9d648a2240fdc83()
    {
        function_6e7290c8ee4f558b( "<dev string:x6d>" );
        function_a9a864379a098ad6( "<dev string:x8c>", "<dev string:x9f>", &function_484fb913cc61250e );
        function_fe953f000498048f();
    }

    // Namespace zombie_deathworm / namespace_f0730cef8234f036
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0xb0b
    // Size: 0x1a4, Type: dev
    function private function_1dbaaec5b9b3ec48()
    {
        self endon( "<dev string:xbc>" );
        
        while ( true )
        {
            metabones_def = function_97fd256a244527b4( self.metabones.bundle_name );
            
            foreach ( metabone in metabones_def.metabones )
            {
                if ( !array_contains( [ "<dev string:xc5>", "<dev string:xd7>", "<dev string:xe9>" ], metabone.name ) )
                {
                    continue;
                }
                
                foreach ( tag in metabone.tags )
                {
                    draw_tag( tag.tagname );
                    var_eda2dcf6e5705be7 = strtok( tag.tagname, "<dev string:xf8>" );
                    tag_num = int( var_eda2dcf6e5705be7[ var_eda2dcf6e5705be7.size - 1 ] );
                    tag_below = "<dev string:xfd>" + ( tag_num - 1 < 10 ? "<dev string:x108>" : "<dev string:x10d>" ) + tag_num - 1;
                    tag_above = "<dev string:xfd>" + ( tag_num + 1 < 10 ? "<dev string:x108>" : "<dev string:x10d>" ) + tag_num + 1;
                }
            }
            
            waitframe();
        }
    }

    // Namespace zombie_deathworm / namespace_f0730cef8234f036
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0xcb7
    // Size: 0x5b, Type: dev
    function private draw_tag( tagname )
    {
        TAG_ORIGIN = self gettagorigin( tagname );
        tag_angles = self gettagangles( tagname );
        function_ad6307798215e0be( tagname + "<dev string:x111>" + tag_angles[ 0 ] + "<dev string:x118>" + tag_angles[ 1 ] + "<dev string:x118>" + tag_angles[ 2 ], TAG_ORIGIN );
    }

    // Namespace zombie_deathworm / namespace_f0730cef8234f036
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0xd1a
    // Size: 0x17, Type: dev
    function private function_41e6ad038b005511()
    {
        return getdvarint( @"hash_dda69ad425f2daac", 0 ) > 0;
    }

    // Namespace zombie_deathworm / namespace_f0730cef8234f036
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0xd39
    // Size: 0x1a, Type: dev
    function private function_484fb913cc61250e()
    {
        function_2fb888667001fc39( "<dev string:x11d>", @"hash_dda69ad425f2daac" );
    }

    // Namespace zombie_deathworm / namespace_f0730cef8234f036
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0xd5b
    // Size: 0x5a, Type: dev
    function private function_ad6307798215e0be( text, pos )
    {
        if ( function_41e6ad038b005511() )
        {
            pos = default_to( pos, self.origin + ( 0, 0, 70 ) );
            print3d( pos, "<dev string:x13a>" + text, ( 1, 0, 0 ) );
        }
    }

#/
