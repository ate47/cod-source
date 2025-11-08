#using scripts\common\utility;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\game;
#using scripts\mp\utility\sound;

#namespace audio;

// Namespace audio / scripts\mp\audio
// Params 0
// Checksum 0x0, Offset: 0x128
// Size: 0x39
function init_audio()
{
    if ( !isdefined( level.audio ) )
    {
        level.audio = spawnstruct();
    }
    
    snd_init();
    init_reverb();
    level.onplayerconnectaudioinit = &onplayerconnectaudioinit;
}

// Namespace audio / scripts\mp\audio
// Params 0
// Checksum 0x0, Offset: 0x169
// Size: 0x3e
function onplayerconnectaudioinit()
{
    apply_reverb( "default" );
    
    if ( getdvarint( @"scr_thirdperson" ) == 1 )
    {
        setglobalsoundcontext( "thirdpersonmode", "on" );
    }
    
    self setsoundsubmix( "hit_indicator_hipfire" );
}

// Namespace audio / scripts\mp\audio
// Params 0
// Checksum 0x0, Offset: 0x1af
// Size: 0x1f
function init_reverb()
{
    add_reverb( "default", "generic", 0.15, 0.9, 2 );
}

// Namespace audio / scripts\mp\audio
// Params 5
// Checksum 0x0, Offset: 0x1d6
// Size: 0x9c
function add_reverb( name, type, wetlevel, drylevel, fadetime )
{
    assert( isdefined( type ) );
    assert( isdefined( wetlevel ) );
    assert( isdefined( drylevel ) );
    reverb = [];
    is_roomtype_valid( type );
    reverb[ "roomtype" ] = type;
    reverb[ "wetlevel" ] = wetlevel;
    reverb[ "drylevel" ] = drylevel;
    reverb[ "fadetime" ] = fadetime;
    level.audio.reverb_settings[ name ] = reverb;
}

// Namespace audio / scripts\mp\audio
// Params 1
// Checksum 0x0, Offset: 0x27a
// Size: 0x16f
function is_roomtype_valid( type )
{
    /#
        switch ( type )
        {
            case #"hash_cb77b3d8a372e08":
            case #"hash_fc258a369439547":
            case #"hash_1b4f1c09bc30f8b7":
            case #"hash_1c5d5131b5fa462e":
            case #"hash_3d9ccd28b21cb88e":
            case #"hash_3e5e0a1ebaebcc7d":
            case #"hash_3f9f17c1662d120a":
            case #"hash_4bdd565aad97d89e":
            case #"hash_4d3e369017db8fda":
            case #"hash_5ff8e011d5b9d1c8":
            case #"hash_67c4c671ba316fb9":
            case #"hash_6929fc3845c34be3":
            case #"hash_8944a3af59c61e8b":
            case #"hash_8a6d0b4f5207c46b":
            case #"hash_9e7f75efc4013b79":
            case #"hash_a1800029963e0fb8":
            case #"hash_af68187c92c7fbc0":
            case #"hash_afe4256f96628234":
            case #"hash_b445759ac0026f01":
            case #"hash_c16009bb5fe873b1":
            case #"hash_dc295829b4ceffa2":
            case #"hash_de1caed68cb47987":
            case #"hash_e991ce5bbbefabf9":
            case #"hash_ed5b5dc2ce86f143":
            case #"hash_f1a23e97c35685da":
            case #"hash_f67bf6cfc4a6bc7a":
                return;
            default:
                assertmsg( type + "<dev string:x150>" );
                break;
        }
    #/
}

// Namespace audio / scripts\mp\audio
// Params 1
// Checksum 0x0, Offset: 0x3f1
// Size: 0x63
function apply_reverb( name )
{
    if ( !isdefined( level.audio.reverb_settings[ name ] ) )
    {
        reverb = level.audio.reverb_settings[ "default" ];
        return;
    }
    
    reverb = level.audio.reverb_settings[ name ];
}

