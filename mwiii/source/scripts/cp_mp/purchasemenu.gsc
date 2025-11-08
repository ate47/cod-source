#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace purchasemenu;

// Namespace purchasemenu / scripts\cp_mp\purchasemenu
// Params 0
// Checksum 0x0, Offset: 0xa0
// Size: 0x163
function init()
{
    level.purchasemenu = [];
    
    if ( isdefined( level.gamemodebundle.purchasemenulist ) )
    {
        var_cf4e196fe0e8f2aa = getscriptbundle( level.gamemodebundle.purchasemenulist );
        
        if ( isdefined( level.var_b25a2c14d4e17e75 ) )
        {
            var_cf4e196fe0e8f2aa = getscriptbundle( level.var_b25a2c14d4e17e75 );
        }
        
        if ( isdefined( var_cf4e196fe0e8f2aa ) && isdefined( var_cf4e196fe0e8f2aa.purchasemenus ) )
        {
            foreach ( i, menu in var_cf4e196fe0e8f2aa.purchasemenus )
            {
                if ( isdefined( menu.menuref ) )
                {
                    level.purchasemenu[ menu.menuref ] = function_61a76cc038f69d62( menu.purchasemenu );
                    
                    if ( isdefined( level.purchasemenu[ menu.menuref ] ) )
                    {
                        level.purchasemenu[ menu.menuref ].id = i + 1;
                        level.purchasemenu[ menu.menuref ].ref = menu.menuref;
                    }
                }
            }
        }
    }
}

// Namespace purchasemenu / scripts\cp_mp\purchasemenu
// Params 2
// Checksum 0x0, Offset: 0x20b
// Size: 0x193
function function_904f24ea774b8f6f( menuref, itemindex )
{
    if ( !isdefined( menuref ) || !isdefined( itemindex ) || !isdefined( level.purchasemenu[ menuref ] ) )
    {
        return;
    }
    
    item = level.purchasemenu[ menuref ].items[ itemindex ];
    
    if ( !isdefined( item ) )
    {
        return;
    }
    
    item_bundle = getscriptbundle( item.asset );
    
    if ( isdefined( item_bundle ) )
    {
        item_struct = spawnstruct();
        item_struct.cost = item_bundle.cost;
        item_struct.scriptable_name = item_bundle.scriptablename;
        item_struct.tier = item_bundle.tier;
        item_struct.itemref = item_bundle.itemref;
        item_struct.itemid = item_bundle.itemid;
        item_struct.scalecost = item_bundle.scalecost;
        item_struct.maxstack = item_bundle.maxstack;
        item_struct.category = item.category;
        item_struct.index = itemindex;
        
        if ( isdefined( item_bundle.currency ) )
        {
            var_ba55b52ed97c10f9 = getscriptbundle( item_bundle.currency );
            
            if ( isdefined( var_ba55b52ed97c10f9 ) )
            {
                item_struct.currency = var_ba55b52ed97c10f9.currencyname;
            }
        }
        
        return item_struct;
    }
}

// Namespace purchasemenu / scripts\cp_mp\purchasemenu
// Params 1
// Checksum 0x0, Offset: 0x3a6
// Size: 0x2e0
function function_61a76cc038f69d62( menubundlename )
{
    if ( !isdefined( menubundlename ) )
    {
        return;
    }
    
    var_d74e5bf68df5bc0e = spawnstruct();
    var_d74e5bf68df5bc0e.items = [];
    menubundle = getscriptbundle( menubundlename );
    var_d74e5bf68df5bc0e.var_8b8931f97eef184 = menubundle.var_cf869621963a1479;
    var_d74e5bf68df5bc0e.var_fd0ea8a834fa0398 = menubundle.var_fd0ea8a834fa0398;
    var_d74e5bf68df5bc0e.var_c7ffb2549ca8ab4b = menubundle.var_479e72ccbb6469b4;
    var_d74e5bf68df5bc0e.closenotify = menubundle.var_412c66c598fa294f;
    
    if ( isdefined( menubundle.var_3a5cecc53aff7c5b ) )
    {
        var_97a2bf47be64d1bd = getscriptbundle( menubundle.var_3a5cecc53aff7c5b );
        globalindex = 0;
        
        if ( isdefined( var_97a2bf47be64d1bd ) && isdefined( var_97a2bf47be64d1bd.var_7ba8aecb362b5db7 ) )
        {
            foreach ( tab in var_97a2bf47be64d1bd.var_7ba8aecb362b5db7 )
            {
                tab_bundle = getscriptbundle( tab.var_dd6ac48cdd89da1e );
                var_50ad891a1213acd8 = getscriptbundle( tab_bundle.var_158da238f6c4491e );
                
                foreach ( index, item in var_50ad891a1213acd8.purchaseitems )
                {
                    if ( isdefined( item.purchaseitem ) )
                    {
                        item_struct = spawnstruct();
                        item_struct.asset = item.purchaseitem;
                        item_struct.category = tab_bundle.tabcategory;
                        var_d74e5bf68df5bc0e.items[ globalindex ] = item_struct;
                        globalindex++;
                    }
                }
            }
        }
    }
    else if ( isdefined( menubundle.var_b3d5e4ca666276bc ) )
    {
        tab_bundle = getscriptbundle( menubundle.var_b3d5e4ca666276bc );
        var_50ad891a1213acd8 = getscriptbundle( tab_bundle.var_158da238f6c4491e );
        globalindex = 0;
        
        foreach ( item in var_50ad891a1213acd8.purchaseitems )
        {
            if ( isdefined( item.purchaseitem ) )
            {
                item_struct = spawnstruct();
                item_struct.asset = item.purchaseitem;
                item_struct.category = tab_bundle.tabcategory;
                var_d74e5bf68df5bc0e.items[ globalindex ] = item_struct;
                globalindex++;
            }
        }
    }
    
    return var_d74e5bf68df5bc0e;
}

// Namespace purchasemenu / scripts\cp_mp\purchasemenu
// Params 1
// Checksum 0x0, Offset: 0x68f
// Size: 0x1c
function function_cfd0e1fb13d7e080( ref )
{
    if ( isdefined( ref ) )
    {
        return level.purchasemenu[ ref ];
    }
}

// Namespace purchasemenu / scripts\cp_mp\purchasemenu
// Params 2
// Checksum 0x0, Offset: 0x6b3
// Size: 0x46
function function_fcb72b7f642e750e( ref, index )
{
    if ( isdefined( ref ) && isdefined( index ) && isdefined( level.purchasemenu[ ref ] ) )
    {
        return level.purchasemenu[ ref ].items[ index ];
    }
}

// Namespace purchasemenu / scripts\cp_mp\purchasemenu
// Params 2
// Checksum 0x0, Offset: 0x701
// Size: 0x41, Type: bool
function function_5c9b6f1c3c67dd97( menuref, channel )
{
    if ( isdefined( channel ) && isdefined( level.purchasemenu[ menuref ] ) )
    {
        return ( level.purchasemenu[ menuref ].closenotify == channel );
    }
    
    return false;
}

