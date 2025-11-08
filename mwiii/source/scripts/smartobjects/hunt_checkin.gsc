#using scripts\asm\asm;
#using scripts\asm\gesture;
#using scripts\engine\utility;
#using scripts\smartobjects\utility;
#using scripts\stealth\group;

#namespace hunt_checkin;

// Namespace hunt_checkin / scripts\smartobjects\hunt_checkin
// Params 0
// Checksum 0x0, Offset: 0x171
// Size: 0x18
function main()
{
    add_smartobject_type( "hunt_checkin", &getinfo, &canuse );
}

// Namespace hunt_checkin / scripts\smartobjects\hunt_checkin
// Params 1
// Checksum 0x0, Offset: 0x191
// Size: 0xd, Type: bool
function canuse( object )
{
    return true;
}

// Namespace hunt_checkin / scripts\smartobjects\hunt_checkin
// Params 0
// Checksum 0x0, Offset: 0x1a7
// Size: 0x5d
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

// Namespace hunt_checkin / scripts\smartobjects\hunt_checkin
// Params 1
// Checksum 0x0, Offset: 0x20d
// Size: 0x169
function onuse( object )
{
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
        exit_wait = randomintrange( 1200, 3600 );
        self.var_9a04c6cfe15e92a7 = self.origin;
        self.stealth.script_skiplookaroundanim = 1;
        self.stealth.script_huntlookaroundduration = exit_wait;
        scripts\asm\gesture::ai_request_gesture( "talk", undefined, 1000, "first_hunt_gesture" );
        self waittill( "first_hunt_gesture" );
        
        if ( !isdefined( var_b45b78df70b9fd3a ) )
        {
            scripts\asm\gesture::ai_request_gesture( "talk", undefined, 1000, "hunt_gesture" );
        }
        else
        {
            self setlookat( var_b45b78df70b9fd3a, 1 );
            scripts\asm\gesture::ai_request_gesture( "military_point", var_b45b78df70b9fd3a, 1000, "hunt_gesture" );
        }
        
        thread waitforgesture( "hunt_gesture" );
        return;
    }
    
    scripts\asm\gesture::ai_request_gesture( "no", undefined, 1000, "hunt_gesture" );
    thread waitforgesture( "hunt_gesture" );
}

// Namespace hunt_checkin / scripts\smartobjects\hunt_checkin
// Params 1
// Checksum 0x0, Offset: 0x37e
// Size: 0x68
function waitforgesture( flag )
{
    self endon( "death" );
    self endon( "smartobject_logic_finished" );
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

// Namespace hunt_checkin / scripts\smartobjects\hunt_checkin
// Params 1
// Checksum 0x0, Offset: 0x3ee
// Size: 0x22
function waitforgesture_timeout( t )
{
    wait t;
    scripts\asm\asm::asm_fireevent( self.asmname, "smartobject_finished" );
}

