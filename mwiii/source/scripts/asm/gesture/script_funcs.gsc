#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\utility;

#namespace script_funcs;

// Namespace script_funcs / scripts\asm\gesture\script_funcs
// Params 4
// Checksum 0x0, Offset: 0xb7
// Size: 0x37, Type: bool
function ai_gesture_requested( asmname, statename, tostatename, params )
{
    return istrue( self._blackboard.gesture_active );
}

// Namespace script_funcs / scripts\asm\gesture\script_funcs
// Params 4
// Checksum 0x0, Offset: 0xf7
// Size: 0x37, Type: bool
function ai_point_gesture_requested( asmname, statename, tostatename, params )
{
    return istrue( self._blackboard.point_gesture_active );
}

// Namespace script_funcs / scripts\asm\gesture\script_funcs
// Params 0
// Checksum 0x0, Offset: 0x137
// Size: 0xd
function ai_lookat_hold()
{
    self.hold_lookat = 1;
}

// Namespace script_funcs / scripts\asm\gesture\script_funcs
// Params 0
// Checksum 0x0, Offset: 0x14c
// Size: 0xc
function ai_lookat_release()
{
    self.hold_lookat = undefined;
}

// Namespace script_funcs / scripts\asm\gesture\script_funcs
// Params 0
// Checksum 0x0, Offset: 0x160
// Size: 0x17
function ai_can_lookat()
{
    if ( isdefined( self.hold_lookat ) )
    {
        return 0;
    }
    
    return 1;
}

// Namespace script_funcs / scripts\asm\gesture\script_funcs
// Params 5
// Checksum 0x0, Offset: 0x17f
// Size: 0x38
function float_remap( value, from1, to1, from2, to2 )
{
    return ( value - from1 ) / ( to1 - from1 ) * ( to2 - from2 ) + from2;
}

// Namespace script_funcs / scripts\asm\gesture\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x1c0
// Size: 0x22
function lerp_float( from, to, delta )
{
    return from + delta * ( to - from );
}

// Namespace script_funcs / scripts\asm\gesture\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x1eb
// Size: 0x3e
function smoothstep( start, end, delta )
{
    delta = clamp( ( delta - start ) / ( end - start ), 0, 1 );
    return delta * delta * ( 3 - 2 * delta );
}

