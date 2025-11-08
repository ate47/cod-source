#using scripts\common\utility;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\scriptable_door_utility;
#using scripts\engine\scriptable;
#using scripts\engine\scriptable_door;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\damage;
#using scripts\mp\utility\equipment;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;

#namespace door_barricade;

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 0
// Checksum 0x0, Offset: 0x2c8
// Size: 0x6f
function function_bfeeefe1b4413ef0()
{
    level.var_b73eb86d1d5a19e9 = [];
    precachestring( &"EQUIPMENT_HINTS/DOOR_BARRICADE_CAN_REMOVE" );
    precachestring( &"EQUIPMENT_HINTS/DOOR_BARRICADE_CANNOT_REMOVE" );
    scripts\engine\scriptable_door::function_29ba88e5ce21f3fd( &function_d42196552ddc1a12 );
    scripts\engine\scriptable_door::function_e37078f3d00ef312( &function_20c4d2ad6cf2bed3 );
    scripts\engine\scriptable_door::function_87d7be37d61cbae3( &function_7e1a3b2e2d74be03 );
    scripts\engine\scriptable::scriptable_adddamagedcallback( &function_fa856206e66d1aca );
    level.var_40a4b55961592afe = spawnstruct();
    function_f2f0951e4a6e218c();
    thread function_7b14c1e8b791b520();
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 0
// Checksum 0x0, Offset: 0x33f
// Size: 0xb
function function_23c3d8f2ae91b6c3()
{
    return level.var_40a4b55961592afe;
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 0
// Checksum 0x0, Offset: 0x353
// Size: 0x183
function function_f2f0951e4a6e218c()
{
    leveldata = function_23c3d8f2ae91b6c3();
    leveldata.var_4acc66ea74cdc413 = getdvarint( @"hash_c7e9a5f7f0d6fe87", 1 ) == 1;
    leveldata.uselifetime = getdvarint( @"hash_de33df60fcc33a48", 1 ) == 1;
    leveldata.lifetime = getdvarint( @"hash_e94d386176ea049c", 360 );
    leveldata.var_8a25a7879becda51 = getdvarfloat( @"hash_6c0ae9b78fea9323", 1.4 );
    leveldata.maxhealth = getdvarfloat( @"hash_50c1b3e18786df16", 1000 );
    leveldata.meleedamage = getdvarfloat( @"hash_12cceb48a02504f", leveldata.maxhealth / 3 );
    leveldata.explosivedamage = getdvarfloat( @"hash_e897c5f4d99c77e2", leveldata.maxhealth );
    leveldata.thermitedamage = getdvarfloat( @"hash_f2559412d6f6e7d3", leveldata.maxhealth / 5 );
    leveldata.var_f2f46c25f5851025 = getdvarfloat( @"hash_a418d23e834a23e7", leveldata.maxhealth / 12 );
    leveldata.var_29fdcb922844f7f = getdvarfloat( @"hash_cce29f6632d1c759", 4 );
    leveldata.debugmode = getdvarint( @"hash_4e9d8c4ac5384a14", 1 ) == 1;
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 0
// Checksum 0x0, Offset: 0x4de
// Size: 0x2a
function function_7b14c1e8b791b520()
{
    if ( getdvarint( @"hash_198b319677696c92", 0 ) != 1 )
    {
        return;
    }
    
    while ( true )
    {
        wait 1;
        function_f2f0951e4a6e218c();
    }
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 0
// Checksum 0x0, Offset: 0x510
// Size: 0x11a, Type: bool
function function_2e07802ab9938047()
{
    if ( !function_5d6c66032973087() )
    {
        /#
            if ( function_23c3d8f2ae91b6c3().debugmode )
            {
                iprintlnbold( "<dev string:x1c>" );
            }
        #/
        
        return false;
    }
    
    doorquery = function_4413c6dd67af86bc();
    
    if ( !isdefined( doorquery ) )
    {
        /#
            if ( function_23c3d8f2ae91b6c3().debugmode )
            {
                iprintlnbold( "<dev string:x63>" );
            }
        #/
        
        return false;
    }
    
    var_3be4437913032095 = function_b0a452739651f90( doorquery.primarydoor, 1 );
    
    if ( !var_3be4437913032095 )
    {
        return false;
    }
    
    if ( isdefined( doorquery.secondarydoor ) )
    {
        var_91073ab900319264 = doorquery.doorstatus == "double";
        var_ef956e1beea273d5 = function_b0a452739651f90( doorquery.secondarydoor, var_91073ab900319264 );
        
        if ( !var_ef956e1beea273d5 && var_91073ab900319264 )
        {
            return false;
        }
        
        function_e2fe2dcb469b8151( doorquery.primarydoor, ter_op( var_ef956e1beea273d5, doorquery.secondarydoor, undefined ) );
    }
    else
    {
        function_e2fe2dcb469b8151( doorquery.primarydoor, undefined );
    }
    
    return true;
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 2
// Checksum 0x0, Offset: 0x633
// Size: 0xe5, Type: bool
function function_b0a452739651f90( door, var_cb5da767b979cc7d )
{
    if ( !door scriptabledoorisclosed() )
    {
        /#
            if ( function_23c3d8f2ae91b6c3().debugmode && var_cb5da767b979cc7d )
            {
                iprintlnbold( "<dev string:x9c>" );
            }
        #/
        
        return false;
    }
    
    if ( !door function_76345fed7f6c60cb() )
    {
        if ( door function_839932ee77f36e1c() )
        {
            /#
                if ( function_23c3d8f2ae91b6c3().debugmode && var_cb5da767b979cc7d )
                {
                    iprintlnbold( "<dev string:xc9>" );
                }
            #/
            
            return false;
        }
    }
    else if ( function_20c4d2ad6cf2bed3( door, self, 1 ) )
    {
        /#
            if ( function_23c3d8f2ae91b6c3().debugmode && var_cb5da767b979cc7d )
            {
                iprintlnbold( "<dev string:x109>" );
            }
        #/
        
        return false;
    }
    else
    {
        /#
            if ( function_23c3d8f2ae91b6c3().debugmode && var_cb5da767b979cc7d )
            {
                iprintlnbold( "<dev string:x136>" );
            }
        #/
        
        return false;
    }
    
    return true;
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 2
// Checksum 0x0, Offset: 0x721
// Size: 0x6d
function function_e2fe2dcb469b8151( var_67c2ef0a05674606, var_a68916f113c5beda )
{
    barricade = function_c104f29141976961( var_67c2ef0a05674606, var_a68916f113c5beda );
    var_67c2ef0a05674606 function_a348fed54b7ad2d1( barricade );
    var_67c2ef0a05674606 function_8d35d9ef24e364e3( 1 );
    
    if ( isdefined( var_a68916f113c5beda ) )
    {
        var_a68916f113c5beda function_a348fed54b7ad2d1( barricade );
        var_a68916f113c5beda function_8d35d9ef24e364e3( 1 );
    }
    
    barricade thread function_47de387357a169a0();
    barricade thread function_9d44d1095c5076fc();
    barricade thread function_49c6f1e402dea720();
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 2
// Checksum 0x0, Offset: 0x796
// Size: 0x22e
function function_c104f29141976961( door, secondarydoor )
{
    position = undefined;
    
    if ( !isdefined( secondarydoor ) )
    {
        position = door function_92093a4b887c3bdc();
    }
    else
    {
        position = door function_4903b126f5910cc7();
    }
    
    var_cf6237ce3f49c883 = spawnstruct();
    var_cf6237ce3f49c883.origin = position;
    var_cf6237ce3f49c883.door = door;
    var_cf6237ce3f49c883.owner = self;
    var_cf6237ce3f49c883 function_7f20536248ae1a5c();
    barricade = spawnstruct();
    barricade.origin = position;
    barricade.owner = self;
    barricade.superid = level.superglobals.staticsuperdata[ "super_door_barricade" ].id;
    barricade.door = door;
    barricade.secondarydoor = secondarydoor;
    barricade.maxhealth = function_23c3d8f2ae91b6c3().maxhealth;
    barricade.damagetaken = 0;
    barricade.var_ca026d0b161c5997 = 0;
    barricade.var_63193e0c7cee097e = spawnscriptable( "equip_door_barricade_mp", var_cf6237ce3f49c883.var_80bf3818b8f0ef9e.origin, var_cf6237ce3f49c883.var_80bf3818b8f0ef9e.angles );
    barricade.var_da4f3d3b3eeac5be = spawnscriptable( "equip_door_barricade_mp", var_cf6237ce3f49c883.var_e72df9befcd314de.origin, var_cf6237ce3f49c883.var_e72df9befcd314de.angles );
    barricade.var_63193e0c7cee097e.var_ca9b433c67c54628 = barricade;
    barricade.var_da4f3d3b3eeac5be.var_ca9b433c67c54628 = barricade;
    
    /#
        if ( function_23c3d8f2ae91b6c3().debugmode )
        {
            barricade thread function_f01315df3715c3b1();
            thread scripts\cp_mp\utility\debug_utility::drawsphere( position, 1, 2.5, ( 0.22, 1, 0.07 ) );
            thread scripts\cp_mp\utility\debug_utility::drawsphere( door function_4903b126f5910cc7(), 1, 2.5, ( 0.22, 1, 0.07 ) );
        }
    #/
    
    return barricade;
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 2
// Checksum 0x0, Offset: 0x9cd
// Size: 0xa6
function function_a6ad5685b28ec03a( var_6c2e7e8ffb9dc2b4, var_56bbde692db1e972 )
{
    if ( self.var_ca026d0b161c5997 )
    {
        return;
    }
    
    self.var_ca026d0b161c5997 = 1;
    dmg = min( self.damagetaken, self.maxhealth );
    scripts\mp\analyticslog::logevent_fieldupgradeexpired( self.owner, self.superid, int( dmg ), istrue( var_56bbde692db1e972 ) );
    function_4c71e3b9e9268274( self.door );
    
    if ( isdefined( self.secondarydoor ) )
    {
        function_4c71e3b9e9268274( self.secondarydoor );
    }
    
    thread function_1591fdb99f47eb45( var_6c2e7e8ffb9dc2b4, var_56bbde692db1e972 );
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 1
// Checksum 0x0, Offset: 0xa7b
// Size: 0x1c
function function_4c71e3b9e9268274( var_67c2ef0a05674606 )
{
    var_67c2ef0a05674606 function_8d35d9ef24e364e3( 0 );
    var_67c2ef0a05674606 function_81f42d756861b14a();
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 2
// Checksum 0x0, Offset: 0xa9f
// Size: 0xb7
function function_1591fdb99f47eb45( deletiondelay, var_56bbde692db1e972 )
{
    self notify( "death" );
    
    if ( istrue( var_56bbde692db1e972 ) )
    {
        self.var_63193e0c7cee097e setscriptablepartstate( "main_death_loop", "destroyed" );
        self.var_da4f3d3b3eeac5be setscriptablepartstate( "main_death_loop", "destroyed" );
    }
    else
    {
        self.var_63193e0c7cee097e setscriptablepartstate( "main_death_loop", "removed" );
        self.var_da4f3d3b3eeac5be setscriptablepartstate( "main_death_loop", "removed" );
    }
    
    if ( isdefined( deletiondelay ) && deletiondelay > 0 )
    {
        wait deletiondelay;
    }
    else
    {
        waitframe();
    }
    
    self.var_63193e0c7cee097e freescriptable();
    self.var_da4f3d3b3eeac5be freescriptable();
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 0
// Checksum 0x0, Offset: 0xb5e
// Size: 0x48
function function_47de387357a169a0()
{
    self endon( "death" );
    settings = function_23c3d8f2ae91b6c3();
    
    if ( settings.uselifetime )
    {
        wait settings.lifetime;
        function_a6ad5685b28ec03a( settings.var_8a25a7879becda51, 0 );
    }
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 0
// Checksum 0x0, Offset: 0xbae
// Size: 0x1a
function function_9d44d1095c5076fc()
{
    self endon( "death" );
    level waittill( "game_ended" );
    function_a6ad5685b28ec03a( undefined, 0 );
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 0
// Checksum 0x0, Offset: 0xbd0
// Size: 0x2
function function_49c6f1e402dea720()
{
    
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 11
// Checksum 0x0, Offset: 0xbda
// Size: 0x133
function function_fa856206e66d1aca( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname )
{
    if ( !isdefined( instance ) || !isdefined( instance.type ) || !isdefined( instance.var_ca9b433c67c54628 ) || instance.var_ca9b433c67c54628.var_ca026d0b161c5997 )
    {
        return;
    }
    
    damage = instance function_5b121785e9363ea4( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname );
    
    if ( isdefined( eattacker ) && isplayer( eattacker ) )
    {
        eattacker scripts\cp_mp\damagefeedback::updatedamagefeedback( "hitequip" );
    }
    
    barricade = instance.var_ca9b433c67c54628;
    barricade.damagetaken += damage;
    
    if ( barricade.damagetaken >= barricade.maxhealth )
    {
        barricade function_7081462a3365812b( eattacker );
    }
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 11
// Checksum 0x0, Offset: 0xd15
// Size: 0x1a7
function function_5b121785e9363ea4( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname )
{
    settings = function_23c3d8f2ae91b6c3();
    
    if ( objweapon.basename == "thermite_av_mp" )
    {
        return settings.thermitedamage;
    }
    
    if ( scripts\mp\damage::issmallsplashdamage( objweapon ) )
    {
        return 0;
    }
    
    if ( isthrowingknife( objweapon.basename ) || isthrowingstar( objweapon.basename ) )
    {
        return 0;
    }
    
    if ( objweapon.basename == "iw9_dm_crossbow_mp" && smeansofdeath != "MOD_MELEE" )
    {
        return 0;
    }
    
    if ( smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_IMPACT" )
    {
        if ( smeansofdeath == "MOD_IMPACT" && objweapon.classname == "grenade" )
        {
            return idamage;
        }
        
        return settings.meleedamage;
    }
    
    if ( smeansofdeath == "MOD_CRUSH" && isdefined( einflictor ) && einflictor.classname == "script_vehicle" )
    {
        if ( isdefined( eattacker ) && !scripts\mp\weapons::friendlyfirecheck( instance.owner, eattacker ) )
        {
            return idamage;
        }
    }
    
    if ( isexplosivedamagemod( smeansofdeath ) )
    {
        return settings.explosivedamage;
    }
    
    idamage = scripts\mp\damage::handleapdamage( objweapon, smeansofdeath, idamage, eattacker );
    idamage = scripts\mp\damage::handleshotgundamage( objweapon, smeansofdeath, idamage );
    return idamage;
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 1
// Checksum 0x0, Offset: 0xec5
// Size: 0x52
function function_7081462a3365812b( attacker )
{
    if ( istrue( scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, attacker ) ) )
    {
        attacker notify( "destroyed_equipment" );
        attacker thread scripts\mp\utility\points::doscoreevent( #"destroyed_equipment" );
    }
    
    function_a6ad5685b28ec03a( function_23c3d8f2ae91b6c3().var_8a25a7879becda51, 1 );
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 1
// Checksum 0x0, Offset: 0xf1f
// Size: 0x20
function function_8d35d9ef24e364e3( lockdoor )
{
    if ( lockdoor )
    {
        self function_9af4c9b2cc1bf989();
        return;
    }
    
    self function_80902296b05be00a();
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 0
// Checksum 0x0, Offset: 0xf47
// Size: 0x48, Type: bool
function function_76345fed7f6c60cb()
{
    if ( !self isscriptableinstance() )
    {
        assertmsg( "<dev string:x168>" );
        return false;
    }
    
    if ( !self scriptableisdoor() )
    {
        assertmsg( "<dev string:x1b8>" );
        return false;
    }
    
    return isdefined( level.var_b73eb86d1d5a19e9[ self.index ] );
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 0
// Checksum 0x0, Offset: 0xf98
// Size: 0x15
function function_988c3e09726886fd()
{
    return level.var_b73eb86d1d5a19e9[ self.index ];
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 1
// Checksum 0x0, Offset: 0xfb6
// Size: 0x20
function function_a348fed54b7ad2d1( barricade )
{
    level.var_b73eb86d1d5a19e9[ self.index ] = barricade;
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 0
// Checksum 0x0, Offset: 0xfde
// Size: 0x15
function function_81f42d756861b14a()
{
    level.var_b73eb86d1d5a19e9[ self.index ] = undefined;
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 0
// Checksum 0x0, Offset: 0xffb
// Size: 0x8
function function_839932ee77f36e1c()
{
    return self function_fac544c98a3d9eb4();
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 2
// Checksum 0x0, Offset: 0x100c
// Size: 0x49
function function_7e1a3b2e2d74be03( var_67c2ef0a05674606, player )
{
    if ( !var_67c2ef0a05674606 function_76345fed7f6c60cb() )
    {
        return;
    }
    
    barricade = var_67c2ef0a05674606 function_988c3e09726886fd();
    barricade function_a6ad5685b28ec03a( function_23c3d8f2ae91b6c3().var_8a25a7879becda51 );
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 3
// Checksum 0x0, Offset: 0x105d
// Size: 0x4c
function function_20c4d2ad6cf2bed3( var_67c2ef0a05674606, player, var_85e3240d30e184e7 )
{
    if ( !var_67c2ef0a05674606 function_76345fed7f6c60cb() )
    {
        return 0;
    }
    
    barricade = var_67c2ef0a05674606 function_988c3e09726886fd();
    return function_bbf23fbf1b086454( player, barricade.owner );
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 0
// Checksum 0x0, Offset: 0x10b2
// Size: 0x313
function function_4413c6dd67af86bc()
{
    settings = function_23c3d8f2ae91b6c3();
    player_forward = anglestoforward( self getplayerangles() );
    rayresult = scripts\engine\trace::ray_trace( self geteye(), self geteye() + player_forward * 120, undefined, undefined, undefined, undefined, 1 );
    
    /#
        if ( function_23c3d8f2ae91b6c3().debugmode )
        {
            thread scripts\cp_mp\utility\debug_utility::drawline( self geteye(), self geteye() + player_forward * 120, 2.5, ( 0.22, 1, 0.07 ) );
        }
    #/
    
    if ( !isdefined( rayresult[ "position" ] ) || !isdefined( rayresult[ "fraction" ] ) || rayresult[ "fraction" ] >= 1 )
    {
        return;
    }
    
    var_f89541bfc95a3f55 = rayresult[ "scriptable" ];
    
    if ( !isdefined( var_f89541bfc95a3f55 ) || !var_f89541bfc95a3f55 scriptableisdoor() )
    {
        return;
    }
    
    centerpos = var_f89541bfc95a3f55 function_92093a4b887c3bdc();
    var_91073ab900319264 = var_f89541bfc95a3f55 scriptabledoorisdouble();
    
    /#
        if ( function_23c3d8f2ae91b6c3().debugmode )
        {
            thread scripts\cp_mp\utility\debug_utility::drawsphere( centerpos, 62.4, 2.5, ter_op( !var_91073ab900319264, ( 1, 0.22, 0.07 ), ( 0.22, 1, 0.07 ) ) );
        }
    #/
    
    result = spawnstruct();
    
    if ( !var_91073ab900319264 && !settings.var_4acc66ea74cdc413 )
    {
        result.doorstatus = "single";
        result.primarydoor = var_f89541bfc95a3f55;
        return result;
    }
    
    var_68704f3ab9e70c8d = ter_op( settings.var_4acc66ea74cdc413, 104, 62.4 );
    var_f89d5f2b4bb6ed36 = scriptable_door_get_in_radius( centerpos, var_68704f3ab9e70c8d, 20 );
    
    foreach ( door in var_f89d5f2b4bb6ed36 )
    {
        if ( door scriptable_door_is_double_door_pair( var_f89541bfc95a3f55 ) )
        {
            result.doorstatus = "double";
            result.primarydoor = var_f89541bfc95a3f55;
            result.secondarydoor = door;
            return result;
        }
    }
    
    /#
        if ( function_23c3d8f2ae91b6c3().debugmode )
        {
            thread scripts\cp_mp\utility\debug_utility::drawsphere( centerpos, 104, 2.5, ( 0, 1, 1 ) );
        }
    #/
    
    foreach ( door in var_f89d5f2b4bb6ed36 )
    {
        if ( door function_8a84bf34f556872d( var_f89541bfc95a3f55 ) )
        {
            result.doorstatus = "faux";
            result.primarydoor = var_f89541bfc95a3f55;
            result.secondarydoor = door;
            return result;
        }
    }
    
    result.doorstatus = "single";
    result.primarydoor = var_f89541bfc95a3f55;
    return result;
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 2
// Checksum 0x0, Offset: 0x13ce
// Size: 0x41
function function_d42196552ddc1a12( var_67c2ef0a05674606, player )
{
    if ( !var_67c2ef0a05674606 function_76345fed7f6c60cb() )
    {
        return &"";
    }
    
    if ( function_20c4d2ad6cf2bed3( var_67c2ef0a05674606, player, 0 ) )
    {
        return &"EQUIPMENT_HINTS/DOOR_BARRICADE_CAN_REMOVE";
    }
    
    return &"EQUIPMENT_HINTS/DOOR_BARRICADE_CANNOT_REMOVE";
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 2
// Checksum 0x0, Offset: 0x1417
// Size: 0x6e
function function_bbf23fbf1b086454( firstplayer, secondplayer )
{
    if ( !isdefined( firstplayer ) || !isdefined( secondplayer ) )
    {
        return 0;
    }
    
    if ( !isdefined( firstplayer.team ) || !isdefined( secondplayer.team ) )
    {
        return 0;
    }
    
    if ( level.teambased )
    {
        return ( firstplayer.team == secondplayer.team );
    }
    
    return firstplayer == secondplayer;
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 0
// Checksum 0x0, Offset: 0x148d
// Size: 0x59, Type: bool
function function_5d6c66032973087()
{
    if ( self isswimming() )
    {
        return false;
    }
    
    if ( istrue( self.isjuggernaut ) )
    {
        return false;
    }
    
    if ( self isinfreefall() )
    {
        return false;
    }
    
    if ( self isjumping() )
    {
        return false;
    }
    
    if ( self ishanging() )
    {
        return false;
    }
    
    if ( self isthrowinggrenade() )
    {
        return false;
    }
    
    if ( isdefined( self.vehicle ) )
    {
        return false;
    }
    
    return true;
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 0
// Checksum 0x0, Offset: 0x14ef
// Size: 0x1d
function function_92093a4b887c3bdc()
{
    return self function_d90515f5e17dbc6f() + anglestoup( self.angles ) * 48;
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 0
// Checksum 0x0, Offset: 0x1515
// Size: 0x34
function function_4903b126f5910cc7()
{
    centerpos = function_92093a4b887c3bdc();
    difference = centerpos - self.origin;
    return centerpos + ( difference[ 0 ], difference[ 1 ], 0 );
}

// Namespace door_barricade / scripts\mp\equipment\door_barricade
// Params 0
// Checksum 0x0, Offset: 0x1552
// Size: 0x251
function function_7f20536248ae1a5c()
{
    self.angles = self.door.angles + ( 0, 90, 0 );
    barricadeforward = anglestoforward( self.angles );
    barricadetoplayer = self.owner.origin - self.origin;
    barricadetoplayer = ( barricadetoplayer[ 0 ], barricadetoplayer[ 1 ], barricadeforward[ 2 ] );
    barricadeforward = vectornormalize( barricadeforward );
    barricadetoplayer = vectornormalize( barricadetoplayer );
    
    /#
        if ( function_23c3d8f2ae91b6c3().debugmode )
        {
            thread scripts\cp_mp\utility\debug_utility::drawline( self.origin, self.origin + barricadeforward * 4, 2.5, ( 0, 1, 1 ) );
            thread scripts\cp_mp\utility\debug_utility::drawline( self.origin, self.origin + barricadetoplayer * 4, 2.5, ( 0, 1, 1 ) );
        }
    #/
    
    cosangle = vectordot( barricadetoplayer, barricadeforward );
    
    if ( cosangle < 0 )
    {
        self.angles += ( 0, 180, 0 );
    }
    
    self.origin += anglestoforward( self.angles ) * function_23c3d8f2ae91b6c3().var_29fdcb922844f7f;
    self.var_80bf3818b8f0ef9e = spawnstruct();
    self.var_80bf3818b8f0ef9e.origin = self.origin;
    self.var_80bf3818b8f0ef9e.angles = self.angles;
    self.angles += ( 0, 180, 0 );
    self.origin += anglestoforward( self.angles ) * function_23c3d8f2ae91b6c3().var_29fdcb922844f7f * 2;
    self.var_e72df9befcd314de = spawnstruct();
    self.var_e72df9befcd314de.origin = self.origin;
    self.var_e72df9befcd314de.angles = self.angles;
}

/#

    // Namespace door_barricade / scripts\mp\equipment\door_barricade
    // Params 0
    // Checksum 0x0, Offset: 0x17ab
    // Size: 0x66, Type: dev
    function function_f01315df3715c3b1()
    {
        self endon( "<dev string:x202>" );
        
        while ( true )
        {
            waitframe();
            
            if ( isdefined( self.damagetaken ) && isdefined( self.maxhealth ) )
            {
                print3d( self.origin, self.damagetaken + "<dev string:x20b>" + self.maxhealth, undefined, 0.5, 0.4, undefined, 1 );
            }
        }
    }

#/
