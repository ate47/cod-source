#using scripts\common\utility;

#namespace c_jup_civ_embassy_office_worker_male_1_3;

// Namespace c_jup_civ_embassy_office_worker_male_1_3 / namespace_8546c10cd8529c5e
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xd7
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_civ_embassy_office_worker_male_1_3";
    
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

// Namespace c_jup_civ_embassy_office_worker_male_1_3 / namespace_8546c10cd8529c5e
// Params 0
// Checksum 0x0, Offset: 0x179
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "c_jup_body_civ_embassy_office_worker_male_1_4" );
    self attach( "head_c_jup_sc_m_george_civ", "", 1 );
    self.headmodel = "head_c_jup_sc_m_george_civ";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_civ_embassy_office_worker_male_1_3 / namespace_8546c10cd8529c5e
// Params 0
// Checksum 0x0, Offset: 0x23b
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_civ_embassy_office_worker_male_1_3 / namespace_8546c10cd8529c5e
// Params 0
// Checksum 0x0, Offset: 0x245
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "c_jup_body_civ_embassy_office_worker_male_1_4" );
    precachemodel( "head_c_jup_sc_m_george_civ" );
}

// Namespace c_jup_civ_embassy_office_worker_male_1_3 / namespace_8546c10cd8529c5e
// Params 0
// Checksum 0x0, Offset: 0x26c
// Size: 0x9
function precache_cpmp()
{
    precache();
}

