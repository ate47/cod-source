#using scripts\common\ai_formation;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_753b428633ceb556;

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 0
// Checksum 0x0, Offset: 0x1e4
// Size: 0x19
function init()
{
    if ( !isdefined( level.var_865c7977a3a308a ) )
    {
        level.var_865c7977a3a308a = [];
    }
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 2
// Checksum 0x0, Offset: 0x205
// Size: 0x99
function function_5921dc142b08795b( patrolname, formationtype )
{
    if ( !isdefined( level.var_865c7977a3a308a ) )
    {
        init();
    }
    
    if ( isdefined( level.var_865c7977a3a308a[ patrolname ] ) )
    {
        return level.var_865c7977a3a308a[ patrolname ];
    }
    
    assertex( formationtype >= 0 && formationtype < 4, "Invalid formation type of " + formationtype );
    level.var_865c7977a3a308a[ patrolname ] = spawnstruct();
    level.var_865c7977a3a308a[ patrolname ].array = [];
    ai_formation::function_a18d80bcfacb9e00( patrolname, formationtype );
    return level.var_865c7977a3a308a[ patrolname ];
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 1
// Checksum 0x0, Offset: 0x2a7
// Size: 0x60
function delete_patrol( patrolname )
{
    if ( !isdefined( level.var_865c7977a3a308a[ patrolname ] ) )
    {
        return;
    }
    
    notifyname = function_8e9e859313e267e2( patrolname );
    level notify( notifyname );
    ai_formation::leave_formation( level.var_865c7977a3a308a[ patrolname ].array );
    ai_formation::delete_formation( patrolname );
    level.var_865c7977a3a308a[ patrolname ] = undefined;
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 3
// Checksum 0x0, Offset: 0x30f
// Size: 0xc6
function function_b41baf16d62d21d8( patrolname, aitoadd, formationtype )
{
    if ( !isdefined( formationtype ) )
    {
        formationtype = 3;
    }
    
    if ( !isdefined( level.var_865c7977a3a308a ) )
    {
        init();
    }
    
    if ( !isdefined( level.var_865c7977a3a308a[ patrolname ] ) )
    {
        function_5921dc142b08795b( patrolname, formationtype );
    }
    
    if ( isarray( aitoadd ) )
    {
        foreach ( ai in aitoadd )
        {
            function_801b4f42c4aec0ff( patrolname, ai, formationtype );
            ai thread function_585606ec5af81775( patrolname );
        }
        
        return;
    }
    
    function_801b4f42c4aec0ff( patrolname, aitoadd, formationtype );
    aitoadd thread function_585606ec5af81775( patrolname );
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3dd
// Size: 0x8d
function private function_ef66f73bdae69270( formationtype )
{
    grouppatrolname = self.grouppatrolname;
    thread function_ca2000d72aa808e8();
    waittill_any_3( "enemy", "leave_group_patrol", "death" );
    
    if ( isdefined( self ) )
    {
        interactionid = self getinteractionid();
        
        if ( isdefined( interactionid ) )
        {
            despawninteraction( interactionid );
        }
        
        leave_patrol( grouppatrolname, self );
        
        if ( isalive( self ) )
        {
            self enableavoidance( 1 );
            self.patroltarget = undefined;
            thread function_84cd8295dbc3496d( formationtype );
        }
    }
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x472
// Size: 0x61
function private function_ca2000d72aa808e8()
{
    self endon( "death" );
    self endon( "enemy" );
    level endon( "game_ended" );
    
    while ( true )
    {
        if ( self choreographer_iscontrolled() )
        {
            break;
        }
        
        if ( isdefined( self.stealth ) && isdefined( self.fnisinstealthidle ) && ![[ self.fnisinstealthidle ]]() )
        {
            break;
        }
        
        waitframe();
    }
    
    self notify( "leave_group_patrol" );
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4db
// Size: 0x65
function private function_84cd8295dbc3496d( formationtype )
{
    self endon( "death" );
    
    while ( true )
    {
        if ( !self choreographer_iscontrolled() && isdefined( self.stealth ) && isdefined( self.fnisinstealthidle ) && [[ self.fnisinstealthidle ]]() )
        {
            break;
        }
        
        waitframe();
    }
    
    function_b41baf16d62d21d8( self.grouppatrolname, self, formationtype );
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x548
// Size: 0x12
function private function_8e9e859313e267e2( patrolname )
{
    return patrolname + "_kill_update";
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x563
// Size: 0xacc
function private function_585606ec5af81775( patrolname )
{
    self endon( "death" );
    self endon( "enemy" );
    self endon( "leave_group_patrol" );
    self endon( "following_entity" );
    level endon( "game_ended" );
    wait 0.5;
    var_bfc2d8f5ab869cac = 200;
    goal_timeout = 5;
    goal_radius = 42;
    self.dont_enter_combat = 1;
    self notify( "stop_going_to_node" );
    waitframe();
    self.dont_enter_combat = undefined;
    self clearbtgoal( 1 );
    self clearbtgoal( 3 );
    self.goalradius = goal_radius;
    self function_b9ac4405e32e38b7( 1 );
    setaiformationtargetradius( level.formationlist[ patrolname ], self aigetdesiredspeed() );
    
    if ( level.var_865c7977a3a308a[ patrolname ].array.size == 1 )
    {
        if ( isdefined( self.spawnpoint.target ) )
        {
            self.patroltarget = scripts\engine\utility::getstruct( self.spawnpoint.target, "targetname" );
            level.var_865c7977a3a308a[ patrolname ].groupleadertarget = self.patroltarget;
            self.currentnode = self.patroltarget;
        }
        else
        {
            while ( !isdefined( level.var_865c7977a3a308a[ patrolname ].groupleadertarget ) )
            {
                waitframe();
            }
        }
    }
    else
    {
        self setgoalpos( self.origin, goal_radius );
        
        if ( isdefined( self.spawnpoint.target ) )
        {
            leader = function_7a82c6e82e83e7d2( patrolname );
            
            if ( !isdefined( leader.patroltarget ) )
            {
                leadertarget = level.var_865c7977a3a308a[ patrolname ].groupleadertarget;
            }
            else
            {
                leadertarget = leader.patroltarget;
            }
            
            if ( isdefined( leadertarget ) )
            {
                nexttarget = scripts\engine\utility::getstruct( self.spawnpoint.target, "targetname" );
                self.patroltarget = nexttarget;
                bestdist = distance( self.patroltarget.origin, leadertarget.origin );
                visited = [ nexttarget ];
                
                while ( true )
                {
                    nexttarget = scripts\engine\utility::getstruct( nexttarget.target, "targetname" );
                    
                    if ( !isdefined( nexttarget ) || array_contains( visited, nexttarget ) )
                    {
                        break;
                    }
                    
                    nextdist = distance( nexttarget.origin, leadertarget.origin );
                    
                    if ( nextdist < bestdist )
                    {
                        self.patroltarget = nexttarget;
                        bestdist = nextdist;
                    }
                    
                    visited[ visited.size ] = nexttarget;
                }
                
                if ( distancesquared( leader.origin, leadertarget.origin ) < var_bfc2d8f5ab869cac )
                {
                    self setgoalpos( self.patroltarget.origin, goal_radius );
                    self.patroltarget = scripts\engine\utility::getstruct( self.patroltarget.target, "targetname" );
                    leader waittill( "group_patrol_node_wait_ended" );
                }
            }
            else
            {
                if ( !isdefined( self.patroltarget ) )
                {
                    self.patroltarget = scripts\engine\utility::getstruct( self.spawnpoint.target, "targetname" );
                }
                
                level.var_865c7977a3a308a[ patrolname ].groupleadertarget = self.patroltarget;
                function_cc7045b3f96482ce();
            }
            
            self.currentnode = self.patroltarget;
        }
        else
        {
            while ( !isdefined( level.var_865c7977a3a308a[ patrolname ].groupleadertarget ) )
            {
                waitframe();
            }
        }
    }
    
    interactionid = self getinteractionid();
    
    if ( isdefined( interactionid ) )
    {
        despawninteraction( interactionid );
    }
    
    while ( true )
    {
        leader = function_7a82c6e82e83e7d2( patrolname );
        self function_b9ac4405e32e38b7( 1 );
        
        if ( self != leader && isdefined( self.patroltarget ) && self.patroltarget == level.var_865c7977a3a308a[ patrolname ].groupleadertarget )
        {
            function_cc7045b3f96482ce();
            leader = self;
        }
        
        if ( self == leader )
        {
            targetpos = isdefined( self.patroltarget ) ? self.patroltarget.origin : level.var_865c7977a3a308a[ patrolname ].groupleadertarget.origin;
            ai_formation::set_goal( patrolname, targetpos );
            wait 0.1;
            var_55576d80f4e2554d = level.var_865c7977a3a308a[ patrolname ].var_55576d80f4e2554d;
            
            if ( isdefined( var_55576d80f4e2554d ) && var_55576d80f4e2554d != 2 )
            {
                var_75c3b1807b9d4e6 = level.var_865c7977a3a308a[ patrolname ].var_75c3b1807b9d4e6;
                horizontalseparation = level.var_865c7977a3a308a[ patrolname ].horizontalseparation;
                verticalseparation = level.var_865c7977a3a308a[ patrolname ].verticalseparation;
                leaderinfront = level.var_865c7977a3a308a[ patrolname ].leaderinfront;
                
                if ( canaiformationfitdownpath( level.formationlist[ patrolname ], self.origin, level.var_865c7977a3a308a[ patrolname ].desiredformationwidth, leaderinfront ) )
                {
                    if ( var_75c3b1807b9d4e6 != var_55576d80f4e2554d )
                    {
                        function_e1f50b1f60aa1b25( patrolname, var_55576d80f4e2554d, horizontalseparation, verticalseparation, leaderinfront );
                    }
                }
                else if ( var_75c3b1807b9d4e6 == var_55576d80f4e2554d )
                {
                    function_e1f50b1f60aa1b25( patrolname, 2, horizontalseparation, verticalseparation, leaderinfront );
                }
            }
        }
        
        while ( true )
        {
            if ( !isdefined( leader ) )
            {
                leader = function_7a82c6e82e83e7d2( patrolname );
                patrolgoal = undefined;
            }
            
            if ( !isdefined( patrolgoal ) )
            {
                if ( isdefined( leader.patroltarget ) )
                {
                    patrolgoal = leader.patroltarget.origin;
                }
                else if ( isdefined( level.var_865c7977a3a308a[ patrolname ].groupleadertarget ) )
                {
                    patrolgoal = level.var_865c7977a3a308a[ patrolname ].groupleadertarget.origin;
                }
            }
            
            if ( isdefined( patrolgoal ) && distance( leader.origin, patrolgoal ) < var_bfc2d8f5ab869cac )
            {
                patrolgoal = undefined;
                break;
            }
            
            waitframe();
        }
        
        if ( isdefined( self.patroltarget ) )
        {
            leader = function_7a82c6e82e83e7d2( patrolname );
            
            if ( self != leader )
            {
                self function_b9ac4405e32e38b7( 0 );
            }
            
            self clearbtgoal( 1 );
            self clearbtgoal( 3 );
            self setgoalpos( self.patroltarget.origin, goal_radius );
            self.goalradius = goal_radius;
        }
        else if ( self == leader )
        {
            self clearbtgoal( 1 );
            self clearbtgoal( 3 );
            self setgoalpos( level.var_865c7977a3a308a[ patrolname ].groupleadertarget.origin, goal_radius );
            self.goalradius = goal_radius;
        }
        
        leader = function_7a82c6e82e83e7d2( patrolname );
        
        if ( function_8b93290be06b5b7f( leader.patroltarget ) )
        {
            self notify( "stop_going_to_node" );
            array_wait( level.var_865c7977a3a308a[ patrolname ].array, "goal", goal_timeout );
        }
        else
        {
            self waittill( "goal" );
        }
        
        interactionai = [];
        node = self.patroltarget;
        var_10c8a4eb616b52f1 = 0;
        
        if ( isdefined( node ) )
        {
            leader = function_7a82c6e82e83e7d2( patrolname );
            
            if ( self != leader )
            {
                self function_b9ac4405e32e38b7( 0 );
                wait randomfloatrange( 0.5, 1 );
            }
            
            if ( isdefined( node.interaction ) )
            {
                interactionid = self getinteractionid();
                ainode = self._blackboard.idlenode;
                
                if ( isdefined( interactionid ) )
                {
                    if ( node == ainode && isdefined( node.interactionid ) && node.interactionid == interactionid )
                    {
                        self enableavoidance( 0 );
                        interactionai[ interactionai.size ] = self;
                        var_10c8a4eb616b52f1 = 1;
                    }
                    else
                    {
                        despawninteraction( interactionid );
                        
                        if ( isdefined( ainode ) )
                        {
                            ainode.interactionid = undefined;
                        }
                    }
                }
                
                if ( !var_10c8a4eb616b52f1 )
                {
                    if ( isdefined( node.interactionid ) )
                    {
                        despawninteraction( node.interactionid );
                        node.interactionid = undefined;
                    }
                    
                    self._blackboard.idlenode = node;
                    angles = node.angles;
                    
                    if ( !isdefined( angles ) )
                    {
                        angles = ( 0, 0, 0 );
                    }
                    
                    interactiontoks = strtok( node.interaction, "+" );
                    interaction = random( interactiontoks );
                    node.interactionid = spawninteraction( interaction, node.origin, angles );
                    self function_76b3cfb91ef40b3b( node.interactionid );
                    self enableavoidance( 0 );
                    interactionai[ interactionai.size ] = self;
                }
            }
        }
        
        childthread function_6d2707dbb5228999( node, leader );
        
        if ( function_8b93290be06b5b7f( leader.patroltarget ) )
        {
            array_wait( level.var_865c7977a3a308a[ patrolname ].array, "group_patrol_node_wait_ended" );
            
            if ( self != leader )
            {
                wait randomfloatrange( 0.5, 1 );
            }
        }
        
        self enableavoidance( 1 );
        self._blackboard.idlenode = node;
        node = self.patroltarget;
        
        if ( isdefined( node ) && isdefined( node.interactionid ) )
        {
            despawninteraction( node.interactionid );
            node.interactionid = undefined;
        }
        
        if ( isdefined( self.patroltarget ) )
        {
            self.patroltarget = scripts\engine\utility::getstruct( self.patroltarget.target, "targetname" );
            self.currentnode = self.patroltarget;
            self clearbtgoal( 1 );
        }
        
        leader = function_7a82c6e82e83e7d2( patrolname );
        
        if ( self == leader && isdefined( level.var_865c7977a3a308a[ patrolname ].groupleadertarget ) )
        {
            level.var_865c7977a3a308a[ patrolname ].groupleadertarget = scripts\engine\utility::getstruct( level.var_865c7977a3a308a[ patrolname ].groupleadertarget.target, "targetname" );
        }
    }
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 1
// Checksum 0x0, Offset: 0x1037
// Size: 0x37, Type: bool
function function_8b93290be06b5b7f( node )
{
    if ( !isdefined( node ) )
    {
        return false;
    }
    
    if ( isdefined( node.interactionid ) )
    {
        return true;
    }
    
    if ( isdefined( node.interaction ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 1
// Checksum 0x0, Offset: 0x1077
// Size: 0x73
function function_7a82c6e82e83e7d2( patrolname )
{
    assertex( isdefined( level.var_865c7977a3a308a[ patrolname ] ), "Patrol was not found" );
    leader = ai_formation::get_leader( patrolname );
    
    if ( !isdefined( leader ) && level.var_865c7977a3a308a[ patrolname ].array.size > 0 )
    {
        leader = level.var_865c7977a3a308a[ patrolname ].array[ 0 ];
    }
    
    return leader;
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x10f3
// Size: 0x134
function private function_6d2707dbb5228999( node, leader )
{
    interactionid = self getinteractionid();
    
    if ( isdefined( interactionid ) )
    {
        msg = waittill_any_return_2( "bseq_user_deleted", "cap_exit_completed" );
        
        if ( msg == "bseq_user_deleted" )
        {
            self waittill( "cap_exit_completed" );
        }
    }
    else if ( !function_8b93290be06b5b7f( node ) )
    {
        if ( !isdefined( node ) )
        {
            if ( isdefined( leader.patroltarget ) )
            {
                node = leader.patroltarget;
            }
            else
            {
                node = level.var_865c7977a3a308a[ self.grouppatrolname ].groupleadertarget;
            }
        }
        
        if ( !isdefined( node.script_delay ) && function_8b93290be06b5b7f( leader.patroltarget ) )
        {
            wait 0.5;
            self notify( "group_patrol_node_wait_ended" );
            return;
        }
        
        node script_delay();
    }
    
    if ( isdefined( node.script_flag_wait ) )
    {
        flag_wait( node.script_flag_wait );
    }
    
    if ( isdefined( node.script_ent_flag_wait ) )
    {
        ent_flag_wait( node.script_ent_flag_wait );
    }
    
    node script_wait();
    self notify( "group_patrol_node_wait_ended" );
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x122f
// Size: 0x76
function private function_801b4f42c4aec0ff( patrolname, aitoadd, formationtype )
{
    index = level.var_865c7977a3a308a[ patrolname ].array.size;
    level.var_865c7977a3a308a[ patrolname ].array[ index ] = aitoadd;
    aitoadd.grouppatrolname = patrolname;
    ai_formation::function_73d6d4ee28a18071( patrolname, aitoadd, formationtype );
    aitoadd thread function_ef66f73bdae69270( formationtype );
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 2
// Checksum 0x0, Offset: 0x12ad
// Size: 0x2c
function function_e780688c49cc9549( patrolname, customoffsetlist )
{
    if ( !isdefined( level.var_865c7977a3a308a[ patrolname ] ) )
    {
        return;
    }
    
    ai_formation::function_e780688c49cc9549( patrolname, customoffsetlist );
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 3
// Checksum 0x0, Offset: 0x12e1
// Size: 0x35
function function_bc785df299663d60( patrolname, formationslot, customoffset )
{
    if ( !isdefined( level.var_865c7977a3a308a[ patrolname ] ) )
    {
        return;
    }
    
    ai_formation::function_bc785df299663d60( patrolname, formationslot, customoffset );
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 2
// Checksum 0x0, Offset: 0x131e
// Size: 0x2c
function set_goal( patrolname, goalposition )
{
    if ( !isdefined( level.var_865c7977a3a308a[ patrolname ] ) )
    {
        return;
    }
    
    ai_formation::set_goal( patrolname, goalposition );
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 2
// Checksum 0x0, Offset: 0x1352
// Size: 0x108
function leave_patrol( patrolname, aitoremove )
{
    if ( !isdefined( level.var_865c7977a3a308a[ patrolname ] ) )
    {
        return;
    }
    
    if ( !isarray( aitoremove ) )
    {
        aitoremove = [ aitoremove ];
    }
    
    foreach ( ai in aitoremove )
    {
        ai_formation::leave_formation( ai );
        ai clearbtgoal( 1 );
        ai clearbtgoal( 3 );
        node = ai.patroltarget;
        
        if ( isdefined( node ) && isdefined( node.interactionid ) )
        {
            despawninteraction( node.interactionid );
            node.interactionid = undefined;
        }
    }
    
    level.var_865c7977a3a308a[ patrolname ].array = array_remove_array( level.var_865c7977a3a308a[ patrolname ].array, aitoremove );
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 0
// Checksum 0x0, Offset: 0x1462
// Size: 0xc7
function function_cc7045b3f96482ce()
{
    assertex( isdefined( self.grouppatrolname ) && self.grouppatrolname != "", "Group patrol has not been defined for agent." );
    ai_formation::function_679b2830741a1384( self.grouppatrolname );
    
    if ( isdefined( self.patroltarget ) )
    {
        level.var_865c7977a3a308a[ self.grouppatrolname ].groupleadertarget = self.patroltarget;
        return;
    }
    
    if ( isdefined( self.spawnpoint.target ) )
    {
        level.var_865c7977a3a308a[ self.grouppatrolname ].groupleadertarget = scripts\engine\utility::getstruct( self.spawnpoint.target, "targetname" );
    }
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 5
// Checksum 0x0, Offset: 0x1531
// Size: 0x91
function function_147af37cda62f235( patrolname, ent, followdistance, timestep, usegoalentity )
{
    if ( !isdefined( usegoalentity ) )
    {
        usegoalentity = 0;
    }
    
    assertex( isdefined( patrolname ) && isdefined( level.var_865c7977a3a308a ) && isdefined( level.var_865c7977a3a308a[ patrolname ] ), "Group patrol not found." );
    assertex( isdefined( ent ), "Specified entity is not defined" );
    
    if ( usegoalentity )
    {
        thread function_67255c72f20ef2f3( patrolname, ent, followdistance, timestep );
        return;
    }
    
    thread function_7bcb65e6db709f70( patrolname, ent, followdistance, timestep );
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x15ca
// Size: 0xaf
function private function_67255c72f20ef2f3( patrolname, ent, followdistance, timestep )
{
    if ( ai_formation::follow_entity( patrolname, ent, followdistance, timestep ) )
    {
        foreach ( agent in level.var_865c7977a3a308a[ patrolname ].array )
        {
            agent notify( "following_entity" );
        }
        
        ent waittill_any_3( "death", "crashing", "entitydeleted" );
        function_fded050d740c3e04( patrolname );
    }
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x1681
// Size: 0xc5
function private function_7bcb65e6db709f70( patrolname, ent, followdistance, timestep )
{
    if ( !isdefined( followdistance ) )
    {
        followdistance = 100;
    }
    
    if ( !isdefined( timestep ) )
    {
        timestep = 2.5;
    }
    
    foreach ( agent in level.var_865c7977a3a308a[ patrolname ].array )
    {
        agent notify( "following_entity" );
    }
    
    thread function_abf1531c14702dc8( patrolname, ent, followdistance, timestep );
    ent waittill_any_3( "death", "crashing", "entitydeleted" );
    function_fded050d740c3e04( patrolname );
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x174e
// Size: 0xf7
function private function_abf1531c14702dc8( patrolname, ent, followdistance, timestep )
{
    ent endon( "death" );
    ent endon( "crashing" );
    ent endon( "entitydeleted" );
    level endon( "game_ended" );
    notifyname = function_8e9e859313e267e2( patrolname );
    level endon( notifyname );
    
    while ( isdefined( level.var_865c7977a3a308a[ patrolname ] ) )
    {
        entforward = anglestoforward( ent.angles );
        offset = -1 * followdistance * entforward;
        newgoal = ent.origin + offset;
        newgoal = getclosestpointonnavmesh( newgoal );
        
        if ( level.var_865c7977a3a308a[ patrolname ].array.size > 0 )
        {
            leader = function_7a82c6e82e83e7d2( patrolname );
            leader setgoalpos( newgoal );
        }
        else
        {
            break;
        }
        
        wait timestep;
    }
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 1
// Checksum 0x0, Offset: 0x184d
// Size: 0x74
function function_fded050d740c3e04( patrolname )
{
    if ( ai_formation::function_5e8d7d93ecffa23f( patrolname ) )
    {
        foreach ( agent in level.var_865c7977a3a308a[ patrolname ].array )
        {
            agent thread function_585606ec5af81775( patrolname );
        }
    }
}

// Namespace namespace_753b428633ceb556 / namespace_6faf037a3568d157
// Params 5
// Checksum 0x0, Offset: 0x18c9
// Size: 0x153
function function_e1f50b1f60aa1b25( patrolname, formationshape, horizontalseparation, verticalseparation, leaderinfront )
{
    if ( !isdefined( leaderinfront ) )
    {
        leaderinfront = 0;
    }
    
    numai = level.var_865c7977a3a308a[ patrolname ].array.size;
    leaderinfront = leaderinfront || formationshape == 1;
    level.var_865c7977a3a308a[ patrolname ].formationwidth = function_cf3f27c3c5266ee2( patrolname, formationshape, numai, horizontalseparation, verticalseparation, leaderinfront );
    level.var_865c7977a3a308a[ patrolname ].horizontalseparation = horizontalseparation;
    level.var_865c7977a3a308a[ patrolname ].verticalseparation = verticalseparation;
    level.var_865c7977a3a308a[ patrolname ].var_75c3b1807b9d4e6 = formationshape;
    level.var_865c7977a3a308a[ patrolname ].leaderinfront = leaderinfront;
    
    if ( !isdefined( level.var_865c7977a3a308a[ patrolname ].var_55576d80f4e2554d ) )
    {
        level.var_865c7977a3a308a[ patrolname ].var_55576d80f4e2554d = formationshape;
    }
    
    if ( formationshape == level.var_865c7977a3a308a[ patrolname ].var_55576d80f4e2554d )
    {
        level.var_865c7977a3a308a[ patrolname ].desiredformationwidth = level.var_865c7977a3a308a[ patrolname ].formationwidth;
    }
}

