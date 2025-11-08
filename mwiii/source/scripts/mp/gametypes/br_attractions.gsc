#using scripts\cp_mp\parachute;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_attraction_gulag;
#using scripts\mp\gametypes\br_attraction_kingofthehill;
#using scripts\mp\gametypes\br_attraction_racetrack;
#using scripts\mp\gametypes\br_attractions;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\trigger;

#namespace br_attractions;

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 0
// Checksum 0x0, Offset: 0x1fa
// Size: 0x54
function init()
{
    if ( !scripts\mp\gametypes\br_gametypes::isfeatureenabled( "attractions" ) )
    {
        return;
    }
    
    level.brattractions = [];
    level.brgametype.useserverhud = getdvarint( @"hash_4452bc3660dc67fa", 1 );
    scripts\mp\gametypes\br_attraction_racetrack::init();
    scripts\mp\gametypes\br_attraction_kingofthehill::init();
    scripts\mp\gametypes\br_attraction_gulag::init();
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 0
// Checksum 0x0, Offset: 0x256
// Size: 0x20, Type: bool
function iskingofthehillactive()
{
    return isdefined( level.brattractions ) && isdefined( level.brattractions[ "koth" ] );
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 1
// Checksum 0x0, Offset: 0x27f
// Size: 0x1c
function onplayerdisconnect( player )
{
    if ( iskingofthehillactive() )
    {
        scripts\mp\gametypes\br_attraction_kingofthehill::onplayerdisconnect( player );
    }
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 9
// Checksum 0x0, Offset: 0x2a3
// Size: 0x15e
function createattractionicontrigger( typeref, locindex, groundorigin, iconzoffset, iconshader, var_ba52080c594353fc, triggerenterfunc, triggerexitfunc, scriptabledefname )
{
    scriptable = spawnscriptable( scriptabledefname, groundorigin );
    closeobjectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
    
    if ( closeobjectiveiconid != -1 )
    {
        objorigin = groundorigin + ( 0, 0, iconzoffset );
        scripts\mp\objidpoolmanager::objective_add_objective( closeobjectiveiconid, "invisible", objorigin, iconshader );
        scripts\mp\objidpoolmanager::update_objective_setbackground( closeobjectiveiconid, 1 );
        objective_removeallfrommask( closeobjectiveiconid );
        objective_showtoplayersinmask( closeobjectiveiconid );
        objective_setplayintro( closeobjectiveiconid, 0 );
        objective_sethideelevation( closeobjectiveiconid, 1 );
    }
    
    trigheight = scripts\cp_mp\parachute::getc130height() - groundorigin[ 2 ];
    icontrigger = spawn( "trigger_radius", groundorigin, 0, var_ba52080c594353fc, trigheight );
    icontrigger.closeobjectiveiconid = closeobjectiveiconid;
    icontrigger.scriptable = scriptable;
    icontrigger.triggerenterfunc = triggerenterfunc;
    icontrigger.triggerexitfunc = triggerexitfunc;
    icontrigger.typeref = typeref;
    icontrigger.locindex = locindex;
    scripts\mp\utility\trigger::makeenterexittrigger( icontrigger, &playericontriggerenter, &playericontriggerexit, undefined, undefined, &playericonfilter );
    return icontrigger;
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 1
// Checksum 0x0, Offset: 0x40a
// Size: 0x6b
function shutdownattractionicontrigger( trigger )
{
    if ( istrue( trigger.shuttingdown ) )
    {
        trigger waittill( "death" );
        return;
    }
    
    trigger.shuttingdown = 1;
    waittillframeend();
    scripts\mp\objidpoolmanager::returnobjectiveid( trigger.closeobjectiveiconid );
    
    if ( isdefined( trigger.scriptable ) )
    {
        trigger.scriptable freescriptable();
    }
    
    trigger delete();
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 1
// Checksum 0x0, Offset: 0x47d
// Size: 0x2c
function triggeraddobjectivetext( localizedstring )
{
    if ( istrue( level.brgametype.useserverhud ) )
    {
        self.objectivetext = localizedstring;
    }
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 0
// Checksum 0x0, Offset: 0x4b1
// Size: 0xc
function triggerremoveobjectivetext()
{
    self.objectivetext = undefined;
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 0
// Checksum 0x0, Offset: 0x4c5
// Size: 0xd
function triggersafearea()
{
    self.sandbox_safe_area = 1;
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 2
// Checksum 0x0, Offset: 0x4da
// Size: 0x98
function playericontriggerenter( player, trigger )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player playersetattractiontype( trigger.typeref );
    player playersetattractionlocationindex( trigger.locindex );
    objective_addclienttomask( trigger.closeobjectiveiconid, player );
    
    if ( isdefined( trigger.objectivetext ) )
    {
        player playerhudattractionobj( trigger.objectivetext );
    }
    
    if ( isdefined( trigger.triggerenterfunc ) )
    {
        player thread [[ trigger.triggerenterfunc ]]( player, trigger );
    }
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 2
// Checksum 0x0, Offset: 0x57a
// Size: 0x7f
function playericontriggerexit( player, trigger )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !istrue( player.ignoreattractions ) )
    {
        player playersetattractionoff();
    }
    
    objective_removeclientfrommask( trigger.closeobjectiveiconid, player );
    
    if ( isdefined( player.hudattractionobj ) )
    {
        player thread playerfadeobjdelete();
    }
    
    if ( isdefined( trigger.triggerexitfunc ) )
    {
        player thread [[ trigger.triggerexitfunc ]]( player, trigger );
    }
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 1
// Checksum 0x0, Offset: 0x601
// Size: 0x5a
function playerhudattractionobj( objectivetext )
{
    if ( !isdefined( self.hudattractionobj ) )
    {
        self.hudattractionobj = scripts\mp\gametypes\br_attractions::createhudstring( 0, objectivetext );
        return;
    }
    
    self notify( "keepHudAttractionObj" );
    self.hudattractionobj.alpha = 1;
    self.hudattractionobj settext( objectivetext );
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 0
// Checksum 0x0, Offset: 0x663
// Size: 0x5f
function playerfadeobjdelete()
{
    self endon( "keepHudAttractionObj" );
    var_b2d4b76e9bbd89ed = 1.5;
    obj = self.hudattractionobj;
    obj fadeovertime( var_b2d4b76e9bbd89ed );
    obj.alpha = 0;
    wait var_b2d4b76e9bbd89ed;
    
    if ( isdefined( obj ) )
    {
        obj destroy();
    }
    
    if ( isdefined( self ) )
    {
        self.hudattractionobj = undefined;
    }
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 2
// Checksum 0x0, Offset: 0x6ca
// Size: 0x3c
function playersetignoreattractions( player, ignore )
{
    if ( istrue( player.ignoreattractions ) && !ignore )
    {
        player playersetattractionoff();
    }
    
    player.ignoreattractions = ignore;
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 2
// Checksum 0x0, Offset: 0x70e
// Size: 0x2f, Type: bool
function playericonfilter( player, trigger )
{
    return istrue( trigger.shuttingdown ) || istrue( player.ignoreattractions );
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 2
// Checksum 0x0, Offset: 0x746
// Size: 0x46
function createhudstring( index, text )
{
    hudelem = scripts\mp\hud_util::createfontstring( "objective", 1.5 );
    hudelem hudelementsetupandposition( index );
    
    if ( isdefined( text ) )
    {
        hudelem settext( text );
    }
    
    return hudelem;
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 1
// Checksum 0x0, Offset: 0x795
// Size: 0x31
function createhudtimer( index )
{
    hudelem = scripts\mp\hud_util::createtimer( "objective", 1.5 );
    hudelem hudelementsetupandposition( index );
    return hudelem;
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 1
// Checksum 0x0, Offset: 0x7cf
// Size: 0xab
function hudelementsetupandposition( index )
{
    var_fc60cba78ac17a0c = 15;
    var_9348226a53701bdb = 160;
    var_6012bdca89ff91e9 = 20;
    self.x = var_fc60cba78ac17a0c;
    self.y = var_9348226a53701bdb + index * var_6012bdca89ff91e9;
    self.alignx = "left";
    self.aligny = "top";
    self.horzalign = "left_adjustable";
    self.vertalign = "top_adjustable";
    self.alpha = 1;
    self.glowalpha = 0;
    self.hidewheninmenu = 1;
    self.archived = 0;
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 0
// Checksum 0x0, Offset: 0x882
// Size: 0xb
function playersetattractionoff()
{
    playersetomnvarattraction( 0, 0 );
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 1
// Checksum 0x0, Offset: 0x895
// Size: 0x51
function playersetattractiontype( typeref )
{
    typeindex = tablelookup( "mp/brattractions.csv", 1, typeref, 0 );
    assertex( isdefined( typeindex ) && typeindex != "<dev string:x1c>", "<dev string:x20>" );
    typeindex = int( typeindex );
    playersetomnvarattraction( 0, typeindex );
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 1
// Checksum 0x0, Offset: 0x8ee
// Size: 0x15
function playersetattractionlocationindex( locationindex )
{
    playersetomnvarattraction( 1, locationindex );
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 1
// Checksum 0x0, Offset: 0x90b
// Size: 0x15
function playersetattractionstateindex( stateindex )
{
    playersetomnvarattraction( 2, stateindex );
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 1
// Checksum 0x0, Offset: 0x928
// Size: 0x15
function playersetattractionextradata( extradata )
{
    playersetomnvarattraction( 3, extradata );
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 1
// Checksum 0x0, Offset: 0x945
// Size: 0x30
function playersetattractionbestplayer( player )
{
    entnum = -1;
    
    if ( isdefined( player ) )
    {
        entnum = player getentitynumber();
    }
    
    playersetomnvarattraction( 4, entnum );
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 1
// Checksum 0x0, Offset: 0x97d
// Size: 0x35
function playersetattractionbesttime( timems )
{
    prev = self getclientomnvar( "ui_br_attraction_best_time" );
    
    if ( timems != prev )
    {
        self setclientomnvar( "ui_br_attraction_best_time", timems );
    }
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 1
// Checksum 0x0, Offset: 0x9ba
// Size: 0x35
function playersetattractiontime( timems )
{
    prev = self getclientomnvar( "ui_br_attraction_time" );
    
    if ( timems != prev )
    {
        self setclientomnvar( "ui_br_attraction_time", timems );
    }
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 2
// Checksum 0x0, Offset: 0x9f7
// Size: 0x7c
function playersetomnvarattraction( dataref, value )
{
    assert( isplayer( self ) );
    [ bitoffset, bitwidth, omnvarref, value ] = getattractionomnvarbitpackinginfo( dataref, value );
    
    if ( omnvarref == "" )
    {
        return;
    }
    
    playerpackdataintoomnvar( omnvarref, value, bitoffset, bitwidth );
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 2
// Checksum 0x0, Offset: 0xa7b
// Size: 0x184
function getattractionomnvarbitpackinginfo( dataref, value )
{
    bitoffset = 0;
    bitwidth = 0;
    omnvarref = "";
    
    switch ( dataref )
    {
        case 0:
            bitoffset = 0;
            bitwidth = 8;
            omnvarref = "ui_br_attraction_data";
            break;
        case 1:
            [ bitoffset, bitwidth ] = [ 8, 8 ];
            omnvarref = "ui_br_attraction_data";
            break;
        case 2:
            [ bitoffset, bitwidth ] = [ 16, 8 ];
            omnvarref = "ui_br_attraction_data";
            break;
        case 3:
            [ bitoffset, bitwidth ] = [ 24, 2 ];
            omnvarref = "ui_br_attraction_data";
            break;
        case 4:
            [ bitoffset, bitwidth ] = [ 0, 8 ];
            omnvarref = "ui_br_attraction_best_data";
            value++;
            break;
        default:
            assertmsg( "<dev string:x41>" + dataref + "<dev string:x5a>" );
            break;
    }
    
    return [ bitoffset, bitwidth, omnvarref, value ];
}

// Namespace br_attractions / scripts\mp\gametypes\br_attractions
// Params 4
// Checksum 0x0, Offset: 0xc08
// Size: 0x9c
function playerpackdataintoomnvar( omnvarref, value, bitoffset, bitwidth )
{
    mask = int( pow( 2, bitwidth ) ) - 1;
    var_a463992091f1d483 = ( value & mask ) << bitoffset;
    invertedmask = ~( mask << bitoffset );
    prevvalue = self getclientomnvar( omnvarref );
    cleanedbase = prevvalue & invertedmask;
    repackedvalue = cleanedbase + var_a463992091f1d483;
    
    if ( repackedvalue != prevvalue )
    {
        self setclientomnvar( omnvarref, repackedvalue );
    }
}

