#using script_60cc31ea91d0ad55;
#using script_7edf952f8921aa6b;
#using scripts\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\engine\utility;

#namespace namespace_85955b341e67f12f;

// Namespace namespace_85955b341e67f12f / namespace_15764f2455729041
// Params 1
// Checksum 0x0, Offset: 0x217
// Size: 0x2ce
function function_304c63cbb536c526( shouldstrip )
{
    function_406984e213848212( "move", &function_eee30195769f679e, &function_3efc6f398dd71d26 );
    
    if ( shouldstrip )
    {
        function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "walk", "down", undefined ), 9 );
        function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "walk", "up", undefined ), 10 );
        function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "run", "down", undefined ), 6 );
        function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "run", "up", undefined ), 6 );
        function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "run", undefined, 1 ) );
        function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "sprint", "down", undefined ), 4 );
        function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "sprint", "up", undefined ), 3 );
        function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "sprint", undefined, 1 ) );
        function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "super_sprint", undefined, undefined ), 3 );
    }
    else
    {
        function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "walk", "down", undefined ), 16 );
        function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "walk", "up", undefined ), 14 );
        function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "run", "down", undefined ), 12 );
        function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "run", "up", undefined ), 12 );
        function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "run", undefined, 1 ) );
        function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "sprint", "down", undefined ), 7 );
        function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "sprint", "up", undefined ), 6 );
        function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "sprint", undefined, 1 ) );
        function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "super_sprint", undefined, undefined ), 4 );
    }
    
    function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "super_sprint", undefined, 1 ) );
    function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "investigate", undefined, undefined ) );
    function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "wander_shuffle", undefined, undefined ) );
    function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "wander_agitated", undefined, undefined ) );
    function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( "wander", undefined, undefined ) );
    function_3f5173a731bdfe2f( "move", function_8776345ecd2673e5( undefined, undefined, 1 ) );
}

// Namespace namespace_85955b341e67f12f / namespace_15764f2455729041
// Params 0
// Checksum 0x0, Offset: 0x4ed
// Size: 0x62
function function_d03eea41ff9cfe90()
{
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &function_36985b9cd291d92 );
    callback::get_template( self.animsetname ) callback::add( "on_is_moving_melee_changed", &function_9fd711257824bb04 );
    callback::get_template( self.animsetname ) callback::add( "on_is_crawling_changed", &function_f32e8d8176ba8554 );
}

// Namespace namespace_85955b341e67f12f / namespace_15764f2455729041
// Params 0
// Checksum 0x0, Offset: 0x557
// Size: 0x19
function function_3426adec3c5d6cb6()
{
    init_move();
    thread wander_listener();
    thread investigate_listener();
}

// Namespace namespace_85955b341e67f12f / namespace_15764f2455729041
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x578
// Size: 0x5c
function private function_36985b9cd291d92( params )
{
    anim_alias = function_8626c13b5be18c1b( "move" );
    
    /#
        record3dtext( "<dev string:x1c>" + anim_alias, self.origin + ( 0, 0, 48 ), ( 1, 0, 0 ), "<dev string:x34>", self );
    #/
}

// Namespace namespace_85955b341e67f12f / namespace_15764f2455729041
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5dc
// Size: 0x17
function private function_9fd711257824bb04( params )
{
    function_8626c13b5be18c1b( "move" );
}

// Namespace namespace_85955b341e67f12f / namespace_15764f2455729041
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5fb
// Size: 0x29
function private function_f32e8d8176ba8554( params )
{
    if ( asm_currentstatehasflag( self.asmname, "move" ) )
    {
        function_3bf2c1ee7854b63a();
    }
}

// Namespace namespace_85955b341e67f12f / namespace_15764f2455729041
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x62c
// Size: 0x54
function private function_8776345ecd2673e5( move_type, arm_pos, is_crawling )
{
    struct = spawnstruct();
    struct.move_type = move_type;
    struct.arm_pos = arm_pos;
    struct.is_crawling = is_crawling;
    return struct;
}

// Namespace namespace_85955b341e67f12f / namespace_15764f2455729041
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x689
// Size: 0x145
function private function_eee30195769f679e( struct )
{
    alias = "";
    
    if ( isdefined( struct.move_type ) )
    {
        alias += struct.move_type;
        
        if ( self._blackboard.movetype != struct.move_type )
        {
            return undefined;
        }
    }
    
    if ( isdefined( struct.arm_pos ) )
    {
        alias += "_a" + ter_op( struct.arm_pos == "down", "d", "u" );
        
        if ( !isdefined( self._blackboard.var_f20ced1f24ab8752 ) || ter_op( self._blackboard.var_f20ced1f24ab8752 > 0, "up", "down" ) != struct.arm_pos )
        {
            return undefined;
        }
    }
    
    if ( isdefined( struct.is_crawling ) )
    {
        alias_empty = alias == "";
        alias += ter_op( struct.is_crawling, ter_op( alias_empty, "", "_crawl" ) );
        
        if ( scripts\aitypes\zombie_base\zombie_base_dismemberment::is_crawling() != struct.is_crawling )
        {
            return undefined;
        }
    }
    
    return alias;
}

// Namespace namespace_85955b341e67f12f / namespace_15764f2455729041
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x7d7
// Size: 0x44
function private function_3efc6f398dd71d26( alias )
{
    self function_164c05dd1bcfbca7( "move", alias );
    
    if ( asm_currentstatehasflag( self.asmname, "move" ) )
    {
        asm_fireevent_internal( self.asmname, "loop_reroll_anim" );
    }
}

// Namespace namespace_85955b341e67f12f / namespace_15764f2455729041
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x823
// Size: 0x179
function private wander_listener()
{
    self endon( "death" );
    var_43a41b8e241075d9 = self.collide_with_ai_allies;
    var_f1a9200c39365c50 = self.script_pushable_by_ai;
    var_e7559f0d8df0d81b = self.script_pushable;
    var_5551942656a0fa38 = self.var_8f499cbc08e88e90;
    var_22af11ae0bd93d28 = 0.5;
    
    while ( true )
    {
        self waittill( "wander_start" );
        move_speed = self.zombieaisettings.speedthreshold_list[ 1 ].movetype;
        
        if ( function_2201d3f3d7ab07a7() > 20 )
        {
            move_speed = "wander_agitated";
        }
        
        function_f1e5805da192a1ef( move_speed, "wander", 22 );
        self.collide_with_ai_allies = 0;
        self.script_pushable_by_ai = 0;
        self.script_pushable = 0;
        
        if ( self.turnrate > 0 && self.turnrate * var_22af11ae0bd93d28 > 0 )
        {
            self.turnrate *= var_22af11ae0bd93d28;
        }
        
        self waittill( "wander_end" );
        function_f1e5805da192a1ef( undefined, "wander" );
        self.collide_with_ai_allies = var_43a41b8e241075d9;
        self.script_pushable_by_ai = var_f1a9200c39365c50;
        self.script_pushable_by_ai = var_e7559f0d8df0d81b;
        
        if ( self.turnrate > 0 && self.turnrate / var_22af11ae0bd93d28 > 0 )
        {
            self.turnrate /= var_22af11ae0bd93d28;
        }
    }
}

// Namespace namespace_85955b341e67f12f / namespace_15764f2455729041
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x9a4
// Size: 0x5a
function private investigate_listener()
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "investigate_start" );
        
        if ( function_2201d3f3d7ab07a7() <= 20 )
        {
            move_speed = "investigate";
            function_f1e5805da192a1ef( move_speed, "investigate", 23 );
            self waittill( "investigate_end" );
            function_f1e5805da192a1ef( undefined, "investigate" );
        }
    }
}

