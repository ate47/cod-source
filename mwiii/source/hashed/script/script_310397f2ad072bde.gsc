#using script_3b78d23dad7ec5be;
#using script_7edf952f8921aa6b;
#using scripts\common\callbacks;

#namespace namespace_7062ba3752363b0;

// Namespace namespace_7062ba3752363b0 / namespace_93602eb41105ea2a
// Params 0
// Checksum 0x0, Offset: 0xa0
// Size: 0x26
function init_knockdown()
{
    function_b5e57408c7878df7( &on_damaged );
    self.knockdowndamagethreshold = self.health * 0.01;
}

// Namespace namespace_7062ba3752363b0 / namespace_93602eb41105ea2a
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xce
// Size: 0x87
function private on_damaged( params )
{
    if ( isexplosivedamagemod( params.smeansofdeath ) && ( !isdefined( params.einflictor ) || !istrue( params.einflictor.prevent_knockdown ) ) )
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

