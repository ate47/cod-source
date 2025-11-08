#using scripts\asm\asm;
#using scripts\asm\soldier\death;
#using scripts\asm\soldier\pain;
#using scripts\common\ai;
#using scripts\engine\utility;

#namespace ground_turret;

// Namespace ground_turret / scripts\asm\soldier\ground_turret
// Params 4
// Checksum 0x0, Offset: 0xe1
// Size: 0x56, Type: bool
function aigroundturret_shouldcompletedismount( asmname, statename, tostatename, params )
{
    turret = self._blackboard.aigroundturretref;
    assert( isdefined( turret ) );
    turret cleartargetentity();
    return true;
}

// Namespace ground_turret / scripts\asm\soldier\ground_turret
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x140
// Size: 0x58
function private disablegroundturret()
{
    turret = self._blackboard.aigroundturretref;
    assert( isdefined( turret ) );
    turret.inuse = 0;
    turret setturretteam( "neutral" );
    turret setmode( "manual" );
    self stopuseturret();
}

// Namespace ground_turret / scripts\asm\soldier\ground_turret
// Params 3
// Checksum 0x0, Offset: 0x1a0
// Size: 0x56
function playanim_mountturret( asmname, statename, params )
{
    turret = self._blackboard.aigroundturretref;
    assert( isdefined( turret ) );
    aigroundturret_mountcompleted();
    asm_playanimstate( asmname, statename, params );
}

// Namespace ground_turret / scripts\asm\soldier\ground_turret
// Params 3
// Checksum 0x0, Offset: 0x1fe
// Size: 0xf6
function playanim_aioperateturret( asmname, statename, params )
{
    turret = self._blackboard.aigroundturretref;
    assert( isdefined( turret ) );
    origin = turret gettagorigin( "tag_gunner" );
    angles = turret gettagangles( "tag_gunner" );
    
    if ( self islinked() )
    {
        self unlink();
    }
    
    turret.inuse = 1;
    turret setturretteam( self.team );
    
    if ( isdefined( turret.usemode ) )
    {
        turret setmode( turret.usemode );
    }
    else
    {
        turret setmode( "auto_nonai" );
    }
    
    self forceteleport( origin, angles );
    self linktoblendtotag( turret, "tag_gunner", 0 );
    self useturret( turret );
    asm_playanimstate( asmname, statename, params );
}

// Namespace ground_turret / scripts\asm\soldier\ground_turret
// Params 3
// Checksum 0x0, Offset: 0x2fc
// Size: 0x2c
function playanim_aibegindismountturret( asmname, statename, params )
{
    disablegroundturret();
    asm_playanimstate( asmname, statename, params );
}

// Namespace ground_turret / scripts\asm\soldier\ground_turret
// Params 3
// Checksum 0x0, Offset: 0x330
// Size: 0x3c
function playanim_aidismountturret( asmname, statename, params )
{
    if ( self islinked() )
    {
        self unlink();
    }
    
    aigroundturret_dismountcompleted();
    asm_playanimstate( asmname, statename, params );
}

// Namespace ground_turret / scripts\asm\soldier\ground_turret
// Params 3
// Checksum 0x0, Offset: 0x374
// Size: 0x6e
function playdeathanim_groundturret( asmname, statename, params )
{
    turret = self._blackboard.aigroundturretref;
    
    if ( isdefined( turret ) )
    {
        turret.inuse = 0;
        turret setturretteam( "neutral" );
        turret setmode( "manual" );
    }
    
    playdeathanim( asmname, statename, params );
}

// Namespace ground_turret / scripts\asm\soldier\ground_turret
// Params 3
// Checksum 0x0, Offset: 0x3ea
// Size: 0x2c
function playpainanim_groundturret( asmname, statename, params )
{
    disablegroundturret();
    scripts\asm\soldier\pain::playpainanim( asmname, statename, params );
}

