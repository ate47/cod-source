#using scripts\common\utility;

#namespace c_jup_sp_hero_fitri;

// Namespace c_jup_sp_hero_fitri / character\c_jup_sp_hero_fitri
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xbe
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_sp_hero_fitri";
    
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

// Namespace c_jup_sp_hero_fitri / character\c_jup_sp_hero_fitri
// Params 0
// Checksum 0x0, Offset: 0x160
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier_female";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_hero_fitri" );
    self attach( "c_jup_head_hero_samara", "", 1 );
    self.headmodel = "c_jup_head_hero_samara";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_hero_fitri / character\c_jup_sp_hero_fitri
// Params 0
// Checksum 0x0, Offset: 0x222
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_hero_fitri / character\c_jup_sp_hero_fitri
// Params 0
// Checksum 0x0, Offset: 0x22c
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_hero_fitri" );
    precachemodel( "c_jup_head_hero_samara" );
}

// Namespace c_jup_sp_hero_fitri / character\c_jup_sp_hero_fitri
// Params 0
// Checksum 0x0, Offset: 0x253
// Size: 0x9
function precache_cpmp()
{
    precache();
}

