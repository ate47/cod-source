#using scripts\common\utility;

#namespace character_jup_enemy_warlord_maestro;

// Namespace character_jup_enemy_warlord_maestro / namespace_aff6b15a4e71a8d7
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xf6
// Size: 0x9b
function private autoexec init()
{
    character = #"character_jup_enemy_warlord_maestro";
    
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

// Namespace character_jup_enemy_warlord_maestro / namespace_aff6b15a4e71a8d7
// Params 0
// Checksum 0x0, Offset: 0x199
// Size: 0xbb
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "warlord_maestro_rainmaker";
    self.voice = #"shadowcompany";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_ext_maestro" );
    self attach( "head_c_jup_ext_maestro", "", 1 );
    self.headmodel = "head_c_jup_ext_maestro";
    self setclothtype( #"vestlight" );
    self setgeartype( #"milmedgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_jup_enemy_warlord_maestro / namespace_aff6b15a4e71a8d7
// Params 0
// Checksum 0x0, Offset: 0x25c
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_enemy_warlord_maestro / namespace_aff6b15a4e71a8d7
// Params 0
// Checksum 0x0, Offset: 0x266
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_ext_maestro" );
    precachemodel( "head_c_jup_ext_maestro" );
}

// Namespace character_jup_enemy_warlord_maestro / namespace_aff6b15a4e71a8d7
// Params 0
// Checksum 0x0, Offset: 0x28d
// Size: 0x9
function precache_cpmp()
{
    precache();
}

