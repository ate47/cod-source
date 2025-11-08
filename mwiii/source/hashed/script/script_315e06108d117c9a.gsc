#using script_3ed005fe9b78b9da;
#using scripts\common\values;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#using scripts\mp\teams;
#using scripts\mp\utility\player;

#namespace namespace_53e6020c2a0a0ef5;

// Namespace namespace_53e6020c2a0a0ef5 / namespace_62dabdb9dfdcde8
// Params 0
// Checksum 0x0, Offset: 0x27c
// Size: 0xcf
function function_7ede0aa8434bebd1()
{
    setdvarifuninitialized( @"hash_87a4f2a7a914d095", 500 );
    setdvarifuninitialized( @"hash_c7f5df54fe79caad", 1.1 );
    self detachall();
    
    if ( !is_equal( self.model, "c_jup_mp_dog_08" ) )
    {
        self setmodel( "c_jup_mp_dog_08" );
    }
    
    self setcamerathirdperson( 1 );
    scripts\mp\utility\player::_setsuit( "jup_gamemode_mutation_hellhound" );
    self.headmodel = undefined;
    self disableweaponpickup();
    self disableexecutionattack();
    self disableexecutionvictim();
    thread namespace_579c1620477fc1a::playerzombiepowers();
    self setmovespeedscale( getdvarfloat( @"hash_c7f5df54fe79caad", 1.1 ) );
    function_44f1e42eec9eace1( getdvarint( @"hash_87a4f2a7a914d095", 500 ) );
    function_6181d87f215c5e16( 0 );
    function_b7d6db4ac5457a99();
}

// Namespace namespace_53e6020c2a0a0ef5 / namespace_62dabdb9dfdcde8
// Params 0
// Checksum 0x0, Offset: 0x353
// Size: 0x44
function function_8121c27ec4fdb19d()
{
    setdvarifuninitialized( @"hash_f8986c6c6b486178", 200 );
    thread function_1200ea6976e7bc44();
    thread function_6f25d396bb48b073( "body_c_jup_mp_sierra_17_mutant", "head_c_jup_mp_sierra_17_mutant" );
    function_44f1e42eec9eace1( getdvarint( @"hash_f8986c6c6b486178", 200 ) );
}

// Namespace namespace_53e6020c2a0a0ef5 / namespace_62dabdb9dfdcde8
// Params 0
// Checksum 0x0, Offset: 0x39f
// Size: 0x44
function function_852acf50e7345bc8()
{
    setdvarifuninitialized( @"hash_66ff68aea0ba9bd0", 200 );
    thread function_1200ea6976e7bc44();
    thread function_6f25d396bb48b073( "body_c_jup_mp_echo_17_mutant", "head_c_jup_mp_echo_17_mutant" );
    function_44f1e42eec9eace1( getdvarint( @"hash_66ff68aea0ba9bd0", 200 ) );
}

// Namespace namespace_53e6020c2a0a0ef5 / namespace_62dabdb9dfdcde8
// Params 0
// Checksum 0x0, Offset: 0x3eb
// Size: 0x44
function function_1824541ee1333b93()
{
    setdvarifuninitialized( @"hash_23f91006197528cb", 200 );
    thread function_1200ea6976e7bc44();
    thread function_6f25d396bb48b073( "body_c_jup_mp_november_12_mutant", "head_c_jup_mp_november_12_mutant" );
    function_44f1e42eec9eace1( getdvarint( @"hash_23f91006197528cb", 200 ) );
}

// Namespace namespace_53e6020c2a0a0ef5 / namespace_62dabdb9dfdcde8
// Params 2
// Checksum 0x0, Offset: 0x437
// Size: 0x64
function function_6f25d396bb48b073( body, head )
{
    player = self;
    player setcustomization( body, head );
    bodymodelname = player getcustomizationbody();
    headmodelname = player getcustomizationhead();
    viewmodelname = player getcustomizationviewmodel();
    player scripts\mp\teams::setcharactermodels( body, head, viewmodelname );
}

// Namespace namespace_53e6020c2a0a0ef5 / namespace_62dabdb9dfdcde8
// Params 0
// Checksum 0x0, Offset: 0x4a3
// Size: 0x56
function function_1200ea6976e7bc44()
{
    self setcamerathirdperson( 0 );
    
    if ( isdefined( self.defaultsuit ) )
    {
        scripts\mp\utility\player::_setsuit( self.defaultsuit );
    }
    
    self.nocorpse = undefined;
    self disableweaponpickup();
    function_6181d87f215c5e16( 1 );
    function_b7d6db4ac5457a99();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    thread namespace_579c1620477fc1a::playerzombiepowers();
}

// Namespace namespace_53e6020c2a0a0ef5 / namespace_62dabdb9dfdcde8
// Params 0
// Checksum 0x0, Offset: 0x501
// Size: 0xb9
function function_b7d6db4ac5457a99()
{
    self endon( "death" );
    setdvarifuninitialized( @"hash_5007a522bebbc3d3", 1.2 );
    fistsweapon = makeweapon( "iw9_me_fists_mp" );
    scripts\cp_mp\utility\inventory_utility::_takeweapon( fistsweapon );
    
    if ( callsharedfunc( "escort", "isDogZombie" ) )
    {
        var_e3438b8cb9c2c515 = makeweapon( "iw9_me_fists_mp_zmb_dog" );
    }
    else
    {
        var_e3438b8cb9c2c515 = makeweapon( "iw9_me_fists_mp_mutant" );
    }
    
    scripts\cp_mp\utility\inventory_utility::_giveweapon( var_e3438b8cb9c2c515, undefined, undefined, 1 );
    self setmovespeedscale( getdvarfloat( @"hash_5007a522bebbc3d3", 1.2 ) );
    
    while ( isdefined( self ) && !is_equal( self getcurrentweapon(), var_e3438b8cb9c2c515 ) )
    {
        scripts\cp_mp\utility\inventory_utility::_switchtoweapon( var_e3438b8cb9c2c515 );
        waitframe();
    }
}

// Namespace namespace_53e6020c2a0a0ef5 / namespace_62dabdb9dfdcde8
// Params 0
// Checksum 0x0, Offset: 0x5c2
// Size: 0x2
function function_57cad676a5cbb536()
{
    
}

// Namespace namespace_53e6020c2a0a0ef5 / namespace_62dabdb9dfdcde8
// Params 0
// Checksum 0x0, Offset: 0x5cc
// Size: 0x1f
function function_e7762eb89190b46c()
{
    if ( isdefined( self.defaultsuit ) )
    {
        scripts\mp\utility\player::_setsuit( self.defaultsuit );
    }
}

// Namespace namespace_53e6020c2a0a0ef5 / namespace_62dabdb9dfdcde8
// Params 0
// Checksum 0x0, Offset: 0x5f3
// Size: 0x3b
function function_702b1da0c13a5636()
{
    function_57cad676a5cbb536();
    function_e7762eb89190b46c();
    self setcamerathirdperson( 0 );
    self.nocorpse = undefined;
    self enableweaponpickup();
    self setmovespeedscale( 1 );
    function_44f1e42eec9eace1( 150 );
}

// Namespace namespace_53e6020c2a0a0ef5 / namespace_62dabdb9dfdcde8
// Params 1
// Checksum 0x0, Offset: 0x636
// Size: 0x1f
function function_44f1e42eec9eace1( health )
{
    self.maxhealth = health;
    self.health = health;
}

// Namespace namespace_53e6020c2a0a0ef5 / namespace_62dabdb9dfdcde8
// Params 1
// Checksum 0x0, Offset: 0x65d
// Size: 0xb8
function function_6181d87f215c5e16( bool )
{
    var_eaa450c2baa37089 = "mutant_dog_allow";
    allows = [ "ledgehang", "ladder", "crouch", "prone", "slide", "dtp" ];
    
    foreach ( allow in allows )
    {
        val::set( var_eaa450c2baa37089, allow, bool );
    }
    
    val::set( var_eaa450c2baa37089, "sprint", 1 );
}

