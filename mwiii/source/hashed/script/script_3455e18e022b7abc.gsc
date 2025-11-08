#using script_67055b3ff4918256;
#using script_6df6604a74a7a9c7;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_9499d190be9a2ad3;

// Namespace namespace_9499d190be9a2ad3 / namespace_26e60c953dc40f2c
// Params 2
// Checksum 0x0, Offset: 0x172
// Size: 0x7a
function init( door, index )
{
    index = default_to( index, 0 );
    self.door = door;
    self.door namespace_b1453e6e8267c3ce::function_2cade2c182251141( self );
    
    if ( isdefined( self.target ) )
    {
        next_digit = getstruct( self.target, "targetname" );
        next_digit init( self.door, index + 1 );
    }
}

// Namespace namespace_9499d190be9a2ad3 / namespace_26e60c953dc40f2c
// Params 2
// Checksum 0x0, Offset: 0x1f4
// Size: 0x2b
function digit_activate( should_activate, index )
{
    if ( should_activate )
    {
        thread digit_spawn( index );
        return;
    }
    
    thread digit_cleanup();
}

// Namespace namespace_9499d190be9a2ad3 / namespace_26e60c953dc40f2c
// Params 1
// Checksum 0x0, Offset: 0x227
// Size: 0x109
function digit_spawn( index )
{
    angle_adjust = function_6ab8997a6d33d00d( index );
    self.plate = spawn_model( function_c3e078f287496cf7( index ), self.origin, self.angles + angle_adjust );
    self.plate.index = index;
    forward = anglestoup( self.angles ) * -1;
    self.scriptable = spawnscriptable( "ob_combo_lock_entry", self.origin + forward * 1, self.plate.angles * -1 );
    self.scriptable.digit_struct = self;
    self.scriptable.door = self.door;
    self.plate.scriptable = self.scriptable;
    self.spawned = 1;
}

// Namespace namespace_9499d190be9a2ad3 / namespace_26e60c953dc40f2c
// Params 1
// Checksum 0x0, Offset: 0x338
// Size: 0x8f
function digit_link( should_link )
{
    if ( !isdefined( self.scriptable ) )
    {
        return;
    }
    
    if ( !istrue( should_link ) )
    {
        current_state = self.scriptable getscriptablepartstate( "vfx", 0 );
        
        if ( current_state != "unlinked" )
        {
            self.scriptable setscriptablepartstate( "model", current_state );
        }
        
        self.scriptable setscriptablepartstate( "vfx", "unlinked" );
        self.scriptable setscriptablepartstate( "health", "damageable" );
    }
}

// Namespace namespace_9499d190be9a2ad3 / namespace_26e60c953dc40f2c
// Params 1
// Checksum 0x0, Offset: 0x3cf
// Size: 0x44
function digit_lock( should_lock )
{
    if ( should_lock )
    {
        self.scriptable setscriptablepartstate( "health", "inactive" );
        return;
    }
    
    self.scriptable setscriptablepartstate( "health", "damageable" );
}

// Namespace namespace_9499d190be9a2ad3 / namespace_26e60c953dc40f2c
// Params 0
// Checksum 0x0, Offset: 0x41b
// Size: 0x8d
function digit_cleanup()
{
    if ( !isdefined( self.scriptable ) )
    {
        return;
    }
    
    self.scriptable setscriptablepartstate( "model", "inactive" );
    self.scriptable setscriptablepartstate( "vfx", "unlinked" );
    self.scriptable setscriptablepartstate( "health", "inactive" );
    self.scriptable freescriptable();
    self.plate setscriptablepartstate( "model", "inactive" );
    self.spawned = 0;
}

// Namespace namespace_9499d190be9a2ad3 / namespace_26e60c953dc40f2c
// Params 11
// Checksum 0x0, Offset: 0x4b0
// Size: 0xd7
function function_cdbec4722f88f614( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vhitloc, modelindex, partname )
{
    if ( !isdefined( instance ) || instance.type != "ob_combo_lock_entry" )
    {
        return;
    }
    
    if ( einflictor.classname == "rocket" || einflictor.classname == "grenade" )
    {
        if ( distance( vhitloc, einflictor.origin ) > 2 )
        {
            instance setscriptablepartstate( "health", "damageable" );
            return;
        }
    }
    
    instance thread function_d94f8bea6e21780d( instance );
}

// Namespace namespace_9499d190be9a2ad3 / namespace_26e60c953dc40f2c
// Params 1
// Checksum 0x0, Offset: 0x58f
// Size: 0x37
function function_d94f8bea6e21780d( instance )
{
    state = instance getscriptablepartstate( "model", 0 );
    instance.door namespace_b1453e6e8267c3ce::function_3edb9b978dca8642( instance, state );
}

// Namespace namespace_9499d190be9a2ad3 / namespace_26e60c953dc40f2c
// Params 4
// Checksum 0x0, Offset: 0x5ce
// Size: 0xee
function function_25da66b947454d11( instance, note, param, var_535d9c3fdddab5a9 )
{
    if ( !isdefined( instance ) || instance.type != "ob_combo_lock_flagstone" || !isdefined( instance.entity ) || !isdefined( instance.entity.index ) )
    {
        return;
    }
    
    instance.entity.scriptable setscriptablepartstate( "model", string( instance.entity.index ) );
    instance.entity.scriptable setscriptablepartstate( "vfx", "unlinked" );
    instance.entity.scriptable setscriptablepartstate( "health", "damageable" );
}

// Namespace namespace_9499d190be9a2ad3 / namespace_26e60c953dc40f2c
// Params 4
// Checksum 0x0, Offset: 0x6c4
// Size: 0x62
function function_d44e5d38e3b8fb2c( instance, note, param, var_535d9c3fdddab5a9 )
{
    if ( !isdefined( instance ) || instance.type != "ob_combo_lock_flagstone" || !isdefined( instance.entity ) )
    {
        return;
    }
    
    thread function_8e0504fb64822985( instance.entity );
}

// Namespace namespace_9499d190be9a2ad3 / namespace_26e60c953dc40f2c
// Params 1
// Checksum 0x0, Offset: 0x72e
// Size: 0x13
function function_8e0504fb64822985( ent )
{
    waitframe();
    ent delete();
}

// Namespace namespace_9499d190be9a2ad3 / namespace_26e60c953dc40f2c
// Params 1
// Checksum 0x0, Offset: 0x749
// Size: 0x5c
function function_c3e078f287496cf7( index )
{
    switch ( index )
    {
        case 1:
        case 2:
        case 6:
        case 7:
            return "ee_rune_flagstone_02_scr";
        default:
            return "ee_rune_flagstone_scr";
    }
}

// Namespace namespace_9499d190be9a2ad3 / namespace_26e60c953dc40f2c
// Params 1
// Checksum 0x0, Offset: 0x7ad
// Size: 0x18
function function_6ab8997a6d33d00d( index )
{
    return ( 0, 0, 0 );
}

