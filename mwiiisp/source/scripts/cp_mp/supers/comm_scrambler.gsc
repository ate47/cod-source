#using script_608c50392df8c7d1;
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\supers\supers;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace comm_scrambler;

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x558
// Size: 0x2e
function autoexec main()
{
    registersharedfunc( "super_comm_scrambler", "init", &function_902e316237968d37 );
    registersharedfunc( "super_comm_scrambler", "get_and_handle_killstreak_blocking", &function_2ed5e780857f0eaf );
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 0
// Checksum 0x0, Offset: 0x58e
// Size: 0x63
function function_902e316237968d37()
{
    level.var_4e74070c2484e644 = [];
    
    if ( issharedfuncdefined( "team_utility", "joinrTeamAggregator" ) )
    {
        [[ getsharedfunc( "team_utility", "joinTeamAggregator" ) ]]( &function_5bb22bae2eafed7 );
    }
    
    registersharedfunc( "super_comm_scrambler", "commScrambler_used", &commscrambler_used );
    registersharedfunc( "super_comm_scrambler", "commScrambler_onHacked", &commscrambler_onhacked );
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 1
// Checksum 0x0, Offset: 0x5f9
// Size: 0x32b
function commscrambler_used( grenade )
{
    grenade endon( "death" );
    level endon( "game_ended" );
    grenade.owner = self;
    grenade.issuper = 1;
    grenade.superid = level.superglobals.staticsuperdata[ "super_comm_scrambler" ].id;
    grenade.bundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3( "super_comm_scrambler" );
    grenade setscriptablepartstate( "visibility", "show", 0 );
    grenade thread function_cbc5bc96e58659c7();
    grenade thread function_44a7cc547d0a4415();
    grenade thread function_cf6202f14a8176f( self );
    grenade waittill( "missile_stuck", stuckto );
    grenade function_d25ff4a17fd8fb37( stuckto );
    
    if ( issharedfuncdefined( "weapons", "onEquipmentPlanted" ) )
    {
        self [[ getsharedfunc( "weapons", "onEquipmentPlanted" ) ]]( grenade, "equip_comm_scrambler", &function_4ee728f14862d601 );
    }
    
    grenade setscriptablepartstate( "activate", "activate", 0 );
    level.var_4e74070c2484e644[ grenade getentitynumber() ] = grenade;
    
    if ( issharedfuncdefined( "emp", "setEMP_Applied_Callback" ) )
    {
        grenade [[ getsharedfunc( "emp", "setEMP_Applied_Callback" ) ]]( &function_2233a8cd9c48a336 );
    }
    
    if ( issharedfuncdefined( "emp", "setEMP_Cleared_Callback" ) )
    {
        grenade [[ getsharedfunc( "emp", "setEMP_Cleared_Callback" ) ]]( &function_93e55db60b551e17 );
    }
    
    grenade scripts\cp_mp\emp_debuff::set_apply_emp_callback( &function_2233a8cd9c48a336 );
    grenade scripts\cp_mp\emp_debuff::set_clear_emp_callback( &function_93e55db60b551e17 );
    grenade scripts\cp_mp\equipment\haywire::function_172d848d58051fdf( &function_89a8296f4d744235 );
    grenade function_e26cc89366241706();
    grenade.isactive = 1;
    grenade.headiconid = grenade scripts\cp_mp\entityheadicons::setheadicon_factionimage( 0, 20, undefined, undefined, undefined, undefined, 1 );
    
    if ( issharedfuncdefined( "game", "createObjective" ) )
    {
        grenade.minimapid = grenade [[ getsharedfunc( "game", "createObjective" ) ]]( "jup_hud_icon_minimap_fieldupgrade_commscrambler", grenade.team, 0, 1, 1 );
        triggerradius = getdvarfloat( @"hash_304ea9c01d3fa58b", grenade.bundle.var_783b73889965c476 );
        grenade scripts\cp_mp\utility\game_utility::function_6b6b6273f8180522( "TestCircle", grenade.origin, triggerradius );
        grenade scripts\cp_mp\utility\game_utility::function_6988310081de7b45();
    }
    
    grenade function_c3decb14deedd3d2();
    grenade setscriptablepartstate( "enemies_present", "not_present", 0 );
    grenade childthread function_b181719d99fb654e();
    grenade childthread function_a7a8818b75adcad8();
    
    if ( !isai( self ) && istrue( grenade.bundle.var_a6682e1889a48304 ) && issharedfuncdefined( "player", "doScoreEvent" ) )
    {
        grenade childthread function_8a689b49bffeed79();
        grenade.var_2020fa0ae4d1323d = 0;
        grenade.var_4b15951dd656dcc0 = [];
        grenade childthread function_71f37f039649db2c();
        grenade childthread function_50c6e9ffe406b26e();
        grenade childthread function_3aed59109065b38a();
    }
    
    scripts\cp_mp\challenges::function_d997435895422ecc( "super_comm_scrambler", function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"use" ) );
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 1
// Checksum 0x0, Offset: 0x92c
// Size: 0xe2
function function_4ee728f14862d601( wasdestroyed )
{
    deletiondelay = 0.1;
    moving_platform = undefined;
    fxoriginoffset = undefined;
    thread function_1d4ab8d63dbf796e( deletiondelay, wasdestroyed );
    
    if ( isdefined( self ) )
    {
        fxorigin = self.origin;
        fxforward = anglestoforward( self.angles );
        fxup = anglestoup( self.angles );
        var_dfdfaa4e665b31fc = self getlinkedparent();
        
        if ( isdefined( var_dfdfaa4e665b31fc ) )
        {
            moving_platform = var_dfdfaa4e665b31fc;
            fxoriginoffset = moving_platform.origin - fxorigin;
        }
        
        self setscriptablepartstate( "destroy", "active", 0 );
        
        if ( isdefined( moving_platform ) && isent( moving_platform ) )
        {
            fxorigin = moving_platform.origin - fxoriginoffset;
        }
    }
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 2
// Checksum 0x0, Offset: 0xa16
// Size: 0x125
function function_1d4ab8d63dbf796e( deletiondelay, wasdestroyed )
{
    self notify( "death" );
    wait deletiondelay;
    self.isdestroyed = 1;
    self setcandamage( 0 );
    self.exploding = 1;
    
    if ( isdefined( self.owner ) && issharedfuncdefined( "weapons", "removeEquip" ) )
    {
        self.owner [[ getsharedfunc( "weapons", "removeEquip" ) ]]( self );
    }
    
    function_e016066e327d42b6();
    clearminimapid();
    scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();
    
    if ( issharedfuncdefined( "dlog", "fieldUpgradeExpired" ) )
    {
        [[ getsharedfunc( "dlog", "fieldUpgradeExpired" ) ]]( self.owner, self.superid, self.usedcount, istrue( wasdestroyed ) );
    }
    
    function_d82a67223a4e56d9();
    level.var_4e74070c2484e644[ self getentitynumber() ] = undefined;
    self.owner scripts\cp_mp\challenges::function_d997435895422ecc( "super_comm_scrambler", function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"end" ), self.usedcount );
    self delete();
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 0
// Checksum 0x0, Offset: 0xb43
// Size: 0x7c
function function_d82a67223a4e56d9()
{
    if ( !isdefined( self.trigger ) )
    {
        return;
    }
    
    foreach ( player in self.trigger.playersintrigger )
    {
        player function_95b4fc5672916c93( self, id );
    }
    
    self.trigger delete();
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 0
// Checksum 0x0, Offset: 0xbc7
// Size: 0x196
function function_c3decb14deedd3d2()
{
    triggerradius = getdvarint( @"hash_304ea9c01d3fa58b", self.bundle.var_783b73889965c476 );
    triggerheight = getdvarint( @"hash_d9d5ba0482f401a", self.bundle.var_1836009701d3c8b );
    spawnpoint = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] - triggerheight / 2 );
    self.trigger = spawn( "trigger_radius", spawnpoint, 0, triggerradius, triggerheight );
    self.trigger.playersintrigger = [];
    self.trigger.var_854cf4c64f4bdd9f = [];
    self.trigger.var_a81e3fef4236357a = [];
    self.trigger enablelinkto();
    self.trigger linkto( self );
    
    /#
        if ( getdvarint( @"hash_7a6de10a710dbdbe", 0 ) == 1 )
        {
            end = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + triggerheight / 2 );
            lifetime = getdvarint( @"hash_2467b36602d82d7f", self.bundle.maxlifetime );
            cylinder( spawnpoint, end, triggerradius, ( 1, 0, 0 ), 0, 20 * lifetime );
        }
    #/
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 0
// Checksum 0x0, Offset: 0xd65
// Size: 0xe4
function function_b181719d99fb654e()
{
    while ( true )
    {
        self.trigger waittill( "trigger" );
        var_5fd22bb97d499b04 = self.trigger getistouchingentities( level.players );
        
        foreach ( player in var_5fd22bb97d499b04 )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            entitynumber = player getentitynumber();
            
            if ( !array_contains_key( self.trigger.playersintrigger, entitynumber ) )
            {
                self.trigger.playersintrigger[ entitynumber ] = player;
                
                if ( self.isactive )
                {
                    player function_ac6ba9556aa071b2( self, entitynumber );
                }
            }
        }
    }
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 2
// Checksum 0x0, Offset: 0xe51
// Size: 0x123
function function_ac6ba9556aa071b2( grenade, id )
{
    if ( isenemy( grenade.owner ) )
    {
        if ( grenade.trigger.var_a81e3fef4236357a.size == 0 )
        {
            grenade setscriptablepartstate( "enemies_present", "present", 0 );
        }
        
        grenade.trigger.var_a81e3fef4236357a = function_6d6af8144a5131f1( grenade.trigger.var_a81e3fef4236357a, id );
        
        if ( !isdefined( self.var_13c9d77f4a31f4cd ) )
        {
            self.var_13c9d77f4a31f4cd = [];
        }
        
        self.var_13c9d77f4a31f4cd = function_6d6af8144a5131f1( self.var_13c9d77f4a31f4cd, grenade );
        self setclientomnvar( "ui_gameplay_comm_scrambler_active", 1 );
        self playsoundtoplayer( "eqp_comm_scrambler_ui_enemyscrambled_transient", self );
        return;
    }
    
    grenade.trigger.var_854cf4c64f4bdd9f = function_6d6af8144a5131f1( grenade.trigger.var_854cf4c64f4bdd9f, id );
    self setplayerghost( 1 );
    self setplayeradvanceduavdot( 1 );
    self.var_8d9c40fe23269431 = 1;
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 0
// Checksum 0x0, Offset: 0xf7c
// Size: 0x120
function function_a7a8818b75adcad8()
{
    while ( true )
    {
        foreach ( id, player in self.trigger.playersintrigger )
        {
            if ( !isdefined( player ) )
            {
                self.trigger.playersintrigger[ id ] = undefined;
                self.trigger.var_854cf4c64f4bdd9f = array_remove( self.trigger.var_854cf4c64f4bdd9f, id );
                self.trigger.var_a81e3fef4236357a = array_remove( self.trigger.var_a81e3fef4236357a, id );
                continue;
            }
            
            if ( !player istouching( self.trigger ) || !player scripts\cp_mp\utility\player_utility::_isalive() )
            {
                self.trigger.playersintrigger[ id ] = undefined;
                
                if ( self.isactive )
                {
                    player function_95b4fc5672916c93( self, id );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 3
// Checksum 0x0, Offset: 0x10a4
// Size: 0x10b
function function_95b4fc5672916c93( grenade, id, owner )
{
    if ( !isdefined( owner ) )
    {
        owner = grenade.owner;
    }
    
    if ( isenemy( owner ) )
    {
        grenade.trigger.var_a81e3fef4236357a = array_remove( grenade.trigger.var_a81e3fef4236357a, id );
        
        if ( grenade.trigger.var_a81e3fef4236357a.size == 0 )
        {
            grenade setscriptablepartstate( "enemies_present", "not_present", 0 );
        }
        
        self.var_13c9d77f4a31f4cd = array_remove( self.var_13c9d77f4a31f4cd, grenade );
        self setclientomnvar( "ui_gameplay_comm_scrambler_active", 0 );
        return;
    }
    
    grenade.trigger.var_854cf4c64f4bdd9f = array_remove( grenade.trigger.var_854cf4c64f4bdd9f, id );
    self setplayerghost( 0 );
    self setplayeradvanceduavdot( 0 );
    self.var_8d9c40fe23269431 = 0;
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 1
// Checksum 0x0, Offset: 0x11b7
// Size: 0xbb
function function_2ed5e780857f0eaf( streakitem )
{
    if ( isdefined( self.var_13c9d77f4a31f4cd ) && self.var_13c9d77f4a31f4cd.size > 0 )
    {
        if ( issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            self [[ getsharedfunc( "hud", "showErrorMessage" ) ]]( "SUPER_MP/COMM_SCRAMBLER_KILLSTREAK_BLOCKED_MESSAGE" );
        }
        
        self playsoundtoplayer( "eqp_comm_scrambler_ui_killstreak_disabled", self );
        
        foreach ( commscrambler in self.var_13c9d77f4a31f4cd )
        {
            commscrambler notify( "killstreak_blocked", self );
        }
        
        return 1;
    }
    
    return 0;
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 0
// Checksum 0x0, Offset: 0x127a
// Size: 0xc4
function function_8a689b49bffeed79()
{
    self.var_9a1a850927bb996f = [];
    
    while ( true )
    {
        self waittill( "killstreak_blocked", playerblocked );
        playerentitynum = playerblocked getentitynumber();
        currenttime = gettime();
        mintime = self.bundle.var_c5ae6960f76c1782 * 1000;
        
        if ( !array_contains_key( self.var_9a1a850927bb996f, playerentitynum ) || currenttime - self.var_9a1a850927bb996f[ playerentitynum ] > mintime )
        {
            self.var_9a1a850927bb996f[ playerentitynum ] = currenttime;
            self.owner thread [[ getsharedfunc( "player", "doScoreEvent" ) ]]( #"super_comm_scrambler_killstreak_blocked" );
        }
    }
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 0
// Checksum 0x0, Offset: 0x1346
// Size: 0x1a1
function function_71f37f039649db2c()
{
    var_fd999362783c862f = self.bundle.var_c93862714a3e756e * 1000;
    
    while ( true )
    {
        var_294e2c9657f8efff = gettime() - self.var_2020fa0ae4d1323d;
        
        if ( var_294e2c9657f8efff < var_fd999362783c862f )
        {
            wait ( var_fd999362783c862f - var_294e2c9657f8efff ) / 1000;
        }
        
        if ( self.isactive )
        {
            var_7b847e685b032554 = 0;
            
            if ( level.teambased )
            {
                var_7b847e685b032554 = default_to( level.activeuavs[ self.owner.team ], 0 );
            }
            else
            {
                var_7b847e685b032554 = default_to( level.activeuavs[ self.owner.guid ], 0 );
            }
            
            hasuav = level.totalactiveuavs - var_7b847e685b032554 > 0;
            
            if ( !hasuav )
            {
                var_71f10319cd3043a9 = 0;
                
                if ( level.teambased )
                {
                    var_71f10319cd3043a9 = default_to( level.activeadvanceduavs[ self.owner.team ], 0 );
                }
                else
                {
                    var_71f10319cd3043a9 = default_to( level.activeadvanceduavs[ self.owner.guid ], 0 );
                }
                
                hasuav = level.activeadvanceduavcount - var_71f10319cd3043a9 > 0;
            }
            
            if ( hasuav )
            {
                var_88859a5a22b4de6e = array_difference( self.trigger.var_854cf4c64f4bdd9f, self.var_4b15951dd656dcc0 );
                
                if ( var_88859a5a22b4de6e.size > 0 )
                {
                    function_e082ef4196a28f0b( var_88859a5a22b4de6e );
                }
            }
        }
        
        wait 0.5;
    }
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 0
// Checksum 0x0, Offset: 0x14ef
// Size: 0x5c
function function_50c6e9ffe406b26e()
{
    while ( true )
    {
        level waittill( "portable_radar_ping", pingposition, pingplayer, pingradius );
        
        if ( self.isactive && pingplayer isenemy( self.owner ) )
        {
            function_721fd61e3d39a6fc( pingposition, pingradius );
        }
    }
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 0
// Checksum 0x0, Offset: 0x1553
// Size: 0x61
function function_3aed59109065b38a()
{
    while ( true )
    {
        level waittill( "portable_radar_ping_team", pingposition, pingteam, pingradius );
        
        if ( self.isactive && pingteam != self.owner.team )
        {
            function_721fd61e3d39a6fc( pingposition, pingradius );
        }
    }
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 2
// Checksum 0x0, Offset: 0x15bc
// Size: 0x149
function function_721fd61e3d39a6fc( pingposition, pingradius )
{
    var_fd999362783c862f = self.bundle.var_c93862714a3e756e * 1000;
    var_294e2c9657f8efff = gettime() - self.var_2020fa0ae4d1323d;
    
    if ( var_294e2c9657f8efff < var_fd999362783c862f )
    {
        return;
    }
    
    var_5826f64c707f910b = array_difference( self.trigger.var_854cf4c64f4bdd9f, self.var_4b15951dd656dcc0 );
    var_b9f63f8c68e691de = [];
    
    foreach ( var_508f4872bf68fa46 in var_5826f64c707f910b )
    {
        var_433f5b38c7205a99 = self.trigger.playersintrigger[ var_508f4872bf68fa46 ];
        var_8081987ef05481dd = distancesquared( var_433f5b38c7205a99.origin, pingposition );
        var_3b85a2c354f9ce88 = float( pingradius * pingradius );
        
        if ( var_8081987ef05481dd < var_3b85a2c354f9ce88 )
        {
            var_b9f63f8c68e691de = function_6d6af8144a5131f1( var_b9f63f8c68e691de, var_508f4872bf68fa46 );
        }
    }
    
    if ( var_b9f63f8c68e691de.size > 0 )
    {
        function_e082ef4196a28f0b( var_b9f63f8c68e691de );
    }
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 1
// Checksum 0x0, Offset: 0x170d
// Size: 0x58
function function_e082ef4196a28f0b( var_88859a5a22b4de6e )
{
    self.owner thread [[ getsharedfunc( "player", "doScoreEvent" ) ]]( #"super_comm_scrambler_ghost" );
    self.var_2020fa0ae4d1323d = gettime();
    self.var_4b15951dd656dcc0 = array_combine( self.var_4b15951dd656dcc0, var_88859a5a22b4de6e );
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 1
// Checksum 0x0, Offset: 0x176d
// Size: 0xde
function function_741968e8ad6d8f0a( isactive )
{
    if ( isactive == self.isactive )
    {
        return;
    }
    
    if ( isactive )
    {
        self.isactive = 1;
        
        foreach ( id, player in self.trigger.playersintrigger )
        {
            player function_ac6ba9556aa071b2( self, id );
        }
        
        return;
    }
    
    self.isactive = 0;
    
    foreach ( player in self.trigger.playersintrigger )
    {
        player function_95b4fc5672916c93( self, id );
    }
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 0
// Checksum 0x0, Offset: 0x1853
// Size: 0x4c
function function_e26cc89366241706()
{
    if ( issharedfuncdefined( "damage", "monitorDamage" ) )
    {
        self thread [[ getsharedfunc( "damage", "monitorDamage" ) ]]( self.bundle.maxhealth, "hitequip", &function_5013def65fabcc8a, &function_79a97ee01dc267d3 );
    }
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 1
// Checksum 0x0, Offset: 0x18a7
// Size: 0x27
function function_5013def65fabcc8a( data )
{
    function_1b38460f9db6a610( data.attacker );
    thread function_4ee728f14862d601( 1 );
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 0
// Checksum 0x0, Offset: 0x18d6
// Size: 0x3f
function function_38c09c457c05cec6()
{
    if ( isdefined( self.outlineid ) )
    {
        if ( issharedfuncdefined( "outline", "outlineDisable" ) )
        {
            [[ getsharedfunc( "outline", "outlineDisable" ) ]]( self.outlineid, self );
        }
    }
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 0
// Checksum 0x0, Offset: 0x191d
// Size: 0x50
function function_e016066e327d42b6()
{
    if ( isdefined( self.headiconid ) )
    {
        scripts\cp_mp\entityheadicons::setheadicon_deleteicon( self.headiconid );
        self.headiconid = undefined;
    }
    
    if ( isdefined( self.headiconfaction ) )
    {
        scripts\cp_mp\entityheadicons::setheadicon_deleteicon( self.headiconfaction );
        self.headiconfaction = undefined;
    }
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 1
// Checksum 0x0, Offset: 0x1975
// Size: 0x8d
function function_1b38460f9db6a610( attacker )
{
    if ( !isdefined( self.owner ) || scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker notify( "destroyed_equipment" );
        
        if ( issharedfuncdefined( "player", "doScoreEvent" ) )
        {
            attacker thread [[ getsharedfunc( "player", "doScoreEvent" ) ]]( #"destroyed_equipment" );
        }
        
        if ( issharedfuncdefined( "battlechatter", "equipmentDestroyed" ) )
        {
            [[ getsharedfunc( "battlechatter", "equipmentDestroyed" ) ]]( self );
        }
    }
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 1
// Checksum 0x0, Offset: 0x1a0a
// Size: 0x13
function function_141dc243d9b500e1( data )
{
    function_4ee728f14862d601( 0 );
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 1
// Checksum 0x0, Offset: 0x1a25
// Size: 0xcf
function function_384bb480ddf5851c( data )
{
    owner = self.owner;
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    superinfo = undefined;
    
    if ( issharedfuncdefined( "player", "getCurrentSuper" ) )
    {
        superinfo = owner [[ getsharedfunc( "player", "getCurrentSuper" ) ]]();
    }
    
    if ( isdefined( superinfo ) && level.allowsupers )
    {
        superinfo.wasrefunded = 1;
        
        if ( issharedfuncdefined( "supers", "getSuperPointsNeeded" ) && issharedfuncdefined( "supers", "setSuperBasePoints" ) )
        {
            owner [[ getsharedfunc( "supers", "setSuperBasePoints" ) ]]( owner [[ getsharedfunc( "supers", "getSuperPointsNeeded" ) ]]() );
        }
    }
    
    function_4ee728f14862d601( 0 );
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 1
// Checksum 0x0, Offset: 0x1afc
// Size: 0xb9
function function_d25ff4a17fd8fb37( stuckto )
{
    data = spawnstruct();
    data.linkparent = stuckto;
    data.deathoverridecallback = &function_141dc243d9b500e1;
    data.invalidparentoverridecallback = &function_384bb480ddf5851c;
    data.endonstring = "death";
    data.validateaccuratetouching = 1;
    
    if ( isdefined( stuckto ) && scripts\cp_mp\utility\train_utility::is_train_ent( stuckto ) )
    {
        data.plantedontrain = 1;
        self setmissileantilagged( 1 );
    }
    
    if ( issharedfuncdefined( "game", "handlemovingplatforms" ) )
    {
        self thread [[ getsharedfunc( "game", "handlemovingplatforms" ) ]]( data );
    }
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 1
// Checksum 0x0, Offset: 0x1bbd
// Size: 0x12e
function function_cf6202f14a8176f( player )
{
    self endon( "death" );
    self endon( "missile_stuck" );
    player endon( "disconnect" );
    msg = waittill_any_timeout_1( 2, "touching_platform" );
    
    if ( msg == "timeout" )
    {
        return;
    }
    
    groundentity = undefined;
    ignoreents = vehicle_getarrayinradius( self.origin, 500, 500 );
    ignoreents[ ignoreents.size ] = self;
    tracecontents = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 1, 1, 0, 1 );
    tracestart = self.origin;
    var_3a7f0173b03f5767 = -2000;
    traceend = self.origin + ( 0, 0, var_3a7f0173b03f5767 );
    traceresults = scripts\engine\trace::ray_trace( tracestart, traceend, ignoreents, tracecontents );
    
    if ( traceresults[ "fraction" ] < 1 )
    {
        groundentity = traceresults[ "entity" ];
        
        if ( isdefined( groundentity ) )
        {
            if ( scripts\cp_mp\utility\train_utility::is_train_ent( groundentity ) )
            {
                self.origin = player.origin;
            }
        }
    }
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 0
// Checksum 0x0, Offset: 0x1cf3
// Size: 0x6c
function function_cbc5bc96e58659c7()
{
    self endon( "death" );
    
    if ( issharedfuncdefined( "hostmigration", "waitLongDurationWithPause" ) )
    {
        [[ getsharedfunc( "hostmigration", "waitLongDurationWithPause" ) ]]( getdvarfloat( @"hash_2467b36602d82d7f", self.bundle.maxlifetime ) );
    }
    
    if ( isdefined( self ) && !istrue( self.isdestroyed ) )
    {
        thread function_4ee728f14862d601( 0 );
    }
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 0
// Checksum 0x0, Offset: 0x1d67
// Size: 0x4b
function function_44a7cc547d0a4415()
{
    self endon( "death" );
    self endon( "comm_scrambler_hacked" );
    self.owner waittill_any_return_no_endon_death_3( "disconnect", "joined_team", "joined_spectators" );
    
    if ( isdefined( self ) && !istrue( self.isdestroyed ) )
    {
        thread function_4ee728f14862d601( 0 );
    }
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 1
// Checksum 0x0, Offset: 0x1dba
// Size: 0x59
function function_2233a8cd9c48a336( data )
{
    function_741968e8ad6d8f0a( 0 );
    
    if ( isdefined( data.attacker ) )
    {
        if ( scripts\engine\utility::issharedfuncdefined( "player", "doScoreEvent" ) )
        {
            data.attacker thread [[ scripts\engine\utility::getsharedfunc( "player", "doScoreEvent" ) ]]( "disabled_comm_scrambler" );
        }
    }
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 1
// Checksum 0x0, Offset: 0x1e1b
// Size: 0x14
function function_93e55db60b551e17( data )
{
    function_741968e8ad6d8f0a( 1 );
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 1
// Checksum 0x0, Offset: 0x1e37
// Size: 0x33
function function_89a8296f4d744235( data )
{
    attacker = data.attacker;
    function_1b38460f9db6a610( attacker );
    thread function_4ee728f14862d601( 1 );
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 1
// Checksum 0x0, Offset: 0x1e72
// Size: 0x62
function function_5bb22bae2eafed7( player )
{
    foreach ( commscrambler in level.var_4e74070c2484e644 )
    {
        if ( isdefined( commscrambler ) )
        {
            commscrambler function_7b2d108a7fefb17( player );
        }
    }
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 0
// Checksum 0x0, Offset: 0x1edc
// Size: 0x59
function function_4957058182ec35a8()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        function_7b2d108a7fefb17( player );
    }
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 1
// Checksum 0x0, Offset: 0x1f3d
// Size: 0xde
function function_7b2d108a7fefb17( player )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    idfaction = self.headiconfaction;
    
    if ( !isdefined( idfaction ) )
    {
        return;
    }
    
    isfriendly = undefined;
    
    if ( issharedfuncdefined( "player", "isFriendly" ) )
    {
        isfriendly = [[ getsharedfunc( "player", "isFriendly" ) ]]( self.owner.team, player );
    }
    
    isused = isdefined( self.playersused ) && isdefined( self.playersused[ player getentitynumber() ] );
    
    if ( isfriendly && !isused )
    {
        scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask( idfaction, player );
        return;
    }
    
    if ( isfriendly )
    {
        scripts\cp_mp\entityheadicons::setheadicon_addclienttomask( idfaction, player );
        return;
    }
    
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask( idfaction, player );
}

// Namespace comm_scrambler / scripts\cp_mp\supers\comm_scrambler
// Params 2
// Checksum 0x0, Offset: 0x2023
// Size: 0x109
function commscrambler_onhacked( newowner, oldowner )
{
    clearminimapid();
    
    if ( issharedfuncdefined( "game", "createObjective" ) )
    {
        self.minimapid = self [[ getsharedfunc( "game", "createObjective" ) ]]( "jup_hud_icon_minimap_fieldupgrade_commscrambler", self.team, 0, 1, 1 );
    }
    
    foreach ( player in self.trigger.playersintrigger )
    {
        player function_95b4fc5672916c93( self, id, oldowner );
    }
    
    self.trigger.playersintrigger = [];
    self.trigger.var_854cf4c64f4bdd9f = [];
    self.trigger.var_a81e3fef4236357a = [];
    self notify( "comm_scrambler_hacked" );
    thread function_44a7cc547d0a4415();
}

