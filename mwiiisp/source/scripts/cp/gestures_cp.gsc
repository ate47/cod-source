#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\movement;
#using scripts\cp\utility\lui_game_event_aggregator;
#using scripts\cp_mp\gestures;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;

#namespace gestures_cp;

// Namespace gestures_cp / scripts\cp\gestures_cp
// Params 0
// Checksum 0x0, Offset: 0x155
// Size: 0x15
function init_cp()
{
    scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback( &watchradialgestureactivation );
    scripts\common\notetrack::function_11f8c6d6f5ba948();
}

// Namespace gestures_cp / scripts\cp\gestures_cp
// Params 2
// Checksum 0x0, Offset: 0x172
// Size: 0xad
function player_gesture_force( gesturename, lookatent )
{
    self endon( "death" );
    gestureplayed = 0;
    blendtime = undefined;
    canceltransition = 0;
    
    if ( get_player_demeanor() == "safe" )
    {
        blendtime = 0.2;
        canceltransition = 1;
    }
    
    if ( isdefined( lookatent ) && isent( lookatent ) )
    {
        gestureplayed = self forceplaygestureviewmodel( gesturename, lookatent, blendtime, undefined, undefined );
    }
    else
    {
        gestureplayed = self forceplaygestureviewmodel( gesturename, undefined, blendtime, undefined, undefined );
    }
    
    if ( gestureplayed )
    {
        thread player_gestures_input_disable( gesturename, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, undefined, "gesture" );
    }
    
    return gestureplayed;
}

// Namespace gestures_cp / scripts\cp\gestures_cp
// Params 14
// Checksum 0x0, Offset: 0x228
// Size: 0x587
function player_gestures_input_disable( gesturename, pronemovement, mantle, sprint, fire, reload, weaponswitch, ads, wallrun, doublejump, meleeattack, offhandweapons, disabletime, tag )
{
    self endon( "death" );
    
    if ( !isdefined( tag ) )
    {
        tag = "gesture";
    }
    
    if ( !isdefined( self.gestures ) )
    {
        self.gestures = spawnstruct();
    }
    
    if ( isdefined( pronemovement ) && pronemovement == 1 )
    {
        if ( self getstance() == "prone" )
        {
            val::set( tag + "_prone", "allow_movement", 0 );
            thread player_gestures_prone_getup_think( gesturename, tag );
            
            if ( !isdefined( self.gestures.restrictingpronespeed ) )
            {
                self.gestures.restrictingpronespeed = 0;
            }
            
            self.gestures.restrictingpronespeed++;
        }
        else
        {
            if ( !isdefined( self.gestures.restrictingpronestance ) )
            {
                self.gestures.restrictingpronestance = 0;
            }
            
            self.gestures.restrictingpronestance++;
            val::set( tag, "prone", 0 );
        }
        
        self.gestures.restrictingpronemovement = 1;
    }
    
    if ( isdefined( mantle ) && mantle == 1 )
    {
        if ( !isdefined( self.gestures.restrictingmantle ) )
        {
            self.gestures.restrictingmantle = 0;
        }
        
        self.gestures.restrictingmantle++;
        val::set( tag, "mantle", 0 );
    }
    
    if ( isdefined( sprint ) && sprint == 1 )
    {
        if ( !isdefined( self.gestures.restrictingsprint ) )
        {
            self.gestures.restrictingsprint = 0;
        }
        
        self.gestures.restrictingsprint++;
        val::set( tag, "sprint", 0 );
    }
    
    if ( isdefined( fire ) && fire == 1 )
    {
        if ( !isdefined( self.gestures.restrictingfire ) )
        {
            self.gestures.restrictingfire = 0;
        }
        
        self.gestures.restrictingfire++;
        val::set( tag, "fire", 0 );
    }
    
    if ( isdefined( reload ) && reload == 1 )
    {
        if ( !isdefined( self.gestures.restrictingreload ) )
        {
            self.gestures.restrictingreload = 0;
        }
        
        self.gestures.restrictingreload++;
        val::set( tag, "reload", 0 );
    }
    
    if ( isdefined( weaponswitch ) && weaponswitch == 1 )
    {
        if ( !isdefined( self.gestures.restrictingweaponswitch ) )
        {
            self.gestures.restrictingweaponswitch = 0;
        }
        
        self.gestures.restrictingweaponswitch++;
        val::set( tag, "weapon_switch", 0 );
    }
    
    if ( isdefined( ads ) && ads == 1 )
    {
        if ( !isdefined( self.gestures.restrictingads ) )
        {
            self.gestures.restrictingads = 0;
        }
        
        self.gestures.restrictingads++;
        val::set( tag, "ads", 0 );
    }
    
    if ( isdefined( wallrun ) && wallrun == 1 )
    {
        if ( !isdefined( self.gestures.restrictingwallrun ) )
        {
            self.gestures.restrictingwallrun = 0;
        }
        
        self.gestures.restrictingwallrun++;
        val::set( tag, "wallrun", 0 );
    }
    
    if ( isdefined( doublejump ) && doublejump == 1 )
    {
        if ( !isdefined( self.gestures.restrictingdoublejump ) )
        {
            self.gestures.restrictingdoublejump = 0;
        }
        
        self.gestures.restrictingdoublejump++;
        val::set( tag, "doublejump", 0 );
    }
    
    if ( isdefined( meleeattack ) && meleeattack == 1 )
    {
        if ( !isdefined( self.gestures.restrictingmeleeattack ) )
        {
            self.gestures.restrictingmeleeattack = 0;
        }
        
        self.gestures.restrictingmeleeattack++;
        val::set( tag, "melee", 0 );
    }
    
    if ( isdefined( offhandweapons ) && offhandweapons == 1 )
    {
        if ( !isdefined( self.gestures.restrictingoffhandweapons ) )
        {
            self.gestures.restrictingoffhandweapons = 0;
        }
        
        self.gestures.restrictingoffhandweapons++;
        val::set( tag, "offhand_weapons", 0 );
    }
    
    if ( isdefined( disabletime ) )
    {
        wait disabletime;
    }
    else
    {
        self waittill( "gesture_stopped", stoppedgesturename );
        
        if ( stoppedgesturename != gesturename )
        {
            while ( true )
            {
                if ( !self isgestureplaying( gesturename ) )
                {
                    break;
                }
                
                wait 0.05;
            }
        }
    }
    
    self notify( gesturename + "gesture_stopped_internal" );
    player_gestures_input_enable( pronemovement, mantle, sprint, fire, reload, weaponswitch, ads, wallrun, doublejump, meleeattack, offhandweapons, tag );
}

// Namespace gestures_cp / scripts\cp\gestures_cp
// Params 12
// Checksum 0x0, Offset: 0x7b7
// Size: 0x231
function player_gestures_input_enable( pronemovement, mantle, sprint, fire, reload, weaponswitch, ads, wallrun, doublejump, meleeattack, offhandweapons, tag )
{
    if ( !isdefined( self.gestures ) )
    {
        self.gestures = spawnstruct();
    }
    
    if ( isdefined( pronemovement ) && pronemovement > 0 )
    {
        if ( isdefined( self.gestures.restrictingpronespeed ) && self.gestures.restrictingpronespeed > 0 )
        {
            self.gestures.restrictingpronespeed--;
            
            if ( self.gestures.restrictingpronespeed <= 0 )
            {
                val::set( tag + "_prone", "allow_movement", 1 );
            }
        }
        
        if ( isdefined( self.gestures.restrictingpronestance ) && self.gestures.restrictingpronestance > 0 )
        {
            self.gestures.restrictingpronestance--;
            val::reset_all( tag );
        }
    }
    
    if ( isdefined( mantle ) && mantle == 1 )
    {
        val::reset_all( tag );
    }
    
    if ( isdefined( sprint ) && sprint == 1 )
    {
        val::reset_all( tag );
    }
    
    if ( isdefined( fire ) && fire == 1 )
    {
        val::reset_all( tag );
    }
    
    if ( isdefined( reload ) && reload == 1 )
    {
        val::reset_all( tag );
    }
    
    if ( isdefined( weaponswitch ) && weaponswitch == 1 )
    {
        val::reset_all( tag );
    }
    
    if ( isdefined( ads ) && ads == 1 )
    {
        val::reset_all( tag );
    }
    
    if ( isdefined( wallrun ) && wallrun == 1 )
    {
        val::set( tag, "wallrun", 0 );
    }
    
    if ( isdefined( doublejump ) && doublejump == 1 )
    {
        val::set( tag, "doublejump", 0 );
    }
    
    if ( isdefined( meleeattack ) && meleeattack == 1 )
    {
        val::reset_all( tag );
    }
    
    if ( isdefined( offhandweapons ) && offhandweapons == 1 )
    {
        val::reset_all( tag );
    }
}

// Namespace gestures_cp / scripts\cp\gestures_cp
// Params 2
// Checksum 0x0, Offset: 0x9f0
// Size: 0xdf
function player_gestures_prone_getup_think( gesturename, tag )
{
    self endon( "death" );
    self endon( gesturename + "gesture_stopped_internal" );
    stillprone = 1;
    
    while ( stillprone )
    {
        if ( self getstance() != "prone" )
        {
            waittillframeend();
            self.gestures.restrictingpronespeed--;
            
            if ( self.gestures.restrictingpronespeed <= 0 )
            {
                val::set( tag + "_prone", "allow_movement", 1 );
            }
            
            if ( !isdefined( self.gestures.restrictingpronestance ) )
            {
                self.gestures.restrictingpronestance = 0;
            }
            
            self.gestures.restrictingpronestance++;
            val::set( tag, "prone", 0 );
            stillprone = 0;
        }
        
        wait 0.05;
    }
}

// Namespace gestures_cp / scripts\cp\gestures_cp
// Params 0
// Checksum 0x0, Offset: 0xad7
// Size: 0x8
function get_player_demeanor()
{
    return self getdemeanorviewmodel();
}

