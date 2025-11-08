#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\utility;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\killstreaks\white_phosphorus;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\engine\math;
#using scripts\engine\utility;

#namespace cp_gas_grenade;

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x3c5
// Size: 0x4c
function gas_used( grenade )
{
    self endon( "disconnect" );
    grenade endon( "death" );
    team = grenade.owner.team;
    thread gas_watchexplode( grenade, team );
    thread function_60397906a6eb5a4f( grenade );
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 2
// Checksum 0x0, Offset: 0x419
// Size: 0x73
function gas_watchexplode( grenade, team )
{
    grenade thread scripts\cp\utility::notifyafterframeend( "death", "end_explode" );
    grenade endon( "end_explode" );
    owner = undefined;
    
    if ( isdefined( grenade.owner ) )
    {
        owner = grenade.owner;
    }
    
    grenade waittill( "explode", position );
    thread gas_createtrigger( position, owner, team );
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x494
// Size: 0x36
function function_60397906a6eb5a4f( grenade )
{
    grenade endon( "explode" );
    grenade waittill( "missile_water_impact", impactdata );
    grenade notify( "end_explode" );
    thread function_da09131c75ad4b63( grenade );
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x4d2
// Size: 0x7a
function function_da09131c75ad4b63( grenade )
{
    grenade waittill( "missile_stuck", stuckdata );
    owner = grenade.owner;
    team = grenade.team;
    position = grenade.origin;
    grenade thread gas_createtrigger( position + ( 0, 0, 10 ), owner, team );
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x554
// Size: 0xa9, Type: bool
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
    
    if ( data.attacker != data.victim )
    {
    }
    
    data.victim thread gas_applycough( data.attacker, 1 );
    return true;
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x606
// Size: 0x9d
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

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 7
// Checksum 0x0, Offset: 0x6ab
// Size: 0x119
function gas_createtrigger( position, owner, team, duration, scale, iscrossbow, crossbowlevel )
{
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
    
    trigger = spawn( "trigger_radius", position + ( 0, 0, int( -57.75 * scale ) ), 0, int( 256 * scale ), int( 175 * scale ) );
    trigger scripts\cp_mp\ent_manager::registerspawn( 1, &sweepgas );
    trigger endon( "death" );
    trigger.owner = owner;
    trigger.team = team;
    trigger.playersintrigger = [];
    trigger thread gas_watchtriggerenter();
    trigger thread gas_watchtriggerexit();
    trigger thread gas_badplace( duration, scale );
    wait duration;
    trigger thread gas_destroytrigger();
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x7cc
// Size: 0xa
function sweepgas()
{
    thread gas_destroytrigger();
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x7de
// Size: 0x80
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
    }
    
    scripts\cp_mp\ent_manager::deregisterspawn();
    self delete();
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x866
// Size: 0x123
function gas_onentertrigger( trigger )
{
    if ( !isdefined( self.gastriggerstouching ) )
    {
        self.gastriggerstouching = [];
    }
    
    entnum = trigger getentitynumber();
    self.gastriggerstouching[ entnum ] = trigger;
    self.lastgastouchtime = gettime();
    
    if ( isplayer( self ) )
    {
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
    }
    else
    {
        weap = makeweapon( "gas_mp" );
        self dodamage( 1, self.origin, trigger.owner, trigger, "MOD_GRENADE_SPLASH", weap );
        self notify( "flashbang", self.origin, 1, 1, trigger.owner, "axis", 9 );
        scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudio( trigger.owner );
    }
    
    return entnum;
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x992
// Size: 0x83
function gas_onexittrigger( triggerid )
{
    assertex( isdefined( triggerid ), "gas_onExitTrigger called with an invalid trigger ID." );
    
    if ( !isdefined( self.gastriggerstouching ) )
    {
        return;
    }
    
    self.gastriggerstouching[ triggerid ] = undefined;
    self.lastgastouchtime = gettime();
    
    if ( isplayer( self ) )
    {
        if ( self.gastriggerstouching.size == 0 )
        {
            thread gas_removespeedredux();
            thread gas_removeblur();
            scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudio();
        }
    }
    else
    {
        scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudio();
    }
    
    self notify( "gas_exited" );
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 0
// Checksum 0x0, Offset: 0xa1d
// Size: 0xd8
function gas_watchtriggerenter()
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "trigger", player );
        
        if ( !isplayer( player ) && !isagent( player ) )
        {
            continue;
        }
        
        if ( istrue( player.isjuggernaut ) )
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
        
        if ( isdefined( self.owner ) && isalive( self.owner ) )
        {
            if ( player != self.owner && !istrue( scripts\cp_mp\utility\player_utility::playersareenemies( player, self.owner ) ) )
            {
                continue;
            }
        }
        else
        {
            continue;
        }
        
        self.playersintrigger[ player getentitynumber() ] = player;
        player thread gas_onentertrigger( self );
    }
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 0
// Checksum 0x0, Offset: 0xafd
// Size: 0xb2
function gas_watchtriggerexit()
{
    self endon( "death" );
    
    while ( true )
    {
        foreach ( player in self.playersintrigger )
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
            player thread gas_onexittrigger( self getentitynumber() );
        }
        
        waitframe();
    }
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0xbb7
// Size: 0x18, Type: bool
function ignoretriggerconditions( player )
{
    if ( player function_7ee20cf3c0390e21() )
    {
        return true;
    }
    
    return false;
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 2
// Checksum 0x0, Offset: 0xbd8
// Size: 0xdf
function gas_badplace( duration, scale )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    navobstaclescaler = 0.66;
    pre_wait = duration * 0.15;
    post_wait = duration * 0.25;
    assertex( pre_wait + post_wait <= duration, "Incorrect pre/post wait values" );
    wait pre_wait;
    navobstacleradius = 256 * scale * navobstaclescaler;
    navobstacleheight = 175 * scale * navobstaclescaler;
    zeroangles = ( 0, 0, 0 );
    navobstacle = createnavbadplacebyshape( self.origin, zeroangles, 8, navobstacleradius, navobstacleheight );
    wait max( 0.05, duration - pre_wait - post_wait );
    
    if ( isdefined( navobstacle ) )
    {
        destroynavobstacle( navobstacle );
    }
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 2
// Checksum 0x0, Offset: 0xcbf
// Size: 0x9d
function gas_applycough( attacker, fromimpact )
{
    var_a15ffac7e41222a2 = scripts\cp\utility::_hasperk( "specialty_gas_grenade_resist" );
    var_8907f741f3a7b3f7 = isdefined( attacker ) && self == attacker;
    
    if ( !var_8907f741f3a7b3f7 && var_a15ffac7e41222a2 )
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

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0xd64
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

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0xe43
// Size: 0x120
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
    self giveandfireoffhand( weaponobj );
    childthread gas_monitorcoughweaponfired( weaponobj );
    childthread gas_monitorcoughweapontaken( weaponobj );
    childthread gas_monitorcoughduration( duration );
    waittill_any_3( "gas_coughWeaponFired", "gas_coughWeaponTaken", "gas_coughDuration" );
    
    if ( self hasweapon( weaponobj ) )
    {
        _takeweapon( weaponobj );
    }
    
    self.gascoughinprogress = undefined;
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0xf6b
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

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0xfb1
// Size: 0xb9
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

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x1072
// Size: 0x49
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

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x10c3
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

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x10fa
// Size: 0x23
function gas_monitorcoughduration( coughduration )
{
    self endon( "gas_coughWeaponTaken" );
    self endon( "gas_coughWeaponFired" );
    wait coughduration;
    self notify( "gas_coughDuration" );
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x1125
// Size: 0xe7
function gas_takeheldoffhand()
{
    if ( isdefined( self.gastakenweaponobj ) )
    {
        gas_restoreheldoffhand();
    }
    
    self endon( "gas_restoreHeldOffhand" );
    self.gastakenweaponobj = self getheldoffhand();
    equipmentref = scripts\cp_mp\equipment::getequipmentreffromweapon( self.gastakenweaponobj );
    
    if ( isdefined( equipmentref ) && scripts\cp_mp\equipment::hasequipment( equipmentref ) )
    {
        self.gastakenweaponammo = scripts\cp_mp\equipment::getequipmentammo( equipmentref );
        _takeweapon( self.gastakenweaponobj );
        waitframe();
        thread gas_restoreheldoffhand();
    }
    
    isgesture = scripts\cp\utility::isgesture( self.gastakenweaponobj );
    
    if ( isgesture )
    {
        _takeweapon( self.gastakenweaponobj );
        waitframe();
        thread gas_restoreheldoffhand();
    }
    
    self.gastakenweaponammo = self getammocount( self.gastakenweaponobj );
    _takeweapon( self.gastakenweaponobj );
    waitframe();
    thread gas_restoreheldoffhand();
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x1214
// Size: 0x185
function gas_restoreheldoffhand()
{
    self notify( "gas_restoreHeldOffhand" );
    equipmentref = scripts\cp_mp\equipment::getequipmentreffromweapon( self.gastakenweaponobj );
    
    if ( isdefined( equipmentref ) && scripts\cp_mp\equipment::hasequipment( equipmentref ) )
    {
        _giveweapon( self.gastakenweaponobj );
        slot = scripts\cp_mp\equipment::findequipmentslot( equipmentref );
        assertex( isdefined( slot ) && ( slot == "primary" || slot == "secondary" ), "gas_restoreHeldOffhand is trying to " + equipmentref + ", but its slot is invalid." );
        
        if ( slot == "primary" )
        {
            self assignweaponoffhandprimary( self.gastakenweaponobj );
        }
        else if ( slot == "secondary" )
        {
            self assignweaponoffhandsecondary( self.gastakenweaponobj );
        }
        
        scripts\cp_mp\equipment::setequipmentammo( equipmentref, self.gastakenweaponammo );
        self.gastakenweaponobj = undefined;
        self.gastakenweaponammo = undefined;
        return;
    }
    
    isgesture = scripts\cp\utility::isgesture( self.gastakenweaponobj );
    
    if ( isgesture )
    {
        if ( isdefined( self.gestureweapon ) && self.gestureweapon == self.gastakenweaponobj.basename )
        {
            _giveweapon( self.gastakenweaponobj );
            self.gastakenweaponobj = undefined;
        }
        
        return;
    }
    
    _giveweapon( self.gastakenweaponobj );
    self setweaponammoclip( self.gastakenweaponobj, self.gastakenweaponammo );
    self.gastakenweaponobj = undefined;
    self.gastakenweaponammo = undefined;
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x13a1
// Size: 0x8c
function get_power_ref_from_weapon( objweapon )
{
    ref = objweapon.basename;
    
    foreach ( struct in level.powers )
    {
        if ( isdefined( struct.weaponuse ) )
        {
            if ( ref == struct.weaponuse )
            {
                return key;
            }
        }
    }
    
    return undefined;
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x1436
// Size: 0x207
function gas_applyspeedredux()
{
    self endon( "death_or_disconnect" );
    self notify( "gas_modify_speed" );
    self endon( "gas_modify_speed" );
    
    if ( isdefined( self.gasspeedmod ) )
    {
        if ( self.gasspeedmod < -0.15 )
        {
            if ( scripts\cp\utility::_hasperk( "specialty_gas_grenade_resist" ) )
            {
                self.gasspeedmod = -0.15;
                self [[ level.move_speed_scale ]]();
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
                        self [[ level.move_speed_scale ]]();
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
    
    if ( scripts\cp\utility::_hasperk( "specialty_gas_grenade_resist" ) )
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
    self [[ level.move_speed_scale ]]();
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x1645
// Size: 0x45
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
    self [[ level.move_speed_scale ]]();
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x1692
// Size: 0x67
function gas_modifyspeed( targetspeedmod )
{
    timeelapsed = 0;
    
    while ( timeelapsed <= 0.65 )
    {
        timeelapsed += 0.05;
        self.gasspeedmod = math::lerp( self.gasspeedmod, targetspeedmod, min( 1, timeelapsed / 0.65 ) );
        self [[ level.move_speed_scale ]]();
        wait 0.05;
    }
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x1701
// Size: 0x2f
function gas_clearspeedredux( fromdeath )
{
    self notify( "gas_modify_speed" );
    self.gasspeedmod = undefined;
    
    if ( !istrue( fromdeath ) )
    {
        self [[ level.move_speed_scale ]]();
    }
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x1738
// Size: 0xff
function gas_applyblur()
{
    self endon( "death_or_disconnect" );
    self notify( "gas_modify_blur" );
    self endon( "gas_modify_blur" );
    shockfile = "gas_grenade_heavy_mp";
    
    if ( scripts\cp\utility::_hasperk( "specialty_gas_grenade_resist" ) )
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

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x183f
// Size: 0xa
function gas_removeblur()
{
    self notify( "gas_modify_blur" );
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x1851
// Size: 0x1f
function gas_clearblur( fromdeath )
{
    self notify( "gas_modify_blur" );
    
    if ( !istrue( fromdeath ) )
    {
        _stopshellshock();
    }
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x1878
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

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x18b9
// Size: 0x41, Type: bool
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
    
    return false;
}

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x1903
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

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 0
// Checksum 0x0, Offset: 0x1930
// Size: 0x30
function gas_updateplayereffects()
{
    if ( istrue( self.isjuggernaut ) )
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

// Namespace cp_gas_grenade / scripts\cp\equipment\cp_gas_grenade
// Params 1
// Checksum 0x0, Offset: 0x1968
// Size: 0x10
function gas_getblurinterruptdelayms( duration )
{
    return 200;
}

