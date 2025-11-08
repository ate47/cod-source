#using scripts\common\utility;
#using scripts\cp\cp_weapons;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;

#namespace cp_thermite;

// Namespace cp_thermite / scripts\cp\equipment\cp_thermite
// Params 3
// Checksum 0x0, Offset: 0x1b3
// Size: 0xd6
function thermite_used( grenade, isgl, var_d4fbc5be3b7d6578 )
{
    if ( isdefined( isgl ) )
    {
        glgrenade = grenade;
        grenade = self launchgrenade( "thermite_mp", glgrenade.origin, ( 0, 0, 0 ) );
        grenade.glgrenade = glgrenade;
        grenade.angles = glgrenade.angles;
        grenade.owner = self;
        grenade.classname = "thermite_mp";
        grenade linkto( glgrenade );
        grenade setscriptablepartstate( "visibility", "hide", 0 );
    }
    
    grenade.grenade_owner_name = self.name;
    grenade thread thermite_watchdisowned();
    grenade thread thermite_watchstuck( isgl, var_d4fbc5be3b7d6578 );
}

// Namespace cp_thermite / scripts\cp\equipment\cp_thermite
// Params 2
// Checksum 0x0, Offset: 0x291
// Size: 0x203
function thermite_watchstuck( isgl, var_d4fbc5be3b7d6578 )
{
    self endon( "death" );
    self.ignore_fire_armor_check = 1;
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
        if ( isdefined( self.owner ) )
        {
            self.owner thread thermite_watchwater( self );
        }
        
        self waittill( "missile_stuck", stuckto, stuckpart );
        
        if ( istrue( var_d4fbc5be3b7d6578 ) )
        {
            thermite_linktostuck( stuckto, stuckpart );
        }
    }
    
    level notify( "grenade_exploded_during_stealth", self, "thermite_mp", self.grenade_owner_name );
    
    if ( isdefined( self.owner ) )
    {
        self.owner endon( "disconnect" );
        self.owner endon( "joined_team" );
        self.owner endon( "joined_spectators" );
    }
    
    if ( !istrue( isgl ) )
    {
        if ( isdefined( stuckto ) && !isplayer( stuckto ) )
        {
            thread scripts\cp\weapon::function_4af015619e2534ba( stuckto, &thermite_destroy, 0 );
        }
    }
    
    thread thermite_watchstucktoterrain();
    self setscriptablepartstate( "effects", "impact", 0 );
    self setscriptablepartstate( "damage", "impact", 0 );
    weaponobj = makeweapon( "thermite_mp" );
    thermite_doradiusdamage( weaponobj );
    wait 0.5;
    var_dcba62ab4b6154ed = makeweapon( "thermite_av_mp" );
    var_dcba5cab4b6147bb = makeweapon( "thermite_ap_mp" );
    ticks = 1;
    
    while ( ticks <= 10 )
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
        wait 0.5;
    }
    
    thread thermite_destroy();
}

// Namespace cp_thermite / scripts\cp\equipment\cp_thermite
// Params 1
// Checksum 0x0, Offset: 0x49c
// Size: 0xfc
function thermite_doradiusdamage( weaponobj )
{
    radius = 125;
    innerdamage = 25;
    outerdamage = 10;
    meansofdeath = "MOD_FIRE";
    
    if ( weaponobj.basename == "thermite_mp" )
    {
        radius = 125;
        innerdamage = 30;
        outerdamage = 30;
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

// Namespace cp_thermite / scripts\cp\equipment\cp_thermite
// Params 1
// Checksum 0x0, Offset: 0x5a0
// Size: 0x3f
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

// Namespace cp_thermite / scripts\cp\equipment\cp_thermite
// Params 7
// Checksum 0x0, Offset: 0x5e7
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

// Namespace cp_thermite / scripts\cp\equipment\cp_thermite
// Params 0
// Checksum 0x0, Offset: 0x681
// Size: 0x9b, Type: bool
function thermite_watchglstuck()
{
    self.glgrenade endon( "death" );
    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );
    self.glgrenade waittill( "missile_stuck", stuckto, stuckpart, surfacetype, velocity, position, normal );
    thermite_linktostuck( stuckto, stuckpart );
    return true;
}

// Namespace cp_thermite / scripts\cp\equipment\cp_thermite
// Params 0
// Checksum 0x0, Offset: 0x725
// Size: 0x5d
function thermite_watchstucktoterrain()
{
    self endon( "death" );
    stuckto = self getlinkedparent();
    
    while ( isdefined( stuckto ) )
    {
        self waittill( "missile_stuck", stuckto );
    }
    
    self.badplace = createnavbadplacebybounds( self.origin, ( 125, 125, 125 ), ( 0, 0, 0 ) );
}

// Namespace cp_thermite / scripts\cp\equipment\cp_thermite
// Params 2
// Checksum 0x0, Offset: 0x78a
// Size: 0x93
function thermite_linktostuck( stuckto, stuckpart )
{
    if ( isdefined( stuckto ) )
    {
        if ( isplayer( stuckto ) || isagent( stuckto ) )
        {
            if ( stuckto scripts\cp_mp\utility\player_utility::_isalive() )
            {
                if ( isdefined( stuckpart ) )
                {
                    self linkto( stuckto, stuckpart );
                }
                else
                {
                    self linkto( stuckto, "j_spine", ( 0, 0, 0 ) );
                }
                
                if ( isplayer( stuckto ) )
                {
                    stuckto thread scripts\cp\cp_weapons::enableburnfxfortime( 0.6 );
                }
            }
            
            return;
        }
        
        if ( isdefined( stuckpart ) )
        {
            self linkto( stuckto, stuckpart );
            return;
        }
        
        self linkto( stuckto );
    }
}

// Namespace cp_thermite / scripts\cp\equipment\cp_thermite
// Params 0
// Checksum 0x0, Offset: 0x825
// Size: 0x30
function thermite_watchdisowned()
{
    self endon( "death" );
    self.owner waittill_any_3( "joined_team", "joined_spectators", "disconnect" );
    thread thermite_destroy();
}

// Namespace cp_thermite / scripts\cp\equipment\cp_thermite
// Params 1
// Checksum 0x0, Offset: 0x85d
// Size: 0x77
function thermite_destroy( isimmediate )
{
    stuckto = self getlinkedparent();
    
    if ( isdefined( stuckto ) && isplayer( stuckto ) )
    {
        if ( istrue( stuckto.inlaststand ) )
        {
            stuckto thread thermite_laststand_effects();
        }
    }
    
    time = 5;
    
    if ( istrue( isimmediate ) )
    {
        time = 0;
    }
    
    thread thermite_delete( time );
    self setscriptablepartstate( "effects", "burnEnd", 0 );
}

// Namespace cp_thermite / scripts\cp\equipment\cp_thermite
// Params 1
// Checksum 0x0, Offset: 0x8dc
// Size: 0x56
function thermite_delete( deletiondelay )
{
    self notify( "death" );
    self.exploding = 1;
    
    if ( isdefined( self.badplace ) )
    {
        destroynavobstacle( self.badplace );
        self.badplace = undefined;
    }
    
    self forcehidegrenadehudwarning( 1 );
    wait deletiondelay;
    self delete();
}

// Namespace cp_thermite / scripts\cp\equipment\cp_thermite
// Params 1
// Checksum 0x0, Offset: 0x93a
// Size: 0x3c, Type: bool
function thermite_onplayerdamaged( data )
{
    if ( data.meansofdeath == "MOD_IMPACT" )
    {
        return true;
    }
    
    data.victim thread scripts\cp\cp_weapons::enableburnfxfortime( 0.6 );
    return true;
}

// Namespace cp_thermite / scripts\cp\equipment\cp_thermite
// Params 0
// Checksum 0x0, Offset: 0x97f
// Size: 0x23
function thermite_laststand_effects()
{
    self endon( "disconnect" );
    self notify( "newBurnFXLaststand" );
    self endon( "newBurnFXLaststand" );
    waitframe();
    thread scripts\cp\cp_weapons::enableburnfxfortime( 4 );
}

