#using scripts\common\utility;
#using scripts\engine\utility;

#namespace utility_common;

// Namespace utility_common / scripts\anim\utility_common
// Params 6
// Checksum 0x0, Offset: 0x1ea
// Size: 0x73
function print3dtime( timer, org, msg, color, alpha, scale )
{
    newtime = timer / 0.05;
    
    for ( i = 0; i < newtime ; i++ )
    {
        /#
            print3d( org, msg, color, alpha, scale );
        #/
        
        wait 0.05;
    }
}

// Namespace utility_common / scripts\anim\utility_common
// Params 5
// Checksum 0x0, Offset: 0x265
// Size: 0x90
function print3drise( org, msg, color, alpha, scale )
{
    newtime = 100;
    up = 0;
    org += randomvector( 30 );
    
    for ( i = 0; i < newtime ; i++ )
    {
        up += 0.5;
        
        /#
            print3d( org + ( 0, 0, up ), msg, color, alpha, scale );
        #/
        
        wait 0.05;
    }
}

// Namespace utility_common / scripts\anim\utility_common
// Params 2
// Checksum 0x0, Offset: 0x2fd
// Size: 0x26, Type: bool
function crossproduct( vec1, vec2 )
{
    return vec1[ 0 ] * vec2[ 1 ] - vec1[ 1 ] * vec2[ 0 ] > 0;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 2
// Checksum 0x0, Offset: 0x32c
// Size: 0x2e
function safemod( a, b )
{
    result = int( a ) % b;
    result += b;
    return result % b;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 1
// Checksum 0x0, Offset: 0x363
// Size: 0x101
function quadrantanimweights( yaw )
{
    forwardweight = cos( yaw );
    leftweight = sin( yaw );
    result[ "front" ] = 0;
    result[ "right" ] = 0;
    result[ "back" ] = 0;
    result[ "left" ] = 0;
    
    if ( isdefined( self.alwaysrunforward ) )
    {
        assert( self.alwaysrunforward );
        result[ "front" ] = 1;
        return result;
    }
    
    if ( forwardweight > 0 )
    {
        if ( leftweight > forwardweight )
        {
            result[ "left" ] = 1;
        }
        else if ( leftweight < -1 * forwardweight )
        {
            result[ "right" ] = 1;
        }
        else
        {
            result[ "front" ] = 1;
        }
    }
    else
    {
        backweight = -1 * forwardweight;
        
        if ( leftweight > backweight )
        {
            result[ "left" ] = 1;
        }
        else if ( leftweight < forwardweight )
        {
            result[ "right" ] = 1;
        }
        else
        {
            result[ "back" ] = 1;
        }
    }
    
    return result;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 1
// Checksum 0x0, Offset: 0x46d
// Size: 0x60
function getquadrant( angle )
{
    angle = angleclamp( angle );
    
    if ( angle < 45 || angle > 315 )
    {
        quadrant = "front";
    }
    else if ( angle < 135 )
    {
        quadrant = "left";
    }
    else if ( angle < 225 )
    {
        quadrant = "back";
    }
    else
    {
        quadrant = "right";
    }
    
    return quadrant;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 2
// Checksum 0x0, Offset: 0x4d6
// Size: 0x3b, Type: bool
function isinset( input, set )
{
    for ( i = set.size - 1; i >= 0 ; i-- )
    {
        if ( input == set[ i ] )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0x51a
// Size: 0x29, Type: bool
function weapon_genade_launcher()
{
    return !isnullweapon( self.weapon ) && weaponclass( self.weapon ) == "grenade";
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0x54c
// Size: 0x3b, Type: bool
function weapon_pump_action_shotgun()
{
    return !isnullweapon( self.weapon ) && weaponisboltaction( self.weapon ) && weaponclass( self.weapon ) == "spread";
}

// Namespace utility_common / scripts\anim\utility_common
// Params 1
// Checksum 0x0, Offset: 0x590
// Size: 0x17, Type: bool
function islmg( weapon )
{
    return weaponclass( weapon ) == "mg";
}

// Namespace utility_common / scripts\anim\utility_common
// Params 1
// Checksum 0x0, Offset: 0x5b0
// Size: 0x17, Type: bool
function isshotgun( weapon )
{
    return weaponclass( weapon ) == "spread";
}

// Namespace utility_common / scripts\anim\utility_common
// Params 1
// Checksum 0x0, Offset: 0x5d0
// Size: 0x17, Type: bool
function issniperrifle( weapon )
{
    return weaponclass( weapon ) == "sniper";
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0x5f0
// Size: 0x11, Type: bool
function isshotgunai()
{
    return isshotgun( self.primaryweapon );
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0x60a
// Size: 0x12, Type: bool
function islongrangeai()
{
    return self aiissniper() || usingrocketlauncher();
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0x625
// Size: 0x16, Type: bool
function usingpistol()
{
    return weaponclass( self.weapon ) == "pistol";
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0x644
// Size: 0x16, Type: bool
function usingrocketlauncher()
{
    return weaponclass( self.weapon ) == "rocketlauncher";
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0x663
// Size: 0x16, Type: bool
function usingmg()
{
    return weaponclass( self.weapon ) == "mg";
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0x682
// Size: 0x16, Type: bool
function isusingshotgun()
{
    return weaponclass( self.weapon ) == "spread";
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0x6a1
// Size: 0x64, Type: bool
function usingriflelikeweapon()
{
    class = weaponclass( self.weapon );
    
    switch ( class )
    {
        case #"hash_690c0d6a821b42e":
        case #"hash_6191aaef9f922f96":
        case #"hash_8cdaf2e4ecfe5b51":
        case #"hash_900cb96c552c5e8e":
        case #"hash_fa24dff6bd60a12d":
            return true;
    }
    
    return false;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 3
// Checksum 0x0, Offset: 0x70e
// Size: 0xf9
function repeater_headshot_ammo_passive( objweapon, attacker, victim )
{
    if ( !isdefined( objweapon ) || !isdefined( attacker ) || !isdefined( victim ) )
    {
        return;
    }
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    base_name = objweapon.basename;
    
    if ( !isdefined( base_name ) || base_name != "iw7_repeater" )
    {
        return;
    }
    
    if ( !isdefined( victim.damagelocation ) )
    {
        return;
    }
    
    if ( victim.damagelocation != "head" && victim.damagelocation != "helmet" )
    {
        return;
    }
    
    maxclipammo = weaponclipsize( objweapon );
    refundcount = maxclipammo * 1;
    currammo = attacker getweaponammoclip( objweapon );
    newammo = min( currammo + refundcount, maxclipammo );
    attacker setweaponammoclip( objweapon, int( newammo ) );
}

// Namespace utility_common / scripts\anim\utility_common
// Params 1
// Checksum 0x0, Offset: 0x80f
// Size: 0xba, Type: bool
function needtoreload( thresholdfraction )
{
    if ( isnullweapon( self.weapon ) )
    {
        return false;
    }
    
    if ( istrue( self.disablereload ) )
    {
        if ( self.bulletsinclip < weaponclipsize( self.weapon ) * 0.5 )
        {
            self.bulletsinclip = int( weaponclipsize( self.weapon ) * 0.5 );
        }
        
        if ( self.bulletsinclip <= 0 )
        {
            self.bulletsinclip = 0;
        }
        
        return false;
    }
    
    if ( self.bulletsinclip <= weaponclipsize( self.weapon ) * thresholdfraction )
    {
        if ( thresholdfraction == 0 )
        {
            if ( cheatammoifnecessary() )
            {
                return false;
            }
        }
        
        return true;
    }
    
    return false;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0x8d2
// Size: 0x11d, Type: bool
function cheatammoifnecessary()
{
    assert( !self.bulletsinclip );
    
    if ( !isdefined( self.enemy ) )
    {
        return false;
    }
    
    if ( self.team != "allies" )
    {
        if ( !isplayer( self.enemy ) )
        {
            return false;
        }
    }
    
    if ( isusingsidearm() || usingrocketlauncher() )
    {
        return false;
    }
    
    if ( gettime() - self.ammocheattime < self.ammocheatinterval )
    {
        return false;
    }
    
    if ( !self cansee( self.enemy ) && distancesquared( self.origin, self.enemy.origin ) > 65536 )
    {
        return false;
    }
    
    self.bulletsinclip = int( weaponclipsize( self.weapon ) / 2 );
    
    if ( self.bulletsinclip > weaponclipsize( self.weapon ) )
    {
        self.bulletsinclip = weaponclipsize( self.weapon );
    }
    
    self.ammocheattime = gettime();
    return true;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0x9f8
// Size: 0x27, Type: bool
function isusingprimary()
{
    return self.weapon == self.primaryweapon && !isnullweapon( self.weapon );
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0xa28
// Size: 0x27, Type: bool
function isusingsecondary()
{
    return self.weapon == self.secondaryweapon && !isnullweapon( self.weapon );
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0xa58
// Size: 0x27, Type: bool
function isusingsidearm()
{
    return self.weapon == self.sidearm && !isnullweapon( self.weapon );
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0xa88
// Size: 0xb
function getclaimednode()
{
    return self.node;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 1
// Checksum 0x0, Offset: 0xa9c
// Size: 0x21
function shootenemywrapper( var_9bc9d0ee2a8a46f5 )
{
    if ( !isdefined( var_9bc9d0ee2a8a46f5 ) )
    {
        var_9bc9d0ee2a8a46f5 = 1;
    }
    
    [[ anim.shootenemywrapper_func ]]( var_9bc9d0ee2a8a46f5 );
}

// Namespace utility_common / scripts\anim\utility_common
// Params 1
// Checksum 0x0, Offset: 0xac5
// Size: 0x73
function getnodeyawtoorigin( pos )
{
    assert( !actor_is3d() );
    
    if ( isdefined( self.node ) )
    {
        yaw = self.node.angles[ 1 ] - getyaw( pos );
    }
    else
    {
        yaw = self.angles[ 1 ] - getyaw( pos );
    }
    
    yaw = angleclamp180( yaw );
    return yaw;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0xb41
// Size: 0xf1
function getnodeyawtoenemy()
{
    assert( !actor_is3d() );
    pos = undefined;
    
    if ( isdefined( self.enemy ) )
    {
        pos = self.enemy.origin;
    }
    else
    {
        if ( isdefined( self.node ) )
        {
            forward = anglestoforward( self.node.angles );
        }
        else
        {
            forward = anglestoforward( self.angles );
        }
        
        forward *= 150;
        pos = self.origin + forward;
    }
    
    if ( isdefined( self.node ) )
    {
        yaw = self.node.angles[ 1 ] - getyaw( pos );
    }
    else
    {
        yaw = self.angles[ 1 ] - getyaw( pos );
    }
    
    yaw = angleclamp180( yaw );
    return yaw;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0xc3b
// Size: 0x97
function getyawtoenemy()
{
    assert( !actor_is3d() );
    pos = undefined;
    
    if ( isdefined( self.enemy ) )
    {
        pos = self.enemy.origin;
    }
    else
    {
        forward = anglestoforward( self.angles );
        forward *= 150;
        pos = self.origin + forward;
    }
    
    yaw = self.angles[ 1 ] - getyaw( pos );
    yaw = angleclamp180( yaw );
    return yaw;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 1
// Checksum 0x0, Offset: 0xcdb
// Size: 0x52
function getyaw2d( org )
{
    assert( !actor_is3d() );
    angles = vectortoangles( ( org[ 0 ], org[ 1 ], 0 ) - ( self.origin[ 0 ], self.origin[ 1 ], 0 ) );
    return angles[ 1 ];
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0xd36
// Size: 0x6b
function absyawtoenemy()
{
    assert( !actor_is3d() );
    assert( isdefined( self.enemy ) );
    yaw = self.angles[ 1 ] - getyaw( self.enemy.origin );
    yaw = angleclamp180( yaw );
    
    if ( yaw < 0 )
    {
        yaw = -1 * yaw;
    }
    
    return yaw;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0xdaa
// Size: 0x6b
function absyawtoenemy2d()
{
    assert( !actor_is3d() );
    assert( isdefined( self.enemy ) );
    yaw = self.angles[ 1 ] - getyaw2d( self.enemy.origin );
    yaw = angleclamp180( yaw );
    
    if ( yaw < 0 )
    {
        yaw = -1 * yaw;
    }
    
    return yaw;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 1
// Checksum 0x0, Offset: 0xe1e
// Size: 0x4f
function absyawtoorigin( org )
{
    assert( !actor_is3d() );
    yaw = self.angles[ 1 ] - getyaw( org );
    yaw = angleclamp180( yaw );
    
    if ( yaw < 0 )
    {
        yaw = -1 * yaw;
    }
    
    return yaw;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 1
// Checksum 0x0, Offset: 0xe76
// Size: 0x49
function absyawtoangles( angles )
{
    assert( !actor_is3d() );
    yaw = self.angles[ 1 ] - angles;
    yaw = angleclamp180( yaw );
    
    if ( yaw < 0 )
    {
        yaw = -1 * yaw;
    }
    
    return yaw;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 2
// Checksum 0x0, Offset: 0xec8
// Size: 0x3a
function getyawfromorigin( org, start )
{
    assert( !actor_is3d() );
    angles = vectortoangles( org - start );
    return angles[ 1 ];
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0xf0b
// Size: 0x10
function getgrenademodel()
{
    return getweaponmodel( self.grenadeweapon );
}

// Namespace utility_common / scripts\anim\utility_common
// Params 1
// Checksum 0x0, Offset: 0xf24
// Size: 0xf4
function getenemyeyepos( enemy )
{
    if ( !isdefined( enemy ) )
    {
        enemy = self.enemy;
    }
    
    if ( isdefined( enemy ) )
    {
        self.a.lastenemypos = enemy getshootatpos();
        self.a.lastenemytime = gettime();
        return self.a.lastenemypos;
    }
    
    if ( isdefined( self.a.lastenemytime ) && isdefined( self.a.lastenemypos ) && self.a.lastenemytime + 3000 < gettime() )
    {
        return self.a.lastenemypos;
    }
    
    targetpos = self getshootatpos();
    targetpos += 196 * self.lookforward;
    return targetpos;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 1
// Checksum 0x0, Offset: 0x1020
// Size: 0xa6
function gettruenodeangles( node )
{
    if ( !isdefined( node ) )
    {
        return ( 0, 0, 0 );
    }
    
    if ( !isdefined( node.script_angles ) )
    {
        return node.angles;
    }
    
    var_f4b64b2e64700883 = node.angles;
    node_x = angleclamp180( var_f4b64b2e64700883[ 0 ] + node.script_angles[ 0 ] );
    node_y = var_f4b64b2e64700883[ 1 ];
    node_z = angleclamp180( var_f4b64b2e64700883[ 2 ] + node.script_angles[ 2 ] );
    return ( node_x, node_y, node_z );
}

// Namespace utility_common / scripts\anim\utility_common
// Params 1
// Checksum 0x0, Offset: 0x10cf
// Size: 0xc6
function getyawtoorigin( org )
{
    assert( !actor_is3d() );
    
    if ( isdefined( self.type ) && isnode3d( self ) )
    {
        node_angles = gettruenodeangles( self );
        forward = anglestoforward( node_angles );
        rotatedorg = rotatepointaroundvector( forward, org - self.origin, node_angles[ 2 ] * -1 );
        rotatedorg += self.origin;
        yaw = getyaw( rotatedorg ) - node_angles[ 1 ];
        yaw = angleclamp180( yaw );
        return yaw;
    }
    
    yaw = getyaw( org ) - self.angles[ 1 ];
    yaw = angleclamp180( yaw );
    return yaw;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 2
// Checksum 0x0, Offset: 0x119e
// Size: 0x61, Type: bool
function canseepointfromexposedatcorner( point, node )
{
    yaw = node getyawtoorigin( point );
    
    if ( yaw > 60 || yaw < -60 )
    {
        return false;
    }
    
    if ( isnodecoverleft( node ) && yaw < -14 )
    {
        return false;
    }
    
    if ( isnodecoverright( node ) && yaw > 12 )
    {
        return false;
    }
    
    return true;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 1
// Checksum 0x0, Offset: 0x1208
// Size: 0x2b9
function getnodeoffset( node )
{
    if ( isdefined( node.offset ) )
    {
        return node.offset;
    }
    
    cover_left_crouch_offset = ( -26, 0.4, 36 );
    cover_left_stand_offset = ( -32, 7, 63 );
    cover_right_crouch_offset = ( 43.5, 11, 36 );
    cover_right_stand_offset = ( 36, 8.3, 63 );
    cover_crouch_offset = ( 3.5, -12.5, 45 );
    cover_stand_offset = ( -3.7, -22, 63 );
    var_ed4a2a73f94d1ab5 = ( 0, 30, 13 );
    cornernode = 0;
    nodeoffset = ( 0, 0, 0 );
    axis = anglestoaxis( node.angles );
    right = axis[ "right" ];
    forward = axis[ "forward" ];
    up = axis[ "up" ];
    nodetype = node.type;
    
    switch ( nodetype )
    {
        case #"hash_e1d8e1adebed5a61":
            higheststance = node gethighestnodestance();
            
            if ( !isdefined( higheststance ) || higheststance == "crouch" )
            {
                nodeoffset = calculatenodeoffset( right, forward, up, cover_left_crouch_offset );
            }
            else
            {
                nodeoffset = calculatenodeoffset( right, forward, up, cover_left_stand_offset );
            }
            
            break;
        case #"hash_cd3ffe799551db82":
            higheststance = node gethighestnodestance();
            
            if ( !isdefined( higheststance ) || higheststance == "crouch" )
            {
                nodeoffset = calculatenodeoffset( right, forward, up, cover_right_crouch_offset );
            }
            else
            {
                nodeoffset = calculatenodeoffset( right, forward, up, cover_right_stand_offset );
            }
            
            break;
        case #"hash_410b602cd708b472":
        case #"hash_78b110033ccb68b0":
        case #"hash_805ed2ec27b468f7":
        case #"hash_bdacbb6eaaa538c7":
            nodeoffset = calculatenodeoffset( right, forward, up, cover_stand_offset );
            break;
        case #"hash_2c4ea8d9cb1d214":
        case #"hash_776752872754e5ee":
        case #"hash_c3b74422dec48736":
            nodeoffset = calculatenodeoffset( right, forward, up, cover_crouch_offset );
            break;
        case #"hash_b786e406d37a0dd7":
            nodeoffset = getcover3dnodeoffset( node );
            break;
        case #"hash_c051a32186a33cae":
            nodeoffset = calculatenodeoffset( right, forward, up, var_ed4a2a73f94d1ab5 );
            break;
    }
    
    node.offset = nodeoffset;
    return node.offset;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 2
// Checksum 0x0, Offset: 0x14ca
// Size: 0x11a
function getcover3dnodeoffset( node, leandir )
{
    assert( isdefined( node ) && node.type == "Cover 3D" );
    var_d9091e7beb7128e8 = ( 2, -10, 35 );
    var_6314194b648994a8 = ( -19, -10, 32 );
    var_4ca040109b9f8c1d = ( 16, -10, 32 );
    right = anglestoright( node.angles );
    forward = anglestoforward( node.angles );
    up = anglestoup( node.angles );
    offset = var_d9091e7beb7128e8;
    
    if ( isdefined( leandir ) )
    {
        if ( leandir == "left" )
        {
            offset = var_6314194b648994a8;
        }
        else if ( leandir == "right" )
        {
            offset = var_4ca040109b9f8c1d;
        }
        else
        {
            assertmsg( "unreachable" );
        }
    }
    
    return calculatenodeoffset( right, forward, up, offset );
}

// Namespace utility_common / scripts\anim\utility_common
// Params 4
// Checksum 0x0, Offset: 0x15ed
// Size: 0x36
function calculatenodeoffset( right, forward, up, baseoffset )
{
    return right * baseoffset[ 0 ] + forward * baseoffset[ 1 ] + up * baseoffset[ 2 ];
}

/#

    // Namespace utility_common / scripts\anim\utility_common
    // Params 2
    // Checksum 0x0, Offset: 0x162c
    // Size: 0x4c, Type: dev
    function persistentdebugline( start, end )
    {
        self endon( "<dev string:x1c>" );
        level notify( "<dev string:x22>" );
        level endon( "<dev string:x22>" );
        
        for ( ;; )
        {
            line( start, end, ( 0.3, 1, 0 ), 1 );
            wait 0.05;
        }
    }

#/

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0x1680
// Size: 0x113
function canseeenemyfromexposed()
{
    now = gettime();
    node = self.node;
    enemy = self.enemy;
    rechecktime = !isdefined( self.canseeenemyfromexposednext ) || now >= self.canseeenemyfromexposednext;
    
    if ( rechecktime || !is_equal( self.canseeenemyfromexposedenemy, enemy ) || !is_equal( self.canseeenemyfromexposednode, node ) )
    {
        self.canseeenemyfromexposed = canseeenemyfromexposedatnode( enemy, node );
        self.canseeenemyfromexposednext = now + 1000;
        self.canseeenemyfromexposednode = node;
        self.canseeenemyfromexposedenemy = enemy;
    }
    
    result = self.canseeenemyfromexposed;
    
    if ( !result )
    {
        /#
            if ( self getentitynumber() == getdvarint( @"hash_c407a6f2012f4956" ) )
            {
                thread persistentdebugline( node.origin + getnodeoffset( node ), getenemyeyepos() );
            }
        #/
    }
    
    return result;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 2
// Checksum 0x0, Offset: 0x179c
// Size: 0xac
function canseeenemyfromexposedatnode( enemy, node )
{
    if ( !isdefined( enemy ) )
    {
        return 0;
    }
    
    if ( !isdefined( node ) )
    {
        result = self cansee( enemy );
    }
    else
    {
        enemyeye = undefined;
        
        if ( isscriptedai( enemy ) )
        {
            enemyeye = enemy getapproxeyepos();
        }
        else
        {
            enemyeye = getenemyeyepos( enemy );
        }
        
        if ( actor_is3d() && isnode3d( node ) )
        {
            result = function_a76836ca0f1172ab( enemy, enemyeye, node );
            
            if ( !result )
            {
                enemyeye = ( enemy.origin + enemyeye ) / 2;
                result = function_a76836ca0f1172ab( enemy, enemyeye, node );
            }
        }
        else
        {
            result = function_a76836ca0f1172ab( enemy, enemyeye, node );
        }
    }
    
    return result;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 3
// Checksum 0x0, Offset: 0x1851
// Size: 0xb4
function function_a76836ca0f1172ab( enemy, point, node )
{
    if ( isnodecoverleft( node ) || isnodecoverright( node ) )
    {
        if ( !canseepointfromexposedatcorner( point, node ) )
        {
            return 0;
        }
    }
    
    nodeoffset = getnodeoffset( node );
    lookfrompoint = node.origin + nodeoffset;
    
    if ( !checkpitchvisibility( lookfrompoint, point, node ) )
    {
        return 0;
    }
    
    if ( !sighttracepassed( lookfrompoint, point, 0, enemy ) )
    {
        if ( isnodecovercrouch( node ) )
        {
            lookfrompoint = ( 0, 0, 64 ) + node.origin;
            return sighttracepassed( lookfrompoint, point, 0, enemy );
        }
        
        return 0;
    }
    
    return 1;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 3
// Checksum 0x0, Offset: 0x190e
// Size: 0xf7, Type: bool
function checkpitchvisibility( frompoint, topoint, atnode )
{
    minpitch = self.upaimlimit - anim.aimpitchdifftolerance;
    maxpitch = self.downaimlimit + anim.aimpitchdifftolerance;
    directionvec = topoint - frompoint;
    
    if ( actor_is3d() )
    {
        if ( isdefined( atnode ) && isnode3d( atnode ) )
        {
            angles = atnode.angles;
        }
        else
        {
            angles = self.angles;
        }
        
        directionvec = rotatevectorinverted( directionvec, angles );
    }
    
    pitch = angleclamp180( vectortopitch( directionvec ) );
    
    if ( pitch < minpitch )
    {
        return false;
    }
    
    if ( pitch > maxpitch )
    {
        if ( isdefined( atnode ) && !isnodecovercrouch( atnode ) )
        {
            return false;
        }
        
        if ( pitch > anim.covercrouchleanpitch + maxpitch )
        {
            return false;
        }
    }
    
    return true;
}

/#

    // Namespace utility_common / scripts\anim\utility_common
    // Params 0
    // Checksum 0x0, Offset: 0x1a0e
    // Size: 0x10, Type: dev
    function dontgiveuponsuppressionyet()
    {
        assertmsg( "obsolete function. do not use. keeping around for script compile backward compatibility." );
    }

#/

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0x1a26
// Size: 0x9c
function cansuppressenemy()
{
    if ( !hassuppressableenemy() || self.doingambush )
    {
        self.goodshootpos = undefined;
        return 0;
    }
    
    suppressiondisabled = istrue( self.disablesuppressingfire );
    
    if ( !isplayer( self.enemy ) )
    {
        if ( !suppressiondisabled || self.forcesuppressai )
        {
            return aisuppressai();
        }
    }
    
    if ( suppressiondisabled )
    {
        return 0;
    }
    
    if ( !checkpitchvisibility( self geteye(), self.lastenemysightpos ) )
    {
        return 0;
    }
    
    startoffset = self getapproxeyepos();
    return findgoodsuppressspot( startoffset );
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0x1acb
// Size: 0x47, Type: bool
function hassuppressableenemy()
{
    if ( !isdefined( self.enemy ) )
    {
        return false;
    }
    
    if ( !isdefined( self.lastenemysightpos ) )
    {
        return false;
    }
    
    if ( !self iscurrentenemyvalid() )
    {
        return false;
    }
    
    if ( !isdefined( self.goodshootpos ) && !needrecalculatesuppressspot() )
    {
        return false;
    }
    
    return true;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0x1b1b
// Size: 0xbe, Type: bool
function aisuppressai()
{
    if ( !self canattackenemynode() && !istrue( self.forcesuppressai ) )
    {
        return false;
    }
    
    shootpos = undefined;
    
    if ( isdefined( self.enemy.covernode ) )
    {
        nodeoffset = getnodeoffset( self.enemy.covernode );
        shootpos = self.enemy.covernode.origin + nodeoffset;
    }
    else
    {
        shootpos = self.enemy getshootatpos();
    }
    
    if ( !self canshoot( shootpos ) && !istrue( self.forcesuppressai ) )
    {
        return false;
    }
    
    self.goodshootpos = shootpos;
    return true;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 1
// Checksum 0x0, Offset: 0x1be2
// Size: 0x73
function canseeandshootpoint( point )
{
    if ( isdefined( self.a.weaponpos ) && isundefinedweapon( self.a.weaponpos[ "right" ] ) )
    {
        return 0;
    }
    
    if ( !sighttracepassed( self getshootatpos(), point, 0, undefined ) )
    {
        return 0;
    }
    
    gunpoint = self getapproxeyepos();
    return sighttracepassed( gunpoint, point, 0, undefined );
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0x1c5e
// Size: 0x6e, Type: bool
function needrecalculatesuppressspot()
{
    if ( isdefined( self.goodshootpos ) && !canseeandshootpoint( self.goodshootpos ) )
    {
        return true;
    }
    
    return !isdefined( self.lastenemysightposold ) || distancesquared( self.lastenemysightposold, self.lastenemysightpos ) > 256 || distancesquared( self.lastenemysightposselforigin, self.origin ) > 1024;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 1
// Checksum 0x0, Offset: 0x1cd5
// Size: 0x152, Type: bool
function findgoodsuppressspot( startoffset )
{
    var_bc4d272afc4e79e6 = min( self.enemy.maxvisibledist, 1024 );
    
    if ( isdefined( self.enemy ) && distancesquared( self.origin, self.enemy.origin ) > squared( var_bc4d272afc4e79e6 + 768 ) )
    {
        self.goodshootpos = undefined;
        return false;
    }
    
    if ( needrecalculatesuppressspot() )
    {
        self.lastenemysightposselforigin = self.origin;
        self.lastenemysightposold = self.lastenemysightpos;
        
        if ( istrue( self.suppress_uselastenemysightpos ) )
        {
            self.goodshootpos = self.lastenemysightpos;
            return true;
        }
        
        currentenemypos = getenemyeyepos();
        self.goodshootpos = self aicalcsuppressspot( startoffset, currentenemypos, self.suppress_numgoodtracesneeded );
        return isdefined( self.goodshootpos );
    }
    else if ( isdefined( self.goodshootpos ) && isdefined( self.pathgoalpos ) && distancesquared( self.origin, self.goodshootpos ) < 1024 )
    {
        self.goodshootpos = undefined;
    }
    
    return isdefined( self.goodshootpos );
}

// Namespace utility_common / scripts\anim\utility_common
// Params 1
// Checksum 0x0, Offset: 0x1e30
// Size: 0x69, Type: bool
function canseeenemy( cacheduration )
{
    if ( !isdefined( self.enemy ) )
    {
        return false;
    }
    
    if ( isdefined( cacheduration ) && self cansee( self.enemy, cacheduration ) || self cansee( self.enemy ) )
    {
        if ( !checkpitchvisibility( self geteye(), self.enemy getshootatpos() ) )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 1
// Checksum 0x0, Offset: 0x1ea2
// Size: 0x36, Type: bool
function recentlysawenemy( time )
{
    if ( !isdefined( time ) )
    {
        time = 5;
    }
    
    return isdefined( self.enemy ) && self seerecently( self.enemy, time );
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0x1ee1
// Size: 0x2f
function issuppressedwrapper()
{
    if ( self.forcesuppression )
    {
        return 1;
    }
    
    if ( self.suppressionmeter <= self.suppressionthreshold )
    {
        return 0;
    }
    
    return self issuppressed();
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0x1f19
// Size: 0xd8, Type: bool
function enemyishiding()
{
    if ( !isdefined( self.enemy ) )
    {
        return false;
    }
    
    if ( self.enemy isflashed() )
    {
        return true;
    }
    
    if ( isplayer( self.enemy ) )
    {
        if ( isdefined( self.enemy.health ) && self.enemy.health < self.enemy.maxhealth )
        {
            return true;
        }
    }
    else if ( isai( self.enemy ) && self.enemy issuppressedwrapper() )
    {
        return true;
    }
    
    if ( isdefined( self.enemy.isreloading ) && self.enemy.isreloading )
    {
        return true;
    }
    
    return false;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 0
// Checksum 0x0, Offset: 0x1ffa
// Size: 0x25, Type: bool
function shouldshootenemyent()
{
    assert( isdefined( self ) );
    
    if ( !canseeenemy() )
    {
        return false;
    }
    
    if ( !self canshootenemy() )
    {
        return false;
    }
    
    return true;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 1
// Checksum 0x0, Offset: 0x2028
// Size: 0xcd
function sortandcullanimstructarray( animstructarray )
{
    newanimstructarray = [];
    
    foreach ( animstruct in animstructarray )
    {
        if ( animstruct.weight <= 0 )
        {
            continue;
        }
        
        for ( i = 0; i < newanimstructarray.size ; i++ )
        {
            if ( animstruct.weight < newanimstructarray[ i ].weight )
            {
                for ( j = newanimstructarray.size; j > i ; j-- )
                {
                    newanimstructarray[ j ] = newanimstructarray[ j - 1 ];
                }
                
                break;
            }
        }
        
        newanimstructarray[ i ] = animstruct;
    }
    
    return newanimstructarray;
}

// Namespace utility_common / scripts\anim\utility_common
// Params 3
// Checksum 0x0, Offset: 0x20fe
// Size: 0x180
function player_can_see_ai( player, ai, latency )
{
    currenttime = gettime();
    
    if ( !isdefined( latency ) )
    {
        latency = 0;
    }
    
    if ( isdefined( ai.playerseesmetime ) && ai.playerseesmetime + latency >= currenttime )
    {
        assert( isdefined( ai.playerseesme ) );
        return ai.playerseesme;
    }
    
    ai.playerseesmetime = currenttime;
    
    if ( !within_fov( player.origin, player.angles, ai.origin, 0.766 ) )
    {
        ai.playerseesme = 0;
        return 0;
    }
    
    playereye = player geteye();
    feetorigin = ai.origin;
    
    if ( sighttracepassed( playereye, feetorigin, 1, player, ai ) )
    {
        ai.playerseesme = 1;
        return 1;
    }
    
    eyeorigin = ai getapproxeyepos();
    
    if ( sighttracepassed( playereye, eyeorigin, 1, player, ai ) )
    {
        ai.playerseesme = 1;
        return 1;
    }
    
    midorigin = ( eyeorigin + feetorigin ) * 0.5;
    
    if ( sighttracepassed( playereye, midorigin, 1, player, ai ) )
    {
        ai.playerseesme = 1;
        return 1;
    }
    
    ai.playerseesme = 0;
    return 0;
}

