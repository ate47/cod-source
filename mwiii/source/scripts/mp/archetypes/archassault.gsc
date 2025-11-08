#using scripts\common\utility;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\points;

#namespace archassault;

// Namespace archassault / scripts\mp\archetypes\archassault
// Params 0
// Checksum 0x0, Offset: 0x17e
// Size: 0x9
function applyarchetype()
{
    equipextras();
}

// Namespace archassault / scripts\mp\archetypes\archassault
// Params 0
// Checksum 0x0, Offset: 0x18f
// Size: 0x2
function equipextras()
{
    
}

// Namespace archassault / scripts\mp\archetypes\archassault
// Params 0
// Checksum 0x0, Offset: 0x199
// Size: 0x2
function removearchetype()
{
    
}

// Namespace archassault / scripts\mp\archetypes\archassault
// Params 0
// Checksum 0x0, Offset: 0x1a3
// Size: 0xb2
function auraquickswap_run()
{
    self endon( "death_or_disconnect" );
    self endon( "removeArchetype" );
    self setclientomnvar( "ui_aura_quickswap", 0 );
    
    while ( true )
    {
        self waittill( "got_a_kill" );
        auraplayers = utility::playersincylinder( self.origin, 384 );
        
        foreach ( player in auraplayers )
        {
            if ( player.team != self.team )
            {
                continue;
            }
            
            player thread auraquickswap_bestowaura( self );
        }
    }
}

// Namespace archassault / scripts\mp\archetypes\archassault
// Params 1
// Checksum 0x0, Offset: 0x25d
// Size: 0x96
function auraquickswap_bestowaura( player )
{
    self endon( "death_or_disconnect" );
    self endon( "giveLoadout_start" );
    level endon( "game_ended" );
    
    if ( self != player )
    {
        player thread doscoreevent( #"buff_teammate" );
    }
    
    self setclientomnvar( "ui_aura_quickswap", 1 );
    giveperk( "specialty_fastreload" );
    self playlocalsound( "mp_overcharge_on" );
    thread cleanupafterplayerdeath();
    wait 5;
    self playlocalsound( "mp_overcharge_off" );
    self notify( "removeAuraQuickswap" );
    removeperk( "specialty_fastreload" );
    self setclientomnvar( "ui_aura_quickswap", 0 );
}

// Namespace archassault / scripts\mp\archetypes\archassault
// Params 0
// Checksum 0x0, Offset: 0x2fb
// Size: 0x25
function cleanupafterplayerdeath()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "death" );
    self setclientomnvar( "ui_aura_quickswap", 0 );
}

