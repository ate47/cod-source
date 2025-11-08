#using scripts\common\utility;

#namespace character_jup_fletcher_base;

// Namespace character_jup_fletcher_base / namespace_861c0bc2e2f8101a
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xe9
// Size: 0x9b
function private autoexec init()
{
    character = #"character_jup_fletcher_base";
    
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

// Namespace character_jup_fletcher_base / namespace_861c0bc2e2f8101a
// Params 0
// Checksum 0x0, Offset: 0x18c
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_zmb_npc_fletcher" );
    self attach( "head_c_jup_zmb_fletcher", "", 1 );
    self.headmodel = "head_c_jup_zmb_fletcher";
    self setclothtype( #"vestlight" );
    self setgeartype( #"milmedgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_jup_fletcher_base / namespace_861c0bc2e2f8101a
// Params 0
// Checksum 0x0, Offset: 0x24e
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_fletcher_base / namespace_861c0bc2e2f8101a
// Params 0
// Checksum 0x0, Offset: 0x258
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_zmb_npc_fletcher" );
    precachemodel( "head_c_jup_zmb_fletcher" );
}

// Namespace character_jup_fletcher_base / namespace_861c0bc2e2f8101a
// Params 0
// Checksum 0x0, Offset: 0x27f
// Size: 0x9
function precache_cpmp()
{
    precache();
}

