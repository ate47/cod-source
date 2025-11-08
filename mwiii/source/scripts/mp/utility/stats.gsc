#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\utility\game;

#namespace stats;

// Namespace stats / scripts\mp\utility\stats
// Params 1
// Checksum 0x0, Offset: 0x244
// Size: 0x6d
function initpersstat( dataname )
{
    if ( !isdefined( level.var_74d2859df4e039f3 ) )
    {
        level.var_74d2859df4e039f3 = getdvarint( @"hash_ab7a3193a6878af5", 1 ) != 0;
    }
    
    if ( level.var_74d2859df4e039f3 )
    {
        if ( isplayer( self ) )
        {
            function_38472c8e1cee838( self, dataname );
            return;
        }
    }
    
    if ( !isdefined( self.pers[ dataname ] ) )
    {
        self.pers[ dataname ] = 0;
    }
}

// Namespace stats / scripts\mp\utility\stats
// Params 1
// Checksum 0x0, Offset: 0x2b9
// Size: 0x5b
function getpersstat( dataname )
{
    if ( !isdefined( level.var_30da0a8ab3edaf1f ) )
    {
        level.var_30da0a8ab3edaf1f = getdvarint( @"hash_c09b6858cb329245", 1 ) != 0;
    }
    
    if ( level.var_30da0a8ab3edaf1f )
    {
        if ( isplayer( self ) )
        {
            return function_e539214eed237be4( self, dataname );
        }
    }
    
    return self.pers[ dataname ];
}

// Namespace stats / scripts\mp\utility\stats
// Params 2
// Checksum 0x0, Offset: 0x31d
// Size: 0x8b
function incpersstat( dataname, increment )
{
    if ( disablepersupdates() )
    {
        return;
    }
    
    assertex( isplayer( self ), "<dev string:x1c>" );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( isdefined( self.leaderboarddata[ dataname ] ) )
    {
        self.leaderboarddata[ dataname ] += increment;
    }
    
    if ( isdefined( level.var_9012afffee4d9306[ dataname ] ) )
    {
        [[ level.var_9012afffee4d9306[ dataname ] ]]( self, increment );
    }
    
    incrementpersistentstat( self, dataname, increment );
}

// Namespace stats / scripts\mp\utility\stats
// Params 2
// Checksum 0x0, Offset: 0x3b0
// Size: 0x68
function initleaderboardstat( dataname, functionptr )
{
    if ( !isdefined( self.leaderboarddata[ dataname ] ) )
    {
        self.leaderboarddata[ dataname ] = 0;
    }
    
    if ( !isdefined( level.var_9012afffee4d9306 ) )
    {
        level.var_9012afffee4d9306 = [];
    }
    
    if ( isdefined( functionptr ) && !isdefined( level.var_9012afffee4d9306[ dataname ] ) )
    {
        level.var_9012afffee4d9306[ dataname ] = functionptr;
    }
}

// Namespace stats / scripts\mp\utility\stats
// Params 1
// Checksum 0x0, Offset: 0x420
// Size: 0x3d
function setextrascore0( newvalue )
{
    if ( disablepersupdates() )
    {
        return;
    }
    
    if ( newvalue >= 65000 )
    {
        newvalue = 65000;
    }
    
    self.extrascore0 = newvalue;
    self.pers[ "extrascore0" ] = newvalue;
}

// Namespace stats / scripts\mp\utility\stats
// Params 1
// Checksum 0x0, Offset: 0x465
// Size: 0x3b
function setextrascore1( newvalue )
{
    if ( disablepersupdates() )
    {
        return;
    }
    
    if ( newvalue >= 255 )
    {
        newvalue = 255;
    }
    
    self.extrascore1 = newvalue;
    self.pers[ "extrascore1" ] = newvalue;
}

// Namespace stats / scripts\mp\utility\stats
// Params 1
// Checksum 0x0, Offset: 0x4a8
// Size: 0x3d
function setextrascore2( newvalue )
{
    if ( disablepersupdates() )
    {
        return;
    }
    
    if ( newvalue >= 65000 )
    {
        newvalue = 65000;
    }
    
    self.extrascore2 = newvalue;
    self.pers[ "extrascore2" ] = newvalue;
}

// Namespace stats / scripts\mp\utility\stats
// Params 1
// Checksum 0x0, Offset: 0x4ed
// Size: 0x3d
function setextrascore3( newvalue )
{
    if ( disablepersupdates() )
    {
        return;
    }
    
    if ( newvalue >= 65000 )
    {
        newvalue = 65000;
    }
    
    self.extrascore3 = newvalue;
    self.pers[ "extrascore3" ] = newvalue;
}

// Namespace stats / scripts\mp\utility\stats
// Params 1
// Checksum 0x0, Offset: 0x532
// Size: 0x3d
function setextrascore4( newvalue )
{
    if ( disablepersupdates() )
    {
        return;
    }
    
    if ( newvalue >= 65000 )
    {
        newvalue = 65000;
    }
    
    self.extrascore4 = newvalue;
    self.pers[ "extrascore4" ] = newvalue;
}

// Namespace stats / scripts\mp\utility\stats
// Params 0
// Checksum 0x0, Offset: 0x577
// Size: 0x2d, Type: bool
function disablepersupdates()
{
    if ( istrue( game[ "practiceRound" ] ) )
    {
        return true;
    }
    
    if ( istrue( level.disablestattracking ) )
    {
        return true;
    }
    
    if ( isagent( self ) )
    {
        return true;
    }
    
    return false;
}

// Namespace stats / scripts\mp\utility\stats
// Params 0
// Checksum 0x0, Offset: 0x5ad
// Size: 0x3e
function function_785a9aed533e514c()
{
    if ( level.leagueplaymatch )
    {
        return "leagueplayprogression";
    }
    
    if ( level.var_77907d733abe8b63 && getdvarint( @"wz_leagueplay_progression_enabled", 0 ) )
    {
        return "leagueplayprogression";
    }
    
    return "mp";
}

// Namespace stats / scripts\mp\utility\stats
// Params 0
// Checksum 0x0, Offset: 0x5f4
// Size: 0x1db
function getplayerdataloadoutgroup()
{
    if ( istrue( level.leagueplaymatch ) )
    {
        if ( getdvarint( @"hash_6299be121597b3c5", 0 ) )
        {
            return "leagueplayloadouts";
        }
        else
        {
            return "rankedloadouts";
        }
    }
    else if ( istrue( level.var_77907d733abe8b63 ) )
    {
        if ( getdvarint( @"wz_leagueplay_loadouts_enabled", 0 ) )
        {
            return "wzleagueplayloadouts";
        }
        else
        {
            return "wzrankedloadouts";
        }
    }
    
    var_7377d0f486a012d0 = scripts\cp_mp\utility\game_utility::isbrstylegametype() || getgametype() == "ballmode";
    
    if ( level.rankedmatch && ( !scripts\mp\utility\game::isanymlgmatch() || getdvarint( @"hash_6037589ac3376ef3", 0 ) ) )
    {
        if ( !getdvarint( @"hash_6dd8fb66d1032ceb", 0 ) )
        {
            if ( isdefined( level.gametypebundle ) && isdefined( level.gametypebundle.var_7dfb2f7ad76e0d5 ) )
            {
                return level.gametypebundle.var_7dfb2f7ad76e0d5;
            }
            
            if ( isdefined( level.gamemodebundle ) && isdefined( level.gamemodebundle.var_7dfb2f7ad76e0d5 ) )
            {
                return level.gamemodebundle.var_7dfb2f7ad76e0d5;
            }
        }
        
        if ( var_7377d0f486a012d0 )
        {
            return "wzrankedloadouts";
        }
        else
        {
            return "rankedloadouts";
        }
    }
    
    if ( !getdvarint( @"hash_6dd8fb66d1032ceb", 0 ) )
    {
        if ( isdefined( level.gametypebundle ) && isdefined( level.gametypebundle.var_713cf903b125c101 ) )
        {
            return level.gametypebundle.var_713cf903b125c101;
        }
        
        if ( isdefined( level.gamemodebundle ) && isdefined( level.gamemodebundle.var_713cf903b125c101 ) )
        {
            return level.gamemodebundle.var_713cf903b125c101;
        }
    }
    
    if ( var_7377d0f486a012d0 )
    {
        return "wzprivateloadouts";
    }
    
    return "privateloadouts";
}

// Namespace stats / scripts\mp\utility\stats
// Params 0
// Checksum 0x0, Offset: 0x7d7
// Size: 0x112
function function_cd79d5c7c340b40e()
{
    if ( !getdvarint( @"hash_6dd8fb66d1032ceb", 0 ) )
    {
        if ( isdefined( level.gametypebundle ) )
        {
            if ( level.rankedmatch && isdefined( level.gametypebundle.var_3d1f074daf608448 ) )
            {
                return level.gametypebundle.var_3d1f074daf608448;
            }
            else if ( isdefined( level.gametypebundle.var_13a8bce3a0b4279e ) )
            {
                return level.gametypebundle.var_13a8bce3a0b4279e;
            }
        }
        
        if ( isdefined( level.gamemodebundle ) )
        {
            if ( level.rankedmatch && isdefined( level.gamemodebundle.var_3d1f074daf608448 ) )
            {
                return level.gamemodebundle.var_3d1f074daf608448;
            }
            else if ( isdefined( level.gamemodebundle.var_13a8bce3a0b4279e ) )
            {
                return level.gamemodebundle.var_13a8bce3a0b4279e;
            }
        }
    }
    
    if ( function_fbadc58163719d2b() )
    {
        return "mp";
    }
    
    return level.loadoutsgroup;
}

// Namespace stats / scripts\mp\utility\stats
// Params 0
// Checksum 0x0, Offset: 0x8f2
// Size: 0x35, Type: bool
function function_fbadc58163719d2b()
{
    return ( getsubgametype() == "dmz" || getsubgametype() == "exgm" ) && getdvarint( @"hash_bb9178da63ce4b9", 1 ) == 1;
}

// Namespace stats / scripts\mp\utility\stats
// Params 0
// Checksum 0x0, Offset: 0x930
// Size: 0x2f
function setplayerdatagroups()
{
    level.progressiongroup = function_785a9aed533e514c();
    level.loadoutsgroup = getplayerdataloadoutgroup();
    level.loadoutdata = function_cd79d5c7c340b40e();
}

// Namespace stats / scripts\mp\utility\stats
// Params 0
// Checksum 0x0, Offset: 0x967
// Size: 0x3e, Type: bool
function canrecordcombatrecordstats()
{
    if ( scripts\cp_mp\utility\game_utility::isinfectedgametype() )
    {
        return false;
    }
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() && !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        return false;
    }
    
    return level.rankedmatch && !istrue( level.ignorescoring );
}

// Namespace stats / scripts\mp\utility\stats
// Params 1
// Checksum 0x0, Offset: 0x9ae
// Size: 0x46
function getstreakrecordtype( streakname )
{
    if ( isenumvaluevalid( level.progressiongroup, "LethalScorestreakStatItems", streakname ) )
    {
        return "lethalScorestreakStats";
    }
    
    if ( isenumvaluevalid( level.progressiongroup, "SupportScorestreakStatItems", streakname ) )
    {
        return "supportScorestreakStats";
    }
    
    return undefined;
}

