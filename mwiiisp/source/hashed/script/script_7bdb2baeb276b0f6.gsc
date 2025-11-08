#using scripts\common\utility;

#namespace c_jup_civ_embassy_office_worker_male_1_1;

// Namespace c_jup_civ_embassy_office_worker_male_1_1 / namespace_8546bf0cd85297f8
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xd6
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_civ_embassy_office_worker_male_1_1";
    
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

// Namespace c_jup_civ_embassy_office_worker_male_1_1 / namespace_8546bf0cd85297f8
// Params 0
// Checksum 0x0, Offset: 0x178
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "c_jup_body_civ_embassy_office_worker_male_1_1" );
    self attach( "head_c_jup_sc_m_banks_civ", "", 1 );
    self.headmodel = "head_c_jup_sc_m_banks_civ";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_civ_embassy_office_worker_male_1_1 / namespace_8546bf0cd85297f8
// Params 0
// Checksum 0x0, Offset: 0x23a
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_civ_embassy_office_worker_male_1_1 / namespace_8546bf0cd85297f8
// Params 0
// Checksum 0x0, Offset: 0x244
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "c_jup_body_civ_embassy_office_worker_male_1_1" );
    precachemodel( "head_c_jup_sc_m_banks_civ" );
}

// Namespace c_jup_civ_embassy_office_worker_male_1_1 / namespace_8546bf0cd85297f8
// Params 0
// Checksum 0x0, Offset: 0x26b
// Size: 0x9
function precache_cpmp()
{
    precache();
}

