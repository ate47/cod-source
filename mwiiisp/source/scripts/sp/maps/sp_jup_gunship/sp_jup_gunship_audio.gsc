#namespace sp_jup_gunship_audio;

// Namespace sp_jup_gunship_audio / scripts\sp\maps\sp_jup_gunship\sp_jup_gunship_audio
// Params 0
// Checksum 0x0, Offset: 0x120
// Size: 0x2
function main()
{
    
}

// Namespace sp_jup_gunship_audio / scripts\sp\maps\sp_jup_gunship\sp_jup_gunship_audio
// Params 0
// Checksum 0x0, Offset: 0x12a
// Size: 0xb7
function function_f7ee9448704d5a66()
{
    allies = getaiarray( "allies" );
    allies = sortbydistance( allies, self.origin );
    close_dist = 2000;
    med_dist = 8000;
    
    if ( allies.size > 0 )
    {
        dist = distance( self.origin, allies[ 0 ].origin );
        sound = "weap_tank_cannon_fire_radio_distant";
        
        if ( dist <= close_dist )
        {
            sound = "weap_tank_cannon_fire_radio_close";
        }
        else if ( dist <= med_dist )
        {
            sound = "weap_tank_cannon_fire_radio_med";
        }
        
        if ( soundexists( sound ) )
        {
            level.player playsound( sound );
        }
    }
}

// Namespace sp_jup_gunship_audio / scripts\sp\maps\sp_jup_gunship\sp_jup_gunship_audio
// Params 1
// Checksum 0x0, Offset: 0x1e9
// Size: 0xb0
function function_62f93285d84dded3( impact_origin )
{
    allies = getaiarray( "allies" );
    allies = sortbydistance( allies, impact_origin );
    close_dist = 2000;
    med_dist = 8000;
    
    if ( allies.size > 0 )
    {
        dist = distance( impact_origin, allies[ 0 ].origin );
        impact_sound = "weap_rpg_exp_radio_distant";
        
        if ( dist <= close_dist )
        {
            impact_sound = "weap_rpg_exp_radio_close";
        }
        else if ( dist <= med_dist )
        {
            impact_sound = "weap_rpg_exp_radio_med";
        }
        
        if ( soundexists( impact_sound ) )
        {
            level.player playsound( impact_sound );
        }
    }
}

// Namespace sp_jup_gunship_audio / scripts\sp\maps\sp_jup_gunship\sp_jup_gunship_audio
// Params 1
// Checksum 0x0, Offset: 0x2a1
// Size: 0xb0
function function_f4edab1c90569f7c( impact_origin )
{
    allies = getaiarray( "allies" );
    allies = sortbydistance( allies, impact_origin );
    close_dist = 2000;
    med_dist = 8000;
    
    if ( allies.size > 0 )
    {
        dist = distance( impact_origin, allies[ 0 ].origin );
        impact_sound = "weap_rpg_exp_radio_distant";
        
        if ( dist <= close_dist )
        {
            impact_sound = "weap_rpg_exp_radio_close";
        }
        else if ( dist <= med_dist )
        {
            impact_sound = "weap_rpg_exp_radio_med";
        }
        
        if ( soundexists( impact_sound ) )
        {
            level.player playsound( impact_sound );
        }
    }
}

