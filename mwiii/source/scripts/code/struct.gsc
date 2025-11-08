#namespace struct;

// Namespace struct / scripts\code\struct
// Params 0
// Checksum 0x0, Offset: 0x88
// Size: 0xc
function initstructs()
{
    level.struct = [];
}

// Namespace struct / scripts\code\struct
// Params 0
// Checksum 0x0, Offset: 0x9c
// Size: 0x2a
function createstruct()
{
    struct = spawnstruct();
    level.struct[ level.struct.size ] = struct;
    return struct;
}

