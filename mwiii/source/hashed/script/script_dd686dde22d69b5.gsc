#using scripts\common\utility;

#namespace character_jup_ava_jansen_base;

// Namespace character_jup_ava_jansen_base / namespace_4536c60af573221d
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xf6
// Size: 0x9b
function private autoexec init()
{
    character = #"character_jup_ava_jansen_base";
    
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

// Namespace character_jup_ava_jansen_base / namespace_4536c60af573221d
// Params 0
// Checksum 0x0, Offset: 0x199
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"unitednationsfemale";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_zmb_npc_ava_jansen" );
    self attach( "head_c_jup_zmb_npc_ava_jansen_lod1", "", 1 );
    self.headmodel = "head_c_jup_zmb_npc_ava_jansen_lod1";
    self setclothtype( #"vestlight" );
    self setgeartype( #"milmedgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_jup_ava_jansen_base / namespace_4536c60af573221d
// Params 0
// Checksum 0x0, Offset: 0x25b
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_ava_jansen_base / namespace_4536c60af573221d
// Params 0
// Checksum 0x0, Offset: 0x265
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_zmb_npc_ava_jansen" );
    precachemodel( "head_c_jup_zmb_npc_ava_jansen_lod1" );
}

// Namespace character_jup_ava_jansen_base / namespace_4536c60af573221d
// Params 0
// Checksum 0x0, Offset: 0x28c
// Size: 0x9
function precache_cpmp()
{
    precache();
}

