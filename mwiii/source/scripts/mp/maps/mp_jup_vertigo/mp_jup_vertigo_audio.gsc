#using scripts\engine\utility;

#namespace mp_jup_vertigo_audio;

// Namespace mp_jup_vertigo_audio / scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_audio
// Params 0
// Checksum 0x0, Offset: 0x1a8
// Size: 0x2
function main()
{
    
}

// Namespace mp_jup_vertigo_audio / scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_audio
// Params 1
// Checksum 0x0, Offset: 0x1b2
// Size: 0x2b
function function_c8f303cb5ce4d4f1( forward_mover )
{
    forward_mover playsoundonmovingent( "sfx_mp_vertigo_moving_block_forward_start" );
    forward_mover waittill( "movedone" );
    forward_mover playsoundonmovingent( "sfx_mp_vertigo_moving_block_forward_stop" );
}

// Namespace mp_jup_vertigo_audio / scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_audio
// Params 1
// Checksum 0x0, Offset: 0x1e5
// Size: 0x2b
function function_15f3cb16ea85459b( back_mover )
{
    back_mover playsoundonmovingent( "sfx_mp_vertigo_moving_block_back_start" );
    back_mover waittill( "movedone" );
    back_mover playsoundonmovingent( "sfx_mp_vertigo_moving_block_back_stop" );
}

// Namespace mp_jup_vertigo_audio / scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_audio
// Params 1
// Checksum 0x0, Offset: 0x218
// Size: 0x1f
function function_a98ceea0b676d81a( forward_mover )
{
    forward_mover waittill( "movedone" );
    forward_mover playsoundonmovingent( "sfx_mp_vertigo_moving_block_push_stop" );
}

// Namespace mp_jup_vertigo_audio / scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_audio
// Params 1
// Checksum 0x0, Offset: 0x23f
// Size: 0x18
function function_f182f4bfb0416785( rotater )
{
    rotater play_loop_sound_on_entity( "sfx_mp_vertigo_rotate" );
}

// Namespace mp_jup_vertigo_audio / scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_audio
// Params 1
// Checksum 0x0, Offset: 0x25f
// Size: 0x17
function rotatestopsound( rotater )
{
    rotater playsoundonmovingent( "sfx_mp_vertigo_rotate_stop" );
}

