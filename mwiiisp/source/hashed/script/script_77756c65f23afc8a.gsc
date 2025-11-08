#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_civilian_asm_female_5;

#namespace character_civilian_ams_female_5_sitting;

// Namespace character_civilian_ams_female_5_sitting / namespace_f62a99d16e48812
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x11e
// Size: 0xb3
function private autoexec init()
{
    character = #"character_civilian_ams_female_5_sitting";
    
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
        level.fncharacterxmodelalias[ %"character_civilian_ams_female_5_sitting" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace character_civilian_ams_female_5_sitting / namespace_f62a99d16e48812
// Params 0
// Checksum 0x0, Offset: 0x1d9
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

// Namespace character_civilian_ams_female_5_sitting / namespace_f62a99d16e48812
// Params 0
// Checksum 0x0, Offset: 0x2a1
// Size: 0x2
function precache()
{
    
}

// Namespace character_civilian_ams_female_5_sitting / namespace_f62a99d16e48812
// Params 0
// Checksum 0x0, Offset: 0x2ab
// Size: 0x21
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\bodies_civilian_asm_female_5::main() );
    precachemodel( "head_sc_f_eghbali_hair_bg" );
}

// Namespace character_civilian_ams_female_5_sitting / namespace_f62a99d16e48812
// Params 0
// Checksum 0x0, Offset: 0x2d4
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace character_civilian_ams_female_5_sitting / namespace_f62a99d16e48812
// Params 1
// Checksum 0x0, Offset: 0x2e5
// Size: 0x36
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_331b214a38c31f04":
            return xmodelalias\bodies_civilian_asm_female_5::main();
    }
    
    assert( 0, "character_civilian_ams_female_5_sitting do not have any xmodelalias" );
}

