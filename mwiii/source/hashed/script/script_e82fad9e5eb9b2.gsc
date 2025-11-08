#using scripts\common\utility;

#namespace c_jup_ob_enemy_pmc_grunt_female_03;

// Namespace c_jup_ob_enemy_pmc_grunt_female_03 / namespace_385f3446395c9ac0
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x106
// Size: 0x9b
function private autoexec init()
{
    character = #"c_jup_ob_enemy_pmc_grunt_female_03";
    
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

// Namespace c_jup_ob_enemy_pmc_grunt_female_03 / namespace_385f3446395c9ac0
// Params 0
// Checksum 0x0, Offset: 0x1a9
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"russianfemale";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_enemy_pmc_grunt_female_01" );
    self attach( "head_c_jup_sp_enemy_pmc_grunt_female_03", "", 1 );
    self.headmodel = "head_c_jup_sp_enemy_pmc_grunt_female_03";
    self setclothtype( #"nylon" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_ob_enemy_pmc_grunt_female_03 / namespace_385f3446395c9ac0
// Params 0
// Checksum 0x0, Offset: 0x26b
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_ob_enemy_pmc_grunt_female_03 / namespace_385f3446395c9ac0
// Params 0
// Checksum 0x0, Offset: 0x275
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_enemy_pmc_grunt_female_01" );
    precachemodel( "head_c_jup_sp_enemy_pmc_grunt_female_03" );
}

// Namespace c_jup_ob_enemy_pmc_grunt_female_03 / namespace_385f3446395c9ac0
// Params 0
// Checksum 0x0, Offset: 0x29c
// Size: 0x9
function precache_cpmp()
{
    precache();
}

