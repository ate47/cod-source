#using scripts\anim\notetracks;
#using scripts\anim\utility_common;
#using scripts\asm\asm_bb;
#using scripts\common\debug;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace notetracks_mp;

// Namespace notetracks_mp / scripts\anim\notetracks_mp
// Params 0
// Checksum 0x0, Offset: 0x1a9
// Size: 0x21
function registernotetracksifnot()
{
    if ( isdefined( anim.notetracks ) )
    {
        return;
    }
    
    anim.notetracks = [];
    registernotetracks();
}

// Namespace notetracks_mp / scripts\anim\notetracks_mp
// Params 0
// Checksum 0x0, Offset: 0x1d2
// Size: 0x8e
function registernotetracks()
{
    level._defaultnotetrackhandler = &handlenotetrack;
    level.fnnotetrackprefixhandler = &function_6d9ff7d18e45dc9c;
    scripts\anim\notetracks::registernotetracks();
    anim.notetracks[ "anim_pose = stand" ] = &notetrackposestand;
    anim.notetracks[ "anim_pose = crouch" ] = &notetrackposecrouch;
    anim.notetracks[ "anim_pose = prone" ] = &notetrackposeprone;
    anim.notetracks[ "gun drop" ] = &notetrackgundrop;
    anim.notetracks[ "dropgun" ] = &notetrackgundrop;
}

// Namespace notetracks_mp / scripts\anim\notetracks_mp
// Params 4
// Checksum 0x0, Offset: 0x268
// Size: 0xbf
function handlenotetrack( note, flagname, customfunction, customparams )
{
    if ( scripts\anim\notetracks::hascustomnotetrackhandler( note ) )
    {
        return scripts\anim\notetracks::handlecustomnotetrackhandler( note, flagname, customfunction, customparams );
    }
    
    retval = scripts\anim\notetracks::handlecommonnotetrack( note, flagname, customfunction, customparams );
    
    if ( isdefined( retval ) && retval == "__unhandled" )
    {
        retval = undefined;
        
        switch ( note )
        {
            case #"hash_88cce8d6571fe7e1":
                if ( weaponclass( self.weapon ) == "rocketlauncher" )
                {
                    notetrackrocketlauncherammoattach();
                }
                
                break;
            default:
                if ( isdefined( customfunction ) )
                {
                    if ( isdefined( customparams ) )
                    {
                        return [[ customfunction ]]( note, customparams );
                    }
                    else
                    {
                        return [[ customfunction ]]( note );
                    }
                }
                
                break;
        }
    }
    
    return retval;
}

// Namespace notetracks_mp / scripts\anim\notetracks_mp
// Params 1
// Checksum 0x0, Offset: 0x330
// Size: 0x155
function function_6d9ff7d18e45dc9c( notetrack )
{
    prefix = getsubstr( notetrack, 0, 3 );
    
    if ( prefix == "as_" )
    {
        alias = getsubstr( notetrack, 3 );
        
        if ( isdefined( self.anim_playsound_func ) )
        {
            self thread [[ self.anim_playsound_func ]]( alias );
        }
        
        return 1;
    }
    
    if ( prefix == "vm_" )
    {
        animation = getsubstr( notetrack, 3 );
        
        if ( isdefined( self.anim_playvm_func ) )
        {
            self thread [[ self.anim_playvm_func ]]( animation );
        }
        
        return 1;
    }
    
    if ( prefix == "ws_" )
    {
        state = getsubstr( notetrack, 3 );
        
        if ( isdefined( self.weapon_state_func ) )
        {
            self thread [[ self.weapon_state_func ]]( state );
        }
        
        return 1;
    }
    
    if ( prefix == "cm_" )
    {
        var_d8958445ed7ab829 = getsubstr( notetrack, 3 );
        
        if ( isdefined( self.cinematic_motion_override ) )
        {
            self thread [[ self.cinematic_motion_override ]]( var_d8958445ed7ab829 );
        }
        
        return 1;
    }
    
    if ( prefix == "df_" )
    {
        doftype = getsubstr( notetrack, 3 );
        
        if ( isdefined( self.dof_func ) )
        {
            self thread [[ self.dof_func ]]( doftype );
        }
        
        return 1;
    }
    
    return scripts\anim\notetracks::notetrack_prefix_handler_common( notetrack );
}

// Namespace notetracks_mp / scripts\anim\notetracks_mp
// Params 0
// Checksum 0x0, Offset: 0x48e
// Size: 0x3b
function notetrackrocketlauncherammoattach()
{
    assert( isdefined( self ) );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( !usingrocketlauncher() )
    {
        return;
    }
    
    if ( self tagexists( "tag_rocket" ) )
    {
        self showpart( "tag_rocket" );
    }
}

// Namespace notetracks_mp / scripts\anim\notetracks_mp
// Params 2
// Checksum 0x0, Offset: 0x4d1
// Size: 0x5b
function notetrackgundrop( note, flagname )
{
    if ( !isai( self ) )
    {
        println( "<dev string:x1c>" + function_a2eaafb222316a2( self ) + "<dev string:x31>" + note + "<dev string:x47>" );
        return;
    }
    
    if ( isdefined( self.fndropweapon ) )
    {
        self [[ self.fndropweapon ]]();
    }
}

// Namespace notetracks_mp / scripts\anim\notetracks_mp
// Params 1
// Checksum 0x0, Offset: 0x534
// Size: 0x27
function setpose( pose )
{
    self.currentpose = pose;
    scripts\asm\asm_bb::bb_requeststance( pose );
    self notify( "entered_pose" + pose );
}

// Namespace notetracks_mp / scripts\anim\notetracks_mp
// Params 2
// Checksum 0x0, Offset: 0x563
// Size: 0x1f
function notetrackposestand( note, flagname )
{
    setpose( "stand" );
}

// Namespace notetracks_mp / scripts\anim\notetracks_mp
// Params 2
// Checksum 0x0, Offset: 0x58a
// Size: 0x1f
function notetrackposecrouch( note, flagname )
{
    setpose( "crouch" );
}

// Namespace notetracks_mp / scripts\anim\notetracks_mp
// Params 2
// Checksum 0x0, Offset: 0x5b1
// Size: 0x1f
function notetrackposeprone( note, flagname )
{
    setpose( "prone" );
}

