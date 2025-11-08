#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment\temp_v;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\perks\perkpackage;
#using scripts\mp\supers;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;

#namespace super_laser_charge;

// Namespace super_laser_charge / scripts\mp\supers\super_laser_charge
// Params 0
// Checksum 0x0, Offset: 0x653
// Size: 0x1c2
function function_38a4f67440cf220e()
{
    scripts\common\values::group_register( "laserRaise", [ "allow_jump", "mantle", "melee", "usability", "killstreaks", "supers", "gesture", "allow_movement", "offhand_weapons", "crouch", "prone", "sprint", "execution_attack", "execution_victim" ] );
    scripts\common\values::group_register( "laserFire", [ "allow_jump", "mantle", "melee", "usability", "killstreaks", "supers", "gesture", "weapon_switch", "allow_movement", "offhand_weapons", "crouch", "prone", "sprint", "execution_attack", "execution_victim" ] );
    scripts\common\values::group_register( "laserDrop", [ "allow_jump", "mantle", "melee", "usability", "killstreaks", "supers", "gesture", "allow_movement", "offhand_weapons", "crouch", "prone", "sprint", "execution_attack", "execution_victim" ] );
    scripts\engine\utility::registersharedfunc( "super_laser_charge", "tryUse", &function_2b8f6cdb729062b4 );
}

// Namespace super_laser_charge / scripts\mp\supers\super_laser_charge
// Params 0
// Checksum 0x0, Offset: 0x81d
// Size: 0x1e, Type: bool
function function_37ddcde87b74cc48()
{
    result = function_2b8f6cdb729062b4( undefined );
    
    if ( !istrue( result ) )
    {
        return false;
    }
    
    return true;
}

// Namespace super_laser_charge / scripts\mp\supers\super_laser_charge
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x844
// Size: 0x3a8, Type: bool
function private function_2b8f6cdb729062b4( killstreakbundle )
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    if ( self isswimming() )
    {
        if ( issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            self [[ getsharedfunc( "hud", "showErrorMessage" ) ]]( "SUPER_MP/SUPER_CANNOT_USE_SWIM" );
        }
        
        return false;
    }
    
    if ( !self isonground() )
    {
        if ( issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            self [[ getsharedfunc( "hud", "showErrorMessage" ) ]]( "SUPER_MP/SUPER_CANNOT_USE_AIR" );
        }
        
        return false;
    }
    
    if ( scripts\cp_mp\utility\player_utility::isinvehicle( 1 ) )
    {
        return false;
    }
    
    cannotstand = self getstanceblocked( "stand" );
    
    if ( istrue( cannotstand ) )
    {
        if ( issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            self [[ getsharedfunc( "hud", "showErrorMessage" ) ]]( "SUPER_MP/SUPER_CANNOT_USE_SPACE" );
        }
        
        return false;
    }
    
    starttrace = self.origin + ( 0, 0, 5 );
    endtrace = starttrace + ( 0, 0, 80 );
    contentoverride = create_contents( 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0 );
    heighttrace = ray_trace( starttrace, endtrace, self, contentoverride );
    
    if ( isdefined( heighttrace ) )
    {
        if ( heighttrace[ "hittype" ] != "hittype_none" || !sphere_trace_passed( endtrace, endtrace, 15, self, contentoverride ) )
        {
            /#
                level thread scripts\cp_mp\utility\debug_utility::drawline( starttrace, endtrace, 10, ( 1, 0, 0 ) );
                level thread scripts\cp_mp\utility\debug_utility::drawsphere( endtrace, 20, 10, ( 1, 0, 0 ) );
                level thread scripts\cp_mp\utility\debug_utility::drawsphere( heighttrace[ "<dev string:x1c>" ], 5, 10, ( 1, 1, 0 ) );
            #/
            
            if ( issharedfuncdefined( "hud", "showErrorMessage" ) )
            {
                self [[ getsharedfunc( "hud", "showErrorMessage" ) ]]( "SUPER_MP/SUPER_CANNOT_USE_SPACE" );
            }
            
            return false;
        }
    }
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        self setclientomnvar( "ui_br_inventory_disabled", 1 );
    }
    
    currentstance = self getstance();
    
    if ( currentstance != "stand" )
    {
        self setstance( "stand" );
    }
    
    laststancechange = self.pers[ "lastStanceChangeTime" ];
    
    if ( isdefined( laststancechange ) )
    {
        stancetimediff = ( gettime() - laststancechange ) / 1000;
        remainingwait = 0;
        
        if ( stancetimediff < 0.8 )
        {
            remainingwait = 0.8 - stancetimediff;
        }
        
        if ( remainingwait > 0 )
        {
            wait remainingwait;
        }
    }
    
    scripts\common\values::group_set( "laserRaise", 0 );
    
    if ( !isdefined( killstreakbundle ) )
    {
        self setclientomnvar( "ui_field_upgrade_use", 0 );
    }
    
    giveperk( "specialty_super_protection" );
    deployweapon = isdefined( killstreakbundle ) && isdefined( killstreakbundle.var_69539d680440246 ) ? killstreakbundle.var_69539d680440246 : "super_laser_charge_mp";
    objweapon = makeweapon( deployweapon, [ "lasercustom_super_laser" ] );
    _giveweapon( objweapon );
    thread function_f9c583614e43d70b();
    self setscriptablepartstate( "superpowers", "laser_charge", 0 );
    deploysuccess = domonitoredweaponswitch( objweapon, 1, 1 );
    
    if ( !istrue( deploysuccess ) )
    {
        self setscriptablepartstate( "superpowers", "off", 0 );
        removeperk( "specialty_super_protection" );
        scripts\common\values::group_reset( "laserRaise" );
        thread getridofweapon( objweapon, 1 );
        
        if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
        {
            self setclientomnvar( "ui_br_inventory_disabled", 0 );
        }
        
        return false;
    }
    
    function_57e6c0e97f405130( objweapon, killstreakbundle );
    return true;
}

// Namespace super_laser_charge / scripts\mp\supers\super_laser_charge
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xbf5
// Size: 0x4c
function private function_f9c583614e43d70b()
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    oldsuit = self.suit;
    newsuit = "iw9_laser_eye_mp";
    _setsuit( newsuit );
    self waittill( "superLaserCharge_finished" );
    _setsuit( oldsuit );
}

// Namespace super_laser_charge / scripts\mp\supers\super_laser_charge
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xc49
// Size: 0x92
function private function_57e6c0e97f405130( laserweapon, killstreakbundle )
{
    if ( !isdefined( killstreakbundle ) )
    {
        self.super.isactive = 1;
    }
    
    giveperk( "specialty_third_person" );
    function_3a9f59811a994a17();
    thread superlasercharge_watchforgameended( killstreakbundle );
    impactent = spawn( "script_model", self gettagorigin( "tag_eye" ) );
    impactent setmodel( "super_laser_charge_impact" );
    impactent dontinterpolate();
    thread function_d962bef837cc0b26( laserweapon, impactent, killstreakbundle );
    thread function_701f65bff172b328( impactent );
}

// Namespace super_laser_charge / scripts\mp\supers\super_laser_charge
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0xce3
// Size: 0x235
function private function_d962bef837cc0b26( laserweapon, impactent, killstreakbundle )
{
    self endon( "disconnect" );
    scripts\common\values::group_reset( "laserRaise" );
    scripts\common\values::group_set( "laserFire", 0 );
    thread function_2fd73aeab5c5946d( impactent, killstreakbundle );
    thread function_fc9013fb22941577();
    shouldfinish = 0;
    dontclear = 1;
    var_117a5f27b3ffab8e = 0;
    startedfiring = 0;
    shouldrefund = 0;
    maxclipammo = weaponclipsize( laserweapon );
    
    while ( !istrue( self.var_2dd3e994a0214ad1 ) )
    {
        currentweapon = self getcurrentweapon();
        currentammo = self getweaponammoclip( laserweapon );
        
        if ( currentweapon == laserweapon )
        {
            if ( !istrue( startedfiring ) )
            {
                startedfiring = 1;
                self notify( "superLaserCharge_start_fire" );
            }
        }
        
        if ( !istrue( function_769566ab9e727f94( currentweapon, laserweapon ) ) )
        {
            var_117a5f27b3ffab8e = 1;
            
            if ( !isreallyalive( self ) || isinlaststand( self ) )
            {
                shouldfinish = 1;
            }
            
            if ( istrue( startedfiring ) )
            {
                dontclear = 0;
            }
            else
            {
                shouldrefund = 1;
            }
            
            break;
        }
        
        if ( currentammo <= 10 )
        {
            break;
        }
        
        waitframe();
    }
    
    self notify( "superLaserCharge_stop_fire" );
    
    if ( istrue( var_117a5f27b3ffab8e ) || istrue( self.var_2dd3e994a0214ad1 ) )
    {
        scripts\common\values::group_reset( "laserFire" );
        thread getridofweapon( laserweapon, 1 );
        self notify( "superLaserCharge_finished" );
        removeperk( "specialty_third_person" );
        removeperk( "specialty_super_protection" );
        
        if ( istrue( self.var_2dd3e994a0214ad1 ) )
        {
            self.var_2dd3e994a0214ad1 = undefined;
            self stopforcedfire();
        }
    }
    else
    {
        scripts\common\values::group_reset( "laserFire" );
        scripts\common\values::group_set( "laserDrop", 0 );
        thread getridofweapon( laserweapon );
        wait 1;
        self notify( "superLaserCharge_finished" );
        removeperk( "specialty_third_person" );
        removeperk( "specialty_super_protection" );
        scripts\common\values::group_reset( "laserDrop" );
    }
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        self setclientomnvar( "ui_br_inventory_disabled", 0 );
    }
    
    scripts\mp\equipment\temp_v::function_269b97f3d86eb172( shouldfinish, 0, undefined, isdefined( killstreakbundle ) );
    
    if ( istrue( shouldrefund ) )
    {
        function_76ac6722cb845c98( killstreakbundle );
        return;
    }
    
    if ( isdefined( killstreakbundle ) )
    {
        self notify( "superLaserCharge_finishedWithoutRefund" );
    }
}

// Namespace super_laser_charge / scripts\mp\supers\super_laser_charge
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xf20
// Size: 0x25
function private function_fc9013fb22941577()
{
    self endon( "disconnect" );
    self endon( "superLaserCharge_start_fire" );
    self endon( "superLaserCharge_stop_fire" );
    wait 2;
    self.var_2dd3e994a0214ad1 = 1;
}

// Namespace super_laser_charge / scripts\mp\supers\super_laser_charge
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xf4d
// Size: 0x71, Type: bool
function private function_769566ab9e727f94( currentweapon, laserweapon )
{
    hasgameended = istrue( level.gameended );
    var_a80fe11aed36c72 = currentweapon == laserweapon;
    return isreallyalive( self ) && self isonground() && istrue( var_a80fe11aed36c72 ) && !isinlaststand( self ) && !self isswimming() && !self isonladder() && !hasgameended;
}

// Namespace super_laser_charge / scripts\mp\supers\super_laser_charge
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xfc7
// Size: 0x1a7
function private function_3a9f59811a994a17()
{
    traceoffset = 50;
    starttrace = self gettagorigin( "j_spineupper" );
    righttraceend = starttrace + anglestoright( self.angles ) * traceoffset;
    var_d809cfcc948bb9ff = ray_trace( starttrace, righttraceend, self, create_default_contents( 1 ) );
    var_d8b6b92db6431a66 = undefined;
    
    if ( isdefined( var_d809cfcc948bb9ff ) && var_d809cfcc948bb9ff[ "hittype" ] != "hittype_none" )
    {
        var_d8b6b92db6431a66 = distance2dsquared( starttrace, var_d809cfcc948bb9ff[ "position" ] );
        
        /#
            level thread scripts\cp_mp\utility\debug_utility::drawline( starttrace, righttraceend, 10, ( 1, 0, 0 ) );
            level thread scripts\cp_mp\utility\debug_utility::drawsphere( var_d809cfcc948bb9ff[ "<dev string:x1c>" ], 5, 10, ( 1, 0, 0 ) );
        #/
    }
    
    lefttraceend = starttrace - anglestoright( self.angles ) * traceoffset;
    var_bdf14b0d52e29044 = ray_trace( starttrace, lefttraceend, self, create_default_contents( 1 ) );
    var_e386728fd4c32e07 = undefined;
    
    if ( isdefined( var_bdf14b0d52e29044 ) && var_bdf14b0d52e29044[ "hittype" ] != "hittype_none" )
    {
        var_e386728fd4c32e07 = distance2dsquared( starttrace, var_bdf14b0d52e29044[ "position" ] );
        
        /#
            level thread scripts\cp_mp\utility\debug_utility::drawline( starttrace, lefttraceend, 10, ( 0, 1, 0 ) );
            level thread scripts\cp_mp\utility\debug_utility::drawsphere( var_bdf14b0d52e29044[ "<dev string:x1c>" ], 5, 10, ( 0, 1, 0 ) );
        #/
    }
    
    shoulderside = 1;
    
    if ( isdefined( var_d8b6b92db6431a66 ) && isdefined( var_e386728fd4c32e07 ) && var_d8b6b92db6431a66 > var_e386728fd4c32e07 )
    {
        shoulderside = 0;
        return;
    }
    
    if ( !isdefined( var_d8b6b92db6431a66 ) )
    {
        shoulderside = 0;
    }
}

// Namespace super_laser_charge / scripts\mp\supers\super_laser_charge
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1176
// Size: 0xda
function private function_2fd73aeab5c5946d( impactent, killstreakbundle )
{
    self endon( "disconnect" );
    
    /#
        thread function_faa526904671fdb4();
    #/
    
    self startforcedfire();
    self playsoundtoplayer( "weap_lasereyes_levitate", self );
    self playsound( "weap_lasereyes_levitate_npc", self, self );
    raiseresult = waittill_any_timeout_1( 1.5, "superLaserCharge_stop_fire" );
    
    if ( !isdefined( raiseresult ) || raiseresult != "timeout" )
    {
        self stopforcedfire();
        return;
    }
    
    if ( !isdefined( killstreakbundle ) )
    {
        thread scripts\mp\supers::updateusetimedecay();
    }
    
    self playsoundtoplayer( "weap_laser_fire_start", self );
    self playsound( "weap_laser_fire_start_npc", self, self );
    self waittill( "superLaserCharge_stop_fire" );
    self playsoundtoplayer( "weap_laser_fire_stop", self );
    self playsound( "weap_laser_fire_stop_npc", self, self );
    self stopforcedfire();
    
    if ( isdefined( impactent ) )
    {
        impactent delete();
    }
}

// Namespace super_laser_charge / scripts\mp\supers\super_laser_charge
// Params 1
// Checksum 0x0, Offset: 0x1258
// Size: 0x4c
function function_701f65bff172b328( impactent )
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    while ( isdefined( impactent ) )
    {
        var_6a31d62c64e37d60 = scripts\cp_mp\utility\player_utility::getplayerlookatpos( self );
        
        if ( isdefined( var_6a31d62c64e37d60 ) )
        {
            impactent.origin = var_6a31d62c64e37d60;
        }
        
        wait 0.05;
    }
}

// Namespace super_laser_charge / scripts\mp\supers\super_laser_charge
// Params 1
// Checksum 0x0, Offset: 0x12ac
// Size: 0x48, Type: bool
function function_4595a2e368e64b18( fromdeath )
{
    self.super.isactive = 0;
    
    if ( utility::issharedfuncdefined( "br", "superSlotCleanUp" ) )
    {
        [[ utility::getsharedfunc( "br", "superSlotCleanUp" ) ]]( self );
    }
    
    return false;
}

// Namespace super_laser_charge / scripts\mp\supers\super_laser_charge
// Params 0
// Checksum 0x0, Offset: 0x12fd
// Size: 0x6e
function function_be41fd9988f890d9()
{
    if ( getgametype() != "infect" )
    {
        scripts\mp\supers::combatrecordsuperkill( "super_laser_charge" );
        self.var_e3ca8ebb9ba5260d++;
        var_2a46027b0350b6aa = scripts\mp\supers::getcombatrecordsupermisc( "super_laser_charge" );
        
        if ( self.var_e3ca8ebb9ba5260d > var_2a46027b0350b6aa )
        {
            increment = self.var_e3ca8ebb9ba5260d - var_2a46027b0350b6aa;
            scripts\mp\supers::combatrecordsupermisc( "super_laser_charge", increment );
        }
    }
}

// Namespace super_laser_charge / scripts\mp\supers\super_laser_charge
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1373
// Size: 0x47
function private superlasercharge_watchforgameended( killstreakbundle )
{
    self endon( "death_or_disconnect" );
    self endon( "super_use_finished" );
    self notify( "superLaserCharge_watchForGameEnded" );
    self endon( "superLaserCharge_watchForGameEnded" );
    level waittill_any_2( "game_ended", "prematch_cleanup" );
    
    if ( !isdefined( killstreakbundle ) )
    {
        thread scripts\mp\supers::superusefinished();
    }
}

// Namespace super_laser_charge / scripts\mp\supers\super_laser_charge
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x13c2
// Size: 0x46
function private function_76ac6722cb845c98( killstreakbundle )
{
    if ( isdefined( killstreakbundle ) )
    {
        self notify( "superLaserCharge_refund" );
        return;
    }
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        scripts\mp\gametypes\br_pickups::_givebrsuper( "equip_laser_charge", "super_laser_charge", 1 );
        return;
    }
    
    scripts\mp\perks\perkpackage::perkpackage_giveimmediate( "super_laser_charge" );
}

/#

    // Namespace super_laser_charge / scripts\mp\supers\super_laser_charge
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x1410
    // Size: 0x1a, Type: dev
    function private function_faa526904671fdb4()
    {
        self endon( "<dev string:x28>" );
        self endon( "<dev string:x3f>" );
        level endon( "<dev string:x5c>" );
    }

#/
