#using script_23ead74859674f83;
#using script_4e0a3b3f9bedd99d;
#using scripts\aitypes\bt_util;
#using scripts\anim\shared;
#using scripts\anim\utility_common;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\mp_agent;

#namespace rusher_agent;

// Namespace rusher_agent / namespace_c77c96f1aa8fcce1
// Params 0
// Checksum 0x0, Offset: 0x1ab
// Size: 0x2
function function_5171170ac608ca01()
{
    
}

// Namespace rusher_agent / namespace_c77c96f1aa8fcce1
// Params 1
// Checksum 0x0, Offset: 0x1b5
// Size: 0x1a0
function initrusher( taskid )
{
    setupagent();
    self.var_d41ed96694c55d83 = 1;
    self.var_1858803ea66e73e0 = 1;
    healthmodifier = getdvarint( @"hash_4db8eab33e045701", 0 );
    
    if ( healthmodifier != 0 )
    {
        self.health += healthmodifier;
        self.maxhealth = self.health;
    }
    
    if ( self isscriptable() )
    {
        thread initscriptable();
    }
    
    self.smokefx = loadfx( "vfx/iw9/level/mp_sealion/vfx_ninja_smoke_bomb_iw9" );
    self function_4924f775ed21316();
    groundpos = getgroundposition( self.origin, 32 );
    
    if ( getdvarint( @"hash_98874c4025ebe46d", 1 ) == 1 && distancesquared( self.origin, groundpos ) < 400 )
    {
        namespace_abe23f4a1f05240f::function_ca247899dbbcf9a4( self.origin );
        namespace_abe23f4a1f05240f::function_d93415244e99e763( self.origin, self.angles, getdvarint( @"hash_37448409e13a1af7", 1 ) == 1, 1 );
        self setgoalpos( self.origin, 32 );
    }
    
    self.pathenemyfightdist = 0;
    self.allowstrafe = 0;
    self setengagementmaxdist( 0.1, 768 );
    self enableavoidance( 1 );
    self.cornercheckenabled = 0;
    self.var_855f7991983b1210 = 1;
    self function_8bbcaeb23a1512ef( "all", 0, "bt" );
    self.var_4c2e21367dbf09d0 = &function_5213d881f2e26966;
    return anim.success;
}

// Namespace rusher_agent / namespace_c77c96f1aa8fcce1
// Params 0
// Checksum 0x0, Offset: 0x35e
// Size: 0x14
function initscriptable()
{
    self setscriptablepartstate( "notetrack_handler", "active", 0 );
}

// Namespace rusher_agent / namespace_c77c96f1aa8fcce1
// Params 0
// Checksum 0x0, Offset: 0x37a
// Size: 0x28f
function setupagent()
{
    self.var_896173c5036728f9 = 1;
    self.ignoreme = 0;
    self.aistate = "idle";
    self.var_6e8bc2a1f79b2398 = "walk";
    self.sharpturnnotifydist = 100;
    self.radius = 15;
    self.height = 40;
    self.damagedradiussq = 2250000;
    self.ignoreclosefoliage = 1;
    self.guid = self getentitynumber();
    self.var_8d31c7eacb516468 = 1;
    self.var_da951e8204605e7 = 1;
    self.var_d2d25942e3b908e9 = 1;
    self.var_5b1209ecd2c2de2 = 1;
    self.var_16734f091bfebaa1 = 0;
    self.var_a045430175c98788 = 0;
    self.allowcrouch = 1;
    self.var_7c0157ec8b265f6e = 40;
    self.var_fa4cf34a0c3681b8 = 70;
    self.meleeradius = self.var_fa4cf34a0c3681b8;
    self.var_a9bbce143412f034 = 80;
    self.var_f5bd7eeb8c658300 = squared( self.var_fa4cf34a0c3681b8 );
    self.meleeradiussq = squared( self.meleeradius );
    self.meleechargedistvsplayer = 125;
    self.meleechargedist = 125;
    self.meleebashmaxdistsq = 8100;
    self.var_8f438ea9e6ae83a2 = 12100;
    self.var_70dd5ab41a229510 = 1;
    self.defaultgoalradius = self.radius + 1;
    self.died_poorly = 0;
    self.damaged_by_player = 0;
    self.full_gib = 0;
    self.var_805f8a6da772965 = [];
    self.highlyawareradius = 200;
    self.var_dc7052bbfe5c799 = 1;
    self.spawned_timestamp = gettime();
    self.lasthittime = [];
    self setcanusecover( 0, "entity" );
    self.teamflashbangimmunity = 1;
    rad = 15;
    
    if ( isdefined( level.var_3dfcdea6efb8a124 ) )
    {
        rad = level.var_3dfcdea6efb8a124;
    }
    
    self setavoidanceradius( rad );
    
    if ( !isdefined( self.a ) )
    {
        self.a = spawnstruct();
    }
    
    self.a.disablepain = getdvarint( @"hash_38c150c4acc3342a", 0 ) == 1;
    self.lastweapon = self.weapon;
    self.deathfunction = &rusher_ondeath;
    thread function_4222d0ecf1d363ba();
    thread function_3a6c3f63da7103bf();
}

// Namespace rusher_agent / namespace_c77c96f1aa8fcce1
// Params 0
// Checksum 0x0, Offset: 0x611
// Size: 0x2d
function function_3a6c3f63da7103bf()
{
    self endon( "death" );
    level waittill( "game_ended" );
    self clearpath();
    self asmsetstate( self.asmname, "exposed_idle" );
}

// Namespace rusher_agent / namespace_c77c96f1aa8fcce1
// Params 0
// Checksum 0x0, Offset: 0x646
// Size: 0xbe
function function_4222d0ecf1d363ba()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_206fd4337ea8ed6f = 0;
    
    while ( true )
    {
        if ( length( self getvelocity() ) == 0 && self.aistate == "move" )
        {
            var_206fd4337ea8ed6f += 0.05;
        }
        else
        {
            var_206fd4337ea8ed6f = 0;
        }
        
        if ( var_206fd4337ea8ed6f > 2 )
        {
            negotiation_node = self getnegotiationstartnode();
            
            if ( isdefined( negotiation_node ) )
            {
                dist_sq = distancesquared( self.origin, negotiation_node.origin );
                
                if ( dist_sq < squared( 15 ) )
                {
                    self setorigin( negotiation_node.origin, 0 );
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace rusher_agent / namespace_c77c96f1aa8fcce1
// Params 1
// Checksum 0x0, Offset: 0x70c
// Size: 0x2b
function checkscripted( taskid )
{
    if ( !istrue( self.scripted_mode ) )
    {
        return anim.failure;
    }
    
    return anim.running;
}

// Namespace rusher_agent / namespace_c77c96f1aa8fcce1
// Params 1
// Checksum 0x0, Offset: 0x740
// Size: 0x11c
function function_16cf274ffc86e1e2( distenemysq )
{
    if ( 1 || !isplayer( self.enemy ) )
    {
        return;
    }
    
    time = gettime();
    
    if ( !isdefined( self.enemy.var_5a6732eff9bd04b7 ) )
    {
        self.enemy.var_5a6732eff9bd04b7 = time;
    }
    else if ( time < self.enemy.var_5a6732eff9bd04b7 )
    {
        return;
    }
    
    dirtoplayer = self.enemy.origin - self.origin;
    enemyfacing = anglestoforward( self.enemy.angles );
    dot = vectordot( dirtoplayer, enemyfacing );
    
    if ( dot > 0 && distenemysq < 250000 )
    {
        self.enemy.var_5a6732eff9bd04b7 = time + randomintrange( 3000, 5000 );
        self.enemy playlocalsound( "zmb_player_impact_hit" );
    }
}

// Namespace rusher_agent / namespace_c77c96f1aa8fcce1
// Params 2
// Checksum 0x0, Offset: 0x864
// Size: 0x6b
function function_5213d881f2e26966( defpos, defradius )
{
    if ( !isdefined( defradius ) )
    {
        defradius = 1000;
    }
    
    defpos = getclosestpointonnavmesh( defpos, self );
    
    if ( !isdefined( defpos ) )
    {
        return;
    }
    
    self.var_cb36cb356b9d9ad3 = defpos;
    self.var_aac0f7cd82056fd1 = defradius;
    self.var_cd9d7559236c5c9f = 0.25 * defradius;
    self.var_4114a481c65fd24c = 0.8 * defradius;
    self.rusherdefending = 1;
}

// Namespace rusher_agent / namespace_c77c96f1aa8fcce1
// Params 0
// Checksum 0x0, Offset: 0x8d7
// Size: 0xc
function stopdefending()
{
    self.rusherdefending = 0;
}

// Namespace rusher_agent / namespace_c77c96f1aa8fcce1
// Params 0
// Checksum 0x0, Offset: 0x8eb
// Size: 0x21, Type: bool
function rusher_ondeath()
{
    bexplosivedamage = utility::wasdamagedbyexplosive();
    
    if ( istrue( bexplosivedamage ) )
    {
        self function_36c9cc1aacacc4a8();
    }
    
    return false;
}

// Namespace rusher_agent / namespace_c77c96f1aa8fcce1
// Params 2
// Checksum 0x0, Offset: 0x915
// Size: 0xe4
function droppostoground( position, drop_distance )
{
    radius = 15;
    height = 45;
    
    if ( isdefined( self.radius ) )
    {
        radius = self.radius;
    }
    
    if ( isdefined( self.height ) )
    {
        height = self.height;
    }
    
    if ( !isdefined( drop_distance ) )
    {
        drop_distance = 18;
    }
    
    startpos = position + ( 0, 0, drop_distance );
    endpos = position + ( 0, 0, drop_distance * -1 );
    droppedpos = self aiphysicstrace( startpos, endpos, self.radius, self.height, 1 );
    
    if ( abs( droppedpos[ 2 ] - startpos[ 2 ] ) < 0.1 )
    {
        return undefined;
    }
    
    if ( abs( droppedpos[ 2 ] - endpos[ 2 ] ) < 0.1 )
    {
        return undefined;
    }
    
    return droppedpos;
}

