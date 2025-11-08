#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;

#namespace cp_escalation;

// Namespace cp_escalation / scripts\cp\cp_escalation
// Params 0
// Checksum 0x0, Offset: 0xa6
// Size: 0x3a
function main()
{
    level.escalation_level = 0;
    level.escalation_counter = 0;
    level.min_escalation_level_override = getdvarint( @"hash_596edec0cdb7175a", 0 );
    
    /#
        level thread function_a3d713c06dc62278();
    #/
}

// Namespace cp_escalation / scripts\cp\cp_escalation
// Params 1
// Checksum 0x0, Offset: 0xe8
// Size: 0x1d
function escalation_level_clamp( value )
{
    return clamp( value, get_min_escalation_level(), get_max_escalation_level() );
}

// Namespace cp_escalation / scripts\cp\cp_escalation
// Params 0
// Checksum 0x0, Offset: 0x10e
// Size: 0x22
function increment_escalation_level()
{
    level.escalation_level = int( escalation_level_clamp( level.escalation_level + 1 ) );
}

// Namespace cp_escalation / scripts\cp\cp_escalation
// Params 0
// Checksum 0x0, Offset: 0x138
// Size: 0x22
function decrement_escalation_level()
{
    level.escalation_level = int( escalation_level_clamp( level.escalation_level - 1 ) );
}

// Namespace cp_escalation / scripts\cp\cp_escalation
// Params 0
// Checksum 0x0, Offset: 0x162
// Size: 0x1c
function set_to_max_escalation()
{
    level.escalation_level = int( escalation_level_clamp( get_max_escalation_level() ) );
}

// Namespace cp_escalation / scripts\cp\cp_escalation
// Params 0
// Checksum 0x0, Offset: 0x186
// Size: 0x1c
function set_to_min_escalation()
{
    level.escalation_level = int( escalation_level_clamp( get_min_escalation_level() ) );
}

// Namespace cp_escalation / scripts\cp\cp_escalation
// Params 0
// Checksum 0x0, Offset: 0x1aa
// Size: 0x12
function get_max_escalation_level()
{
    return getdvarint( @"hash_a8efe8f1b98e7b38", 5 );
}

// Namespace cp_escalation / scripts\cp\cp_escalation
// Params 0
// Checksum 0x0, Offset: 0x1c5
// Size: 0x12
function get_max_escalation_decay_start()
{
    return getdvarint( @"hash_2baf3906967ba87f", 10 );
}

// Namespace cp_escalation / scripts\cp\cp_escalation
// Params 0
// Checksum 0x0, Offset: 0x1e0
// Size: 0x12
function get_max_escalation_decay_rate()
{
    return getdvarint( @"hash_b5effa98a3f6c6a7", 1 );
}

// Namespace cp_escalation / scripts\cp\cp_escalation
// Params 0
// Checksum 0x0, Offset: 0x1fb
// Size: 0x36
function get_min_escalation_level()
{
    return_value = getdvarint( @"hash_596edec0cdb7175a", 0 );
    
    if ( level.min_escalation_level_override != return_value )
    {
        return_value = level.min_escalation_level_override;
    }
    
    return return_value;
}

// Namespace cp_escalation / scripts\cp\cp_escalation
// Params 0
// Checksum 0x0, Offset: 0x23a
// Size: 0xb
function get_escalation_counter()
{
    return level.escalation_counter;
}

// Namespace cp_escalation / scripts\cp\cp_escalation
// Params 1
// Checksum 0x0, Offset: 0x24e
// Size: 0x1b
function increase_minimum_escalation_level( new_value )
{
    level.min_escalation_level_override = escalation_level_clamp( new_value );
}

// Namespace cp_escalation / scripts\cp\cp_escalation
// Params 0
// Checksum 0x0, Offset: 0x271
// Size: 0x4e
function increase_escalation_counter()
{
    new_value = level.escalation_counter + 0.1;
    level.escalation_counter = escalation_level_clamp( new_value );
    
    if ( int( level.escalation_counter ) > level.escalation_level )
    {
        increment_escalation_level();
    }
}

// Namespace cp_escalation / scripts\cp\cp_escalation
// Params 0
// Checksum 0x0, Offset: 0x2c7
// Size: 0x4e
function decrease_escalation_counter()
{
    new_value = level.escalation_counter - 0.1;
    level.escalation_counter = escalation_level_clamp( new_value );
    
    if ( int( level.escalation_counter ) < level.escalation_level )
    {
        decrement_escalation_level();
    }
}

// Namespace cp_escalation / scripts\cp\cp_escalation
// Params 0
// Checksum 0x0, Offset: 0x31d
// Size: 0x42
function handle_escalation_on_death()
{
    level endon( "game_ended" );
    level notify( "handle_escalation_on_death" );
    level endon( "handle_escalation_on_death" );
    increase_escalation_counter();
    wait get_max_escalation_decay_start();
    
    while ( get_escalation_counter() > 0 )
    {
        decrease_escalation_counter();
        wait get_max_escalation_decay_rate();
    }
}

/#

    // Namespace cp_escalation / scripts\cp\cp_escalation
    // Params 0
    // Checksum 0x0, Offset: 0x367
    // Size: 0x7f, Type: dev
    function function_a3d713c06dc62278()
    {
        cmd = "<dev string:x1c>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x80>";
        addentrytodevgui( cmd );
        cmd = "<dev string:xee>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x15c>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x1c4>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x22e>";
        addentrytodevgui( cmd );
        level thread debug_activation( @"hash_d795289aa8918baa", &function_a80873169ee2bf94 );
    }

    // Namespace cp_escalation / scripts\cp\cp_escalation
    // Params 1
    // Checksum 0x0, Offset: 0x3ee
    // Size: 0x1b3, Type: dev
    function function_a80873169ee2bf94( itemref )
    {
        flag_wait( "<dev string:x2aa>" );
        items = strtok( itemref, "<dev string:x2c1>" );
        playertoks = strtok( itemref, "<dev string:x2c3>" );
        params = strtok( itemref, "<dev string:x2c5>" );
        player = undefined;
        
        if ( playertoks.size > 1 )
        {
            playerint = int( playertoks[ 0 ] );
            player = level.players[ playerint ];
        }
        
        switch ( items[ 0 ] )
        {
            case #"hash_95b1a16bfab4c38d":
                increment_escalation_level();
                announcement( "<dev string:x2d0>" + level.escalation_level );
                break;
            case #"hash_97ec2cf56770f7a1":
                decrement_escalation_level();
                announcement( "<dev string:x2d0>" + level.escalation_level );
                break;
            case #"hash_289ae26c1f0ee7f9":
                set_to_max_escalation();
                announcement( "<dev string:x2d0>" + level.escalation_level );
                break;
            case #"hash_1da4229a165378a0":
                set_to_min_escalation();
                announcement( "<dev string:x2d0>" + level.escalation_level );
                break;
            case #"hash_2881d46c1efb4a37":
                increase_minimum_escalation_level( level.min_escalation_level_override + 1 );
                announcement( "<dev string:x2f4>" + level.min_escalation_level_override );
                break;
            case #"hash_6e4a8ac4007a65c3":
                level.min_escalation_level_override = 0;
                set_to_min_escalation();
                announcement( "<dev string:x2d0>" + level.escalation_level );
                break;
        }
    }

#/
