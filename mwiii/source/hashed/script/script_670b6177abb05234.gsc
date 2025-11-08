#using scripts\common\callbacks;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\mp\perks\perkpackage;
#using scripts\mp\supers;

#namespace namespace_fe6cb1145ab372e6;

// Namespace namespace_fe6cb1145ab372e6 / namespace_82ee1eb29fe2bc66
// Params 0
// Checksum 0x0, Offset: 0x102
// Size: 0x66
function function_618664c61d5fc27b()
{
    function_900f562c61c6a5d6( "super", &use_super, &function_e887a53cc71c3aa8, undefined, &function_cff48a3ed0e1c4b9, &function_e03ac9e2c2b89d1f );
    function_900f562c61c6a5d6( "zmsuper", &use_super, &function_e887a53cc71c3aa8, undefined, &function_cff48a3ed0e1c4b9, &function_e03ac9e2c2b89d1f );
    callback::add( "player_spawned", &on_player_spawned );
    callback::add( "on_super_use_finished", &on_super_use_finished );
}

// Namespace namespace_fe6cb1145ab372e6 / namespace_82ee1eb29fe2bc66
// Params 0
// Checksum 0x0, Offset: 0x170
// Size: 0x24, Type: bool
function function_9f7dc3012db92250()
{
    return istrue( level.var_921200c3b5274d3e ) || istrue( level.gametypebundle.var_fa35afda033c6691 );
}

// Namespace namespace_fe6cb1145ab372e6 / namespace_82ee1eb29fe2bc66
// Params 1
// Checksum 0x0, Offset: 0x19d
// Size: 0x30
function on_player_spawned( sparams )
{
    if ( !function_9f7dc3012db92250() && isdefined( self.super ) )
    {
        givesuperpoints( getsuperpointsneeded() );
    }
}

// Namespace namespace_fe6cb1145ab372e6 / namespace_82ee1eb29fe2bc66
// Params 2
// Checksum 0x0, Offset: 0x1d5
// Size: 0x43
function use_super( itembundle, item )
{
    if ( !function_9f7dc3012db92250() )
    {
        scripts\mp\perks\perkpackage::perkpackage_giveimmediate( itembundle.ref );
        return ( item.count - 1 );
    }
    
    return 1;
}

// Namespace namespace_fe6cb1145ab372e6 / namespace_82ee1eb29fe2bc66
// Params 4
// Checksum 0x0, Offset: 0x220
// Size: 0x3e
function function_e887a53cc71c3aa8( itembundle, item, autouse, allowswap )
{
    if ( issuperready() || issuperinuse() )
    {
        return 0;
    }
    
    return 1;
}

// Namespace namespace_fe6cb1145ab372e6 / namespace_82ee1eb29fe2bc66
// Params 0
// Checksum 0x0, Offset: 0x266
// Size: 0xb3
function function_cff48a3ed0e1c4b9()
{
    itembundle = undefined;
    quantity = 0;
    
    if ( isdefined( self.super ) )
    {
        if ( issuperinuse() )
        {
            scripts\mp\supers::superusefinished( undefined, undefined, undefined, 1 );
        }
        else if ( issuperready() )
        {
            superref = self.super.staticdata.ref;
            
            if ( !isdefined( superref ) )
            {
                return [ itembundle, quantity ];
            }
            
            superbundlename = function_61d960957fcf3ca0( superref );
            
            if ( isdefined( superbundlename ) )
            {
                itembundle = getscriptbundle( "itemspawnentry:" + superbundlename );
                quantity = 1;
            }
        }
    }
    
    return [ itembundle, quantity ];
}

// Namespace namespace_fe6cb1145ab372e6 / namespace_82ee1eb29fe2bc66
// Params 0
// Checksum 0x0, Offset: 0x322
// Size: 0x19
function function_e03ac9e2c2b89d1f()
{
    setsuperbasepoints( 0, 0 );
    scripts\mp\perks\perkpackage::perkpackage_giveoverridefieldupgrades();
    clearsuper();
}

// Namespace namespace_fe6cb1145ab372e6 / namespace_82ee1eb29fe2bc66
// Params 1
// Checksum 0x0, Offset: 0x343
// Size: 0x25
function on_super_use_finished( sparams )
{
    if ( inventory_isenabled() && !function_9f7dc3012db92250() )
    {
        function_e03ac9e2c2b89d1f();
    }
}

