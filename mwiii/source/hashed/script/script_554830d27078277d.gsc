#using script_5a4a5d9ba343ff8f;
#using scripts\engine\utility;

#namespace effect_charm;

// Namespace effect_charm / namespace_e1179dfac473753b
// Params 3
// Checksum 0x0, Offset: 0xa1
// Size: 0xc9
function charm( durations, attacker, end_callback )
{
    if ( !istrue( self.aisettings.var_d9f86989ad15047e ) )
    {
        return 0;
    }
    
    if ( function_8ce7894f1a52fb77( "charm" ) )
    {
        return 0;
    }
    
    assert( isdefined( attacker.team ) );
    charm_effect = function_108973a907c11ca7( "charm", durations, undefined, &start_charm, &end_charm );
    charm_effect.original_team = self.team;
    charm_effect.attacker = attacker;
    charm_effect.new_team = attacker.team;
    charm_effect.end_callback = end_callback;
    return start_effect( charm_effect );
}

// Namespace effect_charm / namespace_e1179dfac473753b
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x173
// Size: 0x42
function private start_charm( effect )
{
    self.health = self.maxhealth;
    self.allowpain = 0;
    self.team = effect.new_team;
    self clearpath();
}

// Namespace effect_charm / namespace_e1179dfac473753b
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1bd
// Size: 0x4f
function private end_charm( effect )
{
    self.allowpain = 1;
    self.team = effect.original_team;
    self clearpath();
    
    if ( isdefined( effect.end_callback ) )
    {
        self [[ effect.end_callback ]]();
    }
}

