#using scripts\common\utility;

#namespace character_iw9_pmc_armor_dmr_1;

// Namespace character_iw9_pmc_armor_dmr_1 / namespace_7e2fdc4d18670b43
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xe5
// Size: 0x9a
function private autoexec init()
{
    character = #"character_iw9_pmc_armor_dmr_1";
    
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

// Namespace character_iw9_pmc_armor_dmr_1 / namespace_7e2fdc4d18670b43
// Params 0
// Checksum 0x0, Offset: 0x187
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"shadowcompany";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_sp_opforce_shadow_company_armored_dmr_1_1" );
    self attach( "head_sp_opforce_shadow_company_armored_dmr_1_1", "", 1 );
    self.headmodel = "head_sp_opforce_shadow_company_armored_dmr_1_1";
    self setclothtype( #"nylon" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_iw9_pmc_armor_dmr_1 / namespace_7e2fdc4d18670b43
// Params 0
// Checksum 0x0, Offset: 0x249
// Size: 0x2
function precache()
{
    
}

// Namespace character_iw9_pmc_armor_dmr_1 / namespace_7e2fdc4d18670b43
// Params 0
// Checksum 0x0, Offset: 0x253
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_sp_opforce_shadow_company_armored_dmr_1_1" );
    precachemodel( "head_sp_opforce_shadow_company_armored_dmr_1_1" );
}

// Namespace character_iw9_pmc_armor_dmr_1 / namespace_7e2fdc4d18670b43
// Params 0
// Checksum 0x0, Offset: 0x27a
// Size: 0x9
function precache_cpmp()
{
    precache();
}

