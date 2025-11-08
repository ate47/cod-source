#using scripts\common\utility;

#namespace c_jup_civ_embassy_ambassador_assistant;

// Namespace c_jup_civ_embassy_ambassador_assistant / namespace_ca9c730a9bcc6ad3
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xd1
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_civ_embassy_ambassador_assistant";
    
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

// Namespace c_jup_civ_embassy_ambassador_assistant / namespace_ca9c730a9bcc6ad3
// Params 0
// Checksum 0x0, Offset: 0x173
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react";
    self.voice = #"unitednationsfemale";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "c_jup_body_civ_embassy_ambassador_assistant" );
    self attach( "head_c_jup_sc_f_miller", "", 1 );
    self.headmodel = "head_c_jup_sc_f_miller";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_civ_embassy_ambassador_assistant / namespace_ca9c730a9bcc6ad3
// Params 0
// Checksum 0x0, Offset: 0x235
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_civ_embassy_ambassador_assistant / namespace_ca9c730a9bcc6ad3
// Params 0
// Checksum 0x0, Offset: 0x23f
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "c_jup_body_civ_embassy_ambassador_assistant" );
    precachemodel( "head_c_jup_sc_f_miller" );
}

// Namespace c_jup_civ_embassy_ambassador_assistant / namespace_ca9c730a9bcc6ad3
// Params 0
// Checksum 0x0, Offset: 0x266
// Size: 0x9
function precache_cpmp()
{
    precache();
}

