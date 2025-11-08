#using scripts\asm\asm;
#using scripts\engine\utility;

#namespace first_frame;

// Namespace first_frame / scripts\anim\first_frame
// Params 0
// Checksum 0x0, Offset: 0xbe
// Size: 0xa6
function main()
{
    self endon( "death" );
    self endon( "stop_first_frame" );
    self notify( "killanimscript" );
    self.pushable = 0;
    self leaveinteraction();
    self clearanim( scripts\asm\asm::asm_getbodyknob(), 0.3 );
    
    if ( scripts\engine\utility::actor_is3d() )
    {
        self orientmode( "face angle 3d", self.angles );
    }
    else
    {
        self orientmode( "face angle", self.angles[ 1 ] );
    }
    
    self animmode( "noclip" );
    self setanim( self._first_frame_anim, 1, 0, 0 );
    self._first_frame_anim = undefined;
    self waittill( "killanimscript" );
}

