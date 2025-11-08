#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\cap;

#namespace use_armor_plate_solo;

// Namespace use_armor_plate_solo / namespace_6930af0ec0bf4a3f
// Params 1
// Checksum 0x0, Offset: 0x1c9
// Size: 0x7e
function getfunction( funcid )
{
    switch ( funcid )
    {
        case #"hash_dab0d83df51da4d":
            return &onUserInit;
        case #"hash_722d767fd6d40f56":
            return &onUserTerminate;
        case #"hash_902f9e79d5e57c83":
            return &oneventreceived;
        case #"hash_1637227a26307eb5":
            return &setstationary;
        case #"hash_6279e013ab5c4fdd":
            return &usearmorplate;
    }
    
    assertmsg( "<dev string:x1c>" + funcid );
}

// Namespace use_armor_plate_solo / namespace_6930af0ec0bf4a3f
// Params 1
// Checksum 0x0, Offset: 0x24f
// Size: 0xb
function onUserInit( interactionid )
{
    
}

// Namespace use_armor_plate_solo / namespace_6930af0ec0bf4a3f
// Params 1
// Checksum 0x0, Offset: 0x262
// Size: 0xa1
function onUserTerminate( interactionid )
{
    self clearbtgoal( 1 );
    self notify( "endusearmorplate" );
    
    /#
        if ( isagent( self ) )
        {
            assertex( self isscriptable(), "<dev string:x3d>" + self.agent_type + "<dev string:x4d>" );
        }
    #/
    
    scriptablepart = "armor_plate";
    
    if ( self isscriptable() && self getscriptablehaspart( scriptablepart ) )
    {
        self setscriptablepartstate( scriptablepart, "default" );
    }
    
    if ( isalive( self ) && self.asmname == "cap_use_armor_plate_solo" )
    {
        scripts\common\cap::cap_exit();
    }
}

// Namespace use_armor_plate_solo / namespace_6930af0ec0bf4a3f
// Params 3
// Checksum 0x0, Offset: 0x30b
// Size: 0x65, Type: bool
function oneventreceived( receiver, info, origin )
{
    if ( info == "focused_on" )
    {
        distsq = distancesquared( receiver.origin, origin );
        breakoutdist = 150;
        
        if ( distsq < breakoutdist * breakoutdist )
        {
            self notify( "endusearmorplate" );
            return true;
        }
        
        return true;
    }
    
    return false;
}

// Namespace use_armor_plate_solo / namespace_6930af0ec0bf4a3f
// Params 2
// Checksum 0x0, Offset: 0x379
// Size: 0x28
function setstationary( statename, params )
{
    self function_e64ea2b4e79c4b74( 1 );
    self setbtgoalradius( 1, params[ 0 ] );
}

// Namespace use_armor_plate_solo / namespace_6930af0ec0bf4a3f
// Params 2
// Checksum 0x0, Offset: 0x3a9
// Size: 0x72
function usearmorplate( statename, params )
{
    self endon( "death" );
    self endon( "endusearmorplate" );
    capname = "cap_use_armor_plate_solo";
    
    if ( self.asmname != capname )
    {
        scripts\common\cap::cap_start( capname, "caps/interactions/cap_use_armor_plate_solo" );
    }
    
    tempdialogue( "Using Armor Plate!" );
    self waittill( "cap_exit_completed" );
    asm_fireephemeralevent( "use_armor_plate", "end" );
}

// Namespace use_armor_plate_solo / namespace_6930af0ec0bf4a3f
// Params 1
// Checksum 0x0, Offset: 0x423
// Size: 0x64
function tempdialogue( var_22e9090a351646e9 )
{
    debug = getdvarint( @"hash_3e267ec6e066e2b", 0 );
    
    if ( istrue( debug ) )
    {
        /#
            print3d( self.origin + ( 0, 0, 80 ), var_22e9090a351646e9, ( 1, 1, 1 ), 1, 0.8, 1, 1 );
        #/
    }
}

