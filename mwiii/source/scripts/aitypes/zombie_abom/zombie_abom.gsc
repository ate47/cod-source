#using script_38c251115537f16e;
#using script_3badb8914eb5ac16;
#using script_7edf952f8921aa6b;
#using scripts\aitypes\bt_util;
#using scripts\aitypes\zombie_abom\zombie_abom_audio;
#using scripts\aitypes\zombie_abom\zombie_abom_crawler_deploy;
#using scripts\aitypes\zombie_abom\zombie_abom_heads;
#using scripts\aitypes\zombie_abom\zombie_abom_metabones;
#using scripts\aitypes\zombie_abom\zombie_abom_swallow;
#using scripts\anim\utility_common;
#using scripts\anim\weaponlist;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\utility;

#namespace zombie_abom;

// Namespace zombie_abom / scripts\aitypes\zombie_abom\zombie_abom
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x315
// Size: 0x107
function private function_f49a30f92555b827( params )
{
    function_4880ef9ac634c6e5();
    function_8e401d26d58bc32d();
    function_581a1a8dcccb6a3e();
    function_e21b71f0f396bb06();
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &function_c8c10b313b3fcf09 );
    callback::get_template( self.animsetname ) callback::add( "shocked", &function_c8bbb80c04cd9a37 );
    callback::get_template( self.animsetname ) callback::add( "shocked_end", &function_deadba29b36b687d );
    callback::get_template( self.animsetname ) callback::add( "burned", &function_bf0fe7b30fa14180 );
    callback::get_template( self.animsetname ) callback::add( "burned_end", &function_788a3fa28ef17f52 );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned", &function_dbb5710ec418627e );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_end", &function_afa5ec2deb3f62a0 );
}

// Namespace zombie_abom / scripts\aitypes\zombie_abom\zombie_abom
// Params 1
// Checksum 0x0, Offset: 0x424
// Size: 0x150
function function_7c45a7e2b8990bee( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init_ai( self.zombieaisetting );
    assert( isdefined( self.zombieaisettings.var_e58a65b7a8f5973c ) );
    callback::add( "on_first_ai_init", &function_f49a30f92555b827 );
    self.var_183bb43a8d0e0829 = [];
    self.var_183bb43a8d0e0829[ 0 ] = "head_le";
    self.var_183bb43a8d0e0829[ 1 ] = "head_mid";
    self.var_183bb43a8d0e0829[ 2 ] = "head_ri";
    function_2094af5938acc348();
    function_265e0e58c950559();
    function_64bb14058709dfa1();
    function_5ccebaad82aa8913();
    function_688e6bf6742914c0();
    thread initscriptable();
    function_b5e57408c7878df7( &function_3eb25282a84208ad );
    set( "abom_pain", "pain", 0 );
    thread function_682cfa35bf3314ad();
    thread function_cd5d01aef56958f3();
    
    if ( istrue( self.zombieaisettings.var_e58a65b7a8f5973c.candeploycrawler ) )
    {
        self function_3e89eb3d8e3f1811( "can_deploy_crawler", 1 );
    }
    
    self pushplayer( 0 );
    self function_62004d7561fd321e();
    self.var_62b3e19a38e9dd02 = 0;
    self.allowfriendlyfire = 1;
    return anim.success;
}

// Namespace zombie_abom / scripts\aitypes\zombie_abom\zombie_abom
// Params 0
// Checksum 0x0, Offset: 0x57d
// Size: 0x41
function initscriptable()
{
    self endon( "death" );
    scripts\engine\utility::flag_wait( "scriptables_ready" );
    waitframe();
    
    if ( self isscriptable() )
    {
        utility::function_3ab9164ef76940fd( "base", "base_on" );
        utility::function_3ab9164ef76940fd( "spawn_reveal", "spawn_reveal" );
    }
}

// Namespace zombie_abom / scripts\aitypes\zombie_abom\zombie_abom
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5c6
// Size: 0xce
function private function_c8c10b313b3fcf09( params )
{
    params.body utility::function_3ab9164ef76940fd( "death_reveal", "death_reveal" );
    
    if ( istrue( ent_flag( "burned" ) ) )
    {
        if ( isdefined( params.body ) )
        {
            params.body utility::function_3ab9164ef76940fd( "burned", "burned_on" );
        }
    }
    else if ( istrue( ent_flag( "napalm_burned" ) ) )
    {
        if ( isdefined( params.body ) )
        {
            params.body utility::function_3ab9164ef76940fd( "napalm_burned", "napalm_burned_on" );
        }
    }
    
    body = function_d8853db47f5b98e4( params );
    
    if ( isdefined( body ) )
    {
        wait 2;
        body = function_d8853db47f5b98e4( params );
        
        if ( isdefined( body ) )
        {
            body delete();
        }
    }
}

// Namespace zombie_abom / scripts\aitypes\zombie_abom\zombie_abom
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x69c
// Size: 0x6b
function private function_3eb25282a84208ad( params )
{
    var_a66756ec0bfd073f = 0.2;
    
    if ( function_9f798527e4e931c3( params ) )
    {
        var_9a212dbd04d930eb = 0.05;
        params.damagemaxhealthcap = min( var_9a212dbd04d930eb, params.damagemaxhealthcap );
        return ( params.idamage * var_a66756ec0bfd073f );
    }
    
    return params.idamage;
}

// Namespace zombie_abom / scripts\aitypes\zombie_abom\zombie_abom
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x710
// Size: 0x7c, Type: bool
function private function_9f798527e4e931c3( damage_struct )
{
    if ( isdefined( damage_struct.einflictor ) && damage_struct.einflictor ent_flag( "abom_swallowed" ) )
    {
        return false;
    }
    
    if ( !isdefined( damage_struct.metabonename ) )
    {
        return true;
    }
    
    head_index = function_e5db29e6fd6f6a88( damage_struct.metabonename );
    
    if ( isdefined( head_index ) )
    {
        if ( function_2945ff43fceb0fc8( self, head_index ) != 2 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_abom / scripts\aitypes\zombie_abom\zombie_abom
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x795
// Size: 0x71
function private function_682cfa35bf3314ad()
{
    self enableavoidance( 0 );
    self.nododgemove = 1;
    self endon( "death" );
    
    while ( true )
    {
        in_bull_charge = istrue( self getaiblackboarddynamic( "in_bull_charge" ) );
        
        if ( in_bull_charge )
        {
            if ( self.collide_with_ai )
            {
                self.collide_with_ai = 0;
            }
        }
        else if ( !self.collide_with_ai )
        {
            self.collide_with_ai = 1;
        }
        
        waitframe();
    }
}

// Namespace zombie_abom / scripts\aitypes\zombie_abom\zombie_abom
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x80e
// Size: 0xd2
function private function_cd5d01aef56958f3()
{
    self endon( "death" );
    self function_3e89eb3d8e3f1811( "in_spawn_reveal", 1 );
    waitframe();
    
    if ( ent_flag( "stealth_enabled" ) )
    {
        self.stealth_enabled = 0;
    }
    
    wait 1;
    utility::function_3ab9164ef76940fd( "head_mid", "attached" );
    utility::function_3ab9164ef76940fd( "head_le", "attached" );
    utility::function_3ab9164ef76940fd( "head_ri", "attached" );
    function_3d2728c0e2252a1d( "head_mid", "open" );
    function_3d2728c0e2252a1d( "head_ri", "open" );
    function_3d2728c0e2252a1d( "head_le", "open" );
    wait 1;
    self clearaiblackboarddynamic( "in_spawn_reveal" );
    
    if ( ent_flag( "stealth_enabled" ) )
    {
        self.stealth_enabled = 1;
    }
    
    utility::function_3ab9164ef76940fd( "spawn_reveal", "off" );
}

// Namespace zombie_abom / scripts\aitypes\zombie_abom\zombie_abom
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x8e8
// Size: 0x1c
function private function_c8bbb80c04cd9a37( var_a21093610d4de2ed )
{
    utility::function_3ab9164ef76940fd( "shocked", "shocked_on" );
}

// Namespace zombie_abom / scripts\aitypes\zombie_abom\zombie_abom
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x90c
// Size: 0x1c
function private function_deadba29b36b687d( var_a21093610d4de2ed )
{
    utility::function_3677f2be30fdd581( "shocked", "shocked_off" );
}

// Namespace zombie_abom / scripts\aitypes\zombie_abom\zombie_abom
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x930
// Size: 0x1c
function private function_bf0fe7b30fa14180( var_12c084a213d7ad2 )
{
    utility::function_3ab9164ef76940fd( "burned", "burned_on" );
}

// Namespace zombie_abom / scripts\aitypes\zombie_abom\zombie_abom
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x954
// Size: 0x1c
function private function_788a3fa28ef17f52( var_12c084a213d7ad2 )
{
    utility::function_3677f2be30fdd581( "burned", "burned_off" );
}

// Namespace zombie_abom / scripts\aitypes\zombie_abom\zombie_abom
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x978
// Size: 0x1c
function private function_dbb5710ec418627e( var_12c084a213d7ad2 )
{
    utility::function_3ab9164ef76940fd( "napalm_burned", "napalm_burned_on" );
}

// Namespace zombie_abom / scripts\aitypes\zombie_abom\zombie_abom
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x99c
// Size: 0x1c
function private function_afa5ec2deb3f62a0( var_12c084a213d7ad2 )
{
    utility::function_3677f2be30fdd581( "napalm_burned", "napalm_burned_off" );
}

