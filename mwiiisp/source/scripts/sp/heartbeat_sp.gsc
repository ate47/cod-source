#using scripts\common\heartbeat;

#namespace heartbeat_sp;

// Namespace heartbeat_sp / scripts\sp\heartbeat_sp
// Params 0
// Checksum 0x0, Offset: 0x70
// Size: 0xe
function main()
{
    initcommonheartbeat( &playsoundfunc );
}

// Namespace heartbeat_sp / scripts\sp\heartbeat_sp
// Params 0
// Checksum 0x0, Offset: 0x86
// Size: 0xa
function function_767efe0110bfa73a()
{
    thread function_a9c6f7587066ce13();
}

// Namespace heartbeat_sp / scripts\sp\heartbeat_sp
// Params 3
// Checksum 0x0, Offset: 0x98
// Size: 0x23
function playsoundfunc( firstpersonalias, thirdpersonalias, soundsource )
{
    self playlocalsound( firstpersonalias );
}

