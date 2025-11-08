#namespace struct;

// Namespace struct / scripts\code\struct
// Params 0
// Checksum 0x0, Offset: 0x68
// Size: 0xc
function initstructs()
{
    level.struct = [];
}

// Namespace struct / scripts\code\struct
// Params 0
// Checksum 0x0, Offset: 0x7c
// Size: 0x29
function createstruct()
{
    struct = spawnstruct();
    level.struct[ level.struct.size ] = struct;
    return struct;
}

