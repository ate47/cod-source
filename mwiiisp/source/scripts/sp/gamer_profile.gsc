#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\utility;

#namespace gamer_profile;

// Namespace gamer_profile / scripts\sp\gamer_profile
// Params 0
// Checksum 0x0, Offset: 0x99
// Size: 0x94
function init_gamer_profile()
{
    assert( isdefined( level.missionsettings ) && isdefined( level.missionsettings.levels ) );
    assert( isdefined( level.script ) );
    
    if ( level.script == level.missionsettings.levels[ 0 ].name && !level.player getlocalplayerprofiledata( "hasEverPlayed_SP" ) )
    {
        delaythread( 0.1, &update_gamer_profile );
    }
}

// Namespace gamer_profile / scripts\sp\gamer_profile
// Params 0
// Checksum 0x0, Offset: 0x135
// Size: 0x1e
function update_gamer_profile()
{
    level.player setlocalplayerprofiledata( "hasEverPlayed_SP", 1 );
    updategamerprofile();
}

