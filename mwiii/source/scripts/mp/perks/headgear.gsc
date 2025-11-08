#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment;

#namespace headgear;

// Namespace headgear / scripts\mp\perks\headgear
// Params 0
// Checksum 0x0, Offset: 0x12e
// Size: 0x1c
function init()
{
    level._effect[ "helmet_pop" ] = loadfx( "vfx/iw7/core/human/helmet_sdf_army_split.vfx" );
}

// Namespace headgear / scripts\mp\perks\headgear
// Params 2
// Checksum 0x0, Offset: 0x152
// Size: 0x25
function removeheadgear( equipmentref, slot )
{
    self notify( "remove_headgear" );
    self.hasheadgear = undefined;
}

// Namespace headgear / scripts\mp\perks\headgear
// Params 3
// Checksum 0x0, Offset: 0x17f
// Size: 0x60
function runheadgear( equipmentref, slot, variantid )
{
    self endon( "death_or_disconnect" );
    self endon( "remove_headgear" );
    self.hasheadgear = 1;
    self waittill( "headgear_save" );
    self.hasheadgear = 0;
    
    if ( equipmentref != "" )
    {
        scripts\mp\equipment::setequipmentammo( equipmentref, 0 );
    }
    
    runheadgeareffects();
}

// Namespace headgear / scripts\mp\perks\headgear
// Params 0
// Checksum 0x0, Offset: 0x1e7
// Size: 0x74
function runheadgeareffects()
{
    playfxontag( level._effect[ "helmet_pop" ], self, "j_head" );
    self detach( self.headmodel, "" );
    self setcustomization( self.bodymodelname, self.backuphead );
    self.headmodel = self.backuphead;
    self attach( self.backuphead, "", 1 );
}

// Namespace headgear / scripts\mp\perks\headgear
// Params 0
// Checksum 0x0, Offset: 0x263
// Size: 0x7
function getdamagemod()
{
    return 0.1;
}

// Namespace headgear / scripts\mp\perks\headgear
// Params 0
// Checksum 0x0, Offset: 0x273
// Size: 0x4
function getmaxdamage()
{
    return 20;
}

