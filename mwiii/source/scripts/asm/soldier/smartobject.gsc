#using scripts\anim\notetracks;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\death;
#using scripts\asm\soldier\move;
#using scripts\asm\soldier\pain;
#using scripts\asm\soldier\patrol;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\smartobjects\utility;

#namespace smartobject;

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 3
// Checksum 0x0, Offset: 0x193
// Size: 0x70
function smartobjectinit( asmname, startname, params )
{
    assert( !isdefined( self.asm.smartobject ) );
    self.asm.smartobject = bb_getrequestedsmartobject();
    assert( isdefined( self.asm.smartobject ) );
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 3
// Checksum 0x0, Offset: 0x20b
// Size: 0x83
function smartobjectcomplete( asmname, statename, params )
{
    self.asm.smartobject.lastusetime = gettime();
    self.asm.smartobject smartobject_setnextuse();
    self.asm.smartobject = undefined;
    bb_clearplaysmartobject();
    asm_fireephemeralevent( "smartobject", "finished" );
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 0
// Checksum 0x0, Offset: 0x296
// Size: 0x3e
function getsmartobjectinfo()
{
    type = getsmartobjecttype( self.asm.smartobject.script_smartobject );
    return [[ type.fngetinfo ]]();
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 4
// Checksum 0x0, Offset: 0x2dd
// Size: 0x48, Type: bool
function smartobjecthasintro( asmname, statename, tostatename, params )
{
    info = getsmartobjectinfo();
    
    if ( !isdefined( info.hasintro ) )
    {
        return false;
    }
    
    return true;
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 4
// Checksum 0x0, Offset: 0x32e
// Size: 0x25, Type: bool
function smartobjecthaslogic( asmname, statename, tostatename, params )
{
    return true;
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 4
// Checksum 0x0, Offset: 0x35c
// Size: 0x48, Type: bool
function smartobjecthasoutro( asmname, statename, tostatename, params )
{
    info = getsmartobjectinfo();
    
    if ( !isdefined( info.hasoutro ) )
    {
        return false;
    }
    
    return true;
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 4
// Checksum 0x0, Offset: 0x3ad
// Size: 0x41, Type: bool
function smartobjecthasexits( asmname, statename, tostatename, params )
{
    info = getsmartobjectinfo();
    return istrue( info.hasexits );
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 4
// Checksum 0x0, Offset: 0x3f7
// Size: 0x41, Type: bool
function shouldplaysmartobjectpain( asmname, statename, tostatename, params )
{
    info = getsmartobjectinfo();
    return istrue( info.haspain );
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 4
// Checksum 0x0, Offset: 0x441
// Size: 0x41, Type: bool
function shouldplaysmartobjectdeath( asmname, statename, tostatename, params )
{
    info = getsmartobjectinfo();
    return istrue( info.hasdeath );
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 4
// Checksum 0x0, Offset: 0x48b
// Size: 0x41, Type: bool
function shouldplaysmartobjectreact( asmname, statename, tostatename, params )
{
    info = getsmartobjectinfo();
    return istrue( info.hasreact );
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 4
// Checksum 0x0, Offset: 0x4d5
// Size: 0xa0, Type: bool
function shouldsmartobjectreact( asmname, statename, tostatename, params )
{
    info = getsmartobjectinfo();
    
    if ( istrue( info.bdonotreact ) )
    {
        return false;
    }
    
    if ( self shouldpatrolreact() )
    {
        return true;
    }
    
    if ( isdefined( info.fninterrupt ) && self [[ info.fninterrupt ]]() )
    {
        if ( !isdefined( self.var_fd01ad49b4e38ae8 ) )
        {
            self.var_fd01ad49b4e38ae8 = "med";
        }
        
        self.var_df902e311df99de7 = gettime();
        return true;
    }
    
    return false;
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 3
// Checksum 0x0, Offset: 0x57e
// Size: 0x6c
function playsmartobjectintro( asmname, statename, params )
{
    smartobject = self.asm.smartobject;
    
    if ( isdefined( smartobject.angles ) )
    {
        self orientmode( "face angle", smartobject.angles[ 1 ] );
    }
    
    playsmartobjectanim( asmname, statename );
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 3
// Checksum 0x0, Offset: 0x5f2
// Size: 0xbb
function playsmartobjectlogic( asmname, statename, params )
{
    self endon( statename + "_finished" );
    smartobject = self.asm.smartobject;
    
    if ( isdefined( smartobject.angles ) )
    {
        self orientmode( "face angle", smartobject.angles[ 1 ] );
    }
    
    info = getsmartobjectinfo();
    
    if ( isdefined( info.fnonuse ) )
    {
        self [[ info.fnonuse ]]( smartobject );
    }
    
    playsmartobjectanim( asmname, statename, 0.1, "finished" );
    self asmfireevent( asmname, "smartobject_finished" );
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 3
// Checksum 0x0, Offset: 0x6b5
// Size: 0x9a
function choosesmartobjectanim( asmname, statename, params )
{
    info = getsmartobjectinfo();
    
    if ( istrue( info.var_d0fc6475ed819558 ) )
    {
        return undefined;
    }
    
    animalias = info.animlist[ statename ];
    data = spawnstruct();
    data.animindex = asm_lookupanimfromalias( info.animstatename, animalias );
    data.statename = info.animstatename;
    return data;
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 4
// Checksum 0x0, Offset: 0x758
// Size: 0x137
function playsmartobjectanim( asmname, statename, earlytime, earlynotify )
{
    self endon( statename + "_finished" );
    animdata = asm_getanim( asmname, statename );
    
    if ( !isdefined( animdata ) )
    {
        self waittill( "forever" );
    }
    
    self aisetanim( animdata.statename, animdata.animindex );
    asm_playfacialanim( asmname, animdata.statename, asm_getxanim( animdata.statename, animdata.animindex ) );
    
    if ( isdefined( earlytime ) && isdefined( earlynotify ) )
    {
        xanim = asm_getxanim( animdata.statename, animdata.animindex );
        waittime = getanimlength( xanim ) - earlytime;
        childthread smartobject_earlynotifier( waittime, earlynotify );
    }
    
    endnote = asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ), undefined, animdata.statename );
    
    if ( endnote == "code_move" )
    {
        endnote = asm_donotetracks( asmname, statename, undefined, undefined, animdata.statename );
    }
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 2
// Checksum 0x0, Offset: 0x897
// Size: 0x22
function smartobject_earlynotifier( waittime, earlynotify )
{
    wait waittime;
    asm_fireephemeralevent( "smartobject", earlynotify );
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 1
// Checksum 0x0, Offset: 0x8c1
// Size: 0x47
function smartobject_notetrackhandler( note )
{
    if ( scripts\anim\notetracks::notetrack_prefix_handler( note ) )
    {
        return;
    }
    
    info = getsmartobjectinfo();
    
    if ( isdefined( info.fnnotetrackhandle ) )
    {
        return self [[ info.fnnotetrackhandle ]]( note );
    }
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 4
// Checksum 0x0, Offset: 0x910
// Size: 0x42, Type: bool
function smartobject_shouldexitintomove( asmname, statename, tostatename, params )
{
    return isdefined( self.pathgoalpos ) && length2dsquared( self.velocity ) > 1;
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 3
// Checksum 0x0, Offset: 0x95b
// Size: 0x67
function playsmartobjectexit( asmname, statename, params )
{
    info = getsmartobjectinfo();
    exitanim = asm_getanim( asmname, statename );
    
    if ( !isdefined( exitanim ) )
    {
        asm_fireevent( asmname, "abort" );
        return;
    }
    
    scripts\asm\soldier\move::playstartanim( asmname, info.animstatename, exitanim, 0 );
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 3
// Checksum 0x0, Offset: 0x9ca
// Size: 0x40
function choosesmartobjectexitanim( asmname, statename, params )
{
    info = getsmartobjectinfo();
    return scripts\asm\soldier\move::chooseanim_exit( asmname, info.animstatename, params );
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 3
// Checksum 0x0, Offset: 0xa13
// Size: 0x41
function playsmartobjectreactanim( asmname, statename, params )
{
    info = getsmartobjectinfo();
    scripts\asm\soldier\patrol::playanim_patrolreact_internal( asmname, statename, info.animstatename );
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 3
// Checksum 0x0, Offset: 0xa5c
// Size: 0xfb
function choosesmartobjectreactanim( asmname, statename, params )
{
    info = getsmartobjectinfo();
    
    if ( isdefined( info.animlist ) && isdefined( info.animlist[ statename ] ) )
    {
        assert( asm_hasalias( info.animstatename, info.animlist[ statename ] ) );
        return asm_lookupanimfromalias( info.animstatename, info.animlist[ statename ] );
    }
    
    directionindex = scripts\asm\soldier\patrol::getpatrolreactdirindex();
    alias = "react_med_" + directionindex;
    assertex( asm_hasalias( info.animstatename, alias ), "<dev string:x1c>" + info.animstatename + "<dev string:x42>" + alias );
    return asm_lookupanimfromalias( info.animstatename, alias );
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 3
// Checksum 0x0, Offset: 0xb60
// Size: 0x45
function playsmartobjectpainanim( asmname, statename, params )
{
    info = getsmartobjectinfo();
    scripts\asm\soldier\pain::playpainaniminternal( asmname, statename, params, 0, 1, info.animstatename );
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 3
// Checksum 0x0, Offset: 0xbad
// Size: 0x5a
function playsmartobjectdeathanim( asmname, statename, params )
{
    info = getsmartobjectinfo();
    self.deathstate = info.animstatename;
    self.deathalias = choosesmartobjectdeathalias( statename );
    scripts\asm\soldier\death::playdeathanim( asmname, statename );
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 3
// Checksum 0x0, Offset: 0xc0f
// Size: 0xf0
function choosesmartobjectpainanim( asmname, statename, params )
{
    info = getsmartobjectinfo();
    
    if ( isdefined( info.animlist ) && isdefined( info.animlist[ statename ] ) )
    {
        assert( asm_hasalias( info.animstatename, info.animlist[ statename ] ) );
        return asm_lookupanimfromalias( info.animstatename, info.animlist[ statename ] );
    }
    
    painalias = "pain_" + smtobjgetdamagedir();
    assertex( asm_hasalias( info.animstatename, painalias ), "<dev string:x71>" + info.animstatename + "<dev string:x42>" + painalias );
    return asm_lookupanimfromalias( info.animstatename, painalias );
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 0
// Checksum 0x0, Offset: 0xd08
// Size: 0x6f
function smtobjgetdamagedir()
{
    anglediff = angleclamp180( self.damageyaw - self.angles[ 1 ] );
    
    if ( anglediff < -135 )
    {
        return "2";
    }
    
    if ( anglediff < -45 )
    {
        return "4";
    }
    
    if ( anglediff > 135 )
    {
        return "2";
    }
    
    if ( anglediff > 45 )
    {
        return "6";
    }
    
    return "8";
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 3
// Checksum 0x0, Offset: 0xd7f
// Size: 0x50
function choosesmartobjectdeathanim( asmname, statename, params )
{
    info = getsmartobjectinfo();
    deathalias = choosesmartobjectdeathalias( statename );
    return asm_lookupanimfromalias( info.animstatename, deathalias );
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 1
// Checksum 0x0, Offset: 0xdd8
// Size: 0xbe
function choosesmartobjectdeathalias( statename )
{
    info = getsmartobjectinfo();
    
    if ( isdefined( info.animlist ) && isdefined( info.animlist[ statename ] ) )
    {
        assert( asm_hasalias( info.animstatename, info.animlist[ statename ] ) );
        return info.animlist[ statename ];
    }
    
    deathalias = "death_" + smtobjgetdamagedir();
    assertex( asm_hasalias( info.animstatename, deathalias ), "<dev string:x93>" + info.animstatename + "<dev string:xb6>" + deathalias );
    return deathalias;
}

// Namespace smartobject / scripts\asm\soldier\smartobject
// Params 3
// Checksum 0x0, Offset: 0xe9f
// Size: 0x8c, Type: bool
function needtoturntosmartobject( asmname, statename, params )
{
    smartobj = bb_getrequestedsmartobject();
    
    if ( !isdefined( smartobj ) )
    {
        return false;
    }
    
    if ( !isdefined( smartobj.angles ) )
    {
        return false;
    }
    
    anglediff = angleclamp180( smartobj.angles[ 1 ] - self.angles[ 1 ] );
    
    if ( -45 < anglediff && anglediff < 45 )
    {
        return false;
    }
    
    self.desiredturnyaw = anglediff;
    return true;
}

