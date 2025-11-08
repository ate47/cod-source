#using script_1fa444cdc9dbf364;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\equipment;
#using scripts\mp\supers;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;

#namespace agent_equipment;

// Namespace agent_equipment / namespace_437d750db8e68984
// Params 0
// Checksum 0x0, Offset: 0x1be
// Size: 0x17c
function function_f04c619138baafd8()
{
    if ( getdvarint( @"hash_e1fca8f6ab32aacc", 1 ) == 0 )
    {
        return;
    }
    
    claymorenodes = level.struct_class_names[ "script_noteworthy" ][ "boss_trapper_claymore" ];
    var_e2176a2d7c0e42a4 = level.struct_class_names[ "script_noteworthy" ][ "boss_trapper_at_mine" ];
    var_535166b783f2c94d = level.struct_class_names[ "script_noteworthy" ][ "boss_trapper_cluster" ];
    var_ccd66fb268ce4ca7 = [ claymorenodes, var_e2176a2d7c0e42a4, var_535166b783f2c94d ];
    equipstrings = [ "claymore", "at_mine", "sound_veil" ];
    
    for ( i = 0; i < var_ccd66fb268ce4ca7.size ; i++ )
    {
        if ( !isdefined( var_ccd66fb268ce4ca7[ i ] ) )
        {
            continue;
        }
        
        foreach ( node in var_ccd66fb268ce4ca7[ i ] )
        {
            deploystruct = spawnstruct();
            deploystruct.origin = node.origin;
            deploystruct.angles = node.angles;
            deploystruct.ref = "equip_" + equipstrings[ i ];
            thread namespace_437d750db8e68984::function_fd5966a3a1fdf6b8( deploystruct );
        }
    }
}

// Namespace agent_equipment / namespace_437d750db8e68984
// Params 1
// Checksum 0x0, Offset: 0x342
// Size: 0x158
function function_ac625f4c2bf0906b( equipmentref )
{
    eyeposition = self getvieworigin();
    cameraorientation = self getplayerangles();
    cameraforward = anglestoforward( cameraorientation );
    cameratraceend = eyeposition + cameraforward * 256;
    ignorearray = self;
    var_e76c084d206cfb7f = scripts\engine\trace::create_contents( 1, 0, 0, 1, 0, 1, 0, 1, 1 );
    deploytrace = ray_trace( eyeposition, cameratraceend, ignorearray, var_e76c084d206cfb7f, 0, 0, 1 );
    
    if ( deploytrace[ "hittype" ] == "hittype_none" )
    {
        return;
    }
    
    deploypos = deploytrace[ "position" ];
    deployfwd = math::vector_project_onto_plane( vectornormalize( self.origin - deploytrace[ "position" ] ), deploytrace[ "normal" ] );
    deployup = deploytrace[ "normal" ];
    deployright = vectorcross( deployfwd, deployup );
    deployorientation = axistoangles( deployfwd, deployright, deployup );
    deploystruct = spawnstruct();
    deploystruct.origin = deploypos;
    deploystruct.angles = deployorientation;
    deploystruct.ref = equipmentref;
    namespace_437d750db8e68984::function_fd5966a3a1fdf6b8( deploystruct );
}

// Namespace agent_equipment / namespace_437d750db8e68984
// Params 2
// Checksum 0x0, Offset: 0x4a2
// Size: 0x19a
function function_fd5966a3a1fdf6b8( deploystruct, agentteam )
{
    assertex( isdefined( deploystruct.origin ), "<dev string:x1c>" );
    assertex( isdefined( deploystruct.angles ), "<dev string:x1c>" );
    assertex( isdefined( deploystruct.origin ), "<dev string:x1c>" );
    weaponref = deploystruct.ref;
    isequip = issubstr( deploystruct.ref, "equip_" );
    weaponobj = undefined;
    
    if ( isequip )
    {
        tableinfo = scripts\mp\equipment::getequipmenttableinfo( deploystruct.ref );
        
        if ( isdefined( tableinfo.objweapon ) )
        {
            weaponref = tableinfo.objweapon.basename;
            weaponobj = tableinfo.objweapon;
        }
    }
    else
    {
        weaponobj = makeweapon( weaponref );
    }
    
    fakeowner = scripts\mp\ai_mp_controller::function_af3034a7c69d7edb( scripts\cp_mp\agents\agent_utils::function_30a0d7ca3fae40cc( "merc" ) );
    grenade = fakeowner _launchgrenade( weaponref, deploystruct.origin, ( 0, 0, 0 ), undefined, 0, undefined, 0 );
    grenade.angles = deploystruct.angles;
    
    /#
        level thread draw_angles( grenade.angles, grenade.origin, ( 1, 0, 0 ), 5000, 100 );
    #/
}

