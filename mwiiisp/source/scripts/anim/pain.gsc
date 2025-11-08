#using scripts\asm\asm_sp;

#namespace pain;

// Namespace pain / scripts\anim\pain
// Params 0
// Checksum 0x0, Offset: 0xc1
// Size: 0x10
function main()
{
    self endon( "killanimscript" );
    scripts\asm\asm_sp::paininternal();
}

// Namespace pain / scripts\anim\pain
// Params 0
// Checksum 0x0, Offset: 0xd9
// Size: 0x1c
function initpainfx()
{
    level._effect[ "crawling_death_blood_smear" ] = loadfx( "vfx/core/impacts/blood_smear_decal.vfx" );
}

