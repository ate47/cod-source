#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment\bunkerbuster;

#namespace namespace_afda4b8e83f2f71f;

// Namespace namespace_afda4b8e83f2f71f / namespace_8094e56267749e0f
// Params 3
// Checksum 0x0, Offset: 0x9d
// Size: 0xd3
function function_9b277eeff7fe104a( origin, angles, var_f8f2ebf05b9af55a )
{
    dc = magicgrenademanual( "bunkerbuster_mp", origin + ( 0, 0, 10 ), ( 0, 0, 10 ) );
    waitframe();
    dc.owner = spawnstruct();
    dc.owner.angles = angles;
    dc.owner.team = "neutral";
    dc.team = "neutral";
    dc.headiconid = dc scripts\cp_mp\entityheadicons::setheadicon_factionimage( 0, 5, undefined, undefined, undefined, 0.1 );
    level.players[ 0 ] function_3d78dd516c25ef77( dc );
    return dc;
}

// Namespace namespace_afda4b8e83f2f71f / namespace_8094e56267749e0f
// Params 3
// Checksum 0x0, Offset: 0x179
// Size: 0x9c
function spawn_script_model_at_pos( tag, animname, model )
{
    spawnorg = self gettagorigin( tag );
    spawnang = self gettagangles( tag );
    startorg = spawnorg;
    startangles = spawnang;
    spawned = spawn( "script_model", startorg );
    spawned.angles = startangles;
    spawned setmodel( model );
    spawned linkto( self );
    
    if ( isdefined( animname ) )
    {
        spawned scriptmodelplayanim( animname );
    }
    
    return spawned;
}

