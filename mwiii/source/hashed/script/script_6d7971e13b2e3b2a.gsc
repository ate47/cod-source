#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\utility\game;

#namespace loot_spawner;

// Namespace loot_spawner / namespace_5ec5215ed7483164
// Params 0
// Checksum 0x0, Offset: 0x235
// Size: 0x4b
function init()
{
    if ( isdefined( level.loot_spawner ) )
    {
        return;
    }
    
    initdvars();
    level._effect[ "vfx_golden_loot_explosion_flare" ] = loadfx( "vfx/iw8_br/gameplay/vfx_golden_loot_explosion_flare" );
    level._effect[ "vfx_br_legendary_loot_glow" ] = loadfx( "vfx/iw8_br/gameplay/vfx_br_launch_code_glow" );
}

// Namespace loot_spawner / namespace_5ec5215ed7483164
// Params 0
// Checksum 0x0, Offset: 0x288
// Size: 0x135
function initdvars()
{
    if ( !isdefined( level.loot_spawner ) )
    {
        level.loot_spawner = spawnstruct();
        level.loot_spawner.ammo_types = [];
        level.loot_spawner.ammo_types[ "rifle" ] = "brloot_ammo_762";
        level.loot_spawner.ammo_types[ "mg" ] = "brloot_ammo_762";
        level.loot_spawner.ammo_types[ "pistol" ] = "brloot_ammo_919";
        level.loot_spawner.ammo_types[ "smg" ] = "brloot_ammo_919";
        level.loot_spawner.ammo_types[ "sniper" ] = "brloot_ammo_50cal";
        level.loot_spawner.ammo_types[ "rocketlauncher" ] = "brloot_ammo_rocket";
        level.loot_spawner.ammo_types[ "spread" ] = "brloot_ammo_12g";
    }
    
    level.loot_spawner.original_tables = [];
    level.loot_spawner.loot_tables = [];
}

// Namespace loot_spawner / namespace_5ec5215ed7483164
// Params 2
// Checksum 0x0, Offset: 0x3c5
// Size: 0x83
function function_8cd7f4939fad286d( key, loottable )
{
    if ( !isdefined( level.loot_spawner ) )
    {
        assertmsg( "<dev string:x1c>" );
        return;
    }
    
    if ( !array_contains_key( level.loot_spawner.loot_tables, key ) )
    {
        level.loot_spawner.loot_tables[ key ] = function_7d7a712ef3b127ea( key, loottable );
        return;
    }
    
    assertmsg( "<dev string:x44>" + key + "<dev string:x6a>" );
}

// Namespace loot_spawner / namespace_5ec5215ed7483164
// Params 2
// Checksum 0x0, Offset: 0x450
// Size: 0x52
function function_7b8ccedb73cc8fd3( var_d974cc8b12dcba2f, var_b3067c4046466191 )
{
    if ( function_53b4df89c7012e9a( var_d974cc8b12dcba2f ) )
    {
        return;
    }
    
    if ( array_contains_key( level.loot_spawner.loot_tables, var_d974cc8b12dcba2f ) )
    {
        level.loot_spawner.loot_tables[ var_d974cc8b12dcba2f ] = var_b3067c4046466191;
    }
}

// Namespace loot_spawner / namespace_5ec5215ed7483164
// Params 3
// Checksum 0x0, Offset: 0x4aa
// Size: 0xb2
function function_ef51288f40f95d1b( key, itemid, spawnratio )
{
    if ( function_53b4df89c7012e9a( key ) )
    {
        return;
    }
    
    loot_table = level.loot_spawner.loot_tables[ key ];
    
    if ( !array_contains_key( loot_table, itemid ) )
    {
        level.loot_spawner.original_tables[ key ][ itemid ] = spawnratio;
        level.loot_spawner.loot_tables[ key ] = function_7d7a712ef3b127ea( key, level.loot_spawner.original_tables[ key ] );
        return;
    }
    
    assertmsg( itemid + "<dev string:x8e>" + key );
}

// Namespace loot_spawner / namespace_5ec5215ed7483164
// Params 2
// Checksum 0x0, Offset: 0x564
// Size: 0xc3
function function_26022cd17e1904ce( key, itemid )
{
    if ( function_53b4df89c7012e9a( key ) )
    {
        return;
    }
    
    loot_table = level.loot_spawner.loot_tables[ key ];
    
    if ( array_contains_key( loot_table, itemid ) )
    {
        level.loot_spawner.original_tables[ key ] = array_remove_key( level.loot_spawner.original_tables[ key ], itemid );
        level.loot_spawner.loot_tables[ key ] = function_7d7a712ef3b127ea( key, level.loot_spawner.original_tables[ key ] );
        return;
    }
    
    assertmsg( itemid + "<dev string:xb0>" + key );
}

// Namespace loot_spawner / namespace_5ec5215ed7483164
// Params 1
// Checksum 0x0, Offset: 0x62f
// Size: 0x2b
function function_b3d3903f8130fff7( key )
{
    if ( function_53b4df89c7012e9a( key ) )
    {
        return;
    }
    
    return level.loot_spawner.loot_tables[ key ];
}

// Namespace loot_spawner / namespace_5ec5215ed7483164
// Params 1
// Checksum 0x0, Offset: 0x663
// Size: 0x25
function function_d9ef8d5dab99814c( key )
{
    return array_contains_key( level.loot_spawner.loot_tables, key );
}

// Namespace loot_spawner / namespace_5ec5215ed7483164
// Params 5
// Checksum 0x0, Offset: 0x691
// Size: 0x27e
function function_889a4446bb24ec16( var_bab91ec21655f39c, position, spawncount, spawnvfx, args )
{
    if ( function_53b4df89c7012e9a( var_bab91ec21655f39c ) )
    {
        return;
    }
    
    loot_table = function_b3d3903f8130fff7( var_bab91ec21655f39c );
    lootinfo = spawnstruct();
    lootinfo.dropcount = randomintrange( 1, 10 );
    lootinfo.heightoffset = 0;
    lootinfo.origin = position;
    
    if ( isstring( spawnvfx ) )
    {
    }
    else if ( spawnvfx )
    {
        playfx( getfx( "vfx_golden_loot_explosion_flare" ), position );
    }
    
    for ( i = 0; i < spawncount ; i++ )
    {
        random_value = randomfloat( 1 );
        
        foreach ( key, entry in loot_table )
        {
            var_f35b93a944c13de8 = entry[ 2 ];
            var_2b4ef98997be493 = entry[ 3 ];
            
            if ( random_value >= var_f35b93a944c13de8 && random_value <= var_2b4ef98997be493 )
            {
                switch ( key )
                {
                    case #"hash_637736d2cc79a66a":
                        continue;
                    case #"hash_414a0057bc9c9914":
                        if ( !isdefined( args ) )
                        {
                            assertmsg( isdefined( args[ "<dev string:xd3>" ] ), "<dev string:xe0>" );
                            continue;
                        }
                        
                        if ( !isdefined( args[ "eAttacker" ] ) )
                        {
                            assertex( isdefined( args[ "<dev string:xd3>" ] ), "<dev string:x130>" );
                            continue;
                        }
                        
                        attacker = args[ "eAttacker" ];
                        var_5131da474c4c19ca = undefined;
                        
                        if ( isplayer( attacker ) || isbot( attacker ) || isagent( attacker ) )
                        {
                            var_5131da474c4c19ca = weaponclass( args[ "eAttacker" ] getcurrentweapon() );
                        }
                        
                        if ( !isdefined( var_5131da474c4c19ca ) )
                        {
                            continue;
                        }
                        
                        lootinfo.item = level.loot_spawner.ammo_types[ var_5131da474c4c19ca ];
                        
                        if ( !isdefined( lootinfo.item ) )
                        {
                            continue;
                        }
                        
                        break;
                    default:
                        lootinfo.item = key;
                        break;
                }
                
                lootinfo.dropcount += 2;
                thread spawnloot( lootinfo );
                waitframe();
            }
        }
    }
}

// Namespace loot_spawner / namespace_5ec5215ed7483164
// Params 1
// Checksum 0x0, Offset: 0x917
// Size: 0x3c, Type: bool
function function_53b4df89c7012e9a( key )
{
    if ( !array_contains_key( level.loot_spawner.loot_tables, key ) )
    {
        assertmsg( "<dev string:x18b>" + key );
        return true;
    }
    
    return false;
}

// Namespace loot_spawner / namespace_5ec5215ed7483164
// Params 1
// Checksum 0x0, Offset: 0x95c
// Size: 0xb9
function spawnloot( lootinfo )
{
    lootinfo.legendary = issubstr( lootinfo.item, "lege" );
    itemname = lootinfo.item;
    spawnposition = lootinfo.origin + ( 0, 0, lootinfo.heightoffset );
    angles = ( 0, 0, 0 );
    loot_item = scripts\mp\gametypes\br_lootcache::lootspawnitem( itemname, lootinfo, spawnposition, angles, 0, lootinfo.legendary, 0 );
    lootinfo.heightoffset += 3;
}

// Namespace loot_spawner / namespace_5ec5215ed7483164
// Params 2
// Checksum 0x0, Offset: 0xa1d
// Size: 0x194
function function_7d7a712ef3b127ea( var_ccf10def4015e022, loot_table )
{
    var_7f076c6b7a5ef5b3 = [];
    total_value = 0;
    
    foreach ( value in loot_table )
    {
        total_value += value;
    }
    
    index = 0;
    var_b67d18cac8627e8c = getarraykeys( loot_table );
    previous_key = undefined;
    
    /#
        iprintln( "<dev string:x1aa>" );
        iprintln( "<dev string:x1dd>" + var_ccf10def4015e022 );
    #/
    
    foreach ( key, value in loot_table )
    {
        var_7f076c6b7a5ef5b3[ key ] = [];
        normalized_value = value / total_value;
        
        if ( index == 0 )
        {
            floor_value = 0;
            ceil_value = normalized_value;
        }
        else
        {
            floor_value = previous_key[ 3 ];
            ceil_value = floor_value + normalized_value;
        }
        
        var_7f076c6b7a5ef5b3[ key ] = [ value, normalized_value, floor_value, ceil_value ];
        previous_key = var_7f076c6b7a5ef5b3[ key ];
        
        /#
            iprintln( key + "<dev string:x1ed>" + var_7f076c6b7a5ef5b3[ key ][ 1 ] );
        #/
        
        index++;
    }
    
    /#
        iprintln( "<dev string:x1aa>" );
    #/
    
    level.loot_spawner.original_tables[ var_ccf10def4015e022 ] = loot_table;
    return var_7f076c6b7a5ef5b3;
}

