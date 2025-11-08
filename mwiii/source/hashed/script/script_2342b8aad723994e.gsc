#namespace namespace_36820a34c6c5dfcc;

// Namespace namespace_36820a34c6c5dfcc / namespace_c31609f90efcf2ca
// Params 1
// Checksum 0x0, Offset: 0x88
// Size: 0x74
function onplayerjoinsquad( player )
{
    if ( !isdefined( level.onjoinsquadcallbacks ) )
    {
        level.onjoinsquadcallbacks = [];
    }
    
    foreach ( callback in level.onjoinsquadcallbacks )
    {
        self [[ callback ]]( player );
    }
}

// Namespace namespace_36820a34c6c5dfcc / namespace_c31609f90efcf2ca
// Params 1
// Checksum 0x0, Offset: 0x104
// Size: 0x38
function registeronplayerjoinsquadcallback( callback )
{
    if ( !isdefined( level.onjoinsquadcallbacks ) )
    {
        level.onjoinsquadcallbacks = [];
    }
    
    level.onjoinsquadcallbacks[ level.onjoinsquadcallbacks.size ] = callback;
}

// Namespace namespace_36820a34c6c5dfcc / namespace_c31609f90efcf2ca
// Params 1
// Checksum 0x0, Offset: 0x144
// Size: 0x74
function function_2a1e4811621fdcde( player )
{
    if ( !isdefined( level.var_dfe31f42a61aed79 ) )
    {
        level.var_dfe31f42a61aed79 = [];
    }
    
    foreach ( callback in level.var_dfe31f42a61aed79 )
    {
        self [[ callback ]]( player );
    }
}

// Namespace namespace_36820a34c6c5dfcc / namespace_c31609f90efcf2ca
// Params 1
// Checksum 0x0, Offset: 0x1c0
// Size: 0x38
function function_a99987c7bf114da4( callback )
{
    if ( !isdefined( level.var_dfe31f42a61aed79 ) )
    {
        level.var_dfe31f42a61aed79 = [];
    }
    
    level.var_dfe31f42a61aed79[ level.var_dfe31f42a61aed79.size ] = callback;
}

