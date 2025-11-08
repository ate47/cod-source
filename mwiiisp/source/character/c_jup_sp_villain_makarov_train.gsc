#using scripts\common\utility;

#namespace c_jup_sp_villain_makarov_train;

// Namespace c_jup_sp_villain_makarov_train / character\c_jup_sp_villain_makarov_train
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xc3
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_sp_villain_makarov_train";
    
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

// Namespace c_jup_sp_villain_makarov_train / character\c_jup_sp_villain_makarov_train
// Params 0
// Checksum 0x0, Offset: 0x165
// Size: 0xbb
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"russian";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_villain_makarov_train" );
    self attach( "c_jup_head_hero_makarov", "", 1 );
    self.headmodel = "c_jup_head_hero_makarov";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_villain_makarov_train / character\c_jup_sp_villain_makarov_train
// Params 0
// Checksum 0x0, Offset: 0x228
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_villain_makarov_train / character\c_jup_sp_villain_makarov_train
// Params 0
// Checksum 0x0, Offset: 0x232
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_villain_makarov_train" );
    precachemodel( "c_jup_head_hero_makarov" );
}

// Namespace c_jup_sp_villain_makarov_train / character\c_jup_sp_villain_makarov_train
// Params 0
// Checksum 0x0, Offset: 0x259
// Size: 0x9
function precache_cpmp()
{
    precache();
}

