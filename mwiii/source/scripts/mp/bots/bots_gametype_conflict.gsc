#using script_27fdece778e999d8;
#using script_4a941421347ff7df;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;

#namespace bots_gametype_conflict;

// Namespace bots_gametype_conflict / scripts\mp\bots\bots_gametype_conflict
// Params 0
// Checksum 0x0, Offset: 0xbe
// Size: 0x9
function main()
{
    setup_callbacks();
}

/#

    // Namespace bots_gametype_conflict / scripts\mp\bots\bots_gametype_conflict
    // Params 0
    // Checksum 0x0, Offset: 0xcf
    // Size: 0x5, Type: dev
    function function_e45e46b7c35deadb()
    {
        
    }

#/

// Namespace bots_gametype_conflict / scripts\mp\bots\bots_gametype_conflict
// Params 0
// Checksum 0x0, Offset: 0xdc
// Size: 0xe
function setup_callbacks()
{
    initialize( &function_a3ba36b8f9e1f910 );
}

// Namespace bots_gametype_conflict / scripts\mp\bots\bots_gametype_conflict
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xf2
// Size: 0x28
function private function_a3ba36b8f9e1f910( mind_personality )
{
    var_577f45571c039a54 = namespace_823e1abd5161abb1::function_e65493518b3de050();
    var_577f45571c039a54[ var_577f45571c039a54.size ] = "ControlFob";
    return var_577f45571c039a54;
}

