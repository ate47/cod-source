#using scripts\common\utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\debug;

#namespace secrethunt;

// Namespace secrethunt / scripts\mp\secrethunt
// Params 1
// Checksum 0x0, Offset: 0x14c
// Size: 0x7e
function secrethunt( targetname )
{
    while ( !istrue( game[ "gamestarted" ] ) )
    {
        waitframe();
    }
    
    hiddenobjs = getentarray( targetname, "targetname" );
    
    foreach ( obj in hiddenobjs )
    {
        obj thread trackhiddenobj( hiddenobjs.size );
    }
}

// Namespace secrethunt / scripts\mp\secrethunt
// Params 1
// Checksum 0x0, Offset: 0x1d2
// Size: 0x1c1
function trackhiddenobj( numobjs )
{
    level endon( "game_ended" );
    self setcandamage( 1 );
    self.found = [];
    
    /#
        thread secrethunt_debuglocations();
    #/
    
    while ( true )
    {
        self waittill( "damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isdefined( objweapon ) )
        {
            if ( meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_GRENADE_SPLASH" )
            {
                continue;
            }
        }
        else if ( isdefined( inflictor.streakinfo ) && scripts\cp_mp\utility\killstreak_utility::isvalidkillstreak( inflictor.streakinfo.streakname ) )
        {
            self.health = 5;
            continue;
        }
        
        if ( !isdefined( self.found[ attacker.guid ] ) )
        {
            self.found[ attacker.guid ] = 1;
            
            if ( !isdefined( attacker.hiddenobjcount ) )
            {
                attacker.hiddenobjcount = 1;
            }
            else
            {
                attacker.hiddenobjcount++;
            }
            
            iprintln( "Secret objects found: " + attacker.hiddenobjcount + " of " + numobjs );
        }
        
        if ( self.health <= 0 )
        {
            break;
        }
    }
    
    self delete();
}

// Namespace secrethunt / scripts\mp\secrethunt
// Params 0
// Checksum 0x0, Offset: 0x39b
// Size: 0x6b
function secrethunt_debuglocations()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    while ( true )
    {
        if ( getdvarint( @"hash_7a5a40586350d163", 0 ) == 1 )
        {
            self hudoutlineenable( "outlinefill_nodepth_green" );
            self.outlined = 1;
        }
        else if ( istrue( self.outlined ) )
        {
            self hudoutlinedisable();
            self.outlined = 0;
        }
        
        wait 1;
    }
}

