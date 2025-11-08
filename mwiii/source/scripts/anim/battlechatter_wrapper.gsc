#using scripts\anim\battlechatter;
#using scripts\anim\utility_common;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace battlechatter_wrapper;

// Namespace battlechatter_wrapper / scripts\anim\battlechatter_wrapper
// Params 1
// Checksum 0x0, Offset: 0xbd
// Size: 0xb
function evaluatemoveevent( var_76af5757c71b312c )
{
    
}

// Namespace battlechatter_wrapper / scripts\anim\battlechatter_wrapper
// Params 0
// Checksum 0x0, Offset: 0xd0
// Size: 0x2
function evaluatereloadevent()
{
    
}

// Namespace battlechatter_wrapper / scripts\anim\battlechatter_wrapper
// Params 2
// Checksum 0x0, Offset: 0xda
// Size: 0x2a
function function_f56c2de6db70455f( enemytype, enemy )
{
    executeevent( "spotted", [ enemytype, enemy ] );
}

// Namespace battlechatter_wrapper / scripts\anim\battlechatter_wrapper
// Params 1
// Checksum 0x0, Offset: 0x10c
// Size: 0x18
function evaluateattackevent( type )
{
    executeevent( "attack", type );
}

