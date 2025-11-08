#using scripts\asm\asm;
#using scripts\asm\cap;
#using scripts\asm\shared\utility;

#namespace cap_green_beam;

// Namespace cap_green_beam / namespace_1b5b06ec6f076597
// Params 3
// Checksum 0x0, Offset: 0xfc
// Size: 0x8d
function function_b3363cc14cbca5f3( asmname, statename, params )
{
    laser = spawn( "script_model", self gettagorigin( "tag_accessory_left" ) );
    laser.angles = self gettagangles( "tag_accessory_left" );
    laser setmodel( "misc_wm_handheld_green_laser" );
    laser linkto( self, "tag_accessory_left" );
    self.laser = laser;
    
    if ( !isdefined( self.green_beam ) )
    {
        self.green_beam = 1;
    }
}

// Namespace cap_green_beam / namespace_1b5b06ec6f076597
// Params 3
// Checksum 0x0, Offset: 0x191
// Size: 0x2c, Type: bool
function function_13989fec47c1786f( asmname, statename, params )
{
    if ( istrue( self.green_beam ) )
    {
        return false;
    }
    
    return true;
}

// Namespace cap_green_beam / namespace_1b5b06ec6f076597
// Params 1
// Checksum 0x0, Offset: 0x1c6
// Size: 0xa2
function function_eb6dc231debf349c( note )
{
    if ( !isai( self ) )
    {
        return;
    }
    
    if ( note == "greenbeam_on" )
    {
        if ( isdefined( self.var_4f088434309b2333 ) )
        {
            self.laser setmoverlaserweapon( self.var_4f088434309b2333 );
        }
        else
        {
            self.laser setmoverlaserweapon( "iw8_laser_painter_ac130_lasso_short" );
        }
        
        if ( istrue( self.no_laser ) )
        {
            return;
        }
        
        self.laser laserforceon();
        return;
    }
    
    if ( note == "greenbeam_off" && isdefined( self.laser ) )
    {
        self.laser laserforceoff();
    }
}

// Namespace cap_green_beam / namespace_1b5b06ec6f076597
// Params 3
// Checksum 0x0, Offset: 0x270
// Size: 0x55
function function_3029fafe943a11b9( asmname, statename, params )
{
    if ( isdefined( self.laser ) )
    {
        self.laser delete();
        self.laser = undefined;
    }
    
    self.green_beam = 0;
    scripts\asm\cap::cap_exit( asmname, statename, params );
}

