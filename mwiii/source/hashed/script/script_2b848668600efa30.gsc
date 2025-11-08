#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\engine\utility;

#namespace namespace_824fdea5389ab963;

// Namespace namespace_824fdea5389ab963 / namespace_31f2d672614940ac
// Params 0
// Checksum 0x0, Offset: 0x124
// Size: 0xa7
function function_29b5fb70d7ea841()
{
    function_406984e213848212( "melee", &function_79d559d24ce75889, &function_f01c824a76203041 );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( 0, undefined, 0 ) );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( 0, undefined, 1 ) );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( 1, "walk", undefined ) );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( 1, "run", undefined ) );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( 1, "sprint", undefined ) );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( 1, undefined, undefined ) );
}

// Namespace namespace_824fdea5389ab963 / namespace_31f2d672614940ac
// Params 0
// Checksum 0x0, Offset: 0x1d3
// Size: 0x42
function function_3ff40056b91b6e90()
{
    callback::get_template( self.animsetname ) callback::add( "on_is_moving_melee_changed", &function_830afe26e7e7e559 );
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &function_b06e7f5eb1e44850 );
}

// Namespace namespace_824fdea5389ab963 / namespace_31f2d672614940ac
// Params 0
// Checksum 0x0, Offset: 0x21d
// Size: 0xe
function function_bd41a979b3c3bcb6()
{
    function_8626c13b5be18c1b( "melee" );
}

// Namespace namespace_824fdea5389ab963 / namespace_31f2d672614940ac
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x233
// Size: 0x17
function private function_830afe26e7e7e559( params )
{
    function_8626c13b5be18c1b( "melee" );
}

// Namespace namespace_824fdea5389ab963 / namespace_31f2d672614940ac
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x252
// Size: 0x17
function private function_b06e7f5eb1e44850( params )
{
    function_8626c13b5be18c1b( "melee" );
}

// Namespace namespace_824fdea5389ab963 / namespace_31f2d672614940ac
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x271
// Size: 0x54
function private function_28d26d7ead912662( var_f261c2f31d7de033, move_type, var_d90af5177d0db456 )
{
    struct = spawnstruct();
    struct.var_f261c2f31d7de033 = var_f261c2f31d7de033;
    struct.move_type = move_type;
    struct.var_d90af5177d0db456 = var_d90af5177d0db456;
    return struct;
}

// Namespace namespace_824fdea5389ab963 / namespace_31f2d672614940ac
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2ce
// Size: 0x10d
function private function_79d559d24ce75889( struct )
{
    alias = "";
    
    if ( isdefined( struct.var_f261c2f31d7de033 ) )
    {
        alias += ter_op( istrue( self.var_f261c2f31d7de033 ), "move", "static" );
        
        if ( istrue( self.var_f261c2f31d7de033 ) != struct.var_f261c2f31d7de033 )
        {
            return undefined;
        }
    }
    
    if ( isdefined( struct.move_type ) )
    {
        alias += "_" + struct.move_type;
        
        if ( self._blackboard.movetype != struct.move_type )
        {
            return undefined;
        }
    }
    
    if ( isdefined( struct.var_d90af5177d0db456 ) )
    {
        alias += ter_op( struct.var_d90af5177d0db456, ter_op( alias != "", "_", "" ) + "single_armed", "" );
        
        if ( self.var_f719fcdc90b79bb8 != struct.var_d90af5177d0db456 )
        {
            return undefined;
        }
    }
    
    return alias;
}

// Namespace namespace_824fdea5389ab963 / namespace_31f2d672614940ac
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3e4
// Size: 0x18
function private function_f01c824a76203041( alias )
{
    self function_164c05dd1bcfbca7( "melee", alias );
}

