#using scripts\mp\flags;

#namespace minefields;

// Namespace minefields / scripts\mp\minefields
// Params 0
// Checksum 0x0, Offset: 0x107
// Size: 0x61
function minefields()
{
    minefields = getentarray( "minefield", "targetname" );
    
    if ( minefields.size > 0 )
    {
        level._effect[ "mine_explosion" ] = loadfx( "vfx/core/expl/weap/gre/vfx_exp_gre_dirt_cg" );
    }
    
    for ( i = 0; i < minefields.size ; i++ )
    {
        minefields[ i ] thread minefield_think();
    }
}

// Namespace minefields / scripts\mp\minefields
// Params 0
// Checksum 0x0, Offset: 0x170
// Size: 0x3d
function minefield_think()
{
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    while ( true )
    {
        self waittill( "trigger", other );
        
        if ( isplayer( other ) )
        {
            other thread minefield_kill( self );
        }
    }
}

// Namespace minefields / scripts\mp\minefields
// Params 1
// Checksum 0x0, Offset: 0x1b5
// Size: 0x91
function minefield_kill( trigger )
{
    if ( isdefined( self.minefield ) )
    {
        return;
    }
    
    self.minefield = 1;
    wait 0.5;
    wait randomfloat( 0.5 );
    
    if ( isdefined( self ) && self istouching( trigger ) )
    {
        origin = self getorigin();
        range = 300;
        maxdamage = 2000;
        mindamage = 50;
        radiusdamage( origin, range, maxdamage, mindamage );
    }
    
    self.minefield = undefined;
}

