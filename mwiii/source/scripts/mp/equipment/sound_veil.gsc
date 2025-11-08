#using scripts\anim\combat_utility;
#using scripts\common\ae_utility;
#using scripts\common\elevators;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\utility\callback_group;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\damage;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\shellshock;
#using scripts\mp\supers;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;

#namespace sound_veil;

/#

    // Namespace sound_veil / scripts\mp\equipment\sound_veil
    // Params 0
    // Checksum 0x0, Offset: 0x4e6
    // Size: 0x25, Type: dev
    function function_735ed2b006dce0eb()
    {
        setdevdvarifuninitialized( @"hash_7ab7001b47624fdc", 0 );
        setdevdvarifuninitialized( @"hash_aa851e1cd1444734", 0 );
    }

#/

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0x513
// Size: 0x379
function function_6d91f8514005d18( grenade )
{
    grenade endon( "death" );
    self endon( "disconnect" );
    
    /#
        printgameaction( "<dev string:x1c>", self );
    #/
    
    if ( !isdefined( level.var_4405e76242d7cb8e ) )
    {
        level.var_4405e76242d7cb8e = 0;
    }
    
    grenade scripts\cp_mp\ent_manager::registerspawn( 1, &function_558d562eb33ea61d );
    thread scripts\mp\weapons::monitordisownedgrenade( self, grenade );
    grenade setscriptablepartstate( "visibility", "show", 0 );
    grenade waittill( "missile_stuck", stuckto );
    
    if ( isdefined( stuckto ) && stuckto isvehicle() )
    {
        grenade.vehicle_stuck = 1;
    }
    
    if ( isdefined( level.var_ca4e08767cbdae12 ) )
    {
        canplant = grenade [[ level.var_ca4e08767cbdae12 ]]();
        
        if ( !canplant )
        {
            scripts\mp\supers::refundsuper();
            scripts\mp\hud_message::showerrormessage( "EQUIPMENT/PLANT_FAILED" );
            grenade delete();
            return;
        }
    }
    
    grenade setscriptablepartstate( "plant", "active", 0 );
    grenade setotherent( self );
    grenade setnodeploy( 1 );
    grenade setnonstick( 1 );
    grenade.issuper = 1;
    grenade.superid = level.superglobals.staticsuperdata[ "super_sound_veil" ].id;
    grenade.usedcount = 0;
    grenade.deployingplayer = self;
    grenade.headiconid = grenade scripts\cp_mp\entityheadicons::setheadicon_factionimage( 0, 20, undefined, undefined, undefined, undefined, 1 );
    grenade.activetargets = [];
    trigger = spawn( "trigger_rotatable_radius", grenade.origin, 0, 80, 300 );
    trigger.angles = grenade.angles;
    grenade.trigger = trigger;
    trigger enablelinkto();
    trigger linkto( grenade );
    var_307667d0142f2035 = _hasperk( "specialty_rugged_eqp" );
    onequipmentplanted( grenade, "sound_veil_mp", &function_558d562eb33ea61d );
    level thread monitordisownedequipment( self, grenade );
    grenade scripts\mp\sentientpoolmanager::registersentient( "Tactical_Static", self );
    maxhealth = ter_op( var_307667d0142f2035, 225, 150 );
    grenade thread scripts\mp\damage::monitordamage( maxhealth, "hitequip", &function_f313405d166290be, &function_50b1d2352a6a686a, 0 );
    grenade set_apply_emp_callback( &function_b434ea15774ed770 );
    
    if ( issharedfuncdefined( "emp", "setEMP_Applied_Callback" ) )
    {
        grenade [[ getsharedfunc( "emp", "setEMP_Applied_Callback" ) ]]( &function_3b78125a41e822 );
    }
    
    if ( issharedfuncdefined( "emp", "setEMP_Cleared_Callback" ) )
    {
        grenade [[ getsharedfunc( "emp", "setEMP_Cleared_Callback" ) ]]( &function_844431456055a07b );
    }
    
    grenade scripts\cp_mp\equipment\haywire::function_172d848d58051fdf( &function_391ebdde9e0eec71 );
    grenade function_49197cd063a740ea( &function_558d562eb33ea61d );
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            elevators thread scripts\common\elevators::isentitytouchingdoortrigger( grenade );
        }
    }
    
    grenade function_74844a68121c9b36();
    scripts\cp_mp\challenges::function_d997435895422ecc( "super_sound_veil", function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"use" ) );
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 2
// Checksum 0x0, Offset: 0x894
// Size: 0x5e
function function_7a9d11f284eb6bc3( timeout, var_cd96ae96391c79e6 )
{
    self endon( "destroyed" );
    self notify( "reset_timeout" );
    self endon( "reset_timeout" );
    level endon( "game_ended" );
    result = waittill_any_timeout_1( timeout, "death" );
    
    if ( istrue( var_cd96ae96391c79e6 ) )
    {
        function_a322c0dd80d5eff7();
        return;
    }
    
    function_558d562eb33ea61d();
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0x8fa
// Size: 0x134
function function_95a96c443ac9ea46( player )
{
    self endon( "death" );
    self endon( "destroyed" );
    self endon( "missile_stuck" );
    player endon( "disconnect" );
    msg = waittill_any_timeout_1( 2, "touching_platform" );
    
    if ( msg == "timeout" )
    {
        return;
    }
    
    groundentity = undefined;
    ignoreents = vehicle_getarrayinradius( self.origin, 500, 500 );
    ignoreents[ ignoreents.size ] = self;
    tracecontents = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 1, 1, 0, 1 );
    tracestart = self.origin;
    var_3a7f0173b03f5767 = -2000;
    traceend = self.origin + ( 0, 0, var_3a7f0173b03f5767 );
    traceresults = scripts\engine\trace::ray_trace( tracestart, traceend, ignoreents, tracecontents );
    groundentity = traceresults[ "entity" ];
    
    if ( isdefined( groundentity ) )
    {
        if ( is_train_ent( groundentity ) )
        {
            self.origin += ( 0, 0, 1.6 );
            self linkto( groundentity );
        }
    }
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0xa36
// Size: 0xa0
function function_50b1d2352a6a686a( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    modifieddamage = damage;
    modifieddamage = utility::handlemeleedamage( objweapon, type, modifieddamage );
    modifieddamage = scripts\mp\damage::handleapdamage( objweapon, type, modifieddamage, attacker );
    
    if ( !isagent( attacker ) )
    {
        scripts\mp\weapons::equipmenthit( self.owner, attacker, objweapon, type );
    }
    
    return modifieddamage;
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0xadf
// Size: 0x74
function function_f313405d166290be( data )
{
    attacker = data.attacker;
    
    if ( isplayer( attacker ) && istrue( scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, attacker ) ) )
    {
        attacker notify( "destroyed_equipment" );
        attacker thread doscoreevent( #"destroyed_equipment" );
        attacker thread scripts\mp\battlechatter_mp::onfieldupgradedestroy( #"bc_fieldupgrade_killfirm_soundveil" );
    }
    
    function_558d562eb33ea61d( data );
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0xb5b
// Size: 0xbe
function function_558d562eb33ea61d( data )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    hasattacker = 0;
    
    if ( isdefined( data ) && isdefined( data.attacker ) )
    {
        hasattacker = 1;
        function_7c9d9f1ca399b82c( data.attacker );
    }
    
    if ( isdefined( self.headiconid ) )
    {
        scripts\cp_mp\entityheadicons::setheadicon_deleteicon( self.headiconid );
    }
    
    if ( isdefined( self.navobstacle ) )
    {
        destroynavobstacle( self.navobstacle );
    }
    
    function_77bbce9593e3b2cc();
    thread function_53b79c2279dc402( hasattacker );
    self setscriptablepartstate( "activate", "neutral", 0 );
    self setscriptablepartstate( "destroy", "active", 0 );
    self notify( "destroyed" );
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0xc21
// Size: 0xec
function function_53b79c2279dc402( wasdestroyed )
{
    self endon( "death" );
    
    if ( !isdefined( self ) )
    {
        /#
            iprintln( "<dev string:x32>" );
        #/
    }
    
    self.exploding = 1;
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    if ( isdefined( self.owner ) && isplayer( self.owner ) )
    {
        self.owner scripts\cp_mp\challenges::function_d997435895422ecc( "super_sound_veil", function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"end" ), self.usedcount );
        scripts\mp\analyticslog::logevent_fieldupgradeexpired( self.owner, self.superid, self.usedcount, istrue( wasdestroyed ) );
        self.owner removeequip( self );
    }
    
    wait 2;
    scripts\cp_mp\ent_manager::deregisterspawn();
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0xd15
// Size: 0x4d
function function_7c9d9f1ca399b82c( attacker )
{
    if ( isplayer( attacker ) && istrue( scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, attacker ) ) )
    {
        attacker notify( "destroyed_equipment" );
        attacker thread doscoreevent( #"destroyed_equipment" );
        attacker thread scripts\mp\battlechatter_mp::equipmentdestroyed( self );
    }
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0xd6a
// Size: 0xa6
function function_b434ea15774ed770( data )
{
    if ( !isdefined( data ) || !isdefined( data.victim ) )
    {
        return;
    }
    
    data.victim endon( "death" );
    data.victim endon( "destroyed" );
    data.victim setscriptablepartstate( "empd", "active", 0 );
    data.victim function_3e3ba6dfdea9465b();
    wait 6;
    data.victim setscriptablepartstate( "empd", "neutral", 0 );
    data.victim function_74844a68121c9b36();
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0xe18
// Size: 0x72
function function_3b78125a41e822( data )
{
    if ( !isdefined( data ) || !isdefined( data.victim ) )
    {
        return;
    }
    
    data.victim endon( "death" );
    data.victim endon( "destroyed" );
    data.victim setscriptablepartstate( "empd", "active", 0 );
    data.victim function_3e3ba6dfdea9465b();
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0xe92
// Size: 0x39
function function_844431456055a07b( data )
{
    data.victim setscriptablepartstate( "empd", "neutral", 0 );
    data.victim function_74844a68121c9b36();
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0xed3
// Size: 0x13
function function_391ebdde9e0eec71( data )
{
    function_558d562eb33ea61d( data );
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 0
// Checksum 0x0, Offset: 0xeee
// Size: 0xb7
function function_74844a68121c9b36()
{
    self notify( "enable_" + "super_sound_veil" );
    self setscriptablepartstate( "arm", "active", 0 );
    
    if ( !istrue( self.var_eec43b28df0bc8d6 ) && !istrue( self.ignoretimeout ) )
    {
        defaulttimeout = 60;
        
        if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
        {
            defaulttimeout = 480;
        }
        
        timeoverride = getdvarint( @"hash_aa851e1cd1444734", 0 );
        
        if ( timeoverride > 0 )
        {
            defaulttimeout = timeoverride;
        }
        
        thread function_7a9d11f284eb6bc3( defaulttimeout );
    }
    
    if ( istrue( self.triggered ) )
    {
        self setscriptablepartstate( "activate", "active", 0 );
    }
    
    thread function_caab3d73a9d2b003();
    self.var_eec43b28df0bc8d6 = 1;
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 0
// Checksum 0x0, Offset: 0xfad
// Size: 0x29c
function function_caab3d73a9d2b003()
{
    self endon( "death" );
    self endon( "destroyed" );
    self endon( "disable_" + "super_sound_veil" );
    level endon( "game_ended" );
    self.triggeredents = [];
    
    while ( true )
    {
        self.trigger waittill( "trigger", triggeredent );
        teamtocheck = triggeredent.team;
        
        if ( !isdefined( teamtocheck ) && isagent( triggeredent ) && isdefined( triggeredent.agentteam ) )
        {
            teamtocheck = triggeredent.agentteam;
        }
        
        if ( istrue( level.teambased ) && isdefined( teamtocheck ) && teamtocheck == self.owner.team )
        {
            continue;
        }
        
        if ( isagent( triggeredent ) && !array_contains( self.triggeredents, triggeredent ) )
        {
            if ( istrue( self.var_fff21a869f9fa687 ) && !function_a5a768ec20759f3d( triggeredent ) )
            {
                continue;
            }
            
            self.triggeredents[ self.triggeredents.size ] = triggeredent;
            triggeredent scripts\anim\combat_utility::flashbangstart( 3 );
        }
        
        if ( !istrue( self.triggered ) )
        {
            if ( !function_2567c5ffae3aa0cc( triggeredent ) )
            {
                continue;
            }
            
            self.triggered = 1;
            thread function_7a9d11f284eb6bc3( 20, istrue( self.ignoretimeout ) );
            
            if ( istrue( triggeredent.var_f19a8bf0b538aaf8 ) )
            {
                explosivetrigger( triggeredent, 0 );
            }
            
            self setscriptablepartstate( "trigger", "active", 0 );
            wait 0.35;
            self setscriptablepartstate( "activate", "active", 0 );
            scripts\mp\shellshock::grenade_earthquakeatposition( self.origin, 0.25 );
            
            if ( !isdefined( self.vehicle_stuck ) && !isdefined( self.navobstacle ) )
            {
                half_height = 150;
                half_depth = 20;
                up_vec = anglestoup( self.angles );
                var_d5dd171f21b7daca = self.origin + up_vec * half_height - up_vec * half_depth;
                
                if ( getgametype() == "koth_horde" )
                {
                    badplace_teams = [ "axis", "allies" ];
                    self.navobstacle = createnavbadplacebyshape( var_d5dd171f21b7daca, self.angles, 8, 90, half_height + 40, badplace_teams );
                }
                else
                {
                    self.navobstacle = createnavbadplacebyshape( var_d5dd171f21b7daca, self.angles, 8, 90, half_height + 40 );
                }
            }
            
            continue;
        }
        
        function_ffb333a3a7d50710( triggeredent );
    }
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0x1251
// Size: 0xd2, Type: bool
function function_2567c5ffae3aa0cc( potentialtarget )
{
    if ( potentialtarget isvehicle() )
    {
        if ( !isdefined( potentialtarget.streakinfo ) )
        {
            vehicle = potentialtarget;
            vehicleoccupants = vehicle_occupancy_getalloccupants( vehicle );
            var_7f22902f9e860f6a = 0;
            
            if ( isdefined( vehicleoccupants ) && vehicleoccupants.size > 0 )
            {
                foreach ( occupant in vehicleoccupants )
                {
                    if ( !function_bd10b05c42bb5432( occupant, 1 ) )
                    {
                        continue;
                    }
                    
                    var_7f22902f9e860f6a = 1;
                    break;
                }
            }
            
            if ( !istrue( var_7f22902f9e860f6a ) )
            {
                return false;
            }
        }
        else
        {
            return false;
        }
    }
    else if ( !function_bd10b05c42bb5432( potentialtarget ) )
    {
        return false;
    }
    
    return true;
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 3
// Checksum 0x0, Offset: 0x132c
// Size: 0x55, Type: bool
function function_bd10b05c42bb5432( potentialtarget, ignoresight, var_e6c0b49674829ef4 )
{
    if ( !function_fb91ac0d17ce422e( potentialtarget, var_e6c0b49674829ef4 ) )
    {
        return false;
    }
    
    if ( function_8be3970b7e22cb24( potentialtarget ) )
    {
        return false;
    }
    
    if ( !function_669bd251f952db32( potentialtarget ) && !istrue( ignoresight ) )
    {
        return false;
    }
    
    if ( !function_47bba92311467ca4( potentialtarget ) )
    {
        return false;
    }
    
    return true;
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0x138a
// Size: 0x17, Type: bool
function function_8be3970b7e22cb24( potentialtarget )
{
    return istrue( potentialtarget.var_baf99ff6e658c413 );
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0x13aa
// Size: 0x24, Type: bool
function function_669bd251f952db32( potentialtarget )
{
    if ( !isdefined( potentialtarget ) )
    {
        return false;
    }
    
    return potentialtarget sightconetrace( self.origin, self ) > 0;
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0x13d7
// Size: 0x48, Type: bool
function function_47bba92311467ca4( potentialtarget )
{
    if ( ( isplayer( potentialtarget ) || isagent( potentialtarget ) ) && potentialtarget scripts\cp_mp\utility\player_utility::isinvehicle() )
    {
        potentialtarget = potentialtarget scripts\cp_mp\utility\player_utility::getvehicle();
    }
    
    if ( !potentialtarget istouching( self.trigger ) )
    {
        return false;
    }
    
    return true;
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 3
// Checksum 0x0, Offset: 0x1428
// Size: 0x9e, Type: bool
function function_b6727d48164ba951( potentialtarget, var_e6c0b49674829ef4, var_4a6a11a4f1e2c293 )
{
    if ( !isreallyalive( potentialtarget ) )
    {
        return false;
    }
    
    if ( istrue( level.teambased ) )
    {
        if ( potentialtarget.team == self.owner.team )
        {
            if ( potentialtarget == self.owner )
            {
                if ( istrue( var_e6c0b49674829ef4 ) || istrue( var_4a6a11a4f1e2c293 ) )
                {
                    return true;
                }
            }
        }
        else
        {
            return true;
        }
    }
    else if ( potentialtarget == self.owner )
    {
        if ( istrue( var_e6c0b49674829ef4 ) || istrue( var_4a6a11a4f1e2c293 ) )
        {
            return true;
        }
    }
    else
    {
        return true;
    }
    
    return false;
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0x14cf
// Size: 0xb6, Type: bool
function function_a5a768ec20759f3d( potentialtarget )
{
    if ( isdefined( potentialtarget.agent_type ) && issubstr( potentialtarget.agent_type, "civilian" ) )
    {
        return false;
    }
    
    if ( !istrue( potentialtarget.isactive ) )
    {
        return false;
    }
    
    teamtocheck = potentialtarget.team;
    
    if ( !isdefined( teamtocheck ) && isagent( potentialtarget ) && isdefined( potentialtarget.agentteam ) )
    {
        teamtocheck = potentialtarget.agentteam;
    }
    
    if ( isdefined( teamtocheck ) && potentialtarget.team == self.owner.team )
    {
        return false;
    }
    
    return true;
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 2
// Checksum 0x0, Offset: 0x158e
// Size: 0x6b, Type: bool
function function_fb91ac0d17ce422e( potentialtarget, var_e6c0b49674829ef4 )
{
    var_4a6a11a4f1e2c293 = 0;
    
    /#
        var_4a6a11a4f1e2c293 = getdvarint( @"hash_7ab7001b47624fdc", 0 );
    #/
    
    if ( !isdefined( potentialtarget ) )
    {
        return false;
    }
    
    if ( isplayer( potentialtarget ) && !function_b6727d48164ba951( potentialtarget, var_e6c0b49674829ef4, var_4a6a11a4f1e2c293 ) )
    {
        return false;
    }
    
    if ( isagent( potentialtarget ) && !function_a5a768ec20759f3d( potentialtarget ) )
    {
        return false;
    }
    
    return true;
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0x1602
// Size: 0x15d
function function_ffb333a3a7d50710( enemytarget )
{
    shocktargets = [];
    
    if ( enemytarget isvehicle() )
    {
        if ( !isdefined( enemytarget.streakinfo ) )
        {
            vehicleoccupants = vehicle_occupancy_getalloccupants( enemytarget );
            
            if ( isdefined( vehicleoccupants ) && vehicleoccupants.size > 0 )
            {
                foreach ( occupant in vehicleoccupants )
                {
                    if ( function_bd10b05c42bb5432( occupant, 1, 1 ) )
                    {
                        shocktargets[ shocktargets.size ] = occupant;
                    }
                }
            }
        }
        else
        {
            return;
        }
    }
    else if ( function_bd10b05c42bb5432( enemytarget, undefined, 1 ) )
    {
        shocktargets[ shocktargets.size ] = enemytarget;
    }
    
    foreach ( target in shocktargets )
    {
        if ( !isdefined( target ) )
        {
            continue;
        }
        
        function_58224ad5db7ba3ef( target );
        enemytargetid = function_55f4107c03475907( target );
        function_dba08b318eb4224d( target, enemytargetid );
        thread function_20e0e81ccc2160e7( target, enemytargetid );
        
        if ( isplayer( target ) && !isbot( target ) )
        {
            function_99f74e04a216a21c( target, enemytargetid );
        }
    }
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0x1767
// Size: 0x59
function function_55f4107c03475907( target )
{
    level.var_4405e76242d7cb8e++;
    enemytargetid = 0;
    
    if ( isplayer( target ) && !isbot( target ) )
    {
        enemytargetid = target getxuid();
    }
    else
    {
        enemytargetid = target getentitynumber();
    }
    
    return enemytargetid + "_" + level.var_4405e76242d7cb8e;
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 2
// Checksum 0x0, Offset: 0x17c9
// Size: 0x14d
function function_20e0e81ccc2160e7( enemytarget, enemytargetid )
{
    self endon( "death" );
    self endon( "destroyed" );
    self endon( "lost_target_" + enemytargetid );
    self endon( "disable_" + "super_sound_veil" );
    level endon( "game_ended" );
    var_4a6a11a4f1e2c293 = 0;
    
    /#
        var_4a6a11a4f1e2c293 = getdvarint( @"hash_7ab7001b47624fdc", 0 );
        
        if ( var_4a6a11a4f1e2c293 == 2 )
        {
            return;
        }
    #/
    
    if ( isdefined( enemytarget ) && isplayer( enemytarget ) && isplayer( self.owner ) && enemytarget != self.owner )
    {
        self.owner thread doscoreevent( #"sound_veil_effect" );
    }
    
    while ( isdefined( enemytarget ) )
    {
        shockfile = "sound_veil_mp";
        
        if ( isplayer( enemytarget ) )
        {
            if ( enemytarget _hasperk( "specialty_tac_resist" ) || enemytarget _hasperk( "specialty_tac_resist_br" ) )
            {
                shockfile = "sound_veil_reduced_mp";
            }
        }
        
        enemytarget scripts\cp_mp\utility\shellshock_utility::_shellshock( shockfile, "stun", 0.5, 0 );
        
        if ( isdefined( self.owner ) )
        {
            enemytarget dodamage( 1, self.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_object, "torso_upper" );
        }
        
        wait 0.5;
    }
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 2
// Checksum 0x0, Offset: 0x191e
// Size: 0x32
function function_99f74e04a216a21c( enemytarget, enemytargetid )
{
    if ( enemytarget scripts\common\utility::isusingremote() )
    {
        thread function_a996433357117a3f( enemytarget, enemytargetid );
        return;
    }
    
    thread function_a8b8c5877fc13197( enemytarget, enemytargetid );
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 2
// Checksum 0x0, Offset: 0x1958
// Size: 0x5c
function function_a996433357117a3f( enemytarget, enemytargetid )
{
    self endon( "death" );
    self endon( "destroyed" );
    self endon( "lost_target_" + enemytargetid );
    self endon( "disable_" + "super_sound_veil" );
    level endon( "game_ended" );
    
    while ( isdefined( enemytarget ) && enemytarget scripts\common\utility::isusingremote() )
    {
        waitframe();
    }
    
    thread function_a8b8c5877fc13197( enemytarget, enemytargetid );
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 2
// Checksum 0x0, Offset: 0x19bc
// Size: 0xe5
function function_a8b8c5877fc13197( enemytarget, enemytargetid )
{
    level endon( "game_ended" );
    var_4a6a11a4f1e2c293 = 0;
    
    /#
        var_4a6a11a4f1e2c293 = getdvarint( @"hash_7ab7001b47624fdc", 0 );
        
        if ( var_4a6a11a4f1e2c293 == 2 )
        {
            return;
        }
    #/
    
    shakeoverride = "player_soundveil_shake_mp";
    scramblestrength = 5;
    
    if ( enemytarget _hasperk( "specialty_tac_resist" ) )
    {
        shakeoverride = "player_soundveil_shake_reduced_mp";
        scramblestrength = 3;
    }
    
    scripts\cp_mp\utility\player_utility::function_f7348e400b4a608d( enemytarget, shakeoverride, 1 );
    enemytarget setclientomnvar( "ui_hud_shake", 1 );
    enemytarget scripts\cp_mp\emp_debuff::play_emp_scramble( scramblestrength );
    level waittill_any_ents( self, "death", self, "destroyed", self, "lost_target_" + enemytargetid, self, "disable_" + "super_sound_veil" );
    
    if ( isdefined( enemytarget ) )
    {
        scripts\cp_mp\utility\player_utility::function_56d83cde22535f96( enemytarget );
        enemytarget setclientomnvar( "ui_hud_shake", 0 );
        enemytarget scripts\cp_mp\emp_debuff::stop_emp_scramble( scramblestrength );
    }
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 2
// Checksum 0x0, Offset: 0x1aa9
// Size: 0x3b
function function_dba08b318eb4224d( enemytarget, enemytargetid )
{
    thread function_de45ed589c44b1b6( enemytarget, enemytargetid );
    thread function_f6ff6461277e08e7( enemytarget, enemytargetid );
    thread function_5fdece59c0ffc021( enemytarget, enemytargetid );
    thread function_9ad53f155f459571( enemytarget, enemytargetid );
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 2
// Checksum 0x0, Offset: 0x1aec
// Size: 0x6e
function function_f6ff6461277e08e7( enemytarget, enemytargetid )
{
    self endon( "death" );
    self endon( "destroyed" );
    self endon( "lost_target_" + enemytargetid );
    self endon( "disable_" + "super_sound_veil" );
    level endon( "game_ended" );
    
    if ( isplayer( enemytarget ) )
    {
        enemytarget waittill_any_2( "death_or_disconnect", "killed_player" );
    }
    else
    {
        enemytarget waittill( "death" );
    }
    
    self notify( "lost_target_" + enemytargetid );
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 2
// Checksum 0x0, Offset: 0x1b62
// Size: 0x7a
function function_5fdece59c0ffc021( enemytarget, enemytargetid )
{
    self endon( "death" );
    self endon( "destroyed" );
    self endon( "lost_target_" + enemytargetid );
    self endon( "disable_" + "super_sound_veil" );
    level endon( "game_ended" );
    
    while ( isdefined( enemytarget ) )
    {
        if ( !isdefined( enemytarget.vehicle ) )
        {
            if ( !function_669bd251f952db32( enemytarget ) )
            {
                break;
            }
        }
        
        if ( !function_47bba92311467ca4( enemytarget ) )
        {
            break;
        }
        
        waitframe();
    }
    
    self notify( "lost_target_" + enemytargetid );
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 2
// Checksum 0x0, Offset: 0x1be4
// Size: 0x50
function function_9ad53f155f459571( enemytarget, enemytargetid )
{
    self endon( "death" );
    self endon( "destroyed" );
    self endon( "lost_target_" + enemytargetid );
    self endon( "disable_" + "super_sound_veil" );
    level endon( "game_ended" );
    enemytarget waittill( "using_remote" );
    self notify( "lost_target_" + enemytargetid );
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 2
// Checksum 0x0, Offset: 0x1c3c
// Size: 0x49
function function_de45ed589c44b1b6( enemytarget, enemytargetid )
{
    self endon( "death" );
    self endon( "destroyed" );
    level endon( "game_ended" );
    waittill_any_2( "lost_target_" + enemytargetid, "disable_" + "super_sound_veil" );
    function_61d589d2064b53f2( enemytarget );
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 0
// Checksum 0x0, Offset: 0x1c8d
// Size: 0x34
function function_3e3ba6dfdea9465b()
{
    self notify( "disable_" + "super_sound_veil" );
    self setscriptablepartstate( "activate", "neutral", 0 );
    self setscriptablepartstate( "arm", "neutral", 0 );
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 0
// Checksum 0x0, Offset: 0x1cc9
// Size: 0x38
function function_a322c0dd80d5eff7()
{
    self setscriptablepartstate( "arm", "active", 0 );
    self setscriptablepartstate( "activate", "neutral", 0 );
    self setscriptablepartstate( "trigger", "neutral", 0 );
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0x1d09
// Size: 0x39
function function_58224ad5db7ba3ef( enemytarget )
{
    enemytarget.var_baf99ff6e658c413 = 1;
    self.usedcount++;
    self.activetargets[ self.activetargets.size ] = enemytarget;
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0x1d4a
// Size: 0x82, Type: bool
function function_3c43dcc55621952a( enemytarget )
{
    if ( isdefined( self ) && self.activetargets.size > 0 )
    {
        foreach ( target in self.activetargets )
        {
            if ( isdefined( target ) && isdefined( enemytarget ) && target == enemytarget )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0x1dd5
// Size: 0x34
function function_61d589d2064b53f2( enemytarget )
{
    if ( isdefined( enemytarget ) )
    {
        enemytarget.var_baf99ff6e658c413 = undefined;
        self.activetargets = array_remove( self.activetargets, enemytarget );
    }
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 0
// Checksum 0x0, Offset: 0x1e11
// Size: 0x63
function function_77bbce9593e3b2cc()
{
    if ( isdefined( self.activetargets ) )
    {
        foreach ( target in self.activetargets )
        {
            function_61d589d2064b53f2( target );
        }
    }
}

// Namespace sound_veil / scripts\mp\equipment\sound_veil
// Params 1
// Checksum 0x0, Offset: 0x1e7c
// Size: 0x15
function function_49197cd063a740ea( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

