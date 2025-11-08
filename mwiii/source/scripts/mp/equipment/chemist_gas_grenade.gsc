#using script_208955cb4d2c8fb3;
#using script_24fbedba9a7a1ef4;
#using script_42adcce5878f583;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\gasmask;
#using scripts\cp_mp\killstreaks\white_phosphorus;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\equipment\gas_grenade;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#using scripts\mp\utility\print;
#using scripts\mp\utility\script;

#namespace chemist_gas_grenade;

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 2
// Checksum 0x0, Offset: 0x386
// Size: 0x1ec
function function_c17d42c1c9426b4f( agent, var_3716647cb96f1f04 )
{
    agent.chemist = spawnstruct();
    agent.chemist.gasradius = default_to( float( var_3716647cb96f1f04.gasradius ), 200 );
    agent.chemist.gasdamage = default_to( var_3716647cb96f1f04.gasdamage, 1 );
    agent.chemist.var_2278441f7203ae = default_to( var_3716647cb96f1f04.var_2278441f7203ae, 1.5 );
    agent.chemist.var_353647cb7ffa6545 = default_to( var_3716647cb96f1f04.var_353647cb7ffa6545, 0.5 );
    agent.chemist.cloudslots = [];
    agent.chemist.var_fe9db1b79b6e0fd4 = default_to( var_3716647cb96f1f04.var_fe9db1b79b6e0fd4, 0.9 );
    agent.chemist.var_884e31585e1488e7 = default_to( var_3716647cb96f1f04.var_4ebb0afebf683c01, 5 );
    agent.chemist.var_5aaa252fb3c34a87 = default_to( var_3716647cb96f1f04.var_5aaa252fb3c34a87, 10 );
    agent.chemist.var_a985895b5796100b = default_to( var_3716647cb96f1f04.var_a985895b5796100b, 200 );
    agent.chemist.var_151cd74fd4c1f445 = default_to( var_3716647cb96f1f04.var_151cd74fd4c1f445, 7 );
    agent.chemist.var_52787549de264c36 = default_to( var_3716647cb96f1f04.var_52787549de264c36, "something" );
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 9
// Checksum 0x0, Offset: 0x57a
// Size: 0x368
function gas_createtrigger( position, owner, team, duration, gasradius, var_ddd8710e868c582e, scriptable, damage, tickcooldown )
{
    if ( !isdefined( duration ) )
    {
        duration = owner.stalker.var_35d7093a7102d784;
    }
    
    if ( !isdefined( gasradius ) )
    {
        gasradius = owner.chemist.gasradius;
    }
    
    /#
        dvar = getunarchiveddebugdvar( @"hash_8c0b4f15bd7fd07b", "<dev string:x1c>" );
        
        if ( int( dvar ) && isdefined( self.chemist ) )
        {
            if ( istrue( var_ddd8710e868c582e ) )
            {
                if ( int( getunarchiveddebugdvar( @"hash_8c9ae83d2eacef", self.chemist.gasradius ) ) )
                {
                    gasradius = int( getunarchiveddebugdvar( @"hash_8c9ae83d2eacef", self.chemist.gasradius ) );
                }
            }
            else if ( int( getunarchiveddebugdvar( @"hash_b804dde808052bcd", self.chemist.var_a985895b5796100b ) ) )
            {
                gasradius = int( getunarchiveddebugdvar( @"hash_b804dde808052bcd", self.chemist.var_a985895b5796100b ) );
            }
        }
    #/
    
    trigger = spawn( "trigger_radius", position + ( 0, 0, int( -57.75 ) ), 0, int( gasradius ), int( 175 ) );
    trigger scripts\cp_mp\ent_manager::registerspawn( 1, &sweepgas );
    trigger endon( "death" );
    
    if ( !isdefined( scriptable ) )
    {
        scriptable = owner.chemist.var_52787549de264c36;
        
        if ( istrue( var_ddd8710e868c582e ) )
        {
            scriptable = owner.stalker.var_676a9574befe2b66;
        }
    }
    
    randomrotation = randomintrange( 0, 1 );
    randomrotation = randomrotation * 180 - 90;
    trigger.scriptable = spawnscriptable( scriptable, position, ( randomrotation, 0, 0 ) );
    trigger.scriptable setscriptablepartstate( "smoke", "on" );
    trigger.owner = owner;
    trigger.team = team;
    trigger.playersintrigger = [];
    trigger.var_aeeca2bc23f59ea4 = [];
    trigger.triggertype = "tripwire";
    
    if ( isdefined( trigger.owner ) && isdefined( trigger.owner.chemist ) )
    {
        trigger.triggertype = ter_op( istrue( var_ddd8710e868c582e ), "chemist_defensive", "chemist_offensive" );
    }
    
    trigger thread gas_watchtriggerenter( damage, tickcooldown );
    trigger thread gas_watchtriggerexit();
    trigger thread function_c019d388d556f4c1();
    trigger thread gas_destroytrigger( duration, var_ddd8710e868c582e );
    
    /#
        if ( int( dvar ) )
        {
            draw_circle( position, gasradius, ( 0, 1, 0 ), 1, 0, int( duration / level.framedurationseconds ) );
            draw_circle( position + ( 0, 0, int( 175 ) ), gasradius, ( 0, 1, 0 ), 1, 0, int( duration / level.framedurationseconds ) );
        }
    #/
    
    return trigger;
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 2
// Checksum 0x0, Offset: 0x8eb
// Size: 0x2f9
function gas_watchtriggerenter( damage, tickcooldown )
{
    level endon( "game_ended" );
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "trigger", enteringentity );
        
        if ( !isdefined( enteringentity ) )
        {
            continue;
        }
        
        if ( istrue( self.var_80882985b5288ea2 ) )
        {
            continue;
        }
        
        var_f89a7d23282c775a = [];
        
        if ( isplayer( enteringentity ) )
        {
            var_f89a7d23282c775a[ var_f89a7d23282c775a.size ] = enteringentity;
        }
        else if ( enteringentity scripts\cp_mp\vehicles\vehicle::isvehicle() )
        {
            occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( enteringentity, 0 );
            
            if ( isdefined( occupants ) && isarray( occupants ) )
            {
                foreach ( occupant in occupants )
                {
                    if ( isdefined( occupant ) && isplayer( occupant ) )
                    {
                        var_f89a7d23282c775a[ var_f89a7d23282c775a.size ] = occupant;
                    }
                }
            }
        }
        else if ( isagent( enteringentity ) )
        {
            bnewentity = !array_contains( self.var_aeeca2bc23f59ea4, enteringentity );
            var_a8ea15b041872949 = isdefined( enteringentity.radimmune ) && enteringentity.radimmune;
            bisenemyteam = gas_isenemyteam( enteringentity );
            
            if ( bnewentity )
            {
                if ( !isdefined( enteringentity.var_e4ba42c30663bec8 ) )
                {
                    enteringentity.var_e4ba42c30663bec8 = 0;
                }
                
                self.var_aeeca2bc23f59ea4[ self.var_aeeca2bc23f59ea4.size ] = enteringentity;
                enteringentity.var_e4ba42c30663bec8++;
                
                if ( enteringentity.var_e4ba42c30663bec8 == 1 )
                {
                    enteringentity thread function_157fa9f486d53b6e();
                    enteringentity function_870ea0fefcd757f4( 0, isdefined( enteringentity.chemist ) );
                    
                    if ( !isdefined( enteringentity.callbackdamaged ) )
                    {
                        enteringentity.callbackdamaged = &function_b33be13e1e5a9315;
                    }
                }
                
                if ( var_a8ea15b041872949 )
                {
                    continue;
                }
                
                if ( istrue( enteringentity.var_b426e3a6879aa708 ) )
                {
                    if ( function_6eb21567d00b6925( enteringentity ) )
                    {
                        continue;
                    }
                    
                    if ( !bisenemyteam )
                    {
                        continue;
                    }
                    
                    enteringentity thread gas_onentertrigger( self, damage, tickcooldown );
                }
            }
            
            if ( bnewentity || isdefined( enteringentity.flashendtime ) && enteringentity.flashendtime < gettime() )
            {
                if ( var_a8ea15b041872949 || !bisenemyteam )
                {
                    continue;
                }
                
                enteringentity notify( "flashbang", enteringentity.origin, 1, 1, self.owner, "axis", 9 );
            }
        }
        
        foreach ( player in var_f89a7d23282c775a )
        {
            if ( !function_77090b728077e89( player ) )
            {
                self.playersintrigger[ player getentitynumber() ] = player;
                player thread gas_onentertrigger( self, damage, tickcooldown );
            }
        }
    }
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0xbec
// Size: 0x7f, Type: bool
function gas_isenemyteam( entity )
{
    if ( !level.teambased || !isdefined( self.team ) )
    {
        return true;
    }
    
    teamtocheck = entity.team;
    
    if ( !isdefined( teamtocheck ) && isdefined( entity.agentteam ) )
    {
        teamtocheck = entity.agentteam;
    }
    
    if ( isdefined( teamtocheck ) && isenemyteam( self.team, teamtocheck ) )
    {
        return true;
    }
    
    return false;
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0xc74
// Size: 0xa1, Type: bool
function function_77090b728077e89( player )
{
    if ( !isdefined( player ) )
    {
        return true;
    }
    
    if ( function_f956c3df8422820b( player ) )
    {
        return true;
    }
    
    if ( isdefined( self.playersintrigger[ player getentitynumber() ] ) )
    {
        return true;
    }
    
    if ( level.teambased )
    {
        if ( isdefined( self.owner ) && isalive( self.owner ) )
        {
            if ( player != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies( player, self.owner ) )
            {
                return true;
            }
        }
        else if ( scripts\cp_mp\utility\player_utility::isfriendly( self.team, player ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 0
// Checksum 0x0, Offset: 0xd1e
// Size: 0x1ac
function gas_watchtriggerexit()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    while ( true )
    {
        foreach ( id, player in self.playersintrigger )
        {
            if ( !isdefined( player ) )
            {
                self.playersintrigger[ id ] = undefined;
                continue;
            }
            
            if ( player istouching( self ) && !function_f956c3df8422820b( player ) )
            {
                continue;
            }
            
            playervehicle = player scripts\cp_mp\utility\player_utility::getvehicle();
            
            if ( isdefined( playervehicle ) && playervehicle istouching( self ) )
            {
                continue;
            }
            
            self.playersintrigger[ player getentitynumber() ] = undefined;
            player thread gas_onexittrigger( self getentitynumber(), self.triggertype );
        }
        
        index = 0;
        
        while ( index < self.var_aeeca2bc23f59ea4.size )
        {
            agent = self.var_aeeca2bc23f59ea4[ index ];
            
            if ( isdefined( agent ) )
            {
                if ( agent istouching( self ) && !function_6eb21567d00b6925( agent ) )
                {
                    index++;
                    continue;
                }
                
                if ( isdefined( agent.var_e4ba42c30663bec8 ) && agent.var_e4ba42c30663bec8 > 0 )
                {
                    agent.var_e4ba42c30663bec8--;
                }
            }
            
            self.var_aeeca2bc23f59ea4[ index ] = self.var_aeeca2bc23f59ea4[ self.var_aeeca2bc23f59ea4.size - 1 ];
            self.var_aeeca2bc23f59ea4[ self.var_aeeca2bc23f59ea4.size - 1 ] = undefined;
            agent thread gas_onexittrigger( self getentitynumber(), self.triggertype );
        }
        
        waitframe();
    }
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0xed2
// Size: 0x32, Type: bool
function function_f956c3df8422820b( player )
{
    if ( !player scripts\cp_mp\utility\player_utility::_isalive() )
    {
        return true;
    }
    
    if ( player scripts\mp\utility\killstreak::isjuggernaut() )
    {
        return true;
    }
    
    if ( player function_7ee20cf3c0390e21() )
    {
        return true;
    }
    
    return false;
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0xf0d
// Size: 0x18, Type: bool
function function_6eb21567d00b6925( agent )
{
    if ( !isalive( agent ) )
    {
        return true;
    }
    
    return false;
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 0
// Checksum 0x0, Offset: 0xf2e
// Size: 0xa
function sweepgas()
{
    thread function_84a4f38b8b39ce71();
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 2
// Checksum 0x0, Offset: 0xf40
// Size: 0x7f
function gas_destroytrigger( duration, var_ddd8710e868c582e )
{
    level endon( "game_ended" );
    wait duration;
    
    if ( istrue( var_ddd8710e868c582e ) )
    {
        var_967f24eb3ed9943a = self.origin + ( 0, 0, 150 );
        playsoundatpos( var_967f24eb3ed9943a, "chemist_gas_grenade_defensive_tail" );
    }
    else
    {
        var_967f24eb3ed9943a = self.origin + ( 0, 0, 150 );
        playsoundatpos( var_967f24eb3ed9943a, "chemist_gas_grenade_offensive_tail" );
    }
    
    function_84a4f38b8b39ce71();
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 0
// Checksum 0x0, Offset: 0xfc7
// Size: 0x19c
function function_84a4f38b8b39ce71()
{
    self.var_80882985b5288ea2 = 1;
    
    if ( isdefined( self.owner ) )
    {
        self.owner notify( "trigger_destroyed", self );
    }
    
    self notify( "trigger_destroyed_immediately" );
    
    foreach ( player in self.playersintrigger )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        self.playersintrigger[ player getentitynumber() ] = undefined;
        player thread gas_onexittrigger( self getentitynumber(), self.triggertype );
    }
    
    index = 0;
    
    while ( index < self.var_aeeca2bc23f59ea4.size )
    {
        agent = self.var_aeeca2bc23f59ea4[ index ];
        
        if ( isdefined( agent ) && isdefined( agent.var_e4ba42c30663bec8 ) && agent.var_e4ba42c30663bec8 > 0 )
        {
            agent.var_e4ba42c30663bec8--;
        }
        
        self.var_aeeca2bc23f59ea4[ index ] = self.var_aeeca2bc23f59ea4[ self.var_aeeca2bc23f59ea4.size - 1 ];
        self.var_aeeca2bc23f59ea4[ self.var_aeeca2bc23f59ea4.size - 1 ] = undefined;
        agent thread gas_onexittrigger( self getentitynumber(), self.triggertype );
    }
    
    self.scriptable setscriptablepartstate( "smoke", "off" );
    waitframe();
    self.scriptable freescriptable();
    scripts\cp_mp\ent_manager::deregisterspawn();
    self delete();
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x116b
// Size: 0x179
function private function_c019d388d556f4c1()
{
    level endon( "game_ended" );
    self endon( "trigger_destroyed_immediately" );
    self waittill( "death" );
    
    foreach ( player in self.playersintrigger )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        self.playersintrigger[ player getentitynumber() ] = undefined;
        player thread gas_onexittrigger( self getentitynumber(), self.triggertype );
    }
    
    index = 0;
    
    while ( index < self.var_aeeca2bc23f59ea4.size )
    {
        agent = self.var_aeeca2bc23f59ea4[ index ];
        self.var_aeeca2bc23f59ea4[ index ] = self.var_aeeca2bc23f59ea4[ self.var_aeeca2bc23f59ea4.size - 1 ];
        self.var_aeeca2bc23f59ea4[ self.var_aeeca2bc23f59ea4.size - 1 ] = undefined;
        
        if ( isdefined( agent ) )
        {
            if ( isdefined( agent.var_e4ba42c30663bec8 ) && agent.var_e4ba42c30663bec8 > 0 )
            {
                agent.var_e4ba42c30663bec8--;
            }
            
            agent thread gas_onexittrigger( self getentitynumber(), self.triggertype );
        }
    }
    
    self.scriptable setscriptablepartstate( "smoke", "off" );
    waitframe();
    self.scriptable freescriptable();
    scripts\cp_mp\ent_manager::deregisterspawn();
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 3
// Checksum 0x0, Offset: 0x12ec
// Size: 0x134
function gas_onentertrigger( trigger, damage, tickcooldown )
{
    entnum = trigger getentitynumber();
    function_7ca878a04649aec0( trigger );
    shoulddodamage = 1;
    
    if ( isdefined( trigger.owner ) && isdefined( trigger.owner.chemist ) )
    {
        if ( !isdefined( damage ) )
        {
            damage = trigger.owner.chemist.gasdamage;
        }
        
        if ( !isdefined( tickcooldown ) )
        {
            tickcooldown = trigger.owner.chemist.var_2278441f7203ae;
        }
        
        thread function_415ef5b618aed907( damage, tickcooldown, trigger.owner, trigger.triggertype );
        shoulddodamage = 0;
        
        if ( function_c1dfd599d3f3431b( self ) )
        {
            return entnum;
        }
    }
    
    if ( isplayer( self ) )
    {
        function_9bf22e3dc3f67495( trigger );
        scripts\mp\utility\player::codcastersetplayerstatuseffect( "gas", -1 );
    }
    
    if ( shoulddodamage && trigger.triggertype == "tripwire" )
    {
        thread function_415ef5b618aed907( damage, tickcooldown, undefined, trigger.triggertype );
    }
    
    return entnum;
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 2
// Checksum 0x0, Offset: 0x1429
// Size: 0x113
function gas_onexittrigger( triggerid, triggertype )
{
    assertex( isdefined( triggerid ), "<dev string:x21>" );
    assertex( isdefined( triggertype ), "<dev string:x59>" );
    
    if ( !isdefined( self.gastriggerstouching ) || !isdefined( self.gastriggerstouching[ triggerid ] ) )
    {
        return;
    }
    
    self.gastriggerstouching[ triggerid ] = undefined;
    self.lastgastouchtime = gettime();
    self notify( "exited_trigger_" + triggerid );
    isplayer = isplayer( self );
    
    if ( self.gastriggerstouching.size == 0 )
    {
        if ( isplayer )
        {
            scripts\mp\utility\player::codcastersetplayerstatuseffect( "gas", 0 );
            function_92bdd3200219d4b7();
        }
        
        self notify( "gas_exited" );
    }
    
    if ( isdefined( triggertype ) && function_cdab109851736293( triggertype ) && !function_ca84aec5683c61bd( triggertype ) )
    {
        self notify( "end_gas_periodicDamage_" + triggertype );
        function_906a662a379369c7( triggertype, 0 );
        
        if ( isplayer && !istrue( self.var_d9928cc9ad437613 ) )
        {
            toggle_gasmask( "off" );
        }
        
        /#
            function_a3b978f0d3e37d36( "<dev string:x92>" + triggertype );
        #/
    }
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1544
// Size: 0x42
function private function_7ca878a04649aec0( trigger )
{
    if ( !isdefined( self.gastriggerstouching ) )
    {
        self.gastriggerstouching = [];
    }
    
    self.gastriggerstouching[ trigger getentitynumber() ] = trigger;
    self.lastgastouchtime = gettime();
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x158e
// Size: 0xaa, Type: bool
function private function_415ef5b618aed907( damage, interval, var_5fd212d893bd2ef9, triggertype )
{
    if ( !isdefined( damage ) || !isdefined( interval ) || !isdefined( triggertype ) )
    {
        assertmsg( "<dev string:xbe>" );
        return false;
    }
    
    if ( !( triggertype == "chemist_defensive" || triggertype == "chemist_offensive" || triggertype == "tripwire" ) )
    {
        assertmsg( "<dev string:xf9>" );
        return false;
    }
    
    if ( function_cdab109851736293( triggertype ) )
    {
        return false;
    }
    
    function_906a662a379369c7( triggertype, 1 );
    thread function_9ce4664dde233208( damage, interval, var_5fd212d893bd2ef9, triggertype );
    
    /#
        function_a3b978f0d3e37d36( "<dev string:x140>" + triggertype );
    #/
    
    return true;
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1641
// Size: 0x42
function private function_906a662a379369c7( triggertype, active )
{
    assert( isdefined( triggertype ) );
    
    if ( !isdefined( self.var_13d2db04d43dca86 ) )
    {
        self.var_13d2db04d43dca86 = [];
    }
    
    self.var_13d2db04d43dca86[ triggertype ] = active;
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x168b
// Size: 0x36, Type: bool
function private function_cdab109851736293( triggertype )
{
    assert( isdefined( triggertype ) );
    return isdefined( triggertype ) && isdefined( self.var_13d2db04d43dca86 ) && istrue( self.var_13d2db04d43dca86[ triggertype ] );
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x16ca
// Size: 0x16b
function private function_9ce4664dde233208( damage, interval, attacker, triggertype, tripwireent )
{
    assert( isdefined( damage ) );
    assert( isdefined( interval ) );
    assert( isdefined( triggertype ) );
    level endon( "game_ended" );
    self endon( "death" );
    
    if ( isdefined( attacker ) )
    {
        attacker endon( "death" );
    }
    
    self endon( "end_gas_periodicDamage_" + triggertype );
    
    if ( isdefined( attacker ) )
    {
        attacker endon( "death" );
    }
    
    isplayer = isplayer( self );
    
    while ( true )
    {
        var_da4034b8609498b7 = 0;
        
        if ( triggertype != "chemist_defensive" )
        {
            var_da4034b8609498b7 = !function_ca84aec5683c61bd( "chemist_defensive" );
        }
        else
        {
            var_da4034b8609498b7 = function_ca84aec5683c61bd( triggertype );
        }
        
        if ( var_da4034b8609498b7 )
        {
            if ( isplayer )
            {
                var_356dcf1f8837d91c = scripts\cp_mp\gasmask::hasgasmask( self );
                
                if ( var_356dcf1f8837d91c && !istrue( self.var_11e954ae279ee245 ) )
                {
                    toggle_gasmask( "on" );
                }
            }
            else
            {
                var_356dcf1f8837d91c = 0;
            }
            
            if ( var_356dcf1f8837d91c )
            {
                scripts\cp_mp\gasmask::processdamage( damage );
            }
            else
            {
                if ( !isdefined( attacker ) )
                {
                    attacker = self;
                }
                
                self dodamage( damage, self.origin, attacker, tripwireent, "MOD_TRIGGER_HURT", "<explicitweaponnone>", "body" );
            }
            
            if ( isplayer && triggertype == "chemist_defensive" )
            {
                if ( var_356dcf1f8837d91c )
                {
                    attacker thread namespace_dc53a27a8db8e6bf::function_7f0a446fa91ff206( self );
                }
                else
                {
                    attacker thread namespace_dc53a27a8db8e6bf::function_4e8e1867968e84a5( self );
                }
            }
        }
        
        wait interval;
    }
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x183d
// Size: 0xa7
function toggle_gasmask( state )
{
    var_11e954ae279ee245 = self.gasmaskequipped;
    
    if ( istrue( self.gasmaskswapinprogress ) )
    {
        waittill_notify_or_timeout( "gas_mask_swap_complete", 2 );
    }
    
    if ( state == "on" && !istrue( var_11e954ae279ee245 ) )
    {
        if ( scripts\cp_mp\gasmask::hasgasmask( self ) )
        {
            if ( isdefined( level.var_f26b4e7eb9af8155 ) )
            {
                self [[ level.var_f26b4e7eb9af8155 ]]( "chemist_gas" );
                function_92bdd3200219d4b7();
            }
        }
    }
    
    if ( state == "off" )
    {
        if ( isdefined( level.var_c57ee1e174e42601 ) )
        {
            self [[ level.var_c57ee1e174e42601 ]]( "chemist_gas" );
        }
    }
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x18ec
// Size: 0xb3, Type: bool
function private function_ca84aec5683c61bd( triggertype )
{
    if ( !isdefined( self.gastriggerstouching ) || !isarray( self.gastriggerstouching ) || !isdefined( triggertype ) || !isstring( triggertype ) )
    {
        return false;
    }
    
    foreach ( gastrigger in self.gastriggerstouching )
    {
        if ( isdefined( gastrigger ) && isdefined( gastrigger.triggertype ) && gastrigger.triggertype == triggertype )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x19a8
// Size: 0x30, Type: bool
function private function_6ef47ee9171ed1b9()
{
    if ( !isdefined( self.gastriggerstouching ) || !isarray( self.gastriggerstouching ) )
    {
        return false;
    }
    
    return self.gastriggerstouching.size > 0;
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 2
// Checksum 0x0, Offset: 0x19e1
// Size: 0x11d
function function_abe80254fe179ec7( triggerloc, var_ddd8710e868c582e )
{
    self endon( "death" );
    level endon( "game_ended" );
    
    if ( !function_6ee3c7d8ed420d0b( self ) )
    {
        return;
    }
    
    if ( !istrue( var_ddd8710e868c582e ) || self.chemist.gasclouds.size < self.chemist.var_68d81840282013fc )
    {
        radius = self.chemist.var_a985895b5796100b;
        duration = self.chemist.var_151cd74fd4c1f445;
        
        if ( istrue( var_ddd8710e868c582e ) )
        {
            radius = self.chemist.gasradius;
            duration = self.stalker.var_35d7093a7102d784;
        }
        
        gasgrenade = gas_createtrigger( triggerloc, self, self.team, duration, radius, var_ddd8710e868c582e );
        
        if ( istrue( var_ddd8710e868c582e ) )
        {
            self.chemist.gasclouds = array_add( self.chemist.gasclouds, gasgrenade );
        }
        
        return gasgrenade;
    }
    
    return undefined;
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1b07
// Size: 0x94, Type: bool
function private function_6ee3c7d8ed420d0b( agent )
{
    if ( !isdefined( agent ) )
    {
        assertex( 0, "<dev string:x16e>" );
        return false;
    }
    
    if ( !isalive( agent ) )
    {
        return false;
    }
    
    if ( isdefined( agent.chemist ) )
    {
        return true;
    }
    
    /#
        if ( int( getunarchiveddebugdvar( @"hash_213776149170b77d", "<dev string:x1c>" ) ) )
        {
            warlordparameters = namespace_ad1f398af6f48cb1::function_9acf953fd6bf2e46( "<dev string:x1a3>" );
            
            if ( isdefined( warlordparameters ) )
            {
                function_c17d42c1c9426b4f( agent, warlordparameters );
                return true;
            }
        }
    #/
    
    assertex( 0, "<dev string:x1ae>" );
    return false;
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 2
// Checksum 0x0, Offset: 0x1ba4
// Size: 0x32
function function_870ea0fefcd757f4( showui, var_53567942b7869ae4 )
{
    val::set( "chemist", "show_healthbar", showui );
    
    if ( istrue( var_53567942b7869ae4 ) )
    {
        function_d11b100bf72af184( showui );
    }
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x1bde
// Size: 0xa4
function function_d11b100bf72af184( showicon )
{
    if ( isdefined( self ) && isdefined( self.ob ) && isdefined( self.ob.headicon ) )
    {
        /#
            if ( int( getunarchiveddebugdvar( @"hash_54fc92ada753c66a", "<dev string:x1c>" ) ) )
            {
                print3d( self.origin, "<dev string:x1e3>" + showicon + "<dev string:x1ed>" + gettime(), ( 1, 1, 0 ), 1, 1, 30 );
            }
        #/
        
        setheadiconhideinworld( self.ob.headicon, !showicon );
    }
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x1c8a
// Size: 0xea
function function_157fa9f486d53b6e()
{
    self endon( "death" );
    self endon( "trigger_exited" );
    level endon( "game_ended" );
    
    /#
        thread function_1278077fcd4b2924();
    #/
    
    while ( self.var_e4ba42c30663bec8 > 0 )
    {
        if ( isdefined( self.var_2cb06c767e8080ff ) && self.var_2cb06c767e8080ff < gettime() )
        {
            function_870ea0fefcd757f4( 0, isdefined( self.chemist ) );
        }
        
        waitframe();
    }
    
    if ( isdefined( self.callbackdamaged ) && self.callbackdamaged == &function_b33be13e1e5a9315 )
    {
        self.callbackdamaged = undefined;
    }
    
    function_870ea0fefcd757f4( 1, isdefined( self.chemist ) );
    
    /#
        if ( int( getunarchiveddebugdvar( @"hash_54fc92ada753c66a", "<dev string:x1c>" ) ) )
        {
            print3d( self.origin, "<dev string:x1f5>", ( 1, 0, 1 ), 1, 1, 30, 1 );
        }
    #/
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x1d7c
// Size: 0x2e
function function_584accf001003add( grenade )
{
    grenade endon( "death" );
    thread function_eae98d11d50d3558( grenade, 0 );
    thread function_241fbb1f7f839637( grenade, 0 );
    thread namespace_dc53a27a8db8e6bf::function_f096dea082480f5();
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 13
// Checksum 0x0, Offset: 0x1db2
// Size: 0xab
function function_b33be13e1e5a9315( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon )
{
    function_870ea0fefcd757f4( 1, isdefined( self.chemist ) );
    namespace_daa149ca485fd50a::function_dffac413ed66bcd0( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon );
    self.var_2cb06c767e8080ff = gettime() + 3000;
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 2
// Checksum 0x0, Offset: 0x1e65
// Size: 0x4b
function function_eae98d11d50d3558( grenade, var_ddd8710e868c582e )
{
    grenade thread notifyafterframeend( "death", "end_explode" );
    grenade endon( "end_explode" );
    grenade waittill( "explode", position );
    thread function_abe80254fe179ec7( position, var_ddd8710e868c582e );
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 2
// Checksum 0x0, Offset: 0x1eb8
// Size: 0x75
function function_241fbb1f7f839637( grenade, var_ddd8710e868c582e )
{
    grenade endon( "explode" );
    grenade waittill( "missile_water_impact", impactdata );
    grenade notify( "end_explode" );
    grenade waittill( "missile_stuck", stuckdata );
    position = grenade.origin;
    thread function_abe80254fe179ec7( position + ( 0, 0, 10 ), var_ddd8710e868c582e );
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1f35
// Size: 0x38, Type: bool
function private function_c1dfd599d3f3431b( player )
{
    return isdefined( player.gasmaskhealth ) && player.gasmaskhealth > 0 || istrue( player.gasmaskswapinprogress );
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x1f76
// Size: 0x70
function function_9bf22e3dc3f67495( trigger )
{
    if ( isplayer( self ) )
    {
        if ( !function_c1dfd599d3f3431b( self ) && ( istrue( self.var_d9928cc9ad437613 ) || function_6ef47ee9171ed1b9() ) )
        {
            if ( isdefined( trigger ) )
            {
                thread scripts\mp\equipment\gas_grenade::gas_applycough( trigger.owner, 0 );
            }
            
            if ( function_6ef47ee9171ed1b9() )
            {
                thread scripts\mp\equipment\gas_grenade::gas_applyspeedredux();
                thread scripts\mp\equipment\gas_grenade::gas_applyblur();
            }
            
            scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudio();
        }
    }
}

// Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x1fee
// Size: 0x5a
function function_92bdd3200219d4b7()
{
    if ( isplayer( self ) )
    {
        if ( function_c1dfd599d3f3431b( self ) )
        {
            shouldstop = 1;
        }
        
        if ( !function_6ef47ee9171ed1b9() )
        {
            thread scripts\mp\equipment\gas_grenade::gas_removespeedredux();
            thread scripts\mp\equipment\gas_grenade::gas_removeblur();
            
            if ( !istrue( self.var_d9928cc9ad437613 ) )
            {
                shouldstop = 1;
            }
        }
    }
    
    if ( istrue( shouldstop ) )
    {
        scripts\cp_mp\killstreaks\white_phosphorus::clearloopingcoughaudio();
    }
    
    return shouldstop;
}

/#

    // Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x2051
    // Size: 0x30, Type: dev
    function private function_a3b978f0d3e37d36( text )
    {
        if ( !getdvarint( @"hash_17f79f0678395264", 0 ) )
        {
            return;
        }
        
        scripts\common\debug::function_7320cd1e4f724899( text );
        println( text );
    }

    // Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x2089
    // Size: 0x1d9, Type: dev
    function private function_b8f06ed708934a74()
    {
        localplayer = level.player;
        
        if ( !isdefined( localplayer ) || !isalive( localplayer ) )
        {
            return;
        }
        
        offset_x = 400;
        offset_y = 100;
        scale = 1;
        line_y = 20;
        printtoscreen2d( offset_x, offset_y, "<dev string:x206>", ( 0, 1, 1 ), scale );
        offset_y += line_y;
        
        if ( isdefined( localplayer.gasmaskhealth ) && isdefined( localplayer.gasmaskmaxhealth ) )
        {
            printtoscreen2d( offset_x, offset_y, "<dev string:x226>" + localplayer.gasmaskhealth + "<dev string:x243>" + localplayer.gasmaskmaxhealth, ( 0, 1, 1 ), scale );
            offset_y += line_y;
        }
        
        if ( localplayer function_6ef47ee9171ed1b9() )
        {
            foreach ( id, gastrigger in localplayer.gastriggerstouching )
            {
                if ( isdefined( gastrigger ) )
                {
                    triggertypetext = default_to( gastrigger.triggertype, "<dev string:x24a>" );
                    printtoscreen2d( offset_x, offset_y, "<dev string:x251>" + id + "<dev string:x259>" + triggertypetext, ( 0, 1, 0 ), scale );
                    offset_y += line_y;
                    continue;
                }
                
                printtoscreen2d( offset_x, offset_y, "<dev string:x26a>", ( 1, 0, 0 ), scale );
                offset_y += line_y;
            }
            
            return;
        }
        
        printtoscreen2d( offset_x, offset_y, "<dev string:x24a>", ( 0, 1, 0 ), scale );
        offset_y += line_y;
    }

    // Namespace chemist_gas_grenade / scripts\mp\equipment\chemist_gas_grenade
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x226a
    // Size: 0x97, Type: dev
    function private function_1278077fcd4b2924()
    {
        self endon( "<dev string:x284>" );
        self endon( "<dev string:x28d>" );
        
        while ( self.var_e4ba42c30663bec8 > 0 )
        {
            dvar = int( getunarchiveddebugdvar( @"hash_54fc92ada753c66a", "<dev string:x1c>" ) );
            
            if ( dvar )
            {
                text = ter_op( val::get( "<dev string:x29f>" ), "<dev string:x2b1>", "<dev string:x2bc>" );
                print3d( self.origin, text, ( 1, 0, 1 ), 1, 1, 1, 1 );
            }
            
            waitframe();
        }
    }

#/
