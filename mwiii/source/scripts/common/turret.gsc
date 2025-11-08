#using scripts\common\utility;
#using scripts\engine\utility;

#namespace turret;

// Namespace turret / scripts\common\turret
// Params 0
// Checksum 0x0, Offset: 0xb6
// Size: 0xb0
function turret_vm_playeranims_think()
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "turretownerchange" );
        player = self getturretowner();
        weap = undefined;
        
        if ( isdefined( player ) && isplayer( player ) && !isbot( player ) )
        {
            player giveweapon( self.weaponinfo );
            weap = player getcurrentweapon();
            player switchtoweaponimmediate( self.weaponinfo );
        }
        
        self waittill( "turretownerchange" );
        
        if ( isdefined( player ) && isplayer( player ) && !isbot( player ) )
        {
            player switchtoweaponimmediate( weap );
            player takeweapon( self.weaponinfo );
        }
    }
}

