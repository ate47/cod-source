#using script_18077945bb84ede7;
#using script_19367cd29a4485db;
#using script_2c5daa95f8fec03c;
#using script_5f261a5d57de5f7c;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\healthoverlay;
#using scripts\core_common\item_inventory;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;

#namespace namespace_791d0451;

// Namespace namespace_791d0451/namespace_791d0451
// Params 0, eflags: 0x5
// Checksum 0x8ab3b54a, Offset: 0x298
// Size: 0x4c
function private autoexec __init__system__()
{
    system::register( #"hash_2d064899850813e2", &preinit, &postinit, undefined, undefined );
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 0
// Checksum 0x6f58e92e, Offset: 0x2f0
// Size: 0x63c
function preinit()
{
    level.var_fcb9f1fb = [];
    callback::on_spawned( &on_player_spawn );
    callback::on_item_pickup( &on_item_pickup );
    
    /#
        level.var_c0f77370 = &function_c0f77370;
    #/
    
    level.var_c723ac75 = [];
    function_e854b81f( #"talent_juggernog", #"talent_juggernog_1", #"talent_juggernog_2", #"talent_juggernog_3", #"talent_juggernog_4", #"talent_juggernog_5" );
    function_e854b81f( #"talent_quickrevive", #"talent_quickrevive_1", #"talent_quickrevive_2", #"talent_quickrevive_3", #"talent_quickrevive_4", #"talent_quickrevive_5" );
    function_e854b81f( #"talent_speedcola", #"talent_speedcola_1", #"talent_speedcola_2", #"talent_speedcola_3", #"talent_speedcola_4", #"talent_speedcola_5" );
    function_e854b81f( #"talent_doubletap", #"talent_doubletap", #"talent_doubletap", #"talent_doubletap", #"talent_doubletap", #"talent_doubletap" );
    function_e854b81f( #"talent_deadshot", #"talent_deadshot_1", #"talent_deadshot_2", #"talent_deadshot_3", #"talent_deadshot_4", #"talent_deadshot_5" );
    function_e854b81f( #"talent_staminup", #"talent_staminup_1", #"talent_staminup_2", #"talent_staminup_3", #"talent_staminup_4", #"talent_staminup_5" );
    function_e854b81f( #"talent_elemental_pop", #"talent_elemental_pop_1", #"talent_elemental_pop_2", #"talent_elemental_pop_3", #"talent_elemental_pop_4", #"talent_elemental_pop_5" );
    function_e854b81f( #"talent_tombstone", #"talent_tombstone_1", #"talent_tombstone_2", #"talent_tombstone_3", #"talent_tombstone_4", #"talent_tombstone_5" );
    function_e854b81f( #"talent_mulekick", #"talent_mulekick_1", #"talent_mulekick_2", #"talent_mulekick_3", #"talent_mulekick_4", #"talent_mulekick_5" );
    function_e854b81f( #"talent_deathperception", #"talent_deathperception_1", #"talent_deathperception_2", #"talent_deathperception_3", #"talent_deathperception_4", #"talent_deathperception_5" );
    function_e854b81f( #"talent_phdslider", #"talent_phdslider_1", #"talent_phdslider_2", #"talent_phdslider_3", #"talent_phdslider_4", #"talent_phdslider_5" );
    clientfield::register_clientuimodel( "zm_perks_per_controller.count", 1, 4, "int", 0 );
    
    for ( i = 1; i <= 10 ; i++ )
    {
        clientfield::register_clientuimodel( "zm_perks_per_controller." + i + ".itemIndex", 1, 8, "int", 0 );
        clientfield::register_clientuimodel( "zm_perks_per_controller." + i + ".lost", 1, 2, "int", 0 );
    }
    
    callback::add_callback( #"on_host_migration_end", &on_host_migration_end );
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 0
// Checksum 0x80f724d1, Offset: 0x938
// Size: 0x4
function postinit()
{
    
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 2, eflags: 0x40 variadic
// Checksum 0x8f5ae42d, Offset: 0x948
// Size: 0xf8
function function_e854b81f( var_24303d72, ... )
{
    var_50846129 = [];
    
    if ( !isdefined( var_50846129 ) )
    {
        var_50846129 = [];
    }
    else if ( !isarray( var_50846129 ) )
    {
        var_50846129 = array( var_50846129 );
    }
    
    var_50846129[ var_50846129.size ] = var_24303d72;
    
    for ( i = 0; i < vararg.size ; i++ )
    {
        if ( !isdefined( var_50846129 ) )
        {
            var_50846129 = [];
        }
        else if ( !isarray( var_50846129 ) )
        {
            var_50846129 = array( var_50846129 );
        }
        
        var_50846129[ var_50846129.size ] = vararg[ i ];
    }
    
    level.var_c723ac75[ var_24303d72 ] = var_50846129;
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 2
// Checksum 0x5fb838be, Offset: 0xa48
// Size: 0xca
function function_1b16bd84( var_24303d72, tier )
{
    var_8c590502 = isdefined( getgametypesetting( #"hash_3c2c78e639bfd3c6" ) ) ? getgametypesetting( #"hash_3c2c78e639bfd3c6" ) : 0;
    
    if ( var_8c590502 > 0 )
    {
        tier = var_8c590502;
    }
    
    var_50846129 = level.var_c723ac75[ var_24303d72 ];
    
    if ( !isdefined( var_50846129 ) )
    {
        return var_24303d72;
    }
    
    talent = var_50846129[ tier ];
    
    if ( !isdefined( talent ) )
    {
        return var_24303d72;
    }
    
    return talent;
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 2
// Checksum 0x65dd0f4c, Offset: 0xb20
// Size: 0x34
function function_1050b262( talent, func )
{
    if ( isdefined( talent ) && isdefined( func ) )
    {
        level.var_fcb9f1fb[ talent ] = func;
    }
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 1
// Checksum 0x728a473e, Offset: 0xb60
// Size: 0xbc, Type: bool
function function_56cedda7( perk )
{
    if ( !isplayer( self ) || !isdefined( self.var_7341f980 ) )
    {
        return false;
    }
    
    foreach ( var_7387d8e1 in self.var_7341f980 )
    {
        if ( perk == var_7387d8e1 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 1
// Checksum 0xe2d96fcf, Offset: 0xc28
// Size: 0xa2
function function_12b698fa( statname )
{
    var_8c590502 = isdefined( getgametypesetting( #"hash_3c2c78e639bfd3c6" ) ) ? getgametypesetting( #"hash_3c2c78e639bfd3c6" ) : 0;
    
    if ( var_8c590502 > 0 )
    {
        return var_8c590502;
    }
    
    return self stats::function_6d50f14b( #"cacloadouts", #"upgrade_tiers", statname );
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 1
// Checksum 0x30fa7d16, Offset: 0xcd8
// Size: 0xc2
function function_b852953c( var_aac3d74d )
{
    item_index = getitemindexfromref( var_aac3d74d );
    var_438da649 = function_b143666d( item_index, 5 );
    var_40e28ba = var_438da649.var_cd070e56;
    
    if ( !isdefined( var_40e28ba ) || var_40e28ba == #"" )
    {
        return var_aac3d74d;
    }
    
    tier = self function_12b698fa( var_40e28ba );
    return function_1b16bd84( var_aac3d74d, tier );
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 0
// Checksum 0xf7547f60, Offset: 0xda8
// Size: 0x182
function function_a0a66726()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_7341f980 ) )
    {
        return;
    }
    
    var_fc14f601 = [];
    
    foreach ( var_91b99f7 in self.var_7341f980 )
    {
        itemindex = 0;
        
        if ( isdefined( var_91b99f7 ) && ishash( var_91b99f7 ) && var_91b99f7 != #"" )
        {
            itemindex = getitemindexfromref( var_91b99f7 );
        }
        
        if ( itemindex > 0 )
        {
            if ( !isdefined( var_fc14f601 ) )
            {
                var_fc14f601 = [];
            }
            else if ( !isarray( var_fc14f601 ) )
            {
                var_fc14f601 = array( var_fc14f601 );
            }
            
            if ( !isinarray( var_fc14f601, var_91b99f7 ) )
            {
                var_fc14f601[ var_fc14f601.size ] = var_91b99f7;
            }
        }
    }
    
    self.var_7341f980 = var_fc14f601;
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 0
// Checksum 0xc1749a7e, Offset: 0xf38
// Size: 0x22c
function function_a173ab53()
{
    if ( !isplayer( self ) )
    {
        return 0;
    }
    
    self function_a0a66726();
    count = 0;
    
    if ( isdefined( self.var_7341f980 ) )
    {
        count = self.var_7341f980.size;
        
        for ( i = 1; i <= 10 ; i++ )
        {
            itemindex = 0;
            var_91b99f7 = self.var_7341f980[ i - 1 ];
            
            if ( isdefined( var_91b99f7 ) )
            {
                itemindex = getitemindexfromref( var_91b99f7 );
            }
            
            clientfield::set_player_uimodel( "zm_perks_per_controller." + i + ".itemIndex", itemindex );
            var_58257a54 = 0;
            
            if ( isdefined( self.var_1f3077f0 ) )
            {
                foreach ( var_9aaeaf22 in self.var_1f3077f0 )
                {
                    if ( var_9aaeaf22 === var_91b99f7 )
                    {
                        var_58257a54 = 1;
                        break;
                    }
                }
            }
            
            if ( self namespace_e86ffa8::function_33d837e4( 5 ) )
            {
                clientfield::set_player_uimodel( "zm_perks_per_controller." + i + ".lost", 2 );
                continue;
            }
            
            clientfield::set_player_uimodel( "zm_perks_per_controller." + i + ".lost", var_58257a54 );
        }
    }
    
    clientfield::set_player_uimodel( "zm_perks_per_controller.count", count );
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 0
// Checksum 0x3b0dc1a6, Offset: 0x1170
// Size: 0x3c
function function_4c5d2b62()
{
    cost = 2500;
    
    if ( isdefined( self.var_7341f980 ) )
    {
        cost += self.var_7341f980.size * 500;
    }
    
    return cost;
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 3
// Checksum 0x2b8e5759, Offset: 0x11b8
// Size: 0xc30
function function_3fecad82( talent, var_6e2cc6cb = 1, var_96b5aff5 = #"" )
{
    if ( !isplayer( self ) || !isdefined( self.var_7341f980 ) )
    {
        return;
    }
    
    round_number = zm_utility::get_round_number();
    
    if ( self.var_7341f980.size == 0 && zm_utility::is_classic() )
    {
        self.var_5c68806 = [];
        self.var_c545ae9c = round_number;
        self.var_5c68806[ round_number ] = talent;
        self.var_5c68806[ round_number + 1 ] = #"none";
        self.var_5c68806[ round_number + 2 ] = #"none";
        self.var_5c68806[ round_number + 3 ] = #"none";
        self.var_5c68806[ round_number + 4 ] = #"none";
        self.var_5c68806[ round_number + 5 ] = #"none";
        self.var_5c68806[ round_number + 6 ] = #"none";
        self.var_5c68806[ round_number + 7 ] = #"none";
        self.var_5c68806[ round_number + 8 ] = #"none";
        self.var_5c68806[ round_number + 9 ] = #"none";
    }
    else if ( isdefined( self.var_5c68806 ) && isdefined( self.var_c545ae9c ) && zm_utility::is_classic() )
    {
        if ( !isinarray( self.var_5c68806, talent ) )
        {
            self.var_5c68806[ round_number ] = talent;
        }
        
        var_55c38743 = 1;
        
        for ( i = 0; i < 10 ; i++ )
        {
            if ( self.var_5c68806[ self.var_c545ae9c + i ] == #"none" )
            {
                var_55c38743 = 0;
            }
        }
        
        if ( var_55c38743 )
        {
            self zm_stats::increment_challenge_stat( #"hash_9f4ad7eba874404" );
        }
    }
    
    if ( !isdefined( self.var_7341f980 ) )
    {
        self.var_7341f980 = [];
    }
    else if ( !isarray( self.var_7341f980 ) )
    {
        self.var_7341f980 = array( self.var_7341f980 );
    }
    
    if ( !isinarray( self.var_7341f980, talent ) )
    {
        self.var_7341f980[ self.var_7341f980.size ] = talent;
    }
    
    self function_a173ab53();
    self item_inventory::function_9f438f15();
    
    if ( isdefined( level.var_fcb9f1fb ) && isdefined( level.var_fcb9f1fb[ talent ] ) )
    {
        self [[ level.var_fcb9f1fb[ talent ] ]]();
    }
    
    self notify( #"perk_acquired", { #var_16c042b8:talent } );
    
    switch ( talent )
    {
        case #"talent_quickrevive_2":
        case #"talent_quickrevive_3":
        case #"talent_quickrevive_1":
        case #"talent_quickrevive_4":
        case #"talent_quickrevive_5":
        case #"talent_quickrevive":
            var_6d3b160e = self.var_7341f980[ self.var_7341f980.size - 1 ];
            
            if ( var_6d3b160e != #"talent_quickrevive" || var_6d3b160e != #"talent_quickrevive_1" || var_6d3b160e != #"talent_quickrevive_2" || var_6d3b160e != #"talent_quickrevive_3" || var_6d3b160e != #"talent_quickrevive_4" || var_6d3b160e != #"talent_quickrevive_5" )
            {
                self.var_7341f980[ self.var_7341f980.size - 1 ] = self.var_7341f980[ 0 ];
                self.var_7341f980[ 0 ] = var_6d3b160e;
            }
            
            if ( var_6e2cc6cb )
            {
                self perk_give_bottle_begin( #"talent_quickrevive" );
            }
            
            break;
        case #"talent_speedcola":
        case #"talent_speedcola_1":
        case #"talent_speedcola_2":
        case #"talent_speedcola_3":
        case #"talent_speedcola_4":
        case #"talent_speedcola_5":
            if ( var_6e2cc6cb )
            {
                self perk_give_bottle_begin( #"talent_speedcola" );
            }
            
            break;
        case #"talent_deadshot_3":
        case #"talent_deadshot_5":
        case #"talent_deadshot_4":
        case #"talent_deadshot_2":
        case #"talent_deadshot_1":
        case #"talent_deadshot":
            if ( var_6e2cc6cb )
            {
                self perk_give_bottle_begin( #"talent_deadshot" );
            }
            
            break;
        case #"talent_doubletap":
        case #"talent_doubletap":
        case #"talent_doubletap":
        case #"talent_doubletap":
        case #"talent_doubletap":
        case #"talent_doubletap":
            if ( var_6e2cc6cb )
            {
                self perk_give_bottle_begin( #"talent_doubletap" );
            }
            
            break;
        case #"talent_juggernog":
        case #"talent_juggernog_5":
        case #"talent_juggernog_4":
        case #"talent_juggernog_1":
        case #"talent_juggernog_3":
        case #"talent_juggernog_2":
            if ( var_6e2cc6cb )
            {
                self perk_give_bottle_begin( #"talent_juggernog" );
            }
            
            healthoverlay::function_d2880c8f();
            break;
        case #"talent_staminup_3":
        case #"talent_staminup_4":
        case #"talent_staminup_5":
        case #"talent_staminup_2":
        case #"talent_staminup_1":
        case #"talent_staminup":
            if ( var_6e2cc6cb )
            {
                self perk_give_bottle_begin( #"talent_staminup" );
            }
            
            break;
        case #"talent_elemental_pop":
        case #"talent_elemental_pop_2":
        case #"talent_elemental_pop_3":
        case #"talent_elemental_pop_1":
        case #"talent_elemental_pop_4":
        case #"talent_elemental_pop_5":
            if ( var_6e2cc6cb )
            {
                self perk_give_bottle_begin( #"talent_elemental_pop" );
            }
            
            break;
        case #"talent_tombstone":
        case #"talent_tombstone_5":
        case #"talent_tombstone_1":
        case #"talent_tombstone_2":
        case #"talent_tombstone_3":
        case #"talent_tombstone_4":
            if ( var_6e2cc6cb )
            {
                self perk_give_bottle_begin( #"talent_tombstone" );
            }
            
            break;
        case #"talent_mulekick_5":
        case #"talent_mulekick_4":
        case #"talent_mulekick_3":
        case #"talent_mulekick_2":
        case #"talent_mulekick_1":
        case #"talent_mulekick":
            if ( var_6e2cc6cb )
            {
                self perk_give_bottle_begin( #"talent_mulekick" );
            }
            
            break;
        case #"talent_deathperception":
        case #"talent_deathperception_2":
        case #"talent_deathperception_3":
        case #"talent_deathperception_4":
        case #"talent_deathperception_5":
        case #"talent_deathperception_1":
            if ( var_6e2cc6cb )
            {
                self perk_give_bottle_begin( #"talent_deathperception" );
            }
            
            break;
        case #"talent_phdslider_3":
        case #"talent_phdslider_2":
        case #"talent_phdslider_5":
        case #"talent_phdslider_4":
        case #"talent_phdslider":
        case #"talent_phdslider_1":
            if ( var_6e2cc6cb )
            {
                self perk_give_bottle_begin( #"talent_phdslider" );
            }
            
            break;
    }
    
    self.var_77c69799 += 1;
    self function_b4083162( talent, var_96b5aff5 );
    var_3dab8681 = namespace_e86ffa8::function_cde018a9( talent );
    
    if ( isdefined( level._custom_perks[ var_3dab8681 ] ) && isdefined( level._custom_perks[ var_3dab8681 ].player_thread_give ) )
    {
        self thread [[ level._custom_perks[ var_3dab8681 ].player_thread_give ]]();
    }
    
    if ( isdefined( level._custom_perks[ var_3dab8681 ] ) && isdefined( level._custom_perks[ var_3dab8681 ].clientfield_set ) )
    {
        self [[ level._custom_perks[ var_3dab8681 ].clientfield_set ]]( 1 );
    }
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 2, eflags: 0x4
// Checksum 0x2c8cbfe6, Offset: 0x1df0
// Size: 0x1cc
function private function_b4083162( talent, var_96b5aff5 )
{
    if ( isplayer( self ) )
    {
        switch ( var_96b5aff5 )
        {
            case 1:
                source = #"world";
                break;
            case 2:
                source = #"wonderfizz";
                break;
            default:
                source = #"perk machine";
                break;
        }
        
        var_4f88d102 = { #var_aa8a99e8:function_f8d53445(), #var_13f78fc7:zm_utility::function_e3025ca5(), #var_75c4407f:zm_utility::get_round_number(), #perk:talent, #var_96b5aff5:source, #var_2abfe4d3:self.var_77c69799, #perks_active:self.var_7341f980.size, #var_fa7f8efb:self namespace_2a9f256a::function_6f3fd157() };
        self function_678f57c8( #"dlog_event_zm_perks", var_4f88d102 );
    }
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 0, eflags: 0x4
// Checksum 0x70b9e50b, Offset: 0x1fc8
// Size: 0x54, Type: bool
function private function_2cceca7b()
{
    return self isgrappling() || self isusingoffhand() || self function_55acff10( 1 );
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 1
// Checksum 0xec59f6f4, Offset: 0x2028
// Size: 0x94
function perk_give_bottle_begin( str_perk )
{
    if ( !function_2cceca7b() )
    {
        weapon = get_perk_weapon( str_perk );
        self giveweapon( weapon );
        self switchtooffhand( weapon );
        self thread gestures::function_f3e2696f( self, weapon, undefined, 2.5, undefined, undefined, undefined );
    }
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 1
// Checksum 0xb7fb8d3f, Offset: 0x20c8
// Size: 0x2e2
function get_perk_weapon( str_perk )
{
    switch ( str_perk )
    {
        case #"talent_quickrevive":
            weapon = getweapon( #"zombie_perk_bottle_revive" );
            return weapon;
        case #"talent_speedcola":
            weapon = getweapon( #"zombie_perk_bottle_sleight" );
            return weapon;
        case #"talent_deadshot":
            weapon = getweapon( #"zombie_perk_bottle_deadshot" );
            return weapon;
        case #"talent_doubletap":
            weapon = getweapon( #"zombie_perk_bottle_doubletap" );
            return weapon;
        case #"talent_juggernog":
            weapon = getweapon( #"zombie_perk_bottle_jugg" );
            return weapon;
        case #"talent_staminup":
            weapon = getweapon( #"zombie_perk_bottle_marathon" );
            return weapon;
        case #"talent_elemental_pop":
            weapon = getweapon( #"zombie_perk_bottle_elemental_pop" );
            return weapon;
        case #"talent_tombstone":
            weapon = getweapon( #"zombie_perk_bottle_tombstone" );
            return weapon;
        case #"talent_mulekick":
            weapon = getweapon( #"zombie_perk_bottle_mulekick" );
            return weapon;
        case #"talent_deathperception":
            weapon = getweapon( #"zombie_perk_bottle_death_perception" );
            return weapon;
        case #"talent_phdslider":
            weapon = getweapon( #"zombie_perk_bottle_slider" );
            return weapon;
    }
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 3
// Checksum 0xa0afdef5, Offset: 0x23b8
// Size: 0x2cc
function function_4c1d0e25( perk, var_b2d43592 = 0, var_cd9efd85 = 0 )
{
    if ( !isplayer( self ) || !isdefined( self.var_7341f980 ) )
    {
        return;
    }
    
    if ( var_b2d43592 )
    {
        self.var_1f3077f0 = isdefined( self.var_1f3077f0 ) ? self.var_1f3077f0 : [];
        
        if ( !isdefined( self.var_1f3077f0 ) )
        {
            self.var_1f3077f0 = [];
        }
        else if ( !isarray( self.var_1f3077f0 ) )
        {
            self.var_1f3077f0 = array( self.var_1f3077f0 );
        }
        
        self.var_1f3077f0[ self.var_1f3077f0.size ] = perk;
        
        if ( var_cd9efd85 )
        {
            self.var_ff5d288f = isdefined( self.var_ff5d288f ) ? self.var_ff5d288f : [];
            
            if ( !isdefined( self.var_ff5d288f ) )
            {
                self.var_ff5d288f = [];
            }
            else if ( !isarray( self.var_ff5d288f ) )
            {
                self.var_ff5d288f = array( self.var_ff5d288f );
            }
            
            self.var_ff5d288f[ self.var_ff5d288f.size ] = perk;
        }
        
        self function_a173ab53();
        return;
    }
    
    arrayremovevalue( self.var_7341f980, perk );
    self function_a173ab53();
    self item_inventory::function_9f438f15();
    var_3dab8681 = namespace_e86ffa8::function_cde018a9( perk );
    
    if ( isdefined( level._custom_perks[ var_3dab8681 ] ) && isdefined( level._custom_perks[ var_3dab8681 ].clientfield_set ) )
    {
        self [[ level._custom_perks[ var_3dab8681 ].clientfield_set ]]( 0 );
    }
    
    if ( isdefined( level._custom_perks[ var_3dab8681 ] ) && isdefined( level._custom_perks[ var_3dab8681 ].player_thread_take ) )
    {
        self thread [[ level._custom_perks[ var_3dab8681 ].player_thread_take ]]( 0, undefined, undefined, -1 );
    }
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 0
// Checksum 0xfe47ab01, Offset: 0x2690
// Size: 0xca
function function_4af7e89f()
{
    if ( !isplayer( self ) || !isdefined( self.var_1f3077f0 ) )
    {
        return;
    }
    
    foreach ( perk in self.var_1f3077f0 )
    {
        self function_4c1d0e25( perk );
    }
    
    self.var_1f3077f0 = undefined;
    self.var_ff5d288f = undefined;
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 0
// Checksum 0xc74116da, Offset: 0x2768
// Size: 0x32
function on_player_spawn()
{
    if ( !isdefined( self.var_7341f980 ) )
    {
        self.var_7341f980 = [];
    }
    
    if ( !isdefined( self.var_77c69799 ) )
    {
        self.var_77c69799 = 0;
    }
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 1
// Checksum 0xfda2cb7f, Offset: 0x27a8
// Size: 0x170
function on_item_pickup( params )
{
    item = params.item;
    
    if ( isplayer( self ) )
    {
        if ( isdefined( item.itementry ) )
        {
            if ( item.itementry.itemtype === #"survival_perk" )
            {
                if ( isdefined( item.itementry.talents ) )
                {
                    foreach ( talent in item.itementry.talents )
                    {
                        if ( isdefined( talent.talent ) )
                        {
                            talent = self function_b852953c( talent.talent );
                            function_3fecad82( talent, 1, 1 );
                        }
                    }
                }
                
                return;
            }
            
            if ( item.itementry.itemtype === #"armor" )
            {
            }
        }
    }
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 1
// Checksum 0x6ce2df1e, Offset: 0x2920
// Size: 0x3c
function on_host_migration_end( *params )
{
    if ( isplayer( self ) )
    {
        self item_inventory::function_9f438f15();
    }
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 1
// Checksum 0x2cdef2e9, Offset: 0x2968
// Size: 0x222
function function_c5fb4741( var_79291fdb = 0 )
{
    self endon( #"death" );
    self endon( #"hash_7d1062382b3d7c69" );
    var_3354472e = array( "mus_perks_jugganog_jingle", "mus_perks_speed_jingle", "mus_perks_revive_jingle", "mus_perks_stamin_jingle", "mus_perks_deadshot_jingle", "mus_perks_elementalpop_jingle", "mus_perks_tombstone_jingle", "mus_perks_mulekick_jingle", "mus_perks_deathperception_jingle", "mus_perks_phd_jingle" );
    var_8f2bdcca = self function_381f04ca();
    
    while ( true )
    {
        wait randomintrange( 120, 300 );
        
        if ( self ishidden() )
        {
            continue;
        }
        
        if ( var_79291fdb )
        {
            var_8f2bdcca = var_3354472e[ randomintrange( 0, var_3354472e.size ) ];
        }
        
        if ( !is_true( self.var_c000552f ) && isdefined( var_8f2bdcca ) )
        {
            self.var_c000552f = 1;
            var_dfeb1fd = float( max( isdefined( soundgetplaybacktime( var_8f2bdcca ) ) ? soundgetplaybacktime( var_8f2bdcca ) : 500, 500 ) ) / 1000;
            playsoundatposition( var_8f2bdcca, self.origin + ( 0, 0, 50 ) );
            wait var_dfeb1fd;
            self.var_c000552f = 0;
        }
    }
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 0
// Checksum 0x8dc8661b, Offset: 0x2b98
// Size: 0x17e
function function_381f04ca()
{
    str_alias = undefined;
    
    if ( isdefined( self.targetname ) )
    {
        switch ( self.targetname )
        {
            case #"vending_revive":
                str_alias = "mus_perks_revive_jingle";
                break;
            case #"vending_sleight":
                str_alias = "mus_perks_speed_jingle";
                break;
            case #"vending_marathon":
                str_alias = "mus_perks_stamin_jingle";
                break;
            case #"vending_deadshot":
                str_alias = "mus_perks_deadshot_jingle";
                break;
            case #"vending_elemental_pop":
                str_alias = "mus_perks_elementalpop_jingle";
                break;
            case #"vending_jugg":
                str_alias = "mus_perks_jugganog_jingle";
                break;
            case #"vending_tombstone":
                str_alias = "mus_perks_tombstone_jingle";
                break;
            case #"vending_mulekick":
                str_alias = "mus_perks_mulekick_jingle";
                break;
            case #"vending_deathperception":
                str_alias = "mus_perks_deathperception_jingle";
                break;
            case #"vending_divetonuke":
                str_alias = "mus_perks_phd_jingle";
                break;
        }
    }
    
    return str_alias;
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 1
// Checksum 0xb049032, Offset: 0x2d20
// Size: 0x606
function function_3e9d8a8e( var_11868f5d )
{
    self endon( #"death" );
    
    if ( is_true( self.var_c000552f ) )
    {
        return;
    }
    
    str_alias = undefined;
    
    switch ( var_11868f5d )
    {
        case #"talent_juggernog":
        case #"talent_juggernog_5":
        case #"talent_juggernog_4":
        case #"talent_juggernog_1":
        case #"talent_juggernog_3":
        case #"talent_juggernog_2":
            str_alias = #"mus_perks_jugganog_sting";
            break;
        case #"talent_quickrevive_1":
        case #"talent_quickrevive":
        case #"talent_quickrevive_2":
        case #"talent_quickrevive_3":
        case #"talent_quickrevive_4":
        case #"talent_quickrevive_5":
            str_alias = #"mus_perks_revive_sting";
            break;
        case #"talent_speedcola":
        case #"talent_speedcola_5":
        case #"talent_speedcola_4":
        case #"talent_speedcola_3":
        case #"talent_speedcola_2":
        case #"talent_speedcola_1":
            str_alias = #"mus_perks_speed_sting";
            break;
        case #"talent_deadshot_1":
        case #"talent_deadshot":
        case #"talent_deadshot_3":
        case #"talent_deadshot_5":
        case #"talent_deadshot_4":
        case #"talent_deadshot_2":
            str_alias = #"mus_perks_deadshot_sting";
            break;
        case #"talent_staminup_2":
        case #"talent_staminup_1":
        case #"talent_staminup":
        case #"talent_staminup_5":
        case #"talent_staminup_4":
        case #"talent_staminup_3":
            str_alias = #"mus_perks_stamin_sting";
            break;
        case #"talent_elemental_pop":
        case #"talent_elemental_pop_2":
        case #"talent_elemental_pop_3":
        case #"talent_elemental_pop_1":
        case #"talent_elemental_pop_4":
        case #"talent_elemental_pop_5":
            str_alias = #"mus_perks_elementalpop_sting";
            break;
        case #"talent_doubletap":
        case #"talent_doubletap":
        case #"talent_doubletap":
        case #"talent_doubletap":
        case #"talent_doubletap":
        case #"talent_doubletap":
            str_alias = #"hash_25791821a46525d9";
            break;
        case #"talent_tombstone_5":
        case #"talent_tombstone_1":
        case #"talent_tombstone_2":
        case #"talent_tombstone_3":
        case #"talent_tombstone_4":
        case #"talent_tombstone":
            str_alias = #"mus_perks_tombstone_sting";
            break;
        case #"talent_mulekick_5":
        case #"talent_mulekick_4":
        case #"talent_mulekick_3":
        case #"talent_mulekick_2":
        case #"talent_mulekick_1":
        case #"talent_mulekick":
            if ( self.targetname === "wonderfizz" )
            {
                str_alias = #"mus_perks_mulekick_sting";
            }
            else
            {
                str_alias = #"hash_239089c47153028b";
            }
            
            break;
        case #"talent_deathperception":
        case #"talent_deathperception_2":
        case #"talent_deathperception_3":
        case #"talent_deathperception_4":
        case #"talent_deathperception_5":
        case #"talent_deathperception_1":
            str_alias = #"mus_perks_deathperception_sting";
            break;
        case #"talent_phdslider_5":
        case #"talent_phdslider":
        case #"talent_phdslider_1":
        case #"talent_phdslider_3":
        case #"talent_phdslider_2":
        case #"talent_phdslider_4":
            str_alias = #"mus_perks_phd_sting";
            break;
    }
    
    if ( isdefined( str_alias ) )
    {
        self.var_c000552f = 1;
        playsoundatposition( str_alias, self.origin + ( 0, 0, 50 ) );
        wait 5;
        self.var_c000552f = 0;
    }
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 1
// Checksum 0x704abce, Offset: 0x3330
// Size: 0x6d6, Type: bool
function function_cc0055e9( talent )
{
    if ( !isdefined( talent ) )
    {
        return false;
    }
    
    switch ( talent )
    {
        case #"talent_juggernog":
        case #"talent_juggernog_5":
        case #"talent_juggernog_4":
        case #"talent_juggernog_1":
        case #"talent_juggernog_3":
        case #"talent_juggernog_2":
            if ( !is_true( getgametypesetting( #"hash_350adc73849f66ad" ) ) )
            {
                return false;
            }
            
            break;
        case #"talent_quickrevive_1":
        case #"talent_quickrevive":
        case #"talent_quickrevive_2":
        case #"talent_quickrevive_3":
        case #"talent_quickrevive_4":
        case #"talent_quickrevive_5":
            if ( !is_true( getgametypesetting( #"hash_790760c24def02df" ) ) )
            {
                return false;
            }
            
            break;
        case #"talent_speedcola":
        case #"talent_speedcola_5":
        case #"talent_speedcola_4":
        case #"talent_speedcola_3":
        case #"talent_speedcola_2":
        case #"talent_speedcola_1":
            if ( !is_true( getgametypesetting( #"hash_3ad94f36f9fe01c3" ) ) )
            {
                return false;
            }
            
            break;
        case #"talent_deadshot_1":
        case #"talent_deadshot":
        case #"talent_deadshot_3":
        case #"talent_deadshot_5":
        case #"talent_deadshot_4":
        case #"talent_deadshot_2":
            if ( !is_true( getgametypesetting( #"hash_6c0eea959e1beea9" ) ) )
            {
                return false;
            }
            
            break;
        case #"talent_staminup_2":
        case #"talent_staminup_1":
        case #"talent_staminup":
        case #"talent_staminup_5":
        case #"talent_staminup_4":
        case #"talent_staminup_3":
            if ( !is_true( getgametypesetting( #"hash_1eae2946efd5fc50" ) ) )
            {
                return false;
            }
            
            break;
        case #"talent_elemental_pop":
        case #"talent_elemental_pop_2":
        case #"talent_elemental_pop_3":
        case #"talent_elemental_pop_1":
        case #"talent_elemental_pop_4":
        case #"talent_elemental_pop_5":
            if ( !is_true( getgametypesetting( #"hash_4a821fd3ce297dbb" ) ) )
            {
                return false;
            }
            
            break;
        case #"talent_doubletap":
        case #"talent_doubletap":
        case #"talent_doubletap":
        case #"talent_doubletap":
        case #"talent_doubletap":
        case #"talent_doubletap":
            return false;
        case #"talent_tombstone_5":
        case #"talent_tombstone_1":
        case #"talent_tombstone_2":
        case #"talent_tombstone_3":
        case #"talent_tombstone_4":
        case #"talent_tombstone":
            if ( !is_true( getgametypesetting( #"hash_21f347fcb9fbef2a" ) ) )
            {
                return false;
            }
            
            break;
        case #"talent_mulekick_5":
        case #"talent_mulekick_4":
        case #"talent_mulekick_3":
        case #"talent_mulekick_2":
        case #"talent_mulekick_1":
        case #"talent_mulekick":
            if ( !is_true( getgametypesetting( #"hash_616a22c5c1ebe5b8" ) ) )
            {
                return false;
            }
            
            break;
        case #"talent_deathperception":
        case #"talent_deathperception_2":
        case #"talent_deathperception_3":
        case #"talent_deathperception_4":
        case #"talent_deathperception_5":
        case #"talent_deathperception_1":
            if ( !is_true( getgametypesetting( #"hash_45fa8995b51490e8" ) ) )
            {
                return false;
            }
            
            break;
        case #"talent_phdslider_5":
        case #"talent_phdslider":
        case #"talent_phdslider_1":
        case #"talent_phdslider_3":
        case #"talent_phdslider_2":
        case #"talent_phdslider_4":
            if ( !is_true( getgametypesetting( #"hash_4b8929fb898a9e80" ) ) )
            {
                return false;
            }
            
            break;
    }
    
    return true;
}

/#

    // Namespace namespace_791d0451/namespace_791d0451
    // Params 0
    // Checksum 0xa2a44287, Offset: 0x3a10
    // Size: 0x46c, Type: dev
    function function_c0f77370()
    {
        level endon( #"game_ended" );
        level.var_6f4eb990 = "<dev string:x38>";
        namespace_420b39d3::function_d8ef0f00( &function_1d36527d );
        adddebugcommand( "<dev string:x3c>" + "<dev string:x89>" + "<dev string:x8e>" );
        adddebugcommand( "<dev string:x93>" + "<dev string:xde>" + "<dev string:x8e>" );
        adddebugcommand( "<dev string:xe3>" + "<dev string:x12e>" + "<dev string:x8e>" );
        adddebugcommand( "<dev string:x133>" + "<dev string:x17e>" + "<dev string:x8e>" );
        adddebugcommand( "<dev string:x183>" + "<dev string:x1ce>" + "<dev string:x8e>" );
        adddebugcommand( "<dev string:x1d3>" + "<dev string:x21e>" + "<dev string:x8e>" );
        adddebugcommand( "<dev string:x223>" + function_9e72a96( #"talent_quickrevive" ) + "<dev string:x8e>" );
        adddebugcommand( "<dev string:x26d>" + function_9e72a96( #"talent_speedcola" ) + "<dev string:x8e>" );
        adddebugcommand( "<dev string:x2b3>" + function_9e72a96( #"talent_deadshot" ) + "<dev string:x8e>" );
        adddebugcommand( "<dev string:x2f7>" + function_9e72a96( #"talent_juggernog" ) + "<dev string:x8e>" );
        adddebugcommand( "<dev string:x33c>" + function_9e72a96( #"talent_staminup" ) + "<dev string:x8e>" );
        adddebugcommand( "<dev string:x380>" + function_9e72a96( #"talent_elemental_pop" ) + "<dev string:x8e>" );
        adddebugcommand( "<dev string:x3c9>" + function_9e72a96( #"talent_tombstone" ) + "<dev string:x8e>" );
        adddebugcommand( "<dev string:x40e>" + function_9e72a96( #"talent_mulekick" ) + "<dev string:x8e>" );
        adddebugcommand( "<dev string:x453>" + function_9e72a96( #"talent_deathperception" ) + "<dev string:x8e>" );
        adddebugcommand( "<dev string:x49f>" + function_9e72a96( #"talent_phdslider" ) + "<dev string:x8e>" );
        adddebugcommand( "<dev string:x4e5>" + function_9e72a96( #"talent_quickrevive" ) + "<dev string:x8e>" );
        adddebugcommand( "<dev string:x530>" + function_9e72a96( #"talent_speedcola" ) + "<dev string:x8e>" );
    }

    // Namespace namespace_791d0451/namespace_791d0451
    // Params 1
    // Checksum 0x9e5a3762, Offset: 0x3e88
    // Size: 0x36c, Type: dev
    function function_1d36527d( params )
    {
        tokens = strtok( params.value, "<dev string:x575>" );
        
        if ( !tokens.size || tokens[ 0 ] != "<dev string:x57a>" && tokens[ 0 ] != "<dev string:x58b>" && tokens[ 0 ] != "<dev string:x59c>" && tokens[ 0 ] != "<dev string:x5b1>" )
        {
            return;
        }
        
        foreach ( player in getplayers() )
        {
            if ( tokens[ 0 ] === #"hash_6149e7b90451c6cd" )
            {
                switch ( tokens[ 1 ] )
                {
                    case #"0":
                        level.var_6f4eb990 = "<dev string:x38>";
                        break;
                    case #"1":
                        level.var_6f4eb990 = "<dev string:x5c6>";
                        break;
                    case #"2":
                        level.var_6f4eb990 = "<dev string:x5cc>";
                        break;
                    case #"3":
                        level.var_6f4eb990 = "<dev string:x5d2>";
                        break;
                    case #"4":
                        level.var_6f4eb990 = "<dev string:x5d8>";
                        break;
                    case #"5":
                        level.var_6f4eb990 = "<dev string:x5de>";
                        break;
                }
                
                continue;
            }
            
            if ( tokens[ 0 ] === #"hash_24d26fc861b6ec66" )
            {
                player function_3fecad82( hash( tokens[ 1 ] + level.var_6f4eb990 ), 0 );
                continue;
            }
            
            if ( tokens[ 0 ] === #"hash_2b274b2e4aa51e00" )
            {
                if ( player.var_7341f980.size > 0 )
                {
                    player function_4c1d0e25( player.var_7341f980[ player.var_7341f980.size - 1 ] );
                }
                
                continue;
            }
            
            foreach ( talent in player.var_7341f980 )
            {
                player function_4c1d0e25( talent );
            }
        }
    }

#/
