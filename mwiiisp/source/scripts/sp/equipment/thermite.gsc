#using scripts\sp\equipment\offhands;
#using scripts\sp\utility;

#namespace thermite;

// Namespace thermite / scripts\sp\equipment\thermite
// Params 1
// Checksum 0x0, Offset: 0xd1
// Size: 0x18
function precache( offhand )
{
    registeroffhandfirefunc( offhand, &function_e4f132e4caa48e7e );
}

// Namespace thermite / scripts\sp\equipment\thermite
// Params 2
// Checksum 0x0, Offset: 0xf1
// Size: 0x2c
function function_e4f132e4caa48e7e( grenade, weapon )
{
    grenade endon( "thermite_deleted" );
    thread thermite_used( grenade );
    grenade thread notifyondelete();
}

// Namespace thermite / scripts\sp\equipment\thermite
// Params 0
// Checksum 0x0, Offset: 0x125
// Size: 0x1f
function notifyondelete()
{
    self endon( "explode" );
    
    while ( isdefined( self ) )
    {
        wait 0.05;
    }
    
    self notify( "thermite_deleted" );
}

// Namespace thermite / scripts\sp\equipment\thermite
// Params 2
// Checksum 0x0, Offset: 0x14c
// Size: 0x22
function thermite_used( grenade, isgl )
{
    if ( isdefined( isgl ) )
    {
    }
    
    grenade thread thermite_watchstuck( isgl );
}

// Namespace thermite / scripts\sp\equipment\thermite
// Params 1
// Checksum 0x0, Offset: 0x176
// Size: 0xbe
function thermite_watchstuck( isgl )
{
    self endon( "death" );
    stuckto = undefined;
    self waittill( "missile_stuck", stuckto );
    weaponobj = scripts\sp\utility::make_weapon( "thermite_sp" );
    thread thermite_watchstucktoterrain();
    self setscriptablepartstate( "effects", "impact", 0 );
    thermite_doradiusdamage( weaponobj );
    wait 0.5;
    ticks = 1;
    
    while ( ticks <= 10 )
    {
        curtick = ticks + 1;
        
        if ( mod( curtick, 2 ) > 0 )
        {
            thermite_doradiusdamage( weaponobj );
        }
        else
        {
            thermite_doradiusdamage( weaponobj );
        }
        
        ticks = curtick;
        wait 0.5;
    }
    
    thread thermite_destroy();
}

// Namespace thermite / scripts\sp\equipment\thermite
// Params 0
// Checksum 0x0, Offset: 0x23c
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

// Namespace thermite / scripts\sp\equipment\thermite
// Params 1
// Checksum 0x0, Offset: 0x2a1
// Size: 0x80
function thermite_doradiusdamage( weaponobj )
{
    radius = 125;
    innerdamage = 25;
    outerdamage = 10;
    meansofdeath = "MOD_FIRE";
    
    if ( weaponobj.basename == "thermite_sp" )
    {
        radius = 125;
        innerdamage = 30;
        outerdamage = 30;
    }
    
    self radiusdamage( self.origin, radius, innerdamage, outerdamage, self.owner, meansofdeath, weaponobj );
}

// Namespace thermite / scripts\sp\equipment\thermite
// Params 0
// Checksum 0x0, Offset: 0x329
// Size: 0x1e
function thermite_destroy()
{
    self setscriptablepartstate( "effects", "burnEnd", 0 );
    thread thermite_delete( 5 );
}

// Namespace thermite / scripts\sp\equipment\thermite
// Params 1
// Checksum 0x0, Offset: 0x34f
// Size: 0x5b
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
    
    if ( isdefined( deletiondelay ) )
    {
        wait deletiondelay;
    }
    
    self delete();
}

// Namespace thermite / scripts\sp\equipment\thermite
// Params 2
// Checksum 0x0, Offset: 0x3b2
// Size: 0x39
function mod( dividend, divisor )
{
    q = int( dividend / divisor );
    
    if ( dividend * divisor < 0 )
    {
        q -= 1;
    }
    
    return dividend - q * divisor;
}

