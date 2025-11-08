#using scripts\common\devgui;
#using scripts\cp_mp\gasmask;
#using scripts\cp_mp\killstreaks\white_phosphorus;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\player;

#namespace namespace_6236231ba2ba2d74;

// Namespace namespace_6236231ba2ba2d74 / namespace_8055140764bdf2f4
// Params 0
// Checksum 0x0, Offset: 0x30b
// Size: 0xcb
function function_db1254dca5eaf211()
{
    level.var_f26b4e7eb9af8155 = &function_cdf7f2f6bd3207;
    level.var_c57ee1e174e42601 = &function_8206bc54a1ed73cb;
    level.gasmaskbreakfunc = &breakgasmask;
    level.var_9e3e0db450eec0f7 = getdvarint( @"hash_41e94c252e1d9247", 1 );
    level.var_28231449ea8976a1 = getdvarint( @"hash_e04e2774c39ed0d1", 1 );
    level.gasmasklootid = function_2c836ad05e5f634c( "gas_mask" );
    level.var_479d8ef7f76a4df6 = function_2c836ad05e5f634c( "gas_mask_durable" );
    level.var_534e97d34ef9fa29 = [ level.gasmasklootid, level.var_479d8ef7f76a4df6 ];
    function_900f562c61c6a5d6( "gasmask", &function_9726a41ef12198aa, &function_921a9118b4577d3e, undefined, &function_95271caae9eaad97, &function_22065872fdfd2315 );
}

// Namespace namespace_6236231ba2ba2d74 / namespace_8055140764bdf2f4
// Params 3
// Checksum 0x0, Offset: 0x3de
// Size: 0x44, Type: bool
function function_9726a41ef12198aa( itembundle, item, autouse )
{
    scripts\cp_mp\gasmask::init( item.count, itembundle.ref, itembundle.maxcount );
    return false;
}

// Namespace namespace_6236231ba2ba2d74 / namespace_8055140764bdf2f4
// Params 4
// Checksum 0x0, Offset: 0x42b
// Size: 0x34, Type: bool
function function_921a9118b4577d3e( itembundle, item, autouse, allowswap )
{
    if ( isdefined( self.gasmaskhealth ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_6236231ba2ba2d74 / namespace_8055140764bdf2f4
// Params 0
// Checksum 0x0, Offset: 0x468
// Size: 0x8e
function function_95271caae9eaad97()
{
    itembundle = undefined;
    quantity = 0;
    
    if ( !scripts\cp_mp\gasmask::hasgasmask( self ) )
    {
        return [ itembundle, quantity ];
    }
    
    var_acdff55c23d1f9f = self.gasmasktype;
    
    if ( !isdefined( var_acdff55c23d1f9f ) )
    {
        return [ itembundle, quantity ];
    }
    
    var_6864ed104531914d = function_61d960957fcf3ca0( var_acdff55c23d1f9f );
    
    if ( isdefined( var_6864ed104531914d ) )
    {
        itembundle = getscriptbundle( "itemspawnentry:" + var_6864ed104531914d );
        quantity = self.gasmaskhealth;
    }
    
    return [ itembundle, quantity ];
}

// Namespace namespace_6236231ba2ba2d74 / namespace_8055140764bdf2f4
// Params 0
// Checksum 0x0, Offset: 0x4ff
// Size: 0x9
function function_22065872fdfd2315()
{
    function_febe5318d593116();
}

// Namespace namespace_6236231ba2ba2d74 / namespace_8055140764bdf2f4
// Params 0
// Checksum 0x0, Offset: 0x510
// Size: 0x68
function function_febe5318d593116()
{
    if ( istrue( self.gasmaskswapinprogress ) )
    {
        waittill_notify_or_timeout( "gas_mask_swap_complete", 2 );
    }
    
    if ( istrue( self.gasmaskequipped ) && istrue( self.var_def787c3aedbce76 ) )
    {
        scripts\cp_mp\gasmask::removegasmask();
        self.gasmaskswapinprogress = 0;
    }
    else
    {
        self [[ level.var_c57ee1e174e42601 ]]( "all" );
    }
    
    scripts\cp_mp\gasmask::cleanupgasmask();
}

// Namespace namespace_6236231ba2ba2d74 / namespace_8055140764bdf2f4
// Params 1
// Checksum 0x0, Offset: 0x580
// Size: 0x48
function function_cdf7f2f6bd3207( request )
{
    if ( !isdefined( self.gasmaskrequests ) )
    {
        self.gasmaskrequests = [];
    }
    
    if ( isdefined( self.gasmaskrequests[ request ] ) )
    {
        return;
    }
    
    self.gasmaskrequests[ request ] = 1;
    thread function_2202e74632488bac();
}

// Namespace namespace_6236231ba2ba2d74 / namespace_8055140764bdf2f4
// Params 1
// Checksum 0x0, Offset: 0x5d0
// Size: 0xaa
function function_8206bc54a1ed73cb( request )
{
    if ( !isdefined( self.gasmaskrequests ) )
    {
        self.gasmaskrequests = [];
    }
    
    if ( request == "all" )
    {
        foreach ( request, data in self.gasmaskrequests )
        {
            self.gasmaskrequests[ request ] = undefined;
        }
        
        thread function_2202e74632488bac();
        return;
    }
    else if ( !isdefined( self.gasmaskrequests[ request ] ) )
    {
        return;
    }
    
    self.gasmaskrequests[ request ] = undefined;
    thread function_2202e74632488bac();
}

// Namespace namespace_6236231ba2ba2d74 / namespace_8055140764bdf2f4
// Params 0
// Checksum 0x0, Offset: 0x682
// Size: 0xb8
function function_2202e74632488bac()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    
    while ( function_aeffe7dc479451ad() )
    {
        wait 0.1;
    }
    
    if ( istrue( self.gasmaskswapinprogress ) )
    {
        waittill_notify_or_timeout( "gas_mask_swap_complete", 2 );
        waitframe();
    }
    
    self notify( "gasMaskUpdateOnOff" );
    self endon( "gasMaskUpdateOnOff" );
    waittillframeend();
    
    if ( istrue( self.gasmaskequipped ) && ( !isdefined( self.gasmaskrequests ) || !self.gasmaskrequests.size ) )
    {
        thread removegasmask();
        return;
    }
    
    if ( !istrue( self.gasmaskequipped ) && isdefined( self.gasmaskrequests ) && self.gasmaskrequests.size )
    {
        thread equipgasmask();
    }
}

// Namespace namespace_6236231ba2ba2d74 / namespace_8055140764bdf2f4
// Params 0
// Checksum 0x0, Offset: 0x742
// Size: 0x4e
function function_aeffe7dc479451ad()
{
    player = self;
    delaygesture = 0;
    delaygesture |= player isreloading();
    delaygesture |= player isthrowinggrenade();
    delaygesture |= player isdiving();
    delaygesture |= player issprintsliding();
    delaygesture |= player scripts\mp\utility\player::isplayerads();
    return delaygesture;
}

// Namespace namespace_6236231ba2ba2d74 / namespace_8055140764bdf2f4
// Params 0
// Checksum 0x0, Offset: 0x799
// Size: 0x52, Type: bool
function function_28b827d98b0cc603()
{
    player = self;
    preventgesture = 0;
    preventgesture |= player isinfreefall();
    preventgesture |= player isparachuting();
    preventgesture |= player isbasejumpavailable();
    
    if ( level.var_28231449ea8976a1 != 0 )
    {
        preventgesture |= player isjumping();
    }
    
    return !preventgesture;
}

// Namespace namespace_6236231ba2ba2d74 / namespace_8055140764bdf2f4
// Params 0
// Checksum 0x0, Offset: 0x7f4
// Size: 0x119
function equipgasmask()
{
    self endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self playsoundtoplayer( "br_gas_mask_on_plr", self );
    self.gasmaskswapinprogress = 1;
    thread delayedattach( 0.2 );
    equipgesturelength = self getgestureanimlength( "iw9_vm_ges_gasmask_on" );
    assert( 0.2 < equipgesturelength );
    
    if ( function_28b827d98b0cc603() )
    {
        thread scripts\mp\gametypes\br_public::playerplaygestureweaponanim( "iw8_ges_plyr_gasmask_on", equipgesturelength );
    }
    
    self setclientomnvar( "ui_gas_mask", 2 );
    wait equipgesturelength;
    self.gasmaskswapinprogress = 0;
    self notify( "gas_mask_swap_complete" );
    self.gasmaskequipped = 1;
    scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
    
    if ( isdefined( self.operatorcustomization.gender ) && self.operatorcustomization.gender == "female" )
    {
        self function_555e2d32e2756625( "gasmask_female" );
    }
    else
    {
        self function_555e2d32e2756625( "gasmask_male" );
    }
    
    if ( isdefined( self.gasmaskhealth ) && self.gasmaskhealth <= 0 )
    {
        breakgasmask();
    }
}

// Namespace namespace_6236231ba2ba2d74 / namespace_8055140764bdf2f4
// Params 0
// Checksum 0x0, Offset: 0x915
// Size: 0x10c
function removegasmask()
{
    self endon( "game_ended" );
    self endon( "death_or_disconnect" );
    
    if ( !istrue( self.gasmaskequipped ) )
    {
        return;
    }
    
    self playsoundtoplayer( "br_gas_mask_off_plr", self );
    fadeouttime = self getgestureanimlength( "iw9_vm_ges_gasmask_off" );
    thread delayeddetach( 1.3 );
    
    if ( function_28b827d98b0cc603() )
    {
        thread scripts\mp\gametypes\br_public::playerplaygestureweaponanim( "iw8_ges_plyr_gasmask_off", fadeouttime );
    }
    
    self.gasmaskswapinprogress = 1;
    self setclientomnvar( "ui_gas_mask", 1 );
    wait fadeouttime;
    self.gasmaskswapinprogress = 0;
    self notify( "gas_mask_swap_complete" );
    scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();
    
    if ( isdefined( self.operatorcustomization.gender ) && self.operatorcustomization.gender == "female" )
    {
        self function_555e2d32e2756625( "female" );
    }
    else
    {
        self function_555e2d32e2756625( "" );
    }
    
    if ( isdefined( self.gasmaskhealth ) && self.gasmaskhealth <= 0 )
    {
        cleanupgasmask();
    }
}

// Namespace namespace_6236231ba2ba2d74 / namespace_8055140764bdf2f4
// Params 0
// Checksum 0x0, Offset: 0xa29
// Size: 0xeb
function breakgasmask()
{
    if ( !istrue( self.gasmaskequipped ) )
    {
        return;
    }
    
    self playsoundtoplayer( "br_gas_mask_crack_plr", self );
    thread delayeddetachbreak( 0.6 );
    
    if ( isdefined( self.operatorcustomization.gender ) && self.operatorcustomization.gender == "female" )
    {
        self function_555e2d32e2756625( "female" );
    }
    else
    {
        self function_555e2d32e2756625( "" );
    }
    
    self playsoundtoplayer( "br_gas_mask_depleted_plr", self );
    cleanupgasmask();
    fadeouttime = self getgestureanimlength( "iw9_vm_ges_gasmask_break" );
    thread scripts\mp\gametypes\br_public::playerplaygestureweaponanim( "iw8_ges_plyr_gasmask_break", fadeouttime );
    self.gasmaskswapinprogress = 1;
    self setclientomnvar( "ui_gas_mask", 3 );
    wait fadeouttime;
    
    if ( isdefined( self ) )
    {
        self.gasmaskswapinprogress = 0;
        self notify( "gas_mask_swap_complete" );
        function_8e9b00a1d2b23d72();
    }
}

// Namespace namespace_6236231ba2ba2d74 / namespace_8055140764bdf2f4
// Params 1
// Checksum 0x0, Offset: 0xb1c
// Size: 0x49
function delayedattach( delaytime )
{
    self endon( "game_end" );
    self endon( "death_or_disconnect" );
    
    if ( isdefined( delaytime ) && delaytime > 0 )
    {
        wait delaytime;
    }
    
    self attach( "hat_child_hadir_gas_mask_wm_br", "j_head" );
    wait 0.5;
    scripts\cp_mp\gasmask::createoverlay();
}

// Namespace namespace_6236231ba2ba2d74 / namespace_8055140764bdf2f4
// Params 1
// Checksum 0x0, Offset: 0xb6d
// Size: 0x65
function delayeddetach( delaytime )
{
    self endon( "game_end" );
    self endon( "death_or_disconnect" );
    wait 0.35;
    scripts\cp_mp\gasmask::destroyoverlay();
    
    if ( isdefined( delaytime ) && delaytime > 0.35 )
    {
        wait delaytime - 0.35;
    }
    
    if ( self.gasmaskequipped )
    {
        self detach( "hat_child_hadir_gas_mask_wm_br", "j_head" );
        self.gasmaskequipped = 0;
    }
}

// Namespace namespace_6236231ba2ba2d74 / namespace_8055140764bdf2f4
// Params 1
// Checksum 0x0, Offset: 0xbda
// Size: 0x65
function delayeddetachbreak( delaytime )
{
    self endon( "game_end" );
    self endon( "death_or_disconnect" );
    scripts\cp_mp\gasmask::destroyoverlay();
    
    if ( isdefined( delaytime ) && delaytime > 0.1 )
    {
        wait delaytime - 0.1;
    }
    
    wait 0.1;
    
    if ( self.gasmaskequipped )
    {
        self detach( "hat_child_hadir_gas_mask_wm_br", "j_head" );
        self.gasmaskequipped = 0;
    }
}

// Namespace namespace_6236231ba2ba2d74 / namespace_8055140764bdf2f4
// Params 0
// Checksum 0x0, Offset: 0xc47
// Size: 0x46
function function_8e9b00a1d2b23d72()
{
    player = self;
    
    if ( !inventory_isenabled() )
    {
        return;
    }
    
    var_d035435a9237f3d = function_b27f0c7dafeadb3( level.var_479d8ef7f76a4df6 );
    
    if ( !var_d035435a9237f3d )
    {
        function_b27f0c7dafeadb3( level.gasmasklootid );
    }
}

// Namespace namespace_6236231ba2ba2d74 / namespace_8055140764bdf2f4
// Params 2
// Checksum 0x0, Offset: 0xc95
// Size: 0x64, Type: bool
function function_b27f0c7dafeadb3( targetlootid, var_6e3ef3bd8bb4967a )
{
    backpacksize = function_1b35b10884bd8d67();
    
    for ( i = 0; i < backpacksize ; i++ )
    {
        currentlootid = function_d870b2c45335bd88( i );
        
        if ( currentlootid == targetlootid )
        {
            if ( !istrue( var_6e3ef3bd8bb4967a ) )
            {
                function_777092be5abab355( i );
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_6236231ba2ba2d74 / namespace_8055140764bdf2f4
// Params 0
// Checksum 0x0, Offset: 0xd02
// Size: 0x47
function cleanupgasmask()
{
    self.gasmaskmaxhealth = undefined;
    self.gasmaskhealth = undefined;
    self.gasmaskrequests = undefined;
    self setclientomnvar( "ui_gas_mask", 0 );
    self setclientomnvar( "ui_head_equip_class", 0 );
    self setclientomnvar( "ui_gasmask_damage", 0 );
}

