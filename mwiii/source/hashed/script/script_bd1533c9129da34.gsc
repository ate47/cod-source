#using scripts\common\utility;

#namespace character_jup_zombie_base_male_shredded_02;

// Namespace character_jup_zombie_base_male_shredded_02 / namespace_f16950c7b0ec9a
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xfc
// Size: 0x9b
function private autoexec init()
{
    character = #"character_jup_zombie_base_male_shredded_02";
    
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

// Namespace character_jup_zombie_base_male_shredded_02 / namespace_f16950c7b0ec9a
// Params 0
// Checksum 0x0, Offset: 0x19f
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "zombie_base";
    self.voice = #"unitedstates";
    self.bhasthighholster = 0;
    self.animtree = "zombie_base";
    self setmodel( "c_jup_zombie_base_male_shredded_02" );
    self attach( "c_jup_zombie_base_male_shredded_02_head_half_oz", "", 1 );
    self.headmodel = "c_jup_zombie_base_male_shredded_02_head_half_oz";
    self setclothtype( #"vestheavy" );
    self setgeartype( #"none" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_16c36cf98afe63cd" );
    }
}

// Namespace character_jup_zombie_base_male_shredded_02 / namespace_f16950c7b0ec9a
// Params 0
// Checksum 0x0, Offset: 0x261
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_zombie_base_male_shredded_02 / namespace_f16950c7b0ec9a
// Params 0
// Checksum 0x0, Offset: 0x26b
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "c_jup_zombie_base_male_shredded_02" );
    precachemodel( "c_jup_zombie_base_male_shredded_02_head_half_oz" );
}

// Namespace character_jup_zombie_base_male_shredded_02 / namespace_f16950c7b0ec9a
// Params 0
// Checksum 0x0, Offset: 0x292
// Size: 0x9
function precache_cpmp()
{
    precache();
}

