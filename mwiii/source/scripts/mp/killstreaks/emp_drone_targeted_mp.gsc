#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\killstreaks\mapselect;

#namespace emp_drone_targeted_mp;

// Namespace emp_drone_targeted_mp / scripts\mp\killstreaks\emp_drone_targeted_mp
// Params 0
// Checksum 0x0, Offset: 0xf4
// Size: 0x44
function init()
{
    scripts\engine\utility::registersharedfunc( "empDroneTargeted", "getSelectMapPoint", &emp_drone_targeted_getmapselectpoint );
    scripts\engine\utility::registersharedfunc( "empDroneTargeted", "startMapSelectSequence", &emp_drone_targeted_startmapselectsequence );
    scripts\engine\utility::registersharedfunc( "empDroneTargeted", "monitorDamage", &emp_drone_targeted_monitordamage );
}

// Namespace emp_drone_targeted_mp / scripts\mp\killstreaks\emp_drone_targeted_mp
// Params 3
// Checksum 0x0, Offset: 0x140
// Size: 0x24
function emp_drone_targeted_getmapselectpoint( streakinfo, selectnum, directionalselection )
{
    return scripts\mp\killstreaks\mapselect::function_a5839924b6723eac( streakinfo, selectnum, directionalselection );
}

// Namespace emp_drone_targeted_mp / scripts\mp\killstreaks\emp_drone_targeted_mp
// Params 4
// Checksum 0x0, Offset: 0x16d
// Size: 0x2e
function emp_drone_targeted_startmapselectsequence( navmesh, directionalselection, directionaltype, selectortype )
{
    scripts\mp\killstreaks\mapselect::function_90f093ca8576232f( navmesh, directionalselection, directionaltype, selectortype );
}

// Namespace emp_drone_targeted_mp / scripts\mp\killstreaks\emp_drone_targeted_mp
// Params 7
// Checksum 0x0, Offset: 0x1a3
// Size: 0x4a
function emp_drone_targeted_monitordamage( maxhealth, damagefeedback, ondeathfunc, var_d7b6456018542238, biskillstreak, rumble, resetdamagetaken )
{
    scripts\mp\damage::monitordamage( maxhealth, damagefeedback, ondeathfunc, var_d7b6456018542238, biskillstreak, rumble, resetdamagetaken );
}

