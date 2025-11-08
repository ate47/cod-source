#using scripts\common\lighting;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace mp_jup_hydro_lighting;

// Namespace mp_jup_hydro_lighting / scripts\mp\maps\mp_jup_hydro\mp_jup_hydro_lighting
// Params 0
// Checksum 0x0, Offset: 0x17b
// Size: 0x19
function main()
{
    thread lighting_setup_dvars();
    function_448f852a8710b8ea();
    thread function_d6b7f69ea57299e9();
}

// Namespace mp_jup_hydro_lighting / scripts\mp\maps\mp_jup_hydro\mp_jup_hydro_lighting
// Params 0
// Checksum 0x0, Offset: 0x19c
// Size: 0x2
function lighting_setup_dvars()
{
    
}

// Namespace mp_jup_hydro_lighting / scripts\mp\maps\mp_jup_hydro\mp_jup_hydro_lighting
// Params 0
// Checksum 0x0, Offset: 0x1a6
// Size: 0x6e
function function_448f852a8710b8ea()
{
    level.var_840b0efad7cd12bf = getentarray( "light_crystal_obj", "targetname" );
    
    foreach ( var_827c2f92b949936 in level.var_840b0efad7cd12bf )
    {
        var_827c2f92b949936 function_88cd754a904f2c0a();
    }
}

// Namespace mp_jup_hydro_lighting / scripts\mp\maps\mp_jup_hydro\mp_jup_hydro_lighting
// Params 1
// Checksum 0x0, Offset: 0x21c
// Size: 0x87
function function_bfd6485208f4b621( params )
{
    if ( istrue( level.var_4553a0f3520aab66 ) )
    {
        return;
    }
    
    level.var_4553a0f3520aab66 = 1;
    fade_time = 3;
    
    foreach ( var_827c2f92b949936 in level.var_840b0efad7cd12bf )
    {
        var_827c2f92b949936 thread function_e05a4e827e4d647a( fade_time, 0 );
    }
}

// Namespace mp_jup_hydro_lighting / scripts\mp\maps\mp_jup_hydro\mp_jup_hydro_lighting
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x2ab
// Size: 0x22
function private function_e05a4e827e4d647a( time, endintensity )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    function_70a9f70afd49dead( time, endintensity );
}

// Namespace mp_jup_hydro_lighting / scripts\mp\maps\mp_jup_hydro\mp_jup_hydro_lighting
// Params 0
// Checksum 0x0, Offset: 0x2d5
// Size: 0x53
function function_88cd754a904f2c0a()
{
    self.og_intensity = self getlightintensity();
    self.og_color = self getlightcolor();
    self.og_radius = self getlightradius();
    self.og_position = self.origin;
    self.og_rotation = self.angles;
}

// Namespace mp_jup_hydro_lighting / scripts\mp\maps\mp_jup_hydro\mp_jup_hydro_lighting
// Params 0
// Checksum 0x0, Offset: 0x330
// Size: 0x4d
function function_d6b7f69ea57299e9()
{
    level waittill( "lgt_entity_light_on" );
    thread entity_light_on();
    thread function_9ecba77e83630c1d();
    earthquake( 0.5, 1, level.var_2ada333c838a2316.origin, 3500 );
    level waittill( "lgt_entity_light_off" );
    thread entity_light_off();
}

// Namespace mp_jup_hydro_lighting / scripts\mp\maps\mp_jup_hydro\mp_jup_hydro_lighting
// Params 0
// Checksum 0x0, Offset: 0x385
// Size: 0x12
function function_7c9bfcfc1ca3ddaa()
{
    level waittill( "lgt_entity_exposure_on" );
    thread function_9ecba77e83630c1d();
}

// Namespace mp_jup_hydro_lighting / scripts\mp\maps\mp_jup_hydro\mp_jup_hydro_lighting
// Params 0
// Checksum 0x0, Offset: 0x39f
// Size: 0x70
function entity_light_on()
{
    entity_light = getscriptablearray( "entity_light", "script_noteworthy" );
    
    foreach ( light in entity_light )
    {
        light setscriptablepartstate( "fire_flicker", "fire_flicker_start" );
    }
}

// Namespace mp_jup_hydro_lighting / scripts\mp\maps\mp_jup_hydro\mp_jup_hydro_lighting
// Params 0
// Checksum 0x0, Offset: 0x417
// Size: 0x70
function entity_light_off()
{
    entity_light = getscriptablearray( "entity_light", "script_noteworthy" );
    
    foreach ( light in entity_light )
    {
        light setscriptablepartstate( "fire_flicker", "fire_flicker_off" );
    }
}

// Namespace mp_jup_hydro_lighting / scripts\mp\maps\mp_jup_hydro\mp_jup_hydro_lighting
// Params 0
// Checksum 0x0, Offset: 0x48f
// Size: 0x6a
function function_9ecba77e83630c1d()
{
    function_126edb47d21b4d35( 0, 2, 1 );
    wait 1;
    function_126edb47d21b4d35( 0, 2, 0.75 );
    wait 0.2;
    function_126edb47d21b4d35( 0, 2, 0.5 );
    wait 0.2;
    function_126edb47d21b4d35( 0, 2, 0.25 );
    wait 0.2;
    function_126edb47d21b4d35( 0, 2, 0.1 );
    wait 0.1;
    function_126edb47d21b4d35( 0, 2, 0 );
}

