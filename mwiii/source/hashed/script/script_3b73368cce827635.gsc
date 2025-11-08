#using script_3b73368cce827635;
#using script_4e6e58ab5d96c2b0;
#using scripts\asm\shared\mp\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;

#namespace namespace_f766c5cbe075ba8c;

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x56a
// Size: 0x73
function private resettimer( player )
{
    level endon( "glovesComplete" );
    var_6923400044bc563d = getdvarint( @"hash_75488d15e92d078f", 120 );
    timer = var_6923400044bc563d;
    
    while ( timer >= 0 )
    {
        timer -= 1;
        
        /#
            iprintlnbold( timer + "<dev string:x1c>" );
        #/
        
        wait 1;
    }
    
    namespace_ff283c2f8526a8f::function_6c9ea7e2f4dd2d52( level.var_66c37e5364591fe4 );
    player namespace_ff283c2f8526a8f::function_fda2598d8235bba9();
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 0
// Checksum 0x0, Offset: 0x5e5
// Size: 0x17
function function_804e8e5fc2260520()
{
    loadvfx();
    initteamdata();
    function_ac531909f44e822e();
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x604
// Size: 0x1c
function private loadvfx()
{
    level._effect[ "vfx_boxing_gloves" ] = loadfx( "vfx/jup/ob/gameplay/zm/vfx_aether_fists.vfx" );
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x628
// Size: 0x2e
function private initteamdata()
{
    callback::add( "player_item_pickup", &on_item_pickup );
    callback::add( "player_item_drop", &on_item_drop );
    level.var_a95add7f127007c1 = 0;
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x65e
// Size: 0x45, Type: bool
function private function_743ab81ab6621936()
{
    if ( istrue( level.var_19e7f3165682f28e ) )
    {
        return false;
    }
    
    var_afb7e0639adce453 = scripts\cp_mp\loot\common_inventory::function_4776284a348ebb6a( 50207 );
    var_51309cce530fd66a = var_afb7e0639adce453 >= 0;
    
    if ( var_51309cce530fd66a )
    {
        function_ca3bbb1070436540( var_afb7e0639adce453, 0, 0 );
        return true;
    }
    
    return false;
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 2
// Checksum 0x0, Offset: 0x6ac
// Size: 0x65
function function_ae56df9d51b68c4c( player, trigger )
{
    if ( isplayer( player ) )
    {
        var_afb7e0639adce453 = scripts\cp_mp\loot\common_inventory::function_4776284a348ebb6a( 50207 );
        var_51309cce530fd66a = var_afb7e0639adce453 >= 0;
        
        if ( var_51309cce530fd66a )
        {
            level.var_f2fb4ee1d1ce6d41 showtoplayer( player );
            return;
        }
        
        level.var_f2fb4ee1d1ce6d41 hidefromplayer( player );
    }
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 2
// Checksum 0x0, Offset: 0x719
// Size: 0x1d
function function_78fca00ea9feac52( player, trigger )
{
    if ( !isplayer( player ) )
    {
        return;
    }
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x73e
// Size: 0x158
function private function_ac531909f44e822e()
{
    level.var_5bd1e142a4e31fef = getstruct( "gloves_zombie_spawn", "targetname" );
    
    if ( isdefined( level.var_5bd1e142a4e31fef ) )
    {
        level.var_f2fb4ee1d1ce6d41 = scripts\cp_mp\interaction::register_interact( level.var_5bd1e142a4e31fef.origin + ( 100, 0, 100 ), 200, &function_2a5c422870861dd9 );
        level.var_f2fb4ee1d1ce6d41 scripts\cp_mp\interaction::function_e6c63f16f2258b80( &function_3710286101f0ad65 );
    }
    
    triggerorigin = level.var_5bd1e142a4e31fef.origin - ( 0, 0, 50 );
    
    if ( isdefined( level.var_f2fb4ee1d1ce6d41 ) )
    {
        level.var_f2fb4ee1d1ce6d41.var_26adba977a3c7fb1 = spawn( "trigger_radius", triggerorigin, 0, 100, 100 );
        
        if ( getdvarint( @"hash_978e1d4eb4c5748e", 0 ) )
        {
            /#
                thread scripts\cp_mp\utility\debug_utility::drawcylinder( triggerorigin, 150, 150, 999999, ( 1, 0, 0 ) );
            #/
        }
        
        if ( issharedfuncdefined( "game", "makeEnterExitTrigger" ) )
        {
            [[ getsharedfunc( "game", "makeEnterExitTrigger" ) ]]( level.var_f2fb4ee1d1ce6d41.var_26adba977a3c7fb1, &function_ae56df9d51b68c4c, &function_78fca00ea9feac52 );
        }
        
        level.var_f2fb4ee1d1ce6d41 hide();
    }
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 2
// Checksum 0x0, Offset: 0x89e
// Size: 0x5f
function function_3710286101f0ad65( interact, player )
{
    if ( istrue( level.var_19e7f3165682f28e ) )
    {
        return { #string:&"JUP_OB_S2/ATTUNEMENT_ACTIVE_GLOVES", #type:"HINT_BUTTON" };
    }
    
    return { #string:&"JUP_OB_S2/OFFER_UNATTUNED_RELIC", #type:"HINT_BUTTON" };
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 1
// Checksum 0x0, Offset: 0x905
// Size: 0x154
function function_2a5c422870861dd9( player )
{
    if ( istrue( level.var_19e7f3165682f28e ) )
    {
        return;
    }
    
    if ( player function_743ab81ab6621936() )
    {
        player function_e02246121fec4742();
        level.var_f2fb4ee1d1ce6d41 hidefromplayer( player );
        
        if ( level.var_66c37e5364591fe4 == undefined )
        {
            level.var_66c37e5364591fe4 = player;
        }
        
        squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers( undefined, 1 );
        var_a6aa6ac57e10810c = scripts\mp\utility\player::getplayersinradius( player.origin, 500 );
        
        foreach ( var_49be45f83be0135e in var_a6aa6ac57e10810c )
        {
            var_49be45f83be0135e earthquakeforplayer( 0.5, 1, player.origin, 500 );
        }
        
        foreach ( squadmember in squadmembers )
        {
            level.var_f2fb4ee1d1ce6d41 hidefromplayer( squadmember );
        }
        
        level.var_19e7f3165682f28e = 1;
        level thread resettimer( player );
    }
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xa61
// Size: 0x245
function private function_e02246121fec4742()
{
    if ( !isdefined( level.var_95459c1857553ef8 ) )
    {
        level.var_95459c1857553ef8 = [];
    }
    
    var_b8c072397b4dbad9 = getstruct( "punching_bag_handler_00", "targetname" );
    
    if ( isdefined( var_b8c072397b4dbad9 ) )
    {
        var_a6c992d4adbfc7c2 = var_b8c072397b4dbad9.origin;
        
        if ( isdefined( var_a6c992d4adbfc7c2 ) && !isdefined( level.var_95459c1857553ef8[ 0 ] ) )
        {
            level.var_95459c1857553ef8[ 0 ] = spawnscriptable( "jup_ob_punching_bag_handler", var_a6c992d4adbfc7c2, ( 0, 0, 0 ) );
            level.var_95459c1857553ef8[ 0 ].var_d96e5de6797733b8 = 0;
        }
    }
    
    var_1a212490b616c34b = getstruct( "punching_bag_handler_01", "targetname" );
    
    if ( isdefined( var_1a212490b616c34b ) )
    {
        var_dee013668520046c = var_1a212490b616c34b.origin;
        
        if ( isdefined( var_dee013668520046c ) && !isdefined( level.var_95459c1857553ef8[ 1 ] ) )
        {
            level.var_95459c1857553ef8[ 1 ] = spawnscriptable( "jup_ob_punching_bag_handler", var_dee013668520046c, ( 0, 0, 0 ) );
            level.var_95459c1857553ef8[ 1 ].var_d96e5de6797733b8 = 1;
        }
    }
    
    var_ecc8d5994078794d = getstruct( "punching_bag_handler_02", "targetname" );
    
    if ( isdefined( var_ecc8d5994078794d ) && !isdefined( level.var_95459c1857553ef8[ 2 ] ) )
    {
        var_36716e2b2a205d7e = var_ecc8d5994078794d.origin;
        
        if ( isdefined( var_36716e2b2a205d7e ) )
        {
            level.var_95459c1857553ef8[ 2 ] = spawnscriptable( "jup_ob_punching_bag_handler", var_36716e2b2a205d7e, ( 0, 0, 0 ) );
            level.var_95459c1857553ef8[ 2 ].var_d96e5de6797733b8 = 2;
        }
    }
    
    function_fda2598d8235bba9();
    scripts\engine\scriptable::scriptable_adddamagedcallback( &function_bce9936c9ca7e10b );
    var_3426ab2ac89dbb15 = getstruct( "gloves_zombie_spawn", "targetname" );
    
    if ( isdefined( var_3426ab2ac89dbb15 ) )
    {
        level.var_553ed442961a97b6 = var_3426ab2ac89dbb15.origin;
        
        if ( isdefined( level.var_553ed442961a97b6 ) )
        {
            level.var_e87943c3efff094a = spawnscriptable( "ob_jup_aethertear_s2_quest_gloves", level.var_553ed442961a97b6, ( 0, 0, 0 ) );
            level.var_e87943c3efff094a setscriptablepartstate( "body_aethertear", "unusable" );
        }
    }
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 11
// Checksum 0x0, Offset: 0xcae
// Size: 0x139
function function_bce9936c9ca7e10b( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname )
{
    if ( !is_equal( instance.type, "jup_ob_punching_bag_handler" ) || istrue( instance.destroyed ) )
    {
        return;
    }
    
    if ( isdefined( instance.var_d96e5de6797733b8 ) )
    {
        if ( smeansofdeath == "MOD_MELEE" && instance.var_d96e5de6797733b8 == 0 )
        {
            instance setscriptablepartstate( "vfx", "active" );
            eattacker function_202df4e6c45106e1();
        }
        
        if ( smeansofdeath == "MOD_MELEE" && instance.var_d96e5de6797733b8 == 1 )
        {
            instance setscriptablepartstate( "vfx", "active" );
            eattacker function_4cfe0f16977dc5af();
        }
        
        if ( smeansofdeath == "MOD_MELEE" && instance.var_d96e5de6797733b8 == 2 )
        {
            instance setscriptablepartstate( "vfx", "active" );
            eattacker function_fdcba52cb65c824e();
        }
    }
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xdef
// Size: 0xe1
function private function_fda2598d8235bba9()
{
    level.var_a95add7f127007c1 = 0;
    
    foreach ( var_6b6b5d8876e922ad in level.var_95459c1857553ef8 )
    {
        if ( isdefined( var_6b6b5d8876e922ad ) )
        {
            var_6b6b5d8876e922ad setscriptablepartstate( "base", "healthy" );
            var_6b6b5d8876e922ad setscriptablepartstate( "vfx", "off" );
            var_6b6b5d8876e922ad.health = 50;
        }
    }
    
    level notify( "stopGlovesDeathWatcher" );
    
    if ( isdefined( level.var_c4a253533d7776c8 ) && isalive( level.var_c4a253533d7776c8 ) )
    {
        level.var_c4a253533d7776c8 kill();
    }
    
    level.var_19e7f3165682f28e = 0;
    level.var_c4a253533d7776c8 = undefined;
    level.var_66c37e5364591fe4 = undefined;
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xed8
// Size: 0x94
function private function_3b920e2797fcfd61()
{
    level.var_a95add7f127007c1 = 0;
    
    foreach ( var_6b6b5d8876e922ad in level.var_95459c1857553ef8 )
    {
        var_6b6b5d8876e922ad setscriptablepartstate( "base", "healthy" );
        var_6b6b5d8876e922ad setscriptablepartstate( "vfx", "off" );
        
        if ( isent( var_6b6b5d8876e922ad ) )
        {
            var_6b6b5d8876e922ad delete();
            continue;
        }
        
        var_6b6b5d8876e922ad freescriptable();
    }
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xf74
// Size: 0x35
function private function_202df4e6c45106e1()
{
    if ( level.var_a95add7f127007c1 < 1 )
    {
        level.var_a95add7f127007c1 = 1;
        return;
    }
    
    if ( level.var_a95add7f127007c1 != 1 )
    {
        function_fda2598d8235bba9();
    }
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xfb1
// Size: 0x44
function private function_4cfe0f16977dc5af()
{
    if ( level.var_a95add7f127007c1 < 2 && level.var_a95add7f127007c1 > 0 )
    {
        level.var_a95add7f127007c1 = 2;
        return;
    }
    
    if ( level.var_a95add7f127007c1 != 2 )
    {
        function_fda2598d8235bba9();
    }
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xffd
// Size: 0x4f
function private function_fdcba52cb65c824e()
{
    if ( level.var_a95add7f127007c1 < 3 && level.var_a95add7f127007c1 > 1 )
    {
        level.var_a95add7f127007c1 = 3;
        level thread function_4aefb40f3b5c684c( self );
        return;
    }
    
    if ( level.var_a95add7f127007c1 != 3 )
    {
        function_fda2598d8235bba9();
    }
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 1
// Checksum 0x0, Offset: 0x1054
// Size: 0xd4
function function_901fea53b27b2bac( dmgstruct )
{
    var_3e1bc369aaabbc78 = distance2dsquared( level.var_c4a253533d7776c8.origin, level.var_553ed442961a97b6 ) < 22500;
    
    if ( dmgstruct.smeansofdeath != "MOD_MELEE" || self.var_3e1bc369aaabbc78 == 0 )
    {
        dmgstruct.idamage = 0;
    }
    
    if ( ent_flag( "energy_mine_kill" ) || ent_flag( "frost_blast_active" ) || ent_flag( "tesla_storm_stunned" ) )
    {
        dmgstruct.idamage = 0;
        ent_flag_clear( "energy_mine_kill" );
        ent_flag_clear( "frost_blast_active" );
        ent_flag_clear( "tesla_storm_stunned" );
    }
    
    return dmgstruct.idamage;
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1131
// Size: 0x130
function private function_7dd418fc8b41cdab()
{
    level endon( "stopGlovesDeathWatcher" );
    level endon( "disconnect" );
    
    while ( isdefined( level.var_c4a253533d7776c8 ) )
    {
        level.var_c4a253533d7776c8.var_3e1bc369aaabbc78 = distance2dsquared( level.var_c4a253533d7776c8.origin, level.var_553ed442961a97b6 ) < 22500;
        
        if ( level.var_c4a253533d7776c8.var_3e1bc369aaabbc78 && !istrue( level.var_c4a253533d7776c8.var_c7387f74f029624b ) && isalive( level.var_c4a253533d7776c8 ) )
        {
            level.var_c4a253533d7776c8 function_3ab9164ef76940fd( "obelisk_vfx", "gloves" );
            level.var_c4a253533d7776c8.var_c7387f74f029624b = 1;
        }
        else if ( !level.var_c4a253533d7776c8.var_3e1bc369aaabbc78 && istrue( level.var_c4a253533d7776c8.var_c7387f74f029624b ) )
        {
            level.var_c4a253533d7776c8 function_3ab9164ef76940fd( "obelisk_vfx", "off" );
            level.var_c4a253533d7776c8.var_c7387f74f029624b = 0;
        }
        
        wait 0.2;
    }
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1269
// Size: 0x30f
function private function_4aefb40f3b5c684c( player )
{
    level.var_e87943c3efff094a setscriptablepartstate( "entrance_vfx", "on" );
    squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
    level.var_c4a253533d7776c8 = scripts\mp\mp_agent::spawnnewagentaitype( "jup_spawner_zombie_base", level.var_553ed442961a97b6, ( 0, 0, 0 ), "team_two_hundred" );
    level.var_c4a253533d7776c8 thread function_6eca18484fcc4e39();
    level.var_c4a253533d7776c8 thread function_7dd418fc8b41cdab();
    level.var_c4a253533d7776c8.name = "ringZombie";
    level.var_c4a253533d7776c8.fullhealth = level.var_c4a253533d7776c8.health + 250 * squad.size;
    level.var_c4a253533d7776c8.maxhealth = level.var_c4a253533d7776c8.fullhealth;
    level.var_c4a253533d7776c8.ignore_nuke = 1;
    level.var_c4a253533d7776c8.var_970170ffd4b081ac = &function_901fea53b27b2bac;
    level.var_c4a253533d7776c8 callback::add( "on_zombie_ai_damaged", &function_901fea53b27b2bac );
    level.var_c4a253533d7776c8.var_7e3144ab69fefa03 = 0;
    level.var_c4a253533d7776c8.var_c3554a26521188a8 = &function_a8c9248308033e4e;
    level.var_c4a253533d7776c8.var_b5117f0fdd28774a = &function_245283ba6b8fc;
    level.var_c4a253533d7776c8.var_69fad82b1297b14 = &function_c2cec6c21b6ed690;
    level.var_c4a253533d7776c8.var_8a5ad30eca36b2f9 = &function_2a7521c0cd2cc849;
    level.var_c4a253533d7776c8.var_1b74dbfbf5e984dc = &function_55dafced1c7f2392;
    level.var_c4a253533d7776c8.var_51618a5cd18d54b = &function_57128172ecf78387;
    level.var_c4a253533d7776c8.health = level.var_c4a253533d7776c8.fullhealth;
    waitframe();
    level.var_c4a253533d7776c8 scripts\asm\shared\mp\utility::animscriptedagent( "spawn_hop", "spawn_end", level.var_c4a253533d7776c8.origin, level.var_c4a253533d7776c8.angles );
    waitframe();
    level.var_e87943c3efff094a setscriptablepartstate( "entrance_vfx", "closing" );
    wait 0.25;
    level.var_e87943c3efff094a setscriptablepartstate( "entrance_vfx", "off" );
    waitframe();
    playfxontag( utility::getfx( "vfx_boxing_gloves" ), level.var_c4a253533d7776c8, "j_wrist_ri" );
    playfxontag( utility::getfx( "vfx_boxing_gloves" ), level.var_c4a253533d7776c8, "j_wrist_le" );
    var_11425e3325774718 = scripts\mp\utility\player::getplayersinradius( level.var_c4a253533d7776c8.origin, 500 );
    level.var_c4a253533d7776c8 thread namespace_ff283c2f8526a8f::function_35e8a48dc2442eb2( var_11425e3325774718 );
    thread scripts\cp_mp\overlord::playevent( "s2_rq_gloves_zombie_spawn", var_11425e3325774718 );
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 1
// Checksum 0x0, Offset: 0x1580
// Size: 0x8f
function function_35e8a48dc2442eb2( a_players )
{
    self endon( "death" );
    level endon( "game_ended" );
    
    while ( a_players.size )
    {
        if ( isdefined( self.target ) )
        {
            self function_9322f3cb1cd4111a();
        }
        else
        {
            a_players = array_removedead( a_players );
            a_players = array_removeundefined( a_players );
            e_target = utility::getclosest( self.origin, a_players, 5000 );
        }
        
        if ( isdefined( e_target ) )
        {
            self function_65cdab0fc78aba8f( e_target.origin, 512 );
            wait 10;
            e_target = undefined;
            continue;
        }
        
        wait 1;
    }
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1617
// Size: 0x12e
function private function_6eca18484fcc4e39()
{
    level endon( "game_ended" );
    level endon( "stopGlovesDeathWatcher" );
    self waittill( "death", killer );
    a_squad = killer scripts\cp_mp\utility\squad_utility::getsquadmembers();
    
    foreach ( squadmember in a_squad )
    {
        squadmember.var_63948f173832a6ee = 1;
    }
    
    thread scripts\cp_mp\overlord::playevent( "s2_rq_gloves_zombie_death", a_squad );
    level.var_e87943c3efff094a setscriptablepartstate( "entrance_vfx", "on" );
    wait 1;
    
    if ( isdefined( level.var_66c37e5364591fe4 ) )
    {
        function_8375ccd1b5310841( level.var_66c37e5364591fe4 );
    }
    else
    {
        function_8375ccd1b5310841( killer );
    }
    
    level.var_e87943c3efff094a setscriptablepartstate( "entrance_vfx", "closing" );
    wait 0.25;
    level.var_e87943c3efff094a setscriptablepartstate( "entrance_vfx", "off" );
    level.var_19e7f3165682f28e = 0;
    level.var_6e0ff213c6237a49 = undefined;
    level notify( "glovesComplete" );
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x174d
// Size: 0x1b4
function private function_6c9ea7e2f4dd2d52( player )
{
    if ( !isdefined( level.var_66c37e5364591fe4 ) )
    {
        return;
    }
    
    level.var_518e9a601e7c7ccf = spawnscriptable( "ob_jup_aethertear_s2_quest_gloves", level.var_66c37e5364591fe4.origin, ( 0, 0, 0 ) );
    level.var_518e9a601e7c7ccf setscriptablepartstate( "entrance_vfx", "on" );
    itembundlename = "ob_jup_item_key_rift_gate_season2_gloves";
    itembundle = getscriptbundle( "itemspawnentry:" + itembundlename );
    payload = [ #"teamselect", level.var_66c37e5364591fe4 getentitynumber() ];
    a_squad = level.var_66c37e5364591fe4 scripts\cp_mp\utility\squad_utility::getsquadmembers();
    level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d( a_squad, "ob_contract_lose" );
    item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4( itembundle, level.var_66c37e5364591fe4.origin, undefined, 0, 1, payload );
    item.player = level.var_66c37e5364591fe4;
    level.var_518e9a601e7c7ccf setscriptablepartstate( "entrance_vfx", "closing" );
    
    if ( isdefined( item ) )
    {
        params = spawnstruct();
        params.item = item;
        params.itembundlename = itembundlename;
        params.payload = payload;
        params.player = player;
        
        if ( isdefined( level.var_8b939fbe0ef2d56b ) )
        {
            player [[ level.var_8b939fbe0ef2d56b ]]( params );
        }
        
        level.var_66c37e5364591fe4 function_3b920e2797fcfd61();
        level.var_66c37e5364591fe4 = undefined;
    }
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1909
// Size: 0x18c
function private function_8375ccd1b5310841( player )
{
    level.var_518e9a601e7c7ccf = spawnscriptable( "ob_jup_aethertear_s2_quest_gloves", player.origin, ( 0, 0, 0 ) );
    level.var_518e9a601e7c7ccf setscriptablepartstate( "entrance_vfx", "on" );
    itembundlename = "ob_jup_item_key_rift_gate_season2_gloves_attuned";
    itembundle = getscriptbundle( "itemspawnentry:" + itembundlename );
    payload = [ #"teamselect", player getentitynumber() ];
    a_squad = level.var_66c37e5364591fe4 scripts\cp_mp\utility\squad_utility::getsquadmembers();
    item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4( itembundle, level.var_553ed442961a97b6, undefined, 0, 1, payload );
    item.player = level.var_66c37e5364591fe4;
    level.var_518e9a601e7c7ccf setscriptablepartstate( "entrance_vfx", "closing" );
    
    if ( isdefined( item ) )
    {
        params = spawnstruct();
        params.item = item;
        params.itembundlename = itembundlename;
        params.payload = payload;
        params.player = player;
        
        if ( isdefined( level.var_8b939fbe0ef2d56b ) )
        {
            player [[ level.var_8b939fbe0ef2d56b ]]( params );
        }
        
        thread scripts\cp_mp\overlord::playevent( "s2_rq_get_attuned_gloves_rvnv", a_squad );
        level.var_66c37e5364591fe4 function_3b920e2797fcfd61();
        level.var_66c37e5364591fe4 = undefined;
    }
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1a9d
// Size: 0x94
function private on_item_pickup( params )
{
    if ( isdefined( params.itembundlename ) && params.itembundlename == "ob_jup_item_key_rift_gate_season2_gloves_attuned" )
    {
        if ( !istrue( self.var_7f044f32e5eb64e ) )
        {
            wait 0.5;
            thread scripts\cp_mp\overlord::playevent( "s2_rq_get_attuned_gloves_ent", [ self ] );
            self.var_7f044f32e5eb64e = 1;
        }
    }
    
    if ( isdefined( params.itembundlename ) && params.itembundlename == "ob_jup_item_key_rift_gate_season2_gloves" )
    {
        level.var_f2fb4ee1d1ce6d41 showtoplayer( self );
    }
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1b39
// Size: 0x65
function private on_item_drop( params )
{
    if ( isdefined( params.itembundlename ) && params.itembundlename == "ob_jup_item_key_rift_gate_season2_gloves" )
    {
        var_afb7e0639adce453 = scripts\cp_mp\loot\common_inventory::function_4776284a348ebb6a( 50207 );
        var_51309cce530fd66a = var_afb7e0639adce453 >= 0;
        
        if ( !var_51309cce530fd66a )
        {
            level.var_f2fb4ee1d1ce6d41 hidefromplayer( self );
        }
    }
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 0
// Checksum 0x0, Offset: 0x1ba6
// Size: 0x3, Type: bool
function function_a8c9248308033e4e()
{
    return false;
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 0
// Checksum 0x0, Offset: 0x1bb2
// Size: 0x3, Type: bool
function function_57128172ecf78387()
{
    return false;
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 0
// Checksum 0x0, Offset: 0x1bbe
// Size: 0x3, Type: bool
function function_c2cec6c21b6ed690()
{
    return false;
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 0
// Checksum 0x0, Offset: 0x1bca
// Size: 0x3, Type: bool
function function_245283ba6b8fc()
{
    return false;
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 0
// Checksum 0x0, Offset: 0x1bd6
// Size: 0x3, Type: bool
function function_55dafced1c7f2392()
{
    return false;
}

// Namespace namespace_f766c5cbe075ba8c / namespace_ff283c2f8526a8f
// Params 0
// Checksum 0x0, Offset: 0x1be2
// Size: 0x3, Type: bool
function function_2a7521c0cd2cc849()
{
    return false;
}

