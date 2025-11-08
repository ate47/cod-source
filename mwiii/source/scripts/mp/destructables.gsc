#namespace destructables;

// Namespace destructables / scripts\mp\destructables
// Params 0
// Checksum 0x0, Offset: 0xb9
// Size: 0x73
function init()
{
    ents = getentarray( "destructable", "targetname" );
    
    if ( getdvar( @"scr_destructables" ) == "0" )
    {
        for ( i = 0; i < ents.size ; i++ )
        {
            ents[ i ] delete();
        }
        
        return;
    }
    
    for ( i = 0; i < ents.size ; i++ )
    {
        ents[ i ] thread destructable_think();
    }
}

// Namespace destructables / scripts\mp\destructables
// Params 0
// Checksum 0x0, Offset: 0x134
// Size: 0x10e
function destructable_think()
{
    accumulate = 40;
    threshold = 0;
    
    if ( isdefined( self.script_accumulate ) )
    {
        accumulate = self.script_accumulate;
    }
    
    if ( isdefined( self.script_threshold ) )
    {
        threshold = self.script_threshold;
    }
    
    if ( isdefined( self.script_destructable_area ) )
    {
        areas = strtok( self.script_destructable_area, " " );
        
        for ( i = 0; i < areas.size ; i++ )
        {
            blockarea( areas[ i ] );
        }
    }
    
    if ( isdefined( self.script_fxid ) )
    {
        self.fx = loadfx( self.script_fxid );
    }
    
    dmg = 0;
    self setcandamage( 1 );
    
    while ( true )
    {
        self waittill( "damage", amount, other );
        
        if ( amount >= threshold )
        {
            dmg += amount;
            
            if ( dmg >= accumulate )
            {
                thread destructable_destruct();
                return;
            }
        }
    }
}

// Namespace destructables / scripts\mp\destructables
// Params 0
// Checksum 0x0, Offset: 0x24a
// Size: 0x9b
function destructable_destruct()
{
    ent = self;
    
    if ( isdefined( self.script_destructable_area ) )
    {
        areas = strtok( self.script_destructable_area, " " );
        
        for ( i = 0; i < areas.size ; i++ )
        {
            unblockarea( areas[ i ] );
        }
    }
    
    if ( isdefined( ent.fx ) )
    {
        playfx( ent.fx, ent.origin + ( 0, 0, 6 ) );
    }
    
    ent delete();
}

// Namespace destructables / scripts\mp\destructables
// Params 1
// Checksum 0x0, Offset: 0x2ed
// Size: 0xb
function blockarea( area )
{
    
}

// Namespace destructables / scripts\mp\destructables
// Params 2
// Checksum 0x0, Offset: 0x300
// Size: 0x13
function blockentsinarea( ents, area )
{
    
}

// Namespace destructables / scripts\mp\destructables
// Params 1
// Checksum 0x0, Offset: 0x31b
// Size: 0xb
function unblockarea( area )
{
    
}

// Namespace destructables / scripts\mp\destructables
// Params 2
// Checksum 0x0, Offset: 0x32e
// Size: 0x13
function unblockentsinarea( ents, area )
{
    
}

