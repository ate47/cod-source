#using scripts\anim\face;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\asm_sp;

#namespace scripted;

// Namespace scripted / scripts\anim\scripted
// Params 0
// Checksum 0x0, Offset: 0x210
// Size: 0x2d1
function main()
{
    self endon( "death" );
    self notify( "killanimscript" );
    self notify( "clearSuppressionAttack" );
    asm_clearfacialanim();
    scripts\asm\asm_bb::bb_clearanimscripted();
    asm_animscripted();
    applyheadlook = 1;
    
    if ( istrue( self.var_61eb9d2bd6f5f40a ) )
    {
        applyheadlook = 0;
    }
    
    if ( applyheadlook && ( isdefined( self.animsetname ) || isdefined( self.animationarchetype ) ) )
    {
        if ( isdefined( self.codescripted[ "pitch_min" ] ) )
        {
            headlook_graft_node = asm_getheadlookknobifexists();
            
            if ( isdefined( headlook_graft_node ) )
            {
                self.lookatatrnode = self.codescripted[ "lookat_atr_node" ];
                self setanimlookatranges( self.codescripted[ "pitch_min" ], self.codescripted[ "pitch_max" ], self.codescripted[ "yaw_min" ], self.codescripted[ "yaw_max" ] );
                self setanim( headlook_graft_node, 1, 0.2, 1, self.lookatatrnode );
            }
        }
    }
    
    self endon( "end_sequence" );
    parentent = self.codescripted[ "parent" ];
    
    if ( isdefined( parentent ) )
    {
        assertex( parentent == self getlinkedparent(), "really, this linkto changed already? -_-" );
        self.codescripted[ "origin" ] = parentent.origin + rotatevector( self.codescripted[ "origin" ], parentent.angles );
        self.codescripted[ "angles" ] = combineangles( parentent.angles, self.codescripted[ "angles" ] );
    }
    
    if ( isdefined( self.scriptedthread ) )
    {
        self thread [[ self.scriptedthread ]]();
    }
    
    self startscriptedanim( self.codescripted[ "notifyName" ], self.codescripted[ "origin" ], self.codescripted[ "angles" ], self.codescripted[ "anim" ], self.codescripted[ "animMode" ], self.codescripted[ "root" ], self.codescripted[ "goalTime" ], self.codescripted[ "animRate" ], undefined, undefined, undefined, undefined, undefined, self.codescripted[ "scripted_node_ent" ] );
    self notify( "scripted_anim", self.codescripted );
    self.codescripted = undefined;
    
    if ( isdefined( self.scripted_dialogue ) )
    {
        scripts\anim\face::sayspecificdialogue( self.scripted_dialogue, "scripted_anim_facedone" );
        self.scripted_dialogue = undefined;
    }
    
    if ( isdefined( self.deathstring_passed ) )
    {
        self.deathstring = self.deathstring_passed;
    }
    
    self waittill( "killanimscript" );
}

// Namespace scripted / scripts\anim\scripted
// Params 14
// Checksum 0x0, Offset: 0x4e9
// Size: 0x269
function init( notifyname, origin, angles, theanim, anim_mode, root, goaltime, animrate, pitch_min, pitch_max, yaw_min, yaw_max, lookat_atr_node, scripted_node_ent )
{
    self.codescripted = undefined;
    self.codescripted[ "notifyName" ] = notifyname;
    self.codescripted[ "origin" ] = origin;
    self.codescripted[ "angles" ] = angles;
    self.codescripted[ "anim" ] = theanim;
    
    if ( isdefined( anim_mode ) )
    {
        self.codescripted[ "animMode" ] = anim_mode;
    }
    else
    {
        self.codescripted[ "animMode" ] = "normal";
    }
    
    self.codescripted[ "goalTime" ] = goaltime;
    self.codescripted[ "animRate" ] = animrate;
    self.codescripted[ "root" ] = root;
    self.codescripted[ "pitch_min" ] = pitch_min;
    self.codescripted[ "pitch_max" ] = pitch_max;
    self.codescripted[ "yaw_min" ] = yaw_min;
    self.codescripted[ "yaw_max" ] = yaw_max;
    self.codescripted[ "lookat_atr_node" ] = lookat_atr_node;
    self.codescripted[ "scripted_node_ent" ] = scripted_node_ent;
    parentent = self getlinkedparent();
    
    if ( isdefined( parentent ) )
    {
        self.codescripted[ "parent" ] = parentent;
        self.codescripted[ "origin" ] = rotatevectorinverted( origin - parentent.origin, parentent.angles );
        self.codescripted[ "angles" ] = combineangles( invertangles( parentent.angles ), angles );
    }
    
    switch ( self.unittype )
    {
        case #"hash_f4a90c6c03d32ee9":
            init_dog();
            break;
        default:
            init_human();
            break;
    }
    
    assertex( isdefined( self.codescripted[ "root" ] ), "this value should be inited in one of the subclass init functions if not otherwise set." );
}

#using_animtree( "generic_human" );

// Namespace scripted / scripts\anim\scripted
// Params 0
// Checksum 0x0, Offset: 0x75a
// Size: 0x2e
function init_human()
{
    if ( !isdefined( self.codescripted[ "root" ] ) )
    {
        self.codescripted[ "root" ] = %body;
    }
}

#using_animtree( "dog" );

// Namespace scripted / scripts\anim\scripted
// Params 0
// Checksum 0x0, Offset: 0x790
// Size: 0x2e
function init_dog()
{
    if ( !isdefined( self.codescripted[ "root" ] ) )
    {
        self.codescripted[ "root" ] = %body;
    }
}

