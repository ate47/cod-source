#using scripts\common\utility;

#namespace character_jup_zombie_disciple_pet;

// Namespace character_jup_zombie_disciple_pet / namespace_a02f4c5d421fe415
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xd4
// Size: 0x9b
function private autoexec init()
{
    character = #"character_jup_zombie_disciple_pet";
    
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

// Namespace character_jup_zombie_disciple_pet / namespace_a02f4c5d421fe415
// Params 0
// Checksum 0x0, Offset: 0x177
// Size: 0x99
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "zombie_disciple_pet";
    self.voice = #"unitedstates";
    self.bhasthighholster = 0;
    self.animtree = "zombie_disciple";
    self setmodel( "c_jup_zmb_disciple_body" );
    self setclothtype( #"vestheavy" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_16c36cf98afe63cd" );
    }
}

// Namespace character_jup_zombie_disciple_pet / namespace_a02f4c5d421fe415
// Params 0
// Checksum 0x0, Offset: 0x218
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_zombie_disciple_pet / namespace_a02f4c5d421fe415
// Params 0
// Checksum 0x0, Offset: 0x222
// Size: 0x14
function precache_sp()
{
    precache();
    precachemodel( "c_jup_zmb_disciple_body" );
}

// Namespace character_jup_zombie_disciple_pet / namespace_a02f4c5d421fe415
// Params 0
// Checksum 0x0, Offset: 0x23e
// Size: 0x9
function precache_cpmp()
{
    precache();
}

