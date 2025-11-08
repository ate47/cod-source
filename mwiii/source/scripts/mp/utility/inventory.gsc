#using scripts\common\utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#using scripts\mp\juggernaut;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\script;
#using scripts\mp\utility\weapon;

#namespace inventory;

// Namespace inventory / scripts\mp\utility\inventory
// Params 0
// Checksum 0x0, Offset: 0xd4
// Size: 0x1e
function getlastweapon()
{
    assert( isdefined( self.lastnormalweaponobj ) );
    return self.lastnormalweaponobj;
}

// Namespace inventory / scripts\mp\utility\inventory
// Params 0
// Checksum 0x0, Offset: 0xfb
// Size: 0x5f
function switchtolastweapon()
{
    if ( !isai( self ) )
    {
        lastweaponobj = getlastweapon();
        
        if ( scripts\mp\utility\killstreak::isjuggernaut() )
        {
            lastweaponobj = scripts\mp\juggernaut::jugg_getminigunweapon();
        }
        else if ( !self hasweapon( lastweaponobj ) )
        {
            lastweaponobj = getfirstprimaryweapon();
        }
        
        if ( isdefined( lastweaponobj ) )
        {
            _switchtoweapon( lastweaponobj );
        }
        
        return;
    }
    
    _switchtoweapon( "none" );
}

// Namespace inventory / scripts\mp\utility\inventory
// Params 0
// Checksum 0x0, Offset: 0x162
// Size: 0x62
function getfirstprimaryweapon()
{
    weaponslist = self getweaponslistprimaries();
    
    if ( isdefined( self.pers[ "altStates" ] ) && weaponslist.size > 0 )
    {
        fullweaponstring = getcompleteweaponname( weaponslist[ 0 ] );
        
        if ( istrue( self.pers[ "altStates" ][ fullweaponstring ] ) )
        {
            return weaponslist[ 0 ] getaltweapon();
        }
    }
    
    return weaponslist[ 0 ];
}

// Namespace inventory / scripts\mp\utility\inventory
// Params 3
// Checksum 0x0, Offset: 0x1cd
// Size: 0x1ce
function registerweaponchangecallback( callbackfunc, isoneshot, var_83d988341d1d6755 )
{
    data = self.weaponchangecallbacks;
    
    if ( !isdefined( data ) )
    {
        data = spawnstruct();
        self.weaponchangecallbacks = data;
        data.nextid = 1;
        data.nextoneshotid = -1;
        data.callbacks = [];
        data.oneshotcallbacks = [];
        data.persistentcallbacks = [];
    }
    
    id = undefined;
    
    if ( istrue( isoneshot ) )
    {
        /#
            foreach ( oneshotcallback in data.oneshotcallbacks )
            {
                assertex( oneshotcallback != callbackfunc, "<dev string:x1c>" );
            }
        #/
        
        id = data.nextoneshotid;
        data.nextoneshotid--;
        data.oneshotcallbacks[ id ] = callbackfunc;
    }
    else
    {
        /#
            foreach ( othercallback in data.callbacks )
            {
                assertex( othercallback != callbackfunc, "<dev string:x6a>" );
            }
        #/
        
        id = data.nextid;
        data.nextid++;
        data.callbacks[ id ] = callbackfunc;
    }
    
    if ( istrue( var_83d988341d1d6755 ) )
    {
        data.persistentcallbacks[ id ] = id;
    }
    
    return id;
}

// Namespace inventory / scripts\mp\utility\inventory
// Params 1
// Checksum 0x0, Offset: 0x3a4
// Size: 0x4e
function unregisterweaponchangecallback( id )
{
    data = self.weaponchangecallbacks;
    assert( isdefined( data ) );
    
    if ( id < 0 )
    {
        data.oneshotcallbacks[ id ] = undefined;
        return;
    }
    
    data.callbacks[ id ] = undefined;
}

// Namespace inventory / scripts\mp\utility\inventory
// Params 0
// Checksum 0x0, Offset: 0x3fa
// Size: 0xe1
function handleweaponchangecallbacksondeath()
{
    data = self.weaponchangecallbacks;
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    foreach ( id, callback in data.callbacks )
    {
        if ( !isdefined( data.persistentcallbacks[ id ] ) )
        {
            data.callbacks[ id ] = undefined;
        }
    }
    
    foreach ( id, callback in data.oneshotcallbacks )
    {
        if ( !isdefined( data.persistentcallbacks[ id ] ) )
        {
            data.oneshotcallbacks[ id ] = undefined;
        }
    }
}

