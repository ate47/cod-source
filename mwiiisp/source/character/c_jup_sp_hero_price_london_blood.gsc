#using scripts\common\utility;

#namespace c_jup_sp_hero_price_london_blood;

// Namespace c_jup_sp_hero_price_london_blood / character\c_jup_sp_hero_price_london_blood
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xcd
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_sp_hero_price_london_blood";
    
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

// Namespace c_jup_sp_hero_price_london_blood / character\c_jup_sp_hero_price_london_blood
// Params 0
// Checksum 0x0, Offset: 0x16f
// Size: 0xbb
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"sas";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_hero_price_london_blood" );
    self attach( "head_hero_price_nohat_blood_lod", "", 1 );
    self.headmodel = "head_hero_price_nohat_blood_lod";
    self setclothtype( #"vestlight" );
    self setgeartype( #"milmedgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_hero_price_london_blood / character\c_jup_sp_hero_price_london_blood
// Params 0
// Checksum 0x0, Offset: 0x232
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_hero_price_london_blood / character\c_jup_sp_hero_price_london_blood
// Params 0
// Checksum 0x0, Offset: 0x23c
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_hero_price_london_blood" );
    precachemodel( "head_hero_price_nohat_blood_lod" );
}

// Namespace c_jup_sp_hero_price_london_blood / character\c_jup_sp_hero_price_london_blood
// Params 0
// Checksum 0x0, Offset: 0x263
// Size: 0x9
function precache_cpmp()
{
    precache();
}

