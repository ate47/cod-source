#using scripts\common\utility;

#namespace character;

// Namespace character / scripts\code\character
// Params 1
// Checksum 0x0, Offset: 0xe2
// Size: 0xba
function get_least_used_model( array )
{
    lowest_indices = [];
    lowest_use = 999999;
    lowest_indices[ 0 ] = 0;
    
    for ( i = 0; i < array.size ; i++ )
    {
        if ( !isdefined( level.character_model_cache[ array[ i ] ] ) )
        {
            level.character_model_cache[ array[ i ] ] = 0;
        }
        
        model_count = level.character_model_cache[ array[ i ] ];
        
        if ( model_count > lowest_use )
        {
            continue;
        }
        
        if ( model_count < lowest_use )
        {
            lowest_indices = [];
            lowest_use = model_count;
        }
        
        lowest_indices[ lowest_indices.size ] = i;
    }
    
    assertex( lowest_indices.size, "<dev string:x1c>" );
    rnd = random( lowest_indices );
    return array[ rnd ];
}

// Namespace character / scripts\code\character
// Params 1
// Checksum 0x0, Offset: 0x1a5
// Size: 0x2e
function precachemodelarray( a )
{
    for ( i = 0; i < a.size ; i++ )
    {
        precachemodel( a[ i ] );
    }
}

// Namespace character / scripts\code\character
// Params 2
// Checksum 0x0, Offset: 0x1db
// Size: 0x11a
function attachhead( headalias, var_7556f3e1bb0846bc )
{
    /#
        if ( isdefined( level.var_ccf5af826b36fa06 ) )
        {
            if ( !isdefined( self.characterinfo ) )
            {
                self.characterinfo = spawnstruct();
                self.characterinfo.headalias = headalias;
                self.characterinfo.var_7556f3e1bb0846bc = var_7556f3e1bb0846bc;
            }
        }
    #/
    
    if ( !isdefined( level.character_head_index ) )
    {
        level.character_head_index = [];
    }
    
    if ( !isdefined( level.character_head_index[ headalias ] ) )
    {
        level.character_head_index[ headalias ] = randomint( var_7556f3e1bb0846bc.size );
    }
    
    assert( level.character_head_index[ headalias ] < var_7556f3e1bb0846bc.size );
    index = ( level.character_head_index[ headalias ] + 1 ) % var_7556f3e1bb0846bc.size;
    
    if ( isdefined( self.script_char_index ) )
    {
        index = self.script_char_index % var_7556f3e1bb0846bc.size;
    }
    
    level.character_head_index[ headalias ] = index;
    self attach( var_7556f3e1bb0846bc[ index ], "", 1 );
    self.headmodel = var_7556f3e1bb0846bc[ index ];
}

// Namespace character / scripts\code\character
// Params 2
// Checksum 0x0, Offset: 0x2fd
// Size: 0xa3
function attachhat( hatalias, var_827c5e69d673ce17 )
{
    if ( !isdefined( level.character_hat_index ) )
    {
        level.character_hat_index = [];
    }
    
    if ( !isdefined( level.character_hat_index[ hatalias ] ) )
    {
        level.character_hat_index[ hatalias ] = randomint( var_827c5e69d673ce17.size );
    }
    
    assert( level.character_hat_index[ hatalias ] < var_827c5e69d673ce17.size );
    index = ( level.character_hat_index[ hatalias ] + 1 ) % var_827c5e69d673ce17.size;
    level.character_hat_index[ hatalias ] = index;
    self attach( var_827c5e69d673ce17[ index ] );
    self.hatmodel = var_827c5e69d673ce17[ index ];
}

// Namespace character / scripts\code\character
// Params 0
// Checksum 0x0, Offset: 0x3a8
// Size: 0x40
function new()
{
    self detachall();
    oldgunhand = self.anim_gunhand;
    
    if ( !isdefined( oldgunhand ) )
    {
        return;
    }
    
    self.anim_gunhand = "none";
    self [[ anim.putguninhand ]]( oldgunhand );
}

// Namespace character / scripts\code\character
// Params 0
// Checksum 0x0, Offset: 0x3f0
// Size: 0xec
function save()
{
    info[ "gunHand" ] = self.anim_gunhand;
    info[ "gunInHand" ] = self.anim_guninhand;
    info[ "model" ] = self.model;
    info[ "hatModel" ] = self.hatmodel;
    
    if ( isdefined( self.name ) )
    {
        info[ "name" ] = self.name;
        println( "<dev string:x58>", self.name );
    }
    else
    {
        println( "<dev string:x6f>" );
    }
    
    attachsize = self getattachsize();
    
    for ( i = 0; i < attachsize ; i++ )
    {
        info[ "attach" ][ i ][ "model" ] = self getattachmodelname( i );
        info[ "attach" ][ i ][ "tag" ] = self getattachtagname( i );
    }
    
    return info;
}

// Namespace character / scripts\code\character
// Params 1
// Checksum 0x0, Offset: 0x4e5
// Size: 0xe2
function load( info )
{
    self detachall();
    self.anim_gunhand = info[ "gunHand" ];
    self.anim_guninhand = info[ "gunInHand" ];
    self setmodel( info[ "model" ] );
    self.hatmodel = info[ "hatModel" ];
    
    if ( isdefined( info[ "name" ] ) )
    {
        self.name = info[ "name" ];
        println( "<dev string:x89>", self.name );
    }
    else
    {
        println( "<dev string:xa0>" );
    }
    
    attachinfo = info[ "attach" ];
    attachsize = attachinfo.size;
    
    for ( i = 0; i < attachsize ; i++ )
    {
        self attach( attachinfo[ i ][ "model" ], attachinfo[ i ][ "tag" ] );
    }
}

// Namespace character / scripts\code\character
// Params 1
// Checksum 0x0, Offset: 0x5cf
// Size: 0x8e
function precache( info )
{
    if ( isdefined( info[ "name" ] ) )
    {
        println( "<dev string:xba>", info[ "<dev string:xd5>" ] );
    }
    else
    {
        println( "<dev string:xdd>" );
    }
    
    precachemodel( info[ "model" ] );
    attachinfo = info[ "attach" ];
    attachsize = attachinfo.size;
    
    for ( i = 0; i < attachsize ; i++ )
    {
        precachemodel( attachinfo[ i ][ "model" ] );
    }
}

// Namespace character / scripts\code\character
// Params 3
// Checksum 0x0, Offset: 0x665
// Size: 0x45
function initialize_character_group( prefix, group, amount )
{
    for ( i = 0; i < amount ; i++ )
    {
        level.character_index_cache[ prefix ][ group ][ i ] = 0;
    }
}

// Namespace character / scripts\code\character
// Params 1
// Checksum 0x0, Offset: 0x6b2
// Size: 0x11
function get_random_weapon( amount )
{
    return randomint( amount );
}

// Namespace character / scripts\code\character
// Params 1
// Checksum 0x0, Offset: 0x6cc
// Size: 0x14
function random( array )
{
    return array[ randomint( array.size ) ];
}

