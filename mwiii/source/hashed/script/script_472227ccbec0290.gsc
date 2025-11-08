#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_zmb_zombie_base_male_hoodie_body_yz;
#using xmodelalias\c_jup_zmb_zombie_base_male_hoodie_head;

#namespace character_jup_zombie_base_male_hoodie_yz;

// Namespace character_jup_zombie_base_male_hoodie_yz / namespace_ae4e23ce8493b012
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x10e
// Size: 0xb4
function private autoexec init()
{
    character = #"character_jup_zombie_base_male_hoodie_yz";
    
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
        level.fncharacterxmodelalias[ %"character_jup_zombie_base_male_hoodie_yz" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace character_jup_zombie_base_male_hoodie_yz / namespace_ae4e23ce8493b012
// Params 0
// Checksum 0x0, Offset: 0x1ca
// Size: 0xb1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "zombie_base";
    self.voice = #"unitedstates";
    self.bhasthighholster = 0;
    self.animtree = "zombie_base";
    self setcharactermodelfromarray( "c_jup_zmb_zombie_base_male_hoodie_body_yz", xmodelalias\c_jup_zmb_zombie_base_male_hoodie_body_yz::main() );
    scripts\code\character::attachhead( "c_jup_zmb_zombie_base_male_hoodie_head", xmodelalias\c_jup_zmb_zombie_base_male_hoodie_head::main() );
    self setclothtype( #"vestheavy" );
    self setgeartype( #"none" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_16c36cf98afe63cd" );
    }
}

// Namespace character_jup_zombie_base_male_hoodie_yz / namespace_ae4e23ce8493b012
// Params 0
// Checksum 0x0, Offset: 0x283
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_zombie_base_male_hoodie_yz / namespace_ae4e23ce8493b012
// Params 0
// Checksum 0x0, Offset: 0x28d
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\c_jup_zmb_zombie_base_male_hoodie_body_yz::main() );
    scripts\code\character::precachemodelarray( xmodelalias\c_jup_zmb_zombie_base_male_hoodie_head::main() );
}

// Namespace character_jup_zombie_base_male_hoodie_yz / namespace_ae4e23ce8493b012
// Params 0
// Checksum 0x0, Offset: 0x2b8
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace character_jup_zombie_base_male_hoodie_yz / namespace_ae4e23ce8493b012
// Params 1
// Checksum 0x0, Offset: 0x2c9
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_482a5f44cc0dff85":
            return xmodelalias\c_jup_zmb_zombie_base_male_hoodie_body_yz::main();
        case #"hash_a813d896007c958b":
            return xmodelalias\c_jup_zmb_zombie_base_male_hoodie_head::main();
    }
    
    assert( 0, "<dev string:x1c>" );
}

