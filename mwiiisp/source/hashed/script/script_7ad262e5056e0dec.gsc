#using scripts\common\utility;

#namespace character_iw9_ally_frogman;

// Namespace character_iw9_ally_frogman / namespace_9dc8ee1894fa55be
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xc7
// Size: 0x9a
function private autoexec init()
{
    character = #"character_iw9_ally_frogman";
    
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

// Namespace character_iw9_ally_frogman / namespace_9dc8ee1894fa55be
// Params 0
// Checksum 0x0, Offset: 0x169
// Size: 0xbb
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"unitedstates";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setmodel( "body_mp_milsim_navy_frogman_1_1" );
    self attach( "head_mp_milsim_navy_frogman_1_1", "", 1 );
    self.headmodel = "head_mp_milsim_navy_frogman_1_1";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_iw9_ally_frogman / namespace_9dc8ee1894fa55be
// Params 0
// Checksum 0x0, Offset: 0x22c
// Size: 0x2
function precache()
{
    
}

// Namespace character_iw9_ally_frogman / namespace_9dc8ee1894fa55be
// Params 0
// Checksum 0x0, Offset: 0x236
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_mp_milsim_navy_frogman_1_1" );
    precachemodel( "head_mp_milsim_navy_frogman_1_1" );
}

// Namespace character_iw9_ally_frogman / namespace_9dc8ee1894fa55be
// Params 0
// Checksum 0x0, Offset: 0x25d
// Size: 0x9
function precache_cpmp()
{
    precache();
}

