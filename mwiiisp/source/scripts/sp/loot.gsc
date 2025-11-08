#using scripts\common\utility;
#using scripts\engine\hud_management;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\analytics;
#using scripts\sp\equipment\offhands;
#using scripts\sp\player;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\script_items;
#using scripts\sp\utility;

#namespace loot;

// Namespace loot / scripts\sp\loot
// Params 0
// Checksum 0x0, Offset: 0x431
// Size: 0x2ef
function init()
{
    setdvarifuninitialized( @"hash_7dfe19d75d304409", 0 );
    level.loot = spawnstruct();
    level.loot.types = [];
    level.loot.notifications = [];
    level.loot.classexceptions = [];
    level.loot.var_8da39343ac7feaf3 = [];
    level.loot.var_d0d7b34e9765980a = [];
    level.loot.resourcepending = [];
    level.loot.lastloottime = 0;
    level.loot.spawntags = [ "j_spinelower" ];
    level.loot.sfx = spawn_script_origin( level.player.origin );
    level.loot.sfx linkto( level.player );
    level.loot.offhands = [];
    level.loot.primaryweapons = [];
    level.loot.ammo_types = [];
    level.loot.pickupgesture = undefined;
    level.loot.wheelweapons = undefined;
    level.loot.probability = [];
    level.loot.probability[ "Default" ] = undefined;
    level.loot.probability[ "Offhand" ] = &probabilityoffhand;
    level.loot.probability[ "OffhandWheel" ] = &probabilityoffhandwheel;
    level.loot.probability[ "Never" ] = &probabilityzero;
    
    if ( isdefined( level.gamemodebundle ) )
    {
        function_af421e4ae48662c7( level.gamemodebundle.campaignlootlist );
    }
    
    if ( utility::playerarmorenabled() )
    {
        thread updatearmordroptimer();
    }
    
    thread setworldloot();
    
    if ( istrue( level.loot.var_307d8c71918f2204 ) )
    {
        level thread function_62cab66e6e85f19a();
    }
    
    level thread function_2099b5b188b3a60c();
    level.loot.droppedweapons = [];
    level.loot.droppeditems = [];
    registersharedfunc( "loot", "dropWeapon", &ondropweapon );
    registersharedfunc( "loot", "dropItem", &ondropitem );
    registersharedfunc( "game", "spawnNewItem", &spawnlootitem );
    
    /#
        function_3c821aac4af727f3();
    #/
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x728
// Size: 0x4b1
function function_af421e4ae48662c7( campaignlootlistname )
{
    if ( !isdefined( campaignlootlistname ) )
    {
        return;
    }
    
    level.loot.types = [];
    level.loot.classexceptions = [];
    level.loot.pickupgesture = undefined;
    level.loot.wheelweapons = undefined;
    bundlelist = getscriptbundle( "campaignlootlist:" + campaignlootlistname );
    
    if ( isdefined( bundlelist ) )
    {
        level.player.armor.maxplates = default_to( bundlelist.maxplates, 3 );
        level.loot.pickupgesture = bundlelist.pickupgesture;
        level.loot.splashwidget = bundlelist.pickupwidget;
        
        if ( isdefined( bundlelist.exceptions ) )
        {
            foreach ( exception in bundlelist.exceptions )
            {
                if ( isdefined( exception.classname ) )
                {
                    level.loot.classexceptions[ exception.classname ] = 1;
                }
            }
        }
        
        if ( isdefined( bundlelist.lootlist ) )
        {
            level.loot.maxloot = default_to( bundlelist.maxloot, 25 );
            level.loot.maxweapons = default_to( bundlelist.maxweapons, 25 );
            level.loot.var_307d8c71918f2204 = default_to( bundlelist.var_307d8c71918f2204, 0 );
            
            foreach ( lootlistitem in bundlelist.lootlist )
            {
                loot = getscriptbundle( "campaignloot:" + lootlistitem.loot );
                
                if ( !isdefined( loot ) )
                {
                    continue;
                }
                
                probabilityfunc = level.loot.probability[ default_to( loot.probability, "Default" ) ];
                
                switch ( default_to( loot.type, "General" ) )
                {
                    case #"hash_f759d725729848ab":
                        registerloot( loot, &donothing, &inactive, probabilityfunc );
                        break;
                    case #"hash_b55d42dfb1c5f4ef":
                        registerammoloot( loot, probabilityfunc );
                        break;
                    case #"hash_fd03b70a505586af":
                        registeroffhandloot( loot, probabilityfunc );
                        break;
                    case #"hash_a5b4e93bed724400":
                        registerloot( loot, &lootarmor, &playermaxarmor, &probabilityarmor, undefined, 1 );
                        break;
                    case #"hash_8c5cf2a57bd46bbe":
                        registerloot( loot, &lootarmorvest, &function_a57539eb7fbc0627, &probabilityarmor, undefined, 1 );
                        break;
                    case #"hash_76f2aca395298035":
                        function_1693de8f478a2d4a( loot, &lootresource, undefined, probabilityfunc );
                        break;
                    case #"hash_9dfd4437e7e29775":
                        function_e1bd0ad03241540a( loot, probabilityfunc );
                        break;
                }
            }
        }
        
        if ( isdefined( bundlelist.equipmentwheel ) )
        {
            wheeltable = getscriptbundle( "equipmentradialmenuitemlist:" + bundlelist.equipmentwheel );
            
            if ( isdefined( wheeltable ) )
            {
                level.loot.wheelweapons = [];
                
                foreach ( item in wheeltable.var_95e760736e295b10 )
                {
                    itembundle = getscriptbundle( "equipmentradialmenuitem:" + item.bundle );
                    
                    if ( isdefined( itembundle ) && isdefined( itembundle.equipmentitemref ) && itembundle.equipmentitemref != "none" )
                    {
                        level.loot.wheelweapons[ itembundle.equipmentitemref ] = itembundle.equipmentitemref;
                    }
                }
            }
        }
    }
}

// Namespace loot / scripts\sp\loot
// Params 0
// Checksum 0x0, Offset: 0xbe1
// Size: 0x31
function corpselootthink()
{
    if ( !cancarryloot() )
    {
        return;
    }
    
    self waittill( "death", attacker );
    
    if ( !shoulddroploot( attacker ) )
    {
        return;
    }
    
    spawncorpseloot();
}

// Namespace loot / scripts\sp\loot
// Params 0
// Checksum 0x0, Offset: 0xc1a
// Size: 0x51, Type: bool
function cancarryloot()
{
    if ( !isdefined( self ) )
    {
        return false;
    }
    
    if ( !isdefined( level.loot ) )
    {
        return false;
    }
    
    if ( self.team != "axis" )
    {
        return false;
    }
    
    if ( istrue( level.loot.classexceptions[ self.classname ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0xc74
// Size: 0x79, Type: bool
function shoulddroploot( attacker )
{
    if ( !isdefined( self ) )
    {
        return false;
    }
    
    if ( !isdefined( level.loot ) )
    {
        return false;
    }
    
    if ( !playerlootenabled() )
    {
        return false;
    }
    
    if ( force_armor_drop() )
    {
        return true;
    }
    
    if ( indonotspawnlootvolume( self ) )
    {
        return false;
    }
    
    if ( istrue( self.noloot ) )
    {
        return false;
    }
    
    if ( !is_equal( attacker, level.player ) )
    {
        return false;
    }
    
    if ( isdefined( self.nodrop ) )
    {
        return false;
    }
    
    return true;
}

// Namespace loot / scripts\sp\loot
// Params 0
// Checksum 0x0, Offset: 0xcf6
// Size: 0x106
function onspawnloot()
{
    self.loot = [];
    
    foreach ( name, type in level.loot.types )
    {
        if ( isdefined( level.loot.types[ name ].onspawnfunc ) && isdefined( level.loot.types[ name ].probabilityfunc ) )
        {
            if ( [[ level.loot.types[ name ].probabilityfunc ]]( name, self.origin ) )
            {
                self thread [[ level.loot.types[ name ].onspawnfunc ]]();
                self.loot[ name ] = 1;
            }
        }
    }
}

// Namespace loot / scripts\sp\loot
// Params 6
// Checksum 0x0, Offset: 0xe04
// Size: 0x552
function registerloot( loot, lootfunc, inactivefunc, probabilityfunc, onspawnfunc, isarmor )
{
    name = loot.name_id;
    
    if ( !isstring( name ) || name == "" )
    {
        name = "loot" + level.loot.types.size + 1;
    }
    
    createnotification = default_to( loot.hudnotify, 1 );
    interactoffset = ( default_to( loot.interactoffsetx, 0 ), default_to( loot.interactoffsety, 0 ), default_to( loot.interactoffsetz, 0 ) );
    
    if ( isdefined( level.loot.types[ name ] ) )
    {
        assertmsg( "Duplicate loot name id: " + name );
    }
    
    level.loot.types[ name ] = spawnstruct();
    level.loot.types[ name ].type = default_to( loot.type, "General" );
    level.loot.types[ name ].image = loot.image;
    level.loot.types[ name ].shader = loot.shader;
    level.loot.types[ name ].loc = loot.name;
    level.loot.types[ name ].model = loot.model;
    level.loot.types[ name ].sound = loot.interactsound;
    level.loot.types[ name ].weapon = loot.weapongrenade;
    level.loot.types[ name ].weaponprimary = loot.weaponprimary;
    level.loot.types[ name ].ammoname = loot.ammoname;
    level.loot.types[ name ].hinttake = loot.hinttake;
    level.loot.types[ name ].hintswap = loot.hintswap;
    level.loot.types[ name ].chance = float( default_to( loot.probabilitychance, 40 ) );
    level.loot.types[ name ].requireuse = istrue( loot.requireuse );
    level.loot.types[ name ].createnotification = createnotification;
    level.loot.types[ name ].lootfunc = lootfunc;
    level.loot.types[ name ].inactivefunc = inactivefunc;
    level.loot.types[ name ].probabilityfunc = probabilityfunc;
    level.loot.types[ name ].onspawnfunc = onspawnfunc;
    level.loot.types[ name ].interactoffset = interactoffset;
    level.loot.types[ name ].isarmor = isarmor;
    level.loot.types[ name ].index = level.loot.types.size;
    level.loot.types[ name ].resourceamount = loot.resourceamount;
    
    if ( isdefined( loot.name ) )
    {
        precachestring( loot.name );
    }
    
    if ( isdefined( loot.hinttake ) )
    {
        precachestring( loot.hinttake );
    }
    
    if ( isdefined( loot.hintswap ) )
    {
        precachestring( loot.hintswap );
    }
    
    if ( isdefined( loot.model ) )
    {
        precachemodel( loot.model );
    }
    
    if ( isdefined( loot.shader ) )
    {
        precacheshader( loot.shader );
    }
    
    return name;
}

// Namespace loot / scripts\sp\loot
// Params 6
// Checksum 0x0, Offset: 0x135f
// Size: 0x108
function overrideloot( name, sound, lootfunc, inactivefunc, probabilityfunc, weaponname )
{
    if ( !isdefined( level.loot.types[ name ] ) )
    {
        assertmsg( "Loot name not registered '" + name + "'" );
        return;
    }
    
    level.loot.types[ name ].sound = sound;
    level.loot.types[ name ].lootfunc = lootfunc;
    level.loot.types[ name ].inactivefunc = inactivefunc;
    level.loot.types[ name ].probabilityfunc = probabilityfunc;
    level.loot.types[ name ].weapon = weaponname;
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x146f
// Size: 0x4e
function deregisterloot( name )
{
    level.loot.types[ name ] = undefined;
    level.loot.types = array_remove_key( level.loot.types, name );
}

// Namespace loot / scripts\sp\loot
// Params 2
// Checksum 0x0, Offset: 0x14c5
// Size: 0x5a
function registerammoloot( loot, probabilityfunc )
{
    name = registerloot( loot, &lootammo, &playermaxammo, probabilityfunc );
    level.loot.ammo_types[ level.loot.ammo_types.size ] = name;
}

// Namespace loot / scripts\sp\loot
// Params 2
// Checksum 0x0, Offset: 0x1527
// Size: 0x26
function registeroffhandloot( loot, probabilityfunc )
{
    registerloot( loot, &lootoffhand, &inactiveoffhand, probabilityfunc );
}

// Namespace loot / scripts\sp\loot
// Params 2
// Checksum 0x0, Offset: 0x1555
// Size: 0x26
function function_e1bd0ad03241540a( loot, probabilityfunc )
{
    registerloot( loot, &lootprimaryweapon, &inactive, probabilityfunc );
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x1583
// Size: 0xb1
function removeoffhandloot( offhand )
{
    assertex( isdefined( level.loot ), "removeOffhandLoot() must be called after load::main(). " );
    
    if ( isstring( offhand ) )
    {
        weaponname = offhand;
    }
    else
    {
        weaponname = offhand.basename;
    }
    
    key = scripts\sp\equipment\offhands::getweaponoffhandtype( weaponname );
    
    if ( isdefined( level.loot.offhands[ key ] ) )
    {
        level.loot.offhands = array_remove_key( level.loot.offhands, key );
    }
    
    level.player notify( "offhand_loot_change" );
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x163c
// Size: 0xc8
function setoffhandloot( offhand )
{
    assertex( isdefined( level.loot ), "setOffhandLoot() must be called after load::main(). " );
    
    if ( isstring( offhand ) )
    {
        weaponname = offhand;
    }
    else
    {
        weaponname = offhand.basename;
    }
    
    key = scripts\sp\equipment\offhands::getweaponoffhandtype( weaponname );
    
    if ( isdefined( level.loot.offhands[ key ] ) )
    {
        level.loot.offhands = array_remove_key( level.loot.offhands, key );
    }
    
    level.loot.offhands[ key ] = weaponname;
    level.player notify( "offhand_loot_change" );
}

// Namespace loot / scripts\sp\loot
// Params 0
// Checksum 0x0, Offset: 0x170c
// Size: 0x98
function updatearmordroptimer()
{
    level.player endon( "death" );
    level.loot.lastdroppedarmortime = -60000;
    level.loot.armordroptimer = 0;
    
    while ( true )
    {
        if ( level.player enemynearplayer() && !level.player scripts\sp\player::hasarmor() )
        {
            level.loot.armordroptimer += 0.05;
        }
        
        waitframe();
    }
}

// Namespace loot / scripts\sp\loot
// Params 0
// Checksum 0x0, Offset: 0x17ac
// Size: 0x72, Type: bool
function enemynearplayer()
{
    foreach ( enemy in getaiarray( "axis" ) )
    {
        if ( distancesquared( self.origin, enemy.origin ) <= 1048576 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace loot / scripts\sp\loot
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x1827
// Size: 0x12e
function private function_197355327a7bd01a( lootarray, droppedent, limit )
{
    entid = droppedent getentitynumber();
    lootarray[ entid ] = droppedent;
    
    if ( lootarray.size <= limit )
    {
        return lootarray;
    }
    
    lootarray = array_removeundefined( lootarray, 1 );
    
    if ( lootarray.size <= limit )
    {
        return lootarray;
    }
    
    sortedarray = sortbydistance( lootarray, level.player.origin );
    fallbackitem = undefined;
    
    for ( i = sortedarray.size - 1; i >= 0 ; i-- )
    {
        item = sortedarray[ i ];
        
        if ( level.player math::point_in_fov( item.origin ) )
        {
            if ( !isdefined( fallbackitem ) )
            {
                fallbackitem = item;
            }
            
            continue;
        }
        
        worstitem = item;
        worstitemkey = item getentitynumber();
        worstitem cleanupLootOrWeaponItem();
        lootarray[ worstitemkey ] = undefined;
        fallbackitem = undefined;
        
        if ( lootarray.size <= limit )
        {
            break;
        }
    }
    
    if ( isdefined( fallbackitem ) )
    {
        worstitemkey = fallbackitem getentitynumber();
        fallbackitem cleanupLootOrWeaponItem();
        lootarray[ worstitemkey ] = undefined;
    }
    
    return lootarray;
}

// Namespace loot / scripts\sp\loot
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x195e
// Size: 0x4c
function private ondropweapon( weaponent )
{
    level.loot.droppedweapons = function_197355327a7bd01a( level.loot.droppedweapons, weaponent, level.loot.maxweapons );
}

// Namespace loot / scripts\sp\loot
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x19b2
// Size: 0x4c
function private ondropitem( itement )
{
    level.loot.droppeditems = function_197355327a7bd01a( level.loot.droppeditems, itement, level.loot.maxloot );
}

// Namespace loot / scripts\sp\loot
// Params 0
// Checksum 0x0, Offset: 0x1a06
// Size: 0xdc
function spawncorpseloot()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.loot ) )
    {
        self.loot = [];
    }
    
    spawnpool = getspawnpool();
    
    for ( itemcount = self.loot.size; itemcount < 2 && spawnpool.size > 0 ; itemcount++ )
    {
        name = spawnpool[ randomintrange( 0, spawnpool.size ) ];
        spawnpool = array_remove( spawnpool, name );
        tag = level.loot.spawntags[ randomint( level.loot.spawntags.size ) ];
        origin = self gettagorigin( tag );
        origin = getgroundposition( origin, 1 );
        spawnlootitem( name, origin, undefined, 685, 0, 0 );
    }
}

// Namespace loot / scripts\sp\loot
// Params 2
// Checksum 0x0, Offset: 0x1aea
// Size: 0x15c
function getspawnpool( typefilter, fallbacklootname )
{
    if ( isdefined( typefilter ) && !isarray( typefilter ) )
    {
        typefilter = [ typefilter ];
    }
    
    spawnpool = [];
    
    foreach ( name, loottype in level.loot.types )
    {
        if ( isdefined( typefilter ) && !array_contains( typefilter, loottype.type ) )
        {
            continue;
        }
        
        if ( isdefined( level.loot.types[ name ].onspawnfunc ) )
        {
            continue;
        }
        
        if ( isdefined( self.loot ) && istrue( self.loot[ name ] ) )
        {
            continue;
        }
        
        probabilityfunc = level.loot.types[ name ].probabilityfunc;
        
        if ( isdefined( probabilityfunc ) )
        {
            canspawnloot = self [[ probabilityfunc ]]( name, self.origin );
            
            if ( canspawnloot )
            {
                spawnpool[ spawnpool.size ] = name;
            }
        }
    }
    
    if ( isdefined( fallbacklootname ) && spawnpool.size == 0 )
    {
        spawnpool = [ fallbacklootname ];
    }
    
    return spawnpool;
}

// Namespace loot / scripts\sp\loot
// Params 7
// Checksum 0x0, Offset: 0x1c4f
// Size: 0x198
function spawnlootitem( name, origin, angles, force, worldplaced, shouldsuspend, usephysics )
{
    if ( ( islootarmor( name ) || islootarmorvest( name ) ) && !playerarmorenabled() )
    {
        return;
    }
    
    if ( !isdefined( angles ) )
    {
        angles = randomvectorrange( 0, 360 );
        
        if ( islootarmor( name ) )
        {
            angles = ( -90, angles[ 1 ], 0 );
        }
    }
    
    if ( !isdefined( force ) )
    {
        force = 1;
    }
    
    if ( isdefined( shouldsuspend ) && !isdefined( usephysics ) )
    {
        usephysics = !shouldsuspend;
    }
    
    spawnflags = scripts\sp\script_items::scriptitem_buildspawnflags( shouldsuspend, usephysics, 1, 0, 1 );
    model = level.loot.types[ name ].model;
    impulse = ( randomfloat( 0.5 ), randomfloat( 0.5 ), 1 ) * force;
    item = spawnscriptitem( "script_item_" + name, origin, angles, spawnflags, model, "", impulse, origin );
    item.script_count = self.script_count;
    item.script_count_min = self.script_count_min;
    item.script_count_max = self.script_count_max;
    
    if ( !istrue( worldplaced ) )
    {
        callsharedfunc( "loot", "dropItem", item );
    }
    
    if ( isdefined( item ) )
    {
        setitemasloot( item, name, worldplaced );
        return item;
    }
}

// Namespace loot / scripts\sp\loot
// Params 3
// Checksum 0x0, Offset: 0x1def
// Size: 0x48
function setitemasloot( item, name, worldplaced )
{
    item.name = name;
    item.worldplaced = worldplaced;
    item thread cleanuplootitemondelete();
    item thread checkforlootitemtrigger( name );
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x1e3f
// Size: 0x16
function itemworldplaced( item )
{
    return item.worldplaced;
}

// Namespace loot / scripts\sp\loot
// Params 0
// Checksum 0x0, Offset: 0x1e5e
// Size: 0x11
function cleanuplootitemondelete()
{
    self waittill( "death" );
    cleanupLootOrWeaponItem();
}

// Namespace loot / scripts\sp\loot
// Params 0
// Checksum 0x0, Offset: 0x1e77
// Size: 0x2a
function cleanupLootOrWeaponItem()
{
    if ( isdefined( self.cursor_hint_ent ) )
    {
        self.cursor_hint_ent delete();
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x1ea9
// Size: 0x118
function checkforlootitemtrigger( name )
{
    self endon( "death" );
    
    while ( true )
    {
        if ( istrue( self.worldplaced ) || level.loot.types[ name ].requireuse )
        {
            function_d6a22d94bbd3c5c( name );
        }
        else
        {
            self waittill( "trigger", who );
            
            if ( who != level.player )
            {
                continue;
            }
        }
        
        waittillplayercanloot();
        waittillnextloottime();
        inactivefunc = level.loot.types[ name ].inactivefunc;
        
        if ( isdefined( inactivefunc ) && [[ inactivefunc ]]( name ) )
        {
            continue;
        }
        
        if ( istrue( self.worldplaced ) && isdefined( level.loot.pickupgesture ) )
        {
            level.player playgestureviewmodel( level.loot.pickupgesture, self );
        }
        
        lootfuncandnotification( name );
        self delete();
    }
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x1fc9
// Size: 0xc1
function function_d6a22d94bbd3c5c( name )
{
    displayname = level.loot.types[ name ].loc;
    offset = level.loot.types[ name ].interactoffset;
    self.var_2962af1b05702467 = 1;
    scripts\sp\player\cursor_hint::function_31a9edf082d398f5( "cursorhint_lootpickup", displayname, undefined, offset );
    thread function_8b9cc449b9f5159d( name, displayname );
    
    while ( true )
    {
        self.cursor_hint_ent waittill( "trigger", who );
        
        if ( who != level.player )
        {
            continue;
        }
        
        break;
    }
    
    scripts\sp\player\cursor_hint::remove_cursor_hint();
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x2092
// Size: 0x9a
function function_512014a40727de4( name )
{
    if ( !isdefined( level.loot.types[ name ].weaponobj ) )
    {
        weap = getoffhandweaponname( name );
        
        if ( isdefined( weap ) )
        {
            attachments = getweapondefaultattachments( weap );
            
            if ( istrue( attachments.size ) )
            {
                weaponobj = makeweapon( weap, attachments );
            }
            else
            {
                weaponobj = makeweaponfromstring( weap );
            }
            
            level.loot.types[ name ].weaponobj = weaponobj;
        }
    }
}

// Namespace loot / scripts\sp\loot
// Params 2
// Checksum 0x0, Offset: 0x2134
// Size: 0x213
function function_8b9cc449b9f5159d( name, displayname )
{
    self endon( "hint_destroyed" );
    self endon( "death" );
    self.cursor_hint_ent endon( "death" );
    
    if ( level.loot.types[ name ].type == "Resource" )
    {
        return;
    }
    
    currentammo = -1;
    
    while ( true )
    {
        previousammo = currentammo;
        
        if ( islootammo( name ) )
        {
            currentammo = level.player scripts\sp\player::getammonameamount( name );
        }
        else if ( islootarmor( name ) && !level.player scripts\sp\player::function_34895a6255f4587a() )
        {
            currentammo = level.player scripts\sp\player::getarmoramount();
        }
        else if ( islootarmor( name ) )
        {
            currentammo = level.player scripts\sp\player::function_85e373bb15921966();
        }
        else if ( islootarmorvest( name ) )
        {
            currentammo = level.player scripts\sp\player::getarmoramount();
        }
        else if ( islootweapon( name ) )
        {
            currentammo = -1;
        }
        else
        {
            currentammo = getoffhandcurrentammo( name );
        }
        
        if ( currentammo != previousammo )
        {
            if ( islootammo( name ) )
            {
                maxammo = level.player scripts\sp\player::getammonamemaxamount( name );
            }
            else if ( islootarmor( name ) && !level.player scripts\sp\player::function_34895a6255f4587a() )
            {
                maxammo = level.player scripts\sp\player::getarmormaxamount();
            }
            else if ( islootarmor( name ) )
            {
                maxammo = level.player scripts\sp\player::function_c241aeec324282f0();
            }
            else if ( islootarmorvest( name ) )
            {
                maxammo = level.player scripts\sp\player::getarmormaxamount();
            }
            else
            {
                maxammo = function_57888d406854dc7f( name );
            }
            
            if ( currentammo >= maxammo )
            {
                self.cursor_hint_ent sethintinoperable( 1 );
                self.cursor_hint_ent sethintstring( &"EQUIPMENT/FULL" );
            }
            else
            {
                self.cursor_hint_ent sethintinoperable( 0 );
                self.cursor_hint_ent sethintstring( displayname );
            }
        }
        
        waitframe();
    }
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x234f
// Size: 0x5e
function lootfuncandnotification( name )
{
    self thread [[ level.loot.types[ name ].lootfunc ]]( name );
    scripts\sp\analytics::analytics_event_upload( "loot_pickup", name );
    level.player notify( "item_loot" );
    playlootsound( name );
    thread createnotification( name );
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x23b5
// Size: 0x50
function playermaxarmor( name )
{
    if ( level.player scripts\sp\player::function_34895a6255f4587a() )
    {
        return level.player scripts\sp\player::hasmaxarmorplates();
    }
    
    return level.player scripts\sp\player::getarmoramount() >= level.player scripts\sp\player::getarmormaxamount();
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x240d
// Size: 0x1a
function function_a57539eb7fbc0627( name )
{
    return level.player scripts\sp\player::hasmaxarmor();
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x2430
// Size: 0x2c, Type: bool
function playermaxammo( name )
{
    return level.player scripts\sp\player::getammonameamount( name ) >= level.player scripts\sp\player::getammonamemaxamount( name );
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x2465
// Size: 0xba
function inactiveoffhand( name )
{
    weaponname = getoffhandweaponname( name );
    
    if ( !isdefined( weaponname ) )
    {
        assertmsg( "offhand " + name + " does not have weapon associated." );
    }
    
    if ( issharedfuncdefined( "loot", "_isInactiveOffhand", 0 ) )
    {
        return level.player [[ getsharedfunc( "loot", "_isInactiveOffhand" ) ]]( name, weaponname );
    }
    
    if ( !player_has_equipment( weaponname ) )
    {
        offhandtype = scripts\sp\equipment\offhands::getweaponoffhandtype( weaponname );
        
        if ( !player_offhand_empty( offhandtype ) )
        {
            return 1;
        }
    }
    
    currentammo = getoffhandcurrentammo( name );
    maxammo = function_57888d406854dc7f( name );
    return currentammo >= maxammo;
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x2528
// Size: 0xc, Type: bool
function inactive( name )
{
    return false;
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x253d
// Size: 0x48
function player_offhand_empty( offhandtype )
{
    offhand = level.player getcurrentoffhand( offhandtype );
    
    if ( !isdefined( offhand ) || offhand.basename == "none" )
    {
        return 1;
    }
    
    return 0;
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x258d
// Size: 0x76
function function_3fd5749f637651b7( weapon )
{
    foreach ( loot in level.loot.types )
    {
        if ( is_equal( loot.weapon, weapon ) )
        {
            return name;
        }
    }
    
    return undefined;
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x260c
// Size: 0x2a
function getoffhandprobabilityfromname( name )
{
    return level.loot.types[ name ].chance;
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x263f
// Size: 0x2a
function getoffhandweaponname( name )
{
    return level.loot.types[ name ].weapon;
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x2672
// Size: 0x2a
function function_173c699830122e92( name )
{
    return level.loot.types[ name ].weaponobj;
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x26a5
// Size: 0xd9
function getoffhandcurrentammo( name )
{
    weaponname = getoffhandweaponname( name );
    
    if ( issharedfuncdefined( "loot", "_getOffhandCurrentAmmo", 0 ) )
    {
        return level.player [[ getsharedfunc( "loot", "_getOffhandCurrentAmmo" ) ]]( name, weaponname );
    }
    
    if ( player_has_equipment( weaponname ) )
    {
        equiplist = level.player.offhandinventory;
        
        foreach ( weapon in equiplist )
        {
            if ( weapon.basename == weaponname )
            {
                return level.player getweaponammostock( weapon );
            }
        }
    }
    
    return 0;
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x2787
// Size: 0x66
function function_57888d406854dc7f( name )
{
    if ( isdefined( level.loot.types[ name ].maxammo ) )
    {
        return level.loot.types[ name ].maxammo;
    }
    
    weaponname = getoffhandweaponname( name );
    return weaponmaxammo( weaponname );
}

// Namespace loot / scripts\sp\loot
// Params 2
// Checksum 0x0, Offset: 0x27f6
// Size: 0x34
function function_138ce2f6a3e08e1b( name, maxammo )
{
    level.loot.types[ name ].maxammo = maxammo;
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x2832
// Size: 0x98
function lootammo( name )
{
    itement = self;
    ogammo = scripts\sp\player::getammonameamount( name );
    maxammo = scripts\sp\player::getammonamemaxamount( name );
    var_fab97c83933f6b68 = getammolootamount( ogammo, maxammo );
    finalammo = int( min( maxammo, ogammo + var_fab97c83933f6b68 ) );
    
    if ( finalammo != ogammo )
    {
        level.player scripts\sp\player::setammonameamount( name, finalammo );
        
        /#
            function_3a93ae15cef29091( "<dev string:x1c>" + var_fab97c83933f6b68 + "<dev string:x26>" + name );
        #/
    }
}

// Namespace loot / scripts\sp\loot
// Params 2
// Checksum 0x0, Offset: 0x28d2
// Size: 0x52
function getammolootamount( ogammo, maxammo )
{
    ammofrac = math::normalize_value( 0, maxammo, ogammo );
    ammomaxfrac = math::factor_value( 0.5, 0.1, ammofrac );
    return max( 1, int( ammomaxfrac * maxammo ) );
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x292d
// Size: 0x77
function lootarmor( name )
{
    itement = self;
    
    if ( level.player scripts\sp\player::function_34895a6255f4587a() )
    {
        lastarmorplateamount = level.player scripts\sp\player::function_85e373bb15921966();
        level.player scripts\sp\player::function_e9e42cffedaa98d5( lastarmorplateamount + 1 );
    }
    else
    {
        level.player notify( "armor_pressed" );
    }
    
    thread createnotification( "armorplate" );
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x29ac
// Size: 0x34
function lootarmorvest( name )
{
    itement = self;
    level.player scripts\sp\player::give_player_max_armor();
    thread createnotification( "armorvest" );
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x29e8
// Size: 0x237
function lootoffhand( name )
{
    itement = self;
    weaponname = getoffhandweaponname( name );
    
    if ( !isdefined( weaponname ) )
    {
        assertmsg( "offhand " + name + " does not have weapon associated." );
    }
    
    if ( issharedfuncdefined( "loot", "_lootOffhand", 0 ) )
    {
        level.player [[ getsharedfunc( "loot", "_lootOffhand" ) ]]( name, weaponname );
        return;
    }
    
    if ( player_has_equipment( weaponname, 1 ) )
    {
        equiplist = level.player.offhandinventory;
        
        foreach ( weapon in equiplist )
        {
            if ( isweapon( weapon ) )
            {
                if ( weapon.basename == weaponname )
                {
                    ogammo = level.player getweaponammostock( weapon );
                    maxammo = function_57888d406854dc7f( name );
                    finalammo = int( min( ogammo + 1, maxammo ) );
                    level.player setweaponammoclip( weapon, finalammo );
                }
                
                continue;
            }
            
            if ( isstring( weapon ) )
            {
                if ( weapon == weaponname )
                {
                    attachments = getweapondefaultattachments( weapon );
                    
                    if ( istrue( attachments.size ) )
                    {
                        objweapon = makeweapon( weapon, attachments );
                        
                        foreach ( attachment in attachments )
                        {
                            ogammo = level.player getweaponammostock( objweapon );
                            maxammo = function_57888d406854dc7f( name );
                            finalammo = int( min( ogammo + 1, maxammo ) );
                            level.player setweaponammoclip( objweapon, finalammo );
                        }
                    }
                }
            }
        }
        
        return;
    }
    
    level.player give_offhand( weaponname, 1 );
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x2c27
// Size: 0x67
function lootprimaryweapon( name )
{
    level.player giveweapon( level.loot.types[ name ].weaponprimary );
    level.player switchtoweapon( level.loot.types[ name ].weaponprimary );
}

// Namespace loot / scripts\sp\loot
// Params 6
// Checksum 0x0, Offset: 0x2c96
// Size: 0xdd
function function_1693de8f478a2d4a( loot, lootfunc, inactivefunc, probabilityfunc, onspawnfunc, isarmor )
{
    registerloot( loot, lootfunc, inactivefunc, probabilityfunc, onspawnfunc, isarmor );
    resourcetype = level.loot.types[ loot.name_id ].ammoname;
    level.loot.var_d0d7b34e9765980a[ resourcetype ] = level.player getplayerprogression( "resource", resourcetype );
    
    /#
        if ( getdvarint( @"hash_7dfe19d75d304409", 0 ) )
        {
            iprintlnbold( "<dev string:x2a>" + resourcetype + "<dev string:x30>" + level.loot.var_d0d7b34e9765980a[ resourcetype ] );
        }
    #/
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x2d7b
// Size: 0x1ff
function lootresource( name )
{
    itement = self;
    
    if ( isdefined( level.fnlootresource ) )
    {
        itement [[ level.fnlootresource ]]( name );
        return;
    }
    
    resourcetype = level.loot.types[ name ].ammoname;
    
    if ( !isstring( resourcetype ) )
    {
        return;
    }
    
    var_e7ad591e8456a62 = 0;
    
    if ( isdefined( itement.script_count ) && int( itement.script_count ) != 0 )
    {
        var_e7ad591e8456a62 = int( itement.script_count );
    }
    else if ( isdefined( itement.script_count_min ) && isdefined( itement.script_count_max ) )
    {
        var_e7ad591e8456a62 = int( math::lerp( int( itement.script_count_min ), int( itement.script_count_max ), randomfloat( 1 ) ) );
    }
    
    resourceamount = 0;
    
    if ( var_e7ad591e8456a62 != 0 )
    {
        resourceamount = var_e7ad591e8456a62;
    }
    else
    {
        resourceamount = int( default_to( level.loot.types[ name ].resourceamount, 0 ) );
    }
    
    if ( resourceamount != 0 )
    {
        if ( !isdefined( level.loot.resourcepending[ resourcetype ] ) )
        {
            level.loot.resourcepending[ resourcetype ] = 0;
        }
        
        level.loot.resourcepending[ resourcetype ] += resourceamount;
        
        /#
            if ( getdvarint( @"hash_7dfe19d75d304409", 0 ) )
            {
                iprintlnbold( "<dev string:x2a>" + resourcetype + "<dev string:x30>" + level.loot.var_d0d7b34e9765980a[ resourcetype ] + level.loot.resourcepending[ resourcetype ] );
            }
        #/
    }
}

// Namespace loot / scripts\sp\loot
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2f82
// Size: 0x113
function private function_2099b5b188b3a60c()
{
    while ( true )
    {
        level waittill( "save_saved" );
        
        foreach ( resourcetype, var_6b4440c1be287114 in level.loot.resourcepending )
        {
            banked = level.loot.var_d0d7b34e9765980a[ resourcetype ];
            var_6fcc2676d1564bd4 = banked + var_6b4440c1be287114;
            level.player setplayerprogression( "resource", resourcetype, var_6fcc2676d1564bd4 );
            level.loot.var_d0d7b34e9765980a[ resourcetype ] = var_6fcc2676d1564bd4;
            
            /#
                if ( getdvarint( @"hash_7dfe19d75d304409", 0 ) )
                {
                    iprintlnbold( "<dev string:x2a>" + resourcetype + "<dev string:x30>" + level.loot.var_d0d7b34e9765980a[ resourcetype ] );
                }
            #/
        }
        
        level.loot.resourcepending = [];
    }
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x309d
// Size: 0xb
function donothing( name )
{
    
}

// Namespace loot / scripts\sp\loot
// Params 2
// Checksum 0x0, Offset: 0x30b0
// Size: 0x144, Type: bool
function probabilityarmor( name, origin )
{
    if ( istrue( self.noarmor ) )
    {
        /#
            function_3a93ae15cef29091( "<dev string:x34>" );
        #/
        
        return false;
    }
    
    if ( force_armor_drop() )
    {
        /#
            function_3a93ae15cef29091( "<dev string:x55>" );
        #/
        
        return true;
    }
    
    if ( isdefined( level.player.lootarmorchance ) )
    {
        if ( !isdefined( level.player.var_8add256b2e4988e5 ) )
        {
            level.player.var_8add256b2e4988e5 = 0;
        }
        
        droparmor = randomfloat( 1 ) < level.player.lootarmorchance;
        
        if ( !droparmor )
        {
            level.player.var_8add256b2e4988e5++;
            
            if ( level.player.var_8add256b2e4988e5 >= 1 / level.player.lootarmorchance )
            {
                droparmor = 1;
            }
        }
        
        if ( droparmor )
        {
            /#
                function_3a93ae15cef29091( "<dev string:x72>" + level.player.lootarmorchance );
            #/
            
            level.player.var_8add256b2e4988e5 = 0;
            return true;
        }
    }
    
    return false;
}

// Namespace loot / scripts\sp\loot
// Params 0
// Checksum 0x0, Offset: 0x31fd
// Size: 0x36
function armorinventoryratio()
{
    ratio = 1 - level.player scripts\sp\player::function_85e373bb15921966() / level.player scripts\sp\player::function_c241aeec324282f0();
    return 0.15 * ratio;
}

// Namespace loot / scripts\sp\loot
// Params 0
// Checksum 0x0, Offset: 0x323c
// Size: 0x36
function armorhealthratio()
{
    ratio = 1 - level.player scripts\sp\player::getarmoramount() / level.player scripts\sp\player::getarmormaxamount();
    return 0.1 * ratio;
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x327b
// Size: 0x33
function armordistanceratio( distancesq )
{
    constant = 1 / 2250000;
    ratio = constant * distancesq;
    return 0.75 * ratio;
}

// Namespace loot / scripts\sp\loot
// Params 0
// Checksum 0x0, Offset: 0x32b7
// Size: 0x3d
function armormaxprobability()
{
    ratio = min( level.loot.armordroptimer / 120, 1 );
    addedprobability = 82 * ratio;
    return 3 + addedprobability;
}

// Namespace loot / scripts\sp\loot
// Params 2
// Checksum 0x0, Offset: 0x32fd
// Size: 0x14, Type: bool
function probabilityzero( name, origin )
{
    return false;
}

// Namespace loot / scripts\sp\loot
// Params 0
// Checksum 0x0, Offset: 0x331a
// Size: 0x66
function get_stowed_primary_weapon()
{
    foreach ( weapon in self.primaryinventory )
    {
        if ( !issameweapon( weapon, self.currentprimaryweapon, 1 ) )
        {
            return weapon;
        }
    }
    
    return nullweapon();
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x3389
// Size: 0x95
function function_f9020ea5cfe8cde6( name )
{
    worldcount = 0;
    
    foreach ( item in level.loot.items )
    {
        if ( ( !isdefined( name ) || is_equal( item.name, name ) ) && !itemworldplaced( item ) )
        {
            worldcount++;
        }
    }
    
    return worldcount;
}

// Namespace loot / scripts\sp\loot
// Params 2
// Checksum 0x0, Offset: 0x3427
// Size: 0x13b, Type: bool
function probabilityoffhand( name, origin )
{
    weaponname = getoffhandweaponname( name );
    
    if ( !isdefined( weaponname ) )
    {
        assertmsg( "offhand " + name + " does not have weapon associated." );
    }
    
    if ( !array_contains( level.loot.offhands, weaponname ) )
    {
        return false;
    }
    
    if ( !scripts\sp\equipment\offhands::offhandisprecached( name ) )
    {
        return false;
    }
    
    distancesq = distancesquared( origin, level.player.origin );
    
    if ( distancesq > 2250000 )
    {
        return false;
    }
    
    maxchance = getoffhandprobabilityfromname( name );
    
    if ( maxchance == 0 )
    {
        return false;
    }
    
    currentammo = getoffhandcurrentammo( name );
    maxammo = function_57888d406854dc7f( name );
    
    if ( currentammo >= maxammo )
    {
        chance = 0;
    }
    else
    {
        chance = maxchance * ( 1 - currentammo / maxammo );
    }
    
    if ( randomint( 100 ) > chance )
    {
        return false;
    }
    
    worldcount = function_f9020ea5cfe8cde6( name );
    var_27372c85ed16c136 = worldcount + currentammo >= maxammo;
    
    if ( !var_27372c85ed16c136 )
    {
        return true;
    }
    
    return false;
}

// Namespace loot / scripts\sp\loot
// Params 2
// Checksum 0x0, Offset: 0x356b
// Size: 0x143, Type: bool
function probabilityoffhandwheel( name, origin )
{
    weaponname = getoffhandweaponname( name );
    
    if ( !isdefined( weaponname ) )
    {
        assertmsg( "offhand " + name + " does not have weapon associated." );
    }
    
    if ( !isdefined( level.loot.wheelweapons ) || !isdefined( level.loot.wheelweapons[ weaponname ] ) )
    {
        return false;
    }
    
    if ( !scripts\sp\equipment\offhands::offhandisprecached( weaponname ) )
    {
        return false;
    }
    
    distancesq = distancesquared( origin, level.player.origin );
    
    if ( distancesq > 2250000 )
    {
        return false;
    }
    
    maxchance = getoffhandprobabilityfromname( name );
    
    if ( maxchance <= 0 )
    {
        return false;
    }
    
    if ( !isdefined( level.var_b3db93fc6e8c7f63 ) )
    {
        return false;
    }
    
    if ( !isdefined( level.var_b3db93fc6e8c7f63[ weaponname ] ) )
    {
        return false;
    }
    
    currentammo = getoffhandcurrentammo( name );
    maxammo = function_57888d406854dc7f( name );
    
    if ( currentammo >= maxammo )
    {
        return false;
    }
    
    chance = maxchance * ( 1 - currentammo / maxammo );
    
    if ( randomint( 100 ) > chance )
    {
        return false;
    }
    
    return true;
}

// Namespace loot / scripts\sp\loot
// Params 0
// Checksum 0x0, Offset: 0x36b7
// Size: 0x17
function waittillplayercanloot()
{
    while ( level.player ismeleeing() )
    {
        waitframe();
    }
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x36d6
// Size: 0x97
function playlootsound( name )
{
    if ( isdefined( level.loot.types[ name ].sound ) && soundexists( level.loot.types[ name ].sound ) )
    {
        level.loot.sfx delaycall( 0.2, &playsound, level.loot.types[ name ].sound );
    }
}

// Namespace loot / scripts\sp\loot
// Params 2
// Checksum 0x0, Offset: 0x3775
// Size: 0x24f
function createnotification( name, showinrealism )
{
    isvalidname = isdefined( name );
    
    if ( !isvalidname )
    {
        return;
    }
    
    isvalidtype = isdefined( level.loot.types[ name ] );
    
    if ( !isvalidtype )
    {
        foreach ( loottype in level.loot.types )
        {
            if ( isdefined( loottype.weapon ) && getweaponbasename( loottype.weapon ) == name )
            {
                name = lootname;
                isvalidname = 1;
                isvalidtype = 1;
                break;
            }
        }
    }
    
    if ( !isvalidtype )
    {
        return;
    }
    
    shouldcreatenotification = istrue( level.loot.types[ name ].createnotification );
    
    if ( !shouldcreatenotification )
    {
        return;
    }
    
    shouldcreatenotif = !in_realism_mode() || istrue( showinrealism );
    
    if ( shouldcreatenotif )
    {
        if ( isdefined( level.loot.splashwidget ) )
        {
            if ( !level.player scripts\engine\hud_management::function_ada0825249682644( "loot_splash_display" ) )
            {
                level.player scripts\engine\hud_management::function_90de31b2cbef19f9( "loot_splash_display", level.loot.splashwidget );
                level.player scripts\engine\hud_management::function_f4c37324750dc183( "loot_splash_display", 0, -225, 2, 2 );
            }
            
            level.player scripts\engine\hud_management::function_6e45b720d0914f42( "loot_splash_display", "ui_loot_splash_index", level.loot.types[ name ].index );
        }
        else
        {
            shader = level.loot.types[ name ].shader;
            locname = level.loot.types[ name ].loc;
            setomnvar( "ui_loot_splash_name", locname );
            setomnvar( "ui_loot_splash_icon", shader );
        }
        
        waitframe();
        destroylootnotification();
    }
}

// Namespace loot / scripts\sp\loot
// Params 0
// Checksum 0x0, Offset: 0x39cc
// Size: 0x74
function waittillnextloottime()
{
    currenttime = gettime();
    goaltime = level.loot.lastloottime + 250;
    
    if ( currenttime > goaltime )
    {
        level.loot.lastloottime = currenttime;
        return;
    }
    
    level.loot.lastloottime = goaltime;
    
    while ( gettime() < goaltime )
    {
        waitframe();
    }
}

// Namespace loot / scripts\sp\loot
// Params 0
// Checksum 0x0, Offset: 0x3a48
// Size: 0x57
function destroylootnotification()
{
    if ( isdefined( level.loot.splashwidget ) )
    {
        level.player scripts\engine\hud_management::function_6e45b720d0914f42( "loot_splash_display", "ui_loot_splash_index", 0 );
        return;
    }
    
    setomnvar( "ui_loot_splash_name", "none" );
    setomnvar( "ui_loot_splash_icon", "none" );
}

// Namespace loot / scripts\sp\loot
// Params 0
// Checksum 0x0, Offset: 0x3aa7
// Size: 0x118
function setworldloot()
{
    waittillframeend();
    
    foreach ( struct in getstructarray( "lootSpawn", "targetname" ) )
    {
        isrefloot = struct isrefloot();
        
        if ( !isdefined( struct.script_noteworthy ) )
        {
            if ( !isrefloot )
            {
                struct thread worldlootwaitproximity();
            }
            
            continue;
        }
        
        /#
            if ( !isdefined( level.loot.types[ struct.script_noteworthy ] ) )
            {
                iprintlnbold( "<dev string:x9b>" + struct.script_noteworthy + "<dev string:xc1>" + struct.origin + "<dev string:xc8>" );
                continue;
            }
        #/
        
        if ( !isrefloot )
        {
            struct spawnlootitem( struct.script_noteworthy, struct.origin, struct.angles, 0, 1, istrue( struct.script_suspend ) );
        }
    }
}

// Namespace loot / scripts\sp\loot
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3bc7
// Size: 0x1a5
function private worldlootwaitproximity( radius )
{
    self notify( "worldLootWaitProximity" );
    self endon( "worldLootWaitProximity" );
    radius = default_to( radius, 1000 );
    radiussq = squared( radius );
    
    while ( isdefined( self ) )
    {
        wait randomfloatrange( 0.5, 1 );
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        foreach ( player in level.players )
        {
            if ( distancesquared( player.origin, self.origin ) < radiussq )
            {
                spawnpool = getspawnpool( "Offhand", "frag" );
                
                if ( spawnpool.size > 0 )
                {
                    self.script_noteworthy = spawnpool[ randomintrange( 0, spawnpool.size ) ];
                }
                
                if ( !isdefined( self.script_noteworthy ) )
                {
                    return;
                }
                
                itement = spawnlootitem( self.script_noteworthy, self.origin, self.angles, 0, 1, istrue( self.script_suspend ) );
                
                if ( istrue( level.loot.var_307d8c71918f2204 ) )
                {
                    if ( !isdefined( self.spawned_items ) )
                    {
                        self.spawned_items = [];
                    }
                    
                    self.spawned_items[ itement getentitynumber() ] = itement;
                    level.loot.var_8da39343ac7feaf3[ level.loot.var_8da39343ac7feaf3.size ] = self;
                }
                
                return;
            }
        }
    }
}

// Namespace loot / scripts\sp\loot
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3d74
// Size: 0xdd
function private function_cdd633dcd334b643()
{
    foreach ( lootstruct in level.loot.var_8da39343ac7feaf3 )
    {
        if ( isdefined( lootstruct.spawned_items ) && lootstruct.spawned_items.size > 0 )
        {
            foreach ( itement in lootstruct.spawned_items )
            {
                itement cleanupLootOrWeaponItem();
            }
            
            lootstruct.spawned_items = undefined;
            lootstruct thread worldlootwaitproximity();
        }
    }
}

// Namespace loot / scripts\sp\loot
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3e59
// Size: 0x19
function private function_62cab66e6e85f19a()
{
    while ( true )
    {
        level waittill( "save_loaded" );
        function_cdd633dcd334b643();
    }
}

// Namespace loot / scripts\sp\loot
// Params 0
// Checksum 0x0, Offset: 0x3e7a
// Size: 0x27
function isrefloot()
{
    if ( isdefined( self.spawnflags ) && self.spawnflags & 1 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x3ea9
// Size: 0x25
function islootammo( name )
{
    return array_contains( level.loot.ammo_types, name );
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x3ed7
// Size: 0x21
function islootarmor( name )
{
    return is_equal( tolower( "armorplate" ), tolower( name ) );
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x3f01
// Size: 0x21
function islootarmorvest( name )
{
    return is_equal( tolower( "armorvest" ), tolower( name ) );
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x3f2b
// Size: 0x30, Type: bool
function islootweapon( name )
{
    return level.loot.types[ name ].type == "PrimaryWeapon";
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x3f64
// Size: 0xad
function createpickupicon( shader )
{
    self endon( "death" );
    self endon( "entitydeleted" );
    
    while ( distancesquared( level.player.origin, self.origin ) > 2250000 )
    {
        waitframe();
    }
    
    target_alloc( self, ( 0, 0, 10 ) );
    target_drawsquare( self );
    target_drawsingle( self );
    target_setcolor( self, ( 1, 1, 1 ), 0 );
    target_setscaledrendermode( self, 0 );
    target_showtoplayer( self, level.player );
    target_setshader( self, shader );
    target_flush( self );
    childthread updatepickupicon();
}

// Namespace loot / scripts\sp\loot
// Params 0
// Checksum 0x0, Offset: 0x4019
// Size: 0x1c1
function updatepickupicon()
{
    self.alpha = 0;
    self.iconsize = 0;
    spawntime = gettime();
    
    while ( true )
    {
        distance = distance( level.player.origin, self.origin );
        iconisnew = gettime() < spawntime + 2150;
        playercanseeicon = isalive( level.player ) && level.player scripts\engine\trace::can_see_origin( self.origin + ( 0, 0, 10 ), 0 );
        
        if ( iconisnew || playercanseeicon )
        {
            normalizedalpha = 1 - math::normalize_value( 0, 1000, distance );
            goalalpha = normalizedalpha * 1.25;
        }
        else
        {
            goalalpha = 0;
        }
        
        if ( goalalpha != self.alpha )
        {
            var_dc159c0cf90e1f51 = clamp( ( goalalpha - self.alpha ) * 0.45, -0.125, 0.125 );
            var_e1fa213d78fa2a9b = self.alpha + var_dc159c0cf90e1f51;
            target_setcolor( self, ( 1, 1, 1 ), var_e1fa213d78fa2a9b );
            self.alpha = var_e1fa213d78fa2a9b;
        }
        
        normalizedsize = math::normalize_value( 100, 1000, distance );
        iconsize = int( math::factor_value( 32, 8, normalizedsize ) * 1 );
        
        if ( iconsize != self.iconsize )
        {
            target_setminsize( self, iconsize, 0 );
            target_setmaxsize( self, iconsize, 0 );
            self.iconsize = iconsize;
        }
        
        waitframe();
    }
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x41e2
// Size: 0x74, Type: bool
function indonotspawnlootvolume( entity )
{
    var_788dc5c5a040cc11 = getentarray( "doNotSpawnLoot", "targetname" );
    
    foreach ( volume in var_788dc5c5a040cc11 )
    {
        if ( entity istouching( volume ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x425f
// Size: 0x11e
function has_weapon( weapon )
{
    primaryoffhand = self getoffhandprimaryclass();
    secondaryoffhand = self getoffhandsecondaryclass();
    
    if ( isstring( weapon ) )
    {
        all_weapons = self getweaponslistall();
        
        foreach ( item in all_weapons )
        {
            if ( isnullweapon( item ) )
            {
                continue;
            }
            
            if ( weapontype( item ) == "grenade" && !is_equal( item.basename, primaryoffhand ) && !is_equal( item.basename, secondaryoffhand ) )
            {
                if ( item.basename != "smoke_empty" )
                {
                    continue;
                }
            }
            
            if ( is_equal( item.basename, weapon ) )
            {
                return 1;
            }
        }
        
        return 0;
    }
    
    assert( isweapon( weapon ) );
    return self hasweapon( weapon );
}

// Namespace loot / scripts\sp\loot
// Params 1
// Checksum 0x0, Offset: 0x4385
// Size: 0x15
function set_force_armor_drop( boolean )
{
    self.lootforcearmordrop = boolean;
}

// Namespace loot / scripts\sp\loot
// Params 0
// Checksum 0x0, Offset: 0x43a2
// Size: 0xc, Type: bool
function force_armor_drop()
{
    return istrue( self.lootforcearmordrop );
}

/#

    // Namespace loot / scripts\sp\loot
    // Params 1
    // Checksum 0x0, Offset: 0x43b7
    // Size: 0x1e, Type: dev
    function function_3a93ae15cef29091( string )
    {
        if ( lootdebugenabled() )
        {
            iprintln( string );
        }
    }

    // Namespace loot / scripts\sp\loot
    // Params 0
    // Checksum 0x0, Offset: 0x43dd
    // Size: 0xd, Type: dev
    function function_3c821aac4af727f3()
    {
        thread function_cd2e7283c864308a();
    }

    // Namespace loot / scripts\sp\loot
    // Params 0
    // Checksum 0x0, Offset: 0x43f2
    // Size: 0x15a, Type: dev
    function function_cd2e7283c864308a()
    {
        while ( true )
        {
            if ( !lootdebugenabled() )
            {
                waitframe();
                continue;
            }
            
            if ( isdefined( level.loot.items ) )
            {
                foreach ( item in level.loot.items )
                {
                    line( item.origin, item.origin + ( 0, 0, 120 ), ( 0, 0, 1 ), 1, 0, 1 );
                    print3d( item.origin, item.name, ( 0, 0, 1 ), 1, 0.5, 1 );
                    
                    if ( islootarmor( item.name ) )
                    {
                        if ( itemworldplaced( item ) )
                        {
                            sphere( item.origin, 15, ( 0, 0, 1 ), 0, 1 );
                            continue;
                        }
                        
                        sphere( item.origin, 15, ( 0, 1, 0 ), 0, 1 );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace loot / scripts\sp\loot
    // Params 0
    // Checksum 0x0, Offset: 0x4554
    // Size: 0x14, Type: dev
    function lootdebugenabled()
    {
        return getdvarint( @"hash_7dfe19d75d304409" );
    }

#/
