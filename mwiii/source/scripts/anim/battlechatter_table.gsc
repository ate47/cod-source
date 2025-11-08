#using scripts\common\utility;
#using scripts\engine\utility;

#namespace battlechatter_table;

// Namespace battlechatter_table / scripts\anim\battlechatter_table
// Params 7
// Checksum 0x0, Offset: 0xa8
// Size: 0xd5
function bctable_setfiles( category, filename1, filename2, filename3, filename4, filename5, filename6 )
{
    anim.bctable[ category ] = [];
    
    if ( isdefined( anim.bctabledeck ) )
    {
        anim.bctabledeck[ category ] = undefined;
    }
    
    if ( isdefined( anim.bctablelast ) )
    {
        anim.bctablelast[ category ] = undefined;
    }
    
    if ( isdefined( filename1 ) )
    {
        bctable_addfile( category, filename1 );
    }
    
    if ( isdefined( filename2 ) )
    {
        bctable_addfile( category, filename2 );
    }
    
    if ( isdefined( filename3 ) )
    {
        bctable_addfile( category, filename3 );
    }
    
    if ( isdefined( filename4 ) )
    {
        bctable_addfile( category, filename4 );
    }
    
    if ( isdefined( filename5 ) )
    {
        bctable_addfile( category, filename5 );
    }
    
    if ( isdefined( filename6 ) )
    {
        bctable_addfile( category, filename6 );
    }
}

// Namespace battlechatter_table / scripts\anim\battlechatter_table
// Params 2
// Checksum 0x0, Offset: 0x185
// Size: 0x142
function bctable_addfile( category, filename )
{
    for ( row = 0; true ; row++ )
    {
        tbltype = tolower( tablelookupbyrow( filename, row, 0 ) );
        tblmodifier = tolower( tablelookupbyrow( filename, row, 1 ) );
        var_37bccd17fea9d291 = [];
        
        while ( true )
        {
            alias = tolower( tablelookupbyrow( filename, row, var_37bccd17fea9d291.size + 2 ) );
            
            if ( alias == "" )
            {
                break;
            }
            
            var_37bccd17fea9d291[ var_37bccd17fea9d291.size ] = alias;
        }
        
        if ( tbltype == "" && tblmodifier == "" && var_37bccd17fea9d291.size == 0 )
        {
            break;
        }
        
        if ( tbltype == "" )
        {
            tbltype = "all";
        }
        
        if ( tblmodifier == "" )
        {
            tblmodifier = "all";
        }
        
        key = bctable_categorykey( tbltype, tblmodifier );
        
        if ( !isdefined( anim.bctable[ category ][ key ] ) )
        {
            anim.bctable[ category ][ key ] = [];
        }
        
        size = anim.bctable[ category ][ key ].size;
        anim.bctable[ category ][ key ][ size ] = var_37bccd17fea9d291;
    }
}

// Namespace battlechatter_table / scripts\anim\battlechatter_table
// Params 3
// Checksum 0x0, Offset: 0x2cf
// Size: 0x279
function bctable_pickaliasset( category, type, modifier )
{
    key = bctable_categorykey( type, modifier );
    
    if ( !bctable_exists( category, type, modifier ) )
    {
        println( "<dev string:x1c>" + modifier );
        return undefined;
    }
    
    if ( !isdefined( anim.bctabledeck ) || !isdefined( anim.bctabledeck[ category ] ) || !isdefined( anim.bctabledeck[ category ][ key ] ) )
    {
        anim.bctabledeck[ category ][ key ] = [];
        
        for ( index = 0; index < anim.bctable[ category ][ key ].size ; index++ )
        {
            anim.bctabledeck[ category ][ key ][ index ] = index;
        }
        
        decksize = anim.bctabledeck[ category ][ key ].size;
        
        if ( decksize >= 3 )
        {
            anim.bctabledeck[ category ][ key ] = array_randomize( anim.bctabledeck[ category ][ key ] );
        }
        
        if ( decksize >= 2 )
        {
            if ( isdefined( anim.bctablelast ) && isdefined( anim.bctablelast[ category ][ key ] ) && anim.bctablelast[ category ][ key ] == anim.bctabledeck[ category ][ key ][ decksize - 1 ] )
            {
                temp = anim.bctabledeck[ category ][ key ][ 0 ];
                anim.bctabledeck[ category ][ key ][ 0 ] = anim.bctabledeck[ category ][ key ][ decksize - 1 ];
                anim.bctabledeck[ category ][ key ][ decksize - 1 ] = temp;
            }
        }
    }
    
    if ( anim.bctabledeck[ category ][ key ].size == 0 )
    {
        return undefined;
    }
    
    deckindex = anim.bctabledeck[ category ][ key ].size - 1;
    tableindex = anim.bctabledeck[ category ][ key ][ deckindex ];
    result = anim.bctable[ category ][ key ][ tableindex ];
    assert( isdefined( result ) );
    anim.bctabledeck[ category ][ key ][ deckindex ] = undefined;
    
    if ( anim.bctabledeck[ category ][ key ].size == 0 )
    {
        anim.bctabledeck[ category ][ key ] = undefined;
    }
    
    anim.bctablelast[ category ][ key ] = tableindex;
    return result;
}

// Namespace battlechatter_table / scripts\anim\battlechatter_table
// Params 3
// Checksum 0x0, Offset: 0x551
// Size: 0x79, Type: bool
function bctable_exists( category, type, modifier )
{
    if ( !isdefined( anim.bctable ) || !isdefined( anim.bctable[ category ] ) )
    {
        return false;
    }
    
    key = bctable_categorykey( type, modifier );
    
    if ( !isdefined( anim.bctable[ category ][ key ] ) )
    {
        return false;
    }
    
    if ( anim.bctable[ category ][ key ].size == 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace battlechatter_table / scripts\anim\battlechatter_table
// Params 2
// Checksum 0x0, Offset: 0x5d3
// Size: 0x3e
function bctable_categorykey( type, modifier )
{
    if ( !isdefined( type ) )
    {
        type = "all";
    }
    
    if ( !isdefined( modifier ) )
    {
        modifier = "all";
    }
    
    return tolower( type ) + "_" + tolower( modifier );
}

