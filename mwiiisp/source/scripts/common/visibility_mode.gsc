#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace visibility_mode;

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 1
// Checksum 0x0, Offset: 0x4b1
// Size: 0x15
function main( funcsarray )
{
    level thread visibilitymode_start( funcsarray );
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4ce
// Size: 0x109
function private visibilitymode_start( funcsarray )
{
    var_36256eeb4f76a38c = getdvar( @"hash_33a01af682caae50", 0 );
    setdvarifuninitialized( @"hash_33a01af682caae50", var_36256eeb4f76a38c );
    
    if ( getdvarint( @"hash_33a01af682caae50", -1 ) <= 0 )
    {
        return;
    }
    
    level.visibilitymode = spawnstruct();
    level.visibilitymode.activeclients = [];
    level.visibilitymode.funcs = [];
    
    if ( isfunction( funcsarray ) )
    {
        funcsarray = [[ funcsarray ]]();
    }
    
    foreach ( func in funcsarray )
    {
        level.visibilitymode.funcs[ index ] = func;
    }
    
    if ( !istrue( checkshouldrun() ) )
    {
        return;
    }
    
    level thread function_9d4b2121c099b285();
    
    /#
        level thread function_8977a3724ec5ce9e();
    #/
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x5df
// Size: 0x3d
function private checkshouldrun()
{
    if ( isdefined( level.visibilitymode.funcs[ "shouldRun" ] ) )
    {
        return level [[ level.visibilitymode.funcs[ "shouldRun" ] ]]();
    }
    
    return 0;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x625
// Size: 0x143
function private function_9d4b2121c099b285()
{
    level endon( "game_ended" );
    
    if ( isdefined( level.visibilitymode.funcs[ "init" ] ) )
    {
        level [[ level.visibilitymode.funcs[ "init" ] ]]();
    }
    
    level childthread [[ level.visibilitymode.funcs[ "checkForDataUpdates" ] ]]();
    
    while ( true )
    {
        level waittill( "visibilityModeValUpdatedForPlayer", player, val );
        level.visibilitymode.activeclients = function_c1d9fd48eb09c8c9();
        
        if ( level.visibilitymode.activeclients.size == 0 )
        {
            continue;
        }
        
        for ( index = 0; index < level.visibilitymode.activeclients.size ; index++ )
        {
            if ( isdefined( level.visibilitymode.activeclients[ index ] ) && !isdefined( level.visibilitymode.activeclients[ index ].var_ada3f21a8212c26f ) )
            {
                level thread function_c3ae50f84a8329ac( level.visibilitymode.activeclients[ index ] );
            }
        }
    }
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x770
// Size: 0xbd, Type: bool
function private function_afe539c207a6b2fb( firstplayer, secondplayer )
{
    if ( issp() )
    {
        return ( firstplayer.team == "axis" );
    }
    
    if ( !isdefined( firstplayer ) || !isdefined( secondplayer ) )
    {
        return false;
    }
    
    if ( !isdefined( firstplayer.team ) || !isdefined( secondplayer.team ) )
    {
        return false;
    }
    
    if ( firstplayer.team == "civilian" || secondplayer.team == "civilian" )
    {
        return false;
    }
    
    if ( level.teambased )
    {
        sameteam = firstplayer.team == secondplayer.team;
        return !sameteam;
    }
    
    return firstplayer != secondplayer;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x836
// Size: 0x21, Type: bool
function private function_753e2e2a70ae2d65( ent )
{
    return isalive( ent ) || istrue( ent.visibilitymode_forced );
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x860
// Size: 0x142
function private function_c3ae50f84a8329ac( client )
{
    client endon( "disconnect" );
    client.var_ada3f21a8212c26f = 1;
    playernum = client getentitynumber();
    client childthread function_40353363f8512bb0();
    client thread function_924634e910fbfc75();
    
    while ( client function_5f46cf1503a0541a() )
    {
        wait 0.5;
        
        if ( !client function_5f46cf1503a0541a() )
        {
            break;
        }
        
        if ( !isalive( client ) )
        {
            continue;
        }
        
        active_targets = [[ level.visibilitymode.funcs[ "getTargetArray" ] ]]( client );
        active_targets = array_combine( active_targets, level.visibilitymode.forced_ents );
        
        for ( i = 0; i < active_targets.size ; i++ )
        {
            if ( active_targets[ i ] == client )
            {
                continue;
            }
            
            if ( !function_753e2e2a70ae2d65( active_targets[ i ] ) )
            {
                continue;
            }
            
            if ( active_targets[ i ] function_3359e7308038233e( client ) )
            {
                continue;
            }
            
            if ( isdefined( active_targets[ i ].visibilitymode_outlineids ) )
            {
                if ( isdefined( active_targets[ i ].visibilitymode_outlineids[ playernum ] ) )
                {
                    continue;
                }
            }
            
            if ( isdefined( active_targets[ i ] ) )
            {
                active_targets[ i ] thread function_8419f0f3143cdcfa( client );
            }
        }
    }
    
    client.var_ada3f21a8212c26f = undefined;
    client notify( "visibiltyMode_disabled" );
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x9aa
// Size: 0x163
function private function_8419f0f3143cdcfa( client )
{
    if ( istrue( self.var_533e1f58c82c7473 ) )
    {
        return;
    }
    
    playernum = client getentitynumber();
    
    if ( isdefined( self.visibilitymode_outlineids ) )
    {
        if ( isdefined( self.visibilitymode_outlineids[ playernum ] ) )
        {
            return;
        }
    }
    
    if ( !isdefined( self.team ) )
    {
        return;
    }
    
    var_517520758f9c478f = client function_266da5d877397673();
    
    if ( function_afe539c207a6b2fb( self, client ) )
    {
        if ( var_517520758f9c478f == "alliesonly" )
        {
            return;
        }
        
        self.visibilitymode_outline = client function_ea4e39208c784a4a();
    }
    else if ( isplayer( self ) )
    {
        if ( var_517520758f9c478f == "enemiesonly" )
        {
            return;
        }
        
        self.visibilitymode_outline = client function_63a1833b6a352cd7();
    }
    else
    {
        if ( var_517520758f9c478f == "enemiesonly" )
        {
            return;
        }
        
        self.visibilitymode_outline = client function_4448756918b98e87();
    }
    
    enablefunc = level.visibilitymode.funcs[ "enableForClient" ];
    
    if ( !isdefined( self.visibilitymode_outlineids ) )
    {
        self.visibilitymode_outlineids = [];
    }
    
    id = self [[ enablefunc ]]( client, self.visibilitymode_outline, "lowest" );
    clientnum = client getentitynumber();
    self.visibilitymode_outlineids[ clientnum ] = id;
    thread visibilitymode_disableoutlineoncallback( client );
    thread visibilitymode_disableoutlineondeath();
    thread visibilitymode_disableonsmokeocclude( client );
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xb15
// Size: 0xea
function private visibilitymode_disableoutlineondeath()
{
    level endon( "game_ended" );
    self notify( "visibilityMode_disableOutlineOnDeath" );
    self endon( "visibilityMode_disableOutlineOnDeath" );
    outlineids = [];
    
    foreach ( id in self.visibilitymode_outlineids )
    {
        outlineids[ outlineids.size ] = id;
    }
    
    self waittill( "death_or_disconnect" );
    
    foreach ( id in outlineids )
    {
        if ( isdefined( id ) )
        {
            self [[ level.visibilitymode.funcs[ "disable" ] ]]( id );
        }
    }
    
    self.visibilitymode_outline = undefined;
    self.visibilitymode_outlineids = undefined;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xc07
// Size: 0xe5
function private visibilitymode_disableoutlineoncallback( client )
{
    self endon( "death" );
    client endon( "disconnect" );
    
    if ( isplayer( self ) )
    {
        self endon( "disconnect" );
    }
    
    clientnum = client getentitynumber();
    self notify( "visibilityMode_disableOutlineOnCallback_" + clientnum );
    self endon( "visibilityMode_disableOutlineOnCallback_" + clientnum );
    oldvalue = client.visibilitymodeval;
    
    for ( var_26d30630ea0383c3 = client.var_5615f87228f360c8; true ; var_26d30630ea0383c3 = client.var_5615f87228f360c8 )
    {
        client waittill( "visibilityModeVal", val, outlineval );
        
        if ( isdefined( val ) && val == 0 )
        {
            break;
        }
        
        if ( val != oldvalue || outlineval != var_26d30630ea0383c3 )
        {
            function_85e0f20ba385bf6d( client );
        }
        
        oldvalue = client.visibilitymodeval;
    }
    
    function_6b814eafddccdd4d( client );
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xcf4
// Size: 0xa7
function private function_6b814eafddccdd4d( client )
{
    if ( !isdefined( self.visibilitymode_outlineids ) )
    {
        return;
    }
    
    foreach ( playernum, id in self.visibilitymode_outlineids )
    {
        clientnum = client getentitynumber();
        
        if ( clientnum == playernum )
        {
            if ( isdefined( id ) )
            {
                self [[ level.visibilitymode.funcs[ "disable" ] ]]( id );
                self.visibilitymode_outlineids[ playernum ] = undefined;
            }
        }
    }
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xda3
// Size: 0x1c
function private function_85e0f20ba385bf6d( client )
{
    function_6b814eafddccdd4d( client );
    thread function_8419f0f3143cdcfa( client );
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xdc7
// Size: 0xb3
function private visibilitymode_disableonsmokeocclude( client )
{
    if ( !isdefined( level.visibilitymode.funcs[ "outlineOccluded" ] ) )
    {
        return;
    }
    
    clientnum = client getentitynumber();
    self notify( "visibilityMode_disableOnsmokeOcclude_" + clientnum );
    self endon( "visibilityMode_disableOnsmokeOcclude_" + clientnum );
    self endon( "death_or_disconnect" );
    client endon( "disconnect" );
    client endon( "visibiltyMode_disabled" );
    
    while ( true )
    {
        wait 0.5;
        
        if ( !within_fov( client.origin, client.angles, self.origin, 0.766 ) )
        {
            continue;
        }
        
        if ( function_3359e7308038233e( client ) )
        {
            function_6b814eafddccdd4d( client );
            return;
        }
    }
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xe82
// Size: 0xee, Type: bool
function private function_3359e7308038233e( client )
{
    if ( !isdefined( level.visibilitymode.funcs[ "outlineOccluded" ] ) )
    {
        return false;
    }
    
    self_eye = undefined;
    
    if ( issentient( self ) )
    {
        self_eye = self geteye();
    }
    else if ( istrue( self.visibilitymode_forced ) )
    {
        if ( self tagexists( "TAG_EYE" ) )
        {
            self_eye = self gettagorigin( "TAG_EYE" );
        }
        else if ( self tagexists( "TAG_HEAD" ) )
        {
            self_eye = self gettagorigin( "TAG_HEAD" );
        }
        else
        {
            midpoint = function_abf76cc289cf03a3( self.model );
            self_eye = self.origin + ( 0, 0, midpoint[ 2 ] * 2 );
        }
    }
    
    if ( [[ level.visibilitymode.funcs[ "outlineOccluded" ] ]]( client geteye(), self_eye ) )
    {
        return true;
    }
    
    return false;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 2
// Checksum 0x0, Offset: 0xf79
// Size: 0x10a
function visibilitymode_unpackvalue( invalue, outlinevalue )
{
    println( "<dev string:x1c>" + invalue );
    unpackdata = spawnstruct();
    unpackdata.currentvalue = invalue;
    unpackdata.outlinevalue = outlinevalue;
    unpackdata.controllerindex = 0;
    unpackdata.vismode = "normal";
    unpackdata.playercolor = "green";
    unpackdata.npccolor = "blue";
    unpackdata.enemycolor = "red";
    unpackdata.adsconfirm = 0;
    unpackdata = function_f3239764175224da( unpackdata );
    unpackdata = function_70cde4aff892c728( unpackdata );
    unpackdata = function_3b372246c79c0658( unpackdata );
    unpackdata = function_d7ed7d211a79ceb3( unpackdata );
    unpackdata = function_93260fadbd47622b( unpackdata );
    self.var_be1e6d7ff9628b76 = unpackdata;
    self.visibilitymodeval = invalue;
    self.var_5615f87228f360c8 = outlinevalue;
    self notify( "visibilityModeVal", invalue, outlinevalue );
    level notify( "visibilityModeValUpdatedForPlayer", self, invalue );
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x108b
// Size: 0x67
function private function_f3239764175224da( data )
{
    if ( data.currentvalue >= 3 )
    {
        data.vismode = "alliesonly";
    }
    else if ( data.currentvalue >= 2 )
    {
        data.vismode = "enemiesonly";
    }
    else
    {
        data.vismode = "normal";
    }
    
    return data;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x10fb
// Size: 0x18f
function private function_70cde4aff892c728( data )
{
    if ( isdefined( data.outlinevalue ) && data.outlinevalue == 0 )
    {
        data.currentvalue -= 0;
        data.playercolor = "outlinefill_depth_green";
    }
    else if ( isdefined( data.outlinevalue ) && data.outlinevalue == 1 )
    {
        data.currentvalue -= 64;
        data.playercolor = "outline_highvis_green";
    }
    else if ( data.currentvalue >= 192 )
    {
        data.currentvalue -= 192;
        data.playercolor = "outline_depth_white";
    }
    else if ( data.currentvalue >= 128 )
    {
        data.currentvalue -= 128;
        data.playercolor = "outlinefill_depth_white";
    }
    else if ( data.currentvalue >= 64 )
    {
        data.currentvalue -= 64;
        data.playercolor = "outline_highvis_green";
    }
    else
    {
        data.currentvalue -= 0;
        data.playercolor = "outlinefill_depth_green";
    }
    
    return data;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1293
// Size: 0x18f
function private function_3b372246c79c0658( data )
{
    if ( isdefined( data.outlinevalue ) && data.outlinevalue == 0 )
    {
        data.currentvalue -= 0;
        data.npccolor = "outlinefill_depth_cyan";
    }
    else if ( isdefined( data.outlinevalue ) && data.outlinevalue == 1 )
    {
        data.currentvalue -= 16;
        data.npccolor = "outline_depth_cyan";
    }
    else if ( data.currentvalue >= 48 )
    {
        data.currentvalue -= 48;
        data.npccolor = "outline_depth_green";
    }
    else if ( data.currentvalue >= 32 )
    {
        data.currentvalue -= 32;
        data.npccolor = "outlinefill_depth_green";
    }
    else if ( data.currentvalue >= 16 )
    {
        data.currentvalue -= 16;
        data.npccolor = "outline_depth_cyan";
    }
    else
    {
        data.currentvalue -= 0;
        data.npccolor = "outlinefill_depth_cyan";
    }
    
    return data;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x142b
// Size: 0x18f
function private function_d7ed7d211a79ceb3( data )
{
    if ( isdefined( data.outlinevalue ) && data.outlinevalue == 0 )
    {
        data.currentvalue -= 0;
        data.enemycolor = "outlinefill_depth_red";
    }
    else if ( isdefined( data.outlinevalue ) && data.outlinevalue == 1 )
    {
        data.currentvalue -= 4;
        data.enemycolor = "outline_depth_red";
    }
    else if ( data.currentvalue >= 12 )
    {
        data.currentvalue -= 12;
        data.enemycolor = "outline_depth_yellow";
    }
    else if ( data.currentvalue >= 8 )
    {
        data.currentvalue -= 8;
        data.enemycolor = "outlinefill_depth_yellow";
    }
    else if ( data.currentvalue >= 4 )
    {
        data.currentvalue -= 4;
        data.enemycolor = "outline_depth_red";
    }
    else
    {
        data.currentvalue -= 0;
        data.enemycolor = "outlinefill_depth_red";
    }
    
    return data;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x15c3
// Size: 0x6e
function private function_93260fadbd47622b( data )
{
    if ( data.currentvalue > 2 )
    {
        data.currentvalue -= 2;
        data.adsconfirm = 1;
    }
    else
    {
        data.currentvalue -= 0;
        data.adsconfirm = 0;
    }
    
    return data;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x163a
// Size: 0x54
function private function_40353363f8512bb0()
{
    childthread function_d26ee9ff27d79349();
    
    while ( function_5f46cf1503a0541a() )
    {
        wait 0.1;
        
        if ( !isalive( self ) )
        {
            continue;
        }
        
        if ( !function_787341d4cc18bba() )
        {
            continue;
        }
        
        playerads = self playerads();
        
        if ( playerads == 1 )
        {
            childthread function_c4e7b8218a1533cc();
        }
    }
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1696
// Size: 0x1f5
function private function_c4e7b8218a1533cc()
{
    tracedata = function_b8618b0d8d7ff3e3();
    entity = tracedata.entity;
    
    if ( isdefined( entity ) && isdefined( entity.team ) && isdefined( entity.visibilitymode_outline ) )
    {
        var_517520758f9c478f = function_266da5d877397673();
        
        if ( function_afe539c207a6b2fb( entity, self ) )
        {
            if ( var_517520758f9c478f == "alliesonly" )
            {
                return;
            }
            
            ispinged = 0;
            
            if ( tracedata.type == "middle" )
            {
                if ( ispinged )
                {
                    if ( soundexists( "ui_text_type" ) )
                    {
                        self playlocalsound( "ui_text_type" );
                    }
                }
                
                if ( soundexists( "2pop" ) )
                {
                    self playlocalsound( "2pop" );
                }
            }
            else if ( tracedata.type == "middle_near" )
            {
                if ( ispinged )
                {
                    if ( soundexists( "ui_menu_ability_hover" ) )
                    {
                        self playlocalsound( "ui_menu_ability_hover" );
                    }
                }
                
                if ( soundexists( "2pop_low" ) )
                {
                    self playlocalsound( "2pop_low" );
                }
            }
            else if ( tracedata.type == "left" )
            {
                if ( ispinged )
                {
                    if ( soundexists( "ui_menu_ability_hover" ) )
                    {
                        self playlocalsound( "ui_menu_ability_hover" );
                    }
                }
                
                if ( soundexists( "2pop_low" ) )
                {
                    self playlocalsound( "2pop_low" );
                }
            }
            else
            {
                if ( ispinged )
                {
                    if ( soundexists( "ui_menu_ability_hover" ) )
                    {
                        self playlocalsound( "ui_menu_ability_hover" );
                    }
                }
                
                if ( soundexists( "2pop_low" ) )
                {
                    self playlocalsound( "2pop_low" );
                }
            }
            
            return;
        }
        
        if ( isplayer( entity ) )
        {
            if ( var_517520758f9c478f == "enemiesonly" )
            {
                return;
            }
            
            if ( soundexists( "ui_chyron_firstline" ) )
            {
                self playlocalsound( "ui_chyron_firstline" );
            }
            
            return;
        }
        
        if ( var_517520758f9c478f == "enemiesonly" )
        {
            return;
        }
        
        if ( soundexists( "ui_chyron_plusminus" ) )
        {
            self playlocalsound( "ui_chyron_plusminus" );
        }
    }
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1893
// Size: 0x39d
function private function_b8618b0d8d7ff3e3()
{
    tracedist = self [[ level.visibilitymode.funcs[ "getADSWeaponDist" ] ]]();
    playerangles = self getgunangles();
    traceend = self geteye() + anglestoforward( playerangles ) * tracedist;
    traceoffset = ( 0, 0, 0 );
    tracevecoffset = 32;
    returndata = spawnstruct();
    returndata.entity = undefined;
    returndata.type = "middle";
    
    for ( i = 0; i < 15 ; i++ )
    {
        if ( i == 1 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset * -1, 0 ), playerangles );
            returndata.type = "left";
        }
        else if ( i == 2 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset, 0 ), playerangles );
            returndata.type = "right";
        }
        else if ( i == 3 )
        {
            traceoffset = rotatevector( ( 0, 0, tracevecoffset ), playerangles );
            returndata.type = "middle_near";
        }
        else if ( i == 4 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset * -1, tracevecoffset ), playerangles );
            returndata.type = "left";
        }
        else if ( i == 5 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset, tracevecoffset ), playerangles );
            returndata.type = "right";
        }
        else if ( i == 6 )
        {
            traceoffset = rotatevector( ( 0, 0, tracevecoffset * -1 ), playerangles );
            returndata.type = "middle_near";
        }
        else if ( i == 7 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset * -1, tracevecoffset * -1 ), playerangles );
            returndata.type = "left";
        }
        else if ( i == 8 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset, tracevecoffset * -1 ), playerangles );
            returndata.type = "right";
        }
        else if ( i == 9 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset * -2, tracevecoffset ), playerangles );
            returndata.type = "left";
        }
        else if ( i == 10 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset * -2, 0 ), playerangles );
            returndata.type = "left";
        }
        else if ( i == 11 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset * -2, tracevecoffset * -1 ), playerangles );
            returndata.type = "left";
        }
        else if ( i == 12 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset * 2, tracevecoffset ), playerangles );
            returndata.type = "right";
        }
        else if ( i == 13 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset * 2, 0 ), playerangles );
            returndata.type = "right";
        }
        else if ( i == 14 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset * 2, tracevecoffset * -1 ), playerangles );
            returndata.type = "right";
        }
        
        trace = scripts\engine\trace::ray_trace( self geteye(), traceend + traceoffset );
        
        if ( isdefined( trace[ "entity" ] ) && ( isplayer( trace[ "entity" ] ) || issentient( trace[ "entity" ] ) ) )
        {
            if ( returndata.type == "middle" )
            {
                returndata.type = function_4ffad916a54ca2f( trace, playerangles, tracedist );
            }
            
            returndata.entity = trace[ "entity" ];
            return returndata;
        }
    }
    
    return returndata;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x1c39
// Size: 0x142
function private function_4ffad916a54ca2f( trace, playerangles, tracedist )
{
    hitpos = trace[ "position" ];
    targeteyespos = trace[ "entity" ] geteye();
    targetoriginpos = trace[ "entity" ] gettagorigin( "tag_origin", 1 );
    var_734d8fcbdd28f284 = self geteye() + anglestoforward( playerangles ) * tracedist * 1.5;
    
    if ( isdefined( targeteyespos ) && isdefined( targetoriginpos ) )
    {
        data = scripts\engine\utility::closestdistancebetweenlines( targetoriginpos, targeteyespos, self geteye(), var_734d8fcbdd28f284 );
        
        if ( isdefined( data ) && data[ 2 ] < 7 )
        {
            return "middle";
        }
        else if ( isdefined( data ) )
        {
            up = anglestoup( playerangles );
            var_8a15205372a55a43 = vectornormalize2( var_734d8fcbdd28f284 - self.origin );
            metotarget = vectornormalize2( targetoriginpos - self.origin );
            angbetween = math::anglebetweenvectorssigned( var_8a15205372a55a43, metotarget, up );
            
            if ( angbetween > 0 )
            {
                return "right";
            }
            else
            {
                return "left";
            }
        }
    }
    
    return "middle";
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1d84
// Size: 0xd1
function private function_d26ee9ff27d79349()
{
    self.visibilitymodeads = 0;
    self.var_44446bd6d8fd6ed0 = 0;
    self notifyonplayercommand( "vis_sprint_pressed", "+breath_sprint" );
    self notifyonplayercommand( "vis_sprint_pressed", "+melee_breath" );
    
    while ( function_5f46cf1503a0541a() )
    {
        wait 0.1;
        
        if ( !isalive( self ) )
        {
            continue;
        }
        
        if ( !function_787341d4cc18bba() )
        {
            wait 1;
            continue;
        }
        
        playerads = self playerads();
        
        if ( playerads == 1 )
        {
            if ( self.visibilitymodeads == 0 )
            {
                self.visibilitymodeads = 1;
                thread function_dc7453c8550c512c();
                thread function_eec104c84dc70618( "vis_sprint_pressed" );
            }
            
            continue;
        }
        
        if ( playerads < 1 )
        {
            self.visibilitymodeads = 0;
            self.var_44446bd6d8fd6ed0 = 0;
            self notify( "visibilityMode_stopads" );
        }
    }
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1e5d
// Size: 0x48
function private function_eec104c84dc70618( type )
{
    self endon( "death_or_disconnect" );
    self endon( "visibilityMode_stopads" );
    
    if ( type == "vis_sprint_pressed" )
    {
        while ( true )
        {
            self waittill( "vis_sprint_pressed" );
            function_b17c1eba153a25e8();
            function_5c04dcd5e95fbb53();
            function_49afc10334084167();
        }
    }
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1ead
// Size: 0x3f
function private function_b17c1eba153a25e8()
{
    if ( self getstance() != "prone" )
    {
        return;
    }
    
    angles = ( 0, self.angles[ 1 ], self.angles[ 2 ] );
    self setplayerangles( angles );
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1ef4
// Size: 0x15c
function private function_5c04dcd5e95fbb53()
{
    self endon( "death_or_disconnect" );
    self endon( "visibilityMode_stopads" );
    
    if ( istrue( level.visibilitymode.var_419d1a784e4b187c ) )
    {
        return;
    }
    
    clientallies = function_e3c04f03881b4dc7();
    active_players = [];
    var_b94177401c42c6ef = [];
    
    foreach ( ally in clientallies )
    {
        if ( isplayer( ally ) )
        {
            active_players[ active_players.size ] = ally;
            continue;
        }
        
        var_b94177401c42c6ef[ var_b94177401c42c6ef.size ] = ally;
    }
    
    active_players = sortbydistance( active_players, self.origin );
    
    for ( i = 0; i < active_players.size ; i++ )
    {
        if ( active_players[ i ] == self )
        {
            continue;
        }
        
        if ( !isdefined( active_players[ i ] ) || !isalive( active_players[ i ] ) )
        {
            continue;
        }
        
        if ( !istrue( active_players[ i ].inlaststand ) )
        {
            if ( soundexists( "uin_ping_confirm" ) )
            {
                active_players[ i ] playsound( "uin_ping_confirm" );
            }
        }
        else if ( soundexists( "uin_ping_wheel_announce_help" ) )
        {
            active_players[ i ] playsound( "uin_ping_wheel_announce_help" );
        }
        
        if ( active_players.size > 1 )
        {
            wait 0.2;
        }
    }
    
    if ( active_players.size > 0 )
    {
        wait 0.5;
    }
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2058
// Size: 0x142
function private function_dc7453c8550c512c()
{
    self endon( "death_or_disconnect" );
    self endon( "visibilityMode_stopads" );
    
    if ( self.var_44446bd6d8fd6ed0 == 0 )
    {
        self.var_44446bd6d8fd6ed0 = 1;
    }
    else
    {
        return;
    }
    
    maxdist = self [[ level.visibilitymode.funcs[ "getADSWeaponDist" ] ]]();
    maxdistsq = squared( maxdist );
    clientenemies = function_90ce2459298d263();
    clientenemies = sortbydistance( clientenemies, self.origin );
    var_72013161599ed91b = min( 5, clientenemies.size );
    
    for ( i = 0; i < var_72013161599ed91b ; i++ )
    {
        if ( !function_8eee51af38988db6( self, clientenemies[ i ] ) )
        {
            continue;
        }
        
        if ( !isdefined( clientenemies[ i ] ) || !isalive( clientenemies[ i ] ) )
        {
            continue;
        }
        
        disttome = distancesquared( clientenemies[ i ].origin, self.origin );
        
        if ( disttome < maxdistsq )
        {
            if ( soundexists( "uin_ping_enemy" ) )
            {
                clientenemies[ i ] playsound( "uin_ping_enemy" );
                delay = math::remap( disttome, 0, maxdistsq, 0.15, 0.6 );
                wait delay;
            }
        }
    }
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x21a2
// Size: 0x1ad
function private function_49afc10334084167()
{
    self endon( "death_or_disconnect" );
    self endon( "visibilityMode_stopads" );
    
    if ( istrue( level.visibilitymode.var_a7628fab5ece8d7a ) )
    {
        return;
    }
    
    flag_wait( "objectives_registered" );
    objposarray = [];
    
    for ( i = 0; i < level.worldobjidpool.active.size ; i++ )
    {
        if ( isdefined( level.worldobjidpool.active[ i ].identifier ) && level.worldobjidpool.active[ i ].identifier == "nonobj_marker" )
        {
            continue;
        }
        
        objstruct = spawnstruct();
        objstruct.objinfo = level.worldobjidpool.active[ i ];
        objstruct.origin = objective_getlocation( level.worldobjidpool.active[ i ].objid, 0 );
        objposarray[ objposarray.size ] = objstruct;
    }
    
    objposarray = sortbydistance( objposarray, self.origin );
    
    for ( i = 0; i < objposarray.size ; i++ )
    {
        potentialcustomsound = function_bd41d880db5c1bad( objposarray[ i ].objinfo.identifier );
        
        if ( isdefined( potentialcustomsound ) )
        {
            level thread function_95cd04544bc213e5( objposarray[ i ].origin, self, potentialcustomsound );
        }
        else
        {
            level thread function_95cd04544bc213e5( objposarray[ i ].origin, self );
        }
        
        if ( objposarray.size > 1 )
        {
            wait 1;
        }
    }
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x2357
// Size: 0x6f
function private function_95cd04544bc213e5( origin, player, customsound )
{
    tag_origin = spawn( "script_model", origin );
    tag_origin setmodel( "tag_origin" );
    soundtoplay = "uin_ping_mission";
    
    if ( isdefined( customsound ) )
    {
        soundtoplay = customsound;
    }
    
    player playsound( soundtoplay );
    wait lookupsoundlength( soundtoplay ) / 1000;
    tag_origin delete();
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x23ce
// Size: 0x7e
function private function_bd41d880db5c1bad( var_bc23a0a6125c16f4 )
{
    if ( isdefined( level.visibilitymode.var_3a5f706a07632f07 ) )
    {
        foreach ( sound in level.visibilitymode.var_3a5f706a07632f07 )
        {
            if ( index == var_bc23a0a6125c16f4 )
            {
                return sound;
            }
        }
    }
    
    return undefined;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 2
// Checksum 0x0, Offset: 0x2455
// Size: 0x7e
function function_7068f93aacf2ef59( var_bc23a0a6125c16f4, soundalias )
{
    if ( !isdefined( level.visibilitymode ) )
    {
        return;
    }
    
    if ( !isdefined( level.visibilitymode.var_3a5f706a07632f07 ) )
    {
        level.visibilitymode.var_3a5f706a07632f07 = [];
    }
    
    if ( isdefined( level.visibilitymode.var_3a5f706a07632f07[ var_bc23a0a6125c16f4 ] ) )
    {
        return;
    }
    
    level.visibilitymode.var_3a5f706a07632f07[ var_bc23a0a6125c16f4 ] = soundalias;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 2
// Checksum 0x0, Offset: 0x24db
// Size: 0xdb, Type: bool
function function_8eee51af38988db6( player, target )
{
    if ( !within_fov( player.origin, player.angles, target.origin, 0.766 ) )
    {
        return false;
    }
    
    playereye = player geteye();
    feetorigin = target.origin;
    
    if ( sighttracepassed( playereye, feetorigin, 1, player, target ) )
    {
        return true;
    }
    
    eyeorigin = undefined;
    
    if ( isagent( target ) )
    {
        eyeorigin = target getapproxeyepos();
    }
    else
    {
        eyeorigin = target geteye();
    }
    
    if ( sighttracepassed( playereye, eyeorigin, 1, player, target ) )
    {
        return true;
    }
    
    midorigin = ( eyeorigin + feetorigin ) * 0.5;
    
    if ( sighttracepassed( playereye, midorigin, 1, player, target ) )
    {
        return true;
    }
    
    return false;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0
// Checksum 0x0, Offset: 0x25bf
// Size: 0x1c, Type: bool
function function_5f46cf1503a0541a()
{
    if ( isdefined( self.visibilitymodeval ) )
    {
        return ( self.visibilitymodeval > 0 );
    }
    
    return false;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0
// Checksum 0x0, Offset: 0x25e4
// Size: 0x4d
function function_ea4e39208c784a4a()
{
    color = "outline_depth_red";
    
    if ( isdefined( self.var_be1e6d7ff9628b76 ) && isdefined( self.var_be1e6d7ff9628b76.enemycolor ) )
    {
        color = self.var_be1e6d7ff9628b76.enemycolor;
    }
    
    return color;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0
// Checksum 0x0, Offset: 0x263a
// Size: 0x4d
function function_4448756918b98e87()
{
    color = "outline_depth_cyan";
    
    if ( isdefined( self.var_be1e6d7ff9628b76 ) && isdefined( self.var_be1e6d7ff9628b76.npccolor ) )
    {
        color = self.var_be1e6d7ff9628b76.npccolor;
    }
    
    return color;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0
// Checksum 0x0, Offset: 0x2690
// Size: 0x4d
function function_63a1833b6a352cd7()
{
    color = "outline_highvis_green";
    
    if ( isdefined( self.var_be1e6d7ff9628b76 ) && isdefined( self.var_be1e6d7ff9628b76.playercolor ) )
    {
        color = self.var_be1e6d7ff9628b76.playercolor;
    }
    
    return color;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0
// Checksum 0x0, Offset: 0x26e6
// Size: 0x4d
function function_266da5d877397673()
{
    mode = "normal";
    
    if ( isdefined( self.var_be1e6d7ff9628b76 ) && isdefined( self.var_be1e6d7ff9628b76.vismode ) )
    {
        mode = self.var_be1e6d7ff9628b76.vismode;
    }
    
    return mode;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0
// Checksum 0x0, Offset: 0x273c
// Size: 0x49
function function_787341d4cc18bba()
{
    adsconfirm = 0;
    
    if ( isdefined( self.var_be1e6d7ff9628b76 ) && isdefined( self.var_be1e6d7ff9628b76.adsconfirm ) )
    {
        adsconfirm = self.var_be1e6d7ff9628b76.adsconfirm;
    }
    
    return adsconfirm;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0
// Checksum 0x0, Offset: 0x278e
// Size: 0x8c
function function_88ec96d66632c2b9()
{
    active_targets = [[ level.visibilitymode.funcs[ "getTargetArray" ] ]]( self );
    returnguys = [];
    playernum = self getentitynumber();
    
    for ( i = 0; i < active_targets.size ; i++ )
    {
        if ( isdefined( active_targets[ i ].visibilitymode_outlineids ) )
        {
            if ( isdefined( active_targets[ i ].visibilitymode_outlineids[ playernum ] ) )
            {
                returnguys[ returnguys.size ] = active_targets[ i ];
            }
        }
    }
    
    return returnguys;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0
// Checksum 0x0, Offset: 0x2823
// Size: 0x4e
function function_90ce2459298d263()
{
    all_targets = function_88ec96d66632c2b9();
    return_targets = [];
    
    for ( i = 0; i < all_targets.size ; i++ )
    {
        if ( function_afe539c207a6b2fb( all_targets[ i ], self ) )
        {
            return_targets[ return_targets.size ] = all_targets[ i ];
        }
    }
    
    return return_targets;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0
// Checksum 0x0, Offset: 0x287a
// Size: 0x4e
function function_e3c04f03881b4dc7()
{
    all_targets = function_88ec96d66632c2b9();
    return_targets = [];
    
    for ( i = 0; i < all_targets.size ; i++ )
    {
        if ( !function_afe539c207a6b2fb( all_targets[ i ], self ) )
        {
            return_targets[ return_targets.size ] = all_targets[ i ];
        }
    }
    
    return return_targets;
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0
// Checksum 0x0, Offset: 0x28d1
// Size: 0x87
function function_c1d9fd48eb09c8c9()
{
    if ( isdefined( level.players ) )
    {
        activeplayers = [];
        
        for ( i = 0; i < level.players.size ; i++ )
        {
            if ( level.players[ i ] function_5f46cf1503a0541a() )
            {
                activeplayers[ activeplayers.size ] = level.players[ i ];
            }
        }
        
        return activeplayers;
    }
    
    if ( isdefined( level.player ) )
    {
        return level.player function_5f46cf1503a0541a();
    }
    
    return [];
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0
// Checksum 0x0, Offset: 0x2960
// Size: 0x12f
function function_924634e910fbfc75()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "visibiltyMode_disabled" );
    
    while ( true )
    {
        level waittill( "visibilityTeamName", teamname, soldiersarray, var_5f622d6d58521bea );
        
        foreach ( soldier in soldiersarray )
        {
            if ( !function_753e2e2a70ae2d65( soldier ) )
            {
                continue;
            }
            
            soldier.team = teamname;
            
            if ( istrue( var_5f622d6d58521bea ) )
            {
                soldier.agentname = undefined;
            }
            
            if ( !isdefined( soldier.lastteam ) )
            {
                soldier.lastteam = "";
            }
            
            if ( teamname != soldier.lastteam )
            {
                soldier function_85e0f20ba385bf6d( self );
                soldier.lastteam = teamname;
                
                if ( isdefined( soldier.headmodel ) && isent( soldier.headmodel ) )
                {
                    function_8ba05ef17e2b7d10( soldier.headmodel, teamname );
                }
            }
        }
    }
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 2
// Checksum 0x0, Offset: 0x2a97
// Size: 0xa6
function function_8ba05ef17e2b7d10( entity, team )
{
    if ( !isdefined( level.visibilitymode.forced_ents ) )
    {
        level.visibilitymode.forced_ents = [];
    }
    
    entity.visibilitymode_forced = 1;
    ent_number = entity getentitynumber();
    
    if ( !is_equal( entity.team, team ) )
    {
        entity.team = team;
        level.visibilitymode.forced_ents[ ent_number ] = entity;
        level notify( "visibilityTeamName", team, [ entity ] );
    }
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 1
// Checksum 0x0, Offset: 0x2b45
// Size: 0x72
function function_b6e23e71bb7ad50f( entity )
{
    if ( isdefined( entity ) )
    {
        ent_number = entity getentitynumber();
        
        if ( isdefined( level.visibilitymode.forced_ents ) && isdefined( level.visibilitymode.forced_ents[ ent_number ] ) )
        {
            entity.visibilitymode_forced = undefined;
            level.visibilitymode.forced_ents[ ent_number ] = undefined;
        }
    }
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0
// Checksum 0x0, Offset: 0x2bbf
// Size: 0xce
function function_d5f76e611c78509a()
{
    entity = self;
    model = entity.model;
    headmodel = entity.headmodel;
    
    if ( istrue( entity.visibilitymode_forced ) )
    {
        return;
    }
    
    if ( isplayer( entity ) || isai( entity ) || issentient( entity ) )
    {
        return;
    }
    
    if ( self tagexists( "TAG_EYE" ) || self tagexists( "j_head" ) )
    {
        if ( issubstr( model, "enemy" ) || issubstr( model, "axis" ) || issubstr( model, "villain" ) )
        {
            function_8ba05ef17e2b7d10( entity, "axis" );
            return;
        }
        
        function_8ba05ef17e2b7d10( entity, "allies" );
    }
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2c95
// Size: 0x6f
function private function_8977a3724ec5ce9e()
{
    level endon( "game_ended" );
    dvar = @"hash_5ecd08979278a317";
    
    while ( true )
    {
        while ( true )
        {
            var_4f9df27618277b1e = getdvar( dvar, "" );
            
            if ( var_4f9df27618277b1e != "" )
            {
                level thread function_bf79c9a4bc54b7da( var_4f9df27618277b1e );
                setdvar( dvar, "" );
            }
            
            wait 0.1;
        }
        
        wait 0.1;
    }
}

// Namespace visibility_mode / scripts\common\visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2d0c
// Size: 0x26
function private function_bf79c9a4bc54b7da( val )
{
    val = int( val );
    level.players[ 0 ] visibilitymode_unpackvalue( val );
}

