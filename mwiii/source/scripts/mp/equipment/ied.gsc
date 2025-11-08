#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\equipment_interact;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\perks\perk_equipmentping;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\weapons;

#namespace ied;

// Namespace ied / scripts\mp\equipment\ied
// Params 1
// Checksum 0x0, Offset: 0x2d1
// Size: 0x1b7
function ied_used( grenade )
{
    self endon( "disconnect" );
    grenade endon( "death" );
    
    if ( issharedfuncdefined( #"hash_d8976e21a6adafba", #"hash_ca0042e3cac99672" ) )
    {
        grenade [[ getsharedfunc( #"hash_d8976e21a6adafba", #"hash_ca0042e3cac99672" ) ]]( grenade );
    }
    
    grenade.bundle = scripts\mp\equipment::getEquipmentBundleFromWeaponName( grenade.weapon_name );
    printgameaction( "IED thrown", grenade.owner );
    grenade scripts\cp_mp\ent_manager::registerspawn( 1, &function_5481370bf1e83031 );
    
    if ( _hasperk( "specialty_rugged_eqp" ) )
    {
        grenade.hasruggedeqp = 1;
    }
    
    grenade thread minedamagemonitor();
    grenade thread function_ebd3dd21ad253364();
    grenade thread function_43018577e4dd0c6e();
    grenade thread scripts\mp\equipment_interact::remoteinteractsetup( &ied_detonate, 1, 1 );
    thread scripts\mp\weapons::monitordisownedgrenade( self, grenade );
    grenade waittill( "missile_stuck" );
    grenade.stucktime = gettime();
    grenade thread function_58606993710db8de();
    grenade setotherent( self );
    grenade setnodeploy( 1 );
    onequipmentplanted( grenade, "equip_ied", &ied_delete );
    thread monitordisownedequipment( self, grenade );
    grenade scripts\mp\sentientpoolmanager::registersentient( "Lethal_Static", grenade.owner, 1 );
    grenade function_641996b5e113c5c6( grenade, &function_4260b88126e41b5d );
    grenade thread scripts\mp\perks\perk_equipmentping::runequipmentping();
    grenade setscriptablepartstate( "effects", "plant", 0 );
    thread scripts\mp\weapons::outlineequipmentforowner( grenade );
    grenade missilethermal();
    grenade missileoutline();
    grenade.headiconid = grenade scripts\cp_mp\entityheadicons::setheadicon_factionimage( 0, 0, undefined, undefined, undefined, 0.1, 1 );
    grenade function_1a0e37df908265ce();
}

// Namespace ied / scripts\mp\equipment\ied
// Params 0
// Checksum 0x0, Offset: 0x490
// Size: 0x9c
function function_1a0e37df908265ce()
{
    if ( istrue( level.dangerzoneskipequipment ) )
    {
        return;
    }
    
    if ( isdefined( self.dangerzone ) )
    {
        scripts\mp\spawnlogic::removespawndangerzone( self.dangerzone );
    }
    
    var_d8695b9748c307be = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] - 50 );
    self.dangerzone = scripts\mp\spawnlogic::addspawndangerzone( var_d8695b9748c307be, scripts\mp\spawnlogic::getdefaultminedangerzoneradiussize(), 100, self.owner.team, undefined, self.owner, 0, self, 1 );
}

// Namespace ied / scripts\mp\equipment\ied
// Params 0
// Checksum 0x0, Offset: 0x534
// Size: 0xa7
function function_58606993710db8de()
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "trigger_grenade", ents );
        assert( isdefined( ents ) );
        
        if ( !function_87eebc132ad2bbb0() )
        {
            continue;
        }
        
        foreach ( ent in ents )
        {
            if ( isagent( ent ) || isplayer( ent ) )
            {
                if ( !isreallyalive( ent ) )
                {
                    continue;
                }
                
                thread ied_detonate();
                return;
            }
        }
    }
}

// Namespace ied / scripts\mp\equipment\ied
// Params 0
// Checksum 0x0, Offset: 0x5e3
// Size: 0x19
function function_43018577e4dd0c6e()
{
    self endon( "death" );
    self waittill( "mine_destroyed" );
    thread ied_destroy();
}

// Namespace ied / scripts\mp\equipment\ied
// Params 1
// Checksum 0x0, Offset: 0x604
// Size: 0x82
function ied_detonate( attacker )
{
    self endon( "death" );
    self.owner endon( "disconnect" );
    
    if ( isdefined( attacker ) )
    {
        attacker endon( "disconnect" );
    }
    else
    {
        attacker = self.owner;
    }
    
    self setscriptablepartstate( "effects", "trigger", 0 );
    detonationdelay = default_to( self.bundle.ied_detonationdelay, 0.5 );
    wait detonationdelay;
    thread ied_explode( attacker );
}

// Namespace ied / scripts\mp\equipment\ied
// Params 1
// Checksum 0x0, Offset: 0x68e
// Size: 0x1db
function ied_explode( attacker )
{
    printgameaction( "IED triggered", self.owner );
    level notify( "explosion_extinguish", self.origin, 256, self.owner, self );
    deletiondelay = undefined;
    statename = undefined;
    caststart = self.origin;
    contents = scripts\engine\trace::create_contents( 0, 1, 1, 0, 1, 1, 0, 0, 0 );
    updot = vectordot( ( 0, 0, 1 ), anglestoup( self.angles ) );
    
    if ( abs( updot ) <= 0.81915 )
    {
        castend = caststart - anglestoup( self.angles ) * 5;
        castresults = physics_raycast( caststart, castend, contents, self, 0, "physicsquery_closest", 1 );
        
        if ( isdefined( castresults ) && castresults.size > 0 )
        {
            deletiondelay = 5;
            statename = "explode";
        }
    }
    else if ( updot <= -0.96592 )
    {
        castend = caststart - anglestoup( self.angles ) * 5;
        castresults = physics_raycast( caststart, castend, contents, self, 0, "physicsquery_closest", 1 );
        
        if ( isdefined( castresults ) && castresults.size > 0 )
        {
            deletiondelay = 5;
            statename = "explode";
        }
    }
    
    if ( !isdefined( deletiondelay ) )
    {
        castend = caststart - ( 0, 0, 1 ) * 20;
        castresults = physics_raycast( caststart, castend, contents, self, 0, "physicsquery_closest", 1 );
        
        if ( !isdefined( castresults ) || castresults.size <= 0 )
        {
            deletiondelay = 5;
            statename = "explodeAir";
        }
    }
    
    if ( !isdefined( deletiondelay ) )
    {
        deletiondelay = 5;
        statename = "explode";
    }
    
    thread ied_delete( deletiondelay );
    self setentityowner( attacker );
    self clearscriptabledamageowner();
    self setscriptablepartstate( "effects", statename, 0 );
}

// Namespace ied / scripts\mp\equipment\ied
// Params 0
// Checksum 0x0, Offset: 0x871
// Size: 0xa
function function_5481370bf1e83031()
{
    thread ied_delete();
}

// Namespace ied / scripts\mp\equipment\ied
// Params 1
// Checksum 0x0, Offset: 0x883
// Size: 0x39
function ied_destroy( attacker )
{
    thread ied_delete( 5 );
    self setscriptablepartstate( "effects", "destroy", 0 );
    self setscriptablepartstate( "hacked", "neutral", 0 );
}

// Namespace ied / scripts\mp\equipment\ied
// Params 1
// Checksum 0x0, Offset: 0x8c4
// Size: 0x105
function ied_delete( deletiondelay )
{
    self notify( "death" );
    level.mines[ self getentitynumber() ] = undefined;
    self setscriptablepartstate( "hack_usable", "off" );
    self setcandamage( 0 );
    scripts\cp_mp\ent_manager::deregisterspawn();
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon( self.headiconid );
    self.headiconid = undefined;
    self.exploding = 1;
    
    if ( isdefined( self.dangerzone ) )
    {
        scripts\mp\spawnlogic::removespawndangerzone( self.dangerzone );
        self.dangerzone = undefined;
    }
    
    owner = self.owner;
    
    if ( isdefined( owner ) )
    {
        owner removeequip( self );
    }
    
    thread function_921422f5877505e8();
    
    if ( issharedfuncdefined( #"hash_d8976e21a6adafba", #"hash_c33ceb91d0ca7a9d" ) )
    {
        self [[ getsharedfunc( #"hash_d8976e21a6adafba", #"hash_c33ceb91d0ca7a9d" ) ]]( self );
    }
    
    if ( isdefined( deletiondelay ) )
    {
        wait deletiondelay;
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace ied / scripts\mp\equipment\ied
// Params 0
// Checksum 0x0, Offset: 0x9d1
// Size: 0x40
function function_921422f5877505e8()
{
    self endon( "death" );
    wait 0.5;
    parent = self getlinkedparent();
    
    if ( isdefined( parent ) )
    {
        parent waittill( "death" );
        self setscriptablepartstate( "effects", "neutral", 0 );
    }
}

// Namespace ied / scripts\mp\equipment\ied
// Params 1
// Checksum 0x0, Offset: 0xa19
// Size: 0xa3
function function_4260b88126e41b5d( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    self notify( "enemy_destroyed_equipment", attacker );
    
    if ( istrue( scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, attacker ) ) )
    {
        attacker notify( "destroyed_equipment" );
        attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment( self );
    }
    
    damagefeedback = "";
    
    if ( istrue( self.hasruggedeqp ) )
    {
        damagefeedback = "hitequip";
    }
    
    if ( isplayer( attacker ) )
    {
        attacker updatedamagefeedback( damagefeedback );
    }
    
    thread ied_destroy( attacker );
}

// Namespace ied / scripts\mp\equipment\ied
// Params 1
// Checksum 0x0, Offset: 0xac4
// Size: 0x84
function function_7f534465d312ec86( data )
{
    attacker = data.attacker;
    
    if ( istrue( scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, attacker ) ) )
    {
        attacker notify( "destroyed_equipment" );
        attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment( self );
    }
    
    damagefeedback = "";
    
    if ( istrue( self.hasruggedeqp ) )
    {
        damagefeedback = "hitequip";
    }
    
    if ( isplayer( attacker ) )
    {
        attacker updatedamagefeedback( damagefeedback );
    }
    
    ied_explode( attacker );
}

// Namespace ied / scripts\mp\equipment\ied
// Params 1
// Checksum 0x0, Offset: 0xb50
// Size: 0x63
function ied_disable( attacker )
{
    self endon( "death" );
    attacker thread scripts\mp\utility\points::doscoreevent( #"disabled_c4" );
    self.isdisabled = 1;
    self setscriptablepartstate( "emp", "on", 0 );
    wait 6;
    self setscriptablepartstate( "emp", "off", 0 );
    self.isdisabled = 0;
}

// Namespace ied / scripts\mp\equipment\ied
// Params 0
// Checksum 0x0, Offset: 0xbbb
// Size: 0x23
function function_ebd3dd21ad253364()
{
    self endon( "death" );
    level waittill_any_2( "game_ended", "bro_shot_start" );
    thread ied_destroy();
}

// Namespace ied / scripts\mp\equipment\ied
// Params 0
// Checksum 0x0, Offset: 0xbe6
// Size: 0x6c, Type: bool
function function_87eebc132ad2bbb0()
{
    if ( istrue( self.isdisabled ) || istrue( self.isjammed ) )
    {
        return false;
    }
    
    activationdelay = default_to( self.bundle.ied_activationdelay, 0.5 );
    return isdefined( self.stucktime ) && ( gettime() - self.stucktime ) / 1000 > activationdelay;
}

// Namespace ied / scripts\mp\equipment\ied
// Params 1
// Checksum 0x0, Offset: 0xc5b
// Size: 0x21
function function_f85453705ce0972a( oldowner )
{
    if ( istrue( self.exploding ) )
    {
        return;
    }
    
    thread ied_destroy();
}

