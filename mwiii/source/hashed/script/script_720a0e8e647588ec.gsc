#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\progression_utility;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\game;
#using scripts\mp\utility\weapon;
#using scripts\mp\weaponrank;

#namespace rankup;

// Namespace rankup / namespace_143053cbd5a5349c
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x218
// Size: 0x60
function private onplayerconnect( params )
{
    var_5c9f21448aa0c962 = getdvarint( @"hash_5e68ed857a17e11", 0 );
    
    if ( getbuildversion() != "SHIP" )
    {
        if ( var_5c9f21448aa0c962 > 0 && !scripts\cp_mp\utility\game_utility::function_d04af493b6e718ac() )
        {
            level.dontendonscore = 1;
            
            if ( !isbot( self ) )
            {
                thread function_d579c78c2ac10132();
            }
        }
    }
}

// Namespace rankup / namespace_143053cbd5a5349c
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x280
// Size: 0x13
function private init()
{
    callback::add( "player_connect", &onplayerconnect );
}

// Namespace rankup / namespace_143053cbd5a5349c
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x29b
// Size: 0xdf
function private function_d579c78c2ac10132()
{
    self notify( "player_rankup_loop_singleton" );
    self endon( "player_rankup_loop_singleton" );
    level endon( "game_ended" );
    self endon( "disconnect" );
    level waittill( "matchStartTimer_done" );
    
    while ( !isalive( self ) )
    {
        wait 1;
    }
    
    thread function_f2d9a40693e59a95();
    thread _switchweaponloop();
    
    while ( false )
    {
        if ( isalive( self ) )
        {
            curweap = self getcurrentweapon();
            
            if ( function_e16bb69fe1ca890a( curweap ) )
            {
                currootweapon = getweaponrootname( curweap );
                rank = function_37f14fd361bd3290( currootweapon );
                numranks = level.weaponranktable.maxweaponranks[ currootweapon ];
                
                if ( rank >= numranks - 1 )
                {
                    nextweap = function_8fd5629428f0752b();
                    
                    if ( !isdefined( nextweap ) )
                    {
                        break;
                    }
                    
                    _switchtoweapon( nextweap );
                }
            }
        }
        
        wait 2;
    }
}

// Namespace rankup / namespace_143053cbd5a5349c
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x382
// Size: 0xaf
function private function_8fd5629428f0752b()
{
    foreach ( weap, rank in level.weaponranktable.maxweaponranks )
    {
        if ( !isdefined( weap ) )
        {
            continue;
        }
        
        rootweapon = getweaponrootname( weap );
        
        if ( function_e16bb69fe1ca890a( rootweapon ) )
        {
            rank = function_37f14fd361bd3290( rootweapon );
            numranks = level.weaponranktable.maxweaponranks[ rootweapon ];
            
            if ( rank < numranks - 1 )
            {
                return rootweapon;
            }
        }
    }
    
    return undefined;
}

// Namespace rankup / namespace_143053cbd5a5349c
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x43a
// Size: 0x8a
function private _switchtoweapon( weap )
{
    if ( !isdefined( weap ) )
    {
        return;
    }
    
    curweap = self getcurrentweapon();
    currootweapon = getweaponrootname( curweap );
    scripts\cp_mp\utility\inventory_utility::_takeweapon( curweap );
    rootweapon = getweaponrootname( weap );
    weapon = buildweapon( rootweapon );
    self giveweapon( weapon );
    self setweaponammoclip( weapon, weaponclipsize( weapon ) );
    self setweaponammostock( weapon, weaponmaxammo( weapon ) );
    self switchtoweaponimmediate( weapon );
}

// Namespace rankup / namespace_143053cbd5a5349c
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x4cc
// Size: 0x41
function private function_604e6c056c7de43d()
{
    self notify( "player_shooting_loop" );
    self endon( "player_shooting_loop" );
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    while ( true )
    {
        self startforcedfire();
        wait 0.2;
        self stopforcedfire();
        wait 0.2;
    }
}

// Namespace rankup / namespace_143053cbd5a5349c
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x515
// Size: 0xd0
function private function_f2d9a40693e59a95()
{
    self notify( "player_aim_loop" );
    self endon( "player_aim_loop" );
    level endon( "game_ended" );
    self endon( "disconnect" );
    targetpos = getdvarvector( @"hash_47b188962f53ea3b", ( -2269, -705, 258 ) );
    targetangles = getdvarvector( @"hash_4bd47ef19661c575", ( 0, 177, 0 ) );
    
    while ( true )
    {
        pos = self getorigin();
        angles = self getplayerangles();
        delta = distance( pos, targetpos );
        
        if ( delta > 3 )
        {
            pos = self setorigin( targetpos );
        }
        
        delta = distance( angles, targetangles );
        
        if ( delta > 2 )
        {
            pos = self setplayerangles( targetangles );
        }
        
        wait 10;
    }
}

// Namespace rankup / namespace_143053cbd5a5349c
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5ed
// Size: 0xfc
function private function_37f14fd361bd3290( weaponname )
{
    var_32e9d6e2b27343b9 = self getplayerdata( level.loadoutdata, "squadMembers", "weapon_xp", weaponname );
    curxp = 0;
    
    foreach ( elem in self.pers[ "weaponStats" ] )
    {
        elemrootweapon = getweaponrootname( elem.weapon );
        
        if ( elemrootweapon == weaponname && isdefined( elem.stats[ "xp_earned" ] ) )
        {
            curxp += elem.stats[ "xp_earned" ];
        }
    }
    
    weapxp = var_32e9d6e2b27343b9 + curxp;
    rank = getweaponrankforxp( weapxp );
    return rank;
}

// Namespace rankup / namespace_143053cbd5a5349c
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x6f2
// Size: 0x3d, Type: bool
function private _isriotshield( weaponname )
{
    if ( isweapon( weaponname ) && isnullweapon( weaponname ) )
    {
        return false;
    }
    
    if ( isstring( weaponname ) && weaponname == "none" )
    {
        return false;
    }
    
    return weaponname == "iw9_me_riotshield";
}

// Namespace rankup / namespace_143053cbd5a5349c
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x738
// Size: 0x35
function private _ismeleeweapon( weaponname )
{
    ismeleeweapon = isknifeonly( weaponname ) || isakimbomeleeweapon( weaponname ) || isaxeweapon( weaponname );
    return ismeleeweapon;
}

// Namespace rankup / namespace_143053cbd5a5349c
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x776
// Size: 0x5d, Type: bool
function private function_e16bb69fe1ca890a( weapon )
{
    if ( !isdefined( weapon ) )
    {
        return false;
    }
    
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = getweaponrootname( weapon );
    }
    else
    {
        weaponname = weapon;
    }
    
    if ( _ismeleeweapon( weaponname ) )
    {
        return false;
    }
    
    if ( _isriotshield( weaponname ) )
    {
        return false;
    }
    
    if ( !weaponshouldgetxp( weaponname ) )
    {
        return false;
    }
    
    return true;
}

// Namespace rankup / namespace_143053cbd5a5349c
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x7dc
// Size: 0x6d
function private _switchweaponloop()
{
    self notify( "_switchWeaponLoop" );
    self endon( "_switchWeaponLoop" );
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    while ( true )
    {
        var_b92bd81c89f295e6 = getdvar( @"hash_cf91e71876e160cc" );
        
        if ( var_b92bd81c89f295e6 != "" )
        {
            _switchtoweapon( var_b92bd81c89f295e6 );
            setdvar( @"hash_cf91e71876e160cc", "" );
        }
        
        wait 0.5;
    }
}

