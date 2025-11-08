#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace zombie_react;

// Namespace zombie_react / scripts\asm\soldier\zombie_react
// Params 4
// Checksum 0x0, Offset: 0xc2
// Size: 0x62, Type: bool
function isenemyzombie( asmname, statename, tostatename, params )
{
    return isdefined( self.enemy ) && isdefined( self.enemy.unittype ) && self.enemy.unittype == "zombie";
}

