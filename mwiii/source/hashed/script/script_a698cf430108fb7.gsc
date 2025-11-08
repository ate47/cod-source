#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment\temp_v;
#using scripts\mp\hud_message;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;

#namespace namespace_ba300dc864b9baf9;

// Namespace namespace_ba300dc864b9baf9 / namespace_9f9a23de1f1dc7ff
// Params 0
// Checksum 0x0, Offset: 0x291
// Size: 0x154, Type: bool
function function_cfb677b5f7d5e644()
{
    if ( !isalive( self ) || self isparachuting() || self isskydiving() || self isonladder() || self isonascender() || self isinexecutionattack() || self isinexecutionvictim() )
    {
        return false;
    }
    
    if ( istrue( self.inlaststand ) || isdefined( self.usingremote ) || istrue( self.isdeploying ) || istrue( self.usingascender ) || scripts\cp_mp\utility\player_utility::function_b7869f6d9d4242e3( self ) || istrue( self.isjuggernaut ) || istrue( self.var_859654e0445a36d9 ) )
    {
        return false;
    }
    
    if ( isdefined( self.vehicle ) )
    {
        return false;
    }
    
    thread scripts\mp\hud_message::showsplash( "super_teleport_deploy" + "_activate", undefined, self, undefined, undefined, undefined, 1 );
    self setclientomnvar( "ui_field_upgrade_use", 0 );
    giveperk( "specialty_third_person" );
    function_6caa4b447cb1ee5c( 1 );
    self.plotarmor = 1;
    thread function_49e5c6a221425b7();
    delaythread( getdvarfloat( @"hash_96dbd55b49ef1c2b", 0.1 ), &function_456da1486741f194, 1 );
    delaythread( getdvarfloat( @"hash_81dbead1ca86d536", 0.2 ), &function_e2b829448c14c0f4, 1 );
    thread function_4b2fa585273dbb8c();
    return true;
}

// Namespace namespace_ba300dc864b9baf9 / namespace_9f9a23de1f1dc7ff
// Params 1
// Checksum 0x0, Offset: 0x3ee
// Size: 0x38
function function_e2b829448c14c0f4( shouldhide )
{
    if ( shouldhide )
    {
        function_a593971d75d82113();
        function_379bb555405c16bb( "temp_v_teleport_superpower::superTeleport_hide()" );
        return;
    }
    
    function_6fb380927695ee76();
    function_985b0973f29da4f8( "temp_v_teleport_superpower::superTeleport_hide()" );
}

// Namespace namespace_ba300dc864b9baf9 / namespace_9f9a23de1f1dc7ff
// Params 1
// Checksum 0x0, Offset: 0x42e
// Size: 0xa4
function function_6caa4b447cb1ee5c( isteleporting )
{
    if ( isteleporting )
    {
        blockedvalues = [ "ads", "weapon_switch", "weapon_pickup", "weapon_switch_clip", "reload", "allow_jump", "usability", "vehicle_use", "execution_attack", "execution_victim" ];
        scripts\mp\utility\player::_freezecontrols( 1 );
        scripts\common\values::set_array( "teleport_superpower", blockedvalues, 0 );
        return;
    }
    
    scripts\mp\utility\player::_freezecontrols( 0 );
    scripts\common\values::reset_all( "teleport_superpower" );
}

// Namespace namespace_ba300dc864b9baf9 / namespace_9f9a23de1f1dc7ff
// Params 0
// Checksum 0x0, Offset: 0x4da
// Size: 0x9d
function function_4b2fa585273dbb8c()
{
    var_3f1786887462af7d = getdvarfloat( @"hash_62c67df9c015a11b", 1 );
    wait var_3f1786887462af7d;
    fadetoblackforplayer( self, 1, 0.25 );
    removeperk( "specialty_third_person" );
    self setorigin( function_3754ea1a27eecdd8() );
    self skydive_beginfreefall();
    delaythread( 0.15, &function_e2b829448c14c0f4, 0 );
    delaythread( 0.2, &function_456da1486741f194, 0 );
    self.plotarmor = undefined;
    function_6caa4b447cb1ee5c( 0 );
    fadetoblackforplayer( self, 0, 0.25 );
    scripts\mp\equipment\temp_v::function_269b97f3d86eb172();
}

// Namespace namespace_ba300dc864b9baf9 / namespace_9f9a23de1f1dc7ff
// Params 0
// Checksum 0x0, Offset: 0x57f
// Size: 0x175
function function_3754ea1a27eecdd8()
{
    initialstart = self.origin + ( 0, 0, getdvarint( @"hash_6607bd90c44f0838", 5000 ) );
    caststart = initialstart;
    cachedposition = self.origin;
    safeheight = 1000;
    mapcenter = level.mapcenter;
    var_b8726efb17f1fe54 = 0;
    
    while ( true )
    {
        if ( var_b8726efb17f1fe54 > 20 )
        {
            position = cachedposition;
            break;
        }
        
        castend = caststart + ( 0, 0, -2000 );
        trace = scripts\engine\trace::ray_trace( caststart, castend, self, scripts\engine\trace::create_default_contents( 1 ) );
        positionsafe = 0;
        position = caststart;
        dist = distance( caststart, trace[ "position" ] );
        
        if ( dist >= 1000 )
        {
            positionsafe = 1;
        }
        
        if ( canspawn( position ) )
        {
            if ( positionsafe )
            {
                break;
            }
            else
            {
                cachedposition = position;
            }
        }
        
        dir = flatten_vector( vectornormalize( mapcenter - caststart ) );
        caststart += dir * randomintrange( 250, 1000 );
        
        if ( !positionsafe )
        {
            caststart = ( caststart.x, caststart.y, initialstart.z );
            caststart += ( 0, 0, safeheight - dist );
        }
        
        waitframe();
    }
    
    return position;
}

// Namespace namespace_ba300dc864b9baf9 / namespace_9f9a23de1f1dc7ff
// Params 1
// Checksum 0x0, Offset: 0x6fd
// Size: 0x3e
function function_456da1486741f194( isout )
{
    if ( isout )
    {
        playfx( scripts\engine\utility::getfx( "superPower_teleportOut" ), self.origin );
        return;
    }
    
    self setscriptablepartstate( "superpowers", "teleportIn", 0 );
}

// Namespace namespace_ba300dc864b9baf9 / namespace_9f9a23de1f1dc7ff
// Params 0
// Checksum 0x0, Offset: 0x743
// Size: 0x64
function function_49e5c6a221425b7()
{
    self setscriptablepartstate( "superpowers", "teleportOut", 0 );
    soundorigin = self.origin + ( 0, 0, 15 );
    soundent = spawn( "script_origin", soundorigin );
    soundent playsound( "br_the_boys_teleport_out_npc", self, soundent );
    wait 2;
    soundent delete();
}

