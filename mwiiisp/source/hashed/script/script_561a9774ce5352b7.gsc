#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_c_jup_sp_enemy_rusdelegate;
#using xmodelalias\heads_jup_sp_enemy_kastovsoldier_01;

#namespace character_jup_civ_rusdelegate;

// Namespace character_jup_civ_rusdelegate / namespace_45dfc957a7965bdb
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x125
// Size: 0xb3
function private autoexec init()
{
    character = #"character_jup_civ_rusdelegate";
    
    if ( !isdefined( level.fncharacter ) )
    {
        level.fncharacter = [];
    }
    
    if ( !isdefined( level.fncharacterprecache ) )
    {
        level.fncharacterprecache = [];
    }
    
    if ( !isdefined( level.fncharacterxmodelalias ) )
    {
        level.fncharacterxmodelalias = [];
    }
    
    level.fncharacter[ character ] = &main;
    
    if ( issp() )
    {
        level.fncharacterprecache[ character ] = &precache_sp;
        level.fncharacterxmodelalias[ %"character_jup_civ_rusdelegate" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace character_jup_civ_rusdelegate / namespace_45dfc957a7965bdb
// Params 0
// Checksum 0x0, Offset: 0x1e0
// Size: 0xb1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react";
    self.voice = #"russian";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "bodies_c_jup_sp_enemy_rusdelegate", xmodelalias\bodies_c_jup_sp_enemy_rusdelegate::main() );
    scripts\code\character::attachhead( "heads_jup_sp_enemy_kastovsoldier_01", xmodelalias\heads_jup_sp_enemy_kastovsoldier_01::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_jup_civ_rusdelegate / namespace_45dfc957a7965bdb
// Params 0
// Checksum 0x0, Offset: 0x299
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_civ_rusdelegate / namespace_45dfc957a7965bdb
// Params 0
// Checksum 0x0, Offset: 0x2a3
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\bodies_c_jup_sp_enemy_rusdelegate::main() );
    scripts\code\character::precachemodelarray( xmodelalias\heads_jup_sp_enemy_kastovsoldier_01::main() );
}

// Namespace character_jup_civ_rusdelegate / namespace_45dfc957a7965bdb
// Params 0
// Checksum 0x0, Offset: 0x2ce
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace character_jup_civ_rusdelegate / namespace_45dfc957a7965bdb
// Params 1
// Checksum 0x0, Offset: 0x2df
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_e337c9cf32f37b46":
            return xmodelalias\bodies_c_jup_sp_enemy_rusdelegate::main();
        case #"hash_de3b73cd07d55560":
            return xmodelalias\heads_jup_sp_enemy_kastovsoldier_01::main();
    }
    
    assert( 0, "character_jup_civ_rusdelegate do not have any xmodelalias" );
}

