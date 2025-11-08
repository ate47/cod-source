#namespace frontend;

// Namespace frontend / scripts\mp\gametypes\frontend
// Params 0
// Checksum 0x0, Offset: 0x88
// Size: 0xc6
function main()
{
    level.callbackstartgametype = &callback_frontendstartgametype;
    level.callbackplayerconnect = &callback_frontendplayeractive;
    level.callbackplayerconnect = &callback_frontendplayerconnect;
    level.callbackplayerdisconnect = &callback_frontendplayerdisconnect;
    level.callbackplayerdamage = &callback_frontendplayerdamage;
    level.callbackplayerimpaled = &callback_frontendplayerimpaled;
    level.var_189d24c2bbeed3f5 = &callback_frontendplayerlaunched;
    level.callbackplayerkilled = &callback_frontendplayerkilled;
    level.callbackplayerlaststand = &callback_frontendplayerlaststand;
    level.callbackplayermigrated = &callback_frontendplayermigrated;
    level.callbackhostmigration = &callback_frontendhostmigration;
    level.var_42d9b617bbca6a42 = &function_bfb9c6b70fc8f235;
    level.var_935c97aa3757676f = &function_8901ca5831ce6438;
    level.var_cda3af1f73639c7c = &function_2a643088582c8be3;
}

// Namespace frontend / scripts\mp\gametypes\frontend
// Params 0
// Checksum 0x0, Offset: 0x156
// Size: 0x2
function callback_frontendstartgametype()
{
    
}

// Namespace frontend / scripts\mp\gametypes\frontend
// Params 0
// Checksum 0x0, Offset: 0x160
// Size: 0x2
function callback_frontendplayeractive()
{
    
}

// Namespace frontend / scripts\mp\gametypes\frontend
// Params 0
// Checksum 0x0, Offset: 0x16a
// Size: 0x2
function callback_frontendplayerconnect()
{
    
}

// Namespace frontend / scripts\mp\gametypes\frontend
// Params 1
// Checksum 0x0, Offset: 0x174
// Size: 0xb
function callback_frontendplayerdisconnect( reason )
{
    
}

// Namespace frontend / scripts\mp\gametypes\frontend
// Params 15
// Checksum 0x0, Offset: 0x187
// Size: 0x7b
function callback_frontendplayerdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, var_b0fc59ff15058522, var_be4285b26ed99ab1 )
{
    
}

// Namespace frontend / scripts\mp\gametypes\frontend
// Params 10
// Checksum 0x0, Offset: 0x20a
// Size: 0x53
function callback_frontendplayerimpaled( eattacker, objweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_19f6f25777706f34, var_d3564b2364cb59e6, var_a4d8eb0a63f60f6b )
{
    
}

// Namespace frontend / scripts\mp\gametypes\frontend
// Params 5
// Checksum 0x0, Offset: 0x265
// Size: 0x2b
function callback_frontendplayerlaunched( eattacker, objweapon, vdir, magnitude, shitloc )
{
    
}

// Namespace frontend / scripts\mp\gametypes\frontend
// Params 10
// Checksum 0x0, Offset: 0x298
// Size: 0x53
function callback_frontendplayerkilled( einflictor, attacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    
}

// Namespace frontend / scripts\mp\gametypes\frontend
// Params 10
// Checksum 0x0, Offset: 0x2f3
// Size: 0x53
function callback_frontendplayerlaststand( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, var_318ade4970c8f647 )
{
    
}

// Namespace frontend / scripts\mp\gametypes\frontend
// Params 0
// Checksum 0x0, Offset: 0x34e
// Size: 0x10
function callback_frontendplayermigrated()
{
    assertmsg( "<dev string:x1c>" );
}

// Namespace frontend / scripts\mp\gametypes\frontend
// Params 0
// Checksum 0x0, Offset: 0x366
// Size: 0x10
function callback_frontendhostmigration()
{
    assertmsg( "<dev string:x1c>" );
}

// Namespace frontend / scripts\mp\gametypes\frontend
// Params 0
// Checksum 0x0, Offset: 0x37e
// Size: 0x2
function function_bfb9c6b70fc8f235()
{
    
}

// Namespace frontend / scripts\mp\gametypes\frontend
// Params 1
// Checksum 0x0, Offset: 0x388
// Size: 0xb
function function_8901ca5831ce6438( reason )
{
    
}

// Namespace frontend / scripts\mp\gametypes\frontend
// Params 2
// Checksum 0x0, Offset: 0x39b
// Size: 0x13
function function_2a643088582c8be3( achievementid, progressdata )
{
    
}

