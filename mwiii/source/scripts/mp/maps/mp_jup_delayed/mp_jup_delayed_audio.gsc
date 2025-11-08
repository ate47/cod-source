#namespace mp_jup_delayed_audio;

// Namespace mp_jup_delayed_audio / scripts\mp\maps\mp_jup_delayed\mp_jup_delayed_audio
// Params 0
// Checksum 0x0, Offset: 0x158
// Size: 0x16
function main()
{
    thread sfx_metal_det( "sfx_metal_det", "amb_emt_delayed_metal_det", 3 );
}

// Namespace mp_jup_delayed_audio / scripts\mp\maps\mp_jup_delayed\mp_jup_delayed_audio
// Params 3
// Checksum 0x0, Offset: 0x176
// Size: 0x8f
function sfx_metal_det( var_eaad182af1b91884, alias, timer )
{
    level endon( "game_ended" );
    level waittill( "matchStartTimer_done" );
    metal_triggers = getentarray( var_eaad182af1b91884, "targetname" );
    
    foreach ( trig in metal_triggers )
    {
        thread function_a0912e6a103cc3a( trig, alias, timer );
    }
}

// Namespace mp_jup_delayed_audio / scripts\mp\maps\mp_jup_delayed\mp_jup_delayed_audio
// Params 3
// Checksum 0x0, Offset: 0x20d
// Size: 0xf5
function function_a0912e6a103cc3a( trig, alias, timer )
{
    while ( true )
    {
        if ( !isdefined( trig.scriptable ) )
        {
            scriptables = getscriptablearray( "scriptable_un_office_walkthrough_metal_detector_01_blink", "classname" );
            trig.scriptable = sortbydistance( scriptables, trig.origin )[ 0 ];
            trig.scriptable setscriptablepartstate( "Light_Part", "off" );
        }
        
        trig waittill( "trigger" );
        playsoundatpos( trig.origin + ( 0, 0, 40 ), alias );
        trig.scriptable setscriptablepartstate( "Light_Part", "on" );
        wait timer;
        trig.scriptable setscriptablepartstate( "Light_Part", "off" );
        
        while ( function_77e25cc10461d531( trig ) )
        {
            waitframe();
        }
    }
}

// Namespace mp_jup_delayed_audio / scripts\mp\maps\mp_jup_delayed\mp_jup_delayed_audio
// Params 1
// Checksum 0x0, Offset: 0x30a
// Size: 0x65, Type: bool
function function_77e25cc10461d531( trig )
{
    foreach ( player in level.players )
    {
        if ( player istouching( trig ) )
        {
            return true;
        }
    }
    
    return false;
}

