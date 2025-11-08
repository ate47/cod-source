#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\heads_jup_sp_enemy_kastovsoldier_01;

#namespace c_jup_sp_enemy_kastovsoldier_01;

// Namespace c_jup_sp_enemy_kastovsoldier_01 / character\c_jup_sp_enemy_kastovsoldier_01
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x11b
// Size: 0xb3
function private autoexec init()
{
    character = #"c_jup_sp_enemy_kastovsoldier_01";
    
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
        level.fncharacterxmodelalias[ %"c_jup_sp_enemy_kastovsoldier_01" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace c_jup_sp_enemy_kastovsoldier_01 / character\c_jup_sp_enemy_kastovsoldier_01
// Params 0
// Checksum 0x0, Offset: 0x1d6
// Size: 0xac
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"russian";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_enemy_kastovsoldier_01" );
    scripts\code\character::attachhead( "heads_jup_sp_enemy_kastovsoldier_01", xmodelalias\heads_jup_sp_enemy_kastovsoldier_01::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_enemy_kastovsoldier_01 / character\c_jup_sp_enemy_kastovsoldier_01
// Params 0
// Checksum 0x0, Offset: 0x28a
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_enemy_kastovsoldier_01 / character\c_jup_sp_enemy_kastovsoldier_01
// Params 0
// Checksum 0x0, Offset: 0x294
// Size: 0x21
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_enemy_kastovsoldier_01" );
    scripts\code\character::precachemodelarray( xmodelalias\heads_jup_sp_enemy_kastovsoldier_01::main() );
}

// Namespace c_jup_sp_enemy_kastovsoldier_01 / character\c_jup_sp_enemy_kastovsoldier_01
// Params 0
// Checksum 0x0, Offset: 0x2bd
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace c_jup_sp_enemy_kastovsoldier_01 / character\c_jup_sp_enemy_kastovsoldier_01
// Params 1
// Checksum 0x0, Offset: 0x2ce
// Size: 0x36
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_de3b73cd07d55560":
            return xmodelalias\heads_jup_sp_enemy_kastovsoldier_01::main();
    }
    
    assert( 0, "c_jup_sp_enemy_kastovsoldier_01 do not have any xmodelalias" );
}

