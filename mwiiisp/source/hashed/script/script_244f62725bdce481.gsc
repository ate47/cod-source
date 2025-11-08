#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_civilian_russian_female_body_flashback_soccerfan;
#using xmodelalias\civilian_russian_female_head_flashback;

#namespace c_jup_civ_russian_female_flashback_soccerfan;

// Namespace c_jup_civ_russian_female_flashback_soccerfan / namespace_2c78a3ac74d4846f
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x153
// Size: 0xb3
function private autoexec init()
{
    character = #"c_jup_civ_russian_female_flashback_soccerfan";
    
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
        level.fncharacterxmodelalias[ %"c_jup_civ_russian_female_flashback_soccerfan" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace c_jup_civ_russian_female_flashback_soccerfan / namespace_2c78a3ac74d4846f
// Params 0
// Checksum 0x0, Offset: 0x20e
// Size: 0xb1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react_female";
    self.voice = #"alqatalafemale";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "c_jup_civilian_russian_female_body_flashback_soccerfan", xmodelalias\c_jup_civilian_russian_female_body_flashback_soccerfan::main() );
    scripts\code\character::attachhead( "civilian_russian_female_head_flashback", xmodelalias\civilian_russian_female_head_flashback::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_civ_russian_female_flashback_soccerfan / namespace_2c78a3ac74d4846f
// Params 0
// Checksum 0x0, Offset: 0x2c7
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_civ_russian_female_flashback_soccerfan / namespace_2c78a3ac74d4846f
// Params 0
// Checksum 0x0, Offset: 0x2d1
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\c_jup_civilian_russian_female_body_flashback_soccerfan::main() );
    scripts\code\character::precachemodelarray( xmodelalias\civilian_russian_female_head_flashback::main() );
}

// Namespace c_jup_civ_russian_female_flashback_soccerfan / namespace_2c78a3ac74d4846f
// Params 0
// Checksum 0x0, Offset: 0x2fc
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace c_jup_civ_russian_female_flashback_soccerfan / namespace_2c78a3ac74d4846f
// Params 1
// Checksum 0x0, Offset: 0x30d
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_e278288a35cb3c7b":
            return xmodelalias\c_jup_civilian_russian_female_body_flashback_soccerfan::main();
        case #"hash_2a378a2028ce50fc":
            return xmodelalias\civilian_russian_female_head_flashback::main();
    }
    
    assert( 0, "c_jup_civ_russian_female_flashback_soccerfan do not have any xmodelalias" );
}

