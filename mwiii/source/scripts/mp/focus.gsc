#using scripts\common\utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\utility\player;
#using scripts\mp\utility\spawn_event_aggregator;

#namespace focus;

// Namespace focus / scripts\mp\focus
// Params 0
// Checksum 0x0, Offset: 0x141
// Size: 0xe
function init()
{
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback( &onplayerspawned );
}

// Namespace focus / scripts\mp\focus
// Params 0
// Checksum 0x0, Offset: 0x157
// Size: 0x22
function onplayerspawned()
{
    self.focus = 0;
    self.focuslasttime = -99999;
    thread managefocus();
}

// Namespace focus / scripts\mp\focus
// Params 0
// Checksum 0x0, Offset: 0x181
// Size: 0x34
function managefocus()
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    while ( true )
    {
        while ( !self isholdingbreath() )
        {
            waitframe();
        }
        
        childthread watchforfire();
        dofocus();
    }
}

// Namespace focus / scripts\mp\focus
// Params 0
// Checksum 0x0, Offset: 0x1bd
// Size: 0x5e
function dofocus()
{
    var_663dab9b536c9a71 = !istrue( level.wpinprogress );
    
    if ( var_663dab9b536c9a71 )
    {
        self.focus = 1;
        focusvision();
    }
    
    while ( self isholdingbreath() )
    {
        waitframe();
    }
    
    self notify( "stop_focus_fire_watcher" );
    
    if ( var_663dab9b536c9a71 )
    {
        self.focus = 0;
        restorebasevisionset( 0.35 );
    }
}

// Namespace focus / scripts\mp\focus
// Params 0
// Checksum 0x0, Offset: 0x223
// Size: 0x1f
function watchforfire()
{
    self endon( "stop_focus_fire_watcher" );
    self waittill( "weapon_fired" );
    self.focuslasttime = gettime();
}

// Namespace focus / scripts\mp\focus
// Params 0
// Checksum 0x0, Offset: 0x24a
// Size: 0xa1
function function_bd0d33f283ede2f8()
{
    weapontype = scripts\cp_mp\weapon::getweaponclasstoken( self.currentweapon.basename );
    
    switch ( weapontype )
    {
        case #"hash_fa0ed9f6bd4f4e9a":
        case #"hash_fa18d2f6bd57925a":
        case #"hash_fa21c4f6bd5e3815":
        case #"hash_fa27b9f6bd62a3f2":
        case #"hash_fa4dbdf6bd80bf52":
        case #"hash_fa50b4f6bd82efbe":
        case #"hash_fa50b6f6bd82f2e4":
        case #"hash_fa50b9f6bd82f79d":
            return 1;
        default:
            return 0;
    }
}

// Namespace focus / scripts\mp\focus
// Params 0
// Checksum 0x0, Offset: 0x2f3
// Size: 0x13
function focusvision()
{
    self visionsetnakedforplayer( "focus", 0.57 );
}

