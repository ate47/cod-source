#using scripts\common\swim_common;
#using scripts\common\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;

#namespace namespace_b6acd36531d49c27;

// Namespace namespace_b6acd36531d49c27 / namespace_bed52b18307bf1e0
// Params 0
// Checksum 0x0, Offset: 0x210
// Size: 0x82
function main()
{
    initcommonswim( &getbreathtime, &function_de1545c98ed439f8, &function_a62d0f50f690359, &enterfunc, &exitfunc, &surfacefunc, &descendfunc, &playsoundfunc, &visionsetfunc, &drownfunc, &function_6fed0ef13f84a258, &function_673ece83b6eb66c4 );
    function_a76b0a124a6a8f46();
    function_3e689374a8c8c3a2();
    
    while ( !issharedfuncdefined( "aggregator", "registerOnPlayerSpawnCallback" ) )
    {
        waitframe();
    }
    
    [[ getsharedfunc( "aggregator", "registerOnPlayerSpawnCallback" ) ]]( &function_9ac5625caf26591e );
}

// Namespace namespace_b6acd36531d49c27 / namespace_bed52b18307bf1e0
// Params 0
// Checksum 0x0, Offset: 0x29a
// Size: 0xa
function function_9ac5625caf26591e()
{
    thread function_fc7d07d4cc7ae9f1();
}

// Namespace namespace_b6acd36531d49c27 / namespace_bed52b18307bf1e0
// Params 2
// Checksum 0x0, Offset: 0x2ac
// Size: 0xd1
function function_3e689374a8c8c3a2( breathnormal, breathsprint )
{
    if ( !isdefined( level.swim.breathtimes ) )
    {
        level.swim.breathtimes = spawnstruct();
    }
    
    if ( isdefined( breathnormal ) )
    {
        level.swim.breathtimes.normal = breathnormal;
    }
    else
    {
        level.swim.breathtimes.normal = 23;
    }
    
    if ( isdefined( breathsprint ) )
    {
        level.swim.breathtimes.sprint = breathsprint;
        return;
    }
    
    level.swim.breathtimes.sprint = 15;
}

// Namespace namespace_b6acd36531d49c27 / namespace_bed52b18307bf1e0
// Params 0
// Checksum 0x0, Offset: 0x385
// Size: 0xb0
function getbreathtime()
{
    if ( self isswimsprinting() )
    {
        breathtime = level.swim.breathtimes.sprint;
    }
    else
    {
        breathtime = level.swim.breathtimes.normal;
    }
    
    /#
        if ( getdvarfloat( @"hash_59466cf1acb31334", -1 ) > 0 )
        {
            breathtime = getdvarfloat( @"hash_59466cf1acb31334", -1 );
            
            if ( self isswimsprinting() )
            {
                if ( getdvarfloat( @"hash_eb6fc369d3b1d968", -1 ) > 0 )
                {
                    breathtime = getdvarfloat( @"hash_eb6fc369d3b1d968", -1 );
                }
            }
        }
    #/
    
    return breathtime;
}

// Namespace namespace_b6acd36531d49c27 / namespace_bed52b18307bf1e0
// Params 0
// Checksum 0x0, Offset: 0x43e
// Size: 0x1a
function function_de1545c98ed439f8()
{
    if ( self isswimsprinting() )
    {
        return 4;
    }
    
    return 6;
}

// Namespace namespace_b6acd36531d49c27 / namespace_bed52b18307bf1e0
// Params 0
// Checksum 0x0, Offset: 0x460
// Size: 0x7
function function_a62d0f50f690359()
{
    return 6;
}

// Namespace namespace_b6acd36531d49c27 / namespace_bed52b18307bf1e0
// Params 0
// Checksum 0x0, Offset: 0x470
// Size: 0xbf
function surfacefunc()
{
    if ( issharedfuncdefined( "perk", "hasPerk" ) )
    {
        if ( self [[ getsharedfunc( "perk", "hasPerk" ) ]]( "specialty_swimming" ) )
        {
            self [[ getsharedfunc( "perk", "removePerk" ) ]]( "specialty_swimming" );
        }
    }
    
    if ( issharedfuncdefined( "stealth", "revertAiAccuracy" ) )
    {
        self [[ getsharedfunc( "stealth", "revertAiAccuracy" ) ]]();
    }
    
    if ( issharedfuncdefined( "player", "surfaceFunc" ) )
    {
        self [[ getsharedfunc( "player", "surfaceFunc" ) ]]();
    }
    
    if ( istrue( callsharedfunc( "scubaGasMask", "hasScubaGasMask", self ) ) )
    {
        callsharedfunc( "scubaGasMask", "updateScubaGasmask", self, 0 );
    }
}

// Namespace namespace_b6acd36531d49c27 / namespace_bed52b18307bf1e0
// Params 0
// Checksum 0x0, Offset: 0x537
// Size: 0x90
function descendfunc()
{
    if ( issharedfuncdefined( "perk", "givePerk" ) )
    {
        self [[ getsharedfunc( "perk", "givePerk" ) ]]( "specialty_swimming" );
    }
    
    if ( issharedfuncdefined( "stealth", "dropAiAccuracy" ) )
    {
        self [[ getsharedfunc( "stealth", "dropAiAccuracy" ) ]]();
    }
    
    if ( istrue( callsharedfunc( "scubaGasMask", "hasScubaGasMask", self ) ) )
    {
        callsharedfunc( "scubaGasMask", "updateScubaGasmask", self, 1 );
        thread callsharedfunc( "scubaGasMask", "monitorScubaGasMaskDamage" );
    }
}

// Namespace namespace_b6acd36531d49c27 / namespace_bed52b18307bf1e0
// Params 0
// Checksum 0x0, Offset: 0x5cf
// Size: 0x2e
function enterfunc()
{
    if ( scripts\engine\utility::issharedfuncdefined( "hud", "ftue_triggerTip" ) )
    {
        self [[ scripts\engine\utility::getsharedfunc( "hud", "ftue_triggerTip" ) ]]( "br_ftue_swimming" );
    }
}

// Namespace namespace_b6acd36531d49c27 / namespace_bed52b18307bf1e0
// Params 0
// Checksum 0x0, Offset: 0x605
// Size: 0x2
function exitfunc()
{
    
}

// Namespace namespace_b6acd36531d49c27 / namespace_bed52b18307bf1e0
// Params 3
// Checksum 0x0, Offset: 0x60f
// Size: 0x3b
function playsoundfunc( firstpersonalias, thirdpersonalias, soundsource )
{
    if ( !isdefined( soundsource ) )
    {
        soundsource = self;
    }
    
    if ( isdefined( thirdpersonalias ) )
    {
        self playsound( thirdpersonalias, self );
    }
    
    soundsource playsoundtoplayer( firstpersonalias, self, soundsource );
}

// Namespace namespace_b6acd36531d49c27 / namespace_bed52b18307bf1e0
// Params 0
// Checksum 0x0, Offset: 0x652
// Size: 0x79
function drownfunc()
{
    if ( scripts\cp_mp\utility\player_utility::isinvehicle( 1 ) )
    {
        data = spawnstruct();
        data.allowairexit = 1;
        data.exittype = "INVOLUNTARY";
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit( self.vehicle, undefined, self, data, 1 );
        
        while ( self isvehicleactive() )
        {
            waitframe();
        }
    }
    
    scripts\common\utility::trycall( level.var_da6cb768c7ca7b39 );
    return makeweapon( "iw9_drown_mp" );
}

// Namespace namespace_b6acd36531d49c27 / namespace_bed52b18307bf1e0
// Params 2
// Checksum 0x0, Offset: 0x6d4
// Size: 0x1c
function visionsetfunc( visionset, transitiontime )
{
    self visionsetnakedforplayer( visionset, transitiontime );
}

// Namespace namespace_b6acd36531d49c27 / namespace_bed52b18307bf1e0
// Params 1
// Checksum 0x0, Offset: 0x6f8
// Size: 0x32, Type: bool
function function_afb40a34c99dc4e4( objweapon )
{
    return isdefined( objweapon ) && isdefined( objweapon.basename ) && objweapon.basename == "iw9_drown_mp";
}

// Namespace namespace_b6acd36531d49c27 / namespace_bed52b18307bf1e0
// Params 0
// Checksum 0x0, Offset: 0x733
// Size: 0x8
function function_6fed0ef13f84a258()
{
    return self function_7ee20cf3c0390e21();
}

// Namespace namespace_b6acd36531d49c27 / namespace_bed52b18307bf1e0
// Params 0
// Checksum 0x0, Offset: 0x744
// Size: 0xb7
function function_a76b0a124a6a8f46()
{
    for ( currentid = 1; currentid <= 4 ; currentid++ )
    {
        currenttriggers = getentarray( "trigger_multiple_mp_proto_current_" + currentid, "classname" );
        
        foreach ( currenttrigger in currenttriggers )
        {
            currenttrigger.currentid = currentid;
            
            if ( issharedfuncdefined( "game", "makeEnterExitTrigger" ) )
            {
                [[ getsharedfunc( "game", "makeEnterExitTrigger" ) ]]( currenttrigger, &function_46c5edf87b46fc60, &function_d1ec9743b2c9ea9e );
            }
        }
    }
}

// Namespace namespace_b6acd36531d49c27 / namespace_bed52b18307bf1e0
// Params 2
// Checksum 0x0, Offset: 0x803
// Size: 0x31
function function_46c5edf87b46fc60( player, trigger )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player function_923d9644ab0b076f( trigger.currentid, 1 );
}

// Namespace namespace_b6acd36531d49c27 / namespace_bed52b18307bf1e0
// Params 2
// Checksum 0x0, Offset: 0x83c
// Size: 0x30
function function_d1ec9743b2c9ea9e( player, trigger )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player function_923d9644ab0b076f( trigger.currentid, 0 );
}

// Namespace namespace_b6acd36531d49c27 / namespace_bed52b18307bf1e0
// Params 3
// Checksum 0x0, Offset: 0x874
// Size: 0xd4
function function_673ece83b6eb66c4( vfx, notify_kill, timeout )
{
    self endon( "disconnect" );
    
    /#
        if ( !isdefined( self.model ) || self.model == "<dev string:x1c>" )
        {
            iprintlnbold( "<dev string:x1d>" + self getentitynumber() + "<dev string:x41>" );
            return;
        }
        
        if ( !hastag( self.model, "<dev string:x59>" ) )
        {
            iprintlnbold( "<dev string:x61>" + self.model + "<dev string:x84>" );
            return;
        }
    #/
    
    playfxontagforclients( level._effect[ vfx ], self, "tag_eye", self );
    
    if ( isdefined( notify_kill ) )
    {
        function_1cf86af6f8a0266d( notify_kill, "death", timeout );
        killfxontag( level._effect[ vfx ], self, "tag_eye" );
    }
}

