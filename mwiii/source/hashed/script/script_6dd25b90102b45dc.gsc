#using script_58682e6578ce0515;
#using script_6bffae1b97f70547;
#using script_7edf952f8921aa6b;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\throttle;
#using scripts\engine\utility;

#namespace cryofreeze;

// Namespace cryofreeze / namespace_a7f426fbebc3a6f4
// Params 0
// Checksum 0x0, Offset: 0x1cc
// Size: 0x253
function init_cryofreeze()
{
    sbundle = getscriptbundle( "ammomod:" + level.gamemodebundle.var_4f59eded21c43059 );
    level._effect[ "cryofreeze_impact" ] = loadfx( sbundle.var_b0096ccfd3465d13 );
    
    if ( !istrue( level.var_bfa98c9dd6edb929 ) )
    {
        return;
    }
    
    level endon( "game_ended" );
    flag_wait( "ammo_mods_ready" );
    flag_init( "cryofreeze_ready" );
    var_746d800f9d085b2a = default_to( level.var_f1240a9ac4f65616.var_e79139a1d8a6db93, 0.25 );
    var_ad5528a4132dc97d = default_to( level.var_f1240a9ac4f65616.var_aefab597e0d4ccaa, 0.1 );
    cooldownentity = default_to( level.var_f1240a9ac4f65616.var_79586044f6dc1b7d, 0 );
    cooldownattacker = default_to( level.var_f1240a9ac4f65616.var_51fca1cd08a8156d, 0 );
    cooldownglobal = default_to( level.var_f1240a9ac4f65616.var_d53f3286e9d3529, 1 );
    var_f27a8d5708fd9c4d = default_to( level.var_f1240a9ac4f65616.var_9a4c1c06b0d52447, 1 );
    damagefeedbackicon = default_to( level.var_f1240a9ac4f65616.var_deb7e87f41e610cc, "" );
    damagefeedbacksound = default_to( level.var_f1240a9ac4f65616.var_37e6ce4fbc2055f8, "" );
    element = default_to( level.var_f1240a9ac4f65616.var_5ec51dc708c55f6d, "cold" );
    level.var_c6756fa6096a1e11 = [];
    level.var_86f3f0a869ad0f7f = [];
    function_7f759db5de1b44b0( "cryofreeze", 2, 0.25, 0.1, 0, 0, 1, 1, &function_185301c612d60f6b, "", "", &function_3713b5166b308321, "cold" );
    function_b5e57408c7878df7( &on_ai_damage );
    callback::add( "on_ai_killed", &on_ai_killed );
    flag_set( "cryofreeze_ready" );
    
    /#
        level thread function_750b525ce60bef6c();
    #/
}

// Namespace cryofreeze / namespace_a7f426fbebc3a6f4
// Params 1
// Checksum 0x0, Offset: 0x427
// Size: 0x21
function function_b12cdbe2604ac3f0( func )
{
    level.var_c6756fa6096a1e11[ level.var_c6756fa6096a1e11.size ] = func;
}

// Namespace cryofreeze / namespace_a7f426fbebc3a6f4
// Params 1
// Checksum 0x0, Offset: 0x450
// Size: 0x21
function function_ea61cc8e8adff34e( func )
{
    level.var_86f3f0a869ad0f7f[ level.var_86f3f0a869ad0f7f.size ] = func;
}

// Namespace cryofreeze / namespace_a7f426fbebc3a6f4
// Params 7
// Checksum 0x0, Offset: 0x479
// Size: 0xbb
function function_185301c612d60f6b( death, attacker, mod, sweapon, vpoint, shitloc, modelindex )
{
    if ( level.var_c6756fa6096a1e11.size > 0 )
    {
        foreach ( result_func in level.var_c6756fa6096a1e11 )
        {
            [[ result_func ]]( death, attacker, mod, sweapon, vpoint, shitloc, modelindex );
        }
        
        return;
    }
    
    thread function_d4bd7d34fea892df( death, attacker, mod, sweapon, vpoint, shitloc, modelindex );
}

// Namespace cryofreeze / namespace_a7f426fbebc3a6f4
// Params 10
// Checksum 0x0, Offset: 0x53c
// Size: 0x148
function function_d4bd7d34fea892df( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, overrideduration, var_11deb067b7e33bb5, var_4d0199c75efdcbfd )
{
    level endon( "game_ended" );
    self endon( "death" );
    
    if ( isagent( self ) )
    {
        ent_flag_init( "cryofreeze_active" );
        ent_flag_set( "cryofreeze_active" );
        self.var_fb0325e04fae6ce8 = attacker;
        callback::callback( "on_enemy_cryofreeze" );
    }
    
    waitframe();
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( !istrue( var_4d0199c75efdcbfd ) )
    {
        playfx( getfx( "cryofreeze_impact" ), vpoint );
        thread function_7c31b836cdb7c555();
    }
    else
    {
        self.var_ea5c8d6a820ab8ae = 1;
    }
    
    var_2024d56fc08df992 = isdefined( overrideduration ) ? overrideduration : default_to( level.var_f1240a9ac4f65616.var_2024d56fc08df992, 5 );
    var_8630a9ddd5ccb60b = isdefined( var_11deb067b7e33bb5 ) ? var_11deb067b7e33bb5 : default_to( level.var_f1240a9ac4f65616.var_8630a9ddd5ccb60b, 0.5 );
    slow( "cryofreeze", var_8630a9ddd5ccb60b, var_2024d56fc08df992, attacker, &function_e2d0deba65109366 );
}

// Namespace cryofreeze / namespace_a7f426fbebc3a6f4
// Params 0
// Checksum 0x0, Offset: 0x68c
// Size: 0xab, Type: bool
function function_3713b5166b308321()
{
    if ( istrue( level.ammo_mods[ "cryofreeze" ].immune_result_direct[ self.basearchetype ] ) )
    {
        return false;
    }
    
    if ( isdefined( self.var_51618a5cd18d54b ) )
    {
        var_c1e8182392b8f673 = [[ self.var_51618a5cd18d54b ]]();
        
        if ( !istrue( var_c1e8182392b8f673 ) )
        {
            return false;
        }
    }
    
    foreach ( result_func in level.var_86f3f0a869ad0f7f )
    {
        if ( !istrue( [[ result_func ]]() ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace cryofreeze / namespace_a7f426fbebc3a6f4
// Params 0
// Checksum 0x0, Offset: 0x740
// Size: 0xd
function function_2fb9b4401941c475()
{
    return has_slow( "cryofreeze" );
}

// Namespace cryofreeze / namespace_a7f426fbebc3a6f4
// Params 0
// Checksum 0x0, Offset: 0x756
// Size: 0x1f
function function_e2d0deba65109366()
{
    ent_flag_clear( "cryofreeze_active" );
    self.var_fb0325e04fae6ce8 = undefined;
    function_3f6403d878857236();
}

// Namespace cryofreeze / namespace_a7f426fbebc3a6f4
// Params 0
// Checksum 0x0, Offset: 0x77d
// Size: 0x4d
function function_7c31b836cdb7c555()
{
    level endon( "game_ended" );
    
    if ( self isscriptable() && self getscriptablehaspart( "cryofreeze" ) )
    {
        self setscriptablepartstate( "cryofreeze", "cryofreeze_off" );
        waitframe();
        
        if ( isalive( self ) )
        {
            self setscriptablepartstate( "cryofreeze", "cryofreeze_on" );
        }
    }
}

// Namespace cryofreeze / namespace_a7f426fbebc3a6f4
// Params 0
// Checksum 0x0, Offset: 0x7d2
// Size: 0x43
function function_3f6403d878857236()
{
    if ( istrue( self.var_ea5c8d6a820ab8ae ) )
    {
        self.var_ea5c8d6a820ab8ae = 0;
        return;
    }
    
    if ( self isscriptable() && self getscriptablehaspart( "cryofreeze" ) )
    {
        self setscriptablepartstate( "cryofreeze", "cryofreeze_shatter" );
    }
}

// Namespace cryofreeze / namespace_a7f426fbebc3a6f4
// Params 2
// Checksum 0x0, Offset: 0x81d
// Size: 0x53
function function_b6c568cd7589eed8( str_label, str_tag )
{
    level endon( "game_ended" );
    waitframe();
    fx = getfx( str_label );
    
    if ( isalive( self ) )
    {
        stopfxontag( fx, self, str_tag );
    }
    
    waitframe();
    
    if ( isalive( self ) )
    {
        playfxontag( fx, self, str_tag );
    }
}

// Namespace cryofreeze / namespace_a7f426fbebc3a6f4
// Params 1
// Checksum 0x0, Offset: 0x878
// Size: 0x75
function on_ai_damage( params )
{
    if ( function_2fb9b4401941c475() && isplayer( params.eattacker ) )
    {
        damage = function_136a046f13726c77( params.idamage, params.eattacker, params.smeansofdeath, params.shitloc, params.sweapon );
        return damage;
    }
    
    return -1;
}

// Namespace cryofreeze / namespace_a7f426fbebc3a6f4
// Params 5
// Checksum 0x0, Offset: 0x8f6
// Size: 0x5b
function function_136a046f13726c77( idamage, eattacker, smeansofdeath, shitloc, sweapon )
{
    var_4788909f64a3277d = default_to( level.var_f1240a9ac4f65616.var_4788909f64a3277d, 1.25 );
    idamage = var_4788909f64a3277d * idamage;
    return idamage;
}

// Namespace cryofreeze / namespace_a7f426fbebc3a6f4
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x95a
// Size: 0x7b
function private on_ai_killed( params )
{
    if ( function_2fb9b4401941c475() && isplayer( params.eattacker ) )
    {
        scoreeventparams = spawnstruct();
        scoreeventparams.scoreevent = #"cryofreeze_kill";
        scoreeventparams.reason = #"kill";
        params.eattacker callback::callback( "zombie_score_event", scoreeventparams );
    }
}

/#

    // Namespace cryofreeze / namespace_a7f426fbebc3a6f4
    // Params 0
    // Checksum 0x0, Offset: 0x9dd
    // Size: 0x7b, Type: dev
    function function_493389d543d8fb87()
    {
        foreach ( player in level.players )
        {
            currentweapon = player getcurrentweapon();
            player add_ammo_mod_to_weapon( currentweapon, "<dev string:x1c>" );
            player iprintlnbold( "<dev string:x2a>" );
        }
    }

    // Namespace cryofreeze / namespace_a7f426fbebc3a6f4
    // Params 0
    // Checksum 0x0, Offset: 0xa60
    // Size: 0x2f, Type: dev
    function function_750b525ce60bef6c()
    {
        function_6e7290c8ee4f558b( "<dev string:x46>" );
        function_a9a864379a098ad6( "<dev string:x57>", "<dev string:x6b>", &function_493389d543d8fb87, 0 );
        function_fe953f000498048f();
    }

#/
