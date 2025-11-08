#using scripts\aitypes\bt_util;
#using scripts\aitypes\combat;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace melee;

// Namespace melee / scripts\aitypes\melee
// Params 1
// Checksum 0x0, Offset: 0x164
// Size: 0x60
function initmeleefunctions( taskid )
{
    self.meleerangesq = 6724;
    self.meleechargedistvsplayer = 100;
    self.meleeactorboundsradius = 32;
    self.acceptablemeleefraction = 0.98;
    self.fnismeleevalid = &ismeleevalid;
    self.fncanmovefrompointtopoint = &canmovefrompointtopoint;
    return anim.success;
}

// Namespace melee / scripts\aitypes\melee
// Params 2
// Checksum 0x0, Offset: 0x1cd
// Size: 0x1e
function canmovefrompointtopoint( start, end )
{
    return self maymovefrompointtopoint( start, end, 0, 1 );
}

// Namespace melee / scripts\aitypes\melee
// Params 1
// Checksum 0x0, Offset: 0x1f4
// Size: 0x21
function meleedeathhandler( enemy )
{
    self endon( "melee_finished" );
    self waittill( "terminate_ai_threads" );
    bb_clearmeleetarget();
}

// Namespace melee / scripts\aitypes\melee
// Params 0
// Checksum 0x0, Offset: 0x21d
// Size: 0x12
function melee_destroy()
{
    self clearbtgoal( 3 );
    self function_bdcb37a9431e654();
}

// Namespace melee / scripts\aitypes\melee
// Params 1
// Checksum 0x0, Offset: 0x237
// Size: 0x59
function getmeleechargerange( target )
{
    if ( isplayer( target ) )
    {
        var_a8dde70c8a3396f3 = self.meleechargedistvsplayer;
    }
    else
    {
        var_a8dde70c8a3396f3 = self.meleechargedist;
    }
    
    if ( !hasammoinclip() )
    {
        reloadmultiplier = self.meleechargedistreloadmultiplier;
        var_a8dde70c8a3396f3 *= reloadmultiplier;
    }
    
    return var_a8dde70c8a3396f3;
}

// Namespace melee / scripts\aitypes\melee
// Params 1
// Checksum 0x0, Offset: 0x299
// Size: 0xd2
function gettargetchargepos( target )
{
    assert( isdefined( target ) );
    targetpos = target.origin;
    metotarget = target.origin - self.origin;
    metotarget = vectornormalize( metotarget );
    targetpos -= metotarget * self.meleeactorboundsradius;
    targetposdropped = getclosestpointonnavmesh( targetpos, self );
    
    if ( abs( targetpos[ 2 ] - targetposdropped[ 2 ] ) > self.maxzdiff )
    {
        return undefined;
    }
    
    traceresults = navtrace( self.origin, targetposdropped, self, 1 );
    fraction = traceresults[ "fraction" ];
    
    if ( fraction < self.acceptablemeleefraction )
    {
        return undefined;
    }
    
    return targetposdropped;
}

// Namespace melee / scripts\aitypes\melee
// Params 0
// Checksum 0x0, Offset: 0x374
// Size: 0x67
function canmeleeduringstealth()
{
    if ( isdefined( self.ent_flag ) && isdefined( self.ent_flag[ "_stealth_enabled" ] ) && self.ent_flag[ "_stealth_enabled" ] )
    {
        if ( isdefined( self.ent_flag[ "_stealth_attack" ] ) && !self.ent_flag[ "_stealth_attack" ] )
        {
            return 0;
        }
    }
    
    return anim.success;
}

// Namespace melee / scripts\aitypes\melee
// Params 1
// Checksum 0x0, Offset: 0x3e4
// Size: 0xb1, Type: bool
function iseitherofusalreadyinmelee( optionaltargetoverride )
{
    meleetarget = self.enemy;
    
    if ( isdefined( optionaltargetoverride ) )
    {
        meleetarget = optionaltargetoverride;
    }
    
    if ( self.in_melee )
    {
        return true;
    }
    
    if ( meleetarget.in_melee )
    {
        if ( !isdefined( meleetarget.meleepartner ) )
        {
            if ( isplayer( meleetarget ) )
            {
                meleetarget function_bdcb37a9431e654();
            }
            else
            {
                assert( isdefined( meleetarget.var_42c47bf5f8a7fdf6 ) || meleetarget.var_4ecd594ae357f55b || istrue( meleetarget.var_9aedaf1da799bd67 ), "MeleeTarget has an invalid melee partner defined!" );
            }
        }
        
        if ( meleetarget.in_melee )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace melee / scripts\aitypes\melee
// Params 1
// Checksum 0x0, Offset: 0x49e
// Size: 0x94, Type: bool
function ismeleerangevalid( target )
{
    assert( isdefined( self.meleemaxzdiff ) );
    
    if ( abs( target.origin[ 2 ] - self.origin[ 2 ] ) > self.meleemaxzdiff )
    {
        return false;
    }
    
    chargedist = getmeleechargerange( target );
    chargedistsq = chargedist * chargedist;
    enemydistancesq = distancesquared( self.origin, target.origin );
    return enemydistancesq <= chargedistsq;
}

// Namespace melee / scripts\aitypes\melee
// Params 2
// Checksum 0x0, Offset: 0x53b
// Size: 0x52, Type: bool
function ismeleevalid_common( target, var_92493ae5a92d3699 )
{
    if ( istrue( self.dontmelee ) )
    {
        return false;
    }
    
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    if ( istrue( target.dontmelee ) )
    {
        return false;
    }
    
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( !isalive( target ) )
    {
        return false;
    }
    
    return true;
}

// Namespace melee / scripts\aitypes\melee
// Params 2
// Checksum 0x0, Offset: 0x596
// Size: 0x3c8, Type: bool
function ismeleevalid( target, var_92493ae5a92d3699 )
{
    if ( !ismeleevalid_common( target, var_92493ae5a92d3699 ) )
    {
        return false;
    }
    
    if ( var_92493ae5a92d3699 )
    {
        if ( isdefined( self.a.onback ) || self.currentpose == "prone" )
        {
            return false;
        }
        
        if ( !scripts\asm\shared\utility::melee_checktimer( self.unittype, 1 ) )
        {
            return false;
        }
        
        if ( isdefined( self.pathgoalpos ) && self.facemotion && lengthsquared( self.velocity ) > 1 )
        {
            metotarget = target.origin - self.origin;
            distmetotarget = length( metotarget );
            
            if ( distmetotarget > 60 )
            {
                metotarget /= distmetotarget;
                lookaheadpos = self getposonpath( 30 );
                var_81c732b62ff30ed4 = vectornormalize( lookaheadpos - self.origin );
                
                if ( vectordot( var_81c732b62ff30ed4, metotarget ) < -0.5 )
                {
                    return false;
                }
            }
        }
    }
    
    if ( isdefined( self.grenade ) && self.frontshieldanglecos == 1 )
    {
        return false;
    }
    
    if ( isdefined( self.lastfailedmeleechargetarget ) && self.enemy == self.lastfailedmeleechargetarget && gettime() <= self.nextmeleechecktime )
    {
        return false;
    }
    
    if ( istrue( target.dontattackme ) || istrue( target.ignoreme ) || istrue( target.dontmeleeme ) )
    {
        return false;
    }
    
    if ( !isai( target ) && !isplayer( target ) )
    {
        return false;
    }
    
    if ( isdefined( self.meleealwayswin ) && isdefined( target.meleealwayswin ) )
    {
        return false;
    }
    
    if ( isdefined( self.meleealwayswin ) && isdefined( target.magic_bullet_shield ) || isdefined( target.meleealwayswin ) && isdefined( self.magic_bullet_shield ) )
    {
        return false;
    }
    
    var_55f3401ee64f60b1 = 0;
    
    if ( isagent( target ) )
    {
        if ( istrue( self.bsoldier ) )
        {
            var_55f3401ee64f60b1 = 1;
        }
    }
    else if ( !isbot( target ) )
    {
        var_55f3401ee64f60b1 = isai( target );
    }
    
    if ( var_55f3401ee64f60b1 )
    {
        if ( target isinscriptedstate() )
        {
            return false;
        }
        
        if ( target scripts\engine\utility::doinglongdeath() || target.delayeddeath )
        {
            return false;
        }
        
        assert( isdefined( self.stairsstate ) );
        assert( isdefined( target.stairsstate ) );
        
        if ( self.stairsstate != "none" || target.stairsstate != "none" )
        {
            return false;
        }
        
        if ( target.unittype != "soldier" && target.unittype != "civilian" && target.unittype != "juggernaut" )
        {
            return false;
        }
    }
    
    if ( !isdefined( self.meleeignoreplayerstance ) || !self.meleeignoreplayerstance || !isplayer( target ) )
    {
        if ( isplayer( target ) )
        {
            enemypose = target getstance();
        }
        else
        {
            enemypose = target.currentpose;
        }
        
        if ( enemypose != "stand" && enemypose != "crouch" )
        {
            return false;
        }
    }
    
    if ( isdefined( self.magic_bullet_shield ) && isdefined( target.magic_bullet_shield ) )
    {
        return false;
    }
    
    if ( isdefined( target.grenade ) )
    {
        return false;
    }
    
    if ( isdefined( target.lowcovervolume ) && istrue( target.underlowcover ) )
    {
        return false;
    }
    
    return true;
}

