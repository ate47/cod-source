#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\stealth\utility;

#namespace utility;

/#

    // Namespace utility / scripts\cp_mp\stealth\utility
    // Params 1
    // Checksum 0x0, Offset: 0x29c
    // Size: 0x1f, Type: dev
    function function_a464c293616a3a6( debug_string )
    {
        if ( !function_e39a555170607456() )
        {
            return;
        }
        
        iprintln( debug_string );
    }

    // Namespace utility / scripts\cp_mp\stealth\utility
    // Params 0
    // Checksum 0x0, Offset: 0x2c3
    // Size: 0x17, Type: dev
    function function_e39a555170607456()
    {
        return getdvarint( @"hash_6d78d3cf7d56cdd5", 0 ) != 0;
    }

#/

// Namespace utility / scripts\cp_mp\stealth\utility
// Params 1
// Checksum 0x0, Offset: 0x2e2
// Size: 0x29
function setattackeraccuracy( val )
{
    if ( isplayer( self ) )
    {
        function_50c9c1c52c852f54( val );
        return;
    }
    
    self.attackeraccuracy = val;
}

// Namespace utility / scripts\cp_mp\stealth\utility
// Params 1
// Checksum 0x0, Offset: 0x313
// Size: 0x3c
function function_50c9c1c52c852f54( val )
{
    self.scriptedattackeraccuracy = val;
    
    if ( scripts\engine\utility::issharedfuncdefined( "gameskill", "updatePlayerAttackerAccuracy" ) )
    {
        self [[ scripts\engine\utility::getsharedfunc( "gameskill", "updatePlayerAttackerAccuracy" ) ]]();
    }
}

// Namespace utility / scripts\cp_mp\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0x357
// Size: 0x33, Type: bool
function hassixthsense()
{
    perkname = "specialty_sixth_sense";
    return isdefined( perkname ) && isdefined( self.perks ) && isdefined( self.perks[ perkname ] );
}

// Namespace utility / scripts\cp_mp\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0x393
// Size: 0x33, Type: bool
function function_7043a32c6ff5835a()
{
    perkname = "specialty_ai_stealth_sixth_sense";
    return isdefined( perkname ) && isdefined( self.perks ) && isdefined( self.perks[ perkname ] );
}

// Namespace utility / scripts\cp_mp\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0x3cf
// Size: 0x16
function function_e33c1a98de731caf()
{
    if ( scripts\cp_mp\utility\game_utility::function_42e2dcfd4571b89b() )
    {
        return "all";
    }
    
    return "bad_guys";
}

// Namespace utility / scripts\cp_mp\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0x3ee
// Size: 0x4f2
function function_7f12653d04730492()
{
    var_1572384ef9f3dbe2 = 1;
    
    if ( getdvarint( @"hash_4096753656b86302", 0 ) )
    {
        var_1572384ef9f3dbe2 = 0;
    }
    
    if ( flag( "stealth_spotted" ) && var_1572384ef9f3dbe2 )
    {
        foreach ( guy in level.players )
        {
            guy setclientomnvar( "ui_ai_stealth_edge_glow", 0 );
        }
        
        return;
    }
    
    tracecontents = scripts\engine\trace::create_default_contents( 1 );
    sixthsensedebug = 0;
    
    /#
        sixthsensedebug = getdvarint( @"hash_3a87475a75de0350" ) == 1;
    #/
    
    tootherplayer = undefined;
    var_746071ab06f38fd = undefined;
    
    foreach ( num, player in level.var_97068503cee0ee88 )
    {
        if ( !isdefined( player ) )
        {
            level.var_97068503cee0ee88[ num ] = undefined;
            break;
        }
        
        if ( istrue( player.ignoreme ) || istrue( player.notarget ) )
        {
            continue;
        }
        
        player.process = 0;
        sightmask = 0;
        spottedmask = 0;
        playerpos = player geteye();
        playerteam = player.team;
        playeraim = anglestoforward( player getplayerangles() );
        
        foreach ( otherplayer in getaiarray( function_e33c1a98de731caf() ) )
        {
            if ( player.process >= 25 )
            {
                player.process = 0;
                waitframe();
            }
            
            if ( !isdefined( player ) )
            {
                level.var_97068503cee0ee88[ num ] = undefined;
                break;
            }
            
            if ( !player hassixthsense() && !player function_7043a32c6ff5835a() )
            {
                continue;
            }
            
            if ( istrue( player.ignoreme ) || istrue( player.notarget ) )
            {
                continue;
            }
            
            if ( !player scripts\cp_mp\utility\player_utility::_isalive() )
            {
                continue;
            }
            
            if ( !isdefined( otherplayer ) )
            {
                continue;
            }
            
            if ( !isdefined( otherplayer.stealth ) )
            {
                continue;
            }
            
            if ( !otherplayer scripts\cp_mp\utility\player_utility::_isalive() )
            {
                continue;
            }
            
            if ( istrue( otherplayer.ignoreall ) )
            {
                continue;
            }
            
            if ( otherplayer.team == playerteam )
            {
                continue;
            }
            
            if ( distancesquared( otherplayer.origin, playerpos ) > 16000000 )
            {
                continue;
            }
            
            if ( !otherplayer function_830f660f7a75ee82( player ) )
            {
                continue;
            }
            
            player.process++;
            
            if ( !otherplayer cansee( player ) )
            {
                continue;
            }
            
            otherplayerpos = otherplayer geteye();
            var_ed6e173aa5e562a5 = anglestoforward( otherplayer getplayerangles() );
            fromotherplayer = playerpos - otherplayerpos;
            tootherplayer = otherplayerpos - playerpos;
            dot = vectordot( playeraim, vectornormalize( tootherplayer ) );
            player.process += 2;
            sightmask |= player function_9af348cfa1145f9c( otherplayer );
            
            if ( otherplayer scripts\stealth\utility::function_6a86dd83c01f8faa() && !isdefined( otherplayer.forcesixthsense ) )
            {
                spottedmask |= player function_9af348cfa1145f9c( otherplayer );
                
                if ( spottedmask > 0 )
                {
                    if ( !isdefined( player.var_80221e9c5627503a ) )
                    {
                        player.var_80221e9c5627503a = gettime();
                    }
                    
                    if ( gettime() >= player.var_80221e9c5627503a )
                    {
                        player.var_80221e9c5627503a = gettime() + 5000;
                    }
                }
                
                continue;
            }
            
            if ( isdefined( level.var_28c0d60e971ff699 ) )
            {
                dirs = [ "left", "right", "lower", "upper" ];
                
                foreach ( dir in dirs )
                {
                    active = function_d075e24b4fdf7c87( dir, sightmask );
                    spotted = function_d075e24b4fdf7c87( dir, spottedmask );
                    player function_6186bf9e7a357a3e( dir, active, spotted, sightmask, spottedmask );
                    player thread [[ level.var_28c0d60e971ff699 ]]( dir, active, spotted );
                }
            }
            
            break;
        }
        
        if ( var_1572384ef9f3dbe2 )
        {
            player function_39af3dff662a71d0( sightmask );
        }
    }
}

// Namespace utility / scripts\cp_mp\stealth\utility
// Params 5
// Checksum 0x0, Offset: 0x8e8
// Size: 0xeb
function function_6186bf9e7a357a3e( dir, active, spotted, sightmask, spottedmask )
{
    if ( sightmask > 0 )
    {
        if ( spottedmask == 0 && getstealthdetectstate() != "spotted" )
        {
            if ( !isdefined( self.var_33df676309c77fc4 ) )
            {
                self.var_33df676309c77fc4 = gettime();
            }
            
            if ( gettime() >= self.var_33df676309c77fc4 )
            {
                self.var_33df676309c77fc4 = gettime() + 5000;
                self playlocalsound( "ui_stealth_threat_hud_periph_vision" );
            }
        }
    }
    
    if ( spottedmask > 0 || istrue( spotted ) || getstealthdetectstate() == "spotted" )
    {
        if ( !isdefined( self.var_80221e9c5627503a ) )
        {
            self.var_80221e9c5627503a = gettime();
        }
        
        if ( gettime() >= self.var_80221e9c5627503a )
        {
            self.var_80221e9c5627503a = gettime() + 5000;
        }
    }
}

// Namespace utility / scripts\cp_mp\stealth\utility
// Params 2
// Checksum 0x0, Offset: 0x9db
// Size: 0x10c, Type: bool
function function_d075e24b4fdf7c87( dir, mask )
{
    consts = [];
    
    switch ( dir )
    {
        case #"hash_c9b3133a17a3b2d0":
            consts = [ 128, 32 ];
            break;
        case #"hash_96815ce4f2a3dbc5":
            consts = [ 64, 8 ];
            break;
        case #"hash_1e6b44ab584b8527":
            consts = [ 4, 2, 1 ];
            break;
        case #"hash_c325f7340a63499a":
            consts = [ 16 ];
            break;
        default:
            assertmsg( "<dev string:x1c>" + dir );
            break;
    }
    
    foreach ( constvalue in consts )
    {
        if ( mask & constvalue )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\cp_mp\stealth\utility
// Params 1
// Checksum 0x0, Offset: 0xaf0
// Size: 0x8e
function _getweapongroup( weapon )
{
    if ( isweapon( weapon ) && isnullweapon( weapon ) )
    {
        return "other";
    }
    
    if ( isstring( weapon ) && ( weapon == "none" || weapon == "alt_none" ) )
    {
        return "other";
    }
    
    rootname = getweaponrootname( weapon );
    group = weapongroupmap( rootname );
    
    if ( !isdefined( group ) )
    {
        if ( iskillstreakweapon( weapon ) )
        {
            group = "killstreak";
        }
        else
        {
            group = "other";
        }
    }
    
    return group;
}

// Namespace utility / scripts\cp_mp\stealth\utility
// Params 1
// Checksum 0x0, Offset: 0xb87
// Size: 0xf9, Type: bool
function function_830f660f7a75ee82( player )
{
    if ( istrue( self.juggernaut ) )
    {
        return true;
    }
    
    if ( isdefined( self.unittype ) && self.unittype == "suicidebomber" )
    {
        return true;
    }
    
    objweapon = self.weapon;
    weapongroup = _getweapongroup( objweapon );
    
    switch ( weapongroup )
    {
        case #"hash_bef5ec0b3e197ae":
        case #"hash_47368bc0d2ef1565":
        case #"hash_8af0086b038622b5":
        case #"hash_9d18adab1b65a661":
        case #"hash_ab10f9c080fe4faf":
        case #"hash_c095d67337b1f5a1":
        case #"hash_dd616da0b395a0b0":
            return true;
        case #"hash_16cf6289ab06bd30":
            if ( distancesquared( self.origin, player.origin ) > 160000 )
            {
                return true;
            }
            
            break;
    }
    
    return false;
}

// Namespace utility / scripts\cp_mp\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0xc89
// Size: 0x1c
function function_a5ff5e1965faf40e()
{
    level.var_97068503cee0ee88 = [];
    
    while ( true )
    {
        waitframe();
        function_7f12653d04730492();
    }
}

// Namespace utility / scripts\cp_mp\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0xcad
// Size: 0x3d
function function_378625a93d79fdc2()
{
    self.var_27e6cfd1a20ca927 = 0;
    self.var_de2a54afecc91d1 = 0;
    function_39af3dff662a71d0( 0 );
    playernum = self getentitynumber();
    level.var_97068503cee0ee88[ playernum ] = self;
}

// Namespace utility / scripts\cp_mp\stealth\utility
// Params 0
// Checksum 0x0, Offset: 0xcf2
// Size: 0x4d
function function_1a4d7090fc81e97()
{
    function_39af3dff662a71d0( 0 );
    self.var_27e6cfd1a20ca927 = undefined;
    self.var_de2a54afecc91d1 = undefined;
    self.var_1e85d2f7fb6bd099 = undefined;
    self notify( "removeSixthSense" );
    playernum = self getentitynumber();
    level.var_97068503cee0ee88[ playernum ] = undefined;
}

// Namespace utility / scripts\cp_mp\stealth\utility
// Params 1
// Checksum 0x0, Offset: 0xd47
// Size: 0x18
function function_39af3dff662a71d0( sightmask )
{
    self setclientomnvar( "ui_ai_stealth_edge_glow", sightmask );
}

// Namespace utility / scripts\cp_mp\stealth\utility
// Params 1
// Checksum 0x0, Offset: 0xd67
// Size: 0x13a
function function_9af348cfa1145f9c( enemy )
{
    forward = anglestoforward( self getplayerangles() );
    forward2d = ( forward[ 0 ], forward[ 1 ], forward[ 2 ] );
    forward2d = vectornormalize( forward2d );
    toenemy = enemy.origin - self.origin;
    toenemy2d = ( toenemy[ 0 ], toenemy[ 1 ], toenemy[ 2 ] );
    toenemy2d = vectornormalize( toenemy2d );
    dot = vectordot( forward2d, toenemy2d );
    
    if ( dot >= 0.92388 )
    {
        return 2;
    }
    
    if ( dot >= 0.5 )
    {
        return ter_op( isleft2d( self.origin, forward2d, enemy.origin ), 4, 1 );
    }
    
    if ( dot >= 0.5 )
    {
        return ter_op( isleft2d( self.origin, forward2d, enemy.origin ), 128, 64 );
    }
    
    if ( dot >= -0.707107 )
    {
        return ter_op( isleft2d( self.origin, forward2d, enemy.origin ), 32, 8 );
    }
    
    return 16;
}

