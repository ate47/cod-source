#using scripts\common\utility;

#namespace c_jup_ob_enemy_pmc_grunt_red_02;

// Namespace c_jup_ob_enemy_pmc_grunt_red_02 / namespace_ffc70aab88f65ab2
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xfc
// Size: 0x9b
function private autoexec init()
{
    character = #"c_jup_ob_enemy_pmc_grunt_red_02";
    
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

// Namespace c_jup_ob_enemy_pmc_grunt_red_02 / namespace_ffc70aab88f65ab2
// Params 0
// Checksum 0x0, Offset: 0x19f
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"russian";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_enemy_pmc_grunt_red" );
    self attach( "head_c_jup_sp_enemy_pmc_grunt_05_02", "", 1 );
    self.headmodel = "head_c_jup_sp_enemy_pmc_grunt_05_02";
    self setclothtype( #"nylon" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_ob_enemy_pmc_grunt_red_02 / namespace_ffc70aab88f65ab2
// Params 0
// Checksum 0x0, Offset: 0x261
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_ob_enemy_pmc_grunt_red_02 / namespace_ffc70aab88f65ab2
// Params 0
// Checksum 0x0, Offset: 0x26b
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_enemy_pmc_grunt_red" );
    precachemodel( "head_c_jup_sp_enemy_pmc_grunt_05_02" );
}

// Namespace c_jup_ob_enemy_pmc_grunt_red_02 / namespace_ffc70aab88f65ab2
// Params 0
// Checksum 0x0, Offset: 0x292
// Size: 0x9
function precache_cpmp()
{
    precache();
}

