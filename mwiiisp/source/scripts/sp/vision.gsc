#namespace vision;

// Namespace vision / scripts\sp\vision
// Params 0
// Checksum 0x0, Offset: 0x7e
// Size: 0x5f
function init_vision()
{
    if ( !isdefined( level.visionthermaldefault ) )
    {
        level.visionthermaldefault = "black_bw";
    }
    
    if ( !isdefined( level.visionnakeddefault ) )
    {
        level.visionnakeddefault = "";
    }
    
    visionsetthermal( level.visionthermaldefault );
    thread init_pain();
    thread clear_snake();
    thread clear_vision();
}

// Namespace vision / scripts\sp\vision
// Params 0
// Checksum 0x0, Offset: 0xe5
// Size: 0x13
function init_pain()
{
    wait 0.2;
    visionsetpain( "damage_dead" );
}

// Namespace vision / scripts\sp\vision
// Params 2
// Checksum 0x0, Offset: 0x100
// Size: 0x25
function set_vision_naked( var_c2d8bcafdbdac268, blendtime )
{
    level.visionnakeddefault = var_c2d8bcafdbdac268;
    visionsetnaked( var_c2d8bcafdbdac268, blendtime );
}

// Namespace vision / scripts\sp\vision
// Params 0
// Checksum 0x0, Offset: 0x12d
// Size: 0x16
function clear_vision()
{
    visionsetnaked( level.visionnakeddefault, 0 );
}

// Namespace vision / scripts\sp\vision
// Params 0
// Checksum 0x0, Offset: 0x14b
// Size: 0x12
function clear_snake()
{
    visionsetfadetoblack( "", 0 );
}

