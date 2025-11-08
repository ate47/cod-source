#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace namespace_b17ec7b025ea4a4c;

// Namespace namespace_b17ec7b025ea4a4c / namespace_2c146dc5d41aa016
// Params 0
// Checksum 0x0, Offset: 0x183
// Size: 0xda
function function_29b5fb70d7ea841()
{
    function_406984e213848212( "melee", &function_79d559d24ce75889, &function_f01c824a76203041 );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( undefined, undefined, 1 ) );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( undefined, undefined, 0 ) );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( 1, "wander", undefined ) );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( 1, "walk", undefined ) );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( 1, "run", undefined ) );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( 1, "sprint", undefined ) );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( 1, "super_sprint", undefined ) );
    function_3f5173a731bdfe2f( "melee", function_28d26d7ead912662( 0, undefined, undefined ) );
}

// Namespace namespace_b17ec7b025ea4a4c / namespace_2c146dc5d41aa016
// Params 0
// Checksum 0x0, Offset: 0x265
// Size: 0x41
function init_melee()
{
    callback::add( "on_is_melee_started", &function_5e13f692ca3ad048 );
    callback::add( "on_move_speed_changed", &function_b06e7f5eb1e44850 );
    callback::add( "on_is_moving_melee_changed", &function_830afe26e7e7e559 );
    function_8626c13b5be18c1b( "melee" );
}

// Namespace namespace_b17ec7b025ea4a4c / namespace_2c146dc5d41aa016
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2ae
// Size: 0x1f
function private function_5e13f692ca3ad048( params )
{
    self notify( "melee_started" );
    function_8626c13b5be18c1b( "melee" );
}

// Namespace namespace_b17ec7b025ea4a4c / namespace_2c146dc5d41aa016
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2d5
// Size: 0x17
function private function_b06e7f5eb1e44850( params )
{
    function_8626c13b5be18c1b( "melee" );
}

// Namespace namespace_b17ec7b025ea4a4c / namespace_2c146dc5d41aa016
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2f4
// Size: 0x17
function private function_830afe26e7e7e559( params )
{
    function_8626c13b5be18c1b( "melee" );
}

// Namespace namespace_b17ec7b025ea4a4c / namespace_2c146dc5d41aa016
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x313
// Size: 0x54
function private function_28d26d7ead912662( var_f261c2f31d7de033, move_type, var_7b2cfb8921480a0a )
{
    struct = spawnstruct();
    struct.var_f261c2f31d7de033 = var_f261c2f31d7de033;
    struct.move_type = move_type;
    struct.var_7b2cfb8921480a0a = var_7b2cfb8921480a0a;
    return struct;
}

// Namespace namespace_b17ec7b025ea4a4c / namespace_2c146dc5d41aa016
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x370
// Size: 0x275
function private function_79d559d24ce75889( struct )
{
    if ( istrue( self.var_f261c2f31d7de033 ) )
    {
        alias = "move_walk";
    }
    else
    {
        alias = "melee_default";
    }
    
    if ( !isdefined( self.var_a7e7a5cbca185094 ) )
    {
        return alias;
    }
    
    var_eb9973984c6db0df = self.var_a7e7a5cbca185094;
    
    if ( istrue( struct.var_7b2cfb8921480a0a ) )
    {
        if ( istrue( self.var_f261c2f31d7de033 ) )
        {
            return undefined;
        }
        
        height_diff = 0;
        
        if ( isent( var_eb9973984c6db0df ) )
        {
            height_diff = var_eb9973984c6db0df.origin[ 2 ] - self.origin[ 2 ];
        }
        else if ( isvector( var_eb9973984c6db0df ) )
        {
            height_diff = var_eb9973984c6db0df[ 2 ] - self.origin[ 2 ];
        }
        
        low_enough = 30;
        target_pose = undefined;
        
        if ( isent( var_eb9973984c6db0df ) )
        {
            if ( isplayer( var_eb9973984c6db0df ) )
            {
                target_pose = var_eb9973984c6db0df getstance();
            }
            else if ( isdefined( var_eb9973984c6db0df.currentpose ) )
            {
                target_pose = var_eb9973984c6db0df.currentpose;
            }
        }
        
        if ( height_diff < low_enough && is_equal( target_pose, "prone" ) )
        {
            return "melee_low";
        }
        
        return undefined;
    }
    
    if ( isdefined( struct.var_7b2cfb8921480a0a ) && !struct.var_7b2cfb8921480a0a )
    {
        if ( istrue( self.var_f261c2f31d7de033 ) )
        {
            return undefined;
        }
        
        if ( isent( var_eb9973984c6db0df ) )
        {
            melee_origin = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 65 );
            enemy_origin = ( var_eb9973984c6db0df.origin[ 0 ], var_eb9973984c6db0df.origin[ 1 ], var_eb9973984c6db0df.origin[ 2 ] + 32 );
            
            if ( !scripts\engine\trace::_bullet_trace_passed( melee_origin, enemy_origin, 0, self ) )
            {
                return "melee_low";
            }
        }
        
        return undefined;
    }
    
    if ( isdefined( struct.var_f261c2f31d7de033 ) )
    {
        if ( istrue( self.var_f261c2f31d7de033 ) )
        {
            alias = "move";
        }
        
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
    
    return alias;
}

// Namespace namespace_b17ec7b025ea4a4c / namespace_2c146dc5d41aa016
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5ee
// Size: 0x18
function private function_f01c824a76203041( alias )
{
    self function_164c05dd1bcfbca7( "melee", alias );
}

