#using scripts\common\utility;
#using scripts\engine\utility;

#namespace ai_lookat;

// Namespace ai_lookat / scripts\common\ai_lookat
// Params 2
// Checksum 0x0, Offset: 0xde
// Size: 0x2b
function enablelookatplayer( enabletime, percent )
{
    enablelookatentity( level.player, utility::function_b88f4e5baff057a9( enabletime ), percent );
}

// Namespace ai_lookat / scripts\common\ai_lookat
// Params 0
// Checksum 0x0, Offset: 0x111
// Size: 0x12
function disablelookatplayer()
{
    disablelookatentity( level.player );
}

// Namespace ai_lookat / scripts\common\ai_lookat
// Params 4
// Checksum 0x0, Offset: 0x12b
// Size: 0xc1
function enablelookatentity( ent, speed, percent, offset )
{
    if ( !isdefined( self.lookatentities ) )
    {
        self.lookatentities = [];
    }
    
    if ( !self.lookatentities.size )
    {
        self function_1c339daaba3f71db( 1 );
    }
    
    self.lookatentities[ self.lookatentities.size ] = ent;
    
    if ( isdefined( speed ) )
    {
        self function_106bce0aeee91d2c( speed );
    }
    
    if ( isdefined( percent ) )
    {
        self function_6dc7c9be085f4137( percent );
    }
    
    if ( isplayer( ent ) )
    {
        self function_5621e511b99964a7( ent );
        return;
    }
    
    if ( isdefined( offset ) )
    {
        ent.lookat_offset = offset;
    }
    else
    {
        offset = ( 0, 0, 0 );
    }
    
    self function_6ef849bee4b12dd( ent, offset );
}

// Namespace ai_lookat / scripts\common\ai_lookat
// Params 1
// Checksum 0x0, Offset: 0x1f4
// Size: 0x133
function disablelookatentity( ent )
{
    if ( !isdefined( self.lookatentities ) || !array_contains( self.lookatentities, ent ) )
    {
        return;
    }
    
    lookingatent = function_350e192b13bea45c( self.lookatentities ) == ent;
    self.lookatentities = function_57091b2d67654a14( self.lookatentities, ent );
    self.lookatentities = array_removeundefined( self.lookatentities );
    
    if ( isdefined( ent.lookat_offset ) )
    {
        ent.lookat_offset = undefined;
    }
    
    if ( lookingatent )
    {
        if ( isplayer( ent ) )
        {
            self function_504a5e2df31069a4();
        }
        
        if ( self.lookatentities.size > 0 )
        {
            var_180bbbd4951d78ad = function_350e192b13bea45c( self.lookatentities );
            
            if ( isplayer( var_180bbbd4951d78ad ) )
            {
                self function_5621e511b99964a7( var_180bbbd4951d78ad );
            }
            else
            {
                offset = default_to( var_180bbbd4951d78ad.lookat_offset, ( 0, 0, 0 ) );
                self function_6ef849bee4b12dd( var_180bbbd4951d78ad, offset );
            }
        }
    }
    
    if ( !self.lookatentities.size )
    {
        self function_1c339daaba3f71db( 0 );
        self stoplookat();
    }
}

// Namespace ai_lookat / scripts\common\ai_lookat
// Params 0
// Checksum 0x0, Offset: 0x32f
// Size: 0x11
function islookingatplayer()
{
    return islookingatentity( level.player );
}

// Namespace ai_lookat / scripts\common\ai_lookat
// Params 1
// Checksum 0x0, Offset: 0x349
// Size: 0x18
function islookingatentity( ent )
{
    return is_equal( ent, getlookatentity() );
}

// Namespace ai_lookat / scripts\common\ai_lookat
// Params 0
// Checksum 0x0, Offset: 0x36a
// Size: 0x2f
function getlookatentity()
{
    if ( !isdefined( self.lookatentities ) || !self.lookatentities.size )
    {
        return undefined;
    }
    
    return function_350e192b13bea45c( self.lookatentities );
}

// Namespace ai_lookat / scripts\common\ai_lookat
// Params 12
// Checksum 0x0, Offset: 0x3a2
// Size: 0x94c
function function_11e84eac72368d4e( ontimeclose, ontimefar, offtimeclose, offtimefar, innerradius, outerradius, enabletimeclose, enabletimefar, percentclose, percentfar, fovcos, var_1ff7cb08338acf70 )
{
    self endon( "death" );
    self endon( "stop_idle_lookat" );
    var_1496542aefb33638 = 1;
    var_c0d0b7117d58efe5 = 2;
    var_b60538a3788d98b4 = 2000;
    cstart = 0;
    ccantsee = 1;
    var_c6a46e2201b2e656 = 2;
    var_35a335748f48d56f = 3;
    var_8c9657636d4eed14 = 4;
    var_a729f7c9da5037 = 5;
    var_54ee9baadb24a574 = 6;
    var_afbd8c41b09c1c1d = 7;
    var_e2c608d6182b190b = 8;
    var_41fdd42a3580814e = 9;
    state = cstart;
    nextstate = cstart;
    cooldown = 0;
    ontimeclose = int( ontimeclose ) * 1000;
    ontimefar = int( ontimefar ) * 1000;
    offtimeclose = int( offtimeclose ) * 1000;
    offtimefar = int( offtimefar ) * 1000;
    
    /#
        setdvarifuninitialized( @"hash_f3db11612f967c4a", 0 );
    #/
    
    while ( true )
    {
        disttoplayer = distance( level.player.origin, self.origin );
        diststate = var_c0d0b7117d58efe5;
        
        if ( disttoplayer > innerradius )
        {
            diststate = var_1496542aefb33638;
        }
        
        selfforward = anglestoforward( self.angles );
        playerforward = anglestoforward( level.player.angles );
        toplayer = vectornormalize( level.player.origin - self.origin );
        canseeplayer = vectordot( selfforward, toplayer ) > fovcos && disttoplayer < outerradius;
        playercansee = vectordot( playerforward, -1 * toplayer ) > var_1ff7cb08338acf70;
        
        /#
            if ( getdvarint( @"hash_f3db11612f967c4a", 0 ) )
            {
                statestr = "<dev string:x1c>";
                
                switch ( state )
                {
                    case 0:
                        statestr = "<dev string:x20>";
                        break;
                    case 1:
                        statestr = "<dev string:x29>";
                        break;
                    case 2:
                        statestr = "<dev string:x35>";
                        break;
                    case 3:
                        statestr = "<dev string:x46>";
                        break;
                    case 4:
                        statestr = "<dev string:x54>";
                        break;
                    case 5:
                        statestr = "<dev string:x70>";
                        break;
                    case 6:
                        statestr = "<dev string:x8b>";
                        break;
                    case 7:
                        statestr = "<dev string:x9a>";
                        break;
                    case 8:
                        statestr = "<dev string:xb2>";
                        break;
                    case 9:
                        statestr = "<dev string:xc0>";
                        break;
                    default:
                        statestr = "<dev string:xd7>";
                        break;
                }
                
                debugpos = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 80 );
                print3d( debugpos, statestr, ( 0, 0, 1 ), 1, 0.25, 1, 1 );
            }
        #/
        
        if ( state == cstart )
        {
            if ( !canseeplayer )
            {
                nextstate = ccantsee;
            }
            else if ( canseeplayer )
            {
                nextstate = var_c6a46e2201b2e656;
            }
        }
        else if ( state == ccantsee )
        {
            if ( canseeplayer )
            {
                nextstate = var_c6a46e2201b2e656;
            }
        }
        else if ( state == var_c6a46e2201b2e656 && cooldown < gettime() )
        {
            if ( !canseeplayer )
            {
                nextstate = ccantsee;
            }
            else if ( diststate == var_c0d0b7117d58efe5 && playercansee )
            {
                nextstate = var_35a335748f48d56f;
            }
            else if ( diststate == var_c0d0b7117d58efe5 && !playercansee )
            {
                nextstate = var_54ee9baadb24a574;
            }
            else if ( diststate == var_1496542aefb33638 )
            {
                nextstate = var_e2c608d6182b190b;
            }
        }
        else if ( state == var_35a335748f48d56f )
        {
            if ( diststate != var_c0d0b7117d58efe5 || !canseeplayer || !playercansee )
            {
                nextstate = var_8c9657636d4eed14;
            }
        }
        else if ( state == var_8c9657636d4eed14 && cooldown < gettime() )
        {
            if ( !canseeplayer )
            {
                nextstate = ccantsee;
            }
            else if ( diststate == var_c0d0b7117d58efe5 && playercansee )
            {
                nextstate = var_35a335748f48d56f;
            }
            else if ( diststate == var_c0d0b7117d58efe5 && !playercansee )
            {
                nextstate = var_afbd8c41b09c1c1d;
            }
            else if ( diststate == var_1496542aefb33638 )
            {
                nextstate = var_41fdd42a3580814e;
            }
        }
        else if ( state == var_a729f7c9da5037 && cooldown < gettime() )
        {
            if ( !canseeplayer )
            {
                nextstate = ccantsee;
            }
            else if ( diststate == var_c0d0b7117d58efe5 && playercansee )
            {
                nextstate = var_35a335748f48d56f;
            }
            else if ( diststate == var_c0d0b7117d58efe5 && !playercansee )
            {
                nextstate = var_afbd8c41b09c1c1d;
            }
            else if ( diststate == var_1496542aefb33638 )
            {
                nextstate = var_41fdd42a3580814e;
            }
        }
        else if ( state == var_54ee9baadb24a574 && cooldown < gettime() )
        {
            if ( !canseeplayer )
            {
                nextstate = ccantsee;
            }
            else if ( diststate == var_c0d0b7117d58efe5 && !playercansee )
            {
                nextstate = var_afbd8c41b09c1c1d;
            }
            else if ( diststate == var_c0d0b7117d58efe5 && playercansee )
            {
                nextstate = var_35a335748f48d56f;
            }
            else if ( diststate == var_1496542aefb33638 )
            {
                nextstate = var_41fdd42a3580814e;
            }
        }
        else if ( state == var_afbd8c41b09c1c1d && cooldown < gettime() )
        {
            if ( !canseeplayer )
            {
                nextstate = ccantsee;
            }
            else if ( diststate == var_c0d0b7117d58efe5 && playercansee )
            {
                nextstate = var_a729f7c9da5037;
            }
            else if ( diststate == var_c0d0b7117d58efe5 && !playercansee )
            {
                nextstate = var_54ee9baadb24a574;
            }
            else if ( diststate == var_1496542aefb33638 )
            {
                nextstate = var_41fdd42a3580814e;
            }
        }
        else if ( state == var_e2c608d6182b190b && cooldown < gettime() )
        {
            if ( !canseeplayer )
            {
                nextstate = ccantsee;
            }
            else if ( diststate == var_1496542aefb33638 )
            {
                nextstate = var_41fdd42a3580814e;
            }
            else if ( diststate == var_c0d0b7117d58efe5 && playercansee )
            {
                nextstate = var_35a335748f48d56f;
            }
            else if ( diststate == var_c0d0b7117d58efe5 && !playercansee )
            {
                nextstate = var_afbd8c41b09c1c1d;
            }
        }
        else if ( state == var_41fdd42a3580814e && cooldown < gettime() )
        {
            if ( !canseeplayer )
            {
                nextstate = ccantsee;
            }
            else if ( diststate == var_1496542aefb33638 )
            {
                nextstate = var_e2c608d6182b190b;
            }
            else if ( diststate == var_c0d0b7117d58efe5 && !playercansee )
            {
                nextstate = var_afbd8c41b09c1c1d;
            }
            else if ( diststate == var_c0d0b7117d58efe5 && playercansee )
            {
                nextstate = var_a729f7c9da5037;
            }
        }
        
        if ( state != nextstate )
        {
            if ( state == cstart )
            {
                if ( nextstate == ccantsee )
                {
                    disablelookatplayer();
                }
                else if ( nextstate == var_c6a46e2201b2e656 )
                {
                    cooldown = gettime() + var_b60538a3788d98b4;
                }
            }
            else if ( state == ccantsee )
            {
                if ( nextstate == var_c6a46e2201b2e656 )
                {
                    cooldown = gettime() + var_b60538a3788d98b4;
                }
            }
            else if ( state == var_c6a46e2201b2e656 )
            {
                if ( nextstate == ccantsee )
                {
                    disablelookatplayer();
                }
                else if ( nextstate == var_35a335748f48d56f )
                {
                    enablelookatplayer( enabletimeclose, percentclose );
                }
                else if ( nextstate == var_54ee9baadb24a574 )
                {
                    enablelookatplayer( enabletimeclose, percentclose );
                    cooldown = gettime() + ontimeclose;
                }
                else if ( nextstate == var_e2c608d6182b190b )
                {
                    enablelookatplayer( enabletimefar, percentfar );
                    cooldown = gettime() + ontimefar;
                }
            }
            else if ( state == var_35a335748f48d56f )
            {
                if ( nextstate == var_8c9657636d4eed14 )
                {
                    cooldown = gettime() + var_b60538a3788d98b4;
                }
            }
            else if ( state == var_8c9657636d4eed14 )
            {
                if ( nextstate == ccantsee )
                {
                    disablelookatplayer();
                }
                else if ( nextstate == var_afbd8c41b09c1c1d )
                {
                    disablelookatplayer();
                    cooldown = gettime() + ontimeclose;
                }
                else if ( nextstate == var_41fdd42a3580814e )
                {
                    disablelookatplayer();
                    cooldown = gettime() + ontimeclose;
                }
            }
            else if ( state == var_a729f7c9da5037 )
            {
                if ( nextstate == var_35a335748f48d56f )
                {
                    enablelookatplayer( enabletimeclose, percentclose );
                }
                else if ( nextstate == var_afbd8c41b09c1c1d )
                {
                    cooldown = gettime() + offtimeclose;
                }
                else if ( nextstate == var_41fdd42a3580814e )
                {
                    cooldown = gettime() + offtimefar;
                }
            }
            else if ( state == var_54ee9baadb24a574 )
            {
                if ( nextstate == ccantsee )
                {
                    disablelookatplayer();
                }
                else if ( nextstate == var_afbd8c41b09c1c1d )
                {
                    disablelookatplayer();
                    cooldown = gettime() + offtimeclose;
                }
                else if ( nextstate == var_41fdd42a3580814e )
                {
                    disablelookatplayer();
                    cooldown = gettime() + offtimefar;
                }
            }
            else if ( state == var_afbd8c41b09c1c1d )
            {
                if ( nextstate == var_a729f7c9da5037 )
                {
                    cooldown = gettime() + var_b60538a3788d98b4;
                }
                else if ( nextstate == var_54ee9baadb24a574 )
                {
                    enablelookatplayer( enabletimeclose, percentclose );
                    cooldown = gettime() + ontimeclose;
                }
                else if ( nextstate == var_41fdd42a3580814e )
                {
                    cooldown = gettime() + offtimefar;
                }
            }
            else if ( state == var_e2c608d6182b190b )
            {
                if ( nextstate == ccantsee )
                {
                    disablelookatplayer();
                }
                else if ( nextstate == var_41fdd42a3580814e )
                {
                    disablelookatplayer();
                    cooldown = gettime() + offtimefar;
                }
                else if ( nextstate == var_35a335748f48d56f )
                {
                }
                else if ( nextstate == var_afbd8c41b09c1c1d )
                {
                    disablelookatplayer();
                    cooldown = gettime() + offtimeclose;
                }
            }
            else if ( state == var_41fdd42a3580814e )
            {
                if ( nextstate == var_e2c608d6182b190b )
                {
                    enablelookatplayer( enabletimefar, percentfar );
                    cooldown = gettime() + ontimefar;
                }
                else if ( nextstate == var_afbd8c41b09c1c1d )
                {
                    cooldown = gettime() + offtimeclose;
                }
                else if ( nextstate == var_a729f7c9da5037 )
                {
                    cooldown = gettime() + var_b60538a3788d98b4;
                }
            }
            
            state = nextstate;
        }
        
        waitframe();
    }
}

// Namespace ai_lookat / scripts\common\ai_lookat
// Params 7
// Checksum 0x0, Offset: 0xcf6
// Size: 0x3cc
function function_51c52cb24acd5706( ontime, offtime, radius, enabletime, percent, fovcos, var_1ff7cb08338acf70 )
{
    self endon( "death" );
    self endon( "stop_idle_lookat" );
    ccantsee = 0;
    var_c6a46e2201b2e656 = 1;
    cglance = 2;
    var_a56a8824d14b26df = 3;
    var_738c989de9b7ab4 = 2000;
    state = ccantsee;
    nextstate = ccantsee;
    cooldown = 0;
    ontime = int( ontime ) * 1000;
    offtime = int( offtime ) * 1000;
    
    /#
        setdvarifuninitialized( @"hash_f3db11612f967c4a", 0 );
    #/
    
    while ( true )
    {
        disttoplayer = distance( level.player.origin, self.origin );
        selfforward = anglestoforward( self.angles );
        playerforward = anglestoforward( level.player.angles );
        toplayer = vectornormalize( level.player.origin - self.origin );
        canseeplayer = vectordot( selfforward, toplayer ) > fovcos && disttoplayer < radius;
        playercansee = vectordot( playerforward, -1 * toplayer ) > var_1ff7cb08338acf70;
        canseeplayer = canseeplayer && playercansee;
        
        /#
            if ( getdvarint( @"hash_f3db11612f967c4a", 0 ) )
            {
                statestr = "<dev string:x1c>";
                
                switch ( state )
                {
                    case 0:
                        statestr = "<dev string:x29>";
                        break;
                    case 1:
                        statestr = "<dev string:x35>";
                        break;
                    case 2:
                        statestr = "<dev string:xe2>";
                        break;
                    case 3:
                        statestr = "<dev string:xec>";
                        break;
                    default:
                        statestr = "<dev string:xd7>";
                        break;
                }
                
                debugpos = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 80 );
                print3d( debugpos, statestr, ( 0, 0, 1 ), 1, 0.25, 1, 1 );
            }
        #/
        
        if ( state == ccantsee )
        {
            if ( canseeplayer )
            {
                nextstate = var_c6a46e2201b2e656;
            }
        }
        else if ( state == var_c6a46e2201b2e656 && cooldown < gettime() )
        {
            if ( canseeplayer )
            {
                nextstate = cglance;
            }
            else
            {
                nextstate = ccantsee;
            }
        }
        else if ( state == cglance && cooldown < gettime() )
        {
            if ( canseeplayer )
            {
                nextstate = var_a56a8824d14b26df;
            }
            else
            {
                nextstate = ccantsee;
            }
        }
        else if ( state == var_a56a8824d14b26df && cooldown < gettime() )
        {
            if ( canseeplayer )
            {
                nextstate = cglance;
            }
            else
            {
                nextstate = ccantsee;
            }
        }
        
        if ( state != nextstate )
        {
            if ( state == ccantsee )
            {
                if ( nextstate == var_c6a46e2201b2e656 )
                {
                    cooldown = gettime() + var_738c989de9b7ab4;
                }
            }
            else if ( state == var_c6a46e2201b2e656 )
            {
                if ( nextstate == cglance )
                {
                    enablelookatplayer( enabletime, percent );
                    cooldown = gettime() + ontime;
                }
            }
            else if ( state == cglance )
            {
                if ( nextstate == var_a56a8824d14b26df )
                {
                    disablelookatplayer();
                    cooldown = gettime() + offtime;
                }
                else if ( nextstate == ccantsee )
                {
                    disablelookatplayer();
                }
            }
            else if ( state == var_a56a8824d14b26df )
            {
                if ( nextstate == cglance )
                {
                    enablelookatplayer( enabletime, percent );
                    cooldown = gettime() + ontime;
                }
            }
            
            state = nextstate;
        }
        
        waitframe();
    }
}

// Namespace ai_lookat / scripts\common\ai_lookat
// Params 3
// Checksum 0x0, Offset: 0x10ca
// Size: 0x3f
function function_a72247099f0414e7( enable, playerradius, airadius )
{
    level.var_ee5dcc2cb0e28ecc = enable;
    
    if ( enable )
    {
        level thread function_347c218f281719e4( playerradius, airadius );
        return;
    }
    
    level notify( "end_levellookatteam" );
}

// Namespace ai_lookat / scripts\common\ai_lookat
// Params 2
// Checksum 0x0, Offset: 0x1111
// Size: 0xd7
function function_347c218f281719e4( playerradius, airadius )
{
    level endon( "end_levellookatteam" );
    
    if ( !isdefined( playerradius ) )
    {
        playerradius = 1024;
    }
    
    if ( !isdefined( airadius ) )
    {
        airadius = 512;
    }
    
    while ( level.var_ee5dcc2cb0e28ecc )
    {
        wait 5;
        ai = getaiarrayinradius( level.player.origin, playerradius );
        
        foreach ( guy in ai )
        {
            if ( isdefined( guy isinscriptedstate() ) && guy isinscriptedstate() )
            {
                continue;
            }
            
            /#
                guy thread function_ca76b97da22f081b();
            #/
            
            guy thread function_51a6f1734f850aec( ai, airadius, 5 );
        }
    }
}

// Namespace ai_lookat / scripts\common\ai_lookat
// Params 3
// Checksum 0x0, Offset: 0x11f0
// Size: 0x4e
function function_51a6f1734f850aec( ai, maxdist, maxtargets )
{
    self endon( "death" );
    self endon( "kill_lookatteam" );
    function_80a9352cf824e995( 1 );
    function_2c49add797a42aab( ai, maxdist );
    function_ff0bb38cfb102c11( ai, maxdist, 5 );
    function_80a9352cf824e995( 0 );
}

// Namespace ai_lookat / scripts\common\ai_lookat
// Params 3
// Checksum 0x0, Offset: 0x1246
// Size: 0x93
function function_1961ba599803679a( guys, maxdist, maxtargets )
{
    if ( !isdefined( self ) || !isent( self ) )
    {
        return;
    }
    
    self endon( "death" );
    self endon( "kill_lookatteam" );
    
    if ( !isdefined( self ) || self == level.player )
    {
        return;
    }
    
    function_80a9352cf824e995( 1 );
    guys[ guys.size ] = level.player;
    
    /#
        thread function_ca76b97da22f081b();
    #/
    
    while ( true )
    {
        function_c38d71f632b89906();
        function_2c49add797a42aab( guys );
        function_ff0bb38cfb102c11( guys, maxdist, maxtargets );
    }
}

// Namespace ai_lookat / scripts\common\ai_lookat
// Params 1
// Checksum 0x0, Offset: 0x12e1
// Size: 0x29
function function_80a9352cf824e995( enable )
{
    self function_1c339daaba3f71db( enable );
    self.var_c15ac68fc63fc9a8 = enable;
    
    if ( !enable )
    {
        self notify( "kill_lookatteam" );
    }
}

// Namespace ai_lookat / scripts\common\ai_lookat
// Params 2
// Checksum 0x0, Offset: 0x1312
// Size: 0x118
function function_2c49add797a42aab( guys, maxdist )
{
    if ( !isdefined( self.var_c15ac68fc63fc9a8 ) || !self.var_c15ac68fc63fc9a8 )
    {
        return;
    }
    
    guys = array_removedead( guys );
    guy = random( guys );
    
    if ( guys.size < 2 )
    {
        return;
    }
    
    if ( !isdefined( guy ) || vectordot( self.origin, guy.origin ) < 0 )
    {
        return;
    }
    
    if ( guy == self )
    {
        function_c38d71f632b89906();
        return;
    }
    
    if ( isdefined( self.lastlookattarget ) && self.lastlookattarget == guy )
    {
        self.lastlookattarget = undefined;
        return;
    }
    
    if ( isdefined( maxdist ) && distancesquared( self.origin, guy.origin ) > maxdist * maxdist )
    {
        return;
    }
    
    if ( vectordot( self.origin, guy.origin ) <= 0 )
    {
        return;
    }
    
    self.lastlookattarget = guy;
    
    /#
        self.lookatstate = "<dev string:xff>";
    #/
    
    stare( guy );
}

// Namespace ai_lookat / scripts\common\ai_lookat
// Params 3
// Checksum 0x0, Offset: 0x1432
// Size: 0x15e
function function_ff0bb38cfb102c11( guys, maxdist, maxtargets )
{
    assert( self != level.player );
    guys = array_removedead( guys );
    guys = sortbydistance( guys, self.origin );
    
    if ( guys.size < 2 )
    {
        return;
    }
    
    /#
        self.lookatstate = "<dev string:x109>";
    #/
    
    for ( lookattargetindex = 0; lookattargetindex < guys.size ; lookattargetindex++ )
    {
        guy = guys[ lookattargetindex ];
        
        if ( !isdefined( self.var_c15ac68fc63fc9a8 ) || !self.var_c15ac68fc63fc9a8 )
        {
            continue;
        }
        
        if ( !isdefined( guy ) )
        {
            continue;
        }
        
        if ( self == guy )
        {
            continue;
        }
        
        if ( !isalive( guy ) )
        {
            continue;
        }
        
        if ( isdefined( self.lastlookattarget ) && self.lastlookattarget == guy )
        {
            self.lastlookattarget = undefined;
            continue;
        }
        
        if ( isdefined( maxtargets ) && lookattargetindex >= maxtargets )
        {
            return;
        }
        
        if ( isdefined( maxdist ) && distancesquared( self.origin, guy.origin ) > maxdist * maxdist )
        {
            continue;
        }
        
        if ( vectordot( self.origin, guy.origin ) <= 0 )
        {
            continue;
        }
        
        self.lastlookattarget = guy;
        stare( guy );
    }
    
    function_c38d71f632b89906();
}

// Namespace ai_lookat / scripts\common\ai_lookat
// Params 0
// Checksum 0x0, Offset: 0x1598
// Size: 0x57
function function_c38d71f632b89906()
{
    if ( !isdefined( self ) || !isent( self ) )
    {
        return;
    }
    
    minidletime = 2;
    maxidletime = 4;
    
    /#
        self.lookatstate = "<dev string:x114>";
    #/
    
    self function_1c339daaba3f71db( 0 );
    wait randomfloatrange( minidletime, maxidletime );
    self function_1c339daaba3f71db( 1 );
}

// Namespace ai_lookat / scripts\common\ai_lookat
// Params 1
// Checksum 0x0, Offset: 0x15f7
// Size: 0x94
function stare( other )
{
    percent = 0.8;
    speed = 1;
    enablelookatentity( other, utility::function_b88f4e5baff057a9( speed ), percent );
    var_8660e4be5019b5f = 0.5;
    var_cf84bb92b95910ed = 1;
    
    if ( isdefined( other ) )
    {
        if ( self.team == other.team )
        {
            var_8660e4be5019b5f = 1.5;
            var_cf84bb92b95910ed = 2.5;
        }
        else
        {
            var_8660e4be5019b5f = 1;
            var_cf84bb92b95910ed = 1.5;
        }
    }
    
    wait randomfloatrange( var_8660e4be5019b5f, var_cf84bb92b95910ed );
}

/#

    // Namespace ai_lookat / scripts\common\ai_lookat
    // Params 0
    // Checksum 0x0, Offset: 0x1693
    // Size: 0x92, Type: dev
    function function_ca76b97da22f081b()
    {
        self endon( "<dev string:x11c>" );
        self endon( "<dev string:x125>" );
        setdvarifuninitialized( @"hash_4e640bf30799c32f", 0 );
        
        while ( true )
        {
            waitframe();
            
            if ( getdvarint( @"hash_4e640bf30799c32f", 0 ) )
            {
                debugpos = self.origin + ( 0, 0, 88 );
                
                if ( isdefined( self.lookatstate ) )
                {
                    print3d( debugpos, self.lookatstate, ( 1, 1, 1 ), 1, 0.25 );
                }
            }
        }
    }

#/
