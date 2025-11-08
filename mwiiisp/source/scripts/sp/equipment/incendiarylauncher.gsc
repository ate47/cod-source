#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\molotov;
#using scripts\sp\utility;

#namespace incendiarylauncher;

// Namespace incendiarylauncher / scripts\sp\equipment\incendiarylauncher
// Params 0
// Checksum 0x0, Offset: 0xed
// Size: 0x13
function init()
{
    level.player thread firemanager();
}

// Namespace incendiarylauncher / scripts\sp\equipment\incendiarylauncher
// Params 0
// Checksum 0x0, Offset: 0x108
// Size: 0x113
function firemanager()
{
    self.offhands = spawnstruct();
    self.offhands.lastusedoffhandweapon = undefined;
    self.offhands.lastusedoffhandtime = 0;
    
    while ( true )
    {
        has_gl = 0;
        self waittill( "missile_fire", missile, weapon );
        attachmentnames = getweaponattachments( weapon );
        
        if ( isdefined( attachmentnames ) && attachmentnames.size > 0 )
        {
            foreach ( attachment in attachmentnames )
            {
                if ( issubstr( attachment, "gl" ) )
                {
                    has_gl = 1;
                }
            }
        }
        
        if ( weapon.basename == "iw8_la_mike32_incendiary" )
        {
            missile thread watchforimpact( "explode" );
            continue;
        }
        
        if ( has_gl )
        {
            missile thread watchforimpact( "missile_stuck" );
        }
    }
}

// Namespace incendiarylauncher / scripts\sp\equipment\incendiarylauncher
// Params 1
// Checksum 0x0, Offset: 0x223
// Size: 0xcd
function watchforimpact( msg )
{
    self endon( "entitydeleted" );
    owner = getmissileowner( self );
    
    if ( msg == "missile_stuck" )
    {
        self waittill( "missile_stuck", stuckto, hitentpart, surfacetype, velocity, origin, normal );
        
        if ( distance2d( owner.origin, origin ) > 200 )
        {
            scripts\sp\equipment\molotov::molotovexplode( origin, normal, velocity, stuckto, owner );
        }
        else
        {
            self delete();
        }
        
        return;
    }
    
    self waittill( msg, origin, normal, velocity, entity );
    scripts\sp\equipment\molotov::molotovexplode( origin, normal, velocity, entity, owner );
}

