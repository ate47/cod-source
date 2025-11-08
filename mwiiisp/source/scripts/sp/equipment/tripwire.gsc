#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\bottle;
#using scripts\sp\equipment\offhands;
#using scripts\sp\loot;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_death;
#using scripts\sp\utility;

#namespace tripwire;

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0x92d
// Size: 0x1d
function precache()
{
    if ( !isdefined( level.tripwires ) )
    {
        tripwiremodelprecache();
        spawntripwirelevelstruct();
    }
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0x952
// Size: 0x70
function tripwiremodelprecache()
{
    precachemodel( "equipment_wm_tripwire_standard" );
    precachemodel( "equipment_wm_tripwire_standard" );
    precachemodel( "equipment_wm_tripwire_standard" );
    precachemodel( "equipment_wm_tripwire_wall_after" );
    precachemodel( "equipment_wm_tripwire_wall_after_01" );
    precachemodel( "equipment_wm_tripwire_wall_after_02" );
    precachemodel( "equipment_wm_tripwire_wall_after_03" );
    precachemodel( "equipment_wm_tripwire_wall_after_04" );
    precachemodel( "equipment_wm_tripwire_ceiling_after" );
    precachemodel( "equipment_wm_tripwire_floor_after" );
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 5
// Checksum 0x0, Offset: 0x9ca
// Size: 0x16a
function precachetrap( type, model, candisarm, var_fa943467b1592255, cursorhintstring )
{
    precache();
    
    if ( !isdefined( level.tripwires.traptypes[ type ] ) )
    {
        level.tripwires.traptypes[ type ] = spawnstruct();
        level.tripwires.traptypes[ type ].model = model;
        level.tripwires.traptypes[ type ].triggerfunc = gettriggerfunc( type );
        level.tripwires.traptypes[ type ].setmodelfunc = getsetmodelfunc( type );
        level.tripwires.traptypes[ type ].candisarm = candisarm;
        level.tripwires.traptypes[ type ].var_fa943467b1592255 = var_fa943467b1592255;
        level.tripwires.traptypes[ type ].cursorhintstring = cursorhintstring;
        
        if ( candisarm )
        {
            level.tripwires.traptypes[ type ].disarmfunc = getdisarmfunc( type );
        }
    }
    
    precachemodel( model );
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0xb3c
// Size: 0x86
function spawntripwirelevelstruct()
{
    if ( !isdefined( level.tripwires ) )
    {
        level.tripwires = spawnstruct();
        level.tripwires.traptypes = [];
        level.tripwires.tripwires = [];
        level.tripwires.traps = [];
        level.tripwires.dangerzones = [];
        level.tripwires.var_ba1d822da3e54246 = [];
    }
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0xbca
// Size: 0x140
function init()
{
    if ( !isdefined( level.tripwires ) )
    {
        return;
    }
    
    setdvarifuninitialized( @"debug_tripwire", 0 );
    var_7992e35c1abecadd = getstructarray( "tripwire_start", "script_noteworthy" );
    
    foreach ( startstruct in var_7992e35c1abecadd )
    {
        if ( !isdefined( startstruct.target ) )
        {
            assertmsg( "script_struct_tripwire_start at location " + startstruct.origin + " has no target.  Target a script_struct_tripwire_end where you want the tripwire to end" );
        }
        
        endstructs = getstructarray( startstruct.target, "targetname" );
        
        if ( endstructs.size < 1 )
        {
            assertmsg( "script_struct_tripwire_start at location " + startstruct.origin + " has no target struct.  Target a script_struct_tripwire_end where you want the tripwire to end" );
        }
        
        foreach ( endstruct in endstructs )
        {
            buildtripwire( startstruct, endstruct );
        }
    }
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 3
// Checksum 0x0, Offset: 0xd12
// Size: 0xe6
function buildtripwire( startstruct, endstruct, parenttripwire )
{
    if ( !isdefined( endstruct.script_animname ) )
    {
        endstruct.script_animname = "wall";
    }
    
    tripwire = spawntripwire( startstruct, endstruct );
    tripwire inittripwireanims( endstruct.script_animname );
    tripwire inittripwirestaticmodel( endstruct.script_animname );
    tripwire thread tripwirethink();
    tripwire thread triggertripwirefuncthink( &triggerfunctripwire );
    
    if ( isdefined( parenttripwire ) )
    {
        tripwire.targets = array_add( tripwire.targets, parenttripwire );
    }
    
    tripwire processtripwiretarget( endstruct );
    level.tripwires.tripwires = array_add( level.tripwires.tripwires, tripwire );
    return tripwire;
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0xe01
// Size: 0x153
function processtripwiretarget( endstruct )
{
    msg = "script_struct_tripwire_end at location " + endstruct.origin + " has no target.  Target the ent you want the tripwire to trigger, or another script_struct_tripwire_end to continue the tripwire chain";
    
    if ( !isdefined( endstruct.target ) )
    {
        return;
    }
    
    targetstructs = getstructarray( endstruct.target, "targetname" );
    targetents = getentarray( endstruct.target, "targetname" );
    targets = array_combine( targetstructs, targetents );
    
    if ( targets.size == 0 )
    {
        assertmsg( msg );
    }
    
    if ( endstruct shouldfindnavmodifier() )
    {
        self.navmodifier = createnavmodifier( endstruct.target, "targetname" );
    }
    
    foreach ( target in targets )
    {
        if ( target istripwirestruct() )
        {
            target = buildtripwire( endstruct, target, self );
        }
        else if ( target istripwiretrapstruct() )
        {
            target = buildtripwiretrap( target, self );
        }
        
        self.targets = array_add( self.targets, target );
    }
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0xf5c
// Size: 0x27
function shouldfindnavmodifier()
{
    if ( isdefined( self.spawnflags ) && self.spawnflags & 1 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0xf8b
// Size: 0x27
function function_fe9aa5559bc83b58()
{
    if ( isdefined( self.spawnflags ) && self.spawnflags & 2 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0xfba
// Size: 0x27
function function_f48a6c353ff5d960()
{
    if ( isdefined( self.spawnflags ) && self.spawnflags & 4 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0xfe9
// Size: 0x34
function istripwirestruct()
{
    if ( isstruct( self ) && isdefined( self.script_noteworthy ) && self.script_noteworthy == "tripwire_end" )
    {
        return 1;
    }
    
    return 0;
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0x1025
// Size: 0x38
function istripwiretrapstruct()
{
    if ( isstruct( self ) && isdefined( self.script_noteworthy ) && issubstr( self.script_noteworthy, "tripwire_trap_" ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0x1065
// Size: 0x7d, Type: bool
function hastripwirechild()
{
    foreach ( target in self.targets )
    {
        if ( isdefined( target.istripwire ) && target.istripwire && !isdefined( target.triggered ) )
        {
            return true;
        }
    }
    
    return false;
}

#using_animtree( "script_model" );

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 2
// Checksum 0x0, Offset: 0x10eb
// Size: 0x2d2
function spawntripwire( startstruct, endstruct )
{
    vec = startstruct.origin - endstruct.origin;
    tripwire = spawn( "script_model", endstruct.origin );
    tripwire.angles = vectortoangles( vec );
    tripwire setmodel( gettripwiremodel( endstruct.script_animname ) );
    tripwire useanimtree( #animtree );
    
    if ( isdefined( endstruct.angles ) )
    {
        f = anglestoforward( endstruct.angles );
        r = anglestoright( tripwire.angles );
        u = anglestoup( tripwire.angles );
        tripwire.finalangles = axistoangles( f, r, u );
    }
    
    tripwire.targets = [];
    tripwire.endpoint = startstruct.origin;
    tripwire.length = length( vec );
    tripwiretriggerradius = 30;
    triggerorg = tripwire.origin + anglestoforward( tripwire.angles ) * 0.5 * tripwire.length;
    
    if ( endstruct function_fe9aa5559bc83b58() )
    {
        tripwire.trigger = spawn( "trigger_rotatable_radius", tripwire.origin, 7, tripwiretriggerradius, tripwire.length + 10 );
    }
    else
    {
        tripwire.trigger = spawn( "trigger_rotatable_radius", tripwire.origin, 0, tripwiretriggerradius, tripwire.length + 10 );
    }
    
    tripwire.var_d8ec40ff894a8d81 = endstruct function_f48a6c353ff5d960();
    trigger_f = -1 * anglestoup( tripwire.angles );
    trigger_r = anglestoright( tripwire.angles );
    trigger_u = anglestoforward( tripwire.angles );
    tripwire.trigger.angles = axistoangles( trigger_f, trigger_r, trigger_u );
    tripwire.istripwire = 1;
    
    if ( isdefined( startstruct.script_delay ) )
    {
        tripwire.delay = startstruct.script_delay;
    }
    else
    {
        tripwire.delay = math::factor_value( 0.1, 0.35, tripwire getnormtripwirelength() );
    }
    
    return tripwire;
}

/#

    // Namespace tripwire / scripts\sp\equipment\tripwire
    // Params 0
    // Checksum 0x0, Offset: 0x13c6
    // Size: 0xf6, Type: dev
    function function_e27e699a875868d8()
    {
        length = 10;
        
        while ( true )
        {
            if ( !isdefined( self ) )
            {
                return;
            }
            
            u = anglestoup( self.angles );
            f = anglestoforward( self.angles );
            r = anglestoright( self.angles );
            line( self.origin, self.origin + u * length, ( 0, 0, 1 ), 1, 0, 1 );
            line( self.origin, self.origin + f * length, ( 1, 0, 0 ), 1, 0, 1 );
            line( self.origin, self.origin + r * length, ( 0, 1, 0 ), 1, 0, 1 );
            waitframe();
        }
    }

#/

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x14c4
// Size: 0xcd
function inittripwireanims( animname )
{
    if ( !isdefined( animname ) )
    {
        assertmsg( "tripwire struct found with missing script_animname KVP.  Reopen your map, save, and compile only ents to fix" );
    }
    
    self.triggeranim = gettripwiretriggeranim( animname );
    self.stretchanim = gettripwirestretchanim( animname );
    self setanim( self.triggeranim, 1, 0, 0 );
    self setanim( self.stretchanim, 1, 0, 0 );
    
    if ( self.length < 10 || self.length > 300 )
    {
        assertmsg( "tripwire at location " + self.origin + " must be between " + 10 + " and " + 300 + " units apart." );
    }
    
    self setanimtime( self.stretchanim, getnormtripwirelength() );
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x1599
// Size: 0x2e
function inittripwirestaticmodel( animname )
{
    if ( !isdefined( animname ) )
    {
        assertmsg( "tripwire struct found with missing script_animname KVP.  Reopen your map, save, and compile only ents to fix" );
    }
    
    self.staticmodel = gettripwirestaticmodel( animname );
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x15cf
// Size: 0x30
function gettripwiretriggersound( firsttriggered )
{
    if ( firsttriggered )
    {
        return "tripwire_pop_first";
    }
    
    if ( hastripwirechild() )
    {
        return "tripwire_pop";
    }
    
    return "tripwire_pop_last";
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0x1607
// Size: 0xb2
function tripwirethink()
{
    self endon( "tripwire_trigger" );
    
    while ( true )
    {
        self.trigger waittill( "trigger", who );
        
        /#
            if ( getdvarint( @"debug_tripwire" ) )
            {
                line( self.origin, self.origin + anglestoforward( self.angles ) * self.length, ( 1, 0, 0 ), 1, 0, 1 );
            }
        #/
        
        triggertraps = 1;
        firsttriggered = 1;
        
        if ( tripwireshouldtrigger( who ) )
        {
            self notify( "trigger", who, triggertraps, firsttriggered );
        }
    }
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x16c1
// Size: 0x63
function tripwireshouldtrigger( who )
{
    contentsoverride = create_contents( 1, 0, 0, 0, 1, 1, 0, 0, 1 );
    trace = ray_trace_ents( self.origin, self.endpoint, who, contentsoverride );
    
    if ( trace[ "fraction" ] < 1 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 2
// Checksum 0x0, Offset: 0x172c
// Size: 0x234
function buildtripwiretrap( struct, parenttripwire )
{
    if ( !isdefined( struct.trap ) )
    {
        [[ level.tripwires.traptypes[ struct.script_noteworthy ].setmodelfunc ]]( struct );
        struct.trap thread triggertrapfuncthink( level.tripwires.traptypes[ struct.script_noteworthy ].triggerfunc, struct );
        struct.trap thread damagetrapfuncthink();
        struct.trap.candisarm = level.tripwires.traptypes[ struct.script_noteworthy ].candisarm;
        struct.trap.istrap = 1;
        
        if ( isdefined( level.tripwires.traptypes[ struct.script_noteworthy ].disarmfunc ) )
        {
            struct.trap thread disarmfuncthink( level.tripwires.traptypes[ struct.script_noteworthy ].disarmfunc, struct );
        }
        
        if ( isdefined( struct.script_parameters ) )
        {
            [ struct.trap.grenadeweaponoverride ] = strtok( struct.script_parameters, " " );
        }
        
        struct.trap.parenttripwires = [];
        level.tripwires.traps = array_add( level.tripwires.traps, struct.trap );
    }
    
    struct.trap.parenttripwires = array_add( struct.trap.parenttripwires, parenttripwire );
    return struct.trap;
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0x1969
// Size: 0x16
function getnormtripwirelength()
{
    return math::normalize_value( 10, 300, self.length );
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0x1988
// Size: 0x6e, Type: bool
function tripwirehastraps()
{
    foreach ( target in self.targets )
    {
        if ( isdefined( target.istrap ) && !isdefined( target.triggered ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0x19ff
// Size: 0x81
function gettripwiretraps()
{
    traps = [];
    
    foreach ( target in self.targets )
    {
        if ( isdefined( target.istrap ) && !isdefined( target.triggered ) )
        {
            traps = array_add( traps, target );
        }
    }
    
    return traps;
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x1a89
// Size: 0x8b
function triggertripwirefuncthink( triggerfunc )
{
    while ( true )
    {
        self waittill( "trigger", who, triggertrap, firsttriggered );
        
        if ( triggertrap )
        {
            break;
        }
        
        if ( !tripwirehastraps() )
        {
            break;
        }
    }
    
    if ( isdefined( who ) )
    {
        who.lasttriptime = gettime();
    }
    
    self notify( "tripwire_trigger" );
    self.triggered = 1;
    thread trapdangerzoneproc();
    self [[ triggerfunc ]]( who, triggertrap, firsttriggered );
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0x1b1c
// Size: 0x67
function trapdangerzoneproc()
{
    if ( !tripwirehastraps() )
    {
        return;
    }
    
    traps = gettripwiretraps();
    
    foreach ( trap in traps )
    {
        trap thread spawntrapdangerzone();
    }
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0x1b8b
// Size: 0x8d
function spawntrapdangerzone()
{
    dangerzone = spawn( "trigger_radius", self.origin, 0, 300, 300 );
    level.tripwires.dangerzones = array_add( level.tripwires.dangerzones, dangerzone );
    wait 1;
    level.tripwires.dangerzones = array_remove( level.tripwires.dangerzones, dangerzone );
    dangerzone delete();
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0x1c20
// Size: 0x7a, Type: bool
function playerintripwiredangerzone()
{
    if ( !isdefined( level.tripwires ) )
    {
        return false;
    }
    
    foreach ( dangerzone in level.tripwires.dangerzones )
    {
        if ( level.player istouching( dangerzone ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 2
// Checksum 0x0, Offset: 0x1ca3
// Size: 0xbb
function triggertrapfuncthink( triggerfunc, struct )
{
    while ( true )
    {
        self waittill( "trigger", who, triggertrap );
        
        if ( triggertrap )
        {
            break;
        }
    }
    
    self notify( "trap_trigger" );
    self.triggered = 1;
    
    if ( isdefined( self.defusehintstruct ) && !isdefined( self.defusehintstruct.defused ) && !level.tripwires.traptypes[ struct.script_noteworthy ].var_fa943467b1592255 )
    {
        self.defusehintstruct scripts\sp\player\cursor_hint::remove_cursor_hint();
    }
    
    self [[ triggerfunc ]]( who );
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x1d66
// Size: 0x90
function gettriggerfunc( type )
{
    switch ( type )
    {
        case #"hash_32670e2a61b99a3b":
            return &triggerfuncc4;
        case #"hash_4beeaacc1db7b8cc":
            return &triggerfuncsemtex;
        case #"hash_496a20490fb91698":
            return &triggerfuncfrag;
        case #"hash_e0b40680bb70bdb4":
            return &function_ff147402c60ccd89;
        case #"hash_996be0d30bf84ba0":
            return &function_69edfcd6ffcd5561;
        default:
            assertmsg( "Add a triggerFunc for trigger trap " + type + " to scriptsspequipment\tripwire::getTriggerFunc" );
            break;
    }
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x1dfe
// Size: 0x90
function getsetmodelfunc( type )
{
    switch ( type )
    {
        case #"hash_32670e2a61b99a3b":
            return &function_dc3cd630742e5ae9;
        case #"hash_4beeaacc1db7b8cc":
            return &function_dc3cd630742e5ae9;
        case #"hash_496a20490fb91698":
            return &function_dc3cd630742e5ae9;
        case #"hash_e0b40680bb70bdb4":
            return &function_dc3cd630742e5ae9;
        case #"hash_996be0d30bf84ba0":
            return &function_af551bcedf90478;
        default:
            assertmsg( "Add a setModelFunc for trigger trap " + type + " to scriptsspequipment\tripwire::getSetModelFunc" );
            break;
    }
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x1e96
// Size: 0xb4
function function_dc3cd630742e5ae9( struct )
{
    if ( !isdefined( struct.angles ) )
    {
        angles = ( 0, 0, 0 );
    }
    else
    {
        angles = struct.angles;
    }
    
    struct.trap = spawn( "script_model", struct.origin );
    struct.trap.angles = angles;
    struct.trap setmodel( level.tripwires.traptypes[ struct.script_noteworthy ].model );
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x1f52
// Size: 0x1c9
function function_af551bcedf90478( struct )
{
    weaponentity = getent( struct.target, "targetname" );
    
    if ( !isdefined( weaponentity.angles ) )
    {
        angles = ( 0, 0, 0 );
    }
    else
    {
        angles = weaponentity.angles;
    }
    
    struct.trap = spawn( "script_model", weaponentity.origin );
    struct.trap.angles = angles;
    weaponbasename = getweaponbasename( weaponentity );
    weaponattachments = getweaponattachments( weaponentity );
    struct.trap.weaponobject = make_weapon( weaponbasename, weaponattachments );
    struct.trap utility::make_weapon_model( weaponbasename, struct.trap.weaponobject.attachments );
    struct.trap.script_ammo_clip = weaponentity.script_ammo_clip;
    struct.trap.var_e84ad86715d85cc = struct.trap gettagorigin( "tag_flash" );
    struct.trap.var_6a862672391c9895 = struct.trap.var_e84ad86715d85cc + anglestoforward( struct.trap gettagangles( "tag_flash" ) ) * 100;
    struct.trap.targetname = weaponentity.targetname;
    weaponentity delete();
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x2123
// Size: 0xfb
function gettripwiretriggeranim( animname )
{
    switch ( animname )
    {
        case #"hash_28b4e95012259360":
            return random( [ %tripwire_trigger_standard_ceiling ] );
        case #"hash_3e7681464ca7b9fd":
            return random( [ %tripwire_trigger_standard_floor ] );
        case #"hash_bdea657441323e75":
            if ( shouldusewallsize1() )
            {
                return random( [ %tripwire_trigger_standard_wall_01 ] );
            }
            else if ( shouldusewallsize2() )
            {
                return random( [ %tripwire_trigger_standard_wall_02 ] );
            }
            else if ( shouldusewallsize3() )
            {
                return random( [ %tripwire_trigger_standard_wall_03 ] );
            }
            else if ( shouldusewallsize4() )
            {
                return random( [ %tripwire_trigger_standard_wall_04 ] );
            }
            else
            {
                return random( [ %tripwire_trigger_standard_wall ] );
            }
            
            break;
    }
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x2226
// Size: 0x92
function gettripwirestaticmodel( animname )
{
    switch ( animname )
    {
        case #"hash_28b4e95012259360":
            return "equipment_wm_tripwire_ceiling_after";
        case #"hash_3e7681464ca7b9fd":
            return "equipment_wm_tripwire_floor_after";
        case #"hash_bdea657441323e75":
            if ( shouldusewallsize1() )
            {
                return "equipment_wm_tripwire_wall_after_01";
            }
            else if ( shouldusewallsize2() )
            {
                return "equipment_wm_tripwire_wall_after_02";
            }
            else if ( shouldusewallsize3() )
            {
                return "equipment_wm_tripwire_wall_after_03";
            }
            else if ( shouldusewallsize4() )
            {
                return "equipment_wm_tripwire_wall_after_04";
            }
            else
            {
                return "equipment_wm_tripwire_wall_after";
            }
            
            break;
    }
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x22c0
// Size: 0x56
function gettripwirestretchanim( animname )
{
    switch ( animname )
    {
        case #"hash_28b4e95012259360":
            return %tripwire_trigger_standard_stretch;
        case #"hash_3e7681464ca7b9fd":
            return %tripwire_trigger_standard_stretch;
        case #"hash_bdea657441323e75":
            return %tripwire_trigger_standard_stretch;
    }
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x231e
// Size: 0x5d
function gettripwiremodel( animname )
{
    if ( !isdefined( animname ) )
    {
        assertmsg( "tripwire struct found with missing script_animname KVP.  Reopen your map, save, and compile only ents to fix" );
    }
    
    switch ( animname )
    {
        case #"hash_28b4e95012259360":
            return "equipment_wm_tripwire_standard";
        case #"hash_3e7681464ca7b9fd":
            return "equipment_wm_tripwire_standard";
        case #"hash_bdea657441323e75":
            return "equipment_wm_tripwire_standard";
    }
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0x2383
// Size: 0x1e, Type: bool
function shouldusewallsize1()
{
    return self.length >= 51 && self.length < 69;
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0x23aa
// Size: 0x1e, Type: bool
function shouldusewallsize2()
{
    return self.length >= 69 && self.length < 100;
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0x23d1
// Size: 0x1e, Type: bool
function shouldusewallsize3()
{
    return self.length > 10 && self.length < 37;
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0x23f8
// Size: 0x1e, Type: bool
function shouldusewallsize4()
{
    return self.length >= 37 && self.length < 51;
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 3
// Checksum 0x0, Offset: 0x241f
// Size: 0x187
function triggerfunctripwire( who, triggertraps, firsttriggered )
{
    self.trigger delete();
    self setanimrate( self.triggeranim, 1 );
    self setanim( %tripwire_stretch_overlay, 0, 0.2, 0 );
    
    if ( !self.var_d8ec40ff894a8d81 )
    {
        thread swaptostaticmodel();
    }
    
    triggersound = gettripwiretriggersound( firsttriggered );
    thread play_sound_in_space( triggersound, self.origin );
    
    if ( isdefined( self.finalangles ) && !self.var_d8ec40ff894a8d81 )
    {
        thread rotatetofinalangles();
    }
    
    if ( who == level.player )
    {
        level.player playrumbleonentity( "damage_light" );
        earthquake( 0.1, 0.2, level.player.origin, 2000 );
    }
    
    wait self.delay;
    
    if ( isdefined( self.navmodifier ) )
    {
        destroynavobstacle( self.navmodifier );
    }
    
    firsttriggered = 0;
    
    foreach ( target in self.targets )
    {
        target notify( "trigger", who, triggertraps, firsttriggered );
    }
    
    if ( self.var_d8ec40ff894a8d81 )
    {
        self delete();
    }
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0x25ae
// Size: 0x24
function rotatetofinalangles()
{
    self endon( "death" );
    wait 0.25;
    self rotateto( self.finalangles, 0.25 );
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0x25da
// Size: 0x2d
function swaptostaticmodel()
{
    animtime = getanimlength( self.triggeranim );
    wait animtime;
    self setmodel( self.staticmodel );
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x260f
// Size: 0x100
function triggerfuncsemtex( who )
{
    if ( isdefined( self.grenadeweaponoverride ) )
    {
        grenadetype = self.grenadeweaponoverride;
    }
    else
    {
        grenadetype = "semtex_tripwire";
    }
    
    semtex = magicgrenademanual( grenadetype, self.origin, ( 0, 0, 0 ), 0.25 );
    semtex.angles = self.angles;
    semtex.origin = self.origin;
    semtex linkto( self );
    self hide();
    thread death_hint_think( 60, "MOD_GRENADE_SPLASH" );
    semtex waittill( "explode" );
    level notify( "tripwire_grenade_explode", self );
    playrumbleonposition( "grenade_rumble", self.origin );
    earthquake( 0.45, 0.7, self.origin, 800 );
    wait 0.1;
    self notify( "cancel_death_hint" );
    self delete();
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x2717
// Size: 0x100
function triggerfuncfrag( who )
{
    if ( isdefined( self.grenadeweaponoverride ) )
    {
        grenadetype = self.grenadeweaponoverride;
    }
    else
    {
        grenadetype = "frag_tripwire";
    }
    
    frag = magicgrenademanual( grenadetype, self.origin, ( 0, 0, 0 ), 0.25 );
    frag.angles = self.angles;
    frag.origin = self.origin;
    frag linkto( self );
    self hide();
    thread death_hint_think( 60, "MOD_GRENADE_SPLASH" );
    frag waittill( "explode" );
    level notify( "tripwire_grenade_explode", self );
    playrumbleonposition( "grenade_rumble", self.origin );
    earthquake( 0.45, 0.7, self.origin, 800 );
    wait 0.1;
    self notify( "cancel_death_hint" );
    self delete();
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x281f
// Size: 0x110
function triggerfuncc4( who )
{
    if ( isdefined( self.grenadeweaponoverride ) )
    {
        grenadetype = self.grenadeweaponoverride;
    }
    else
    {
        grenadetype = "c4_sp_tripwire";
    }
    
    c4 = magicgrenademanual( grenadetype, self.origin, ( 0, 0, 0 ), 0.25 );
    c4.angles = self.angles;
    c4.origin = self.origin;
    thread play_sound_in_space( "minefield_click", self.origin );
    self hide();
    c4 setscriptablepartstate( "plant", "active", 0 );
    c4 waittill( "explode" );
    thread play_sound_in_space( "iw9_frag_grenade_expl_trans", self.origin );
    playrumbleonposition( "grenade_rumble", self.origin );
    earthquake( 0.45, 0.7, self.origin, 800 );
    self delete();
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x2937
// Size: 0x98
function function_ff147402c60ccd89( who )
{
    if ( isdefined( self.grenadeweaponoverride ) )
    {
        grenadetype = self.grenadeweaponoverride;
    }
    else
    {
        grenadetype = "bottle";
    }
    
    bottle = magicgrenademanual( grenadetype, self.origin, ( 0, 0, 0 ) );
    bottle.angles = self.angles;
    bottle.origin = self.origin;
    self delete();
    who thread scripts\sp\equipment\bottle::function_4b06c81b27875a14( bottle );
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x29d7
// Size: 0x101
function function_69edfcd6ffcd5561( who )
{
    thread overkill_manager();
    magicbullet( self.weaponobject, self.var_e84ad86715d85cc, self.var_6a862672391c9895 );
    
    if ( !isdefined( level.stealth ) )
    {
        return;
    }
    
    if ( flag( "stealth_spotted" ) )
    {
        radius = getstealtheventrange( "spotted", "gunshot" );
    }
    else
    {
        radius = getstealtheventrange( "hidden", "gunshot" );
    }
    
    aiarray = getaiarrayinradius( self.origin, radius );
    
    foreach ( ai in aiarray )
    {
        if ( !isdefined( ai.stealth ) )
        {
            continue;
        }
        
        ai aieventlistenerevent( "gunshot", who, self.origin );
    }
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0x2ae0
// Size: 0x4b
function overkill_manager()
{
    level.player val::set( "trap", "shotgun_overkill", 1 );
    waitframe();
    
    if ( isalive( level.player ) )
    {
        level.player val::set( "trap", "shotgun_overkill", 0 );
    }
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 2
// Checksum 0x0, Offset: 0x2b33
// Size: 0x70
function death_hint_think( quote, var_74cf69ce872e454a )
{
    self endon( "cancel_death_hint" );
    level.player waittill( "death", attacker, cause, objweapon, movingplatform, inflictor );
    
    if ( cause == var_74cf69ce872e454a )
    {
        scripts\sp\player_death::set_custom_death_quote( quote );
    }
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 2
// Checksum 0x0, Offset: 0x2bab
// Size: 0x1e9
function damagetrapfuncthink( damagefunc, struct )
{
    self endon( "trap_trigger" );
    self setcandamage( 1 );
    self.health = 99999;
    
    while ( true )
    {
        self waittill( "damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( candamagetrap( attacker, type, damage ) )
        {
            break;
        }
        
        self.health += damage;
    }
    
    self.triggered = 1;
    
    if ( isdefined( self.defusehintstruct ) && !isdefined( self.defusehintstruct.defused ) && !level.tripwires.traptypes[ struct.script_noteworthy ].var_fa943467b1592255 )
    {
        self.defusehintstruct scripts\sp\player\cursor_hint::remove_cursor_hint();
    }
    
    triggertraps = 0;
    firsttriggered = 1;
    
    foreach ( parenttripwire in self.parenttripwires )
    {
        parenttripwire notify( "trigger", attacker, triggertraps, firsttriggered );
    }
    
    self notify( "trigger", attacker, 1 );
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 3
// Checksum 0x0, Offset: 0x2d9c
// Size: 0x76, Type: bool
function candamagetrap( attacker, type, damage )
{
    if ( !isdefined( attacker ) )
    {
        return false;
    }
    
    if ( attacker == level.player && ( type == "MOD_GRENADE_SPLASH" || type == "MOD_PROJECTILE_SPLASH" ) && damage > 150 )
    {
        if ( level.player getplayerprogression( "achievementBoom" ) != "true" )
        {
            thread trapachievementboom();
        }
        
        return true;
    }
    
    return false;
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 0
// Checksum 0x0, Offset: 0x2e1b
// Size: 0x105
function trapachievementboom()
{
    tok = strtok( level.player getplayerprogression( "achievementBoom" ), "," );
    string_origin = "" + self.origin[ 0 ] + self.origin[ 1 ];
    
    if ( level.player getplayerprogression( "achievementBoom" ) == "" )
    {
        level.player setplayerprogression( "achievementBoom", string_origin );
        return;
    }
    
    if ( tok.size == 1 && tok[ 0 ] != string_origin )
    {
        level.player setplayerprogression( "achievementBoom", tok[ 0 ] + "," + string_origin );
        return;
    }
    
    if ( tok.size == 2 && !isstartstr( tok[ 0 ], string_origin ) && !isstartstr( tok[ 1 ], string_origin ) )
    {
        level.player setplayerprogression( "achievementBoom", "true" );
        level thread scripts\sp\utility::giveachievement_wrapper( "boom" );
    }
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 2
// Checksum 0x0, Offset: 0x2f28
// Size: 0x264
function disarmfuncthink( disarmfunc, struct )
{
    if ( !level.tripwires.traptypes[ struct.script_noteworthy ].var_fa943467b1592255 )
    {
        self endon( "trap_trigger" );
    }
    
    if ( isdefined( struct.radius ) )
    {
        var_7c46ca1bdcc9e980 = struct.radius;
    }
    else
    {
        var_7c46ca1bdcc9e980 = 64;
    }
    
    hint_offset = ( 0, 0, 0 );
    self.defusehintstruct = struct spawn_script_origin();
    
    if ( isdefined( level.tripwires.traptypes[ struct.script_noteworthy ].cursorhintstring ) )
    {
        self.defusehintstruct scripts\sp\player\cursor_hint::create_cursor_hint( undefined, hint_offset, level.tripwires.traptypes[ struct.script_noteworthy ].cursorhintstring, 2, var_7c46ca1bdcc9e980, 64, 0, 0, 0, undefined, "duration_medium" );
    }
    else
    {
        self.defusehintstruct scripts\sp\player\cursor_hint::create_cursor_hint( undefined, hint_offset, &"SCRIPT/DEFUSE", 2, var_7c46ca1bdcc9e980, 64, 0, 0, 0, undefined, "duration_medium" );
    }
    
    if ( isdefined( struct.script_spotlight ) )
    {
        self.defusehintstruct.script_spotlight = struct.script_spotlight;
    }
    
    self.defusehintstruct waittill( "trigger", who );
    level.lasttripwiredefusedtime = gettime();
    self.defusehintstruct.defused = 1;
    self.triggered = 1;
    triggertraps = 0;
    firsttriggered = 1;
    
    if ( isdefined( self.var_e8c8fefe0dfaabde ) )
    {
        self [[ self.var_e8c8fefe0dfaabde ]]();
    }
    
    self [[ disarmfunc ]]( who );
    
    foreach ( parenttripwire in self.parenttripwires )
    {
        parenttripwire notify( "trigger", who, triggertraps, firsttriggered );
    }
    
    if ( isdefined( self.var_68eed041e77be27 ) )
    {
        self [[ self.var_68eed041e77be27 ]]();
    }
    
    self delete();
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x3194
// Size: 0x7e
function getdisarmfunc( type )
{
    switch ( type )
    {
        case #"hash_4beeaacc1db7b8cc":
            return &disarmfuncsemtex;
        case #"hash_496a20490fb91698":
            return &disarmfuncfrag;
        case #"hash_e0b40680bb70bdb4":
            return &function_a7f90b357bc11ab5;
        case #"hash_996be0d30bf84ba0":
            return &function_7b932c4705fd44b5;
        default:
            assertmsg( "Add a disarm func for trigger trap " + type + " to scriptsspequipment\tripwire::getDisarmFunc" );
            break;
    }
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x321a
// Size: 0x1d
function disarmfuncsemtex( who )
{
    who function_fcbf46aca1ddde2a( "semtex", "semtex" );
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x323f
// Size: 0x1d
function disarmfuncfrag( who )
{
    who function_fcbf46aca1ddde2a( "frag", "frag" );
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x3264
// Size: 0x1d
function function_a7f90b357bc11ab5( who )
{
    who function_fcbf46aca1ddde2a( "bottle", "bottle" );
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x3289
// Size: 0x29f
function function_7b932c4705fd44b5( who )
{
    if ( !isplayer( who ) )
    {
        return;
    }
    
    if ( who player_has_weapon( self.weaponobject ) )
    {
        ammoamount = self.script_ammo_clip;
        var_9eabbd13591b6dfb = who getweaponammostock( getweaponbasename( self.weaponobject ) ) + ammoamount;
        who setweaponammostock( self.weaponobject, var_9eabbd13591b6dfb );
        who notify( "ammo_pickup", ammoamount, getweaponammopoolname( self.weaponobject ) );
        return;
    }
    
    primaryweapons = who.primaryweapons;
    
    foreach ( primaryweapon in primaryweapons )
    {
        if ( is_equal( primaryweapon.basename, "none" ) )
        {
            primaryweapons = array_remove( primaryweapons, primaryweapon );
        }
    }
    
    if ( primaryweapons.size >= 2 )
    {
        if ( weaponcandrop( who.currentweapon ) )
        {
            var_b375af50d8d557a3 = who getweaponammostock( who.currentweapon );
            var_3b508d61581b138d = who getweaponammoclip( who.currentweapon );
            var_cd028c8593c6371d = getweaponattachments( who.currentweapon );
            droppedweaponname = who.currentweapon.basename;
            
            foreach ( var_443a58b864c0b11c in var_cd028c8593c6371d )
            {
                droppedweaponname += "+" + var_443a58b864c0b11c;
            }
            
            droppedweapon = spawn( "weapon_" + droppedweaponname, who.origin + ( 0, 0, 15 ) );
            droppedweapon itemweaponsetammo( var_3b508d61581b138d, var_b375af50d8d557a3 );
            who notify( "pickup", undefined, droppedweapon );
        }
        else
        {
            who notify( "pickup" );
        }
        
        who takeweapon( who.currentweapon );
        who giveweapon( self.weaponobject );
        who switchtoweapon( self.weaponobject );
        return;
    }
    
    who notify( "pickup" );
    who giveweapon( self.weaponobject );
    who switchtoweapon( self.weaponobject );
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 2
// Checksum 0x0, Offset: 0x3530
// Size: 0x5f
function function_fcbf46aca1ddde2a( equipmentname, lootname )
{
    if ( self == level.player )
    {
        if ( !hasequipmentoftype( equipmentname ) )
        {
            level.player give_offhand( equipmentname );
            level.player setweaponammoclip( equipmentname, 0 );
        }
        
        if ( scripts\engine\sp\utility::player_has_equipment( equipmentname ) )
        {
            scripts\sp\loot::lootfuncandnotification( lootname );
        }
    }
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 1
// Checksum 0x0, Offset: 0x3597
// Size: 0x96, Type: bool
function hasequipmentoftype( weap )
{
    objweapon = weap;
    
    if ( isstring( weap ) )
    {
        objweapon = makeweaponfromstring( weap );
    }
    
    equiplist = level.player.offhandinventory;
    
    foreach ( weapon in equiplist )
    {
        if ( issameoffhandtype( weapon, objweapon ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace tripwire / scripts\sp\equipment\tripwire
// Params 2
// Checksum 0x0, Offset: 0x3636
// Size: 0x29, Type: bool
function issameoffhandtype( weapon, objweapon )
{
    if ( scripts\sp\equipment\offhands::getweaponoffhandtype( weapon ) == scripts\sp\equipment\offhands::getweaponoffhandtype( objweapon ) )
    {
        return true;
    }
    
    return false;
}

