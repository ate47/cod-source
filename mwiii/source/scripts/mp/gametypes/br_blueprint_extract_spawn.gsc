#using scripts\cp_mp\utility\game_utility;
#using scripts\mp\gametypes\br_extract_quest;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;

#namespace br_blueprint_extract_spawn;

// Namespace br_blueprint_extract_spawn / scripts\mp\gametypes\br_blueprint_extract_spawn
// Params 0
// Checksum 0x0, Offset: 0x143
// Size: 0x177
function init()
{
    level.blueprint_maxpermatch = undefined;
    level.blueprint_chancebase = undefined;
    level.blueprint_chancepercontract = undefined;
    brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();
    
    if ( brgametype == "plunder" || brgametype == "risk" )
    {
        level.blueprint_maxpermatch = getdvarfloat( @"scr_blueprint_plunder_maxpermatch", 4 );
        level.blueprint_chancebase = getdvarfloat( @"scr_blueprint_plunder_chancebase", 0.02 );
        level.blueprint_chancepercontract = getdvarfloat( @"scr_blueprint_plunder_chancepercontract", 0 );
    }
    else
    {
        level.blueprint_maxpermatch = getdvarfloat( @"scr_blueprint_br_maxpermatch", 4 );
        level.blueprint_chancebase = getdvarfloat( @"scr_blueprint_br_chancebase", 0.02 );
        level.blueprint_chancepercontract = getdvarfloat( @"scr_blueprint_br_chancepercontract", 0 );
    }
    
    level.blueprintextractspawns = 0;
    level.blueprintextractchance = level.blueprint_chancebase;
    level.blueprintcreatingteam = undefined;
    
    foreach ( unlockabledata in level.questinfo.unlockables )
    {
        registerpickupcreatedcallback( "brloot_blueprintextract_tablet", &blueprintextract_onpickupcreated );
    }
}

// Namespace br_blueprint_extract_spawn / scripts\mp\gametypes\br_blueprint_extract_spawn
// Params 1
// Checksum 0x0, Offset: 0x2c2
// Size: 0x8c
function blueprintextract_trygetreward( rewardorigin )
{
    if ( !blueprintextract_shouldgivereward( rewardorigin ) )
    {
        return undefined;
    }
    
    if ( level.blueprintextractspawns >= level.blueprint_maxpermatch )
    {
        return undefined;
    }
    
    randomvalue = randomfloat( 1 );
    
    if ( randomvalue <= level.blueprintextractchance )
    {
        level.blueprintextractspawns += 1;
        return "brloot_blueprintextract_tablet";
    }
    
    level.blueprintextractchance += level.blueprint_chancepercontract;
    return undefined;
}

// Namespace br_blueprint_extract_spawn / scripts\mp\gametypes\br_blueprint_extract_spawn
// Params 1
// Checksum 0x0, Offset: 0x356
// Size: 0xd4, Type: bool
function blueprintextract_shouldgivereward( rewardorigin )
{
    if ( scripts\mp\gametypes\br_public::isanytutorialorbotpracticematch() )
    {
        return false;
    }
    
    if ( scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924() )
    {
        return false;
    }
    
    if ( istrue( level.bmoovertime ) )
    {
        return false;
    }
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) && isdefined( level.br_level ) && isdefined( level.br_level.br_circleclosetimes ) )
    {
        currentcircleindex = level.br_circle.circleindex;
        finalcircleindex = level.br_level.br_circleclosetimes.size - 1;
        
        if ( finalcircleindex - currentcircleindex < 4 )
        {
            return false;
        }
    }
    
    if ( !scripts\mp\gametypes\br_extract_quest::extractlocale_islocaleavailable( rewardorigin ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_blueprint_extract_spawn / scripts\mp\gametypes\br_blueprint_extract_spawn
// Params 1
// Checksum 0x0, Offset: 0x433
// Size: 0x15
function blueprintextract_beforepickupspawned( team )
{
    level.blueprintcreatingteam = team;
}

// Namespace br_blueprint_extract_spawn / scripts\mp\gametypes\br_blueprint_extract_spawn
// Params 0
// Checksum 0x0, Offset: 0x450
// Size: 0x2c
function blueprintextract_onpickupcreated()
{
    randomlootid = scripts\mp\gametypes\br_quest_util::getrandomextractunlockablelootid();
    blueprintextract_setunlockablelootid( randomlootid );
    thread blueprintextract_createtempobjective();
    thread blueprintextract_cleanupwhennoavailablelocales();
}

// Namespace br_blueprint_extract_spawn / scripts\mp\gametypes\br_blueprint_extract_spawn
// Params 1
// Checksum 0x0, Offset: 0x484
// Size: 0x1e
function blueprintextract_setunlockablelootid( unlockablelootid )
{
    scripts\mp\gametypes\br_pickups::loot_setitemcount( self, unlockablelootid );
    self.extractunlockablelootid = unlockablelootid;
}

// Namespace br_blueprint_extract_spawn / scripts\mp\gametypes\br_blueprint_extract_spawn
// Params 0
// Checksum 0x0, Offset: 0x4aa
// Size: 0x135
function blueprintextract_createtempobjective()
{
    creatingteam = level.blueprintcreatingteam;
    level.blueprintcreatingteam = undefined;
    
    if ( !isdefined( creatingteam ) )
    {
        return;
    }
    
    objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
    
    if ( objectiveiconid != -1 )
    {
        scripts\mp\objidpoolmanager::objective_add_objective( objectiveiconid, "invisible", ( 0, 0, 0 ), "ui_mp_br_mapmenu_icon_extraction_objective" );
        scripts\mp\objidpoolmanager::objective_set_play_intro( objectiveiconid, 1 );
        scripts\mp\objidpoolmanager::update_objective_setbackground( objectiveiconid, 1 );
        
        foreach ( player in getteamdata( creatingteam, "players" ) )
        {
            if ( !player scripts\mp\gametypes\br_public::isplayeringulag() )
            {
                objective_addclienttomask( objectiveiconid, player );
            }
        }
    }
    
    starttime = gettime();
    
    while ( isdefined( self ) && gettime() - starttime < 15000 )
    {
        newpos = self.origin + ( 0, 0, 10 );
        scripts\mp\objidpoolmanager::update_objective_position( objectiveiconid, newpos );
        waitframe();
    }
    
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall( objectiveiconid );
    scripts\mp\objidpoolmanager::returnobjectiveid( objectiveiconid );
}

// Namespace br_blueprint_extract_spawn / scripts\mp\gametypes\br_blueprint_extract_spawn
// Params 0
// Checksum 0x0, Offset: 0x5e7
// Size: 0x25
function blueprintextract_cleanupwhennoavailablelocales()
{
    while ( isdefined( self ) )
    {
        if ( !scripts\mp\gametypes\br_extract_quest::extractlocale_islocaleavailable( self.origin ) )
        {
            deletescriptableinstance();
            return;
        }
        
        waitframe();
    }
}

