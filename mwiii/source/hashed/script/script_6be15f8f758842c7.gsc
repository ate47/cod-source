#namespace mp_zombie_abilities_dog_charge_anim;

#using_animtree( "playerasmhellhound2" );

// Namespace mp_zombie_abilities_dog_charge_anim / scripts\mp\gametypes\mp_zombie_abilities_dog_charge_anim
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x111
// Size: 0x90
function autoexec main()
{
    level.scr_animtree[ "dog_charge" ] = #animtree;
    level.scr_anim[ "dog_charge" ][ "hellhound_charge" ] = %jup_mp_hellhound_sprint;
    level.scr_eventanim[ "dog_charge" ][ "hellhound_charge" ] = %"jup_mp_hellhound_sprint";
    level.scr_anim[ "dog_charge" ][ "hellhound_hit_wall" ] = %jup_mp_hellhound_charge_hit;
    level.scr_eventanim[ "dog_charge" ][ "hellhound_hit_wall" ] = %"jup_mp_hellhound_charge_hit";
}

