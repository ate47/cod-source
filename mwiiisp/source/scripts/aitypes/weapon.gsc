#using scripts\aitypes\bt_util;
#using scripts\aitypes\combat;
#using scripts\anim\utility_common;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace weapon;

// Namespace weapon / scripts\aitypes\weapon
// Params 0
// Checksum 0x0, Offset: 0xb6
// Size: 0x99
function initweaponarray()
{
    self.weapons = [];
    
    if ( !isnullweapon( self.primaryweapon ) )
    {
        self.weapons[ self.weapons.size ] = self.primaryweapon;
    }
    
    if ( !isnullweapon( self.secondaryweapon ) )
    {
        self.weapons[ self.weapons.size ] = self.secondaryweapon;
    }
    
    if ( !isnullweapon( self.sidearm ) )
    {
        self.weapons[ self.weapons.size ] = self.sidearm;
    }
}

// Namespace weapon / scripts\aitypes\weapon
// Params 0
// Checksum 0x0, Offset: 0x157
// Size: 0xc5
function choosebestweapon()
{
    if ( istrue( self.forcesidearm ) )
    {
        return "pistol";
    }
    
    if ( istrue( self._blackboard.droppedlmg ) )
    {
        return "pistol";
    }
    
    bestscore = 0;
    bestweaponclass = undefined;
    
    foreach ( weapon in self.weapons )
    {
        weapclass = weaponclass( weapon );
        score = evalweaponscore( weapclass, weapon );
        
        if ( score > bestscore )
        {
            bestscore = score;
            bestweaponclass = weapclass;
        }
    }
    
    return bestweaponclass;
}

// Namespace weapon / scripts\aitypes\weapon
// Params 0
// Checksum 0x0, Offset: 0x225
// Size: 0x47
function getsidearmdist()
{
    var_8465f7779f8a19a = isusingsidearm();
    sidearmdist = 409;
    bsniper = self aiissniper( 0 );
    
    if ( bsniper )
    {
        sidearmdist = 512;
    }
    
    if ( var_8465f7779f8a19a )
    {
        sidearmdist += 36;
    }
    
    return sidearmdist;
}

// Namespace weapon / scripts\aitypes\weapon
// Params 0
// Checksum 0x0, Offset: 0x275
// Size: 0x81, Type: bool
function withinswitchtopistoldist()
{
    if ( isdefined( self.enemy ) && isdefined( self.sidearm ) && !isnullweapon( self.sidearm ) && !istrue( self.disablepistol ) )
    {
        sidearmdist = getsidearmdist();
        disttoenemysq = distancesquared( self.origin, self.enemy.origin );
        return ( disttoenemysq < sidearmdist * sidearmdist );
    }
    
    return false;
}

// Namespace weapon / scripts\aitypes\weapon
// Params 2
// Checksum 0x0, Offset: 0x2ff
// Size: 0x16f
function evalweaponscore( weapclass, weapon )
{
    if ( weapclass == "pistol" )
    {
        if ( weaponclass( self.weapon ) == "rocketlauncher" && self.rocketammo <= 0 )
        {
            return 1000;
        }
        
        if ( canswitchtosidearm( undefined ) != anim.success )
        {
            return 0;
        }
        
        covernode = scripts\asm\asm_bb::bb_getcovernode();
        
        if ( usingmg() && isdefined( covernode ) && !self iscovervalidagainstenemy( covernode ) )
        {
            return 1000;
        }
        
        if ( checkcoverforsidearm( undefined ) != anim.success )
        {
            return 0;
        }
        
        withindist = withinswitchtopistoldist();
        bsniper = self aiissniper( 0 );
        
        if ( withindist )
        {
            assert( isdefined( self.enemy ) );
            disttoenemysq = distancesquared( self.origin, self.enemy.origin );
            
            if ( bsniper )
            {
                return 1000;
            }
            
            if ( usingmg() && disttoenemysq < 16384 )
            {
                return 1000;
            }
            
            if ( isusingprimary() && scripts\aitypes\combat::hasatleastammo( 0.1 ) )
            {
                return 10;
            }
            
            return 1000;
        }
        
        return 0;
    }
    else if ( weapclass == "rocketlauncher" )
    {
        if ( self.rocketammo <= 0 )
        {
            return 0;
        }
        
        return 100;
    }
    else
    {
        return 100;
    }
    
    return 100;
}

// Namespace weapon / scripts\aitypes\weapon
// Params 1
// Checksum 0x0, Offset: 0x477
// Size: 0x27
function issniper( task )
{
    if ( self aiissniper() )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace weapon / scripts\aitypes\weapon
// Params 1
// Checksum 0x0, Offset: 0x4a7
// Size: 0x46
function usingsidearm( task )
{
    if ( self.weapon == self.sidearm && !isnullweapon( self.weapon ) )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace weapon / scripts\aitypes\weapon
// Params 1
// Checksum 0x0, Offset: 0x4f6
// Size: 0x85
function shouldswitchtosidearm( task )
{
    if ( usingsidearm( task ) == anim.success )
    {
        return anim.failure;
    }
    
    if ( istrue( self.forcesidearm ) )
    {
        return anim.success;
    }
    
    if ( canswitchtosidearm( task ) != anim.success )
    {
        return anim.failure;
    }
    
    if ( checkcoverforsidearm( task ) != anim.success )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace weapon / scripts\aitypes\weapon
// Params 1
// Checksum 0x0, Offset: 0x584
// Size: 0x77
function canswitchtosidearm( task )
{
    if ( istrue( self.disablepistol ) )
    {
        return anim.failure;
    }
    
    if ( bb_moverequested() && isdefined( self.pathgoalpos ) && length2dsquared( self.velocity ) > 1 )
    {
        return anim.failure;
    }
    
    if ( self.in_melee )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace weapon / scripts\aitypes\weapon
// Params 1
// Checksum 0x0, Offset: 0x604
// Size: 0x54
function checkcoverforsidearm( task )
{
    covernode = scripts\asm\asm_bb::bb_getcovernode();
    
    if ( isdefined( covernode ) && distance( self.origin, covernode.origin ) < 16 )
    {
        return anim.failure;
    }
    
    return anim.success;
}

