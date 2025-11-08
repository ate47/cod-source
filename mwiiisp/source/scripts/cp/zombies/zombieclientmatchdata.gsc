#using scripts\common\utility;
#using scripts\engine\utility;

#namespace zombieclientmatchdata;

// Namespace zombieclientmatchdata / scripts\cp\zombies\zombieclientmatchdata
// Params 0
// Checksum 0x0, Offset: 0xb0
// Size: 0x46
function init()
{
    if ( !isdefined( game[ "clientMatchDataDef" ] ) )
    {
        game[ "clientMatchDataDef" ] = "ddl/mp/zombieclientmatchdata.ddl";
        setclientmatchdatadef( game[ "clientMatchDataDef" ] );
        setclientmatchdata( "map", level.script );
    }
    
    level.maxdeaths = 50;
}

