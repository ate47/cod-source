#using scripts\common\utility;

#namespace c_jup_ob_enemy_pmc_spforce_05;

// Namespace c_jup_ob_enemy_pmc_spforce_05 / namespace_4dc2ef625e9b424f
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xf9
// Size: 0x9b
function private autoexec init()
{
    character = #"c_jup_ob_enemy_pmc_spforce_05";
    
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

// Namespace c_jup_ob_enemy_pmc_spforce_05 / namespace_4dc2ef625e9b424f
// Params 0
// Checksum 0x0, Offset: 0x19c
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"russian";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_enemy_pmc_spforce_05" );
    self attach( "head_c_jup_ob_enemy_pmc_capt_01", "", 1 );
    self.headmodel = "head_c_jup_ob_enemy_pmc_capt_01";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_ob_enemy_pmc_spforce_05 / namespace_4dc2ef625e9b424f
// Params 0
// Checksum 0x0, Offset: 0x25e
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_ob_enemy_pmc_spforce_05 / namespace_4dc2ef625e9b424f
// Params 0
// Checksum 0x0, Offset: 0x268
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_enemy_pmc_spforce_05" );
    precachemodel( "head_c_jup_ob_enemy_pmc_capt_01" );
}

// Namespace c_jup_ob_enemy_pmc_spforce_05 / namespace_4dc2ef625e9b424f
// Params 0
// Checksum 0x0, Offset: 0x28f
// Size: 0x9
function precache_cpmp()
{
    precache();
}

