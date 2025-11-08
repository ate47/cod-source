#using scripts\common\utility;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;

#namespace entityheadicons;

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 0
// Checksum 0x0, Offset: 0x1ae
// Size: 0xaa
function init()
{
    /#
        issharedfuncdefined( "<dev string:x1c>", "<dev string:x2a>", 1 );
    #/
    
    level.var_32fe21b3c5052471 = getdvarint( @"hash_8ed0da01bb4e0c5f", 1 );
    level.factionfriendlyheadicon = "hud_icon_head_friendly_sm";
    level.factionenemyheadicon = "hud_icon_head_enemy_sm";
    
    if ( function_6ede573723f08c0f() )
    {
        level.factionfriendlyheadicon = "hud_icon_head_equipment_friendly";
        level.factionenemyheadicon = "hud_icon_head_equipment_enemy";
    }
    
    level.activeheadicons = [];
    level.var_b516ed3abe09ea = [ "hud_icon_death_spawn", "hud_icon_head_friendly_sm", "hud_icon_head_enemy_sm", "hud_icon_new_marked" ];
}

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 12
// Checksum 0x0, Offset: 0x260
// Size: 0x218
function setheadicon_singleimage( showto, image, offset, drawthroughgeo, maxdrawdist, naturaldist, delaytime, var_fa4cf28a58192889, var_b3ea37733a1577e5, overrideorigin, showonminimap, iconsize )
{
    level endon( "game_ended" );
    
    if ( isdefined( delaytime ) )
    {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( delaytime );
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    icon = setheadicon_createnewicon( undefined, overrideorigin );
    setheadiconimage( icon, image );
    
    if ( !isdefined( offset ) )
    {
        offset = 30;
    }
    
    setheadiconzoffset( icon, offset );
    
    if ( !isdefined( drawthroughgeo ) )
    {
        drawthroughgeo = 0;
    }
    
    setheadicondrawthroughgeo( icon, drawthroughgeo );
    
    if ( !isdefined( maxdrawdist ) )
    {
        maxdrawdist = 0;
    }
    
    setheadiconmaxdistance( icon, maxdrawdist );
    
    if ( !isdefined( naturaldist ) )
    {
        naturaldist = 0;
    }
    
    setheadiconnaturaldistance( icon, naturaldist );
    
    if ( isarray( showto ) )
    {
        foreach ( showtoent in showto )
        {
            if ( isplayer( showtoent ) )
            {
                addclienttoheadiconmask( icon, showtoent );
                continue;
            }
            
            if ( isdefined( showtoent ) && isteam( showtoent ) )
            {
                addteamtoheadiconmask( icon, showtoent );
            }
        }
    }
    else if ( isplayer( showto ) )
    {
        addclienttoheadiconmask( icon, showto );
    }
    else if ( isdefined( showto ) && isteam( showto ) )
    {
        addteamtoheadiconmask( icon, showto );
    }
    
    if ( !istrue( var_fa4cf28a58192889 ) )
    {
        thread setheadicon_watchdeath( icon );
    }
    
    if ( istrue( var_b3ea37733a1577e5 ) )
    {
        setheadiconsnaptoedges( icon, 1 );
    }
    
    if ( istrue( showonminimap ) )
    {
        setheadicondrawinmap( icon, 1 );
    }
    
    if ( istrue( level.var_32fe21b3c5052471 ) && level.teambased && isdefined( self.team ) && function_670bc5c30525bf6( image ) )
    {
        setheadiconteam( icon, self.team );
        setheadiconusecustomcolors( icon, 1 );
    }
    
    if ( isdefined( iconsize ) )
    {
        setheadiconsize( icon, iconsize );
    }
    
    return icon;
}

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 13
// Checksum 0x0, Offset: 0x481
// Size: 0x26f
function setheadicon_multiimage( showto, friendlyimage, neutralimage, enemyimage, offset, drawthroughgeo, maxdrawdist, naturaldist, delaytime, var_fa4cf28a58192889, var_b3ea37733a1577e5, overrideorigin, showonminimap )
{
    level endon( "game_ended" );
    
    if ( isdefined( delaytime ) )
    {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( delaytime );
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    icon = setheadicon_createnewicon( undefined, overrideorigin );
    
    if ( isdefined( friendlyimage ) )
    {
        setheadiconfriendlyimage( icon, friendlyimage );
    }
    
    if ( isdefined( neutralimage ) )
    {
        setheadiconneutralimage( icon, neutralimage );
    }
    
    if ( isdefined( enemyimage ) )
    {
        setheadiconenemyimage( icon, enemyimage );
    }
    
    if ( !isplayer( self ) )
    {
        if ( !isdefined( self.owner ) && !isdefined( self.team ) )
        {
            assertmsg( "<dev string:x44>" );
            setheadicon_deleteicon( icon );
            return;
        }
        
        if ( isdefined( self.owner ) )
        {
            setheadiconowner( icon, self.owner );
        }
        
        if ( level.teambased && isdefined( self.team ) )
        {
            setheadiconteam( icon, self.team );
        }
    }
    
    if ( !isdefined( offset ) )
    {
        offset = 30;
    }
    
    setheadiconzoffset( icon, offset );
    
    if ( !isdefined( drawthroughgeo ) )
    {
        drawthroughgeo = 0;
    }
    
    setheadicondrawthroughgeo( icon, drawthroughgeo );
    
    if ( !isdefined( maxdrawdist ) )
    {
        maxdrawdist = 0;
    }
    
    setheadiconmaxdistance( icon, maxdrawdist );
    
    if ( !isdefined( naturaldist ) )
    {
        naturaldist = 0;
    }
    
    setheadiconnaturaldistance( icon, naturaldist );
    
    if ( isarray( showto ) )
    {
        foreach ( showtoent in showto )
        {
            if ( isplayer( showtoent ) )
            {
                addclienttoheadiconmask( icon, showtoent );
                continue;
            }
            
            if ( isdefined( showtoent ) && isteam( showtoent ) )
            {
                addteamtoheadiconmask( icon, showtoent );
            }
        }
    }
    else if ( isplayer( showto ) )
    {
        addclienttoheadiconmask( icon, showto );
    }
    else if ( isdefined( showto ) && isteam( showto ) )
    {
        addteamtoheadiconmask( icon, showto );
    }
    
    if ( !istrue( var_fa4cf28a58192889 ) )
    {
        thread setheadicon_watchdeath( icon );
    }
    
    if ( istrue( var_b3ea37733a1577e5 ) )
    {
        setheadiconsnaptoedges( icon, 1 );
    }
    
    if ( istrue( showonminimap ) )
    {
        setheadicondrawinmap( icon, 1 );
    }
    
    return icon;
}

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 10
// Checksum 0x0, Offset: 0x6f9
// Size: 0x1b7
function setheadicon_factionimage( showtoallfactions, offset, drawthroughgeo, maxdrawdist, naturaldist, delaytime, var_fa4cf28a58192889, ownerinvisible, overrideorigin, showonminimap )
{
    if ( scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924() )
    {
        return;
    }
    
    level endon( "game_ended" );
    
    if ( isdefined( delaytime ) )
    {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( delaytime );
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    icon = setheadicon_createnewicon( undefined, overrideorigin );
    icondata = spawnstruct();
    icondata.icon = icon;
    icondata.entowner = self.owner;
    icondata.showtoallfactions = showtoallfactions;
    icondata.ownerinvisible = ownerinvisible;
    
    if ( !isdefined( offset ) )
    {
        offset = 30;
    }
    
    setheadiconzoffset( icondata.icon, offset );
    
    if ( !isdefined( drawthroughgeo ) )
    {
        drawthroughgeo = 0;
    }
    
    setheadicondrawthroughgeo( icondata.icon, drawthroughgeo );
    
    if ( !isdefined( maxdrawdist ) )
    {
        maxdrawdist = 768;
    }
    
    setheadiconmaxdistance( icondata.icon, maxdrawdist );
    
    if ( !isdefined( naturaldist ) )
    {
        naturaldist = 0;
    }
    
    setheadiconnaturaldistance( icondata.icon, naturaldist );
    
    if ( !istrue( var_fa4cf28a58192889 ) )
    {
        thread setheadicon_watchdeath( icondata.icon );
    }
    
    if ( istrue( showonminimap ) )
    {
        setheadicondrawinmap( icon, 1 );
    }
    
    _updateiconowner( icondata );
    thread setheadicon_watchfornewowner( icondata );
    useteamswitch = getdvarint( @"hash_264312901607c2ac", 1 );
    
    if ( useteamswitch )
    {
        thread setheadicon_watchforteamswitch( icondata );
    }
    
    return icondata.icon;
}

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 1
// Checksum 0x0, Offset: 0x8b9
// Size: 0x37d
function _updateiconowner( icondata )
{
    self notify( "_updateIconOwner()" );
    
    if ( istrue( icondata.showtoallfactions ) )
    {
        setheadiconfriendlyimage( icondata.icon, level.factionfriendlyheadicon );
        setheadiconneutralimage( icondata.icon, level.factionenemyheadicon );
        setheadiconenemyimage( icondata.icon, level.factionenemyheadicon );
        
        if ( !isplayer( self ) )
        {
            if ( !isdefined( self.owner ) && !isdefined( self.team ) )
            {
                assertmsg( "<dev string:xa6>" );
                setheadicon_deleteicon( icondata.icon );
                return;
            }
            
            if ( isdefined( self.owner ) )
            {
                setheadiconowner( icondata.icon, self.owner );
            }
            
            if ( level.teambased && isdefined( self.team ) )
            {
                setheadiconteam( icondata.icon, self.team );
            }
        }
    }
    else
    {
        image = level.factionfriendlyheadicon;
        setheadiconimage( icondata.icon, image );
        
        if ( istrue( level.var_32fe21b3c5052471 ) && level.teambased && isdefined( self.team ) && function_670bc5c30525bf6( image ) )
        {
            setheadiconteam( icondata.icon, self.team );
            setheadiconusecustomcolors( icondata.icon, 1 );
        }
    }
    
    foreach ( player in level.players )
    {
        removeclientfromheadiconmask( icondata.icon, player );
    }
    
    if ( istrue( icondata.showtoallfactions ) )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            addclienttoheadiconmask( icondata.icon, player );
        }
        
        thread setheadicon_watchforlateconnect( icondata.icon );
        return;
    }
    
    if ( !isdefined( self.owner ) )
    {
        assertmsg( "<dev string:x11c>" );
        setheadicon_deleteicon( icondata.icon );
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( level.teambased && player.team != self.owner.team )
        {
            continue;
        }
        
        if ( !level.teambased && player != self.owner )
        {
            continue;
        }
        
        if ( istrue( icondata.ownerinvisible ) && player == self.owner )
        {
            continue;
        }
        
        addclienttoheadiconmask( icondata.icon, player );
    }
}

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 1
// Checksum 0x0, Offset: 0xc3e
// Size: 0x55
function setheadicon_watchforlateconnect( icon )
{
    self endon( "death" );
    self endon( "_updateIconOwner()" );
    
    if ( isplayer( self ) )
    {
        self endon( "disconnect" );
    }
    
    level endon( "game_ended" );
    
    while ( true )
    {
        level waittill( "connected", player );
        thread setheadicon_watchforlatespawn( icon, player );
    }
}

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 2
// Checksum 0x0, Offset: 0xc9b
// Size: 0x50
function setheadicon_watchforlatespawn( icon, player )
{
    self endon( "death" );
    self endon( "_updateIconOwner()" );
    
    if ( isplayer( self ) )
    {
        self endon( "disconnect" );
    }
    
    level endon( "game_ended" );
    
    while ( true )
    {
        player waittill( "spawned_player" );
        addclienttoheadiconmask( icon, player );
    }
}

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 1
// Checksum 0x0, Offset: 0xcf3
// Size: 0x6c
function setheadicon_watchfornewowner( icondata )
{
    self endon( "death" );
    
    if ( isplayer( self ) )
    {
        self endon( "disconnect" );
    }
    
    level endon( "game_ended" );
    
    while ( true )
    {
        if ( icondata.entowner != self.owner )
        {
            icondata.entowner = self.owner;
            _updateiconowner( icondata );
        }
        
        wait 0.1;
    }
}

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 1
// Checksum 0x0, Offset: 0xd67
// Size: 0xc8
function setheadicon_watchforteamswitch( icondata )
{
    level endon( "game_ended" );
    self endon( "headicon_deleted" );
    self endon( "death" );
    
    while ( true )
    {
        level waittill( "add_to_team", player );
        removeclientfromheadiconmask( icondata.icon, player );
        
        if ( istrue( icondata.showtoallfactions ) )
        {
            addclienttoheadiconmask( icondata.icon, player );
            continue;
        }
        
        if ( !isdefined( self.owner ) )
        {
            setheadicon_deleteicon( icondata.icon );
            return;
        }
        
        if ( player.team != self.owner.team )
        {
            continue;
        }
        
        addclienttoheadiconmask( icondata.icon, player );
    }
}

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 1
// Checksum 0x0, Offset: 0xe37
// Size: 0x47
function setheadicon_watchdeath( icon )
{
    level endon( "game_ended" );
    self endon( "headicon_deleted" );
    
    if ( isplayer( self ) && !isbot( self ) )
    {
        self waittill( "death_or_disconnect" );
    }
    else
    {
        self waittill( "death" );
    }
    
    setheadicon_deleteicon( icon );
}

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 1
// Checksum 0x0, Offset: 0xe86
// Size: 0x76, Type: bool
function isteam( showto )
{
    if ( showto == "spectator" || showto == "codcaster" )
    {
        return true;
    }
    
    foreach ( teamname in level.teamnamelist )
    {
        if ( showto == teamname )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 2
// Checksum 0x0, Offset: 0xf05
// Size: 0xfb
function setheadicon_createnewicon( prioritygroup, overrideorigin )
{
    if ( !isdefined( prioritygroup ) )
    {
        prioritygroup = 0;
    }
    
    if ( !setheadicon_allowiconcreation() )
    {
        setheadicon_removeoldicon( prioritygroup );
    }
    
    newicon = undefined;
    
    if ( isdefined( overrideorigin ) )
    {
        newicon = createheadiconatorigin( overrideorigin );
    }
    else
    {
        newicon = createheadicon( self );
    }
    
    if ( !isdefined( newicon ) || newicon < 0 )
    {
        /#
            var_a41b5f8513836136 = self;
            
            if ( isdefined( self.owner ) )
            {
                var_a41b5f8513836136 = self.owner;
            }
            
            var_a41b5f8513836136 iprintlnbold( "<dev string:x192>" );
        #/
        
        return;
    }
    
    iconinfo = spawnstruct();
    iconinfo.icon = newicon;
    iconinfo.entmarked = self;
    iconinfo.prioritygroup = prioritygroup;
    iconinfo.timecreated = gettime();
    level.activeheadicons[ iconinfo.icon ] = iconinfo;
    return iconinfo.icon;
}

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 1
// Checksum 0x0, Offset: 0x1009
// Size: 0x69
function setheadicon_deleteicon( icon )
{
    iconinfo = setheadicon_getexistingiconinfo( icon );
    
    if ( isdefined( iconinfo ) )
    {
        if ( isdefined( iconinfo.entmarked ) )
        {
            iconinfo.entmarked notify( "headicon_deleted" );
        }
        
        deleteheadicon( iconinfo.icon );
        level.activeheadicons[ iconinfo.icon ] = undefined;
    }
}

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 0
// Checksum 0x0, Offset: 0x107a
// Size: 0x10, Type: bool
function setheadicon_allowiconcreation()
{
    return level.activeheadicons.size < 1023;
}

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 1
// Checksum 0x0, Offset: 0x1093
// Size: 0x2c
function setheadicon_getexistingiconinfo( icon )
{
    if ( !isdefined( icon ) )
    {
        return;
    }
    
    if ( !isdefined( level.activeheadicons[ icon ] ) )
    {
        return;
    }
    
    return level.activeheadicons[ icon ];
}

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 1
// Checksum 0x0, Offset: 0x10c8
// Size: 0x37
function setheadicon_removeoldicon( var_85c943684cfc2305 )
{
    lowestpriority = setheadicon_findlowestprioritygroup( var_85c943684cfc2305 );
    oldestcreatedicon = setheadicon_findoldestcreatedicon( lowestpriority );
    setheadicon_deleteicon( oldestcreatedicon );
}

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 1
// Checksum 0x0, Offset: 0x1107
// Size: 0x7e
function setheadicon_findlowestprioritygroup( var_85c943684cfc2305 )
{
    lowestpriority = var_85c943684cfc2305;
    
    foreach ( iconinfo in level.activeheadicons )
    {
        if ( lowestpriority > iconinfo.prioritygroup )
        {
            lowestpriority = iconinfo.prioritygroup;
        }
    }
    
    return lowestpriority;
}

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 1
// Checksum 0x0, Offset: 0x118e
// Size: 0xa4
function setheadicon_findoldestcreatedicon( var_49d4316fce0b35b7 )
{
    var_4a38995d4f273f6b = undefined;
    oldesticon = undefined;
    
    foreach ( iconinfo in level.activeheadicons )
    {
        if ( !isdefined( var_4a38995d4f273f6b ) && !isdefined( oldesticon ) || var_4a38995d4f273f6b.timecreated > iconinfo.timecreated )
        {
            var_4a38995d4f273f6b = iconinfo;
            oldesticon = iconinfo.icon;
        }
    }
    
    return oldesticon;
}

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 2
// Checksum 0x0, Offset: 0x123b
// Size: 0x32
function setheadicon_addclienttomask( headicon, client )
{
    iconinfo = setheadicon_getexistingiconinfo( headicon );
    
    if ( isdefined( iconinfo ) )
    {
        addclienttoheadiconmask( headicon, client );
    }
}

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 2
// Checksum 0x0, Offset: 0x1275
// Size: 0x32
function setheadicon_removeclientfrommask( headicon, client )
{
    iconinfo = setheadicon_getexistingiconinfo( headicon );
    
    if ( isdefined( iconinfo ) )
    {
        removeclientfromheadiconmask( headicon, client );
    }
}

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 1
// Checksum 0x0, Offset: 0x12af
// Size: 0x5e, Type: bool
function function_670bc5c30525bf6( imagename )
{
    foreach ( name in level.var_b516ed3abe09ea )
    {
        if ( name == imagename )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace entityheadicons / scripts\cp_mp\entityheadicons
// Params 0
// Checksum 0x0, Offset: 0x1316
// Size: 0x11
function function_6ede573723f08c0f()
{
    return getdvarint( @"hash_1d8c3eb547f8c176", 0 );
}

