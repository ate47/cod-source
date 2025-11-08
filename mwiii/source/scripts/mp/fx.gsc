#using scripts\common\createfx;
#using scripts\common\fx;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\createfx;

#namespace fx;

// Namespace fx / scripts\mp\fx
// Params 0
// Checksum 0x0, Offset: 0x111
// Size: 0x18d
function script_print_fx()
{
    if ( !isdefined( self.script_fxid ) || !isdefined( self.script_fxcommand ) || !isdefined( self.script_delay ) )
    {
        println( "<dev string:x1c>", self.origin, "<dev string:x31>" );
        self delete();
        return;
    }
    
    if ( isdefined( self.target ) )
    {
        org = getent( self.target ).origin;
    }
    else
    {
        org = "undefined";
    }
    
    /#
        if ( self.script_fxcommand == "<dev string:x6c>" )
        {
            println( "<dev string:x79>" + self.script_fxid + "<dev string:x95>" + self.origin + "<dev string:x9c>" + self.script_delay + "<dev string:x9c>" + org + "<dev string:xa2>" );
        }
        
        if ( self.script_fxcommand == "<dev string:xa8>" )
        {
            println( "<dev string:xb2>" + self.script_fxid + "<dev string:x95>" + self.origin + "<dev string:x9c>" + self.script_delay + "<dev string:x9c>" + org + "<dev string:xa2>" );
        }
        
        if ( self.script_fxcommand == "<dev string:xcb>" )
        {
            println( "<dev string:xd8>" + self.script_fxid + "<dev string:x95>" + self.origin + "<dev string:x9c>" + self.script_delay + "<dev string:x9c>" + org + "<dev string:xa2>" );
        }
    #/
}

// Namespace fx / scripts\mp\fx
// Params 1
// Checksum 0x0, Offset: 0x2a6
// Size: 0x34
function grenadeexplosionfx( pos )
{
    playfx( level._effect[ "mechanical explosion" ], pos );
    earthquake( 0.15, 0.5, pos, 250 );
}

// Namespace fx / scripts\mp\fx
// Params 3
// Checksum 0x0, Offset: 0x2e2
// Size: 0x62
function soundfx( fxid, fxpos, endonnotify )
{
    org = spawn( "script_origin", ( 0, 0, 0 ) );
    org.origin = fxpos;
    org playloopsound( fxid );
    
    if ( isdefined( endonnotify ) )
    {
        org thread soundfxdelete( endonnotify );
    }
}

// Namespace fx / scripts\mp\fx
// Params 1
// Checksum 0x0, Offset: 0x34c
// Size: 0x16
function soundfxdelete( endonnotify )
{
    level waittill( endonnotify );
    self delete();
}

// Namespace fx / scripts\mp\fx
// Params 0
// Checksum 0x0, Offset: 0x36a
// Size: 0x152
function func_glass_handler()
{
    var_f5207dc7648baed9 = [];
    var_5f91ac0fae720aac = [];
    temp_decals = getentarray( "vfx_custom_glass", "targetname" );
    
    foreach ( decal in temp_decals )
    {
        if ( isdefined( decal.script_noteworthy ) )
        {
            attached_glass = getglass( decal.script_noteworthy );
            
            if ( isdefined( attached_glass ) )
            {
                var_5f91ac0fae720aac[ attached_glass ] = decal;
                var_f5207dc7648baed9[ var_f5207dc7648baed9.size ] = attached_glass;
            }
        }
    }
    
    var_5765c257f01f4f2b = var_f5207dc7648baed9.size;
    var_5356ea5b8d524ec1 = var_f5207dc7648baed9.size;
    max_iterations = 5;
    current_index = 0;
    
    while ( var_5765c257f01f4f2b != 0 )
    {
        max_index = current_index + max_iterations - 1;
        
        if ( max_index > var_5356ea5b8d524ec1 )
        {
            max_index = var_5356ea5b8d524ec1;
        }
        
        if ( current_index == var_5356ea5b8d524ec1 )
        {
        }
        
        for ( current_index = 0; current_index < max_index ; current_index++ )
        {
            glass_index = var_f5207dc7648baed9[ current_index ];
            decal = var_5f91ac0fae720aac[ glass_index ];
            
            if ( isdefined( decal ) )
            {
                if ( isglassdestroyed( glass_index ) )
                {
                    decal delete();
                    var_5765c257f01f4f2b--;
                    var_5f91ac0fae720aac[ glass_index ] = undefined;
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace fx / scripts\mp\fx
// Params 1
// Checksum 0x0, Offset: 0x4c4
// Size: 0x1a
function blenddelete( blend )
{
    self waittill( "death" );
    blend delete();
}

