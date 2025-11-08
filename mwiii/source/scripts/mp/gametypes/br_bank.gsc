#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\utility\trigger;

#namespace br_bank;

// Namespace br_bank / scripts\mp\gametypes\br_bank
// Params 0
// Checksum 0x0, Offset: 0x148
// Size: 0xfe
function init()
{
    level.br_bank_alarm_enabled = getdvarint( @"hash_bbb179520c2c4a14", 0 );
    
    if ( !istrue( level.br_bank_alarm_enabled ) )
    {
        return;
    }
    
    level._effect[ "poi_light_bank" ] = loadfx( "vfx/iw8_br/gameplay/vfx_br_poi_light_bank.vfx" );
    level.bankalltriggers = getentarray( "bank_entry_detector", "targetname" );
    
    foreach ( trigger in level.bankalltriggers )
    {
        if ( !isdefined( trigger ) )
        {
            continue;
        }
        
        trigger.playersinsidebank = 0;
        trigger.alarmstillplaying = 0;
        trigger.banklights = getstructarray( trigger.target, "targetname" );
        trigger thread scripts\mp\utility\trigger::makeenterexittrigger( trigger, &bankplayerentering, &bankplayerexiting );
    }
}

// Namespace br_bank / scripts\mp\gametypes\br_bank
// Params 2
// Checksum 0x0, Offset: 0x24e
// Size: 0x4e
function bankplayerentering( player, banktrigger )
{
    if ( !isdefined( banktrigger ) )
    {
        return;
    }
    
    banktrigger.playersinsidebank += 1;
    
    if ( banktrigger.playersinsidebank != 1 )
    {
        return;
    }
    
    banktrigger thread bankturnonalarm();
}

// Namespace br_bank / scripts\mp\gametypes\br_bank
// Params 2
// Checksum 0x0, Offset: 0x2a4
// Size: 0x6d
function bankplayerexiting( player, banktrigger )
{
    if ( !isdefined( banktrigger ) )
    {
        return;
    }
    
    assertex( banktrigger.playersinsidebank > 0, "<dev string:x1c>" );
    banktrigger.playersinsidebank = max( banktrigger.playersinsidebank - 1, 0 );
    
    if ( banktrigger.playersinsidebank == 0 )
    {
        banktrigger thread bankturnoffalarm();
    }
}

// Namespace br_bank / scripts\mp\gametypes\br_bank
// Params 0
// Checksum 0x0, Offset: 0x319
// Size: 0x97
function bankplunderdeposited()
{
    if ( !istrue( level.br_bank_alarm_enabled ) )
    {
        return;
    }
    
    player = self;
    player notify( "bankPlunderDeposited" );
    player endon( "bankPlunderDeposited" );
    var_8e204c4acdb20d51 = getclosest( player.origin, level.bankalltriggers, 90000 );
    
    if ( !isdefined( var_8e204c4acdb20d51 ) )
    {
        return;
    }
    
    var_8e204c4acdb20d51 bankturnoffalarm();
    var_b4a32387dba557b9 = getdvarint( @"hash_32eab55ff865c3c", 15 );
    wait var_b4a32387dba557b9;
    
    if ( var_8e204c4acdb20d51.playersinsidebank > 0 )
    {
        var_8e204c4acdb20d51 bankturnonalarm();
    }
}

// Namespace br_bank / scripts\mp\gametypes\br_bank
// Params 0
// Checksum 0x0, Offset: 0x3b8
// Size: 0x137
function bankturnonalarm()
{
    self notify( "bank_alarm_triggered" );
    banktrigger = self;
    banktrigger.alarmstillplaying = 1;
    banktrigger playloopsound( "bank_alarm_lp" );
    
    foreach ( banklight in banktrigger.banklights )
    {
        forwardvect = anglestoforward( banklight.angles );
        upvect = anglestoup( banklight.angles );
        banklight.fx = spawnfx( level._effect[ "poi_light_bank" ], banklight.origin + forwardvect * 5, forwardvect, upvect );
        triggerfx( banklight.fx );
    }
    
    var_50b6c105426b8e48 = getdvarint( @"hash_5b11f68d6b008181", 5 );
    wait var_50b6c105426b8e48;
    banktrigger.alarmstillplaying = 0;
    
    if ( banktrigger.playersinsidebank == 0 )
    {
        banktrigger bankturnoffalarm();
    }
}

// Namespace br_bank / scripts\mp\gametypes\br_bank
// Params 0
// Checksum 0x0, Offset: 0x4f7
// Size: 0x9b
function bankturnoffalarm()
{
    self endon( "bank_alarm_triggered" );
    banktrigger = self;
    
    if ( banktrigger.alarmstillplaying )
    {
        return;
    }
    
    wait 3;
    banktrigger stoploopsound();
    
    foreach ( banklight in banktrigger.banklights )
    {
        if ( isdefined( banklight.fx ) )
        {
            banklight.fx delete();
        }
    }
}

