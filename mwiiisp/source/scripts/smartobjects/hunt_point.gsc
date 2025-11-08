#using scripts\anim\battlechatter;
#using scripts\asm\asm;
#using scripts\asm\gesture;
#using scripts\engine\utility;
#using scripts\smartobjects\utility;
#using scripts\stealth\group;

#namespace hunt_point;

// Namespace hunt_point / scripts\smartobjects\hunt_point
// Params 0
// Checksum 0x0, Offset: 0x13f
// Size: 0x18
function main()
{
    add_smartobject_type( "hunt_point", &getinfo, &canuse );
}

// Namespace hunt_point / scripts\smartobjects\hunt_point
// Params 1
// Checksum 0x0, Offset: 0x15f
// Size: 0xd, Type: bool
function canuse( object )
{
    return true;
}

// Namespace hunt_point / scripts\smartobjects\hunt_point
// Params 0
// Checksum 0x0, Offset: 0x175
// Size: 0x5c
function getinfo()
{
    info = createsmartobjectinfo();
    info.fnonuse = &onuse;
    info.var_d0fc6475ed819558 = 1;
    info.radiussqrd = 3600;
    info.nextusetime = 0;
    info addsmartobjectanim( "loop" );
    return info;
}

// Namespace hunt_point / scripts\smartobjects\hunt_point
// Params 1
// Checksum 0x0, Offset: 0x1da
// Size: 0x17f
function onuse( object )
{
    var_e8003c5231baea93 = self._blackboard.var_3dbe624a18d61f13;
    pod = function_bc5df124338cefea( self );
    assert( isdefined( pod ) );
    job = pod scripts\stealth\group::function_75087b386454d072( self );
    otherguy = job.guys[ 0 ];
    
    if ( self == otherguy )
    {
        otherguy = job.guys[ 1 ];
    }
    
    var_b45b78df70b9fd3a = otherguy.var_7b492275ef047be2;
    
    if ( self == job.leader )
    {
        exit_wait = randomintrange( 1200, 2800 );
        self.var_9a04c6cfe15e92a7 = self.origin;
        self.var_587d8840dea10869 = 1;
        self.var_4b1fa39975a3fd58 = exit_wait;
        scripts\asm\gesture::ai_request_gesture( "military_point", var_e8003c5231baea93, 1000, "first_hunt_gesture" );
        self waittill( "first_hunt_gesture" );
        
        if ( !isdefined( var_b45b78df70b9fd3a ) )
        {
            scripts\asm\gesture::ai_request_gesture( "talk", undefined, 1000, "hunt_gesture" );
        }
        else
        {
            otherguy delaycall( 0.5, &glanceatpos, var_b45b78df70b9fd3a, 300 );
            scripts\asm\gesture::ai_request_gesture( "military_point", var_b45b78df70b9fd3a, 1000, "hunt_gesture" );
        }
    }
    else
    {
        scripts\asm\gesture::ai_request_gesture( "yes", undefined, 1000, "hunt_gesture" );
    }
    
    thread waitforgesture( "hunt_gesture" );
    scripts\anim\battlechatter::set_cooldown( "coordinate", 20 );
}

// Namespace hunt_point / scripts\smartobjects\hunt_point
// Params 1
// Checksum 0x0, Offset: 0x361
// Size: 0x6e
function waitforgesture( flag )
{
    self endon( "death" );
    self endon( "smartobject_logic_finished" );
    self setlookatentity();
    childthread waitforgesture_timeout( 10 );
    
    while ( true )
    {
        self waittill( flag, status );
        
        if ( status == "gesture_finish" || status == "gesture_cancel" )
        {
            break;
        }
    }
    
    scripts\asm\asm::asm_fireevent( self.asmname, "smartobject_finished" );
}

// Namespace hunt_point / scripts\smartobjects\hunt_point
// Params 1
// Checksum 0x0, Offset: 0x3d7
// Size: 0x22
function waitforgesture_timeout( t )
{
    wait t;
    scripts\asm\asm::asm_fireevent( self.asmname, "smartobject_finished" );
}

