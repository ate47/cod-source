#using script_14c0c0fe8f807d31;
#using script_16ea1b94f0f381b3;
#using script_185660037b9236c1;
#using script_1df9c23e5c1ee0d5;
#using script_220d0eb95a8fab7d;
#using script_36eea22a3c04ac87;
#using script_3732202f0c4ea8b5;
#using script_39d11000e476a42a;
#using script_3d1e2bb7b03b1421;
#using script_41387eecc35b88bf;
#using script_419394a994aff1cd;
#using script_43ec7beab1d3ec4d;
#using script_482376d10f69832c;
#using script_4b13b59dbb4394e1;
#using script_4e6e58ab5d96c2b0;
#using script_4ef01fe6151dde4d;
#using script_4fdefae8b7bcdf73;
#using script_5753ba9c28794a65;
#using script_64351208cb856df9;
#using script_7956d56c4922bd1;
#using script_79deab1955343d5d;
#using script_7e018ed120c71de8;
#using script_7e41e37180e554f;
#using script_b57ac4d1a8845a1;
#using script_fa7b94914d42b31;
#using scripts\asm\shared\mp\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\utility\player;
#using scripts\ob\points;

#namespace namespace_71d5b8ce7aad46e3;

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 0
// Checksum 0x0, Offset: 0x9d9
// Size: 0x17
function init()
{
    callback::add( #"hash_7e2a860a57ef2c24", &function_e80f81f8625ce680 );
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 0
// Checksum 0x0, Offset: 0x9f8
// Size: 0x228
function function_3385e6792034eca9()
{
    /#
        thread function_fffd1047da555697();
        thread function_b771bf7aa70451f();
    #/
    
    if ( !getdvarint( @"hash_d3bc57668d7ef9cb", 0 ) )
    {
        level thread function_3772522b0b9af7c();
    }
    
    activity_common::function_89384091f7a2dbd( "REV_OB_UNSTABLE_RIFT_OBELISK", 0, &function_dedab1fbed7882de );
    activity_common::function_89384091f7a2dbd( "REV_OB_UNSTABLE_RIFT_OBELISK", 1, &function_caeaa8a40e161031 );
    activity_common::function_89384091f7a2dbd( "REV_OB_UNSTABLE_RIFT_OBELISK", 2, &function_c83b0ac33bca60a1 );
    activity_common::function_89384091f7a2dbd( "REV_OB_UNSTABLE_RIFT_OBELISK", 3, &function_6b672ad2c2d7e340 );
    activity_common::function_89384091f7a2dbd( "REV_OB_UNSTABLE_RIFT_OBELISK", 4, &function_39d346908caed0bd );
    activity_common::function_89384091f7a2dbd( "REV_OB_UNSTABLE_RIFT_OBELISK", 5, &function_a0fdbee567f0bd1e );
    activity_common::function_8b5b2a3392fc7e2a( "PlayerJoin", &function_1531bbf5cff97dc0, "REV_OB_UNSTABLE_RIFT_OBELISK" );
    activity_common::function_8b5b2a3392fc7e2a( "PlayerLeave", &function_5c651df8cfad0810, "REV_OB_UNSTABLE_RIFT_OBELISK" );
    level.var_871c6dfd1d2e510 = getdvarint( @"hash_adb236e5565ddb62", 1 );
    level.var_f6026c03a08e67fa = [ 30, 35, 40, 45 ];
    level.var_b5c75487d8c13198 = 0;
    level.var_f607826b73b56d1c = [ 10, 7.5, 5 ];
    level.var_6d298bb3b2c8bf0 = 0;
    level.objids = [];
    level.var_6646765597d09f2c = [];
    level._effect[ "item_glow_toxic" ] = loadfx( "vfx/jup/ob/gameplay/zm/vfx_obelisk_toxic_trail.vfx" );
    level._effect[ "item_glow_electric" ] = loadfx( "vfx/jup/ob/gameplay/zm/vfx_obelisk_elec_trail.vfx" );
    level._effect[ "item_glow_fire" ] = loadfx( "vfx/jup/ob/gameplay/zm/vfx_obelisk_fire_trail.vfx" );
    level._effect[ "item_glow_ice" ] = loadfx( "vfx/jup/ob/gameplay/zm/vfx_obelisk_cryo_trail.vfx" );
    level._effect[ "item_portal" ] = loadfx( "vfx/jup/ob/gameplay/zm/vfx_obelisk_geotrail_portal.vfx" );
    level._effect[ "zombie_death" ] = loadfx( "vfx/jup/ob/gameplay/zm/vfx_obelisk_soul_spawn.vfx" );
    level._effect[ "zombie_soul" ] = loadfx( "vfx/jup/ob/gameplay/zm/vfx_obelisk_soul_trail.vfx" );
    level._effect[ "zombie_soul_impact" ] = loadfx( "vfx/jup/ob/gameplay/zm/vfx_obelisk_soul_impact.vfx" );
    level thread namespace_5cbfe3d9044efce3::function_b7cec7edca510b6b();
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 0
// Checksum 0x0, Offset: 0xc28
// Size: 0x62
function function_dedab1fbed7882de()
{
    self.variant_definition = namespace_3485b020a23acaae::function_b9c4aa88ad97ee68( self );
    self.var_a480a3c2412fafb6 = "s_" + tolower( self.varianttag );
    [ self.var_14cb6c6c3e50ff2f ] = utility::getstructarray( self.var_a480a3c2412fafb6, "targetname" );
    function_3b2ade2aba896009();
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 0
// Checksum 0x0, Offset: 0xc92
// Size: 0x2
function function_caeaa8a40e161031()
{
    
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 0
// Checksum 0x0, Offset: 0xc9c
// Size: 0x2
function function_c83b0ac33bca60a1()
{
    
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 0
// Checksum 0x0, Offset: 0xca6
// Size: 0x5f
function function_6b672ad2c2d7e340()
{
    self.obelisk freescriptable();
    self.obelisk notify( "death" );
    self.var_427c4a1fb88ca4b3 freescriptable();
    self.var_427c4a1fb88ca4b3 notify( "death" );
    self.var_68d7534b8c965ed9 freescriptable();
    self.var_68d7534b8c965ed9 notify( "death" );
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 0
// Checksum 0x0, Offset: 0xd0d
// Size: 0x5b
function function_39d346908caed0bd()
{
    if ( !isdefined( self.var_14cb6c6c3e50ff2f ) )
    {
        var_aae133967c465bb1 = utility::getstructarray( "s_" + tolower( self.varianttag ), "targetname" );
        return var_aae133967c465bb1[ 0 ].origin;
    }
    
    return self.var_14cb6c6c3e50ff2f.origin;
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 0
// Checksum 0x0, Offset: 0xd71
// Size: 0x36
function function_a0fdbee567f0bd1e()
{
    reward_structs = utility::getstructarray( "s_" + tolower( self.varianttag ) + "_reward", "targetname" );
    return reward_structs[ 0 ];
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 1
// Checksum 0x0, Offset: 0xdb0
// Size: 0x37
function function_1531bbf5cff97dc0( var_b381b0883bcd4847 )
{
    player_list = var_b381b0883bcd4847.playerlist;
    var_a83ac3549acc2da2 = var_b381b0883bcd4847.playerjoinreason;
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 1
// Checksum 0x0, Offset: 0xdef
// Size: 0x22
function function_5c651df8cfad0810( var_b381b0883bcd4847 )
{
    player_list = var_b381b0883bcd4847.playerlist;
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 0
// Checksum 0x0, Offset: 0xe19
// Size: 0x1cb
function function_3b2ade2aba896009()
{
    var_f0a73224e2b13518 = utility::getstructarray( self.var_a480a3c2412fafb6, "target" );
    self.content_structs = [];
    
    foreach ( content_struct in var_f0a73224e2b13518 )
    {
        if ( !isdefined( content_struct.script_noteworthy ) )
        {
            continue;
        }
        
        if ( !isdefined( self.content_structs[ content_struct.script_noteworthy ] ) )
        {
            self.content_structs[ content_struct.script_noteworthy ] = [];
        }
        
        self.content_structs[ content_struct.script_noteworthy ] = utility::array_add( self.content_structs[ content_struct.script_noteworthy ], content_struct );
    }
    
    a_volumes = getnoentvolumearray( "obelisk_kill_radius", "targetname" );
    
    foreach ( volume in a_volumes )
    {
        if ( is_equal( volume.target, self.var_a480a3c2412fafb6 ) )
        {
            self.var_532ab55a367ba566 = volume;
            self.var_532ab55a367ba566.activity_instance = self;
        }
    }
    
    setup_obelisk( self.content_structs[ "obelisk_spawn" ][ 0 ] );
    
    /#
        if ( !isdefined( level.var_c3686ee8648cdaef ) )
        {
            level.var_c3686ee8648cdaef = [];
        }
        
        level.var_c3686ee8648cdaef[ level.var_c3686ee8648cdaef.size ] = self;
    #/
    
    namespace_4fda5d7358015a06::function_b6fc2c96b463c007( self );
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 1
// Checksum 0x0, Offset: 0xfec
// Size: 0x1a5
function setup_obelisk( obelisk_struct )
{
    self.var_61b796a5850f426d = getdvarint( @"hash_a5a29a83288936e0", level.var_f6026c03a08e67fa[ 0 ] );
    self.var_d27f8b283029b2d9 = 0;
    self.var_6b879e3378fe4f93 = 0;
    self.var_d46adf995eb7a148 = 0;
    self.var_2da558e8c88e09c = 0;
    self.var_8de84d74a1d3c4e6 = function_1bd14e008c9c2954();
    self.obelisk = spawnscriptable( "jup_zm_rift_pedestal_top_scriptable", obelisk_struct.origin + ( 0, 0, 40 ), obelisk_struct.angles );
    self.obelisk.activity_instance = self;
    self.obelisk setscriptablepartstate( "fx", "off" );
    self.var_427c4a1fb88ca4b3 = spawnscriptable( "jup_zm_rift_pedestal_base_scriptable", obelisk_struct.origin, obelisk_struct.angles );
    self.var_427c4a1fb88ca4b3.activity_instance = self;
    self.var_427c4a1fb88ca4b3.element = self.var_8de84d74a1d3c4e6;
    self.var_427c4a1fb88ca4b3.completed = 0;
    self.var_427c4a1fb88ca4b3 setscriptablepartstate( "body", "spawned_" + self.var_8de84d74a1d3c4e6 );
    self.var_427c4a1fb88ca4b3 setscriptablepartstate( "interact", "on" );
    scripts\cp_mp\interaction::function_32645103f7520635( self.var_427c4a1fb88ca4b3, &activate_obelisk, undefined, &obelisk_gesture );
    self.var_427c4a1fb88ca4b3 scripts\cp_mp\interaction::function_e6c63f16f2258b80( &function_dda97bcf0f20e53f );
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 0
// Checksum 0x0, Offset: 0x1199
// Size: 0x3a
function function_1bd14e008c9c2954()
{
    a_elements = [ "fire", "electric", "ice", "toxic" ];
    return random( a_elements );
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 2
// Checksum 0x0, Offset: 0x11dc
// Size: 0x113
function function_dda97bcf0f20e53f( interact, player )
{
    if ( !function_293126e150af264e( interact, player ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( istrue( interact.activity_instance.on_cooldown ) )
    {
        time_remaining = int( 30 - ( gettime() - interact.activity_instance.cooldown_timestamp ) / 1000 );
        return { #params:[ time_remaining ], #string:&"SHARED_HINTSTRINGS/UNSTABLE_RIFT_OBELISK_ON_COOLDOWN", #type:"HINT_NOBUTTON" };
    }
    
    if ( istrue( interact.activity_instance.var_d46adf995eb7a148 ) )
    {
        return { #string:&"JUP_OB_S1/SEAL_ALREADY_ACTIVE", #type:"HINT_NOBUTTON" };
    }
    
    return { #string:&"JUP_OB_S1/ACTIVATE_OBELISK", #type:"HINT_BUTTON" };
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 1
// Checksum 0x0, Offset: 0x12f7
// Size: 0x31
function obelisk_gesture( player )
{
    if ( function_293126e150af264e( self, player ) )
    {
        wait 1.15;
        
        if ( player usebuttonpressed() )
        {
            player forceplaygestureviewmodel( "jup_ges_open_portal" );
        }
    }
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 1
// Checksum 0x0, Offset: 0x1330
// Size: 0x2b3
function activate_obelisk( player )
{
    if ( !function_293126e150af264e( self, player ) || istrue( self.activity_instance.on_cooldown ) || istrue( self.var_d46adf995eb7a148 ) )
    {
        return;
    }
    
    var_9907d14293e5472f = scripts\mp\utility\player::getplayersinradius( self.origin, 600 );
    
    foreach ( nearby_player in var_9907d14293e5472f )
    {
        if ( !isdefined( self.activity_instance.var_24df7d1a509429e9 ) )
        {
            self.activity_instance.var_24df7d1a509429e9 = [];
        }
        
        self.activity_instance.var_24df7d1a509429e9[ nearby_player getentitynumber() ] = gettime();
        
        if ( !function_4ab1cdfd84bbd3f2( self.activity_instance, nearby_player ) )
        {
            function_bbdcd857d0c2a65e( self.activity_instance, nearby_player, "PlayerJoinedDamage" );
            self.activity_instance thread function_84f8dd4ca3291f3c( nearby_player );
        }
    }
    
    self.activity_instance.var_d46adf995eb7a148 = 1;
    self.activity_instance.var_2da558e8c88e09c = 0;
    
    foreach ( player in self.activity_instance.playerparticipants )
    {
        player namespace_b3f32c8cb80b8124::function_1b4c60d1baa7885f( "outbreak_riftrun" );
    }
    
    self.activity_instance thread namespace_b3f32c8cb80b8124::function_e73a92bbeb2ae323();
    self setscriptablepartstate( "body", "active_" + self.element );
    self setscriptablepartstate( "interact", "off" );
    self.activity_instance.var_68d7534b8c965ed9 = spawnscriptable( "jup_zm_rift_pedestal_orb_scriptable", self.origin + ( 0, 0, 40 ), self.angles );
    waitframe();
    level callback::add( "on_ai_killed", &function_6e42339d9503b6b7 );
    function_606642b946a01237( "obelisk", self.origin, 1500, self.element == "ice" );
    self.activity_instance function_6094ec6f1a58a381();
    self.activity_instance thread function_658b421b37fd7662();
    self.activity_instance thread function_c86b467241174d03();
    self.activity_instance thread function_d623f48233d8a741();
    self.activity_instance thread function_41c2e90ff617a658();
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 0
// Checksum 0x0, Offset: 0x15eb
// Size: 0x36
function function_d623f48233d8a741()
{
    self endon( "activity_ended" );
    self endon( "instance_destroyed" );
    var_985445305bbb9ea3 = getdvarint( @"hash_a92d27d37258fdb8", 180 );
    wait 180;
    reset_obelisk();
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 0
// Checksum 0x0, Offset: 0x1629
// Size: 0xcb
function function_41c2e90ff617a658()
{
    self endon( "activity_ended" );
    self endon( "instance_destroyed" );
    progresscheck = self.var_2da558e8c88e09c;
    
    if ( !isdefined( progresscheck ) )
    {
        progresscheck = 0;
    }
    
    var_fca2da9bc548a266 = getdvarint( @"hash_55e69644311e128d", 40 );
    var_34c61ca87e9edbf2 = gettime();
    
    while ( true )
    {
        if ( istrue( self.var_d46adf995eb7a148 ) && isdefined( self.var_2da558e8c88e09c ) )
        {
            if ( self.var_2da558e8c88e09c > progresscheck )
            {
                var_34c61ca87e9edbf2 = gettime();
                progresscheck = self.var_2da558e8c88e09c;
            }
            else if ( gettime() > var_34c61ca87e9edbf2 + var_fca2da9bc548a266 * 1000 )
            {
                reset_obelisk();
            }
        }
        else
        {
            var_34c61ca87e9edbf2 = gettime();
            progresscheck = self.var_2da558e8c88e09c;
        }
        
        wait 1;
    }
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 0
// Checksum 0x0, Offset: 0x16fc
// Size: 0x2e
function obelisk_on_cooldown()
{
    if ( istrue( self.on_cooldown ) )
    {
        return;
    }
    
    self notify( "on_cooldown" );
    self.cooldown_timestamp = gettime();
    thread function_1f6c6590e49b9fd();
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 0
// Checksum 0x0, Offset: 0x1732
// Size: 0x28
function function_1f6c6590e49b9fd()
{
    self endon( "activity_ended" );
    self endon( "instance_destroyed" );
    self.on_cooldown = 1;
    wait 30;
    self.on_cooldown = 0;
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 0
// Checksum 0x0, Offset: 0x1762
// Size: 0x10f
function function_c86b467241174d03()
{
    self endon( "activity_ended" );
    self endon( "instance_destroyed" );
    var_c1516fab62c509e6 = 0;
    var_9470827792ff998 = undefined;
    
    while ( true )
    {
        if ( istrue( self.var_d46adf995eb7a148 ) )
        {
            var_9907d14293e5472f = scripts\mp\utility\player::getplayersinradius( self.obelisk.origin, 600 );
            
            if ( !isdefined( self.var_24df7d1a509429e9 ) )
            {
                self.var_24df7d1a509429e9 = [];
            }
            
            foreach ( player in var_9907d14293e5472f )
            {
                self.var_24df7d1a509429e9[ player getentitynumber() ] = gettime();
            }
            
            if ( is_equal( var_9907d14293e5472f.size, 0 ) )
            {
                if ( !isdefined( var_9470827792ff998 ) )
                {
                    var_9470827792ff998 = gettime();
                }
            }
            else
            {
                var_9470827792ff998 = undefined;
            }
            
            if ( isdefined( var_9470827792ff998 ) && gettime() > var_9470827792ff998 + 5000 )
            {
                reset_obelisk();
                return;
            }
        }
        
        wait 3;
    }
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 0
// Checksum 0x0, Offset: 0x1879
// Size: 0x132
function reset_obelisk()
{
    if ( !istrue( self.var_d46adf995eb7a148 ) )
    {
        return;
    }
    
    self.var_d46adf995eb7a148 = 0;
    self.obelisk setscriptablepartstate( "fx", "off" );
    self.var_427c4a1fb88ca4b3.completed = 0;
    self.var_427c4a1fb88ca4b3 setscriptablepartstate( "body", "spawned_" + self.var_8de84d74a1d3c4e6 );
    self.var_427c4a1fb88ca4b3 setscriptablepartstate( "interact", "on" );
    self.var_68d7534b8c965ed9 freescriptable();
    self.var_68d7534b8c965ed9 notify( "death" );
    self.var_6b879e3378fe4f93 = 0;
    self.var_d27f8b283029b2d9 = 0;
    level callback::remove( "on_ai_killed", &function_6e42339d9503b6b7 );
    self notify( "obelisk_reset" );
    
    foreach ( player in self.playerparticipants )
    {
        function_91c9ad377a3c4725( self, [ player ] );
    }
    
    obelisk_on_cooldown();
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 0
// Checksum 0x0, Offset: 0x19b3
// Size: 0xa5
function function_6094ec6f1a58a381()
{
    self.var_44b27a8e32ebe296 = spawn_request( "ai_flood_fill_encounter:enc_ob_activity_unstable_rift_obelisk_" + self.var_427c4a1fb88ca4b3.element, self.var_427c4a1fb88ca4b3.origin, 1000, 1, 1, 0 );
    function_d37068aac7785c04( self.var_44b27a8e32ebe296, "special", 1 );
    function_bc5315dc37ae4cf( self.var_44b27a8e32ebe296, &function_b07493f60764eed4, self );
    function_73147cdf5c28d10c( self.var_44b27a8e32ebe296, &function_64f4df7704af6dc2, self );
    function_e4a67fe4ddca7ed5( self.var_44b27a8e32ebe296, &function_5d1738a71dc36fa0, self.var_427c4a1fb88ca4b3 );
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 0
// Checksum 0x0, Offset: 0x1a60
// Size: 0x165
function function_658b421b37fd7662()
{
    self endon( "activity_ended" );
    self endon( "instance_destroyed" );
    self endon( "on_cooldown" );
    
    while ( istrue( self.var_d46adf995eb7a148 ) )
    {
        var_f911aed45eb961a3 = getaiarrayinradius( self.var_427c4a1fb88ca4b3.origin, 1000 );
        
        foreach ( zombie in var_f911aed45eb961a3 )
        {
            if ( !isdefined( zombie.var_f89106513931332c ) )
            {
                zombie.var_f89106513931332c = 0;
            }
            
            var_52d83275cdaec498 = distance2dsquared( zombie.origin, self.var_427c4a1fb88ca4b3.origin ) < 171396;
            
            if ( var_52d83275cdaec498 == 1 && zombie.var_f89106513931332c == 0 && isalive( zombie ) )
            {
                zombie function_3ab9164ef76940fd( "obelisk_vfx", self.var_8de84d74a1d3c4e6 );
                zombie.var_f89106513931332c = 1;
                continue;
            }
            
            if ( var_52d83275cdaec498 == 0 && zombie.var_f89106513931332c == 1 )
            {
                zombie function_3ab9164ef76940fd( "obelisk_vfx", "off" );
                zombie.var_f89106513931332c = 0;
            }
        }
        
        wait 0.2;
    }
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 1
// Checksum 0x0, Offset: 0x1bcd
// Size: 0xb1
function function_35682bc06e3a7d3a( params )
{
    if ( level.var_747eee71c41ccadc != "" && level.var_6d298bb3b2c8bf0 == 0 )
    {
        if ( distance2dsquared( self.origin, level.obelisks[ level.var_747eee71c41ccadc ].origin ) < 1000000 )
        {
            if ( level.var_b5c75487d8c13198 < level.var_f607826b73b56d1c.size )
            {
                level.var_6d298bb3b2c8bf0 = level.var_f607826b73b56d1c[ level.var_b5c75487d8c13198 ];
                level.var_b5c75487d8c13198++;
                wait level.var_6d298bb3b2c8bf0;
                level.var_6d298bb3b2c8bf0 = 0;
            }
        }
    }
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 2
// Checksum 0x0, Offset: 0x1c86
// Size: 0x9f
function function_b07493f60764eed4( requestid, activity_instance )
{
    squadsize = level.players.size;
    var_b4a0bb985e832edf = activity_instance.var_d27f8b283029b2d9 / activity_instance.var_61b796a5850f426d;
    var_415fd8a0dbe8422f = 0.7;
    var_ebae3ffd14f48d6e = 2.3;
    waveinterval = var_415fd8a0dbe8422f + ( var_ebae3ffd14f48d6e - var_415fd8a0dbe8422f ) * ( 1 - var_b4a0bb985e832edf );
    wait waveinterval + level.var_6d298bb3b2c8bf0;
    
    if ( istrue( activity_instance.var_d46adf995eb7a148 ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 2
// Checksum 0x0, Offset: 0x1d2d
// Size: 0x2a
function function_64f4df7704af6dc2( requestid, userdata )
{
    if ( istrue( userdata.var_d46adf995eb7a148 ) )
    {
        return 0;
    }
    
    return 1;
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 4
// Checksum 0x0, Offset: 0x1d5f
// Size: 0xa1
function function_5d1738a71dc36fa0( requestid, obelisk, zombie, ai_data )
{
    if ( is_equal( zombie.subclass, "zombie_disciple" ) || is_equal( zombie.subclass, "zombie_mangler" ) || is_equal( zombie.subclass, "zombie_mimic" ) )
    {
        function_d37068aac7785c04( requestid, "special", 0 );
    }
    
    zombie.obelisk = obelisk;
    zombie function_65cdab0fc78aba8f( obelisk.origin, 621 );
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 1
// Checksum 0x0, Offset: 0x1e08
// Size: 0x33d
function function_6e42339d9503b6b7( params )
{
    self function_9322f3cb1cd4111a();
    function_3ab9164ef76940fd( "obelisk_vfx", "off" );
    
    if ( !isdefined( self.obelisk ) )
    {
        a_volumes = getnoentvolumearray( "obelisk_kill_radius", "targetname" );
        
        foreach ( volume in a_volumes )
        {
            if ( self istouching( volume ) && isdefined( volume.activity_instance ) )
            {
                self.obelisk = volume.activity_instance.obelisk;
            }
        }
        
        if ( !isdefined( self.obelisk ) )
        {
            return;
        }
    }
    
    var_3e5bef4b6dd3e32a = self.obelisk.origin;
    
    if ( istrue( function_84c6c9f7004416ed( self, self.obelisk.activity_instance.var_8de84d74a1d3c4e6, params ) ) && distance2dsquared( self.origin, var_3e5bef4b6dd3e32a ) < 171396 )
    {
        playfx( getfx( "zombie_death" ), self.origin );
        
        if ( self.obelisk.activity_instance.var_d27f8b283029b2d9 < self.obelisk.activity_instance.var_61b796a5850f426d )
        {
            self.obelisk.activity_instance.var_d27f8b283029b2d9++;
            function_2b6783f1c69393ff( self.origin + ( 0, 0, 40 ), var_3e5bef4b6dd3e32a + ( 0, 0, 170 ), 0.25, self.obelisk.activity_instance );
            
            if ( !isdefined( self.obelisk.activity_instance.var_7c5e1244d0e9acfa ) )
            {
                self.obelisk.activity_instance.var_7c5e1244d0e9acfa = [];
            }
            
            if ( isplayer( params.eattacker ) && isalive( params.eattacker ) )
            {
                self.obelisk.activity_instance.var_7c5e1244d0e9acfa = function_6d6af8144a5131f1( self.obelisk.activity_instance.var_7c5e1244d0e9acfa, params.eattacker );
                level.var_6646765597d09f2c = function_6d6af8144a5131f1( level.var_6646765597d09f2c, params.eattacker );
                
                if ( !function_4ab1cdfd84bbd3f2( self.obelisk.activity_instance, params.eattacker ) )
                {
                    function_bbdcd857d0c2a65e( self.obelisk.activity_instance, params.eattacker, "PlayerJoinedDamage" );
                    self.obelisk.activity_instance thread function_84f8dd4ca3291f3c( params.eattacker );
                }
            }
        }
    }
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 1
// Checksum 0x0, Offset: 0x214d
// Size: 0xa6
function function_84f8dd4ca3291f3c( player )
{
    self endon( "activity_ended" );
    self endon( "instance_destroyed" );
    player endon( "death_or_disconnect" );
    self endon( "obelisk_reset" );
    
    while ( true )
    {
        if ( isarray( self.var_24df7d1a509429e9 ) )
        {
            player_num = player getentitynumber();
            
            if ( !isdefined( self.var_24df7d1a509429e9[ player_num ] ) || gettime() > self.var_24df7d1a509429e9[ player_num ] + 5000 )
            {
                self.var_24df7d1a509429e9 = array_remove_key( self.var_24df7d1a509429e9, player_num );
                function_91c9ad377a3c4725( self, [ player ] );
                return;
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 2
// Checksum 0x0, Offset: 0x21fb
// Size: 0x101, Type: bool
function function_293126e150af264e( interact, player )
{
    s_ammo_mod = "";
    
    switch ( interact.activity_instance.var_8de84d74a1d3c4e6 )
    {
        case #"hash_ceb098150f024a39":
            s_ammo_mod = "napalmburst";
            break;
        case #"hash_f7a6ad55f66e4e1e":
            s_ammo_mod = "deadwire";
            break;
        case #"hash_47276d6c2f4cfd60":
            s_ammo_mod = "cryofreeze";
            break;
        case #"hash_6fe0d38b135245cc":
            s_ammo_mod = "brainrot";
            break;
    }
    
    a_weapons = player getweaponslistall();
    
    foreach ( weapon in a_weapons )
    {
        if ( is_equal( player function_87b7af080857567f( weapon ), s_ammo_mod ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 3
// Checksum 0x0, Offset: 0x2305
// Size: 0x1c0, Type: bool
function function_84c6c9f7004416ed( zombie, str_element, death_params )
{
    weaponelementtype = undefined;
    
    if ( isdefined( zombie.var_d37b75616f7c2ee ) && isdefined( zombie.var_d37b75616f7c2ee.weaponelementtype ) )
    {
        weaponelementtype = zombie.var_d37b75616f7c2ee.weaponelementtype;
    }
    else
    {
        weaponelementtype = function_591305dc9c07499b( death_params.sweapon, death_params.eattacker, death_params.smeansofdeath );
    }
    
    switch ( str_element )
    {
        case #"hash_ceb098150f024a39":
            if ( weaponelementtype == "fire" || death_params.smeansofdeath == "MOD_ELEMENTAL_FIRE" )
            {
                return true;
            }
            
            return false;
        case #"hash_f7a6ad55f66e4e1e":
            if ( weaponelementtype == "electrical" || death_params.smeansofdeath == "MOD_ELEMENTAL_ELEC" || isdefined( death_params.sweapon ) && is_equal( death_params.sweapon.basename, "energy_mine" ) )
            {
                return true;
            }
            
            return false;
        case #"hash_47276d6c2f4cfd60":
            if ( weaponelementtype == "cold" || death_params.smeansofdeath == "MOD_ELEMENTAL_COLD" )
            {
                return true;
            }
            
            return false;
        case #"hash_6fe0d38b135245cc":
            if ( weaponelementtype == "toxic" || death_params.smeansofdeath == "MOD_ELEMENTAL_TOXIC" || isdefined( death_params.eattacker ) && isplayer( death_params.eattacker.var_941802a0997e0c42 ) )
            {
                return true;
            }
            
            return false;
    }
    
    return false;
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 4
// Checksum 0x0, Offset: 0x24ce
// Size: 0x74
function function_2b6783f1c69393ff( spawn_origin, goal_position, move_delay, activity_instance )
{
    move_delay = utility::default_to( move_delay, 0 );
    trail = utility::spawn_model( "tag_origin", spawn_origin );
    trail.goal_position = goal_position;
    playfxontag( getfx( "zombie_soul" ), trail, "tag_origin" );
    trail thread function_57961c5b765c270( move_delay, activity_instance );
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 2
// Checksum 0x0, Offset: 0x254a
// Size: 0xb0
function function_57961c5b765c270( move_delay, activity_instance )
{
    self endon( "death" );
    self playsound( "evt_ob_rr_obelisk_soul_spawn" );
    self playloopsound( "evt_ob_rr_obelisk_soul_lp" );
    
    if ( move_delay > 0 )
    {
        wait move_delay;
    }
    
    self moveto( self.goal_position, 0.8, 0.2 );
    self waittill( "movedone" );
    playfx( getfx( "zombie_soul_impact" ), self.goal_position );
    killfxontag( getfx( "zombie_soul" ), self, "tag_origin" );
    playsoundatpos( self.origin, "evt_ob_rr_obelisk_soul_impact" );
    function_4234407e34a559f9( activity_instance );
    self delete();
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 1
// Checksum 0x0, Offset: 0x2602
// Size: 0x20e
function function_4234407e34a559f9( activity_instance )
{
    activity_instance.var_2da558e8c88e09c = min( activity_instance.var_d27f8b283029b2d9 / activity_instance.var_61b796a5850f426d, 1 );
    
    if ( activity_instance.var_2da558e8c88e09c > 0.33 && activity_instance.var_2da558e8c88e09c < 0.66 )
    {
        if ( !isdefined( activity_instance.var_f85150d2e7c056ab ) )
        {
            activity_instance.var_f85150d2e7c056ab = 0;
        }
        
        if ( !istrue( activity_instance.var_f85150d2e7c056ab ) )
        {
            activity_instance.var_f85150d2e7c056ab = 1;
            function_d37068aac7785c04( activity_instance.var_44b27a8e32ebe296, "special", 1 );
        }
    }
    else if ( activity_instance.var_2da558e8c88e09c > 0.66 )
    {
        if ( !isdefined( activity_instance.var_c1d5d3bb132994a6 ) )
        {
            activity_instance.var_c1d5d3bb132994a6 = 0;
        }
        
        if ( !istrue( activity_instance.var_c1d5d3bb132994a6 ) )
        {
            activity_instance.var_c1d5d3bb132994a6 = 1;
            function_d37068aac7785c04( activity_instance.var_44b27a8e32ebe296, "special", 1 );
        }
    }
    
    foreach ( player in level.players )
    {
    }
    
    if ( activity_instance.var_2da558e8c88e09c >= 1 )
    {
        activity_instance obelisk_completed( activity_instance.obelisk.origin );
        return;
    }
    
    if ( activity_instance.var_2da558e8c88e09c * 4 >= activity_instance.var_6b879e3378fe4f93 + 1 )
    {
        if ( activity_instance.var_6b879e3378fe4f93 == 0 && randomint( 100 ) < 66 )
        {
        }
        
        activity_instance.var_6b879e3378fe4f93++;
        activity_instance.obelisk setscriptablepartstate( "fx", activity_instance.var_8de84d74a1d3c4e6 + activity_instance.var_6b879e3378fe4f93 );
    }
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 1
// Checksum 0x0, Offset: 0x2818
// Size: 0x32a
function obelisk_completed( var_5535f2813b83d678 )
{
    self.var_427c4a1fb88ca4b3.completed = 1;
    self.obelisk setscriptablepartstate( "body", "destroyed" );
    self.obelisk setscriptablepartstate( "fx", self.var_8de84d74a1d3c4e6 + "_done" );
    self.var_427c4a1fb88ca4b3 setscriptablepartstate( "body", "spawned_" + self.var_8de84d74a1d3c4e6 );
    self.var_68d7534b8c965ed9 setscriptablepartstate( "body", "done" );
    self.var_6b879e3378fe4f93 = 0;
    self.var_d27f8b283029b2d9 = 0;
    level.var_b5c75487d8c13198 = 0;
    self.var_d46adf995eb7a148 = 0;
    level callback::remove( "on_ai_killed", &function_6e42339d9503b6b7 );
    function_c7311cb3f768f21e( "obelisk", 10 );
    explosionzombies = getaiarrayinradius( var_5535f2813b83d678, 1000, "team_two_hundred" );
    
    foreach ( zombie in explosionzombies )
    {
        if ( isalive( zombie ) )
        {
            zombie function_3ab9164ef76940fd( "obelisk_vfx", "off" );
            zombie kill();
            corpse = zombie getcorpseentity();
            
            if ( isdefined( corpse ) )
            {
                var_a33d2a2c3ffecb81 = corpse.origin - var_5535f2813b83d678 + ( 0, 0, 60 );
                var_83fd98f3ac829176 = max( 500 - distance2d( corpse.origin, var_5535f2813b83d678 ), 0 ) / 4;
                corpse startragdollfromimpact( "torso_upper", var_a33d2a2c3ffecb81 * var_83fd98f3ac829176 );
            }
        }
    }
    
    waitframe();
    level notify( "obelisk_complete" );
    params = spawnstruct();
    params.obelisk = self.obelisk;
    params.instance = self;
    
    if ( level.var_871c6dfd1d2e510 )
    {
        params.var_7c5e1244d0e9acfa = [];
        
        foreach ( player in level.var_6646765597d09f2c )
        {
            if ( isdefined( player ) )
            {
                a_squad = player squad_utility::getsquadmembers( undefined, 0 );
                
                foreach ( squad_player in a_squad )
                {
                    params.var_7c5e1244d0e9acfa = utility::function_6d6af8144a5131f1( params.var_7c5e1244d0e9acfa, squad_player );
                }
            }
        }
    }
    else
    {
        params.var_7c5e1244d0e9acfa = self.var_7c5e1244d0e9acfa;
    }
    
    callback::callback( "obelisk_completed", params );
    thread function_1b4163237ac97fbd();
    endactivity( self, 1 );
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 0
// Checksum 0x0, Offset: 0x2b4a
// Size: 0x112
function function_1b4163237ac97fbd()
{
    if ( !isarray( self.var_7c5e1244d0e9acfa ) )
    {
        return;
    }
    
    reward_placement = namespace_71ca15b739deab72::function_3ae7f99339b96499( self.obelisk.origin );
    reward_groups = [];
    
    foreach ( player in self.var_7c5e1244d0e9acfa )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        a_squad = player getsquadmembers( undefined, 0 );
        
        foreach ( squad_player in a_squad )
        {
            if ( isdefined( squad_player ) )
            {
                reward_groups[ reward_groups.size ] = [ squad_player ];
            }
        }
    }
    
    namespace_e8853d3344e33cf6::function_863be9e39e19fe2f( reward_groups, reward_placement, &function_e71c465bc9560e4f );
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 1
// Checksum 0x0, Offset: 0x2c64
// Size: 0x14a
function function_e71c465bc9560e4f( var_f7f66a8bcca0ac73 )
{
    cache = spawnstruct();
    
    if ( !isdefined( self.difficulty_region ) )
    {
        self.difficulty_region = "";
    }
    
    self.difficulty_region = [[ level.var_fac39a693f085779 ]]( self.obelisk.origin );
    
    switch ( self.difficulty_region )
    {
        case #"hash_7bb2cd766703d463":
            items = function_bc2f4857c90f5344( "ob_jup_items_contracts_yellow", 3 );
            break;
        case #"hash_af83e47edfa8900a":
            items = function_bc2f4857c90f5344( "ob_jup_items_contracts_orange", 3 );
            break;
        case #"hash_5343b465e56ec9a4":
            items = function_bc2f4857c90f5344( "ob_jup_items_contracts_orange", 3 );
            break;
        case #"hash_651f76c0ad6741ec":
            items = function_bc2f4857c90f5344( "ob_jup_items_contracts_orange", 3 );
            break;
        default:
            items = function_bc2f4857c90f5344( "ob_jup_items_contracts_yellow", 3 );
            break;
    }
    
    var_2ec876b0a5fd9ba5 = function_bc2f4857c90f5344( "ob_jup_items_ammomods", 1 );
    var_934d65bbe4c6a09 = array_combine( var_2ec876b0a5fd9ba5, items );
    common_cache::function_fd95ef820bb2b980( var_934d65bbe4c6a09, cache );
    return cache.contents;
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 0
// Checksum 0x0, Offset: 0x2db7
// Size: 0xba
function function_3772522b0b9af7c()
{
    level endon( "game_ended" );
    var_ce1dc1daec2ebb10 = getdvarint( @"hash_bbf0253c350a4df8", 3 );
    setdvar( @"hash_1866ffcb3e0817f2", var_ce1dc1daec2ebb10 );
    var_ce1dc1daec2ebb10 = getdvarint( @"hash_1cdf325484052db8", 2 );
    var_4ffad5755d8154aa = getdvarint( @"hash_7722e900429a2b62", 240 );
    
    while ( true )
    {
        wait var_4ffad5755d8154aa;
        var_527c858347566a7f = getdvarint( @"hash_1866ffcb3e0817f2", 0 );
        n_max = var_527c858347566a7f + var_ce1dc1daec2ebb10;
        
        if ( n_max >= 45 )
        {
            setdvar( @"hash_1866ffcb3e0817f2", 45 );
            return;
        }
        
        setdvar( @"hash_1866ffcb3e0817f2", n_max );
    }
}

// Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
// Params 1
// Checksum 0x0, Offset: 0x2e79
// Size: 0x1af
function function_e80f81f8625ce680( params )
{
    if ( !isdefined( params ) || !isdefined( params.var_b20b51d6b62fdff5 ) )
    {
        return;
    }
    
    switch ( params.var_b20b51d6b62fdff5 )
    {
        case #"hash_31103fbc01bd840c":
            function_447c6ab4bea16b52( "objective", "REV_OB_UNSTABLE_RIFT_OBELISK", &namespace_a304e973fe7f3f00::function_3385e6792034eca9, &namespace_1ae86528721c396f::function_fd69cf02ba4d90a2 );
            break;
        case #"hash_311042bc01bd88c5":
            function_447c6ab4bea16b52( "objective", "REV_OB_UNSTABLE_RIFT_OBELISK", &namespace_a304e973fe7f3f00::function_3385e6792034eca9, &namespace_15ac7d7a0789715f::function_fd69cf02ba4d90a2 );
            break;
        case #"hash_311041bc01bd8732":
            function_447c6ab4bea16b52( "objective", "REV_OB_UNSTABLE_RIFT_OBELISK", &namespace_a304e973fe7f3f00::function_3385e6792034eca9, &namespace_5e97d2e611a10663::function_fd69cf02ba4d90a2 );
            break;
        case #"hash_31103cbc01bd7f53":
            function_447c6ab4bea16b52( "objective", "REV_OB_UNSTABLE_RIFT_OBELISK", &namespace_a304e973fe7f3f00::function_3385e6792034eca9, &namespace_25ffb8c10bd771c3::function_fd69cf02ba4d90a2 );
            break;
        case #"hash_31103bbc01bd7dc0":
            function_447c6ab4bea16b52( "objective", "REV_OB_UNSTABLE_RIFT_OBELISK", &namespace_a304e973fe7f3f00::function_3385e6792034eca9, &namespace_e5c64f4f8e1690ef::function_fd69cf02ba4d90a2 );
            break;
        case #"hash_31103ebc01bd8279":
            function_447c6ab4bea16b52( "objective", "REV_OB_UNSTABLE_RIFT_OBELISK", &namespace_a304e973fe7f3f00::function_3385e6792034eca9, &namespace_e8b4c184a6d86a1f::function_fd69cf02ba4d90a2 );
            break;
        case #"hash_31103dbc01bd80e6":
            function_447c6ab4bea16b52( "objective", "REV_OB_UNSTABLE_RIFT_OBELISK", &namespace_a304e973fe7f3f00::function_3385e6792034eca9, &namespace_c4351e63e5ee1a1b::function_fd69cf02ba4d90a2 );
            break;
        case #"hash_311048bc01bd9237":
            function_447c6ab4bea16b52( "objective", "REV_OB_UNSTABLE_RIFT_OBELISK", &namespace_a304e973fe7f3f00::function_3385e6792034eca9, &namespace_a025e647ef8c2dbb::function_fd69cf02ba4d90a2 );
            break;
        case #"hash_311047bc01bd90a4":
            function_447c6ab4bea16b52( "objective", "REV_OB_UNSTABLE_RIFT_OBELISK", &namespace_a304e973fe7f3f00::function_3385e6792034eca9, &namespace_38b331194dcaff5f::function_fd69cf02ba4d90a2 );
            break;
    }
}

/#

    // Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
    // Params 0
    // Checksum 0x0, Offset: 0x3030
    // Size: 0x15a, Type: dev
    function function_b771bf7aa70451f()
    {
        level endon( "<dev string:x1c>" );
        level waittill( "<dev string:x2a>" );
        
        while ( level.players.size > 0 && level.var_c3686ee8648cdaef.size > 0 )
        {
            if ( getdvarint( @"hash_c3f8f7f1a32d1909", 0 ) == 1 )
            {
                setdvar( @"hash_c3f8f7f1a32d1909", 0 );
                
                foreach ( var_4dc8549c049ea9d3 in level.var_c3686ee8648cdaef )
                {
                    if ( isdefined( var_4dc8549c049ea9d3 ) && isdefined( var_4dc8549c049ea9d3.obelisk ) && !namespace_4fda5d7358015a06::function_bdd22095c4312f34( var_4dc8549c049ea9d3 ) )
                    {
                        zoffset = 50;
                        
                        foreach ( player in level.players )
                        {
                            if ( isdefined( player ) && isalive( player ) )
                            {
                                player setorigin( var_4dc8549c049ea9d3.obelisk.origin + ( 0, 0, zoffset ) );
                                zoffset += 50;
                            }
                        }
                        
                        break;
                    }
                }
            }
            
            wait 5;
        }
    }

    // Namespace namespace_71d5b8ce7aad46e3 / namespace_a304e973fe7f3f00
    // Params 1
    // Checksum 0x0, Offset: 0x3192
    // Size: 0xe, Type: dev
    function function_fffd1047da555697( params )
    {
        
    }

#/
