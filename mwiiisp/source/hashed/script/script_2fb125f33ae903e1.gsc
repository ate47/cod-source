#using scripts\anim\dialogue;
#using scripts\engine\utility;

#namespace namespace_e494424f3a96e848;

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x442c
// Size: 0x45
function vo_init()
{
    if ( isdefined( level.vo ) == 0 )
    {
        level.vo = spawnstruct();
        function_4edf904ca43031e();
        function_84904b9ff7b853();
        thread function_b793a5f9451957d5();
        thread vo_combat();
        thread function_b847acce90b82260();
    }
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x4479
// Size: 0x3c
function private function_4edf904ca43031e()
{
    if ( isdefined( level.laswell ) == 0 )
    {
        level.laswell = level.player;
    }
    
    if ( isdefined( level.nik ) == 0 )
    {
        level.nik = level;
    }
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x44bd
// Size: 0x549
function private function_84904b9ff7b853()
{
    if ( isdefined( level.vo.var_62aef2420d04a ) == 0 )
    {
        level.vo.var_62aef2420d04a = [];
        level.vo.var_629ef2420ce17 = [];
        level.vo.var_dab0d30275ebc78d = [];
        level.vo.var_dab0d00275ebc0f4 = [];
        level.vo.var_62aef2420d04a[ level.vo.var_62aef2420d04a.size ] = "ai_grp1_1";
        level.vo.var_629ef2420ce17[ level.vo.var_629ef2420ce17.size ] = "ai_grp1_2";
        level.vo.var_dab0d30275ebc78d[ level.vo.var_dab0d30275ebc78d.size ] = "ai_grp2_1";
        level.vo.var_dab0d00275ebc0f4[ level.vo.var_dab0d00275ebc0f4.size ] = "ai_grp2_2";
        level.vo.var_dab0d30275ebc78d[ level.vo.var_dab0d30275ebc78d.size ] = "ai_grp3_1";
        level.vo.var_dab0d00275ebc0f4[ level.vo.var_dab0d00275ebc0f4.size ] = "ai_grp3_2";
        level.vo.var_dab0d30275ebc78d[ level.vo.var_dab0d30275ebc78d.size ] = "ai_grp4_1";
        level.vo.var_dab0d00275ebc0f4[ level.vo.var_dab0d00275ebc0f4.size ] = "ai_grp4_2";
        level.vo.var_dab0d30275ebc78d[ level.vo.var_dab0d30275ebc78d.size ] = "ai_grp5_1";
        level.vo.var_dab0d00275ebc0f4[ level.vo.var_dab0d00275ebc0f4.size ] = "ai_grp5_1";
        level.vo.var_62aef2420d04a[ level.vo.var_62aef2420d04a.size ] = "ai_grp6_1";
        level.vo.var_dab0d30275ebc78d[ level.vo.var_dab0d30275ebc78d.size ] = "ai_grp6_1";
        level.vo.var_dab0d30275ebc78d[ level.vo.var_dab0d30275ebc78d.size ] = "ai_grp7_1";
        level.vo.var_dab0d00275ebc0f4[ level.vo.var_dab0d00275ebc0f4.size ] = "ai_grp7_2";
        level.vo.var_dab0d30275ebc78d[ level.vo.var_dab0d30275ebc78d.size ] = "ai_grp7_3";
        level.vo.var_dab0d00275ebc0f4[ level.vo.var_dab0d00275ebc0f4.size ] = "ai_grp7_4";
        level.vo.var_dab0d30275ebc78d[ level.vo.var_dab0d30275ebc78d.size ] = "ai_grp8_1";
        level.vo.var_dab0d00275ebc0f4[ level.vo.var_dab0d00275ebc0f4.size ] = "ai_grp8_2";
        level.vo.var_629ef2420ce17[ level.vo.var_629ef2420ce17.size ] = "ai_grp9_1";
        level.vo.var_dab0d00275ebc0f4[ level.vo.var_dab0d00275ebc0f4.size ] = "ai_grp9_2";
        level.vo.var_629ef2420ce17[ level.vo.var_629ef2420ce17.size ] = "ai_grp10_1";
        level.vo.var_dab0d00275ebc0f4[ level.vo.var_dab0d00275ebc0f4.size ] = "ai_grp10_1";
        level.vo.var_62aef2420d04a[ level.vo.var_62aef2420d04a.size ] = "ai_grp11_1";
        level.vo.var_dab0d30275ebc78d[ level.vo.var_dab0d30275ebc78d.size ] = "ai_grp11_1";
        level.vo.var_dab0d30275ebc78d[ level.vo.var_dab0d30275ebc78d.size ] = "ai_grp12_1";
        level.vo.var_dab0d00275ebc0f4[ level.vo.var_dab0d00275ebc0f4.size ] = "ai_grp12_1";
        level.vo.var_dab0d00275ebc0f4[ level.vo.var_dab0d00275ebc0f4.size ] = "ar_t1_rus_kas";
    }
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4a0e
// Size: 0x108
function private function_42a9e539b0cbbee0( ent )
{
    if ( isdefined( level.vo ) && isdefined( level.vo.var_62aef2420d04a ) && isdefined( ent ) && isdefined( ent.script_noteworthy ) )
    {
        if ( array_contains( level.vo.var_62aef2420d04a, ent.script_noteworthy ) )
        {
            return "female_1";
        }
        else if ( array_contains( level.vo.var_629ef2420ce17, ent.script_noteworthy ) )
        {
            return "female_2";
        }
        else if ( array_contains( level.vo.var_dab0d30275ebc78d, ent.script_noteworthy ) )
        {
            return "male_1";
        }
        else if ( array_contains( level.vo.var_dab0d00275ebc0f4, ent.script_noteworthy ) )
        {
            return "male_2";
        }
    }
    
    return "gender, what a concept!";
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x4b1f
// Size: 0x199, Type: bool
function private function_bdd7b496380aa8e3( ent, checkplayer, var_3eac767594ec9570 )
{
    checkplayer = default_to( checkplayer, 0 );
    var_3eac767594ec9570 = default_to( var_3eac767594ec9570, 0 );
    var_3ca809a7bdc95834 = getentarray( "kill_room", "targetname" );
    
    if ( isdefined( var_3ca809a7bdc95834 ) )
    {
        if ( var_3eac767594ec9570 == 1 )
        {
            if ( isdefined( ent ) == 1 )
            {
                foreach ( element in var_3ca809a7bdc95834 )
                {
                    if ( ispointinvolume( ent.origin, element ) && ispointinvolume( level.player.origin, element ) )
                    {
                        return true;
                    }
                }
            }
        }
        else
        {
            if ( isdefined( ent ) == 1 )
            {
                foreach ( element in var_3ca809a7bdc95834 )
                {
                    if ( ispointinvolume( ent.origin, element ) )
                    {
                        return true;
                    }
                }
            }
            
            if ( checkplayer == 1 )
            {
                foreach ( element in var_3ca809a7bdc95834 )
                {
                    if ( ispointinvolume( level.player.origin, element ) )
                    {
                        return true;
                    }
                }
            }
        }
    }
    
    return false;
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x4cc1
// Size: 0xac, Type: bool
function private function_688d32a48b7b029b()
{
    if ( flag( "flag_alarm" ) || time_has_passed( default_to( level.vo.var_26da7b43424980b5, 0 ), 3 ) == 0 || flag( "vo_coughing" ) || isdefined( level.vo.var_86838cbbb9e37b5c ) && time_has_passed( level.vo.var_86838cbbb9e37b5c, 4 ) == 0 || time_has_passed( default_to( level.player.last_weapon_fire_time, 0 ), 2 ) == 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x4d76
// Size: 0x84
function private function_1c11a2950dae76a7( duration, interval, var_ed86f55e48dbb8c4 )
{
    level endon( "game_ended" );
    duration = default_to( duration, 1 );
    interval = default_to( interval, 0.25 );
    var_ed86f55e48dbb8c4 = default_to( var_ed86f55e48dbb8c4, "vo_blocking_clear" );
    flag_set( "vo_blocking" );
    flag_clear( var_ed86f55e48dbb8c4 );
    wait duration;
    
    while ( function_688d32a48b7b029b() == 1 )
    {
        wait interval;
    }
    
    flag_set( var_ed86f55e48dbb8c4 );
    flag_clear( "vo_blocking" );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x4e02
// Size: 0x73
function function_155fe87f0d1ac7b()
{
    level.laswell say_team( "dx_sp_jmlb_intr_lasw_watchertoyankeeeyeso", 1 );
    wait 0.7;
    level.nik say_team( "dx_sp_jmlb_intr_niko_copywatchershitsabou", 1 );
    thread function_1c11a2950dae76a7( 0.5, 0.1 );
    flag_wait( "vo_blocking_clear" );
    
    if ( flag( "player_has_holstered" ) == 0 )
    {
        return;
    }
    
    flag_set( "vo_intro_complete" );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x4e7d
// Size: 0x1dc
function function_55f59c2fe542a1de()
{
    if ( isdefined( level.vo.var_f4dfefaed8808b90 ) == 0 )
    {
        level.vo.var_f4dfefaed8808b90 = create_deck( [ "dx_sp_jmlb_intr_lasw_securingmyweapon", "dx_sp_jmlb_intr_lasw_concealingmysidearm", "dx_sp_jmlb_intr_lasw_puttingitaway" ], 1, 1 );
    }
    
    if ( isdefined( level.vo.var_f4dff2aed8809229 ) == 0 )
    {
        level.vo.var_f4dff2aed8809229 = create_deck( [ "dx_sp_jmlb_intr_niko_smartsuppressorsaref", "dx_sp_jmlb_intr_niko_idoubtx12sarestandar", "dx_sp_jmlb_intr_niko_yourx12woulddrawthew", "dx_sp_jmlb_intr_niko_idoubtsuppressorsare", "dx_sp_jmlb_intr_niko_asuppressedweaponwou" ], 1, 1 );
    }
    
    var_38fad3e748e5df90 = level.laswell function_bce20c074033e937();
    
    if ( isdefined( var_38fad3e748e5df90 ) && var_38fad3e748e5df90 < 0.5 )
    {
        wait 0.5 - var_38fad3e748e5df90;
    }
    
    thread function_1c11a2950dae76a7( 0, 0.25 );
    flag_wait( "vo_blocking_clear" );
    level.laswell say_team( level.vo.var_f4dfefaed8808b90 deck_draw(), 1 );
    timestamp = gettime();
    thread function_1c11a2950dae76a7( 0.7, 0.25 );
    flag_wait( "vo_blocking_clear" );
    
    if ( time_has_passed( timestamp, 1.5 ) == 0 )
    {
        level.nik say_team( level.vo.var_f4dff2aed8809229 deck_draw(), 1 );
        thread function_1c11a2950dae76a7( 0.7, 0.25 );
        flag_wait( "vo_blocking_clear" );
        level.laswell say_team( "dx_sp_jmlb_intr_lasw_roghardtowalkontoane", 1 );
    }
    
    flag_set( "vo_intro_complete" );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x5061
// Size: 0x256
function function_cd1c141856757c32()
{
    if ( isdefined( level.vo.var_fa324e47a4f28751 ) == 0 )
    {
        level.vo.var_fa324e47a4f28751 = create_deck( [ "dx_sp_jmlb_intr_niko_yuriwonthavemuchtime", "dx_sp_jmlb_intr_niko_yurisdelegationwillb" ], 1, 1 );
    }
    
    if ( isdefined( level.vo.var_fa324d47a4f2851e ) == 0 )
    {
        level.vo.var_fa324d47a4f2851e = create_deck( [ "dx_sp_jmlb_intr_lasw_inandoutnobodygetshu", "dx_sp_jmlb_intr_lasw_quickanddirtyneither" ], 1, 1 );
    }
    
    if ( isdefined( level.vo.var_fa325047a4f28bb7 ) == 0 )
    {
        level.vo.var_fa325047a4f28bb7 = create_deck( [ "dx_sp_jmlb_intr_niko_iknowarklovwelltellm", "dx_sp_jmlb_intr_niko_iknowarklovwellilldo" ], 1, 1 );
    }
    
    thread function_1c11a2950dae76a7( 0, 0.25 );
    flag_wait( "vo_blocking_clear" );
    level.laswell say_team( "dx_sp_jmlb_intr_lasw_yurishouldhavesentyo", 1 );
    thread function_1c11a2950dae76a7( 0.5, 0.25 );
    flag_wait( "vo_blocking_clear" );
    level.nik say_team( "dx_sp_jmlb_intr_niko_affirmativearklovadm", 1 );
    thread function_1c11a2950dae76a7( 0.5, 0.25 );
    flag_wait( "vo_blocking_clear" );
    level.laswell say_team( "dx_sp_jmlb_intr_lasw_copydishontheroof", 1 );
    thread function_1c11a2950dae76a7( 0.5, 0.25 );
    flag_wait( "vo_blocking_clear" );
    level.nik say_team( level.vo.var_fa324e47a4f28751 deck_draw(), 1 );
    thread function_1c11a2950dae76a7( 0.5, 0.25 );
    flag_wait( "vo_blocking_clear" );
    level.laswell say_team( level.vo.var_fa324d47a4f2851e deck_draw(), 1 );
    thread function_1c11a2950dae76a7( 0.5, 0.25 );
    flag_wait( "vo_blocking_clear" );
    level.nik say_team( level.vo.var_fa325047a4f28bb7 deck_draw(), 1 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x52bf
// Size: 0x136
function function_f2ffae8c74f88dde()
{
    if ( isdefined( level.vo.var_e19567c63fcab477 ) == 0 )
    {
        level.vo.var_e19567c63fcab477 = create_deck( [ "dx_sp_jmlb_glob_lasw_approachingtheadminb", "dx_sp_jmlb_glob_lasw_closingontheentrance", "dx_sp_jmlb_glob_lasw_eyesontheadminbuildi" ], 1, 1 );
    }
    
    if ( isdefined( level.vo.var_eab13e7d7853ad1 ) == 0 )
    {
        level.vo.var_eab13e7d7853ad1 = create_deck( [ "dx_sp_jmlb_glob_niko_thatstheplaceyuriisi", "dx_sp_jmlb_glob_niko_sofarsogood", "dx_sp_jmlb_glob_niko_nowyouneedtogetinsid" ], 1, 1 );
    }
    
    thread function_1c11a2950dae76a7( 0, 0.15 );
    flag_wait( "vo_blocking_clear" );
    level.laswell say_team( level.vo.var_e19567c63fcab477 deck_draw(), 1 );
    thread function_1c11a2950dae76a7( 0.5, 0.15 );
    flag_wait( "vo_blocking_clear" );
    level.nik say_team( level.vo.var_eab13e7d7853ad1 deck_draw(), 1 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x53fd
// Size: 0x1fb
function function_5729a6df7fd10f13()
{
    if ( isdefined( level.vo.var_50b3c5ec7fae3234 ) == 0 )
    {
        level.vo.var_50b3c5ec7fae3234 = create_deck( [ "dx_sp_jmlb_card_niko_youllneedtoborrowone", "dx_sp_jmlb_card_niko_goodthingyoureaspy" ], 1, 1 );
    }
    
    if ( isdefined( level.vo.var_a8fedfd250da3bc2 ) == 0 )
    {
        level.vo.var_a8fedfd250da3bc2 = create_deck( [ "dx_sp_jmlb_card_lasw_beticouldfindoneonan", "dx_sp_jmlb_card_lasw_illsnagacardoffanoff" ], 1, 1 );
    }
    
    flag_set( "vo_suppress_suspicion" );
    thread function_1c11a2950dae76a7( 0, 0.25 );
    flag_wait( "vo_blocking_clear" );
    level.laswell say_team( "dx_sp_jmlb_card_lasw_gotaproblemneedasecu", 1 );
    thread function_1c11a2950dae76a7( 0.5, 0.25 );
    flag_wait( "vo_blocking_clear" );
    level.nik say_team( level.vo.var_50b3c5ec7fae3234 deck_draw(), 1 );
    thread function_1c11a2950dae76a7( 1, 0.25 );
    flag_wait( "vo_blocking_clear" );
    timestamp = gettime();
    result = level.laswell say_team( level.vo.var_a8fedfd250da3bc2 deck_draw(), 1 );
    thread function_1c11a2950dae76a7( 0.7, 0.25 );
    flag_wait( "vo_blocking_clear" );
    
    if ( istrue( result ) == 0 || time_has_passed( timestamp, 6 ) )
    {
        return;
    }
    
    level.laswell say_team( "dx_sp_jmlb_card_lasw_anyoneenteringorexit", 1 );
    thread function_1c11a2950dae76a7( 0.6, 0.25 );
    flag_wait( "vo_blocking_clear" );
    level.nik say_team( "dx_sp_jmlb_card_niko_goodcalllookforanoff", 1 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x5600
// Size: 0xd2
function function_39a46d271fddf188()
{
    if ( isdefined( level.vo.var_a60ac0e297ae463b ) == 0 )
    {
        level.vo.var_a60ac0e297ae463b = create_deck( [ "dx_sp_jmlb_card_niko_soundslikeyoufoundyo", "dx_sp_jmlb_card_niko_waittilhesaloneanddo" ], 1, 1 );
    }
    
    thread function_1c11a2950dae76a7( 0, 0.15 );
    flag_wait( "vo_blocking_clear" );
    level.laswell say_team( "dx_sp_jmlb_card_lasw_iseeamajorleavingthe", 1 );
    thread function_1c11a2950dae76a7( 0.7, 0.15 );
    flag_wait( "vo_blocking_clear" );
    level.nik say_team( level.vo.var_a60ac0e297ae463b deck_draw(), 1 );
    flag_clear( "vo_suppress_suspicion" );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x56da
// Size: 0x2
function function_4f77d38ab53b78c0()
{
    
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x56e4
// Size: 0x113
function function_2474b6ab7ddebaab()
{
    thread function_1c11a2950dae76a7( 0, 0.15 );
    flag_wait( "vo_blocking_clear" );
    level.laswell say_team( "dx_sp_jmlb_card_lasw_targeteliminatedkeyc", 1, 1 );
    thread function_1c11a2950dae76a7( 0.8, 0.15 );
    flag_wait( "vo_blocking_clear" );
    level.nik say_team( "dx_sp_jmlb_card_niko_hetookonefortheteam", 1 );
    thread function_1c11a2950dae76a7( 0.6, 0.15 );
    flag_wait( "vo_blocking_clear" );
    level.laswell say_team( "dx_sp_jmlb_card_lasw_hadtobedone", 0.9, 2 );
    thread function_1c11a2950dae76a7( 0.4, 0.15 );
    flag_wait( "vo_blocking_clear" );
    level.nik say_team( "dx_sp_jmlb_card_niko_thatonesonmakarovnot", 1 );
    thread function_1c11a2950dae76a7( 0.8, 0.2 );
    flag_wait( "vo_blocking_clear" );
    level.laswell say_team( "dx_sp_jmlb_card_lasw_yuribettermakethiswo", 0.9, 2 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x57ff
// Size: 0xad
function function_50e88508a1b3a727()
{
    level.nik say( "dx_sp_jmlb_escp_niko_yankeetowatcherlaswe", 1, 1 );
    thread function_1c11a2950dae76a7( 0.8, 0.15 );
    flag_wait( "vo_blocking_clear" );
    level.laswell say_team( "dx_sp_jmlb_escp_lasw_fornowmissileattackc", 1 );
    level.nik say( "dx_sp_jmlb_escp_niko_gettothehighgroundlo", 1, 1 );
    
    if ( flag( "vo_gas_4" ) )
    {
        return;
    }
    
    thread function_1c11a2950dae76a7( 0.6, 0.15 );
    flag_wait( "vo_blocking_clear" );
    level.laswell say_team( "dx_sp_jmlb_escp_lasw_rogeronmyway", 1 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x58b4
// Size: 0xb7
function function_ab947789152120e2()
{
    if ( isdefined( level.vo.var_cfdb14c3784bc4c7 ) == 0 )
    {
        level.vo.var_cfdb14c3784bc4c7 = create_deck( [ "dx_sp_jmlb_escp_lasw_cominupnownikyouhere", "dx_sp_jmlb_escp_lasw_needanetanik", "dx_sp_jmlb_escp_lasw_nikwhereyou" ], 1, 1 );
    }
    
    thread function_1c11a2950dae76a7( 0, 0.15 );
    flag_wait( "vo_blocking_clear" );
    level.laswell say_team( level.vo.var_cfdb14c3784bc4c7 deck_draw(), 1 );
    level.nik say( "dx_sp_jmlb_escp_niko_circlingnowpeopleare", 1, 1 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x5973
// Size: 0x9a
function function_5752c30310012c2f()
{
    if ( isdefined( level.vo.var_ea54b2823ef16da1 ) == 0 )
    {
        level.vo.var_ea54b2823ef16da1 = create_deck( [ "dx_sp_jmlb_escp_niko_laswellimovertheroof", "dx_sp_jmlb_escp_niko_laswellimattheexfilg", "dx_sp_jmlb_escp_niko_gettotheroofforexfil", "dx_sp_jmlb_escp_niko_wedonthavemuchtimeth" ], 1, 1 );
    }
    
    wait 10;
    
    if ( flag( "vo_gas_6" ) )
    {
        return;
    }
    
    return level.nik say_team( level.vo.var_ea54b2823ef16da1 deck_draw(), 1 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x5a16
// Size: 0x172
function function_29efd9f9273328c6()
{
    if ( isdefined( level.vo.var_74322a235813a483 ) == 0 )
    {
        level.vo.var_74322a235813a483 = create_deck( [ [ level.laswell, 0.6, "dx_sp_jmlb_escp_lasw_negativewewentsepara" ], [ level.laswell, 0.7, "dx_sp_jmlb_escp_lasw_negativewesplitup" ] ], 1, 1 );
    }
    
    if ( isdefined( level.vo.var_5706c2778ea669d ) == 0 )
    {
        level.vo.var_5706c2778ea669d = create_deck( [ [ level.nik, 0.8, "dx_sp_jmlb_escp_niko_ihopehemakesit" ], [ level.nik, 0.7, "dx_sp_jmlb_escp_niko_hesasurvivorlikeyou" ] ], 1, 1 );
    }
    
    escape_yuri = [ level.nik, 0.5, "dx_sp_jmlb_escp_niko_isyuriwithyou", level.vo.var_74322a235813a483 deck_draw(), level.vo.var_5706c2778ea669d deck_draw() ];
    return level say_sequence( escape_yuri, 1, 0 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x5b91
// Size: 0x9f
function function_10066217f1e7ea88()
{
    level endon( "game_ended" );
    
    if ( isdefined( level.vo.var_c2aaa140b9b3b4c6 ) == 0 )
    {
        level.vo.var_c2aaa140b9b3b4c6 = create_deck( [ "dx_sp_jmlb_escp_niko_theladderlaswellusei", "dx_sp_jmlb_escp_niko_usetheladderlaswell", "dx_sp_jmlb_escp_niko_climbtheladderlaswel" ], 1, 1 );
    }
    
    wait 7;
    
    if ( level.player isonladder() == 1 )
    {
        return;
    }
    
    return level.nik say( level.vo.var_c2aaa140b9b3b4c6 deck_draw(), 0, 1 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x5c39
// Size: 0x1c
function private function_4b9f182f4435cad4()
{
    wait 0.35;
    level.nik stop_dialogue( 1, 1 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x5c5d
// Size: 0x150
function function_c535089281bbdef1()
{
    if ( isdefined( level.vo.var_8be396006b1cdc6c ) == 0 )
    {
        level.vo.var_8be396006b1cdc6c = create_deck( [ "dx_sp_jmlb_escp_lasw_climbingtheladdernow", "dx_sp_jmlb_escp_lasw_cominguptheladder" ], 1, 1 );
    }
    
    if ( isdefined( level.vo.var_263de9dcd78a93ee ) == 0 )
    {
        level.vo.var_263de9dcd78a93ee = create_deck( [ "dx_sp_jmlb_escp_niko_hurrythecloudisrisin", "dx_sp_jmlb_escp_niko_quicklylaswellthegas", "dx_sp_jmlb_escp_niko_quickwatcherthegasis" ], 1, 1 );
    }
    
    while ( true )
    {
        if ( flag( "vo_gas_8" ) )
        {
            return;
        }
        
        if ( level.player isonladder() == 1 )
        {
            break;
        }
        
        wait 0.1;
    }
    
    thread function_4b9f182f4435cad4();
    level.laswell say( level.vo.var_8be396006b1cdc6c deck_draw(), 1, 0.3 );
    wait 0.4;
    
    if ( flag( "vo_gas_8" ) )
    {
        return;
    }
    
    level.nik say( level.vo.var_263de9dcd78a93ee deck_draw(), 1, 0.3 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x5db5
// Size: 0x11b
function function_c92fb4892b0d25eb()
{
    if ( isdefined( level.vo.var_b8c70a04745d0f6 ) == 0 )
    {
        level.vo.var_b8c70a04745d0f6 = create_deck( [ "dx_sp_jmlb_escp_lasw_imalmosttoyounikstan", "dx_sp_jmlb_escp_lasw_stillpushingupnikhol" ], 1, 1 );
    }
    
    if ( isdefined( level.vo.var_b1abf967b8af6848 ) == 0 )
    {
        level.vo.var_b1abf967b8af6848 = create_deck( [ "dx_sp_jmlb_escp_niko_imherelaswelliwontle", "dx_sp_jmlb_escp_niko_ofcourselaswelljustc" ], 1, 1 );
    }
    
    thread function_1c11a2950dae76a7( 0, 0.15 );
    flag_wait( "vo_blocking_clear" );
    level.laswell say_team( level.vo.var_b8c70a04745d0f6 deck_draw(), 1 );
    wait 0.5;
    
    if ( flag( "vo_gas_10" ) )
    {
        return;
    }
    
    level.nik say_team( level.vo.var_b1abf967b8af6848 deck_draw(), 1 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x5ed8
// Size: 0x1c
function function_67cc8ceb8dbc7061()
{
    return level.nik say( "dx_sp_jmlb_escp_niko_laswelliseeyoujump", 1, 1, 1 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x5efd
// Size: 0x58
function function_36cd5a85f290c8ef()
{
    vo_officer_1_in = [ [ level.laswell, "dx_sp_jmlb_card_lasw_majorsbreakingawayhe" ], [ level.nik, 0.5, "dx_sp_jmlb_card_niko_couldbeagoodplacetoc" ] ];
    return level say_sequence( vo_officer_1_in, 1, 0 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x5f5e
// Size: 0x58
function function_6b8d9f94b222d874()
{
    vo_officer_1_out = [ [ level.laswell, "dx_sp_jmlb_card_lasw_majorsheadingbackdow" ], [ level.nik, 0.5, "dx_sp_jmlb_card_niko_adviseyouwaituntilhe" ] ];
    return level say_sequence( vo_officer_1_out, 1, 0 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x5fbf
// Size: 0x58
function function_7e4c38a3be37d1cc()
{
    vo_officer_2_in = [ [ level.laswell, "dx_sp_jmlb_card_lasw_hesheadingtowardsane" ], [ level.nik, 0.5, "dx_sp_jmlb_card_niko_ifitscleartakehimout" ] ];
    return level say_sequence( vo_officer_2_in, 1, 0 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x6020
// Size: 0x58
function function_a480481b1742edf9()
{
    vo_officer_2_out = [ [ level.laswell, "dx_sp_jmlb_card_lasw_majorsleavingtheequi" ], [ level.nik, 0.5, "dx_sp_jmlb_card_niko_keepyourdistancewait" ] ];
    return level say_sequence( vo_officer_2_out, 1, 0 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x6081
// Size: 0x58
function function_e2a19ab98e3473a1()
{
    vo_officer_3_in = [ [ level.laswell, "dx_sp_jmlb_card_lasw_majorsenteringthehan" ], [ level.nik, 0.5, "dx_sp_jmlb_card_niko_takehimdownandgethis" ] ];
    return level say_sequence( vo_officer_3_in, 1, 0 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x60e2
// Size: 0xb6
function function_481f27137efdcb82()
{
    if ( isdefined( level.vo.officer_3_out ) == 0 )
    {
        level.vo.officer_3_out = create_deck( [ "dx_sp_jmlb_card_lasw_majorsexitingthehang", "dx_sp_jmlb_card_lasw_majorsleavingthegara" ], 1, 1 );
    }
    
    vo_officer_3_out = [ [ level.laswell, level.vo.officer_3_out deck_draw() ], [ level.nik, 0.5, "dx_sp_jmlb_card_niko_stayonhimlaswell" ] ];
    return level say_sequence( vo_officer_3_out, 1, 0 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x61a1
// Size: 0x87, Type: bool
function private function_442854a0e08362fa( soldier, var_53db94485a61f025, var_2c1d28c412904651 )
{
    var_c04ba734aa3b11ae = 1;
    var_f15659fbd33f740a = 1;
    
    if ( var_53db94485a61f025 )
    {
        var_c04ba734aa3b11ae = isalive( level.officer );
        
        if ( var_c04ba734aa3b11ae == 0 )
        {
            broadcaststealthevent( soldier, "death" );
        }
    }
    
    if ( var_2c1d28c412904651 )
    {
        var_f15659fbd33f740a = isalive( soldier );
        
        if ( var_f15659fbd33f740a == 0 )
        {
            broadcaststealthevent( level.officer, "death" );
        }
    }
    
    return var_c04ba734aa3b11ae && var_f15659fbd33f740a;
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x6231
// Size: 0xe7, Type: bool
function private function_810716cd17f8dabb( entarray )
{
    if ( isdefined( entarray ) == 0 || isarray( entarray ) == 0 )
    {
        return false;
    }
    
    var_8e10af1793932453 = 0;
    
    foreach ( ent in entarray )
    {
        if ( isalive( ent ) == 0 )
        {
            var_8e10af1793932453 = 1;
        }
    }
    
    if ( var_8e10af1793932453 == 1 )
    {
        foreach ( ent in entarray )
        {
            if ( isalive( ent ) == 1 )
            {
                ent stop_dialogue( 1, 1 );
                broadcaststealthevent( ent, "death" );
            }
        }
        
        return false;
    }
    
    return true;
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x6321
// Size: 0x251
function function_9dfdd6a6e617ab0d()
{
    var_5d14be1c9dbe6082 = istrue( level.vo.var_38c66843ef1f9b5c );
    sequence = [ "dx_sp_jmlb_icdm_offc_statusupdateonthecom", "dx_sp_jmlb_icdm_rf01_upgradesarecurrently", "dx_sp_jmlb_icdm_offc_whenwillitbereadyfor", "dx_sp_jmlb_icdm_rf01_endofday" ];
    sequence_alt = [ "dx_sp_jmlb_icdm_offc_fillmeinsoldier", "dx_sp_jmlb_icdm_rf02_inspectionscompletew", "dx_sp_jmlb_icdm_offc_goodkeepthemomentumg", "dx_sp_jmlb_icdm_rf02_yessir" ];
    soldier1 = getent( "officer_meet_1", "script_noteworthy", 1 );
    soldier1.var_36023fdce648d2ea = 1;
    soldier1 endon( "death" );
    level.officer endon( "death" );
    flag_wait( "officer_pretalk_1" );
    soldier1.radius = 20;
    soldier1.goalradius = 20;
    soldier1 leaveinteraction();
    
    if ( function_442854a0e08362fa( soldier1, 1, 1 ) == 0 )
    {
        return 0;
    }
    
    soldier1.var_36023fdce648d2ea = 0;
    
    if ( function_442854a0e08362fa( soldier1, 1, 1 ) == 0 )
    {
        return 0;
    }
    
    currentline = level.officer say( var_5d14be1c9dbe6082 == 0 ? sequence[ 0 ] : sequence_alt[ 0 ] );
    wait 1.25;
    
    if ( function_442854a0e08362fa( soldier1, 0, 1 ) == 0 )
    {
        return 0;
    }
    
    currentline = soldier1 say( var_5d14be1c9dbe6082 == 0 ? sequence[ 1 ] : sequence_alt[ 1 ] );
    wait 1.2;
    
    if ( function_442854a0e08362fa( soldier1, 1, 0 ) == 0 )
    {
        return 0;
    }
    
    currentline = level.officer say( var_5d14be1c9dbe6082 == 0 ? sequence[ 2 ] : sequence_alt[ 2 ] );
    wait 0.7;
    
    if ( function_442854a0e08362fa( soldier1, 0, 1 ) == 0 )
    {
        return 0;
    }
    
    currentline = soldier1 say( var_5d14be1c9dbe6082 == 0 ? sequence[ 3 ] : sequence_alt[ 3 ] );
    flag_clear( "officer_conversation_1" );
    soldier1 setlookatentity( level.player );
    level.officer setlookatentity( level.player );
    soldier1.var_36023fdce648d2ea = 1;
    flag_set( "conv_1_done" );
    wait 15;
    flag_clear( "conv_1_done" );
    flag_clear( "officer_pretalk_1" );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x657a
// Size: 0x23b
function function_9dfdd3a6e617a474()
{
    var_5d14be1c9dbe6082 = istrue( level.vo.var_38c66843ef1f9b5c );
    sequence = [ "dx_sp_jmlb_icdm_offc_isthesupplyshipmenta", "dx_sp_jmlb_icdm_ru01_affirmative", "dx_sp_jmlb_icdm_offc_eta", "dx_sp_jmlb_icdm_ru01_weshouldseethembysun" ];
    sequence_alt = [ "dx_sp_jmlb_icdm_offc_thosedrillsneedtobep", "dx_sp_jmlb_icdm_ru01_yessir", "dx_sp_jmlb_icdm_offc_illneedafullreport", "dx_sp_jmlb_icdm_ru01_ofcourseitllbeonyour" ];
    soldier1 = getent( "officer_meet_2", "script_noteworthy", 1 );
    soldier1.var_36023fdce648d2ea = 1;
    soldier1 endon( "death" );
    level.officer endon( "death" );
    flag_wait( "officer_pretalk_2" );
    soldier1 leaveinteraction();
    
    if ( function_442854a0e08362fa( soldier1, 1, 1 ) == 0 )
    {
        return 0;
    }
    
    soldier1.var_36023fdce648d2ea = 0;
    wait 2.5;
    
    if ( function_442854a0e08362fa( soldier1, 1, 1 ) == 0 )
    {
        return 0;
    }
    
    wait 1.25;
    currentline = level.officer say( var_5d14be1c9dbe6082 == 0 ? sequence[ 0 ] : sequence_alt[ 0 ] );
    wait 0.6;
    
    if ( function_442854a0e08362fa( soldier1, 0, 1 ) == 0 )
    {
        return 0;
    }
    
    currentline = soldier1 say( var_5d14be1c9dbe6082 == 0 ? sequence[ 1 ] : sequence_alt[ 1 ] );
    wait 0.7;
    
    if ( function_442854a0e08362fa( soldier1, 1, 0 ) == 0 )
    {
        return 0;
    }
    
    currentline = level.officer say( var_5d14be1c9dbe6082 == 0 ? sequence[ 2 ] : sequence_alt[ 2 ] );
    
    if ( function_442854a0e08362fa( soldier1, 0, 1 ) == 0 )
    {
        return 0;
    }
    
    currentline = soldier1 say( var_5d14be1c9dbe6082 == 0 ? sequence[ 3 ] : sequence_alt[ 3 ] );
    flag_clear( "officer_conversation_2" );
    soldier1 setlookatentity( level.player );
    level.officer setlookatentity( level.player );
    soldier1.var_36023fdce648d2ea = 1;
    flag_set( "conv_2_done" );
    wait 15;
    flag_clear( "conv_2_done" );
    flag_clear( "officer_pretalk_2" );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x67bd
// Size: 0x277
function function_9dfdd4a6e617a6a7()
{
    var_5d14be1c9dbe6082 = istrue( level.vo.var_38c66843ef1f9b5c );
    sequence = [ "dx_sp_jmlb_icdm_offc_iwantastatusupdate", "dx_sp_jmlb_icdm_ru01_finishingupsoon", "dx_sp_jmlb_icdm_offc_whenshouldiexpectit", "dx_sp_jmlb_icdm_ru01_1900atthelatest" ];
    sequence_alt = [ "dx_sp_jmlb_icdm_offc_whatsthelatest", "dx_sp_jmlb_icdm_ru02_thegeneralgreenlitou", "dx_sp_jmlb_icdm_offc_goodkeeponschedule", "dx_sp_jmlb_icdm_ru02_copy" ];
    soldier1 = getent( "officer_meet_3", "script_noteworthy", 1 );
    soldier1.var_36023fdce648d2ea = 1;
    soldier1 endon( "death" );
    level.officer endon( "death" );
    flag_wait( "officer_pretalk_3" );
    soldier1.radius = 25;
    soldier1.goalradius = 25;
    soldier1 leaveinteraction();
    
    if ( function_442854a0e08362fa( soldier1, 1, 1 ) == 0 )
    {
        return 0;
    }
    
    soldier1.var_36023fdce648d2ea = 0;
    wait 1.35;
    
    if ( function_442854a0e08362fa( soldier1, 1, 1 ) == 0 )
    {
        return 0;
    }
    
    soldier1 setlookatentity( level.officer );
    level.officer setlookatentity( soldier1 );
    currentline = level.officer say( var_5d14be1c9dbe6082 == 0 ? sequence[ 0 ] : sequence_alt[ 0 ] );
    wait 0.75;
    
    if ( function_442854a0e08362fa( soldier1, 0, 1 ) == 0 )
    {
        return 0;
    }
    
    currentline = soldier1 say( var_5d14be1c9dbe6082 == 0 ? sequence[ 1 ] : sequence_alt[ 1 ] );
    wait 1.25;
    
    if ( function_442854a0e08362fa( soldier1, 1, 0 ) == 0 )
    {
        return 0;
    }
    
    currentline = level.officer say( var_5d14be1c9dbe6082 == 0 ? sequence[ 2 ] : sequence_alt[ 2 ] );
    wait 0.75;
    
    if ( function_442854a0e08362fa( soldier1, 0, 1 ) == 0 )
    {
        return 0;
    }
    
    currentline = soldier1 say( var_5d14be1c9dbe6082 == 0 ? sequence[ 3 ] : sequence_alt[ 3 ] );
    flag_clear( "officer_conversation_3" );
    soldier1 setlookatentity( level.player );
    level.officer setlookatentity( level.player );
    soldier1.var_36023fdce648d2ea = 1;
    flag_set( "conv_3_done" );
    wait 15;
    flag_clear( "conv_3_done" );
    flag_clear( "officer_pretalk_3" );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x6a3c
// Size: 0x226
function function_346fa52676920c09()
{
    level endon( "game_ended" );
    level endon( "officer_dead" );
    
    if ( flag( "keycard_nag_playing" ) == 1 )
    {
        return;
    }
    
    flag_set( "keycard_nag_playing" );
    
    if ( isdefined( level.vo.var_46b934600d05c4be ) == 0 )
    {
        level.vo.var_46b934600d05c4be = create_deck( [ "dx_sp_jmlb_card_niko_yuriwontwaitforeverd", "dx_sp_jmlb_card_niko_laswellhaveyouacquir", "dx_sp_jmlb_card_niko_watcherwhatsyourstat" ], 1, 1 );
        level.vo.var_346a6915c777b87e = create_deck( [ "dx_sp_jmlb_card_niko_tellmewhenyouveacqui", "dx_sp_jmlb_card_niko_besuretotakethemajor" ], 1, 1 );
    }
    
    if ( isdefined( level.vo.var_6d50f530ac495744 ) == 0 )
    {
        level.vo.var_6d50f530ac495744 = create_deck( [ "dx_sp_jmlb_card_lasw_negatorynokeycardyet", "dx_sp_jmlb_card_lasw_negativeworkingonit" ], 1, 1, 0 );
    }
    
    delay = growing_delay( 30, 60, 4 );
    wait 25;
    
    while ( true )
    {
        waitfor( delay );
        
        if ( flag( "officer_dead" ) )
        {
            level thread function_1815cc87725ae2e6();
            return;
        }
        
        function_1bb9cb52443650af();
        
        if ( flag( "officer_dead" ) == 0 )
        {
            var_1296b1f3f4f40e11 = percent_chance( 50 );
            
            if ( var_1296b1f3f4f40e11 == 0 )
            {
                result = level.nik function_fc0eb6b81c66c661( 0.3, level.vo.var_346a6915c777b87e deck_draw(), 0, 2 );
                continue;
            }
            
            result = level.nik function_fc0eb6b81c66c661( 0.3, level.vo.var_46b934600d05c4be deck_draw(), 0, 2 );
            
            if ( istrue( result ) && flag( "officer_dead" ) == 0 )
            {
                level.laswell function_fc0eb6b81c66c661( 0.5, level.vo.var_6d50f530ac495744 deck_draw(), 0, 2 );
            }
        }
    }
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x6c6a
// Size: 0xad
function private function_1bb9cb52443650af()
{
    while ( true )
    {
        if ( isdefined( level.officer ) == 0 || flag( "officer_dead" ) == 1 )
        {
            return;
        }
        
        if ( distancesquared( level.player.origin, level.officer.origin ) < 62500 )
        {
            wait 1;
            continue;
        }
        
        if ( function_6c31b0b0edd184ed( [ level.player, level.nik ], 3 ) )
        {
            wait 2;
            continue;
        }
        
        if ( function_bdd7b496380aa8e3( level.officer, 1, 1 ) )
        {
            wait 3;
            continue;
        }
        
        return;
    }
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x6d1f
// Size: 0xc9
function function_1815cc87725ae2e6()
{
    level endon( "game_ended" );
    
    if ( isdefined( level.vo.var_46b934600d05c4be ) == 0 )
    {
        level.vo.var_46b934600d05c4be = create_deck( [ "dx_sp_jmlb_card_niko_yuriwontwaitforeverd", "dx_sp_jmlb_card_niko_laswellhaveyouacquir", "dx_sp_jmlb_card_niko_watcherwhatsyourstat" ], 1, 1 );
    }
    
    wait 10;
    delay = growing_delay( 15, 30, 3 );
    
    while ( true )
    {
        if ( flag( "obj_keycard_completed" ) == 1 )
        {
            return;
        }
        
        level.nik function_fc0eb6b81c66c661( 0.5, level.vo.var_46b934600d05c4be deck_draw(), 0, 1 );
        waitfor( delay );
    }
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x6df0
// Size: 0x115
function function_dd37afb56087641b()
{
    level endon( "game_ended" );
    
    if ( isdefined( level.vo.var_51732fe0b2eb5b25 ) == 0 )
    {
        level.vo.var_51732fe0b2eb5b25 = create_deck( [ "dx_sp_jmlb_card_niko_gettotheadminbuildin", "dx_sp_jmlb_card_niko_yurisintheadminbuild", "dx_sp_jmlb_card_niko_youhavethekeycardlas", "dx_sp_jmlb_card_niko_thekeycardwillgetyou", "dx_sp_jmlb_card_niko_watcheryoushouldbein", "dx_sp_jmlb_glob_niko_youneedtotalktoyurim" ], 1, 1 );
    }
    
    delay = growing_delay( 15, 30, 3 );
    
    while ( true )
    {
        if ( flag( "ready_for_yuri" ) == 1 )
        {
            return;
        }
        
        result = level.nik function_fc0eb6b81c66c661( 0.5, level.vo.var_51732fe0b2eb5b25, 0, 1 );
        
        if ( flag( "ready_for_yuri" ) == 1 || istrue( result ) == 0 )
        {
            return;
        }
        
        level.laswell say_team( "dx_sp_jmlb_card_lasw_movingnow", 0 );
        waitfor( delay );
    }
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x6f0d
// Size: 0x1fd
function function_f2b43508e695e9c8()
{
    if ( isdefined( level.vo.var_1dc7663d5658926a ) == 0 )
    {
        level.vo.var_1dc7663d5658926a = create_deck( [ [ level.laswell, "dx_sp_jmlb_intr_lasw_standbysoldierspassi" ], [ level.laswell, "dx_sp_jmlb_intr_lasw_gottroopspassingme" ], [ level.laswell, "dx_sp_jmlb_intr_lasw_squadapproachingstan" ] ], 1, 1 );
    }
    
    if ( isdefined( level.vo.var_1dc7653d56589037 ) == 0 )
    {
        level.vo.var_1dc7653d56589037 = create_deck( [ [ level.nik, 0.5, "dx_sp_jmlb_intr_niko_besttokeepyourdistan" ], [ level.nik, 0.5, "dx_sp_jmlb_intr_niko_theyvenoreasontosusp" ], [ level.nik, 0.5, "dx_sp_jmlb_intr_niko_actnaturallylaswell" ] ], 1, 1 );
    }
    
    aliases = [ level.vo.var_1dc7663d5658926a deck_draw(), level.vo.var_1dc7653d56589037 deck_draw(), [ level.laswell, 0.5, "dx_sp_jmlb_intr_lasw_imaspynikthatshowiro" ], [ level.nik, 0.5, "dx_sp_jmlb_intr_niko_ofcoursestillthisisc" ], [ level.laswell, 0.5, "dx_sp_jmlb_intr_lasw_wereallalittlecrazyn" ] ];
    wait 1.25;
    return level.laswell say_sequence( aliases, 0.5, 0 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x7113
// Size: 0x1bc
function function_c5425b5ce819b3d2()
{
    level endon( "game_ended" );
    level endon( "intel_reached" );
    wait 45;
    
    if ( flag( "spawn_small_heli" ) == 1 )
    {
        return;
    }
    
    sequence = [ level.nik, 0, "dx_sp_jmlb_intr_niko_whereareyoulaswell", level.laswell, 0.5, "dx_sp_jmlb_intr_lasw_lookingfortheadminbu", level.nik, 0.5, "dx_sp_jmlb_intr_niko_twostoriessatellited", level.nik, 0.8, "dx_sp_jmlb_intr_niko_nexttothehangerthere", level.nik, 1.5, "dx_sp_jmlb_intr_niko_flagsovertheslidingg" ];
    level say_sequence( sequence, 1, 1 );
    options = [ "dx_sp_jmlb_intr_lasw_checkrooftopsatellit", "dx_sp_jmlb_intr_lasw_copyglassdoorsflagsa" ];
    result = level.laswell say_delayed( 1, random( options ), 0.5, 2 );
    wait 2;
    var_28265f486074243d = flag( "spawn_small_heli" ) == 0;
    
    if ( istrue( result ) && var_28265f486074243d )
    {
        sequence_extra = [ level.laswell, 0, "dx_sp_jmlb_intr_lasw_yurididntmakethiseas", level.nik, 0.75, "dx_sp_jmlb_intr_niko_itsatest", level.laswell, 1, "dx_sp_jmlb_intr_lasw_whatisnt" ];
        level say_sequence( sequence_extra, 1, 1 );
    }
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x72d7
// Size: 0x19d
function function_b02ccd95322149d7()
{
    level endon( "game_ended" );
    level endon( "intel_reached" );
    level endon( "obj_yuri_completed" );
    
    if ( isdefined( level.vo.var_816dc6e1a2170c1 ) == 0 )
    {
        level.vo.var_816dc6e1a2170c1 = create_deck( [ "dx_sp_jmlb_glob_niko_laswellwhatsyourstat", "dx_sp_jmlb_glob_niko_dontgetmadelaswellbu", "dx_sp_jmlb_glob_niko_yurisattheadminbuild", "dx_sp_jmlb_glob_niko_yurisentcommshecantw", "dx_sp_jmlb_glob_niko_yuriiswaitingforyoua", "dx_sp_jmlb_glob_niko_laswellyouvecomethis", "dx_sp_jmlb_glob_niko_yuricheckedinhesinth", "dx_sp_jmlb_glob_niko_laswellmeetyuriinthe", "dx_sp_jmlb_glob_niko_thearklovadministrat", "dx_sp_jmlb_glob_niko_adminbuildingstoward", "dx_sp_jmlb_glob_niko_lookfortheslidinggla", "dx_sp_jmlb_glob_niko_ifyouseethehangarthe", "dx_sp_jmlb_glob_niko_yuricheckedinheswait" ], 1, 1 );
    }
    
    delay = growing_delay( 30, 60, 3 );
    wait 20;
    
    while ( true )
    {
        while ( function_6c31b0b0edd184ed( [ level.laswell, level.nik ], 4 ) == 1 )
        {
            wait 1;
        }
        
        if ( flag( "intel_reached" ) == 1 || flag( "obj_yuri_completed" ) == 1 || flag( "escape_sequence_start" ) == 1 )
        {
            return;
        }
        
        result = level.nik function_fc0eb6b81c66c661( 0.3, level.vo.var_816dc6e1a2170c1 deck_draw(), 0, 0.5, 0 );
        
        if ( istrue( result ) )
        {
            waitfor( delay );
            continue;
        }
        
        wait 5;
    }
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x747c
// Size: 0x104
function vo_combat()
{
    if ( isdefined( level.vo.combat_started ) == 0 )
    {
        level.vo.combat_started = create_deck( [ "dx_sp_jmlb_glob_lasw_contact", "dx_sp_jmlb_glob_lasw_engaging", "dx_sp_jmlb_glob_lasw_goinhot", "dx_sp_jmlb_glob_lasw_firing" ], 1, 1 );
    }
    
    flag_wait( "flag_dungeon_intro_complete" );
    
    while ( true )
    {
        waitframe();
        var_6078f5ff9c36f195 = default_to( level.player.last_weapon_fire_time, -10000 );
        level.player waittill( "weapon_fired" );
        
        if ( time_has_passed( var_6078f5ff9c36f195, 10 ) == 0 || function_bdd7b496380aa8e3( undefined, 1 ) )
        {
            continue;
        }
        
        if ( flag( "escape_sequence_start" ) )
        {
            return;
        }
        
        level.laswell say( level.vo.combat_started deck_draw(), 2, 1 );
    }
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x7588
// Size: 0x151
function vo_spotted()
{
    if ( isdefined( level.vo.var_f51be24087ee9b71 ) == 0 )
    {
        level.vo.var_f51be24087ee9b71 = create_deck( [ "dx_sp_jmlb_glob_lasw_shittheyreontome", "dx_sp_jmlb_glob_lasw_theyseeme", "dx_sp_jmlb_glob_lasw_havetoshaketheseguys", "dx_sp_jmlb_glob_lasw_imcompromised", "dx_sp_jmlb_glob_lasw_coversblown", "dx_sp_jmlb_glob_lasw_theyspottedmetakingf", "dx_sp_jmlb_glob_lasw_immade" ], 1, 1 );
    }
    
    if ( isdefined( level.vo.var_9802d1e40164f68b ) == 0 )
    {
        level.vo.var_9802d1e40164f68b = create_deck( [ "dx_sp_jmlb_glob_niko_repositionandtrytolo", "dx_sp_jmlb_glob_niko_findcoverlaswell", "dx_sp_jmlb_glob_niko_getoutoftherewatcher", "dx_sp_jmlb_glob_niko_gettosafetylaswell", "dx_sp_jmlb_glob_niko_movelaswellbeforethe" ], 1, 1 );
    }
    
    result = level.laswell say( level.vo.var_f51be24087ee9b71 deck_draw(), 1, 1, 1 );
    wait 0.5;
    
    if ( istrue( result ) )
    {
        level.nik say( level.vo.var_9802d1e40164f68b deck_draw(), 1, 1, 1 );
    }
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x76e1
// Size: 0x1d7
function function_4c9de23a4ed31bac()
{
    if ( flag( "suspicious_vo_playing" ) == 1 || flag( "confrontation_vo_playing" ) == 1 )
    {
        return;
    }
    
    flag_set( "suspicious_vo_playing" );
    
    if ( isdefined( level.vo.var_269786c4b6bde411 ) == 0 )
    {
        level.vo.var_269786c4b6bde411 = create_deck( [ "dx_sp_jmlb_glob_lasw_theyresuspicious", "dx_sp_jmlb_glob_lasw_needtoblendinbetter", "dx_sp_jmlb_glob_lasw_somethingsup", "dx_sp_jmlb_glob_lasw_theyreonalertineedto", "dx_sp_jmlb_glob_lasw_gettinsomeunwantedat" ], 1, 1 );
    }
    
    if ( isdefined( level.vo.var_30891b5f99ad2b2b ) == 0 )
    {
        level.vo.var_30891b5f99ad2b2b = create_deck( [ "dx_sp_jmlb_glob_niko_keepgoingdontgetcomp", "dx_sp_jmlb_glob_niko_dontgetmadelaswell", "dx_sp_jmlb_glob_niko_trytoreposition", "dx_sp_jmlb_glob_niko_dontmakeanysuddenmov", "dx_sp_jmlb_glob_niko_trytoresistdoinganyt", "dx_sp_jmlb_glob_niko_ifyougoloudtheyllkil", "dx_sp_jmlb_glob_niko_dontgoloudwatcherthe", "dx_sp_jmlb_glob_niko_onceyougoloudyoucant", "dx_sp_jmlb_glob_niko_ifyougoloudshitmayhi", "dx_sp_jmlb_glob_niko_ifyougohotitmaystayh", "dx_sp_jmlb_glob_niko_yourenothereforagunf", "dx_sp_jmlb_glob_niko_adviseyoustayunderth" ], 1, 1 );
    }
    
    result = level.laswell say( level.vo.var_269786c4b6bde411 deck_draw(), 1, 1 );
    wait 0.5;
    
    if ( istrue( result ) && function_6c31b0b0edd184ed( [ level.nik ], 3 ) == 0 )
    {
        level.nik say( level.vo.var_30891b5f99ad2b2b deck_draw(), 0, 1 );
    }
    
    wait 3;
    flag_clear( "suspicious_vo_playing" );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x78c0
// Size: 0x168
function function_b793a5f9451957d5()
{
    level endon( "game_ended" );
    
    if ( isdefined( level.vo.enemy_killed ) == 0 )
    {
        level.vo.enemy_killed = create_deck( [ "dx_sp_jmlb_glob_lasw_enemydown", "dx_sp_jmlb_glob_lasw_sitdown", "dx_sp_jmlb_glob_lasw_staydown", "dx_sp_jmlb_glob_lasw_burnedone", "dx_sp_jmlb_glob_lasw_droppedone", "dx_sp_jmlb_glob_lasw_targetdown", "dx_sp_jmlb_glob_lasw_onedown" ], 1, 1 );
    }
    
    flag_wait( "flag_dungeon_intro_complete" );
    
    while ( true )
    {
        wait randomfloat( 0.35 ) + 0.15;
        level waittill( "ai_killed", ent );
        
        if ( isdefined( ent ) == 0 || isdefined( level.officer ) && ent == level.officer || time_has_passed( level.player.lastenemykilltime, 0.2 ) == 1 || function_bdd7b496380aa8e3( ent ) )
        {
            wait 0.5;
            continue;
        }
        
        if ( flag( "escape_sequence_start" ) )
        {
            return;
        }
        
        result = level.laswell say_team( level.vo.enemy_killed deck_draw(), 0.5, 1, 1, 0.4 );
        wait 5;
    }
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x7a30
// Size: 0x17e
function function_40a70bdc1e21d8e6()
{
    if ( isdefined( level.vo.var_768fdc0d4efd6505 ) == 0 )
    {
        level.vo.var_768fdc0d4efd6505 = create_deck( [ "dx_sp_jmlb_glob_lasw_imclear", "dx_sp_jmlb_glob_lasw_thinkimclear", "dx_sp_jmlb_glob_lasw_allclear", "dx_sp_jmlb_glob_lasw_novisiblethreats", "dx_sp_jmlb_glob_lasw_onethemove" ], 1, 1 );
    }
    
    if ( isdefined( level.vo.var_c5fa8c929b97df3f ) == 0 )
    {
        level.vo.var_c5fa8c929b97df3f = create_deck( [ "dx_sp_jmlb_glob_niko_goodworklaswell", "dx_sp_jmlb_glob_niko_welldonewatcher", "dx_sp_jmlb_glob_niko_trynottodothatagain", "dx_sp_jmlb_glob_niko_youmaynotbesoluckyne", "dx_sp_jmlb_glob_niko_goodnowgettoyuri", "dx_sp_jmlb_glob_niko_impressivedontpushyo", "dx_sp_jmlb_glob_niko_keepmovingiftheyfind", "dx_sp_jmlb_glob_niko_gooddonttempfatelasw", "dx_sp_jmlb_glob_niko_getgoingbeforetheyfi", "dx_sp_jmlb_glob_niko_goodnowgotoyuribefor" ], 1, 1 );
    }
    
    while ( function_e9e38931019c791f() == 1 )
    {
        wait 0.5;
    }
    
    sequence = [ level.vo.var_768fdc0d4efd6505 deck_draw(), level.nik, 0.5, level.vo.var_c5fa8c929b97df3f deck_draw() ];
    level.laswell say_sequence( sequence, 0, 1 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x7bb6
// Size: 0x4b
function vo_death()
{
    var_57a5ca219946e29f = create_deck( [ "dx_sp_jmlb_glob_niko_laswellareyouthere", "dx_sp_jmlb_glob_niko_laswellcomeinlaswell", "dx_sp_jmlb_glob_niko_laswellhowcopyareyou" ], 1, 1 );
    level say( var_57a5ca219946e29f deck_draw(), 2, 0.5, 1 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x7c09
// Size: 0xe3
function function_1bbd596081a62ad5()
{
    level.laswell function_fc0eb6b81c66c661( 0, "dx_sp_jmlb_glob_lasw_adminparkinglotsonth" );
    level.laswell function_fc0eb6b81c66c661( 0, "dx_sp_jmlb_glob_lasw_seetheadminbuildingo" );
    level.laswell function_fc0eb6b81c66c661( 0, "dx_sp_jmlb_glob_lasw_seetheadminbuildingo_01" );
    level.laswell function_fc0eb6b81c66c661( 0, "dx_sp_jmlb_glob_lasw_eyesontheadminbuildi_01" );
    level.laswell function_fc0eb6b81c66c661( 0, "dx_sp_jmlb_glob_lasw_adminbuildingsrightb" );
    level.laswell function_fc0eb6b81c66c661( 0, "dx_sp_jmlb_glob_lasw_onthemainpathseethea" );
    var_57a5ca219946e29f = create_deck( [ "dx_sp_jmlb_glob_niko_copy", "dx_sp_jmlb_glob_niko_soundsgoodgettherequ", "dx_sp_jmlb_glob_niko_enterquicklyyuriswai", "dx_sp_jmlb_glob_niko_copythat", "dx_sp_jmlb_glob_niko_makeyourwayin" ], 1, 1 );
    level.nik say_team( var_57a5ca219946e29f deck_draw(), 0, 1 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x7cf4
// Size: 0xbc
function vo_coughing()
{
    if ( isdefined( level.vo.coughing ) == 0 )
    {
        level.vo.coughing = create_deck( [ "dx_sp_jmlb_glob_lasw_coughing", "dx_sp_jmlb_glob_lasw_coughing_01", "dx_sp_jmlb_glob_lasw_coughing_02", "dx_sp_jmlb_glob_lasw_coughing_03", "dx_sp_jmlb_glob_lasw_coughing_04" ], 1, 1 );
    }
    
    flag_set( "vo_coughing" );
    wait randomfloat( 0.3 ) + 0.1;
    level.laswell say( level.vo.coughing deck_draw(), 0, 1 );
    flag_clear( "vo_coughing" );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x7db8
// Size: 0xa0
function function_26981e4b4ad3721a()
{
    if ( isdefined( level.vo.major_aggro ) == 0 )
    {
        level.vo.major_aggro = create_deck( [ "dx_sp_jmlb_card_offc_whoareyouidentifyyou", "dx_sp_jmlb_card_offc_showmeyouridsoldier", "dx_sp_jmlb_card_offc_heyyoufollowingmemaa", "dx_sp_jmlb_card_offc_youwhatsyourbusiness", "dx_sp_jmlb_card_offc_showmeyouridentifica" ], 1, 1 );
    }
    
    if ( isdefined( level.officer ) )
    {
        level.officer say_team( level.vo.major_aggro deck_draw(), 0, 1 );
    }
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x7e60
// Size: 0x25
function function_4f631b41706e6270()
{
    level.laswell say_team( "dx_sp_jmlb_glob_lasw_hesdown", 1, 0.5, 1, 0.4 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x7e8d
// Size: 0x14d
function function_4330f0ff1be9a2b()
{
    if ( isdefined( level.vo.var_c7784938489c22bb ) == 0 )
    {
        level.vo.var_c7784938489c22bb = create_deck( [ "dx_sp_jmlb_entr_niko_yurisaidhedbeinastor", "dx_sp_jmlb_entr_niko_laswellyuriisinthest" ], 1, 1 );
    }
    
    thread function_1c11a2950dae76a7( 0, 0.15 );
    flag_wait( "vo_blocking_clear" );
    level.laswell say_team( "dx_sp_jmlb_entr_lasw_imin", 1 );
    thread function_1c11a2950dae76a7( 0.5, 0.15 );
    flag_wait( "vo_blocking_clear" );
    level.nik say_team( level.vo.var_c7784938489c22bb deck_draw(), 1 );
    yuri_struct = getstruct( "obj_yuri_meet", "targetname" );
    thread function_1c11a2950dae76a7( 0.6, 0.15 );
    flag_wait( "vo_blocking_clear" );
    var_4bb70fcfe28df803 = distance_2d_squared( level.player.origin, yuri_struct.origin );
    
    if ( var_4bb70fcfe28df803 > 40000 )
    {
        level.laswell say_team( "dx_sp_jmlb_entr_lasw_downthehallrightofth", 1 );
    }
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x7fe2
// Size: 0x134
function function_3f9c9aafcd751ff1()
{
    level endon( "game_ended" );
    level endon( "obj_yuri_completed" );
    
    if ( isdefined( level.vo.var_c79b353848c23e77 ) == 0 )
    {
        level.vo.var_c79b353848c23e77 = create_deck( [ "dx_sp_jmlb_entr_niko_laswellyuriwaitingan", "dx_sp_jmlb_entr_niko_yurisaysheswaitingho", "dx_sp_jmlb_entr_niko_laswellwhatsyourstat" ], 1, 1 );
    }
    
    yuri_struct = getstruct( "obj_yuri_meet", "targetname" );
    delay = growing_delay( 10, 30, 3 );
    wait 10;
    
    while ( !flag( "obj_yuri_completed" ) )
    {
        if ( function_e9e38931019c791f() == 1 )
        {
            wait 0.5;
        }
        else if ( isdefined( yuri_struct ) && distance_2d_squared( level.player.origin, yuri_struct.origin ) > 22500 )
        {
            result = level.nik say_team( level.vo.var_c79b353848c23e77 deck_draw(), 0, 0 );
            
            if ( istrue( result ) )
            {
                waitfor( delay );
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x811e
// Size: 0x8a
function function_b8d0983186d43b3e()
{
    if ( isdefined( level.vo.var_210c5c962c98bd48 ) == 0 )
    {
        level.vo.var_210c5c962c98bd48 = create_deck( [ "dx_sp_jmlb_entr_lasw_founditgoinin", "dx_sp_jmlb_entr_lasw_gotit", "dx_sp_jmlb_entr_lasw_makinentry", "dx_sp_jmlb_entr_lasw_imtherenikout" ], 1, 1 );
    }
    
    level.laswell say_team( level.vo.var_210c5c962c98bd48 deck_draw(), 1, 0 );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1
// Checksum 0x0, Offset: 0x81b0
// Size: 0x1b4
function function_cf05aa10a12bd83f( ent )
{
    if ( isdefined( level.vo ) == 0 || flag( "flag_alarm" ) || isdefined( ent.var_26da7b43424980b5 ) && time_has_passed( ent.var_26da7b43424980b5, 6 ) == 0 )
    {
        return;
    }
    
    ent.var_26da7b43424980b5 = gettime();
    
    if ( flag( "vo_suppress_suspicion" ) == 0 )
    {
        level.vo.var_26da7b43424980b5 = gettime();
    }
    
    result = undefined;
    
    if ( isdefined( level.officer ) && ent == level.officer )
    {
        function_26981e4b4ad3721a();
    }
    else
    {
        gender = function_42a9e539b0cbbee0( ent );
        
        switch ( gender )
        {
            case #"hash_c7395e92a00f64d9":
                result = function_621105878e7ae9f4( ent );
                break;
            case #"hash_c7395b92a00f6020":
                result = function_621108878e7af08d( ent );
                break;
            case #"hash_e08bb8fa24531464":
                result = function_3bba07c2594fe475( ent );
                break;
            case #"hash_e08bbbfa2453191d":
                result = function_3bba04c2594fdddc( ent );
                break;
            default:
                break;
        }
    }
    
    if ( function_bdd7b496380aa8e3( ent, 1, 1 ) )
    {
        return;
    }
    
    if ( istrue( result ) )
    {
        wait 0.4;
        
        if ( isdefined( level.player.last_weapon_fire_time ) && time_has_passed( level.player.last_weapon_fire_time, 5 ) == 0 )
        {
            return;
        }
        
        if ( flag( "vo_suppress_suspicion" ) == 0 )
        {
            thread function_4c9de23a4ed31bac();
        }
    }
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x836c
// Size: 0xa4
function private function_621105878e7ae9f4( ent )
{
    if ( isdefined( level.vo.var_f10d867ecbfcbdee ) == 0 )
    {
        level.vo.var_f10d867ecbfcbdee = create_deck( [ "dx_sp_jmlb_icdm_rf01_shesunfamiliar", "dx_sp_jmlb_icdm_rf01_haventseenher", "dx_sp_jmlb_icdm_rf01_neverseenherbefore", "dx_sp_jmlb_icdm_rf01_whosthat", "dx_sp_jmlb_icdm_rf01_idontknowher", "dx_sp_jmlb_icdm_rf01_whoisthat" ], 1, 1 );
    }
    
    return ent say( level.vo.var_f10d867ecbfcbdee deck_draw(), 1, 0, 1, 0, "self" );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x8419
// Size: 0xa4
function private function_621108878e7af08d( ent )
{
    if ( isdefined( level.vo.var_f10d857ecbfcbbbb ) == 0 )
    {
        level.vo.var_f10d857ecbfcbbbb = create_deck( [ "dx_sp_jmlb_icdm_rf02_shesunfamiliar", "dx_sp_jmlb_icdm_rf02_haventseenher", "dx_sp_jmlb_icdm_rf02_neverseenherbefore", "dx_sp_jmlb_icdm_rf02_whosthat", "dx_sp_jmlb_icdm_rf02_idontknowher", "dx_sp_jmlb_icdm_rf02_whoisthat" ], 1, 1 );
    }
    
    return ent say( level.vo.var_f10d857ecbfcbbbb deck_draw(), 1, 0, 1, 0, "self" );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x84c6
// Size: 0xa4
function private function_3bba07c2594fe475( ent )
{
    if ( isdefined( level.vo.var_250e1119461635e3 ) == 0 )
    {
        level.vo.var_250e1119461635e3 = create_deck( [ "dx_sp_jmlb_icdm_ru01_shesunfamiliar", "dx_sp_jmlb_icdm_ru01_haventseenher", "dx_sp_jmlb_icdm_ru01_neverseenherbefore", "dx_sp_jmlb_icdm_ru01_whosthat", "dx_sp_jmlb_icdm_ru01_idontknowher", "dx_sp_jmlb_icdm_ru01_whoisthat" ], 1, 1 );
    }
    
    return ent say( level.vo.var_250e1119461635e3 deck_draw(), 1, 0, 1, 0, "self" );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x8573
// Size: 0xa4
function private function_3bba04c2594fdddc( ent )
{
    if ( isdefined( level.vo.var_250e121946163816 ) == 0 )
    {
        level.vo.var_250e121946163816 = create_deck( [ "dx_sp_jmlb_icdm_ru02_shesunfamiliar", "dx_sp_jmlb_icdm_ru02_haventseenher", "dx_sp_jmlb_icdm_ru02_neverseenherbefore", "dx_sp_jmlb_icdm_ru02_whosthat", "dx_sp_jmlb_icdm_ru02_idontknowher", "dx_sp_jmlb_icdm_ru02_whoisthat" ], 1, 1 );
    }
    
    return ent say( level.vo.var_250e121946163816 deck_draw(), 1, 0, 1, 0, "self" );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1
// Checksum 0x0, Offset: 0x8620
// Size: 0x100
function function_d02f2011fc113e3c( ent )
{
    level endon( "game_ended" );
    flag_set( "confrontation_vo_playing" );
    gender = function_42a9e539b0cbbee0( ent );
    
    switch ( gender )
    {
        case #"hash_c7395e92a00f64d9":
            function_18752e4f494dcc1e( ent );
            break;
        case #"hash_c7395b92a00f6020":
            function_18752d4f494dc9eb( ent );
            break;
        case #"hash_e08bb8fa24531464":
            function_144ef1320016a093( ent );
            break;
        case #"hash_e08bbbfa2453191d":
            function_144ef2320016a2c6( ent );
            break;
        default:
            break;
    }
    
    level.vo.var_86838cbbb9e37b5c = gettime();
    
    if ( function_bdd7b496380aa8e3( ent, 1 ) == 0 )
    {
        thread vo_spotted();
    }
    
    wait 5;
    
    if ( time_has_passed( level.vo.var_86838cbbb9e37b5c, 4 ) )
    {
        flag_clear( "confrontation_vo_playing" );
    }
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x8728
// Size: 0xa5
function private function_18752e4f494dcc1e( ent )
{
    if ( isdefined( level.vo.var_b0b5435b89724e5c ) == 0 )
    {
        level.vo.var_b0b5435b89724e5c = create_deck( [ "dx_sp_jmlb_icdm_rf01_heystoprightthere", "dx_sp_jmlb_icdm_rf01_showmeyourid", "dx_sp_jmlb_icdm_rf01_youcomehere", "dx_sp_jmlb_icdm_rf01_showyouridentificati", "dx_sp_jmlb_icdm_rf01_stopshowyourid", "dx_sp_jmlb_icdm_rf01_comehererightnow" ], 1, 1 );
    }
    
    ent say( level.vo.var_b0b5435b89724e5c deck_draw(), 1, 0, 1, 0, "self" );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x87d5
// Size: 0xa5
function private function_18752d4f494dc9eb( ent )
{
    if ( isdefined( level.vo.var_b0b5465b897254f5 ) == 0 )
    {
        level.vo.var_b0b5465b897254f5 = create_deck( [ "dx_sp_jmlb_icdm_rf02_heystoprightthere", "dx_sp_jmlb_icdm_rf02_showmeyourid", "dx_sp_jmlb_icdm_rf02_youcomehere", "dx_sp_jmlb_icdm_rf02_showyouridentificati", "dx_sp_jmlb_icdm_rf02_stopshowyourid", "dx_sp_jmlb_icdm_rf02_comehererightnow" ], 1, 1 );
    }
    
    ent say( level.vo.var_b0b5465b897254f5 deck_draw(), 1, 0, 1, 0, "self" );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x8882
// Size: 0xa5
function private function_144ef1320016a093( ent )
{
    if ( isdefined( level.vo.var_becba6d5380bfbdd ) == 0 )
    {
        level.vo.var_becba6d5380bfbdd = create_deck( [ "dx_sp_jmlb_icdm_ru01_heystoprightthere", "dx_sp_jmlb_icdm_ru01_showmeyourid", "dx_sp_jmlb_icdm_ru01_youcomehere", "dx_sp_jmlb_icdm_ru01_showyouridentificati", "dx_sp_jmlb_icdm_ru01_stopshowyourid", "dx_sp_jmlb_icdm_ru01_comehererightnow" ], 1, 1 );
    }
    
    ent say( level.vo.var_becba6d5380bfbdd deck_draw(), 1, 0, 1, 0, "self" );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x892f
// Size: 0xa5
function private function_144ef2320016a2c6( ent )
{
    if ( isdefined( level.vo.var_becba3d5380bf544 ) == 0 )
    {
        level.vo.var_becba3d5380bf544 = create_deck( [ "dx_sp_jmlb_icdm_ru02_heystoprightthere", "dx_sp_jmlb_icdm_ru02_showmeyourid", "dx_sp_jmlb_icdm_ru02_youcomehere", "dx_sp_jmlb_icdm_ru02_showyouridentificati", "dx_sp_jmlb_icdm_ru02_stopshowyourid", "dx_sp_jmlb_icdm_ru02_comehererightnow" ], 1, 1 );
    }
    
    ent say( level.vo.var_becba3d5380bf544 deck_draw(), 1, 0, 1, 0, "self" );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x89dc
// Size: 0x103, Type: bool
function private function_3da7d0ca9612546a( ent1, ent2, distance )
{
    if ( flag( "flag_alarm" ) || ent1 getthreatsight( level.player ) > 0.1 || ent2 getthreatsight( level.player ) > 0.1 || level.player function_6c31b0b0edd184ed( [ level.laswell, level.nik ], 1 ) )
    {
        return false;
    }
    
    var_91df0db5f21b5479 = distance * distance;
    
    if ( flag( "vo_conversation_playing" ) == 0 && ( distance_2d_squared( ent1.origin, level.player.origin ) < var_91df0db5f21b5479 || distance_2d_squared( ent2.origin, level.player.origin ) < var_91df0db5f21b5479 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 5
// Checksum 0x0, Offset: 0x8ae8
// Size: 0x25d
function function_9f6a778d1cac0ad3( var_7c3fd0c3070f11dc, var_7c3fd3c3070f1875, conversation, mindistance, maxdistance )
{
    level endon( "game_ended" );
    maxdistance = default_to( maxdistance, 200 );
    mindistance = default_to( mindistance, 50 );
    
    if ( isdefined( var_7c3fd0c3070f11dc ) == 0 || isdefined( var_7c3fd3c3070f1875 ) == 0 || isdefined( conversation ) == 0 || isarray( conversation ) == 0 )
    {
        return;
    }
    
    ent1 = undefined;
    ent2 = undefined;
    
    while ( isdefined( ent1 ) == 0 && isdefined( ent2 ) == 0 )
    {
        if ( isdefined( ent1 ) == 0 )
        {
            ent1 = getent( var_7c3fd0c3070f11dc, "script_noteworthy" );
        }
        
        if ( isdefined( ent2 ) == 0 )
        {
            ent2 = getent( var_7c3fd3c3070f1875, "script_noteworthy" );
        }
        
        wait 3;
    }
    
    ActualDistance = randomint( maxdistance - mindistance ) + mindistance;
    
    while ( true )
    {
        if ( isdefined( ent1 ) == 0 || isdefined( ent2 ) == 0 )
        {
            return;
        }
        else if ( isalive( ent1 ) == 0 || isalive( ent2 ) == 0 )
        {
            return;
        }
        
        if ( function_3da7d0ca9612546a( ent1, ent2, ActualDistance ) )
        {
            break;
        }
        
        wait 1;
    }
    
    flag_set( "vo_conversation_playing" );
    wait randomfloat( 4 );
    
    if ( function_810716cd17f8dabb( [ ent1, ent2 ] ) == 0 )
    {
        return;
    }
    
    ent1 say( conversation[ 0 ], 0.5, 1 );
    wait 1.3;
    
    if ( function_810716cd17f8dabb( [ ent1, ent2 ] ) == 0 )
    {
        return;
    }
    
    ent2 say( conversation[ 1 ], 0.5, 1 );
    wait 1.1;
    
    if ( function_810716cd17f8dabb( [ ent1, ent2 ] ) == 0 )
    {
        return;
    }
    
    ent1 say( conversation[ 2 ], 0.5, 1 );
    wait 1.4;
    
    if ( function_810716cd17f8dabb( [ ent1, ent2 ] ) == 0 )
    {
        return;
    }
    
    ent2 say( conversation[ 3 ], 0.5, 1 );
    wait 1;
    
    if ( function_810716cd17f8dabb( [ ent1, ent2 ] ) == 0 )
    {
        return;
    }
    
    ent1 say( conversation[ 4 ], 0.5, 1 );
    wait 1.5;
    
    if ( function_810716cd17f8dabb( [ ent1, ent2 ] ) == 0 )
    {
        return;
    }
    
    ent2 say( conversation[ 5 ], 0.5, 1 );
    wait randomfloat( 3 );
    flag_clear( "vo_conversation_playing" );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 0
// Checksum 0x0, Offset: 0x8d4d
// Size: 0x67b
function function_b847acce90b82260()
{
    sequence = [ "dx_sp_jmlb_icdm_rf01_howisthereportcoming", "dx_sp_jmlb_icdm_ru01_stillworkingonit", "dx_sp_jmlb_icdm_rf01_whatstakingsolong", "dx_sp_jmlb_icdm_ru01_everyonesheldupwitht", "dx_sp_jmlb_icdm_rf01_thatsnotanexcusewhen", "dx_sp_jmlb_icdm_ru01_tomorrowmorningatthe" ];
    thread function_9f6a778d1cac0ad3( "ai_grp10_1", "ai_grp10_2", sequence, 250, 275 );
    sequence = [ "dx_sp_jmlb_icdm_ru01_anything", "dx_sp_jmlb_icdm_ru02_negative", "dx_sp_jmlb_icdm_ru01_guesswellcheckwithth", "dx_sp_jmlb_icdm_ru02_thatmightbetoolate", "dx_sp_jmlb_icdm_ru01_everyoneisexceptiona", "dx_sp_jmlb_icdm_ru02_tobeexpectedwehaveim" ];
    thread function_9f6a778d1cac0ad3( "ai_grp5_1", "ai_grp5_2", sequence, 275, 375 );
    sequence = [ "dx_sp_jmlb_icdm_rf02_howlongdoyouthinkthi", "dx_sp_jmlb_icdm_ru02_coupleofhoursperhaps", "dx_sp_jmlb_icdm_rf02_ineedthemtoreviewthe", "dx_sp_jmlb_icdm_ru02_shalliaskthemtomeetw", "dx_sp_jmlb_icdm_rf02_yesicantmoveforwardw", "dx_sp_jmlb_icdm_ru02_understood" ];
    thread function_9f6a778d1cac0ad3( "ai_grp9_1", "ai_grp9_2", sequence, 250, 300 );
    sequence = [ "dx_sp_jmlb_icdm_ru02_seeanything", "dx_sp_jmlb_icdm_ru01_allisquiet", "dx_sp_jmlb_icdm_ru02_oneneverknowswithour", "dx_sp_jmlb_icdm_ru01_wevebeeninconstantco", "dx_sp_jmlb_icdm_ru02_iwouldexpectnothingl", "dx_sp_jmlb_icdm_ru01_arklovrunslikeclockw" ];
    thread function_9f6a778d1cac0ad3( "ai_grp2_1", "ai_grp2_2", sequence, 250, 325 );
    sequence = [ level.var_113bbae53e90f5a5, 0, "dx_sp_jmlb_icdm_ru01_howwedoingonscheduli", level.var_113bb7e53e90ef0c, 0, "dx_sp_jmlb_icdm_ru02_everythingslockedin", level.var_113bbae53e90f5a5, 0, "dx_sp_jmlb_icdm_ru01_andyoufinishedthepap", level.var_113bb7e53e90ef0c, 0, "dx_sp_jmlb_icdm_ru02_justmomentsago", level.var_113bbae53e90f5a5, 0, "dx_sp_jmlb_icdm_ru01_bringitbymyofficeand", level.var_113bb7e53e90ef0c, 0, "dx_sp_jmlb_icdm_ru02_willdo" ];
    sequence = [ level.var_7240e483156a1d55, 0, "dx_sp_jmlb_icdm_rf02_hearanythingaboutthe", level.var_113bbae53e90f5a5, 0, "dx_sp_jmlb_icdm_ru01_notyetitsmeanttobeco", level.var_7240e483156a1d55, 0, "dx_sp_jmlb_icdm_rf02_whatdidtheythinkofth", level.var_113bbae53e90f5a5, 0, "dx_sp_jmlb_icdm_ru01_wellfindoutsoon", level.var_7240e483156a1d55, 0, "dx_sp_jmlb_icdm_rf02_thiscouldbeagreatopp", level.var_113bbae53e90f5a5, 0, "dx_sp_jmlb_icdm_ru01_agreed" ];
    sequence = [ level.var_113bb7e53e90ef0c, 0, "dx_sp_jmlb_icdm_ru02_hasthedelegationarri", level.var_113bbae53e90f5a5, 0, "dx_sp_jmlb_icdm_ru01_yestheyaremeetingwit", level.var_113bb7e53e90ef0c, 0, "dx_sp_jmlb_icdm_ru02_doescommandneedassis", level.var_113bbae53e90f5a5, 0, "dx_sp_jmlb_icdm_ru01_notcurrentlybutberea", level.var_113bb7e53e90ef0c, 0, "dx_sp_jmlb_icdm_ru02_ofcourse", level.var_113bbae53e90f5a5, 0, "dx_sp_jmlb_icdm_ru01_wellcheckwithyouonth" ];
    sequence = [ level.var_7240e183156a16bc, 0, "dx_sp_jmlb_icdm_rf01_gotmorehelosin", level.var_113bbae53e90f5a5, 0, "dx_sp_jmlb_icdm_ru01_isawjustyesterday", level.var_113bb7e53e90ef0c, 0, "dx_sp_jmlb_icdm_ru02_weretheypresentedtoo", level.var_7240e183156a16bc, 0, "dx_sp_jmlb_icdm_rf01_yestheywerequietplea", level.var_113bbae53e90f5a5, 0, "dx_sp_jmlb_icdm_ru01_thatsgoodtohear", level.var_113bb7e53e90ef0c, 0, "dx_sp_jmlb_icdm_ru02_lookforwardtoseeingt" ];
    sequence = [ level.var_7240e483156a1d55, 0, "dx_sp_jmlb_icdm_rf02_thatllbetheday", level.var_7240e183156a16bc, 0, "dx_sp_jmlb_icdm_rf01_yougoodonwater", level.var_7240e483156a1d55, 0, "dx_sp_jmlb_icdm_rf02_runninglowtodaysmarc", level.var_7240e183156a16bc, 0, "dx_sp_jmlb_icdm_rf01_youshouldgrabsomemor", level.var_7240e483156a1d55, 0, "dx_sp_jmlb_icdm_rf02_imokay", level.var_7240e183156a16bc, 0, "dx_sp_jmlb_icdm_rf01_betterbeimnotcarryin" ];
    sequence = [ level.var_7240e183156a16bc, 0, "dx_sp_jmlb_icdm_rf01_thepaperworkneedstob", level.var_113bbae53e90f5a5, 0, "dx_sp_jmlb_icdm_ru01_alreadydone", level.var_113bb7e53e90ef0c, 0, "dx_sp_jmlb_icdm_ru02_hopefullywehearbackb", level.var_7240e183156a16bc, 0, "dx_sp_jmlb_icdm_rf01_wouldntcountonit", level.var_113bbae53e90f5a5, 0, "dx_sp_jmlb_icdm_ru01_yeahtheyrebusywithth", level.var_113bb7e53e90ef0c, 0, "dx_sp_jmlb_icdm_ru02_havetomakeagoodimpre" ];
    sequence = [ level.var_113bbae53e90f5a5, 0, "dx_sp_jmlb_icdm_ru01_gotanupdatedcompanys", level.var_7240e483156a1d55, 0, "dx_sp_jmlb_icdm_rf02_niceandbcompany", level.var_113bb7e53e90ef0c, 0, "dx_sp_jmlb_icdm_ru02_0400tomorrow", level.var_113bbae53e90f5a5, 0, "dx_sp_jmlb_icdm_ru01_feelliketheyvebeengo", level.var_7240e483156a1d55, 0, "dx_sp_jmlb_icdm_rf02_trainingisbrutal", level.var_113bb7e53e90ef0c, 0, "dx_sp_jmlb_icdm_ru02_itsmeanttobe" ];
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1
// Checksum 0x0, Offset: 0x93d0
// Size: 0x141
function function_e8e5d930e0f830c7( ent )
{
    if ( isdefined( level.vo.var_a1395ef416be4149 ) )
    {
        level.vo.var_a1395ef416be4149 += randomint( 3 ) + 2;
        
        if ( level.vo.var_a1395ef416be4149 >= 5 )
        {
            level.vo.var_a1395ef416be4149 = 0;
            return;
        }
    }
    else
    {
        level.vo.var_a1395ef416be4149 = 0;
    }
    
    wait randomfloat( 3 ) + 0.5;
    gender = function_42a9e539b0cbbee0( ent );
    
    switch ( gender )
    {
        case #"hash_c7395e92a00f64d9":
            level thread function_e6406eb4a12876ac( ent );
            break;
        case #"hash_c7395b92a00f6020":
            level thread function_e64071b4a1287d45( ent );
            break;
        case #"hash_e08bb8fa24531464":
            level thread function_f2434223d82c812d( ent );
            break;
        case #"hash_e08bbbfa2453191d":
            level thread function_f2433f23d82c7a94( ent );
            break;
        default:
            level thread function_f2434223d82c812d( ent );
            break;
    }
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x9519
// Size: 0xac
function private function_e6406eb4a12876ac( ent )
{
    if ( isdefined( level.vo.var_b6375eff15dff092 ) == 0 )
    {
        level.vo.var_b6375eff15dff092 = create_deck( [ "dx_sp_jmlb_icdm_rf01_letusin", "dx_sp_jmlb_icdm_rf01_itburns", "dx_sp_jmlb_icdm_rf01_openthedoor", "dx_sp_jmlb_icdm_rf01_weregoingtodieouther", "dx_sp_jmlb_icdm_rf01_helpus", "dx_sp_jmlb_icdm_rf01_cantbreathe", "dx_sp_jmlb_icdm_rf01_weneedtogetinside", "dx_sp_jmlb_icdm_rf01_letusinside" ], 1, 1 );
    }
    
    ent say( level.vo.var_b6375eff15dff092 deck_draw() );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x95cd
// Size: 0xac
function private function_e64071b4a1287d45( ent )
{
    if ( isdefined( level.vo.var_b6375dff15dfee5f ) == 0 )
    {
        level.vo.var_b6375dff15dfee5f = create_deck( [ "dx_sp_jmlb_icdm_rf02_letusin", "dx_sp_jmlb_icdm_rf02_itburns", "dx_sp_jmlb_icdm_rf02_openthedoor", "dx_sp_jmlb_icdm_rf02_weregoingtodieouther", "dx_sp_jmlb_icdm_rf02_helpus", "dx_sp_jmlb_icdm_rf02_cantbreathe", "dx_sp_jmlb_icdm_rf02_weneedtogetinside", "dx_sp_jmlb_icdm_rf02_letusinside" ], 1, 1 );
    }
    
    ent say( level.vo.var_b6375dff15dfee5f deck_draw() );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x9681
// Size: 0xac
function private function_f2434223d82c812d( ent )
{
    if ( isdefined( level.vo.var_c31bc28afbe976e7 ) == 0 )
    {
        level.vo.var_c31bc28afbe976e7 = create_deck( [ "dx_sp_jmlb_icdm_ru01_letusin", "dx_sp_jmlb_icdm_ru01_itburns", "dx_sp_jmlb_icdm_ru01_openthedoor", "dx_sp_jmlb_icdm_ru01_weregoingtodieouther", "dx_sp_jmlb_icdm_ru01_helpus", "dx_sp_jmlb_icdm_ru01_cantbreathe", "dx_sp_jmlb_icdm_ru01_weneedtogetinside", "dx_sp_jmlb_icdm_ru01_letusinside" ], 1, 1 );
    }
    
    ent say( level.vo.var_c31bc28afbe976e7 deck_draw() );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x9735
// Size: 0xac
function private function_f2433f23d82c7a94( ent )
{
    if ( isdefined( level.vo.var_c31bc38afbe9791a ) == 0 )
    {
        level.vo.var_c31bc38afbe9791a = create_deck( [ "dx_sp_jmlb_icdm_ru02_letusin", "dx_sp_jmlb_icdm_ru02_itburns", "dx_sp_jmlb_icdm_ru02_openthedoor", "dx_sp_jmlb_icdm_ru02_weregoingtodieouther", "dx_sp_jmlb_icdm_ru02_helpus", "dx_sp_jmlb_icdm_ru02_cantbreathe", "dx_sp_jmlb_icdm_ru02_weneedtogetinside", "dx_sp_jmlb_icdm_ru02_letusinside" ], 1, 1 );
    }
    
    ent say( level.vo.var_c31bc38afbe9791a deck_draw() );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1
// Checksum 0x0, Offset: 0x97e9
// Size: 0xc9
function function_7c056844333ddb9d( ent )
{
    if ( istrue( ent.var_301447e919c423db ) )
    {
        return;
    }
    
    ent.var_301447e919c423db = 1;
    ent stop_dialogue();
    gender = function_42a9e539b0cbbee0( ent );
    
    switch ( gender )
    {
        case #"hash_c7395e92a00f64d9":
            level thread function_76444f96cc4dc14a( ent );
            break;
        case #"hash_c7395b92a00f6020":
            level thread function_76444e96cc4dbf17( ent );
            break;
        case #"hash_e08bb8fa24531464":
            level thread function_cb2225ff5becb75f( ent );
            break;
        case #"hash_e08bbbfa2453191d":
            level thread function_cb2226ff5becb992( ent );
            break;
        default:
            level thread function_cb2225ff5becb75f( ent );
            break;
    }
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x98ba
// Size: 0xbd
function private function_76444f96cc4dc14a( ent )
{
    if ( isdefined( level.vo.var_76a7431d315cab54 ) == 0 )
    {
        level.vo.var_76a7431d315cab54 = create_deck( [ "dx_sp_jmlb_icdm_rf01_weregoingtodie", "dx_sp_jmlb_icdm_rf01_needamask", "dx_sp_jmlb_icdm_rf01_mylungsburn", "dx_sp_jmlb_icdm_rf01_needtogetoutofhere", "dx_sp_jmlb_icdm_rf01_notgoingtomakeit", "dx_sp_jmlb_icdm_rf01_imscared", "dx_sp_jmlb_icdm_rf01_thegasiseverywhere", "dx_sp_jmlb_icdm_rf01_help", "dx_sp_jmlb_icdm_rf01_whatdowedo", "dx_sp_jmlb_icdm_rf01_ithurts" ], 1, 1 );
    }
    
    return ent say( level.vo.var_76a7431d315cab54 deck_draw() );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x9980
// Size: 0xbd
function private function_76444e96cc4dbf17( ent )
{
    if ( isdefined( level.vo.var_76a7461d315cb1ed ) == 0 )
    {
        level.vo.var_76a7461d315cb1ed = create_deck( [ "dx_sp_jmlb_icdm_rf02_weregoingtodie", "dx_sp_jmlb_icdm_rf02_needamask", "dx_sp_jmlb_icdm_rf02_mylungsburn", "dx_sp_jmlb_icdm_rf02_needtogetoutofhere", "dx_sp_jmlb_icdm_rf02_notgoingtomakeit", "dx_sp_jmlb_icdm_rf02_imscared", "dx_sp_jmlb_icdm_rf02_thegasiseverywhere", "dx_sp_jmlb_icdm_rf02_help", "dx_sp_jmlb_icdm_rf02_whatdowedo", "dx_sp_jmlb_icdm_rf02_ithurts" ], 1, 1 );
    }
    
    return ent say( level.vo.var_76a7461d315cb1ed deck_draw() );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x9a46
// Size: 0xbd
function private function_cb2225ff5becb75f( ent )
{
    if ( isdefined( level.vo.var_471a4840371bacd5 ) == 0 )
    {
        level.vo.var_471a4840371bacd5 = create_deck( [ "dx_sp_jmlb_icdm_ru01_weregoingtodie", "dx_sp_jmlb_icdm_ru01_needamask", "dx_sp_jmlb_icdm_ru01_mylungsburn", "dx_sp_jmlb_icdm_ru01_needtogetoutofhere", "dx_sp_jmlb_icdm_ru01_notgoingtomakeit", "dx_sp_jmlb_icdm_ru01_imscared", "dx_sp_jmlb_icdm_ru01_thegasiseverywhere", "dx_sp_jmlb_icdm_ru01_help", "dx_sp_jmlb_icdm_ru01_whatdowedo", "dx_sp_jmlb_icdm_ru01_ithurts" ], 1, 1 );
    }
    
    return ent say( level.vo.var_471a4840371bacd5 deck_draw() );
}

// Namespace namespace_e494424f3a96e848 / namespace_368694a19653433
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x9b0c
// Size: 0xbd
function private function_cb2226ff5becb992( ent )
{
    if ( isdefined( level.vo.var_471a4540371ba63c ) == 0 )
    {
        level.vo.var_471a4540371ba63c = create_deck( [ "dx_sp_jmlb_icdm_ru02_weregoingtodie", "dx_sp_jmlb_icdm_ru02_needamask", "dx_sp_jmlb_icdm_ru02_mylungsburn", "dx_sp_jmlb_icdm_ru02_needtogetoutofhere", "dx_sp_jmlb_icdm_ru02_notgoingtomakeit", "dx_sp_jmlb_icdm_ru02_imscared", "dx_sp_jmlb_icdm_ru02_thegasiseverywhere", "dx_sp_jmlb_icdm_ru02_help", "dx_sp_jmlb_icdm_ru02_whatdowedo", "dx_sp_jmlb_icdm_ru02_ithurts" ], 1, 1 );
    }
    
    return ent say( level.vo.var_471a4540371ba63c deck_draw() );
}

