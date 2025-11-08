#using scripts\asm\asm;
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\engine\math;
#using scripts\engine\utility;

#namespace namespace_ce6c437f7a6dedb6;

// Namespace namespace_ce6c437f7a6dedb6 / namespace_e8d5850900a5d8dc
// Params 0
// Checksum 0x0, Offset: 0x129
// Size: 0x7a
function function_306feec3952fc2ef()
{
    assert( isdefined( self.grenadeweapon ), "<dev string:x1c>" );
    
    if ( isplayer( self.var_c24f43a7d0d8d195 ) )
    {
        if ( self.var_c24f43a7d0d8d195 function_4c108309dc0d7fd2() > self._blackboard.var_4a850e88a81da5f9 )
        {
            self._blackboard.zombieunreachableisattacking = 0;
            return;
        }
    }
    
    function_ac90fa5cc0a80298( "ranged_attack_in" );
    thread function_198bfdd7fc72700a();
}

// Namespace namespace_ce6c437f7a6dedb6 / namespace_e8d5850900a5d8dc
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1ab
// Size: 0x162
function private function_198bfdd7fc72700a()
{
    self endon( "death" );
    self notify( "terminate_ranged_attack" );
    self endon( "terminate_ranged_attack" );
    thread function_c2de30ecd5f08178();
    self waittill( "gutgrab" );
    assertex( istrue( self._blackboard.var_285a93cddadff26a ), "<dev string:x48>" );
    self.var_35bcbbe0ba774121 = ter_op( self._blackboard.var_d15d23565f5a60a1 == 0, "tag_accessory_left", "tag_accessory_right" );
    
    if ( isdefined( self.zombieaisettings.var_e2b91916dda5f27f ) && self.zombieaisettings.var_e2b91916dda5f27f.size > 0 )
    {
        self.projectile_model = random( self.zombieaisettings.var_e2b91916dda5f27f ).modelname;
        self attach( self.projectile_model, self.var_35bcbbe0ba774121 );
    }
    
    self waittill( "gutgo" );
    target = self.var_c24f43a7d0d8d195;
    projectile_velocity = self function_66847aa1462af647( isent( target ) ? target : undefined, 1, self._blackboard.var_d15d23565f5a60a1 );
    projectile_velocity = default_to( projectile_velocity, self._blackboard.var_acff9536dc447bac );
    function_7ed594e1ada9063e( projectile_velocity );
}

// Namespace namespace_ce6c437f7a6dedb6 / namespace_e8d5850900a5d8dc
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x315
// Size: 0xbf
function private function_7ed594e1ada9063e( projectile_velocity )
{
    projectile_timeout = 8;
    projectile_model = self.projectile_model;
    
    if ( isdefined( self.projectile_model ) )
    {
        self detach( self.projectile_model, self.var_35bcbbe0ba774121 );
        self.projectile_model = undefined;
    }
    
    if ( !isdefined( projectile_velocity ) )
    {
        return;
    }
    
    start_pos = self gettagorigin( self.var_35bcbbe0ba774121 );
    grenade = magicgrenademanual( self.grenadeweapon, start_pos, projectile_velocity, projectile_timeout, self );
    grenade.angles = self gettagangles( self.var_35bcbbe0ba774121 );
    
    if ( isdefined( projectile_model ) )
    {
        grenade setmodel( projectile_model );
    }
}

// Namespace namespace_ce6c437f7a6dedb6 / namespace_e8d5850900a5d8dc
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3dc
// Size: 0x9a
function private function_c2de30ecd5f08178()
{
    ranged_target = self.var_c24f43a7d0d8d195;
    
    if ( isplayer( ranged_target ) )
    {
        ranged_target function_e89f2bdb307f137e();
    }
    
    waittill_any_2( "terminate_ranged_attack", "death" );
    
    if ( isdefined( self ) )
    {
        if ( isdefined( self.projectile_model ) )
        {
            self detach( self.projectile_model, self.var_35bcbbe0ba774121 );
        }
        else if ( !isalive( self ) )
        {
            self detachall();
        }
        
        self.projectile_model = undefined;
        self.var_35bcbbe0ba774121 = undefined;
    }
    
    if ( isplayer( ranged_target ) )
    {
        ranged_target function_a33073d6fd58e58e();
    }
}

