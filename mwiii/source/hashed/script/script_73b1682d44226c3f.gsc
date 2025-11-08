#using scripts\common\utility;

#namespace character_iw9_usmc;

// Namespace character_iw9_usmc / namespace_c2bf947ac8ea30e1
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xe8
// Size: 0x9b
function private autoexec init()
{
    character = #"character_iw9_usmc";
    
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

// Namespace character_iw9_usmc / namespace_c2bf947ac8ea30e1
// Params 0
// Checksum 0x0, Offset: 0x18b
// Size: 0xbb
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"unitedstates";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setmodel( "body_sp_ally_usmc_ar_1_1" );
    self attach( "head_sp_ally_usmc_ar_1_1", "", 1 );
    self.headmodel = "head_sp_ally_usmc_ar_1_1";
    self setclothtype( #"vestheavy" );
    self setgeartype( #"milhvygr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_iw9_usmc / namespace_c2bf947ac8ea30e1
// Params 0
// Checksum 0x0, Offset: 0x24e
// Size: 0x2
function precache()
{
    
}

// Namespace character_iw9_usmc / namespace_c2bf947ac8ea30e1
// Params 0
// Checksum 0x0, Offset: 0x258
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_sp_ally_usmc_ar_1_1" );
    precachemodel( "head_sp_ally_usmc_ar_1_1" );
}

// Namespace character_iw9_usmc / namespace_c2bf947ac8ea30e1
// Params 0
// Checksum 0x0, Offset: 0x27f
// Size: 0x9
function precache_cpmp()
{
    precache();
}

