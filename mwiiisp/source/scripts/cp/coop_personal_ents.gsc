#using scripts\common\utility;
#using scripts\cp\coop_personal_ents;
#using scripts\cp\interaction;
#using scripts\cp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace coop_personal_ents;

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x320
// Size: 0x5e
function autoexec main()
{
    if ( !isdefined( level.normal_mode_activation_funcs ) )
    {
        level.normal_mode_activation_funcs = [];
    }
    
    if ( !isdefined( level.special_mode_activation_funcs ) )
    {
        level.special_mode_activation_funcs = [];
    }
    
    if ( !isdefined( level.pentskipfov ) )
    {
        level.pentskipfov = [];
    }
    
    if ( !isdefined( level.pentparams ) )
    {
        level.pentparams = [];
    }
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 1
// Checksum 0x0, Offset: 0x386
// Size: 0x113
function assignpersonalmodelents( player )
{
    if ( getdvarint( @"hash_f043116157a9c2a", 0 ) )
    {
        if ( !isdefined( player.personalents ) || player.personalents.size < 1 )
        {
            player.personalents = [];
            player ent_flag_init( "personal_ents_updating" );
            
            for ( i = 0; i < 35 ; i++ )
            {
                ent = spawn( "script_model", ( 0, 0, -5000 ) );
                ent.ogorigin = ( 0, 0, -5000 );
                ent setmodel( "tag_origin" );
                ent.claimed = 0;
                ent.used = 0;
                adjustmodelvis( player, ent );
                player.personalents[ player.personalents.size ] = ent;
            }
        }
        
        disableuseotherplayerspents( player );
        level thread deletepentsondisconnect( player );
        level thread deletepentsonrespawn( player );
    }
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 1
// Checksum 0x0, Offset: 0x4a1
// Size: 0xa5
function deletepentsonrespawn( player )
{
    player notify( "deletePEntsOnRespawn" );
    player endon( "deletePEntsOnRespawn" );
    player endon( "disconnect" );
    level endon( "game_ended" );
    player waittill( "respawn_player", bool );
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.personalents ) )
    {
        return;
    }
    
    for ( i = 0; i < player.personalents.size ; i++ )
    {
        if ( isdefined( player.personalents[ i ] ) )
        {
            player.personalents[ i ] delete();
        }
    }
    
    player.personalents = [];
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 1
// Checksum 0x0, Offset: 0x54e
// Size: 0x80
function deletepentsondisconnect( player )
{
    level endon( "game_ended" );
    player notify( "deletePEntsOnDisconnect" );
    player endon( "deletePEntsOnDisconnect" );
    player waittill( "disconnect" );
    
    if ( !isdefined( player.personalents ) )
    {
        return;
    }
    
    for ( i = 0; i < player.personalents.size ; i++ )
    {
        if ( isdefined( player.personalents[ i ] ) )
        {
            player.personalents[ i ] delete();
        }
    }
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 11
// Checksum 0x0, Offset: 0x5d6
// Size: 0x170
function registerpentparams( script_noteworthy, type, icon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov )
{
    struct = spawnstruct();
    struct.type = type;
    struct.icon = icon;
    struct.hintstring = hintstring;
    struct.priority = priority;
    struct.duration = duration;
    struct.onobstruction = onobstruction;
    struct.hintdist = hintdist;
    struct.hintfov = hintfov;
    struct.usedist = usedist;
    struct.usefov = usefov;
    struct.hint_func = level.interactions[ script_noteworthy ].hint_func;
    struct.activation_func = level.interactions[ script_noteworthy ].activation_func;
    level.pentparams[ script_noteworthy ] = struct;
    level.interactions[ script_noteworthy ].hint_func = undefined;
    level.interactions[ script_noteworthy ].activation_func = undefined;
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 1
// Checksum 0x0, Offset: 0x74e
// Size: 0x17, Type: bool
function pentparamsdefined( script_noteworthy )
{
    return isdefined( level.pentparams[ script_noteworthy ] );
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 1
// Checksum 0x0, Offset: 0x76e
// Size: 0x16
function getpentparams( script_noteworthy )
{
    return level.pentparams[ script_noteworthy ];
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 3
// Checksum 0x0, Offset: 0x78d
// Size: 0xa6
function createpenthintobj( param_array, struct, useent )
{
    ent = createhintobject( struct.origin, param_array.type, param_array.icon, param_array.hintstring, param_array.priority, param_array.duration, param_array.onobstruction, param_array.hintdist, param_array.hintfov, param_array.usedist, param_array.usefov );
    return ent;
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 1
// Checksum 0x0, Offset: 0x83c
// Size: 0x154
function addtopersonalinteractionlist( interaction_struct )
{
    interaction_struct notify( "addToPersonalInteractionList" );
    
    if ( !array_contains( level.current_personal_interaction_structs, interaction_struct ) )
    {
        level.current_personal_interaction_structs = array_add( level.current_personal_interaction_structs, interaction_struct );
        
        if ( flag_exist( "personal_ent_zones_initialized" ) && flag( "personal_ent_zones_initialized" ) )
        {
            if ( isdefined( level.personal_ent_zones ) && level.personal_ent_zones.size > 0 )
            {
                foreach ( zone in level.personal_ent_zones )
                {
                    if ( !isdefined( zone.attached_pents ) )
                    {
                        continue;
                    }
                    
                    if ( !isdefined( interaction_struct.p_ent_zones ) )
                    {
                        continue;
                    }
                    
                    if ( ispointinvolume( interaction_struct.origin, zone ) )
                    {
                        zone.attached_pents[ zone.attached_pents.size ] = interaction_struct;
                        interaction_struct.p_ent_zones[ interaction_struct.p_ent_zones.size ] = zone;
                        zone.attached_pents = array_remove_duplicates( zone.attached_pents );
                    }
                }
            }
        }
    }
    
    update_special_mode_for_all_players( 1 );
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 1
// Checksum 0x0, Offset: 0x998
// Size: 0xfa
function removefrompersonalinteractionlist( interaction_struct )
{
    interaction_struct notify( "removeFromPersonalInteractionList" );
    
    if ( array_contains( level.current_personal_interaction_structs, interaction_struct ) )
    {
        level.current_personal_interaction_structs = array_remove( level.current_personal_interaction_structs, interaction_struct );
        
        if ( flag_exist( "personal_ent_zones_initialized" ) && flag( "personal_ent_zones_initialized" ) )
        {
            if ( isdefined( interaction_struct.p_ent_zones ) )
            {
                foreach ( zone in interaction_struct.p_ent_zones )
                {
                    zone.attached_pents = array_remove( zone.attached_pents, interaction_struct );
                    zone.attached_pents = array_remove_duplicates( zone.attached_pents );
                }
            }
        }
    }
    
    update_special_mode_for_all_players( 1 );
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 1
// Checksum 0x0, Offset: 0xa9a
// Size: 0x21
function delayed_remove_peent_interaction( interaction_struct )
{
    wait 0.25;
    scripts\cp\coop_personal_ents::removefrompersonalinteractionlist( interaction_struct );
    scripts\cp\interaction::remove_from_current_interaction_list( interaction_struct );
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 1
// Checksum 0x0, Offset: 0xac3
// Size: 0x5d5
function movepentstostructs( player )
{
    player endon( "disconnect" );
    player notify( "movePEntsToStructs" );
    player endon( "movePEntsToStructs" );
    
    if ( !flag( "init_interaction_done" ) )
    {
        flag_wait( "init_interaction_done" );
    }
    
    /#
        playernum = undefined;
        
        foreach ( guy in level.players )
        {
            if ( guy == player )
            {
                playernum = int( index );
                break;
            }
        }
        
        setdvarifuninitialized( @"hash_684a47815a15ca0f", 0 );
        setdvarifuninitialized( @"hash_a551e4711f41a202", 0 );
        cmd = "<dev string:x1c>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x6a>";
        addentrytodevgui( cmd );
        
        if ( isdefined( playernum ) )
        {
            cmd = "<dev string:xc1>" + playernum + "<dev string:x111>";
            addentrytodevgui( cmd );
        }
    #/
    
    while ( true )
    {
        if ( player ent_flag_exist( "personal_ents_updating" ) )
        {
            player ent_flag_set( "personal_ents_updating" );
        }
        
        showlines = 0;
        
        /#
            if ( getdvarint( @"hash_684a47815a15ca0f", 0 ) != 0 )
            {
                showlines = 1;
            }
        #/
        
        statechanged = 0;
        
        if ( isdefined( player.all_available_pents ) )
        {
            structs = player.all_available_pents;
        }
        else
        {
            structs = get_array_of_closest( player.origin, level.current_personal_interaction_structs, undefined, 100 );
        }
        
        /#
            if ( showlines )
            {
                print( "<dev string:x122>" + structs.size + "<dev string:x135>" );
            }
        #/
        
        if ( structs.size > 0 )
        {
            /#
                if ( getdvarint( @"hash_a551e4711f41a202", 0 ) != 0 )
                {
                    wait 0.25;
                    
                    if ( player ent_flag_exist( "<dev string:x153>" ) )
                    {
                        player ent_flag_clear( "<dev string:x153>" );
                    }
                    
                    player notify( "<dev string:x16a>" );
                    player waittill_any_in_array_return_no_endon_death( [ "<dev string:x177>", "<dev string:x183>" ] );
                    continue;
                }
            #/
            
            structs = removeinvalidstructs( structs, player );
            player resetents( player, structs );
            
            foreach ( struct in structs )
            {
                targetstruct = undefined;
                
                if ( isdefined( struct.target ) )
                {
                    targetstruct = getstruct( struct.target, "targetname" );
                }
                
                if ( struct hasplayerentattached( player, struct ) )
                {
                    ent = getattachedpersonalent( player, struct );
                    
                    if ( isdefined( ent ) )
                    {
                        if ( isdefined( struct.pentmodel ) && struct.pentmodel != ent.model )
                        {
                            ent setmodel( struct.pentmodel );
                        }
                        
                        /#
                            if ( showlines )
                            {
                                print3d( ent.origin + ( 0, 0, 32 ), ent getentitynumber() + "<dev string:x18f>" + ent.model, ( 1, 0, 0 ), 1, 1, 100 );
                                ent thread draw_line_for_time( ent.origin, ent.origin + ( 0, 0, 128 ), 1, 1, 0, 5 );
                            }
                        #/
                        
                        if ( istrue( player.force_p_ent_reset ) )
                        {
                            if ( struct_has_advanced_settings( struct ) )
                            {
                                ent thread pentadvancedoptions( 0, struct, ent, player, targetstruct );
                            }
                        }
                    }
                    
                    continue;
                }
                
                ent = getunclaimedpersonalent( player, structs );
                
                if ( isdefined( ent ) )
                {
                    if ( player_can_see_p_ent( struct, player ) )
                    {
                        continue;
                    }
                    
                    struct.awaitingpent = 1;
                    ent dontinterpolate();
                    
                    if ( isdefined( targetstruct ) )
                    {
                        ent.origin = targetstruct.origin;
                        
                        if ( isdefined( targetstruct.angles ) )
                        {
                            ent.angles = targetstruct.angles;
                        }
                        else
                        {
                            ent.angles = ( 0, 0, 0 );
                        }
                    }
                    else
                    {
                        ent.origin = struct.origin;
                        
                        if ( isdefined( struct.angles ) )
                        {
                            ent.angles = struct.angles;
                        }
                        else
                        {
                            ent.angles = ( 0, 0, 0 );
                        }
                    }
                    
                    if ( isdefined( struct.pentmodel ) )
                    {
                        thread pentdelaysetmodel( player, ent, struct );
                    }
                    else
                    {
                        /#
                            if ( showlines )
                            {
                                print3d( ent.origin + ( 0, 0, 32 ), ent getentitynumber() + "<dev string:x18f>" + ent.model, ( 1, 0, 0 ), 1, 1, 100 );
                                ent thread draw_line_for_time( ent.origin, ent.origin + ( 0, 0, 128 ), 1, 1, 0, 5 );
                            }
                        #/
                    }
                    
                    if ( struct_has_advanced_settings( struct ) )
                    {
                        ent thread pentadvancedoptions( 0, struct, ent, player, targetstruct );
                    }
                }
            }
        }
        
        player.force_p_ent_reset = undefined;
        wait 0.25;
        
        if ( player ent_flag_exist( "personal_ents_updating" ) )
        {
            player ent_flag_clear( "personal_ents_updating" );
        }
        
        player notify( "pEntsUpdated" );
        player waittill_any_in_array_return_no_endon_death( [ "zone_change", "updatePEnts" ] );
    }
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 2
// Checksum 0x0, Offset: 0x10a0
// Size: 0xd3
function player_can_see_p_ent( struct, player )
{
    if ( istrue( struct.p_ent_skip_fov ) )
    {
        return 0;
    }
    
    if ( isdefined( level.pentskipfov ) && istrue( level.pentskipfov[ struct.script_noteworthy ] ) )
    {
        return 0;
    }
    
    var_865048328835e385 = within_fov( player geteye(), player getplayerangles(), struct.origin, cos( 65 ) );
    
    if ( var_865048328835e385 )
    {
        var_d1f3388db95fab09 = scripts\engine\trace::ray_trace_passed( player geteye(), struct.origin, array_combine( level.players, player.personalents ) );
        
        if ( var_d1f3388db95fab09 )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    return 0;
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 1
// Checksum 0x0, Offset: 0x117b
// Size: 0x90
function struct_has_advanced_settings( struct )
{
    if ( isdefined( struct.script_noteworthy ) )
    {
        key = struct.script_noteworthy;
    }
    else
    {
        return 0;
    }
    
    if ( istrue( struct.pentadvanced ) )
    {
        return 1;
    }
    
    if ( isdefined( level.normal_mode_activation_funcs[ key ] ) )
    {
        return 1;
    }
    
    if ( isdefined( level.special_mode_activation_funcs[ key ] ) )
    {
        return 1;
    }
    
    if ( pentparamsdefined( struct.script_noteworthy ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 3
// Checksum 0x0, Offset: 0x1213
// Size: 0x190
function pentdelaysetmodel( player, ent, struct )
{
    level endon( "game_ended" );
    player endon( "disconnect" );
    ent endon( "p_ent_reset" );
    ent.claimed = 1;
    ent.parentstruct = struct;
    
    if ( !isdefined( struct.linkedpents ) )
    {
        struct.linkedpents = [];
    }
    
    struct.linkedpents[ struct.linkedpents.size ] = ent;
    ent.used = 1;
    
    if ( player_can_see_p_ent( struct, player ) )
    {
        ent resetpersonalent( ent, player );
        return;
    }
    
    wait 0.1;
    ent setmodel( struct.pentmodel );
    
    if ( isdefined( struct.expectedstate ) )
    {
        ent setscriptablepartstate( struct.expectedstate[ 0 ], struct.expectedstate[ 1 ], 1 );
    }
    
    struct.awaitingpent = undefined;
    
    /#
        if ( getdvarint( @"hash_684a47815a15ca0f", 0 ) != 0 )
        {
            print3d( ent.origin + ( 0, 0, 32 ), ent getentitynumber() + "<dev string:x18f>" + ent.model, ( 1, 0, 0 ), 1, 1, 100 );
            ent thread draw_line_for_time( ent.origin, ent.origin + ( 0, 0, 128 ), 1, 1, 0, 5 );
        }
    #/
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 2
// Checksum 0x0, Offset: 0x13ab
// Size: 0x69
function update_special_mode_for_player( player, force_reset )
{
    level endon( "game_ended" );
    player endon( "disconnect" );
    player notify( "update_special_mode_for_player" );
    player endon( "update_special_mode_for_player" );
    
    if ( istrue( force_reset ) )
    {
    }
    
    if ( player ent_flag_exist( "personal_ents_updating" ) && player ent_flag( "personal_ents_updating" ) )
    {
        player ent_flag_waitopen( "personal_ents_updating" );
    }
    
    player notify( "updatePEnts" );
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 1
// Checksum 0x0, Offset: 0x141c
// Size: 0x65
function update_special_mode_for_all_players( force_reset )
{
    level endon( "game_ended" );
    
    foreach ( player in level.players )
    {
        thread update_special_mode_for_player( player, force_reset );
    }
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 2
// Checksum 0x0, Offset: 0x1489
// Size: 0x22d
function resetents( player, structs )
{
    temparray = [];
    noteworthy = undefined;
    struct = undefined;
    
    foreach ( ent in player.personalents )
    {
        if ( !isent( ent ) )
        {
            continue;
        }
        
        var_b076f2949cb48f5b = 0;
        
        foreach ( struct in structs )
        {
            if ( isdefined( struct.playeroffset ) && isdefined( struct.playeroffset[ player.name ] ) )
            {
                if ( ent.origin == struct.playeroffset[ player.name ] )
                {
                    noteworthy = struct.script_noteworthy;
                    var_b076f2949cb48f5b = 1;
                    break;
                }
            }
            
            if ( isdefined( struct.target ) )
            {
                targetstruct = getstruct( struct.target, "targetname" );
                
                if ( isdefined( targetstruct ) && ent.origin == targetstruct.origin )
                {
                    noteworthy = struct.script_noteworthy;
                    var_b076f2949cb48f5b = 1;
                    break;
                }
                else if ( ent.origin == struct.origin )
                {
                    noteworthy = struct.script_noteworthy;
                    var_b076f2949cb48f5b = 1;
                    break;
                }
                
                continue;
            }
            
            if ( ent.origin == struct.origin )
            {
                noteworthy = struct.script_noteworthy;
                var_b076f2949cb48f5b = 1;
                break;
            }
        }
        
        if ( !var_b076f2949cb48f5b )
        {
            if ( isdefined( struct ) && player_can_see_p_ent( struct, player ) )
            {
                continue;
            }
            
            ent resetpersonalent( ent, player );
        }
    }
    
    wait 0.1;
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 2
// Checksum 0x0, Offset: 0x16be
// Size: 0x1ba
function removeinvalidstructs( structs, player )
{
    temparray = [];
    structs = sortbydistance( structs, player.origin );
    
    foreach ( struct in structs )
    {
        if ( isdefined( player.disabled_interactions ) && array_contains( player.disabled_interactions, struct ) )
        {
            continue;
        }
        
        if ( isdefined( struct.in_array ) )
        {
            if ( !istrue( struct.in_array ) )
            {
                continue;
            }
        }
        else if ( isdefined( level.current_interaction_structs ) && !array_contains( level.current_interaction_structs, struct ) )
        {
            continue;
        }
        
        if ( isdefined( struct.target ) )
        {
            var_81cd6d6462bb16b5 = getstructarray( struct.targetname, "targetname" );
            
            foreach ( newstruct in var_81cd6d6462bb16b5 )
            {
                if ( isdefined( newstruct.target ) && newstruct.target == struct.target )
                {
                    structs = array_remove( structs, newstruct );
                }
            }
            
            temparray[ temparray.size ] = struct;
            
            if ( temparray.size >= 35 )
            {
                break;
            }
            
            continue;
        }
        
        temparray[ temparray.size ] = struct;
        
        if ( temparray.size >= 35 )
        {
            break;
        }
    }
    
    return temparray;
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 2
// Checksum 0x0, Offset: 0x1881
// Size: 0x14d, Type: bool
function hasplayerentattached( player, struct )
{
    foreach ( ent in player.personalents )
    {
        if ( isdefined( struct.playeroffset ) && isdefined( struct.playeroffset[ player.name ] ) )
        {
            if ( ent.origin == struct.playeroffset[ player.name ] )
            {
                ent.used = 1;
                return true;
            }
        }
        
        if ( isdefined( struct.target ) )
        {
            targetstruct = getstruct( struct.target, "targetname" );
            
            if ( isdefined( targetstruct ) && ent.origin == targetstruct.origin )
            {
                ent.used = 1;
                return true;
            }
        }
        
        if ( ent.origin == struct.origin )
        {
            ent.used = 1;
            return true;
        }
    }
    
    return false;
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 2
// Checksum 0x0, Offset: 0x19d7
// Size: 0x75
function adjustmodelvis( player, ent )
{
    foreach ( guy in level.players )
    {
        if ( guy == player )
        {
            ent showtoplayer( guy );
            continue;
        }
        
        ent hidefromplayer( guy );
    }
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 2
// Checksum 0x0, Offset: 0x1a54
// Size: 0xf5
function resetpersonalent( ent, player )
{
    ent setmodel( "tag_origin" );
    ent.claimed = 0;
    ent.used = 0;
    ent dontinterpolate();
    ent.origin = ent.ogorigin;
    
    if ( isdefined( ent.parentstruct ) )
    {
        if ( isdefined( ent.parentstruct.linkedpents ) )
        {
            if ( array_contains( ent.parentstruct.linkedpents, ent ) )
            {
                ent.parentstruct.linkedpents = array_remove( ent.parentstruct.linkedpents, ent );
            }
        }
        
        ent.parentstruct notify( "p_ents_updated" );
        ent.parentstruct = undefined;
    }
    
    ent notify( "p_ent_reset" );
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 2
// Checksum 0x0, Offset: 0x1b51
// Size: 0x12c
function getattachedpersonalent( player, struct )
{
    temparray = [];
    
    foreach ( ent in player.personalents )
    {
        if ( isdefined( struct.playeroffset ) && isdefined( struct.playeroffset[ player.name ] ) )
        {
            if ( ent.origin == struct.playeroffset[ player.name ] )
            {
                return ent;
            }
        }
        
        if ( isdefined( struct.target ) )
        {
            targetstruct = getstruct( struct.target, "targetname" );
            
            if ( isdefined( targetstruct ) && ent.origin == targetstruct.origin )
            {
                return ent;
            }
        }
        
        if ( ent.origin == struct.origin )
        {
            return ent;
        }
    }
    
    return undefined;
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 2
// Checksum 0x0, Offset: 0x1c86
// Size: 0x190
function getunclaimedpersonalent( player, structs )
{
    temparray = [];
    
    foreach ( ent in player.personalents )
    {
        var_b076f2949cb48f5b = 0;
        
        foreach ( struct in structs )
        {
            if ( isdefined( struct.playeroffset ) && isdefined( struct.playeroffset[ player.name ] ) )
            {
                if ( ent.origin == struct.playeroffset[ player.name ] )
                {
                    var_b076f2949cb48f5b = 1;
                    break;
                }
            }
            
            if ( isdefined( struct.target ) )
            {
                targetstruct = getstruct( struct.target, "targetname" );
                
                if ( isdefined( targetstruct ) && ent.origin == targetstruct.origin )
                {
                    var_b076f2949cb48f5b = 1;
                    break;
                }
            }
            
            if ( ent.origin == struct.origin )
            {
                var_b076f2949cb48f5b = 1;
                break;
            }
        }
        
        if ( !var_b076f2949cb48f5b )
        {
            return ent;
        }
    }
    
    return undefined;
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 1
// Checksum 0x0, Offset: 0x1e1f
// Size: 0x94
function watchforplayerzonechange( player )
{
    level endon( "game_ended" );
    player endon( "disconnect" );
    flag_wait( "init_interaction_done" );
    trigger = getent( "zone_change", "targetname" );
    
    if ( isdefined( trigger ) )
    {
        while ( true )
        {
            if ( player istouching( trigger ) )
            {
                player notify( "rave_status_changed" );
                
                /#
                    player iprintlnbold( "<dev string:x192>" + player.name + "<dev string:x196>" + "<dev string:x1bc>" );
                #/
                
                wait 1;
                continue;
            }
            
            wait 0.1;
        }
    }
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 5
// Checksum 0x0, Offset: 0x1ebb
// Size: 0x17a
function pentadvancedoptions( var_c00517b36ef68852, struct, ent, player, targetstruct )
{
    key = ter_op( isdefined( struct.name ), struct.name, struct.script_noteworthy );
    
    if ( isdefined( level.normal_mode_activation_funcs[ key ] ) )
    {
        if ( isdefined( targetstruct ) )
        {
            ent [[ level.normal_mode_activation_funcs[ key ] ]]( ent, targetstruct, 0, player );
        }
        else
        {
            ent thread [[ level.normal_mode_activation_funcs[ key ] ]]( ent, struct, 0, player );
        }
    }
    
    if ( pentparamsdefined( struct.script_noteworthy ) )
    {
        hintobj = createpenthintobj( getpentparams( struct.script_noteworthy ), struct, undefined );
        ent.hintobj = hintobj;
        
        foreach ( guy in level.players )
        {
            if ( guy == player )
            {
                hintobj enableplayeruse( player );
                continue;
            }
            
            hintobj disableplayeruse( guy );
        }
        
        thread watch_for_player_trigger( ent, struct, player, hintobj );
        thread reset_struct_when_pent_moves( ent, struct, player, hintobj );
        thread watch_for_hintstring_updates( ent, struct, player, hintobj );
    }
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 4
// Checksum 0x0, Offset: 0x203d
// Size: 0x115
function reset_struct_when_pent_moves( ent, struct, player, hintobj )
{
    ent notify( "reset_struct_when_pent_moves" );
    ent endon( "reset_struct_when_pent_moves" );
    struct notify( "reset_struct_when_pent_moves_" + player.name );
    struct endon( "reset_struct_when_pent_moves_" + player.name );
    level endon( "game_ended" );
    waittill_any_ents( ent, "p_ent_reset", struct, "remove_from_current_interaction_list", player, "remove_from_current_interaction_list_for_player_" + player.name );
    
    if ( isdefined( hintobj ) && hintobj != ent )
    {
        hintobj delete();
    }
    else if ( isdefined( hintobj ) )
    {
        hintobj clearhintobject( hintobj );
    }
    
    if ( isdefined( ent.hintobj ) )
    {
        ent.hintobj = undefined;
    }
    
    if ( isdefined( ent.collision ) )
    {
        ent.collision delete();
    }
    
    if ( isdefined( struct.collision ) )
    {
        struct.collision delete();
    }
    
    scripts\cp\interaction::add_to_current_interaction_list_for_player( struct, player );
    update_special_mode_for_all_players( 1 );
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 1
// Checksum 0x0, Offset: 0x215a
// Size: 0xed
function disableuseotherplayerspents( player )
{
    foreach ( guy in level.players )
    {
        if ( guy == player )
        {
            continue;
        }
        
        if ( isdefined( guy.personalents ) )
        {
            for ( i = 0; i < guy.personalents.size ; i++ )
            {
                if ( isdefined( guy.personalents[ i ] ) )
                {
                    guy.personalents[ i ] disableplayeruse( player );
                    
                    if ( isdefined( guy.personalents[ i ].hintobj ) )
                    {
                        guy.personalents[ i ].hintobj disableplayeruse( player );
                    }
                }
            }
        }
    }
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 4
// Checksum 0x0, Offset: 0x224f
// Size: 0x123
function watch_for_player_trigger( ent, struct, player, hintobj )
{
    struct notify( "watch_for_player_trigger_" + player.name );
    struct endon( "watch_for_player_trigger_" + player.name );
    ent notify( "watch_for_player_trigger" );
    ent endon( "watch_for_player_trigger" );
    ent endon( "p_ent_reset" );
    use_func = getpentinteractionusefunc( struct );
    ent.hintobj = hintobj;
    
    if ( isdefined( use_func ) )
    {
        while ( true )
        {
            hintobj makeusable();
            
            foreach ( guy in level.players )
            {
                if ( guy == player )
                {
                    hintobj enableplayeruse( player );
                    continue;
                }
                
                hintobj disableplayeruse( guy );
            }
            
            hintobj waittill( "trigger", var_484ce98a6b8c62f3 );
            
            if ( isplayer( var_484ce98a6b8c62f3 ) )
            {
                level thread [[ use_func ]]( struct, player );
            }
        }
    }
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 1
// Checksum 0x0, Offset: 0x237a
// Size: 0x99
function getpentinteractionusefunc( interaction_struct )
{
    if ( isdefined( level.pentparams[ interaction_struct.script_noteworthy ].activation_func ) )
    {
        return level.pentparams[ interaction_struct.script_noteworthy ].activation_func;
    }
    
    if ( isdefined( level.interactions[ interaction_struct.script_noteworthy ].activation_func ) )
    {
        return level.interactions[ interaction_struct.script_noteworthy ].activation_func;
    }
    
    return undefined;
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 2
// Checksum 0x0, Offset: 0x241b
// Size: 0x29
function update_pent_hintstring( interaction_struct, hintstring )
{
    interaction_struct.hintstring = hintstring;
    interaction_struct notify( "pent_update_hint", hintstring );
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 4
// Checksum 0x0, Offset: 0x244c
// Size: 0x73
function watch_for_hintstring_updates( ent, struct, player, hintobj )
{
    struct endon( "watch_for_player_trigger_" + player.name );
    ent endon( "watch_for_player_trigger" );
    ent endon( "p_ent_reset" );
    
    while ( true )
    {
        struct waittill( "pent_update_hint", hintstring );
        
        if ( !hasplayerentattached( player, struct ) )
        {
            return;
        }
        
        hintobj sethintstring( hintstring );
    }
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 1
// Checksum 0x0, Offset: 0x24c7
// Size: 0x2d
function player_run_pent_updates( player )
{
    if ( isdefined( level.personal_ent_zones ) )
    {
        thread update_pents_from_volumes( player );
        return;
    }
    
    thread update_pents_global( player );
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 1
// Checksum 0x0, Offset: 0x24fc
// Size: 0xeb
function update_pents_from_volumes( player )
{
    level endon( "game_ended" );
    player notify( "update_pents_from_volumes" );
    player endon( "update_pents_from_volumes" );
    player endon( "disconnect" );
    
    if ( !flag_exist( "personal_ent_zones_initialized" ) )
    {
        return;
    }
    else
    {
        flag_wait( "personal_ent_zones_initialized" );
    }
    
    while ( true )
    {
        player.all_available_pents = [];
        
        foreach ( zone in level.personal_ent_zones )
        {
            if ( ispointinvolume( player.origin, zone ) )
            {
                player.all_available_pents = array_combine( player.all_available_pents, zone.attached_pents );
            }
        }
        
        wait 1;
        update_special_mode_for_player( player );
    }
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 1
// Checksum 0x0, Offset: 0x25ef
// Size: 0x59
function update_pents_global( player )
{
    level endon( "game_ended" );
    player notify( "update_pents_from_volumes" );
    player endon( "update_pents_from_volumes" );
    player endon( "disconnect" );
    
    if ( !flag_exist( "personal_ent_zones_initialized" ) )
    {
        return;
    }
    else
    {
        flag_wait( "personal_ent_zones_initialized" );
    }
    
    while ( true )
    {
        wait 1;
        update_special_mode_for_player( player );
    }
}

// Namespace coop_personal_ents / scripts\cp\coop_personal_ents
// Params 0
// Checksum 0x0, Offset: 0x2650
// Size: 0x144
function init_personal_ent_zones()
{
    var_d7d94e6f18e42b32 = level.current_personal_interaction_structs;
    personal_ent_zones = getentarray( "p_ent_zone", "targetname" );
    
    foreach ( zone in personal_ent_zones )
    {
        zone.attached_pents = [];
        
        foreach ( struct in var_d7d94e6f18e42b32 )
        {
            if ( !isdefined( struct.p_ent_zones ) )
            {
                struct.p_ent_zones = [];
            }
            
            if ( ispointinvolume( struct.origin, zone ) )
            {
                zone.attached_pents[ zone.attached_pents.size ] = struct;
                struct.p_ent_zones[ struct.p_ent_zones.size ] = zone;
            }
        }
    }
    
    if ( personal_ent_zones.size > 0 )
    {
        level.personal_ent_zones = personal_ent_zones;
    }
    
    flag_set( "personal_ent_zones_initialized" );
}

