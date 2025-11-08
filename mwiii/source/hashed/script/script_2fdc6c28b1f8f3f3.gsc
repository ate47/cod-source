#using script_554830d27078277d;
#using script_6bffae1b97f70547;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace brainrot;

// Namespace brainrot / namespace_73918c307cdbe1ff
// Params 0
// Checksum 0x0, Offset: 0x17c
// Size: 0x334
function init_brainrot()
{
    if ( !istrue( level.var_bfa98c9dd6edb929 ) )
    {
        return;
    }
    
    level endon( "game_ended" );
    level._effect[ "vfx_zai_exp_aoe_brain_rot" ] = loadfx( level.var_f1240a9ac4f65616.var_fb1ea41cdec7fb3d );
    flag_wait( "ammo_mods_ready" );
    flag_init( "brainrot_ready" );
    var_746d800f9d085b2a = getdvarfloat( @"hash_e5d9831d19a49874", isdefined( level.var_f1240a9ac4f65616.brainrotpercentage ) ? level.var_f1240a9ac4f65616.brainrotpercentage : 0.15 );
    var_ad5528a4132dc97d = getdvarfloat( @"hash_7a0b932dc704d890", isdefined( level.var_f1240a9ac4f65616.var_ef4776d7c7a5e1b7 ) ? level.var_f1240a9ac4f65616.var_ef4776d7c7a5e1b7 : 0.03 );
    cooldownentity = getdvarfloat( @"hash_48bb866e33cc0a98", isdefined( level.var_f1240a9ac4f65616.var_6902494309ecdf82 ) ? level.var_f1240a9ac4f65616.var_6902494309ecdf82 : 0 );
    cooldownattacker = getdvarfloat( @"hash_b274fefae7b30b9c", isdefined( level.var_f1240a9ac4f65616.var_77f6495a5efa75b6 ) ? level.var_f1240a9ac4f65616.var_77f6495a5efa75b6 : 40 );
    cooldownglobal = getdvarfloat( @"hash_73abd79b8e6537b4", isdefined( level.var_f1240a9ac4f65616.var_d79991c2a1c06c16 ) ? level.var_f1240a9ac4f65616.var_d79991c2a1c06c16 : 5 );
    var_f27a8d5708fd9c4d = getdvarint( @"hash_98bef196ad6233f7", isdefined( level.var_f1240a9ac4f65616.var_d337dfeb11be1d02 ) ? level.var_f1240a9ac4f65616.var_d337dfeb11be1d02 : 1 );
    damagefeedbackicon = isdefined( level.var_f1240a9ac4f65616.var_609b1a97084eeeef ) ? level.var_f1240a9ac4f65616.var_609b1a97084eeeef : "";
    damagefeedbacksound = isdefined( level.var_f1240a9ac4f65616.var_4c0e7ad946f68c49 ) ? level.var_f1240a9ac4f65616.var_4c0e7ad946f68c49 : "";
    element = isdefined( level.var_f1240a9ac4f65616.brainrotelement ) ? level.var_f1240a9ac4f65616.brainrotelement : "toxic";
    level.var_37f448fda9dfdd24 = [];
    level.var_fda3ff4feb6c4546 = [];
    level callback::add( "on_ai_killed", &function_266be48a55c0cdc5 );
    function_7f759db5de1b44b0( "brainrot", 1, var_746d800f9d085b2a, var_ad5528a4132dc97d, cooldownentity, cooldownattacker, cooldownglobal, var_f27a8d5708fd9c4d, &function_52575fe8c8a247f8, damagefeedbackicon, damagefeedbacksound, &function_e77373dffa58f4fe, element );
    registersharedfunc( "zombie_utils", "set_brainrot", &set_brainrot );
    flag_set( "brainrot_ready" );
    
    /#
        level thread function_eb3305baa083c02d();
    #/
}

// Namespace brainrot / namespace_73918c307cdbe1ff
// Params 1
// Checksum 0x0, Offset: 0x4b8
// Size: 0x21
function function_8bd543daa9037db7( func )
{
    level.var_37f448fda9dfdd24[ level.var_37f448fda9dfdd24.size ] = func;
}

// Namespace brainrot / namespace_73918c307cdbe1ff
// Params 1
// Checksum 0x0, Offset: 0x4e1
// Size: 0x21
function function_7d4e03466fcf5dc9( func )
{
    level.var_fda3ff4feb6c4546[ level.var_fda3ff4feb6c4546.size ] = func;
}

// Namespace brainrot / namespace_73918c307cdbe1ff
// Params 0
// Checksum 0x0, Offset: 0x50a
// Size: 0x2a
function function_aada6661ca89c2af()
{
    brainrottime = default_to( level.var_f1240a9ac4f65616.brainrottime, 15 );
    return brainrottime;
}

// Namespace brainrot / namespace_73918c307cdbe1ff
// Params 0
// Checksum 0x0, Offset: 0x53d
// Size: 0x2a
function function_3c3ea73ba0073f0a()
{
    var_97a50fc940220bd7 = default_to( level.var_f1240a9ac4f65616.var_97a50fc940220bd7, 6 );
    return var_97a50fc940220bd7;
}

// Namespace brainrot / namespace_73918c307cdbe1ff
// Params 2
// Checksum 0x0, Offset: 0x570
// Size: 0xbf
function set_brainrot( attacker, player_owner )
{
    brainrottime = function_aada6661ca89c2af();
    success = charm( brainrottime, attacker, &brainrot_end );
    
    if ( success )
    {
        self function_65cdab0fc78aba8f( attacker.origin, 2000 );
        self.ignoreme = 1;
        params = spawnstruct();
        params.attacker = attacker;
        self.var_941802a0997e0c42 = player_owner;
        self.var_dec41e66d2f7fffd = self.maxhealth;
        self.brainrot_kills = 0;
        callback::callback( "on_turned", params );
        thread function_9814cb5a82d0bc92();
        thread zombie_kill_tracker();
    }
}

// Namespace brainrot / namespace_73918c307cdbe1ff
// Params 7
// Checksum 0x0, Offset: 0x637
// Size: 0xf0
function function_52575fe8c8a247f8( death, attacker, mod, sweapon, vpoint, shitloc, modelindex )
{
    if ( level.var_37f448fda9dfdd24.size > 0 )
    {
        foreach ( result_func in level.var_37f448fda9dfdd24 )
        {
            [[ result_func ]]( death, attacker, mod, sweapon, vpoint, shitloc, modelindex );
        }
        
        return;
    }
    
    if ( isplayer( attacker ) )
    {
        if ( isdefined( self.aicategory ) && ( self.aicategory == "normal" || self.aicategory == "special" ) )
        {
            set_brainrot( attacker, attacker );
        }
    }
}

// Namespace brainrot / namespace_73918c307cdbe1ff
// Params 0
// Checksum 0x0, Offset: 0x72f
// Size: 0x3f
function zombie_kill_tracker()
{
    self endon( "death" );
    var_97a50fc940220bd7 = function_3c3ea73ba0073f0a();
    
    while ( self.brainrot_kills < var_97a50fc940220bd7 )
    {
        wait 1;
    }
    
    if ( isalive( self ) )
    {
        brainrot_end();
    }
}

// Namespace brainrot / namespace_73918c307cdbe1ff
// Params 0
// Checksum 0x0, Offset: 0x776
// Size: 0x24
function function_9814cb5a82d0bc92()
{
    waitframe();
    
    if ( isdefined( self ) && isalive( self ) )
    {
        self.health = self.maxhealth;
    }
}

// Namespace brainrot / namespace_73918c307cdbe1ff
// Params 0
// Checksum 0x0, Offset: 0x7a2
// Size: 0xab, Type: bool
function function_e77373dffa58f4fe()
{
    if ( istrue( level.ammo_mods[ "brainrot" ].immune_result_direct[ self.basearchetype ] ) )
    {
        return false;
    }
    
    if ( isdefined( self.var_c3554a26521188a8 ) )
    {
        failbrainrot = [[ self.var_c3554a26521188a8 ]]();
        
        if ( !istrue( failbrainrot ) )
        {
            return false;
        }
    }
    
    foreach ( result_func in level.var_fda3ff4feb6c4546 )
    {
        if ( !istrue( [[ result_func ]]() ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace brainrot / namespace_73918c307cdbe1ff
// Params 0
// Checksum 0x0, Offset: 0x856
// Size: 0x76
function brainrot_end()
{
    self.forceannihilate = 1;
    playfx( getfx( "vfx_zai_exp_aoe_brain_rot" ), self.origin );
    
    if ( isplayer( self.var_941802a0997e0c42 ) && isalive( self.var_941802a0997e0c42 ) )
    {
        self kill( self.origin, self.var_941802a0997e0c42 );
        return;
    }
    
    self kill( self.origin );
}

// Namespace brainrot / namespace_73918c307cdbe1ff
// Params 1
// Checksum 0x0, Offset: 0x8d4
// Size: 0x4a
function function_266be48a55c0cdc5( sparams )
{
    if ( isdefined( sparams.eattacker ) && isdefined( sparams.eattacker.var_941802a0997e0c42 ) )
    {
        sparams.eattacker.brainrot_kills++;
    }
}

/#

    // Namespace brainrot / namespace_73918c307cdbe1ff
    // Params 0
    // Checksum 0x0, Offset: 0x926
    // Size: 0x7b, Type: dev
    function function_4eca2aaa68c96aa0()
    {
        foreach ( player in level.players )
        {
            currentweapon = player getcurrentweapon();
            player add_ammo_mod_to_weapon( currentweapon, "<dev string:x1c>" );
            player iprintlnbold( "<dev string:x28>" );
        }
    }

    // Namespace brainrot / namespace_73918c307cdbe1ff
    // Params 0
    // Checksum 0x0, Offset: 0x9a9
    // Size: 0x2f, Type: dev
    function function_eb3305baa083c02d()
    {
        function_6e7290c8ee4f558b( "<dev string:x42>" );
        function_a9a864379a098ad6( "<dev string:x53>", "<dev string:x65>", &function_4eca2aaa68c96aa0, 0 );
        function_fe953f000498048f();
    }

#/
