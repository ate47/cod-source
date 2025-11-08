#using script_3b78d23dad7ec5be;
#using script_60cc31ea91d0ad55;
#using script_7edf952f8921aa6b;
#using scripts\aitypes\zombie_abom\zombie_abom_audio;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\engine\math;
#using scripts\engine\utility;

#namespace namespace_36031e382978bc8d;

// Namespace namespace_36031e382978bc8d / namespace_23e577195401fd11
// Params 0
// Checksum 0x0, Offset: 0x213
// Size: 0x5d
function function_304c63cbb536c526()
{
    function_406984e213848212( "move", &function_eee30195769f679e, &function_3efc6f398dd71d26 );
    function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "walk" ) );
    function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "run" ) );
    function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "sprint" ) );
}

// Namespace namespace_36031e382978bc8d / namespace_23e577195401fd11
// Params 0
// Checksum 0x0, Offset: 0x278
// Size: 0x62
function function_e666bc1f7f826ea2()
{
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &function_36985b9cd291d92 );
    callback::get_template( self.animsetname ) callback::add( "head_destroyed", &function_fd1cffcbaac9dd4f );
    callback::get_template( self.animsetname ) callback::add( "zombie_melee", &function_385b704af023d89a );
}

// Namespace namespace_36031e382978bc8d / namespace_23e577195401fd11
// Params 0
// Checksum 0x0, Offset: 0x2e2
// Size: 0x53
function function_ac7db7e26eb6926c()
{
    init_move();
    self.var_f93d9d0a2d07bf11 = 100;
    self.turnrate = 0.1;
    self.var_8f499cbc08e88e90 = getdvarint( @"hash_d6e3599499e45349", 1 );
    thread wander_listener();
    thread function_3cb62239fb4bdf95();
    thread function_25ddc7410cd116ca();
}

// Namespace namespace_36031e382978bc8d / namespace_23e577195401fd11
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x33d
// Size: 0x5d
function private function_36985b9cd291d92( params )
{
    anim_alias = function_8626c13b5be18c1b( "move" );
    
    if ( self._blackboard.movetype == "sprint" )
    {
        self.turnrate = 0.2;
        return;
    }
    
    self.turnrate = 0.1;
}

// Namespace namespace_36031e382978bc8d / namespace_23e577195401fd11
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3a2
// Size: 0x2a
function private function_8776345ecd2673e5( move_type )
{
    struct = spawnstruct();
    struct.move_type = move_type;
    return struct;
}

// Namespace namespace_36031e382978bc8d / namespace_23e577195401fd11
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3d5
// Size: 0x5f
function private function_eee30195769f679e( struct )
{
    alias = "";
    
    if ( isdefined( struct.move_type ) )
    {
        alias += struct.move_type;
        
        if ( self._blackboard.movetype != struct.move_type )
        {
            return undefined;
        }
    }
    
    return alias;
}

// Namespace namespace_36031e382978bc8d / namespace_23e577195401fd11
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x43d
// Size: 0x44
function private function_3efc6f398dd71d26( alias )
{
    self function_164c05dd1bcfbca7( "move", alias );
    
    if ( asm_currentstatehasflag( self.asmname, "move" ) )
    {
        asm_fireevent_internal( self.asmname, "loop_reroll_anim" );
    }
}

// Namespace namespace_36031e382978bc8d / namespace_23e577195401fd11
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x489
// Size: 0x87
function private wander_listener()
{
    var_db4c957c16fc7ad1 = 1;
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "wander_start" );
        function_f1e5805da192a1ef( "walk", "wander", 22 );
        self.turnrate *= var_db4c957c16fc7ad1;
        thread function_ff4bd4c9a8c14004();
        self waittill( "wander_end" );
        function_f1e5805da192a1ef( undefined, "wander" );
        self.turnrate /= var_db4c957c16fc7ad1;
        self notify( "ambientvox_shutdown" );
    }
}

// Namespace namespace_36031e382978bc8d / namespace_23e577195401fd11
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x518
// Size: 0x5d
function private function_fd1cffcbaac9dd4f( params )
{
    if ( params.heads_remaining.size == 1 && istrue( self.zombieaisettings.var_e58a65b7a8f5973c.var_668afeb0154eeeb5 ) )
    {
        function_f1e5805da192a1ef( "sprint", "abom_rage_mode", 30 );
        return;
    }
    
    thread function_138dc2e6ae3e968b();
}

// Namespace namespace_36031e382978bc8d / namespace_23e577195401fd11
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x57d
// Size: 0x104
function private function_138dc2e6ae3e968b()
{
    self endon( "death" );
    self notify( "enter_rage_mode" );
    self endon( "enter_rage_mode" );
    function_f1e5805da192a1ef( "sprint", "abom_rage_mode", 30 );
    round_number = function_2201d3f3d7ab07a7();
    var_7b2050dc73de2280 = clamp( math::remap( round_number, 20, 50, 0, 20 ), 0, 20 );
    rage_time = 10 + var_7b2050dc73de2280;
    var_76ef1958db146de = gettime() + rage_time * 1000;
    var_45b42d8d38a439e1 = function_7df646d888a5ca2d();
    var_fa6a5e0ea277e5a6 = 0;
    
    while ( gettime() < var_76ef1958db146de && var_fa6a5e0ea277e5a6 < var_45b42d8d38a439e1 )
    {
        var_5d5e22fbeb751015 = ( var_76ef1958db146de - gettime() ) / 1000;
        
        if ( var_5d5e22fbeb751015 <= 0 )
        {
            break;
        }
        
        wait_result = waittill_any_timeout_1( rage_time, "melee_hit_ent" );
        
        if ( wait_result == "melee_hit_ent" )
        {
            var_fa6a5e0ea277e5a6 += 1;
        }
    }
    
    function_f1e5805da192a1ef( undefined, "abom_rage_mode", 30 );
}

// Namespace namespace_36031e382978bc8d / namespace_23e577195401fd11
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x689
// Size: 0xe6
function private function_7df646d888a5ca2d()
{
    target_range = 1000;
    var_6a56ad71356b457c = 4;
    target_query = physics_querypoint( self.origin, target_range, physics_createcontents( [ "physicscontents_characterproxy" ] ), [ self ], "physicsquery_all" );
    target_list = [];
    
    foreach ( target in target_query )
    {
        target_ent = target[ "entity" ];
        
        if ( isalive( target_ent ) && target_ent.team != self.team )
        {
            target_list = array_add( target_list, target_ent );
        }
    }
    
    return clamp( target_list.size, 1, var_6a56ad71356b457c );
}

// Namespace namespace_36031e382978bc8d / namespace_23e577195401fd11
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x778
// Size: 0x22
function private function_385b704af023d89a( params )
{
    if ( isdefined( params.meleehitent ) )
    {
        self notify( "melee_hit_ent" );
    }
}

// Namespace namespace_36031e382978bc8d / namespace_23e577195401fd11
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x7a2
// Size: 0x6f
function private function_3cb62239fb4bdf95()
{
    self endon( "death" );
    var_342eb5fe1a97cdab = self.zombieaisettings.var_e58a65b7a8f5973c.var_e6d515ce731e9948;
    
    if ( !isdefined( var_342eb5fe1a97cdab ) || var_342eb5fe1a97cdab <= 0 )
    {
        return;
    }
    
    while ( true )
    {
        msg = scripts\engine\utility::waittill_notify_or_timeout_return( "melee_hit_ent", var_342eb5fe1a97cdab );
        
        if ( msg != "melee_hit_ent" )
        {
            function_138dc2e6ae3e968b();
        }
    }
}

// Namespace namespace_36031e382978bc8d / namespace_23e577195401fd11
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x819
// Size: 0x26d
function private function_25ddc7410cd116ca()
{
    self endon( "death" );
    speedthresholds = self.zombieaisettings.speedthreshold_list;
    knockdowndatas = self.zombieaisettings.var_e58a65b7a8f5973c.knockdowndata_list;
    
    if ( speedthresholds.size == 0 || knockdowndatas.size == 0 )
    {
        return;
    }
    
    minmovespeed = speedthresholds[ 0 ].speedthreshold;
    
    for ( i = 1; i < speedthresholds.size ; i++ )
    {
        minmovespeed = min( minmovespeed, speedthresholds[ i ].speedthreshold );
    }
    
    minmovespeedsqr = squared( minmovespeed * 0.75 );
    
    while ( isdefined( self ) )
    {
        knockdowndata = knockdowndatas[ 0 ];
        
        foreach ( entry in knockdowndatas )
        {
            if ( entry.movetype == self._blackboard.movetype )
            {
                knockdowndata = entry;
                break;
            }
        }
        
        velocity = self.velocity;
        speedsqr = lengthsquared( velocity );
        
        if ( speedsqr > minmovespeedsqr )
        {
            knockdown_pos = self.origin;
            
            if ( knockdowndata.velocityoffset > 0 )
            {
                vel_norm = vectornormalize( velocity );
                knockdown_pos += vel_norm * knockdowndata.velocityoffset;
            }
            
            /#
            #/
            
            potential_targets = getaiarrayinradius( knockdown_pos, knockdowndata.radius );
            
            foreach ( target in potential_targets )
            {
                if ( isalive( target ) && target != self && ( !isdefined( target.aicategory ) || target.aicategory == "normal" ) && !target function_e67a89537ae7d4b7() )
                {
                    target knockdown_ai( knockdown_pos );
                }
            }
        }
        
        wait knockdowndata.interval;
    }
}

