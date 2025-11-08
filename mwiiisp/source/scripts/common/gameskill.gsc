#using scripts\anim\utility_common;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace gameskill;

// Namespace gameskill / scripts\common\gameskill
// Params 1
// Checksum 0x0, Offset: 0xcc
// Size: 0x2f
function get_skill_from_index( index )
{
    if ( utility::issp() || utility::iscp() )
    {
        index += 1;
    }
    
    return level.difficultytype[ index ];
}

// Namespace gameskill / scripts\common\gameskill
// Params 1
// Checksum 0x0, Offset: 0x104
// Size: 0x55
function apply_difficulty_settings_shared( current_frac )
{
    assert( isplayer( self ) );
    self.gameskillmisstimeconstant = get_difficultysetting_frac( "missTimeConstant", current_frac );
    self.gameskillmisstimedistancefactor = get_difficultysetting_frac( "missTimeDistanceFactor", current_frac );
    function_38ae83992c7eb8a5( get_difficultysetting( "double_grenades_allowed" ) );
}

// Namespace gameskill / scripts\common\gameskill
// Params 2
// Checksum 0x0, Offset: 0x161
// Size: 0x1c
function get_difficultysetting_frac( setting, frac )
{
    return get_difficultysetting( setting ) * frac;
}

// Namespace gameskill / scripts\common\gameskill
// Params 2
// Checksum 0x0, Offset: 0x186
// Size: 0x36
function get_difficultysetting( setting, gameskill )
{
    if ( !isdefined( gameskill ) )
    {
        gameskill = self.gameskill;
    }
    
    return level.difficultysettings[ setting ][ get_skill_from_index( gameskill ) ];
}

// Namespace gameskill / scripts\common\gameskill
// Params 1
// Checksum 0x0, Offset: 0x1c5
// Size: 0x26
function get_difficultysetting_global( setting )
{
    return level.difficultysettings[ setting ][ get_skill_from_index( level.gameskill ) ];
}

// Namespace gameskill / scripts\common\gameskill
// Params 0
// Checksum 0x0, Offset: 0x1f4
// Size: 0x3, Type: bool
function always_pain()
{
    return false;
}

// Namespace gameskill / scripts\common\gameskill
// Params 0
// Checksum 0x0, Offset: 0x200
// Size: 0x17, Type: bool
function pain_protection()
{
    if ( !pain_protection_check() )
    {
        return false;
    }
    
    return randomint( 100 ) > 25;
}

// Namespace gameskill / scripts\common\gameskill
// Params 0
// Checksum 0x0, Offset: 0x220
// Size: 0xa2, Type: bool
function pain_protection_check()
{
    if ( !isalive( self.enemy ) )
    {
        return false;
    }
    
    if ( !isplayer( self.enemy ) )
    {
        return false;
    }
    
    if ( !isalive( level.painai ) || level.painai.script != "pain" )
    {
        level.painai = self;
    }
    
    if ( self == level.painai )
    {
        return false;
    }
    
    objweapon = self.damageweapon;
    
    if ( !isnullweapon( objweapon ) && objweapon.isbolt )
    {
        return false;
    }
    
    return true;
}

// Namespace gameskill / scripts\common\gameskill
// Params 0
// Checksum 0x0, Offset: 0x2cb
// Size: 0xa3
function set_accuracy_based_on_situation()
{
    if ( self aiissniper() && isalive( self.enemy ) )
    {
        self function_73ef2fe03a776cd7();
        return;
    }
    
    if ( isplayer( self.enemy ) )
    {
        resetmissdebouncetime();
        
        if ( self.misstime > gettime() )
        {
            self.accuracy = 0;
            return;
        }
    }
    
    self.accuracy = self.baseaccuracy;
    
    if ( isdefined( self.isrambo ) && isdefined( self.ramboaccuracymult ) )
    {
        self.accuracy *= self.ramboaccuracymult;
    }
}

// Namespace gameskill / scripts\common\gameskill
// Params 0
// Checksum 0x0, Offset: 0x376
// Size: 0xc
function didsomethingotherthanshooting()
{
    self.misstimedebounce = 0;
}

// Namespace gameskill / scripts\common\gameskill
// Params 0
// Checksum 0x0, Offset: 0x38a
// Size: 0x14
function resetmissdebouncetime()
{
    self.misstimedebounce = gettime() + 3000;
}

// Namespace gameskill / scripts\common\gameskill
// Params 0
// Checksum 0x0, Offset: 0x3a6
// Size: 0x59
function default_door_node_flashbang_frequency()
{
    if ( self.team == "allies" )
    {
        self.doorflashchance = 0.6;
    }
    
    if ( self isbadguy() )
    {
        if ( level.gameskill >= 2 )
        {
            self.doorflashchance = 0.8;
            return;
        }
        
        self.doorflashchance = 0.6;
    }
}

// Namespace gameskill / scripts\common\gameskill
// Params 0
// Checksum 0x0, Offset: 0x407
// Size: 0x53
function grenadeawareness()
{
    if ( self.team == "allies" )
    {
        self.grenadeawareness = 0.9;
        self.grenadereturnthrowchance = 0.9;
        return;
    }
    
    if ( self isbadguy() )
    {
        self.grenadeawareness = 1;
        self.grenadereturnthrowchance = 0.2;
    }
}

// Namespace gameskill / scripts\common\gameskill
// Params 0
// Checksum 0x0, Offset: 0x462
// Size: 0x4c
function map_is_early_in_the_game()
{
    if ( !isdefined( level.early_level ) )
    {
        /#
            print( "<dev string:x1c>" );
        #/
        
        return 1;
    }
    
    if ( isdefined( level.early_level[ level.script ] ) )
    {
        return level.early_level[ level.script ];
    }
    
    return 0;
}

// Namespace gameskill / scripts\common\gameskill
// Params 0
// Checksum 0x0, Offset: 0x4b7
// Size: 0xc
function set_early_level()
{
    level.early_level = [];
}

