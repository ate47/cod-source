#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;

#namespace perk_mark_targets;

// Namespace perk_mark_targets / scripts\mp\perks\perk_mark_targets
// Params 0
// Checksum 0x0, Offset: 0x105
// Size: 0x2
function marktarget_init()
{
    
}

// Namespace perk_mark_targets / scripts\mp\perks\perk_mark_targets
// Params 3
// Checksum 0x0, Offset: 0x10f
// Size: 0x71
function marktarget_run( victim, objweapon, smeansofdeath )
{
    if ( isbulletdamage( smeansofdeath ) && isplayer( victim ) && isreallyalive( victim ) && victim.team != self.team && isdefined( objweapon ) && !objweapon.isalternate )
    {
        thread marktarget_execute( victim );
    }
}

// Namespace perk_mark_targets / scripts\mp\perks\perk_mark_targets
// Params 1
// Checksum 0x0, Offset: 0x188
// Size: 0x3d
function marktarget_execute( target )
{
    target notify( "delayHealing_started" );
    target endon( "delayHealing_started" );
    target.healthregendisabled = 1;
    tagmarkedplayer( target );
    
    if ( isdefined( target ) )
    {
        target removemarkfromtarget();
    }
}

// Namespace perk_mark_targets / scripts\mp\perks\perk_mark_targets
// Params 1
// Checksum 0x0, Offset: 0x1cd
// Size: 0x70
function tagmarkedplayer( target )
{
    self endon( "death_or_disconnect" );
    target endon( "death_or_disconnect" );
    var_79e98e0273d56283 = 1;
    
    if ( target _hasperk( "specialty_frangible_resist" ) )
    {
        var_79e98e0273d56283 += getdvarfloat( @"hash_cfc1f984f402559f", -0.5 );
    }
    
    timemarked = gettime() + 3500 * var_79e98e0273d56283;
    
    while ( gettime() < timemarked )
    {
        waitframe();
    }
}

// Namespace perk_mark_targets / scripts\mp\perks\perk_mark_targets
// Params 0
// Checksum 0x0, Offset: 0x245
// Size: 0xc
function removemarkfromtarget()
{
    self.healthregendisabled = undefined;
}

