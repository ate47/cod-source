#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\heads_jup_sp_enemy_kastovsoldier_female;

#namespace c_jup_sp_enemy_kastovsoldier_female_civ;

// Namespace c_jup_sp_enemy_kastovsoldier_female_civ / namespace_e13a9367ca0c4d0
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x12f
// Size: 0xb3
function private autoexec init()
{
    character = #"c_jup_sp_enemy_kastovsoldier_female_civ";
    
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
        level.fncharacterxmodelalias[ %"c_jup_sp_enemy_kastovsoldier_female_civ" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace c_jup_sp_enemy_kastovsoldier_female_civ / namespace_e13a9367ca0c4d0
// Params 0
// Checksum 0x0, Offset: 0x1ea
// Size: 0xab
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react_female";
    self.voice = #"russianfemale";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_hero_laswell_bdu" );
    scripts\code\character::attachhead( "heads_jup_sp_enemy_kastovsoldier_female", xmodelalias\heads_jup_sp_enemy_kastovsoldier_female::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_enemy_kastovsoldier_female_civ / namespace_e13a9367ca0c4d0
// Params 0
// Checksum 0x0, Offset: 0x29d
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_enemy_kastovsoldier_female_civ / namespace_e13a9367ca0c4d0
// Params 0
// Checksum 0x0, Offset: 0x2a7
// Size: 0x21
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_hero_laswell_bdu" );
    scripts\code\character::precachemodelarray( xmodelalias\heads_jup_sp_enemy_kastovsoldier_female::main() );
}

// Namespace c_jup_sp_enemy_kastovsoldier_female_civ / namespace_e13a9367ca0c4d0
// Params 0
// Checksum 0x0, Offset: 0x2d0
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace c_jup_sp_enemy_kastovsoldier_female_civ / namespace_e13a9367ca0c4d0
// Params 1
// Checksum 0x0, Offset: 0x2e1
// Size: 0x36
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_1f13018c0ea66403":
            return xmodelalias\heads_jup_sp_enemy_kastovsoldier_female::main();
    }
    
    assert( 0, "c_jup_sp_enemy_kastovsoldier_female_civ do not have any xmodelalias" );
}

