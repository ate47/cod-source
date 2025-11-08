#using script_cbb0697de4c5728;
#using scripts\common\utility;
#using scripts\cp_mp\equipment\throwing_knife;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;

#namespace throwing_knife;

// Namespace throwing_knife / scripts\cp_mp\equipment\throwing_knife
// Params 0
// Checksum 0x0, Offset: 0x3ba
// Size: 0x5b
function throwing_knife_init()
{
    level.throwingknifemaxpickups = getdvarfloat( @"hash_9cf2c444ba60d047", 12 );
    level.throwingknifepickuptimeout = getdvarfloat( @"hash_63a7b50937e43d7b", 20 );
    
    /#
        scripts\engine\utility::issharedfuncdefined( "<dev string:x1c>", "<dev string:x2e>" );
    #/
    
    [[ getsharedfunc( "throwing_knife", "init" ) ]]();
}

// Namespace throwing_knife / scripts\cp_mp\equipment\throwing_knife
// Params 3
// Checksum 0x0, Offset: 0x41d
// Size: 0x45
function throwing_knife_ongive( equipmentref, equipmentslot, variantid )
{
    if ( scripts\engine\utility::issharedfuncdefined( "throwing_knife", "onGive" ) )
    {
        self [[ getsharedfunc( "throwing_knife", "onGive" ) ]]( equipmentref, equipmentslot, variantid );
    }
}

// Namespace throwing_knife / scripts\cp_mp\equipment\throwing_knife
// Params 2
// Checksum 0x0, Offset: 0x46a
// Size: 0x3c
function throwing_knife_ontake( equipmentref, equipmentslot )
{
    if ( scripts\engine\utility::issharedfuncdefined( "throwing_knife", "onTake" ) )
    {
        self [[ getsharedfunc( "throwing_knife", "onTake" ) ]]( equipmentref, equipmentslot );
    }
}

// Namespace throwing_knife / scripts\cp_mp\equipment\throwing_knife
// Params 2
// Checksum 0x0, Offset: 0x4ae
// Size: 0x27
function function_d763df6d36a1e34a( equipmentref, currammo )
{
    if ( isdefined( currammo ) && currammo == 0 )
    {
        scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive( equipmentref );
    }
}

// Namespace throwing_knife / scripts\cp_mp\equipment\throwing_knife
// Params 1
// Checksum 0x0, Offset: 0x4dd
// Size: 0x172
function throwing_knife_used( grenade )
{
    grenade endon( "death" );
    grenade function_a39ea6b39ffb2b53();
    grenade.bwasunderwater = isswimmingunderwater();
    grenade thread function_bdd18334e29f6933();
    grenade makeunusable();
    
    if ( !isdefined( grenade.equipmentref ) )
    {
        if ( grenade.weapon_name == "shuriken_mp" || grenade.weapon_name == "shuriken_mp_inert" )
        {
            grenade.equipmentref = "equip_shuriken";
        }
        else
        {
            grenade.equipmentref = "equip_throwing_knife";
        }
    }
    
    stuckto = undefined;
    stuckpart = undefined;
    grenade_owner_name = self.name;
    grenade endon( "throwKnifeCancelStuckWait" );
    grenade waittill( "missile_stuck", stuckto, stuckpart );
    level notify( "grenade_exploded_during_stealth", grenade, "throwingknife_mp", grenade_owner_name );
    hitshield = isdefined( stuckpart ) && stuckpart == "tag_flicker";
    hitplayer = isdefined( stuckto ) && ( isplayer( stuckto ) || isagent( stuckto ) );
    
    if ( hitplayer && hitshield )
    {
        stuckto notify( "shield_hit", grenade );
    }
    
    if ( isdefined( stuckto ) && istrue( stuckto.var_a8622ecf49acda6e ) )
    {
        grenade delete();
        return;
    }
    
    grenade setscriptablepartstate( "showLocation", "active", 0 );
    
    /#
        grenade thread function_dec7a62735f22d28();
    #/
    
    grenade throwing_knife_makepickup();
}

/#

    // Namespace throwing_knife / scripts\cp_mp\equipment\throwing_knife
    // Params 0
    // Checksum 0x0, Offset: 0x657
    // Size: 0x50, Type: dev
    function function_dec7a62735f22d28()
    {
        self endon( "<dev string:x36>" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_a8d9e3f367c7effc" ) > 0 )
            {
                cylinder( self.origin, self.origin + ( 0, 0, 64 ), 64 );
            }
            
            waitframe();
        }
    }

#/

// Namespace throwing_knife / scripts\cp_mp\equipment\throwing_knife
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x6af
// Size: 0x4d
function private function_bdd18334e29f6933()
{
    self endon( "explode" );
    self endon( "death" );
    self endon( "missile_stuck" );
    
    if ( istrue( self.inertknife ) )
    {
        return 0;
    }
    
    self waittill( "missile_water_impact", impactdata );
    self.bwasunderwater = 1;
    thread function_86b5c08af20abc5e();
}

// Namespace throwing_knife / scripts\cp_mp\equipment\throwing_knife
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x704
// Size: 0xf8
function private function_86b5c08af20abc5e()
{
    level endon( "game_end" );
    self endon( "missile_stuck" );
    owner = self.owner;
    newspawnpos = self.origin;
    var_f84a0525bcc7d85 = self.weapon_object;
    var_c653f46ee7eb6b5a = self.angles;
    inertweapon = "throwingknife_mp_inert";
    
    if ( is_equal( self.weapon_name, "shuriken_mp" ) )
    {
        inertweapon = "shuriken_mp_inert";
    }
    
    self waittill( "missile_change_to_dud", dudpos );
    owner notify( "throwKnifeCancelStuckWait" );
    
    if ( isdefined( dudpos ) )
    {
        newspawnpos = dudpos;
    }
    
    replacementknife = owner launchgrenade( inertweapon, newspawnpos, ( 0, 0, 0 ), undefined, undefined );
    replacementknife.inertknife = 1;
    replacementknife.var_f84a0525bcc7d85 = var_f84a0525bcc7d85;
    replacementknife.angles = var_c653f46ee7eb6b5a;
}

// Namespace throwing_knife / scripts\cp_mp\equipment\throwing_knife
// Params 1
// Checksum 0x0, Offset: 0x804
// Size: 0x54
function function_3d8b0933df7505fd( victim )
{
    outdmg = 45;
    var_451f4dc5070c2a = victim.health - 45 <= 0;
    
    if ( var_451f4dc5070c2a )
    {
        outdmg = int( max( victim.health - 1, 1 ) );
    }
    
    return outdmg;
}

// Namespace throwing_knife / scripts\cp_mp\equipment\throwing_knife
// Params 1
// Checksum 0x0, Offset: 0x861
// Size: 0x16a
function getcorpstablestate( stuckpart )
{
    switch ( stuckpart )
    {
        case #"hash_21fb295da569a24b":
            return "head";
        case #"hash_de9ffaed3aaf2f50":
            return "head";
        case #"hash_402665c8637b5f05":
            return "head";
        case #"hash_b68fa57896eba8d3":
            return "to_";
        case #"hash_75d098324e281f06":
            return "to_";
        case #"hash_270342211f93c022":
            return "ar_";
        case #"hash_274912211fcb218c":
            return "al_";
        case #"hash_d6c67a869aa3949f":
            return "ar_";
        case #"hash_d70b82869ad9bb31":
            return "al_";
        case #"hash_d332e6054003402b":
            return "ar_";
        case #"hash_d3921605404ec06d":
            return "al_";
        case #"hash_74dd72dc5d3dc459":
            return "lr";
        case #"hash_74e38adc5d42674f":
            return "ll_";
        case #"hash_87e17a385203b93f":
            return "lr";
        case #"hash_882682385239dfd1":
            return "ll_";
        case #"hash_34953cef3230c1eb":
            return "lr";
        case #"hash_34f36cef327aaf2d":
            return "ll_";
        default:
            println( "<dev string:x3f>" + stuckpart + "<dev string:x6a>" );
            return undefined;
    }
}

// Namespace throwing_knife / scripts\cp_mp\equipment\throwing_knife
// Params 0
// Checksum 0x0, Offset: 0x9d3
// Size: 0x47
function function_a39ea6b39ffb2b53()
{
    var_e5f5e8abcb0b75bc = namespace_46e942396566f2da::function_150370c11a6c880( self.weapon_object );
    
    if ( var_e5f5e8abcb0b75bc )
    {
        state = self.owner namespace_46e942396566f2da::function_8114951a631bd6a6();
        self setscriptablepartstate( "soulEater", state );
    }
}

// Namespace throwing_knife / scripts\cp_mp\equipment\throwing_knife
// Params 0
// Checksum 0x0, Offset: 0xa22
// Size: 0x10c
function throwing_knife_makepickup()
{
    self makeunusable();
    trigger = spawn( "trigger_radius", self.origin, 0, 64, 64 );
    trigger.targetname = "dropped_knife";
    trigger enablelinkto();
    trigger linkto( self );
    self.knife_trigger = trigger;
    
    if ( !isdefined( level.throwingknives ) )
    {
        level.throwingknives = [];
    }
    
    temparr = [ self ];
    
    foreach ( throwingknife in level.throwingknives )
    {
        if ( temparr.size >= level.throwingknifemaxpickups )
        {
            if ( isdefined( throwingknife ) )
            {
                throwingknife throwing_knife_deletepickup();
            }
            
            continue;
        }
        
        if ( isdefined( throwingknife ) )
        {
            temparr[ temparr.size ] = throwingknife;
        }
    }
    
    level.throwingknives = temparr;
    thread throwing_knife_watchpickup();
    thread throwing_knife_watchpickuptimeout();
}

// Namespace throwing_knife / scripts\cp_mp\equipment\throwing_knife
// Params 0
// Checksum 0x0, Offset: 0xb36
// Size: 0x129
function throwing_knife_watchpickup()
{
    self endon( "death" );
    isbackpackinventoryenabled = 0;
    
    if ( scripts\engine\utility::issharedfuncdefined( "inventory", "isBackpackInventoryEnabled" ) )
    {
        isbackpackinventoryenabled = [[ getsharedfunc( "inventory", "isBackpackInventoryEnabled" ) ]]();
    }
    
    while ( true )
    {
        self.knife_trigger waittill( "trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( !player _isalive() )
        {
            continue;
        }
        
        if ( isdefined( self.owner ) && self.owner != player )
        {
            continue;
        }
        
        if ( isdefined( self.var_f84a0525bcc7d85 ) )
        {
            if ( !player hasweapon( self.var_f84a0525bcc7d85 ) && !isbackpackinventoryenabled )
            {
                continue;
            }
        }
        else if ( !player hasweapon( self.weapon_object ) && !isbackpackinventoryenabled )
        {
            continue;
        }
        
        variantid = 0;
        weaponobj = self.weapon_object;
        
        if ( isdefined( weaponobj ) )
        {
            variantid = weaponobj.variantid;
        }
        
        if ( player throwing_knife_trytopickup( self.equipmentref, variantid ) )
        {
            thread throwing_knife_deletepickup();
        }
    }
}

// Namespace throwing_knife / scripts\cp_mp\equipment\throwing_knife
// Params 0
// Checksum 0x0, Offset: 0xc67
// Size: 0x1b
function throwing_knife_watchpickuptimeout()
{
    self endon( "death" );
    wait level.throwingknifepickuptimeout;
    thread throwing_knife_deletepickup();
}

// Namespace throwing_knife / scripts\cp_mp\equipment\throwing_knife
// Params 0
// Checksum 0x0, Offset: 0xc8a
// Size: 0x25
function throwing_knife_deletepickup()
{
    if ( isdefined( self.knife_trigger ) )
    {
        self.knife_trigger delete();
    }
    
    self delete();
}

// Namespace throwing_knife / scripts\cp_mp\equipment\throwing_knife
// Params 2
// Checksum 0x0, Offset: 0xcb7
// Size: 0x5a
function throwing_knife_trytopickup( equipmentref, variantid )
{
    if ( scripts\engine\utility::issharedfuncdefined( "throwing_knife", "tryToPickup" ) )
    {
        pickupsuccessful = self [[ getsharedfunc( "throwing_knife", "tryToPickup" ) ]]( equipmentref );
        assertex( isdefined( pickupsuccessful ), "<dev string:x70>" );
        return pickupsuccessful;
    }
    
    return 1;
}

