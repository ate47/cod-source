#using scripts\common\utility;

#namespace character_jup_capture_bot;

// Namespace character_jup_capture_bot / namespace_7eb5c3a922f62367
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xad
// Size: 0x9b
function private autoexec init()
{
    character = #"character_jup_capture_bot";
    
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

// Namespace character_jup_capture_bot / namespace_7eb5c3a922f62367
// Params 0
// Checksum 0x0, Offset: 0x150
// Size: 0x99
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "capture_bot";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "capture_bot";
    self setmodel( "tag_origin" );
    self setclothtype( #"vestlight" );
    self setgeartype( #"none" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_jup_capture_bot / namespace_7eb5c3a922f62367
// Params 0
// Checksum 0x0, Offset: 0x1f1
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_capture_bot / namespace_7eb5c3a922f62367
// Params 0
// Checksum 0x0, Offset: 0x1fb
// Size: 0x14
function precache_sp()
{
    precache();
    precachemodel( "tag_origin" );
}

// Namespace character_jup_capture_bot / namespace_7eb5c3a922f62367
// Params 0
// Checksum 0x0, Offset: 0x217
// Size: 0x9
function precache_cpmp()
{
    precache();
}

