#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;

#namespace br_publicevent_plundermultipliers;

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x31f
// Size: 0x41
function autoexec main()
{
    scripts\mp\gametypes\br_publicevents::function_dbc8f6cb3760cd82( %"bloodmoney", &function_9aa5ae7661a3a913 );
    scripts\mp\gametypes\br_publicevents::function_dbc8f6cb3760cd82( %"contractor", &initcontractor );
    scripts\mp\gametypes\br_publicevents::function_dbc8f6cb3760cd82( %"moneysiphon", &function_1cac290201dd47fc );
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 1
// Checksum 0x0, Offset: 0x368
// Size: 0xe1
function function_9aa5ae7661a3a913( bloodmoney )
{
    if ( !isdefined( level.plundermultipliers ) )
    {
        level.plundermultipliers = spawnstruct();
    }
    
    bloodmoney.validatefunc = &function_e7a80b9a5971257a;
    bloodmoney.activatefunc = &function_41b1afbe1c7af99;
    bloodmoney.waitfunc = &function_aec5c0a5b73ae7c5;
    bloodmoney.postinitfunc = &function_adc3e7f53e3456d0;
    bloodmoney.timertype = 10;
    bloodmoney.var_45620a2820463e6e = getdvarint( @"hash_290bf19648dc8eb2", 2 );
    bloodmoney.var_ee5fb771f83add5e = getdvarfloat( @"hash_8685285f3db98a1c", 2 );
    bloodmoney.duration = getdvarint( @"hash_4e87bb76afe4eb45", 120 );
    bloodmoney.type = %"bloodmoney";
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 1
// Checksum 0x0, Offset: 0x451
// Size: 0x101
function initcontractor( contractor )
{
    if ( !isdefined( level.plundermultipliers ) )
    {
        level.plundermultipliers = spawnstruct();
    }
    
    contractor.validatefunc = &function_6150c8f67e691807;
    contractor.activatefunc = &contractor_activatefunc;
    contractor.waitfunc = &contractor_waitfunc;
    contractor.postinitfunc = &function_3c14f9df7efc9951;
    contractor.timertype = 11;
    contractor.var_46a451f9012bd1c = getdvarint( @"hash_f4f0d78ce0da6030", 2 );
    setdvarifuninitialized( @"hash_f4f0d78ce0da6030", contractor.var_46a451f9012bd1c );
    contractor.duration = getdvarint( @"hash_5b1205ec7121272c", 120 );
    contractor.type = %"contractor";
    contractor.onend = &function_ae81543a21ecadd3;
    contractor.onstart = &function_1362a29d8775e5d6;
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0x55a
// Size: 0x116
function function_1362a29d8775e5d6()
{
    if ( isdefined( level.contractmanager ) )
    {
        if ( isdefined( level.contractmanager.currenttasks ) )
        {
            foreach ( task in level.contractmanager.currenttasks )
            {
                if ( !istrue( task.contractoractive ) )
                {
                    task.contractoractive = 1;
                }
            }
        }
    }
    
    if ( isdefined( level.contractmanager.var_3c3c5b819ea01809 ) )
    {
        foreach ( var_220fa84c3caee5a7 in level.contractmanager.var_3c3c5b819ea01809 )
        {
            thread [[ var_220fa84c3caee5a7 ]]();
        }
    }
    
    setomnvar( "contractor_active", 1 );
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0x678
// Size: 0x80
function function_ae81543a21ecadd3()
{
    if ( isdefined( level.contractmanager.var_5041655a5e1a439e ) )
    {
        foreach ( var_7478fae583a50fa in level.contractmanager.var_5041655a5e1a439e )
        {
            thread [[ var_7478fae583a50fa ]]();
        }
    }
    
    setomnvar( "contractor_active", 0 );
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 1
// Checksum 0x0, Offset: 0x700
// Size: 0x6a
function function_1cac290201dd47fc( moneysiphon )
{
    if ( !isdefined( level.plundermultipliers ) )
    {
        level.plundermultipliers = spawnstruct();
    }
    
    moneysiphon.validatefunc = &function_98e0aab5f4a07947;
    moneysiphon.activatefunc = &function_8645e7ba0e3942c0;
    moneysiphon.waitfunc = &function_b44e7b12bcdc2c14;
    moneysiphon.postinitfunc = &function_ef3989dd64896a91;
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 2
// Checksum 0x0, Offset: 0x772
// Size: 0x1cd
function function_ca6e399c0a8a91b6( eventstruct, eventname )
{
    level endon( "game_ended" );
    scripts\mp\gametypes\br_publicevents::showsplashtoall( "br_plunder_pe_" + eventname + "_active", "splash_list_br_plunder_iw9_mp" );
    scripts\mp\gametypes\br_public::brleaderdialog( "public_events_" + eventname + "_start" );
    setomnvar( "ui_minimap_pulse", 1 );
    setomnvar( "ui_publicevent_timer_type", eventstruct.timertype );
    eventduration = eventstruct.duration;
    eventendtime = gettime() + eventduration * 1000;
    setomnvar( "ui_publicevent_timer", eventendtime );
    clockobject = spawn( "script_origin", ( 0, 0, 0 ) );
    clockobject hide();
    
    if ( isdefined( eventstruct.onstart ) )
    {
        [[ eventstruct.onstart ]]();
    }
    else
    {
        eventstruct.active = 1;
    }
    
    thread function_23913a35c5ebd726( eventname );
    var_49978e5850a50d57 = 5;
    
    if ( eventduration > var_49978e5850a50d57 )
    {
        wait eventduration - var_49978e5850a50d57;
    }
    else
    {
        var_49978e5850a50d57 = int( eventduration );
    }
    
    for ( i = 0; i < var_49978e5850a50d57 ; i++ )
    {
        clockobject playsound( "ui_mp_fire_sale_timer" );
        wait 1;
    }
    
    if ( isdefined( eventstruct.onend ) )
    {
        [[ eventstruct.onend ]]();
    }
    else
    {
        eventstruct.active = 0;
    }
    
    scripts\mp\gametypes\br_publicevents::function_2907d01a7d692108( eventstruct.type );
    level notify( "public_event_" + eventname + "_end" );
    scripts\mp\gametypes\br_public::brleaderdialog( "public_events_" + eventname + "_end" );
    setomnvar( "ui_minimap_pulse", 0 );
    setomnvar( "ui_publicevent_timer_type", 0 );
    clockobject delete();
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 1
// Checksum 0x0, Offset: 0x947
// Size: 0x22
function function_23913a35c5ebd726( eventname )
{
    wait 2;
    scripts\mp\gametypes\br_public::brleaderdialog( "public_events_" + eventname + "_active" );
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0x971
// Size: 0x28
function function_adc3e7f53e3456d0()
{
    game[ "dialog" ][ "public_events_blood_money_start" ] = "bldm_grav_name";
    game[ "dialog" ][ "public_events_blood_money_active" ] = "bldm_grav_boos";
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0x9a1
// Size: 0xe, Type: bool
function function_e7a80b9a5971257a()
{
    return scripts\mp\utility\game::getsubgametype() == "plunder";
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0x9b8
// Size: 0x2
function function_aec5c0a5b73ae7c5()
{
    
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0x9c2
// Size: 0x28
function function_41b1afbe1c7af99()
{
    level endon( "game_ended" );
    function_ca6e399c0a8a91b6( level.br_pe_data[ %"bloodmoney" ], "blood_money" );
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0x9f2
// Size: 0x28
function function_3c14f9df7efc9951()
{
    game[ "dialog" ][ "public_events_contractor_start" ] = "ctrc_grav_name";
    game[ "dialog" ][ "public_events_contractor_active" ] = "ctrc_grav_boos";
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0xa22
// Size: 0x4, Type: bool
function function_6150c8f67e691807()
{
    return true;
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0xa2f
// Size: 0x2
function contractor_waitfunc()
{
    
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0xa39
// Size: 0x28
function contractor_activatefunc()
{
    level endon( "game_ended" );
    function_ca6e399c0a8a91b6( level.br_pe_data[ %"contractor" ], "contractor" );
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0xa69
// Size: 0x2
function function_93ccb74a1d25e826()
{
    
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0xa73
// Size: 0x2
function function_4109d1fefcb9970()
{
    
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0xa7d
// Size: 0x2
function heat_waitfunc()
{
    
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0xa87
// Size: 0x2
function heat_activatefunc()
{
    
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0xa91
// Size: 0x113
function function_ef3989dd64896a91()
{
    game[ "dialog" ][ "public_events_money_siphon_active" ] = "csht_grav_boos";
    moneysiphon = spawnstruct();
    moneysiphon.type = %"moneysiphon";
    moneysiphon.timertype = 13;
    moneysiphon.active = 0;
    moneysiphon.var_e8fb817a73e06aba = getdvarint( @"hash_55d165f2f9e49694", 2 );
    moneysiphon.var_9714ddda6a6df159 = getdvarint( @"hash_1cc3febe5f5f8883", 100 );
    moneysiphon.depositinterval = getdvarfloat( @"hash_23750ae04694dc22", 3 );
    moneysiphon.duration = getdvarint( @"hash_1a720e1709ceabf0", 120 );
    moneysiphon.var_f9b722c9edce3106 = getdvarint( @"hash_74f7c2602fc10dd8", 120 );
    moneysiphon.var_2f1ee623e7fc5c8c = getdvarint( @"hash_2ac717f48aef9bd0", 1 );
    level.plundermultipliers.moneysiphon = moneysiphon;
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0xbac
// Size: 0xe, Type: bool
function function_98e0aab5f4a07947()
{
    return scripts\mp\utility\game::getsubgametype() == "plunder";
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0xbc3
// Size: 0x2
function function_b44e7b12bcdc2c14()
{
    
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0xbcd
// Size: 0x28
function function_8645e7ba0e3942c0()
{
    level endon( "game_ended" );
    function_ca6e399c0a8a91b6( level.plundermultipliers.moneysiphon, "money_siphon" );
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0xbfd
// Size: 0x2
function function_7ebdc9e059a1beaf()
{
    
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0xc07
// Size: 0xe, Type: bool
function function_6dc1bbc26235ec1d()
{
    return scripts\mp\utility\game::getsubgametype() == "plunder";
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0xc1e
// Size: 0x2
function function_c6fa8ae160635b3a()
{
    
}

// Namespace br_publicevent_plundermultipliers / scripts\mp\gametypes\br_publicevent_plundermultipliers
// Params 0
// Checksum 0x0, Offset: 0xc28
// Size: 0x28
function function_218e108e5da1b92a()
{
    level endon( "game_ended" );
    function_ca6e399c0a8a91b6( level.br_pe_data[ %"hash_588fce12d26723f" ], "cannon_fodder" );
}

