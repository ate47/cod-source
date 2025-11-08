#using scripts\common\utility;

#namespace character_mp_opforce_al_qatala_juggernaut;

// Namespace character_mp_opforce_al_qatala_juggernaut / namespace_70732e81c32e1db3
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xf2
// Size: 0x9b
function private autoexec init()
{
    character = #"character_mp_opforce_al_qatala_juggernaut";
    
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

// Namespace character_mp_opforce_al_qatala_juggernaut / namespace_70732e81c32e1db3
// Params 0
// Checksum 0x0, Offset: 0x195
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "juggernaut";
    self.voice = #"alqatala";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_sp_opforce_aq_jugg_basebody" );
    self attach( "head_sp_opforce_aq_jugg", "", 1 );
    self.headmodel = "head_sp_opforce_aq_jugg";
    self setclothtype( #"vestheavy" );
    self setgeartype( #"milhvygr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_mp_opforce_al_qatala_juggernaut / namespace_70732e81c32e1db3
// Params 0
// Checksum 0x0, Offset: 0x257
// Size: 0x2
function precache()
{
    
}

// Namespace character_mp_opforce_al_qatala_juggernaut / namespace_70732e81c32e1db3
// Params 0
// Checksum 0x0, Offset: 0x261
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_sp_opforce_aq_jugg_basebody" );
    precachemodel( "head_sp_opforce_aq_jugg" );
}

// Namespace character_mp_opforce_al_qatala_juggernaut / namespace_70732e81c32e1db3
// Params 0
// Checksum 0x0, Offset: 0x288
// Size: 0x9
function precache_cpmp()
{
    precache();
}

