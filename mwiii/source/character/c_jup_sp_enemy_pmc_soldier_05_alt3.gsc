#using scripts\common\utility;

#namespace c_jup_sp_enemy_pmc_soldier_05_alt3;

// Namespace c_jup_sp_enemy_pmc_soldier_05_alt3 / character\c_jup_sp_enemy_pmc_soldier_05_alt3
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x105
// Size: 0x9b
function private autoexec init()
{
    character = #"c_jup_sp_enemy_pmc_soldier_05_alt3";
    
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
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace c_jup_sp_enemy_pmc_soldier_05_alt3 / character\c_jup_sp_enemy_pmc_soldier_05_alt3
// Params 0
// Checksum 0x0, Offset: 0x1a8
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"russian";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_enemy_pmc_soldier_05_alt" );
    self attach( "head_c_jup_sp_enemy_pmc_soldier_05_alt3", "", 1 );
    self.headmodel = "head_c_jup_sp_enemy_pmc_soldier_05_alt3";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_enemy_pmc_soldier_05_alt3 / character\c_jup_sp_enemy_pmc_soldier_05_alt3
// Params 0
// Checksum 0x0, Offset: 0x26a
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_enemy_pmc_soldier_05_alt3 / character\c_jup_sp_enemy_pmc_soldier_05_alt3
// Params 0
// Checksum 0x0, Offset: 0x274
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_enemy_pmc_soldier_05_alt" );
    precachemodel( "head_c_jup_sp_enemy_pmc_soldier_05_alt3" );
}

// Namespace c_jup_sp_enemy_pmc_soldier_05_alt3 / character\c_jup_sp_enemy_pmc_soldier_05_alt3
// Params 0
// Checksum 0x0, Offset: 0x29b
// Size: 0x9
function precache_cpmp()
{
    precache();
}

