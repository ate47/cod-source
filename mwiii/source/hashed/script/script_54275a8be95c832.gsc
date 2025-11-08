#using scripts\common\utility;

#namespace character_jup_zombie_mimic_hvt;

// Namespace character_jup_zombie_mimic_hvt / namespace_95d5cbb54220c81c
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xeb
// Size: 0x9b
function private autoexec init()
{
    character = #"character_jup_zombie_mimic_hvt";
    
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

// Namespace character_jup_zombie_mimic_hvt / namespace_95d5cbb54220c81c
// Params 0
// Checksum 0x0, Offset: 0x18e
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "zombie_mimic_hvt";
    self.voice = #"unitedstates";
    self.bhasthighholster = 0;
    self.animtree = "zombie_mimic";
    self setmodel( "c_jup_zmb_mimic_hvt" );
    self attach( "c_jup_zmb_mimic_head_hvt", "", 1 );
    self.headmodel = "c_jup_zmb_mimic_head_hvt";
    self setclothtype( #"vestheavy" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_16c36cf98afe63cd" );
    }
}

// Namespace character_jup_zombie_mimic_hvt / namespace_95d5cbb54220c81c
// Params 0
// Checksum 0x0, Offset: 0x250
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_zombie_mimic_hvt / namespace_95d5cbb54220c81c
// Params 0
// Checksum 0x0, Offset: 0x25a
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "c_jup_zmb_mimic_hvt" );
    precachemodel( "c_jup_zmb_mimic_head_hvt" );
}

// Namespace character_jup_zombie_mimic_hvt / namespace_95d5cbb54220c81c
// Params 0
// Checksum 0x0, Offset: 0x281
// Size: 0x9
function precache_cpmp()
{
    precache();
}

