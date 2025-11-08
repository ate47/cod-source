#using scripts\common\utility;

#namespace character_jup_zombie_entity;

// Namespace character_jup_zombie_entity / namespace_cfa3fb38eb4bf04f
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xde
// Size: 0x9b
function private autoexec init()
{
    character = #"character_jup_zombie_entity";
    
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

// Namespace character_jup_zombie_entity / namespace_cfa3fb38eb4bf04f
// Params 0
// Checksum 0x0, Offset: 0x181
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "zombie_entity";
    self.voice = #"unitedstates";
    self.bhasthighholster = 0;
    self.animtree = "zombie_entity";
    self setmodel( "body_c_jup_zmb_npc_entity" );
    self attach( "head_c_jup_zmb_npc_entity", "", 1 );
    self.headmodel = "head_c_jup_zmb_npc_entity";
    self setclothtype( #"vestheavy" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_16c36cf98afe63cd" );
    }
}

// Namespace character_jup_zombie_entity / namespace_cfa3fb38eb4bf04f
// Params 0
// Checksum 0x0, Offset: 0x243
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_zombie_entity / namespace_cfa3fb38eb4bf04f
// Params 0
// Checksum 0x0, Offset: 0x24d
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_zmb_npc_entity" );
    precachemodel( "head_c_jup_zmb_npc_entity" );
}

// Namespace character_jup_zombie_entity / namespace_cfa3fb38eb4bf04f
// Params 0
// Checksum 0x0, Offset: 0x274
// Size: 0x9
function precache_cpmp()
{
    precache();
}

