#using scripts\common\utility;

#namespace character_jup_zombie_disciple_hvt;

// Namespace character_jup_zombie_disciple_hvt / namespace_4671825c45957bae
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xc2
// Size: 0x9b
function private autoexec init()
{
    character = #"character_jup_zombie_disciple_hvt";
    
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

// Namespace character_jup_zombie_disciple_hvt / namespace_4671825c45957bae
// Params 0
// Checksum 0x0, Offset: 0x165
// Size: 0x99
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "zombie_disciple";
    self.voice = #"unitedstates";
    self.bhasthighholster = 0;
    self.animtree = "zombie_disciple";
    self setmodel( "c_jup_zmb_disciple_body_hvt" );
    self setclothtype( #"vestheavy" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_16c36cf98afe63cd" );
    }
}

// Namespace character_jup_zombie_disciple_hvt / namespace_4671825c45957bae
// Params 0
// Checksum 0x0, Offset: 0x206
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_zombie_disciple_hvt / namespace_4671825c45957bae
// Params 0
// Checksum 0x0, Offset: 0x210
// Size: 0x14
function precache_sp()
{
    precache();
    precachemodel( "c_jup_zmb_disciple_body_hvt" );
}

// Namespace character_jup_zombie_disciple_hvt / namespace_4671825c45957bae
// Params 0
// Checksum 0x0, Offset: 0x22c
// Size: 0x9
function precache_cpmp()
{
    precache();
}

