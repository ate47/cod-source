#using scripts\common\utility;
#using scripts\engine\utility;

#namespace passives;

// Namespace passives / scripts\mp\passives
// Params 0
// Checksum 0x0, Offset: 0xbd
// Size: 0x13
function init()
{
    level.passivemap = [];
    passiveparsetable();
}

// Namespace passives / scripts\mp\passives
// Params 0
// Checksum 0x0, Offset: 0xd8
// Size: 0x21d
function passiveparsetable()
{
    if ( !isdefined( level.passivemap ) )
    {
        level.passivemap = [];
    }
    
    for ( row = 0; true ; row++ )
    {
        id = tablelookupbyrow( "mp/passivetable.csv", row, 0 );
        
        if ( id == "" )
        {
            break;
        }
        
        var_9f77fa0224fd3b6b = tablelookupbyrow( "mp/passivetable.csv", row, 1 );
        attachmentref = tablelookupbyrow( "mp/passivetable.csv", row, 12 );
        perkref = tablelookupbyrow( "mp/passivetable.csv", row, 13 );
        messageref = tablelookupbyrow( "mp/passivetable.csv", row, 14 );
        struct = spawnstruct();
        struct.name = var_9f77fa0224fd3b6b;
        struct.weapontype = ter_op( tablelookupbyrow( "mp/passivetable.csv", row, 8 ) == "", 0, 1 );
        struct.killstreaktype = ter_op( tablelookupbyrow( "mp/passivetable.csv", row, 9 ) == "", 0, 1 );
        struct.lethaltype = ter_op( tablelookupbyrow( "mp/passivetable.csv", row, 10 ) == "", 0, 1 );
        struct.tacticaltype = ter_op( tablelookupbyrow( "mp/passivetable.csv", row, 11 ) == "", 0, 1 );
        
        if ( attachmentref != "" )
        {
            struct.attachmentref = attachmentref;
        }
        
        if ( getdvar( @"ui_gametype" ) == "zombie" )
        {
            var_4c1a232672db4b7f = tablelookupbyrow( "mp/passivetable.csv", row, 22 );
            
            if ( var_4c1a232672db4b7f != "" )
            {
                struct.attachmentref = var_4c1a232672db4b7f;
            }
        }
        
        if ( perkref != "" )
        {
            struct.perkref = perkref;
        }
        
        if ( messageref != "" )
        {
            struct.messageref = messageref;
        }
        
        if ( !isdefined( level.passivemap[ var_9f77fa0224fd3b6b ] ) )
        {
            level.passivemap[ var_9f77fa0224fd3b6b ] = struct;
        }
    }
}

// Namespace passives / scripts\mp\passives
// Params 1
// Checksum 0x0, Offset: 0x2fd
// Size: 0x34
function getpassivestruct( passive )
{
    if ( !isdefined( level.passivemap[ passive ] ) )
    {
        return undefined;
    }
    
    struct = level.passivemap[ passive ];
    return struct;
}

// Namespace passives / scripts\mp\passives
// Params 1
// Checksum 0x0, Offset: 0x33a
// Size: 0x41
function getpassiveattachment( passive )
{
    struct = getpassivestruct( passive );
    
    if ( !isdefined( struct ) || !isdefined( struct.attachmentref ) )
    {
        return undefined;
    }
    
    return struct.attachmentref;
}

// Namespace passives / scripts\mp\passives
// Params 1
// Checksum 0x0, Offset: 0x384
// Size: 0x41
function getpassiveperk( passive )
{
    struct = getpassivestruct( passive );
    
    if ( !isdefined( struct ) || !isdefined( struct.perkref ) )
    {
        return undefined;
    }
    
    return struct.perkref;
}

// Namespace passives / scripts\mp\passives
// Params 1
// Checksum 0x0, Offset: 0x3ce
// Size: 0x41
function getpassivemessage( passive )
{
    struct = getpassivestruct( passive );
    
    if ( !isdefined( struct ) || !isdefined( struct.messageref ) )
    {
        return undefined;
    }
    
    return struct.messageref;
}

// Namespace passives / scripts\mp\passives
// Params 0
// Checksum 0x0, Offset: 0x418
// Size: 0x78
function getweapontypepassives()
{
    passives = [];
    
    foreach ( passive in level.passivemap )
    {
        if ( passive.weapontype )
        {
            passives[ passives.size ] = passive.name;
        }
    }
    
    return passives;
}

// Namespace passives / scripts\mp\passives
// Params 0
// Checksum 0x0, Offset: 0x499
// Size: 0x78
function getkillstreaktypepassives()
{
    passives = [];
    
    foreach ( passive in level.passivemap )
    {
        if ( passive.killstreaktype )
        {
            passives[ passives.size ] = passive.name;
        }
    }
    
    return passives;
}

// Namespace passives / scripts\mp\passives
// Params 0
// Checksum 0x0, Offset: 0x51a
// Size: 0x78
function getlethaltypepassives()
{
    passives = [];
    
    foreach ( passive in level.passivemap )
    {
        if ( passive.lethaltype )
        {
            passives[ passives.size ] = passive.name;
        }
    }
    
    return passives;
}

// Namespace passives / scripts\mp\passives
// Params 0
// Checksum 0x0, Offset: 0x59b
// Size: 0x78
function gettacticaltypepassives()
{
    passives = [];
    
    foreach ( passive in level.passivemap )
    {
        if ( passive.tacticaltype )
        {
            passives[ passives.size ] = passive.name;
        }
    }
    
    return passives;
}

