#using script_57bdd8aff28a4717;
#using script_71f05b1d487869d3;
#using script_7c2886c7a12179f;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\teams;

#namespace namespace_8cc7824223500536;

// Namespace namespace_8cc7824223500536 / namespace_f60f8b35aea76152
// Params 0
// Checksum 0x0, Offset: 0x36f
// Size: 0xf1
function init()
{
    var_c18b410395ac261f = 0;
    
    foreach ( player in level.players )
    {
        player.var_fad5c3453452323f = 0;
        
        if ( namespace_362cfff5d79f8b9b::function_95ec56461198f3f9( player ) )
        {
            var_c18b410395ac261f = 1;
        }
    }
    
    if ( istrue( var_c18b410395ac261f ) )
    {
        namespace_af97b0039fe151ef::main();
        waitframe();
        level.var_5511b213868eba12 = [];
        level._effect[ "footstep_left" ] = loadfx( "vfx/jup/equipment/vfx_blacklight_print_left.vfx" );
        level._effect[ "footstep_right" ] = loadfx( "vfx/jup/equipment/vfx_blacklight_print_right.vfx" );
        scripts\engine\utility::registersharedfunc( "unlock_relics_s3", "death_perception_check", &function_b8fe7f5ed600420d );
        function_107f5908606cc82();
        function_5eb3707c330f26a8();
        return;
    }
    
    logstring( "S3 Crayon Relic: No players in match can receive Crayon Relic, fully skipping initialization" );
}

// Namespace namespace_8cc7824223500536 / namespace_f60f8b35aea76152
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x468
// Size: 0x43
function private function_b8fe7f5ed600420d()
{
    if ( isdefined( self ) && isplayer( self ) && namespace_362cfff5d79f8b9b::function_95ec56461198f3f9( self ) && !istrue( self.var_fad5c3453452323f ) )
    {
        level.var_5511b213868eba12 = function_6d6af8144a5131f1( level.var_5511b213868eba12, self );
    }
}

// Namespace namespace_8cc7824223500536 / namespace_f60f8b35aea76152
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x4b3
// Size: 0xfe
function private function_107f5908606cc82()
{
    var_5a99f3b0edabea7 = getstructarray( "relic_crayon_footstep_left", "targetname" );
    var_85010eb80cfe5ea0 = getstructarray( "relic_crayon_footstep_right", "targetname" );
    
    foreach ( step in var_5a99f3b0edabea7 )
    {
        level thread function_db697c35c5f45d87( step.origin, step.angles, 1 );
    }
    
    foreach ( var_62a529761893c693 in var_85010eb80cfe5ea0 )
    {
        level thread function_db697c35c5f45d87( var_62a529761893c693.origin, var_62a529761893c693.angles );
    }
}

// Namespace namespace_8cc7824223500536 / namespace_f60f8b35aea76152
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x5b9
// Size: 0x15c
function private function_db697c35c5f45d87( pos, angles, var_1ec37f1e7a9e2ec9 )
{
    level endon( "game_ended" );
    
    if ( !isdefined( pos ) )
    {
        return;
    }
    
    forwardvec = anglestoforward( angles );
    upvec = anglestoup( angles );
    assert( isdefined( forwardvec ) && isdefined( upvec ), "<dev string:x1c>" );
    waitduration = getdvarfloat( @"hash_91498974181abee6", 4 );
    effectid = istrue( var_1ec37f1e7a9e2ec9 ) ? level._effect[ "footstep_left" ] : level._effect[ "footstep_right" ];
    
    while ( true )
    {
        if ( level.var_5511b213868eba12.size > 0 )
        {
            var_cd72aa21f648238e = 0;
            
            foreach ( player in level.var_5511b213868eba12 )
            {
                if ( !isdefined( player ) )
                {
                    var_cd72aa21f648238e = 1;
                    continue;
                }
                
                playfx( effectid, pos, forwardvec, upvec, player );
                wait waitduration;
            }
            
            if ( var_cd72aa21f648238e )
            {
                level.var_5511b213868eba12 = array_removeundefined( level.var_5511b213868eba12 );
            }
            
            continue;
        }
        
        wait 5;
    }
}

// Namespace namespace_8cc7824223500536 / namespace_f60f8b35aea76152
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x71d
// Size: 0xb0
function private function_5eb3707c330f26a8()
{
    array = [];
    level.var_e16818aeb4b10beb = getnoentvolumearray( "relic_crayon_footstep_bed_trigger", "targetname" );
    interactionstruct = getstruct( "relic_journal_bed_interact", "targetname" );
    var_179343b5981c3088 = getstruct( "relic_journal_bed_reward", "targetname" );
    
    foreach ( volume in level.var_e16818aeb4b10beb )
    {
        thread function_967c8a57bedde2ee( volume, interactionstruct, var_179343b5981c3088 );
    }
}

// Namespace namespace_8cc7824223500536 / namespace_f60f8b35aea76152
// Params 3
// Checksum 0x0, Offset: 0x7d5
// Size: 0x11e
function function_967c8a57bedde2ee( volume, interactionstruct, var_179343b5981c3088 )
{
    assert( isdefined( volume ) );
    level endon( "game_ended" );
    volume endon( "death" );
    volume.interact = scripts\cp_mp\interaction::register_interact( interactionstruct.origin, interactionstruct.radius, &function_7f0f61d056244f1e );
    volume.interact scripts\cp_mp\interaction::function_e6c63f16f2258b80( &function_71b156e80b222071 );
    volume.interact.var_cd1123b87e8747d4 = [];
    volume.interact.var_179343b5981c3088 = var_179343b5981c3088;
    
    while ( true )
    {
        volume waittill( "trigger", enteringentity );
        
        if ( isdefined( enteringentity ) && isplayer( enteringentity ) && namespace_362cfff5d79f8b9b::function_95ec56461198f3f9( enteringentity ) && !istrue( enteringentity.var_fad5c3453452323f ) )
        {
            volume.interact.var_cd1123b87e8747d4 = function_6d6af8144a5131f1( volume.interact.var_cd1123b87e8747d4, enteringentity );
        }
    }
}

// Namespace namespace_8cc7824223500536 / namespace_f60f8b35aea76152
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x8fb
// Size: 0xfd
function private function_7f0f61d056244f1e( player )
{
    if ( !isdefined( player ) || istrue( player.var_fad5c3453452323f ) )
    {
        return;
    }
    
    var_8232fe13bffb624 = isdefined( self.var_179343b5981c3088 ) ? self.var_179343b5981c3088.origin : self.origin;
    a_squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
    
    if ( isdefined( a_squad ) )
    {
        self.var_cd1123b87e8747d4 = array_remove_array( a_squad, self.var_cd1123b87e8747d4 );
        
        foreach ( squadmember in a_squad )
        {
            squadmember.var_fad5c3453452323f = 1;
            thread scripts\cp_mp\overlord::playevent( "RFT_S3_5_RGUQ_Whispers_Drawing", [ squadmember ] );
        }
    }
    
    wait 10;
    namespace_fc89f9b99b72df11::function_65e52fad2bce952c( player, "ob_jup_hydro_obelisk_reward_crayon_s3", var_8232fe13bffb624 );
}

// Namespace namespace_8cc7824223500536 / namespace_f60f8b35aea76152
// Params 2
// Checksum 0x0, Offset: 0xa00
// Size: 0xc1
function function_71b156e80b222071( interact, player )
{
    if ( isdefined( interact.var_cd1123b87e8747d4 ) && interact.var_cd1123b87e8747d4.size > 0 && array_contains( interact.var_cd1123b87e8747d4, player ) && istrue( array_contains( level.var_5511b213868eba12, player ) ) )
    {
        var_7855fd9575dfd1bf = player getstance() == "prone";
        
        if ( var_7855fd9575dfd1bf )
        {
            var_e5242855a04339bf = &"JUP_OB_S3/UNLOCK_QUEST_RELIC_CRAYON_INVESTIGATE";
            return { #string:var_e5242855a04339bf, #type:"HINT_BUTTON" };
        }
    }
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

