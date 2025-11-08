#using scripts\mp\gametypes\br_pickups;

#namespace namespace_27e634277336b001;

// Namespace namespace_27e634277336b001 / namespace_86a7acb508545234
// Params 0
// Checksum 0x0, Offset: 0xf1
// Size: 0xb
function function_e1b062a375b4a629()
{
    return self.plundercount;
}

// Namespace namespace_27e634277336b001 / namespace_86a7acb508545234
// Params 0
// Checksum 0x0, Offset: 0x105
// Size: 0x11
function function_91b0046262bd8519()
{
    return getdvarint( @"scr_br_plunder_start_amount", 0 );
}

// Namespace namespace_27e634277336b001 / namespace_86a7acb508545234
// Params 3
// Checksum 0x0, Offset: 0x11f
// Size: 0x7f
function function_e22745f1660c79de( var_e318e240dd21247, position, cashamount )
{
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo( position );
    
    if ( !isdefined( cashamount ) && isdefined( level.br_pickups.counts[ var_e318e240dd21247 ] ) )
    {
        cashamount = level.br_pickups.counts[ var_e318e240dd21247 ];
    }
    
    item = scripts\mp\gametypes\br_pickups::spawnpickup( var_e318e240dd21247, dropinfo, cashamount );
    
    if ( !isdefined( item ) )
    {
        return;
    }
    
    return item;
}

// Namespace namespace_27e634277336b001 / namespace_86a7acb508545234
// Params 2
// Checksum 0x0, Offset: 0x1a7
// Size: 0x55
function function_72c1ec67d589d251( callback, cashitem )
{
    self endon( "death_or_disconnect" );
    
    if ( isdefined( cashitem ) )
    {
        level waittill( "pickedupweapon_kill_callout_" + cashitem.type + cashitem.origin );
    }
    else
    {
        self waittill( "self_pickedupitem_" + "plunder" );
    }
    
    self [[ callback ]]();
}

// Namespace namespace_27e634277336b001 / namespace_86a7acb508545234
// Params 1
// Checksum 0x0, Offset: 0x204
// Size: 0x41, Type: bool
function function_ad5378568b077260( cashitem )
{
    if ( !isdefined( cashitem ) )
    {
        return false;
    }
    
    itemtype = cashitem.type;
    itemstate = cashitem getscriptablepartstate( itemtype );
    return itemstate != "hidden";
}

// Namespace namespace_27e634277336b001 / namespace_86a7acb508545234
// Params 1
// Checksum 0x0, Offset: 0x24e
// Size: 0x3c
function function_a380cf8dd38a32ee( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.amount ) );
    return function_8635d35b49720a75( params.amount );
}

// Namespace namespace_27e634277336b001 / namespace_86a7acb508545234
// Params 1
// Checksum 0x0, Offset: 0x293
// Size: 0x19, Type: bool
function function_8635d35b49720a75( amount )
{
    return self.plundercount * 10 >= amount;
}

