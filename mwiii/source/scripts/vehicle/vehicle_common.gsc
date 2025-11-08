#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\engine\utility;

#namespace vehicle_common;

// Namespace vehicle_common / scripts\vehicle\vehicle_common
// Params 4
// Checksum 0x0, Offset: 0xf6
// Size: 0x226
function requestentervehicle( vehicle, spawninvehicle, chosenvehicleposition, chosenvehicleanimpos )
{
    self._blackboard.var_b5096603d1631c0b = vehicle;
    self._blackboard.var_83aebffe3c7883c9 = spawninvehicle;
    self._blackboard.chosenvehiclelocation = chosenvehicleposition.origin;
    self._blackboard.chosenvehicleangles = chosenvehicleposition.angles;
    self._blackboard.var_9176cae5619d7fba = chosenvehicleposition.vehicle_position;
    self._blackboard.var_6a69fa6b0b354c93 = istrue( chosenvehicleposition.canshootinvehicle );
    self._blackboard.currentvehicleanimalias = vehicle.vehicleanimalias;
    self._blackboard.chosenvehicleanimpos_sittag = chosenvehicleanimpos.sittag;
    self._blackboard.chosenvehicleanimpos_linktoblend = istrue( chosenvehicleanimpos.linktoblend );
    self._blackboard.chosenvehicleanimpos_fastroperig = chosenvehicleanimpos.fastroperig;
    self._blackboard.var_ffbe5b175387642c = istrue( chosenvehicleanimpos.var_8af43e63a663dbd6 );
    self._blackboard.var_feaa963beeb05107 = istrue( chosenvehicleanimpos.onleft );
    
    if ( isdefined( chosenvehicleanimpos.vehicle_getoutanim ) )
    {
        self._blackboard.chosenvehicleanimpos_getoutanim = getanimname( chosenvehicleanimpos.vehicle_getoutanim );
    }
    else
    {
        self._blackboard.chosenvehicleanimpos_getoutanim = undefined;
    }
    
    self._blackboard.chosenvehicleanimpos_deathragdoll = istrue( chosenvehicleanimpos.deathragdoll );
    self._blackboard.chosenvehicleanimpos_deathimpulse = istrue( chosenvehicleanimpos.deathimpulse );
    self._blackboard.vehiclerequested = 1;
}

// Namespace vehicle_common / scripts\vehicle\vehicle_common
// Params 0
// Checksum 0x0, Offset: 0x324
// Size: 0x5e, Type: bool
function waitforentervehicle()
{
    msg = waittill_any_return_4( "entervehicle", "death", "long_death", "failedentervehicle" );
    
    if ( msg != "entervehicle" )
    {
        return false;
    }
    
    self allowvehiclepredictiveragdoll( 0 );
    self._blackboard.vehiclerequested = 0;
    
    /#
        thread function_9ec907df2fa3ceb7();
    #/
    
    return true;
}

// Namespace vehicle_common / scripts\vehicle\vehicle_common
// Params 0
// Checksum 0x0, Offset: 0x38b
// Size: 0x8a
function waitforarrivedatvehicle()
{
    self endon( "death" );
    self endon( "long_death" );
    
    while ( istrue( self._blackboard.vehiclerequested ) || isdefined( self._blackboard.currentvehicle ) && !istrue( self._blackboard.startedenteringvehicle ) && !istrue( self._blackboard.enteredvehicle ) && !self._blackboard.invehicle )
    {
        waitframe();
    }
}

// Namespace vehicle_common / scripts\vehicle\vehicle_common
// Params 4
// Checksum 0x0, Offset: 0x41d
// Size: 0x34, Type: bool
function entervehicle( vehicle, spawninvehicle, chosenvehicleposition, chosenvehicleanimpos )
{
    requestentervehicle( vehicle, spawninvehicle, chosenvehicleposition, chosenvehicleanimpos );
    return waitforentervehicle();
}

// Namespace vehicle_common / scripts\vehicle\vehicle_common
// Params 0
// Checksum 0x0, Offset: 0x45a
// Size: 0x2d
function requestexitvehicle()
{
    self._blackboard.exitvehiclerequested = 1;
    self._blackboard.vehiclerequested = 0;
}

// Namespace vehicle_common / scripts\vehicle\vehicle_common
// Params 0
// Checksum 0x0, Offset: 0x48f
// Size: 0x49
function waitforexitvehicle()
{
    self endon( "death" );
    self endon( "long_death" );
    
    while ( !istrue( self._blackboard.hasexitedvehicle ) )
    {
        waitframe();
    }
    
    self allowvehiclepredictiveragdoll( 1 );
    self._blackboard.hasexitedvehicle = 0;
}

// Namespace vehicle_common / scripts\vehicle\vehicle_common
// Params 0
// Checksum 0x0, Offset: 0x4e0
// Size: 0x10
function exitvehicle()
{
    requestexitvehicle();
    waitforexitvehicle();
}

// Namespace vehicle_common / scripts\vehicle\vehicle_common
// Params 0
// Checksum 0x0, Offset: 0x4f8
// Size: 0x3c, Type: bool
function hasvehicle()
{
    return istrue( self._blackboard.vehiclerequested ) || isdefined( self._blackboard ) && isdefined( self._blackboard.currentvehicle );
}

// Namespace vehicle_common / scripts\vehicle\vehicle_common
// Params 0
// Checksum 0x0, Offset: 0x53d
// Size: 0x18
function setuprope()
{
    self._blackboard.vehiclesetuprope = 1;
}

// Namespace vehicle_common / scripts\vehicle\vehicle_common
// Params 0
// Checksum 0x0, Offset: 0x55d
// Size: 0x7f, Type: bool
function function_b795d4c865a7bc7e()
{
    model = self.vehiclemodel;
    
    if ( model == "" )
    {
        model = self.model;
    }
    
    if ( issubstr( model, "::" ) )
    {
        model = strtok( model, "::" )[ 1 ];
    }
    
    if ( isdefined( level.vehicle.templates.husk[ model ] ) && !istrue( self.var_b3f762a51e1ed52a ) )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle_common / scripts\vehicle\vehicle_common
// Params 0
// Checksum 0x0, Offset: 0x5e5
// Size: 0x1f
function cancelentervehicle()
{
    self notify( "stop_loading" );
    self._blackboard.isrunningtovehicle = 0;
}

// Namespace vehicle_common / scripts\vehicle\vehicle_common
// Params 1
// Checksum 0x0, Offset: 0x60c
// Size: 0xa9, Type: bool
function function_ffd4bd7b834e69eb( var_1f37a785bba731e3 )
{
    vehicle = self._blackboard.currentvehicle;
    
    if ( !isdefined( vehicle ) )
    {
        return false;
    }
    
    if ( self._blackboard.var_9176cae5619d7fba == var_1f37a785bba731e3 )
    {
        return true;
    }
    
    if ( var_1f37a785bba731e3 >= vehicle.usedpositions.size )
    {
        return false;
    }
    
    if ( vehicle.usedpositions[ var_1f37a785bba731e3 ] == 1 )
    {
        return false;
    }
    
    self._blackboard.var_e38c46be257216d3 = var_1f37a785bba731e3;
    self._blackboard.var_bb19bd9078f99962 = 1;
    thread function_b2841b0708f2b5d4();
    return true;
}

// Namespace vehicle_common / scripts\vehicle\vehicle_common
// Params 0
// Checksum 0x0, Offset: 0x6be
// Size: 0x1eb
function function_b2841b0708f2b5d4()
{
    self endon( "death" );
    self endon( "long_death" );
    self._blackboard.var_3769628964ac89c1 = 0;
    
    while ( !self._blackboard.var_3769628964ac89c1 )
    {
        waitframe();
    }
    
    self._blackboard.var_9176cae5619d7fba = self._blackboard.var_e38c46be257216d3;
    self._blackboard.var_bb19bd9078f99962 = 0;
    vehicleanims = scripts\common\vehicle_aianim::anim_pos( self._blackboard.currentvehicle, self._blackboard.var_9176cae5619d7fba );
    self._blackboard.chosenvehicleanimpos_sittag = vehicleanims.sittag;
    self._blackboard.chosenvehicleanimpos_linktoblend = istrue( vehicleanims.linktoblend );
    self._blackboard.chosenvehicleanimpos_fastroperig = vehicleanims.fastroperig;
    self._blackboard.var_ffbe5b175387642c = vehicleanims.var_8af43e63a663dbd6;
    self._blackboard.var_feaa963beeb05107 = vehicleanims.onleft;
    
    if ( isdefined( vehicleanims.vehicle_getoutanim ) )
    {
        self._blackboard.chosenvehicleanimpos_getoutanim = getanimname( vehicleanims.vehicle_getoutanim );
    }
    else
    {
        self._blackboard.chosenvehicleanimpos_getoutanim = undefined;
    }
    
    self._blackboard.chosenvehicleanimpos_deathragdoll = istrue( vehicleanims.deathragdoll );
    self._blackboard.chosenvehicleanimpos_deathimpulse = istrue( vehicleanims.deathimpulse );
    self._blackboard.var_e38c46be257216d3 = undefined;
}

/#

    // Namespace vehicle_common / scripts\vehicle\vehicle_common
    // Params 1
    // Checksum 0x0, Offset: 0x8b1
    // Size: 0x54, Type: dev
    function function_745ac044fcee731b( value )
    {
        if ( getdvarint( @"ai_debugentindex" ) == -1 || getdvarint( @"ai_debugentindex" ) == self getentitynumber() )
        {
            if ( getdvarint( @"hash_3a76c9f686d280fc", 0 ) == value )
            {
                return 1;
            }
        }
        
        return 0;
    }

    // Namespace vehicle_common / scripts\vehicle\vehicle_common
    // Params 0
    // Checksum 0x0, Offset: 0x90d
    // Size: 0x5f6, Type: dev
    function function_9ec907df2fa3ceb7()
    {
        self endon( "<dev string:x1c>" );
        debugtextsize = 0.3;
        
        while ( isdefined( self._blackboard.currentvehicle ) )
        {
            vehicle = self._blackboard.currentvehicle;
            
            if ( function_745ac044fcee731b( 1 ) )
            {
                debugvehicleinfo = "<dev string:x25>" + string( vehicle scripts\common\vehicle_code::get_vehicle_classname() );
                var_93f33954046fbb10 = "<dev string:x32>";
                
                if ( isdefined( self._blackboard.var_9176cae5619d7fba ) )
                {
                    var_93f33954046fbb10 += string( self._blackboard.var_9176cae5619d7fba );
                }
                
                var_16614ab5a07da138 = "<dev string:x3e>";
                
                if ( isdefined( self._blackboard.currentvehicleanimalias ) )
                {
                    var_16614ab5a07da138 += string( self._blackboard.currentvehicleanimalias );
                }
                
                debugtaginfo = "<dev string:x47>";
                
                if ( isdefined( self._blackboard.chosenvehicleanimpos_sittag ) )
                {
                    debugtaginfo += string( self._blackboard.chosenvehicleanimpos_sittag );
                }
                
                print3d( self.origin + ( 0, 0, 69 ), debugvehicleinfo, ( 1, 1, 1 ), 1, debugtextsize );
                print3d( self.origin + ( 0, 0, 66 ), var_93f33954046fbb10, ( 1, 1, 1 ), 1, debugtextsize );
                print3d( self.origin + ( 0, 0, 63 ), var_16614ab5a07da138, ( 1, 1, 1 ), 1, debugtextsize );
                print3d( self.origin + ( 0, 0, 60 ), debugtaginfo, ( 1, 1, 1 ), 1, debugtextsize );
                selffwd = anglestoforward( self.angles );
                draw_arrow( self.origin, self.origin + selffwd * 20, ( 1, 1, 1 ) );
                seattagorigin = vehicle gettagorigin( self._blackboard.chosenvehicleanimpos_sittag );
                seattagangles = vehicle gettagangles( self._blackboard.chosenvehicleanimpos_sittag );
                seattagfwd = anglestoforward( seattagangles );
                var_965bea2644cdb628 = ( 0, 0, 1 );
                draw_arrow( seattagorigin + var_965bea2644cdb628, seattagorigin + seattagfwd * 15 + var_965bea2644cdb628, ( 0.6, 0, 0.6 ) );
                vehiclebundleinfo = scripts\common\vehicle_aianim::anim_pos( vehicle, self._blackboard.var_9176cae5619d7fba );
                linkangle = ( 0, 0, 0 );
                linkoffset = ( 0, 0, 0 );
                
                if ( isdefined( vehiclebundleinfo.linkangle ) )
                {
                    linkangle = vehiclebundleinfo.linkangle;
                }
                
                if ( isdefined( vehiclebundleinfo.linkoffset ) )
                {
                    linkoffset = vehiclebundleinfo.linkoffset;
                }
                
                if ( linkangle != ( 0, 0, 0 ) || linkoffset != ( 0, 0, 0 ) )
                {
                    fwdlinkoffset = rotatevector( seattagfwd, linkangle );
                    draw_arrow( seattagorigin + linkoffset + var_965bea2644cdb628, seattagorigin + linkoffset + var_965bea2644cdb628 + fwdlinkoffset * 15, ( 1, 0.2, 0.2 ) );
                }
            }
            else if ( function_745ac044fcee731b( 2 ) )
            {
                vehiclebundleinfo = scripts\common\vehicle_aianim::anim_pos( vehicle, self._blackboard.var_9176cae5619d7fba );
                var_adbf2061fb4e443d = "<dev string:x55>";
                
                if ( istrue( vehiclebundleinfo.canshootinvehicle ) )
                {
                    var_adbf2061fb4e443d = "<dev string:x71>";
                }
                
                var_7e03637d68944c16 = "<dev string:x8c>";
                
                if ( istrue( vehiclebundleinfo.canmeleeinvehicle ) )
                {
                    var_7e03637d68944c16 = "<dev string:xa8>";
                }
                
                var_461e599857a1a70f = "<dev string:xc3>";
                
                if ( istrue( vehiclebundleinfo.deathragdoll ) )
                {
                    var_461e599857a1a70f = "<dev string:xda>";
                }
                
                var_1165ae8c3a544686 = "<dev string:xf0>";
                
                if ( istrue( vehiclebundleinfo.bhasgunwhileriding ) )
                {
                    var_1165ae8c3a544686 = "<dev string:x10c>";
                }
                
                print3d( self.origin + ( 0, 0, 69 ), var_adbf2061fb4e443d, ( 1, 1, 1 ), 1, debugtextsize );
                print3d( self.origin + ( 0, 0, 66 ), var_7e03637d68944c16, ( 1, 1, 1 ), 1, debugtextsize );
                print3d( self.origin + ( 0, 0, 63 ), var_461e599857a1a70f, ( 1, 1, 1 ), 1, debugtextsize );
                print3d( self.origin + ( 0, 0, 60 ), var_1165ae8c3a544686, ( 1, 1, 1 ), 1, debugtextsize );
            }
            else if ( function_745ac044fcee731b( 3 ) )
            {
                var_10effa490054d61e = isdefined( self.var_d9134148f9bb887 ) && isdefined( self.var_f39c6b01b1d95542 ) && gettime() >= self.var_f39c6b01b1d95542 && gettime() < self.var_d9134148f9bb887;
                debugtransitioninfo = "<dev string:x127>";
                
                if ( var_10effa490054d61e )
                {
                    debugtransitioninfo += "<dev string:x12b>";
                }
                
                print3d( self.origin + ( 0, 0, 69 ), debugtransitioninfo, ( 1, 1, 1 ), 1, debugtextsize );
            }
            
            waitframe();
        }
    }

#/
