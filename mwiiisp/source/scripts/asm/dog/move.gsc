#using scripts\asm\asm;
#using scripts\common\cap;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace move;

// Namespace move / scripts\asm\dog\move
// Params 3
// Checksum 0x0, Offset: 0x1f2
// Size: 0x8a
function dog_init( asmname, statename, params )
{
    self.sharpturnlookaheaddist = 60;
    self getbasearchetype();
    self.asm.customdata = spawnstruct();
    self enabletraversals( 0 );
    self.soundent = spawn_tag_origin();
    self.soundent linkto( self, "tag_eye" );
    scripts\common\cap::init_cap();
    thread waitfordeath( self.soundent );
}

// Namespace move / scripts\asm\dog\move
// Params 1
// Checksum 0x0, Offset: 0x284
// Size: 0x27
function waitfordeath( soundent )
{
    self waittill( "death" );
    
    if ( isdefined( soundent ) )
    {
        soundent stopsounds();
        waitframe();
        soundent delete();
    }
}

// Namespace move / scripts\asm\dog\move
// Params 4
// Checksum 0x0, Offset: 0x2b3
// Size: 0x102
function needtoturn( asmname, statename, tostatename, params )
{
    target = undefined;
    
    if ( isdefined( self.enemy ) )
    {
        target = self.enemy;
    }
    else if ( isdefined( self._blackboard.target ) )
    {
        target = self._blackboard.target;
    }
    
    if ( !isdefined( target ) )
    {
        return 0;
    }
    
    metotarget = vectornormalize( target.origin - self.origin );
    desiredyaw = vectortoyaw( metotarget );
    anglediff = angleclamp180( desiredyaw - self.angles[ 1 ] );
    bturn = anglediff < -35 || anglediff > 35;
    
    if ( bturn )
    {
        self._blackboard.desiredturnyaw = desiredyaw;
    }
    
    return bturn;
}

// Namespace move / scripts\asm\dog\move
// Params 4
// Checksum 0x0, Offset: 0x3be
// Size: 0xb9
function needtoturnforexit( asmname, statename, tostatename, params )
{
    if ( !isdefined( self.pathgoalpos ) )
    {
        return 0;
    }
    
    if ( distance2dsquared( self.origin, self.pathgoalpos ) < 4 )
    {
        return 0;
    }
    
    lookaheadyaw = vectortoyaw( self.lookaheaddir );
    anglediff = angleclamp180( lookaheadyaw - self.angles[ 1 ] );
    bturn = anglediff < -46 || anglediff > 46;
    
    if ( bturn )
    {
        self._blackboard.desiredturnyaw = lookaheadyaw;
    }
    
    return bturn;
}

// Namespace move / scripts\asm\dog\move
// Params 4
// Checksum 0x0, Offset: 0x480
// Size: 0x8e, Type: bool
function shouldstartarrival( asmname, statename, tostatename, params )
{
    if ( !isdefined( self.pathgoalpos ) )
    {
        return false;
    }
    
    if ( self.in_melee )
    {
        return false;
    }
    
    if ( !asm_eventfired( asmname, "cover_approach" ) )
    {
        return false;
    }
    
    var_c5bad00580f36fb7 = 128;
    var_d3c3e7b6d4058099 = 96;
    var_39d91e399be1c48d = self pathdisttogoal();
    
    if ( var_39d91e399be1c48d > var_c5bad00580f36fb7 || var_39d91e399be1c48d < var_d3c3e7b6d4058099 )
    {
        return false;
    }
    
    return true;
}

// Namespace move / scripts\asm\dog\move
// Params 3
// Checksum 0x0, Offset: 0x517
// Size: 0x27
function chooseanim_arrival( asmname, statename, params )
{
    return asm_lookupanimfromalias( statename, "2" );
}

// Namespace move / scripts\asm\dog\move
// Params 3
// Checksum 0x0, Offset: 0x547
// Size: 0x184
function playanim_arrival( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self animmode( "zonly_physics", 0 );
    arrivalanim = asm_getanim( asmname, statename );
    arrivalxanim = asm_getxanim( statename, arrivalanim );
    var_ca37f3fb87ac82a1 = self.pathgoalpos - self.origin;
    desiredangle = vectortoyaw( var_ca37f3fb87ac82a1 );
    animdelta = getmovedelta( arrivalxanim );
    angledelta = getangledelta( arrivalxanim );
    actualdist = length( var_ca37f3fb87ac82a1 );
    arrivalrate = length( animdelta ) / actualdist;
    goalpos = self.pathgoalpos;
    desiredstartpos = goalpos - rotatevector( animdelta, ( 0, desiredangle, 0 ) );
    goalyaw = desiredangle + angledelta;
    warpduration = int( 1000 * getanimlength( arrivalxanim ) - 200 );
    self startcoverarrival();
    self motionwarpwithanim( desiredstartpos, ( 0, desiredangle, 0 ), goalpos, ( 0, goalyaw, 0 ), warpduration );
    self.asm.arriving = statename;
    self aisetanim( statename, arrivalanim, arrivalrate );
    asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ), statename );
}

// Namespace move / scripts\asm\dog\move
// Params 3
// Checksum 0x0, Offset: 0x6d3
// Size: 0x29
function playanim_arrival_cleanup( asmname, statename, params )
{
    self finishcoverarrival();
    self motionwarpcancel();
}

// Namespace move / scripts\asm\dog\move
// Params 3
// Checksum 0x0, Offset: 0x704
// Size: 0xe0
function chooseturnanim( asmname, statename, params )
{
    assert( isdefined( self._blackboard.desiredturnyaw ) );
    anglediff = angleclamp180( self._blackboard.desiredturnyaw - self.angles[ 1 ] );
    animmap = [ "2", "3", "6", "9", "8", "7", "4", "1", "2" ];
    animindex = getangleindex( anglediff );
    return asm_lookupanimfromalias( statename, animmap[ animindex ] );
}

// Namespace move / scripts\asm\dog\move
// Params 3
// Checksum 0x0, Offset: 0x7ed
// Size: 0x72
function function_5f1dbd8857a878ad( asmname, statename, params )
{
    self endon( statename + "_finished" );
    turnanim = asm_getanim( asmname, statename );
    self aisetanim( statename, turnanim );
    self.useanimgoalweight = 1;
    self._blackboard.turnanim = turnanim;
    asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ), statename );
}

// Namespace move / scripts\asm\dog\move
// Params 3
// Checksum 0x0, Offset: 0x867
// Size: 0x4b
function playturnanim_cleanup( asmname, statename, params )
{
    self.useanimgoalweight = 0;
    self._blackboard.desiredturnyaw = undefined;
    self._blackboard.turnanim = undefined;
}

// Namespace move / scripts\asm\dog\move
// Params 3
// Checksum 0x0, Offset: 0x8ba
// Size: 0x3b
function playanim_idle( asmname, statename, params )
{
    thread playanim_headtrack( asmname, statename );
    thread playanim_growltrack( asmname, statename );
    function_fb56c9527636713f( asmname, statename, 1, 0 );
}

// Namespace move / scripts\asm\dog\move
// Params 2
// Checksum 0x0, Offset: 0x8fd
// Size: 0xa6
function playanim_headtrack( asmname, statename )
{
    self endon( statename + "_finished" );
    
    while ( true )
    {
        if ( isdefined( self.stealth ) && self.stealthidlecurious )
        {
            assert( isdefined( self.soundent ) );
            
            if ( utility::issp() )
            {
                self.soundent playsound( "anml_dog_bark_attention", "dog_bark_attention", 1 );
            }
            else
            {
                self.soundent scripts\engine\utility::playsoundonentity( "anml_dog_bark_attention", "dog_bark_attention" );
            }
            
            self.soundent waittill( "dog_bark_attention" );
        }
        
        waitframe();
    }
}

// Namespace move / scripts\asm\dog\move
// Params 2
// Checksum 0x0, Offset: 0x9ab
// Size: 0xca
function playanim_growltrack( asmname, statename )
{
    self endon( statename + "_finished" );
    
    while ( true )
    {
        while ( !isdefined( self.stealth ) || !isdefined( self.stealth.bgrowl ) || !self.stealth.bgrowl )
        {
            waitframe();
        }
        
        assert( isdefined( self.soundent ) );
        
        if ( utility::issp() )
        {
            self.soundent playsound( "anml_dog_growl", "dog_growl", 1 );
        }
        else
        {
            self.soundent scripts\engine\utility::playsoundonentity( "anml_dog_growl", "dog_growl" );
        }
        
        self.soundent waittill( "dog_growl" );
        waitframe();
    }
}

// Namespace move / scripts\asm\dog\move
// Params 4
// Checksum 0x0, Offset: 0xa7d
// Size: 0x76, Type: bool
function shouldidlebark( asmname, statename, tostatename, params )
{
    var_8ed21a2d0e7adb3 = isdefined( self.stealth ) && isdefined( self.stealth.bbark ) && self.stealth.bbark;
    return istrue( self.forcebark ) || var_8ed21a2d0e7adb3;
}

// Namespace move / scripts\asm\dog\move
// Params 4
// Checksum 0x0, Offset: 0xafc
// Size: 0x2e, Type: bool
function notshouldidlebark( asmname, statename, tostatename, params )
{
    return !shouldidlebark( asmname, statename, tostatename, params );
}

// Namespace move / scripts\asm\dog\move
// Params 3
// Checksum 0x0, Offset: 0xb33
// Size: 0x6d
function playanim_bark( asmname, statename, params )
{
    self endon( statename + "_finished" );
    var_ee74db5e2b0c71f6 = asm_getanim( asmname, statename );
    self aisetanim( statename, var_ee74db5e2b0c71f6 );
    
    while ( true )
    {
        asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ), statename );
        var_ee74db5e2b0c71f6 = asm_getanim( asmname, statename );
        self aisetanim( statename, var_ee74db5e2b0c71f6 );
    }
}

// Namespace move / scripts\asm\dog\move
// Params 1
// Checksum 0x0, Offset: 0xba8
// Size: 0x142, Type: bool
function handledogfootstepnotetracks( note )
{
    switch ( note )
    {
        case #"hash_39938c83dae363ae":
        case #"hash_39968283dae59287":
        case #"hash_504bcbfad9f23e88":
        case #"hash_508da5fada25de19":
        case #"hash_d29ca63665fe050e":
        case #"hash_d2ab9c3666092e43":
        case #"hash_ee8da1e0b86401b0":
        case #"hash_ee919be0b867c9d5":
            groundtype = undefined;
            
            if ( isdefined( self.groundtype ) )
            {
                groundtype = self.groundtype;
                self.lastgroundtype = groundtype;
            }
            else if ( isdefined( self.lastgroundtype ) )
            {
                groundtype = self.lastgroundtype;
            }
            else
            {
                groundtype = "dirt";
            }
            
            if ( groundtype != "dirt" && groundtype != "concrete" && groundtype != "wood" && groundtype != "metal" )
            {
                groundtype = "dirt";
            }
            
            if ( groundtype == "concrete" )
            {
                groundtype = "cement";
            }
            
            movetype = self._blackboard.movetype;
            self playsound( "dogstep_" + movetype + "_" + groundtype );
            return true;
    }
    
    return false;
}

// Namespace move / scripts\asm\dog\move
// Params 2
// Checksum 0x0, Offset: 0xcf3
// Size: 0xd6, Type: bool
function handleorientnotetracks( note, statename )
{
    switch ( note )
    {
        case #"hash_5565eda892be0b23":
            if ( isdefined( self._blackboard.turnanim ) && isdefined( self._blackboard.desiredturnyaw ) )
            {
                turnxanim = asm_getxanim( statename, self._blackboard.turnanim );
                curanimtime = self aigetanimtime( turnxanim );
                animendangle = getangledelta( turnxanim, curanimtime, 1 );
                self orientmode( "face angle", self._blackboard.desiredturnyaw - animendangle );
            }
            
            break;
        default:
            return false;
    }
    
    return true;
}

// Namespace move / scripts\asm\dog\move
// Params 2
// Checksum 0x0, Offset: 0xdd2
// Size: 0x125
function dog_notehandler( note, statename )
{
    if ( handledogfootstepnotetracks( note ) )
    {
        return;
    }
    
    if ( note == "sound_dogstep_run_default" )
    {
        self playsound( "dogstep_run_default" );
        return;
    }
    
    if ( handleorientnotetracks( note, statename ) )
    {
        return;
    }
    
    if ( note == "dog_melee" )
    {
        if ( isdefined( self.enemy ) && distance2dsquared( self.origin, self.enemy.origin ) < self.meleerangesq )
        {
            damage = 50;
            
            if ( isdefined( self.unarmedmeleedamageoverride ) )
            {
                damage = self.unarmedmeleedamageoverride;
            }
            
            self.enemy dodamage( damage, self geteye(), self, self, "MOD_MELEE" );
        }
        
        return;
    }
    
    prefix = getsubstr( note, 0, 3 );
    
    if ( prefix != "ps_" )
    {
        return;
    }
    
    alias = getsubstr( note, 3 );
    
    if ( isalive( self ) )
    {
        thread scripts\engine\utility::playsoundontag( alias, "tag_eye" );
        return;
    }
    
    thread play_sound_in_space( alias, self geteye() );
}

