#using script_53651341190c5aab;
#using scripts\asm\asm;
#using scripts\common\cap;
#using scripts\common\string;

#namespace civ_group;

// Namespace civ_group / namespace_6dfc85bbd850d6d
// Params 1
// Checksum 0x0, Offset: 0x122
// Size: 0x87
function getfunction( funcid )
{
    switch ( funcid )
    {
        case #"hash_fe0e9f8796a0acad":
            return &onUserInit;
        case #"hash_e93ace2ec1639636":
            return &onUserTerminate;
        case #"hash_ec77c425122ce561":
            return &startcaprole;
        case #"hash_f803c2a7263b7274":
            return &assignrole;
        case #"hash_c97cf04d1c01da13":
            return &filterlastrole;
        case #"hash_331df3154e569c83":
            return &CanLeaveGroup;
    }
    
    return namespace_f901a4f9d899be59::function_efcea5d26798e5b6( funcid );
}

// Namespace civ_group / namespace_6dfc85bbd850d6d
// Params 1
// Checksum 0x0, Offset: 0x1b2
// Size: 0x99
function onUserInit( interactionid )
{
    sid = scripts\common\string::to_string( interactionid );
    
    if ( !isdefined( level.bseqinstancedata ) )
    {
        level.bseqinstancedata = [];
    }
    
    if ( !isdefined( level.bseqinstancedata[ sid ] ) )
    {
        level.bseqinstancedata[ sid ] = spawnstruct();
        level.bseqinstancedata[ sid ].nextrole = 0;
    }
    
    self.lastrole = 0;
    self.interactionrole = "undefined";
    self.var_85ecbbe4fae7c0ae = "cap_init";
    self notify( "interaction_end" );
}

// Namespace civ_group / namespace_6dfc85bbd850d6d
// Params 1
// Checksum 0x0, Offset: 0x253
// Size: 0x91
function onUserTerminate( interactionid )
{
    function_25c933655d73066a( interactionid );
    self.lastrole = undefined;
    self.interactionrole = undefined;
    self.lastrole = 0;
    self._blackboard.bseqphase = undefined;
    sid = scripts\common\string::to_string( interactionid );
    level.bseqinstancedata[ sid ].nextrole--;
    OnDeleteUser( interactionid );
    
    if ( self.defaultasm != self.asmname )
    {
        scripts\common\cap::cap_exit();
    }
}

// Namespace civ_group / namespace_6dfc85bbd850d6d
// Params 2
// Checksum 0x0, Offset: 0x2ec
// Size: 0xee
function assignrole( statename, params )
{
    roles = [ "Guy1", "Guy2", "Guy3", "Guy4", "Guy5", "Guy6" ];
    interactionid = self getinteractionid();
    sid = scripts\common\string::to_string( interactionid );
    roleindex = level.bseqinstancedata[ sid ].nextrole;
    self.interactionrole = roles[ roleindex ];
    capinfo = undefined;
    
    if ( isdefined( roles[ roleindex + 1 ] ) )
    {
        capinfo = getcapinfoforrole( self, roles[ roleindex + 1 ] );
    }
    
    if ( !isdefined( capinfo ) )
    {
        self.lastrole = 1;
    }
    
    level.bseqinstancedata[ sid ].nextrole++;
}

// Namespace civ_group / namespace_6dfc85bbd850d6d
// Params 2
// Checksum 0x0, Offset: 0x3e2
// Size: 0xab
function startcaprole( statename, shouldteleport )
{
    capinfo = undefined;
    
    if ( isdefined( self.interactionrole ) )
    {
        capinfo = getcapinfoforrole( self, self.interactionrole );
    }
    
    if ( !isdefined( capinfo ) )
    {
        scripts\asm\asm::asm_fireephemeralevent( "exit", "end" );
        self leaveinteraction();
        return;
    }
    
    role = [ self.interactionrole ];
    
    if ( isdefined( shouldteleport[ 0 ] ) || istrue( self.startinteractionimmediate ) )
    {
        self.startinteractionimmediate = 1;
        self.customarrivalhandler = &customarrival;
    }
    
    startcap( statename, role );
}

// Namespace civ_group / namespace_6dfc85bbd850d6d
// Params 1
// Checksum 0x0, Offset: 0x495
// Size: 0x15, Type: bool
function filterlastrole( param )
{
    return istrue( self.lastrole );
}

// Namespace civ_group / namespace_6dfc85bbd850d6d
// Params 4
// Checksum 0x0, Offset: 0x4b3
// Size: 0x2d, Type: bool
function CanLeaveGroup( asmname, statename, tostatename, params )
{
    return istrue( self.CanLeaveGroup );
}

// Namespace civ_group / namespace_6dfc85bbd850d6d
// Params 0
// Checksum 0x0, Offset: 0x4e9
// Size: 0x2
function customarrival()
{
    
}

