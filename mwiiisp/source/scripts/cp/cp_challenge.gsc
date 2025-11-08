#using scripts\common\utility;
#using scripts\cp\agent_damage;
#using scripts\cp\loadout;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp\weapon;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;

#namespace cp_challenge;

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 0
// Checksum 0x0, Offset: 0x37b
// Size: 0x1d
function init()
{
    if ( !challengesenabled() )
    {
        return;
    }
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        level setupchallengelocales();
    }
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 0
// Checksum 0x0, Offset: 0x3a0
// Size: 0x1fe
function setupchallengelocales()
{
    level.localetriggers = [];
    areas = getentarray( "locale_area_trigger", "targetname" );
    
    if ( isdefined( areas ) && areas.size > 0 )
    {
        foreach ( area in areas )
        {
            if ( !isdefined( area.script_noteworthy ) )
            {
                continue;
            }
            
            switch ( area.script_noteworthy )
            {
                case #"hash_2c5efc9850d0cbb5":
                    area.localeid = 0;
                    break;
                case #"hash_a86d6bdba8e7b140":
                    area.localeid = 1;
                    break;
                case #"hash_c0087eafd38b4fed":
                    area.localeid = 2;
                    break;
                case #"hash_959ab3efc8aa213":
                    area.localeid = 3;
                    break;
                case #"hash_45caf0be6d4b6190":
                    area.localeid = 4;
                    break;
                case #"hash_f48a166c03bb39c1":
                    area.localeid = 5;
                    break;
                case #"hash_490db84e1b08c326":
                    area.localeid = 6;
                    break;
                case #"hash_879d655c265bd99f":
                    area.localeid = 7;
                    break;
                case #"hash_b445759ac0026f01":
                    area.localeid = 8;
                    break;
                case #"hash_a66d876237312560":
                    area.localeid = 9;
                    break;
                case #"hash_5f22fd847b75bb06":
                    area.localeid = 10;
                    break;
                case #"hash_663b0900ff0e81c7":
                    area.localeid = 11;
                    break;
            }
        }
        
        level.localetriggers = areas;
    }
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 0
// Checksum 0x0, Offset: 0x5a6
// Size: 0x21
function challengesenabled()
{
    if ( getdvarint( @"hash_f0c3671383d467f8", 0 ) != 0 )
    {
        return 0;
    }
    
    return level.challengesallowed;
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 0
// Checksum 0x0, Offset: 0x5d0
// Size: 0x25, Type: bool
function challengesenabledforplayer()
{
    if ( !challengesenabled() )
    {
        return false;
    }
    
    if ( !isplayer( self ) || isai( self ) )
    {
        return false;
    }
    
    return true;
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 8
// Checksum 0x0, Offset: 0x5fe
// Size: 0x6c2
function onplayerkilled( inflictor, attacker, damage, damageflags, meansofdeath, objweapon, hitloc, modifiers )
{
    if ( !attacker challengesenabledforplayer() )
    {
        return;
    }
    
    victim = self;
    
    if ( !isplayer( attacker ) )
    {
        if ( isdefined( inflictor ) && isplayer( inflictor ) )
        {
            attacker = inflictor;
        }
        else
        {
            return;
        }
    }
    
    if ( !scripts\cp\utility\player::isfriendly( attacker.team, victim ) )
    {
        equipmentname = scripts\cp_mp\equipment::getequipmentreffromweapon( objweapon );
        
        if ( !isdefined( equipmentname ) )
        {
            equipmentname = getdefaultweaponbasename( objweapon.basename );
        }
        
        switch ( equipmentname )
        {
            case #"hash_53b56552dcba7edd":
            case #"hash_da7316c483b6c780":
                equipmentname = "support_box_mp";
                break;
            default:
                break;
        }
        
        var_6747b178b5fc3b95 = "";
        
        if ( isdefined( attacker.secondaryweaponobj ) )
        {
            if ( objweapon == attacker.primaryweaponobj )
            {
                var_6747b178b5fc3b95 = getdefaultweaponbasename( attacker.secondaryweaponobj.basename );
            }
            else if ( objweapon == attacker.secondaryweaponobj )
            {
                var_6747b178b5fc3b95 = getdefaultweaponbasename( attacker.primaryweaponobj.basename );
            }
        }
        
        weapons = [ equipmentname, var_6747b178b5fc3b95 ];
        modifiers1 = 0;
        modifiers2 = 0;
        
        if ( isdefined( modifiers ) )
        {
            modifiers1 = modifiers[ "mask" ];
            modifiers2 = modifiers[ "mask2" ];
        }
        
        operators = [ attacker scripts\cp\loadout::lookupcurrentoperator( attacker.team ), attacker scripts\cp\loadout::lookupotheroperator( attacker.team ) ];
        
        if ( !getdvarint( @"hash_78653010d584aa6e" ) )
        {
            game_type = getgametype();
            
            if ( !isdefined( game_type ) )
            {
                game_type = getdvar( @"g_gametype" );
            }
            
            gametypecol = level.challengeandeventglobals.game_type_col[ game_type ];
        }
        else
        {
            gametypecol = level.challengeandeventglobals.game_type_col[ level.gametypebundle.var_d20acad05758f0d8 ];
        }
        
        var_349e390338192305 = "";
        var_c832cc337856aca8 = 1;
        
        if ( isdefined( objweapon.attachments ) )
        {
            var_7208e21ea18240fb = 0;
            
            foreach ( attachment in objweapon.attachments )
            {
                if ( issubstr( attachment, "snprscope" ) )
                {
                    var_7208e21ea18240fb = 1;
                }
                
                if ( scripts\cp\weapon::attachmentisselectable( objweapon, attachment ) )
                {
                    if ( !var_c832cc337856aca8 )
                    {
                        var_349e390338192305 += "|";
                    }
                    
                    var_349e390338192305 += attachment;
                    var_c832cc337856aca8 = 0;
                }
            }
            
            if ( var_7208e21ea18240fb )
            {
                if ( !var_c832cc337856aca8 )
                {
                    var_349e390338192305 += "|";
                }
                
                var_349e390338192305 += "default_sniper_scope";
            }
        }
        
        loadout_perks = "";
        var_a4b6d9caa65995d = 1;
        
        if ( isdefined( attacker.classstruct ) && isdefined( attacker.classstruct.loadoutperks ) )
        {
            foreach ( perk in attacker.classstruct.loadoutperks )
            {
                if ( !var_a4b6d9caa65995d )
                {
                    loadout_perks += "|";
                }
                
                loadout_perks += perk;
                var_a4b6d9caa65995d = 0;
            }
        }
        
        var_b5eec3b49cf346d2 = [ damage, 0 ];
        enemytype = 0;
        
        if ( isplayer( victim ) )
        {
            enemytype |= 1;
        }
        else if ( isagent( victim ) )
        {
            enemytype = return_enemy_type_mask( enemytype, victim );
        }
        
        isground = 0;
        isaerial = 0;
        issupport = 0;
        var_b93834c5c289dcdc = 0;
        
        if ( isdefined( victim.streakinfo ) )
        {
            enemytype |= 2;
            killstreakname = victim.streakinfo.streakname;
            var_b93834c5c289dcdc = iskillstreakvehicle( killstreakname );
            
            switch ( killstreakname )
            {
                case #"hash_4ad475e6e15635bd":
                case #"hash_4d5aa76e8707f47b":
                case #"hash_52d9b7ed584bec3e":
                case #"hash_cf0ef5bef19a311b":
                case #"hash_e477c24ee18bb2f6":
                    isground = 1;
                    break;
                case #"hash_bf2f9adbd2b41d5":
                case #"hash_195360490caa3220":
                case #"hash_28d0236400e33fd0":
                case #"hash_349713b5ad494dda":
                case #"hash_413c38e72fe8b5bf":
                case #"hash_691f39dddd9116b8":
                case #"hash_8c766d6477287bb6":
                case #"hash_b4ac3581c343a029":
                case #"hash_e6bea339d3cbd3e8":
                    isaerial = 1;
                    break;
                case #"hash_27002778019fb447":
                case #"hash_634b246c3da5c56f":
                case #"hash_e171e5b86ef0a4cc":
                case #"hash_f64c697bfb4c6b54":
                    isaerial = 1;
                    issupport = 1;
                    break;
                case #"hash_2289ec11d77bce8f":
                case #"hash_56979e0566996b2e":
                    issupport = 1;
                    break;
            }
            
            if ( isground )
            {
                enemytype |= 8;
            }
            
            if ( isaerial )
            {
                enemytype |= 4;
            }
            
            if ( issupport )
            {
                enemytype |= 16;
            }
        }
        
        if ( isdefined( victim.vehiclename ) || var_b93834c5c289dcdc )
        {
            enemytype |= 32;
            
            if ( !isground && isdefined( victim.vehiclename ) && !istrue( victim scripts\cp_mp\vehicles\vehicle::vehiclecanfly() ) )
            {
                enemytype |= 8;
            }
        }
        
        if ( isdefined( victim.equipmentref ) )
        {
            enemytype |= 64;
        }
        
        var_a5958dc7369199c7 = "";
        
        if ( enemytype == 512 )
        {
            juggernaut_kill_assists_included( attacker, victim, var_b5eec3b49cf346d2, weapons, modifiers1, modifiers2, operators, gametypecol, var_349e390338192305, loadout_perks, enemytype, var_a5958dc7369199c7 );
            return;
        }
        
        attacker reportchallengeuserevent( "kill", var_b5eec3b49cf346d2, weapons, modifiers1, modifiers2, operators, gametypecol, var_349e390338192305, loadout_perks, enemytype, var_a5958dc7369199c7, gettouchinglocaletriggers( attacker, victim ) );
    }
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 2
// Checksum 0x0, Offset: 0xcc8
// Size: 0xdd
function return_enemy_type_mask( enemytype, victim )
{
    type = victim.aitype;
    
    if ( !isdefined( victim.aitype ) )
    {
        if ( isdefined( victim.unittype ) )
        {
            type = victim.unittype;
        }
    }
    
    assertex( isdefined( type ), "<dev string:x1c>" );
    
    switch ( type )
    {
        case #"hash_44aaeb0edd152195":
            enemytype |= 128;
            break;
        case #"hash_4ad475e6e15635bd":
            enemytype |= 512;
            break;
        case #"hash_1403dfb5d1265ddc":
            enemytype |= 1024;
            break;
        case #"hash_321a9678047d0a4e":
            enemytype |= 256;
            break;
        default:
            enemytype |= 128;
            break;
    }
    
    return enemytype;
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 12
// Checksum 0x0, Offset: 0xdae
// Size: 0x1ef, Type: bool
function juggernaut_kill_assists_included( attacker, victim, var_b5eec3b49cf346d2, weapons, modifiers1, modifiers2, operators, gametypecol, var_349e390338192305, loadout_perks, enemytype, var_a5958dc7369199c7 )
{
    if ( enemytype != 512 )
    {
        return false;
    }
    
    if ( isdefined( victim.attackers ) )
    {
        foreach ( player in victim.attackers )
        {
            if ( !isdefined( scripts\cp\agent_damage::_validateattacker( player ) ) )
            {
                continue;
            }
            
            if ( victim == player )
            {
                continue;
            }
            
            if ( isdefined( level.assists_disabled ) )
            {
                continue;
            }
            
            assistweapon = undefined;
            
            if ( isdefined( victim.attackerdata ) )
            {
                attackerdata = victim.attackerdata[ player.guid ];
                
                if ( isdefined( attackerdata ) )
                {
                    assistweapon = attackerdata.objweapon;
                }
            }
            
            bonusmagnitude = 0;
            
            if ( self.attackerdata[ player.guid ].damage >= victim.maxhealth * 0.1 )
            {
                bonusmagnitude = 1;
            }
            
            if ( self.attackerdata[ player.guid ].damage >= victim.maxhealth * 0.2 )
            {
                bonusmagnitude = 2;
            }
            
            if ( bonusmagnitude >= 1 )
            {
                player reportchallengeuserevent( "kill", var_b5eec3b49cf346d2, weapons, modifiers1, modifiers2, operators, gametypecol, var_349e390338192305, loadout_perks, enemytype, var_a5958dc7369199c7, gettouchinglocaletriggers( player, victim ) );
            }
        }
        
        return true;
    }
    
    return false;
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 8
// Checksum 0x0, Offset: 0xfa6
// Size: 0x5a
function ondeath( inflictor, attacker, damage, damageflags, meansofdeath, objweapon, hitloc, modifiers )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    self reportchallengeuserevent( "death", 0 );
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 1
// Checksum 0x0, Offset: 0x1008
// Size: 0x134
function onplayerkillassist( victim )
{
    attacker = self;
    
    if ( !attacker challengesenabledforplayer() )
    {
        return;
    }
    
    if ( !scripts\cp\utility\player::isfriendly( attacker.team, victim ) )
    {
        primaryweapon = "";
        
        if ( isdefined( attacker.primaryweaponobj ) )
        {
            primaryweapon = getdefaultweaponbasename( attacker.primaryweaponobj.basename );
        }
        
        secondaryweapon = "";
        
        if ( isdefined( attacker.secondaryweaponobj ) )
        {
            secondaryweapon = getdefaultweaponbasename( attacker.secondaryweaponobj.basename );
        }
        
        weapons = [ primaryweapon, secondaryweapon ];
        var_b5eec3b49cf346d2 = [ 0, 0 ];
        enemytype = 0;
        
        if ( isplayer( victim ) )
        {
            enemytype |= 1;
        }
        else if ( isagent( victim ) )
        {
            enemytype = return_enemy_type_mask( enemytype, victim );
        }
        
        operators = attacker getoperators();
        attacker reportchallengeuserevent( "assist", var_b5eec3b49cf346d2, weapons, operators );
    }
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 7
// Checksum 0x0, Offset: 0x1144
// Size: 0x12b
function onkillstreakend( ref, duration, currenttime, totalkills, var_eed18a862d3f3954, var_eed18d862d3f3fed, var_eed18c862d3f3dba )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    killstreak = ref;
    time_used = duration;
    current_gametime = currenttime;
    total_kills = totalkills;
    var_4b45015a9a8707e4 = var_eed18a862d3f3954;
    var_4b45045a9a870e7d = var_eed18d862d3f3fed;
    var_4b45035a9a870c4a = var_eed18c862d3f3dba;
    operators = scripts\cp_mp\challenges::getoperators();
    
    if ( !isdefined( total_kills ) )
    {
        total_kills = 0;
    }
    
    switch ( killstreak )
    {
        case #"hash_7725c6315aacaf74":
        case #"hash_d9a3d9c73a2f3976":
        case #"hash_e09c10dfa78ba2cb":
        case #"hash_e220fb363b0f9fbd":
            killstreak = "support_box_mp";
            
            if ( total_kills == 0 )
            {
                total_kills++;
            }
            
            break;
        default:
            break;
    }
    
    self reportchallengeuserevent( "killstreak_end", killstreak, time_used, current_gametime, total_kills, var_4b45015a9a8707e4, var_4b45045a9a870e7d, var_4b45035a9a870c4a, operators );
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 2
// Checksum 0x0, Offset: 0x1277
// Size: 0x6c
function onfieldupgradeendbuffer( ref, value )
{
    field_upgrade = ref;
    
    if ( ref == "super_recon_drone" && isdefined( self.recondronesuper ) )
    {
        if ( isdefined( self.recondronesuper.usedcountinveh ) )
        {
            value = self.recondronesuper.usedcountinveh;
        }
    }
    
    scripts\cp_mp\challenges::function_bd59aa7e8cece1ab( ref, value );
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 2
// Checksum 0x0, Offset: 0x12eb
// Size: 0x43
function onfieldupgradeend( ref, value )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    field_upgrade = ref;
    amount = value;
    self reportchallengeuserevent( "field_end", field_upgrade, amount );
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 1
// Checksum 0x0, Offset: 0x1336
// Size: 0xd6
function oncapture( modifiers )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    modifiers1 = 0;
    modifiers2 = 0;
    
    if ( isdefined( modifiers ) )
    {
        modifiers1 = modifiers[ "mask" ];
        modifiers2 = modifiers[ "mask2" ];
    }
    
    if ( !getdvarint( @"hash_78653010d584aa6e" ) )
    {
        game_type = getgametype();
        
        if ( !isdefined( game_type ) )
        {
            game_type = getdvar( @"g_gametype" );
        }
        
        gametypecol = level.challengeandeventglobals.game_type_col[ game_type ];
    }
    else
    {
        gametypecol = level.challengeandeventglobals.game_type_col[ level.gametypebundle.var_d20acad05758f0d8 ];
    }
    
    self reportchallengeuserevent( "capture", gametypecol, modifiers1, modifiers2 );
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 1
// Checksum 0x0, Offset: 0x1414
// Size: 0xd6
function ondefuse( modifiers )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    modifiers1 = 0;
    modifiers2 = 0;
    
    if ( isdefined( modifiers ) )
    {
        modifiers1 = modifiers[ "mask" ];
        modifiers2 = modifiers[ "mask2" ];
    }
    
    if ( !getdvarint( @"hash_78653010d584aa6e" ) )
    {
        game_type = getgametype();
        
        if ( !isdefined( game_type ) )
        {
            game_type = getdvar( @"g_gametype" );
        }
        
        gametypecol = level.challengeandeventglobals.game_type_col[ game_type ];
    }
    else
    {
        gametypecol = level.challengeandeventglobals.game_type_col[ level.gametypebundle.var_d20acad05758f0d8 ];
    }
    
    self reportchallengeuserevent( "defuse", gametypecol, modifiers1, modifiers2 );
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 1
// Checksum 0x0, Offset: 0x14f2
// Size: 0x76
function onplant( modifiers )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    modifiers1 = 0;
    modifiers2 = 0;
    
    if ( isdefined( modifiers ) )
    {
        modifiers1 = modifiers[ "mask" ];
        modifiers2 = modifiers[ "mask2" ];
    }
    
    gametype = scripts\cp_mp\challenges::function_17c5d7feb226e256();
    operators = getoperators();
    self reportchallengeuserevent( "defuse", gametype, modifiers1, modifiers2, operators );
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 1
// Checksum 0x0, Offset: 0x1570
// Size: 0x22
function onstun( equipment )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    self reportchallengeuserevent( "stun", equipment );
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 1
// Checksum 0x0, Offset: 0x159a
// Size: 0x22
function onstim( health_recovered )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    self reportchallengeuserevent( "stim", health_recovered );
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 1
// Checksum 0x0, Offset: 0x15c4
// Size: 0xcd
function onhack( equipment )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    loadout_perks = "";
    var_a4b6d9caa65995d = 1;
    
    if ( isdefined( self.classstruct ) && isdefined( self.classstruct.loadoutperks ) )
    {
        foreach ( perk in self.classstruct.loadoutperks )
        {
            if ( !var_a4b6d9caa65995d )
            {
                loadout_perks += "|";
            }
            
            loadout_perks += perk;
            var_a4b6d9caa65995d = 0;
        }
    }
    
    self reportchallengeuserevent( "hack", equipment, loadout_perks );
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 2
// Checksum 0x0, Offset: 0x1699
// Size: 0xcd
function gettouchinglocaletriggers( attacker, victim )
{
    buffer = "";
    
    if ( !isdefined( level.localetriggers ) )
    {
        return buffer;
    }
    
    found = 0;
    
    foreach ( trigger in level.localetriggers )
    {
        if ( attacker istouching( trigger ) || victim istouching( trigger ) )
        {
            if ( isdefined( trigger.localeid ) )
            {
                if ( found )
                {
                    buffer += "|";
                }
                
                buffer += trigger.localeid;
                found = 1;
            }
        }
    }
    
    return buffer;
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 2
// Checksum 0x0, Offset: 0x176f
// Size: 0x13
function onplayerteamrevive( reviver, revivee )
{
    
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 1
// Checksum 0x0, Offset: 0x178a
// Size: 0xb
function onsuccessfulhit( objweapon )
{
    
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 0
// Checksum 0x0, Offset: 0x179d
// Size: 0x2
function onspawn()
{
    
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 2
// Checksum 0x0, Offset: 0x17a7
// Size: 0x13
function updatesuperweaponkills( objweapon, inflictor )
{
    
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 3
// Checksum 0x0, Offset: 0x17c2
// Size: 0x1b
function updatesuperkills( superref, meansofdeath, var_b34cda8a56dd46c5 )
{
    
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 1
// Checksum 0x0, Offset: 0x17e5
// Size: 0xb
function resistedstun( attacker )
{
    
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 0
// Checksum 0x0, Offset: 0x17f8
// Size: 0x2
function triggereddelayedexplosion()
{
    
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 3
// Checksum 0x0, Offset: 0x1802
// Size: 0x1b
function minedestroyed( mine, attacker, type )
{
    
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 0
// Checksum 0x0, Offset: 0x1825
// Size: 0x2
function roundbegin()
{
    
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 1
// Checksum 0x0, Offset: 0x182f
// Size: 0xb
function roundend( winnerstring )
{
    
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 6
// Checksum 0x0, Offset: 0x1842
// Size: 0x33
function playerdamaged( inflictor, attacker, damage, meansofdeath, objweapon, shitloc )
{
    
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 2
// Checksum 0x0, Offset: 0x187d
// Size: 0x13
function processuavassist( owner, uavtype )
{
    
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 5
// Checksum 0x0, Offset: 0x1898
// Size: 0x2b
function killstreakdamaged( killstreakname, owner, attacker, weapon, damage )
{
    
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 8
// Checksum 0x0, Offset: 0x18cb
// Size: 0x680
function killstreakkilled( killstreakname, owner, streakent, attacker, damage, damagetype, objweapon, scorepopupname )
{
    if ( !attacker challengesenabledforplayer() )
    {
        return;
    }
    
    victim = self;
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    if ( !isdefined( victim.owner ) )
    {
        return;
    }
    
    if ( !scripts\cp\utility\player::isfriendly( attacker.team, victim.owner ) )
    {
        equipmentname = scripts\cp_mp\equipment::getequipmentreffromweapon( objweapon );
        
        if ( !isdefined( equipmentname ) )
        {
            equipmentname = getdefaultweaponbasename( objweapon.basename );
        }
        
        var_6747b178b5fc3b95 = "";
        
        if ( isdefined( attacker.secondaryweaponobj ) )
        {
            if ( objweapon == attacker.primaryweaponobj )
            {
                var_6747b178b5fc3b95 = getdefaultweaponbasename( attacker.secondaryweaponobj.basename );
            }
            else if ( objweapon == attacker.secondaryweaponobj )
            {
                var_6747b178b5fc3b95 = getdefaultweaponbasename( attacker.primaryweaponobj.basename );
            }
        }
        
        weapons = [ equipmentname, var_6747b178b5fc3b95 ];
        modifiers1 = 0;
        modifiers2 = 0;
        
        if ( isdefined( attacker.modifiers ) )
        {
            modifiers1 = attacker.modifiers[ "mask" ];
            modifiers2 = attacker.modifiers[ "mask2" ];
        }
        
        operators = [ attacker scripts\cp\loadout::lookupcurrentoperator( attacker.team ), attacker scripts\cp\loadout::lookupotheroperator( attacker.team ) ];
        
        if ( !getdvarint( @"hash_78653010d584aa6e" ) )
        {
            game_type = getgametype();
            
            if ( !isdefined( game_type ) )
            {
                game_type = getdvar( @"g_gametype" );
            }
            
            gametypecol = level.challengeandeventglobals.game_type_col[ game_type ];
        }
        else
        {
            gametypecol = level.challengeandeventglobals.game_type_col[ level.gametypebundle.var_d20acad05758f0d8 ];
        }
        
        var_349e390338192305 = "";
        var_c832cc337856aca8 = 1;
        
        if ( isdefined( objweapon.attachments ) )
        {
            var_7208e21ea18240fb = 0;
            
            foreach ( attachment in objweapon.attachments )
            {
                if ( issubstr( attachment, "snprscope" ) )
                {
                    var_7208e21ea18240fb = 1;
                }
                
                if ( scripts\cp\weapon::attachmentisselectable( objweapon, attachment ) )
                {
                    if ( issubstr( attachment, "snprscope" ) )
                    {
                        attachment = "default_sniper_scope";
                    }
                    
                    if ( !var_c832cc337856aca8 )
                    {
                        var_349e390338192305 += "|";
                    }
                    
                    var_349e390338192305 += attachment;
                    var_c832cc337856aca8 = 0;
                }
            }
            
            if ( var_7208e21ea18240fb )
            {
                if ( !var_c832cc337856aca8 )
                {
                    var_349e390338192305 += "|";
                }
                
                var_349e390338192305 += "default_sniper_scope";
            }
        }
        
        loadout_perks = "";
        var_a4b6d9caa65995d = 1;
        
        if ( isdefined( attacker.classstruct ) && isdefined( attacker.classstruct.loadoutperks ) )
        {
            foreach ( perk in attacker.classstruct.loadoutperks )
            {
                if ( !var_a4b6d9caa65995d )
                {
                    loadout_perks += "|";
                }
                
                loadout_perks += perk;
                var_a4b6d9caa65995d = 0;
            }
        }
        
        var_b5eec3b49cf346d2 = [ damage, 0 ];
        enemytype = 0;
        
        if ( isplayer( victim ) )
        {
            enemytype |= 1;
        }
        else if ( isagent( victim ) )
        {
            enemytype = return_enemy_type_mask( enemytype, victim );
        }
        
        isground = 0;
        isaerial = 0;
        issupport = 0;
        var_b93834c5c289dcdc = 0;
        
        if ( isdefined( victim.streakinfo ) )
        {
            enemytype |= 2;
            killstreakname = victim.streakinfo.streakname;
            var_b93834c5c289dcdc = iskillstreakvehicle( killstreakname );
            
            switch ( killstreakname )
            {
                case #"hash_4ad475e6e15635bd":
                case #"hash_4d5aa76e8707f47b":
                case #"hash_52d9b7ed584bec3e":
                case #"hash_cf0ef5bef19a311b":
                case #"hash_e477c24ee18bb2f6":
                    isground = 1;
                    break;
                case #"hash_bf2f9adbd2b41d5":
                case #"hash_195360490caa3220":
                case #"hash_28d0236400e33fd0":
                case #"hash_349713b5ad494dda":
                case #"hash_413c38e72fe8b5bf":
                case #"hash_691f39dddd9116b8":
                case #"hash_8c766d6477287bb6":
                case #"hash_b4ac3581c343a029":
                case #"hash_e6bea339d3cbd3e8":
                    isaerial = 1;
                    break;
                case #"hash_27002778019fb447":
                case #"hash_634b246c3da5c56f":
                case #"hash_e171e5b86ef0a4cc":
                case #"hash_f64c697bfb4c6b54":
                    isaerial = 1;
                    issupport = 1;
                    break;
                case #"hash_2289ec11d77bce8f":
                case #"hash_56979e0566996b2e":
                    issupport = 1;
                    break;
            }
            
            if ( isground )
            {
                enemytype |= 8;
            }
            
            if ( isaerial )
            {
                enemytype |= 4;
            }
            
            if ( issupport )
            {
                enemytype |= 16;
            }
        }
        
        if ( isdefined( victim.vehiclename ) || var_b93834c5c289dcdc )
        {
            enemytype |= 32;
            
            if ( !isground && isdefined( victim.vehiclename ) && !istrue( victim scripts\cp_mp\vehicles\vehicle::vehiclecanfly() ) )
            {
                enemytype |= 8;
            }
        }
        
        if ( isdefined( victim.equipmentref ) )
        {
            enemytype |= 64;
        }
        
        var_a5958dc7369199c7 = "";
        attacker reportchallengeuserevent( "kill", var_b5eec3b49cf346d2, weapons, modifiers1, modifiers2, operators, gametypecol, var_349e390338192305, loadout_perks, enemytype, var_a5958dc7369199c7, gettouchinglocaletriggers( attacker, victim ) );
    }
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 1
// Checksum 0x0, Offset: 0x1f53
// Size: 0x48, Type: bool
function iskillstreakvehicle( killstreakname )
{
    switch ( killstreakname )
    {
        case #"hash_28d0236400e33fd0":
        case #"hash_4ad475e6e15635bd":
        case #"hash_4d5aa76e8707f47b":
        case #"hash_52d9b7ed584bec3e":
            return false;
    }
    
    return true;
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 8
// Checksum 0x0, Offset: 0x1fa4
// Size: 0x667
function equipmentdestroyed( inflictor, attacker, damage, damageflags, meansofdeath, objweapon, hitloc, modifiers )
{
    if ( !attacker challengesenabledforplayer() )
    {
        return;
    }
    
    victim = self;
    
    if ( !isplayer( attacker ) )
    {
        if ( isdefined( inflictor ) && isplayer( inflictor ) )
        {
            attacker = inflictor;
        }
        else
        {
            return;
        }
    }
    
    if ( !isdefined( victim.owner ) )
    {
        return;
    }
    
    if ( !scripts\cp\utility\player::isfriendly( attacker.team, victim.owner ) )
    {
        equipmentname = scripts\cp_mp\equipment::getequipmentreffromweapon( objweapon );
        
        if ( !isdefined( equipmentname ) )
        {
            equipmentname = getdefaultweaponbasename( objweapon.basename );
        }
        
        var_6747b178b5fc3b95 = "";
        
        if ( objweapon == attacker.primaryweaponobj )
        {
            var_6747b178b5fc3b95 = getdefaultweaponbasename( attacker.secondaryweaponobj.basename );
        }
        else if ( objweapon == attacker.secondaryweaponobj )
        {
            var_6747b178b5fc3b95 = getdefaultweaponbasename( attacker.primaryweaponobj.basename );
        }
        
        weapons = [ equipmentname, var_6747b178b5fc3b95 ];
        modifiers1 = 0;
        modifiers2 = 0;
        
        if ( isdefined( modifiers ) )
        {
            modifiers1 = modifiers[ "mask" ];
            modifiers2 = modifiers[ "mask2" ];
        }
        
        operators = [ attacker scripts\cp\loadout::lookupcurrentoperator( attacker.team ), attacker scripts\cp\loadout::lookupotheroperator( attacker.team ) ];
        
        if ( !getdvarint( @"hash_78653010d584aa6e" ) )
        {
            game_type = getgametype();
            
            if ( !isdefined( game_type ) )
            {
                game_type = getdvar( @"g_gametype" );
            }
            
            gametypecol = level.challengeandeventglobals.game_type_col[ game_type ];
        }
        else
        {
            gametypecol = level.challengeandeventglobals.game_type_col[ level.gametypebundle.var_d20acad05758f0d8 ];
        }
        
        var_349e390338192305 = "";
        var_c832cc337856aca8 = 1;
        
        if ( isdefined( objweapon.attachments ) )
        {
            var_7208e21ea18240fb = 0;
            
            foreach ( attachment in objweapon.attachments )
            {
                if ( issubstr( attachment, "snprscope" ) )
                {
                    var_7208e21ea18240fb = 1;
                }
                
                if ( scripts\cp\weapon::attachmentisselectable( objweapon, attachment ) )
                {
                    if ( !var_c832cc337856aca8 )
                    {
                        var_349e390338192305 += "|";
                    }
                    
                    var_349e390338192305 += attachment;
                    var_c832cc337856aca8 = 0;
                }
            }
            
            if ( var_7208e21ea18240fb )
            {
                if ( !var_c832cc337856aca8 )
                {
                    var_349e390338192305 += "|";
                }
                
                var_349e390338192305 += "default_sniper_scope";
            }
        }
        
        loadout_perks = "";
        var_a4b6d9caa65995d = 1;
        
        if ( isdefined( attacker.classstruct ) && isdefined( attacker.classstruct.loadoutperks ) )
        {
            foreach ( perk in attacker.classstruct.loadoutperks )
            {
                if ( !var_a4b6d9caa65995d )
                {
                    loadout_perks += "|";
                }
                
                loadout_perks += perk;
                var_a4b6d9caa65995d = 0;
            }
        }
        
        var_b5eec3b49cf346d2 = [ damage, 0 ];
        enemytype = 0;
        
        if ( isplayer( victim ) )
        {
            enemytype |= 1;
        }
        else if ( isagent( victim ) )
        {
            enemytype = return_enemy_type_mask( enemytype, victim );
        }
        
        isground = 0;
        isaerial = 0;
        issupport = 0;
        var_b93834c5c289dcdc = 0;
        
        if ( isdefined( victim.streakinfo ) )
        {
            enemytype |= 2;
            killstreakname = victim.streakinfo.streakname;
            var_b93834c5c289dcdc = iskillstreakvehicle( killstreakname );
            
            switch ( killstreakname )
            {
                case #"hash_4ad475e6e15635bd":
                case #"hash_4d5aa76e8707f47b":
                case #"hash_52d9b7ed584bec3e":
                case #"hash_cf0ef5bef19a311b":
                case #"hash_e477c24ee18bb2f6":
                    isground = 1;
                    break;
                case #"hash_bf2f9adbd2b41d5":
                case #"hash_195360490caa3220":
                case #"hash_28d0236400e33fd0":
                case #"hash_349713b5ad494dda":
                case #"hash_413c38e72fe8b5bf":
                case #"hash_691f39dddd9116b8":
                case #"hash_8c766d6477287bb6":
                case #"hash_b4ac3581c343a029":
                case #"hash_e6bea339d3cbd3e8":
                    isaerial = 1;
                    break;
                case #"hash_27002778019fb447":
                case #"hash_634b246c3da5c56f":
                case #"hash_e171e5b86ef0a4cc":
                case #"hash_f64c697bfb4c6b54":
                    isaerial = 1;
                    issupport = 1;
                    break;
                case #"hash_2289ec11d77bce8f":
                case #"hash_56979e0566996b2e":
                    issupport = 1;
                    break;
            }
            
            if ( isground )
            {
                enemytype |= 8;
            }
            
            if ( isaerial )
            {
                enemytype |= 4;
            }
            
            if ( issupport )
            {
                enemytype |= 16;
            }
        }
        
        if ( isdefined( victim.vehiclename ) || var_b93834c5c289dcdc )
        {
            enemytype |= 32;
            
            if ( !isground && isdefined( victim.vehiclename ) && !istrue( victim scripts\cp_mp\vehicles\vehicle::vehiclecanfly() ) )
            {
                enemytype |= 8;
            }
        }
        
        if ( isdefined( victim.equipmentref ) )
        {
            enemytype |= 64;
        }
        
        var_a5958dc7369199c7 = "";
        attacker reportchallengeuserevent( "kill", var_b5eec3b49cf346d2, weapons, modifiers1, modifiers2, operators, gametypecol, var_349e390338192305, loadout_perks, enemytype, var_a5958dc7369199c7, gettouchinglocaletriggers( attacker, victim ) );
    }
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 4
// Checksum 0x0, Offset: 0x2613
// Size: 0x629
function vehiclekilled( vehicle, attacker, damage, objweapon )
{
    if ( !attacker challengesenabledforplayer() )
    {
        return;
    }
    
    victim = vehicle;
    equipmentname = scripts\cp_mp\equipment::getequipmentreffromweapon( objweapon );
    
    if ( !isdefined( equipmentname ) )
    {
        equipmentname = getdefaultweaponbasename( objweapon.basename );
    }
    
    var_6747b178b5fc3b95 = "";
    
    if ( objweapon == attacker.primaryweaponobj )
    {
        var_6747b178b5fc3b95 = getdefaultweaponbasename( attacker.secondaryweaponobj.basename );
    }
    else if ( objweapon == attacker.secondaryweaponobj )
    {
        var_6747b178b5fc3b95 = getdefaultweaponbasename( attacker.primaryweaponobj.basename );
    }
    
    weapons = [ equipmentname, var_6747b178b5fc3b95 ];
    modifiers1 = 0;
    modifiers2 = 0;
    
    if ( isdefined( attacker.modifiers ) )
    {
        modifiers1 = attacker.modifiers[ "mask" ];
        modifiers2 = attacker.modifiers[ "mask2" ];
    }
    
    operators = [ attacker scripts\cp\loadout::lookupcurrentoperator( attacker.team ), attacker scripts\cp\loadout::lookupotheroperator( attacker.team ) ];
    
    if ( !getdvarint( @"hash_78653010d584aa6e" ) )
    {
        game_type = getgametype();
        
        if ( !isdefined( game_type ) )
        {
            game_type = getdvar( @"g_gametype" );
        }
        
        gametypecol = level.challengeandeventglobals.game_type_col[ game_type ];
    }
    else
    {
        gametypecol = level.challengeandeventglobals.game_type_col[ level.gametypebundle.var_d20acad05758f0d8 ];
    }
    
    var_349e390338192305 = "";
    var_c832cc337856aca8 = 1;
    
    if ( isdefined( objweapon.attachments ) )
    {
        var_7208e21ea18240fb = 0;
        
        foreach ( attachment in objweapon.attachments )
        {
            if ( issubstr( attachment, "snprscope" ) )
            {
                var_7208e21ea18240fb = 1;
            }
            
            if ( scripts\cp\weapon::attachmentisselectable( objweapon, attachment ) )
            {
                if ( issubstr( attachment, "snprscope" ) )
                {
                    attachment = "default_sniper_scope";
                }
                
                if ( !var_c832cc337856aca8 )
                {
                    var_349e390338192305 += "|";
                }
                
                var_349e390338192305 += attachment;
                var_c832cc337856aca8 = 0;
            }
        }
        
        if ( var_7208e21ea18240fb )
        {
            if ( !var_c832cc337856aca8 )
            {
                var_349e390338192305 += "|";
            }
            
            var_349e390338192305 += "default_sniper_scope";
        }
    }
    
    loadout_perks = "";
    var_a4b6d9caa65995d = 1;
    
    if ( isdefined( attacker.classstruct ) && isdefined( attacker.classstruct.loadoutperks ) )
    {
        foreach ( perk in attacker.classstruct.loadoutperks )
        {
            if ( !var_a4b6d9caa65995d )
            {
                loadout_perks += "|";
            }
            
            loadout_perks += perk;
            var_a4b6d9caa65995d = 0;
        }
    }
    
    var_b5eec3b49cf346d2 = [ damage, 0 ];
    enemytype = 0;
    
    if ( isplayer( victim ) )
    {
        enemytype |= 1;
    }
    else if ( isagent( victim ) )
    {
        enemytype = return_enemy_type_mask( enemytype, victim );
    }
    
    isground = 0;
    isaerial = 0;
    issupport = 0;
    var_b93834c5c289dcdc = 0;
    
    if ( isdefined( victim.streakinfo ) )
    {
        enemytype |= 2;
        killstreakname = victim.streakinfo.streakname;
        var_b93834c5c289dcdc = iskillstreakvehicle( killstreakname );
        
        switch ( killstreakname )
        {
            case #"hash_4ad475e6e15635bd":
            case #"hash_4d5aa76e8707f47b":
            case #"hash_52d9b7ed584bec3e":
            case #"hash_cf0ef5bef19a311b":
            case #"hash_e477c24ee18bb2f6":
                isground = 1;
                break;
            case #"hash_bf2f9adbd2b41d5":
            case #"hash_195360490caa3220":
            case #"hash_28d0236400e33fd0":
            case #"hash_349713b5ad494dda":
            case #"hash_413c38e72fe8b5bf":
            case #"hash_691f39dddd9116b8":
            case #"hash_8c766d6477287bb6":
            case #"hash_b4ac3581c343a029":
            case #"hash_e6bea339d3cbd3e8":
                isaerial = 1;
                break;
            case #"hash_27002778019fb447":
            case #"hash_634b246c3da5c56f":
            case #"hash_e171e5b86ef0a4cc":
            case #"hash_f64c697bfb4c6b54":
                isaerial = 1;
                issupport = 1;
                break;
            case #"hash_2289ec11d77bce8f":
            case #"hash_56979e0566996b2e":
                issupport = 1;
                break;
        }
        
        if ( isground )
        {
            enemytype |= 8;
        }
        
        if ( isaerial )
        {
            enemytype |= 4;
        }
        
        if ( issupport )
        {
            enemytype |= 16;
        }
    }
    
    if ( isdefined( victim.vehiclename ) || var_b93834c5c289dcdc )
    {
        enemytype |= 32;
        
        if ( !isground && isdefined( victim.vehiclename ) && !istrue( victim scripts\cp_mp\vehicles\vehicle::vehiclecanfly() ) )
        {
            enemytype |= 8;
        }
    }
    
    if ( isdefined( victim.equipmentref ) )
    {
        enemytype |= 64;
    }
    
    var_a5958dc7369199c7 = "";
    attacker reportchallengeuserevent( "kill", var_b5eec3b49cf346d2, weapons, modifiers1, modifiers2, operators, gametypecol, var_349e390338192305, loadout_perks, enemytype, var_a5958dc7369199c7, gettouchinglocaletriggers( attacker, victim ) );
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 2
// Checksum 0x0, Offset: 0x2c44
// Size: 0x13
function processfinalkillchallenges( attacker, victim )
{
    
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 1
// Checksum 0x0, Offset: 0x2c5f
// Size: 0xb
function usedkillstreak( streakname )
{
    
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 0
// Checksum 0x0, Offset: 0x2c72
// Size: 0x36
function getoperators()
{
    operators = [];
    operators[ 0 ] = scripts\cp\loadout::lookupcurrentoperator( self.team );
    operators[ 1 ] = scripts\cp\loadout::lookupotheroperator( self.team );
    return operators;
}

// Namespace cp_challenge / scripts\cp\cp_challenge
// Params 8
// Checksum 0x0, Offset: 0x2cb1
// Size: 0x65d
function onplayerkillednew( inflictor, attacker, damage, damageflags, meansofdeath, objweapon, hitloc, modifiers )
{
    if ( !attacker challengesenabledforplayer() )
    {
        return;
    }
    
    victim = self;
    
    if ( !isplayer( attacker ) )
    {
        if ( isdefined( inflictor ) && isplayer( inflictor ) )
        {
            attacker = inflictor;
        }
        else
        {
            return;
        }
    }
    
    if ( !scripts\cp\utility\player::isfriendly( attacker.team, victim ) )
    {
        equipmentname = scripts\cp_mp\equipment::getequipmentreffromweapon( objweapon );
        
        if ( !isdefined( equipmentname ) )
        {
            equipmentname = getdefaultweaponbasename( objweapon.basename );
        }
        
        var_6747b178b5fc3b95 = "";
        
        if ( isdefined( attacker.secondaryweaponobj ) )
        {
            if ( objweapon == attacker.primaryweaponobj )
            {
                var_6747b178b5fc3b95 = getdefaultweaponbasename( attacker.secondaryweaponobj.basename );
            }
            else if ( objweapon == attacker.secondaryweaponobj )
            {
                var_6747b178b5fc3b95 = getdefaultweaponbasename( attacker.primaryweaponobj.basename );
            }
        }
        
        weapons = [ equipmentname, var_6747b178b5fc3b95 ];
        modifiers1 = 0;
        modifiers2 = 0;
        
        if ( isdefined( modifiers ) )
        {
            modifiers1 = modifiers[ "mask" ];
            modifiers2 = modifiers[ "mask2" ];
        }
        
        operators = [ attacker scripts\cp\loadout::lookupcurrentoperator( attacker.team ), attacker scripts\cp\loadout::lookupotheroperator( attacker.team ) ];
        
        if ( !getdvarint( @"hash_78653010d584aa6e" ) )
        {
            game_type = getgametype();
            
            if ( !isdefined( game_type ) )
            {
                game_type = getdvar( @"g_gametype" );
            }
            
            gametypecol = level.challengeandeventglobals.game_type_col[ game_type ];
        }
        else
        {
            gametypecol = level.challengeandeventglobals.game_type_col[ level.gametypebundle.var_d20acad05758f0d8 ];
        }
        
        var_349e390338192305 = "";
        var_c832cc337856aca8 = 1;
        
        if ( isdefined( objweapon.attachments ) )
        {
            var_7208e21ea18240fb = 0;
            
            foreach ( attachment in objweapon.attachments )
            {
                if ( issubstr( attachment, "snprscope" ) )
                {
                    var_7208e21ea18240fb = 1;
                }
                
                if ( scripts\cp\weapon::attachmentisselectable( objweapon, attachment ) )
                {
                    if ( !var_c832cc337856aca8 )
                    {
                        var_349e390338192305 += "|";
                    }
                    
                    var_349e390338192305 += attachment;
                    var_c832cc337856aca8 = 0;
                }
            }
            
            if ( var_7208e21ea18240fb )
            {
                if ( !var_c832cc337856aca8 )
                {
                    var_349e390338192305 += "|";
                }
                
                var_349e390338192305 += "default_sniper_scope";
            }
        }
        
        loadout_perks = "";
        var_a4b6d9caa65995d = 1;
        
        if ( isdefined( attacker.classstruct ) && isdefined( attacker.classstruct.loadoutperks ) )
        {
            foreach ( perk in attacker.classstruct.loadoutperks )
            {
                if ( !var_a4b6d9caa65995d )
                {
                    loadout_perks += "|";
                }
                
                loadout_perks += perk;
                var_a4b6d9caa65995d = 0;
            }
        }
        
        var_b5eec3b49cf346d2 = [ damage, 0 ];
        enemytype = 0;
        
        if ( isplayer( victim ) )
        {
            enemytype |= 1;
        }
        else if ( isagent( victim ) )
        {
            enemytype = return_enemy_type_mask( enemytype, victim );
        }
        
        isground = 0;
        isaerial = 0;
        issupport = 0;
        var_b93834c5c289dcdc = 0;
        
        if ( isdefined( victim.streakinfo ) )
        {
            enemytype |= 2;
            killstreakname = victim.streakinfo.streakname;
            var_b93834c5c289dcdc = iskillstreakvehicle( killstreakname );
            
            switch ( killstreakname )
            {
                case #"hash_4ad475e6e15635bd":
                case #"hash_4d5aa76e8707f47b":
                case #"hash_52d9b7ed584bec3e":
                case #"hash_cf0ef5bef19a311b":
                case #"hash_e477c24ee18bb2f6":
                    isground = 1;
                    break;
                case #"hash_bf2f9adbd2b41d5":
                case #"hash_195360490caa3220":
                case #"hash_28d0236400e33fd0":
                case #"hash_349713b5ad494dda":
                case #"hash_413c38e72fe8b5bf":
                case #"hash_691f39dddd9116b8":
                case #"hash_8c766d6477287bb6":
                case #"hash_b4ac3581c343a029":
                case #"hash_e6bea339d3cbd3e8":
                    isaerial = 1;
                    break;
                case #"hash_27002778019fb447":
                case #"hash_634b246c3da5c56f":
                case #"hash_e171e5b86ef0a4cc":
                case #"hash_f64c697bfb4c6b54":
                    isaerial = 1;
                    issupport = 1;
                    break;
                case #"hash_2289ec11d77bce8f":
                case #"hash_56979e0566996b2e":
                    issupport = 1;
                    break;
            }
            
            if ( isground )
            {
                enemytype |= 8;
            }
            
            if ( isaerial )
            {
                enemytype |= 4;
            }
            
            if ( issupport )
            {
                enemytype |= 16;
            }
        }
        
        if ( isdefined( victim.vehiclename ) || var_b93834c5c289dcdc )
        {
            enemytype |= 32;
            
            if ( !isground && isdefined( victim.vehiclename ) && !istrue( victim scripts\cp_mp\vehicles\vehicle::vehiclecanfly() ) )
            {
                enemytype |= 8;
            }
        }
        
        if ( isdefined( victim.equipmentref ) )
        {
            enemytype |= 64;
        }
        
        var_a5958dc7369199c7 = "";
        attacker reportchallengeuserevent( "kill", var_b5eec3b49cf346d2, weapons, modifiers1, modifiers2, operators, gametypecol, var_349e390338192305, loadout_perks, enemytype, var_a5958dc7369199c7, gettouchinglocaletriggers( attacker, victim ) );
    }
}

