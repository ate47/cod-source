#using scripts\asm\asm_bb;

#namespace utility;

// Namespace utility / scripts\smartobjects\utility
// Params 0
// Checksum 0x0, Offset: 0x12e
// Size: 0x1a
function init_smartobjects()
{
    if ( isdefined( anim.smartobjects ) )
    {
        return;
    }
    
    anim.smartobjects = [];
}

// Namespace utility / scripts\smartobjects\utility
// Params 0
// Checksum 0x0, Offset: 0x150
// Size: 0xa4
function validate()
{
    if ( !isdefined( anim.smartobjectpoints ) )
    {
        return;
    }
    
    foreach ( point in anim.smartobjectpoints )
    {
        assertex( isdefined( anim.smartobjects[ point.script_smartobject ] ), "<dev string:x1c>" + point.script_smartobject + "<dev string:x2d>" + point.origin + "<dev string:x36>" );
    }
}

// Namespace utility / scripts\smartobjects\utility
// Params 3
// Checksum 0x0, Offset: 0x1fc
// Size: 0x70
function add_smartobject_type( name, fngetinfo, fnusecondition )
{
    init_smartobjects();
    assert( !isdefined( anim.smartobjects[ name ] ) );
    struct = spawnstruct();
    struct.fngetinfo = fngetinfo;
    struct.fnusecondition = fnusecondition;
    anim.smartobjects[ name ] = struct;
}

// Namespace utility / scripts\smartobjects\utility
// Params 0
// Checksum 0x0, Offset: 0x274
// Size: 0x21
function createsmartobjectinfo()
{
    info = spawnstruct();
    info.animlist = [];
    return info;
}

// Namespace utility / scripts\smartobjects\utility
// Params 2
// Checksum 0x0, Offset: 0x29e
// Size: 0x3c
function addsmartobjectanim_internal( statename, alias )
{
    if ( !isdefined( self.animlist[ statename ] ) )
    {
        self.animlist[ statename ] = [];
    }
    
    self.animlist[ statename ] = alias;
}

// Namespace utility / scripts\smartobjects\utility
// Params 1
// Checksum 0x0, Offset: 0x2e2
// Size: 0x23
function addsmartobjectintroanim( alias )
{
    addsmartobjectanim_internal( "smartobject_intro", alias );
    self.hasintro = 1;
}

// Namespace utility / scripts\smartobjects\utility
// Params 1
// Checksum 0x0, Offset: 0x30d
// Size: 0x18
function addsmartobjectanim( alias )
{
    addsmartobjectanim_internal( "smartobject_logic", alias );
}

// Namespace utility / scripts\smartobjects\utility
// Params 1
// Checksum 0x0, Offset: 0x32d
// Size: 0x28
function addsmartobjectreactanim( alias )
{
    if ( isdefined( alias ) )
    {
        addsmartobjectanim_internal( "smartobject_react", alias );
    }
    
    self.hasreact = 1;
}

// Namespace utility / scripts\smartobjects\utility
// Params 1
// Checksum 0x0, Offset: 0x35d
// Size: 0x23
function addsmartobjectoutroanim( alias )
{
    addsmartobjectanim_internal( "smartobject_outro", alias );
    self.hasoutro = 1;
}

// Namespace utility / scripts\smartobjects\utility
// Params 0
// Checksum 0x0, Offset: 0x388
// Size: 0xd
function addsmartobjectarrivalanims()
{
    self.hasarrivals = 1;
}

// Namespace utility / scripts\smartobjects\utility
// Params 0
// Checksum 0x0, Offset: 0x39d
// Size: 0xd
function addsmartobjectexitanims()
{
    self.hasexits = 1;
}

// Namespace utility / scripts\smartobjects\utility
// Params 1
// Checksum 0x0, Offset: 0x3b2
// Size: 0x28
function addsmartobjectpainanim( alias )
{
    if ( isdefined( alias ) )
    {
        addsmartobjectanim_internal( "smartobject_pain", alias );
    }
    
    self.haspain = 1;
}

// Namespace utility / scripts\smartobjects\utility
// Params 1
// Checksum 0x0, Offset: 0x3e2
// Size: 0x28
function addsmartobjectdeathanim( alias )
{
    if ( isdefined( alias ) )
    {
        addsmartobjectanim_internal( "smartobject_death", alias );
    }
    
    self.hasdeath = 1;
}

// Namespace utility / scripts\smartobjects\utility
// Params 1
// Checksum 0x0, Offset: 0x412
// Size: 0x16
function getsmartobjecttype( name )
{
    return anim.smartobjects[ name ];
}

// Namespace utility / scripts\smartobjects\utility
// Params 0
// Checksum 0x0, Offset: 0x431
// Size: 0x10c
function smartobject_setnextuse()
{
    objtype = getsmartobjecttype( self.script_smartobject );
    info = self [[ objtype.fngetinfo ]]();
    
    if ( isdefined( info.useonce ) )
    {
        self.neveruseagain = 1;
        return;
    }
    
    nextusetime = gettime() + info.nextusetime * 1000;
    self.nextusetime = nextusetime;
    
    if ( isdefined( self.linkedsmartobjects ) )
    {
        foreach ( obj in self.linkedsmartobjects )
        {
            if ( isdefined( obj.nextusetime ) )
            {
                obj.nextusetime = max( obj.nextusetime, nextusetime );
                continue;
            }
            
            obj.nextusetime = nextusetime;
        }
    }
}

// Namespace utility / scripts\smartobjects\utility
// Params 1
// Checksum 0x0, Offset: 0x545
// Size: 0x44
function claimsmartobject( obj )
{
    assertex( !isdefined( obj.claimer ) || obj.claimer == self, "<dev string:x4b>" );
    obj.claimer = self;
}

// Namespace utility / scripts\smartobjects\utility
// Params 1
// Checksum 0x0, Offset: 0x591
// Size: 0x42
function unclaimsmartobject( obj )
{
    assertex( !isdefined( obj.claimer ) || obj.claimer == self, "<dev string:x7b>" );
    obj.claimer = undefined;
}

// Namespace utility / scripts\smartobjects\utility
// Params 1
// Checksum 0x0, Offset: 0x5db
// Size: 0x18, Type: bool
function canclaimsmartobject( obj )
{
    return !isdefined( obj.claimer );
}

// Namespace utility / scripts\smartobjects\utility
// Params 1
// Checksum 0x0, Offset: 0x5fc
// Size: 0x89
function canusesmartobject( obj )
{
    if ( istrue( obj.donotuse ) )
    {
        return 0;
    }
    
    if ( isdefined( obj.neveruseagain ) )
    {
        return 0;
    }
    
    if ( isdefined( obj.nextusetime ) && gettime() < obj.nextusetime )
    {
        return 0;
    }
    
    objbp = getsmartobjecttype( obj.script_smartobject );
    result = [[ objbp.fnusecondition ]]( obj );
    return result;
}

// Namespace utility / scripts\smartobjects\utility
// Params 3
// Checksum 0x0, Offset: 0x68e
// Size: 0xf9
function getbestsmartobject( desiredpos, volume, var_f34327e65116baaa )
{
    if ( !isdefined( anim.smartobjectpoints ) )
    {
        return undefined;
    }
    
    var_b28bb506e83973be = var_f34327e65116baaa * var_f34327e65116baaa;
    allsmartobjects = sortbydistance( anim.smartobjectpoints, desiredpos );
    numsmartobjects = allsmartobjects.size;
    
    for ( iobj = 0; iobj < numsmartobjects ; iobj++ )
    {
        object = allsmartobjects[ iobj ];
        
        if ( distancesquared( object.origin, desiredpos ) > var_b28bb506e83973be )
        {
            break;
        }
        
        if ( !canclaimsmartobject( object ) )
        {
            continue;
        }
        
        if ( !canusesmartobject( object ) )
        {
            continue;
        }
        
        if ( !issmartobjectwithinrange( object, desiredpos, volume ) )
        {
            continue;
        }
        
        objbp = getsmartobjecttype( object.script_smartobject );
        
        if ( [[ objbp.fnusecondition ]]( object ) )
        {
            return object;
        }
    }
    
    return undefined;
}

// Namespace utility / scripts\smartobjects\utility
// Params 1
// Checksum 0x0, Offset: 0x790
// Size: 0x103, Type: bool
function isplayernearsmartobject( obj )
{
    radiussq = 1600;
    zdiffsq = 4096;
    
    foreach ( player in level.players )
    {
        if ( distance2dsquared( obj.origin, player.origin ) < radiussq && squared( obj.origin[ 2 ] - player.origin[ 2 ] ) < zdiffsq )
        {
            objtoplayeryaw = vectortoyaw( player.origin - obj.origin );
            
            if ( abs( angleclamp180( objtoplayeryaw - obj.angles[ 1 ] ) ) < 90 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace utility / scripts\smartobjects\utility
// Params 7
// Checksum 0x0, Offset: 0x89c
// Size: 0x9cb
function getbestsmartobjectalongline( startpos, endpos, region, volume, var_a0c8823e405a381f, var_7975c128a04cff8c, var_188936ff4f82c5c )
{
    if ( !isdefined( anim.smartobjectpoints ) )
    {
        return;
    }
    
    var_1d73dedf4c253ef9 = 60;
    clineheight = 60;
    var_8b8967d098e7c16e = 5184;
    var_79fa165ae4fcd077 = 48;
    
    if ( isdefined( region.volume.script_radius ) )
    {
        var_79fa165ae4fcd077 = region.volume.script_radius;
    }
    
    var_db6950e933ba5ea4 = 128;
    
    if ( isdefined( region.volume.script_maxdist ) )
    {
        var_db6950e933ba5ea4 = region.volume.script_maxdist;
    }
    
    starttoend = endpos - startpos;
    linelen = length( starttoend );
    starttoenddir = starttoend / linelen;
    starttoendnormal = vectornormalize( ( starttoenddir[ 1 ], -1 * starttoenddir[ 0 ], 0 ) );
    bdrawdebug = 0;
    drawtime = undefined;
    
    /#
        drawtime = 40;
        bdrawdebug = getdvarint( @"hash_e24fb561372dfef1", -1 ) == self getentitynumber();
        
        if ( bdrawdebug )
        {
            line( startpos + ( 0, 0, 6 ), endpos + ( 0, 0, 6 ), ( 0, 0.5, 0.7 ), 1, 0, drawtime );
        }
    #/
    
    var_42737f8f4a46a4b4 = 60;
    var_56aad2fdc4c529d9 = 5;
    var_ff6725f929e35fcd = 0.33;
    var_259bd6e47136a920 = 1.5;
    var_321115db75019eda = 300000;
    var_c92fd93ef32888fd = 0.001;
    bestobj = undefined;
    bestobjscore = -9999;
    
    foreach ( obj in region.smart_objects )
    {
        if ( distancesquared( obj.origin, self.origin ) < var_8b8967d098e7c16e )
        {
            /#
                if ( bdrawdebug )
                {
                    orientedbox( obj.origin + ( 0, 0, 32 ), ( 12, 12, 12 ), obj.angles, ( 0.9, 0.4, 0 ), 0, drawtime );
                    print3d( obj.origin + ( 0, 0, 24 ), "<dev string:xb0>", ( 0.5, 0.5, 0.5 ), 1, 0.2, drawtime );
                }
            #/
            
            continue;
        }
        
        if ( !canclaimsmartobject( obj ) )
        {
            /#
                if ( bdrawdebug )
                {
                    orientedbox( obj.origin + ( 0, 0, 32 ), ( 12, 12, 12 ), obj.angles, ( 0.9, 0.4, 0 ), 0, drawtime );
                    print3d( obj.origin + ( 0, 0, 24 ), "<dev string:xb7>", ( 0.5, 0.5, 0.5 ), 1, 0.2, drawtime );
                }
            #/
            
            continue;
        }
        
        if ( !istrue( var_188936ff4f82c5c ) && !canusesmartobject( obj ) )
        {
            /#
                if ( bdrawdebug )
                {
                    orientedbox( obj.origin + ( 0, 0, 32 ), ( 12, 12, 12 ), obj.angles, ( 0.9, 0.4, 0 ), 0, drawtime );
                    print3d( obj.origin + ( 0, 0, 24 ), "<dev string:xbe>", ( 0.5, 0.5, 0.5 ), 1, 0.2, drawtime );
                }
            #/
            
            continue;
        }
        
        var_9515fec383bd148b = obj.origin - startpos;
        distdownline = vectordot( starttoenddir, var_9515fec383bd148b );
        
        if ( distdownline < var_a0c8823e405a381f )
        {
            /#
                if ( bdrawdebug )
                {
                    orientedbox( obj.origin + ( 0, 0, 32 ), ( 12, 12, 12 ), obj.angles, ( 0.9, 0.4, 0 ), 0, drawtime );
                    print3d( obj.origin + ( 0, 0, 24 ), "<dev string:xc6>", ( 0.5, 0.5, 0.5 ), 1, 0.2, drawtime );
                }
            #/
            
            continue;
        }
        
        if ( distdownline > linelen + var_1d73dedf4c253ef9 )
        {
            /#
                if ( bdrawdebug )
                {
                    orientedbox( obj.origin + ( 0, 0, 32 ), ( 12, 12, 12 ), obj.angles, ( 0.9, 0.4, 0 ), 0, drawtime );
                    print3d( obj.origin + ( 0, 0, 24 ), "<dev string:xcd>", ( 0.5, 0.5, 0.5 ), 1, 0.2, drawtime );
                }
            #/
            
            continue;
        }
        
        distfromline = abs( vectordot( starttoendnormal, var_9515fec383bd148b ) );
        objradiussq = getsmartobjectradiussq( obj );
        
        if ( distfromline * distfromline > objradiussq )
        {
            /#
                if ( bdrawdebug )
                {
                    orientedbox( obj.origin + ( 0, 0, 32 ), ( 12, 12, 12 ), obj.angles, ( 0.9, 0.4, 0 ), 0, drawtime );
                    print3d( obj.origin + ( 0, 0, 24 ), "<dev string:xd4>", ( 0.5, 0.5, 0.5 ), 1, 0.2, drawtime );
                }
            #/
            
            continue;
        }
        
        var_6f4072292388afb1 = var_db6950e933ba5ea4;
        
        if ( linelen - distfromline < 60 )
        {
            var_6f4072292388afb1 *= 0.5;
        }
        
        if ( distfromline > var_6f4072292388afb1 )
        {
            /#
                if ( bdrawdebug )
                {
                    orientedbox( obj.origin + ( 0, 0, 32 ), ( 12, 12, 12 ), obj.angles, ( 0.9, 0.4, 0 ), 0, drawtime );
                    print3d( obj.origin + ( 0, 0, 24 ), "<dev string:xd9>", ( 0.5, 0.5, 0.5 ), 1, 0.2, drawtime );
                }
            #/
            
            continue;
        }
        
        if ( isdefined( volume ) && !ispointinvolume( obj.origin, volume ) )
        {
            /#
                if ( bdrawdebug )
                {
                    orientedbox( obj.origin + ( 0, 0, 32 ), ( 12, 12, 12 ), obj.angles, ( 0.9, 0.4, 0 ), 0, drawtime );
                    print3d( obj.origin + ( 0, 0, 24 ), "<dev string:xe0>", ( 0.5, 0.5, 0.5 ), 1, 0.2, drawtime );
                }
            #/
            
            continue;
        }
        
        objbp = getsmartobjecttype( obj.script_smartobject );
        adjustedlinelen = linelen - var_a0c8823e405a381f;
        var_18c156b57d0acfed = distdownline - var_a0c8823e405a381f;
        var_3544e1d5d0bf7496 = var_7975c128a04cff8c - var_a0c8823e405a381f;
        
        if ( var_18c156b57d0acfed < var_3544e1d5d0bf7496 )
        {
            score = var_56aad2fdc4c529d9 + var_42737f8f4a46a4b4 * ( 1 - ( var_3544e1d5d0bf7496 - var_18c156b57d0acfed ) / var_3544e1d5d0bf7496 );
        }
        else
        {
            adjustedlinelen = linelen - var_7975c128a04cff8c + var_1d73dedf4c253ef9;
            var_18c156b57d0acfed = distdownline - var_7975c128a04cff8c;
            score = var_56aad2fdc4c529d9 + var_42737f8f4a46a4b4 * ( adjustedlinelen - var_18c156b57d0acfed ) / adjustedlinelen;
        }
        
        if ( distfromline > var_79fa165ae4fcd077 )
        {
            distfrompreferred = distfromline - var_79fa165ae4fcd077;
            score *= var_ff6725f929e35fcd + ( 1 - distfrompreferred / ( var_6f4072292388afb1 - var_79fa165ae4fcd077 ) ) * ( 1 - var_ff6725f929e35fcd );
        }
        
        if ( isplayernearsmartobject( obj ) )
        {
            score *= var_259bd6e47136a920;
            
            /#
                if ( bdrawdebug )
                {
                    print3d( obj.origin + ( 0, 0, 20 ), "<dev string:xe8>", ( 0.5, 0.5, 0.5 ), 1, 0.2, drawtime );
                }
            #/
        }
        
        objinfo = obj [[ objbp.fngetinfo ]]();
        
        if ( isdefined( objinfo.fngetprioritymultiplier ) )
        {
            score *= self [[ objinfo.fngetprioritymultiplier ]]( obj );
        }
        
        if ( isdefined( obj.lastusetime ) )
        {
            if ( gettime() - obj.lastusetime < var_321115db75019eda )
            {
                score *= var_c92fd93ef32888fd;
            }
            else
            {
                obj.lastusetime = undefined;
            }
        }
        
        if ( score > bestobjscore )
        {
            bestobjscore = score;
            bestobj = obj;
        }
        
        /#
            if ( bdrawdebug )
            {
                orientedbox( obj.origin + ( 0, 0, 32 ), ( 12, 12, 12 ), obj.angles, ( 0.8, 0.8, 0 ), 0, drawtime );
                print3d( obj.origin + ( 0, 0, 24 ), "<dev string:xed>" + score, ( 0.5, 0.5, 0.5 ), 1, 0.2, drawtime );
            }
        #/
    }
    
    return bestobj;
}

// Namespace utility / scripts\smartobjects\utility
// Params 1
// Checksum 0x0, Offset: 0x1270
// Size: 0xb1
function getsmartobjectradiussq( obj )
{
    if ( isdefined( obj.radius ) )
    {
        return ( obj.radius * obj.radius );
    }
    
    objtype = anim.smartobjects[ obj.script_smartobject ];
    objinfo = [[ objtype.fngetinfo ]]();
    
    if ( isdefined( objinfo.radius ) )
    {
        return ( objinfo.radius * objinfo.radius );
    }
    
    assert( isdefined( objinfo.radiussqrd ) );
    return objinfo.radiussqrd;
}

// Namespace utility / scripts\smartobjects\utility
// Params 3
// Checksum 0x0, Offset: 0x132a
// Size: 0xe5, Type: bool
function issmartobjectwithinrange( object, optorigin, volume )
{
    if ( isdefined( optorigin ) )
    {
        pos = optorigin;
    }
    else
    {
        pos = self.origin;
    }
    
    distsqrd = distancesquared( pos, object.origin );
    
    if ( isdefined( object.radius ) )
    {
        if ( distsqrd > squared( object.radius ) )
        {
            return false;
        }
    }
    else
    {
        type = anim.smartobjects[ object.script_smartobject ];
        info = [[ type.fngetinfo ]]();
        
        if ( distsqrd > info.radiussqrd )
        {
            return false;
        }
    }
    
    if ( isdefined( volume ) && !ispointinvolume( object.origin, volume ) )
    {
        return false;
    }
    
    return true;
}

// Namespace utility / scripts\smartobjects\utility
// Params 1
// Checksum 0x0, Offset: 0x1418
// Size: 0x90
function setcustomsmartobjectarrivaldata( obj )
{
    objbp = getsmartobjecttype( obj.script_smartobject );
    info = [[ objbp.fngetinfo ]]();
    
    if ( !istrue( info.hasarrivals ) )
    {
        return;
    }
    
    self.customarrivalangles = obj.angles;
    self.customarrivalstate = info.animstatename;
    self.var_171120e99df3e286 = 1;
    self.customarrivaloptionalprefix = "arrival";
}

// Namespace utility / scripts\smartobjects\utility
// Params 1
// Checksum 0x0, Offset: 0x14b0
// Size: 0x3a
function setsmartobject( smartobj )
{
    prevsmartobj = scripts\asm\asm_bb::bb_getrequestedsmartobject();
    
    if ( isdefined( prevsmartobj ) )
    {
        clearsmartobject( prevsmartobj );
    }
    
    claimsmartobject( smartobj );
    scripts\asm\asm_bb::bb_requestsmartobject( smartobj );
}

// Namespace utility / scripts\smartobjects\utility
// Params 1
// Checksum 0x0, Offset: 0x14f2
// Size: 0x1f
function clearsmartobject( smartobj )
{
    if ( isdefined( smartobj ) )
    {
        unclaimsmartobject( smartobj );
    }
    
    scripts\asm\asm_bb::bb_clearsmartobject();
}

// Namespace utility / scripts\smartobjects\utility
// Params 1
// Checksum 0x0, Offset: 0x1519
// Size: 0x4b, Type: bool
function canusesmartobject_stealth( smartobj )
{
    if ( !isdefined( self.script_stealthgroup ) )
    {
        return false;
    }
    
    if ( ![[ self.fnisinstealthinvestigate ]]() && ![[ self.fnisinstealthhunt ]]() )
    {
        return false;
    }
    
    if ( isdefined( self.enemy ) )
    {
        return false;
    }
    
    return true;
}

// Namespace utility / scripts\smartobjects\utility
// Params 1
// Checksum 0x0, Offset: 0x156d
// Size: 0xb8, Type: bool
function canusesmartobject_nostrafenoturn( smartobj )
{
    forward = anglestoforward( self.angles );
    normal = vectornormalize( smartobj.origin - self.origin );
    
    if ( vectordot( forward, normal ) >= cos( 60 ) )
    {
        strafedist = 64;
    }
    else
    {
        strafedist = 100;
    }
    
    if ( distancesquared( self.origin, smartobj.origin ) <= strafedist * strafedist )
    {
        return false;
    }
    
    forward = anglestoforward( smartobj.angles );
    
    if ( vectordot( forward, normal ) < cos( 45 ) )
    {
        return false;
    }
    
    return true;
}

