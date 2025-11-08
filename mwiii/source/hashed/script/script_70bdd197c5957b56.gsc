#using script_239a365a92ee4476;
#using script_2f981f68661d5e1a;
#using script_32d93a194074fa6a;
#using script_35ee5e2cef30eea2;
#using script_3f3c7170aedfefd7;
#using script_458ce44388c14a5f;
#using script_45e6947be98e16e3;
#using script_47a7dd805c87b33f;
#using script_4bcf78b337139620;
#using script_5961052449eb875f;
#using script_5dfa1fb6b030bdcb;
#using script_61565a6c1fdee6ac;
#using script_6981400abfcd765c;
#using script_89c4e8e66e8a360;
#using script_b5c3028255f05a7;
#using script_c7a00602fb8e464;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\utility\game;
#using scripts\mp\utility\inventory;
#using scripts\mp\utility\outline;

#namespace namespace_5026cc22a303fab7;

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x2cf
// Size: 0x5d
function function_578b87d7eb32541c()
{
    function_9e0151baa208fe9e( #"hash_5145401edfbf737d" );
    ascenders = function_866b54331a9baec7( self, 2000 );
    self.var_657f5a0d17435bc.var_82caa11345c69977.nearestzipline = function_e09fe43dabd5e4cf( self, ascenders );
    function_b06dec4dbf57b06b();
    childthread function_5c154fbf6a4ff505();
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x334
// Size: 0x15e
function function_5c154fbf6a4ff505()
{
    while ( self.var_657f5a0d17435bc.var_82caa11345c69977.var_3af3cd0524977042 )
    {
        ziplinedistance = distancesquared( self.var_657f5a0d17435bc.var_82caa11345c69977.nearestzipline.origin, self.origin );
        
        if ( ziplinedistance < 10000 && self.var_657f5a0d17435bc.var_82caa11345c69977.waypointactive )
        {
            function_7fd621b8ba80e652();
            function_a1a89aeb095402f2();
            childthread function_9e0151baa208fe9e( #"hash_1ec2183747b3d52e" );
        }
        
        if ( ziplinedistance >= 10000 && ziplinedistance <= 4000000 && !self.var_657f5a0d17435bc.var_82caa11345c69977.waypointactive )
        {
            function_7fd621b8ba80e652();
            function_b06dec4dbf57b06b();
            childthread function_9e0151baa208fe9e( #"hash_5145401edfbf737d" );
        }
        
        if ( ziplinedistance > 9000000 )
        {
            self.var_657f5a0d17435bc.var_82caa11345c69977.var_3af3cd0524977042 = 0;
            function_a1a89aeb095402f2();
            function_f339c5c73d11ea20( #"hash_5145401edfbf737d", 0, level.ftuedata.var_f09f2ffd8a67fe03 );
            self notify( "currentContextualTipAborted" );
        }
        
        waitframe();
    }
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x49a
// Size: 0x95
function function_b06dec4dbf57b06b()
{
    position = self.var_657f5a0d17435bc.var_82caa11345c69977.nearestzipline.origin + ( 0, 0, 15 );
    self.var_657f5a0d17435bc.var_82caa11345c69977.waypoint = function_e5524fb8509827bf( position, &"FTUE_MOBILE/GO_HERE", "icon_waypoint_objective_general", 15, self );
    self.var_657f5a0d17435bc.var_82caa11345c69977.waypointactive = 1;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x537
// Size: 0x45
function function_a1a89aeb095402f2()
{
    function_4d03b9ef456d0972( self.var_657f5a0d17435bc.var_82caa11345c69977.waypoint );
    self.var_657f5a0d17435bc.var_82caa11345c69977.waypointactive = 0;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x584
// Size: 0x82
function function_549535e92d5c8d97()
{
    function_9e0151baa208fe9e( #"hash_8cf6f845e104583d" );
    self.var_657f5a0d17435bc.var_480aa6483c54887.objectiveid = function_e5524fb8509827bf( self.var_657f5a0d17435bc.var_e7cee4fbb5b46ef2.origin, &"FTUE_MOBILE/OPEN", "icon_waypoint_objective_general", 40, self );
    childthread function_dadee81d5ce668bd( &function_549537e92d5c91fd );
    childthread function_cd83759e21f3ff42( &function_549536e92d5c8fca );
    childthread function_96c1d0188650c7a2();
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x60e
// Size: 0x9d
function function_549536e92d5c8fca()
{
    function_4d03b9ef456d0972( self.var_657f5a0d17435bc.var_480aa6483c54887.objectiveid );
    function_f339c5c73d11ea20( #"hash_8cf6f845e104583d", 1, level.ftuedata.var_f09f2ffd8a67fe03 );
    self.var_657f5a0d17435bc.var_480aa6483c54887.var_b6ffaaa84babd1bc = #"hash_570dd05e461590ee";
    childthread function_9e0151baa208fe9e( #"hash_570dd05e461590ee" );
    childthread function_b40f17685dbcc4e6( &function_ee934ee06dde4bf4 );
    childthread function_4bfc467c67d38fe0( &function_cfec8edeb2fc6dd5 );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x6b3
// Size: 0x83
function function_549537e92d5c91fd()
{
    function_f339c5c73d11ea20( self.var_657f5a0d17435bc.var_480aa6483c54887.var_b6ffaaa84babd1bc, 1, level.ftuedata.var_f09f2ffd8a67fe03 );
    self.var_657f5a0d17435bc.var_480aa6483c54887.anypurchase = 1;
    self.var_657f5a0d17435bc.var_480aa6483c54887.var_78c14e981c4a4a62 = 1;
    self notify( "currentContextualTipCompleted" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x73e
// Size: 0x40
function function_cfec8edeb2fc6dd5()
{
    function_7fd621b8ba80e652();
    self.var_657f5a0d17435bc.var_480aa6483c54887.var_b6ffaaa84babd1bc = #"hash_b2359857a05db957";
    function_9e0151baa208fe9e( #"hash_b2359857a05db957" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x786
// Size: 0x30
function function_ee934ee06dde4bf4()
{
    if ( !self.var_657f5a0d17435bc.var_480aa6483c54887.anypurchase )
    {
        function_7fd621b8ba80e652();
        function_549535e92d5c8d97();
    }
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x7be
// Size: 0xd7
function function_96c1d0188650c7a2()
{
    self.var_657f5a0d17435bc.var_480aa6483c54887.var_78c14e981c4a4a62 = 0;
    
    while ( !self.var_657f5a0d17435bc.var_480aa6483c54887.var_78c14e981c4a4a62 )
    {
        dist = distance( self.origin, self.var_657f5a0d17435bc.var_e7cee4fbb5b46ef2.origin );
        
        if ( dist > 1500 )
        {
            self.var_657f5a0d17435bc.var_480aa6483c54887.var_78c14e981c4a4a62 = 1;
            function_4d03b9ef456d0972( self.var_657f5a0d17435bc.var_480aa6483c54887.objectiveid );
            function_7fd621b8ba80e652();
            self notify( "currentContextualTipAborted" );
        }
        
        waitframe();
    }
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x89d
// Size: 0x3, Type: bool
function function_49a922d5b933eb1f()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 1
// Checksum 0x0, Offset: 0x8a9
// Size: 0x6d
function function_79858f3473b63cc5( alive )
{
    if ( alive )
    {
        function_f339c5c73d11ea20( #"hash_bb1f816dd31911f9", 1, level.ftuedata.var_f09f2ffd8a67fe03 );
        self notify( "currentContextualTipCompleted" );
    }
    else
    {
        function_7fd621b8ba80e652();
        self notify( "currentContextualTipAborted" );
    }
    
    self.var_657f5a0d17435bc.var_9daf1075af0426fa.var_3af3cd0524977042 = 0;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x91e
// Size: 0xcf
function function_fa8e7d5852d94142()
{
    var_bb918f79c008801e = 1;
    
    while ( self.var_657f5a0d17435bc.var_9daf1075af0426fa.var_3af3cd0524977042 )
    {
        dist = distance( self.origin, self.var_657f5a0d17435bc.var_9daf1075af0426fa.allydown.origin );
        maxdistance = 3300;
        
        if ( dist > maxdistance && var_bb918f79c008801e )
        {
            function_7fd621b8ba80e652();
            function_9e0151baa208fe9e( #"hash_6f2d59859a7174aa" );
            var_bb918f79c008801e = 0;
        }
        
        if ( dist <= 3000 && !var_bb918f79c008801e )
        {
            function_7fd621b8ba80e652();
            function_9e0151baa208fe9e( #"hash_bb1f816dd31911f9" );
            var_bb918f79c008801e = 1;
        }
        
        waitframe();
    }
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x9f5
// Size: 0x3f
function function_79858e3473b63a92()
{
    function_f339c5c73d11ea20( #"hash_6f2d59859a7174aa", 1, level.ftuedata.var_f09f2ffd8a67fe03 );
    function_9e0151baa208fe9e( #"hash_bb1f816dd31911f9" );
    childthread function_fa8e7d5852d94142();
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0xa3c
// Size: 0xc1
function function_79858d3473b6385f()
{
    function_9e0151baa208fe9e( #"hash_6f2d59859a7174aa" );
    function_f0027ce50e5ef437( &function_79858e3473b63a92 );
    
    foreach ( ally in self.var_ffddba74f404a30 )
    {
        if ( istrue( ally.inlaststand ) )
        {
            self.var_657f5a0d17435bc.var_9daf1075af0426fa.allydown = ally;
        }
    }
    
    function_79ff3ea7e538a94a( self.var_657f5a0d17435bc.var_9daf1075af0426fa.allydown, &function_79858f3473b63cc5 );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0xb05
// Size: 0xa
function function_4f790fe93cb38325()
{
    self notify( "currentContextualTipCompleted" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0xb17
// Size: 0x51
function function_4f790ee93cb380f2()
{
    self endon( "FTUEAbortedTipParachute" );
    childthread function_9e0151baa208fe9e( #"hash_288de16a57a01c2" );
    function_a67db5cf006fc19e( 50, 30 );
    function_f339c5c73d11ea20( #"hash_288de16a57a01c2", 1, level.ftuedata.var_f09f2ffd8a67fe03 );
    function_4f790fe93cb38325();
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0xb70
// Size: 0x35
function function_4f7909e93cb375f3()
{
    function_914e9d5e71cc6efb();
    function_f339c5c73d11ea20( #"hash_e76f36104d89edbb", 1, level.ftuedata.var_f09f2ffd8a67fe03 );
    function_4f790ee93cb380f2();
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0xbad
// Size: 0x3e
function function_4f7908e93cb373c0()
{
    function_f339c5c73d11ea20( #"hash_4288e609a7c5b000", 1, level.ftuedata.var_f09f2ffd8a67fe03 );
    function_9e0151baa208fe9e( #"hash_e76f36104d89edbb" );
    function_4f7909e93cb375f3();
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0xbf3
// Size: 0x1e
function function_4f790be93cb37a59()
{
    function_9e0151baa208fe9e( #"hash_4288e609a7c5b000" );
    function_ba481c5cd3c4f5b4( &function_4f7908e93cb373c0 );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0xc19
// Size: 0x29
function function_abca315d6e0d1a92()
{
    self notify( "waypoint_active" );
    function_9e0151baa208fe9e( #"hash_a0cc0ba4a902563a" );
    childthread function_ec7f69bba0f79ee7( &function_cbb841015b2745f2, 1 );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0xc4a
// Size: 0x25
function function_cbb841015b2745f2()
{
    wait 1;
    self.var_657f5a0d17435bc.var_25d8f562f9f2daa3.var_71aff0f17d48e44b = 1;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0xc77
// Size: 0xcd
function function_28e0fc227558e22d()
{
    if ( !isdefined( self.lootcachesopened ) )
    {
        self.var_657f5a0d17435bc.lootcachesopened = 0;
    }
    else
    {
        self.var_657f5a0d17435bc.lootcachesopened = self.lootcachesopened;
    }
    
    self.var_657f5a0d17435bc.var_bdbb54412eeff8e7 = "lootCrate2Tip";
    self.var_657f5a0d17435bc.var_3bc7a9defa307c4c = "lootCrate1Tip";
    self.var_657f5a0d17435bc.var_ebf862078b683a7a.var_2f8a41afc9ebef12 = function_6fbf6c2055aeee37();
    
    if ( !isdefined( self.var_657f5a0d17435bc.var_ebf862078b683a7a.var_2f8a41afc9ebef12 ) )
    {
        self notify( "currentContextualTipAborted" );
        return 0;
    }
    
    childthread function_fa457bbe0f704b56();
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0xd4c
// Size: 0xa4
function function_fa457bbe0f704b56()
{
    while ( self.var_657f5a0d17435bc.var_ebf862078b683a7a.var_3af3cd0524977042 )
    {
        if ( isdefined( self.var_657f5a0d17435bc.var_ebf862078b683a7a.var_2f8a41afc9ebef12.itemsdropped ) )
        {
            self.var_657f5a0d17435bc.var_ebf862078b683a7a.var_3af3cd0524977042 = 0;
            function_661ea9bd573dd789();
            function_f339c5c73d11ea20( #"hash_56654f7a895c860f", 1, level.ftuedata.var_f09f2ffd8a67fe03 );
            self notify( "currentContextualTipCompleted" );
        }
        
        waitframe();
    }
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0xdf8
// Size: 0x11b
function function_d299302042f1def3()
{
    while ( self.var_657f5a0d17435bc.var_ebf862078b683a7a.var_3af3cd0524977042 )
    {
        var_9bb5914ddafa7f59 = distancesquared( self.var_657f5a0d17435bc.var_ebf862078b683a7a.var_2f8a41afc9ebef12.origin, self.origin );
        
        if ( var_9bb5914ddafa7f59 < 10000 && self.var_657f5a0d17435bc.var_ebf862078b683a7a.waypointactive )
        {
            function_661ea9bd573dd789();
        }
        
        if ( var_9bb5914ddafa7f59 >= 10000 && var_9bb5914ddafa7f59 <= 2250000 && !self.var_657f5a0d17435bc.var_ebf862078b683a7a.waypointactive )
        {
            function_13f06d25094c35de();
        }
        
        if ( var_9bb5914ddafa7f59 > 2250000 )
        {
            self.var_657f5a0d17435bc.var_ebf862078b683a7a.var_3af3cd0524977042 = 0;
            function_661ea9bd573dd789();
            function_f339c5c73d11ea20( #"hash_56654f7a895c860f", 0 );
            self notify( "currentContextualTipAborted" );
        }
        
        waitframe();
    }
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0xf1b
// Size: 0x88
function function_13f06d25094c35de()
{
    self.var_657f5a0d17435bc.var_ebf862078b683a7a.waypointactive = 1;
    self.var_657f5a0d17435bc.var_ebf862078b683a7a.waypoint = function_e5524fb8509827bf( self.var_657f5a0d17435bc.var_ebf862078b683a7a.var_2f8a41afc9ebef12.origin + ( 0, 0, 18 ), &"FTUE_MOBILE/OPEN", "icon_waypoint_objective_general", 15, self );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0xfab
// Size: 0x45
function function_661ea9bd573dd789()
{
    self.var_657f5a0d17435bc.var_ebf862078b683a7a.waypointactive = 0;
    function_4d03b9ef456d0972( self.var_657f5a0d17435bc.var_ebf862078b683a7a.waypoint );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0xff8
// Size: 0x11c
function function_6fbf6c2055aeee37()
{
    var_37eae69752fa4856 = function_f3be9fa4b21eafc2( 1500 );
    var_93bacbf8fe541c21 = undefined;
    var_4525bec79b5d223b = 2250000;
    
    foreach ( lootcrate in var_37eae69752fa4856 )
    {
        if ( isdefined( lootcrate.itemsdropped ) )
        {
            continue;
        }
        
        horizontaldist = distancesquared( ( self.origin[ 0 ], self.origin[ 1 ], 0 ), ( lootcrate.origin[ 0 ], lootcrate.origin[ 1 ], 0 ) );
        verticaldist = distancesquared( ( 0, 0, self.origin[ 2 ] ), ( 0, 0, lootcrate.origin[ 2 ] ) );
        verticaldist *= 2;
        totaldist = horizontaldist + verticaldist;
        
        if ( totaldist < var_4525bec79b5d223b )
        {
            var_4525bec79b5d223b = totaldist;
            var_93bacbf8fe541c21 = lootcrate;
        }
    }
    
    return var_93bacbf8fe541c21;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x111d
// Size: 0x3, Type: bool
function function_76064823fdd76685()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x1129
// Size: 0x3, Type: bool
function function_76064123fdd75720()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x1135
// Size: 0x3f
function function_76064223fdd75953()
{
    self.var_657f5a0d17435bc.var_6d2384744119499a.loadoutopened = 1;
    function_9e0151baa208fe9e( #"hash_d290767b5f9aa9a4" );
    childthread function_43a9b7793648c22a( &function_f5ebdd40dec5a364 );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x117c
// Size: 0x2f
function function_f5ebdd40dec5a364()
{
    function_f339c5c73d11ea20( #"hash_d290767b5f9aa9a4", 1, level.ftuedata.var_f09f2ffd8a67fe03 );
    self notify( "currentContextualTipCompleted" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x11b3
// Size: 0x4d
function function_76064323fdd75b86()
{
    self.var_657f5a0d17435bc.var_6d2384744119499a.loadoutopened = 0;
    function_9e0151baa208fe9e( #"hash_edb81681b796ed6f" );
    function_1c1e99fe9773964f();
    childthread function_4ae36036bf751abe( &function_78e6b7ae51b19e28 );
    childthread function_ebd8e89c3c22fb4f();
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x1208
// Size: 0x2e
function function_78e6b7ae51b19e28()
{
    function_f339c5c73d11ea20( #"hash_72617674e0990935", 1, level.ftuedata.var_f09f2ffd8a67fe03 );
    function_76064223fdd75953();
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x123e
// Size: 0x157
function function_ebd8e89c3c22fb4f()
{
    while ( !self.var_657f5a0d17435bc.var_6d2384744119499a.loadoutopened )
    {
        loadoutdistance = distance( self.var_657f5a0d17435bc.var_495bb1c9678267c7.origin, self.origin );
        
        if ( loadoutdistance < 100 && self.var_657f5a0d17435bc.var_6d2384744119499a.waypointactive )
        {
            self.var_657f5a0d17435bc.var_6d2384744119499a.waypointactive = 0;
            function_7fd621b8ba80e652();
            function_9e0151baa208fe9e( #"hash_72617674e0990935" );
            function_5259ee04dc61ca35();
        }
        
        if ( !self.var_657f5a0d17435bc.var_6d2384744119499a.waypointactive && loadoutdistance >= 100 && loadoutdistance <= 1500 )
        {
            function_7fd621b8ba80e652();
            function_9e0151baa208fe9e( #"hash_edb81681b796ed6f" );
            function_1c1e99fe9773964f();
        }
        
        if ( loadoutdistance > 2000 )
        {
            function_7fd621b8ba80e652();
            function_5259ee04dc61ca35();
            self.var_657f5a0d17435bc.var_6d2384744119499a.loadoutopened = 1;
            self notify( "currentContextualTipAborted" );
        }
        
        waitframe();
    }
    
    function_5259ee04dc61ca35();
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x139d
// Size: 0xaa
function function_1c1e99fe9773964f()
{
    self.var_657f5a0d17435bc.var_6d2384744119499a.waypointactive = 1;
    waypointposition = self.var_657f5a0d17435bc.var_495bb1c9678267c7.origin + ( 0, 0, 67 );
    self.var_657f5a0d17435bc.var_6d2384744119499a.waypoint = function_e5524fb8509827bf( waypointposition, &"FTUE_MOBILE/OPEN", "icon_waypoint_objective_general", 10, self );
    self.var_657f5a0d17435bc.var_495bb1c9678267c7 hudoutlineenableforclient( self, "outline_ftue_touch_yellow" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x144f
// Size: 0x40
function function_5259ee04dc61ca35()
{
    self.var_657f5a0d17435bc.var_495bb1c9678267c7 hudoutlinedisableforclient( self );
    function_4d03b9ef456d0972( self.var_657f5a0d17435bc.var_6d2384744119499a.waypoint );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x1497
// Size: 0x51
function function_683a9cf72e77d5bf()
{
    function_9e0151baa208fe9e( #"hash_612572faef529442" );
    self.var_657f5a0d17435bc.var_108d73ddf65aa72c.var_78f9776e5d16bcfb = #"hash_612572faef529442";
    childthread function_59ded31f4834f8de( &function_683a9df72e77d7f2 );
    childthread function_7fdf3cf66304f3c5( self, 45 );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x14f0
// Size: 0x79
function function_683a9df72e77d7f2()
{
    function_f339c5c73d11ea20( #"hash_612572faef529442", 1, level.ftuedata.var_f09f2ffd8a67fe03 );
    childthread function_9e0151baa208fe9e( #"inventorysystem2tip" );
    self.var_657f5a0d17435bc.var_108d73ddf65aa72c.var_78f9776e5d16bcfb = #"inventorysystem2tip";
    childthread function_7d664ce89c1009ca( &function_6db7fc623e2239c2 );
    childthread function_bd09b7d6832880c4( &function_1954c3f1618972d5 );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 4
// Checksum 0x0, Offset: 0x1571
// Size: 0x50
function function_1954c3f1618972d5( var_eb124d17b9cf50b7, itemtypedropped, itemindexdropped, fulldrop )
{
    function_f339c5c73d11ea20( #"inventorysystem2tip", 1, level.ftuedata.var_f09f2ffd8a67fe03 );
    self notify( "currentContextualTipCompleted" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x15c9
// Size: 0x4a
function function_6db7fc623e2239c2()
{
    if ( !self.var_657f5a0d17435bc.completed[ "inventorySystem2Tip" ] )
    {
        function_f339c5c73d11ea20( #"inventorysystem2tip", 0, level.ftuedata.var_f09f2ffd8a67fe03 );
        self notify( "currentContextualTipAborted" );
    }
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x161b
// Size: 0x3b
function function_7fa70c0fd64f5a06()
{
    childthread function_4557767cdfd3dc52();
    var_744254a0a817ff39 = spawnstruct();
    var_744254a0a817ff39.duration = 5;
    childthread function_9e0151baa208fe9e( #"hash_a5c87b6f59b63618", var_744254a0a817ff39 );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x165e
// Size: 0x61
function function_4557767cdfd3dc52()
{
    foreach ( ally in self.var_ffddba74f404a30 )
    {
        outlineenableforplayer( ally, self, "outline_ftue_touch_bots_green", "top" );
    }
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x16c7
// Size: 0x11
function function_ede2f98d54ae4ffe()
{
    function_7fd621b8ba80e652();
    self notify( "currentContextualTipAborted" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x16e0
// Size: 0xa
function function_af141ad10d4457ef()
{
    self notify( "currentContextualTipCompleted" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 1
// Checksum 0x0, Offset: 0x16f2
// Size: 0x36
function function_af1417d10d445156( haswon )
{
    function_f339c5c73d11ea20( #"hash_9fcffddd63d54838", haswon, level.ftuedata.var_f09f2ffd8a67fe03 );
    function_af141ad10d4457ef();
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x1730
// Size: 0xa1
function function_af1418d10d445389()
{
    if ( !istrue( self.var_657f5a0d17435bc.var_dba7867b4e133164 ) )
    {
        function_f339c5c73d11ea20( #"hash_db8d0de856c06433", 1, level.ftuedata.var_f09f2ffd8a67fe03 );
    }
    
    var_744254a0a817ff39 = spawnstruct();
    var_744254a0a817ff39.duration = 3;
    function_9e0151baa208fe9e( #"hash_9fcffddd63d54838", var_744254a0a817ff39 );
    self.var_657f5a0d17435bc.var_f028b7eee8d5ac0d.var_78f9776e5d16bcfb = #"hash_9fcffddd63d54838";
    function_8efd0509e8d63ca9( &function_af1417d10d445156 );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x17d9
// Size: 0x74, Type: bool
function function_af1415d10d444cf0()
{
    if ( istrue( self.var_657f5a0d17435bc.var_dba7867b4e133164 ) )
    {
        function_af1418d10d445389();
    }
    else
    {
        function_9e0151baa208fe9e( #"hash_db8d0de856c06433" );
        self.var_657f5a0d17435bc.var_f028b7eee8d5ac0d.var_78f9776e5d16bcfb = #"hash_db8d0de856c06433";
        childthread function_88b1ad5e2a6d9e6d( &function_ede2f98d54ae4ffe );
        function_b3e2a55102596658( &function_af1418d10d445389 );
    }
    
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x1856
// Size: 0x11
function function_6e076951711f3f0d()
{
    function_7fd621b8ba80e652();
    self notify( "currentContextualTipCompleted" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x186f
// Size: 0x3f
function function_6e076851711f3cda()
{
    pausecircle( 0 );
    function_f339c5c73d11ea20( #"hash_efd3ad9a60c678a0", 1, level.ftuedata.var_f09f2ffd8a67fe03 );
    function_9e0151baa208fe9e( #"hash_94b8fda10689035b" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x18b6
// Size: 0x35
function function_6e076751711f3aa7()
{
    function_9e0151baa208fe9e( #"hash_efd3ad9a60c678a0" );
    pausecircle( 1 );
    childthread function_331e465c203522e0( &function_6e076851711f3cda );
    childthread function_506621f96f8313a5( &function_6e076951711f3f0d );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x18f3
// Size: 0x3b
function function_a678411ce9a6f9ea()
{
    var_744254a0a817ff39 = spawnstruct();
    var_744254a0a817ff39.duration = 3;
    function_9e0151baa208fe9e( #"hash_a5b5f1a8929ba9d3", var_744254a0a817ff39 );
    waitframe();
    self notify( "currentContextualTipCompleted" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x1936
// Size: 0x30
function function_605b756ff40f6aa8()
{
    waitframe();
    function_f339c5c73d11ea20( #"hash_4a4caa71da6050d7", 1, level.ftuedata.var_f09f2ffd8a67fe03 );
    self notify( "currentContextualTipCompleted" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x196e
// Size: 0x2b
function function_605b786ff40f7141()
{
    childthread function_9e0151baa208fe9e( #"hash_4a4caa71da6050d7" );
    childthread function_9b8f4317c9bee442( &function_605b756ff40f6aa8 );
    childthread function_7fdf3cf66304f3c5( self, 30 );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x19a1
// Size: 0x2f
function function_d98f4306380ee473()
{
    function_f339c5c73d11ea20( #"hash_2ac4de9747a9637a", 1, level.ftuedata.var_f09f2ffd8a67fe03 );
    self notify( "currentContextualTipCompleted" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x19d8
// Size: 0x1e
function function_d98f4406380ee6a6()
{
    function_9e0151baa208fe9e( #"hash_2ac4de9747a9637a" );
    function_c3ff6825172b7e02( &function_d98f4306380ee473 );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x19fe
// Size: 0x114
function executecash()
{
    if ( !self.var_657f5a0d17435bc.var_9fd058151789294e.var_977a0264ee6a021b )
    {
        self.var_657f5a0d17435bc.var_9fd058151789294e.waypointposition = drop_to_ground( self.var_657f5a0d17435bc.var_9fd058151789294e.closedcash.origin, 100 ) + ( 0, 0, 1 );
        self.var_657f5a0d17435bc.var_9fd058151789294e.waypoint = function_e5524fb8509827bf( self.var_657f5a0d17435bc.var_9fd058151789294e.waypointposition, &"FTUE_MOBILE/PICK_UP", "icon_waypoint_objective_general", 15, self, 1 );
        function_9e0151baa208fe9e( #"cashtip" );
        self.var_657f5a0d17435bc.var_9fd058151789294e.cashpicked = 0;
        childthread function_72c1ec67d589d251( &function_734a3ce54e168099 );
        return;
    }
    
    self notify( "currentContextualTipAborted" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x1b1a
// Size: 0x22
function function_734a3ce54e168099()
{
    self.var_657f5a0d17435bc.var_9fd058151789294e.cashpicked = 1;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x1b44
// Size: 0xf6
function function_5e5de51cbcc60dc()
{
    self endon( "currentContextualTipAborted" );
    var_f3da6461821c0212 = 1;
    var_14c4829f9474851d = 0;
    dangercircleradius = level.br_circle.dangercircleent.origin[ 2 ];
    var_2e12ff7e544d85f7 = 2000;
    var_a0b221200d114e38 = dangercircleradius * 0.25;
    
    if ( var_2e12ff7e544d85f7 > var_a0b221200d114e38 )
    {
        var_2e12ff7e544d85f7 = var_a0b221200d114e38;
    }
    
    while ( !var_14c4829f9474851d )
    {
        if ( function_725b52f601c21a7a( var_2e12ff7e544d85f7, 100 ) && var_f3da6461821c0212 )
        {
            function_7fd621b8ba80e652();
            var_f3da6461821c0212 = 0;
            childthread function_9e0151baa208fe9e( #"hash_50bcbc77a76ce45c" );
        }
        
        if ( function_725b52f601c21a7a( -1, -200 ) && !var_f3da6461821c0212 )
        {
            function_7fd621b8ba80e652();
            var_f3da6461821c0212 = 1;
            childthread function_9e0151baa208fe9e( #"hash_16387c82e81ffa47" );
        }
        
        if ( function_725b52f601c21a7a( 3000, var_2e12ff7e544d85f7 ) )
        {
            childthread function_7fd621b8ba80e652();
            var_14c4829f9474851d = 1;
            self notify( "currentContextualTipCompleted" );
        }
        
        waitframe();
    }
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x1c42
// Size: 0xa
function function_5e5e151cbcc6775()
{
    childthread function_5e5de51cbcc60dc();
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x1c54
// Size: 0xe4
function function_c5ea332184e0a3e8()
{
    childthread namespace_91fad7208d9cd856::function_64f6dbf96d0e6f81();
    self endon( "currentContextualTipCompleted" );
    self endon( "currentContextualTipAborted" );
    
    if ( !namespace_ba266451167c225d::function_43c47cf181121e3() )
    {
        self.var_657f5a0d17435bc.var_40834c928484edfb.var_654c850c2646f8e0 = 1;
        childthread function_9e0151baa208fe9e( #"hash_e09e5ff38edd2e81" );
        namespace_91fad7208d9cd856::function_7618f4372cdd1ce();
        currentwaittime = 0;
        
        while ( currentwaittime <= 120 )
        {
            if ( namespace_ba266451167c225d::function_43c47cf181121e3() )
            {
                function_f339c5c73d11ea20( #"hash_e09e5ff38edd2e81", 1, level.ftuedata.var_f09f2ffd8a67fe03 );
                childthread function_c5ea362184e0aa81();
                break;
            }
            else
            {
                currentwaittime++;
            }
            
            wait 1;
        }
        
        if ( currentwaittime >= 120 )
        {
            namespace_91fad7208d9cd856::function_3ff2b2e0317f4686();
            function_f339c5c73d11ea20( #"hash_e09e5ff38edd2e81", 0 );
            self notify( "currentContextualTipAborted" );
        }
        
        return;
    }
    
    childthread function_c5ea362184e0aa81();
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x1d40
// Size: 0x7a
function function_c5ea362184e0aa81()
{
    self endon( "redeployAlly_3" );
    self endon( "currentContextualTipCompleted" );
    self endon( "currentContextualTipAborted" );
    childthread function_9e0151baa208fe9e( #"hash_ab21380bf4498612" );
    childthread namespace_91fad7208d9cd856::function_59299228aa688748();
    childthread function_cd83759e21f3ff42( &function_c5ea352184e0a84e );
    currentwaittime = 0;
    
    while ( currentwaittime <= 120 )
    {
        currentwaittime++;
        wait 1;
    }
    
    namespace_91fad7208d9cd856::function_66ee5612ecdfbac6();
    function_f339c5c73d11ea20( #"hash_ab21380bf4498612", 0 );
    self notify( "currentContextualTipAborted" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x1dc2
// Size: 0x72
function function_c5ea352184e0a84e()
{
    self notify( "redeployAlly_3" );
    namespace_91fad7208d9cd856::function_66ee5612ecdfbac6();
    function_f339c5c73d11ea20( #"hash_ab21380bf4498612", 1, level.ftuedata.var_f09f2ffd8a67fe03 );
    function_9e0151baa208fe9e( #"hash_e5b29000b3a1234b" );
    childthread function_dadee81d5ce668bd( &function_9ba4efe4f079799, "airdrop" );
    childthread function_dadee81d5ce668bd( &function_aa05b333b0355a6 );
    childthread function_b40f17685dbcc4e6( &function_e13c98cc4be85c6c );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x1e3c
// Size: 0x4f
function function_9ba4efe4f079799()
{
    self.var_657f5a0d17435bc.var_40834c928484edfb.var_55d2955394d9da6f = 1;
    self notify( "currentContextualTipCompleted" );
    function_f339c5c73d11ea20( #"hash_e5b29000b3a1234b", 1, level.ftuedata.var_f09f2ffd8a67fe03 );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x1e93
// Size: 0x93
function function_aa05b333b0355a6()
{
    self.var_657f5a0d17435bc.var_40834c928484edfb.anypurchase = 1;
    wait 0.5;
    
    if ( !self.var_657f5a0d17435bc.var_40834c928484edfb.var_55d2955394d9da6f )
    {
        if ( !self.var_657f5a0d17435bc.var_40834c928484edfb.var_654c850c2646f8e0 )
        {
            function_7fd621b8ba80e652();
            childthread function_c5ea332184e0a3e8();
            return;
        }
        
        function_f339c5c73d11ea20( #"hash_e5b29000b3a1234b", 0 );
        self notify( "currentContextualTipAborted" );
    }
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x1f2e
// Size: 0x66
function function_e13c98cc4be85c6c()
{
    self endon( "currentContextualTipAborted" );
    self endon( "currentContextualTipCompleted" );
    wait 0.5;
    
    if ( !self.var_657f5a0d17435bc.var_40834c928484edfb.var_55d2955394d9da6f && !self.var_657f5a0d17435bc.var_40834c928484edfb.anypurchase )
    {
        function_7fd621b8ba80e652();
        function_c5ea362184e0aa81();
    }
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x1f9c
// Size: 0x113
function executeswitchweapon()
{
    childthread namespace_91fad7208d9cd856::function_962a086325a6ebcc();
    firstprimaryweapon = getfirstprimaryweapon();
    self.var_657f5a0d17435bc.var_cd0ce7cfecde4c03.firstweapon = self getcurrentprimaryweapon();
    
    if ( firstprimaryweapon.basename == self.var_657f5a0d17435bc.var_cd0ce7cfecde4c03.firstweapon.basename )
    {
        self.var_657f5a0d17435bc.var_cd0ce7cfecde4c03.var_78f9776e5d16bcfb = #"hash_77d61ce6efc11661";
    }
    else
    {
        self.var_657f5a0d17435bc.var_cd0ce7cfecde4c03.var_78f9776e5d16bcfb = #"hash_ebd4f5043d2dcbf2";
    }
    
    function_9e0151baa208fe9e( self.var_657f5a0d17435bc.var_cd0ce7cfecde4c03.var_78f9776e5d16bcfb );
    childthread function_7fdf3cf66304f3c5( self, 20, self.var_657f5a0d17435bc.var_cd0ce7cfecde4c03.var_78f9776e5d16bcfb );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x20b7
// Size: 0x33
function function_ae5757fdad4729b8()
{
    function_9e0151baa208fe9e( #"hash_f2222fe44741673c" );
    childthread function_fc9d282d9afeec03();
    childthread function_7fdf3cf66304f3c5( self, getdvarint( @"hash_954866cda5724c", 45 ) );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x20f2
// Size: 0x39
function function_fc9d282d9afeec03()
{
    while ( true )
    {
        self waittill( "luinotifyserver", channel );
        
        if ( isdefined( channel ) && channel == "ftue_tips_disabled" )
        {
            self notify( "currentContextualTipCompleted" );
            break;
        }
    }
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x2133
// Size: 0x3, Type: bool
function function_51221897a20c4cd0()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x213f
// Size: 0x42
function function_3197c7ae9b533b7a()
{
    function_f339c5c73d11ea20( self.var_657f5a0d17435bc.var_f028b7eee8d5ac0d.var_78f9776e5d16bcfb, 0, level.ftuedata.var_f09f2ffd8a67fe03 );
    self notify( "currentContextualTipAborted" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x2189
// Size: 0x11
function function_390588110ddad141()
{
    self notify( "FTUEAbortedTipParachute" );
    namespace_91fad7208d9cd856::function_5ebbaba0d200b31();
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x21a2
// Size: 0x3, Type: bool
function function_eeb8aa7d0df4f4ac()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x21ae
// Size: 0x3, Type: bool
function function_eeb8ad7d0df4fb45()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x21ba
// Size: 0x3, Type: bool
function function_84e2f790050bd9cb()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x21c6
// Size: 0x3, Type: bool
function function_918c5ab6e5d63b1e()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x21d2
// Size: 0x3, Type: bool
function function_918c59b6e5d638eb()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x21de
// Size: 0x3, Type: bool
function function_2386fbec5e1ca175()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x21ea
// Size: 0x3, Type: bool
function function_2386f8ec5e1c9adc()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x21f6
// Size: 0x3, Type: bool
function function_91f8e694098031e8()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x2202
// Size: 0x3, Type: bool
function function_2dd522f4e3055cc7()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x220e
// Size: 0x3, Type: bool
function function_aa84fb15f18ef8d()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x221a
// Size: 0x3, Type: bool
function function_144b9f4ec7316632()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x2226
// Size: 0x3, Type: bool
function function_389f36df89442c4f()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x2232
// Size: 0x3, Type: bool
function function_3ab35f644c83fe44()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x223e
// Size: 0x3, Type: bool
function function_6e9877da3497be33()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x224a
// Size: 0x3, Type: bool
function function_32a1b6e53b39b557()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x2256
// Size: 0x3, Type: bool
function function_fc79c8376f59bf78()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x2262
// Size: 0x3, Type: bool
function function_6440647b22203967()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x226e
// Size: 0x11
function function_6440657b22203b9a()
{
    function_7fd621b8ba80e652();
    self notify( "currentContextualTipAborted" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x2287
// Size: 0x3, Type: bool
function function_abb1b1e76e6d3c20()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x2293
// Size: 0x3, Type: bool
function function_8e4ce4303149d181()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x229f
// Size: 0x6f
function endlootenemybycond1()
{
    childthread namespace_91fad7208d9cd856::function_6d7761e5ee79ee04( level.var_305547d6de59eba4.var_2f72209eba1e0b19, 0 );
    function_4d03b9ef456d0972( self.var_657f5a0d17435bc.var_25d8f562f9f2daa3.waypoint );
    function_f339c5c73d11ea20( #"hash_a0cc0ba4a902563a", 1, level.ftuedata.var_f09f2ffd8a67fe03 );
    self notify( "currentContextualTipCompleted" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x2316
// Size: 0x51
function function_b340dd5a8c093af1()
{
    childthread namespace_91fad7208d9cd856::function_6d7761e5ee79ee04( level.var_305547d6de59eba4.var_2f72209eba1e0b19, 0 );
    function_4d03b9ef456d0972( self.var_657f5a0d17435bc.var_25d8f562f9f2daa3.waypoint );
    function_7fd621b8ba80e652();
    self notify( "currentContextualTipAborted" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x236f
// Size: 0x3, Type: bool
function function_b872aff17393df33()
{
    return false;
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x237b
// Size: 0x36
function function_4a531c5ba156e6b()
{
    function_fd8c7c643982ffe3();
    function_f339c5c73d11ea20( #"cashtip", 1, level.ftuedata.var_f09f2ffd8a67fe03 );
    self notify( "currentContextualTipCompleted" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x23b9
// Size: 0x18
function function_4a532c5ba15709e()
{
    function_fd8c7c643982ffe3();
    function_7fd621b8ba80e652();
    self notify( "currentContextualTipAborted" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x23d9
// Size: 0x42
function function_fd8c7c643982ffe3()
{
    function_4d03b9ef456d0972( self.var_657f5a0d17435bc.var_9fd058151789294e.waypoint );
    childthread namespace_91fad7208d9cd856::function_6d7761e5ee79ee04( level.var_305547d6de59eba4.var_2f72209eba1e0b19, 0 );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x2423
// Size: 0x55
function function_1873c2c76f8cf9ba()
{
    function_f339c5c73d11ea20( #"hash_1ec2183747b3d52e", 1, level.ftuedata.var_f09f2ffd8a67fe03 );
    self.var_657f5a0d17435bc.var_82caa11345c69977.var_3af3cd0524977042 = 0;
    function_a1a89aeb095402f2();
    self notify( "currentContextualTipCompleted" );
}

// Namespace namespace_5026cc22a303fab7 / namespace_88945a6f395620be
// Params 0
// Checksum 0x0, Offset: 0x2480
// Size: 0x43
function function_34eca3f4488832d6()
{
    function_f339c5c73d11ea20( self.var_657f5a0d17435bc.var_cd0ce7cfecde4c03.var_78f9776e5d16bcfb, 1, level.ftuedata.var_f09f2ffd8a67fe03 );
    self notify( "currentContextualTipCompleted" );
}

