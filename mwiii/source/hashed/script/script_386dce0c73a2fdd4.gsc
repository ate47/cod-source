#using scripts\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\engine\utility;

#namespace namespace_b4de76d2d2c1c2ca;

// Namespace namespace_b4de76d2d2c1c2ca / namespace_e14c6ab0ceb9c048
// Params 0
// Checksum 0x0, Offset: 0x18c
// Size: 0x113
function function_29b5fb70d7ea841()
{
    function_406984e213848212( "melee", &function_79d559d24ce75889, &function_f01c824a76203041 );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( undefined, undefined, 1 ) );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( 1, "walk", undefined ) );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( 1, "run", undefined ) );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( 1, "sprint", undefined ) );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( 1, "super_sprint", undefined ) );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( 1, "wander", undefined ) );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( 1, "wander_shuffle", undefined ) );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( 1, "wander_agitated", undefined ) );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( 1, "investigate", undefined ) );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( 0, undefined, 0 ) );
}

// Namespace namespace_b4de76d2d2c1c2ca / namespace_e14c6ab0ceb9c048
// Params 0
// Checksum 0x0, Offset: 0x2a7
// Size: 0x62
function function_52b682d1bb0ddc02()
{
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &function_b06e7f5eb1e44850 );
    callback::get_template( self.animsetname ) callback::add( "on_is_moving_melee_changed", &function_830afe26e7e7e559 );
    callback::get_template( self.animsetname ) callback::add( "on_is_crawling_changed", &function_6221279973a1af55 );
}

// Namespace namespace_b4de76d2d2c1c2ca / namespace_e14c6ab0ceb9c048
// Params 0
// Checksum 0x0, Offset: 0x311
// Size: 0xe
function init_melee()
{
    function_8626c13b5be18c1b( "melee" );
}

// Namespace namespace_b4de76d2d2c1c2ca / namespace_e14c6ab0ceb9c048
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x327
// Size: 0x17
function private function_b06e7f5eb1e44850( params )
{
    function_8626c13b5be18c1b( "melee" );
}

// Namespace namespace_b4de76d2d2c1c2ca / namespace_e14c6ab0ceb9c048
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x346
// Size: 0x17
function private function_830afe26e7e7e559( params )
{
    function_8626c13b5be18c1b( "melee" );
}

// Namespace namespace_b4de76d2d2c1c2ca / namespace_e14c6ab0ceb9c048
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x365
// Size: 0x17
function private function_6221279973a1af55( params )
{
    function_8626c13b5be18c1b( "melee" );
}

// Namespace namespace_b4de76d2d2c1c2ca / namespace_e14c6ab0ceb9c048
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x384
// Size: 0x54
function private function_28d26d7ead912662( var_f261c2f31d7de033, move_type, is_crawling )
{
    struct = spawnstruct();
    struct.var_f261c2f31d7de033 = var_f261c2f31d7de033;
    struct.move_type = move_type;
    struct.is_crawling = is_crawling;
    return struct;
}

// Namespace namespace_b4de76d2d2c1c2ca / namespace_e14c6ab0ceb9c048
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3e1
// Size: 0x10a
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
    
    if ( isdefined( struct.is_crawling ) )
    {
        alias += ter_op( struct.is_crawling, ter_op( alias != "", "_", "" ) + "crawl", "" );
        
        if ( scripts\aitypes\zombie_base\zombie_base_dismemberment::is_crawling() != struct.is_crawling )
        {
            return undefined;
        }
    }
    
    return alias;
}

// Namespace namespace_b4de76d2d2c1c2ca / namespace_e14c6ab0ceb9c048
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4f4
// Size: 0x18
function private function_f01c824a76203041( alias )
{
    self function_164c05dd1bcfbca7( "melee", alias );
}

