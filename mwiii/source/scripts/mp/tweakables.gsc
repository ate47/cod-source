#using scripts\engine\utility;

#namespace tweakables;

// Namespace tweakables / scripts\mp\tweakables
// Params 2
// Checksum 0x0, Offset: 0x357
// Size: 0x184
function gettweakabledvarvalue( category, name )
{
    switch ( category )
    {
        case #"hash_8e9d608fb4870733":
            dvar = level.rules[ name ].dvar;
            break;
        case #"hash_7f3b480f12a29d67":
            dvar = level.gametweaks[ name ].dvar;
            break;
        case #"hash_33857c6e26098e6c":
            dvar = level.teamtweaks[ name ].dvar;
            break;
        case #"hash_87d1443ef2805760":
            dvar = level.playertweaks[ name ].dvar;
            break;
        case #"hash_cde859b8cc88ecdf":
            dvar = level.classtweaks[ name ].dvar;
            break;
        case #"hash_27124c6c97ccffa1":
            dvar = level.weapontweaks[ name ].dvar;
            break;
        case #"hash_efa87aad60239272":
            dvar = level.hardpointtweaks[ name ].dvar;
            break;
        case #"hash_4e4ad96c32f7d3a6":
            dvar = level.hudtweaks[ name ].dvar;
            break;
        default:
            dvar = undefined;
            break;
    }
    
    assert( isdefined( dvar ) );
    value = getdvarint( dvar );
    return value;
}

// Namespace tweakables / scripts\mp\tweakables
// Params 2
// Checksum 0x0, Offset: 0x4e4
// Size: 0x174
function gettweakabledvar( category, name )
{
    switch ( category )
    {
        case #"hash_8e9d608fb4870733":
            value = level.rules[ name ].dvar;
            break;
        case #"hash_7f3b480f12a29d67":
            value = level.gametweaks[ name ].dvar;
            break;
        case #"hash_33857c6e26098e6c":
            value = level.teamtweaks[ name ].dvar;
            break;
        case #"hash_87d1443ef2805760":
            value = level.playertweaks[ name ].dvar;
            break;
        case #"hash_cde859b8cc88ecdf":
            value = level.classtweaks[ name ].dvar;
            break;
        case #"hash_27124c6c97ccffa1":
            value = level.weapontweaks[ name ].dvar;
            break;
        case #"hash_efa87aad60239272":
            value = level.hardpointtweaks[ name ].dvar;
            break;
        case #"hash_4e4ad96c32f7d3a6":
            value = level.hudtweaks[ name ].dvar;
            break;
        default:
            value = undefined;
            break;
    }
    
    assert( isdefined( value ) );
    return value;
}

// Namespace tweakables / scripts\mp\tweakables
// Params 2
// Checksum 0x0, Offset: 0x661
// Size: 0x1e7
function gettweakablevalue( category, name )
{
    switch ( category )
    {
        case #"hash_8e9d608fb4870733":
            value = level.rules[ name ].value;
            break;
        case #"hash_7f3b480f12a29d67":
            value = level.gametweaks[ name ].value;
            break;
        case #"hash_33857c6e26098e6c":
            value = level.teamtweaks[ name ].value;
            break;
        case #"hash_87d1443ef2805760":
            value = level.playertweaks[ name ].value;
            break;
        case #"hash_cde859b8cc88ecdf":
            value = level.classtweaks[ name ].value;
            break;
        case #"hash_27124c6c97ccffa1":
            value = level.weapontweaks[ name ].value;
            break;
        case #"hash_efa87aad60239272":
            value = level.hardpointtweaks[ name ].value;
            break;
        case #"hash_4e4ad96c32f7d3a6":
            value = level.hudtweaks[ name ].value;
            break;
        default:
            value = undefined;
            break;
    }
    
    /#
        if ( scripts\engine\utility::issharedfuncdefined( "<dev string:x1c>", "<dev string:x24>" ) )
        {
            gametype = [[ scripts\engine\utility::getsharedfunc( "<dev string:x1c>", "<dev string:x24>" ) ]]();
            overridedvar = hashcat( @"scr_", gametype, "<dev string:x33>", category, "<dev string:x33>", name );
            
            if ( isstring( value ) )
            {
                return getdvar( overridedvar, value );
            }
            else
            {
                return getdvarint( overridedvar, value );
            }
        }
    #/
    
    assert( isdefined( value ) );
    return value;
}

// Namespace tweakables / scripts\mp\tweakables
// Params 2
// Checksum 0x0, Offset: 0x851
// Size: 0x174
function gettweakablelastvalue( category, name )
{
    switch ( category )
    {
        case #"hash_8e9d608fb4870733":
            value = level.rules[ name ].lastvalue;
            break;
        case #"hash_7f3b480f12a29d67":
            value = level.gametweaks[ name ].lastvalue;
            break;
        case #"hash_33857c6e26098e6c":
            value = level.teamtweaks[ name ].lastvalue;
            break;
        case #"hash_87d1443ef2805760":
            value = level.playertweaks[ name ].lastvalue;
            break;
        case #"hash_cde859b8cc88ecdf":
            value = level.classtweaks[ name ].lastvalue;
            break;
        case #"hash_27124c6c97ccffa1":
            value = level.weapontweaks[ name ].lastvalue;
            break;
        case #"hash_efa87aad60239272":
            value = level.hardpointtweaks[ name ].lastvalue;
            break;
        case #"hash_4e4ad96c32f7d3a6":
            value = level.hudtweaks[ name ].lastvalue;
            break;
        default:
            value = undefined;
            break;
    }
    
    assert( isdefined( value ) );
    return value;
}

// Namespace tweakables / scripts\mp\tweakables
// Params 3
// Checksum 0x0, Offset: 0x9ce
// Size: 0x178
function settweakabledvar( category, name, value )
{
    switch ( category )
    {
        case #"hash_8e9d608fb4870733":
            dvar = level.rules[ name ].dvar;
            break;
        case #"hash_7f3b480f12a29d67":
            dvar = level.gametweaks[ name ].dvar;
            break;
        case #"hash_33857c6e26098e6c":
            dvar = level.teamtweaks[ name ].dvar;
            break;
        case #"hash_87d1443ef2805760":
            dvar = level.playertweaks[ name ].dvar;
            break;
        case #"hash_cde859b8cc88ecdf":
            dvar = level.classtweaks[ name ].dvar;
            break;
        case #"hash_27124c6c97ccffa1":
            dvar = level.weapontweaks[ name ].dvar;
            break;
        case #"hash_efa87aad60239272":
            dvar = level.hardpointtweaks[ name ].dvar;
            break;
        case #"hash_4e4ad96c32f7d3a6":
            dvar = level.hudtweaks[ name ].dvar;
            break;
        default:
            dvar = undefined;
            break;
    }
    
    setdvar( dvar, value );
}

// Namespace tweakables / scripts\mp\tweakables
// Params 3
// Checksum 0x0, Offset: 0xb4e
// Size: 0x163
function settweakablevalue( category, name, value )
{
    switch ( category )
    {
        case #"hash_8e9d608fb4870733":
            level.rules[ name ].value = value;
            break;
        case #"hash_7f3b480f12a29d67":
            level.gametweaks[ name ].value = value;
            break;
        case #"hash_33857c6e26098e6c":
            level.teamtweaks[ name ].value = value;
            break;
        case #"hash_87d1443ef2805760":
            level.playertweaks[ name ].value = value;
            break;
        case #"hash_cde859b8cc88ecdf":
            level.classtweaks[ name ].value = value;
            break;
        case #"hash_27124c6c97ccffa1":
            level.weapontweaks[ name ].value = value;
            break;
        case #"hash_efa87aad60239272":
            level.hardpointtweaks[ name ].value = value;
            break;
        case #"hash_4e4ad96c32f7d3a6":
            level.hudtweaks[ name ].v = value;
            break;
        default:
            break;
    }
}

// Namespace tweakables / scripts\mp\tweakables
// Params 3
// Checksum 0x0, Offset: 0xcb9
// Size: 0x163
function settweakablelastvalue( category, name, value )
{
    switch ( category )
    {
        case #"hash_8e9d608fb4870733":
            level.rules[ name ].lastvalue = value;
            break;
        case #"hash_7f3b480f12a29d67":
            level.gametweaks[ name ].lastvalue = value;
            break;
        case #"hash_33857c6e26098e6c":
            level.teamtweaks[ name ].lastvalue = value;
            break;
        case #"hash_87d1443ef2805760":
            level.playertweaks[ name ].lastvalue = value;
            break;
        case #"hash_cde859b8cc88ecdf":
            level.classtweaks[ name ].lastvalue = value;
            break;
        case #"hash_27124c6c97ccffa1":
            level.weapontweaks[ name ].lastvalue = value;
            break;
        case #"hash_efa87aad60239272":
            level.hardpointtweaks[ name ].lastvalue = value;
            break;
        case #"hash_4e4ad96c32f7d3a6":
            level.hudtweaks[ name ].lastvalue = value;
            break;
        default:
            break;
    }
}

// Namespace tweakables / scripts\mp\tweakables
// Params 4
// Checksum 0x0, Offset: 0xe24
// Size: 0x3ea
function registertweakable( category, name, dvar, value )
{
    if ( isstring( value ) )
    {
        value = getdvar( dvar, value );
    }
    else
    {
        value = getdvarint( dvar, value );
    }
    
    switch ( category )
    {
        case #"hash_8e9d608fb4870733":
            if ( !isdefined( level.rules[ name ] ) )
            {
                level.rules[ name ] = spawnstruct();
            }
            
            level.rules[ name ].value = value;
            level.rules[ name ].lastvalue = value;
            level.rules[ name ].dvar = dvar;
            break;
        case #"hash_7f3b480f12a29d67":
            if ( !isdefined( level.gametweaks[ name ] ) )
            {
                level.gametweaks[ name ] = spawnstruct();
            }
            
            level.gametweaks[ name ].value = value;
            level.gametweaks[ name ].lastvalue = value;
            level.gametweaks[ name ].dvar = dvar;
            break;
        case #"hash_33857c6e26098e6c":
            if ( !isdefined( level.teamtweaks[ name ] ) )
            {
                level.teamtweaks[ name ] = spawnstruct();
            }
            
            level.teamtweaks[ name ].value = value;
            level.teamtweaks[ name ].lastvalue = value;
            level.teamtweaks[ name ].dvar = dvar;
            break;
        case #"hash_87d1443ef2805760":
            if ( !isdefined( level.playertweaks[ name ] ) )
            {
                level.playertweaks[ name ] = spawnstruct();
            }
            
            level.playertweaks[ name ].value = value;
            level.playertweaks[ name ].lastvalue = value;
            level.playertweaks[ name ].dvar = dvar;
            break;
        case #"hash_cde859b8cc88ecdf":
            if ( !isdefined( level.classtweaks[ name ] ) )
            {
                level.classtweaks[ name ] = spawnstruct();
            }
            
            level.classtweaks[ name ].value = value;
            level.classtweaks[ name ].lastvalue = value;
            level.classtweaks[ name ].dvar = dvar;
            break;
        case #"hash_27124c6c97ccffa1":
            if ( !isdefined( level.weapontweaks[ name ] ) )
            {
                level.weapontweaks[ name ] = spawnstruct();
            }
            
            level.weapontweaks[ name ].value = value;
            level.weapontweaks[ name ].lastvalue = value;
            level.weapontweaks[ name ].dvar = dvar;
            break;
        case #"hash_efa87aad60239272":
            if ( !isdefined( level.hardpointtweaks[ name ] ) )
            {
                level.hardpointtweaks[ name ] = spawnstruct();
            }
            
            level.hardpointtweaks[ name ].value = value;
            level.hardpointtweaks[ name ].lastvalue = value;
            level.hardpointtweaks[ name ].dvar = dvar;
            break;
        case #"hash_4e4ad96c32f7d3a6":
            if ( !isdefined( level.hudtweaks[ name ] ) )
            {
                level.hudtweaks[ name ] = spawnstruct();
            }
            
            level.hudtweaks[ name ].value = value;
            level.hudtweaks[ name ].lastvalue = value;
            level.hudtweaks[ name ].dvar = dvar;
            break;
    }
}

// Namespace tweakables / scripts\mp\tweakables
// Params 0
// Checksum 0x0, Offset: 0x1216
// Size: 0x47f
function init()
{
    level.clienttweakables = [];
    level.tweakablesinitialized = 1;
    level.rules = [];
    level.gametweaks = [];
    level.teamtweaks = [];
    level.playertweaks = [];
    level.classtweaks = [];
    level.weapontweaks = [];
    level.hardpointtweaks = [];
    level.hudtweaks = [];
    registertweakable( "game", "graceperiod", @"hash_c653d32c30815d2b", 20 );
    registertweakable( "game", "graceperiod_comp", @"hash_72b071fcab2e5a53", 30 );
    registertweakable( "game", "onlyheadshots", @"hash_a54edeed7c5b587f", 0 );
    registertweakable( "game", "allowkillcam", @"scr_game_allowkillcam", 1 );
    registertweakable( "game", "spectatetype", @"scr_game_spectatetype", 1 );
    registertweakable( "game", "allow3rdspectate", @"scr_game_allow3rdspectate", 0 );
    registertweakable( "game", "deathpointloss", @"hash_cd8fc3bf8aba4931", 0 );
    registertweakable( "game", "suicidepointloss", @"hash_1ef34a7cbafda853", 0 );
    registertweakable( "team", "teamkillpointloss", @"hash_e8121d056bde22a3", 0 );
    registertweakable( "game", "thirdperson", @"camera_thirdperson", 0 );
    registertweakable( "game", "lowgravity", @"hash_12ca000dd2976ebc", 0 );
    registertweakable( "game", "lowgravitystrength", @"hash_2f4cf62df1af9a6", 125 );
    registertweakable( "game", "minfalldamageheight", @"bg_falldamageminheight", 225 );
    registertweakable( "game", "herodrop", @"hash_f1b2bd0a1fa58a73", 0 );
    registertweakable( "game", "perkpackage", @"perk_package_enabled", 1 );
    registertweakable( "game", "showperksonspawn", @"scr_showperksonspawn", 1 );
    registertweakable( "game", "loadoutperksoff", @"hash_8463bc866e14f4c7", 0 );
    registertweakable( "game", "one_tap_headshot", @"hash_c0f3f80ec94308d1", 0 );
    registertweakable( "team", "fftype", @"scr_team_fftype", 0 );
    registertweakable( "team", "teamkillspawndelay", @"hash_15ee15c57c8bc94c", 0 );
    registertweakable( "player", "maxhealth", @"scr_player_maxhealth", 150 );
    registertweakable( "player", "laststand", @"scr_player_laststand", 0 );
    registertweakable( "player", "healthregentime", @"scr_player_healthregentime", 6 );
    registertweakable( "player", "forcerespawn", @"hash_5d64cd3b24cf883a", 1 );
    registertweakable( "player", "streamingwaittime", @"hash_2ec2ff107406b60d", 5 );
    registertweakable( "weapon", "allowfrag", @"scr_weapon_allowfrags", 1 );
    registertweakable( "weapon", "allowsmoke", @"scr_weapon_allowsmoke", 1 );
    registertweakable( "weapon", "allowflash", @"scr_weapon_allowflash", 1 );
    registertweakable( "weapon", "allowc4", @"scr_weapon_allowc4", 1 );
    registertweakable( "weapon", "allowclaymores", @"hash_fb822e5b2c3150e", 1 );
    registertweakable( "weapon", "allowrpgs", @"scr_weapon_allowrpgs", 1 );
    registertweakable( "weapon", "allowmines", @"scr_weapon_allowmines", 1 );
    registertweakable( "hardpoint", "allowartillery", @"hash_cc7cdcc9fae6cf74", 1 );
    registertweakable( "hardpoint", "allowuav", @"hash_a3fdcc0352d0cdde", 1 );
    registertweakable( "hardpoint", "allowsupply", @"hash_92e6eac5a7e8a8b9", 1 );
    registertweakable( "hardpoint", "allowhelicopter", @"hash_477cfb1bbabaa927", 1 );
    registertweakable( "hud", "showobjicons", @"ui_hud_showobjicons", 1 );
    setdvar( @"ui_hud_showobjicons", 1 );
    level notify( "tweakablesInitialized" );
}

