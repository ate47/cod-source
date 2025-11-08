#using script_13d927d1fbe8598c;
#using script_25a541cdebf5c6ce;
#using script_2cd07641bf71242a;
#using script_3b7ffa11ee92fc3;
#using script_3badb8914eb5ac16;
#using script_4e131720d70aa378;
#using script_7edf952f8921aa6b;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace zombie_abom_asm;

// Namespace zombie_abom_asm / scripts\asm\zombie_abom\zombie_abom_asm
// Params 1
// Checksum 0x0, Offset: 0x13e
// Size: 0x13
function precache( params )
{
    function_cf142512f48666b7( params );
}

// Namespace zombie_abom_asm / scripts\asm\zombie_abom\zombie_abom_asm
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x159
// Size: 0x10
function private function_f49a30f92555b827()
{
    function_304c63cbb536c526();
    function_e666bc1f7f826ea2();
}

// Namespace zombie_abom_asm / scripts\asm\zombie_abom\zombie_abom_asm
// Params 3
// Checksum 0x0, Offset: 0x171
// Size: 0xe7
function function_7c45a7e2b8990bee( asmname, statename, params )
{
    function_a343ac31ca854535( &function_f49a30f92555b827 );
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    asm_setmoveplaybackrate( 1 );
    function_ac7db7e26eb6926c();
    function_1d4cf90e795ad643();
    function_c84ae25edc875e49();
    function_75a233b1c9abd8f();
    function_64d97cf652a4d385();
    callback::add( "on_ai_init", &on_ai_init );
    ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_abom_asm / scripts\asm\zombie_abom\zombie_abom_asm
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x260
// Size: 0x2e
function private on_ai_init( params )
{
    function_f1e5805da192a1ef( "run", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

