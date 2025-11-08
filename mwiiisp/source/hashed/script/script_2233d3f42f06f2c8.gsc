#using scripts\common\utility;

#namespace character_jup_hero_shepherd_tundra;

// Namespace character_jup_hero_shepherd_tundra / namespace_acaf0f2f428737d2
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xc2
// Size: 0x9a
function private autoexec init()
{
    character = #"character_jup_hero_shepherd_tundra";
    
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

// Namespace character_jup_hero_shepherd_tundra / namespace_acaf0f2f428737d2
// Params 0
// Checksum 0x0, Offset: 0x164
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"sas";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_hero_shepherd_tundra" );
    self attach( "c_jup_head_hero_sheperd", "", 1 );
    self.headmodel = "c_jup_head_hero_sheperd";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_jup_hero_shepherd_tundra / namespace_acaf0f2f428737d2
// Params 0
// Checksum 0x0, Offset: 0x226
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_hero_shepherd_tundra / namespace_acaf0f2f428737d2
// Params 0
// Checksum 0x0, Offset: 0x230
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_hero_shepherd_tundra" );
    precachemodel( "c_jup_head_hero_sheperd" );
}

// Namespace character_jup_hero_shepherd_tundra / namespace_acaf0f2f428737d2
// Params 0
// Checksum 0x0, Offset: 0x257
// Size: 0x9
function precache_cpmp()
{
    precache();
}

