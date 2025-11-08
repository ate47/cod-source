#using script_32d93a194074fa6a;
#using scripts\engine\utility;

#namespace namespace_a17b9a0132e7fbfc;

// Namespace namespace_a17b9a0132e7fbfc / namespace_8dfd86bc6ebc750d
// Params 1
// Checksum 0x0, Offset: 0xcc
// Size: 0x65
function function_9c8e6a1620edc3b9( var_b8df88d128399821 )
{
    assert( isplayer( self ) );
    var_20a11c870d111377 = function_7052cffee37e6327( var_b8df88d128399821 );
    
    if ( !isdefined( var_20a11c870d111377 ) )
    {
        assertmsg( "<dev string:x1c>" + var_b8df88d128399821 + "<dev string:x51>" + level.var_cf6b53e10210d950 );
        return;
    }
    
    self function_14a669727e767840( level.var_1986e4576cc38610[ var_20a11c870d111377 ] );
}

// Namespace namespace_a17b9a0132e7fbfc / namespace_8dfd86bc6ebc750d
// Params 0
// Checksum 0x0, Offset: 0x139
// Size: 0x19
function function_c858a1889a6cc094()
{
    assert( isplayer( self ) );
    self function_14a669727e767840( 0 );
}

// Namespace namespace_a17b9a0132e7fbfc / namespace_8dfd86bc6ebc750d
// Params 0
// Checksum 0x0, Offset: 0x15a
// Size: 0x9
function function_e9bceeafa296cb55()
{
    function_f6586fa40d64f63e();
}

// Namespace namespace_a17b9a0132e7fbfc / namespace_8dfd86bc6ebc750d
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x16b
// Size: 0xf1
function private function_f6586fa40d64f63e()
{
    level.var_1986e4576cc38610 = [];
    visibilitylist = getscriptbundle( "ftuehudvisibilitylist:ftuehudvisibility_list_mgl" ).var_ce22599a7f93f1c3;
    
    foreach ( tip in level.var_cf6b53e10210d950 )
    {
        var_f4685368dcf821c5 = getscriptbundlefieldvalue( hashcat( %"hash_6b016976aff9ae9f", tip.bundle ), #"visibilitybundle" );
        
        if ( isdefined( var_f4685368dcf821c5 ) )
        {
            for ( var_fccc3e3abfa0e121 = 0; visibilitylist[ var_fccc3e3abfa0e121 ].bundle != var_f4685368dcf821c5 && var_fccc3e3abfa0e121 < visibilitylist.size ; var_fccc3e3abfa0e121++ )
            {
            }
            
            level.var_1986e4576cc38610[ tip.bundle ] = var_fccc3e3abfa0e121 + 1;
        }
    }
}

