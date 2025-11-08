#using script_16ea1b94f0f381b3;
#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_3ab210ea917601e7;
#using script_3e31016b9c11a616;
#using script_41387eecc35b88bf;
#using script_4ef01fe6151dde4d;
#using script_4fdefae8b7bcdf73;
#using script_5753ba9c28794a65;
#using script_6df6604a74a7a9c7;
#using script_7956d56c4922bd1;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_c8a807248ca3f47d;

// Namespace namespace_c8a807248ca3f47d / namespace_d56687a02b91720a
// Params 0
// Checksum 0x0, Offset: 0x1b9
// Size: 0x9f
function function_31e28d0e057c0d07()
{
    function_89384091f7a2dbd( "REV_OB_SEISMIC_REFRACTOR", 0, &activity_setup );
    function_89384091f7a2dbd( "REV_OB_SEISMIC_REFRACTOR", 1, &activity_begin );
    function_89384091f7a2dbd( "REV_OB_SEISMIC_REFRACTOR", 2, &activity_ended );
    function_89384091f7a2dbd( "REV_OB_SEISMIC_REFRACTOR", 3, &activity_destroy );
    function_89384091f7a2dbd( "REV_OB_SEISMIC_REFRACTOR", 4, &function_6bb48579974ebf1e );
    function_89384091f7a2dbd( "REV_OB_SEISMIC_REFRACTOR", 5, &function_81c481082c5b5b33 );
    function_8b5b2a3392fc7e2a( "PlayerJoin", &function_1531bbf5cff97dc0, "REV_OB_SEISMIC_REFRACTOR" );
    function_8b5b2a3392fc7e2a( "PlayerLeave", &function_5c651df8cfad0810, "REV_OB_SEISMIC_REFRACTOR" );
}

// Namespace namespace_c8a807248ca3f47d / namespace_d56687a02b91720a
// Params 0
// Checksum 0x0, Offset: 0x260
// Size: 0x102
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( "activity_ended" );
    activity_instance endon( "instance_destroyed" );
    self.event_center = getstruct( self.varianttag, "targetname" );
    self.var_d1ae8ddead6cd001 = getstruct( self.varianttag + "_RADIANT", "targetname" );
    self.var_5e039caea04140ad = self.var_d1ae8ddead6cd001 function_50b5e4fcc500bb90( "seismic_refractor_console", "targetname" )[ 0 ];
    self.var_5e039caea04140ad setscriptablepartstate( "model", "1" );
    self.request_id = function_3ee36bc763779ba1( self.var_d1ae8ddead6cd001.target, 1, 1, 2, 2 );
    function_84b829dec3e573eb( self.request_id, &function_e79f9faf8ebf2975, activity_instance );
    
    while ( !( self.var_5e039caea04140ad getscriptablepartstate( "model" ) == "active" ) )
    {
        waitframe();
    }
    
    function_b6fc2c96b463c007( activity_instance );
}

// Namespace namespace_c8a807248ca3f47d / namespace_d56687a02b91720a
// Params 0
// Checksum 0x0, Offset: 0x36a
// Size: 0x3b
function activity_begin()
{
    activity_instance = self;
    activity_instance endon( "activity_ended" );
    activity_instance endon( "instance_destroyed" );
    thread function_29e25c057d535749();
    wait 4;
    function_55caa7ecdad1659c( self.request_id );
}

// Namespace namespace_c8a807248ca3f47d / namespace_d56687a02b91720a
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3ad
// Size: 0x7c
function private function_29e25c057d535749()
{
    var_85605e53426618ed = randomintrange( 8, 12 );
    var_2a4bffc6b2eef12d = 300;
    
    for ( i = 0; i < var_85605e53426618ed ; i++ )
    {
        offset = function_6174330574a2a273() * var_2a4bffc6b2eef12d;
        
        while ( !( self.var_5e039caea04140ad getscriptablepartstate( "effects" ) == "pulse" ) )
        {
            waitframe();
        }
        
        wait 1;
    }
    
    endactivity( self, 0 );
}

// Namespace namespace_c8a807248ca3f47d / namespace_d56687a02b91720a
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x431
// Size: 0x25, Type: bool
function private function_e79f9faf8ebf2975( requestid, userdata, zmb, data )
{
    return true;
}

// Namespace namespace_c8a807248ca3f47d / namespace_d56687a02b91720a
// Params 1
// Checksum 0x0, Offset: 0x45f
// Size: 0x1f
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( "instance_destroyed" );
}

// Namespace namespace_c8a807248ca3f47d / namespace_d56687a02b91720a
// Params 0
// Checksum 0x0, Offset: 0x486
// Size: 0x1d
function activity_destroy()
{
    activity_instance = self;
    activity_instance endon( "instance_destroyed" );
    function_c0d31caee717b8eb();
}

// Namespace namespace_c8a807248ca3f47d / namespace_d56687a02b91720a
// Params 0
// Checksum 0x0, Offset: 0x4ab
// Size: 0x34
function function_c0d31caee717b8eb()
{
    self.var_5e039caea04140ad setscriptablepartstate( "effects", "0" );
    self.var_5e039caea04140ad setscriptablepartstate( "model", "0" );
}

// Namespace namespace_c8a807248ca3f47d / namespace_d56687a02b91720a
// Params 0
// Checksum 0x0, Offset: 0x4e7
// Size: 0xf
function function_6bb48579974ebf1e()
{
    return ( 0, 0, 0 );
}

// Namespace namespace_c8a807248ca3f47d / namespace_d56687a02b91720a
// Params 0
// Checksum 0x0, Offset: 0x4ff
// Size: 0x5a
function function_81c481082c5b5b33()
{
    var_cc7aa96a854fd8ee = spawnstruct();
    var_cc7aa96a854fd8ee.origin = self.var_d1ae8ddead6cd001.origin + ( 0, 50, 0 );
    var_cc7aa96a854fd8ee.angles = ( 0, 0, 0 );
    return var_cc7aa96a854fd8ee;
}

// Namespace namespace_c8a807248ca3f47d / namespace_d56687a02b91720a
// Params 1
// Checksum 0x0, Offset: 0x562
// Size: 0x37
function function_1531bbf5cff97dc0( var_b381b0883bcd4847 )
{
    player_list = var_b381b0883bcd4847.playerlist;
    var_a83ac3549acc2da2 = var_b381b0883bcd4847.playerjoinreason;
}

// Namespace namespace_c8a807248ca3f47d / namespace_d56687a02b91720a
// Params 1
// Checksum 0x0, Offset: 0x5a1
// Size: 0x22
function function_5c651df8cfad0810( var_b381b0883bcd4847 )
{
    player_list = var_b381b0883bcd4847.playerlist;
}

