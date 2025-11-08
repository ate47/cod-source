#using script_2047cdbf5176ba0;
#using script_208955cb4d2c8fb3;
#using script_2304453c69e996e2;
#using script_24fbedba9a7a1ef4;
#using script_42adcce5878f583;
#using script_6df6604a74a7a9c7;
#using script_7005217d66fc0ff2;
#using script_7e41e37180e554f;
#using script_edb8e725d068ac9;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\player;

#namespace ob_warlord_behaviors_all_for_one;

// Namespace ob_warlord_behaviors_all_for_one / scripts\ob\warlords\ob_warlord_behaviors_all_for_one
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x31d
// Size: 0x4b
function autoexec main()
{
    namespace_87d75ea764a6d2fd::setup_data( "AllForOne", "WARLORD_ALLFORONE" );
    namespace_87d75ea764a6d2fd::function_56e8f78ce1511d35( "AllForOne", &oninitialization );
    namespace_87d75ea764a6d2fd::function_dbfada6bda9049b3( "AllForOne", &function_325892ecd89575e1 );
    scripts\engine\utility::registersharedfunc( "warlords", "tile_a_warlord_registration", &function_a2a8b2608a9edf57 );
}

// Namespace ob_warlord_behaviors_all_for_one / scripts\ob\warlords\ob_warlord_behaviors_all_for_one
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x370
// Size: 0x36
function private function_a2a8b2608a9edf57()
{
    if ( !istrue( scripts\engine\utility::callsharedfunc( "warlords", "warlordIsDisabled", "WARLORD_ALLFORONE" ) ) )
    {
        namespace_609d2ee77dae3d8c::function_447c6ab4bea16b52( "objective", "REV_OB_WARLORD", &namespace_75b9b66caa533c31::function_8abadf3d8f19384a, &namespace_21bf7da565c2f6ec::function_fd69cf02ba4d90a2 );
    }
}

// Namespace ob_warlord_behaviors_all_for_one / scripts\ob\warlords\ob_warlord_behaviors_all_for_one
// Params 2
// Checksum 0x0, Offset: 0x3ae
// Size: 0x347
function oninitialization( agent, userdata )
{
    var_3ecf047d758de560 = namespace_87d75ea764a6d2fd::function_ce3f50617905370d( agent );
    var_3ecf047d758de560.var_f64d092b9829f981 = [];
    var_3ecf047d758de560.var_f16e24e60b9de7d5 = [];
    var_3ecf047d758de560.var_646f92cd1f221082 = [];
    warlorddata = namespace_87d75ea764a6d2fd::function_b14ea143c425c696( agent );
    warlorddata.var_29e8dc80c773ec6a = 0;
    warlorddata.var_640e7d92eea3d37 = 0;
    warlorddata.var_b5739f387f466219 = 0;
    warlorddata.grenade_spots = [];
    warlorddata.grenade_spawns = [];
    
    /#
        setdvarifuninitialized( @"hash_1423e3b1f1835994", 350 );
        setdvarifuninitialized( @"hash_1e6e7fa974d6933a", 750 );
        setdvarifuninitialized( @"hash_69ea888aa7700368", 1500 );
        setdvarifuninitialized( @"hash_c62ee53c1f036633", 0 );
    #/
    
    function_22bbd2d65e43a26b( agent );
    function_77d09d16e6dea696( agent );
    warlorddata.grenade_spots = var_3ecf047d758de560.activityinstance.centerstruct namespace_6c6964e55ab1bec8::function_954eb52ab4cdeb46( "grenade_spot", "targetname" );
    warlorddata.grenade_spawns = var_3ecf047d758de560.activityinstance.centerstruct namespace_6c6964e55ab1bec8::function_954eb52ab4cdeb46( "grenade_spawn", "targetname" );
    
    if ( getdvarfloat( @"hash_6494d9d3c82ad345", 1 ) )
    {
        agent thread grenadewatcher();
    }
    
    if ( agent.armorhealth > 0 )
    {
        agent.callbackdamaged = &warlord_damaged;
    }
    
    traptriggers = getnoentvolumearray( "auto_afo_closet", "targetname" );
    
    if ( isdefined( traptriggers ) )
    {
        foreach ( traptrigger in traptriggers )
        {
            agent thread function_f6b236a9e4b842ea( traptrigger );
        }
    }
    
    traptriggers = getnoentvolumearray( "warlord_allforone_encounter", "targetname" );
    
    if ( isarray( traptriggers ) && traptriggers.size > 0 )
    {
        foreach ( trapvolume in traptriggers )
        {
            if ( trapvolume.script_noteworthy == "auto_afo_closet_entrance" )
            {
                agent thread function_f6b236a9e4b842ea( trapvolume );
            }
        }
    }
    
    agent.dontmelee = 1;
    agent.armorplate_count = 0;
    agent.var_c6ec05f768303aaf = 0;
    agent.var_56556ae2f14239f6 = 0;
    agent.var_942e0b541df033d5 = 0;
    agent.var_3e90c8305bbecde3 = 1;
    agent.badplaceawareness = 0;
    agent.guid = agent getuniqueid();
    specialweapon = scripts\cp_mp\weapon::buildweapon_blueprint( "jup_jp09_sh_oromeo12", undefined, undefined, 7, undefined, undefined );
    weapon = specialweapon;
    agent scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff( undefined, undefined, weapon, undefined, undefined, undefined, undefined, 1 );
    agent.alreadydroppedweapon = 1;
}

// Namespace ob_warlord_behaviors_all_for_one / scripts\ob\warlords\ob_warlord_behaviors_all_for_one
// Params 0
// Checksum 0x0, Offset: 0x6fd
// Size: 0x184
function grenadewatcher()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    while ( true )
    {
        if ( isdefined( self.enemy ) )
        {
            if ( self.grenadeammo == 0 )
            {
                self.grenadeammo++;
            }
            
            grenadecooldown = getdvarint( @"hash_3517ae04300073fe", 10 );
            wait grenadecooldown;
            players = function_2b2c04ddfc825d3( self.ob.warlorddata.grenade_spots );
            players = array_randomize( players );
            
            for ( i = 0; i < players.size ; i++ )
            {
                var_106a5458182a46f7 = function_4d046f33253e46e0( players[ i ].origin, self.ob.warlorddata.grenade_spots, 262144 );
                var_2936aa44ec8bed9 = function_4d046f33253e46e0( var_106a5458182a46f7.origin, self.ob.warlorddata.grenade_spawns, 262144 );
                self.var_43ae9f4734246fb0 = 1;
                wait 3.5;
                grenade = self magicgrenade( var_2936aa44ec8bed9.origin, var_106a5458182a46f7.origin, 2.4, 1 );
                
                if ( !isdefined( grenade ) )
                {
                    continue;
                }
                
                wait 0.5;
                self.var_43ae9f4734246fb0 = 0;
                break;
            }
        }
        
        wait 0.1;
    }
}

// Namespace ob_warlord_behaviors_all_for_one / scripts\ob\warlords\ob_warlord_behaviors_all_for_one
// Params 1
// Checksum 0x0, Offset: 0x889
// Size: 0xb9
function function_2b2c04ddfc825d3( points )
{
    assert( isdefined( points ) && isarray( points ) );
    ztolerance = 240;
    totaltargets = [];
    
    foreach ( point in points )
    {
        players = getplayersinradius( point.origin, point.radius, ztolerance, 1 );
        
        if ( !isdefined( players ) )
        {
            continue;
        }
        
        totaltargets = array_combine_unique( totaltargets, players );
    }
    
    return totaltargets;
}

// Namespace ob_warlord_behaviors_all_for_one / scripts\ob\warlords\ob_warlord_behaviors_all_for_one
// Params 2
// Checksum 0x0, Offset: 0x94b
// Size: 0xc4
function function_325892ecd89575e1( agent, userdata )
{
    agent.ob.warlorddata = spawnstruct();
    agent.ob.warlordtype = "AllForOne";
    function_22bbd2d65e43a26b( agent );
    warlord = namespace_87d75ea764a6d2fd::get_warlord( agent );
    
    if ( isdefined( warlord ) && isdefined( agent.stealth_groupname ) )
    {
        if ( issubstr( agent.stealth_groupname, "2f_dormitory" ) )
        {
            warlord.var_56556ae2f14239f6++;
            warlord.var_942e0b541df033d5++;
            agent thread function_fb8ebd4c04df224e( warlord );
        }
        
        agent function_85e7c2baf116abf8( warlord );
        agent function_741a41cd8e7cacd0( 200 );
    }
}

// Namespace ob_warlord_behaviors_all_for_one / scripts\ob\warlords\ob_warlord_behaviors_all_for_one
// Params 1
// Checksum 0x0, Offset: 0xa17
// Size: 0x18
function function_22bbd2d65e43a26b( agent )
{
    agent.var_685390c6753c2cc7 = 0;
}

// Namespace ob_warlord_behaviors_all_for_one / scripts\ob\warlords\ob_warlord_behaviors_all_for_one
// Params 1
// Checksum 0x0, Offset: 0xa37
// Size: 0xad
function function_77d09d16e6dea696( warlord )
{
    triggervolumes = getnoentvolumearray( "warlord_allforone_encounter", "targetname" );
    
    if ( isarray( triggervolumes ) && triggervolumes.size > 0 )
    {
        foreach ( triggervolume in triggervolumes )
        {
            if ( triggervolume.script_noteworthy == "auto_afo_barkVO_balcony" )
            {
                warlord thread function_e7f383d618470607( triggervolumes[ 0 ] );
                break;
            }
        }
        
        return;
    }
    
    assertmsg( "<dev string:x1c>" );
}

// Namespace ob_warlord_behaviors_all_for_one / scripts\ob\warlords\ob_warlord_behaviors_all_for_one
// Params 1
// Checksum 0x0, Offset: 0xaec
// Size: 0x6e
function function_e7f383d618470607( triggervolume )
{
    level endon( "game_ended" );
    self endon( "death" );
    
    while ( true )
    {
        triggervolume waittill( "trigger", ent );
        
        if ( isplayer( ent ) )
        {
            if ( !istrue( self.roombreached ) )
            {
                self.roombreached = 1;
                namespace_dc53a27a8db8e6bf::function_42f4a9aee5b6c6d3();
                thread function_c06825d6f9a3aac7();
                break;
            }
        }
        
        wait 0.1;
    }
}

// Namespace ob_warlord_behaviors_all_for_one / scripts\ob\warlords\ob_warlord_behaviors_all_for_one
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xb62
// Size: 0x4e
function private function_f6b236a9e4b842ea( traptrigger )
{
    level endon( "game_ended" );
    self endon( "death" );
    
    while ( true )
    {
        traptrigger waittill( "trigger", ent );
        
        if ( isplayer( ent ) )
        {
            function_19be9e67c6b8fcaf();
            break;
        }
        
        wait 0.1;
    }
}

// Namespace ob_warlord_behaviors_all_for_one / scripts\ob\warlords\ob_warlord_behaviors_all_for_one
// Params 14
// Checksum 0x0, Offset: 0xbb8
// Size: 0xf2
function warlord_damaged( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid )
{
    damage = namespace_ad1f398af6f48cb1::function_395c3a00db83ba6( damage, meansofdeath, objweapon );
    namespace_daa149ca485fd50a::function_dffac413ed66bcd0( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname );
    
    if ( self.armorhealth <= 600 && isdefined( self.ob ) && !istrue( self.ob.spawnedagents ) )
    {
        function_19be9e67c6b8fcaf( 1 );
        self.ob.spawnedagents = 1;
    }
}

// Namespace ob_warlord_behaviors_all_for_one / scripts\ob\warlords\ob_warlord_behaviors_all_for_one
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xcb2
// Size: 0x78
function private function_c06825d6f9a3aac7()
{
    self endon( "death" );
    level endon( "game_ended" );
    warlord = namespace_87d75ea764a6d2fd::get_warlord( self );
    
    while ( isdefined( warlord ) )
    {
        if ( istrue( warlord.var_56556ae2f14239f6 ) && warlord.var_56556ae2f14239f6 > 0 && istrue( warlord.var_942e0b541df033d5 ) && warlord.var_942e0b541df033d5 <= 1 )
        {
            function_19be9e67c6b8fcaf();
            break;
        }
        
        waitframe();
    }
}

// Namespace ob_warlord_behaviors_all_for_one / scripts\ob\warlords\ob_warlord_behaviors_all_for_one
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xd32
// Size: 0x41
function private function_fb8ebd4c04df224e( warlord )
{
    level endon( "game_ended" );
    
    if ( !isdefined( warlord ) )
    {
        return;
    }
    
    self waittill( "death" );
    
    if ( isdefined( warlord ) && isdefined( warlord.var_942e0b541df033d5 ) )
    {
        warlord.var_942e0b541df033d5--;
    }
}

// Namespace ob_warlord_behaviors_all_for_one / scripts\ob\warlords\ob_warlord_behaviors_all_for_one
// Params 1
// Checksum 0x0, Offset: 0xd7b
// Size: 0x7d
function function_19be9e67c6b8fcaf( var_1f55566be45b01f4 )
{
    warlord = namespace_87d75ea764a6d2fd::get_warlord( self );
    
    if ( !isdefined( warlord ) || warlord.var_c6ec05f768303aaf )
    {
        return;
    }
    
    encounterid = scripts\cp_mp\agents\ai_spawn_director::spawn_request( "ai_encounter:enc_ob_activity_warlord_allforone_closet", warlord.origin, 1024, 1, 1, 0 );
    
    if ( isdefined( encounterid ) )
    {
        warlord.var_c6ec05f768303aaf = 1;
        
        if ( istrue( var_1f55566be45b01f4 ) )
        {
            warlord thread function_ae665ae169e5a53a();
        }
    }
}

// Namespace ob_warlord_behaviors_all_for_one / scripts\ob\warlords\ob_warlord_behaviors_all_for_one
// Params 0
// Checksum 0x0, Offset: 0xe00
// Size: 0x43
function function_ae665ae169e5a53a()
{
    level endon( "game_ended" );
    self endon( "death" );
    self.var_43ae9f4734246fb0 = 1;
    var_c25ffec52f8668aa = getdvarint( @"hash_e3fb3f771a0cb64", 7 );
    wait var_c25ffec52f8668aa;
    self.var_43ae9f4734246fb0 = 0;
}

// Namespace ob_warlord_behaviors_all_for_one / scripts\ob\warlords\ob_warlord_behaviors_all_for_one
// Params 0
// Checksum 0x0, Offset: 0xe4b
// Size: 0x32
function function_1f13aaf6c3fa00e3()
{
    level endon( "game_ended" );
    self endon( "death" );
    utility::waittill_any_4( "stealth_investigate", "stealth_hunt", "stealth_combat", "startCombatRush" );
    function_a9f5229ecf5cca14();
}

// Namespace ob_warlord_behaviors_all_for_one / scripts\ob\warlords\ob_warlord_behaviors_all_for_one
// Params 0
// Checksum 0x0, Offset: 0xe85
// Size: 0xb8
function function_a9f5229ecf5cca14()
{
    foundgoalvolume = 0;
    
    foreach ( activityinstance in level.ob.var_7dd4780d4e4bff4d )
    {
        if ( activityinstance.goal_volumes.size > 0 && issubstr( activityinstance.varianttag, "ALLFORONE" ) )
        {
            self setgoalvolumeauto( activityinstance.goal_volumes[ 0 ] );
            foundgoalvolume = 1;
            break;
        }
    }
    
    assertex( istrue( foundgoalvolume ), "<dev string:x50>" );
}

