#using scripts\common\utility;

#namespace character_hero_price_urban;

// Namespace character_hero_price_urban / character\character_hero_price_urban
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xd6
// Size: 0x9a
function private autoexec init()
{
    character = #"character_hero_price_urban";
    
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

// Namespace character_hero_price_urban / character\character_hero_price_urban
// Params 0
// Checksum 0x0, Offset: 0x178
// Size: 0xd9
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"sas";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setmodel( "body_hero_price_urban_beanie" );
    self attach( "head_hero_price_newrig_bald", "", 1 );
    self.headmodel = "head_hero_price_newrig_bald";
    self.hatmodel = "hat_hero_price_beanie";
    self attach( self.hatmodel );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_hero_price_urban / character\character_hero_price_urban
// Params 0
// Checksum 0x0, Offset: 0x259
// Size: 0x2
function precache()
{
    
}

// Namespace character_hero_price_urban / character\character_hero_price_urban
// Params 0
// Checksum 0x0, Offset: 0x263
// Size: 0x2a
function precache_sp()
{
    precache();
    precachemodel( "body_hero_price_urban_beanie" );
    precachemodel( "head_hero_price_newrig_bald" );
    precachemodel( "hat_hero_price_beanie" );
}

// Namespace character_hero_price_urban / character\character_hero_price_urban
// Params 0
// Checksum 0x0, Offset: 0x295
// Size: 0x9
function precache_cpmp()
{
    precache();
}

