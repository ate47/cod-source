#using script_3ed005fe9b78b9da;
#using scripts\common\callbacks;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\hud_util;
#using scripts\mp\supers\super_emp_pulse;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;

#namespace namespace_e9bdd7488df43871;

// Namespace namespace_e9bdd7488df43871 / namespace_e5b8d54a860243e8
// Params 0
// Checksum 0x0, Offset: 0x2b2
// Size: 0x76
function function_c9af900a7b02e1()
{
    cooldowntime = getdvarfloat( @"hash_27e50976961fc819", 20 );
    addpowerbutton( self, "gas", "+smoke", &function_3287e064cd7027f, 0, &function_395d3f84bc2aa867, &function_95863013475ad0e9, &function_395d3f84bc2aa867, &"MP_ZXP/GAS_GRENADE", undefined, 10, "gasGrenadeStatus", "gasGrenadeProgress" );
    self.powers[ "gas" ].istactical = 1;
}

// Namespace namespace_e9bdd7488df43871 / namespace_e5b8d54a860243e8
// Params 0
// Checksum 0x0, Offset: 0x330
// Size: 0x76
function function_227f2863eee9ec43()
{
    cooldowntime = getdvarfloat( @"hash_b354e314c0b6260c", 20 );
    addpowerbutton( self, "gas", "+smoke", &function_3287e064cd7027f, 0, &function_f84d275bd74b89e7, &function_95863013475ad0e9, &function_f84d275bd74b89e7, &"MP_ZXP/GAS_GRENADE", undefined, 10, "gasGrenadeStatus", "gasGrenadeProgress" );
    self.powers[ "gas" ].istactical = 1;
}

// Namespace namespace_e9bdd7488df43871 / namespace_e5b8d54a860243e8
// Params 0
// Checksum 0x0, Offset: 0x3ae
// Size: 0x87
function function_71a5bfdc64379827()
{
    cooldowntime = getdvarfloat( @"hash_3b2d36b2285f2a11", 5.5 );
    addpowerbutton( self, "gas", "+smoke", &function_3287e064cd7027f, 0, &function_3087dfdc74003c67, &function_95863013475ad0e9, &function_3087dfdc74003c67, &"MP_ZXP/GAS_GRENADE", undefined, cooldowntime, "gasGrenadeStatus", "gasGrenadeProgress" );
    self.powers[ "gas" ].istactical = 1;
    level callback::add( "player_connect", &function_658882aab2ec5fb2 );
}

// Namespace namespace_e9bdd7488df43871 / namespace_e5b8d54a860243e8
// Params 2
// Checksum 0x0, Offset: 0x43d
// Size: 0x3f
function function_f84d275bd74b89e7( powerstruct, powerref )
{
    grenade = "equip_smoke";
    scripts\mp\equipment::giveequipment( grenade, "secondary" );
    scripts\mp\equipment::setequipmentslotammo( "secondary", 1 );
}

// Namespace namespace_e9bdd7488df43871 / namespace_e5b8d54a860243e8
// Params 2
// Checksum 0x0, Offset: 0x484
// Size: 0x3f
function function_3087dfdc74003c67( powerstruct, powerref )
{
    grenade = "equip_mutant_emp_ball";
    scripts\mp\equipment::giveequipment( grenade, "secondary" );
    scripts\mp\equipment::setequipmentslotammo( "secondary", 1 );
}

// Namespace namespace_e9bdd7488df43871 / namespace_e5b8d54a860243e8
// Params 2
// Checksum 0x0, Offset: 0x4cb
// Size: 0x3f
function function_395d3f84bc2aa867( powerstruct, powerref )
{
    grenade = "equip_snapshot_grenade";
    scripts\mp\equipment::giveequipment( grenade, "secondary" );
    scripts\mp\equipment::setequipmentslotammo( "secondary", 1 );
}

// Namespace namespace_e9bdd7488df43871 / namespace_e5b8d54a860243e8
// Params 2
// Checksum 0x0, Offset: 0x512
// Size: 0xe5
function function_3287e064cd7027f( powerstruct, powerref )
{
    level endon( "game_ended" );
    self endon( "offhand_end" );
    self endon( "zombie_unset" );
    self endon( "death_or_disconnect" );
    customfunc = powerstruct.powers[ powerref ].var_ad6e547ed6ed5a8c;
    
    if ( isdefined( customfunc ) )
    {
        self [[ customfunc ]]();
        thread function_120695737abd78f4( powerstruct, powerref );
        self notify( "gas_grenade_finished" );
        return;
    }
    
    self waittill( "grenade_fire", grenade, objweapon, tickpercent, originalowner );
    
    if ( !scripts\mp\utility\weapon::grenadethrown( grenade ) )
    {
        return;
    }
    
    self playsound( "zxp_grenade_vo_npc", self, self );
    thread function_e38335c47f60d959( grenade );
    thread function_120695737abd78f4( powerstruct, powerref );
    wait 0.25;
    function_95863013475ad0e9( powerstruct, powerref );
    self notify( "gas_grenade_finished" );
}

// Namespace namespace_e9bdd7488df43871 / namespace_e5b8d54a860243e8
// Params 2
// Checksum 0x0, Offset: 0x5ff
// Size: 0x1f
function function_95863013475ad0e9( powerstruct, powerref )
{
    scripts\mp\equipment::takeequipment( "secondary" );
}

// Namespace namespace_e9bdd7488df43871 / namespace_e5b8d54a860243e8
// Params 2
// Checksum 0x0, Offset: 0x626
// Size: 0x32
function function_8312451ba46e27bd( powerstruct, powerref )
{
    scripts\mp\equipment::giveequipment( "equip_concussion", "secondary" );
    scripts\mp\equipment::setequipmentslotammo( "secondary", 1 );
}

// Namespace namespace_e9bdd7488df43871 / namespace_e5b8d54a860243e8
// Params 2
// Checksum 0x0, Offset: 0x660
// Size: 0x9b
function function_2db4212b6911c09c( powerstruct, powerref )
{
    level endon( "game_ended" );
    self endon( "offhand_end" );
    self endon( "zombie_unset" );
    self endon( "death_or_disconnect" );
    self waittill( "grenade_fire", grenade, objweapon, tickpercent, originalowner );
    
    if ( !scripts\mp\utility\weapon::grenadethrown( grenade ) )
    {
        return;
    }
    
    self playsound( "zxp_grenade_vo_npc", self, self );
    thread function_120695737abd78f4( powerstruct, powerref );
    wait 0.25;
    function_95863013475ad0e9( powerstruct, powerref );
    self notify( "gas_grenade_finished" );
}

// Namespace namespace_e9bdd7488df43871 / namespace_e5b8d54a860243e8
// Params 2
// Checksum 0x0, Offset: 0x703
// Size: 0x1f
function function_567159ca61b10630( powerstruct, powerref )
{
    scripts\mp\equipment::takeequipment( "secondary" );
}

// Namespace namespace_e9bdd7488df43871 / namespace_e5b8d54a860243e8
// Params 1
// Checksum 0x0, Offset: 0x72a
// Size: 0x182
function function_e38335c47f60d959( grenade )
{
    self endon( "disconnect" );
    grenade endon( "explode_end" );
    grenade waittill( "explode", position );
    ents = empdebuff_get_emp_ents( position, 130 );
    objweapon = makeweapon( "jup_mutant_emp_ball" );
    self.var_3ff0b2483ea046e3 = [];
    
    foreach ( ent in ents )
    {
        entowner = ent.owner;
        
        if ( isdefined( entowner ) )
        {
            if ( !playersareenemies( self, entowner ) )
            {
                continue;
            }
        }
        
        data = packdamagedata( self, ent, 1, objweapon, "MOD_EXPLOSIVE", grenade, position );
        thread function_25310643899068a8( data, 4 );
    }
    
    players = getplayersinradius( position, 130 );
    
    foreach ( player in players )
    {
        if ( !function_641436d9bd65f63c( self, player ) )
        {
            continue;
        }
        
        data = packdamagedata( self, player, 1, objweapon, "MOD_EXPLOSIVE", grenade, position );
        thread emppulse_apply_player( data, 4 );
    }
}

// Namespace namespace_e9bdd7488df43871 / namespace_e5b8d54a860243e8
// Params 1
// Checksum 0x0, Offset: 0x8b4
// Size: 0x118
function function_658882aab2ec5fb2( params )
{
    player = self;
    player endon( "disconnect" );
    
    while ( true )
    {
        player waittill( "grenade_thrown", grenade );
        
        if ( isdefined( grenade ) && is_equal( grenade.weapon_name, "jup_mutant_emp_ball" ) )
        {
            team = scripts\mp\utility\game::getotherteam( player.pers[ "team" ] )[ 0 ];
            
            while ( isdefined( grenade ) )
            {
                alive_enemies = scripts\mp\utility\teams::getteamdata( team, "alivePlayers" );
                
                foreach ( enemy in alive_enemies )
                {
                    origin = enemy geteye();
                    
                    if ( isdefined( grenade ) && distance( grenade.origin, origin ) < 56 )
                    {
                        grenade detonate( player );
                    }
                }
                
                waitframe();
            }
        }
    }
}

