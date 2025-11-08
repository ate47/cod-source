#using scripts\common\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_collision;
#using scripts\cp_mp\vehicles\vehicle_compass;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_dlog;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;

#namespace namespace_2a0940ff51ea0cff;

// Namespace namespace_2a0940ff51ea0cff / namespace_405c71940c7ec9ea
// Params 0
// Checksum 0x0, Offset: 0x295
// Size: 0x13
function main()
{
    function_c0b3ddc9a6bdcc46( "veh9_techo_rebel_armor", &function_c036143411f3540 );
}

// Namespace namespace_2a0940ff51ea0cff / namespace_405c71940c7ec9ea
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2b0
// Size: 0x4c
function private function_c036143411f3540()
{
    if ( !function_9697379150687859( "veh9_techo_rebel_armor" ) )
    {
        return;
    }
    
    callbacks = [];
    callbacks[ "spawn" ] = &function_c1b385596f29457e;
    callbacks[ "armorShouldMitigateDamage" ] = &function_96939d4c4815b891;
    function_8497e7e46b5e397( "veh9_techo_rebel_armor", callbacks );
    function_1b72aff42925d411();
}

// Namespace namespace_2a0940ff51ea0cff / namespace_405c71940c7ec9ea
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x304
// Size: 0xd8
function private function_1b72aff42925d411()
{
    var_f18669893e89dd0 = undefined;
    var_44efe20b6ff851cb = undefined;
    
    if ( issharedfuncdefined( "veh9_techo_rebel_armor", "armorDamageFeedback" ) )
    {
        var_f18669893e89dd0 = getsharedfunc( "veh9_techo_rebel_armor", "armorDamageFeedback" );
    }
    
    if ( issharedfuncdefined( "veh9_techo_rebel_armor", "armorDeathFeedback" ) )
    {
        var_44efe20b6ff851cb = getsharedfunc( "veh9_techo_rebel_armor", "armorDeathFeedback" );
    }
    
    if ( isdefined( var_f18669893e89dd0 ) || isdefined( var_44efe20b6ff851cb ) )
    {
        foreach ( parttag, data in function_870cbf6ca47076b6( "veh9_techo_rebel_armor" ) )
        {
            if ( issubstr( parttag, "tag_armor" ) )
            {
                function_bc320cf9a1b27cb5( "veh9_techo_rebel_armor", parttag, var_44efe20b6ff851cb, var_f18669893e89dd0 );
            }
        }
    }
}

// Namespace namespace_2a0940ff51ea0cff / namespace_405c71940c7ec9ea
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x3e4
// Size: 0x5c
function private function_c1b385596f29457e( spawndata, faildata )
{
    vehicle = function_bba34cf920370ff4( "veh9_techo_rebel_armor", spawndata, faildata );
    
    if ( issharedfuncdefined( "veh9_techo_rebel_armor", "armorDamageMitigation" ) )
    {
        vehicle.var_7a646ff827387ac0 = getsharedfunc( "veh9_techo_rebel_armor", "armorDamageMitigation" );
    }
    
    return vehicle;
}

// Namespace namespace_2a0940ff51ea0cff / namespace_405c71940c7ec9ea
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x449
// Size: 0x2ca, Type: bool
function private function_96939d4c4815b891( partname, meansofdeath, damagelocation, objweapon )
{
    if ( isdefined( partname ) && partname != "tag_origin" && partname != "" && partname != "none" )
    {
        return true;
    }
    else if ( isexplosivedamagemod( meansofdeath ) )
    {
        dir = vectornormalize( ( damagelocation - self.origin ) * ( 1, 1, 0 ) );
        fwd = anglestoright( self.angles );
        dot = vectordot( dir, fwd );
        pos = [];
        
        if ( dot > 0 )
        {
            taginfo = function_8a52a8aab7e2b441( "tag_armor_15" );
            
            if ( isdefined( taginfo ) )
            {
                pos[ pos.size ] = taginfo;
            }
            
            taginfo = function_8a52a8aab7e2b441( "tag_armor_12" );
            
            if ( isdefined( taginfo ) )
            {
                pos[ pos.size ] = taginfo;
            }
            
            taginfo = function_8a52a8aab7e2b441( "tag_armor_07" );
            
            if ( isdefined( taginfo ) )
            {
                pos[ pos.size ] = taginfo;
            }
            
            taginfo = function_8a52a8aab7e2b441( "tag_armor_14" );
            
            if ( isdefined( taginfo ) )
            {
                pos[ pos.size ] = taginfo;
            }
            
            taginfo = function_8a52a8aab7e2b441( "tag_armor_08" );
            
            if ( isdefined( taginfo ) )
            {
                pos[ pos.size ] = taginfo;
            }
            
            taginfo = function_8a52a8aab7e2b441( "tag_armor_17" );
            
            if ( isdefined( taginfo ) )
            {
                pos[ pos.size ] = taginfo;
            }
        }
        else if ( dot < 0 )
        {
            taginfo = function_8a52a8aab7e2b441( "tag_armor_05" );
            
            if ( isdefined( taginfo ) )
            {
                pos[ pos.size ] = taginfo;
            }
            
            taginfo = function_8a52a8aab7e2b441( "tag_armor_11" );
            
            if ( isdefined( taginfo ) )
            {
                pos[ pos.size ] = taginfo;
            }
            
            taginfo = function_8a52a8aab7e2b441( "tag_armor_19" );
            
            if ( isdefined( taginfo ) )
            {
                pos[ pos.size ] = taginfo;
            }
            
            taginfo = function_8a52a8aab7e2b441( "tag_armor_18" );
            
            if ( isdefined( taginfo ) )
            {
                pos[ pos.size ] = taginfo;
            }
            
            taginfo = function_8a52a8aab7e2b441( "tag_armor_13" );
            
            if ( isdefined( taginfo ) )
            {
                pos[ pos.size ] = taginfo;
            }
            
            taginfo = function_8a52a8aab7e2b441( "tag_armor_16" );
            
            if ( isdefined( taginfo ) )
            {
                pos[ pos.size ] = taginfo;
            }
        }
        
        taginfo = function_8a52a8aab7e2b441( "tag_armor_01" );
        
        if ( isdefined( taginfo ) )
        {
            pos[ pos.size ] = taginfo;
        }
        
        taginfo = function_8a52a8aab7e2b441( "tag_armor_02" );
        
        if ( isdefined( taginfo ) )
        {
            pos[ pos.size ] = taginfo;
        }
        
        taginfo = function_8a52a8aab7e2b441( "tag_armor_06" );
        
        if ( isdefined( taginfo ) )
        {
            pos[ pos.size ] = taginfo;
        }
        
        damage_positions = get_array_of_closest( damagelocation, pos, undefined, undefined, 250, 0 );
        
        if ( damage_positions.size )
        {
            if ( distancesquared( damagelocation, damage_positions[ 0 ].origin ) < 10000 )
            {
                if ( isdefined( self.damageableparts ) && isdefined( self.damageableparts[ damage_positions[ 0 ].tagname ] ) && self.damageableparts[ damage_positions[ 0 ].tagname ].healthvalue < 1 )
                {
                    return false;
                }
                
                return true;
            }
        }
    }
    
    return false;
}

// Namespace namespace_2a0940ff51ea0cff / namespace_405c71940c7ec9ea
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x71c
// Size: 0x49
function private function_8a52a8aab7e2b441( tagname )
{
    if ( self tagexists( tagname ) )
    {
        info = spawnstruct();
        info.origin = self gettagorigin( tagname );
        info.tagname = tagname;
        return info;
    }
    
    return undefined;
}

