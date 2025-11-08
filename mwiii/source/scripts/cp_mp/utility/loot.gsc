#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;

#namespace loot;

// Namespace loot / scripts\cp_mp\utility\loot
// Params 0
// Checksum 0x0, Offset: 0x769
// Size: 0xae
function init()
{
    level.lootmaster = [];
    
    for ( row = 0; true ; row++ )
    {
        typename = tablelookupbyrow( "loot/loot_types.csv", row, 0 );
        
        if ( !isdefined( typename ) || typename == "" )
        {
            break;
        }
        
        typevalue = int( tablelookupbyrow( "loot/loot_types.csv", row, 1 ) );
        data = spawnstruct();
        data.typename = typename;
        data.typevalue = typevalue;
        level.lootmaster[ typename ] = data;
    }
    
    function_7d267b05c8f10c00();
    function_f6b6d73054e210b1();
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 0
// Checksum 0x0, Offset: 0x81f
// Size: 0x135
function function_f6b6d73054e210b1()
{
    level.var_b8122168a1d73b08 = [];
    level.var_8d8a8ce3fdb2e872 = [];
    var_197b05400b063f0a = getdvar( @"hash_531b2ab282f3dbab" );
    
    if ( isdefined( var_197b05400b063f0a ) )
    {
        itemids = strtok( var_197b05400b063f0a, "|" );
        
        foreach ( itemid in itemids )
        {
            level.var_b8122168a1d73b08 = array_add( level.var_b8122168a1d73b08, int( itemid ) );
        }
    }
    
    var_197b05400b063f0a = getdvar( @"hash_18d43c13f449a92b" );
    
    if ( isdefined( var_197b05400b063f0a ) )
    {
        itemnames = strtok( var_197b05400b063f0a, "|" );
        
        foreach ( itemname in itemnames )
        {
            level.var_8d8a8ce3fdb2e872 = array_add( level.var_8d8a8ce3fdb2e872, itemname );
        }
    }
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 0
// Checksum 0x0, Offset: 0x95c
// Size: 0x15b
function function_7d267b05c8f10c00()
{
    if ( isdefined( level.var_1a37f44229729be9 ) )
    {
        return;
    }
    
    level.var_1a37f44229729be9 = [];
    level.var_fb669fe7caba3cf2 = [];
    projectscriptbundle = level.projectbundle;
    var_ffa92a8d5e47d362 = getscriptbundle( hashcat( %"hash_6da2812724ad07ed", projectscriptbundle.consumablelist ) );
    
    /#
        if ( !isdefined( var_ffa92a8d5e47d362 ) )
        {
            println( "<dev string:x1c>" + projectscriptbundle.consumablelist );
        }
    #/
    
    consumablelist = var_ffa92a8d5e47d362.consumablelist;
    
    for ( i = 0; i < consumablelist.size ; i++ )
    {
        if ( !isdefined( consumablelist[ i ].bundle ) )
        {
            continue;
        }
        
        consumablebundle = getscriptbundle( hashcat( %"hash_2d4d7620ade90519", consumablelist[ i ].bundle ) );
        
        if ( !isdefined( consumablebundle ) )
        {
            println( "<dev string:x4c>" + projectscriptbundle.consumablelist + "<dev string:x85>" + consumablelist[ i ].bundle );
            continue;
        }
        
        consumableref = consumablelist[ i ].bundle;
        level.var_1a37f44229729be9[ consumableref ] = consumablebundle;
        level.var_fb669fe7caba3cf2[ level.var_fb669fe7caba3cf2.size ] = consumableref;
    }
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0xabf
// Size: 0x42
function function_43b02b62387ec23e( consumableref )
{
    function_7d267b05c8f10c00();
    
    if ( array_contains_key( level.var_1a37f44229729be9, consumableref ) )
    {
        return level.var_1a37f44229729be9[ consumableref ];
    }
    
    println( "<dev string:x8b>" + consumableref );
    return undefined;
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0xb0a
// Size: 0x81
function function_b481a180dac1c1cc( lootid )
{
    function_7d267b05c8f10c00();
    
    foreach ( consumable in level.var_1a37f44229729be9 )
    {
        if ( consumable.lootid == lootid )
        {
            return consumable;
        }
    }
    
    println( "<dev string:xb6>" + lootid );
    return undefined;
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0xb94
// Size: 0x74
function function_6fb104d58e745d61( typevalue )
{
    foreach ( data in level.lootmaster )
    {
        if ( typevalue == data.typevalue )
        {
            return data.typename;
        }
    }
    
    return undefined;
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0xc11
// Size: 0x74
function function_8662a0aef570ff4b( typename )
{
    foreach ( data in level.lootmaster )
    {
        if ( typename == data.typename )
        {
            return data.typevalue;
        }
    }
    
    return undefined;
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0xc8e
// Size: 0x5e
function function_282cf83c9eeda744( lootid )
{
    if ( !isdefined( lootid ) )
    {
        return undefined;
    }
    
    lootinfo = getlootiteminfofromid( lootid );
    
    if ( !isdefined( lootinfo ) || !isdefined( lootinfo.category ) )
    {
        return undefined;
    }
    
    typename = lootinfo.category;
    
    if ( typename == "" )
    {
        return undefined;
    }
    
    return typename;
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 2
// Checksum 0x0, Offset: 0xcf5
// Size: 0x1fa
function function_2f80e9272a2074d( lootid, weaponrootname )
{
    uniqueref = function_793e8a72cedb8ef3( lootid );
    bundledata = scripts\cp_mp\weapon::function_a622d54bb517923a( uniqueref, [ #"baseref" ] );
    
    if ( isdefined( bundledata ) && isdefined( bundledata.baseref ) && bundledata.baseref != "" )
    {
        if ( bundledata.baseref != uniqueref )
        {
            var_39dd70c4a332b134 = scripts\cp_mp\weapon::function_a622d54bb517923a( bundledata.baseref, [ #"lootid" ] );
            assertex( isdefined( var_39dd70c4a332b134 ), "<dev string:xee>" + bundledata.baseref );
            
            if ( isdefined( var_39dd70c4a332b134 ) && var_39dd70c4a332b134.lootid != 0 )
            {
                lootid = var_39dd70c4a332b134.lootid;
            }
        }
    }
    
    assert( isarray( level.attachmentslotarray ) );
    
    foreach ( slot in level.attachmentslotarray )
    {
        var_e1ffc4455c6c4f8a = function_75b035199842693d( weaponrootname, slot );
        
        if ( isdefined( var_e1ffc4455c6c4f8a ) )
        {
            foreach ( attachment in var_e1ffc4455c6c4f8a )
            {
                id = getscriptbundlefieldvalue( hashcat( %"hash_3c2c9813bb16552f", attachment ), #"lootid" );
                
                if ( !isdefined( id ) )
                {
                    logprint( "^3Failed to find attachment data with a valid id for [", attachment, "] despite the weapon [", weaponrootname, "] listing it as a possible attachment." );
                    continue;
                }
                
                if ( id == lootid )
                {
                    return attachment;
                }
            }
        }
    }
    
    return uniqueref;
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0xef8
// Size: 0x133
function function_793e8a72cedb8ef3( lootid )
{
    if ( !isdefined( lootid ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_f41abe634712663c ) )
    {
        level.var_f41abe634712663c = [];
    }
    
    if ( isdefined( level.var_f41abe634712663c[ lootid ] ) )
    {
        return level.var_f41abe634712663c[ lootid ];
    }
    
    itemref = undefined;
    lootinfo = getlootiteminfofromid( lootid );
    
    if ( isdefined( lootinfo ) && isdefined( lootinfo.itemref ) )
    {
        itemref = lootinfo.itemref;
    }
    
    if ( !isdefined( itemref ) )
    {
        if ( getdvarint( @"hash_6d4a21dadd19744d", 0 ) == 1 && getdvar( @"loot_table_name", "mp/loot/br/default/loot_item_defs.csv" ) == "mp/loot/br/default/loot_item_defs.csv" )
        {
            itemref = "";
            
            if ( isdefined( level.br_pickups.var_b13dc7e63676bbe7[ lootid ] ) )
            {
                itemref = level.br_pickups.var_b13dc7e63676bbe7[ lootid ];
            }
        }
        else if ( isdefined( level.brloottablename ) )
        {
            itemref = tablelookup( level.brloottablename, 5, lootid, 1 );
        }
    }
    
    if ( isdefined( itemref ) && itemref != "" )
    {
        level.var_f41abe634712663c[ lootid ] = itemref;
    }
    
    return itemref;
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0x1034
// Size: 0x91
function getlootidfromref( ref )
{
    if ( !isdefined( ref ) )
    {
        return undefined;
    }
    
    if ( !isdefined( level.var_782b4804d4e2d690 ) )
    {
        level.var_782b4804d4e2d690 = [];
    }
    
    if ( isdefined( level.var_782b4804d4e2d690[ ref ] ) )
    {
        return level.var_782b4804d4e2d690[ ref ];
    }
    
    lootinfo = getlootiteminfofromref( ref );
    
    if ( !isdefined( lootinfo ) || !isdefined( lootinfo.itemid ) )
    {
        return 0;
    }
    
    lootid = lootinfo.itemid;
    level.var_782b4804d4e2d690[ ref ] = lootid;
    return lootid;
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0x10ce
// Size: 0x184
function function_c2c9fb447c203cb2( type )
{
    if ( !isdefined( type ) )
    {
        return undefined;
    }
    
    switch ( type )
    {
        case #"hash_27124c6c97ccffa1":
        case #"hash_325cb2e66f67d5b9":
        case #"hash_511d3c24fcedcdb1":
            return "weapon";
        case #"hash_933827ed049cbeb9":
            return "special_weapon";
        case #"hash_339227cb650975db":
        case #"hash_850999d7864fa3b4":
        case #"hash_93c71e7b6c0b81d7":
            return "equipment";
        case #"hash_9b65aa0f76e2e865":
        case #"hash_b60679835e82a584":
        case #"hash_e534fd8ec73eafb4":
            return "super";
        case #"hash_1cac65e1b8bf24a7":
            return "killstreak";
        case #"hash_ab671284a3fc4e3d":
            return "perk";
        case #"hash_4a01666eb6c388c8":
            return "attachment";
        case #"hash_59b8e9d05b31ff9":
        case #"hash_7d516d84d0a82f2":
        case #"hash_d42d44f53610ee5":
        case #"hash_13d1f84d0ae96a5f":
        case #"hash_55425b6c36803a4c":
        case #"hash_5e0a8ff36bce5106":
        case #"hash_6287e3a709aed1ed":
        case #"hash_68f4eeaa46e980a8":
        case #"hash_69146251ab5ca13a":
        case #"hash_7142f43f1e6394cf":
        case #"hash_7b7fff9980d178cf":
        case #"hash_8499464a48c4e157":
        case #"hash_bf5597954aaed3d7":
            return "consumable";
    }
    
    return undefined;
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0x125b
// Size: 0xbc
function function_b88cfb4893ceedac( ref )
{
    if ( !isdefined( ref ) )
    {
        return undefined;
    }
    
    if ( !isdefined( level.br_pickups ) )
    {
        return;
    }
    
    if ( !isdefined( level.br_pickups ) )
    {
        return undefined;
    }
    
    if ( isdefined( level.br_pickups.br_weapontoscriptable[ ref ] ) )
    {
        return level.br_pickups.br_weapontoscriptable[ ref ];
    }
    
    if ( isdefined( level.br_pickups.br_equipnametoscriptable[ ref ] ) )
    {
        return level.br_pickups.br_equipnametoscriptable[ ref ];
    }
    
    if ( isdefined( level.br_pickups.var_838863c4848d4c26[ ref ] ) )
    {
        return level.br_pickups.var_838863c4848d4c26[ ref ];
    }
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0x131f
// Size: 0x7e
function getscriptablefromlootid( lootid )
{
    scriptable = getscriptablefromlootidsharedfunc( lootid );
    
    if ( isdefined( scriptable ) )
    {
        return scriptable;
    }
    
    if ( isdefined( level.br_pickups ) && isdefined( level.br_pickups.var_b13dc7e63676bbe7[ lootid ] ) )
    {
        return level.br_pickups.var_b13dc7e63676bbe7[ lootid ];
    }
    
    ref = function_793e8a72cedb8ef3( lootid );
    return function_b88cfb4893ceedac( ref );
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0x13a5
// Size: 0x12a
function function_fae5e1d3de32d3f7( ref )
{
    if ( !isdefined( ref ) )
    {
        return undefined;
    }
    
    if ( issharedfuncdefined( "game", "getLootIDFromRef" ) )
    {
        return level [[ getsharedfunc( "game", "getLootIDFromRef" ) ]]( ref );
    }
    else if ( isdefined( level.br_pickups.var_7b2bff2d04ee1017[ ref ] ) )
    {
        return level.br_pickups.var_7b2bff2d04ee1017[ ref ];
    }
    
    if ( isdefined( level.br_pickups.var_14bd11727c4b6629[ ref ] ) && isdefined( level.br_pickups.br_itemtype[ ref ] ) )
    {
        itemtype = level.br_pickups.br_itemtype[ ref ];
        
        if ( itemtype == #"health" )
        {
            itemtype = #"consumable";
        }
        
        return getlootidfromref( level.br_pickups.var_14bd11727c4b6629[ ref ] );
    }
    
    if ( isdefined( level.br_pickups.br_equipname[ ref ] ) )
    {
        return getlootidfromref( level.br_pickups.br_equipname[ ref ] );
    }
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0x14d7
// Size: 0x29
function function_afa71c22d9dcfdc5( lootid )
{
    cost = function_b481a180dac1c1cc( lootid ).cost;
    return cost;
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0x1509
// Size: 0x2c
function function_4068c937ebaa0ebd( scriptablename )
{
    lootid = function_fae5e1d3de32d3f7( scriptablename );
    
    if ( !isdefined( lootid ) )
    {
        return 0;
    }
    
    return function_c02e0fb782d242f2( lootid );
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0x153e
// Size: 0x3b, Type: bool
function function_c02e0fb782d242f2( lootid )
{
    var_4b67a123f86227ce = function_b481a180dac1c1cc( lootid ).var_4b67a123f86227ce;
    
    if ( !isdefined( var_4b67a123f86227ce ) )
    {
        return true;
    }
    
    if ( var_4b67a123f86227ce == 1 )
    {
        return false;
    }
    
    return true;
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0x1582
// Size: 0x48, Type: bool
function isitemfiltered( var_25978461c6e4f61b )
{
    if ( !isdefined( var_25978461c6e4f61b ) )
    {
        return false;
    }
    
    return issubstr( getdvar( @"loot_table_filter", "" ), var_25978461c6e4f61b ) || issubstr( getdvar( @"hash_ac347c5a6346b8ac", "" ), var_25978461c6e4f61b );
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0x15d3
// Size: 0x2c, Type: bool
function function_5d47301f7bb7a6ba( lootid )
{
    if ( !isdefined( lootid ) )
    {
        return false;
    }
    
    var_25978461c6e4f61b = getscriptablefromlootid( lootid );
    return isitemfiltered( var_25978461c6e4f61b );
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0x1608
// Size: 0x37
function function_54b046aa3ba2678a( var_9023cea8f03e72d2 )
{
    var_3d329ebb0d03d6db = tablelookup( "mp/buyStation/buyStationDefs.csv", 1, var_9023cea8f03e72d2, 0 );
    
    if ( var_3d329ebb0d03d6db != "" )
    {
        return int( var_3d329ebb0d03d6db );
    }
    
    return undefined;
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0x1648
// Size: 0x1f0
function function_151b82e1257f4cde( ref )
{
    if ( !isdefined( ref ) )
    {
        return undefined;
    }
    
    switch ( ref )
    {
        case #"hash_aa60ec2aec479ec8":
            return "super_tac_cover";
        case #"hash_c848458cca24d656":
            return "super_trophy";
        case #"hash_de0fbd002a2503b7":
            return "super_recon_drone";
        case #"hash_8bb4a7de3879026d":
            return "super_deadsilence";
        case #"hash_b593201e2eae5dcd":
            return "super_support_box";
        case #"hash_ecd28780631ff043":
            return "super_ammo_drop";
        case #"hash_91076f076ee682f4":
            return "super_armor_drop";
        case #"hash_5bb446fe7b2c92da":
            return "super_haunted_drop";
        case #"hash_b3d0752364b0193d":
            return "super_utility_drop";
        case #"hash_4d6bb233bacb2d87":
            return "super_battlerage";
        case #"hash_2ee3956fc66771d2":
            return "super_stimpistol";
        case #"hash_8e058a166a2a6049":
            return "super_deployed_decoy";
        case #"hash_1eeb976ed8edf3e2":
            return "super_tac_camera";
        case #"hash_ac9ba190f352c1f":
            return "super_emp_pulse";
        case #"hash_4cbb2e16d7934fbc":
            return "super_supply_drop";
        case #"hash_9abd51e099d625":
            return "super_fulton";
        case #"hash_59c61d6301a0c38f":
            return "super_vehicle_drop";
        case #"hash_f4e4d96da65cbe0c":
            return "super_sound_veil";
        case #"hash_7c09786dbc292c05":
            return "super_sonar_pulse";
        case #"hash_221cbd05ce8eda95":
            return "super_suppression_rounds";
        case #"hash_1a66514788f13506":
            return "super_reinforcement_flare";
        case #"hash_d83c44d7d3de6d4a":
            return "super_personal_redeploy_drone";
        case #"hash_d7c0526ce6fa6664":
            return "super_oxygen_mask";
        case #"hash_26da5d1481b16057":
            return "super_squadrage";
        case #"hash_4b4a6458f00d9319":
            return "super_hb_sensor";
        case #"hash_d3dba172bb61068c":
            return "super_redeploy_drone_beacon";
    }
    
    return undefined;
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0x1841
// Size: 0x18
function function_2ce015d8f99a66e0( lootid )
{
    return function_e025bb823276187( getscriptablefromlootid( lootid ) );
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0x1862
// Size: 0x5b
function function_e025bb823276187( scriptablename )
{
    if ( !isdefined( scriptablename ) )
    {
        return 0;
    }
    
    if ( !isdefined( level.br_pickups.counts ) || !isdefined( level.br_pickups.counts[ scriptablename ] ) )
    {
        return 0;
    }
    
    return level.br_pickups.counts[ scriptablename ];
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0x18c6
// Size: 0x2f
function function_20be2251dd0a8076( lootid )
{
    if ( !isdefined( level.var_b8122168a1d73b08 ) )
    {
        function_f6b6d73054e210b1();
    }
    
    return array_contains( level.var_b8122168a1d73b08, lootid );
}

// Namespace loot / scripts\cp_mp\utility\loot
// Params 1
// Checksum 0x0, Offset: 0x18fe
// Size: 0x4b
function function_8c610908c0e9c6e4( ref )
{
    if ( !isdefined( level.var_b8122168a1d73b08 ) )
    {
        function_f6b6d73054e210b1();
    }
    
    if ( array_contains( level.var_8d8a8ce3fdb2e872, ref ) )
    {
        return 1;
    }
    
    return array_contains( level.var_b8122168a1d73b08, getlootidfromref( ref ) );
}

