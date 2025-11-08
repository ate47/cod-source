#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\utility;

#namespace destructible_vehicle;

// Namespace destructible_vehicle / scripts\sp\destructibles\destructible_vehicle
// Params 0
// Checksum 0x0, Offset: 0x140
// Size: 0x15
function destructible_vehicle_init()
{
    precacheitem( "car_grenade" );
    thread destructible_vehicle_main();
}

// Namespace destructible_vehicle / scripts\sp\destructibles\destructible_vehicle
// Params 0
// Checksum 0x0, Offset: 0x15d
// Size: 0xb1
function destructible_vehicle_main()
{
    waitframe();
    scriptables = getentarray( "scriptable", "code_classname" );
    
    foreach ( scriptable in scriptables )
    {
        if ( issubstr( scriptable.model, "veh_" ) || issubstr( scriptable.model, "veh8_" ) || issubstr( scriptable.model, "veh9_" ) )
        {
            scriptable thread destructible_vehicle_thread();
        }
    }
}

// Namespace destructible_vehicle / scripts\sp\destructibles\destructible_vehicle
// Params 0
// Checksum 0x0, Offset: 0x216
// Size: 0xb5
function destructible_vehicle_thread()
{
    self.destructible_type = "vehicle";
    
    while ( true )
    {
        self waittill( "scriptableNotification", note, param );
        
        switch ( note )
        {
            case #"hash_e5776eac05aaee34":
            case #"hash_f292a20224944002":
                thread burningcar_indicator();
                break;
            case #"hash_3b9cb3e6d5ebb052":
            case #"hash_65f8b242ffc4f6e8":
            case #"hash_ac44ea5d34937252":
                self notify( "destroyed" );
                
                if ( isdefined( self.burningcarindicator ) )
                {
                    self.burningcarindicator delete();
                }
                
                self.onfire = undefined;
                return;
        }
    }
}

// Namespace destructible_vehicle / scripts\sp\destructibles\destructible_vehicle
// Params 0
// Checksum 0x0, Offset: 0x2d3
// Size: 0x87
function burningcar_indicator()
{
    if ( isdefined( self.burningcarindicator ) )
    {
        return;
    }
    
    self endon( "destroyed" );
    self.onfire = 1;
    wait 0.2;
    self.burningcarindicator = magicgrenade( "car_grenade", self.origin + ( 0, 0, 10 ), self.origin, 9999, 0 );
    self.burningcarindicator.targetname = "offhand_car_grenade";
    self.burningcarindicator makeunusable();
}

