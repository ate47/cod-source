#using scripts\common\utility;
#using scripts\cp\cp_hud_util;
#using scripts\cp\rank;
#using scripts\cp\utility;
#using scripts\engine\utility;

#namespace cp_hud_message;

// Namespace cp_hud_message / scripts\cp\cp_hud_message
// Params 0
// Checksum 0x0, Offset: 0x314
// Size: 0x23
function init_cp_hud_message()
{
    level.var_4cd98c0c1064cfc0 = [];
    level thread onplayerconnect_cphudmessage();
    level.showerrormessagefunc = &showerrormessage;
}

// Namespace cp_hud_message / scripts\cp\cp_hud_message
// Params 0
// Checksum 0x0, Offset: 0x33f
// Size: 0x33
function onplayerconnect_cphudmessage()
{
    for ( ;; )
    {
        level waittill( "connected", player );
        player thread hintmessagedeaththink();
        player thread lowermessagethink();
        player thread splashshownthink();
    }
}

// Namespace cp_hud_message / scripts\cp\cp_hud_message
// Params 3
// Checksum 0x0, Offset: 0x37a
// Size: 0x4e
function showkillstreaksplash( splashref, streakval, var_38ecfeb60187e7d3 )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    actiondata = spawnstruct();
    
    if ( isdefined( var_38ecfeb60187e7d3 ) )
    {
        splashref += "_" + var_38ecfeb60187e7d3;
    }
    
    showsplash( splashref, streakval );
}

// Namespace cp_hud_message / scripts\cp\cp_hud_message
// Params 2
// Checksum 0x0, Offset: 0x3d0
// Size: 0xa0
function showchallengesplash( challengeref, tieroverride )
{
    challengestate = undefined;
    
    if ( isdefined( tieroverride ) )
    {
        challengestate = tieroverride;
    }
    else
    {
        challengestate = mt_getstate( challengeref ) - 1;
    }
    
    displayparam = level.meritinfo[ challengeref ][ "displayParam" ];
    
    if ( !isdefined( displayparam ) )
    {
        displayparam = mt_gettarget( challengeref, challengestate );
        
        if ( displayparam == 0 )
        {
            displayparam = 1;
        }
        
        paramscale = level.meritinfo[ challengeref ][ "paramScale" ];
        
        if ( isdefined( paramscale ) )
        {
            displayparam = int( displayparam / paramscale );
        }
    }
    
    thread showsplash( challengeref, displayparam );
}

// Namespace cp_hud_message / scripts\cp\cp_hud_message
// Params 6
// Checksum 0x0, Offset: 0x478
// Size: 0x67
function showsplash( ref, optionalnumber, playerforplayercard, altdisplayindex, var_ef4849b4cb3ac7e2, splashlistoverride )
{
    if ( isdefined( self.recentsplashcount ) && self.recentsplashcount >= 6 )
    {
        queuesplash( ref, optionalnumber, playerforplayercard, splashlistoverride );
        return;
    }
    
    showsplashinternal( ref, optionalnumber, playerforplayercard, splashlistoverride );
}

// Namespace cp_hud_message / scripts\cp\cp_hud_message
// Params 4
// Checksum 0x0, Offset: 0x4e7
// Size: 0x1e9
function showsplashinternal( ref, optionalnumber, playerforplayercard, splashlistoverride )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    isscriptbundlesplash = 0;
    splashid = tablelookuprownum( getsplashtablename(), 0, ref );
    
    if ( !isdefined( splashid ) || splashid < 0 )
    {
        splashid = function_73baf095c3b9cce6( ref, splashlistoverride );
        isscriptbundlesplash = 1;
    }
    
    if ( !isdefined( splashid ) || splashid < 0 )
    {
        return;
    }
    
    assertex( splashid < ( 2047 ^ 4095 ), "ui_splash_id_X is too small to store all splashes. Increase the size of the omnvar." );
    
    if ( !isdefined( self.nextsplashlistindex ) )
    {
        self.nextsplashlistindex = 0;
    }
    
    if ( !isdefined( self.splashlisttoggle ) )
    {
        self.splashlisttoggle = 1;
    }
    
    omnvarvalue = splashid;
    
    if ( self.splashlisttoggle )
    {
        omnvarvalue |= 2047 ^ 4095;
    }
    
    if ( isdefined( optionalnumber ) )
    {
        self setclientomnvar( "ui_player_splash_param_" + self.nextsplashlistindex, optionalnumber );
    }
    else
    {
        self setclientomnvar( "ui_player_splash_param_" + self.nextsplashlistindex, -1 );
    }
    
    if ( isdefined( playerforplayercard ) )
    {
        self setclientomnvar( "ui_player_splash_cardClientId_" + self.nextsplashlistindex, playerforplayercard getentitynumber() );
    }
    else
    {
        self setclientomnvar( "ui_player_splash_cardClientId_" + self.nextsplashlistindex, -1 );
    }
    
    self setclientomnvar( "ui_player_splash_scriptBundle_" + self.nextsplashlistindex, isscriptbundlesplash );
    self setclientomnvar( "ui_player_splash_id_" + self.nextsplashlistindex, omnvarvalue );
    
    if ( !isdefined( self.recentsplashcount ) )
    {
        self.recentsplashcount = 1;
    }
    else
    {
        self.recentsplashcount++;
    }
    
    thread cleanuplocalplayersplashlist();
    self.nextsplashlistindex++;
    
    if ( self.nextsplashlistindex >= 6 )
    {
        self.nextsplashlistindex = 0;
        self.splashlisttoggle = !self.splashlisttoggle;
    }
}

// Namespace cp_hud_message / scripts\cp\cp_hud_message
// Params 4
// Checksum 0x0, Offset: 0x6d8
// Size: 0xbe
function queuesplash( ref, optionalnumber, playerforplayercard, splashlistoverride )
{
    struct = spawnstruct();
    struct.ref = ref;
    struct.optionalnumber = optionalnumber;
    struct.playerforplayercard = playerforplayercard;
    struct.splashlistoverride = splashlistoverride;
    
    if ( !isdefined( self.splashqueuehead ) )
    {
        self.splashqueuehead = struct;
        self.splashqueuetail = struct;
        thread handlesplashqueue();
        return;
    }
    
    oldtail = self.splashqueuetail;
    oldtail.nextsplash = struct;
    self.splashqueuetail = struct;
}

// Namespace cp_hud_message / scripts\cp\cp_hud_message
// Params 0
// Checksum 0x0, Offset: 0x79e
// Size: 0xbd
function handlesplashqueue()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    
    while ( isdefined( self.splashqueuehead ) )
    {
        self waittill( "splash_list_cleared" );
        
        for ( queueindex = 0; queueindex < 6 ; queueindex++ )
        {
            struct = self.splashqueuehead;
            showsplashinternal( struct.ref, struct.optionalnumber, struct.playerforplayercard, struct.splashlistoverride );
            self.splashqueuehead = struct.nextsplash;
            
            if ( !isdefined( self.splashqueuehead ) )
            {
                break;
            }
        }
    }
    
    self.splashqueuetail = undefined;
}

// Namespace cp_hud_message / scripts\cp\cp_hud_message
// Params 2
// Checksum 0x0, Offset: 0x863
// Size: 0x19c
function function_73baf095c3b9cce6( splashref, splashlistoverride )
{
    id = level.var_4cd98c0c1064cfc0[ splashref ];
    
    if ( isdefined( id ) )
    {
        return id;
    }
    
    var_c1c3e6a4f162ab45 = undefined;
    
    if ( isdefined( splashlistoverride ) )
    {
        var_c1c3e6a4f162ab45 = splashlistoverride;
    }
    
    if ( !isdefined( var_c1c3e6a4f162ab45 ) && isdefined( level.gametypebundle ) )
    {
        var_c1c3e6a4f162ab45 = level.gametypebundle.splashlist;
    }
    
    if ( !isdefined( var_c1c3e6a4f162ab45 ) )
    {
        var_c1c3e6a4f162ab45 = level.gamemodebundle.splashlist;
    }
    
    if ( !isdefined( var_c1c3e6a4f162ab45 ) )
    {
        return undefined;
    }
    
    if ( isxhashasset( var_c1c3e6a4f162ab45 ) )
    {
        splashlist = getscriptbundle( var_c1c3e6a4f162ab45 );
    }
    else
    {
        splashlist = getscriptbundle( hashcat( %"hash_7ac5a0b15c7d50e5", var_c1c3e6a4f162ab45 ) );
    }
    
    if ( !isdefined( splashlist ) || !isdefined( splashlist.splash_list ) )
    {
        return undefined;
    }
    
    foreach ( var_68cc4b3bf54adcfe in splashlist.splash_list )
    {
        if ( var_68cc4b3bf54adcfe.ref != splashref )
        {
            continue;
        }
        
        id = function_2336488258354fbc( #"scriptbundle_splash", hashcat( %"hash_39857ea6520cf871", var_68cc4b3bf54adcfe.splashbundle ) );
        
        if ( !isdefined( id ) )
        {
            break;
        }
        
        level.var_4cd98c0c1064cfc0[ splashref ] = id;
        return id;
    }
    
    id = scripts\cp\rank::function_1e00d01d19fde519( splashref );
    
    if ( isdefined( id ) )
    {
        level.var_4cd98c0c1064cfc0[ splashref ] = id;
        return id;
    }
    
    return undefined;
}

// Namespace cp_hud_message / scripts\cp\cp_hud_message
// Params 0
// Checksum 0x0, Offset: 0xa08
// Size: 0x1d6
function lowermessagethink()
{
    self endon( "disconnect" );
    self.lowermessages = [];
    lowermessagefont = "default";
    
    if ( isdefined( level.lowermessagefont ) )
    {
        lowermessagefont = level.lowermessagefont;
    }
    
    messagey = level.lowertexty;
    var_4c254f3e1813b5ac = level.lowertextfontsize;
    var_ed9168da0f317746 = 1.25;
    
    if ( level.splitscreen || self issplitscreenplayer() && !isai( self ) )
    {
        messagey -= 40;
        var_4c254f3e1813b5ac = level.lowertextfontsize * 1.3;
        var_ed9168da0f317746 *= 1.5;
    }
    
    self.lowermessage = createfontstring( lowermessagefont, var_4c254f3e1813b5ac );
    self.lowermessage settext( "" );
    self.lowermessage.archived = 0;
    self.lowermessage.sort = 10;
    self.lowermessage.showinkillcam = 0;
    self.lowermessage setpoint( "CENTER", level.lowertextyalign, 0, messagey );
    self.lowertimer = createfontstring( "default", var_ed9168da0f317746 );
    self.lowertimer setparent( self.lowermessage );
    self.lowertimer setpoint( "TOP", "BOTTOM", 0, 0 );
    self.lowertimer settext( "" );
    self.lowertimer.archived = 0;
    self.lowertimer.sort = 10;
    self.lowertimer.showinkillcam = 0;
}

// Namespace cp_hud_message / scripts\cp\cp_hud_message
// Params 0
// Checksum 0x0, Offset: 0xbe6
// Size: 0x3, Type: bool
function isdoingsplash()
{
    return false;
}

// Namespace cp_hud_message / scripts\cp\cp_hud_message
// Params 0
// Checksum 0x0, Offset: 0xbf2
// Size: 0x7
function getsplashtablename()
{
    return "mp/splashtable.csv";
}

// Namespace cp_hud_message / scripts\cp\cp_hud_message
// Params 0
// Checksum 0x0, Offset: 0xc02
// Size: 0x3b
function cleanuplocalplayersplashlist()
{
    self endon( "disconnect" );
    self notify( "cleanupLocalPlayerSplashList()" );
    self endon( "cleanupLocalPlayerSplashList()" );
    waittill_notify_or_timeout( "death", 0.5 );
    self.recentsplashcount = undefined;
    self notify( "splash_list_cleared" );
}

// Namespace cp_hud_message / scripts\cp\cp_hud_message
// Params 0
// Checksum 0x0, Offset: 0xc45
// Size: 0x85
function splashshownthink()
{
    self endon( "disconnect" );
    
    while ( true )
    {
        self waittill( "luinotifyserver", channel, splashindex );
        
        if ( channel != "splash_shown" )
        {
            continue;
        }
        
        splashref = tablelookupbyrow( getsplashtablename(), splashindex, 0 );
        type = tablelookupbyrow( getsplashtablename(), splashindex, 5 );
        
        switch ( type )
        {
            case #"hash_fb8615ef44a4f5d7":
                break;
        }
    }
}

// Namespace cp_hud_message / scripts\cp\cp_hud_message
// Params 1
// Checksum 0x0, Offset: 0xcd2
// Size: 0xb
function onkillstreaksplashshown( splashref )
{
    
}

// Namespace cp_hud_message / scripts\cp\cp_hud_message
// Params 2
// Checksum 0x0, Offset: 0xce5
// Size: 0xc2
function showerrormessage( var_1797174f9e968e96, optionalparam )
{
    rownum = tablelookuprownum( "mp/errorMessages.csv", 0, var_1797174f9e968e96 );
    assertex( isdefined( rownum ) && rownum >= 0, "Unable to find \"" + var_1797174f9e968e96 + "\" in errorMessage.csv" );
    
    if ( isdefined( optionalparam ) )
    {
        self setclientomnvar( "ui_mp_error_message_param", optionalparam );
    }
    else
    {
        self setclientomnvar( "ui_mp_error_message_param", -1 );
    }
    
    self setclientomnvar( "ui_mp_error_message_id", rownum );
    
    if ( !isdefined( self.errormessagebitflipper ) )
    {
        self.errormessagebitflipper = 0;
    }
    
    self.errormessagebitflipper = !self.errormessagebitflipper;
    self setclientomnvar( "ui_mp_error_trigger", ter_op( self.errormessagebitflipper, 2, 1 ) );
}

// Namespace cp_hud_message / scripts\cp\cp_hud_message
// Params 2
// Checksum 0x0, Offset: 0xdaf
// Size: 0x66
function showerrormessagetoallplayers( var_1797174f9e968e96, optionalparam )
{
    foreach ( player in level.players )
    {
        player showerrormessage( var_1797174f9e968e96, optionalparam );
    }
}

// Namespace cp_hud_message / scripts\cp\cp_hud_message
// Params 1
// Checksum 0x0, Offset: 0xe1d
// Size: 0xc6
function showmiscmessage( messageref )
{
    rownum = tablelookuprownum( "mp/miscMessages.csv", 0, messageref );
    assertex( isdefined( rownum ) && rownum >= 0, "Unable to find \"" + messageref + "\" in miscMessages.csv" );
    sound = tablelookupbyrow( "mp/miscMessages.csv", rownum, 3 );
    
    if ( isdefined( sound ) && sound != "" )
    {
        self playlocalsound( sound );
    }
    
    self setclientomnvar( "ui_misc_message_id", rownum );
    
    if ( !isdefined( self.miscmessagebitflipper ) )
    {
        self.miscmessagebitflipper = 0;
    }
    
    self.miscmessagebitflipper = !self.miscmessagebitflipper;
    self setclientomnvar( "ui_misc_message_trigger", ter_op( self.miscmessagebitflipper, 1, 0 ) );
}

// Namespace cp_hud_message / scripts\cp\cp_hud_message
// Params 3
// Checksum 0x0, Offset: 0xeeb
// Size: 0x84
function teamhudtutorialmessage( msg, team, time )
{
    if ( !isdefined( team ) )
    {
        team = "allies";
    }
    
    if ( !isdefined( time ) )
    {
        time = 5;
    }
    
    foreach ( player in level.players )
    {
        player thread tutorialprint( msg, time );
    }
}

// Namespace cp_hud_message / scripts\cp\cp_hud_message
// Params 2
// Checksum 0x0, Offset: 0xf77
// Size: 0x44
function tutorialprint( msg, time )
{
    level endon( "game_ended" );
    self endon( "clear_tutorial_messages" );
    self endon( "disconnect" );
    
    if ( !isdefined( time ) )
    {
        time = 5;
    }
    
    self sethudtutorialmessage( msg, 1 );
    wait time;
    self clearhudtutorialmessage();
}

// Namespace cp_hud_message / scripts\cp\cp_hud_message
// Params 0
// Checksum 0x0, Offset: 0xfc3
// Size: 0x31
function hintmessagedeaththink()
{
    self endon( "disconnect" );
    
    for ( ;; )
    {
        self waittill( "death" );
        
        if ( isdefined( self.hintmessage ) )
        {
            self.hintmessage destroyelem();
        }
    }
}

