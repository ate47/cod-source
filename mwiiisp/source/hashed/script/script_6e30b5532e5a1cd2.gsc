#using script_3a8f9ace195c9da9;
#using scripts\common\utility;
#using scripts\cp_mp\fogofwar;
#using scripts\engine\utility;

#namespace namespace_a552950f139412a7;

// Namespace namespace_a552950f139412a7 / namespace_97f2cf3995839d6e
// Params 0
// Checksum 0x0, Offset: 0xa3
// Size: 0x105
function init()
{
    scripts\engine\utility::registersharedfunc( "fogofwar", "should_play_intro", &namespace_1170726b2799ea65::should_play_intro );
    setdvar( @"hash_77d113f022f794", 1 );
    setdvar( @"hash_d79899fb31780dea", 0 );
    setdvar( @"hash_f74d46256f1f1833", 0 );
    setdvar( @"hash_5ea4ad60f090ee37", 0 );
    setdvar( @"hash_5cb9a2edac290a5a", 1150 );
    setdvar( @"hash_a5977b1881c200f9", 0.05 );
    setdvar( @"hash_b99ee24d4ab44550", 30 );
    setdvar( @"hash_f14b5a58d0c4c968", 600 );
    setdvar( @"hash_6122be3e1bbfdd4b", 590 );
    setdvar( @"hash_63a6ae1db0e57d7", 1 );
    setdvar( @"hash_9d6e77cba023265", 0.5 );
    setdvar( @"hash_83d363a370e55b35", 2 );
    setdvar( @"hash_4c33a1fbcdd8f052", 1 );
    scripts\cp_mp\fogofwar::init();
}

