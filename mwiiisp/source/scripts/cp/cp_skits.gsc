#using scripts\anim\shared;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\asm\shared\mp\utility;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp\coop_stealth;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;

#namespace cp_skits;

#using_animtree( "script_model" );

// Namespace cp_skits / scripts\cp\cp_skits
// Params 0
// Checksum 0x0, Offset: 0xb5a
// Size: 0x1ec
function setup_spawn_skits()
{
    level endon( "game_ended" );
    flag_wait( "level_ready_for_script" );
    level.spawn_skits = [];
    add_spawn_skit( "stealth_sitting_laptop", &stealth_sitting_laptop );
    add_spawn_skit( "stealth_sitting_pistol", &stealth_sitting_pistol );
    add_spawn_skit( "stealth_sitting_cell", &stealth_sitting_cell );
    add_spawn_skit( "stealth_sitting_sleep", &stealth_sitting_sleep );
    add_spawn_skit( "smoking", &smoking );
    add_spawn_skit( "cell_phone", &standing_cellphone );
    add_spawn_skit( "stealth_sitting_cell_no_props", &stealth_sitting_cell_no_props );
    add_spawn_skit( "standing_cellphone", &standing_cellphone );
    add_spawn_skit( "end_game_cheer", &end_game_cheer );
    level.scr_animtree[ "idle_chair" ] = #animtree;
    level.scr_model[ "idle_chair" ] = "cp_disco_folding_chair_lod0";
    level.scr_anim[ "idle_chair" ][ "sit_sleeping_react" ] = %reb_stl_idle_sit_sleeping_react_chair;
    level.scr_anim[ "idle_chair" ][ "sit_sleeping_death" ] = %reb_stl_idle_sit_sleeping_death01_chair;
    level.scr_anim[ "idle_chair" ][ "sit_cellphone_react" ] = %reb_stl_idle_sit_phone01_react_chair;
    level.scr_anim[ "idle_chair" ][ "sit_cellphone_death" ] = %reb_stl_idle_sit_phone01_death02_4_chair;
    level.scr_anim[ "idle_chair" ][ "sit_laptop_react" ] = %reb_stl_idle_sit_laptop_react_chair;
    level.scr_anim[ "idle_chair" ][ "sit_laptop_death" ] = %reb_stl_idle_sit_laptop_death02_2_chair;
    level.scr_anim[ "idle_chair" ][ "sit_pistol_clean_react" ] = %reb_stl_idle_sit_gunmaintenance_react_chair;
    level.scr_anim[ "idle_chair" ][ "sit_pistol_clean_death" ] = %reb_stl_idle_sit_gunmaintenance_death01_6_chair;
    level.scr_model[ "idle_cellphone" ] = "offhand_wm_smartphone";
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 0
// Checksum 0x0, Offset: 0xd4e
// Size: 0x1c
function skit_fx()
{
    level.g_effect[ "cellphone_glow" ] = loadfx( "vfx/iw7/levels/piccadilly/vfx_pic_phone_light_01.vfx" );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 2
// Checksum 0x0, Offset: 0xd72
// Size: 0x4a
function add_spawn_skit( skit_name, skit_func )
{
    struct = spawnstruct();
    struct.skit_name = skit_name;
    struct.skit_func = skit_func;
    level.spawn_skits[ skit_name ] = struct;
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 4
// Checksum 0x0, Offset: 0xdc4
// Size: 0x174
function hostage_rescue_fight( attacker_spawn, victim_spawn, attacker_aitype, victim_aitype )
{
    attacker = scripts\mp\mp_agent::spawnnewagentaitype( attacker_aitype, attacker_spawn.origin, attacker_spawn.angles );
    victim = scripts\mp\mp_agent::spawnnewagentaitype( victim_aitype, victim_spawn.origin, victim_spawn.angles );
    attacker setup_fight_guy();
    victim setup_fight_guy();
    var_47ec4e67ed48c949 = attacker scripts\asm\asm::asm_lookupanimfromalias( "animscripted", "fight1_attacker" );
    attacker_xanim = attacker scripts\asm\asm::asm_getxanim( "animscripted", var_47ec4e67ed48c949 );
    var_e7b925ec7c8d5ea8 = victim scripts\asm\asm::asm_lookupanimfromalias( "animscripted", "fight1_victim" );
    victim_xanim = victim scripts\asm\asm::asm_getxanim( "animscripted", var_e7b925ec7c8d5ea8 );
    attacker aisetanim( "animscripted", var_47ec4e67ed48c949 );
    victim aisetanim( "animscripted", var_e7b925ec7c8d5ea8 );
    victim.deathstate = "animscripted";
    victim.deathalias = "fight1_victim_death";
    len = 30;
    attacker thread waitfor_death( len, victim, &death_fight1, &victim_killed_fight1 );
    victim thread waitfor_save( attacker, &victim_saved );
    victim waittill_any_timeout_no_endon_death_2( 30, "saved", "death" );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 7
// Checksum 0x0, Offset: 0xf40
// Size: 0x29a
function hostage_rescue_meatshield( attacker_spawn, victim_spawn, attacker_aitype, victim_aitype, attacker, victim, idletime )
{
    if ( !isdefined( attacker ) )
    {
        attacker = scripts\mp\mp_agent::spawnnewagentaitype( attacker_aitype, attacker_spawn.origin, attacker_spawn.angles );
    }
    
    if ( !isdefined( victim ) )
    {
        victim = scripts\mp\mp_agent::spawnnewagentaitype( victim_aitype, victim_spawn.origin, victim_spawn.angles );
    }
    
    attacker setup_fight_guy();
    victim setup_fight_guy();
    ai_pistol = scripts\cp_mp\weapon::buildweapon( "iw8_pi_golf21_mp", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    attacker giveweapon( ai_pistol );
    attacker.og_weapon = attacker.weapon;
    attacker setspawnweapon( ai_pistol );
    attacker utility::initweapon( ai_pistol );
    attacker scripts\anim\shared::placeweaponon( ai_pistol, "right" );
    attacker scripts\anim\shared::placeweaponon( attacker.weapon, "back" );
    attacker.sidearm = ai_pistol;
    attacker.deathstate = "animscripted";
    attacker.deathalias = "fight3_attacker_death";
    var_47ec4e67ed48c949 = attacker scripts\asm\asm::asm_lookupanimfromalias( "animscripted", "fight3_attacker" );
    attacker_xanim = attacker scripts\asm\asm::asm_getxanim( "animscripted", var_47ec4e67ed48c949 );
    var_e7b925ec7c8d5ea8 = victim scripts\asm\asm::asm_lookupanimfromalias( "animscripted", "fight3_victim" );
    victim_xanim = victim scripts\asm\asm::asm_getxanim( "animscripted", var_e7b925ec7c8d5ea8 );
    attacker aisetanim( "animscripted", var_47ec4e67ed48c949 );
    victim aisetanim( "animscripted", var_e7b925ec7c8d5ea8 );
    len = getanimlength( attacker_xanim );
    looptime = len * 5;
    
    if ( isdefined( idletime ) )
    {
        looptime = idletime;
    }
    
    attacker thread waitfor_death( looptime, victim, &death_fight2, &victim_killed_fight2 );
    victim thread waitfor_save( attacker, &victim_saved_shield );
    time = gettime() + len * 5 * 1000;
    
    if ( isdefined( idletime ) )
    {
        time = gettime() + idletime * 1000;
    }
    
    level thread fight_idle( time, victim, attacker, len, var_47ec4e67ed48c949, var_e7b925ec7c8d5ea8 );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 0
// Checksum 0x0, Offset: 0x11e2
// Size: 0x6f
function victim_saved_shield()
{
    anim_index = scripts\asm\asm::asm_lookupanimfromalias( "animscripted", "fight3_victim_saved" );
    xanim = scripts\asm\asm::asm_getxanim( "animscripted", anim_index );
    self aisetanim( "animscripted", anim_index );
    wait 2;
    reset_guy( self );
    
    if ( isdefined( self.anchor ) )
    {
        self unlink();
        self.anchor delete();
    }
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 6
// Checksum 0x0, Offset: 0x1259
// Size: 0x97
function fight_idle( time, victim, attacker, len, var_47ec4e67ed48c949, var_e7b925ec7c8d5ea8 )
{
    victim endon( "death" );
    attacker endon( "death" );
    
    if ( time <= 0 )
    {
        while ( true )
        {
            wait len;
            attacker aisetanim( "animscripted", var_47ec4e67ed48c949 );
            victim aisetanim( "animscripted", var_e7b925ec7c8d5ea8 );
        }
        
        return;
    }
    
    while ( gettime() < time )
    {
        wait len;
        attacker aisetanim( "animscripted", var_47ec4e67ed48c949 );
        victim aisetanim( "animscripted", var_e7b925ec7c8d5ea8 );
    }
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 0
// Checksum 0x0, Offset: 0x12f8
// Size: 0x30
function setup_fight_guy()
{
    self.ignoreall = 1;
    scripts\asm\asm_mp::asm_setanimscripted();
    self setlookatentity();
    self.headlook_enabled = 0;
    self.disableautolookat = 1;
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 0
// Checksum 0x0, Offset: 0x1330
// Size: 0x14
function setup_anim_guy()
{
    scripts\asm\asm_mp::asm_setanimscripted();
    self.playing_skit = 1;
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x134c
// Size: 0xee
function death_fight2( victim )
{
    self endon( "death" );
    victim.deathstate = "animscripted";
    victim.deathalias = "fight3_victim_death";
    magicbullet( self.sidearm, self gettagorigin( "tag_flash" ), anglestoforward( self gettagangles( "tag_flash" ) ) * 1000 );
    self shoot( 10, victim, 1, 1 );
    victim dodamage( victim.health + 100, victim.origin );
    scripts\asm\shared\mp\utility::animscripted_single( "fight3_attacker_win" );
    self giveweapon( self.og_weapon );
    self setspawnweapon( self.og_weapon );
    scripts\anim\shared::placeweaponon( self.og_weapon, "right" );
    scripts\anim\shared::placeweaponon( self.sidearm, "none" );
    reset_guy( self );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x1442
// Size: 0x55
function death_fight1( victim )
{
    victim.deathstate = "animscripted";
    victim.deathalias = "fight1_victim_death";
    victim dodamage( victim.health + 100, victim.origin );
    reset_guy( self );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 0
// Checksum 0x0, Offset: 0x149f
// Size: 0x16
function victim_saved()
{
    scripts\asm\shared\mp\utility::animscripted_single( "fight3_victim_saved" );
    reset_guy( self );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 0
// Checksum 0x0, Offset: 0x14bd
// Size: 0xa
function victim_killed_fight1()
{
    reset_guy( self );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 0
// Checksum 0x0, Offset: 0x14cf
// Size: 0x54
function victim_killed_fight2()
{
    self giveweapon( self.og_weapon );
    self setspawnweapon( self.og_weapon );
    scripts\anim\shared::placeweaponon( self.og_weapon, "right" );
    scripts\anim\shared::placeweaponon( self.sidearm, "none" );
    reset_guy( self );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 4
// Checksum 0x0, Offset: 0x152b
// Size: 0x82
function waitfor_death( time, victim, timeout_func, var_9443c17d464b753e )
{
    self endon( "scene_interrupt" );
    result = waittill_any_ents_or_timeout_return( time, self, "death", victim, "death" );
    
    if ( isdefined( result ) && result == "timeout" )
    {
        self thread [[ timeout_func ]]( victim );
        return;
    }
    
    if ( isalive( victim ) )
    {
        victim notify( "saved" );
    }
    
    if ( isalive( self ) )
    {
        self thread [[ var_9443c17d464b753e ]]();
    }
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 2
// Checksum 0x0, Offset: 0x15b5
// Size: 0x2c
function waitfor_save( attacker, save_func )
{
    self endon( "death" );
    self waittill( "saved" );
    
    if ( isdefined( save_func ) )
    {
        self [[ save_func ]]();
    }
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x15e9
// Size: 0x95
function reset_guy( guy )
{
    guy allowedstances( "prone", "stand", "crouch" );
    guy scripts\asm\shared\mp\utility::animscripted_clear();
    guy setlookatentity();
    guy.headlook_enabled = 1;
    guy.disableautolookat = 0;
    guy.deathstate = undefined;
    guy.deathalias = undefined;
    guy.ignoreall = 0;
    guy.playing_skit = undefined;
    
    if ( isdefined( self.anchor ) )
    {
        self.anchor delete();
    }
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x1686
// Size: 0x10f
function stealth_sitting_laptop( chair )
{
    if ( scripts\cp\coop_stealth::should_run_sp_stealth() )
    {
        self function_e4b58a023e0da030( self.origin, self.angles, "sit_laptop" );
        
        if ( !have_props_spawned() )
        {
            spawn_table();
        }
        
        if ( isdefined( self.spawnpoint ) )
        {
            self.spawnpoint.props_spawned = 1;
        }
        
        return;
    }
    
    if ( !have_props_spawned() )
    {
        anim_chair = spawn_chair( chair );
        thread stealth_sit_react( anim_chair, "sitting_laptop_react", "reb_stl_idle_sit_laptop_react_chair" );
        thread stealth_sit_death( anim_chair, "reb_stl_idle_sit_laptop_death02_2_chair" );
        table = spawn_table();
        set_props_spawned();
    }
    
    if ( isdefined( self.spawnpoint ) )
    {
        self.spawnpoint.props_spawned = 1;
    }
    
    setup_anim_guy();
    self.deathstate = "patrol_sitting_laptop_death";
    self.deathalias = "death";
    thread stealth_sit_idle( "sitting_laptop_idle" );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x179d
// Size: 0x12f
function stealth_sitting_pistol( chair )
{
    if ( scripts\cp\coop_stealth::should_run_sp_stealth() )
    {
        self function_e4b58a023e0da030( self.origin, self.angles, "sit_pistol_clean" );
        
        if ( !have_props_spawned() )
        {
            spawn_table();
        }
        
        if ( isdefined( self.spawnpoint ) )
        {
            self.spawnpoint.props_spawned = 1;
        }
        
        return;
    }
    
    if ( !have_props_spawned() )
    {
        anim_chair = spawn_chair( chair );
        thread stealth_sit_react( anim_chair, "sitting_pistol_react", "reb_stl_idle_sit_gunmaintenance_react_chair" );
        thread stealth_sit_death( anim_chair, "reb_stl_idle_sit_gunmaintenance_death01_6_chair" );
        table = spawn_table();
        set_props_spawned();
    }
    
    setup_anim_guy();
    self.idle_prop = spawn( "script_model", self.origin );
    self.idle_prop setmodel( "weapon_g18_rare_wm" );
    self.idle_prop linkto( self, "tag_accessory_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    thread stealth_sit_idle( "sitting_pistol_idle" );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 0
// Checksum 0x0, Offset: 0x18d4
// Size: 0x32
function crouching_phone()
{
    setup_anim_guy();
    self.deathstate = "patrol_sitting_cellphone_death";
    self.deathalias = "death";
    thread idle_crouching_phone( "sitting_cellphone_idle" );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x190e
// Size: 0x4e
function idle_crouching_phone( animalias )
{
    self endon( "death" );
    self endon( "alerted" );
    thread ai_notetrack_loop( "smoking" );
    
    while ( true )
    {
        smoking_idle_start( "smoking_idle_start" );
        scripts\asm\shared\mp\utility::animscripted_single( animalias );
        smoking_idle_end( "smoking_idle_end" );
    }
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x1964
// Size: 0x12a
function stealth_sitting_cell_no_props( chair )
{
    if ( scripts\cp\coop_stealth::should_run_sp_stealth() )
    {
        self function_e4b58a023e0da030( self.origin, self.angles, "sit_cellphone" );
        
        if ( isdefined( self.spawnpoint ) )
        {
            self.spawnpoint.props_spawned = 1;
        }
        
        return;
    }
    
    if ( !have_props_spawned() )
    {
        anim_chair = spawn_chair( chair );
        thread stealth_sit_react( anim_chair, "sitting_cellphone_react", "reb_stl_idle_sit_phone01_react_chair" );
        thread stealth_sit_death( anim_chair, "reb_stl_idle_sit_phone01_death02_4_chair" );
        set_props_spawned();
    }
    
    setup_anim_guy();
    self.deathstate = "patrol_sitting_cellphone_death";
    self.deathalias = "death";
    self.idle_prop = spawn( "script_model", self.origin );
    self.idle_prop setmodel( "offhand_vm_cellphone_old" );
    self.idle_prop linkto( self, "tag_accessory_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    thread stealth_sit_idle( "sitting_cellphone_idle" );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x1a96
// Size: 0x14b
function stealth_sitting_cell( chair )
{
    if ( scripts\cp\coop_stealth::should_run_sp_stealth() )
    {
        self function_e4b58a023e0da030( self.origin, self.angles, "sit_cellphone" );
        
        if ( !have_props_spawned() )
        {
            spawn_table();
        }
        
        if ( isdefined( self.spawnpoint ) )
        {
            self.spawnpoint.props_spawned = 1;
        }
        
        return;
    }
    
    if ( !have_props_spawned() )
    {
        anim_chair = spawn_chair( chair );
        thread stealth_sit_react( anim_chair, "sitting_cellphone_react", "reb_stl_idle_sit_phone01_react_chair" );
        thread stealth_sit_death( anim_chair, "reb_stl_idle_sit_phone01_death02_4_chair" );
        table = spawn_table();
        set_props_spawned();
    }
    
    setup_anim_guy();
    self.deathstate = "patrol_sitting_cellphone_death";
    self.deathalias = "death";
    self.idle_prop = spawn( "script_model", self.origin );
    self.idle_prop setmodel( "equipment_personal_smartphone_01" );
    self.idle_prop linkto( self, "tag_accessory_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    thread stealth_sit_idle( "sitting_cellphone_idle" );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x1be9
// Size: 0xcb
function stealth_sitting_sleep( chair )
{
    if ( scripts\cp\coop_stealth::should_run_sp_stealth() )
    {
        self function_e4b58a023e0da030( self.origin, self.angles, "sit_sleeping" );
        
        if ( isdefined( self.spawnpoint ) )
        {
            self.spawnpoint.props_spawned = 1;
        }
        
        return;
    }
    
    if ( !have_props_spawned() )
    {
        anim_chair = spawn_chair( chair );
        thread stealth_sit_react( anim_chair, "sitting_sleeping_react", "reb_stl_idle_sit_sleeping_react_chair" );
        thread stealth_sit_death( anim_chair, "reb_stl_idle_sit_sleeping_death01_chair" );
        set_props_spawned();
    }
    
    setup_anim_guy();
    self.deathstate = "patrol_sitting_sleeping_death";
    self.deathalias = "death";
    thread stealth_sit_idle( "sitting_sleeping_idle" );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 0
// Checksum 0x0, Offset: 0x1cbc
// Size: 0x68
function spawn_table()
{
    table = spawn( "script_model", self.origin + anglestoforward( self.angles ) * 32 );
    table.angles = self.angles + ( 0, 90, 0 );
    table setmodel( "furniture_table_folding_01_open" );
    table disconnectpaths();
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x1d2c
// Size: 0x60
function spawn_chair( chair )
{
    if ( !isdefined( chair ) )
    {
        chair = spawn( "script_model", self.origin + anglestoforward( self.angles ) * -8 );
        chair.angles = self.angles;
        chair setmodel( "cp_disco_folding_chair_lod0" );
        chair disconnectpaths();
    }
    
    return chair;
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x1d95
// Size: 0x28
function stealth_sit_idle( animalias )
{
    self endon( "death" );
    self endon( "alerted" );
    self endon( "enter_combat" );
    scripts\asm\shared\mp\utility::animscripted_loop( animalias );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 3
// Checksum 0x0, Offset: 0x1dc5
// Size: 0xda
function stealth_sit_react( chair, react_alias, chair_anim )
{
    self endon( "death" );
    self waittill( "alerted" );
    scripts\cp\spawning::set_kill_off_time( 20 );
    self.deathstate = undefined;
    self.deathalias = undefined;
    
    if ( isdefined( self.idle_prop ) )
    {
        self.idle_prop unlink();
        self.idle_prop physicslaunchserver( self.idle_prop.origin, ( 0, 0, -10 ) );
        self.idle_prop = undefined;
    }
    
    chair scriptmodelplayanimdeltamotion( chair_anim );
    scripts\asm\shared\mp\utility::animscripted_single( react_alias );
    chair scriptmodelclearanim();
    chair physicslaunchserver( chair.origin, ( 0, 0, 15 ) );
    reset_guy( self );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 2
// Checksum 0x0, Offset: 0x1ea7
// Size: 0xa2
function stealth_sit_death( chair, chair_anim )
{
    self endon( "alerted" );
    idle_prop = undefined;
    
    if ( isdefined( self.idle_prop ) )
    {
        idle_prop = self.idle_prop;
    }
    
    self waittill( "death" );
    
    if ( isdefined( idle_prop ) )
    {
        idle_prop unlink();
        idle_prop physicslaunchserver( idle_prop.origin, ( 0, 0, -10 ) );
    }
    
    chair scriptmodelplayanimdeltamotion( chair_anim );
    wait 1;
    chair scriptmodelclearanim();
    chair physicslaunchserver( chair.origin, ( 0, 0, 15 ) );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 0
// Checksum 0x0, Offset: 0x1f51
// Size: 0x81
function smoking()
{
    self.playing_skit = 1;
    
    if ( scripts\cp\coop_stealth::should_run_sp_stealth() )
    {
        self function_e4b58a023e0da030( self.origin, self.angles, "smoking" );
        return;
    }
    
    setup_anim_guy();
    self.deathstate = "animscripted";
    self.deathalias = "smoking_death";
    thread smoking_idle( "smoking_idle" );
    thread smoking_react( "smoking_react" );
    thread smoking_death( "smoking_death" );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x1fda
// Size: 0x84
function smoking_idle( animalias )
{
    level endon( "weapons_free" );
    self endon( "death" );
    self endon( "alerted" );
    thread ai_notetrack_loop( "smoking" );
    
    while ( true )
    {
        smoking_idle_start( "smoking_idle_start" );
        scripts\asm\shared\mp\utility::animscripted_single( animalias );
        smoking_idle_end( "smoking_idle_end" );
        ai_smoking_cleanup();
        
        if ( istrue( self.single_loop ) )
        {
            self notify( "ai_notetrack_Loop" );
            self notify( "cancel_loop" );
            reset_guy( self );
            break;
        }
    }
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x2066
// Size: 0x21
function smoking_idle_start( animalias )
{
    self endon( "death" );
    self endon( "alerted" );
    scripts\asm\shared\mp\utility::animscripted_single( animalias );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x208f
// Size: 0x21
function smoking_idle_end( animalias )
{
    self endon( "death" );
    self endon( "alerted" );
    scripts\asm\shared\mp\utility::animscripted_single( animalias );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x20b8
// Size: 0xd1
function smoking_react( react_alias )
{
    self endon( "death" );
    self endon( "cancel_loop" );
    level add_wait( &waittill_msg, "weapons_free" );
    add_wait( &waittill_any_2, "alerted", "checking_friendly_corpse" );
    do_wait_any();
    scripts\cp\spawning::set_kill_off_time( 20 );
    ai_smoking_cleanup();
    self.deathstate = undefined;
    self.deathalias = undefined;
    
    if ( isdefined( self.idle_prop ) )
    {
        self.idle_prop unlink();
        self.idle_prop physicslaunchserver( self.idle_prop.origin, ( 0, 0, -10 ) );
        self.idle_prop = undefined;
    }
    
    scripts\asm\shared\mp\utility::animscripted_single( react_alias );
    reset_guy( self );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x2191
// Size: 0x28
function smoking_death( sanim )
{
    self endon( "alerted" );
    self endon( "cancel_loop" );
    self waittill( "death" );
    ai_smoking_cleanup();
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x21c1
// Size: 0xec
function ai_notetrack_loop( skit )
{
    self endon( "death" );
    self notify( "ai_notetrack_Loop" );
    self endon( "ai_notetrack_Loop" );
    self endon( "alerted" );
    
    while ( true )
    {
        self waittill( "animscripted", notes );
        
        if ( !isdefined( notes ) )
        {
            notes = [ "undefined" ];
        }
        
        if ( !isarray( notes ) )
        {
            notes = [ notes ];
        }
        
        assert( isdefined( self.fnasm_handlenotetrack ) );
        defined_val = undefined;
        
        foreach ( note in notes )
        {
            if ( skit == "smoking" )
            {
                ai_notehandler_smoking( note );
                continue;
            }
            
            if ( skit == "standing_cellphone" )
            {
                ai_notehandler_cellphone( note );
            }
        }
    }
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x22b5
// Size: 0x120
function ai_notehandler_smoking( note )
{
    switch ( note )
    {
        case #"hash_2d1403e602f082a4":
            playfxontag( level.g_effect[ "cigarette_unlit" ], self, "tag_accessory_right" );
            break;
        case #"hash_d582c3286e5c390f":
            playfxontag( level.g_effect[ "cigarette_lit" ], self, "tag_accessory_right" );
            stopfxontag( level.g_effect[ "cigarette_unlit" ], self, "tag_accessory_right" );
            playfx( level.g_effect[ "lighter_glow" ], self gettagorigin( "tag_accessory_right" ) );
            thread ai_smoking_blowsmoke();
            break;
        case #"hash_682ec8b49fe7aa12":
            stopfxontag( level.g_effect[ "cigarette_lit" ], self, "tag_accessory_right" );
            stopfxontag( level.g_effect[ "cigarette_unlit" ], self, "tag_accessory_right" );
            playfx( level.g_effect[ "cigarette_lit_toss" ], self gettagorigin( "tag_accessory_right" ), anglestoforward( self gettagangles( "tag_accessory_right" ) ) );
            break;
    }
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 0
// Checksum 0x0, Offset: 0x23dd
// Size: 0x7d
function ai_smoking_blowsmoke()
{
    self endon( "smoking_end" );
    self endon( "death" );
    self notify( "ai_notetrack_Loop" );
    self endon( "ai_notetrack_Loop" );
    self endon( "alerted" );
    
    while ( true )
    {
        playfx( level.g_effect[ "cigarette_smoke" ], self geteye() - ( 0, 0, 2 ), anglestoforward( self gettagangles( "tag_eye" ) ) );
        waittime = randomintrange( 5, 8 );
        wait waittime;
    }
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 0
// Checksum 0x0, Offset: 0x2462
// Size: 0x51
function ai_smoking_cleanup()
{
    self notify( "smoking_end" );
    
    if ( isdefined( self gettagorigin( "tag_accessory_right", 1 ) ) )
    {
        killfxontag( level.g_effect[ "cigarette_lit" ], self, "tag_accessory_right" );
        killfxontag( level.g_effect[ "cigarette_unlit" ], self, "tag_accessory_right" );
    }
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x24bb
// Size: 0x77
function standing_cellphone( var_ff75b4157a7aa48a )
{
    if ( scripts\cp\coop_stealth::should_run_sp_stealth() )
    {
        self function_e4b58a023e0da030( self.origin, self.angles, "cellphone" );
        return;
    }
    
    if ( !isdefined( var_ff75b4157a7aa48a ) )
    {
        var_ff75b4157a7aa48a = 1;
    }
    
    setup_anim_guy();
    self.deathstate = "animscripted";
    self.deathalias = "stand_cellphone_death";
    thread ai_notetrack_loop( "standing_cellphone" );
    thread standing_cellphone_anim_seq( var_ff75b4157a7aa48a );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x253a
// Size: 0x51
function standing_cellphone_anim_seq( var_ff75b4157a7aa48a )
{
    self endon( "death" );
    self endon( "alerted" );
    thread cellphone_react( "smoking_react" );
    standing_cellphone_anim( "stand_cellphone_intro" );
    
    if ( var_ff75b4157a7aa48a > 0 )
    {
        standing_cellphone_loop( "stand_cellphone_loop", var_ff75b4157a7aa48a );
    }
    
    standing_cellphone_anim( "stand_cellphone_exit" );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x2593
// Size: 0x21
function standing_cellphone_anim( animalias )
{
    self endon( "death" );
    self endon( "alerted" );
    scripts\asm\shared\mp\utility::animscripted_single( animalias );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 2
// Checksum 0x0, Offset: 0x25bc
// Size: 0x39
function standing_cellphone_loop( animalias, loops )
{
    level endon( "weapons_free" );
    self endon( "death" );
    self endon( "alerted" );
    scripts\asm\shared\mp\utility::animscripted_loop_n_times( animalias, loops );
    reset_guy( self );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x25fd
// Size: 0x7f
function ai_notehandler_cellphone( note )
{
    self endon( "death" );
    self endon( "alerted" );
    
    switch ( note )
    {
        case #"hash_2d1403e602f082a4":
            self.idle_prop = scripts\common\anim::anim_link_tag_model( "offhand_wm_smartphone", "tag_accessory_right" );
            break;
        case #"hash_682ec8b49fe7aa12":
            if ( isdefined( self.idle_prop ) )
            {
                self.idle_prop delete();
                self.idle_prop = undefined;
            }
            
            break;
    }
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 1
// Checksum 0x0, Offset: 0x2684
// Size: 0xca
function cellphone_react( react_alias )
{
    self endon( "death" );
    level add_wait( &waittill_msg, "weapons_free" );
    add_wait( &waittill_any_2, "alerted", "checking_friendly_corpse" );
    do_wait_any();
    scripts\cp\spawning::set_kill_off_time( 20 );
    ai_cellphone_cleanup();
    self.deathstate = undefined;
    self.deathalias = undefined;
    
    if ( isdefined( self.idle_prop ) )
    {
        self.idle_prop unlink();
        self.idle_prop physicslaunchserver( self.idle_prop.origin, ( 0, 0, -10 ) );
        self.idle_prop = undefined;
    }
    
    scripts\asm\shared\mp\utility::animscripted_single( react_alias );
    reset_guy( self );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 0
// Checksum 0x0, Offset: 0x2756
// Size: 0x9
function ai_cellphone_cleanup()
{
    self endon( "death" );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 0
// Checksum 0x0, Offset: 0x2767
// Size: 0x24, Type: bool
function have_props_spawned()
{
    return isdefined( self.spawnpoint ) && istrue( self.spawnpoint.props_spawned );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 0
// Checksum 0x0, Offset: 0x2794
// Size: 0x25
function set_props_spawned()
{
    if ( isdefined( self.spawnpoint ) )
    {
        self.spawnpoint.props_spawned = 1;
    }
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 0
// Checksum 0x0, Offset: 0x27c1
// Size: 0x17d
function end_game_cheer()
{
    self endon( "death" );
    self endon( "alerted" );
    scripts\cp\spawning::set_demeanor_from_unittype( "patrol" );
    scripts\cp\spawning::set_goal_radius( 4 );
    scripts\cp\spawning::set_goal_pos( self.origin );
    self.ignoreall = 1;
    self.ignoreme = 1;
    self takeallweapons();
    fists = scripts\cp_mp\weapon::buildweapon( "iw9_me_fists_mp", [], "none", "none", -1 );
    self giveweapon( fists );
    scripts\anim\shared::forceuseweapon( fists, "primary" );
    wait 0.5;
    closest_player = getclosest( self.origin, level.players );
    self setlookatentity( closest_player );
    wait 0.5;
    setup_anim_guy();
    anims = [ "cap_ff_010_cheer_scene_civ01", "cap_ff_010_cheer_scene_civ02", "cap_ff_010_cheer_scene_civ03", "cap_ff_010_cheer_scene_civ04", "cap_ff_010_cheer_scene_civ06", "cap_ff_010_cheer_scene_civ07", "cap_ff_010_cheer_scene_civ08", "cap_ff_010_cheer_scene_civ09", "cap_ff_010_cheer_scene_civ10", "cap_ff_010_cheer_scene_civ11", "cap_ff_010_cheer_scene_civ12", "cap_ff_010_cheer_scene_civ13" ];
    anim_sequence = [];
    anim_sequence[ anim_sequence.size ] = [ &play_looping_skit_anim, "animscripted2", anims, undefined, undefined ];
    play_anim_sequence( anim_sequence, 1 );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 0
// Checksum 0x0, Offset: 0x2946
// Size: 0x13
function setup_gulag_weapon_check()
{
    add_spawn_skit( "checkin_guard_idle", &checkin_guard_idle );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 0
// Checksum 0x0, Offset: 0x2961
// Size: 0x1a5
function checkin_guard_idle()
{
    self endon( "death" );
    self endon( "alerted" );
    setup_anim_guy();
    anim_sequence = [];
    anim_sequence[ anim_sequence.size ] = [ &play_looping_skit_anim, "animscripted2", "cp_informant_checkin_sit_idle", 2, self.spawnpoint ];
    anim_sequence[ anim_sequence.size ] = [ &play_single_skit_anim, "animscripted2", "cp_informant_checkin_sit_2_stand", undefined, undefined, undefined ];
    anim_sequence[ anim_sequence.size ] = [ &play_looping_skit_anim, "animscripted2", [ "cp_informant_checkin_stand_idle_01", "cp_informant_checkin_stand_idle_02" ], 2, self.spawnpoint ];
    anim_sequence[ anim_sequence.size ] = [ &play_single_skit_anim, "animscripted2", [ "cp_informant_checkin_stand_payment_01", "cp_informant_checkin_stand_payment_02" ], undefined ];
    anim_sequence[ anim_sequence.size ] = [ &play_single_skit_anim, "animscripted2", "cp_informant_checkin_stand_2_sit", undefined ];
    anim_sequence[ anim_sequence.size ] = [ &play_looping_skit_anim, "animscripted2", "cp_informant_checkin_sit_idle", undefined, self.spawnpoint ];
    var_3690c2f8da0ea87d = [];
    var_3690c2f8da0ea87d[ var_3690c2f8da0ea87d.size ] = [ &spawn_skit_prop, "actor_position_determined", &get_position_from_actor, &get_angles_from_actor, "ee_furniture_chair_metal_folding_open", 1 ];
    play_anim_sequence( anim_sequence, 1 );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 3
// Checksum 0x0, Offset: 0x2b0e
// Size: 0x190
function play_anim_sequence( anim_sequence, looping, var_3690c2f8da0ea87d )
{
    if ( isdefined( var_3690c2f8da0ea87d ) )
    {
        for ( p = 0; p < var_3690c2f8da0ea87d.size ; p++ )
        {
            data = var_3690c2f8da0ea87d[ p ];
            func = data[ 0 ];
            parm1 = ter_op( isdefined( data[ 1 ] ), data[ 1 ], undefined );
            parm2 = ter_op( isdefined( data[ 2 ] ), data[ 2 ], undefined );
            parm3 = ter_op( isdefined( data[ 3 ] ), data[ 3 ], undefined );
            parm4 = ter_op( isdefined( data[ 4 ] ), data[ 4 ], undefined );
            var_77895a5b8a625552 = ter_op( isdefined( data[ 5 ] ), data[ 5 ], undefined );
            var_7789595b8a62531f = ter_op( isdefined( data[ 6 ] ), data[ 6 ], undefined );
            self childthread [[ func ]]( parm1, parm2, parm3, parm4, var_77895a5b8a625552 );
        }
    }
    
    while ( true )
    {
        for ( i = 0; i < anim_sequence.size ; i++ )
        {
            data = anim_sequence[ i ];
            func = data[ 0 ];
            parm1 = ter_op( isdefined( data[ 1 ] ), data[ 1 ], undefined );
            parm2 = ter_op( isdefined( data[ 2 ] ), data[ 2 ], undefined );
            parm3 = ter_op( isdefined( data[ 3 ] ), data[ 3 ], undefined );
            parm4 = ter_op( isdefined( data[ 4 ] ), data[ 4 ], undefined );
            self [[ func ]]( parm1, parm2, parm3, parm4 );
        }
        
        if ( !istrue( looping ) )
        {
            break;
        }
    }
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 4
// Checksum 0x0, Offset: 0x2ca6
// Size: 0x15f
function play_looping_skit_anim( statename, var_75ecb34d5a496906, loops, scene_node )
{
    level endon( "game_ended" );
    level endon( "end_current_skit_anim" );
    self endon( "end_current_skit_anim" );
    
    if ( isdefined( var_75ecb34d5a496906 ) && !isarray( var_75ecb34d5a496906 ) )
    {
        temp_array = [ var_75ecb34d5a496906 ];
        var_75ecb34d5a496906 = temp_array;
        temp_array = undefined;
    }
    
    animalias = random( var_75ecb34d5a496906 );
    
    if ( !isdefined( statename ) )
    {
        statename = "animscripted";
    }
    
    anim_index = scripts\asm\asm::asm_lookupanimfromalias( statename, animalias );
    xanim = scripts\asm\asm::asm_getxanim( statename, anim_index );
    numloops = 0;
    org = undefined;
    ang = undefined;
    
    if ( isdefined( scene_node ) )
    {
        org = scene_node.origin;
        ang = scene_node.angles;
    }
    
    while ( true )
    {
        if ( isdefined( scene_node ) )
        {
            startorg = getstartorigin( org, ang, xanim );
            startangles = getstartangles( org, ang, xanim );
            self dontinterpolate();
            self forceteleport( startorg, startangles );
            self notify( "actor_position_determined" );
        }
        
        self aisetanim( statename, anim_index );
        wait getanimlength( xanim );
        
        if ( isdefined( loops ) )
        {
            numloops++;
            
            if ( numloops >= loops )
            {
                return;
            }
        }
    }
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 4
// Checksum 0x0, Offset: 0x2e0d
// Size: 0x138
function play_single_skit_anim( statename, var_75ecb34d5a496906, scene_node, unused )
{
    level endon( "game_ended" );
    level endon( "end_current_skit_anim" );
    self endon( "end_current_skit_anim" );
    
    if ( isdefined( var_75ecb34d5a496906 ) && !isarray( var_75ecb34d5a496906 ) )
    {
        temp_array = [ var_75ecb34d5a496906 ];
        var_75ecb34d5a496906 = temp_array;
        temp_array = undefined;
    }
    
    animalias = random( var_75ecb34d5a496906 );
    
    if ( !isdefined( statename ) )
    {
        statename = "animscripted";
    }
    
    anim_index = scripts\asm\asm::asm_lookupanimfromalias( statename, animalias );
    xanim = scripts\asm\asm::asm_getxanim( statename, anim_index );
    org = undefined;
    ang = undefined;
    
    if ( isdefined( scene_node ) )
    {
        org = scene_node.origin;
        ang = scene_node.angles;
    }
    
    if ( isdefined( scene_node ) )
    {
        startorg = getstartorigin( org, ang, xanim );
        startangles = getstartangles( org, ang, xanim );
        self dontinterpolate();
        self forceteleport( startorg, startangles );
        self notify( "actor_position_determined" );
    }
    
    self aisetanim( statename, anim_index );
    wait getanimlength( xanim );
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 5
// Checksum 0x0, Offset: 0x2f4d
// Size: 0x92
function spawn_skit_prop( string_waittill, startorg, startangles, prop_model, should_disconnectpaths )
{
    if ( isdefined( string_waittill ) )
    {
        self waittill( string_waittill );
    }
    
    if ( isfunction( startorg ) )
    {
        startorg = self [[ startorg ]]();
    }
    
    if ( isfunction( startangles ) )
    {
        startangles = self [[ startangles ]]();
    }
    
    prop = spawn( "script_model", startorg );
    prop.angles = self.angles;
    prop setmodel( prop_model );
    
    if ( istrue( should_disconnectpaths ) )
    {
        prop disconnectpaths();
    }
    
    return prop;
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 0
// Checksum 0x0, Offset: 0x2fe8
// Size: 0x39
function get_position_from_actor()
{
    pos = self gettagorigin( "j_mainroot" );
    thread draw_line_for_time( pos, pos + ( 0, 0, 128 ), 1, 1, 1, 30 );
    return pos;
}

// Namespace cp_skits / scripts\cp\cp_skits
// Params 0
// Checksum 0x0, Offset: 0x302a
// Size: 0x36
function get_angles_from_actor()
{
    angles = self gettagangles( "j_mainroot" );
    thread draw_angles( angles, angles + ( 0, 0, 128 ), undefined, 1, 30 );
    return angles;
}

