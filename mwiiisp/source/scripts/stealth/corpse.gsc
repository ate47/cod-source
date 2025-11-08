#using scripts\asm\asm;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\stealth\debug;
#using scripts\stealth\utility;

#namespace corpse;

// Namespace corpse / scripts\stealth\corpse
// Params 0
// Checksum 0x0, Offset: 0x10d
// Size: 0x2e
function corpse_init_entity()
{
    assert( isdefined( self.stealth ) );
    self.stealth.corpse = spawnstruct();
}

// Namespace corpse / scripts\stealth\corpse
// Params 0
// Checksum 0x0, Offset: 0x143
// Size: 0x8c
function corpse_init_level()
{
    if ( isdefined( level.stealth ) && isdefined( level.stealth.corpse ) )
    {
        return;
    }
    
    level.stealth.corpse = spawnstruct();
    level.stealth.corpse.reset_time = 30;
    level scripts\stealth\utility::set_stealth_func( "saw_corpse", &corpse_seen );
    level scripts\stealth\utility::set_stealth_func( "found_corpse", &corpse_found );
    set_corpse_ranges_default();
}

// Namespace corpse / scripts\stealth\corpse
// Params 0
// Checksum 0x0, Offset: 0x1d7
// Size: 0x33
function set_corpse_ranges_default()
{
    array[ "sight_dist" ] = 600;
    array[ "detect_dist" ] = 300;
    array[ "found_dist" ] = 100;
    set_corpse_ranges( array );
}

// Namespace corpse / scripts\stealth\corpse
// Params 1
// Checksum 0x0, Offset: 0x212
// Size: 0x2c
function set_corpse_ranges( array )
{
    if ( !isdefined( array[ "shadow_dist" ] ) )
    {
        array[ "shadow_dist" ] = array[ "found_dist" ];
    }
    
    setstealthcorpsedistances( array );
}

// Namespace corpse / scripts\stealth\corpse
// Params 0
// Checksum 0x0, Offset: 0x246
// Size: 0x1a
function set_corpse_ignore()
{
    assert( isent( self ) );
    setcorpseignored( self, 1 );
}

// Namespace corpse / scripts\stealth\corpse
// Params 1
// Checksum 0x0, Offset: 0x268
// Size: 0xc4, Type: bool
function corpse_check_shadow( origin )
{
    if ( !isdefined( self.in_shadow_origin ) || distancesquared( self.in_shadow_origin, origin ) > 1 )
    {
        self.in_shadow = undefined;
        
        if ( isdefined( level.trigger_stealth_shadow ) )
        {
            foreach ( trigger in level.trigger_stealth_shadow )
            {
                if ( isdefined( trigger ) && ispointinvolume( origin, trigger ) )
                {
                    self.in_shadow = 1;
                    break;
                }
            }
        }
        
        self.in_shadow_origin = origin;
    }
    
    return istrue( self.in_shadow );
}

// Namespace corpse / scripts\stealth\corpse
// Params 1
// Checksum 0x0, Offset: 0x335
// Size: 0xfb
function corpse_found( event )
{
    self notify( "corpse_found" );
    self endon( "corpse_found" );
    self endon( "death" );
    
    if ( isdefined( level.battlechatter ) )
    {
        addbattlechatternotify( self, undefined, "corpse_found" );
    }
    
    corpse = event.entity;
    corpseorigin = getcorpseorigin( corpse );
    
    if ( isdefined( self.var_2836afe73a94b60b ) && self.var_2836afe73a94b60b != corpse )
    {
        setcorpseseen( self.var_2836afe73a94b60b, 0 );
    }
    
    self.var_2836afe73a94b60b = corpse;
    
    if ( !isdefined( self.var_a9abd657131af071 ) || self.var_a9abd657131af071 == "small" )
    {
        self.bexaminerequested = 1;
    }
    
    if ( isdefined( level.fnsetcorpseremovetimerfunc ) )
    {
        corpse [[ level.fnsetcorpseremovetimerfunc ]]( level.stealth.corpse.reset_time );
    }
}

// Namespace corpse / scripts\stealth\corpse
// Params 1
// Checksum 0x0, Offset: 0x438
// Size: 0xde
function corpse_seen( event )
{
    if ( isdefined( level.battlechatter ) )
    {
        addbattlechatternotify( self, undefined, "corpse_seen" );
    }
    
    corpse = event.entity;
    corpseorigin = getcorpseorigin( corpse );
    self.stealth.corpse.origin = corpseorigin;
    
    if ( !isdefined( self.var_a9abd657131af071 ) || self.var_a9abd657131af071 == "small" )
    {
        self.bexaminerequested = 1;
    }
    
    self notify( "corpse_seen_claim" );
    
    if ( isdefined( self.var_2836afe73a94b60b ) && self.var_2836afe73a94b60b != corpse )
    {
        setcorpseseen( self.var_2836afe73a94b60b, 0 );
    }
    
    setcorpseseen( corpse, 1 );
    self.var_2836afe73a94b60b = corpse;
}

