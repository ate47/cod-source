#namespace damage_tuning;

// Namespace damage_tuning / scripts\common\damage_tuning
// Params 0
// Checksum 0x0, Offset: 0x88
// Size: 0x81
function init()
{
    level.var_be6a42242be00b66 = isdefined( level.gametypebundle ) && istrue( level.gametypebundle.var_53fc2c66905a7332 );
    
    /#
        if ( getdvarint( @"hash_e600610a3da3e873", 0 ) > 0 )
        {
            level.var_be6a42242be00b66 = 0;
        }
    #/
    
    if ( istrue( level.var_be6a42242be00b66 ) && !function_950c8234f03299d4() )
    {
        /#
            function_5013853947770621( #"damage tuning" );
        #/
        
        level.var_be6a42242be00b66 = 0;
        return;
    }
}

// Namespace damage_tuning / scripts\common\damage_tuning
// Params 2
// Checksum 0x0, Offset: 0x111
// Size: 0x16a
function function_4a2ecb33b6adeb85( damagedata, var_e913079a5ffda56d )
{
    if ( !level.var_be6a42242be00b66 )
    {
        return 0;
    }
    
    objweapon = damagedata.objweapon;
    meansofdeath = damagedata.meansofdeath;
    var_b66e269a387db351 = var_e913079a5ffda56d.var_b66e269a387db351;
    
    if ( !isdefined( var_b66e269a387db351 ) )
    {
        assertmsg( "<dev string:x1c>" );
        return;
    }
    
    if ( isstring( meansofdeath ) )
    {
        meansofdeath = getxhash( meansofdeath );
    }
    
    thisweaponclass = weaponclass( objweapon );
    
    if ( isstring( thisweaponclass ) )
    {
        thisweaponclass = getxhash( thisweaponclass );
    }
    
    foreach ( var_e1e1bfdd0ed6864f in var_b66e269a387db351 )
    {
        if ( isdefined( var_e1e1bfdd0ed6864f.weaponclass ) && var_e1e1bfdd0ed6864f.weaponclass != thisweaponclass )
        {
            continue;
        }
        
        if ( isdefined( var_e1e1bfdd0ed6864f.meansofdeath ) && var_e1e1bfdd0ed6864f.meansofdeath != meansofdeath )
        {
            continue;
        }
        
        if ( isdefined( var_e1e1bfdd0ed6864f.damagemodcategory ) && var_e1e1bfdd0ed6864f.damagemodcategory != var_e1e1bfdd0ed6864f.damagemodcategory )
        {
            continue;
        }
        
        return var_e1e1bfdd0ed6864f.var_b66e269a387db351;
    }
}

// Namespace damage_tuning / scripts\common\damage_tuning
// Params 6
// Checksum 0x0, Offset: 0x283
// Size: 0x2c2
function getmodifieddamageusingdamagetuning( attacker, objweapon, mod, amount, maxhealth, damage_tuning )
{
    multipliers = damage_tuning.damagemultipliers;
    hitstokill = damage_tuning.var_aaf772ef14275e0b;
    
    if ( !isdefined( multipliers ) )
    {
        assertmsg( "<dev string:x3c>" );
        return amount;
    }
    
    if ( !isdefined( hitstokill ) )
    {
        assertmsg( "<dev string:x8a>" );
        return amount;
    }
    
    if ( isstring( mod ) )
    {
        mod = getxhash( mod );
    }
    
    thisweaponclass = weaponclass( objweapon );
    
    if ( isstring( thisweaponclass ) )
    {
        thisweaponclass = getxhash( thisweaponclass );
    }
    
    damageamount = amount;
    
    foreach ( var_a5c813dce206559b in hitstokill )
    {
        if ( isdefined( var_a5c813dce206559b.weaponclass ) && var_a5c813dce206559b.weaponclass != thisweaponclass )
        {
            continue;
        }
        
        if ( isdefined( var_a5c813dce206559b.meansofdeath ) && var_a5c813dce206559b.meansofdeath != mod )
        {
            continue;
        }
        
        if ( isdefined( var_a5c813dce206559b.damagemodcategory ) && var_a5c813dce206559b.damagemodcategory != objweapon.damagemodcategory )
        {
            continue;
        }
        
        hitstokillamount = var_a5c813dce206559b.hitstokill;
        
        if ( hitstokillamount <= 0 )
        {
            assertmsg( "<dev string:xe0>" + hitstokillamount + "<dev string:xf0>" );
            continue;
        }
        
        damageamount = int( ceil( float( self.maxhealth ) / hitstokillamount ) );
        return damageamount;
    }
    
    foreach ( currentmultiplier in multipliers )
    {
        if ( isdefined( currentmultiplier.weaponclass ) && currentmultiplier.weaponclass != thisweaponclass )
        {
            continue;
        }
        
        if ( isdefined( currentmultiplier.meansofdeath ) && currentmultiplier.meansofdeath != mod )
        {
            continue;
        }
        
        if ( isdefined( currentmultiplier.damagemodcategory ) && currentmultiplier.damagemodcategory != objweapon.damagemodcategory )
        {
            continue;
        }
        
        var_b2646ba6b5716a4e = currentmultiplier.multiplier;
        damageamount = int( ceil( var_b2646ba6b5716a4e * amount ) );
        return damageamount;
    }
    
    return int( damageamount );
}

// Namespace damage_tuning / scripts\common\damage_tuning
// Params 2
// Checksum 0x0, Offset: 0x54e
// Size: 0x35
function setupdamagetuning( var_e913079a5ffda56d, maxhealth )
{
    if ( !istrue( level.var_be6a42242be00b66 ) )
    {
        return;
    }
    
    self.var_e913079a5ffda56d = var_e913079a5ffda56d;
    self.maxhealth = maxhealth;
}

