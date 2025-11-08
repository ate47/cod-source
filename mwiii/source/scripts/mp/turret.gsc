#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;

#namespace turret;

// Namespace turret / scripts\mp\turret
// Params 0
// Checksum 0x0, Offset: 0x18c
// Size: 0xb2
function init()
{
    array = getentarray( "turret_mp", "targetname" );
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        foreach ( ent in array )
        {
            ent delete();
        }
        
        return;
    }
    
    foreach ( ent in array )
    {
        add_turret( ent );
    }
}

// Namespace turret / scripts\mp\turret
// Params 1
// Checksum 0x0, Offset: 0x246
// Size: 0x259
function add_turret( turret )
{
    turret makeunusable();
    turret setnodeploy( 1 );
    turret setdefaultdroppitch( 0 );
    objweapon = makeweapon( turret.weaponinfo );
    turret.objweapon = objweapon;
    
    if ( isdefined( turret.script_noteworthy ) )
    {
        types = strtok( turret.script_noteworthy, "," );
        
        foreach ( type in types )
        {
            values = strtok( type, "|" );
            
            if ( isdefined( values ) )
            {
                if ( values[ 0 ] == "arc" )
                {
                    if ( isdefined( values[ 1 ] ) && values[ 1 ] != "0" )
                    {
                        turret setleftarc( int( values[ 1 ] ) );
                    }
                    
                    if ( isdefined( values[ 2 ] ) && values[ 2 ] != "0" )
                    {
                        turret setrightarc( int( values[ 2 ] ) );
                    }
                    
                    if ( isdefined( values[ 3 ] ) && values[ 3 ] != "0" )
                    {
                        turret settoparc( int( values[ 3 ] ) );
                    }
                    
                    if ( isdefined( values[ 4 ] ) && values[ 4 ] != "0" )
                    {
                        turret setbottomarc( int( values[ 4 ] ) );
                    }
                }
            }
        }
    }
    
    useobjorigin = turret gettagorigin( "tag_turret_pitch" );
    useobj = scripts\mp\gameobjects::createhintobject( useobjorigin, "HINT_BUTTON", "hud_icon_turret", &"KILLSTREAKS_HINTS/SENTRY_USE_GL" );
    useobj linkto( turret, "tag_turret_pitch", ( 0, 0, 5 ), ( 0, 0, 0 ) );
    turret.useobj = useobj;
    useobj thread turretthink( turret );
    killcamorigin = turret gettagorigin( "tag_player" );
    turret.killcament = spawn( "script_model", killcamorigin );
    turret.killcament linkto( turret, "tag_player", ( -60, 0, 20 ), ( 0, 0, 0 ) );
}

// Namespace turret / scripts\mp\turret
// Params 1
// Checksum 0x0, Offset: 0x4a7
// Size: 0xec
function turretthink( turret )
{
    while ( true )
    {
        self waittill( "trigger", player );
        self makeunusable();
        thread endturretonplayer( player );
        player.prevweapon = player getcurrentweapon();
        player.useweapon = getcompleteweaponname( turret.objweapon );
        player _giveweapon( player.useweapon, undefined, undefined, 1 );
        
        while ( player domonitoredweaponswitch( player.useweapon, 1 ) == 0 )
        {
            waitframe();
        }
        
        player controlturreton( turret );
        thread endturretusewatch( player, turret );
        self waittill( "end_turret_use" );
        
        if ( isdefined( player ) )
        {
            player controlturretoff( turret );
            player switchtoweaponimmediate( player.prevweapon );
            player _takeweapon( player.useweapon );
        }
        
        self makeusable();
    }
}

// Namespace turret / scripts\mp\turret
// Params 2
// Checksum 0x0, Offset: 0x59b
// Size: 0x3d
function endturretusewatch( player, turret )
{
    while ( player usebuttonpressed() )
    {
        waitframe();
    }
    
    while ( true )
    {
        if ( player usebuttonpressed() )
        {
            self notify( "end_turret_use" );
            break;
        }
        
        waitframe();
    }
}

// Namespace turret / scripts\mp\turret
// Params 1
// Checksum 0x0, Offset: 0x5e0
// Size: 0x1b
function endturretonplayer( player )
{
    player waittill( "death_or_disconnect" );
    self notify( "end_turret_use" );
}

