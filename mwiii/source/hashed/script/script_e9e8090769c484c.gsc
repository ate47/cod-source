#using scripts\common\utility;

#namespace character_jup_enemy_warlord_allforone;

// Namespace character_jup_enemy_warlord_allforone / namespace_d83fb0ce0a8be1b8
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xef
// Size: 0x9b
function private autoexec init()
{
    character = #"character_jup_enemy_warlord_allforone";
    
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

// Namespace character_jup_enemy_warlord_allforone / namespace_d83fb0ce0a8be1b8
// Params 0
// Checksum 0x0, Offset: 0x192
// Size: 0xbb
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "warlord_allforone";
    self.voice = #"shadowcompany";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setmodel( "body_sp_opforce_pmc_1_1" );
    self attach( "head_sp_opforce_pmc_1_1", "", 1 );
    self.headmodel = "head_sp_opforce_pmc_1_1";
    self setclothtype( #"vestlight" );
    self setgeartype( #"milmedgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_jup_enemy_warlord_allforone / namespace_d83fb0ce0a8be1b8
// Params 0
// Checksum 0x0, Offset: 0x255
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_enemy_warlord_allforone / namespace_d83fb0ce0a8be1b8
// Params 0
// Checksum 0x0, Offset: 0x25f
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_sp_opforce_pmc_1_1" );
    precachemodel( "head_sp_opforce_pmc_1_1" );
}

// Namespace character_jup_enemy_warlord_allforone / namespace_d83fb0ce0a8be1b8
// Params 0
// Checksum 0x0, Offset: 0x286
// Size: 0x9
function precache_cpmp()
{
    precache();
}

