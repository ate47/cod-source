#using script_21bdef0c2290d3e2;
#using script_638d701d263ee1ed;
#using script_793f5fa29ca62c00;
#using script_7edf952f8921aa6b;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace ob_dog_whistle;

// Namespace ob_dog_whistle / namespace_d546a7e525bb4c8
// Params 0
// Checksum 0x0, Offset: 0x1c4
// Size: 0x24
function function_d18f1e707dc52a0d()
{
    /#
        level thread function_9b5eae6a141d151();
    #/
    
    registersharedfunc( "ob_dog_whistle", "spawn_hellhound_pet", &function_8b9945c368da84a2 );
}

// Namespace ob_dog_whistle / namespace_d546a7e525bb4c8
// Params 0
// Checksum 0x0, Offset: 0x1f0
// Size: 0x130
function spawn_hellhound_pet()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( self getcurrentweapon() != nullweapon() )
    {
        self playgestureviewmodel( "jup_vm_gesture_zm_dogwhistle" );
    }
    
    spawn_struct = spawnstruct();
    spawn_struct.angles = self.angles;
    forward = anglestoforward( self.angles );
    forward = vectornormalize( forward );
    forward *= ( 64, 64, 64 );
    pos = self.origin + forward;
    
    if ( !ispointonnavmesh( pos ) )
    {
        pos = getgroundposition( self.origin + forward, 1 );
        
        if ( !ispointonnavmesh( pos ) )
        {
            pos = getclosestpointonnavmesh( pos );
        }
    }
    
    spawn_struct.origin = pos;
    hound = namespace_f82e883a38a92b9a::function_93c37ea2b2745734( self, spawn_struct, 1 );
    
    if ( isdefined( hound ) )
    {
        self.companion_type = 1;
        self.var_c5668dcaf32afbc3 = hound;
        hound thread animscriptedagent( "spawn", "spawn_end", undefined, undefined, "spawn_animating" );
        hound callback::add( "on_zombie_ai_killed", &function_1ccfcd11184fd840 );
        hound function_3de9c56dadc05fbc();
    }
}

// Namespace ob_dog_whistle / namespace_d546a7e525bb4c8
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x328
// Size: 0x16e
function private function_3de9c56dadc05fbc()
{
    if ( istrue( self.var_f20036ce01c27a4d ) && isdefined( self.var_c5668dcaf32afbc3 ) )
    {
        self.var_f20036ce01c27a4d = 0;
        
        if ( isdefined( self.var_a0c81984c27cf26e ) )
        {
            self.var_c5668dcaf32afbc3.nameindex = self.var_a0c81984c27cf26e;
        }
        
        if ( isdefined( self.var_dfb50237dca2ad85 ) )
        {
            dog_difficulty = "difficulty_easy";
            var_cb36002629685317 = getdvarint( @"hash_bb677973b07d33f7", 7500 );
            
            switch ( self.var_dfb50237dca2ad85 )
            {
                case #"hash_311012bc01bd3d35":
                    dog_difficulty = "difficulty_normal";
                    var_cb36002629685317 = getdvarint( @"hash_bb677a73b07d362a", 18000 );
                    break;
                case #"hash_311011bc01bd3ba2":
                    dog_difficulty = "difficulty_hard";
                    var_cb36002629685317 = getdvarint( @"hash_bb677b73b07d385d", 30000 );
                    break;
                case #"hash_31100cbc01bd33c3":
                    dog_difficulty = "difficulty_darkaether";
                    var_cb36002629685317 = getdvarint( @"hash_bb677473b07d28f8", 45000 );
                    break;
                default:
                    break;
            }
            
            self.var_c5668dcaf32afbc3 namespace_4df2ab39b0e96ec7::function_4a4fab5fd0b06d7b( dog_difficulty );
            self.var_c5668dcaf32afbc3 scripts\common\ai::function_dd21d67ede8ba22( var_cb36002629685317 );
            self.var_c5668dcaf32afbc3.health = self.var_c5668dcaf32afbc3.maxhealth;
        }
    }
}

// Namespace ob_dog_whistle / namespace_d546a7e525bb4c8
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x49e
// Size: 0x7e
function private function_1ccfcd11184fd840( params )
{
    if ( isdefined( self.var_66c1831357048c02 ) && isalive( self.var_66c1831357048c02 ) )
    {
        self.var_66c1831357048c02.var_c5668dcaf32afbc3 = undefined;
        self.var_66c1831357048c02.var_209d25b535dfbcf = 0;
        
        if ( !istrue( self.var_66c1831357048c02.var_ded04cdd264a7e00 ) )
        {
            self.var_66c1831357048c02.companion_type = 0;
        }
    }
}

/#

    // Namespace ob_dog_whistle / namespace_d546a7e525bb4c8
    // Params 0
    // Checksum 0x0, Offset: 0x524
    // Size: 0x2e, Type: dev
    function function_9b5eae6a141d151()
    {
        function_6e7290c8ee4f558b( "<dev string:x1c>" );
        function_a9a864379a098ad6( "<dev string:x23>", "<dev string:x3f>", &function_cb675302a33d65ae );
        function_fe953f000498048f();
    }

    // Namespace ob_dog_whistle / namespace_d546a7e525bb4c8
    // Params 0
    // Checksum 0x0, Offset: 0x55a
    // Size: 0x59, Type: dev
    function function_cb675302a33d65ae()
    {
        foreach ( player in level.players )
        {
            player spawn_hellhound_pet();
        }
    }

#/
