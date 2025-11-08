#using scripts\common\utility;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\equipment;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;

#namespace thermite;

// Namespace thermite / scripts\mp\equipment\thermite
// Params 2
// Checksum 0x0, Offset: 0x24a
// Size: 0xcd
function thermite_used( grenade, isgl )
{
    if ( isdefined( isgl ) )
    {
        glgrenade = grenade;
        grenade = scripts\mp\utility\weapon::_launchgrenade( "thermite_mp", glgrenade.origin, ( 0, 0, 0 ) );
        scripts\mp\weapons::grenadeinitialize( grenade, makeweapon( "thermite_mp" ) );
        grenade.glgrenade = glgrenade;
        grenade.angles = glgrenade.angles;
        grenade.glgrenadeparent = self getcurrentweapon();
        grenade linkto( glgrenade );
        grenade.exploding = 1;
        grenade setscriptablepartstate( "visibility", "hide", 0 );
    }
    
    grenade thread thermite_watchdisowned();
    grenade thread thermite_watchstuck( isgl );
}

// Namespace thermite / scripts\mp\equipment\thermite
// Params 1
// Checksum 0x0, Offset: 0x31f
// Size: 0x40
function thermite_watchwater( grenade )
{
    grenade endon( "missile_stuck" );
    thrownunderwater = 0;
    
    if ( scripts\cp_mp\utility\player_utility::isswimmingunderwater() )
    {
        thrownunderwater = 1;
    }
    
    grenade waittill( "missile_water_impact" );
    
    if ( !thrownunderwater )
    {
        grenade notify( "missile_stuck" );
    }
}

// Namespace thermite / scripts\mp\equipment\thermite
// Params 1
// Checksum 0x0, Offset: 0x367
// Size: 0x38d
function thermite_watchstuck( isgl )
{
    self endon( "death" );
    stuckto = undefined;
    
    if ( istrue( isgl ) )
    {
        glstuck = thermite_watchglstuck();
        
        if ( !istrue( glstuck ) )
        {
            thread thermite_delete();
            return;
        }
        
        if ( isdefined( self.glgrenade ) )
        {
            self.glgrenade delete();
        }
    }
    else
    {
        self.owner thread thermite_watchwater( self );
        self waittill( "missile_stuck", stuckto );
    }
    
    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );
    
    if ( !istrue( isgl ) )
    {
        if ( isdefined( stuckto ) )
        {
            if ( isplayer( stuckto ) || isagent( stuckto ) )
            {
                thread scripts\mp\weapons::grenadestuckto( self, stuckto );
            }
            else
            {
                thread scripts\mp\equipment::function_4af015619e2534ba( stuckto, &thermite_destroy, 0 );
            }
        }
    }
    
    weaponobj = self.weapon_object;
    
    if ( isdefined( self.glgrenadeparent ) )
    {
        self.owner function_49967318fbd12317( weaponobj, self.glgrenadeparent );
    }
    
    thread thermite_watchstucktoterrain();
    test = self.weapon_object.attachmentblueprints;
    
    foreach ( thing in test )
    {
        test2 = 1;
    }
    
    if ( isdefined( self.weapon_object.attachmentblueprints[ "jup_equip_thermite_rec" ] ) && self.weapon_object.attachmentblueprints[ "jup_equip_thermite_rec" ].attachmentdata == "jup_equip_rec_thermite_v2083" )
    {
        self setscriptablepartstate( "effects", "impact_v1", 0 );
    }
    else
    {
        self setscriptablepartstate( "effects", "impact", 0 );
    }
    
    thermite_doradiusdamage( weaponobj );
    
    if ( !istrue( level.dangerzoneskipequipment ) && isdefined( self.owner.team ) )
    {
        self.dangerzoneid = scripts\mp\spawnlogic::addspawndangerzone( self.origin, self.bundle.var_d50a926593e2caf3, self.bundle.var_14a6a04a6414f1a2, self.owner.team, 100, self.owner, 1, self, 1 );
    }
    
    wait self.bundle.var_752b4c2699b8d484;
    var_dcba62ab4b6154ed = makeweapon( "thermite_av_mp" );
    var_dcba5cab4b6147bb = makeweapon( "thermite_ap_mp" );
    
    if ( isdefined( self.glgrenadeparent ) )
    {
        self.owner function_49967318fbd12317( var_dcba62ab4b6154ed, self.glgrenadeparent );
        self.owner function_49967318fbd12317( var_dcba5cab4b6147bb, self.glgrenadeparent );
    }
    
    ticks = 1;
    
    while ( ticks <= self.bundle.var_bfbd38a362955730 )
    {
        curtick = ticks + 1;
        
        if ( mod( curtick, 2 ) > 0 )
        {
            thermite_doradiusdamage( var_dcba62ab4b6154ed );
        }
        else
        {
            thermite_doradiusdamage( var_dcba5cab4b6147bb );
        }
        
        ticks = curtick;
        wait self.bundle.var_752b4c2699b8d484;
    }
    
    thread thermite_destroy();
}

// Namespace thermite / scripts\mp\equipment\thermite
// Params 0
// Checksum 0x0, Offset: 0x6fc
// Size: 0x109, Type: bool
function thermite_watchglstuck()
{
    self.glgrenade endon( "death" );
    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );
    self.glgrenade waittill( "missile_stuck", stuckto, stuckpart, surfacetype, velocity, position, normal );
    
    if ( isdefined( stuckto ) )
    {
        if ( isplayer( stuckto ) || isagent( stuckto ) )
        {
            if ( stuckto scripts\cp_mp\utility\player_utility::_isalive() )
            {
                if ( isplayer( stuckto ) )
                {
                    thread scripts\mp\weapons::grenadestuckto( self, stuckto );
                }
                
                if ( isdefined( stuckpart ) )
                {
                    self linkto( stuckto );
                }
                else
                {
                    self linkto( stuckto, "j_spine4", ( 0, 0, 0 ) );
                }
            }
        }
        else if ( isdefined( stuckpart ) )
        {
            self linkto( stuckto, stuckpart );
        }
        else
        {
            self linkto( stuckto );
        }
    }
    
    return true;
}

// Namespace thermite / scripts\mp\equipment\thermite
// Params 0
// Checksum 0x0, Offset: 0x80e
// Size: 0x102
function thermite_watchstucktoterrain()
{
    self endon( "death" );
    stuckto = self getlinkedparent();
    
    while ( isdefined( stuckto ) )
    {
        self waittill( "missile_stuck", stuckto );
    }
    
    if ( isdefined( level.var_85f0faee1e7958bb ) )
    {
        self.badplace = createnavbadplacebyboundsignoreteams( self.origin, ( self.bundle.var_eb23ed0231b8d2b1, self.bundle.var_eb23ed0231b8d2b1, self.bundle.var_eb23ed0231b8d2b1 ), ( 0, 0, 0 ), level.var_85f0faee1e7958bb );
        return;
    }
    
    self.badplace = createnavbadplacebybounds( self.origin, ( self.bundle.var_eb23ed0231b8d2b1, self.bundle.var_eb23ed0231b8d2b1, self.bundle.var_eb23ed0231b8d2b1 ), ( 0, 0, 0 ) );
}

// Namespace thermite / scripts\mp\equipment\thermite
// Params 1
// Checksum 0x0, Offset: 0x918
// Size: 0x15f
function thermite_doradiusdamage( weaponobj )
{
    radius = self.bundle.var_28c96dfdec697cba;
    innerdamage = self.bundle.var_4e8f75cece4d1d5a;
    outerdamage = self.bundle.var_48508dcf1e9bacd1;
    meansofdeath = "MOD_FIRE";
    
    if ( weaponobj.basename == "thermite_mp" )
    {
        radius = self.bundle.var_eb23ed0231b8d2b1;
        innerdamage = self.bundle.var_ad724d6c4e8c19f3;
        outerdamage = self.bundle.var_3c9376f5fb19f0e8;
    }
    
    stuckto = self.stuckenemyentity;
    
    if ( isdefined( stuckto ) )
    {
        if ( isplayer( stuckto ) && scripts\cp_mp\utility\player_utility::isreallyalive( stuckto ) )
        {
            stuckto dodamage( innerdamage, self.origin, self.owner, self, meansofdeath, weaponobj, "torso_upper" );
            stuckto scripts\cp_mp\utility\damage_utility::adddamagemodifier( "thermiteStuck", 0, 0, &thermite_damagemodifierignorefunc );
        }
        else
        {
            stuckto = undefined;
        }
    }
    
    self radiusdamage( self.origin, radius, innerdamage, outerdamage, self.owner, meansofdeath, weaponobj );
    
    if ( isdefined( stuckto ) )
    {
        stuckto scripts\cp_mp\utility\damage_utility::removedamagemodifier( "thermiteStuck", 0 );
    }
}

// Namespace thermite / scripts\mp\equipment\thermite
// Params 7
// Checksum 0x0, Offset: 0xa7f
// Size: 0x91, Type: bool
function thermite_damagemodifierignorefunc( inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc )
{
    if ( !isdefined( inflictor ) )
    {
        return true;
    }
    
    if ( !isdefined( inflictor.weapon_name ) || inflictor.weapon_name != "thermite_mp" )
    {
        return true;
    }
    
    if ( !isdefined( inflictor.stuckenemyentity ) || inflictor.stuckenemyentity != victim )
    {
        return true;
    }
    
    return false;
}

// Namespace thermite / scripts\mp\equipment\thermite
// Params 0
// Checksum 0x0, Offset: 0xb19
// Size: 0x30
function thermite_watchdisowned()
{
    self endon( "death" );
    self.owner waittill_any_3( "joined_team", "joined_spectators", "disconnect" );
    thread thermite_destroy();
}

// Namespace thermite / scripts\mp\equipment\thermite
// Params 1
// Checksum 0x0, Offset: 0xb51
// Size: 0x3c
function thermite_destroy( isimmediate )
{
    time = 5;
    
    if ( istrue( isimmediate ) )
    {
        time = undefined;
    }
    
    self setscriptablepartstate( "effects", "burnEnd", 0 );
    thread thermite_delete( time );
}

// Namespace thermite / scripts\mp\equipment\thermite
// Params 1
// Checksum 0x0, Offset: 0xb95
// Size: 0x87
function thermite_delete( deletiondelay )
{
    self notify( "death" );
    self.exploding = 1;
    
    if ( isdefined( self.dangerzoneid ) )
    {
        scripts\mp\spawnlogic::removespawndangerzone( self.dangerzoneid );
        self.dangerzoneid = undefined;
    }
    
    if ( isdefined( self.badplace ) )
    {
        destroynavobstacle( self.badplace );
        self.badplace = undefined;
    }
    
    self forcehidegrenadehudwarning( 1 );
    
    if ( isdefined( deletiondelay ) )
    {
        wait deletiondelay;
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace thermite / scripts\mp\equipment\thermite
// Params 1
// Checksum 0x0, Offset: 0xc24
// Size: 0x73, Type: bool
function thermite_onplayerdamaged( data )
{
    if ( data.meansofdeath == "MOD_IMPACT" )
    {
        return true;
    }
    
    data.victim.lastburntime = gettime();
    data.victim thread scripts\mp\weapons::enableburnfxfortime( 0.6 );
    data.victim scripts\mp\utility\player::codcastersetplayerstatuseffect( "fire", 0.6 );
    return true;
}

