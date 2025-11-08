#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\archetypes\archassault;
#using scripts\mp\utility\perk;

#namespace archcommon;

// Namespace archcommon / scripts\mp\archetypes\archcommon
// Params 0
// Checksum 0x0, Offset: 0x110
// Size: 0xad
function init()
{
    level.archetypes = [];
    level.archetypeids = [];
    
    for ( row = 0; true ; row++ )
    {
        index = tablelookupbyrow( "mp/battleRigTable.csv", row, 0 );
        
        if ( !isdefined( index ) || index == "" )
        {
            break;
        }
        
        index = int( index );
        ref = tablelookupbyrow( "mp/battleRigTable.csv", row, 1 );
        assertex( isdefined( "<dev string:x1c>" ), "<dev string:x23>" + index + "<dev string:x33>" );
        level.archetypes[ index ] = ref;
        level.archetypeids[ ref ] = index;
    }
}

// Namespace archcommon / scripts\mp\archetypes\archcommon
// Params 1
// Checksum 0x0, Offset: 0x1c5
// Size: 0x54
function removearchetype( loadoutarchetype )
{
    if ( !isdefined( loadoutarchetype ) )
    {
        return;
    }
    
    funcremove = undefined;
    
    switch ( loadoutarchetype )
    {
        case #"hash_98ff6f21872f18e0":
            funcremove = &scripts\mp\archetypes\archassault::removearchetype;
            break;
        default:
            return;
    }
    
    if ( isdefined( funcremove ) )
    {
        self [[ funcremove ]]();
    }
}

// Namespace archcommon / scripts\mp\archetypes\archcommon
// Params 1
// Checksum 0x0, Offset: 0x221
// Size: 0x26
function _allowbattleslide( allow )
{
    if ( allow )
    {
        giveperk( "specialty_battleslide" );
        return;
    }
    
    self notify( "battleslide_unset" );
}

// Namespace archcommon / scripts\mp\archetypes\archcommon
// Params 1
// Checksum 0x0, Offset: 0x24f
// Size: 0x53
function getrigindexfromarchetyperef( archetyperefstring )
{
    if ( !isdefined( archetyperefstring ) || archetyperefstring == "none" )
    {
        return 0;
    }
    
    for ( rigindex = 0; rigindex < level.archetypes.size ; rigindex++ )
    {
        if ( level.archetypes[ rigindex ] == archetyperefstring )
        {
            return rigindex;
        }
    }
    
    return 0;
}

