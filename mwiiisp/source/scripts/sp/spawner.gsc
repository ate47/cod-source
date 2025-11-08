#using script_78ee1f1787a2e6a4;
#using scripts\anim\init;
#using scripts\anim\utility_common;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\sp\utility;
#using scripts\common\ai;
#using scripts\common\debug;
#using scripts\common\gameskill;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\ai_armor;
#using scripts\sp\analytics;
#using scripts\sp\anim;
#using scripts\sp\damagefeedback;
#using scripts\sp\debug;
#using scripts\sp\drone_base;
#using scripts\sp\fakeactor;
#using scripts\sp\flags;
#using scripts\sp\friendlyfire;
#using scripts\sp\gameskill;
#using scripts\sp\loot;
#using scripts\sp\mgturret;
#using scripts\sp\player;
#using scripts\sp\player_stats;
#using scripts\sp\spawner;
#using scripts\sp\stealth\idle_sitting;
#using scripts\sp\stealth\manager;
#using scripts\sp\utility;
#using scripts\stealth\callbacks;
#using scripts\stealth\enemy;

#namespace spawner;

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0xd6a
// Size: 0x4a5
function main()
{
    level.spawn_funcs = [];
    level.spawn_funcs[ "allies" ] = [];
    level.spawn_funcs[ "axis" ] = [];
    level.spawn_funcs[ "team3" ] = [];
    level.spawn_funcs[ "neutral" ] = [];
    thread scripts\sp\spawner::goalvolumes();
    var_520231d77c80a465 = getentarray( "flood_and_secure", "targetname" );
    array_thread( var_520231d77c80a465, &flood_and_secure );
    
    if ( !isdefined( level.ai_number ) )
    {
        level.ai_number = 0;
    }
    
    if ( getdvar( @"fallback" ) == "" )
    {
        setdvar( @"fallback", "0" );
    }
    
    if ( getdvar( @"noai" ) == "" )
    {
        setdvar( @"noai", "off" );
    }
    
    createthreatbiasgroup( "allies" );
    createthreatbiasgroup( "axis" );
    createthreatbiasgroup( "team3" );
    createthreatbiasgroup( "civilian" );
    createthreatbiasgroup( "equipment" );
    setthreatbias( "axis", "equipment", 250 );
    setthreatbias( "allies", "equipment", 250 );
    setthreatbias( "team3", "equipment", -1000 );
    scripts\sp\flags::init_sp_flags();
    scripts\sp\player::init();
    scripts\sp\gameskill::init_gameskill();
    
    foreach ( player in level.players )
    {
        player setthreatbiasgroup( "allies" );
    }
    
    /#
        setdvarifuninitialized( @"hash_c3ae5b7542b15a78", "<dev string:x1c>" );
        setdvarifuninitialized( @"hash_38a088b03f78dca1", "<dev string:x1c>" );
    #/
    
    level._ai_group = [];
    level.gather_delay = [];
    
    if ( !isdefined( level.deathflags ) )
    {
        level.deathflags = [];
    }
    
    level.spawner_number = 0;
    
    if ( !isdefined( level.unittype_spawn_functions ) )
    {
        level.unittype_spawn_functions = [];
    }
    
    level.unittype_spawn_functions[ "soldier" ] = &spawn_unittype_soldier;
    
    if ( !isdefined( level.subclass_spawn_functions ) )
    {
        level.subclass_spawn_functions = [];
    }
    
    level.subclass_spawn_functions[ "juggernaut" ] = &spawn_subclass_juggernaut;
    level.subclass_spawn_functions[ "tier2" ] = &scripts\sp\ai_armor::function_1ddcdf764c5bdd84;
    level.subclass_spawn_functions[ "tier3" ] = &scripts\sp\ai_armor::function_1ddcdf764c5bdd84;
    level.team_specific_spawn_functions = [];
    level.team_specific_spawn_functions[ "axis" ] = &spawn_team_axis;
    level.team_specific_spawn_functions[ "allies" ] = &spawn_team_allies;
    level.team_specific_spawn_functions[ "team3" ] = &spawn_team_team3;
    level.team_specific_spawn_functions[ "neutral" ] = &spawn_team_neutral;
    
    if ( !isdefined( level.default_goalradius ) )
    {
        level.default_goalradius = 2048;
    }
    
    if ( !isdefined( level.default_goalheight ) )
    {
        level.default_goalheight = 512;
    }
    
    level.portable_mg_gun_tag = "J_Shoulder_RI";
    level._max_script_health = 0;
    ai = getaispeciesarray();
    array_thread( ai, &living_ai_prethink );
    level.ai_classname_in_level = [];
    level.drone_paths = [];
    spawners = getspawnerarray();
    
    for ( i = 0; i < spawners.size ; i++ )
    {
        spawners[ i ] thread spawn_prethink();
    }
    
    level.drone_paths = undefined;
    hudoutline_add_child_channel( "tracker", 1, "default" );
    thread process_deathflags();
    array_thread( ai, &spawn_think );
    var_662425da496a7dd3 = getarraykeys( level.ai_classname_in_level );
    precache_rpg = 0;
    precache_armor = 0;
    
    for ( i = 0; i < var_662425da496a7dd3.size ; i++ )
    {
        classname = tolower( var_662425da496a7dd3[ i ] );
        
        if ( !precache_rpg && issubstr( classname, "rpg" ) )
        {
            precache_rpg = 1;
            rocketlauncher = "iw8_la_rpapa7";
            precacheitem( rocketlauncher );
            continue;
        }
        
        if ( !precache_armor && issubstr( classname, "tier" ) )
        {
            precache_armor = 1;
            scripts\sp\ai_armor::precache();
        }
        
        if ( precache_rpg && precache_armor )
        {
            break;
        }
    }
    
    /#
        aitype_check();
    #/
}

/#

    // Namespace spawner / scripts\sp\spawner
    // Params 0
    // Checksum 0x0, Offset: 0x1217
    // Size: 0xae, Type: dev
    function aitype_check()
    {
        ents = getaispeciesarray();
        ents = array_combine( getspawnerarray(), ents );
        
        foreach ( ent in ents )
        {
            if ( issubstr( ent.classname, "<dev string:x1e>" ) )
            {
                assertmsg( "<dev string:x2e>" + ent.classname + "<dev string:x50>" + ent.origin + "<dev string:x56>" );
            }
        }
    }

#/

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x12cd
// Size: 0x62
function process_deathflags()
{
    foreach ( deathflag, array in level.deathflags )
    {
        if ( !isdefined( level.flag[ deathflag ] ) )
        {
            flag_init( deathflag );
        }
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x1337
// Size: 0x30
function spawn_guys_until_death_or_no_count()
{
    self endon( "death" );
    
    for ( ;; )
    {
        if ( self.count > 0 )
        {
            self waittill( "spawned" );
        }
        
        waittillframeend();
        
        if ( !self.count )
        {
            return;
        }
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x136f
// Size: 0x8f
function vehicle_deathflag()
{
    ai_number = self.unique_id;
    deathflag = self.script_deathflag;
    
    if ( !isdefined( level.deathflags ) || !isdefined( level.deathflags[ self.script_deathflag ] ) )
    {
        waittillframeend();
        
        if ( !isdefined( self ) )
        {
            return;
        }
    }
    
    level.deathflags[ deathflag ][ "vehicles" ][ ai_number ] = self;
    self waittill( "death" );
    level.deathflags[ deathflag ][ "vehicles" ][ ai_number ] = undefined;
    update_deathflag( deathflag );
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x1406
// Size: 0xb9
function spawner_deathflag()
{
    level.deathflags[ self.script_deathflag ] = [];
    waittillframeend();
    
    if ( !isdefined( self ) || self.count == 0 )
    {
        return;
    }
    
    self.spawner_number = level.spawner_number;
    level.spawner_number++;
    level.deathflags[ self.script_deathflag ][ "spawners" ][ self.spawner_number ] = self;
    deathflag = self.script_deathflag;
    id = self.spawner_number;
    spawn_guys_until_death_or_no_count();
    level.deathflags[ deathflag ][ "spawners" ][ id ] = undefined;
    update_deathflag( deathflag );
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x14c7
// Size: 0xa9
function vehicle_spawner_deathflag()
{
    level.deathflags[ self.script_deathflag ] = [];
    waittillframeend();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.spawner_number = level.spawner_number;
    level.spawner_number++;
    level.deathflags[ self.script_deathflag ][ "vehicle_spawners" ][ self.spawner_number ] = self;
    deathflag = self.script_deathflag;
    id = self.spawner_number;
    spawn_guys_until_death_or_no_count();
    level.deathflags[ deathflag ][ "vehicle_spawners" ][ id ] = undefined;
    update_deathflag( deathflag );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x1578
// Size: 0x7f
function update_deathflag( deathflag )
{
    level notify( "updating_deathflag_" + deathflag );
    level endon( "updating_deathflag_" + deathflag );
    waittillframeend();
    
    foreach ( array in level.deathflags[ deathflag ] )
    {
        if ( getarraykeys( array ).size > 0 )
        {
            return;
        }
    }
    
    flag_set( deathflag );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x15ff
// Size: 0x9c
function outdoor_think( trigger )
{
    assert( trigger.spawnflags & 1 || trigger.spawnflags & 2 || trigger.spawnflags & 4, "trigger_outdoor at " + trigger.origin + " is not set up to trigger AI! Check one of the AI checkboxes on the trigger." );
    trigger endon( "death" );
    
    for ( ;; )
    {
        trigger waittill( "trigger", guy );
        
        if ( !isai( guy ) )
        {
            continue;
        }
        
        guy thread ignore_triggers( 0.15 );
        guy utility::disable_cqbwalk();
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x16a3
// Size: 0x9c
function indoor_think( trigger )
{
    assert( trigger.spawnflags & 1 || trigger.spawnflags & 2 || trigger.spawnflags & 4, "trigger_indoor at " + trigger.origin + " is not set up to trigger AI! Check one of the AI checkboxes on the trigger." );
    trigger endon( "death" );
    
    for ( ;; )
    {
        trigger waittill( "trigger", guy );
        
        if ( !isai( guy ) )
        {
            continue;
        }
        
        guy thread ignore_triggers( 0.15 );
        guy utility::enable_cqbwalk();
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x1747
// Size: 0x12c
function trigger_spawner( trigger )
{
    assertex( isdefined( trigger.target ), "Triggers with flag TRIGGER_SPAWN at " + trigger.origin + " must target at least one spawner." );
    trigger waittill( "trigger" );
    target = trigger.target;
    trigger script_delay();
    spawners = array_combine( getspawnerarray( target ), vehicle_getspawnerarray( target ) );
    
    foreach ( spawner in spawners )
    {
        if ( !isnonentspawner( spawner ) && spawner.code_classname == "script_vehicle" )
        {
            if ( isdefined( spawner.script_moveoverride ) && spawner.script_moveoverride == 1 || !isdefined( spawner.target ) )
            {
                thread scripts\common\vehicle::vehicle_spawn( spawner );
            }
            else
            {
                spawner thread scripts\common\vehicle::spawn_vehicle_and_gopath();
            }
            
            continue;
        }
        
        spawner thread spawn_ai();
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x187b
// Size: 0x1a6
function trigger_spawner_reinforcement( trigger )
{
    assertex( isdefined( trigger.target ), "Triggers with flag TRIGGER_SPAWN at " + trigger.origin + " must target or link to at least one spawner." );
    target = trigger.target;
    targetsreinforcement = 0;
    spawners = getspawnerarray( target );
    
    foreach ( spawner in spawners )
    {
        if ( !isdefined( spawner.target ) )
        {
            continue;
        }
        
        reinforcement_spawner = getspawner( spawner.target, "targetname" );
        
        if ( !isdefined( reinforcement_spawner ) )
        {
            if ( !isdefined( spawner.script_linkto ) )
            {
                continue;
            }
            
            reinforcement_spawner = getspawner( spawner.script_linkto, "script_linkname" );
            
            if ( !isdefined( reinforcement_spawner ) )
            {
                reinforcement_spawner = spawner get_linked_ent();
            }
            
            if ( !isdefined( reinforcement_spawner ) )
            {
                continue;
            }
            
            if ( !isspawner( reinforcement_spawner ) )
            {
                continue;
            }
        }
        
        targetsreinforcement = 1;
        break;
    }
    
    assertex( targetsreinforcement == 1, "trigger_multiple_spawn_reinforcement trigger needs at least one AI to target a reinforcement spawner. You should just be using trigger_multiple_spawn in this case." );
    trigger waittill( "trigger" );
    trigger script_delay();
    spawners = getspawnerarray( target );
    
    foreach ( spawner in spawners )
    {
        spawner thread trigger_reinforcement_spawn_guys();
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x1a29
// Size: 0x14a
function trigger_reinforcement_spawn_guys()
{
    reinforcement = trigger_reinforcement_get_reinforcement_spawner();
    guy = spawn_ai();
    
    if ( !isdefined( guy ) )
    {
        self delete();
        
        if ( isdefined( reinforcement ) )
        {
            guy = reinforcement spawn_ai();
            reinforcement delete();
            
            if ( !isdefined( guy ) )
            {
                return;
            }
        }
        else
        {
            return;
        }
    }
    
    if ( !isdefined( reinforcement ) )
    {
        return;
    }
    
    guy waittill( "death" );
    
    if ( !isdefined( reinforcement ) )
    {
        return;
    }
    
    if ( !isdefined( reinforcement.count ) )
    {
        reinforcement.count = 1;
    }
    
    for ( ;; )
    {
        if ( !isdefined( reinforcement ) )
        {
            break;
        }
        
        spawned = reinforcement spawn_ai();
        
        if ( !isdefined( spawned ) )
        {
            reinforcement delete();
            break;
        }
        
        spawned thread reincrement_count_if_deleted( reinforcement );
        spawned waittill( "death", attacker );
        
        if ( !player_saw_kill( spawned, attacker ) )
        {
            println( "<dev string:x84>" );
            
            if ( !isdefined( reinforcement ) )
            {
                break;
            }
            
            reinforcement.count++;
        }
        
        if ( !isdefined( spawned ) )
        {
            continue;
        }
        
        if ( !isdefined( reinforcement ) )
        {
            break;
        }
        
        if ( !isdefined( reinforcement.count ) )
        {
            break;
        }
        
        if ( reinforcement.count <= 0 )
        {
            break;
        }
        
        if ( !script_wait() )
        {
            wait randomfloatrange( 1, 3 );
        }
    }
    
    if ( isdefined( reinforcement ) )
    {
        reinforcement delete();
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x1b7b
// Size: 0x7f
function trigger_reinforcement_get_reinforcement_spawner()
{
    if ( isdefined( self.target ) )
    {
        reinforcement = getspawner( self.target, "targetname" );
        
        if ( isdefined( reinforcement ) && isspawner( reinforcement ) )
        {
            return reinforcement;
        }
    }
    
    if ( isdefined( self.script_linkto ) )
    {
        reinforcement = getspawner( self.script_linkto, "script_linkname" );
        
        if ( !isdefined( reinforcement ) )
        {
            reinforcement = get_linked_ent();
        }
        
        if ( isdefined( reinforcement ) && isspawner( reinforcement ) )
        {
            return reinforcement;
        }
    }
    
    return undefined;
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x1c03
// Size: 0x3b
function flood_spawner_scripted( spawners )
{
    assertex( isdefined( spawners ) && spawners.size, "Script tried to flood spawn without any spawners" );
    array_thread( spawners, &flood_spawner_init );
    array_thread( spawners, &flood_spawner_think );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x1c46
// Size: 0x45
function reincrement_count_if_deleted( spawner )
{
    spawner endon( "death" );
    
    if ( isdefined( self.script_force_count ) )
    {
        if ( self.script_force_count )
        {
            return;
        }
    }
    
    self waittill( "death" );
    
    if ( !isdefined( self ) )
    {
        spawner.count++;
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x1c93
// Size: 0x3b
function kill_spawner( trigger )
{
    killspawnernum = trigger.script_killspawner;
    trigger waittill( "trigger" );
    waittillframeend();
    waittillframeend();
    killspawner( killspawnernum );
    kill_trigger( trigger );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x1cd6
// Size: 0xa9
function killspawner( killspawnernum )
{
    println( "<dev string:xbb>" + killspawnernum );
    actor_spawners = getspawnerarray();
    vehicle_spawners = vehicle_getspawnerarray();
    spawners = array_combine( actor_spawners, vehicle_spawners );
    
    for ( i = 0; i < spawners.size ; i++ )
    {
        if ( isdefined( spawners[ i ].script_killspawner ) && killspawnernum == spawners[ i ].script_killspawner )
        {
            if ( isnonentspawner( spawners[ i ] ) )
            {
                spawners[ i ] notify( "death" );
            }
            
            spawners[ i ] delete();
        }
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x1d87
// Size: 0x3d
function kill_trigger( trigger )
{
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    if ( isdefined( trigger.targetname ) && trigger.targetname != "flood_spawner" )
    {
        return;
    }
    
    trigger delete();
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x1dcc
// Size: 0x60
function random_killspawner( trigger )
{
    trigger endon( "death" );
    random_killspawner = trigger.script_random_killspawner;
    waittillframeend();
    
    if ( !isdefined( level.killspawn_groups ) )
    {
        level.killspawn_groups = [];
    }
    
    if ( !isdefined( level.killspawn_groups[ random_killspawner ] ) )
    {
        return;
    }
    
    trigger waittill( "trigger" );
    cull_spawners_from_killspawner( random_killspawner );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x1e34
// Size: 0x11b
function cull_spawners_from_killspawner( random_killspawner )
{
    if ( !isdefined( level.killspawn_groups ) )
    {
        level.killspawn_groups = [];
    }
    
    if ( !isdefined( level.killspawn_groups[ random_killspawner ] ) )
    {
        return;
    }
    
    spawn_groups = level.killspawn_groups[ random_killspawner ];
    keys = getarraykeys( spawn_groups );
    
    if ( keys.size <= 1 )
    {
        return;
    }
    
    save_key = random( keys );
    spawn_groups[ save_key ] = undefined;
    
    foreach ( spawners in spawn_groups )
    {
        foreach ( spawner in spawners )
        {
            if ( isdefined( spawner ) )
            {
                spawner delete();
            }
        }
        
        level.killspawn_groups[ random_killspawner ][ key ] = undefined;
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x1f57
// Size: 0x98
function empty_spawner( trigger )
{
    emptyspawner = trigger.script_emptyspawner;
    trigger waittill( "trigger" );
    spawners = getspawnerarray();
    
    for ( i = 0; i < spawners.size ; i++ )
    {
        if ( !isdefined( spawners[ i ].script_emptyspawner ) )
        {
            continue;
        }
        
        if ( emptyspawner != spawners[ i ].script_emptyspawner )
        {
            continue;
        }
        
        spawners[ i ] set_count( 0 );
        spawners[ i ] notify( "emptied spawner" );
    }
    
    trigger notify( "deleted spawners" );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x1ff7
// Size: 0x88
function kill_spawnernum( number )
{
    spawners = getspawnerarray();
    
    foreach ( spawner in spawners )
    {
        if ( !isdefined( spawner.script_killspawner ) )
        {
            continue;
        }
        
        if ( number != spawner.script_killspawner )
        {
            continue;
        }
        
        spawner delete();
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 2
// Checksum 0x0, Offset: 0x2087
// Size: 0x34
function spawn_grenade( origin, team )
{
    grenade = spawn( "weapon_frag", origin );
    grenade thread add_to_grenade_cache( team );
    return grenade;
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x20c4
// Size: 0x9f
function add_to_grenade_cache( team )
{
    if ( !isdefined( level.grenade_cache ) || !isdefined( level.grenade_cache[ team ] ) )
    {
        level.grenade_cache_index[ team ] = 0;
        level.grenade_cache[ team ] = [];
    }
    
    index = level.grenade_cache_index[ team ];
    item = level.grenade_cache[ team ][ index ];
    
    if ( isdefined( item ) )
    {
        item delete();
    }
    
    level.grenade_cache[ team ][ index ] = self;
    level.grenade_cache_index[ team ] = ( index + 1 ) % 16;
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x216b
// Size: 0x9
function dronespawner_init()
{
    scripts\sp\drone_base::drone_init_path();
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x217c
// Size: 0x9
function fakeactorspawner_init()
{
    scripts\sp\fakeactor::fakeactor_spawner_init();
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x218d
// Size: 0x399
function spawn_prethink()
{
    assert( self != level );
    level.ai_classname_in_level[ self.classname ] = 1;
    
    /#
        if ( getdvar( @"noai", "<dev string:xd1>" ) != "<dev string:xd1>" )
        {
            set_count( 0 );
            return;
        }
    #/
    
    if ( isdefined( self.script_difficulty ) )
    {
        switch ( self.script_difficulty )
        {
            case #"hash_22ce4003c1e5227b":
                if ( level.gameskill > 1 )
                {
                    set_count( 0 );
                }
                
                break;
            case #"hash_cc9157548a55043c":
                if ( level.gameskill < 2 )
                {
                    set_count( 0 );
                }
                
                break;
        }
    }
    
    init_stealth();
    
    if ( isdefined( self.script_drone ) )
    {
        thread dronespawner_init();
    }
    
    if ( isdefined( self.script_fakeactor ) )
    {
        thread fakeactorspawner_init();
    }
    
    if ( isdefined( self.script_aigroup ) )
    {
        aigroup = self.script_aigroup;
        
        if ( !isdefined( level._ai_group[ aigroup ] ) )
        {
            aigroup_create( aigroup );
        }
        
        thread aigroup_spawnerthink( level._ai_group[ aigroup ] );
    }
    
    if ( isdefined( self.script_delete ) )
    {
        array_size = 0;
        
        if ( isdefined( level._ai_delete ) )
        {
            if ( isdefined( level._ai_delete[ self.script_delete ] ) )
            {
                array_size = level._ai_delete[ self.script_delete ].size;
            }
        }
        
        level._ai_delete[ self.script_delete ][ array_size ] = self;
    }
    
    if ( isdefined( self.script_health ) )
    {
        if ( self.script_health > level._max_script_health )
        {
            level._max_script_health = self.script_health;
        }
        
        array_size = 0;
        
        if ( isdefined( level._ai_health ) )
        {
            if ( isdefined( level._ai_health[ self.script_health ] ) )
            {
                array_size = level._ai_health[ self.script_health ].size;
            }
        }
        
        level._ai_health[ self.script_health ][ array_size ] = self;
    }
    
    if ( isdefined( self.script_deathflag ) )
    {
        thread spawner_deathflag();
    }
    
    if ( isdefined( self.target ) )
    {
        crawl_targets_init_flags( self.target );
    }
    
    if ( isdefined( self.script_spawngroup ) )
    {
        add_to_spawngroup();
    }
    
    if ( isdefined( self.script_random_killspawner ) )
    {
        add_random_killspawner_to_spawngroup();
    }
    
    if ( !isdefined( self.spawn_functions ) )
    {
        self.spawn_functions = [];
    }
    
    for ( ;; )
    {
        self waittill( "spawned", spawned );
        
        if ( !isalive( spawned ) )
        {
            continue;
        }
        
        if ( isdefined( level.spawnercallbackthread ) )
        {
            self thread [[ level.spawnercallbackthread ]]( spawned );
        }
        
        if ( isdefined( self.script_delete ) )
        {
            for ( i = 0; i < level._ai_delete[ self.script_delete ].size ; i++ )
            {
                if ( level._ai_delete[ self.script_delete ][ i ] != self )
                {
                    level._ai_delete[ self.script_delete ][ i ] delete();
                }
            }
        }
        
        spawned.spawn_funcs = self.spawn_functions;
        spawned.spawn_functions = undefined;
        spawned.spawner = self;
        
        if ( isdefined( self.targetname ) )
        {
            spawned thread spawn_think( self.targetname );
            continue;
        }
        
        spawned thread spawn_think();
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x252e
// Size: 0x56
function init_stealth()
{
    if ( !isdefined( self.script_stealth ) && !isdefined( self.script_stealthgroup ) )
    {
        return;
    }
    
    if ( isdefined( self.script_stealth ) && !isdefined( self.script_stealthgroup ) )
    {
        self.script_stealthgroup = self.script_stealth;
    }
    
    self.script_stealth = undefined;
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x258c
// Size: 0xa6
function spawn_think( targetname )
{
    assert( self != level );
    level.ai_classname_in_level[ self.classname ] = 1;
    
    if ( isdefined( self.asmname ) && self.asmname == "seeker" )
    {
        return;
    }
    
    spawn_think_action( targetname );
    assert( isalive( self ) );
    self endon( "death" );
    
    if ( shouldnt_spawn_because_of_script_difficulty() )
    {
        self delete();
        assertex( 0, "Should never get here" );
    }
    
    thread run_spawn_functions();
    self.finished_spawning = 1;
    self notify( "finished spawning" );
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x263a
// Size: 0x73
function shouldnt_spawn_because_of_script_difficulty()
{
    if ( !isdefined( self.script_difficulty ) )
    {
        return 0;
    }
    
    should_delete = 0;
    
    switch ( self.script_difficulty )
    {
        case #"hash_22ce4003c1e5227b":
            if ( level.gameskill > 1 )
            {
                should_delete = 1;
            }
            
            break;
        case #"hash_cc9157548a55043c":
            if ( level.gameskill < 2 )
            {
                should_delete = 1;
            }
            
            break;
    }
    
    return should_delete;
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x26b6
// Size: 0x324
function run_spawn_functions()
{
    team = ter_op( isdefined( level.vehicle.spawn_functions_enable ) && level.vehicle.spawn_functions_enable && self.code_classname == "script_vehicle", self.script_team, self.team );
    
    if ( isdefined( team ) )
    {
        for ( i = 0; i < level.spawn_funcs[ team ].size ; i++ )
        {
            func = level.spawn_funcs[ team ][ i ];
            
            if ( isdefined( func[ "param5" ] ) )
            {
                thread [[ func[ "function" ] ]]( func[ "param1" ], func[ "param2" ], func[ "param3" ], func[ "param4" ], func[ "param5" ] );
                continue;
            }
            
            if ( isdefined( func[ "param4" ] ) )
            {
                thread [[ func[ "function" ] ]]( func[ "param1" ], func[ "param2" ], func[ "param3" ], func[ "param4" ] );
                continue;
            }
            
            if ( isdefined( func[ "param3" ] ) )
            {
                thread [[ func[ "function" ] ]]( func[ "param1" ], func[ "param2" ], func[ "param3" ] );
                continue;
            }
            
            if ( isdefined( func[ "param2" ] ) )
            {
                thread [[ func[ "function" ] ]]( func[ "param1" ], func[ "param2" ] );
                continue;
            }
            
            if ( isdefined( func[ "param1" ] ) )
            {
                thread [[ func[ "function" ] ]]( func[ "param1" ] );
                continue;
            }
            
            thread [[ func[ "function" ] ]]();
        }
    }
    
    if ( !isdefined( self.spawn_funcs ) )
    {
        if ( !isdefined( self.script_suspend ) )
        {
            self.spawner = undefined;
        }
        
        return;
    }
    
    for ( i = 0; i < self.spawn_funcs.size ; i++ )
    {
        func = self.spawn_funcs[ i ];
        
        if ( isdefined( func[ "param5" ] ) )
        {
            thread [[ func[ "function" ] ]]( func[ "param1" ], func[ "param2" ], func[ "param3" ], func[ "param4" ], func[ "param5" ] );
            continue;
        }
        
        if ( isdefined( func[ "param4" ] ) )
        {
            thread [[ func[ "function" ] ]]( func[ "param1" ], func[ "param2" ], func[ "param3" ], func[ "param4" ] );
            continue;
        }
        
        if ( isdefined( func[ "param3" ] ) )
        {
            thread [[ func[ "function" ] ]]( func[ "param1" ], func[ "param2" ], func[ "param3" ] );
            continue;
        }
        
        if ( isdefined( func[ "param2" ] ) )
        {
            thread [[ func[ "function" ] ]]( func[ "param1" ], func[ "param2" ] );
            continue;
        }
        
        if ( isdefined( func[ "param1" ] ) )
        {
            thread [[ func[ "function" ] ]]( func[ "param1" ] );
            continue;
        }
        
        thread [[ func[ "function" ] ]]();
    }
    
    /#
        self.var_5295f7f174b863a6 = self.spawn_funcs;
    #/
    
    self.spawn_funcs = undefined;
    
    /#
        self.spawn_funcs = self.var_5295f7f174b863a6;
        self.var_5295f7f174b863a6 = undefined;
    #/
    
    if ( !isdefined( self.script_suspend ) )
    {
        self.spawner = undefined;
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x29e2
// Size: 0x19f
function deathfunctions()
{
    self waittill( "death", attacker, cause, objweapon );
    weapon = undefined;
    
    if ( isdefined( objweapon ) )
    {
        weapon = getcompleteweaponname( objweapon );
    }
    
    level notify( "ai_killed", self, attacker, cause, weapon );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( attacker ) )
    {
        if ( self.team == "axis" || self.team == "team3" )
        {
            killtype = undefined;
            
            if ( isdefined( attacker.attacker ) )
            {
                if ( isdefined( attacker.issentrygun ) && attacker.issentrygun )
                {
                    killtype = "sentry";
                }
                
                if ( isdefined( attacker.destructible_type ) )
                {
                    killtype = "destructible";
                }
                
                attacker = attacker.attacker;
            }
            else if ( isdefined( attacker.owner ) )
            {
                if ( isai( attacker ) && isplayer( attacker.owner ) )
                {
                    killtype = "friendly";
                }
                
                attacker = attacker.owner;
            }
            else if ( isdefined( attacker.damageowner ) )
            {
                if ( isdefined( attacker.destructible_type ) )
                {
                    killtype = "destructible";
                }
                
                attacker = attacker.damageowner;
            }
            
            validattacker = 0;
            
            if ( isplayer( attacker ) )
            {
                validattacker = 1;
            }
            
            if ( validattacker )
            {
                attacker.lastenemykilltime = gettime();
                attacker scripts\sp\player_stats::register_kill( self, cause, weapon, killtype );
            }
            
            scripts\sp\analytics::function_7212c89168020e04( self, attacker, objweapon );
        }
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x2b89
// Size: 0x21f
function ai_damage_think()
{
    self endon( "entitydeleted" );
    
    if ( !isdefined( self.damage_functions ) )
    {
        self.damage_functions = [];
    }
    
    for ( ;; )
    {
        self waittill( "damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon );
        self.paindamage = damage;
        
        if ( isdefined( attacker ) && isplayer( attacker ) )
        {
            objcurrentweapon = attacker.currentweapon;
            
            if ( isdefined( objcurrentweapon ) && isprimaryweapon( objcurrentweapon ) && isdefined( type ) && ( type == "MOD_PISTOL_BULLET" || type == "MOD_RIFLE_BULLET" ) )
            {
                attacker thread scripts\sp\player_stats::register_shot_hit();
                
                if ( self isbadguy() )
                {
                    attacker.lastenemydmgtime = gettime();
                }
                
                if ( isalive( self ) )
                {
                    addbattlechatternotify( self, undefined, "wounded" );
                }
            }
        }
        
        /#
            if ( getdvarint( @"hash_81d89e4abec64203", 0 ) != 0 )
            {
                dmg_data = [];
                dmg_data[ "<dev string:xd5>" ] = attacker;
                dmg_data[ "<dev string:xdf>" ] = damage;
                dmg_data[ "<dev string:xe7>" ] = type;
                dmg_data[ "<dev string:xf5>" ] = point;
                dmg_data[ "<dev string:xfc>" ] = direction_vec;
                dmg_data[ "<dev string:x101>" ] = objweapon;
                dmg_data[ "<dev string:x10b>" ] = partname;
                scripts\common\debug::function_8245dce28f1f395c( dmg_data );
            }
        #/
        
        foreach ( func in self.damage_functions )
        {
            thread [[ func ]]( damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon );
        }
        
        if ( !isalive( self ) || self.delayeddeath )
        {
            break;
        }
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x2db0
// Size: 0x26
function living_ai_prethink()
{
    init_stealth();
    
    if ( isdefined( self.target ) )
    {
        crawl_targets_init_flags( self.target );
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x2dde
// Size: 0x20a
function crawl_targets_init_flags( target )
{
    goals = get_target_goals( target );
    
    if ( goals.size == 0 )
    {
        return;
    }
    
    index = -1;
    
    for ( ;; )
    {
        index++;
        
        if ( index >= goals.size )
        {
            break;
        }
        
        goal = goals[ index ];
        
        if ( isdefined( goal.crawled ) )
        {
            continue;
        }
        
        goal.crawled = 1;
        level thread remove_crawled( goal );
        
        if ( isdefined( goal.script_flag_set ) )
        {
            if ( !isdefined( level.flag[ goal.script_flag_set ] ) )
            {
                flag_init( goal.script_flag_set );
            }
        }
        
        if ( isdefined( goal.script_flag_wait ) )
        {
            if ( !isdefined( level.flag[ goal.script_flag_wait ] ) )
            {
                flag_init( goal.script_flag_wait );
            }
        }
        
        if ( isdefined( goal.script_flag_clear ) )
        {
            if ( !isdefined( level.flag[ goal.script_flag_clear ] ) )
            {
                flag_init( goal.script_flag_clear );
            }
        }
        
        if ( isdefined( goal.script_flag_waitopen ) )
        {
            if ( !isdefined( level.flag[ goal.script_flag_waitopen ] ) )
            {
                flag_init( goal.script_flag_waitopen );
            }
        }
        
        if ( isdefined( goal.script_idle ) )
        {
            if ( !isdefined( level.idle_funcs ) )
            {
                scripts\sp\stealth\idle_sitting::main();
            }
        }
        
        if ( isdefined( goal.target ) )
        {
            new_goals = get_target_goals( goal.target );
            
            foreach ( new in new_goals )
            {
                if ( !isdefined( new.crawled ) )
                {
                    goals[ goals.size ] = new;
                }
            }
        }
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x2ff0
// Size: 0x1c
function remove_crawled( ent )
{
    waittillframeend();
    
    if ( isdefined( ent ) )
    {
        ent.crawled = undefined;
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x3014
// Size: 0x21
function spawn_team_allies()
{
    self.usechokepoints = 0;
    checkboosttraversal();
    self function_523285babab34e5b( "all", 1 );
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x303d
// Size: 0x78
function spawn_team_axis()
{
    checkboosttraversal();
    
    if ( isdefined( self.script_combatmode ) )
    {
        self.combatmode = self.script_combatmode;
    }
    
    /#
        if ( getdvar( @"hash_c3ae5b7542b15a78" ) == "<dev string:x114>" )
        {
            self.combatmode = "<dev string:x114>";
            return;
        }
        
        if ( getdvar( @"hash_c3ae5b7542b15a78" ) == "<dev string:x11b>" )
        {
            self.combatmode = "<dev string:x11b>";
        }
    #/
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x30bd
// Size: 0x53
function checkboosttraversal()
{
    var_5181f3dc1052495f[ "crew" ] = 1;
    var_5181f3dc1052495f[ "no_boost" ] = 1;
    var_5181f3dc1052495f[ "noboost" ] = 1;
    
    if ( isdefined( self.subclass ) && isdefined( var_5181f3dc1052495f[ self.subclass ] ) )
    {
        self enabletraversals( 0, "soldier_boost" );
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x3118
// Size: 0x10
function spawn_team_team3()
{
    spawn_team_axis();
    checkboosttraversal();
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x3130
// Size: 0x9
function spawn_team_neutral()
{
    checkboosttraversal();
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x3141
// Size: 0x2
function spawn_unittype_soldier()
{
    
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x314b
// Size: 0x10
function spawn_think_game_skill_related()
{
    scripts\common\gameskill::default_door_node_flashbang_frequency();
    scripts\common\gameskill::grenadeawareness();
}

/#

    // Namespace spawner / scripts\sp\spawner
    // Params 0
    // Checksum 0x0, Offset: 0x3163
    // Size: 0x70, Type: dev
    function function_14174a31d7324291()
    {
        if ( getdvar( @"debug_misstime" ) == "<dev string:x12d>" )
        {
            thread scripts\sp\debug::debugmisstime();
        }
        
        thread show_bad_path();
        
        if ( self.type == "<dev string:x133>" )
        {
            assertex( self.pathenemylookahead == 0 && self.pathenemyfightdist == 0, "<dev string:x139>" + self.export );
        }
    }

#/

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x31db
// Size: 0x306
function spawn_think_action( targetname )
{
    thread ai_damage_think();
    thread tanksquish();
    
    if ( !isdefined( level.ai_dont_glow_in_thermal ) )
    {
        self thermaldrawenable();
    }
    
    self.spawner_number = undefined;
    
    if ( !isdefined( self.unique_id ) )
    {
        set_ai_number();
        function_82581894f5a1c71c();
    }
    
    thread deathfunctions();
    level thread scripts\sp\friendlyfire::friendly_fire_think( self );
    self.walkdist = 16;
    
    /#
        function_14174a31d7324291();
    #/
    
    init_reset_ai();
    spawn_think_game_skill_related();
    ai::spawner_fields( self );
    thread scripts\sp\loot::corpselootthink();
    
    /#
        if ( getdvarint( @"scr_heat" ) == 1 )
        {
            enable_heat_behavior();
        }
    #/
    
    [[ level.team_specific_spawn_functions[ self.team ] ]]();
    
    if ( isdefined( level.unittype_spawn_functions[ self.unittype ] ) )
    {
        self thread [[ level.unittype_spawn_functions[ self.unittype ] ]]();
    }
    
    if ( isdefined( self.subclass ) && isdefined( level.subclass_spawn_functions[ self.subclass ] ) )
    {
        self thread [[ level.subclass_spawn_functions[ self.subclass ] ]]();
    }
    
    if ( self.team == "axis" )
    {
        thread add_damage_function( &scripts\sp\damagefeedback::damagefeedback_took_damage );
    }
    
    set_goal_height_from_settings();
    
    if ( isdefined( self.suspended_ai ) )
    {
        postspawn_suspended_ai();
    }
    
    if ( isdefined( self.script_playerseek ) )
    {
        self setgoalentity( level.player );
        return;
    }
    
    if ( isdefined( self.script_stealthgroup ) )
    {
        if ( !isdefined( level.stealth ) )
        {
            scripts\sp\stealth\manager::main();
        }
        
        stealth_call_thread( "do_stealth" );
        return;
    }
    
    if ( isdefined( self.script_readystand ) && self.script_readystand == 1 )
    {
        enable_readystand();
    }
    
    if ( isdefined( self.script_delayed_playerseek ) )
    {
        if ( !isdefined( self.script_radius ) )
        {
            self.goalradius = 800;
        }
        
        self setgoalentity( level.player );
        level thread delayed_player_seek_think( self );
        return;
    }
    
    if ( isdefined( self.script_moveoverride ) && self.script_moveoverride == 1 )
    {
        set_goal_from_settings();
        self setgoalpos( self.origin );
        return;
    }
    
    var_12c0b5e114d7ddb = 1;
    
    if ( isdefined( self.script_stealthgroup ) )
    {
        var_12c0b5e114d7ddb = 0;
    }
    
    if ( var_12c0b5e114d7ddb )
    {
        defaultgoalradius = 4;
        
        if ( isdefined( self.aisettings ) && istrue( self.aisettings.var_90936cd2d6771517 ) )
        {
            defaultgoalradius = self.aisettings.goalradius;
        }
        
        assertex( self.goalradius == defaultgoalradius, "Changed the goalradius on guy with export " + self.export + " without waiting for spawn_failed. Note that this change will NOT show up by putting a breakpoint on the actors goalradius field because breakpoints don't properly handle the first frame an actor exists." );
    }
    
    set_goal_from_settings();
    
    if ( isdefined( self.target ) )
    {
        thread go_to_node();
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x34e9
// Size: 0x6a
function init_reset_ai()
{
    if ( !isdefined( self.var_6c18812ecbd3b6ae ) || self.var_6c18812ecbd3b6ae )
    {
        set_default_pathenemy_settings();
    }
    
    if ( isdefined( self.script_grenades ) )
    {
        self.grenadeammo = self.script_grenades;
    }
    
    if ( isdefined( self.primaryweapon ) )
    {
        self.noattackeraccuracymod = self aiissniper();
    }
    
    self.neversprintforvariation = 1;
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x355b
// Size: 0x1c0
function scrub_guy()
{
    if ( self.team == "neutral" )
    {
        self setthreatbiasgroup( "civilian" );
    }
    else
    {
        self setthreatbiasgroup( self.team );
    }
    
    init_reset_ai();
    self.baseaccuracy = 1;
    scripts\common\gameskill::grenadeawareness();
    clear_force_color();
    self.interval = 96;
    self.disablearrivals = 0;
    self.ignoreme = 0;
    self.ignoreall = 0;
    self.threatbias = 0;
    self.pacifist = 0;
    self.pacifistwait = 20;
    self.ignorerandombulletdamage = 0;
    self.pushable = 1;
    self.script_pushable = 1;
    self.allowdeath = 0;
    self.anglelerprate = 540;
    self.badplaceawareness = 0.75;
    self.dontavoidplayer = 0;
    self.drawoncompass = 1;
    self.dropweapon = 1;
    self.goalradius = level.default_goalradius;
    self.goalheight = level.default_goalheight;
    self.ignoresuppression = 0;
    self pushplayer( 0 );
    self.grenadeammo = 3;
    
    if ( isdefined( self.magic_bullet_shield ) && self.magic_bullet_shield )
    {
        stop_magic_bullet_shield();
    }
    
    disable_replace_on_death();
    self.maxsightdistsqrd = 67108864;
    self.script_forcegrenade = 0;
    self.walkdist = 16;
    self.pushable = 1;
    self.script_pushable = 1;
    scripts\anim\init::set_anim_playback_rate();
    self.fixednode = self.team == "allies";
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x3723
// Size: 0x4c
function delayed_player_seek_think( spawned )
{
    spawned endon( "death" );
    
    while ( isalive( spawned ) )
    {
        if ( spawned.goalradius > 200 )
        {
            spawned.goalradius -= 200;
        }
        
        wait 6;
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x3777
// Size: 0xde
function get_target_goals( target )
{
    goals = getnodearray( target, "targetname" );
    new_goals = getstructarray( target, "targetname" );
    
    foreach ( new in new_goals )
    {
        goals[ goals.size ] = new;
    }
    
    new_goals = getentarray( target, "targetname" );
    
    foreach ( new in new_goals )
    {
        if ( !is_target_goal_valid( new ) )
        {
            continue;
        }
        
        goals[ goals.size ] = new;
    }
    
    return goals;
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x385e
// Size: 0x5d, Type: bool
function is_target_goal_valid( object )
{
    if ( isspawner( object ) )
    {
        return false;
    }
    
    switch ( object.code_classname )
    {
        case #"hash_1b79c5d9e0f9886a":
        case #"hash_5e0756fcd4e0adcd":
        case #"hash_8040aa10d9cac1e8":
        case #"hash_81903cb95a447b8c":
            return false;
    }
    
    return true;
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x38c4
// Size: 0x28, Type: bool
function node_has_radius( node )
{
    return isdefined( node.radius ) && node.radius != 0;
}

// Namespace spawner / scripts\sp\spawner
// Params 4
// Checksum 0x0, Offset: 0x38f5
// Size: 0x78
function go_to_node( nodes, optional_arrived_at_node_func, var_5e38f20c9628ae25, var_686ec37f85316247 )
{
    if ( !isdefined( nodes ) )
    {
        nodes = [];
        
        if ( isdefined( self.target ) )
        {
            nodes = get_target_goals( self.target );
        }
        
        if ( nodes.size == 0 )
        {
            self notify( "reached_path_end" );
            return;
        }
    }
    else if ( !isarray( nodes ) )
    {
        nodes = [ nodes ];
    }
    
    go_to_node_internal( nodes, optional_arrived_at_node_func, var_5e38f20c9628ae25, var_686ec37f85316247 );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x3975
// Size: 0xd6
function get_least_used_from_array( array )
{
    if ( array.size == 1 )
    {
        return array[ 0 ];
    }
    
    array = array_randomize( array );
    least_used = array[ 0 ];
    
    if ( !isdefined( least_used.used_time ) )
    {
        least_used.used_time = 0;
    }
    
    foreach ( node in array )
    {
        if ( !isdefined( node.used_time ) )
        {
            node.used_time = 0;
        }
        
        if ( node.used_time < least_used.used_time )
        {
            least_used = node;
        }
    }
    
    least_used.used_time = gettime();
    return least_used;
}

// Namespace spawner / scripts\sp\spawner
// Params 4
// Checksum 0x0, Offset: 0x3a54
// Size: 0x2c1
function go_to_node_internal( node, optional_arrived_at_node_func, var_5e38f20c9628ae25, var_686ec37f85316247 )
{
    self notify( "stop_going_to_node" );
    self endon( "stop_going_to_node" );
    self endon( "death" );
    
    if ( !isarray( node ) )
    {
        node = [ node ];
    }
    
    if ( isdefined( var_686ec37f85316247 ) )
    {
        startnode = var_686ec37f85316247;
    }
    else
    {
        startnode = node[ 0 ];
    }
    
    thread go_to_node_end();
    usingpatharray = 0;
    patharray = undefined;
    self.interactionplayed = undefined;
    
    for ( ;; )
    {
        if ( !usingpatharray )
        {
            if ( isdefined( level.var_375b317cc772ef57 ) )
            {
                node = [[ level.var_375b317cc772ef57 ]]( node );
            }
            else
            {
                node = get_least_used_from_array( node );
            }
            
            self.patharraystartnode = startnode;
            patharray = get_path_array( node, startnode );
            self.patharray = patharray;
            self.patharrayindex = -1;
            
            if ( patharray.size > 1 )
            {
                usingpatharray = 1;
            }
        }
        
        self.currentnode = node;
        
        if ( usingpatharray )
        {
            node = patharray[ patharray.size - 1 ];
            go_through_patharray( patharray, optional_arrived_at_node_func, var_5e38f20c9628ae25 );
            patharray = undefined;
            usingpatharray = 0;
        }
        else
        {
            node_fields_pre_goal( node );
            
            if ( isdefined( self.stealth ) )
            {
                stealth_call( "go_to_node_wait", &go_to_node_set_goal, node );
            }
            else
            {
                go_to_node_set_goal( node );
                self waittill( "goal" );
            }
        }
        
        node notify( "trigger", self );
        node_fields_after_goal( node, optional_arrived_at_node_func );
        interactionid = self getinteractionid();
        
        if ( isdefined( interactionid ) )
        {
            self waittill( "bseq_user_deleted" );
        }
        else
        {
            node script_delay();
        }
        
        if ( isdefined( node.script_flag_wait ) )
        {
            flag_wait( node.script_flag_wait );
        }
        
        if ( isdefined( node.script_flag_waitopen ) )
        {
            flag_waitopen( node.script_flag_waitopen );
        }
        
        if ( isdefined( node.script_ent_flag_wait ) )
        {
            ent_flag_wait( node.script_ent_flag_wait );
        }
        
        if ( isdefined( node.var_43add43a57978cd ) )
        {
            ent_flag_waitopen( node.var_43add43a57978cd );
        }
        
        node script_wait();
        node_fields_after_goal_and_wait( node, var_5e38f20c9628ae25 );
        
        if ( !isdefined( node.target ) )
        {
            break;
        }
        
        nextnode_array = get_target_goals( node.target );
        
        if ( !nextnode_array.size )
        {
            break;
        }
        
        node = nextnode_array;
    }
    
    self notify( "reached_path_end" );
    
    if ( isdefined( self.script_forcegoal ) )
    {
        return;
    }
    
    volume = self getgoalvolume();
    
    if ( isdefined( volume ) )
    {
        self setgoalvolumeauto( volume, volume get_cover_volume_forward() );
        return;
    }
    
    self.goalradius = level.default_goalradius;
}

// Namespace spawner / scripts\sp\spawner
// Params 3
// Checksum 0x0, Offset: 0x3d1d
// Size: 0x102
function go_through_patharray( patharray, optional_arrived_at_node_func, var_5e38f20c9628ae25 )
{
    self setgoalpath( patharray );
    
    foreach ( index, tempnode in patharray )
    {
        node_fields_pre_goal( tempnode );
        
        if ( index == 0 )
        {
            while ( istrue( self.arriving ) )
            {
                waitframe();
            }
        }
        
        patharrayindex = waittill_subgoal();
        self.patharrayindex = patharrayindex;
        
        if ( isdefined( self.patharray ) && !isdefined( self.patharrayindex ) )
        {
            self.patharrayindex = self.patharray.size - 1;
        }
        
        if ( index == patharray.size - 1 )
        {
            self waittill( "goal" );
            break;
        }
        
        tempnode notify( "trigger", self );
        function_b8caa11a38862f1c( tempnode, optional_arrived_at_node_func );
        node_fields_after_goal_and_wait( tempnode, var_5e38f20c9628ae25 );
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x3e27
// Size: 0x1d
function waittill_subgoal()
{
    self endon( "goal" );
    self waittill( "subgoal", index );
    return index;
}

// Namespace spawner / scripts\sp\spawner
// Params 2
// Checksum 0x0, Offset: 0x3e4d
// Size: 0x138
function get_path_array( node, startnode )
{
    array = [];
    count = 0;
    
    while ( true )
    {
        if ( is_equal( node.code_classname, "info_volume" ) )
        {
            break;
        }
        
        array[ array.size ] = node;
        count++;
        
        if ( count == 16 )
        {
            break;
        }
        
        if ( go_to_node_should_stop( node ) )
        {
            break;
        }
        
        if ( !istrue( node.var_97c8a15d77788e5a ) )
        {
            if ( isdefined( node.target ) )
            {
                node.interactionid = getinteractionidfortargetname( node.target );
            }
            
            node.var_97c8a15d77788e5a = 1;
        }
        
        if ( isdefined( node.interactionid ) )
        {
            break;
        }
        
        if ( node == startnode )
        {
            if ( array.size > 1 )
            {
                break;
            }
        }
        
        if ( !isdefined( node.target ) )
        {
            break;
        }
        
        nextnode_array = get_target_goals( node.target );
        
        if ( !nextnode_array.size )
        {
            break;
        }
        
        if ( isdefined( level.var_375b317cc772ef57 ) )
        {
            node = [[ level.var_375b317cc772ef57 ]]( nextnode_array );
            continue;
        }
        
        node = get_least_used_from_array( nextnode_array );
    }
    
    return array;
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x3f8e
// Size: 0x252
function node_fields_pre_goal( node )
{
    if ( isdefined( node.radius ) )
    {
        self.goalradius = node.radius;
    }
    
    if ( isdefined( node.height ) )
    {
        self.goalheight = node.height;
    }
    
    if ( isdefined( node.script_demeanor ) )
    {
        if ( node.script_demeanor == "cqb" )
        {
            utility::enable_cqbwalk();
        }
        else
        {
            utility::demeanor_override( node.script_demeanor );
        }
    }
    
    if ( isdefined( node.script_civilian_state ) )
    {
        scripts\asm\asm_bb::bb_setcivilianstate( node.script_civilian_state );
    }
    
    if ( isdefined( node.script_pacifist ) )
    {
        self.pacifist = node.script_pacifist;
    }
    
    if ( isdefined( node.script_ignoreall ) )
    {
        set_ignoreall( node.script_ignoreall );
    }
    
    if ( isdefined( node.script_ignoreme ) )
    {
        set_ignoreme( node.script_ignoreme );
    }
    
    if ( isdefined( node.script_moveplaybackrate ) )
    {
        set_moveplaybackrate( node.script_moveplaybackrate, 0.25 );
    }
    
    if ( isdefined( node.script_speed ) )
    {
        set_movement_speed( node.script_speed );
    }
    
    if ( isdefined( node.script_gunpose ) )
    {
        set_gunpose( node.script_gunpose );
    }
    
    if ( isdefined( node.script_disable_arrivals ) )
    {
        if ( node.script_disable_arrivals )
        {
            disable_arrivals();
        }
        else
        {
            self.disablearrivals = 0;
        }
    }
    
    if ( isdefined( node.script_disable_exits ) )
    {
        if ( node.script_disable_exits )
        {
            disable_exits();
        }
        else
        {
            enable_exits();
        }
    }
    
    if ( isdefined( node.script_combatmode ) )
    {
        self.combatmode = node.script_combatmode;
    }
    
    if ( isdefined( node.script_forcegoal ) )
    {
        assert( isdefined( node.targetname ) );
        self.target = node.targetname;
    }
    
    if ( isdefined( self.var_8068d435ada84157 ) )
    {
        thread [[ self.var_8068d435ada84157 ]]();
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 3
// Checksum 0x0, Offset: 0x41e8
// Size: 0x128
function node_fields_after_goal( node, optional_arrived_at_node_func, var_8c99244d1e6128b0 )
{
    if ( isdefined( self.stealth ) )
    {
        stealth_call( "go_to_node_arrive", &go_to_node_set_goal, node );
    }
    
    if ( !istrue( var_8c99244d1e6128b0 ) )
    {
        if ( isdefined( node.target ) && ( isdefined( node.interactionid ) || isdefined( node.interaction ) ) )
        {
            scripts\common\ai::function_8cb35add373dee8a( &go_to_node_set_goal, node );
        }
        else
        {
            go_to_node_set_goal();
            self waittill( "goal" );
        }
    }
    
    if ( isdefined( optional_arrived_at_node_func ) )
    {
        [[ optional_arrived_at_node_func ]]( node );
    }
    
    if ( isdefined( node.script_flag_set ) )
    {
        flag_set( node.script_flag_set );
    }
    
    if ( isdefined( node.script_ent_flag_set ) )
    {
        ent_flag_set( node.script_ent_flag_set );
    }
    
    if ( isdefined( node.script_ent_flag_clear ) )
    {
        ent_flag_clear( node.script_ent_flag_clear );
    }
    
    if ( isdefined( node.script_flag_clear ) )
    {
        flag_clear( node.script_flag_clear );
    }
    
    if ( targets_and_uses_turret( node ) )
    {
        return 1;
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 2
// Checksum 0x0, Offset: 0x4318
// Size: 0x1e
function function_b8caa11a38862f1c( node, optional_arrived_at_node_func )
{
    node_fields_after_goal( node, optional_arrived_at_node_func, 1 );
}

// Namespace spawner / scripts\sp\spawner
// Params 2
// Checksum 0x0, Offset: 0x433e
// Size: 0x189
function node_fields_after_goal_and_wait( node, var_5e38f20c9628ae25 )
{
    if ( isdefined( node.script_soundalias ) )
    {
        self playsound( node.script_soundalias );
    }
    
    if ( isdefined( node.script_gesture ) )
    {
        thread gesture_simple( node.script_gesture );
    }
    
    if ( isdefined( self.stealth ) )
    {
        stealth_call( "go_to_node_post_wait", &go_to_node_set_goal, node );
    }
    
    if ( isdefined( self.post_wait_func ) )
    {
        [[ self.post_wait_func ]]( node );
    }
    
    if ( isdefined( node.script_delay_post ) )
    {
        wait node.script_delay_post;
    }
    
    while ( isdefined( node.script_requires_player ) )
    {
        if ( go_to_node_wait_for_player( node, &get_target_goals ) )
        {
            node notify( "script_requires_player" );
            break;
        }
        
        wait 0.1;
    }
    
    if ( isdefined( node.script_demeanor_post ) )
    {
        if ( node.script_demeanor_post == "cqb" )
        {
            utility::enable_cqbwalk();
        }
        else
        {
            utility::demeanor_override( node.script_demeanor_post );
        }
    }
    
    if ( isdefined( var_5e38f20c9628ae25 ) )
    {
        [[ var_5e38f20c9628ae25 ]]( node );
    }
    
    if ( istrue( node.script_death ) )
    {
        die();
    }
    
    if ( istrue( node.script_delete ) )
    {
        if ( istrue( node.script_nosight ) )
        {
            level thread scripts\engine\sp\utility::ai_delete_when_out_of_sight( [ self ], 350 );
            return;
        }
        
        if ( isdefined( self.magic_bullet_shield ) )
        {
            stop_magic_bullet_shield();
        }
        
        self delete();
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x44cf
// Size: 0x4c
function go_to_node_end()
{
    self endon( "death" );
    waittillframeend();
    self.using_goto_node = 1;
    waittill_any_2( "reached_path_end", "stop_going_to_node" );
    self.using_goto_node = undefined;
    self.patharray = undefined;
    self.patharrayindex = undefined;
    thread function_480f99299b4cbc38();
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x4523
// Size: 0x8e
function function_480f99299b4cbc38()
{
    self endon( "death" );
    
    if ( isdefined( self.currentnode ) && isdefined( self.currentnode.interactionid ) && isdefined( self.currentnode.interaction ) )
    {
        if ( isdefined( self getinteractionid() ) )
        {
            self waittill( "bseq_user_deleted" );
        }
        
        despawninteraction( self.currentnode.interactionid );
        self.currentnode.interactionid = undefined;
    }
    
    self.currentnode = undefined;
}

// Namespace spawner / scripts\sp\spawner
// Params 2
// Checksum 0x0, Offset: 0x45b9
// Size: 0x1f4, Type: bool
function go_to_node_wait_for_player( node, get_target_func )
{
    if ( distancesquared( level.player.origin, node.origin ) < distancesquared( self.origin, node.origin ) )
    {
        return true;
    }
    
    if ( !isdefined( node.script_dist_only ) )
    {
        vec = anglestoforward( self.angles );
        
        if ( isdefined( node.target ) )
        {
            temp = [[ get_target_func ]]( node.target );
            
            if ( temp.size == 1 )
            {
                vec = vectornormalize( temp[ 0 ].origin - node.origin );
            }
            else if ( isdefined( node.angles ) )
            {
                vec = anglestoforward( node.angles );
            }
        }
        else if ( isdefined( node.angles ) )
        {
            vec = anglestoforward( node.angles );
        }
        
        vec2 = [];
        vec2[ vec2.size ] = vectornormalize( level.player.origin - self.origin );
        
        foreach ( value in vec2 )
        {
            if ( vectordot( vec, value ) > 0 )
            {
                return true;
            }
        }
    }
    
    dist = 32;
    
    if ( node.script_requires_player > dist )
    {
        dist = node.script_requires_player;
    }
    
    if ( distancesquared( level.player.origin, self.origin ) < squared( dist ) )
    {
        return true;
    }
    
    return false;
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x47b6
// Size: 0x144, Type: bool
function go_to_node_should_stop( arrivaltarget )
{
    if ( !isdefined( arrivaltarget ) )
    {
        return true;
    }
    
    if ( !isdefined( arrivaltarget.target ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_delay ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_delay_min ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_delay_max ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_wait ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_wait_add ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_wait_min ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_wait_max ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_flag_wait ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_flag_waitopen ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_ent_flag_wait ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_delay_post ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_requires_player ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_idle ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_stopnode ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.interaction ) || isdefined( arrivaltarget.interactionid ) )
    {
        return true;
    }
    
    return false;
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x4903
// Size: 0x6a
function go_to_node_set_goal( ent )
{
    if ( isnode( ent ) )
    {
        go_to_node_set_goal_node( ent );
    }
    else if ( isstruct( ent ) )
    {
        go_to_node_set_goal_pos( ent );
    }
    else if ( isent( ent ) )
    {
        go_to_node_set_goal_ent( ent );
    }
    
    if ( isstruct( ent ) || isnode( ent ) )
    {
        ent.patrol_stop = go_to_node_should_stop( ent );
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x4975
// Size: 0x3f
function go_to_node_set_goal_ent( ent )
{
    if ( ent.code_classname == "info_volume" )
    {
        self setgoalvolumeauto( ent, ent get_cover_volume_forward() );
        self notify( "go_to_node_new_goal" );
        return;
    }
    
    go_to_node_set_goal_pos( ent );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x49bc
// Size: 0x1b
function go_to_node_set_goal_pos( ent )
{
    set_goal_ent( ent );
    self notify( "go_to_node_new_goal" );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x49df
// Size: 0x1b
function go_to_node_set_goal_node( node )
{
    set_goal_node( node );
    self notify( "go_to_node_new_goal" );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x4a02
// Size: 0x76, Type: bool
function targets_and_uses_turret( node )
{
    if ( !isdefined( node.target ) )
    {
        return false;
    }
    
    turrets = getentarray( node.target, "targetname" );
    
    if ( !turrets.size )
    {
        return false;
    }
    
    turret = turrets[ 0 ];
    
    if ( !issubstr( turret.classname, "misc_turret" ) )
    {
        return false;
    }
    
    thread use_a_turret( turret );
    return true;
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x4a81
// Size: 0x36
function set_goal_height_from_settings()
{
    if ( isdefined( self.script_goalheight ) )
    {
        self.goalheight = self.script_goalheight;
        return;
    }
    
    self.goalheight = level.default_goalheight;
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x4abf
// Size: 0xb1
function set_goal_from_settings( node )
{
    if ( isdefined( self.script_radius ) )
    {
        self.goalradius = self.script_radius;
        return;
    }
    
    if ( isdefined( self.script_forcegoal ) )
    {
        if ( isdefined( node ) && isdefined( node.radius ) )
        {
            self.goalradius = node.radius;
            return;
        }
    }
    
    if ( !isdefined( self getgoalvolume() ) )
    {
        if ( self.unittype == "juggernaut" )
        {
            return;
        }
        
        if ( self.type == "civilian" )
        {
            self.goalradius = 128;
            return;
        }
        
        self.goalradius = level.default_goalradius;
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x4b78
// Size: 0x68
function autotarget( targets )
{
    for ( ;; )
    {
        user = self getturretowner();
        
        if ( !isalive( user ) )
        {
            wait 1.5;
            continue;
        }
        
        if ( !isdefined( user.enemy ) )
        {
            self settargetentity( random( targets ) );
            self notify( "startfiring" );
            self startfiring();
        }
        
        wait 2 + randomfloat( 1 );
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x4be8
// Size: 0x36
function manualtarget( targets )
{
    for ( ;; )
    {
        self settargetentity( random( targets ) );
        self notify( "startfiring" );
        self startfiring();
        wait 2 + randomfloat( 1 );
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x4c26
// Size: 0x198
function use_a_turret( turret )
{
    self endon( "stop_using_turret" );
    self endon( "death" );
    
    if ( self isbadguy() && self.health == 150 )
    {
        self.health = 100;
        self.allowlongdeath = 0;
    }
    
    scripts\asm\asm_bb::bb_requestturret( turret );
    
    while ( !isdefined( self getturret() ) || self getturret() != turret )
    {
        wait 0.05;
    }
    
    if ( isdefined( turret.target ) && turret.target != turret.targetname )
    {
        ents = getentarray( turret.target, "targetname" );
        targets = [];
        
        for ( i = 0; i < ents.size ; i++ )
        {
            if ( ents[ i ].classname == "script_origin" )
            {
                targets[ targets.size ] = ents[ i ];
            }
        }
        
        if ( isdefined( turret.script_autotarget ) )
        {
            turret thread autotarget( targets );
        }
        else if ( isdefined( turret.script_manualtarget ) )
        {
            turret setmode( "manual_ai" );
            turret thread manualtarget( targets );
        }
        else if ( targets.size > 0 )
        {
            if ( targets.size == 1 )
            {
                turret.manual_target = targets[ 0 ];
                turret settargetentity( targets[ 0 ] );
                thread scripts\sp\mgturret::manual_think( turret );
            }
            else
            {
                turret thread scripts\sp\mgturret::mg42_suppressionfire( targets );
            }
        }
    }
    
    thread player_use_turret_watcher( turret );
    thread scripts\sp\mgturret::mg42_firing( turret );
    turret notify( "startfiring" );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x4dc6
// Size: 0xaf
function player_use_turret_watcher( turret )
{
    self endon( "death" );
    
    if ( self.team != "allies" )
    {
        return;
    }
    
    trigger = spawn( "trigger_radius", turret.origin, 0, 56, 56 );
    thread delete_on_death( trigger );
    shouldbreak = 0;
    
    while ( !shouldbreak )
    {
        trigger waittill( "trigger" );
        
        while ( level.player istouching( trigger ) )
        {
            if ( level.player usebuttonpressed() )
            {
                shouldbreak = 1;
                break;
            }
            
            wait 0.05;
        }
    }
    
    trigger delete();
    stop_using_turret();
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x4e7d
// Size: 0x46
function stop_using_turret()
{
    self notify( "stop_using_turret" );
    self notify( "stop_using_built_in_burst_fire" );
    turret = self getturret();
    
    if ( !isdefined( turret ) )
    {
        return;
    }
    
    self stopuseturret();
    scripts\asm\asm_bb::bb_requestturret( undefined );
    self stopanimscripted();
    turret stopfiring();
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x4ecb
// Size: 0x16d
function friendly_mgturret( trigger )
{
    /#
        if ( !isdefined( trigger.target ) )
        {
            error( "<dev string:x1ab>" + trigger getorigin() );
        }
    #/
    
    node = getnode( trigger.target, "targetname" );
    
    /#
        if ( !isdefined( node.target ) )
        {
            error( "<dev string:x1d8>" + node.origin );
        }
    #/
    
    mg42 = getent( node.target, "targetname" );
    mg42 setmode( "auto_ai" );
    mg42 cleartargetentity();
    in_use = 0;
    
    while ( true )
    {
        trigger waittill( "trigger", other );
        
        if ( !isai( other ) )
        {
            continue;
        }
        
        if ( !isdefined( other.team ) )
        {
            continue;
        }
        
        if ( other.team != "allies" )
        {
            continue;
        }
        
        if ( isdefined( other.script_usemg42 ) && other.script_usemg42 == 0 )
        {
            continue;
        }
        
        if ( other thread friendly_mg42_useable( mg42, node ) )
        {
            other thread friendly_mg42_think( mg42, node );
            mg42 waittill( "friendly_finished_using_mg42" );
            
            if ( isalive( other ) )
            {
                other.turret_use_time = gettime() + 10000;
            }
        }
        
        wait 1;
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 2
// Checksum 0x0, Offset: 0x5040
// Size: 0x2a
function friendly_mg42_death_notify( guy, mg42 )
{
    mg42 endon( "friendly_finished_using_mg42" );
    guy waittill( "death" );
    mg42 notify( "friendly_finished_using_mg42" );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x5072
// Size: 0x6a
function friendly_mg42_wait_for_use( mg42 )
{
    mg42 endon( "friendly_finished_using_mg42" );
    self.useable = 1;
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( &"PLATFORM_USEAIONMG42" );
    self waittill( "trigger" );
    self.useable = 0;
    self sethintstring( "" );
    self stopuseturret();
    self notify( "stopped_use_turret" );
    mg42 notify( "friendly_finished_using_mg42" );
}

// Namespace spawner / scripts\sp\spawner
// Params 2
// Checksum 0x0, Offset: 0x50e4
// Size: 0x70, Type: bool
function friendly_mg42_useable( mg42, node )
{
    if ( self.useable )
    {
        return false;
    }
    
    if ( isdefined( self.turret_use_time ) && gettime() < self.turret_use_time )
    {
        return false;
    }
    
    if ( distance( level.player.origin, node.origin ) < 100 )
    {
        return false;
    }
    
    return true;
}

// Namespace spawner / scripts\sp\spawner
// Params 2
// Checksum 0x0, Offset: 0x515d
// Size: 0x2a
function friendly_mg42_endtrigger( mg42, guy )
{
    mg42 endon( "friendly_finished_using_mg42" );
    self waittill( "trigger" );
    mg42 notify( "friendly_finished_using_mg42" );
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x518f
// Size: 0x3e
function nofour()
{
    self endon( "death" );
    self waittill( "goal" );
    self.goalradius = self.oldradius;
    
    if ( self.goalradius < 32 )
    {
        self.goalradius = 400;
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 2
// Checksum 0x0, Offset: 0x51d5
// Size: 0x18a
function friendly_mg42_think( mg42, node )
{
    self endon( "death" );
    mg42 endon( "friendly_finished_using_mg42" );
    level thread friendly_mg42_death_notify( self, mg42 );
    self.oldradius = self.goalradius;
    self.goalradius = 28;
    thread nofour();
    self setgoalnode( node );
    self.ignoresuppression = 1;
    self waittill( "goal" );
    self.goalradius = self.oldradius;
    
    if ( self.goalradius < 32 )
    {
        self.goalradius = 400;
    }
    
    self.ignoresuppression = 0;
    self.goalradius = self.oldradius;
    
    if ( distance( level.player.origin, node.origin ) < 32 )
    {
        mg42 notify( "friendly_finished_using_mg42" );
        return;
    }
    
    self.friendly_mg42 = mg42;
    thread friendly_mg42_wait_for_use( mg42 );
    thread friendly_mg42_cleanup( mg42 );
    self useturret( mg42 );
    
    if ( isdefined( mg42.target ) )
    {
        stoptrigger = getent( mg42.target, "targetname" );
        
        if ( isdefined( stoptrigger ) )
        {
            stoptrigger thread friendly_mg42_endtrigger( mg42, self );
        }
    }
    
    while ( true )
    {
        if ( distance( self.origin, node.origin ) < 32 )
        {
            self useturret( mg42 );
        }
        else
        {
            break;
        }
        
        wait 1;
    }
    
    mg42 notify( "friendly_finished_using_mg42" );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x5367
// Size: 0x21
function friendly_mg42_cleanup( mg42 )
{
    self endon( "death" );
    mg42 waittill( "friendly_finished_using_mg42" );
    friendly_mg42_doneusingturret();
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x5390
// Size: 0xbe
function friendly_mg42_doneusingturret()
{
    self endon( "death" );
    turret = self.friendly_mg42;
    self.friendly_mg42 = undefined;
    self stopuseturret();
    self notify( "stopped_use_turret" );
    self.useable = 0;
    self.goalradius = self.oldradius;
    
    if ( !isdefined( turret ) )
    {
        return;
    }
    
    if ( !isdefined( turret.target ) )
    {
        return;
    }
    
    node = getnode( turret.target, "targetname" );
    oldradius = self.goalradius;
    self.goalradius = 8;
    self setgoalnode( node );
    wait 2;
    self.goalradius = 384;
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x54be
// Size: 0x62
function tanksquish()
{
    if ( isdefined( level.notanksquish ) )
    {
        assertex( level.notanksquish, "level.noTankSquish must be true or undefined" );
        return;
    }
    
    if ( isdefined( level.vehicle.has_vehicles ) && !level.vehicle.has_vehicles )
    {
        return;
    }
    
    add_damage_function( &tanksquish_damage_check );
}

// Namespace spawner / scripts\sp\spawner
// Params 10
// Checksum 0x0, Offset: 0x5528
// Size: 0xca
function tanksquish_damage_check( amt, who, force, point, type, modelname, tagname, partname, idflags, weapon )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isalive( self ) )
    {
        return;
    }
    
    if ( !isalive( who ) )
    {
        return;
    }
    
    if ( !isdefined( who.vehicletype ) )
    {
        return;
    }
    
    if ( who scripts\common\vehicle::ishelicopter() )
    {
        return;
    }
    
    if ( !isdefined( self.noragdoll ) )
    {
        if ( isdefined( self.fnpreragdoll ) )
        {
            self [[ self.fnpreragdoll ]]();
        }
        
        self startragdoll();
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    remove_damage_function( &tanksquish_damage_check );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x55fa
// Size: 0x18a
function flood_and_secure( instantrespawn )
{
    if ( !isdefined( instantrespawn ) )
    {
        instantrespawn = 0;
    }
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "instant_respawn" )
    {
        instantrespawn = 1;
    }
    
    level.spawnerwave = [];
    spawners = getspawnerarray( self.target );
    array_thread( spawners, &flood_and_secure_spawner, instantrespawn );
    playertriggered = 0;
    diddelay = 0;
    
    for ( ;; )
    {
        self waittill( "trigger", other );
        
        if ( !diddelay )
        {
            diddelay = 1;
            script_delay();
        }
        
        if ( self istouching( level.player ) )
        {
            playertriggered = 1;
        }
        else
        {
            if ( !isalive( other ) )
            {
                continue;
            }
            
            if ( isplayer( other ) )
            {
                playertriggered = 1;
            }
            else if ( !isdefined( other.issquad ) || !other.issquad )
            {
                continue;
            }
        }
        
        spawners = getspawnerarray( self.target );
        
        if ( isdefined( spawners[ 0 ] ) )
        {
            if ( isdefined( spawners[ 0 ].script_randomspawn ) )
            {
                cull_spawners_from_killspawner( spawners[ 0 ].script_randomspawn );
            }
        }
        
        spawners = getspawnerarray( self.target );
        
        for ( i = 0; i < spawners.size ; i++ )
        {
            spawners[ i ].playertriggered = playertriggered;
            spawners[ i ] notify( "flood_begin" );
        }
        
        if ( playertriggered )
        {
            wait 5;
            continue;
        }
        
        wait 0.1;
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x578c
// Size: 0x259
function flood_and_secure_spawner( instantrespawn )
{
    if ( isdefined( self.securestarted ) )
    {
        return;
    }
    
    self.securestarted = 1;
    self.triggerunlocked = 1;
    target = self.target;
    targetname = self.targetname;
    
    if ( !isdefined( target ) && !isdefined( self.script_moveoverride ) )
    {
        println( "<dev string:x20b>" + self.classname + "<dev string:x213>" + self.origin + "<dev string:x21f>" );
        waittillframeend();
        assert( isdefined( target ) );
    }
    
    spawners = [];
    
    if ( isdefined( target ) )
    {
        possiblespawners = getspawnerarray( target );
        
        for ( i = 0; i < possiblespawners.size ; i++ )
        {
            if ( !issubstr( possiblespawners[ i ].classname, "actor" ) )
            {
                continue;
            }
            
            spawners[ spawners.size ] = possiblespawners[ i ];
        }
    }
    
    ent = spawnstruct();
    org = self.origin;
    flood_and_secure_spawner_think( ent, spawners.size > 0, instantrespawn );
    
    if ( isalive( ent.ai ) )
    {
        ent.ai waittill( "death" );
    }
    
    if ( !isdefined( target ) )
    {
        return;
    }
    
    possiblespawners = getspawnerarray( target );
    
    if ( !possiblespawners.size )
    {
        return;
    }
    
    for ( i = 0; i < possiblespawners.size ; i++ )
    {
        if ( !issubstr( possiblespawners[ i ].classname, "actor" ) )
        {
            continue;
        }
        
        possiblespawners[ i ].targetname = targetname;
        newtarget = target;
        
        if ( isdefined( possiblespawners[ i ].target ) )
        {
            targetent = getspawner( possiblespawners[ i ].target, "targetname" );
            
            if ( !isdefined( targetent ) || !issubstr( targetent.classname, "actor" ) )
            {
                newtarget = possiblespawners[ i ].target;
            }
        }
        
        possiblespawners[ i ].target = newtarget;
        possiblespawners[ i ] thread flood_and_secure_spawner( instantrespawn );
        possiblespawners[ i ].playertriggered = 1;
        possiblespawners[ i ] notify( "flood_begin" );
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 3
// Checksum 0x0, Offset: 0x59ed
// Size: 0x21a
function flood_and_secure_spawner_think( ent, oneshot, instantrespawn )
{
    assert( isdefined( instantrespawn ) );
    self endon( "death" );
    count = self.count;
    
    if ( !oneshot )
    {
        oneshot = isdefined( self.script_noteworthy ) && self.script_noteworthy == "delete";
    }
    
    set_count( 2 );
    assertex( !isdefined( self.script_suspend ), "Flood and secure spawner does not support script_suspend" );
    
    if ( isdefined( self.script_delay ) )
    {
        delay = self.script_delay;
    }
    else
    {
        delay = 0;
    }
    
    for ( ;; )
    {
        self waittill( "flood_begin" );
        
        if ( self.playertriggered )
        {
            break;
        }
        
        if ( delay )
        {
            continue;
        }
        
        break;
    }
    
    dist = distance( level.player.origin, self.origin );
    
    while ( count )
    {
        self.truecount = count;
        set_count( 2 );
        wait delay;
        spawn = spawn_ai();
        
        if ( spawn_failed( spawn ) )
        {
            playerkill = 0;
            
            if ( delay < 2 )
            {
                wait 2;
            }
            
            continue;
        }
        else
        {
            thread addtowavespawner( spawn );
            spawn thread flood_and_secure_spawn( self );
            
            if ( isdefined( self.script_accuracy ) )
            {
                spawn.baseaccuracy = self.script_accuracy;
            }
            
            ent.ai = spawn;
            ent notify( "got_ai" );
            self waittill( "spawn_died", deleted, playerkill );
            
            if ( delay > 2 )
            {
                delay = randomint( 4 ) + 2;
            }
            else
            {
                delay = 0.5 + randomfloat( 0.5 );
            }
        }
        
        if ( deleted )
        {
            waittillrestartordistance( dist );
            continue;
        }
        
        if ( playerwasnearby( playerkill || oneshot, ent.ai ) )
        {
            count--;
        }
        
        if ( !instantrespawn )
        {
            waituntilwaverelease();
        }
    }
    
    self delete();
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x5c0f
// Size: 0x1a
function waittilldeletedordeath( spawn )
{
    self endon( "death" );
    spawn waittill( "death" );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x5c31
// Size: 0x144
function addtowavespawner( spawn )
{
    name = self.targetname;
    
    if ( !isdefined( level.spawnerwave[ name ] ) )
    {
        level.spawnerwave[ name ] = spawnstruct();
        level.spawnerwave[ name ] set_count( 0 );
        level.spawnerwave[ name ].total = 0;
    }
    
    if ( !isdefined( self.addedtowave ) )
    {
        self.addedtowave = 1;
        level.spawnerwave[ name ].total++;
    }
    
    level.spawnerwave[ name ].count++;
    waittilldeletedordeath( spawn );
    level.spawnerwave[ name ].count--;
    
    if ( !isdefined( self ) )
    {
        level.spawnerwave[ name ].total--;
    }
    
    if ( level.spawnerwave[ name ].total )
    {
        if ( level.spawnerwave[ name ].count / level.spawnerwave[ name ].total < 0.32 )
        {
            level.spawnerwave[ name ] notify( "waveReady" );
        }
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x5d7d
// Size: 0x40
function waituntilwaverelease()
{
    name = self.targetname;
    
    if ( level.spawnerwave[ name ].count )
    {
        level.spawnerwave[ name ] waittill( "waveReady" );
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 2
// Checksum 0x0, Offset: 0x5dc5
// Size: 0x92
function playerwasnearby( playerkill, ai )
{
    if ( playerkill )
    {
        return 1;
    }
    
    if ( isdefined( ai ) && isdefined( ai.origin ) )
    {
        org = ai.origin;
    }
    else
    {
        org = self.origin;
    }
    
    if ( distance( level.player.origin, org ) < 700 )
    {
        return 1;
    }
    
    return scripts\engine\trace::_bullet_trace_passed( level.player geteye(), ai geteye(), 0, undefined );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x5e60
// Size: 0x47
function waittillrestartordistance( dist )
{
    self endon( "flood_begin" );
    dist *= 0.75;
    
    while ( distance( level.player.origin, self.origin ) > dist )
    {
        wait 1;
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x5eaf
// Size: 0x7d
function flood_and_secure_spawn( spawner )
{
    thread flood_and_secure_spawn_goal();
    self waittill( "death", other );
    playerkill = isalive( other ) && isplayer( other );
    
    if ( !playerkill && isdefined( other ) && other.classname == "worldspawn" )
    {
        playerkill = 1;
    }
    
    deleted = !isdefined( self );
    spawner notify( "spawn_died", deleted, playerkill );
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x5f34
// Size: 0x280
function flood_and_secure_spawn_goal()
{
    if ( isdefined( self.script_moveoverride ) )
    {
        return;
    }
    
    self endon( "death" );
    node = getnode( self.target, "targetname" );
    
    if ( isdefined( node ) )
    {
        self setgoalnode( node );
    }
    else
    {
        node = getent( self.target, "targetname" );
        
        if ( isdefined( node ) )
        {
            self setgoalpos( node.origin );
        }
    }
    
    assertex( isdefined( node ), "flood_and_secure_spawn_goal behavior requires a valid node or origin to be specified as the target." );
    
    if ( isdefined( level.fightdist ) )
    {
        self.pathenemyfightdist = level.fightdist;
        self.pathenemylookahead = level.maxdist;
    }
    
    if ( isdefined( node.radius ) && node.radius >= 0 )
    {
        self.goalradius = node.radius;
    }
    else
    {
        self.goalradius = 256;
    }
    
    self waittill( "goal" );
    
    while ( isdefined( node.target ) )
    {
        newnode = getnode( node.target, "targetname" );
        
        if ( isdefined( newnode ) )
        {
            node = newnode;
        }
        else
        {
            break;
        }
        
        self setgoalnode( node );
        
        if ( node_has_radius( node ) )
        {
            self.goalradius = node.radius;
        }
        else
        {
            self.goalradius = 256;
        }
        
        self waittill( "goal" );
    }
    
    if ( isdefined( self.script_noteworthy ) )
    {
        if ( self.script_noteworthy == "delete" )
        {
            self kill();
            return;
        }
    }
    
    if ( isdefined( node.target ) )
    {
        turret = getent( node.target, "targetname" );
        
        if ( isdefined( turret ) && turret.code_classname == "misc_turret" )
        {
            self setgoalnode( node );
            self.goalradius = 4;
            self waittill( "goal" );
            
            if ( !isdefined( self.script_forcegoal ) )
            {
                self.goalradius = level.default_goalradius;
            }
            
            use_a_turret( turret );
        }
    }
    
    if ( isdefined( self.script_noteworthy ) )
    {
        if ( self.script_noteworthy == "hide" )
        {
            thread utility::set_battlechatter( 0 );
            return;
        }
    }
    
    if ( !isdefined( self.script_forcegoal ) && !isdefined( self getgoalvolume() ) )
    {
        self.goalradius = level.default_goalradius;
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x61bc
// Size: 0xf2
function goalvolumes()
{
    volumes = getentarray( "info_volume", "classname" );
    volumes = array_combine( volumes, getentarray( "info_volume_color", "classname" ) );
    level.deathchain_goalvolume = [];
    level.goalvolumes = [];
    
    for ( i = 0; i < volumes.size ; i++ )
    {
        volume = volumes[ i ];
        
        if ( isdefined( volume.script_deathchain ) )
        {
            level.deathchain_goalvolume[ volume.script_deathchain ] = volume;
        }
        
        if ( isdefined( volume.script_goalvolume ) )
        {
            assertex( !isdefined( level.goalvolumes[ volume.script_goalvolume ] ), "Tried to overwrite goalvolume with script_goalvolume " + volume.script_goalvolume + ". Maybe you are using the same script_goalvolume value in a prefab? Script_goalvolume is not autocast in prefabs." );
            level.goalvolumes[ volume.script_goalvolume ] = volume;
        }
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x62b6
// Size: 0x8f
function aigroup_create( aigroup )
{
    level._ai_group[ aigroup ] = spawnstruct();
    level._ai_group[ aigroup ].aicount = 0;
    level._ai_group[ aigroup ].aideaths = 0;
    level._ai_group[ aigroup ].spawnercount = 0;
    level._ai_group[ aigroup ].ai = [];
    level._ai_group[ aigroup ].spawners = [];
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x634d
// Size: 0x8e
function aigroup_spawnerthink( tracker )
{
    self endon( "death" );
    self endon( "stop_aigroup_spawnerthink" );
    self.decremented = 0;
    tracker.spawnercount++;
    tracker.spawners = array_add( tracker.spawners, self );
    thread aigroup_spawnerdeath( tracker );
    thread aigroup_spawnerempty( tracker );
    self waittill( "spawned", soldier );
    
    if ( !spawn_failed( soldier ) )
    {
        soldier thread aigroup_soldierthink( tracker );
    }
    
    aigroup_decrement( tracker );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x63e3
// Size: 0x37
function aigroup_decrement( tracker )
{
    if ( self.decremented )
    {
        return;
    }
    
    self.decremented = 1;
    tracker.spawnercount--;
    self notify( "stop_aigroup_spawnerthink" );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x6422
// Size: 0x20
function aigroup_spawnerdeath( tracker )
{
    self waittill( "death" );
    
    if ( isdefined( self ) )
    {
        aigroup_decrement( tracker );
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x644a
// Size: 0x22
function aigroup_spawnerempty( tracker )
{
    self endon( "death" );
    self waittill( "emptied spawner" );
    aigroup_decrement( tracker );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x6474
// Size: 0x68
function aigroup_soldierthink( tracker )
{
    tracker.aicount++;
    tracker.ai[ tracker.ai.size ] = self;
    
    if ( isdefined( self.script_deathflag_longdeath ) )
    {
        ai::function_d3262c3e00795e21();
    }
    else
    {
        self waittill( "death" );
    }
    
    tracker.aicount--;
    tracker.aideaths++;
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x64e4
// Size: 0x22b
function camper_trigger_think( trigger )
{
    tokens = strtok( trigger.script_linkto, " " );
    spawners = [];
    nodes = [];
    
    for ( i = 0; i < tokens.size ; i++ )
    {
        token = tokens[ i ];
        ai = getspawner( token, "script_linkname" );
        
        if ( isdefined( ai ) )
        {
            spawners = array_add_safe( spawners, ai );
            continue;
        }
        
        node = getnode( token, "script_linkname" );
        
        if ( !isdefined( node ) )
        {
            println( "<dev string:x22e>" + token + "<dev string:x24d>" );
            continue;
        }
        
        nodes = array_add_safe( nodes, node );
    }
    
    assertex( spawners.size, "camper_spawner without any spawners associated" );
    assertex( nodes.size, "camper_spawner without any nodes associated" );
    assertex( nodes.size >= spawners.size, "camper_spawner with less nodes than spawners" );
    trigger waittill( "trigger" );
    nodes = array_randomize( nodes );
    
    for ( i = 0; i < nodes.size ; i++ )
    {
        nodes[ i ].claimed = 0;
    }
    
    j = 0;
    
    for ( i = 0; i < spawners.size ; i++ )
    {
        spawner = spawners[ i ];
        
        if ( !isdefined( spawner ) )
        {
            continue;
        }
        
        if ( isdefined( spawner.script_spawn_here ) )
        {
            continue;
        }
        
        while ( isdefined( nodes[ j ].script_noteworthy ) && nodes[ j ].script_noteworthy == "dont_spawn" )
        {
            j++;
        }
        
        spawner.origin = nodes[ j ].origin;
        spawner.angles = nodes[ j ].angles;
        spawner add_spawn_function( &claim_a_node, nodes[ j ] );
        j++;
    }
    
    array_thread( spawners, &add_spawn_function, &camper_guy );
    array_thread( spawners, &add_spawn_function, &move_when_enemy_hides, nodes );
    array_thread( spawners, &spawn_ai );
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x6717
// Size: 0x18
function camper_guy()
{
    self.goalradius = 8;
    self.fixednode = 1;
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x6737
// Size: 0x131
function move_when_enemy_hides( nodes )
{
    self endon( "death" );
    var_8feb02c67161a30d = 0;
    
    while ( true )
    {
        if ( !isalive( self.enemy ) )
        {
            self waittill( "enemy" );
            var_8feb02c67161a30d = 0;
            continue;
        }
        
        if ( isplayer( self.enemy ) )
        {
            if ( self.enemy scripts\sp\player::belowcriticalhealththreshold() || self.enemy isflashed() )
            {
                self.fixednode = 0;
                
                for ( ;; )
                {
                    self.goalradius = 180;
                    self setgoalpos( level.player.origin );
                    wait 1;
                }
                
                return;
            }
        }
        
        if ( var_8feb02c67161a30d )
        {
            if ( self cansee( self.enemy ) )
            {
                wait 0.05;
                continue;
            }
            
            var_8feb02c67161a30d = 0;
        }
        else
        {
            if ( self cansee( self.enemy ) )
            {
                var_8feb02c67161a30d = 1;
            }
            
            wait 0.05;
            continue;
        }
        
        if ( randomint( 3 ) > 0 )
        {
            node = find_unclaimed_node( nodes );
            
            if ( isdefined( node ) )
            {
                claim_a_node( node, self.claimed_node );
                self waittill( "goal" );
            }
        }
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 2
// Checksum 0x0, Offset: 0x6870
// Size: 0x45
function claim_a_node( claimed_node, var_5398a02809086d75 )
{
    self setgoalnode( claimed_node );
    self.claimed_node = claimed_node;
    claimed_node.claimed = 1;
    
    if ( isdefined( var_5398a02809086d75 ) )
    {
        var_5398a02809086d75.claimed = 0;
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x68bd
// Size: 0x3f
function find_unclaimed_node( nodes )
{
    for ( i = 0; i < nodes.size ; i++ )
    {
        if ( nodes[ i ].claimed )
        {
            continue;
        }
        
        return nodes[ i ];
    }
    
    return undefined;
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x6905
// Size: 0xa9
function flood_trigger_think( trigger )
{
    assertex( isdefined( trigger.target ), "flood_spawner at " + trigger.origin + " without target" );
    floodspawners = getspawnerarray( trigger.target );
    assertex( floodspawners.size, "flood_spawner at with target " + trigger.target + " without any targets" );
    array_thread( floodspawners, &flood_spawner_init );
    trigger waittill( "trigger" );
    floodspawners = getspawnerarray( trigger.target );
    array_thread( floodspawners, &flood_spawner_think, trigger );
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x69b6
// Size: 0x26
function flood_spawner_init()
{
    assertex( isspawner( self ), "Spawner at origin " + self.origin + " is not a spawner!" );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x69e4
// Size: 0x1e, Type: bool
function trigger_requires_player( trigger )
{
    if ( !isdefined( trigger ) )
    {
        return false;
    }
    
    return isdefined( trigger.script_requires_player );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x6a0b
// Size: 0xf4
function flood_spawner_think( trigger )
{
    if ( isspawner( self ) )
    {
        self endon( "death" );
    }
    
    self notify( "stop current floodspawner" );
    self endon( "stop current floodspawner" );
    
    if ( is_pyramid_spawner() )
    {
        pyramid_spawn( trigger );
        return;
    }
    
    requires_player = trigger_requires_player( trigger );
    script_delay();
    
    while ( self.count > 0 )
    {
        while ( requires_player && !level.player istouching( trigger ) )
        {
            wait 0.5;
        }
        
        soldier = spawn_ai();
        
        if ( spawn_failed( soldier ) )
        {
            wait 2;
            continue;
        }
        
        soldier thread reincrement_count_if_deleted( self );
        soldier waittill( "death", attacker );
        
        if ( !player_saw_kill( soldier, attacker ) )
        {
            self.count++;
        }
        
        if ( !isdefined( soldier ) )
        {
            continue;
        }
        
        if ( !script_wait() )
        {
            wait randomfloatrange( 5, 9 );
        }
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 2
// Checksum 0x0, Offset: 0x6b07
// Size: 0x109
function player_saw_kill( guy, attacker )
{
    if ( isdefined( self.script_force_count ) )
    {
        if ( self.script_force_count )
        {
            return 1;
        }
    }
    
    if ( !isdefined( guy ) )
    {
        return 0;
    }
    
    if ( isalive( attacker ) )
    {
        if ( isplayer( attacker ) )
        {
            return 1;
        }
        
        if ( distance( attacker.origin, level.player.origin ) < 200 )
        {
            return 1;
        }
    }
    else if ( isdefined( attacker ) )
    {
        if ( attacker.classname == "worldspawn" )
        {
            return 0;
        }
        
        if ( distance( attacker.origin, level.player.origin ) < 200 )
        {
            return 1;
        }
    }
    
    if ( distance( guy.origin, level.player.origin ) < 200 )
    {
        return 1;
    }
    
    return scripts\engine\trace::_bullet_trace_passed( level.player geteye(), guy geteye(), 0, undefined );
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x6c19
// Size: 0x48
function is_pyramid_spawner()
{
    if ( !isdefined( self.target ) )
    {
        return 0;
    }
    
    ent = getspawnerarray( self.target );
    
    if ( !ent.size )
    {
        return 0;
    }
    
    return issubstr( ent[ 0 ].classname, "actor" );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x6c6a
// Size: 0x25
function pyramid_death_report( spawner )
{
    spawner.spawn waittill( "death" );
    self notify( "death_report" );
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x6c97
// Size: 0x30f
function pyramid_spawn( trigger )
{
    self endon( "death" );
    requires_player = trigger_requires_player( trigger );
    script_delay();
    
    if ( requires_player )
    {
        while ( !level.player istouching( trigger ) )
        {
            wait 0.5;
        }
    }
    
    spawners = getspawnerarray( self.target );
    
    /#
        for ( i = 0; i < spawners.size ; i++ )
        {
            assertex( issubstr( spawners[ i ].classname, "<dev string:x25d>" ), "<dev string:x263>" );
        }
    #/
    
    self.spawners = 0;
    array_thread( spawners, &pyramid_spawner_reports_death, self );
    offset = randomint( spawners.size );
    
    for ( i = 0; i < spawners.size ; i++ )
    {
        if ( self.count <= 0 )
        {
            return;
        }
        
        offset++;
        
        if ( offset >= spawners.size )
        {
            offset = 0;
        }
        
        spawner = spawners[ offset ];
        spawner set_count( 1 );
        soldier = spawner spawn_ai();
        
        if ( spawn_failed( soldier ) )
        {
            wait 2;
            continue;
        }
        
        self.count--;
        spawner.spawn = soldier;
        soldier thread reincrement_count_if_deleted( self );
        soldier thread expand_goalradius( trigger );
        thread pyramid_death_report( spawner );
    }
    
    var_aaf538144199da10 = 0.01;
    
    while ( self.count > 0 )
    {
        self waittill( "death_report" );
        issuspended = 0;
        
        foreach ( spawner in spawners )
        {
            spawner.postspawnresetorigin = 1;
            
            if ( isdefined( spawner.suspended_ai ) )
            {
                issuspended = 1;
            }
        }
        
        if ( issuspended )
        {
            trigger waittill( "trigger" );
        }
        
        script_wait();
        offset = randomint( spawners.size );
        
        for ( i = 0; i < spawners.size ; i++ )
        {
            spawners = array_removeundefined( spawners );
            
            if ( !spawners.size )
            {
                if ( isdefined( self ) )
                {
                    self delete();
                }
                
                return;
            }
            
            offset++;
            
            if ( offset >= spawners.size )
            {
                offset = 0;
            }
            
            spawner = spawners[ offset ];
            
            if ( isalive( spawner.spawn ) )
            {
                continue;
            }
            
            if ( isdefined( spawner.target ) )
            {
                self.target = spawner.target;
            }
            else
            {
                self.target = undefined;
            }
            
            soldier = spawn_ai();
            
            if ( spawn_failed( soldier ) )
            {
                wait 2;
                continue;
            }
            
            assertex( isdefined( spawner ), "Theoretically impossible." );
            soldier thread reincrement_count_if_deleted( self );
            soldier thread expand_goalradius( trigger );
            spawner.spawn = soldier;
            thread pyramid_death_report( spawner );
            
            if ( self.count <= 0 )
            {
                return;
            }
        }
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x6fae
// Size: 0x47
function pyramid_spawner_reports_death( parent )
{
    parent endon( "death" );
    parent.spawners++;
    self waittill( "death" );
    parent.spawners--;
    
    if ( !parent.spawners )
    {
        parent delete();
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x6ffd
// Size: 0x87
function expand_goalradius( trigger )
{
    if ( isdefined( self.script_forcegoal ) )
    {
        return;
    }
    
    radius = level.default_goalradius;
    
    if ( isdefined( trigger ) )
    {
        if ( isdefined( trigger.script_radius ) )
        {
            if ( trigger.script_radius == -1 )
            {
                return;
            }
            
            radius = trigger.script_radius;
        }
    }
    
    if ( isdefined( self.script_forcegoal ) )
    {
        return;
    }
    
    self endon( "death" );
    self waittill( "goal" );
    self.goalradius = radius;
}

/#

    // Namespace spawner / scripts\sp\spawner
    // Params 0
    // Checksum 0x0, Offset: 0x708c
    // Size: 0xe3, Type: dev
    function show_bad_path()
    {
        if ( !isdefined( level.debug_badpath ) || !level.debug_badpath )
        {
            return;
        }
        
        setdvarifuninitialized( @"hash_5ae66c3bb0c9dbba", "<dev string:x283>" );
        self endon( "<dev string:x286>" );
        var_b3bffc9a15155a83 = -5000;
        serverduration = 200;
        var_29d65c2e0b18c7f6 = 0;
        
        for ( ;; )
        {
            self waittill( "<dev string:x28c>", badpathpos );
            
            if ( gettime() - var_b3bffc9a15155a83 > 5000 )
            {
                var_29d65c2e0b18c7f6 = 0;
            }
            else
            {
                var_29d65c2e0b18c7f6++;
            }
            
            var_b3bffc9a15155a83 = gettime();
            
            if ( var_29d65c2e0b18c7f6 < getdvarint( @"hash_5ae66c3bb0c9dbba" ) )
            {
                continue;
            }
            
            for ( i = 0; i < serverduration ; i++ )
            {
                line( self.origin, badpathpos, ( 1, 0.4, 0.1 ) );
                waitframe();
            }
        }
    }

#/

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x7177
// Size: 0xc9
function random_spawn( trigger )
{
    trigger waittill( "trigger" );
    spawners = getspawnerarray( trigger.target );
    
    if ( !spawners.size )
    {
        return;
    }
    
    spawner = random( spawners );
    spawners = [];
    spawners[ spawners.size ] = spawner;
    
    if ( isdefined( spawner.script_linkto ) )
    {
        links = strtok( spawner.script_linkto, " " );
        
        for ( i = 0; i < links.size ; i++ )
        {
            spawners[ spawners.size ] = getspawner( links[ i ], "script_linkname" );
        }
    }
    
    waittillframeend();
    array_thread( spawners, &add_spawn_function, &blowout_goalradius_on_pathend );
    array_thread( spawners, &spawn_ai );
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x7248
// Size: 0x3b
function blowout_goalradius_on_pathend()
{
    if ( isdefined( self.script_forcegoal ) )
    {
        return;
    }
    
    self endon( "death" );
    self waittill( "reached_path_end" );
    
    if ( !isdefined( self getgoalvolume() ) )
    {
        self.goalradius = level.default_goalradius;
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x728b
// Size: 0x1e7
function function_7a2464dfda234e36()
{
    drone = self;
    
    if ( !isundefinedweapon( drone.weapon ) )
    {
        defaults = getweapondefaultattachments( drone.weapon.basename );
        weaponattached = 0;
        
        if ( defaults.size == 0 )
        {
            weapon_model = getweaponmodel( drone.weapon );
            
            if ( modelhastag( weapon_model, "tag_flash" ) )
            {
                drone attach( weapon_model, "tag_weapon_right" );
                hidetaglist = getweaponhidetags( drone.weapon );
                
                for ( i = 0; i < hidetaglist.size ; i++ )
                {
                    tag = hidetaglist[ i ];
                    
                    if ( hastag( weapon_model, tag ) )
                    {
                        drone hidepart( tag, weapon_model );
                    }
                }
                
                weaponattached = 1;
            }
        }
        
        if ( !weaponattached )
        {
            if ( !istrue( drone.usescriptedweapon ) )
            {
                defaults_pruned = utility::removeconflictingattachments( drone.weapon.attachments, defaults, drone.weapon.basename );
                drone.weapon = drone.weapon withoutattachments();
                drone.weapon = drone.weapon withattachments( array_combine( defaults_pruned, drone.weapon.attachments ) );
            }
            
            drone gun_create_fake( getweaponattachmentworldmodels( drone.weapon ) );
            
            if ( !istrue( self.nodrop ) )
            {
                drone.weapon_object = drone.weapon;
            }
            
            drone.weapon = nullweapon();
        }
    }
    
    drone enable_procedural_bones();
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x747a
// Size: 0x7f
function spawner_dronespawn( spawner )
{
    drone = spawner scripts\sp\fakeactor::spawndrone();
    drone function_7a2464dfda234e36();
    drone.spawner = spawner;
    drone.drone_delete_on_unload = isdefined( spawner.script_noteworthy ) && spawner.script_noteworthy == "drone_delete_on_unload";
    drone.finished_spawning = 1;
    drone notify( "finished spawning" );
    spawner notify( "drone_spawned", drone );
    return drone;
}

// Namespace spawner / scripts\sp\spawner
// Params 2
// Checksum 0x0, Offset: 0x7502
// Size: 0x2a4
function spawner_makerealai( drone, target_override )
{
    if ( !isdefined( drone.spawner ) )
    {
        /#
            println( "<dev string:x295>" );
            println( "<dev string:x2c0>" + drone.classname );
            println( "<dev string:x2d2>" + drone.origin );
        #/
        
        assertmsg( "makerealai called on drone does with no .spawner" );
    }
    
    orgorg = drone.spawner.origin;
    organg = drone.spawner.angles;
    orgtarg = drone.spawner.target;
    drone.spawner.origin = drone.origin;
    drone.spawner.angles = drone.angles;
    
    if ( isdefined( target_override ) )
    {
        drone.spawner.target = target_override;
    }
    
    drone.spawner.count += 1;
    guy = drone.spawner stalingradspawn();
    failed = spawn_failed( guy );
    
    if ( failed )
    {
        /#
            println( "<dev string:x295>" );
            println( "<dev string:x2e4>" + drone.origin );
            println( "<dev string:x302>" + drone.spawner.export );
            println( "<dev string:x323>" + getaiarray().size );
            println( "<dev string:x338>" );
        #/
        
        assertmsg( "failed to make real ai out of drone( see console for more info )" );
    }
    
    guy.vehicle_idling = drone.vehicle_idling;
    guy.vehicle_position = drone.vehicle_position;
    guy.standing = drone.standing;
    guy.forcecolor = drone.forcecolor;
    drone.spawner.origin = orgorg;
    drone.spawner.angles = organg;
    drone.spawner.target = orgtarg;
    drone delete();
    return guy;
}

// Namespace spawner / scripts\sp\spawner
// Params 2
// Checksum 0x0, Offset: 0x77af
// Size: 0x293
function spawner_makefakeactor( ai, target_override )
{
    if ( !isdefined( ai.spawner ) )
    {
        /#
            println( "<dev string:x295>" );
            println( "<dev string:x370>" + ai.classname );
            println( "<dev string:x37f>" + ai.origin );
        #/
        
        assertmsg( "makerealai called on drone does with no .spawner" );
    }
    
    orgorg = ai.spawner.origin;
    organg = ai.spawner.angles;
    orgtarg = ai.spawner.target;
    ai.spawner.origin = ai.origin;
    ai.spawner.angles = ai.angles;
    
    if ( isdefined( target_override ) )
    {
        ai.spawner.target = target_override;
    }
    
    ai.spawner.count += 1;
    guy = fakeactorspawn( ai.spawner );
    failed = spawn_failed( guy );
    
    if ( failed )
    {
        /#
            println( "<dev string:x38e>" );
            println( "<dev string:x2e4>" + ai.origin );
            println( "<dev string:x302>" + ai.spawner.export );
            println( "<dev string:x338>" );
        #/
        
        assertmsg( "failed to make fakeactor out of ai( see console for more info )" );
    }
    
    guy.vehicle_idling = ai.vehicle_idling;
    guy.vehicle_position = ai.vehicle_position;
    guy.standing = ai.standing;
    guy.forcecolor = ai.forcecolor;
    ai.spawner.origin = orgorg;
    ai.spawner.angles = organg;
    ai.spawner.target = orgtarg;
    ai delete();
    return guy;
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x7a4b
// Size: 0xbe
function add_random_killspawner_to_spawngroup()
{
    assertex( isdefined( self.script_randomspawn ), "Spawner at origin " + self.origin + " has no script_randomspawn!" );
    spawngroup = self.script_random_killspawner;
    subgroup = self.script_randomspawn;
    
    if ( !isdefined( level.killspawn_groups ) )
    {
        level.killspawn_groups = [];
    }
    
    if ( !isdefined( level.killspawn_groups[ spawngroup ] ) )
    {
        level.killspawn_groups[ spawngroup ] = [];
    }
    
    if ( !isdefined( level.killspawn_groups[ spawngroup ][ subgroup ] ) )
    {
        level.killspawn_groups[ spawngroup ][ subgroup ] = [];
    }
    
    level.killspawn_groups[ spawngroup ][ subgroup ][ self.export ] = self;
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x7b11
// Size: 0xa7
function add_to_spawngroup()
{
    assertex( isdefined( self.script_spawnsubgroup ), "Spawner at origin " + self.origin + " has no script_spawnsubgroup!" );
    spawngroup = self.script_spawngroup;
    subgroup = self.script_spawnsubgroup;
    
    if ( !isdefined( level.spawn_groups[ spawngroup ] ) )
    {
        level.spawn_groups[ spawngroup ] = [];
    }
    
    if ( !isdefined( level.spawn_groups[ spawngroup ][ subgroup ] ) )
    {
        level.spawn_groups[ spawngroup ][ subgroup ] = [];
    }
    
    level.spawn_groups[ spawngroup ][ subgroup ][ self.export ] = self;
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x7bc0
// Size: 0xb0
function tracker_bullet_hit( point )
{
    self notify( "tracker_bullet_hit" );
    self endon( "tracker_bullet_hit" );
    
    if ( self.team != "axis" )
    {
        return;
    }
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    hudoutline_enable_new( "outlinefill_nodepth_red", "tracker" );
    waittill_notify_or_timeout( "death", 5 );
    hudoutline_disable( "tracker" );
    
    if ( isalive( self ) )
    {
        for ( i = 0; i < 3 ; i++ )
        {
            wait 0.2;
            hudoutline_enable_new( "outlinefill_nodepth_red", "tracker" );
            wait 0.15;
            hudoutline_disable( "tracker" );
        }
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x7c78
// Size: 0x109
function prespawn_suspended_ai()
{
    if ( !isdefined( self.script_suspend ) )
    {
        return undefined;
    }
    
    if ( !isdefined( self.suspended_ai ) )
    {
        return 0;
    }
    
    self.count++;
    
    if ( !isdefined( self.og_spawner_origin ) )
    {
        self.og_spawner_origin = self.origin;
    }
    
    if ( !isdefined( self.og_spawner_angles ) )
    {
        self.og_spawner_angles = self.angles;
    }
    
    if ( isdefined( self.try_og_origin ) )
    {
        self.origin = self.og_spawner_origin;
        self.angles = self.og_spawner_angles;
    }
    else
    {
        self.origin = self.suspended_ai.origin;
        self.angles = self.suspended_ai.angles;
    }
    
    if ( isdefined( self.suspended_ai.suspendvars ) )
    {
        self.suspendvars = self.suspended_ai.suspendvars;
    }
    
    return 1;
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x7d8a
// Size: 0xb1
function postspawn_suspended_ai()
{
    suspendstruct = self.spawner.suspended_ai;
    
    if ( isdefined( self.spawner.postspawnresetorigin ) )
    {
        self.spawner.origin = self.og_spawner_origin;
        self.spawner.angles = self.og_spawner_angles;
    }
    
    thread postspawn_suspend_ai_framedelay( suspendstruct );
    
    if ( !isdefined( suspendstruct.suspendvars ) )
    {
        return;
    }
    
    self.suspendvars = suspendstruct.suspendvars;
    self.spawner.suspended_ai = undefined;
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x7e43
// Size: 0x101
function postspawn_suspend_ai_framedelay( suspendstruct )
{
    waittillframeend();
    waittillframeend();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( suspendstruct.stealth ) )
    {
        assertex( self.team == "axis", "postspawn_suspended_ai() currently does not support non AXIS AI" );
        bsmstate = suspendstruct.stealthbsmstate;
        
        if ( bsmstate > 1 )
        {
            bsmstate = suspendstruct.stealthbsmstate - int( ( gettime() - suspendstruct.suspendtime ) / 10000 );
            bsmstate = int( max( 2, bsmstate ) );
        }
        else if ( bsmstate > 0 )
        {
            bsmstate = suspendstruct.stealthbsmstate - int( ( gettime() - suspendstruct.suspendtime ) / 5000 );
            bsmstate = int( max( 0, bsmstate ) );
        }
        
        state = int_to_stealth_state( bsmstate );
        scripts\stealth\enemy::bt_set_stealth_state( state, suspendstruct.stealth.investigateevent );
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x7f4c
// Size: 0x5c
function int_to_stealth_state( num )
{
    switch ( num )
    {
        case 0:
            return "idle";
        case 1:
            return "investigate";
        case 2:
            return "hunt";
        case 3:
            return "combat";
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 1
// Checksum 0x0, Offset: 0x7fb0
// Size: 0x1ec
function trigger_zone_spawn( trigger )
{
    trigger endon( "death" );
    assertex( !( trigger.spawnflags & 32 ), "Trigger at " + trigger.origin + " cannot use spawnflags TRIGGER_SPAWN." );
    assertex( isdefined( trigger.target ), "Trigger at " + trigger.origin + " must target at least one spawner." );
    script_suspend = undefined;
    
    if ( isdefined( trigger.script_suspend ) )
    {
        script_suspend = trigger.script_suspend;
    }
    
    script_suspend_group = undefined;
    
    if ( isdefined( trigger.script_suspend_group ) )
    {
        script_suspend_group = trigger.script_suspend_group;
    }
    
    spawners = getspawnerarray( trigger.target );
    
    foreach ( spawner in spawners )
    {
        if ( !isdefined( spawner.script_suspend ) )
        {
            spawner.script_suspend = script_suspend;
        }
        
        if ( !isdefined( spawner.script_suspend_group ) )
        {
            spawner.script_suspend_group = script_suspend_group;
        }
    }
    
    while ( true )
    {
        trigger waittill( "trigger", other );
        trigger script_delay();
        spawners = getspawnerarray( trigger.target );
        
        foreach ( spawner in spawners )
        {
            spawner thread spawn_ai();
        }
        
        while ( isalive( other ) && other istouching( trigger ) )
        {
            wait 0.1;
        }
    }
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x81a4
// Size: 0x96
function spawn_subclass_juggernaut()
{
    if ( !isdefined( level.juggernaut_initialized ) )
    {
        level.juggernaut_initialized = 1;
        level.juggernaut_next_alert_time = 0;
    }
    
    disable_turnanims();
    disable_surprise();
    
    if ( isdefined( level.var_bf8aa3f39f981625 ) )
    {
        foreach ( func in level.var_bf8aa3f39f981625 )
        {
            self thread [[ func ]]();
        }
    }
    
    thread juggernaut_sound_when_close();
}

// Namespace spawner / scripts\sp\spawner
// Params 0
// Checksum 0x0, Offset: 0x8242
// Size: 0xa8
function juggernaut_sound_when_close()
{
    self endon( "death" );
    
    while ( true )
    {
        waitframe();
        
        if ( gettime() < level.juggernaut_next_alert_time )
        {
            continue;
        }
        
        if ( !isalive( level.player ) )
        {
            continue;
        }
        
        if ( distancesquared( level.player.origin, self.origin ) > 2250000 )
        {
            continue;
        }
        
        if ( !self cansee( level.player ) )
        {
            continue;
        }
        
        break;
    }
    
    level.juggernaut_next_alert_time = gettime() + 15000;
    level notify( "juggernaut_attacking" );
    
    if ( isdefined( self.skip_intro_sound ) )
    {
        return;
    }
}

