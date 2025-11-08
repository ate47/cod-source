#using scripts\common\utility;

#namespace c_jup_civ_paramedic_01_a;

// Namespace c_jup_civ_paramedic_01_a / namespace_a8782e63605d16e2
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xb8
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_civ_paramedic_01_a";
    
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

// Namespace c_jup_civ_paramedic_01_a / namespace_a8782e63605d16e2
// Params 0
// Checksum 0x0, Offset: 0x15a
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"russian";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_civ_paramedic_01" );
    self attach( "c_jup_head_sc_m_dunn", "", 1 );
    self.headmodel = "c_jup_head_sc_m_dunn";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_civ_paramedic_01_a / namespace_a8782e63605d16e2
// Params 0
// Checksum 0x0, Offset: 0x21c
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_civ_paramedic_01_a / namespace_a8782e63605d16e2
// Params 0
// Checksum 0x0, Offset: 0x226
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_civ_paramedic_01" );
    precachemodel( "c_jup_head_sc_m_dunn" );
}

// Namespace c_jup_civ_paramedic_01_a / namespace_a8782e63605d16e2
// Params 0
// Checksum 0x0, Offset: 0x24d
// Size: 0x9
function precache_cpmp()
{
    precache();
}

