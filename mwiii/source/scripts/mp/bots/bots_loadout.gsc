#using scripts\common\utility;
#using scripts\engine\utility;

#namespace bots_loadout;

// Namespace bots_loadout / scripts\mp\bots\bots_loadout
// Params 0
// Checksum 0x0, Offset: 0x2f1
// Size: 0x6c
function init()
{
    level.botloadouts = spawnstruct();
    level.botloadouts.loadouts = [];
    level.botloadouts.loadoutsets = [];
    level.botloadouts.initialized = 0;
    function_13edd4d60268005f();
    level.botloadouts.initialized = 1;
}

// Namespace bots_loadout / scripts\mp\bots\bots_loadout
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x365
// Size: 0x369
function private function_13edd4d60268005f()
{
    var_2c01e192ee48a8a9 = level.gamemodebundle.var_3d5c458ede7b8a36;
    var_5cfbd0f1b8a69ed9 = getscriptbundle( hashcat( %"hash_2c353b56cfc15851", var_2c01e192ee48a8a9 ) );
    
    if ( !isdefined( var_5cfbd0f1b8a69ed9 ) )
    {
        assertmsg( "<dev string:x1c>" + default_to( var_2c01e192ee48a8a9, "<dev string:x73>" ) );
        return;
    }
    
    foreach ( botloadout in var_5cfbd0f1b8a69ed9.var_e2eb85f16407d26a )
    {
        var_2637bff642ea1c8d = getscriptbundle( "botloadout:" + botloadout.loadout );
        
        if ( !isdefined( var_2637bff642ea1c8d ) )
        {
            assertmsg( "<dev string:x80>" );
            continue;
        }
        
        level.botloadouts.loadouts[ botloadout.loadout ] = var_2637bff642ea1c8d;
        personalitylist = [];
        difficultylist = [];
        
        if ( isdefined( var_2637bff642ea1c8d.personality ) )
        {
            if ( istrue( var_2637bff642ea1c8d.personality.camper ) )
            {
                personalitylist[ personalitylist.size ] = "camper";
            }
            
            if ( istrue( var_2637bff642ea1c8d.personality.runandgun ) )
            {
                personalitylist[ personalitylist.size ] = "run_and_gun";
            }
            
            if ( istrue( var_2637bff642ea1c8d.personality.cqb ) )
            {
                personalitylist[ personalitylist.size ] = "cqb";
            }
        }
        
        if ( isdefined( var_2637bff642ea1c8d.difficulty ) )
        {
            if ( istrue( var_2637bff642ea1c8d.difficulty.recruit ) )
            {
                difficultylist[ difficultylist.size ] = "recruit";
            }
            
            if ( istrue( var_2637bff642ea1c8d.difficulty.regular ) )
            {
                difficultylist[ difficultylist.size ] = "regular";
            }
            
            if ( istrue( var_2637bff642ea1c8d.difficulty.hardened ) )
            {
                difficultylist[ difficultylist.size ] = "hardened";
            }
            
            if ( istrue( var_2637bff642ea1c8d.difficulty.veteran ) )
            {
                difficultylist[ difficultylist.size ] = "veteran";
            }
        }
        
        if ( isdefined( var_2637bff642ea1c8d.archetype ) )
        {
            foreach ( personality in personalitylist )
            {
                foreach ( difficulty in difficultylist )
                {
                    var_cdce92e2f99a113d = function_b1cbf0185df8c1a8( personality, difficulty, "archetype_" + tolower( var_2637bff642ea1c8d.archetype ) );
                    
                    if ( !isdefined( level.botloadouts.loadoutsets[ var_cdce92e2f99a113d ] ) )
                    {
                        level.botloadouts.loadoutsets[ var_cdce92e2f99a113d ] = [];
                    }
                    
                    var_b9fb2de33b94c967 = level.botloadouts.loadoutsets[ var_cdce92e2f99a113d ].size;
                    level.botloadouts.loadoutsets[ var_cdce92e2f99a113d ][ var_b9fb2de33b94c967 ] = botloadout.loadout;
                }
            }
        }
    }
}

// Namespace bots_loadout / scripts\mp\bots\bots_loadout
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x6d6
// Size: 0x2c
function private function_b1cbf0185df8c1a8( personality, difficulty, archetype )
{
    return personality + "_" + difficulty + "_" + archetype;
}

// Namespace bots_loadout / scripts\mp\bots\bots_loadout
// Params 0
// Checksum 0x0, Offset: 0x70b
// Size: 0x3cc
function function_70d701f63acab018()
{
    defaultloadout = spawnstruct();
    defaultloadout.archetype = "assault";
    defaultloadout.primaryweapon = spawnstruct();
    defaultloadout.primaryweapon.weapon = "iw9_sm_alpha57";
    defaultloadout.primaryweapon.attachment1 = "iw9_minireddot03_tall_p01";
    defaultloadout.primaryweapon.attachment2 = "grip_vert01";
    defaultloadout.primaryweapon.attachment3 = "barsil_sm_p01";
    defaultloadout.primaryweapon.attachment4 = "grip_angled01";
    defaultloadout.primaryweapon.attachment5 = "pgrip_ske_p01";
    defaultloadout.primaryweapon.attachment6 = "laserbox_ads02";
    defaultloadout.primaryweapon.camo = "none";
    defaultloadout.primaryweapon.reticle = "none";
    defaultloadout.secondaryweapon = spawnstruct();
    defaultloadout.secondaryweapon.weapon = "iw9_pi_golf17";
    defaultloadout.secondaryweapon.attachment1 = "bar_pi_heavy_p24";
    defaultloadout.secondaryweapon.attachment2 = "mag_pi_large_p24";
    defaultloadout.secondaryweapon.attachment3 = "stockno_pi_p24";
    defaultloadout.secondaryweapon.attachment4 = "pgrip_aim_p24";
    defaultloadout.secondaryweapon.attachment5 = "none";
    defaultloadout.secondaryweapon.camo = "none";
    defaultloadout.secondaryweapon.reticle = "none";
    defaultloadout.equipment = spawnstruct();
    defaultloadout.equipment.primary = "equip_throwing_knife";
    defaultloadout.equipment.secondary = "equip_shockstick";
    defaultloadout.extrapower = spawnstruct();
    defaultloadout.extrapower.primary = 0;
    defaultloadout.extrapower.secondary = 0;
    defaultloadout.perks = spawnstruct();
    defaultloadout.perks.perk1 = "specialty_warhead";
    defaultloadout.perks.perk2 = "specialty_huntmaster";
    defaultloadout.perks.perk3 = "specialty_covert_ops";
    defaultloadout.extraperks = spawnstruct();
    defaultloadout.extraperks.perk1 = "specialty_guerrilla";
    defaultloadout.extraperks.perk2 = "specialty_null";
    defaultloadout.extraperks.perk3 = "specialty_null";
    defaultloadout.gesture = "iw8_ges_plyr_gesture000";
    defaultloadout.execution = "neck_stab";
    defaultloadout.fieldupgrade1 = "none";
    defaultloadout.fieldupgrade2 = "none";
    defaultloadout.role = "role_hunter";
    defaultloadout.overkill = 0;
    defaultloadout.specialist = 1;
    return defaultloadout;
}

// Namespace bots_loadout / scripts\mp\bots\bots_loadout
// Params 1
// Checksum 0x0, Offset: 0xae0
// Size: 0x54, Type: bool
function function_ebe5d810fc2c7196( loadoutname )
{
    assertex( istrue( level.botloadouts.initialized ), "<dev string:xd0>" );
    
    if ( isdefined( level.botloadouts.loadouts[ loadoutname ] ) )
    {
        self.var_b2f042bf9991295d = loadoutname;
        return true;
    }
    
    return false;
}

// Namespace bots_loadout / scripts\mp\bots\bots_loadout
// Params 3
// Checksum 0x0, Offset: 0xb3d
// Size: 0x99, Type: bool
function function_4f1b939bbc96291b( personality, difficulty, archetype )
{
    assertex( istrue( level.botloadouts.initialized ), "<dev string:x11f>" );
    var_76cd494d92ac8074 = function_b1cbf0185df8c1a8( personality, difficulty, archetype );
    
    if ( isdefined( level.botloadouts.loadoutsets[ var_76cd494d92ac8074 ] ) )
    {
        var_b2f042bf9991295d = scripts\engine\utility::random( level.botloadouts.loadoutsets[ var_76cd494d92ac8074 ] );
        return function_ebe5d810fc2c7196( var_b2f042bf9991295d );
    }
    
    return false;
}

// Namespace bots_loadout / scripts\mp\bots\bots_loadout
// Params 0
// Checksum 0x0, Offset: 0xbdf
// Size: 0x4c, Type: bool
function function_a693c24def6fb1ed()
{
    if ( !isdefined( self.pers[ "gamemodeLoadout" ] ) )
    {
        if ( istrue( level.botloadouts.initialized ) )
        {
            self.classcallback = &function_b606843c205d2dfc;
            return true;
        }
        
        assertmsg( "<dev string:x16f>" );
    }
    
    return false;
}

// Namespace bots_loadout / scripts\mp\bots\bots_loadout
// Params 0
// Checksum 0x0, Offset: 0xc34
// Size: 0xc0
function function_b606843c205d2dfc()
{
    assertex( istrue( level.botloadouts.initialized ), "<dev string:x1c1>" );
    
    if ( !isdefined( self.var_b2f042bf9991295d ) )
    {
        personality = self botgetpersonality();
        difficulty = self botgetdifficulty();
        assignsucceeded = function_4f1b939bbc96291b( personality, difficulty, "archetype_assault" );
        assertex( assignsucceeded, "<dev string:x20e>" );
    }
    
    return ter_op( isdefined( level.botloadouts.loadouts[ self.var_b2f042bf9991295d ] ), level.botloadouts.loadouts[ self.var_b2f042bf9991295d ], function_70d701f63acab018() );
}

