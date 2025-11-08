#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\math;
#using scripts\engine\utility;

#namespace namespace_9e85c6b7b4fb5ff9;

// Namespace namespace_9e85c6b7b4fb5ff9 / namespace_421fb1e92658d94c
// Params 0
// Checksum 0x0, Offset: 0x179
// Size: 0x2d5
function function_c31b39e6bb1bcd42()
{
    self endon( "death" );
    self.ridingplayers = [];
    self.entstouching = [];
    prevonground = !self vehicle_isphysveh() || self vehicle_isonground();
    
    while ( true )
    {
        validridingplayers = [];
        
        foreach ( player in utility::playersnear( self.origin, 550 ) )
        {
            if ( isdefined( player ) && player _isalive() && isdefined( player.guid ) && !player isvehicleactive() && isdefined( player getmovingplatformparent() ) && player getmovingplatformparent() == self )
            {
                validridingplayers[ player.guid ] = 1;
                
                if ( !isdefined( self.ridingplayers[ player.guid ] ) )
                {
                    self.ridingplayers[ player.guid ] = player;
                    function_153a6accf001dff6( player );
                }
                
                isininterior = function_3d25af3a88ad31c3( player );
                
                if ( !istrue( player.var_54a215ef59a7a0c3 ) && isininterior )
                {
                    function_3ffe455e5ea6d0f5( player );
                }
                else if ( istrue( player.var_54a215ef59a7a0c3 ) && !isininterior )
                {
                    function_b2cc563ed7324a8d( player );
                }
                
                player.var_54a215ef59a7a0c3 = isininterior;
            }
        }
        
        foreach ( guid, player in self.ridingplayers )
        {
            if ( !istrue( validridingplayers[ guid ] ) )
            {
                self.ridingplayers[ guid ] = undefined;
                function_71adb8f84c3df6bb( player );
                
                if ( istrue( player.var_54a215ef59a7a0c3 ) )
                {
                    function_b2cc563ed7324a8d( player );
                }
                
                if ( isdefined( player ) )
                {
                    player.var_54a215ef59a7a0c3 = undefined;
                }
            }
        }
        
        onground = function_3a5fc0673be748ae();
        
        if ( onground != prevonground )
        {
            if ( !onground )
            {
                foreach ( player in self.ridingplayers )
                {
                    player vehicle_occupancy_startmovefeedbackforplayer();
                }
            }
            else
            {
                foreach ( player in self.ridingplayers )
                {
                    player vehicle_occupancy_stopmovefeedbackforplayer();
                }
            }
        }
        
        prevonground = onground;
        wait 0.25;
    }
}

// Namespace namespace_9e85c6b7b4fb5ff9 / namespace_421fb1e92658d94c
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x456
// Size: 0x13, Type: bool
function private function_3a5fc0673be748ae()
{
    return !self vehicle_isphysveh() || self vehicle_isonground();
}

// Namespace namespace_9e85c6b7b4fb5ff9 / namespace_421fb1e92658d94c
// Params 1
// Checksum 0x0, Offset: 0x472
// Size: 0x121
function function_153a6accf001dff6( player )
{
    if ( !function_3a5fc0673be748ae() )
    {
        player vehicle_occupancy_startmovefeedbackforplayer();
    }
    
    if ( isdefined( self.onstartriding ) )
    {
        self [[ self.onstartriding ]]( player );
    }
    
    if ( !istrue( self.var_9bd69326cfeb9fe9 ) )
    {
        scripts\cp_mp\utility\vehicle_omnvar_utility::function_d2d9c09551d91164( self, player );
    }
    
    if ( !isdefined( level.var_b531611b8d662db7 ) )
    {
        level.var_b531611b8d662db7 = getdvarint( @"hash_dee18061c0d4dfe", ter_op( scripts\cp_mp\utility\game_utility::isbrstylegametype(), 0, 1 ) ) == 1;
    }
    
    if ( !level.var_b531611b8d662db7 )
    {
        return;
    }
    
    vehicleteam = vehicle_occupancy_getteamfriendlyto( self );
    
    if ( isdefined( vehicleteam ) && isdefined( player.team ) && vehicleteam != "neutral" && vehicleteam != player.team && issharedfuncdefined( "game", "onEnterOOBTrigger" ) )
    {
        player.var_1f34845fdd0a6631 = 1;
        self [[ getsharedfunc( "game", "onEnterOOBTrigger" ) ]]( self, player );
    }
    else
    {
        player.var_1f34845fdd0a6631 = undefined;
    }
    
    vehicle_spawn_stopwatchingabandoned();
}

// Namespace namespace_9e85c6b7b4fb5ff9 / namespace_421fb1e92658d94c
// Params 1
// Checksum 0x0, Offset: 0x59b
// Size: 0xad
function function_71adb8f84c3df6bb( player )
{
    if ( isdefined( player ) )
    {
        player vehicle_occupancy_stopmovefeedbackforplayer();
        
        if ( !isdefined( player.vehicle ) )
        {
            scripts\cp_mp\utility\vehicle_omnvar_utility::function_5211953231a09ed5( self, player );
        }
        
        if ( isdefined( self.onendriding ) )
        {
            self [[ self.onendriding ]]( player );
        }
        
        if ( istrue( player.var_1f34845fdd0a6631 ) && isdefined( player.oob ) && player.oob > 0 && issharedfuncdefined( "game", "onExitOOBTrigger" ) )
        {
            self [[ getsharedfunc( "game", "onExitOOBTrigger" ) ]]( self, player );
        }
    }
    
    thread vehicle_spawn_watchabandoned();
}

// Namespace namespace_9e85c6b7b4fb5ff9 / namespace_421fb1e92658d94c
// Params 1
// Checksum 0x0, Offset: 0x650
// Size: 0x29
function function_3ffe455e5ea6d0f5( player )
{
    player setclienttriggeraudiozonepartial( "iw9_palfa_interior", "reverb", "weapon_reflection" );
    player notify( "entered_vehicle_interior" );
}

// Namespace namespace_9e85c6b7b4fb5ff9 / namespace_421fb1e92658d94c
// Params 1
// Checksum 0x0, Offset: 0x681
// Size: 0x24
function function_b2cc563ed7324a8d( player )
{
    if ( isdefined( player ) )
    {
        player clearclienttriggeraudiozone( 0.5 );
        player notify( "exited_vehicle_interior" );
    }
}

// Namespace namespace_9e85c6b7b4fb5ff9 / namespace_421fb1e92658d94c
// Params 1
// Checksum 0x0, Offset: 0x6ad
// Size: 0x52
function function_3d25af3a88ad31c3( player )
{
    if ( !isdefined( self ) || !isalive( self ) || !isdefined( self.origin ) || !isdefined( player ) || !isdefined( player.origin ) )
    {
        return 0;
    }
    
    return function_773691f1a617f7d9( player.origin );
}

// Namespace namespace_9e85c6b7b4fb5ff9 / namespace_421fb1e92658d94c
// Params 1
// Checksum 0x0, Offset: 0x708
// Size: 0xec, Type: bool
function function_773691f1a617f7d9( origin )
{
    forward = anglestoforward( self.angles );
    up = anglestoup( self.angles );
    toorigin = origin - self.origin;
    transform = coordtransformtranspose( origin, self.origin, self.angles );
    forwarddist = transform[ 0 ];
    sidedist = transform[ 1 ];
    verticaldist = transform[ 2 ];
    withinforward = forwarddist > -225 && forwarddist < 225;
    withinside = sidedist > -60 && sidedist < 60;
    withinvertical = verticaldist > -235 && verticaldist < -115;
    return withinforward && withinside && withinvertical;
}

