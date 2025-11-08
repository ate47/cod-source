#using script_2cd07641bf71242a;
#using script_3badb8914eb5ac16;
#using script_3e4f26df9dc4b465;
#using script_4d5690421d14cda9;
#using script_4fa22bc28608e9bd;
#using script_7edf952f8921aa6b;
#using script_ac32c5a74321662;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\engine\utility;

#namespace zombie_disciple_asm;

// Namespace zombie_disciple_asm / namespace_b9742a57ad9ac793
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x19f
// Size: 0x75
function private function_f49a30f92555b827()
{
    function_e763a1820edbfd28();
    function_7e95224caecd6944();
    function_3f12f7bb3b0f7b28();
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
    level.scr_anim[ self.animname ][ "spawn_fast" ] = "spawn_fast";
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &on_move_speed_changed );
}

// Namespace zombie_disciple_asm / namespace_b9742a57ad9ac793
// Params 3
// Checksum 0x0, Offset: 0x21c
// Size: 0xef
function function_f4d5b246417ef16a( asmname, statename, params )
{
    function_a343ac31ca854535( &function_f49a30f92555b827 );
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    asm_setmoveplaybackrate( 1 );
    thread wander_listener();
    function_64d97cf652a4d385();
    function_a9a0b485d2e58d71();
    function_949f643edcd1aade();
    function_d956fa70427897a();
    function_99484082dc3884de();
    callback::add( "on_ai_init", &on_ai_init );
    ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_disciple_asm / namespace_b9742a57ad9ac793
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x313
// Size: 0x2e
function private on_ai_init( params )
{
    function_f1e5805da192a1ef( "run", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

// Namespace zombie_disciple_asm / namespace_b9742a57ad9ac793
// Params 0
// Checksum 0x0, Offset: 0x349
// Size: 0x41
function wander_listener()
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "wander_start" );
        function_f1e5805da192a1ef( "walk", "wander", 22 );
        self waittill( "wander_end" );
        function_f1e5805da192a1ef( undefined, "wander" );
    }
}

// Namespace zombie_disciple_asm / namespace_b9742a57ad9ac793
// Params 1
// Checksum 0x0, Offset: 0x392
// Size: 0x1a
function on_move_speed_changed( params )
{
    self.var_30158902d2e2c3c0 = self aigetdesiredspeed();
}

