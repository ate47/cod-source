#using script_2d9d24f7c63ac143;
#using scripts\common\utility;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_headgear;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\utility\player;

#namespace helmet;

// Namespace helmet / scripts\mp\helmet
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x321
// Size: 0x155
function autoexec auto_init()
{
    if ( !istrue( getmatchrulesdata( "helmetData", "enabled" ) ) )
    {
        return;
    }
    
    thread function_18646af290fbfbb2();
    level.helmetdata = spawnstruct();
    level.helmetdata.var_bc47c031cc42316 = getmatchrulesdata( "helmetData", "durability" );
    level.helmetdata.threshold = getmatchrulesdata( "helmetData", "damageThreshold" );
    level.helmetdata.clampdamage = getmatchrulesdata( "helmetData", "damageClamp" );
    level.helmetdata.excludedweaponclasses = getmatchrulesdata( "helmetData", "excludedWeaponClasses" );
    level.helmetdata.excludedmeansofdeath = getmatchrulesdata( "helmetData", "excludedMeansOfDeath" );
    assertex( level.helmetdata.threshold - level.helmetdata.clampdamage == 1, "<dev string:x1c>" );
    utility::registersharedfunc( "helmet", "modifyHelmetDamage", &modifyhelmetdamage );
    utility::registersharedfunc( "helmet", "helmet_wasBroke", &helmet_wasbroke );
    utility::registersharedfunc( "helmet", "updateProtectionState", &function_299cd501b61c0d3c );
}

// Namespace helmet / scripts\mp\helmet
// Params 0
// Checksum 0x0, Offset: 0x47e
// Size: 0x150
function function_18646af290fbfbb2()
{
    if ( !isdefined( level.headgeardata ) )
    {
        level waittill( "headgear_init" );
    }
    
    if ( isdefined( level.headgeardata ) && utility::issharedfuncdefined( "headgear", "registerHeadGear" ) )
    {
        headgeardata = spawnstruct();
        headgeardata.hasheadgearfunc = &hashelmet;
        headgeardata.var_8965dea27a03f00f = &function_a1207d6155a4cb21;
        headgeardata.var_10b068badc49b1ad = &function_820310353aa408e;
        headgeardata.var_d2148115f2c3c399 = &function_d036366985435d3;
        headgeardata.var_9b9af82c327f6a63 = &function_a3a56edac9b26e89;
        headgeardata.var_8928676cf7288c90 = &function_914175cb65959c24;
        headgeardata.var_f830d658f5f0af18 = &init;
        headgeardata.breakfunc = &breakhelmet;
        headgeardata.var_fe0fd9391666371 = &function_9ad6194c61c4bd34;
        headgeardata.var_a7d8d38f4018a344 = &function_da78138ef883afb9;
        headgeardata.var_4aeed0bec3628793 = &function_d01dc4dc9edc024;
        headgeardata.preremovefunc = &function_2a823033fec9c3a3;
        headgeardata.onremovefunc = &function_47f53709b7a29a77;
        headgeardata.var_bb61027a51ec1e05 = &function_99410e7ff54d683c;
        [[ utility::getsharedfunc( "headgear", "registerHeadGear" ) ]]( "helmet", headgeardata );
    }
}

// Namespace helmet / scripts\mp\helmet
// Params 2
// Checksum 0x0, Offset: 0x5d6
// Size: 0x44
function function_5ce1095d3ebdaa68( shitloc, partname )
{
    if ( shitloc == "head" || shitloc == "helmet" || shitloc == "neck" )
    {
        return 1;
    }
    
    if ( isdefined( partname ) )
    {
        return scripts\cp_mp\utility\damage_utility::function_b656251147d7d40b( partname );
    }
    
    return 0;
}

// Namespace helmet / scripts\mp\helmet
// Params 8
// Checksum 0x0, Offset: 0x623
// Size: 0xec
function modifyhelmetdamage( attacker, victim, idamage, var_c619bd3ead94932e, objweapon, shitloc, partname, smeansofdeath )
{
    if ( isplayer( attacker ) )
    {
        helmet_clearbroke( attacker );
    }
    
    if ( function_4aef917a60fe6683( victim ) )
    {
        var_b0bc7939c659f729 = 1;
        
        if ( getdvarint( @"hash_fc28fbd9295bad17", 0 ) == 0 )
        {
            if ( victim.health + var_c619bd3ead94932e <= level.helmetdata.clampdamage )
            {
                var_b0bc7939c659f729 = 0;
            }
        }
        
        modifieddamage = idamage + var_c619bd3ead94932e;
        
        if ( var_b0bc7939c659f729 && function_5ce1095d3ebdaa68( shitloc, partname ) )
        {
            modifieddamage = victim modifydamage( modifieddamage, attacker, objweapon, smeansofdeath );
        }
        
        idamage = modifieddamage - var_c619bd3ead94932e;
    }
    
    return [ idamage, var_c619bd3ead94932e ];
}

// Namespace helmet / scripts\mp\helmet
// Params 3
// Checksum 0x0, Offset: 0x718
// Size: 0xeb
function init( var_5698e367753e03ba, var_113085cb6cb9173c, var_c36a76d3071e80ae )
{
    var_f6ba8d6e6a3dcf59 = 5;
    var_bc47c031cc42316 = ter_op( isdefined( var_c36a76d3071e80ae ), var_c36a76d3071e80ae, level.helmetdata.var_bc47c031cc42316 );
    self.var_5698e367753e03ba = var_bc47c031cc42316;
    self.var_113085cb6cb9173c = ter_op( isdefined( var_113085cb6cb9173c ), var_113085cb6cb9173c, "brloot_equip_helmet" );
    self.headgeartype = "helmet";
    isbr = issharedfuncdefined( "game", "isBRStyleGameType" ) && [[ getsharedfunc( "game", "isBRStyleGameType" ) ]]();
    
    if ( isbr )
    {
        level.var_64e0c53009427bca = self.var_5698e367753e03ba / 6;
    }
    
    self setclientomnvar( "ui_head_equip_class", var_f6ba8d6e6a3dcf59 );
    self setclientomnvar( "ui_gasmask_damage", self.var_5698e367753e03ba / var_bc47c031cc42316 );
}

// Namespace helmet / scripts\mp\helmet
// Params 0
// Checksum 0x0, Offset: 0x80b
// Size: 0x15, Type: bool
function function_820310353aa408e()
{
    return getdvarint( @"hash_ce0fed1fd6f9e303", 1 ) == 1;
}

// Namespace helmet / scripts\mp\helmet
// Params 1
// Checksum 0x0, Offset: 0x829
// Size: 0x69
function getscriptablename( var_b14a276853a7becd )
{
    var_52bae67b850d8400 = undefined;
    
    switch ( var_b14a276853a7becd )
    {
        case #"hash_1c62bcd1f60e106c":
        case #"hash_8a1772f5f912c880":
            var_52bae67b850d8400 = "brloot_equip_helmet";
            break;
        case #"hash_e1f05d0a4963cf16":
            var_52bae67b850d8400 = "brloot_equip_reinforced_helmet";
            break;
        default:
            break;
    }
    
    return var_52bae67b850d8400;
}

// Namespace helmet / scripts\mp\helmet
// Params 4
// Checksum 0x0, Offset: 0x89b
// Size: 0xf8
function modifydamage( damage, attacker, objweapon, smeansofdeath )
{
    outdamage = damage;
    clampeddamage = level.helmetdata.clampdamage;
    damagethreshold = level.helmetdata.threshold;
    
    if ( function_91b88df2883c5dd( objweapon ) && function_d9824ece84e7fe6( smeansofdeath ) )
    {
        if ( damage >= damagethreshold )
        {
            outdamage = clampeddamage;
            self.var_5698e367753e03ba -= 1;
        }
    }
    
    if ( self.var_5698e367753e03ba <= 0 )
    {
        if ( isdefined( level.headgeardata ) && isdefined( level.headgeardata.gear[ "helmet" ] ) )
        {
            scripts\mp\gametypes\br_headgear::breakheadgear( "helmet", attacker );
        }
        else
        {
            breakhelmet();
        }
        
        helmet_setbroke( attacker );
    }
    
    return outdamage;
}

// Namespace helmet / scripts\mp\helmet
// Params 1
// Checksum 0x0, Offset: 0x99c
// Size: 0x35, Type: bool
function function_91b88df2883c5dd( objweapon )
{
    if ( issubstr( level.helmetdata.excludedweaponclasses, objweapon.classname ) )
    {
        return false;
    }
    
    return true;
}

// Namespace helmet / scripts\mp\helmet
// Params 1
// Checksum 0x0, Offset: 0x9da
// Size: 0x2b, Type: bool
function function_d9824ece84e7fe6( smeansofdeath )
{
    if ( issubstr( level.helmetdata.excludedmeansofdeath, smeansofdeath ) )
    {
        return false;
    }
    
    return true;
}

// Namespace helmet / scripts\mp\helmet
// Params 1
// Checksum 0x0, Offset: 0xa0e
// Size: 0x50
function setbrokenoverlaymaterial( material )
{
    if ( isdefined( self.var_d59ea89f027676fc ) )
    {
        if ( isdefined( material ) )
        {
            self.var_d59ea89f027676fc setshader( material, 640, 480 );
            return;
        }
        
        self.var_d59ea89f027676fc setshader( "gasmask_overlay_delta2_broken", 640, 480 );
    }
}

// Namespace helmet / scripts\mp\helmet
// Params 1
// Checksum 0x0, Offset: 0xa66
// Size: 0x17, Type: bool
function hashelmet( player )
{
    return isdefined( player.var_5698e367753e03ba );
}

// Namespace helmet / scripts\mp\helmet
// Params 1
// Checksum 0x0, Offset: 0xa86
// Size: 0x17, Type: bool
function function_a1207d6155a4cb21( player )
{
    return istrue( player.var_5b9dafb6c753684 );
}

// Namespace helmet / scripts\mp\helmet
// Params 0
// Checksum 0x0, Offset: 0xaa6
// Size: 0x9
function function_99410e7ff54d683c()
{
    function_52dad6cd70b673b2();
}

// Namespace helmet / scripts\mp\helmet
// Params 0
// Checksum 0x0, Offset: 0xab7
// Size: 0x4e
function function_e0e91b770d992a81()
{
    player = self;
    delaygesture = 0;
    delaygesture |= player isreloading();
    delaygesture |= player isthrowinggrenade();
    delaygesture |= player isdiving();
    delaygesture |= player issprintsliding();
    delaygesture |= player scripts\mp\utility\player::isplayerads();
    return delaygesture;
}

// Namespace helmet / scripts\mp\helmet
// Params 0
// Checksum 0x0, Offset: 0xb0e
// Size: 0x4e, Type: bool
function function_d9d43450e3d74d25()
{
    player = self;
    preventgesture = 0;
    preventgesture |= player isinfreefall();
    preventgesture |= player isskydiving();
    preventgesture |= player isparachuting();
    preventgesture |= player isbasejumpavailable();
    preventgesture |= player ismantling();
    return !preventgesture;
}

// Namespace helmet / scripts\mp\helmet
// Params 0
// Checksum 0x0, Offset: 0xb65
// Size: 0xf
function function_da78138ef883afb9()
{
    self playsoundtoplayer( "br_gas_mask_on_plr", self );
}

// Namespace helmet / scripts\mp\helmet
// Params 0
// Checksum 0x0, Offset: 0xb7c
// Size: 0x72
function function_d01dc4dc9edc024()
{
    self.var_5b9dafb6c753684 = 1;
    function_299cd501b61c0d3c( self );
    
    if ( isdefined( self.var_5698e367753e03ba ) && self.var_5698e367753e03ba <= 0 )
    {
        if ( isdefined( level.headgeardata ) && isdefined( level.headgeardata.gear[ "helmet" ] ) )
        {
            scripts\mp\gametypes\br_headgear::breakheadgear( "helmet" );
            return;
        }
        
        breakhelmet();
    }
}

// Namespace helmet / scripts\mp\helmet
// Params 0
// Checksum 0x0, Offset: 0xbf6
// Size: 0xf
function function_2a823033fec9c3a3()
{
    self playsoundtoplayer( "br_gas_mask_off_plr", self );
}

// Namespace helmet / scripts\mp\helmet
// Params 0
// Checksum 0x0, Offset: 0xc0d
// Size: 0x25
function function_47f53709b7a29a77()
{
    if ( isdefined( self.var_5698e367753e03ba ) && self.var_5698e367753e03ba <= 0 )
    {
        function_52dad6cd70b673b2();
    }
}

// Namespace helmet / scripts\mp\helmet
// Params 1
// Checksum 0x0, Offset: 0xc3a
// Size: 0x78
function breakhelmet( attacker )
{
    if ( !istrue( self.var_5b9dafb6c753684 ) )
    {
        return;
    }
    
    if ( isdefined( attacker ) && isdefined( self.var_113085cb6cb9173c ) && istrue( self.var_113085cb6cb9173c == "brloot_equip_reinforced_helmet" ) )
    {
        attacker playsoundtoplayer( "hit_marker_3d_reinforce_helmet_break", attacker );
    }
    else
    {
        self playsoundtoplayer( "br_gas_mask_break_plr", self );
        self playsoundtoplayer( "br_gas_mask_depleted_plr", self );
    }
    
    function_52dad6cd70b673b2();
    function_9ad6194c61c4bd34();
}

// Namespace helmet / scripts\mp\helmet
// Params 0
// Checksum 0x0, Offset: 0xcba
// Size: 0x5b
function function_52dad6cd70b673b2()
{
    self.var_5b9dafb6c753684 = undefined;
    self.var_13bc0a60757228ba = undefined;
    self.var_5698e367753e03ba = undefined;
    self.var_113085cb6cb9173c = undefined;
    self.headgeartype = undefined;
    self setclientomnvar( "ui_gas_mask", 0 );
    self setclientomnvar( "ui_head_equip_class", 0 );
    self setclientomnvar( "ui_gasmask_damage", 0 );
}

// Namespace helmet / scripts\mp\helmet
// Params 0
// Checksum 0x0, Offset: 0xd1d
// Size: 0x41
function function_9ad6194c61c4bd34()
{
    player = self;
    
    if ( !player namespace_aead94004cf4c147::isbackpackinventoryenabled() )
    {
        return;
    }
    
    var_d035435a9237f3d = player scripts\mp\gametypes\br_pickups::function_b76f69ce63757cea( "brloot_equip_reinforced_helmet" );
    
    if ( !var_d035435a9237f3d )
    {
        player scripts\mp\gametypes\br_pickups::function_b76f69ce63757cea( "brloot_equip_helmet" );
    }
}

// Namespace helmet / scripts\mp\helmet
// Params 2
// Checksum 0x0, Offset: 0xd66
// Size: 0x4a, Type: bool
function function_d036366985435d3( player, pickupent )
{
    if ( !istrue( player.var_5b9dafb6c753684 ) || self.var_5698e367753e03ba == 0 )
    {
        return true;
    }
    
    return pickupent.count > self.var_5698e367753e03ba;
}

// Namespace helmet / scripts\mp\helmet
// Params 1
// Checksum 0x0, Offset: 0xdb9
// Size: 0x22
function function_a3a56edac9b26e89( player )
{
    if ( function_a1207d6155a4cb21( player ) )
    {
        return player.var_113085cb6cb9173c;
    }
    
    return undefined;
}

// Namespace helmet / scripts\mp\helmet
// Params 1
// Checksum 0x0, Offset: 0xde4
// Size: 0x28, Type: bool
function function_4aef917a60fe6683( player )
{
    return isdefined( player.var_5698e367753e03ba ) && player.var_5698e367753e03ba > 0;
}

// Namespace helmet / scripts\mp\helmet
// Params 1
// Checksum 0x0, Offset: 0xe15
// Size: 0x22
function function_914175cb65959c24( player )
{
    if ( function_4aef917a60fe6683( player ) )
    {
        return player.var_5698e367753e03ba;
    }
    
    return 0;
}

// Namespace helmet / scripts\mp\helmet
// Params 1
// Checksum 0x0, Offset: 0xe40
// Size: 0x2c, Type: bool
function helmet_wasbroke( attacker )
{
    return isdefined( attacker.var_46019d40799ece5f ) && gettime() == attacker.var_46019d40799ece5f;
}

// Namespace helmet / scripts\mp\helmet
// Params 1
// Checksum 0x0, Offset: 0xe75
// Size: 0x1c
function helmet_setbroke( attacker )
{
    attacker.var_46019d40799ece5f = gettime();
}

// Namespace helmet / scripts\mp\helmet
// Params 1
// Checksum 0x0, Offset: 0xe99
// Size: 0x16
function helmet_clearbroke( attacker )
{
    attacker.var_46019d40799ece5f = undefined;
}

// Namespace helmet / scripts\mp\helmet
// Params 1
// Checksum 0x0, Offset: 0xeb7
// Size: 0x75
function function_299cd501b61c0d3c( player )
{
    if ( !function_a1207d6155a4cb21( player ) )
    {
        return;
    }
    
    currentstate = player getclientomnvar( "ui_helmet_protection_state" );
    var_1247e7bf97720271 = player.health + player.armorhealth > level.helmetdata.clampdamage;
    
    if ( currentstate != var_1247e7bf97720271 )
    {
        player setclientomnvar( "ui_helmet_protection_state", var_1247e7bf97720271 );
    }
}

