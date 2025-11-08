#using scripts\cp\coop_stealth;
#using scripts\cp\spawning;
#using scripts\stealth\manager;
#using scripts\stealth\utility;

#namespace enemy_cp;

// Namespace enemy_cp / namespace_f07a91c6c17492be
// Params 1
// Checksum 0x0, Offset: 0xdd
// Size: 0x117
function init( aitype )
{
    if ( scripts\cp\coop_stealth::level_should_run_sp_stealth() )
    {
        thread function_5eeb4be2b32a5c41();
    }
    
    if ( !isdefined( aitype ) )
    {
        aitype = self.agent_type;
    }
    
    if ( !scripts\cp\spawning::is_specified_unittype( "dog" ) )
    {
        self.meleechargedistvsplayer = 50;
    }
    
    if ( issubstr( aitype, "_smg" ) )
    {
    }
    else if ( issubstr( aitype, "_ar" ) )
    {
        self.maxfaceenemydist = 3000;
    }
    else if ( issubstr( aitype, "_sniper" ) )
    {
        self.maxfaceenemydist = 3000;
    }
    else if ( issubstr( aitype, "_juggernaut" ) )
    {
        self.maxfaceenemydist = 3000;
    }
    else if ( issubstr( aitype, "_shotgun" ) )
    {
    }
    else if ( issubstr( aitype, "_lmg" ) )
    {
        self.maxfaceenemydist = 3000;
    }
    else if ( issubstr( aitype, "_rpg" ) )
    {
        self.maxfaceenemydist = 3000;
    }
    else
    {
        self.maxfaceenemydist = 3000;
    }
    
    self.maxfacenewenemydist = 4000;
    function_48ea06dbce62f5b3();
}

// Namespace enemy_cp / namespace_f07a91c6c17492be
// Params 0
// Checksum 0x0, Offset: 0x1fc
// Size: 0x5a
function function_5eeb4be2b32a5c41()
{
    self endon( "death" );
    
    while ( !isdefined( self.stealth ) )
    {
        waitframe();
    }
    
    while ( !isdefined( self.stealth.funcs ) )
    {
        waitframe();
    }
    
    if ( getdvarint( @"hash_216befcb8b10d029", 0 ) != 0 )
    {
        scripts\stealth\utility::set_stealth_func( "has_lost_enemy", &function_f2c466350f598ead );
    }
}

// Namespace enemy_cp / namespace_f07a91c6c17492be
// Params 0
// Checksum 0x0, Offset: 0x25e
// Size: 0xf, Type: bool
function function_ccdad4e4232d8253()
{
    if ( scripts\stealth\manager::anyone_in_combat() )
    {
        return true;
    }
    
    return false;
}

// Namespace enemy_cp / namespace_f07a91c6c17492be
// Params 0
// Checksum 0x0, Offset: 0x276
// Size: 0x10e, Type: bool
function function_f2c466350f598ead()
{
    if ( function_ccdad4e4232d8253() )
    {
        ctimetolose = 10000;
        var_7c08dd16ffa22ba8 = 15000;
        cstillrighttheredistsq = 50625;
    }
    else
    {
        ctimetolose = 10000;
        var_7c08dd16ffa22ba8 = 15000;
        cstillrighttheredistsq = 2500;
    }
    
    curtime = gettime();
    enemy = self.enemy;
    
    if ( isdefined( enemy ) && issentient( enemy ) && isalive( enemy ) )
    {
        if ( enemy.team != "allies" )
        {
            return false;
        }
        
        lasttime = self lastknowntime( enemy );
        
        if ( curtime < lasttime + ctimetolose )
        {
            return false;
        }
        
        lastknownpostoenemy = self lastknownpos( enemy );
        
        if ( lasttime > 0 && distancesquared( enemy.origin, lastknownpostoenemy ) < cstillrighttheredistsq )
        {
            return false;
        }
        
        if ( curtime < lasttime + var_7c08dd16ffa22ba8 && enemy hastacvis( lastknownpostoenemy ) )
        {
            return false;
        }
        
        if ( istrue( self.benemyinlowcover ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace enemy_cp / namespace_f07a91c6c17492be
// Params 0
// Checksum 0x0, Offset: 0x38d
// Size: 0x57
function function_48ea06dbce62f5b3()
{
    if ( getdvarint( @"hash_880405187e0bd323", 0 ) == 0 )
    {
        return;
    }
    
    if ( !istrue( level.var_84b6efb0b4cdabd5 ) )
    {
        return;
    }
    
    if ( self [[ self.fnisinstealthcombat ]]() || self [[ self.fnisinstealthhunt ]]() )
    {
        return;
    }
    
    self [[ self.fnsetstealthstate ]]( "hunt" );
}

