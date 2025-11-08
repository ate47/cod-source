#using script_16ea1b94f0f381b3;
#using script_1e2b21a2f6c06fac;
#using script_23b580b08abe064f;
#using script_310397f2ad072bde;
#using script_38c251115537f16e;
#using script_3b78d23dad7ec5be;
#using script_3badb8914eb5ac16;
#using script_5a4a5d9ba343ff8f;
#using script_7edf952f8921aa6b;
#using scripts\aitypes\bt_util;
#using scripts\anim\utility_common;
#using scripts\anim\weaponlist;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment\molotov;
#using scripts\mp\rank;

#namespace zombie_hellhound;

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 1
// Checksum 0x0, Offset: 0x54f
// Size: 0x13
function precache( params )
{
    function_b527524106e2d980( params );
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x56a
// Size: 0x163
function private function_f49a30f92555b827( params )
{
    function_842e17022dab63c3();
    function_8e401d26d58bc32d();
    callback::get_template( self.animsetname ) callback::add( "on_turned", &function_e809d2e0583ea302 );
    callback::get_template( self.animsetname ) callback::add( "shocked", &function_c8bbb80c04cd9a37 );
    callback::get_template( self.animsetname ) callback::add( "shocked_end", &function_deadba29b36b687d );
    callback::get_template( self.animsetname ) callback::add( "burned", &function_bf0fe7b30fa14180 );
    callback::get_template( self.animsetname ) callback::add( "burned_end", &function_788a3fa28ef17f52 );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned", &function_dbb5710ec418627e );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_end", &function_afa5ec2deb3f62a0 );
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &function_c8c10b313b3fcf09 );
    callback::get_template( self.animsetname ) callback::add( "spawn_animscripted", &function_6b324dd53aa590da );
    callback::get_template( self.animsetname ) callback::add( "zombie_melee", &function_619c067c56623b02 );
    
    /#
        function_c9e001e49a9899b9();
    #/
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 1
// Checksum 0x0, Offset: 0x6d5
// Size: 0x14f
function function_e62bc0179274066c( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init_ai( self.zombieaisetting );
    assert( isdefined( self.zombieaisettings.var_e58a65b7a8f5973c ) );
    callback::add( "on_first_ai_init", &function_f49a30f92555b827 );
    function_1fc0eb1eb90c8dd0( "walk", 64 );
    function_1fc0eb1eb90c8dd0( "run", 160 );
    function_1fc0eb1eb90c8dd0( "sprint", 220 );
    function_1fc0eb1eb90c8dd0( "super_sprint", 220 );
    self.var_c3554a26521188a8 = &function_a8c9248308033e4e;
    function_b5e57408c7878df7( &function_cb228ad4c8cfdff4 );
    self.allowstrafe = 0;
    self.var_a0a21e4139ad1af4 = 1;
    
    if ( getdvarint( @"hash_e21e718cfe10e8c2" ) == 1 )
    {
        if ( istrue( self.zombieaisettings.var_e58a65b7a8f5973c.diggingenabled ) )
        {
            if ( isdefined( self.zombieaisettings.var_e58a65b7a8f5973c.diggingitemspawnlist ) )
            {
                thread dig_monitor();
            }
        }
    }
    
    init_knockdown();
    function_265e0e58c950559();
    function_8f8cff4c91f6845b();
    thread initscriptable();
    thread function_c15f0cdbdebc41b4();
    return anim.success;
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 0
// Checksum 0x0, Offset: 0x82d
// Size: 0x68
function initscriptable()
{
    self endon( "death" );
    scripts\engine\utility::flag_wait( "scriptables_ready" );
    waitframe();
    
    if ( self isscriptable() )
    {
        var_2586c4df00068e74 = 0;
        
        if ( self getscriptablehaspart( "cryofreeze" ) && self getscriptablepartstate( "cryofreeze" ) == "cryofreeze_on" )
        {
            var_2586c4df00068e74 = 1;
        }
        
        if ( !var_2586c4df00068e74 )
        {
            utility::function_3ab9164ef76940fd( "base", "base_on" );
        }
    }
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x89d
// Size: 0x75
function private function_b527524106e2d980( params )
{
    zombieaisettings = getscriptbundle( "zombieaisettings:" + params.zombieaisetting );
    zombiehellhoundaisettings = getscriptbundle( zombieaisettings.var_fef5d84db3c8e7f7 );
    utility::add_fx( "hellhound_spawn_flash_fx", zombiehellhoundaisettings.spawnvfx );
    utility::add_fx( "hellhound_spawn_in_fx", zombiehellhoundaisettings.var_848dc4e5882f3b52 );
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x91a
// Size: 0xc6
function private function_c8c10b313b3fcf09( params )
{
    if ( istrue( ent_flag( "burned" ) ) )
    {
        if ( isdefined( params.body ) )
        {
            params.body utility::function_3ab9164ef76940fd( "burned", "burned_on" );
            params.body thread function_d13d798c34386976();
        }
    }
    else if ( istrue( ent_flag( "napalm_burned" ) ) )
    {
        if ( isdefined( params.body ) )
        {
            params.body utility::function_3ab9164ef76940fd( "napalm_burned", "napalm_burned_on" );
            params.body thread function_c14610f0b3bdffe6();
        }
    }
    
    thread death_explode( params.body, params.eattacker );
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x9e8
// Size: 0x1e
function private function_d13d798c34386976()
{
    wait 3;
    
    if ( isdefined( self ) )
    {
        utility::function_3677f2be30fdd581( "burned", "burned_off" );
    }
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xa0e
// Size: 0x1e
function private function_c14610f0b3bdffe6()
{
    wait 3;
    
    if ( isdefined( self ) )
    {
        utility::function_3677f2be30fdd581( "napalm_burned", "napalm_burned_off" );
    }
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xa34
// Size: 0x1c
function private function_c8bbb80c04cd9a37( var_a21093610d4de2ed )
{
    utility::function_3ab9164ef76940fd( "shocked", "shocked_on" );
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xa58
// Size: 0x1c
function private function_deadba29b36b687d( var_a21093610d4de2ed )
{
    utility::function_3677f2be30fdd581( "shocked", "shocked_off" );
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xa7c
// Size: 0x1c
function private function_bf0fe7b30fa14180( var_12c084a213d7ad2 )
{
    utility::function_3ab9164ef76940fd( "burned", "burned_on" );
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xaa0
// Size: 0x1c
function private function_788a3fa28ef17f52( var_12c084a213d7ad2 )
{
    utility::function_3677f2be30fdd581( "burned", "burned_off" );
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xac4
// Size: 0x1c
function private function_dbb5710ec418627e( var_12c084a213d7ad2 )
{
    utility::function_3ab9164ef76940fd( "napalm_burned", "napalm_burned_on" );
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xae8
// Size: 0x28
function private function_afa5ec2deb3f62a0( var_12c084a213d7ad2 )
{
    ent_flag_clear( "napalm_burned" );
    utility::function_3677f2be30fdd581( "napalm_burned", "napalm_burned_off" );
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xb18
// Size: 0x45
function private function_e809d2e0583ea302( var_8c62cb683d643eb7 )
{
    function_f1e5805da192a1ef( "sprint", "turned", 25 );
    utility::function_3ab9164ef76940fd( "brainrot", "brainrot_on" );
    self._blackboard.var_8d19c6ba087e7a86 = 1;
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 0
// Checksum 0x0, Offset: 0xb65
// Size: 0x13, Type: bool
function function_a8c9248308033e4e()
{
    if ( istrue( self.var_f8a44d7cde24460a ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xb81
// Size: 0x30a
function private death_explode( body, attacker )
{
    level endon( "game_ended" );
    utility::function_3ab9164ef76940fd( "base", "base_off" );
    body utility::function_3ab9164ef76940fd( "base", "base_on" );
    explode_time = 0.5;
    
    if ( isdefined( self.asmname ) )
    {
        statename = self asmgetcurrentstate( self.asmname );
        animid = asm_getanim( self.asmname, statename );
        xanim = asm_getxanim( statename, animid );
        animlength = getanimlength( xanim );
        
        if ( animhasnotetrack( xanim, "zombie_dog_explode" ) )
        {
            explodefrac = getnotetracktimes( xanim, "zombie_dog_explode" )[ 0 ];
            explode_time = animlength * explodefrac;
        }
    }
    
    flame_struct = spawnstruct();
    flame_struct.var_6f31a7068904c04a = self.zombieaisettings.var_e58a65b7a8f5973c.var_afaf1e2ffb9ece69;
    flame_struct.var_1ef1cf7ab37370f3 = self.zombieaisettings.var_e58a65b7a8f5973c.var_9d3a40c028602d2e;
    flame_struct.var_93f824ae56e54ef3 = self.zombieaisettings.var_e58a65b7a8f5973c.var_65d26f6523498490;
    flame_struct.flame_duration = self.zombieaisettings.var_e58a65b7a8f5973c.flameduration;
    flame_struct.round_number = function_2201d3f3d7ab07a7();
    wait explode_time;
    
    if ( isdefined( body ) )
    {
        blast_radius = 65;
        var_d7daf7298f4b8f1a = 17;
        var_537db625234e9bb3 = 7;
        var_951f208ecf500c87 = 0.1;
        body utility::function_3ab9164ef76940fd( "death", "explode_on" );
        tag = "j_spine2";
        explode_origin = body gettagorigin( tag );
        explode_origin = utility::groundpos( explode_origin );
        fire_ent = spawn( "script_model", explode_origin );
        
        if ( !isdefined( fire_ent ) )
        {
            fire_ent = body;
            body setcorpseremovetimer( flame_struct.flame_duration + var_951f208ecf500c87 );
        }
        
        fire_ent.owner = attacker;
        fire_ent.weapon_name = "hellhound_molotov";
        fire_ent.prevent_knockdown = 1;
        fire_ent.var_6f3cee3c008da525 = &function_6f3cee3c008da525;
        level thread function_ddb55358dcda86f1( explode_origin, blast_radius, var_d7daf7298f4b8f1a, var_537db625234e9bb3, attacker, body, "MOD_EXPLOSIVE", flame_struct, fire_ent );
        level thread explosion_knockdown( explode_origin, blast_radius, body );
        body thread function_78b13007be57d581( explode_origin, flame_struct.flame_duration, attacker, fire_ent );
        wait var_951f208ecf500c87;
        
        if ( !isdefined( body ) )
        {
            return;
        }
        
        body hide();
        wait flame_struct.flame_duration;
        
        if ( isdefined( body ) )
        {
            body delete();
        }
        
        if ( isdefined( fire_ent ) )
        {
            fire_ent delete();
        }
    }
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 9, eflags: 0x4
// Checksum 0x0, Offset: 0xe93
// Size: 0x252
function private function_ddb55358dcda86f1( origin, radius, inner_damage, outer_damage, attacker, exploder, means_of_death, flame_struct, fire_ent )
{
    level endon( "game_ended" );
    potential_targets = [];
    potential_targets = getaiarrayinradius( origin, radius );
    
    if ( isdefined( exploder.team ) )
    {
        players = getplayersinradius( origin, radius );
        potential_players = [];
        
        foreach ( player in players )
        {
            if ( exploder.team != player.team )
            {
                potential_players[ potential_players.size ] = player;
            }
        }
        
        if ( potential_players.size )
        {
            potential_targets = array_combine( potential_targets, potential_players );
        }
    }
    
    if ( !isdefined( attacker ) )
    {
        attacker = fire_ent;
    }
    
    foreach ( target in potential_targets )
    {
        if ( !isalive( target ) || target == exploder )
        {
            continue;
        }
        
        var_4724784e2530a13f = mapfloat( 0, radius, inner_damage, outer_damage, distance( target.origin, origin ) );
        
        if ( isai( target ) )
        {
            n_round = flame_struct.round_number;
            
            if ( n_round >= flame_struct.var_6f31a7068904c04a )
            {
                if ( n_round > flame_struct.var_1ef1cf7ab37370f3 )
                {
                    n_round = flame_struct.var_1ef1cf7ab37370f3;
                }
                
                adjustment_rounds = n_round - flame_struct.var_6f31a7068904c04a + 1;
                adjustment_percentage = 1 + flame_struct.var_93f824ae56e54ef3;
                var_ee7508144d16292c = pow( adjustment_percentage, adjustment_rounds );
                var_4724784e2530a13f = int( var_4724784e2530a13f * var_ee7508144d16292c );
            }
        }
        
        var_4724784e2530a13f = int( var_4724784e2530a13f );
        target dodamage( var_4724784e2530a13f, origin, attacker, fire_ent, means_of_death, undefined, "torso_lower" );
    }
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x10ed
// Size: 0x99
function private explosion_knockdown( origin, radius, exploder )
{
    potential_targets = getaiarrayinradius( origin, radius );
    
    foreach ( target in potential_targets )
    {
        if ( !isalive( target ) || target == exploder )
        {
            continue;
        }
        
        if ( !target function_e67a89537ae7d4b7() )
        {
            target knockdown_ai( origin );
        }
    }
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x118e
// Size: 0x12d
function private function_78b13007be57d581( fire_position, duration, attacker, fire_ent )
{
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    burnbundle = spawnstruct();
    burnbundle.var_e0cf068ccab49e34 = 2;
    burnbundle.var_81c84c326caec1d2 = 2;
    burnbundle.var_74fbf35a2265fa59 = 2;
    burnbundle.var_439885d26a2f9bf5 = 0.2;
    fire_ent.var_e569b726ededed94 = burnbundle;
    fire_ent.blueprintdefindex = 0;
    
    if ( isdefined( level.equipment.table[ "equip_molotov" ] ) )
    {
        equipment_molotov = level.equipment.table[ "equip_molotov" ];
        
        if ( isdefined( equipment_molotov.objweapon ) )
        {
            burnbundle.useweapon = equipment_molotov.objweapon;
        }
    }
    
    thread scripts\mp\equipment\molotov::molotov_simulate_impact( fire_ent, fire_position, ( 0, 0, 1 ), undefined, ( 0, 0, 100 ), gettime(), "equip_molotov_hellhound_pool_mp_p" );
    thread function_6e86bd36fa3acc99( fire_position );
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x12c3
// Size: 0x7e
function private function_6e86bd36fa3acc99( position )
{
    self endon( "death" );
    ignore = undefined;
    
    if ( isalive( ignore ) )
    {
        ignore = self;
    }
    
    trace = scripts\engine\trace::_bullet_trace( position + ( 0, 0, 20 ), position, 0, ignore );
    under_water = trace[ "surfacetype" ] == "surftype_water";
    
    if ( !under_water )
    {
        if ( isdefined( self ) )
        {
            utility::function_3ab9164ef76940fd( "death_impact", "impact_on" );
        }
    }
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1349
// Size: 0x78
function private function_cb228ad4c8cfdff4( params )
{
    if ( isdefined( params.einflictor ) && is_equal( params.einflictor.weapon_name, "hellhound_molotov" ) )
    {
        return 0;
    }
    
    if ( isdefined( self.var_182bc385bd9c0c1d ) )
    {
        newdamage = self [[ self.var_182bc385bd9c0c1d ]]( params );
        
        if ( isdefined( newdamage ) )
        {
            return newdamage;
        }
    }
    
    return params.idamage;
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x13ca
// Size: 0x1bf
function private function_6b324dd53aa590da( params )
{
    level endon( "game_ended" );
    self endon( "death" );
    var_b6a017ab1b344adf = "show_hound";
    self hide();
    thread function_cc4e2461ddaebfd7();
    scriptable = undefined;
    
    if ( isdefined( self.zombieaisettings.var_e58a65b7a8f5973c.spawnscriptable ) )
    {
        scriptable = spawnscriptable( self.zombieaisettings.var_e58a65b7a8f5973c.spawnscriptable, self.origin + ( 0, 0, 90 ), self.angles );
        scriptable setscriptablepartstate( "spawn_fx", "spawn_loop" );
    }
    
    thread function_56d21bc47a25d617( scriptable, var_b6a017ab1b344adf );
    waitframe();
    show_time = 2;
    
    if ( isdefined( self.asmname ) )
    {
        animparams = undefined;
        
        if ( isdefined( params ) && isdefined( params.aliasname ) )
        {
            animparams = [ params.aliasname ];
        }
        
        statename = self asmgetcurrentstate( self.asmname );
        animid = asm_getanim( self.asmname, statename, animparams );
        xanim = asm_getxanim( statename, animid );
        animlength = getanimlength( xanim );
        
        if ( animhasnotetrack( xanim, var_b6a017ab1b344adf ) )
        {
            frac = getnotetracktimes( xanim, var_b6a017ab1b344adf )[ 0 ];
            show_time = animlength * frac;
        }
    }
    
    wait show_time;
    self notify( var_b6a017ab1b344adf );
    
    if ( isalive( self ) )
    {
        self notify( "show_hellhound" );
        thread function_37e7327e560b34b6();
        
        if ( isalive( self ) )
        {
            self show();
        }
    }
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1592
// Size: 0x15
function private function_cc4e2461ddaebfd7()
{
    wait 10;
    
    if ( isalive( self ) )
    {
        self show();
    }
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x15af
// Size: 0x33
function private function_56d21bc47a25d617( scriptable, end_note )
{
    level endon( "game_ended" );
    waittill_either( end_note, "death" );
    
    if ( isdefined( scriptable ) )
    {
        scriptable freescriptable();
    }
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x15ea
// Size: 0x13
function private function_37e7327e560b34b6()
{
    utility::function_3ab9164ef76940fd( "spawn_fx", "spawn_flash" );
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 1
// Checksum 0x0, Offset: 0x1605
// Size: 0x12e
function hellhound_dig( item_count )
{
    self endon( "death" );
    level endon( "game_ended" );
    
    if ( !isdefined( item_count ) )
    {
        item_count = 1;
    }
    
    thread animscripted_sharedfunc( "dig", "hellhound_dig_complete", undefined, undefined, undefined );
    utility::function_3ab9164ef76940fd( "digging", "digging_on" );
    self waittill( "hellhound_dig_complete" );
    utility::function_3ab9164ef76940fd( "digging", "digging_off" );
    
    if ( isdefined( self.var_941802a0997e0c42 ) )
    {
        closestplayer = namespace_99b160f0b52a4db::function_874f6b6d8f270d36();
        
        if ( distancesquared( closestplayer.origin, self.origin ) > 40000 )
        {
            self waittill( "ob_pet_player_reached" );
        }
        
        wait 0.75;
        head_pos = self gettagorigin( "j_head" );
        item = spawnpickupfromlistsharedfunc( self.zombieaisettings.var_e58a65b7a8f5973c.diggingitemspawnlist, item_count, head_pos );
    }
    else
    {
        item = spawnpickupfromlistsharedfunc( self.zombieaisettings.var_e58a65b7a8f5973c.diggingitemspawnlist, item_count, self.origin );
    }
    
    self.digging_object = 0;
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x173b
// Size: 0xcf
function private dig_monitor()
{
    self endon( "death" );
    level endon( "game_ended" );
    self.digging_object = 0;
    dig_wait = 30;
    
    while ( true )
    {
        wait randomfloat( dig_wait );
        
        if ( randomfloat( 1 ) < 0.5 )
        {
            is_turned = 0;
            
            if ( namespace_c56b0b75fd51eab1::function_8ce7894f1a52fb77( "charm" ) )
            {
                is_turned = 1;
            }
            
            if ( !self.digging_object )
            {
                if ( is_turned )
                {
                    if ( !isdefined( self.enemy ) && !istrue( self.petting ) )
                    {
                        self.digging_object = 1;
                        thread hellhound_dig( 1 );
                    }
                }
                else if ( !isdefined( self.enemy ) )
                {
                    self.digging_object = 1;
                    thread hellhound_dig( 1 );
                }
            }
        }
        
        wait dig_wait;
    }
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1812
// Size: 0x28
function private function_c15f0cdbdebc41b4()
{
    self endon( "death" );
    level endon( "game_ended" );
    
    while ( true )
    {
        self waittill( "bmeleeended" );
        thread function_5825d55253f004b2();
    }
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1842
// Size: 0x52
function private function_5825d55253f004b2()
{
    var_c95d96659ab72b55 = 1;
    level endon( "game_ended" );
    self endon( "death" );
    self notify( "start_chase_slowdown" );
    self endon( "start_chase_slowdown" );
    function_f1e5805da192a1ef( "walk", "chase_slowdown", 15 );
    wait var_c95d96659ab72b55;
    function_f1e5805da192a1ef( undefined, "chase_slowdown" );
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x189c
// Size: 0x4a
function private function_619c067c56623b02( params )
{
    if ( isdefined( params.meleehitent ) && isplayer( params.meleehitent ) )
    {
        params.meleehitent utility::function_3ab9164ef76940fd( "hellhoundMeleeVFX", "hit_fx" );
    }
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x18ee
// Size: 0x5a
function private function_6f3cee3c008da525()
{
    attacker = self.owner;
    
    if ( !isdefined( attacker ) || !isplayer( attacker ) )
    {
        return;
    }
    
    if ( !isdefined( self.kill_count ) )
    {
        self.kill_count = 0;
    }
    
    self.kill_count++;
    attacker function_b8e70cc126c2fd5c( self.kill_count );
}

// Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1950
// Size: 0x58
function private function_b8e70cc126c2fd5c( kill_count )
{
    attacker = self;
    
    if ( isplayer( attacker ) && kill_count == 5 )
    {
        points = scripts\mp\rank::getscoreinfovalue( #"hash_b937bf9fd26f15f1" );
        
        if ( isdefined( points ) )
        {
            attacker doscoreeventsharedfunc( #"hash_b937bf9fd26f15f1" );
        }
    }
}

/#

    // Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x19b0
    // Size: 0x2f, Type: dev
    function private function_c9e001e49a9899b9()
    {
        waitframe();
        function_6e7290c8ee4f558b( "<dev string:x1c>" );
        function_a9a864379a098ad6( "<dev string:x30>", "<dev string:x52>", &function_2400186ca86b8b7d );
        function_fe953f000498048f();
    }

    // Namespace zombie_hellhound / namespace_66aa06755cfb5bdd
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x19e7
    // Size: 0xe7, Type: dev
    function private function_2400186ca86b8b7d( params )
    {
        player = level.players[ 0 ];
        ai_array = getaiarrayinradius( player.origin, 500 );
        
        foreach ( ai in ai_array )
        {
            if ( !isalive( ai ) || isdefined( ai.subclass ) && !issubstr( ai.subclass, "<dev string:x67>" ) )
            {
                continue;
            }
            
            if ( ai asmhasstate( ai.asmname, "<dev string:x7b>" ) )
            {
                ai startliveragdoll();
                ai function_ac90fa5cc0a80298( "<dev string:x7b>" );
            }
        }
    }

#/
