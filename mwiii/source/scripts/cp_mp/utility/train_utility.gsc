#namespace train_utility;

// Namespace train_utility / scripts\cp_mp\utility\train_utility
// Params 0
// Checksum 0x0, Offset: 0x143
// Size: 0x27, Type: bool
function player_standing_on_train()
{
    potential_train = self getmovingplatformparent();
    
    if ( isdefined( potential_train ) )
    {
        if ( is_train_ent( potential_train ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace train_utility / scripts\cp_mp\utility\train_utility
// Params 0
// Checksum 0x0, Offset: 0x173
// Size: 0x3d
function function_d6b0a591ac99bd()
{
    if ( isdefined( level.wztrain_info ) && isdefined( level.wztrain_info.train_array ) )
    {
        return level.wztrain_info.train_array[ 0 ];
    }
}

// Namespace train_utility / scripts\cp_mp\utility\train_utility
// Params 1
// Checksum 0x0, Offset: 0x1b8
// Size: 0xa6, Type: bool
function is_train_ent( hitent )
{
    if ( isdefined( level.wztrain_info ) )
    {
        foreach ( ent in level.wztrain_info.train_array )
        {
            if ( !isdefined( ent ) )
            {
                continue;
            }
            
            if ( ent == hitent )
            {
                return true;
            }
            
            if ( isdefined( ent.linked_model ) && ent.linked_model == hitent )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace train_utility / scripts\cp_mp\utility\train_utility
// Params 0
// Checksum 0x0, Offset: 0x267
// Size: 0x2a
function function_31156831afc882ad()
{
    if ( !isdefined( level.wztrain_info ) )
    {
        return undefined;
    }
    
    potential_train = self getmovingplatformparent();
    return function_e58b746157089c68( potential_train );
}

// Namespace train_utility / scripts\cp_mp\utility\train_utility
// Params 1
// Checksum 0x0, Offset: 0x29a
// Size: 0x103
function function_e58b746157089c68( hitent )
{
    if ( !isdefined( level.wztrain_info ) )
    {
        return undefined;
    }
    
    if ( !isdefined( level.wztrain_info.trains ) )
    {
        return undefined;
    }
    
    if ( !isdefined( hitent ) )
    {
        return undefined;
    }
    
    foreach ( train, array in level.wztrain_info.trains )
    {
        foreach ( ent in array )
        {
            if ( ent == hitent )
            {
                return train;
            }
            
            if ( isdefined( ent.linked_model ) && ent.linked_model == hitent )
            {
                return train;
            }
        }
    }
    
    return undefined;
}

// Namespace train_utility / scripts\cp_mp\utility\train_utility
// Params 0
// Checksum 0x0, Offset: 0x3a6
// Size: 0x54
function function_d699841d5e241043()
{
    content = [ "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_playerclip" ];
    return physics_createcontents( content );
}

// Namespace train_utility / scripts\cp_mp\utility\train_utility
// Params 1
// Checksum 0x0, Offset: 0x403
// Size: 0xa5, Type: bool
function is_moving_platform_train( movingplatforment )
{
    if ( !isdefined( movingplatforment ) )
    {
        return false;
    }
    
    if ( isdefined( level.wztrain_info ) )
    {
        foreach ( ent in level.wztrain_info.train_array )
        {
            if ( ent == movingplatforment )
            {
                return true;
            }
            
            if ( isdefined( ent.linked_model ) && ent.linked_model == movingplatforment )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace train_utility / scripts\cp_mp\utility\train_utility
// Params 9
// Checksum 0x0, Offset: 0x4b1
// Size: 0x71
function isplayerinsiderectangularzonebasedonent( player, referenceent, var_f5e80a9c637f1716, var_1575b6a2d72eab66, var_dff51823f3f6bcdd, var_98029591bfd2abae, zonelength, zonewidth, zoneheight )
{
    rectangularzone = createrectangularzonebasedonent( referenceent, var_f5e80a9c637f1716, var_1575b6a2d72eab66, var_dff51823f3f6bcdd, var_98029591bfd2abae, zonelength, zonewidth, zoneheight );
    return isplayerinsiderectangularzone( player, rectangularzone );
}

// Namespace train_utility / scripts\cp_mp\utility\train_utility
// Params 2
// Checksum 0x0, Offset: 0x52b
// Size: 0xca, Type: bool
function isplayerinsiderectangularzone( player, rectangularzone )
{
    player_x = player.origin[ 0 ];
    player_y = player.origin[ 1 ];
    player_z = player.origin[ 2 ];
    
    if ( player_x > rectangularzone.max_x )
    {
        return false;
    }
    
    if ( player_x < rectangularzone.min_x )
    {
        return false;
    }
    
    if ( player_y > rectangularzone.max_y )
    {
        return false;
    }
    
    if ( player_y < rectangularzone.min_y )
    {
        return false;
    }
    
    if ( player_z > rectangularzone.max_z )
    {
        return false;
    }
    
    if ( player_z < rectangularzone.min_z )
    {
        return false;
    }
    
    return true;
}

// Namespace train_utility / scripts\cp_mp\utility\train_utility
// Params 8
// Checksum 0x0, Offset: 0x5fe
// Size: 0x276
function createrectangularzonebasedonent( referenceent, var_f5e80a9c637f1716, var_1575b6a2d72eab66, var_dff51823f3f6bcdd, var_98029591bfd2abae, zonelength, zonewidth, zoneheight )
{
    rectangularzone = createdefaultrectangularzone();
    referenceforward = anglestoforward( referenceent.angles );
    referenceright = anglestoright( referenceent.angles );
    referenceup = anglestoup( referenceent.angles );
    basetagpos = referenceent gettagorigin( var_f5e80a9c637f1716 );
    zonecenter = basetagpos + referenceforward * var_1575b6a2d72eab66 + referenceright * var_dff51823f3f6bcdd + referenceup * var_98029591bfd2abae;
    var_b068b11c5df814d = [];
    
    /#
        function_6c75bb7dbb04ead5( zonecenter );
    #/
    
    halflength = zonelength / 2;
    halfwidth = zonewidth / 2;
    halfheight = zoneheight / 2;
    var_b125447fffeb35c0 = [ halflength, halflength * -1 ];
    var_5a33cfa8a827bfd2 = [ halfwidth, halfwidth * -1 ];
    zoneheightoffset = [ halfheight, halfheight * -1 ];
    
    foreach ( lengthoffset in var_b125447fffeb35c0 )
    {
        foreach ( widthoffset in var_5a33cfa8a827bfd2 )
        {
            foreach ( heightoffset in zoneheightoffset )
            {
                var_1b5afbedd7e1ee0c = zonecenter + referenceforward * lengthoffset + referenceright * widthoffset + referenceup * heightoffset;
                
                /#
                    function_e3aeb62332441401( var_1b5afbedd7e1ee0c );
                    var_b068b11c5df814d[ var_b068b11c5df814d.size ] = var_1b5afbedd7e1ee0c;
                #/
                
                updaterectangularzone( var_1b5afbedd7e1ee0c, rectangularzone );
            }
        }
    }
    
    /#
        function_e80ba1fe0db513dc( var_b068b11c5df814d );
    #/
    
    return rectangularzone;
}

// Namespace train_utility / scripts\cp_mp\utility\train_utility
// Params 2
// Checksum 0x0, Offset: 0x87d
// Size: 0xec
function updaterectangularzone( var_1b5afbedd7e1ee0c, rectangularzone )
{
    var_b068011c5df691c = var_1b5afbedd7e1ee0c[ 0 ];
    var_b068111c5df6b4f = var_1b5afbedd7e1ee0c[ 1 ];
    var_b068211c5df6d82 = var_1b5afbedd7e1ee0c[ 2 ];
    
    if ( var_b068011c5df691c > rectangularzone.max_x )
    {
        rectangularzone.max_x = var_b068011c5df691c;
    }
    
    if ( var_b068011c5df691c < rectangularzone.min_x )
    {
        rectangularzone.min_x = var_b068011c5df691c;
    }
    
    if ( var_b068111c5df6b4f > rectangularzone.max_y )
    {
        rectangularzone.max_y = var_b068111c5df6b4f;
    }
    
    if ( var_b068111c5df6b4f < rectangularzone.min_y )
    {
        rectangularzone.min_y = var_b068111c5df6b4f;
    }
    
    if ( var_b068211c5df6d82 > rectangularzone.max_z )
    {
        rectangularzone.max_z = var_b068211c5df6d82;
    }
    
    if ( var_b068211c5df6d82 < rectangularzone.min_z )
    {
        rectangularzone.min_z = var_b068211c5df6d82;
    }
}

// Namespace train_utility / scripts\cp_mp\utility\train_utility
// Params 0
// Checksum 0x0, Offset: 0x971
// Size: 0x7a
function createdefaultrectangularzone()
{
    rectangularzone = spawnstruct();
    rectangularzone.max_x = -999999;
    rectangularzone.min_x = 999999;
    rectangularzone.max_y = -999999;
    rectangularzone.min_y = 999999;
    rectangularzone.max_z = -999999;
    rectangularzone.min_z = 999999;
    return rectangularzone;
}

/#

    // Namespace train_utility / scripts\cp_mp\utility\train_utility
    // Params 1
    // Checksum 0x0, Offset: 0x9f4
    // Size: 0x31, Type: dev
    function function_6c75bb7dbb04ead5( zonecenter )
    {
        if ( !function_4237fc6e024c0cc1() )
        {
            return;
        }
        
        sphere( zonecenter, 2, ( 1, 0, 0 ), 0, 60 );
    }

    // Namespace train_utility / scripts\cp_mp\utility\train_utility
    // Params 1
    // Checksum 0x0, Offset: 0xa2d
    // Size: 0x31, Type: dev
    function function_e3aeb62332441401( var_1b5afbedd7e1ee0c )
    {
        if ( !function_4237fc6e024c0cc1() )
        {
            return;
        }
        
        sphere( var_1b5afbedd7e1ee0c, 2, ( 0, 1, 0 ), 0, 60 );
    }

    // Namespace train_utility / scripts\cp_mp\utility\train_utility
    // Params 1
    // Checksum 0x0, Offset: 0xa66
    // Size: 0xd0, Type: dev
    function function_e80ba1fe0db513dc( var_b068b11c5df814d )
    {
        if ( !function_4237fc6e024c0cc1() )
        {
            return;
        }
        
        foreach ( var_1b5afbedd7e1ee0c in var_b068b11c5df814d )
        {
            var_bffc067dc1ee8974 = var_b068b11c5df814d;
            
            foreach ( var_459b52e393ab64cf in var_bffc067dc1ee8974 )
            {
                if ( var_459b52e393ab64cf == var_1b5afbedd7e1ee0c )
                {
                    continue;
                }
                
                line( var_1b5afbedd7e1ee0c, var_459b52e393ab64cf, ( 0, 0, 1 ), 1, 0, 60 );
            }
        }
    }

    // Namespace train_utility / scripts\cp_mp\utility\train_utility
    // Params 0
    // Checksum 0x0, Offset: 0xb3e
    // Size: 0x17, Type: dev
    function function_4237fc6e024c0cc1()
    {
        return getdvarint( @"hash_aaddf2135ab39ed5", 0 ) != 0;
    }

#/
