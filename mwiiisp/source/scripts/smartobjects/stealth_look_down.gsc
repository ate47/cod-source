#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\smartobjects\utility;

#namespace stealth_look_down;

// Namespace stealth_look_down / scripts\smartobjects\stealth_look_down
// Params 0
// Checksum 0x0, Offset: 0xc8
// Size: 0x18
function main()
{
    add_smartobject_type( "stealth_look_down", &getinfo, &canusecondition );
}

// Namespace stealth_look_down / scripts\smartobjects\stealth_look_down
// Params 1
// Checksum 0x0, Offset: 0xe8
// Size: 0x19, Type: bool
function canusecondition( object )
{
    if ( !canusesmartobject_stealth( object ) )
    {
        return false;
    }
    
    return true;
}

// Namespace stealth_look_down / scripts\smartobjects\stealth_look_down
// Params 0
// Checksum 0x0, Offset: 0x10a
// Size: 0x9c
function getinfo()
{
    struct = createsmartobjectinfo();
    struct.animstatename = "smartobject_look_down";
    struct addsmartobjectintroanim( "enter_loop" );
    struct addsmartobjectanim( "loop" );
    struct addsmartobjectoutroanim( "exit_loop" );
    struct addsmartobjectdeathanim( "death" );
    struct addsmartobjectreactanim();
    struct addsmartobjectpainanim();
    struct.radiussqrd = squared( 400 );
    struct.fninterrupt = &onenemy;
    struct.nextusetime = 60;
    return struct;
}

// Namespace stealth_look_down / scripts\smartobjects\stealth_look_down
// Params 0
// Checksum 0x0, Offset: 0x1af
// Size: 0x13, Type: bool
function onenemy()
{
    if ( !isdefined( self.enemy ) )
    {
        return false;
    }
    
    return true;
}

