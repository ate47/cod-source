#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace interactable;

// Namespace interactable / scripts\asm\soldier\interactable
// Params 0
// Checksum 0x0, Offset: 0x10d
// Size: 0x13
function onlevelload()
{
    registerinteractable( "example", &run_example_interactable );
}

// Namespace interactable / scripts\asm\soldier\interactable
// Params 3
// Checksum 0x0, Offset: 0x128
// Size: 0x75
function run_example_interactable( asmname, statename, animationdata )
{
    iprintlnbold( "Example Interactable is Running." );
    covernode = scripts\asm\asm_bb::bb_getcovernode();
    assert( covernode );
    self aiclearanim( asm_getbodyknob(), 0.2 );
    self setflaggedanimknobrestart( statename, animationdata, 1, 0.2, 1 );
    asm_donotetracks( asmname, statename );
}

// Namespace interactable / scripts\asm\soldier\interactable
// Params 2
// Checksum 0x0, Offset: 0x1a5
// Size: 0x37
function registerinteractable( interactable, func )
{
    if ( !isdefined( level.interactables ) )
    {
        level.interactables = [];
    }
    
    level.interactables[ interactable ] = func;
}

// Namespace interactable / scripts\asm\soldier\interactable
// Params 0
// Checksum 0x0, Offset: 0x1e4
// Size: 0x29
function disableinteractable()
{
    assert( isnode( self ) );
    
    if ( isdefined( self.interaction ) )
    {
        self.disableinteraction = 1;
    }
}

// Namespace interactable / scripts\asm\soldier\interactable
// Params 4
// Checksum 0x0, Offset: 0x215
// Size: 0x5e, Type: bool
function shouldplayinteractable( asmname, statename, tostatename, params )
{
    covernode = scripts\asm\asm_bb::bb_getcovernode();
    
    if ( isdefined( covernode ) && isdefined( covernode.interactable ) && !isdefined( covernode.disableinteraction ) )
    {
        return true;
    }
    
    return false;
}

// Namespace interactable / scripts\asm\soldier\interactable
// Params 4
// Checksum 0x0, Offset: 0x27c
// Size: 0x2f
function interactablefinished( asmname, statename, tostatename, params )
{
    return asm_eventfired( asmname, "interactable_finished" );
}

// Namespace interactable / scripts\asm\soldier\interactable
// Params 3
// Checksum 0x0, Offset: 0x2b4
// Size: 0x5f
function chooseaniminteractable( asmname, statename, params )
{
    covernode = scripts\asm\asm_bb::bb_getcovernode();
    assert( isdefined( covernode ) );
    assert( isdefined( covernode.interactable ) );
    return asm_lookupanimfromalias( statename, covernode.interactable );
}

// Namespace interactable / scripts\asm\soldier\interactable
// Params 3
// Checksum 0x0, Offset: 0x31c
// Size: 0xd4
function playinteractable( asmname, statename, params )
{
    self endon( statename + "_finished" );
    animations = asm_getanim( asmname, statename );
    covernode = scripts\asm\asm_bb::bb_getcovernode();
    assert( isdefined( covernode ) );
    assert( isdefined( covernode.interactable ) );
    assertex( isdefined( level.interactables[ covernode.interactable ] ), "<dev string:x1c>" + covernode.interactable + "<dev string:x2d>" );
    covernode.disableinteraction = 1;
    [[ level.interactables[ covernode.interactable ] ]]( asmname, statename, animations );
    asm_fireevent( asmname, "interactable_finished" );
}

// Namespace interactable / scripts\asm\soldier\interactable
// Params 3
// Checksum 0x0, Offset: 0x3f8
// Size: 0x1b
function interactableterminate( asmname, statename, params )
{
    
}

