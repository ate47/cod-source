#using scripts\sp\endmission;

#namespace pausemenu;

// Namespace pausemenu / scripts\sp\pausemenu
// Params 0
// Checksum 0x0, Offset: 0x8c
// Size: 0xa
function main()
{
    thread pausemenu_think();
}

// Namespace pausemenu / scripts\sp\pausemenu
// Params 0
// Checksum 0x0, Offset: 0x9e
// Size: 0x21
function pausemenu_think()
{
    while ( true )
    {
        level.player waittill( "restartmission" );
        restartmission();
    }
}

// Namespace pausemenu / scripts\sp\pausemenu
// Params 0
// Checksum 0x0, Offset: 0xc7
// Size: 0x89
function restartmission()
{
    version = getbuildversion();
    
    if ( version == "PROFILE" || version == "DEMO" )
    {
        map_restart();
        return;
    }
    
    /#
        if ( getdvarint( @"hash_893e98eb981706e2" ) > 0 )
        {
            map_restart();
            return;
        }
    #/
    
    level.player enableinvulnerability();
    map = scripts\sp\endmission::getrestartlevel( level.script );
    
    if ( isdefined( map ) )
    {
        changelevel( map, 0, 0 );
        return;
    }
    
    map_restart();
}

