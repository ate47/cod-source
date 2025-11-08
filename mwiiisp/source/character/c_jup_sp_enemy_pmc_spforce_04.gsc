#using scripts\common\utility;

#namespace c_jup_sp_enemy_pmc_spforce_04;

// Namespace c_jup_sp_enemy_pmc_spforce_04 / character\c_jup_sp_enemy_pmc_spforce_04
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xcd
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_sp_enemy_pmc_spforce_04";
    
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

// Namespace c_jup_sp_enemy_pmc_spforce_04 / character\c_jup_sp_enemy_pmc_spforce_04
// Params 0
// Checksum 0x0, Offset: 0x16f
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"russian";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_enemy_pmc_spforce_04" );
    self attach( "head_c_jup_sp_enemy_pmc_spforce_04", "", 1 );
    self.headmodel = "head_c_jup_sp_enemy_pmc_spforce_04";
    self setclothtype( #"vestheavy" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_enemy_pmc_spforce_04 / character\c_jup_sp_enemy_pmc_spforce_04
// Params 0
// Checksum 0x0, Offset: 0x231
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_enemy_pmc_spforce_04 / character\c_jup_sp_enemy_pmc_spforce_04
// Params 0
// Checksum 0x0, Offset: 0x23b
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_enemy_pmc_spforce_04" );
    precachemodel( "head_c_jup_sp_enemy_pmc_spforce_04" );
}

// Namespace c_jup_sp_enemy_pmc_spforce_04 / character\c_jup_sp_enemy_pmc_spforce_04
// Params 0
// Checksum 0x0, Offset: 0x262
// Size: 0x9
function precache_cpmp()
{
    precache();
}

