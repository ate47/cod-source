#using scripts\common\utility;

#namespace character_jup_zombie_mimic_hvt_emp;

// Namespace character_jup_zombie_mimic_hvt_emp / namespace_2a5ddef6b9e7fc31
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xf2
// Size: 0x9b
function private autoexec init()
{
    character = #"character_jup_zombie_mimic_hvt_emp";
    
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

// Namespace character_jup_zombie_mimic_hvt_emp / namespace_2a5ddef6b9e7fc31
// Params 0
// Checksum 0x0, Offset: 0x195
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "zombie_mimic_hvt";
    self.voice = #"unitedstates";
    self.bhasthighholster = 0;
    self.animtree = "zombie_mimic";
    self setmodel( "c_jup_zmb_mimic_hvt_emp" );
    self attach( "c_jup_zmb_mimic_head_hvt_emp", "", 1 );
    self.headmodel = "c_jup_zmb_mimic_head_hvt_emp";
    self setclothtype( #"vestheavy" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_16c36cf98afe63cd" );
    }
}

// Namespace character_jup_zombie_mimic_hvt_emp / namespace_2a5ddef6b9e7fc31
// Params 0
// Checksum 0x0, Offset: 0x257
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_zombie_mimic_hvt_emp / namespace_2a5ddef6b9e7fc31
// Params 0
// Checksum 0x0, Offset: 0x261
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "c_jup_zmb_mimic_hvt_emp" );
    precachemodel( "c_jup_zmb_mimic_head_hvt_emp" );
}

// Namespace character_jup_zombie_mimic_hvt_emp / namespace_2a5ddef6b9e7fc31
// Params 0
// Checksum 0x0, Offset: 0x288
// Size: 0x9
function precache_cpmp()
{
    precache();
}

