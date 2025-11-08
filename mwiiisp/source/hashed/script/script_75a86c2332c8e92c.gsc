#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_e12d9122c31ca175;

// Namespace namespace_e12d9122c31ca175 / namespace_1189bdf1260c0376
// Params 0
// Checksum 0x0, Offset: 0xb0
// Size: 0x5e
function init()
{
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515" ) == 1 )
        {
            return;
        }
    #/
    
    if ( !isdefined( game[ "clientMatchDataDef" ] ) )
    {
        game[ "clientMatchDataDef" ] = "ddl/mp/zombieclientmatchdata.ddl";
        setclientmatchdatadef( game[ "clientMatchDataDef" ] );
        setclientmatchdata( "map", level.script );
    }
    
    level.maxdeaths = 50;
}

