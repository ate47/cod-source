#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\soldier\death;
#using scripts\asm\soldier\patrol;
#using scripts\common\anim;
#using scripts\common\string;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace patrol_idle;

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 0
// Checksum 0x0, Offset: 0x31f
// Size: 0x46
function patrol_idle_getcellphone()
{
    modelname = "offhand_wm_smartphone_on";
    
    if ( isdefined( level.scr_model ) && isdefined( level.scr_model[ "idle_cellphone" ] ) )
    {
        modelname = level.scr_model[ "idle_cellphone" ];
    }
    
    return modelname;
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x36e
// Size: 0x2d
function patrol_idle_init( asmname, statename, params )
{
    self.newenemyreactiondistsq = 0;
    thread patrol_prop_waitfordelete();
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x3a3
// Size: 0x5e
function patrol_idle_cleanup( asmname, statename, params )
{
    self.newenemyreactiondistsq = 262144;
    self function_f7cff9f6dafb297();
    
    if ( isdefined( self.idle_prop ) )
    {
        self.idle_prop delete();
        self.idle_prop = undefined;
    }
    
    self notify( "patrol_idle_complete" );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 4
// Checksum 0x0, Offset: 0x409
// Size: 0x7c, Type: bool
function patrol_idle_istype( asmname, statename, tostatename, params )
{
    assert( isdefined( params ) );
    assert( self._blackboard.idlenodeisvalid );
    assert( isdefined( self._blackboard.var_fe458d6a41146a8c ) );
    return self._blackboard.var_fe458d6a41146a8c == params;
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 2
// Checksum 0x0, Offset: 0x48e
// Size: 0x3f
function patrol_getcustomfunc( scenename, funcname )
{
    if ( isdefined( level.idle_funcs ) && isdefined( level.idle_funcs[ scenename ] ) )
    {
        return level.idle_funcs[ scenename ][ funcname ];
    }
    
    return undefined;
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x4d6
// Size: 0x6d
function patrol_idle_getnotehandler( asmname, statename, params )
{
    if ( isdefined( self._blackboard.customidlenode ) )
    {
        notehandler = patrol_getcustomfunc( self._blackboard.customidlenode, params + "_note" );
        
        if ( isdefined( notehandler ) )
        {
            return notehandler;
        }
    }
    
    return asm_getnotehandler( asmname, statename );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 5
// Checksum 0x0, Offset: 0x54c
// Size: 0xd2
function patrol_playanim( asmname, statename, params, notehandler, animrate )
{
    self endon( statename + "_finished" );
    patrolanim = asm_getanim( asmname, statename );
    patrolxanim = asm_getxanim( statename, patrolanim );
    
    if ( isnumber( patrolanim ) )
    {
        self aisetanim( statename, patrolanim, animrate );
    }
    else
    {
        assertex( utility::issp(), "<dev string:x1c>" );
        blankindex = asm_lookupanimfromalias( statename, "blank" );
        self aisetanim( statename, blankindex, animrate );
        self setflaggedanimrestart( statename, patrolanim, 1, animrate );
    }
    
    asm_playfacialanim( asmname, statename, patrolxanim );
    asm_donotetracks( asmname, statename, notehandler, statename );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x626
// Size: 0xbc
function patrol_playidleintro( asmname, statename, params )
{
    self animmode( "zonly_physics", 0 );
    desiredangle = self.angles[ 1 ];
    
    if ( self._blackboard.idlenodeisvalid )
    {
        if ( isdefined( self._blackboard.idlenodeangles ) )
        {
            desiredangle = self._blackboard.idlenodeangles[ 1 ];
        }
        else
        {
            desiredangle = 0;
        }
    }
    
    self orientmode( "face angle", desiredangle );
    notehandler = patrol_idle_getnotehandler( asmname, statename, "intro" );
    patrol_playanim( asmname, statename, params, notehandler, 1 );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x6ea
// Size: 0x105
function patrol_playidleloop( asmname, statename, params )
{
    self endon( statename + "_finished" );
    bodyknob = asm_getbodyknob();
    prevanim = bodyknob;
    notehandler = patrol_idle_getnotehandler( asmname, statename, "loop" );
    
    while ( true )
    {
        loopanim = asm_getanim( asmname, statename );
        
        if ( isnumber( loopanim ) )
        {
            self aisetanim( statename, loopanim );
        }
        else
        {
            assertex( utility::issp(), "<dev string:x4a>" );
            blankindex = asm_lookupanimfromalias( statename, "blank" );
            self aisetanim( statename, blankindex );
            self setflaggedanimrestart( statename, loopanim, 1, 0.2, 1 );
        }
        
        loopxanim = asm_getxanim( statename, loopanim );
        asm_playfacialanim( asmname, statename, loopxanim );
        prevanim = loopanim;
        asm_donotetracks( asmname, statename, notehandler, statename );
    }
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x7f7
// Size: 0x5d
function patrol_chooseidlereact( asmname, statename, params )
{
    reactyaw = 0;
    alias = scripts\asm\soldier\patrol::function_a23a26adcf97fdd0();
    
    if ( isint( alias ) )
    {
        alias = scripts\common\string::to_string( alias );
    }
    
    reactanim = asm_lookupanimfromalias( statename, alias );
    return reactanim;
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x85d
// Size: 0x158
function patrol_playidlereact( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self function_f7cff9f6dafb297();
    patrolanim = asm_getanim( asmname, statename );
    notehandler = patrol_idle_getnotehandler( asmname, statename, "react" );
    patrolxanim = asm_getxanim( statename, patrolanim );
    animrate = 1;
    
    if ( isdefined( self.stealthreactendtime ) )
    {
        animlength = getanimlength( patrolxanim );
        desiredlength = ( self.stealthreactendtime - gettime() ) / 2000;
        
        if ( desiredlength < animlength )
        {
            if ( desiredlength < 0.3 )
            {
                desiredlength = 0.3;
            }
            
            animrate = animlength / desiredlength;
        }
    }
    
    if ( isnumber( patrolanim ) )
    {
        self aisetanim( statename, patrolanim, animrate );
    }
    else
    {
        assertex( utility::issp(), "<dev string:x78>" );
        blankindex = asm_lookupanimfromalias( statename, "blank" );
        self aisetanim( statename, blankindex, animrate );
        self setflaggedanimrestart( statename, patrolanim, 1, 0.2, animrate );
    }
    
    asm_playfacialanim( asmname, statename, patrolxanim );
    self function_df303d9c05757e6b( patrolanim, statename );
    asm_donotetracks( asmname, statename, notehandler, statename );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x9bd
// Size: 0x49
function patrol_playidleend( asmname, statename, params )
{
    notehandler = patrol_idle_getnotehandler( asmname, statename, "end" );
    self notify( "smoking_end" );
    patrol_playanim( asmname, statename, params, notehandler, 1 );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 2
// Checksum 0x0, Offset: 0xa0e
// Size: 0x15b
function patrol_notehandler_smoking( note, statename )
{
    note = getsubstr( note, 10 );
    
    if ( isstartstr( note, "attach" ) )
    {
        self.idle_fx = level.g_effect[ "cigarette_unlit" ];
        playfxontag( self.idle_fx, self, "tag_accessory_right" );
        return;
    }
    
    if ( isstartstr( note, "light" ) )
    {
        self.idle_fx = level.g_effect[ "cigarette_lit" ];
        playfxontag( self.idle_fx, self, "tag_accessory_right" );
        stopfxontag( level.g_effect[ "cigarette_unlit" ], self, "tag_accessory_right" );
        playfx( level.g_effect[ "lighter_glow" ], self gettagorigin( "tag_accessory_right" ) );
        thread patrol_smoking_blowsmoke( statename );
        return;
    }
    
    if ( isstartstr( note, "detach" ) )
    {
        stopfxontag( level.g_effect[ "cigarette_lit" ], self, "tag_accessory_right" );
        self.idle_fx = undefined;
        playfx( level.g_effect[ "cigarette_lit_toss" ], self gettagorigin( "tag_accessory_right" ), anglestoforward( self gettagangles( "tag_accessory_right" ) ) );
        return;
    }
    
    if ( isstartstr( note, "face_goal" ) )
    {
        scripts\asm\soldier\patrol::handlefacegoalnotetrack( statename, note, undefined );
    }
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 1
// Checksum 0x0, Offset: 0xb71
// Size: 0x81
function patrol_smoking_blowsmoke( statename )
{
    self endon( "smoking_end" );
    self endon( "death" );
    
    while ( true )
    {
        self.smoke_fx_ent = playfxontag( level.g_effect[ "cigarette_smoke" ], self, "tag_eye" );
        waittime = randomintrange( 5, 8 );
        wait waittime;
        
        if ( isdefined( self.smoke_fx_ent ) )
        {
            self.smoke_fx_ent delete();
            self.smoke_fx_ent = undefined;
        }
    }
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0xbfa
// Size: 0x7f
function patrol_smoking_cleanup( asmname, statename, params )
{
    self notify( "smoking_end" );
    
    if ( isdefined( self.idle_fx ) )
    {
        stopfxontag( self.idle_fx, self, "tag_accessory_right" );
        self.idle_fx = undefined;
    }
    
    if ( isdefined( self.smoke_fx_ent ) )
    {
        self.smoke_fx_ent delete();
        self.smoke_fx_ent = undefined;
    }
    
    patrol_idle_cleanup( asmname, statename, params );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 2
// Checksum 0x0, Offset: 0xc81
// Size: 0xcf
function patrol_notehandler_cellphone( note, statename )
{
    self endon( statename + "_finished" );
    
    switch ( note )
    {
        case #"hash_2d1403e602f082a4":
            self.idle_prop = scripts\common\anim::anim_link_tag_model( patrol_idle_getcellphone(), "tag_accessory_right" );
            wait 2;
            
            if ( isdefined( self.idle_prop ) )
            {
                playfxontag( level.g_effect[ "cellphone_glow" ], self.idle_prop, "tag_origin" );
            }
            
            break;
        case #"hash_682ec8b49fe7aa12":
            if ( isdefined( self.idle_prop ) )
            {
                self.idle_prop delete();
                self.idle_prop = undefined;
            }
            
            break;
        case #"hash_2c250facc201a952":
            scripts\asm\soldier\patrol::handlefacegoalnotetrack( statename, note, undefined );
            break;
    }
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0xd58
// Size: 0x110
function patrol_prop_cleanup( asmname, statename, params )
{
    if ( isdefined( self.idle_prop ) )
    {
        if ( ![[ self.fnisinstealthidle ]]() || !isalive( self ) )
        {
            launchforce = anglestoforward( self.angles );
            launchforce *= randomfloatrange( 30, 45 );
            forcex = launchforce[ 0 ];
            forcey = launchforce[ 1 ];
            forcez = randomfloatrange( 80, 90 );
            self.idle_prop unlink();
            self.idle_prop physicslaunchserver( self.idle_prop.origin, ( forcex, forcey, forcez ) );
            self.idle_prop thread patrol_prop_delete();
            self.idle_prop = undefined;
            return;
        }
        
        if ( [[ self.fnstealthisidlecurious ]]() )
        {
            self.idle_prop delete();
            self.idle_prop = undefined;
        }
    }
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 0
// Checksum 0x0, Offset: 0xe70
// Size: 0x4e
function patrol_prop_delete()
{
    wait 5;
    
    while ( isalive( level.player ) && distance2dsquared( level.player.origin, self.origin ) < 160000 )
    {
        wait 1;
    }
    
    self delete();
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 2
// Checksum 0x0, Offset: 0xec6
// Size: 0x92
function patrol_notehandler_drinking( note, statename )
{
    switch ( note )
    {
        case #"hash_2d1403e602f082a4":
            self.idle_prop = scripts\common\anim::anim_link_tag_model( "p7_bottle_plastic_16oz_water", "tag_accessory_right" );
            break;
        case #"hash_682ec8b49fe7aa12":
            if ( isdefined( self.idle_prop ) )
            {
                self.idle_prop delete();
                self.idle_prop = undefined;
            }
            
            break;
        case #"hash_2c250facc201a952":
            scripts\asm\soldier\patrol::handlefacegoalnotetrack( statename, note, undefined );
            break;
    }
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0xf60
// Size: 0x1c1
function patrol_playidlesittingloop( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self animmode( "noclip" );
    groundpos = scripts\engine\utility::drop_to_ground( self._blackboard.idlenodeorigin, 8, -128 );
    
    if ( isdefined( params ) )
    {
        assert( self._blackboard.idlenodeisvalid );
        assert( isdefined( level.fnanimatedprop_setup ) );
        [[ level.fnanimatedprop_setup ]]( "idle_chair", params, groundpos, self._blackboard.idlenodeangles );
    }
    
    var_b95ecd0bf886bb98 = 1;
    bodyknob = asm_getbodyknob();
    prevanim = bodyknob;
    
    while ( true )
    {
        loopanim = asm_getanim( asmname, statename );
        loopxanim = asm_getxanim( statename, loopanim );
        self aisetanim( statename, loopanim );
        asm_playfacialanim( asmname, statename, loopxanim );
        prevanim = loopanim;
        
        if ( var_b95ecd0bf886bb98 )
        {
            assert( self._blackboard.idlenodeisvalid );
            movedelta = getmovedelta( loopxanim );
            startpos = groundpos - rotatevector( movedelta, self._blackboard.idlenodeangles );
            self startcoverarrival( startpos, self._blackboard.idlenodeangles[ 1 ] );
            thread patrol_idlesitting_checkforcoverarrivalcomplete( statename, groundpos );
            var_b95ecd0bf886bb98 = 0;
        }
        
        asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ), statename );
    }
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 2
// Checksum 0x0, Offset: 0x1129
// Size: 0x44
function patrol_idlesitting_checkforcoverarrivalcomplete( statename, endpos )
{
    self endon( statename + "_finished" );
    
    while ( true )
    {
        if ( distance2dsquared( self.origin, endpos ) < 4 )
        {
            self finishcoverarrival();
            break;
        }
        
        waitframe();
    }
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x1175
// Size: 0x22
function patrol_playidlesittingloop_cleanup( asmname, statename, params )
{
    self finishcoverarrival();
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x119f
// Size: 0x2f
function patrol_playidlesittingloop_prop_cleanup( asmname, statename, params )
{
    patrol_prop_cleanup( asmname, statename, params );
    patrol_playidlesittingloop_cleanup( asmname, statename, params );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x11d6
// Size: 0x25
function patrol_playidlesittingloop_sleeping( asmname, statename, params )
{
    patrol_playidlesittingloop( asmname, statename, params );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x1203
// Size: 0x25
function patrol_playidlesittingloop_sleeping_cleanup( asmname, statename, params )
{
    patrol_playidlesittingloop_cleanup( asmname, statename, params );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x1230
// Size: 0x62
function patrol_playidlesittingloop_cellphone( asmname, statename, params )
{
    self.idle_prop = scripts\common\anim::anim_link_tag_model( patrol_idle_getcellphone(), "tag_accessory_right" );
    playfxontag( level.g_effect[ "cellphone_glow" ], self.idle_prop, "tag_origin" );
    patrol_playidlesittingloop( asmname, statename, params );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x129a
// Size: 0x25
function patrol_playidlesittingloop_laptop( asmname, statename, params )
{
    patrol_playidlesittingloop( asmname, statename, params );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x12c7
// Size: 0x3e
function patrol_playidlesittingloop_pistolclean( asmname, statename, params )
{
    self.idle_prop = scripts\common\anim::anim_link_tag_model( "weapon_wm_pi_mike1911_phys", "tag_accessory_right" );
    patrol_playidlesittingloop( asmname, statename, params );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x130d
// Size: 0x57
function patrol_playdeathanim_sitting( asmname, statename, params )
{
    if ( isdefined( self.animated_prop ) )
    {
        assert( isdefined( level.fnanimatedprop_startanim ) );
        self [[ level.fnanimatedprop_startanim ]]( "idle_chair", params );
    }
    
    scripts\asm\soldier\death::playdeathanim( asmname, statename );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x136c
// Size: 0x48
function patrol_playidlesittingreact( asmname, statename, params )
{
    self animmode( "noclip" );
    
    if ( isdefined( params ) )
    {
        self [[ level.fnanimatedprop_setanim ]]( "idle_chair", params );
    }
    
    asm_playanimstate( asmname, statename );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 4
// Checksum 0x0, Offset: 0x13bc
// Size: 0xba, Type: bool
function patrol_hascustomanim( asmname, statename, tostatename, params )
{
    if ( isdefined( self._blackboard.customidlenode ) )
    {
        scenename = self._blackboard.customidlenode;
    }
    else
    {
        scenename = self._blackboard.var_fe458d6a41146a8c;
    }
    
    assert( isdefined( scenename ) );
    return isdefined( level.scr_anim[ "patrol_idle" ] ) && isdefined( level.scr_anim[ "patrol_idle" ][ scenename ] ) && isdefined( level.scr_anim[ "patrol_idle" ][ scenename ][ params ] );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 4
// Checksum 0x0, Offset: 0x147f
// Size: 0xdb
function patrol_iscustomanimdefaultvalue( asmname, statename, tostatename, params )
{
    if ( isdefined( self._blackboard.customidlenode ) )
    {
        scenename = self._blackboard.customidlenode;
    }
    else
    {
        scenename = self._blackboard.var_fe458d6a41146a8c;
    }
    
    assert( isdefined( scenename ) );
    assert( isdefined( level.scr_anim[ "<dev string:xaa>" ] ) && isdefined( level.scr_anim[ "<dev string:xaa>" ][ scenename ] ) && isdefined( level.scr_anim[ "<dev string:xaa>" ][ scenename ][ params ] ) );
    return isnumber( level.scr_anim[ "patrol_idle" ][ scenename ][ params ] );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x1563
// Size: 0x206
function patrol_chooseanim_custom( asmname, statename, params )
{
    assert( isdefined( self._blackboard.customidlenode ) );
    scenename = self._blackboard.customidlenode;
    state = params;
    assert( isdefined( scenename ) );
    assert( isdefined( level.scr_anim ) );
    assert( isdefined( level.scr_anim[ "<dev string:xaa>" ] ), "<dev string:xb9>" + scenename + "<dev string:xe7>" + "<dev string:xaa>" + "<dev string:xff>" );
    assert( isdefined( level.scr_anim[ "<dev string:xaa>" ][ scenename ] ), "<dev string:xb9>" + scenename + "<dev string:xe7>" + "<dev string:xaa>" + "<dev string:xff>" );
    assert( isdefined( level.scr_anim[ "<dev string:xaa>" ][ scenename ][ state ] ), "<dev string:x10c>" + state + "<dev string:xe7>" + "<dev string:xaa>" + "<dev string:x12f>" + scenename + "<dev string:xff>" );
    
    if ( isarray( level.scr_anim[ "patrol_idle" ][ scenename ][ state ] ) )
    {
        numanims = level.scr_anim[ "patrol_idle" ][ scenename ][ state ].size;
        assert( numanims > 0 );
        
        if ( numanims > 1 )
        {
            if ( isdefined( self.fnisinstealthinvestigate ) && [[ self.fnisinstealthinvestigate ]]() )
            {
                if ( isdefined( self.var_bb3bab49c9a764a4 ) )
                {
                    if ( self.var_f97ff24102472069 == "investigate" )
                    {
                        return level.scr_anim[ "patrol_idle" ][ scenename ][ state ][ 0 ];
                    }
                }
            }
            
            return level.scr_anim[ "patrol_idle" ][ scenename ][ state ][ 1 ];
        }
        else
        {
            return level.scr_anim[ "patrol_idle" ][ scenename ][ 0 ];
        }
        
        return;
    }
    
    return level.scr_anim[ "patrol_idle" ][ scenename ][ state ];
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x1771
// Size: 0x85
function patrol_idle_custom_init( asmname, statename, params )
{
    assert( self._blackboard.idlenodeisvalid );
    assert( isdefined( self._blackboard.var_fe458d6a41146a8c ) );
    self._blackboard.customidlenode = self._blackboard.var_fe458d6a41146a8c;
    patrol_idle_init( asmname, statename, params );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x17fe
// Size: 0x4d
function patrol_idle_custom_cleanup( asmname, statename, params )
{
    patrol_idle_cleanup( asmname, statename, params );
    patrol_idle_callcustomcallback( "cleanup" );
    
    if ( isalive( self ) )
    {
        self._blackboard.customidlenode = undefined;
    }
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 1
// Checksum 0x0, Offset: 0x1853
// Size: 0x87
function patrol_idle_callcustomcallback( funcname )
{
    if ( isdefined( level.idle_funcs ) )
    {
        assert( isdefined( self._blackboard.customidlenode ) );
        scenename = self._blackboard.customidlenode;
        
        if ( isdefined( level.idle_funcs[ scenename ] ) && isdefined( level.idle_funcs[ scenename ][ funcname ] ) )
        {
            self thread [[ level.idle_funcs[ scenename ][ funcname ] ]]();
        }
    }
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x18e2
// Size: 0x31
function patrol_playidleintro_custom( asmname, statename, params )
{
    patrol_idle_callcustomcallback( "intro_begin" );
    patrol_playidleintro( asmname, statename, params );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x191b
// Size: 0x31
function patrol_playidleloop_custom( asmname, statename, params )
{
    patrol_idle_callcustomcallback( "loop_begin" );
    patrol_playidleloop( asmname, statename, params );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x1954
// Size: 0x31
function patrol_playidlereact_custom( asmname, statename, params )
{
    patrol_idle_callcustomcallback( "react_begin" );
    patrol_playidlereact( asmname, statename, params );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x198d
// Size: 0x31
function patrol_playidleend_custom( asmname, statename, params )
{
    patrol_idle_callcustomcallback( "exit_begin" );
    patrol_playidleend( asmname, statename, params );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 3
// Checksum 0x0, Offset: 0x19c6
// Size: 0x51
function patrol_playidle_custom_terminate( asmname, statename, params )
{
    assert( isdefined( self._blackboard.customidlenode ) );
    assert( isdefined( params ) );
    patrol_idle_callcustomcallback( params + "_end" );
}

// Namespace patrol_idle / scripts\asm\soldier\patrol_idle
// Params 0
// Checksum 0x0, Offset: 0x1a1f
// Size: 0x2d
function patrol_prop_waitfordelete()
{
    self endon( "patrol_idle_complete" );
    self waittill( "entitydeleted" );
    
    if ( isdefined( self.idle_prop ) )
    {
        self.idle_prop delete();
    }
}

