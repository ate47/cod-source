#using scripts\common\whizby;
#using scripts\engine\utility;

#namespace bullet_feedback;

// Namespace bullet_feedback / scripts\sp\player\bullet_feedback
// Params 0
// Checksum 0x0, Offset: 0x9d
// Size: 0x3f
function bullet_feedback_init()
{
    scripts\common\whizby::init();
    level.player ent_flag_init( "pause_suppression" );
    level.player thread bulletwhizby_monitor();
    level.player scripts\common\whizby::initplayer();
}

// Namespace bullet_feedback / scripts\sp\player\bullet_feedback
// Params 0
// Checksum 0x0, Offset: 0xe4
// Size: 0x5c
function bulletwhizby_monitor()
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "bulletwhizby", attacker, distance, position, forward );
        
        if ( !shoulddobulletwhizby() )
        {
            continue;
        }
        
        scripts\common\whizby::whizbyeffect( attacker, distance, position, forward );
    }
}

// Namespace bullet_feedback / scripts\sp\player\bullet_feedback
// Params 0
// Checksum 0x0, Offset: 0x148
// Size: 0x14, Type: bool
function shoulddobulletwhizby()
{
    if ( ent_flag( "pause_suppression" ) )
    {
        return false;
    }
    
    return true;
}

