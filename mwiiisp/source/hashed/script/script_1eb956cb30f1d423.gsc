#using script_504283b70de854fa;
#using script_537a712b2be3193c;
#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace namespace_e09acb604a639f22;

// Namespace namespace_e09acb604a639f22 / namespace_1f8baead48123ebb
// Params 1
// Checksum 0x0, Offset: 0x17e
// Size: 0x6c
function function_cc07567b08d95292( defend_area )
{
    var_1491a51c2ef8b214 = getstructarray( defend_area, "targetname" );
    
    foreach ( area in var_1491a51c2ef8b214 )
    {
        area thread function_3b6cb5add3327a1b();
    }
}

// Namespace namespace_e09acb604a639f22 / namespace_1f8baead48123ebb
// Params 0
// Checksum 0x0, Offset: 0x1f2
// Size: 0x260
function function_3b6cb5add3327a1b()
{
    trig = spawn( "trigger_radius", self.origin, 0, int( self.radius ), 1024 );
    
    while ( true )
    {
        trig waittill( "trigger", ent );
        
        if ( !isplayer( ent ) )
        {
            continue;
        }
        
        break;
    }
    
    var_cff4cd4d39602aae = getstructarray( self.target, "targetname" );
    spot = random( var_cff4cd4d39602aae );
    mortar = spawn( "script_model", spot.origin );
    mortar.angles = spot.angles;
    mortar setmodel( "misc_wm_mortar" );
    mortar.script_noteworthy = "mortar";
    spawnpoint = getclosest( spot.origin, level.var_5a11797125800495 );
    aitype = "actor_enemy_cp_rus_desert_smg";
    guys = [];
    guys[ guys.size ] = namespace_d9d93e01b62de24a::ai_spawn( aitype, spawnpoint, 0, 128 );
    guys[ guys.size ] = namespace_d9d93e01b62de24a::ai_spawn( aitype, spawnpoint, 0, 128 );
    
    foreach ( guy in guys )
    {
        if ( !isdefined( guy ) )
        {
            continue;
        }
        
        if ( !isdefined( mortar.operator ) )
        {
            mortar.operator = guy;
        }
        else
        {
            guy setgoalpos( mortar.origin );
            guy setgoalentity( mortar );
        }
        
        guy.entered_combat = 1;
    }
    
    mortar.spawned_team = guys;
    level notify( "mortar_team_spawned", mortar );
    level thread function_230d6eebda212ccf( mortar, trig );
    namespace_d9d93e01b62de24a::function_e4f3059610095250( guys );
    mortar notify( "stop_mortar_think" );
    mortar notify( "stop_attracting" );
    wait 3;
    mortar playsound( "sentry_explode" );
    playfxontag( getfx( "sentry_explode_mp" ), mortar, "tag_origin" );
    playfxontag( getfx( "sentry_smoke_mp" ), mortar, "tag_aim" );
    wait 1;
    mortar delete();
}

// Namespace namespace_e09acb604a639f22 / namespace_1f8baead48123ebb
// Params 2
// Checksum 0x0, Offset: 0x45a
// Size: 0x91
function function_230d6eebda212ccf( mortar, trig )
{
    mortar endon( "stop_mortar_think" );
    level.get_mortar_impact_pos = &function_aa2345159b60a661;
    mortar.targets = undefined;
    
    while ( true )
    {
        targets = get_array_of_valid_players();
        targets = function_9cb5e0b04644dd1a( trig );
        
        if ( targets.size > 0 )
        {
            mortar.targets = targets;
            namespace_b430cd84d48ee8d6::attract_agent_to_mortar( mortar, 1, 1024 );
            mortar.targets = undefined;
            wait randomintrange( 5, 10 );
            continue;
        }
        
        wait 1;
    }
}

// Namespace namespace_e09acb604a639f22 / namespace_1f8baead48123ebb
// Params 1
// Checksum 0x0, Offset: 0x4f3
// Size: 0x8b
function function_aa2345159b60a661( mortar )
{
    if ( !isdefined( mortar.targets ) )
    {
        return undefined;
    }
    
    player = random( mortar.targets );
    point = player.origin + ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), 0 );
    trace = scripts\engine\trace::ray_trace( point + ( 0, 0, 500 ), point );
    return trace[ "position" ];
}

// Namespace namespace_e09acb604a639f22 / namespace_1f8baead48123ebb
// Params 1
// Checksum 0x0, Offset: 0x587
// Size: 0x93
function function_9cb5e0b04644dd1a( trig )
{
    validplayers = [];
    
    foreach ( player in level.players )
    {
        if ( !player is_valid_player() || !player isonground() || player isonladder() )
        {
            continue;
        }
        
        if ( player istouching( trig ) )
        {
            validplayers[ validplayers.size ] = player;
        }
    }
    
    return validplayers;
}

