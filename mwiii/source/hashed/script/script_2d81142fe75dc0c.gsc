#using script_61afae50a53c3917;
#using script_7b13d902fe77425;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\squads;
#using scripts\engine\utility;
#using scripts\mp\utility\teams;

#namespace namespace_bf88184663f2b9d2;

// Namespace namespace_bf88184663f2b9d2 / namespace_a04d40d58a5bc9d8
// Params 0
// Checksum 0x0, Offset: 0x1c8
// Size: 0x3f
function init()
{
    callback::add( "on_ai_killed", &function_e5ea18b76842725f );
    scripts\engine\utility::registersharedfunc( "relics", "blade_throw_hit", &function_999826d9d417b8e5 );
    scripts\engine\utility::registersharedfunc( "relics", "blade_throw_end", &function_6f0bbbd9b5432375 );
}

// Namespace namespace_bf88184663f2b9d2 / namespace_a04d40d58a5bc9d8
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x20f
// Size: 0x176
function private function_de6ff1bee84a5815( attacker, victim, iskill )
{
    if ( !( isdefined( attacker ) && isdefined( victim ) ) )
    {
        return;
    }
    
    if ( !isdefined( attacker.var_4fa1e36e78b7530b ) )
    {
        attacker.var_4fa1e36e78b7530b = [];
    }
    
    var_fa2fc22bae862fef = 0;
    
    foreach ( var_dbbf09832047c81c in attacker.var_4fa1e36e78b7530b )
    {
        if ( isdefined( var_dbbf09832047c81c.victim ) && var_dbbf09832047c81c.victim == victim )
        {
            var_dbbf09832047c81c.iskill = istrue( iskill );
            var_fa2fc22bae862fef = 1;
            break;
        }
    }
    
    if ( !istrue( var_fa2fc22bae862fef ) )
    {
        var_126c88efe6492c66 = spawnstruct();
        var_126c88efe6492c66.victim = victim;
        var_126c88efe6492c66.pos = victim.origin;
        var_126c88efe6492c66.var_79126dc038fda33e = attacker.var_4fa1e36e78b7530b.size + 1;
        
        if ( isdefined( self.subclass ) && function_5ca65d1c4edfcee3( victim ) )
        {
            var_126c88efe6492c66.var_5c36fa3c7bcf3a2f = 1;
        }
        
        var_126c88efe6492c66.iskill = istrue( iskill );
        attacker.var_4fa1e36e78b7530b[ attacker.var_4fa1e36e78b7530b.size ] = var_126c88efe6492c66;
    }
}

// Namespace namespace_bf88184663f2b9d2 / namespace_a04d40d58a5bc9d8
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x38d
// Size: 0x94
function private function_e5ea18b76842725f( sparams )
{
    if ( isdefined( sparams.sweapon ) && isdefined( sparams.eattacker ) && isdefined( sparams ) && isdefined( self ) && isdefined( sparams.sweapon.basename ) )
    {
        if ( sparams.sweapon.basename == "jup_aether_blade_ob" && function_4d79c8a3dc259ea2( sparams.eattacker ) )
        {
            function_de6ff1bee84a5815( sparams.eattacker, self, 1 );
        }
    }
}

// Namespace namespace_bf88184663f2b9d2 / namespace_a04d40d58a5bc9d8
// Params 1
// Checksum 0x0, Offset: 0x429
// Size: 0x2b
function function_999826d9d417b8e5( attacker )
{
    if ( !( isdefined( attacker ) && isdefined( self ) ) || !function_4d79c8a3dc259ea2( attacker ) )
    {
        return;
    }
    
    function_de6ff1bee84a5815( attacker, self );
}

// Namespace namespace_bf88184663f2b9d2 / namespace_a04d40d58a5bc9d8
// Params 1
// Checksum 0x0, Offset: 0x45c
// Size: 0x176
function function_6f0bbbd9b5432375( attacker )
{
    if ( !( isdefined( attacker ) && isdefined( attacker.var_4fa1e36e78b7530b ) ) || attacker.var_4fa1e36e78b7530b.size == 0 )
    {
        return;
    }
    
    var_d16a163d25ba20ba = getdvarint( @"hash_e7718d728ed4607e", 2 );
    
    foreach ( var_9ac4a47219d443d7 in attacker.var_4fa1e36e78b7530b )
    {
        if ( istrue( var_9ac4a47219d443d7.var_5c36fa3c7bcf3a2f ) && istrue( var_9ac4a47219d443d7.iskill ) && isdefined( var_9ac4a47219d443d7.var_79126dc038fda33e ) && var_9ac4a47219d443d7.var_79126dc038fda33e >= var_d16a163d25ba20ba || getdvarint( @"hash_906f501d2cbecf25", 0 ) )
        {
            thread function_4274f780d2a511f9( attacker, var_9ac4a47219d443d7.pos );
            break;
        }
    }
    
    /#
        if ( getdvarint( @"hash_621db215d72a8a8b", 0 ) )
        {
            foreach ( var_9ac4a47219d443d7 in attacker.var_4fa1e36e78b7530b )
            {
                thread debugprint( attacker, var_9ac4a47219d443d7 );
            }
        }
    #/
    
    attacker.var_4fa1e36e78b7530b = undefined;
}

// Namespace namespace_bf88184663f2b9d2 / namespace_a04d40d58a5bc9d8
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x5da
// Size: 0x74
function private function_4274f780d2a511f9( var_fb7680c7bee58bb9, pos )
{
    level endon( "game_ended" );
    var_fb7680c7bee58bb9 endon( "death" );
    wait getdvarfloat( @"hash_d05ee8b84d98206d", 0.3 );
    
    if ( isdefined( var_fb7680c7bee58bb9 ) )
    {
        var_5722f5b98852f4f8 = getgroundposition( pos, 15 );
        namespace_c8baf39126f1ef99::function_65e52fad2bce952c( var_fb7680c7bee58bb9, "ob_jup_item_reward_diary_s5", var_5722f5b98852f4f8, 1 );
        wait 2;
        thread scripts\cp_mp\overlord::playconversation( "RFT_S5_5_RGUQ_Relic_Drop_Locked_Diary", [ var_fb7680c7bee58bb9 ] );
    }
}

// Namespace namespace_bf88184663f2b9d2 / namespace_a04d40d58a5bc9d8
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x656
// Size: 0x2c, Type: bool
function private function_4d79c8a3dc259ea2( attacker )
{
    return isplayer( attacker ) && namespace_362d05f5d79f98cd::function_eaee8a3e6cdeefcf( attacker ) && !namespace_c8baf39126f1ef99::function_d737da36e4f0f6c2( attacker, "ob_jup_item_reward_diary_s5" );
}

// Namespace namespace_bf88184663f2b9d2 / namespace_a04d40d58a5bc9d8
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x68b
// Size: 0xa9
function private function_5ca65d1c4edfcee3( zombie )
{
    if ( getdvarint( @"hash_762f928c40cf31ea", 0 ) )
    {
        return 1;
    }
    
    var_8752f73156485a57 = 0;
    
    if ( isdefined( zombie ) && isdefined( zombie.subclass ) )
    {
        if ( issubstr( zombie.subclass, "zombie_mangler" ) || issubstr( zombie.subclass, "zombie_mimic" ) || issubstr( zombie.subclass, "zombie_disciple" ) || issubstr( zombie.subclass, "zombie_abom" ) )
        {
            var_8752f73156485a57 = 1;
        }
    }
    
    return var_8752f73156485a57;
}

/#

    // Namespace namespace_bf88184663f2b9d2 / namespace_a04d40d58a5bc9d8
    // Params 2
    // Checksum 0x0, Offset: 0x73d
    // Size: 0xa0, Type: dev
    function debugprint( attacker, var_9ac4a47219d443d7 )
    {
        color = ( 1, 1, 1 );
        
        if ( istrue( var_9ac4a47219d443d7.iskill ) )
        {
            color = ( 1, 0, 0 );
        }
        
        alpha = 1;
        scale = 1;
        print3d( var_9ac4a47219d443d7.pos, "<dev string:x1c>" + var_9ac4a47219d443d7.var_79126dc038fda33e + "<dev string:x21>" + istrue( var_9ac4a47219d443d7.var_5c36fa3c7bcf3a2f ), color, alpha, scale, 300 );
    }

#/
