#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_civilian_asm_female_5;

#namespace character_civilian_ams_female_5;

// Namespace character_civilian_ams_female_5 / namespace_16a63bcff8a84289
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x116
// Size: 0xb3
function private autoexec init()
{
    character = #"character_civilian_ams_female_5";
    
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
        level.fncharacterxmodelalias[ %"character_civilian_ams_female_5" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace character_civilian_ams_female_5 / namespace_16a63bcff8a84289
// Params 0
// Checksum 0x0, Offset: 0x1d1
// Size: 0xc0
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react_loco";
    self.voice = #"unitednationsfemale";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "bodies_civilian_asm_female_5", xmodelalias\bodies_civilian_asm_female_5::main() );
    self attach( "head_sc_f_eghbali_hair_bg", "", 1 );
    self.headmodel = "head_sc_f_eghbali_hair_bg";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_civilian_ams_female_5 / namespace_16a63bcff8a84289
// Params 0
// Checksum 0x0, Offset: 0x299
// Size: 0x2
function precache()
{
    
}

// Namespace character_civilian_ams_female_5 / namespace_16a63bcff8a84289
// Params 0
// Checksum 0x0, Offset: 0x2a3
// Size: 0x21
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\bodies_civilian_asm_female_5::main() );
    precachemodel( "head_sc_f_eghbali_hair_bg" );
}

// Namespace character_civilian_ams_female_5 / namespace_16a63bcff8a84289
// Params 0
// Checksum 0x0, Offset: 0x2cc
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace character_civilian_ams_female_5 / namespace_16a63bcff8a84289
// Params 1
// Checksum 0x0, Offset: 0x2dd
// Size: 0x36
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_331b214a38c31f04":
            return xmodelalias\bodies_civilian_asm_female_5::main();
    }
    
    assert( 0, "character_civilian_ams_female_5 do not have any xmodelalias" );
}

