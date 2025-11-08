#using script_16ea1b94f0f381b3;
#using script_686729055b66c6e4;
#using script_7edf952f8921aa6b;
#using scripts\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\asm\asm;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\utility\vision_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\engine\utility;
#using scripts\stealth\enemy;
#using scripts\vehicle\vehicle_common;

#namespace namespace_773c12e74d6509f9;

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x6a1
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_5ac61c6302a2110d", #"ww_setup", &pre_main, undefined );
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x6ca
// Size: 0x62
function private pre_main()
{
    level callback::add( "player_weapon_change", &function_4405588a9af68a0a );
    function_51479cdb5a0fd4c7();
    utility::registersharedfunc( "player", "onHumanGunPowerupDamage", &function_248c0b74e56b5699 );
    level zombie_utils::function_b5e57408c7878df7( &function_95fd04af9b96bd16 );
    level agent_utils::function_9a024cd909d6e0a3( &function_ca515975069c3e76 );
    level damage_utility::register_vehicle_damage_callback( &function_7c89ba702a4e1038 );
    
    /#
        function_9979ab75cbd987dd();
    #/
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x734
// Size: 0x5d9
function private function_51479cdb5a0fd4c7()
{
    var_2de32448c67a5ad = makeweapon( "jup_la_humangun_mp" );
    
    if ( !is_equal( getweaponrootstring( var_2de32448c67a5ad ), "humangun" ) )
    {
        assertmsg( "<dev string:x1c>" );
        return;
    }
    
    level.var_e01baa6e6a9eef5c = { #var_2759d442fe0a4fc8:[], #var_a884758675fa7873:[] };
    custom_settings = var_2de32448c67a5ad.weaponcustomsettings;
    
    if ( !isdefined( custom_settings ) )
    {
        assertmsg( "<dev string:x40>" );
        return;
    }
    
    if ( isdefined( custom_settings.var_f83ca5ee7d0caf2f ) )
    {
        foreach ( var_7d06282de3611219 in custom_settings.var_f83ca5ee7d0caf2f )
        {
            if ( !isdefined( var_7d06282de3611219.unittype ) || !isdefined( var_7d06282de3611219.subclass ) )
            {
                continue;
            }
            
            level.var_e01baa6e6a9eef5c.var_a884758675fa7873[ level.var_e01baa6e6a9eef5c.var_a884758675fa7873.size ] = var_7d06282de3611219.unittype + ":" + var_7d06282de3611219.subclass;
        }
    }
    
    if ( isdefined( custom_settings.var_db084f1cf5e27d83 ) )
    {
        foreach ( var_24e74da2ae566502 in custom_settings.var_db084f1cf5e27d83 )
        {
            if ( !isdefined( var_24e74da2ae566502.name ) )
            {
                continue;
            }
            
            type_array = [];
            type_weights = [];
            type_index = 0;
            
            foreach ( var_6bbf8239a7a2d1f3 in var_24e74da2ae566502.typelist )
            {
                if ( var_6bbf8239a7a2d1f3.weight > 0 )
                {
                    type_array[ type_index ] = var_6bbf8239a7a2d1f3.aitype;
                    type_weights[ type_index ] = var_6bbf8239a7a2d1f3.weight;
                    type_index++;
                }
            }
            
            level.var_e01baa6e6a9eef5c.var_64344bdf55255fd7[ var_24e74da2ae566502.name ] = { #type_weights:type_weights, #type_array:type_array };
        }
    }
    
    if ( isdefined( custom_settings.var_20233888a67ff470 ) )
    {
        foreach ( transformation_info in custom_settings.var_20233888a67ff470 )
        {
            if ( !isdefined( transformation_info.unittype ) || !isdefined( transformation_info.subclass ) || !isdefined( transformation_info.var_5217ac10dbbbc8d9 ) )
            {
                continue;
            }
            
            assert( isdefined( level.var_e01baa6e6a9eef5c.var_64344bdf55255fd7[ transformation_info.var_5217ac10dbbbc8d9 ] ) );
            level.var_e01baa6e6a9eef5c.var_2759d442fe0a4fc8[ transformation_info.unittype + ":" + transformation_info.subclass ] = { #health_override:transformation_info.healthoverride, #var_64344bdf55255fd7:transformation_info.var_5217ac10dbbbc8d9 };
        }
    }
    
    if ( isdefined( custom_settings.transformationvfx ) )
    {
        level._effect[ "humangun_transformation_fx" ] = loadfx( custom_settings.transformationvfx );
    }
    
    if ( isdefined( custom_settings.var_d321e477699580b7 ) )
    {
        level._effect[ "humangun_transformation_pap_fx" ] = loadfx( custom_settings.var_d321e477699580b7 );
    }
    
    if ( isdefined( custom_settings.powerupvisionset ) )
    {
        level.var_e01baa6e6a9eef5c.var_6de68dec41c3f263 = custom_settings.powerupvisionset;
    }
    
    if ( isdefined( custom_settings.var_4e1f6080aa106884 ) )
    {
        level.var_e01baa6e6a9eef5c.var_1966e1831c542d8e = custom_settings.var_4e1f6080aa106884;
        
        for ( i = 0; i < custom_settings.var_4e1f6080aa106884.size ; i++ )
        {
            if ( isdefined( custom_settings.var_4e1f6080aa106884[ i ].var_fda0ed7e67ea625d ) )
            {
                level._effect[ "humangun_consecutive_hit_normal_fx_" + i + 1 ] = loadfx( custom_settings.var_4e1f6080aa106884[ i ].var_fda0ed7e67ea625d );
            }
            
            if ( isdefined( custom_settings.var_4e1f6080aa106884[ i ].var_cbc64e1962385dc0 ) )
            {
                level._effect[ "humangun_consecutive_hit_normal_pap_fx_" + i + 1 ] = loadfx( custom_settings.var_4e1f6080aa106884[ i ].var_cbc64e1962385dc0 );
            }
            
            if ( isdefined( custom_settings.var_4e1f6080aa106884[ i ].var_7b066992b167348f ) )
            {
                level._effect[ "humangun_consecutive_hit_large_fx_" + i + 1 ] = loadfx( custom_settings.var_4e1f6080aa106884[ i ].var_7b066992b167348f );
            }
            
            if ( isdefined( custom_settings.var_4e1f6080aa106884[ i ].var_268d8ef9df8d4f06 ) )
            {
                level._effect[ "humangun_consecutive_hit_large_pap_fx_" + i + 1 ] = loadfx( custom_settings.var_4e1f6080aa106884[ i ].var_268d8ef9df8d4f06 );
            }
        }
    }
    
    if ( isdefined( custom_settings.var_622d0dcc6ccb65a2 ) )
    {
        level._effect[ "humangun_pap_transformed_explosion_fx" ] = loadfx( custom_settings.var_622d0dcc6ccb65a2 );
    }
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 1
// Checksum 0x0, Offset: 0xd15
// Size: 0xbe
function function_4405588a9af68a0a( params )
{
    if ( isweapon( params.weapon ) )
    {
        root_name = getweaponrootstring( params.weapon );
        
        if ( is_equal( root_name, "humangun" ) )
        {
            assert( isdefined( level.var_e01baa6e6a9eef5c ) );
            thread monitor_humangun_fire();
            is_upgraded = namespace_2b1145f62aa835b8::function_af5127390d3221e9( params.weapon ) > 0;
            thread monitor_humangun_vfx_state( is_upgraded );
            thread function_c0fff54bdd610fff();
            return;
        }
    }
    
    self notify( "stop_monitor_humangun_fire" );
    self notify( "stop_monitor_humangun_vfx_state" );
    utility::function_3677f2be30fdd581( "human_gun_fx", "off" );
    self.var_f71a970f77310f07 = undefined;
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xddb
// Size: 0x66
function private function_c0fff54bdd610fff()
{
    self endon( "death" );
    self endon( "stop_monitor_humangun_vfx_state" );
    
    while ( true )
    {
        result = waittill_any_return_5( "weapon_switch_started", "skydive_deployparachute", "weapon_switch_canceled", "offhand_end", "skydive_end" );
        
        if ( !isdefined( result ) )
        {
            continue;
        }
        
        self.var_f71a970f77310f07 = result == "weapon_switch_started" || result == "skydive_deployparachute";
    }
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xe49
// Size: 0xa8
function private monitor_humangun_vfx_state( is_upgraded )
{
    self endon( "death" );
    self notify( "stop_monitor_humangun_vfx_state" );
    self endon( "stop_monitor_humangun_vfx_state" );
    was_active = 0;
    
    if ( !istrue( self.var_c2ffb89c2dc28d5e ) )
    {
        wait 1.2;
        self.var_c2ffb89c2dc28d5e = 1;
    }
    
    while ( true )
    {
        weapon_active = !istrue( self.var_f71a970f77310f07 );
        
        if ( weapon_active != was_active )
        {
            if ( weapon_active )
            {
                utility::function_3677f2be30fdd581( "human_gun_fx", is_upgraded ? "weapon_active_pap" : "weapon_active" );
            }
            else
            {
                utility::function_3677f2be30fdd581( "human_gun_fx", "off" );
            }
            
            was_active = weapon_active;
        }
        
        waitframe();
    }
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xef9
// Size: 0xa5
function private monitor_humangun_fire()
{
    self endon( "death" );
    self notify( "stop_monitor_humangun_fire" );
    self endon( "stop_monitor_humangun_fire" );
    
    while ( true )
    {
        self waittill( "missile_fire", projectile, weapon );
        
        if ( isdefined( projectile ) && isdefined( weapon ) && is_equal( getweaponrootstring( weapon ), "humangun" ) )
        {
            projectile setentityowner( undefined );
            projectile.is_upgraded = namespace_2b1145f62aa835b8::function_af5127390d3221e9( weapon ) > 0;
            projectile thread monitor_death( self, weapon );
            projectile thread function_49d9f4c10c483cc4( self, weapon );
            projectile thread function_2dc0cad678a62470( self );
            projectile thread function_7ad0f0c81051396f( self );
        }
    }
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xfa6
// Size: 0x59
function private monitor_death( attacker, weapon )
{
    self endon( "humangun_hit" );
    self waittill( "death" );
    
    if ( isdefined( self ) && isplayer( attacker ) )
    {
        attacker.var_f5164c160f176e2f = undefined;
        attacker radiusdamage( self.origin, 50, 220, 5, attacker, "MOD_EXPLOSIVE", weapon );
    }
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1007
// Size: 0x63
function private function_69fbf21c6968c480()
{
    self endon( "death" );
    max_targets = istrue( self.is_upgraded ) ? 3 : 1;
    self notify( "humangun_hit" );
    self.hit_count = default_to( self.hit_count, 0 ) + 1;
    
    if ( self.hit_count >= max_targets )
    {
        waittillframeend();
        self delete();
    }
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1072
// Size: 0x1a
function private delay_endon( string )
{
    self waittill( string );
    waittillframeend();
    self notify( "delay_" + string );
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1094
// Size: 0x73
function private function_49d9f4c10c483cc4( attacker, weapon )
{
    self endon( "delay_death" );
    childthread delay_endon( "death" );
    attacker endon( "death_or_disconnect" );
    
    if ( !isdefined( attacker.team ) )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( "projectile_impact_ai", ai );
        
        if ( function_748523900abdc0af( ai, attacker ) )
        {
            continue;
        }
        
        thread function_b1b8bef6d07fab7b( ai, attacker, weapon );
    }
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x110f
// Size: 0x5a, Type: bool
function private function_748523900abdc0af( ai, attacker )
{
    return !isalive( ai ) || is_equal( ai.team, attacker.team ) || isdefined( ai.var_e365c08bc3b28fc0 ) || istrue( ai.var_1aafe987ad681a50 );
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1172
// Size: 0x5a
function private function_dd53a55c27406672( var_e702bf0dc03f8c6d )
{
    var_64344bdf55255fd7 = level.var_e01baa6e6a9eef5c.var_64344bdf55255fd7[ var_e702bf0dc03f8c6d ];
    
    if ( isdefined( var_64344bdf55255fd7 ) )
    {
        var_6bbf8239a7a2d1f3 = random_weighted( var_64344bdf55255fd7.type_array, var_64344bdf55255fd7.type_weights );
        return var_6bbf8239a7a2d1f3;
    }
    
    return undefined;
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x11d5
// Size: 0x154
function private function_b1b8bef6d07fab7b( ai, attacker, weapon )
{
    thread function_69fbf21c6968c480();
    attacker function_b4a87d1c46429f40( ai );
    
    if ( !isdefined( ai.unittype ) || !isdefined( ai.subclass ) )
    {
        return;
    }
    
    var_520fbbdb23e0bddd = ai.unittype + ":" + ai.subclass;
    
    if ( istrue( ai._blackboard.var_93aa3eefdf57f46 ) || array_contains( level.var_e01baa6e6a9eef5c.var_a884758675fa7873, var_520fbbdb23e0bddd ) )
    {
        ai function_b73079d82ccbc0cb( attacker, 1, istrue( self.is_upgraded ) );
        waitframe();
        
        if ( isalive( ai ) )
        {
            ai kill( ai.origin, attacker );
        }
        
        return;
    }
    
    transformation_info = level.var_e01baa6e6a9eef5c.var_2759d442fe0a4fc8[ var_520fbbdb23e0bddd ];
    
    if ( isdefined( transformation_info ) )
    {
        var_6bbf8239a7a2d1f3 = function_dd53a55c27406672( transformation_info.var_64344bdf55255fd7 );
        
        if ( isdefined( var_6bbf8239a7a2d1f3 ) )
        {
            ai thread transform_into( var_6bbf8239a7a2d1f3, attacker, transformation_info.health_override, istrue( self.is_upgraded ) );
        }
        
        return;
    }
    
    thread damage_ai( ai, attacker, weapon );
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1331
// Size: 0xe0
function private function_2f8e6fe2d4ed8af8( new_agent )
{
    self.var_f8acc27178c5ea5b = default_to( self.var_f8acc27178c5ea5b, [] );
    var_c413d6aa7dc7aba0 = [];
    
    for ( i = self.var_f8acc27178c5ea5b.size - 1; i >= 0 ; i-- )
    {
        agent = self.var_f8acc27178c5ea5b[ i ];
        
        if ( !isalive( agent ) || isai( agent ) && agent doinglongdeath() || agent == new_agent )
        {
            continue;
        }
        
        if ( is_equal( agent.var_e365c08bc3b28fc0, 1 ) )
        {
            if ( var_c413d6aa7dc7aba0.size < 2 )
            {
                var_c413d6aa7dc7aba0[ var_c413d6aa7dc7aba0.size ] = agent;
                continue;
            }
            
            agent kill();
        }
    }
    
    if ( var_c413d6aa7dc7aba0.size > 0 )
    {
        var_c413d6aa7dc7aba0 = array_reverse( var_c413d6aa7dc7aba0 );
    }
    
    var_c413d6aa7dc7aba0[ var_c413d6aa7dc7aba0.size ] = new_agent;
    self.var_f8acc27178c5ea5b = var_c413d6aa7dc7aba0;
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1419
// Size: 0x1a
function private function_3c0a0f8cc46643f1( alias_name )
{
    self endon( "death" );
    animscripted_single( alias_name );
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x143b
// Size: 0x23
function private function_a8f0e10480b1f5b4( alias_name, node_struct )
{
    self endon( "death" );
    animscripted_single_relative( alias_name, node_struct );
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x1466
// Size: 0x41a
function private transform_into( new_type, attacker, health_override, is_upgraded )
{
    attacker_team = attacker.team;
    
    if ( !isdefined( attacker_team ) )
    {
        return;
    }
    
    if ( isdefined( self.var_e365c08bc3b28fc0 ) )
    {
        return;
    }
    
    self.var_e365c08bc3b28fc0 = 0;
    self.battlechatterallowed = 0;
    self notify( "removed from battleChatter" );
    disable_pain();
    val::set( "humangun_transforming", "ignoreall", 1 );
    val::set( "humangun_transforming", "disallow_stun", 1 );
    val::set( "humangun_transforming", "disallow_knockdown", 1 );
    transformation_fx = is_upgraded ? "humangun_transformation_pap_fx" : "humangun_transformation_fx";
    
    if ( utility::fxexists( transformation_fx ) )
    {
        playfxontag( utility::getfx( transformation_fx ), self, "j_spine4" );
    }
    
    if ( vehicle_common::hasvehicle() )
    {
        waitframe();
        
        if ( isalive( self ) )
        {
            self kill( self.origin, attacker );
        }
        
        return;
    }
    
    if ( self asmhasstate( self.asmname, "animscripted" ) && isdefined( asm_lookupanimfromalias( "animscripted", "humangun_turn_into" ) ) )
    {
        function_3c0a0f8cc46643f1( "humangun_turn_into" );
    }
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    agent_gender = self function_617d6e7d0b7859cc() ? "female" : "male";
    agent_aitype = self.agent_type;
    var_e9ecac3bbe4fc333 = self.characterlistname;
    
    if ( string_starts_with( agent_aitype, "actor_" ) )
    {
        agent_aitype = getsubstr( agent_aitype, 6 );
    }
    
    anim_node = spawnstruct();
    anim_node.origin = self.origin;
    anim_node.angles = self.angles;
    
    if ( is_equal( self.type, "zombie" ) )
    {
        self.var_7e4b076a06c6df27 = 1;
    }
    
    self.var_13fbc1870bc29ba = attacker;
    despawnagent();
    character_list = undefined;
    
    if ( issubstr( new_type, "basic_grunt" ) && agent_gender == "female" )
    {
        character_list = "female";
    }
    
    agent_team = attacker_team;
    
    if ( isplayer( attacker ) && isdefined( attacker.team ) )
    {
        agent_team = attacker.team;
    }
    
    new_agent = spawnnewaitype_sharedfunc( new_type, anim_node.origin, anim_node.angles, agent_team, character_list, agent_gender );
    
    if ( isdefined( new_agent ) )
    {
        new_agent.var_e365c08bc3b28fc0 = 1;
        new_agent.var_8e63ab141b9f85f9 = agent_aitype;
        new_agent.var_ca8cda392638c7db = var_e9ecac3bbe4fc333;
        
        if ( isdefined( health_override ) && health_override > 0 )
        {
            new_agent.maxhealth = health_override;
        }
        
        new_agent function_ca27630def7b7aad( attacker );
        new_agent.var_941802a0997e0c42 = attacker;
        new_agent.var_93eb5ea81d2cc4d = 1;
        new_agent.brainrot_kills = 0;
        new_agent val::set( "humangun_transformed", "damage", 0 );
        new_agent val::set( "humangun_transformed", "ignoreme", 1 );
        new_agent.battlechatterallowed = 0;
        new_agent notify( "removed from battleChatter" );
        new_agent utility::function_3677f2be30fdd581( "humangun_transformed", "transformed_fx_on" );
        
        if ( !isdefined( new_agent.script_stealthgroup ) )
        {
            new_agent.script_stealthgroup = "humangun_transformed_stealth_group";
            new_agent thread scripts\stealth\enemy::main();
        }
        
        if ( isplayer( attacker ) )
        {
            attacker function_2f8e6fe2d4ed8af8( new_agent );
        }
        
        new_agent function_a8f0e10480b1f5b4( "humangun_turn_from", anim_node );
        
        if ( isalive( new_agent ) )
        {
            new_agent animscripted_clear();
            new_agent function_65cdab0fc78aba8f( new_agent.origin, 2000 );
            new_agent val::reset( "humangun_transformed", "ignoreme" );
            new_agent.aggressivemode = 1;
            new_agent.usestrictreacquiresightshoot = 1;
            new_agent thread function_c5b688060b9a63ae( is_upgraded );
        }
    }
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1888
// Size: 0x21b
function private function_e61ac5f093c0ad62()
{
    function_3c0a0f8cc46643f1( "humangun_turned_death_intro" );
    
    if ( !isalive( self ) )
    {
        return undefined;
    }
    
    anim_node = spawnstruct();
    anim_node.origin = self.origin;
    anim_node.angles = self.angles;
    agent_team = self.team;
    agent_health = self.health;
    agent_maxhealth = self.maxhealth;
    agent_gender = self function_617d6e7d0b7859cc() ? "female" : "male";
    old_aitype = self.var_8e63ab141b9f85f9;
    var_c3f0a3ebfd4659db = is_equal( self.var_ca8cda392638c7db, "default" ) ? undefined : self.var_ca8cda392638c7db;
    var_941802a0997e0c42 = self.var_941802a0997e0c42;
    brainrot_kills = self.brainrot_kills;
    
    if ( is_equal( self.type, "zombie" ) )
    {
        self.var_7e4b076a06c6df27 = 1;
    }
    
    self.var_941802a0997e0c42 = undefined;
    despawnagent();
    
    if ( isdefined( old_aitype ) )
    {
        old_agent = spawnnewaitype_sharedfunc( old_aitype, anim_node.origin, anim_node.angles, agent_team, var_c3f0a3ebfd4659db, agent_gender );
        
        if ( isdefined( old_agent ) )
        {
            old_agent.var_e365c08bc3b28fc0 = 2;
            old_agent function_ca27630def7b7aad();
            old_agent.var_941802a0997e0c42 = var_941802a0997e0c42;
            old_agent.var_93eb5ea81d2cc4d = 1;
            old_agent.brainrot_kills = brainrot_kills;
            old_agent val::set( "humangun_transformed", "damage", 0 );
            old_agent.maxhealth = agent_maxhealth;
            old_agent.health = agent_health;
            old_agent.do_immediate_ragdoll = 1;
            old_agent utility::function_3677f2be30fdd581( "humangun_transformed", "transformed_fx_on" );
            old_agent function_a8f0e10480b1f5b4( "humangun_turned_death_outro", anim_node );
            return old_agent;
        }
    }
    
    return undefined;
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1aac
// Size: 0xfa
function private function_2a853ff67461d06b( is_upgraded )
{
    agent = self;
    
    if ( is_equal( self.unittype, "soldier" ) )
    {
        agent = function_e61ac5f093c0ad62();
    }
    
    if ( !isalive( agent ) )
    {
        return;
    }
    
    if ( is_upgraded )
    {
        if ( utility::fxexists( "humangun_pap_transformed_explosion_fx" ) )
        {
            explosion_origin = default_to( agent gettagorigin( "j_spine4", 1 ), agent.origin );
            playfx( utility::getfx( "humangun_pap_transformed_explosion_fx" ), explosion_origin );
        }
        
        agent radiusdamage( agent.origin, 256, 3420, 1700, agent, "MOD_EXPLOSIVE" );
        agent scripts\aitypes\zombie_base\zombie_base_dismemberment::annihilate();
        agent invisiblenotsolid();
        wait 1.2;
    }
    
    if ( isalive( agent ) )
    {
        if ( is_equal( agent.type, "zombie" ) )
        {
            agent.var_7e4b076a06c6df27 = 1;
        }
        
        agent kill();
    }
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1bae
// Size: 0x1e
function private function_c5b688060b9a63ae( is_upgraded )
{
    self endon( "death" );
    wait 15;
    thread function_2a853ff67461d06b( is_upgraded );
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1bd4
// Size: 0xae
function private function_b4a87d1c46429f40( victim )
{
    if ( !isdefined( self.var_f5164c160f176e2f ) )
    {
        self.var_f5164c160f176e2f = spawnstruct();
    }
    
    if ( !isdefined( self.var_f5164c160f176e2f.victim ) || self.var_f5164c160f176e2f.victim != victim )
    {
        self.var_f5164c160f176e2f.victim = victim;
        self.var_f5164c160f176e2f.hit_streak = 0;
    }
    
    self.var_f5164c160f176e2f.hit_streak = self.var_f5164c160f176e2f.hit_streak % 3 + 1;
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x1c8a
// Size: 0x117
function private damage_ai( agent, attacker, weapon )
{
    if ( isdefined( agent.aicategory ) )
    {
        if ( agent.aicategory == "special" )
        {
            function_3aac7fba9f5de153( agent, attacker, attacker.var_f5164c160f176e2f.hit_streak, weapon );
        }
        else if ( agent.aicategory == "elite" )
        {
            function_54976578adb8d7f7( agent, attacker, attacker.var_f5164c160f176e2f.hit_streak, weapon );
        }
        else if ( agent.aicategory == "boss" )
        {
            function_3d2e2ae7d4a1195f( agent, attacker, attacker.var_f5164c160f176e2f.hit_streak, weapon );
        }
        
        return;
    }
    
    if ( agent ai::is_warlord() )
    {
        function_54976578adb8d7f7( agent, attacker, attacker.var_f5164c160f176e2f.hit_streak, weapon );
        return;
    }
    
    function_3aac7fba9f5de153( agent, attacker, attacker.var_f5164c160f176e2f.hit_streak, weapon );
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x1da9
// Size: 0xc0
function private function_b73079d82ccbc0cb( attacker, hit_streak, is_upgraded )
{
    if ( isdefined( self.aicategory ) && self.aicategory == "boss" )
    {
        return;
    }
    
    hit_fx = undefined;
    half_bounds = self getboundshalfsize();
    
    if ( max( half_bounds[ 0 ], half_bounds[ 1 ] ) < 64 )
    {
        hit_fx = ( is_upgraded ? "humangun_consecutive_hit_normal_pap_fx_" : "humangun_consecutive_hit_normal_fx_" ) + hit_streak;
    }
    else
    {
        hit_fx = ( is_upgraded ? "humangun_consecutive_hit_large_pap_fx_" : "humangun_consecutive_hit_large_fx_" ) + hit_streak;
    }
    
    if ( utility::fxexists( hit_fx ) && isplayer( attacker ) )
    {
        playfxontagforclients( utility::getfx( hit_fx ), self, "j_spine4", attacker );
    }
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x1e71
// Size: 0x1a6
function private function_3aac7fba9f5de153( agent, attacker, hit_streak, weapon )
{
    var_1cb27f891d7c8b99 = [ 0.1, 0.15, 0.25 ];
    assert( hit_streak > 0 && hit_streak <= var_1cb27f891d7c8b99.size );
    hit_damage = agent.maxhealth * var_1cb27f891d7c8b99[ hit_streak - 1 ];
    agent function_b73079d82ccbc0cb( attacker, hit_streak, istrue( self.is_upgraded ) );
    var_d39b9b69b9c1a06a = is_equal( agent.type, "human" );
    
    switch ( hit_streak )
    {
        case 2:
            stun_duration = 3;
            
            if ( istrue( self.is_upgraded ) )
            {
                stun_duration *= 2;
            }
            
            if ( var_d39b9b69b9c1a06a )
            {
                agent notify( "flashbang", agent.origin, 1, 1, attacker, attacker.team, stun_duration );
            }
            else
            {
                agent namespace_ed7c38f3847343dc::stun_ai( stun_duration );
            }
        case 1:
            agent dodamage( hit_damage, self.origin, attacker, self, "MOD_IMPACT", weapon );
            break;
        case 3:
            if ( hit_damage >= agent.health && !var_d39b9b69b9c1a06a )
            {
                agent scripts\aitypes\zombie_base\zombie_base_dismemberment::annihilate();
                agent kill( agent.origin, attacker );
            }
            else
            {
                agent dodamage( hit_damage, self.origin, attacker, self, "MOD_IMPACT", weapon );
            }
            
            break;
    }
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x201f
// Size: 0x185
function private function_54976578adb8d7f7( agent, attacker, hit_streak, weapon )
{
    var_1cb27f891d7c8b99 = [ 0.025, 0.05, 0.1 ];
    assert( hit_streak <= var_1cb27f891d7c8b99.size );
    hit_damage = agent.maxhealth * var_1cb27f891d7c8b99[ hit_streak - 1 ];
    agent function_b73079d82ccbc0cb( attacker, hit_streak, istrue( self.is_upgraded ) );
    var_d39b9b69b9c1a06a = is_equal( agent.type, "human" );
    
    switch ( hit_streak )
    {
        case 1:
            agent disable_pain();
            agent dodamage( hit_damage, self.origin, attacker, self, "MOD_IMPACT", weapon );
            
            if ( isalive( agent ) )
            {
                agent enable_pain();
            }
            
            break;
        case 3:
            stun_duration = 3;
            
            if ( istrue( self.is_upgraded ) )
            {
                stun_duration *= 2;
            }
            
            if ( var_d39b9b69b9c1a06a )
            {
                agent notify( "flashbang", agent.origin, 1, 1, attacker, attacker.team, stun_duration );
            }
            else
            {
                agent namespace_ed7c38f3847343dc::stun_ai( stun_duration );
            }
        case 2:
            agent dodamage( hit_damage, self.origin, attacker, self, "MOD_IMPACT", weapon );
            break;
    }
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x21ac
// Size: 0xa1
function private function_3d2e2ae7d4a1195f( agent, attacker, hit_streak, weapon )
{
    var_1cb27f891d7c8b99 = [ 0.005, 0.0025, 0.05 ];
    assert( hit_streak <= var_1cb27f891d7c8b99.size );
    hit_damage = agent.maxhealth * var_1cb27f891d7c8b99[ hit_streak - 1 ];
    agent function_b73079d82ccbc0cb( attacker, hit_streak, istrue( self.is_upgraded ) );
    agent dodamage( hit_damage, self.origin, attacker, self, "MOD_IMPACT", weapon );
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x2255
// Size: 0x3d, Type: bool
function private function_3f283b94120f2cf8( weapon, meansofdeath )
{
    if ( !isdefined( weapon ) || !isdefined( meansofdeath ) )
    {
        return false;
    }
    
    return is_equal( getweaponrootstring( weapon ), "humangun" ) && meansofdeath == "MOD_EXPLOSIVE";
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x229b
// Size: 0x33
function private function_95fd04af9b96bd16( params )
{
    if ( function_3f283b94120f2cf8( params.sweapon, params.smeansofdeath ) )
    {
        return 0;
    }
    
    return function_248c0b74e56b5699( params );
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x22d7
// Size: 0x2e
function private function_ca515975069c3e76( params )
{
    if ( function_3f283b94120f2cf8( params.sweapon, params.smeansofdeath ) )
    {
        return 0;
    }
    
    return -1;
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x230e
// Size: 0x95
function private function_2dc0cad678a62470( attacker )
{
    self endon( "delay_death" );
    childthread delay_endon( "death" );
    attacker endon( "death_or_disconnect" );
    
    if ( !isdefined( attacker.team ) )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( "projectile_impact_player", player );
        
        if ( !isalive( player ) || !is_equal( player.team, attacker.team ) || is_equal( player, attacker ) )
        {
            continue;
        }
        
        thread function_6d650476765969f( player, attacker );
    }
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x23ab
// Size: 0x2e
function private function_6d650476765969f( player, attacker )
{
    thread function_69fbf21c6968c480();
    attacker function_b4a87d1c46429f40( player );
    player thread give_powerup( attacker );
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x23e1
// Size: 0xc5
function private give_powerup( attacker )
{
    if ( istrue( self.humangun_transformed ) )
    {
        return;
    }
    
    self.humangun_transformed = 1;
    utility::callsharedfunc( "player", "setIgnoredByZombies", "humangun", 1 );
    powerup_vision = level.var_e01baa6e6a9eef5c.var_6de68dec41c3f263;
    
    if ( isdefined( powerup_vision ) )
    {
        vision_utility::function_27a921508cb04613( powerup_vision, 0.5 );
    }
    
    utility::function_3677f2be30fdd581( "humangun_powerup_fx", "powerup_fx_on" );
    wait 7;
    
    if ( isdefined( self ) )
    {
        utility::callsharedfunc( "player", "setIgnoredByZombies", "humangun", 0 );
        
        if ( isdefined( powerup_vision ) )
        {
            vision_utility::function_9a92ae402e209ecc( powerup_vision );
        }
        
        utility::function_3677f2be30fdd581( "humangun_powerup_fx", "powerup_fx_worn_off" );
        self.humangun_transformed = undefined;
    }
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x24ae
// Size: 0x49
function private function_248c0b74e56b5699( params )
{
    if ( isplayer( params.eattacker ) && istrue( params.eattacker.humangun_transformed ) )
    {
        return ( params.idamage * 2 );
    }
    
    return -1;
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2500
// Size: 0x2e
function private function_7c89ba702a4e1038( params )
{
    if ( function_3f283b94120f2cf8( params.objweapon, params.meansofdeath ) )
    {
        return 0;
    }
    
    return -1;
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2537
// Size: 0x120
function private function_7ad0f0c81051396f( attacker )
{
    self endon( "delay_death" );
    childthread delay_endon( "death" );
    attacker endon( "death_or_disconnect" );
    
    while ( true )
    {
        self waittill( "projectile_impact_vehicle", vehicle );
        
        if ( istrue( self.is_upgraded ) && vehicle isvehicle() && !vehicle isvehiclehusk() )
        {
            repair_amount = vehicle.maxhealth * 0.25;
            vehicle function_653b96ce8310763e( repair_amount );
            vehicle thread function_5fd2dcf6788ab3f2();
            
            if ( isdefined( vehicle.fuel ) )
            {
                max_fuel = vehicle_interact_getleveldataforvehicle( vehicle.vehiclename ).maxfuel;
                vehicle.fuel = min( max_fuel, vehicle.fuel + max_fuel * 0.25 );
                vehicle scripts\cp_mp\utility\vehicle_omnvar_utility::function_9da76b0be4b2a2d4( vehicle.fuel, max_fuel );
            }
            
            if ( is_equal( vehicle.vehiclename, "veh_jup_ob_tank_escort" ) )
            {
                vehicle notify( "damage" );
            }
        }
    }
}

// Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x265f
// Size: 0x23
function private function_5fd2dcf6788ab3f2()
{
    if ( isdefined( self.deadwheels ) )
    {
        function_e6f68a61bffc259a( self, 0 );
        return;
    }
    
    function_9b27177ad97bb8d8( self );
}

/#

    // Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x268a
    // Size: 0x70, Type: dev
    function private function_9979ab75cbd987dd()
    {
        function_6e7290c8ee4f558b( "<dev string:x73>" );
        function_b23a59dfb4ca49a1( "<dev string:x8f>", "<dev string:xaa>", &function_2b409a09a21ce63d );
        function_b23a59dfb4ca49a1( "<dev string:xd0>", "<dev string:xef>", &function_2b409a09a21ce63d );
        function_a9a864379a098ad6( "<dev string:x115>", "<dev string:x139>", &function_d566dbc05a0a774 );
        function_a9a864379a098ad6( "<dev string:x15f>", "<dev string:x172>", &function_5c99c5fb2d0edeee );
        function_fe953f000498048f();
    }

    // Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x2702
    // Size: 0x151, Type: dev
    function private function_2b409a09a21ce63d( params )
    {
        player = level.players[ 0 ];
        enemies = getaispeciesarray( "<dev string:x18e>", "<dev string:x196>" );
        sorted_enemies = get_array_of_closest( player.origin, enemies );
        is_upgraded = int( params[ 0 ] ) > 0;
        closest_agent = undefined;
        
        foreach ( agent in sorted_enemies )
        {
            if ( !isdefined( agent.var_e365c08bc3b28fc0 ) )
            {
                closest_agent = agent;
                break;
            }
        }
        
        if ( !isdefined( closest_agent ) )
        {
            return;
        }
        
        transformation_info = level.var_e01baa6e6a9eef5c.var_2759d442fe0a4fc8[ closest_agent.unittype + "<dev string:x19d>" + closest_agent.subclass ];
        
        if ( isdefined( transformation_info ) )
        {
            var_6bbf8239a7a2d1f3 = function_dd53a55c27406672( transformation_info.var_64344bdf55255fd7 );
            
            if ( isdefined( var_6bbf8239a7a2d1f3 ) )
            {
                closest_agent thread transform_into( var_6bbf8239a7a2d1f3, player, transformation_info.health_override, is_upgraded );
            }
        }
    }

    // Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x285b
    // Size: 0xbd, Type: dev
    function private function_d566dbc05a0a774( params )
    {
        player = level.players[ 0 ];
        enemies = getaispeciesarray( "<dev string:x18e>", "<dev string:x196>" );
        sorted_enemies = get_array_of_closest( player.origin, enemies );
        
        foreach ( agent in sorted_enemies )
        {
            if ( is_equal( agent.var_e365c08bc3b28fc0, 1 ) )
            {
                agent thread function_2a853ff67461d06b( 1 );
            }
        }
    }

    // Namespace namespace_773c12e74d6509f9 / namespace_bbdaab8ec2235136
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x2920
    // Size: 0x26, Type: dev
    function private function_5c99c5fb2d0edeee()
    {
        player = level.players[ 0 ];
        player thread give_powerup( player );
    }

#/
