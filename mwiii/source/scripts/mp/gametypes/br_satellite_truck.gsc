#using scripts\engine\utility;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_functional_poi;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\player;

#namespace br_satellite_truck;

// Namespace br_satellite_truck / scripts\mp\gametypes\br_satellite_truck
// Params 0
// Checksum 0x0, Offset: 0x3fc
// Size: 0x110
function init()
{
    level._effect[ "poi_sat_truck_available" ] = loadfx( "vfx/iw8_br/gameplay/vfx_br_poi_satnav_white.vfx" );
    level._effect[ "poi_sat_truck_charging" ] = loadfx( "vfx/iw8_br/gameplay/vfx_br_poi_satnav_red.vfx" );
    level.br_satellitetruck = [];
    level.br_satellite_truck_enabled = getdvarint( @"hash_2f77ec116b49bdf9", 0 ) != 0;
    level.satellitetruckactivetimeseconds = getdvarfloat( @"hash_aed581beb83f1b08", 15 );
    level.satellitetruckplundercost = getdvarint( @"hash_e361609d81154a08", 1 );
    scripts\mp\gametypes\br_functional_poi::initstatemachineforpoitype( "satellite_truck" );
    scripts\mp\gametypes\br_functional_poi::registerstatecallbacksforpoitype( "satellite_truck", 0, &_onenterdefaultstate, undefined, &_onexitdefaultstate );
    scripts\mp\gametypes\br_functional_poi::registerstatecallbacksforpoitype( "satellite_truck", 1, &_onenterchargingstate, undefined, &_onexitchargingstate );
    scripts\mp\gametypes\br_functional_poi::registerstatecallbacksforpoitype( "satellite_truck", 2, &_onenteractivestate, undefined, &_onexitactivestate );
    scripts\mp\gametypes\br_functional_poi::registerstatecallbacksforpoitype( "satellite_truck", 3, &_onenterscanningstate, undefined, &_onexitscanningstate );
    scripts\mp\gametypes\br_functional_poi::registerstatecallbacksforpoitype( "satellite_truck", 4, &_onentercooldownstate, undefined, undefined );
}

// Namespace br_satellite_truck / scripts\mp\gametypes\br_satellite_truck
// Params 1
// Checksum 0x0, Offset: 0x514
// Size: 0x1c6
function spawnsatellitetruck( struct )
{
    if ( !istrue( level.br_satellite_truck_enabled ) )
    {
        return;
    }
    
    var_f95cd92c3f35a916 = spawn( "script_model", struct.origin );
    
    if ( isdefined( struct.angles ) )
    {
        var_f95cd92c3f35a916.angles = struct.angles;
    }
    
    var_f95cd92c3f35a916 setmodel( "veh8_mil_lnd_mkilo23_skud_static2" );
    var_b7729b6d8545a7fe = getstruct( struct.target, "targetname" );
    
    if ( !isdefined( var_f95cd92c3f35a916.satellitekeyboard ) )
    {
        satellitekeyboard = spawn( "script_model", var_b7729b6d8545a7fe.origin );
        
        if ( isdefined( var_b7729b6d8545a7fe.angles ) )
        {
            satellitekeyboard.angles = var_b7729b6d8545a7fe.angles;
        }
        
        satellitekeyboard setmodel( "electrical_elevator_access_keypad_01" );
        satellitekeyboard setcursorhint( "HINT_NOICON" );
        satellitekeyboard setuseholdduration( "duration_medium" );
        satellitekeyboard sethintdisplayfov( 120 );
        satellitekeyboard setusefov( 120 );
        satellitekeyboard setuserange( 80 );
        satellitekeyboard setusepriority( -1 );
        var_f95cd92c3f35a916.satellitekeyboard = satellitekeyboard;
    }
    
    satelliteiconid = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
    
    if ( satelliteiconid != -1 )
    {
        scripts\mp\objidpoolmanager::objective_add_objective( satelliteiconid, "active", ( 0, 0, 0 ), "hud_icon_br_satellite_truck" );
        scripts\mp\objidpoolmanager::update_objective_onentity( satelliteiconid, var_f95cd92c3f35a916 );
        scripts\mp\objidpoolmanager::update_objective_setbackground( satelliteiconid, 1 );
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall( satelliteiconid );
        var_f95cd92c3f35a916.satelliteiconid = satelliteiconid;
        var_f95cd92c3f35a916 thread _satellitetruckmanageminimapicon();
    }
    else
    {
        println( "<dev string:x1c>" );
    }
    
    level.br_satellitetruck[ level.br_satellitetruck.size ] = var_f95cd92c3f35a916;
    return var_f95cd92c3f35a916;
}

// Namespace br_satellite_truck / scripts\mp\gametypes\br_satellite_truck
// Params 0
// Checksum 0x0, Offset: 0x6e3
// Size: 0x5c
function onprematchdone()
{
    foreach ( satellitetruck in level.br_satellitetruck )
    {
        satellitetruck scripts\mp\gametypes\br_functional_poi::gotopoistate( "satellite_truck", 0 );
    }
}

// Namespace br_satellite_truck / scripts\mp\gametypes\br_satellite_truck
// Params 0
// Checksum 0x0, Offset: 0x747
// Size: 0x173
function _satellitetruckmanageminimapicon()
{
    satellitetruck = self;
    satellitetruck endon( "death" );
    updateinterval = 1;
    visibleradius = 5000;
    satellitetruck.playersinrange = [];
    
    while ( true )
    {
        wait updateinterval;
        
        if ( !istrue( level.br_prematchstarted ) )
        {
            continue;
        }
        
        foreach ( player in satellitetruck.playersinrange )
        {
            if ( isdefined( player ) )
            {
                scripts\mp\objidpoolmanager::objective_playermask_hidefrom( satellitetruck.satelliteiconid, player );
            }
        }
        
        satellitetruck.playersinrange = scripts\mp\utility\player::getplayersinradius( satellitetruck.origin, visibleradius );
        
        foreach ( player in satellitetruck.playersinrange )
        {
            if ( isdefined( satellitetruck.playerteam ) && player.team == satellitetruck.playerteam && satellitetruck.currentstate == 3 )
            {
                continue;
            }
            
            scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( satellitetruck.satelliteiconid, player );
        }
    }
}

// Namespace br_satellite_truck / scripts\mp\gametypes\br_satellite_truck
// Params 0
// Checksum 0x0, Offset: 0x8c2
// Size: 0x19c
function _satellitetruckstartsound()
{
    satellitetruck = self;
    var_5c8800eda76b9a59 = satellitetruck;
    var_dd99c56a1f7a2b7 = satellitetruck.satellitekeyboard;
    assertex( isdefined( var_dd99c56a1f7a2b7 ), "<dev string:x4a>" );
    
    while ( true )
    {
        satellitetruck waittill( "poi_state_change" );
        state = satellitetruck.currentstate;
        
        if ( !isdefined( satellitetruck.audiostate ) )
        {
            satellitetruck.audiostate = state;
        }
        else if ( satellitetruck.audiostate == state )
        {
            continue;
        }
        
        satellitetruck.audiostate = state;
        
        switch ( state )
        {
            default:
                break;
            case 0:
                break;
            case 1:
                var_5c8800eda76b9a59 playsound( "truck_sattruck_initialstartup_os" );
                wait 7.5;
                var_5c8800eda76b9a59 playloopsound( "truck_sattruck_idling_lp" );
                break;
            case 2:
                break;
            case 3:
                satellitetruck.isscanning = 1;
                var_dd99c56a1f7a2b7 playsound( "truck_sattruck_initdeploy_os" );
                wait 4;
                var_dd99c56a1f7a2b7 playloopsound( "truck_sattruck_scanning_lp" );
                break;
            case 4:
                var_5c8800eda76b9a59 playsound( "truck_sattruck_engineoff" );
                
                if ( istrue( satellitetruck.isscanning ) )
                {
                    var_dd99c56a1f7a2b7 playsound( "truck_sattruck_scanning_off" );
                    satellitetruck.isscanning = undefined;
                    wait 0.05;
                    var_dd99c56a1f7a2b7 stoploopsound();
                }
                
                wait 0.45;
                var_5c8800eda76b9a59 stoploopsound();
                break;
        }
    }
}

// Namespace br_satellite_truck / scripts\mp\gametypes\br_satellite_truck
// Params 0
// Checksum 0x0, Offset: 0xa66
// Size: 0x17
function _satellitetruckendusethink()
{
    satellitetruck = self;
    satellitetruck notify( "satelliteTruckUseThinkEnd" );
}

// Namespace br_satellite_truck / scripts\mp\gametypes\br_satellite_truck
// Params 0
// Checksum 0x0, Offset: 0xa85
// Size: 0x123
function _satellitetruckusethink()
{
    satellitetruck = self;
    satellitetruck endon( "death" );
    satellitetruck _satellitetruckendusethink();
    satellitetruck endon( "satelliteTruckUseThinkEnd" );
    satellitetruck thread _satellitetruckstartsound();
    originalstate = satellitetruck scripts\mp\gametypes\br_functional_poi::getcurrentpoistate();
    
    while ( true )
    {
        satellitetruck.satellitekeyboard waittill( "trigger", player );
        
        if ( satellitetruck scripts\mp\gametypes\br_functional_poi::getcurrentpoistate() != originalstate )
        {
            return;
        }
        
        if ( satellitetruck scripts\mp\gametypes\br_functional_poi::getcurrentpoistate() == 0 )
        {
            if ( player.plundercount < level.satellitetruckplundercost )
            {
                player scripts\mp\hud_message::showerrormessage( "MP_BR_INGAME/NOT_ENOUGH_PLUNDER_ACTIVATE" );
                continue;
            }
            else
            {
                player scripts\mp\gametypes\br_plunder::playersetplundercount( player.plundercount - level.satellitetruckplundercost );
            }
        }
        
        if ( originalstate == 0 )
        {
            satellitetruck.playerteam = player.team;
            satellitetruck thread scripts\mp\gametypes\br_functional_poi::gotopoistate( "satellite_truck", 1 );
            return;
        }
        
        if ( originalstate == 2 )
        {
            satellitetruck.playerteam = player.team;
            satellitetruck thread scripts\mp\gametypes\br_functional_poi::gotopoistate( "satellite_truck", 3 );
        }
    }
}

// Namespace br_satellite_truck / scripts\mp\gametypes\br_satellite_truck
// Params 0
// Checksum 0x0, Offset: 0xbb0
// Size: 0xf2
function _satellitetruckactivate()
{
    satellitetruck = self;
    satellitetruck endon( "death" );
    level thread scripts\mp\gametypes\br::teamsplashbr( "br_satellite_truck_active", satellitetruck.player, satellitetruck.playerteam );
    sweepcount = 0;
    sweepspeed = getdvarint( @"hash_53e16ec28b970932", 500 );
    var_46d176fdcd576507 = getdvarint( @"hash_d1658ac67eb8d4a8", 2 );
    
    while ( sweepcount * var_46d176fdcd576507 <= level.satellitetruckactivetimeseconds )
    {
        triggerportableradarpingteam( self.origin, satellitetruck.playerteam, 5000, sweepspeed );
        sweepcount++;
        wait var_46d176fdcd576507;
    }
    
    var_6e5bd4fa4b5fcf47 = getdvarfloat( @"hash_9a9c532332e3743d", 3 );
    scripts\mp\gametypes\br_functional_poi::showmiscmessagetoteam( satellitetruck.playerteam, "br_satellite_truck_cooldown", var_6e5bd4fa4b5fcf47 );
    satellitetruck thread scripts\mp\gametypes\br_functional_poi::gotopoistate( "satellite_truck", 4 );
}

// Namespace br_satellite_truck / scripts\mp\gametypes\br_satellite_truck
// Params 1
// Checksum 0x0, Offset: 0xcaa
// Size: 0x81
function _onenterdefaultstate( satellitetruck )
{
    outlineasset = scripts\mp\gametypes\br_functional_poi::getinteractiveoutlineasset();
    satellitetruck.satellitekeyboard hudoutlineenable( outlineasset );
    satellitetruck.satellitekeyboard makeusable();
    satellitetruck.satellitekeyboard sethintstring( &"MP/BR_ACTIVATE_SATELLITE_TRUCK" );
    satellitetruck thread _satellitetruckusethink();
    var_18e46c38378f618 = getfx( "poi_sat_truck_available" );
    playfxontag( var_18e46c38378f618, satellitetruck, "tag_origin" );
}

// Namespace br_satellite_truck / scripts\mp\gametypes\br_satellite_truck
// Params 1
// Checksum 0x0, Offset: 0xd33
// Size: 0x59
function _onexitdefaultstate( satellitetruck )
{
    satellitetruck.satellitekeyboard hudoutlinedisable();
    satellitetruck _satellitetruckendusethink();
    satellitetruck.satellitekeyboard makeunusable();
    var_18e46c38378f618 = getfx( "poi_sat_truck_available" );
    stopfxontag( var_18e46c38378f618, satellitetruck, "tag_origin" );
}

// Namespace br_satellite_truck / scripts\mp\gametypes\br_satellite_truck
// Params 1
// Checksum 0x0, Offset: 0xd94
// Size: 0x7c
function _onenterchargingstate( satellitetruck )
{
    var_3058dbc123e6c741 = getdvarfloat( @"hash_9ecb6742d002ed16", 10 );
    satellitetruck thread scripts\mp\gametypes\br_functional_poi::gotopoistateontimer( "satellite_truck", 2, var_3058dbc123e6c741 );
    scripts\mp\gametypes\br_functional_poi::showmiscmessagetoteam( satellitetruck.playerteam, "br_satellite_truck_charging", var_3058dbc123e6c741, int( var_3058dbc123e6c741 * 1000 ) );
    var_90d6a5c6923319de = getfx( "poi_sat_truck_charging" );
    playfxontag( var_90d6a5c6923319de, satellitetruck, "tag_origin" );
}

// Namespace br_satellite_truck / scripts\mp\gametypes\br_satellite_truck
// Params 1
// Checksum 0x0, Offset: 0xe18
// Size: 0x2f
function _onexitchargingstate( satellitetruck )
{
    var_90d6a5c6923319de = getfx( "poi_sat_truck_charging" );
    stopfxontag( var_90d6a5c6923319de, satellitetruck, "tag_origin" );
}

// Namespace br_satellite_truck / scripts\mp\gametypes\br_satellite_truck
// Params 1
// Checksum 0x0, Offset: 0xe4f
// Size: 0x5f
function _onenteractivestate( satellitetruck )
{
    outlineasset = scripts\mp\gametypes\br_functional_poi::getinteractiveoutlineasset();
    satellitetruck.satellitekeyboard hudoutlineenable( outlineasset );
    satellitetruck.satellitekeyboard makeusable();
    satellitetruck.satellitekeyboard sethintstring( &"MP/BR_USE_SATELLITE_TRUCK" );
    satellitetruck thread _satellitetruckusethink();
}

// Namespace br_satellite_truck / scripts\mp\gametypes\br_satellite_truck
// Params 1
// Checksum 0x0, Offset: 0xeb6
// Size: 0x35
function _onexitactivestate( satellitetruck )
{
    satellitetruck.satellitekeyboard hudoutlinedisable();
    satellitetruck _satellitetruckendusethink();
    satellitetruck.satellitekeyboard makeunusable();
}

// Namespace br_satellite_truck / scripts\mp\gametypes\br_satellite_truck
// Params 1
// Checksum 0x0, Offset: 0xef3
// Size: 0x14
function _onenterscanningstate( satellitetruck )
{
    satellitetruck thread _satellitetruckactivate();
}

// Namespace br_satellite_truck / scripts\mp\gametypes\br_satellite_truck
// Params 1
// Checksum 0x0, Offset: 0xf0f
// Size: 0x16
function _onexitscanningstate( satellitetruck )
{
    satellitetruck.playerteam = undefined;
}

// Namespace br_satellite_truck / scripts\mp\gametypes\br_satellite_truck
// Params 1
// Checksum 0x0, Offset: 0xf2d
// Size: 0x37
function _onentercooldownstate( satellitetruck )
{
    cooldowntimeseconds = getdvarfloat( @"hash_2333f90f274605a5", 15 );
    satellitetruck thread scripts\mp\gametypes\br_functional_poi::gotopoistateontimer( "satellite_truck", 0, cooldowntimeseconds );
}

