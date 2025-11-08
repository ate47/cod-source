#using script_3b78d23dad7ec5be;
#using script_7edf952f8921aa6b;
#using scripts\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\values;
#using scripts\engine\utility;

#namespace zombie_base_knockdown;

// Namespace zombie_base_knockdown / scripts\aitypes\zombie_base\zombie_base_knockdown
// Params 0
// Checksum 0x0, Offset: 0x10f
// Size: 0x42
function function_976734974e28596e()
{
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &on_damaged );
    callback::get_template( self.animsetname ) callback::add( "on_is_crawling_changed", &on_is_crawling_changed );
}

// Namespace zombie_base_knockdown / scripts\aitypes\zombie_base\zombie_base_knockdown
// Params 0
// Checksum 0x0, Offset: 0x159
// Size: 0x1a
function init_knockdown()
{
    self.knockdowndamagethreshold = self.health * 0.01;
}

// Namespace zombie_base_knockdown / scripts\aitypes\zombie_base\zombie_base_knockdown
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x17b
// Size: 0x9c
function private on_damaged( params )
{
    if ( isexplosivedamagemod( params.smeansofdeath ) && ( !isdefined( params.einflictor ) || !istrue( params.einflictor.prevent_knockdown ) ) && !function_aa75c57142022473( params.sweapon ) )
    {
        if ( params.idamage > self.knockdowndamagethreshold )
        {
            if ( !function_e67a89537ae7d4b7() )
            {
                knockdown_ai( params.vpoint );
            }
        }
    }
    
    return params.idamage;
}

// Namespace zombie_base_knockdown / scripts\aitypes\zombie_base\zombie_base_knockdown
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x220
// Size: 0x22
function private on_is_crawling_changed( params )
{
    val::set( "is_crawling", "disallow_knockdown", scripts\aitypes\zombie_base\zombie_base_dismemberment::is_crawling() );
}

// Namespace zombie_base_knockdown / scripts\aitypes\zombie_base\zombie_base_knockdown
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x24a
// Size: 0x50, Type: bool
function private function_aa75c57142022473( weapon_object )
{
    if ( isdefined( weapon_object ) && isdefined( weapon_object.basename ) && isdefined( level.var_c16493593d07b88f ) && array_contains( level.var_c16493593d07b88f, weapon_object.basename ) )
    {
        return true;
    }
    
    return false;
}

