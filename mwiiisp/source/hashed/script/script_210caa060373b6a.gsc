#using scripts\aitypes\combat;
#using scripts\anim\combat_utility;
#using scripts\anim\shared;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\patrol;
#using scripts\common\dog_utility;

#namespace setup;

// Namespace setup / namespace_bbb55abdbe98026a
// Params 1
// Checksum 0x0, Offset: 0xcb
// Size: 0x144
function setupagent( taskid )
{
    if ( istrue( self.bagentinitialized ) )
    {
        return anim.success;
    }
    
    scripts\aitypes\combat::soldier_init_common();
    self.goalradius = 480;
    self.goalheight = 1024;
    self.moveplaybackrate = 1;
    self.animplaybackrate = 1;
    self.movetransitionrate = 1;
    self.lookfordoorsalongpath = 1;
    self.dont_cleanup = 1;
    self.bsoldier = 1;
    self.space = 0;
    self.export = "agent";
    self.var_689bf433cb5c5322 = "melee_ai_mp";
    self.fnplaceweaponon = &scripts\anim\shared::placeweaponon;
    self.fndropweapon = &scripts\anim\shared::dropaiweapon;
    self.fnstealthgotonode = &scripts\common\dog_utility::go_to_node;
    scripts\asm\soldier\patrol::function_3aba5f22b60d37f5();
    scripts\asm\shared\utility::setupsoldierdefaults();
    self.dropweapon = 0;
    thread default_weaponsetup();
    thread handledeathcleanup();
    thread scripts\anim\combat_utility::monitorflash();
    self enablemissedbulletclientonly( 1 );
    
    if ( isdefined( level.fnoffhandfire ) )
    {
        self thread [[ level.fnoffhandfire ]]();
    }
    
    self.bagentinitialized = 1;
    return anim.success;
}

// Namespace setup / namespace_bbb55abdbe98026a
// Params 1
// Checksum 0x0, Offset: 0x218
// Size: 0x2b
function function_40150623eb9f4ea2( taskid )
{
    self.disablepistol = 1;
    self.disablelmgmount = 1;
    self.allowlongdeath = 0;
}

// Namespace setup / namespace_bbb55abdbe98026a
// Params 0
// Checksum 0x0, Offset: 0x24b
// Size: 0x18
function handledeathcleanup()
{
    level endon( "game_ended" );
    self waittill( "death" );
    bb_clearmeleetarget();
}

