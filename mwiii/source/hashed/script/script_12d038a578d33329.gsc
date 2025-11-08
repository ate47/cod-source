#using scripts\common\utility;

#namespace c_jup_warlord_rainmaker;

// Namespace c_jup_warlord_rainmaker / namespace_2cbc9cb98a1d9175
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xfa
// Size: 0x9b
function private autoexec init()
{
    character = #"c_jup_warlord_rainmaker";
    
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

// Namespace c_jup_warlord_rainmaker / namespace_2cbc9cb98a1d9175
// Params 0
// Checksum 0x0, Offset: 0x19d
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "warlord_maestro_rainmaker";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_ext_rainmaker" );
    self attach( "head_c_jup_ext_rainmaker", "", 1 );
    self.headmodel = "head_c_jup_ext_rainmaker";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_warlord_rainmaker / namespace_2cbc9cb98a1d9175
// Params 0
// Checksum 0x0, Offset: 0x25f
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_warlord_rainmaker / namespace_2cbc9cb98a1d9175
// Params 0
// Checksum 0x0, Offset: 0x269
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_ext_rainmaker" );
    precachemodel( "head_c_jup_ext_rainmaker" );
}

// Namespace c_jup_warlord_rainmaker / namespace_2cbc9cb98a1d9175
// Params 0
// Checksum 0x0, Offset: 0x290
// Size: 0x9
function precache_cpmp()
{
    precache();
}

