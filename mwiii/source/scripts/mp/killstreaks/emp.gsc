#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;

#namespace emp;

// Namespace emp / scripts\mp\killstreaks\emp
// Params 0
// Checksum 0x0, Offset: 0x1c9
// Size: 0x13
function init()
{
    scripts\mp\killstreaks\killstreaks::registerkillstreak( "emp", &tryuseempfromstruct );
}

// Namespace emp / scripts\mp\killstreaks\emp
// Params 0
// Checksum 0x0, Offset: 0x1e4
// Size: 0x21
function tryuseemp()
{
    streakinfo = createstreakinfo( "emp", self );
    return tryuseempfromstruct( streakinfo );
}

// Namespace emp / scripts\mp\killstreaks\emp
// Params 1
// Checksum 0x0, Offset: 0x20e
// Size: 0xa5, Type: bool
function tryuseempfromstruct( streakinfo )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, makeweapon( "ks_gesture_generic_mp" ) );
    
    if ( !istrue( deployresult ) )
    {
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    thread startemp();
    level callback::callback( "killstreak_finish_use", { #streakinfo:self.streakinfo } );
    return true;
}

// Namespace emp / scripts\mp\killstreaks\emp
// Params 0
// Checksum 0x0, Offset: 0x2bc
// Size: 0x158
function startemp()
{
    level endon( "game_ended" );
    heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
    heightoffset = 3000;
    
    if ( isdefined( heightent ) )
    {
        heightoffset = heightent.origin[ 2 ] + 500;
    }
    
    fxspawnpos = level.mapcenter * ( 1, 1, 0 ) + ( 0, 0, heightoffset );
    playfx( getfx( "emp_shockwave" ), fxspawnpos );
    self playsound( "jammer_drone_shockwave" );
    
    foreach ( player in level.players )
    {
        if ( !isreallyalive( player ) )
        {
            continue;
        }
        
        player thread applyempshellshock();
    }
    
    enemyteams = getenemyteams( self.owner.team );
    
    foreach ( entry in enemyteams )
    {
        destroyactiveobjects( entry, self );
    }
}

// Namespace emp / scripts\mp\killstreaks\emp
// Params 0
// Checksum 0x0, Offset: 0x41c
// Size: 0x58
function applyempshellshock()
{
    self setscriptablepartstate( "emped", "active", 0 );
    self playloopsound( "emp_nade_lp" );
    thread applyempshellshockvisionset();
    wait 0.5;
    self setscriptablepartstate( "emped", "neutral", 0 );
    self playsound( "emp_nade_lp_end" );
    self stoploopsound( "emp_nade_lp" );
}

// Namespace emp / scripts\mp\killstreaks\emp
// Params 0
// Checksum 0x0, Offset: 0x47c
// Size: 0x2f
function applyempshellshockvisionset()
{
    visionsetnaked( "coup_sunblind", 0.05 );
    waitframe();
    visionsetnaked( "coup_sunblind", 0 );
    visionsetnaked( "", 0.5 );
}

// Namespace emp / scripts\mp\killstreaks\emp
// Params 2
// Checksum 0x0, Offset: 0x4b3
// Size: 0xf1
function destroyactiveobjects( team, owner )
{
    weapon = "nuke_mp";
    var_6c845d64be969ce8 = level.activekillstreaks;
    equipmentarray = [[ level.getactiveequipmentarray ]]();
    activeobjects = undefined;
    
    if ( isdefined( var_6c845d64be969ce8 ) && isdefined( equipmentarray ) )
    {
        activeobjects = array_combine_unique( var_6c845d64be969ce8, equipmentarray );
    }
    else if ( isdefined( var_6c845d64be969ce8 ) )
    {
        activeobjects = var_6c845d64be969ce8;
    }
    else if ( isdefined( equipmentarray ) )
    {
        activeobjects = equipmentarray;
    }
    
    if ( isdefined( activeobjects ) )
    {
        foreach ( object in activeobjects )
        {
            if ( isdefined( object ) )
            {
                object dodamagetokillstreak( 10000, owner, owner, team, object.origin, "MOD_EXPLOSIVE", weapon );
            }
        }
    }
}

