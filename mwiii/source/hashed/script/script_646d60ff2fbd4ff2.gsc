#using scripts\cp_mp\utility\weapon_utility;
#using scripts\mp\gametypes\dmz_ai_chopper;

#namespace namespace_43fa28e17601014d;

// Namespace namespace_43fa28e17601014d / namespace_fd5db9939c683aa4
// Params 1
// Checksum 0x0, Offset: 0x1be
// Size: 0xd4
function function_6aa2e7131056a6a2( pos )
{
    chopper = scripts\mp\gametypes\dmz_ai_chopper::function_4c4df9aeb773709a( pos, "veh9_mil_air_heli_medium", "veh9_mil_air_heli_medium_weapons", level.var_d44040648e9624f, "dmz_patrol_heli" );
    chopper.attackfunc = &function_2da0e1059066956f;
    chopper.funcs[ "strafe" ] = &function_f1400b978167ad73;
    chopper.missileweapon = makeweapon( "chopper_gunner_proj_dmz" );
    turretr = chopper function_5ba2582ce376900c( "tag_rocket_right" );
    turretl = chopper function_5ba2582ce376900c( "tag_rocket_left" );
    chopper.turrets = [ turretr, turretl ];
    chopper.missilecount = 5;
    chopper.var_abeda157c03de022 = 40;
    return chopper;
}

// Namespace namespace_43fa28e17601014d / namespace_fd5db9939c683aa4
// Params 1
// Checksum 0x0, Offset: 0x29b
// Size: 0xe3
function function_5ba2582ce376900c( tag )
{
    turret = spawnturret( "misc_turret", self gettagorigin( tag ), "chopper_support_turret_mp" );
    turret setmodel( "veh9_mil_air_heli_hind_turret_mp" );
    turret.owner = self.owner;
    turret.team = self.team;
    turret.angles = self.angles + ( 90, 0, 0 );
    turret.originalangles = turret.angles;
    turret.disabled = 0;
    turret.targetstate = undefined;
    turret linkto( self, tag );
    turret setturretteam( self.team );
    turret setturretmodechangewait( 0 );
    turret setmode( "manual" );
    return turret;
}

// Namespace namespace_43fa28e17601014d / namespace_fd5db9939c683aa4
// Params 1
// Checksum 0x0, Offset: 0x387
// Size: 0xaa
function function_2da0e1059066956f( target )
{
    self endon( "death" );
    self endon( "crashing" );
    self endon( "state_change" );
    var_40130bd790669c04 = target.origin;
    
    while ( true )
    {
        self setlookatent( target );
        
        if ( !scripts\mp\gametypes\dmz_ai_chopper::function_9f656e924a854c1b( target, 5000, 8, randomint( 360 ), 1000 ) )
        {
            scripts\mp\gametypes\dmz_ai_chopper::function_3be784d69cc30a0( target, -500 );
            scripts\mp\gametypes\dmz_ai_chopper::function_7743aeff79a08975( "idle" );
        }
        
        if ( distance2dsquared( var_40130bd790669c04, target.origin ) > 100000000 )
        {
            scripts\mp\gametypes\dmz_ai_chopper::function_3be784d69cc30a0( target, -800 );
            scripts\mp\gametypes\dmz_ai_chopper::function_7743aeff79a08975( "idle" );
            return;
        }
    }
}

// Namespace namespace_43fa28e17601014d / namespace_fd5db9939c683aa4
// Params 1
// Checksum 0x0, Offset: 0x439
// Size: 0x9a
function function_f1400b978167ad73( target )
{
    wait 1;
    
    for ( i = 0; i < self.var_abeda157c03de022 ; i++ )
    {
        self.turrets[ i % 2 ].angles = self.turrets[ i % 2 ].originalangles + ( randomint( 10 ) - 5, randomint( 10 ) - 5, randomint( 10 ) - 5 );
        self.turrets[ i % 2 ] shootturret();
        wait 0.02;
    }
}

// Namespace namespace_43fa28e17601014d / namespace_fd5db9939c683aa4
// Params 1
// Checksum 0x0, Offset: 0x4db
// Size: 0xc7
function function_eb5fec1420a757c2( target )
{
    missiletags = [ "tag_rocket_right", "tag_rocket_left" ];
    wait 1;
    
    for ( i = 0; i < self.missilecount ; i++ )
    {
        missilestart = self gettagorigin( missiletags[ i % 2 ] ) + anglestoforward( self.angles ) * 200;
        missileend = self gettagorigin( missiletags[ i % 2 ] ) + anglestoforward( self.angles ) * 1000;
        missile = scripts\cp_mp\utility\weapon_utility::_magicbullet( self.missileweapon, missilestart, missileend, self.owner );
        wait 0.3;
    }
}

