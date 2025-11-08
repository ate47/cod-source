#using scripts\common\utility;

#namespace c_jup_sp_hero_soap_jump;

// Namespace c_jup_sp_hero_soap_jump / namespace_1f1bd7c86939153e
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xc1
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_sp_hero_soap_jump";
    
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

// Namespace c_jup_sp_hero_soap_jump / namespace_1f1bd7c86939153e
// Params 0
// Checksum 0x0, Offset: 0x163
// Size: 0xbb
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"sas";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_hero_soap_jump" );
    self attach( "head_c_jup_sp_hero_soap_jump", "", 1 );
    self.headmodel = "head_c_jup_sp_hero_soap_jump";
    self setclothtype( #"nylon" );
    self setgeartype( #"milmedgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_hero_soap_jump / namespace_1f1bd7c86939153e
// Params 0
// Checksum 0x0, Offset: 0x226
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_hero_soap_jump / namespace_1f1bd7c86939153e
// Params 0
// Checksum 0x0, Offset: 0x230
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_hero_soap_jump" );
    precachemodel( "head_c_jup_sp_hero_soap_jump" );
}

// Namespace c_jup_sp_hero_soap_jump / namespace_1f1bd7c86939153e
// Params 0
// Checksum 0x0, Offset: 0x257
// Size: 0x9
function precache_cpmp()
{
    precache();
}

