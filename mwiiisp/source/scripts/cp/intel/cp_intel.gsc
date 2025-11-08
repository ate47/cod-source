#using scripts\common\utility;
#using scripts\cp\cp_achievement;
#using scripts\cp\cp_analytics;
#using scripts\cp\cp_hud_message;
#using scripts\cp\pickups;
#using scripts\cp\rewards_cp;
#using scripts\cp\utility;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\equipment\geiger_counter;
#using scripts\engine\scriptable;
#using scripts\engine\utility;

#namespace cp_intel;

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 0
// Checksum 0x0, Offset: 0x5ac
// Size: 0x90
function intel_init()
{
    level.var_364c64ac310725a0 = 1;
    level.intel_pieces = [];
    level.var_513dade59614f0d7 = [];
    scripts\cp_mp\equipment\geiger_counter::function_58bf160252f94e21();
    function_fe2f023d5e916d98();
    function_73a0b19d74034096();
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "intel_interaction", &intel_onuse );
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "cp_intel_found", &function_8ee46d8dd9b85eb4 );
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "key_interaction", &function_c67a2a3c68f962a1 );
    cmd = "devgui_cmd \"CP Debug:2 / Intel / Show Intel Positions\" \"set intel_outline 1\" \n";
    addentrytodevgui( cmd );
    cmd = "devgui_cmd \"CP Debug:2 / Intel / Give All Intel For Level\" \"set intel_giveall 1\" \n";
    addentrytodevgui( cmd );
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 0
// Checksum 0x0, Offset: 0x644
// Size: 0x56
function function_fe2f023d5e916d98()
{
    level.var_513dade59614f0d7 = [];
    
    for ( index = 0; true ; index++ )
    {
        val = tablelookup( "cp/cp_intel.csv", 0, index, 1 );
        
        if ( val == "" )
        {
            break;
        }
        
        level.var_513dade59614f0d7[ index ] = val;
    }
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 0
// Checksum 0x0, Offset: 0x6a2
// Size: 0x586
function function_73a0b19d74034096()
{
    if ( flag_exist( "strike_init_done" ) )
    {
        flag_wait( "strike_init_done" );
    }
    
    wait 2;
    var_3004da8038b93d37 = getstructarray( "cp_intel", "targetname" );
    
    foreach ( var_c0c4728da43ffc9e in var_3004da8038b93d37 )
    {
        if ( !isdefined( level.intel_pieces[ var_c0c4728da43ffc9e.inteltype ] ) )
        {
            level.intel_pieces[ var_c0c4728da43ffc9e.inteltype ] = [];
        }
        
        if ( !isdefined( level.intel_pieces[ var_c0c4728da43ffc9e.inteltype ][ var_c0c4728da43ffc9e.script_noteworthy ] ) )
        {
            level.intel_pieces[ var_c0c4728da43ffc9e.inteltype ][ var_c0c4728da43ffc9e.script_noteworthy ] = [];
        }
        
        level.intel_pieces[ var_c0c4728da43ffc9e.inteltype ][ var_c0c4728da43ffc9e.script_noteworthy ][ level.intel_pieces[ var_c0c4728da43ffc9e.inteltype ][ var_c0c4728da43ffc9e.script_noteworthy ].size ] = var_c0c4728da43ffc9e;
    }
    
    duplicates = [];
    var_5f9f112a3d6a73af = [];
    keys = getarraykeys( level.intel_pieces );
    
    foreach ( key in keys )
    {
        foreach ( entry in level.intel_pieces[ key ] )
        {
            if ( isarray( entry ) )
            {
                duplicates[ duplicates.size ] = entry;
                continue;
            }
            
            var_5f9f112a3d6a73af[ var_5f9f112a3d6a73af.size ] = entry;
        }
    }
    
    foreach ( duplicate in duplicates )
    {
        duplicate = array_randomize( duplicate );
        var_5f9f112a3d6a73af[ var_5f9f112a3d6a73af.size ] = duplicate[ 0 ];
    }
    
    foreach ( entry in var_5f9f112a3d6a73af )
    {
        entry.intel = spawn( "script_model", entry.origin );
        entry.intel.angles = entry.angles;
        entry.intel setmodel( entry.scriptablename );
        entry.intel.inteltype = entry.inteltype;
        entry.intel.info = entry.script_noteworthy;
        entry.intel.foundintel = spawnscriptable( "cp_intel_found", entry.origin, entry.angles );
        
        if ( isdefined( entry.target ) )
        {
            linkedent = getent( entry.target, "targetname" );
            entry.intel linkto( linkedent );
            entry.intel.linkedent = linkedent;
            offset = rotatevectorinverted( entry.intel.foundintel.origin - linkedent.origin, linkedent.angles );
            entry.intel.foundintel utility::scriptable_setparententity( linkedent, offset );
        }
        
        if ( entry.inteltype == "geiger" || entry.inteltype == "burried" )
        {
            scripts\cp_mp\equipment\geiger_counter::function_f0d61e14dfde9ccd( entry.intel );
            entry.intel.foundintel.origin = entry.origin + ( 0, 0, 18 );
        }
    }
    
    /#
        if ( getdvarint( @"intel_hud", 0 ) > 0 )
        {
            foreach ( player in level.players )
            {
                if ( var_5f9f112a3d6a73af.size > 1 )
                {
                    player.var_23f0673432d1890 setdevtext( "<dev string:x1c>" + var_5f9f112a3d6a73af.size );
                    continue;
                }
                
                player.var_4cfa2a66836f458a setdevtext( "<dev string:x2e>" );
            }
        }
    #/
    
    level.var_ed3f685fff07e56c = var_5f9f112a3d6a73af.size;
    level.var_7bed7fd13abbbc9c = var_5f9f112a3d6a73af;
    setomnvar( "ui_aar_intel_items_total", level.var_ed3f685fff07e56c );
    level thread intel_debug( var_5f9f112a3d6a73af );
    level thread function_9f807f191f427b48();
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 1
// Checksum 0x0, Offset: 0xc30
// Size: 0x205
function intel_debug( var_5f9f112a3d6a73af )
{
    /#
        outlineenabled = 0;
        
        while ( true )
        {
            if ( getdvarint( @"intel_outline", 0 ) > 0 )
            {
                foreach ( intel in var_5f9f112a3d6a73af )
                {
                    if ( !isdefined( intel.intel ) )
                    {
                        continue;
                    }
                    
                    sphere( intel.origin, 8, ( 1, 0, 0 ), 0, 20 );
                }
            }
            
            if ( getdvarint( @"hash_fb385e7c0068a335", 0 ) > 0 )
            {
                foreach ( intel in level.var_7bed7fd13abbbc9c )
                {
                    if ( !isdefined( intel.intel.uses ) )
                    {
                        intel.intel.uses = 0;
                    }
                    
                    intel.intel.uses++;
                    function_99676fb4e1a06631( intel, level.players[ 0 ] );
                    intel.intel disablescriptablepartplayeruse( "<dev string:x48>", level.players[ 0 ] );
                    intel.intel hidefromplayer( level.players[ 0 ] );
                    intel.intel.foundintel enablescriptablepartplayeruse( "<dev string:x5a>", level.players[ 0 ] );
                    intel.intel.foundintel setscriptablepartstate( "<dev string:x5a>", "<dev string:x69>" );
                }
                
                iprintlnbold( "<dev string:x70>" );
                setdvar( @"hash_fb385e7c0068a335", 0 );
            }
            
            wait 1;
        }
    #/
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 6
// Checksum 0x0, Offset: 0xe3d
// Size: 0x72
function function_c67a2a3c68f962a1( instance, part, state, player, bautouse, usestring )
{
    player thread playerplaypickupanim( "iw9_ges_pickup" );
    wait 0.35;
    player playlocalsound( "iw9_br_pickup_key" );
    player.var_d203b9037bcf0441 = 1;
    instance.entity hide();
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 6
// Checksum 0x0, Offset: 0xeb7
// Size: 0x266
function intel_onuse( instance, part, state, player, bautouse, usestring )
{
    player endon( "disconnect" );
    
    if ( !isdefined( instance.uses ) )
    {
        instance.uses = 0;
    }
    
    instance.uses++;
    inteltype = instance.inteltype;
    player thread playerplaypickupanim( "iw9_ges_pickup" );
    player playlocalsound( "cp_generic_pickup_intel" );
    function_99676fb4e1a06631( instance, player );
    
    /#
        if ( getdvarint( @"intel_hud", 0 ) > 0 )
        {
            player.var_23f0673432d1890 setdevtext( "<dev string:x8d>" + player.var_131e879b6bb142ac + "<dev string:x9c>" + level.var_ed3f685fff07e56c );
        }
    #/
    
    player function_d1c29eebb4179b49( instance );
    player scripts\cp\rewards_cp::function_1caa50f367871948();
    player scripts\cp\rewards_cp::function_5da13cac404268cb();
    instance disablescriptablepartplayeruse( part, player );
    wait 0.35;
    instance.entity hidefromplayer( player );
    
    foreach ( playerent in level.players )
    {
        if ( playerent != player )
        {
            if ( !playerent function_6fb0c700a7aaf634( instance ) )
            {
                instance.entity.foundintel disablescriptablepartplayeruse( "cp_intel_found", playerent );
            }
        }
    }
    
    wait 5;
    instance.entity.foundintel enablescriptablepartplayeruse( "cp_intel_found", player );
    instance.entity.foundintel setscriptablepartstate( "cp_intel_found", "usable" );
    
    foreach ( playerent in level.players )
    {
        if ( playerent != player )
        {
            if ( !playerent function_6fb0c700a7aaf634( instance ) )
            {
                instance.entity.foundintel disablescriptablepartplayeruse( "cp_intel_found", playerent );
            }
        }
    }
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 0
// Checksum 0x0, Offset: 0x1125
// Size: 0x12f
function intel_onplayerconnect()
{
    if ( !istrue( level.var_364c64ac310725a0 ) )
    {
        return;
    }
    
    player = self;
    
    if ( !isdefined( player.var_23f0673432d1890 ) )
    {
        player.var_23f0673432d1890 = newclienthudelem( player );
        player.var_23f0673432d1890.alignx = "left";
        player.var_23f0673432d1890.location = 0;
        player.var_23f0673432d1890.foreground = 1;
        player.var_23f0673432d1890.fontscale = 0.8;
        player.var_23f0673432d1890.sort = 20;
        player.var_23f0673432d1890.alpha = 1;
        player.var_23f0673432d1890.x = 50;
        player.var_23f0673432d1890.y = 40;
        
        /#
            if ( getdvarint( @"intel_hud", 0 ) > 0 )
            {
                player.var_23f0673432d1890 setdevtext( "<dev string:x9e>" );
            }
        #/
    }
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 0
// Checksum 0x0, Offset: 0x125c
// Size: 0xa
function function_383bbac10494b5ff()
{
    thread function_1b529f27946812ef();
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 0
// Checksum 0x0, Offset: 0x126e
// Size: 0x1c8
function function_1b529f27946812ef()
{
    self endon( "disconnect" );
    self setclientomnvar( "ui_aar_intel_items_found", 0 );
    
    if ( !istrue( level.var_364c64ac310725a0 ) )
    {
        return;
    }
    
    while ( !isdefined( level.var_7bed7fd13abbbc9c ) )
    {
        wait 1;
    }
    
    foreach ( intel in level.var_7bed7fd13abbbc9c )
    {
        if ( function_6fb0c700a7aaf634( intel ) )
        {
            if ( !isdefined( intel.intel.uses ) )
            {
                intel.intel.uses = 0;
            }
            
            intel.intel.uses++;
            function_99676fb4e1a06631( intel, self );
            
            /#
                if ( getdvarint( @"intel_hud", 0 ) > 0 )
                {
                    self.var_23f0673432d1890 setdevtext( "<dev string:x8d>" + self.var_131e879b6bb142ac + "<dev string:x9c>" + level.var_ed3f685fff07e56c );
                }
            #/
            
            intel.intel disablescriptablepartplayeruse( "intel_interaction", self );
            intel.intel hidefromplayer( self );
            intel.intel.foundintel enablescriptablepartplayeruse( "cp_intel_found", self );
            intel.intel.foundintel setscriptablepartstate( "cp_intel_found", "usable" );
            continue;
        }
        
        intel.intel enablescriptablepartplayeruse( "intel_interaction", self );
        intel.intel.foundintel disablescriptablepartplayeruse( "cp_intel_found", self );
    }
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 2
// Checksum 0x0, Offset: 0x143e
// Size: 0x178
function function_99676fb4e1a06631( intel, player )
{
    var_f5d35734c484490 = intel;
    
    if ( isdefined( intel.entity ) )
    {
        var_f5d35734c484490 = intel.entity;
    }
    else if ( isdefined( intel.intel ) )
    {
        var_f5d35734c484490 = intel.intel;
    }
    
    if ( !isdefined( player.foundintel ) )
    {
        player.foundintel = [];
        player.var_131e879b6bb142ac = 0;
    }
    
    if ( !isdefined( player.foundintel[ var_f5d35734c484490.inteltype ] ) )
    {
        player.foundintel[ var_f5d35734c484490.inteltype ] = [];
    }
    
    player.foundintel[ var_f5d35734c484490.inteltype ][ player.foundintel[ var_f5d35734c484490.inteltype ].size ] = var_f5d35734c484490.info;
    player.var_131e879b6bb142ac++;
    
    if ( scripts\engine\utility::issharedfuncdefined( "cp_intel", "givetoplayer" ) )
    {
        var_fa03ab34cbdaece2 = scripts\engine\utility::getsharedfunc( "cp_intel", "givetoplayer" );
        player thread [[ var_fa03ab34cbdaece2 ]]( intel );
    }
    
    if ( isdefined( var_f5d35734c484490.inteltype ) && var_f5d35734c484490.inteltype == "geiger" )
    {
        level notify( "geigerIntelGiven", player );
    }
    
    player setclientomnvar( "ui_aar_intel_items_found", player.var_131e879b6bb142ac );
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 1
// Checksum 0x0, Offset: 0x15be
// Size: 0x2e
function function_6fb0c700a7aaf634( intel )
{
    intel_table_ref = function_de2ec54ae00c7b1e( intel );
    return self getplayerdata( "cp", "cpIntel", intel_table_ref );
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 1
// Checksum 0x0, Offset: 0x15f5
// Size: 0xbb
function function_d1c29eebb4179b49( intel )
{
    intel_table_ref = 1;
    intel_table_ref = function_de2ec54ae00c7b1e( intel );
    
    if ( !function_6fb0c700a7aaf634( intel ) )
    {
        total_intel = self getplayerdata( "cp", "totalIntel" );
        self setplayerdata( "cp", "totalIntel", total_intel + 1 );
        total_intel = self getplayerdata( "cp", "totalIntel" );
        
        if ( total_intel >= 20 )
        {
            scripts\cp\cp_achievement::function_5979446ee216f232();
        }
    }
    
    self setplayerdata( "cp", "cpIntel", intel_table_ref, 1 );
    thread function_db99538b03b9907c( intel, intel_table_ref );
    thread scripts\cp\cp_hud_message::showsplash( "cp_intel_found_" + self.var_131e879b6bb142ac, level.var_7bed7fd13abbbc9c.size, self );
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 2
// Checksum 0x0, Offset: 0x16b8
// Size: 0x159
function function_db99538b03b9907c( intel, intel_table_ref )
{
    if ( !isdefined( intel_table_ref ) )
    {
        intel_table_ref = 1;
    }
    
    current_beat = scripts\cp\cp_analytics::function_32900c5a73179b4();
    sharedaccount_uid = scripts\cp\cp_analytics::function_512417bddbe63792();
    kit = scripts\cp\cp_analytics::function_4bf5c934fad2bc96();
    [ x1, y1, z1 ] = scripts\cp\cp_analytics::function_72d38b83fc04ee8e();
    active_objective = level.active_objectives_string;
    self dlog_recordplayerevent( "dlog_event_cpdata_plr_found_intel", [ "levelname", level.script, "name", self.name, "x1", x1, "y1", y1, "z1", z1, "intel_table_ref", "" + intel_table_ref, "player_kit", scripts\cp\cp_analytics::function_4bf5c934fad2bc96(), "sharedaccount_uid", sharedaccount_uid, "current_beat", current_beat, "active_objective", active_objective ] );
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 1
// Checksum 0x0, Offset: 0x1819
// Size: 0x99
function function_de2ec54ae00c7b1e( intel )
{
    foreach ( index, var_513dade59614f0d7 in level.var_513dade59614f0d7 )
    {
        if ( isstruct( intel ) )
        {
            if ( var_513dade59614f0d7 == intel.intel.info )
            {
                return index;
            }
            
            continue;
        }
        
        if ( var_513dade59614f0d7 == intel.entity.info )
        {
            return index;
        }
    }
    
    return undefined;
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 0
// Checksum 0x0, Offset: 0x18bb
// Size: 0xc0
function function_e6685bde2112e37()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player scripts\cp_mp\equipment::hasequipment( "equip_geigercounter" ) || player function_80e71ae6dd99cf74( self ) )
            {
                self enablescriptablepartplayeruse( "intel_interaction", player );
                self.foundintel enablescriptablepartplayeruse( "cp_intel_found", player );
            }
            else
            {
                self disablescriptablepartplayeruse( "intel_interaction", player );
                self.foundintel disablescriptablepartplayeruse( "cp_intel_found", player );
            }
            
            waitframe();
        }
        
        wait 1;
    }
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 1
// Checksum 0x0, Offset: 0x1983
// Size: 0xa3, Type: bool
function function_80e71ae6dd99cf74( intel )
{
    near = 0;
    
    foreach ( player in level.players )
    {
        if ( player == self )
        {
            continue;
        }
        
        if ( !player scripts\cp_mp\equipment::hasequipment( "equip_geigercounter" ) )
        {
            continue;
        }
        
        if ( distancesquared( player.origin, intel.origin ) < 1048576 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 0
// Checksum 0x0, Offset: 0x1a2f
// Size: 0x131
function function_9f807f191f427b48()
{
    deskdrawer = getent( "deskdrawer", "targetname" );
    
    if ( !isdefined( deskdrawer ) )
    {
        return;
    }
    
    deskdrawer.usableent = spawn( "script_model", deskdrawer.origin + ( 0, 0, 2 ) + anglestoforward( deskdrawer.angles + ( 0, -90, 0 ) ) * 2 );
    deskdrawer.usableent setmodel( "tag_origin" );
    deskdrawer.usableent makeusable();
    deskdrawer.usableent sethintstring( &"CP_INTEL_IW9/OPEN_DRAWER" );
    deskdrawer.usableent setcursorhint( "HINT_BUTTON" );
    deskdrawer.usableent sethintdisplayrange( 150 );
    deskdrawer.usableent sethintdisplayfov( 65 );
    deskdrawer.usableent setusefov( 65 );
    deskdrawer.usableent setuserange( 65 );
    deskdrawer.usableent sethintonobstruction( "hide" );
    deskdrawer thread function_d6793ff179c0374b();
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 1
// Checksum 0x0, Offset: 0x1b68
// Size: 0xd7
function function_d6793ff179c0374b( var_23d618c7053f6873 )
{
    while ( true )
    {
        self.usableent waittill( "trigger", ent );
        
        if ( !ent is_valid_player() )
        {
            continue;
        }
        
        self.usableent disableplayeruseforallplayers();
        
        if ( !istrue( ent.var_d203b9037bcf0441 ) )
        {
            ent scripts\cp\cp_hud_message::tutorialprint( &"CP_INTEL_IW9/LOCKED", 2 );
            self.usableent enableplayeruseforallplayers();
            continue;
        }
        
        break;
    }
    
    self.usableent delete();
    
    if ( soundexists( "cp_hydro_open_drawer" ) )
    {
        self playsound( "cp_hydro_open_drawer" );
    }
    
    self moveto( self.origin + anglestoforward( self.angles + ( 0, -90, 0 ) ) * 12, 1 );
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 0
// Checksum 0x0, Offset: 0x1c47
// Size: 0x117
function function_659eeda1bb608163()
{
    level.var_1b411690973e8aff = [];
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "interact_main", &function_c5c7693371e9ebfc );
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "interact_radio", &function_c5c7693371e9ebfc );
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "interact_radar", &function_c5c7693371e9ebfc );
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "interact_antenna", &function_c5c7693371e9ebfc );
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "sat_interaction", &function_22b1dddc0c1daadc );
    sat = getent( "sat_main", "targetname" );
    sat.antennae = getent( "sat_antennae", "targetname" );
    sat.radar = getent( "sat_radar", "targetname" );
    sat.radio = getent( "sat_radio", "targetname" );
    level.sat = sat;
    level.var_1b411690973e8aff = [ sat.antennae, sat.radar, sat.radio ];
    level.var_e319f9bcb1dcc775 = 0;
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 6
// Checksum 0x0, Offset: 0x1d66
// Size: 0x1c4
function function_22b1dddc0c1daadc( instance, part, state, player, bautouse, usestring )
{
    player thread playerplaypickupanim( "iw9_ges_pickup" );
    player playlocalsound( "cp_generic_pickup" );
    instance.entity hide();
    
    if ( instance.entity == level.sat.antennae )
    {
        level.sat.antennae linkto( level.sat, "j_antenna_pivot", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        player.var_f9c2aa6bb00dbd44 = 1;
    }
    else if ( instance.entity == level.sat.radio )
    {
        level.sat.radio linkto( level.sat, "j_controller_01", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        player.var_2c77748d45bd1b70 = 1;
    }
    else if ( instance.entity == level.sat.radar )
    {
        level.sat.radar linkto( level.sat, "j_radar_rot_01", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        player.var_2c9a618d45e3395f = 1;
    }
    
    instance setscriptablepartstate( part, "unusable" );
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 6
// Checksum 0x0, Offset: 0x1f32
// Size: 0x1aa
function function_c5c7693371e9ebfc( instance, part, state, player, bautouse, usestring )
{
    haspart = 0;
    
    if ( part == "interact_radio" && istrue( player.var_2c77748d45bd1b70 ) )
    {
        haspart = 1;
        level.sat.radio show();
    }
    else if ( part == "interact_antenna" && istrue( player.var_2c9a618d45e3395f ) )
    {
        haspart = 1;
        level.sat.radar show();
    }
    else if ( part == "interact_radar" && istrue( player.var_f9c2aa6bb00dbd44 ) )
    {
        haspart = 1;
        level.sat.antennae show();
    }
    
    if ( !haspart )
    {
        return;
    }
    
    instance setscriptablepartstate( part, "unusable" );
    level.var_e319f9bcb1dcc775++;
    
    if ( level.var_e319f9bcb1dcc775 == 3 )
    {
        level.sat setmodel( "military_deployable_satellite_rig_skeleton" );
        level.sat.antennae delete();
        level.sat.radio delete();
        level.sat.radar delete();
        level.sat setscriptablepartstate( "base", "unfold" );
        wait 7;
        level.sat setscriptablepartstate( "base", "rotation_loop" );
    }
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 0
// Checksum 0x0, Offset: 0x20e4
// Size: 0xef
function function_4f08afa61f734625()
{
    level.var_1462dc4ebe91527e = getentarray( "geiger_counter", "targetname" );
    
    if ( getdvarint( @"hash_e45ebe94a1ac60bd", 0 ) != 0 )
    {
        array_call( level.var_1462dc4ebe91527e, &delete );
        return;
    }
    
    foreach ( ent in level.var_1462dc4ebe91527e )
    {
        ent makeusable();
        ent sethintstring( &"COOP_GAME_PLAY/GEIGER_COUNTER_INTERACTION" );
        ent setcursorhint( "HINT_BUTTON" );
        ent sethinticon( "hud_icon_equipment_geiger" );
        ent sethintdisplayrange( 150 );
        ent sethintdisplayfov( 65 );
        ent setusefov( 65 );
        ent setuserange( 65 );
        ent sethintonobstruction( "hide" );
        ent thread function_52d31db6d260fbc();
    }
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 0
// Checksum 0x0, Offset: 0x21db
// Size: 0x103
function function_52d31db6d260fbc()
{
    self notify( "geigerCounterUseLoop" );
    self endon( "geigerCounterUseLoop" );
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( player scripts\cp_mp\equipment::hasequipment( "equip_geigercounter" ) )
        {
            continue;
        }
        
        player thread playerplaypickupanim( "iw9_ges_pickup" );
        player playlocalsound( "cp_generic_pickup" );
        var_3da70b8624e508a3 = player scripts\cp_mp\equipment::getcurrentequipment( "secondary" );
        var_6c8a4da181cd7a25 = undefined;
        
        if ( isdefined( var_3da70b8624e508a3 ) )
        {
            var_6c8a4da181cd7a25 = player scripts\cp_mp\equipment::getequipmentammo( var_3da70b8624e508a3 );
        }
        
        if ( isdefined( var_3da70b8624e508a3 ) && isdefined( var_6c8a4da181cd7a25 ) && var_6c8a4da181cd7a25 > 0 && player scripts\cp\pickups::function_8a160d9935d47f5e( var_3da70b8624e508a3, "equipment", var_6c8a4da181cd7a25 ) )
        {
            player scripts\cp\pickups::additemtobackpackbyref( var_3da70b8624e508a3, "equipment", var_6c8a4da181cd7a25 );
        }
        
        player thread scripts\cp_mp\equipment::giveequipment( "equip_geigercounter", "secondary" );
        player scripts\cp_mp\equipment::setequipmentammo( "equip_geigercounter", 1 );
        level notify( "geiger_given", player );
        self hidefromplayer( player );
    }
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 6
// Checksum 0x0, Offset: 0x22e6
// Size: 0x177
function function_8ee46d8dd9b85eb4( instance, part, state, player, bautouse, usestring )
{
    player endon( "disconnect" );
    
    if ( isdefined( player.var_e278c25f33b395d ) )
    {
        if ( gettime() - player.var_e278c25f33b395d < 4000 )
        {
            return;
        }
    }
    
    player.var_e278c25f33b395d = gettime();
    var_6755441cc24e975b = level.var_7bed7fd13abbbc9c.size - player.var_131e879b6bb142ac;
    player thread scripts\cp\cp_hud_message::showsplash( "cp_intel_already_found", var_6755441cc24e975b, player );
    wait 3;
    
    if ( var_6755441cc24e975b > 0 )
    {
        var_47402759f3df2df6 = [];
        
        foreach ( intel in level.var_7bed7fd13abbbc9c )
        {
            if ( !player function_6fb0c700a7aaf634( intel ) )
            {
                var_47402759f3df2df6[ var_47402759f3df2df6.size ] = intel;
            }
        }
        
        var_3aed03d71ca95f80 = getclosest( player.origin, var_47402759f3df2df6 );
        var_633cf60160097a37 = distance( player.origin, var_3aed03d71ca95f80.origin );
        var_633cf60160097a37 = function_c3f45de79d11b744( var_633cf60160097a37 );
        player thread scripts\cp\cp_hud_message::showsplash( "cp_intel_already_found_proximity", var_633cf60160097a37, player );
    }
}

// Namespace cp_intel / scripts\cp\intel\cp_intel
// Params 1
// Checksum 0x0, Offset: 0x2465
// Size: 0x30
function function_c3f45de79d11b744( inches )
{
    assertex( isnumber( inches ), "uToMeters() not given a number" );
    return int( int( inches ) * 0.0254 );
}

