#using script_74b851b7aa1ef32d;
#using scripts\common\ae_utility;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\killstreaks\white_phosphorus;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\br;
#using scripts\mp\perks\perks;
#using scripts\mp\spawnlogic;
#using scripts\mp\supers;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\print;
#using scripts\mp\utility\script;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;

#namespace gas_grenade;

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x62d
// Size: 0x94
function gas_used( grenade )
{
    self endon( "disconnect" );
    grenade endon( "death" );
    team = grenade.owner.team;
    scripts\cp_mp\challenges::function_b0f754c8a379154e( "equip_gas_grenade", self, undefined, function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"use" ) );
    printgameaction( "gasGrenade spawn", grenade.owner );
    thread scripts\mp\weapons::monitordisownedgrenade( self, grenade );
    thread gas_watchexplode( grenade, team );
    thread function_60397906a6eb5a4f( grenade );
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 2
// Checksum 0x0, Offset: 0x6c9
// Size: 0x7c
function gas_watchexplode( grenade, team )
{
    grenade thread notifyafterframeend( "death", "end_explode" );
    grenade endon( "end_explode" );
    owner = grenade.owner;
    grenade waittill( "explode", position );
    duration = getdvarfloat( @"hash_6cf4a762721de876", 7 );
    thread gas_createtrigger( position, owner, team, duration );
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x74d
// Size: 0x37
function function_60397906a6eb5a4f( grenade )
{
    grenade endon( "explode" );
    grenade waittill( "missile_water_impact", impactdata );
    grenade notify( "end_explode" );
    thread function_da09131c75ad4b63( grenade );
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x78c
// Size: 0x78
function function_da09131c75ad4b63( grenade )
{
    grenade waittill( "missile_stuck", stuckdata );
    owner = grenade.owner;
    team = grenade.team;
    position = grenade.origin;
    grenade thread gas_createtrigger( position + ( 0, 0, 10 ), owner, team );
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x80c
// Size: 0x192, Type: bool
function gas_onplayerdamaged( data )
{
    if ( data.meansofdeath == "MOD_IMPACT" )
    {
        return true;
    }
    
    if ( data.attacker == data.victim )
    {
        if ( distancesquared( data.point, data.victim.origin ) > 30625 )
        {
            return false;
        }
    }
    else if ( isplayer( data.attacker ) )
    {
        data.attacker scripts\mp\damage::combatrecordtacticalstat( "equip_gas_grenade" );
        data.attacker scripts\mp\utility\stats::incpersstat( "gasHits", 1 );
        scripts\cp_mp\challenges::function_b0f754c8a379154e( "equip_gas_grenade", data.attacker, undefined, function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"hit" ) );
        
        if ( data.victim scripts\mp\utility\perk::_hasperk( "specialty_gas_grenade_resist" ) )
        {
            data.attacker updatedamagefeedback( "hittacresist", undefined, undefined, undefined, 1 );
        }
    }
    
    if ( data.attacker != data.victim )
    {
        data.attacker namespace_a850435086c88de3::doonactionscoreevent( 0, "gasGrenadeHit" );
    }
    
    if ( function_4cd5239298745de7() && isdefined( self.gasmaskhealth ) && self.gasmaskhealth > 0 )
    {
        return true;
    }
    
    data.victim thread gas_applycough( data.attacker, 1 );
    return true;
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x9a7
// Size: 0xa0
function gas_clear( fromdeath )
{
    gas_clearspeedredux( fromdeath );
    gas_clearblur( fromdeath );
    gas_clearcough( fromdeath );
    
    if ( isdefined( self.gastriggerstouching ) )
    {
        foreach ( trigger in self.gastriggerstouching )
        {
            if ( !isdefined( trigger ) )
            {
                continue;
            }
            
            trigger.playersintrigger[ self getentitynumber() ] = undefined;
        }
    }
    
    self.gastriggerstouching = undefined;
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 10
// Checksum 0x0, Offset: 0xa4f
// Size: 0x2fe
function gas_createtrigger( position, owner, team, duration, scale, iscrossbow, crossbowlevel, radius, height, offset )
{
    if ( !isdefined( iscrossbow ) )
    {
        iscrossbow = 0;
    }
    
    if ( !isdefined( crossbowlevel ) )
    {
        crossbowlevel = 0;
    }
    
    if ( !isdefined( radius ) )
    {
        radius = 256;
    }
    
    if ( !isdefined( height ) )
    {
        height = 175;
    }
    
    if ( !isdefined( offset ) )
    {
        offset = -57.75;
    }
    
    if ( !isdefined( position ) )
    {
        return;
    }
    
    if ( scripts\engine\utility::issharedfuncdefined( "pmc_missions", "onGasGrenadeExplode" ) )
    {
        [[ scripts\engine\utility::getsharedfunc( "pmc_missions", "onGasGrenadeExplode" ) ]]( position, owner, team );
    }
    
    if ( !isdefined( duration ) )
    {
        duration = 7;
    }
    
    if ( !isdefined( scale ) )
    {
        scale = 1;
    }
    
    if ( getdvarint( @"mgl", 0 ) )
    {
        thread scripts\common\ai::mgladdactivesmoke( position, 0 );
    }
    
    radius *= scale;
    height *= scale;
    offset *= scale;
    trigger = spawn( "trigger_radius", position + ( 0, 0, offset ), 0, radius, height );
    trigger scripts\cp_mp\ent_manager::registerspawn( 1, &sweepgas );
    badplace = createnavbadplacebybounds( position + ( 0, 0, int( -57.75 * scale ) ), ( int( 256 * scale ), int( 256 * scale ), int( 175 * scale ) ), ( 0, 0, 0 ) );
    trigger.height = height;
    trigger.radius = radius;
    trigger.duration = duration;
    trigger endon( "death" );
    trigger.owner = owner;
    trigger.team = team;
    trigger.iscrossbow = iscrossbow;
    trigger.crossbowlevel = crossbowlevel;
    trigger.playersintrigger = [];
    trigger.var_aeeca2bc23f59ea4 = [];
    trigger.badplace = badplace;
    
    if ( function_4cd5239298745de7() )
    {
        trigger thread scripts\mp\gametypes\br::function_4b2456ab9e1c7b81( position );
    }
    
    trigger thread gas_watchtriggerenter();
    trigger thread gas_watchtriggerexit();
    trigger thread function_b3f6ad35b2a40677( position + ( 0, 0, offset ), radius, height, duration );
    
    /#
        draw_version = getdvarint( @"hash_94521eb2fc22ae59", 0 );
        
        switch ( draw_version )
        {
            case 1:
                drawentitybounds( trigger, ( 1, 0, 0 ), 0, int( duration / level.framedurationseconds ) );
                break;
            case 2:
                cylinder( trigger.origin, trigger.origin + ( 0, 0, height ), radius, ( 1, 0, 0 ), 0, int( duration / level.framedurationseconds ) );
                break;
        }
    #/
    
    trigger thread function_4a5b553867d71fa9( duration, "gas_cleared" );
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 4
// Checksum 0x0, Offset: 0xd55
// Size: 0x82
function function_b3f6ad35b2a40677( location, radius, height, duration )
{
    if ( istrue( level.dangerzoneskipequipment ) )
    {
        return;
    }
    
    if ( isdefined( self.dangerzone ) )
    {
        scripts\mp\spawnlogic::removespawndangerzone( self.dangerzone );
    }
    
    self.dangerzone = scripts\mp\spawnlogic::addspawndangerzone( location, radius, height, self.owner.team, duration, self.owner, 1, self, 1 );
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 0
// Checksum 0x0, Offset: 0xddf
// Size: 0x1b, Type: bool
function function_4cd5239298745de7()
{
    return scripts\cp_mp\utility\game_utility::isbrstylegametype() && getdvarint( @"scr_gas_grenade_gas_mask_protection", 0 );
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 0
// Checksum 0x0, Offset: 0xe03
// Size: 0x1c, Type: bool
function function_97782fcb5ee69702()
{
    return scripts\cp_mp\utility\game_utility::isbrstylegametype() && getdvarint( @"hash_93c3a50d09e1989b", 1 );
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 0
// Checksum 0x0, Offset: 0xe28
// Size: 0xa
function sweepgas()
{
    thread gas_destroytrigger();
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 0
// Checksum 0x0, Offset: 0xe3a
// Size: 0xd2
function gas_destroytrigger()
{
    foreach ( player in self.playersintrigger )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        self.playersintrigger[ player getentitynumber() ] = undefined;
        player thread gas_onexittrigger( self getentitynumber() );
        
        if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
        {
            player setclientomnvar( "ui_br_player_is_in_gas_from_grenade", 0 );
        }
    }
    
    if ( isdefined( self.dangerzone ) )
    {
        scripts\mp\spawnlogic::removespawndangerzone( self.dangerzone );
    }
    
    scripts\cp_mp\ent_manager::deregisterspawn();
    
    if ( isdefined( self.badplace ) )
    {
        destroynavobstacle( self.badplace );
    }
    
    self delete();
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 2
// Checksum 0x0, Offset: 0xf14
// Size: 0x4c
function function_4a5b553867d71fa9( delaytime, var_aecde818fb1b329 )
{
    if ( isdefined( self.owner ) )
    {
        self.owner waittill_notify_or_timeout( "disconnect", delaytime );
    }
    else
    {
        wait delaytime;
    }
    
    if ( isdefined( var_aecde818fb1b329 ) )
    {
        self notify( var_aecde818fb1b329 );
    }
    
    thread gas_destroytrigger();
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 1
// Checksum 0x0, Offset: 0xf68
// Size: 0x245
function gas_onentertrigger( trigger )
{
    if ( !isdefined( self.gastriggerstouching ) )
    {
        self.gastriggerstouching = [];
    }
    
    entnum = trigger getentitynumber();
    self.gastriggerstouching[ entnum ] = trigger;
    self.lastgastouchtime = gettime();
    
    if ( getdvarint( @"hash_9ae216012f64affd" ) && isdefined( trigger.owner.chemist ) )
    {
        if ( issharedfuncdefined( "warlord_chemist", "periodicdamage" ) )
        {
            thread callsharedfunc( "warlord_chemist", "periodicdamage", trigger.owner.chemist.gasdamage, trigger.owner.chemist.var_2278441f7203ae, trigger.owner );
        }
        
        if ( isdefined( self.gasmaskhealth ) )
        {
            if ( self.gasmaskhealth > 0 )
            {
                if ( isdefined( level.var_f26b4e7eb9af8155 ) )
                {
                    self [[ level.var_f26b4e7eb9af8155 ]]( "gas_grenade" );
                }
                
                return entnum;
            }
        }
        
        if ( issharedfuncdefined( "warlord_chemist", "gasmask_watcher" ) && !istrue( self.gasmaskequipped ) )
        {
            thread callsharedfunc( "warlord_chemist", "gasmask_watcher" );
        }
    }
    
    if ( function_4cd5239298745de7() && isdefined( self.gasmaskhealth ) && self.gasmaskhealth > 0 )
    {
        return;
    }
    
    if ( function_97782fcb5ee69702() )
    {
        thread function_3a3f27425a46d2cb( trigger );
    }
    
    if ( self.gastriggerstouching.size >= 1 )
    {
        thread gas_applyspeedredux();
        thread gas_applyblur();
    }
    
    if ( self.gastriggerstouching.size == 1 )
    {
        thread gas_applycough( trigger.owner, 0 );
        scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudio( trigger.owner );
    }
    
    codcastersetplayerstatuseffect( "gas", -1 );
    
    if ( getdvarint( @"hash_9ae216012f64affd" ) && !istrue( self.var_ce8d114cc1b073db ) && issharedfuncdefined( "warlord_chemist", "removegastriggers" ) )
    {
        self.var_ce8d114cc1b073db = 1;
        thread callsharedfunc( "warlord_chemist", "removegastriggers" );
    }
    
    return entnum;
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x11b6
// Size: 0x9c
function gas_onexittrigger( triggerid )
{
    assertex( isdefined( triggerid ), "<dev string:x1c>" );
    
    if ( !isdefined( self.gastriggerstouching ) )
    {
        return;
    }
    
    self.gastriggerstouching[ triggerid ] = undefined;
    self.lastgastouchtime = gettime();
    
    if ( self.gastriggerstouching.size == 0 )
    {
        if ( isdefined( level.var_f26b4e7eb9af8155 ) )
        {
            self [[ level.var_c57ee1e174e42601 ]]( "gas_grenade" );
        }
        
        codcastersetplayerstatuseffect( "gas", 0 );
        thread gas_removespeedredux();
        thread gas_removeblur();
        scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudio();
        self notify( "gas_exited" );
    }
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x125a
// Size: 0x22b
function gas_watchtriggerenter()
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "trigger", player );
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isplayer( player ) )
        {
            if ( isagent( player ) )
            {
                if ( isdefined( self.owner ) && player scripts\common\utility::function_ec40425fb125f6cf( "tear_gas", self.owner.team ) )
                {
                    continue;
                }
                
                if ( !array_contains( self.var_aeeca2bc23f59ea4, player ) || isdefined( player.flashendtime ) && player.flashendtime < gettime() )
                {
                    self.var_aeeca2bc23f59ea4[ self.var_aeeca2bc23f59ea4.size ] = player;
                    
                    if ( isdefined( player.radimmune ) && player.radimmune )
                    {
                        continue;
                    }
                    
                    player notify( "flashbang", player.origin, 1, 1, self.owner, "axis", 9 );
                }
                
                if ( utility::issharedfuncdefined( "ai", "gasGrenade_onGasTrigger" ) )
                {
                    player thread [[ utility::getsharedfunc( "ai", "gasGrenade_onGasTrigger" ) ]]( self );
                }
            }
            
            continue;
        }
        
        if ( istrue( player.var_f8e21465665e3f81 ) )
        {
            continue;
        }
        
        if ( player scripts\mp\utility\killstreak::isjuggernaut() && !scripts\mp\utility\game::isjuggermoshgamemode() )
        {
            continue;
        }
        
        if ( ignoretriggerconditions( player ) )
        {
            continue;
        }
        
        if ( !player scripts\cp_mp\utility\player_utility::_isalive() )
        {
            continue;
        }
        
        if ( isdefined( self.playersintrigger[ player getentitynumber() ] ) )
        {
            continue;
        }
        
        if ( level.teambased )
        {
            if ( isdefined( self.owner ) && isalive( self.owner ) )
            {
                if ( player != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies( player, self.owner ) )
                {
                    continue;
                }
            }
            else if ( scripts\cp_mp\utility\player_utility::isfriendly( self.team, player ) )
            {
                continue;
            }
        }
        
        self.playersintrigger[ player getentitynumber() ] = player;
        
        if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
        {
            player setclientomnvar( "ui_br_player_is_in_gas_from_grenade", 1 );
        }
        
        player thread gas_onentertrigger( self );
    }
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x148d
// Size: 0xcb
function gas_watchtriggerexit()
{
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
            
            if ( !player scripts\cp_mp\utility\player_utility::_isalive() )
            {
                continue;
            }
            
            if ( player istouching( self ) && !ignoretriggerconditions( player ) )
            {
                continue;
            }
            
            self.playersintrigger[ player getentitynumber() ] = undefined;
            
            if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
            {
                player setclientomnvar( "ui_br_player_is_in_gas_from_grenade", 0 );
            }
            
            player thread gas_onexittrigger( self getentitynumber() );
        }
        
        waitframe();
    }
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x1560
// Size: 0x18, Type: bool
function ignoretriggerconditions( player )
{
    if ( player function_7ee20cf3c0390e21() )
    {
        return true;
    }
    
    return false;
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 2
// Checksum 0x0, Offset: 0x1581
// Size: 0xaa
function gas_applycough( attacker, fromimpact )
{
    var_a15ffac7e41222a2 = scripts\mp\utility\perk::_hasperk( "specialty_gas_grenade_resist" );
    var_8907f741f3a7b3f7 = isdefined( attacker ) && self == attacker;
    
    if ( !var_8907f741f3a7b3f7 && var_a15ffac7e41222a2 || istrue( self.inairpocket ) )
    {
        return;
    }
    
    isheavy = 0;
    
    if ( istrue( fromimpact ) )
    {
        isheavy = 1;
        
        if ( var_8907f741f3a7b3f7 )
        {
            isheavy = 0;
            
            /#
                if ( getdvarint( @"hash_6c7fd12a611ca1e8", 0 ) == 1 )
                {
                    isheavy = 1;
                }
            #/
        }
    }
    
    if ( !istrue( self.gascoughinprogress ) || istrue( fromimpact ) )
    {
        thread gas_queuecough( isheavy );
    }
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x1633
// Size: 0xd7
function gas_queuecough( isheavy )
{
    self endon( "death_or_disconnect" );
    self endon( "gas_clear_cough" );
    self endon( "gas_exited" );
    self notify( "gas_queue_cough" );
    self endon( "gas_queue_cough" );
    var_fff525b27a42fc40 = gettime() + 1000;
    
    while ( gas_coughisblocked() )
    {
        waitframe();
    }
    
    if ( isheavy && gettime() > var_fff525b27a42fc40 )
    {
        isheavy = 0;
    }
    
    var_81b4070b5858078d = getdvarint( @"hash_827901421ad0679", 1 ) == 1;
    
    if ( var_81b4070b5858078d )
    {
        thread gas_begincoughing( isheavy );
        return;
    }
    
    self endon( "gas_begin_coughing" );
    self.gascoughinprogress = 1;
    
    if ( isheavy )
    {
        self playgestureviewmodel( "iw9_ges_gas_cough_long" );
        wait 3.33;
    }
    else
    {
        self playgestureviewmodel( "iw9_ges_gas_cough" );
        wait 1.833;
    }
    
    self.gascoughinprogress = undefined;
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x1712
// Size: 0x143
function gas_begincoughing( isheavy )
{
    self endon( "death_or_disconnect" );
    self endon( "gas_clear_cough" );
    self notify( "gas_begin_coughing" );
    self endon( "gas_begin_coughing" );
    
    if ( !isnullweapon( self getheldoffhand() ) )
    {
        childthread gas_takeheldoffhand();
    }
    
    self.gascoughinprogress = 1;
    
    if ( self hasweapon( makeweapon( "gas_cough_light_mp" ) ) )
    {
        _takeweapon( "gas_cough_light_mp" );
    }
    
    if ( self hasweapon( makeweapon( "gas_cough_heavy_mp" ) ) )
    {
        _takeweapon( "gas_cough_heavy_mp" );
    }
    
    weaponobj = ter_op( istrue( isheavy ), makeweapon( "gas_cough_heavy_mp" ), makeweapon( "gas_cough_light_mp" ) );
    duration = ter_op( istrue( isheavy ), 3.33, 1.833 );
    val::set( "gas_grenade", "supers", 0 );
    self giveandfireoffhand( weaponobj );
    childthread gas_monitorcoughweaponfired( weaponobj );
    childthread gas_monitorcoughweapontaken( weaponobj );
    childthread gas_monitorcoughduration( duration );
    waittill_any_3( "gas_coughWeaponFired", "gas_coughWeaponTaken", "gas_coughDuration" );
    val::reset( "gas_grenade", "supers" );
    
    if ( self hasweapon( weaponobj ) )
    {
        _takeweapon( weaponobj );
    }
    
    self.gascoughinprogress = undefined;
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x185d
// Size: 0x3e
function gas_removecough( fromdeath )
{
    self notify( "gas_queue_cough" );
    self notify( "gas_begin_coughing" );
    self.gascoughinprogress = undefined;
    
    if ( !istrue( fromdeath ) )
    {
        if ( isdefined( self.gastakenweaponobj ) )
        {
            gas_restoreheldoffhand();
        }
    }
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x18a3
// Size: 0xba
function gas_clearcough( fromdeath )
{
    self notify( "gas_queue_cough" );
    self notify( "gas_begin_coughing" );
    self.gascoughinprogress = undefined;
    
    if ( !istrue( fromdeath ) )
    {
        var_81b4070b5858078d = getdvarint( @"hash_827901421ad0679", 1 ) == 1;
        
        if ( var_81b4070b5858078d )
        {
            if ( self hasweapon( makeweapon( "gas_cough_light_mp" ) ) )
            {
                _takeweapon( "gas_cough_light_mp" );
            }
            
            if ( self hasweapon( makeweapon( "gas_cough_heavy_mp" ) ) )
            {
                _takeweapon( "gas_cough_heavy_mp" );
            }
            
            if ( isdefined( self.gastakenweaponobj ) )
            {
                gas_restoreheldoffhand();
            }
            
            return;
        }
        
        self stopgestureviewmodel( "iw9_ges_gas_cough" );
        self stopgestureviewmodel( "iw9_ges_gas_cough_long" );
    }
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x1965
// Size: 0x4a
function gas_monitorcoughweaponfired( coughweaponobj )
{
    self endon( "gas_coughWeaponTaken" );
    self endon( "gas_coughDuration" );
    
    while ( true )
    {
        self waittill( "offhand_fired", weaponobj );
        
        if ( issameweapon( weaponobj, coughweaponobj ) )
        {
            break;
        }
    }
    
    self notify( "gas_coughWeaponFired" );
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x19b7
// Size: 0x2f
function gas_monitorcoughweapontaken( coughweaponobj )
{
    self endon( "gas_coughWeaponFired" );
    self endon( "gas_coughDuration" );
    
    while ( self hasweapon( coughweaponobj ) )
    {
        waitframe();
    }
    
    self notify( "gas_coughWeaponTaken" );
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x19ee
// Size: 0x23
function gas_monitorcoughduration( coughduration )
{
    self endon( "gas_coughWeaponTaken" );
    self endon( "gas_coughWeaponFired" );
    wait coughduration;
    self notify( "gas_coughDuration" );
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x1a19
// Size: 0x166
function gas_takeheldoffhand()
{
    if ( isdefined( self.gastakenweaponobj ) )
    {
        gas_restoreheldoffhand();
    }
    
    self endon( "gas_restoreHeldOffhand" );
    self.gastakenweaponobj = self getheldoffhand();
    equipmentref = scripts\mp\equipment::getequipmentreffromweapon( self.gastakenweaponobj );
    
    if ( isdefined( equipmentref ) && scripts\mp\equipment::hasequipment( equipmentref ) )
    {
        self.gastakenweaponammo = scripts\mp\equipment::getequipmentammo( equipmentref );
        _takeweapon( self.gastakenweaponobj );
        wait 0.05;
        thread gas_restoreheldoffhand();
    }
    
    superref = scripts\mp\supers::getsuperrefforsuperoffhand( self.gastakenweaponobj );
    
    if ( isdefined( superref ) )
    {
        currentsuperref = scripts\mp\supers::getcurrentsuperref();
        
        if ( isdefined( currentsuperref ) && currentsuperref == superref )
        {
            self.gastakenweaponammo = self getammocount( self.gastakenweaponobj );
            _takeweapon( self.gastakenweaponobj );
            wait 0.05;
            thread gas_restoreheldoffhand();
        }
    }
    
    isgesture = scripts\mp\utility\weapon::isgesture( self.gastakenweaponobj );
    
    if ( isgesture )
    {
        _takeweapon( self.gastakenweaponobj );
        wait 0.05;
        thread gas_restoreheldoffhand();
    }
    
    self.gastakenweaponammo = self getammocount( self.gastakenweaponobj );
    _takeweapon( self.gastakenweaponobj );
    wait 0.05;
    thread gas_restoreheldoffhand();
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x1b87
// Size: 0x23e
function gas_restoreheldoffhand()
{
    self notify( "gas_restoreHeldOffhand" );
    superref = scripts\mp\supers::getsuperrefforsuperoffhand( self.gastakenweaponobj );
    
    if ( isdefined( superref ) )
    {
        currentsuperref = scripts\mp\supers::getcurrentsuperref();
        
        if ( isdefined( currentsuperref ) && currentsuperref == superref )
        {
            _giveweapon( self.gastakenweaponobj );
            self assignweaponoffhandspecial( self.gastakenweaponobj );
            self setweaponammoclip( self.gastakenweaponobj, self.gastakenweaponammo );
            self.gastakenweaponobj = undefined;
            self.gastakenweaponammo = undefined;
        }
        
        return;
    }
    
    equipmentref = scripts\mp\equipment::getequipmentreffromweapon( self.gastakenweaponobj );
    
    if ( isdefined( equipmentref ) && scripts\mp\equipment::hasequipment( equipmentref ) )
    {
        if ( scripts\mp\equipment::hasequipment( equipmentref ) )
        {
            _giveweapon( self.gastakenweaponobj );
            slot = scripts\mp\equipment::findequipmentslot( equipmentref );
            assertex( isdefined( slot ) && ( slot == "<dev string:x54>" || slot == "<dev string:x5f>" ), "<dev string:x6c>" + equipmentref + "<dev string:x94>" );
            
            if ( slot == "primary" )
            {
                self assignweaponoffhandprimary( self.gastakenweaponobj );
            }
            else if ( slot == "secondary" )
            {
                self assignweaponoffhandsecondary( self.gastakenweaponobj );
            }
            
            scripts\mp\equipment::setequipmentammo( equipmentref, self.gastakenweaponammo );
            self.gastakenweaponobj = undefined;
            self.gastakenweaponammo = undefined;
        }
        
        return;
    }
    
    isgesture = scripts\mp\utility\weapon::isgesture( self.gastakenweaponobj );
    
    if ( isgesture )
    {
        if ( isdefined( self.gestureweapon ) && self.gestureweapon == self.gastakenweaponobj.basename )
        {
            _giveweapon( self.gastakenweaponobj );
            self.gastakenweaponobj = undefined;
        }
        
        return;
    }
    
    var_869d09b2ffbc5a27 = scripts\mp\supers::function_a465412785d4c550( self.gastakenweaponobj );
    
    if ( var_869d09b2ffbc5a27 )
    {
        self.gastakenweaponobj = undefined;
        return;
    }
    
    _giveweapon( self.gastakenweaponobj );
    self setweaponammoclip( self.gastakenweaponobj, self.gastakenweaponammo );
    self.gastakenweaponobj = undefined;
    self.gastakenweaponammo = undefined;
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x1dcd
// Size: 0x205
function gas_applyspeedredux()
{
    self endon( "death_or_disconnect" );
    self notify( "gas_modify_speed" );
    self endon( "gas_modify_speed" );
    
    if ( isdefined( self.gasspeedmod ) )
    {
        if ( self.gasspeedmod < -0.15 )
        {
            if ( scripts\mp\utility\perk::_hasperk( "specialty_gas_grenade_resist" ) )
            {
                scripts\mp\perks\perks::activateperk( "specialty_tac_resist" );
                self.gasspeedmod = -0.15;
                scripts\mp\weapons::updatemovespeedscale();
                return;
            }
            
            if ( isdefined( self.gastriggerstouching ) )
            {
                foreach ( trigger in self.gastriggerstouching )
                {
                    if ( isdefined( trigger ) && isdefined( trigger.owner ) && trigger.owner == self )
                    {
                        /#
                            if ( getdvarint( @"hash_6c7fd12a611ca1e8", 0 ) == 1 )
                            {
                                self.gasspeedmod = 0;
                                break;
                            }
                        #/
                        
                        self.gasspeedmod = -0.15;
                        scripts\mp\weapons::updatemovespeedscale();
                        return;
                    }
                }
            }
        }
    }
    else
    {
        self.gasspeedmod = 0;
    }
    
    targetspeedmod = -0.35;
    
    if ( scripts\mp\utility\perk::_hasperk( "specialty_gas_grenade_resist" ) )
    {
        targetspeedmod = -0.15;
    }
    else if ( isdefined( self.gastriggerstouching ) )
    {
        foreach ( trigger in self.gastriggerstouching )
        {
            if ( isdefined( trigger ) && isdefined( trigger.owner ) && trigger.owner == self )
            {
                /#
                    if ( getdvarint( @"hash_6c7fd12a611ca1e8", 0 ) == 1 )
                    {
                        break;
                    }
                #/
                
                targetspeedmod = -0.15;
            }
        }
    }
    
    gas_modifyspeed( targetspeedmod );
    self.gasspeedmod = targetspeedmod;
    scripts\mp\weapons::updatemovespeedscale();
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x1fda
// Size: 0x3f
function gas_removespeedredux()
{
    self endon( "death_or_disconnect" );
    self notify( "gas_modify_speed" );
    self endon( "gas_modify_speed" );
    
    if ( !isdefined( self.gasspeedmod ) )
    {
        return;
    }
    
    gas_modifyspeed( 0 );
    self.gasspeedmod = undefined;
    scripts\mp\weapons::updatemovespeedscale();
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x2021
// Size: 0x62
function gas_modifyspeed( targetspeedmod )
{
    timeelapsed = 0;
    
    while ( timeelapsed <= 0.65 )
    {
        timeelapsed += 0.05;
        self.gasspeedmod = math::lerp( self.gasspeedmod, targetspeedmod, min( 1, timeelapsed / 0.65 ) );
        scripts\mp\weapons::updatemovespeedscale();
        wait 0.05;
    }
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x208b
// Size: 0x29
function gas_clearspeedredux( fromdeath )
{
    self notify( "gas_modify_speed" );
    self.gasspeedmod = undefined;
    
    if ( !istrue( fromdeath ) )
    {
        scripts\mp\weapons::updatemovespeedscale();
    }
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x20bc
// Size: 0x101
function gas_applyblur()
{
    self endon( "death_or_disconnect" );
    self notify( "gas_modify_blur" );
    self endon( "gas_modify_blur" );
    shockfile = "gas_grenade_heavy_mp";
    
    if ( scripts\mp\utility\perk::_hasperk( "specialty_gas_grenade_resist" ) )
    {
        shockfile = "gas_grenade_light_mp";
    }
    else if ( isdefined( self.gastriggerstouching ) )
    {
        foreach ( trigger in self.gastriggerstouching )
        {
            if ( isdefined( trigger ) && isdefined( trigger.owner ) && trigger.owner == self )
            {
                /#
                    if ( getdvarint( @"hash_6c7fd12a611ca1e8", 0 ) == 1 )
                    {
                        break;
                    }
                #/
                
                shockfile = "gas_grenade_light_mp";
            }
        }
    }
    
    while ( true )
    {
        _shellshock( shockfile, "gas", 0.5, 0 );
        wait 0.2;
    }
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x21c5
// Size: 0xa
function gas_removeblur()
{
    self notify( "gas_modify_blur" );
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x21d7
// Size: 0x1f
function gas_clearblur( fromdeath )
{
    self notify( "gas_modify_blur" );
    
    if ( !istrue( fromdeath ) )
    {
        _stopshellshock();
    }
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x21fe
// Size: 0x38, Type: bool
function gas_shouldtakeheldoffhand()
{
    switch ( self getheldoffhand().basename )
    {
        case #"hash_3102ab88c5c102fc":
            return false;
        default:
            return true;
    }
    
    return false;
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x223f
// Size: 0x4e, Type: bool
function gas_coughisblocked()
{
    if ( !val::get( "cough_gesture" ) )
    {
        return true;
    }
    
    if ( !val::get( "offhand_weapons" ) )
    {
        return true;
    }
    
    if ( !isnullweapon( self getheldoffhand() ) && !gas_shouldtakeheldoffhand() )
    {
        return true;
    }
    
    if ( player::isinlaststand( self ) )
    {
        return true;
    }
    
    return false;
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x2296
// Size: 0x24, Type: bool
function gas_isintrigger()
{
    if ( !isdefined( self.gastriggerstouching ) )
    {
        return false;
    }
    
    if ( self.gastriggerstouching.size == 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x22c3
// Size: 0x36
function gas_updateplayereffects()
{
    if ( scripts\mp\utility\killstreak::isjuggernaut() && !scripts\mp\utility\game::isjuggermoshgamemode() )
    {
        gas_clear();
        return;
    }
    
    if ( gas_isintrigger() )
    {
        thread gas_applyspeedredux();
        thread gas_applyblur();
    }
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x2301
// Size: 0x10
function gas_getblurinterruptdelayms( duration )
{
    return 200;
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x231a
// Size: 0x149
function function_3a3f27425a46d2cb( trigger )
{
    victim = self;
    attacker = trigger.owner;
    victim endon( "death_or_disconnect" );
    victim endon( "gas_inflict_damage_end" );
    victim endon( "gas_exit" );
    victim notify( "gas_inflict_damage_reset" );
    victim endon( "gas_inflict_damage_reset" );
    victim thread function_8f331092cff3bb6b( trigger );
    var_9269e02033bdf484 = victim scripts\mp\utility\perk::_hasperk( "specialty_gas_grenade_resist" );
    var_14af965f6ea7998f = victim scripts\mp\utility\perk::_hasperk( "specialty_outlander" );
    var_576851e39bb1f1f1 = istrue( victim == attacker );
    damagetick = 5;
    
    if ( var_9269e02033bdf484 || var_14af965f6ea7998f || var_576851e39bb1f1f1 )
    {
        damagetick = 3;
    }
    
    damagetick = int( max( 1, damagetick ) );
    weapon = isdefined( trigger.weapon ) ? trigger.weapon : "gas_grenade_mp";
    
    while ( isdefined( trigger ) )
    {
        if ( !istrue( victim.inairpocket ) )
        {
            victim dodamage( damagetick, trigger.origin, trigger.owner, trigger, "MOD_TRIGGER_HURT", weapon, "none" );
            victim scripts\cp_mp\armor::damagearmor( damagetick );
        }
        
        wait 1;
    }
}

// Namespace gas_grenade / scripts\mp\equipment\gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x246b
// Size: 0x55
function function_8f331092cff3bb6b( trigger )
{
    victim = self;
    level endon( "game_ended" );
    victim endon( "death_or_disconnect" );
    victim notify( "gas_exit_damage_reset" );
    victim endon( "gas_exit_damage_reset" );
    victim waittill_notify_or_timeout( "gas_exited", trigger.duration );
    victim notify( "gas_inflict_damage_end" );
}

