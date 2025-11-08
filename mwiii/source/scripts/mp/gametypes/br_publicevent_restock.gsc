#using script_744cad313ed0a87e;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;

#namespace br_publicevent_restock;

// Namespace br_publicevent_restock / scripts\mp\gametypes\br_publicevent_restock
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x20a
// Size: 0x17
function autoexec main()
{
    scripts\mp\gametypes\br_publicevents::function_dbc8f6cb3760cd82( %"restock", &init );
}

// Namespace br_publicevent_restock / scripts\mp\gametypes\br_publicevent_restock
// Params 1
// Checksum 0x0, Offset: 0x229
// Size: 0x60
function init( eventinfo )
{
    eventinfo.validatefunc = &validatefunc;
    eventinfo.waitfunc = &waitfunc;
    eventinfo.activatefunc = &activatefunc;
    eventinfo.deactivatefunc = &deactivatefunc;
    eventinfo.postinitfunc = &postinitfunc;
}

// Namespace br_publicevent_restock / scripts\mp\gametypes\br_publicevent_restock
// Params 0
// Checksum 0x0, Offset: 0x291
// Size: 0x33
function postinitfunc()
{
    game[ "dialog" ][ "power_up_field_resupply" ] = "pblc_grav_rsnd";
    level.var_bd006676148e6c40 = [];
    level.var_a688dd9515c7def = [];
    level.var_344f2168e7b1bc8e = [];
}

// Namespace br_publicevent_restock / scripts\mp\gametypes\br_publicevent_restock
// Params 0
// Checksum 0x0, Offset: 0x2cc
// Size: 0x4, Type: bool
function validatefunc()
{
    return true;
}

// Namespace br_publicevent_restock / scripts\mp\gametypes\br_publicevent_restock
// Params 0
// Checksum 0x0, Offset: 0x2d9
// Size: 0x10
function waitfunc()
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );
}

// Namespace br_publicevent_restock / scripts\mp\gametypes\br_publicevent_restock
// Params 0
// Checksum 0x0, Offset: 0x2f1
// Size: 0xb8
function activatefunc()
{
    level endon( "game_ended" );
    scripts\mp\gametypes\br_publicevents::showsplashtoall( "br_pe_restock_active" );
    scripts\mp\gametypes\br_public::brleaderdialog( "power_up_field_resupply", 1, undefined, undefined, 1 );
    
    if ( isdefined( level.var_ea7c6955bb1589bd ) )
    {
        [[ level.var_ea7c6955bb1589bd ]]();
    }
    
    foreach ( instance in level.var_bd006676148e6c40 )
    {
        if ( !isdefined( instance ) )
        {
            continue;
        }
        
        instance setscriptablepartstate( "body", "closing" );
        instance function_f929dbb719836091();
        instance br_lootcache::removecrate();
    }
}

// Namespace br_publicevent_restock / scripts\mp\gametypes\br_publicevent_restock
// Params 0
// Checksum 0x0, Offset: 0x3b1
// Size: 0x2
function deactivatefunc()
{
    
}

// Namespace br_publicevent_restock / scripts\mp\gametypes\br_publicevent_restock
// Params 0
// Checksum 0x0, Offset: 0x3bb
// Size: 0xca
function function_f929dbb719836091()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    switch ( self.type )
    {
        case #"hash_417c605750c7baa5":
            function_8cd3ae6cb0d422dc();
            break;
        case #"hash_19ba8d41970911ad":
        case #"hash_d1616a5975b7a941":
            function_c7076b566f348b22();
            break;
        case #"hash_4ca1dc2e1b0de0d3":
            br_lootcache::function_27f0aed354031248();
            break;
        case #"hash_4654cfd269b6fc02":
        case #"hash_9c5f01407ae504fc":
        case #"hash_bc13d03dc3f6d6e8":
            break;
        default:
            function_ec86e04eb404ce02();
            break;
    }
    
    if ( isdefined( self.fortress ) )
    {
        namespace_bd614c3c2275579a::function_df20d77fc7d6103c( self.fortress, self );
    }
}

// Namespace br_publicevent_restock / scripts\mp\gametypes\br_publicevent_restock
// Params 0
// Checksum 0x0, Offset: 0x48d
// Size: 0x59
function function_8cd3ae6cb0d422dc()
{
    if ( !isdefined( level.var_a688dd9515c7def ) || level.var_a688dd9515c7def.size <= 0 )
    {
        return;
    }
    
    index = level.var_a688dd9515c7def.size - 1;
    self.contents = level.var_a688dd9515c7def[ index ];
    level.var_a688dd9515c7def[ index ] = undefined;
}

// Namespace br_publicevent_restock / scripts\mp\gametypes\br_publicevent_restock
// Params 0
// Checksum 0x0, Offset: 0x4ee
// Size: 0x59
function function_c7076b566f348b22()
{
    if ( !isdefined( level.var_344f2168e7b1bc8e ) || level.var_344f2168e7b1bc8e.size <= 0 )
    {
        return;
    }
    
    index = level.var_344f2168e7b1bc8e.size - 1;
    self.contents = level.var_344f2168e7b1bc8e[ index ];
    level.var_344f2168e7b1bc8e[ index ] = undefined;
}

// Namespace br_publicevent_restock / scripts\mp\gametypes\br_publicevent_restock
// Params 0
// Checksum 0x0, Offset: 0x54f
// Size: 0x22
function function_ec86e04eb404ce02()
{
    if ( !isdefined( self.originalcontents ) )
    {
        return;
    }
    
    self.contents = self.originalcontents;
}

// Namespace br_publicevent_restock / scripts\mp\gametypes\br_publicevent_restock
// Params 0
// Checksum 0x0, Offset: 0x579
// Size: 0x2d, Type: bool
function function_a5cbf2004ced4597()
{
    return istrue( level.var_b06bb395c37b7ab8 ) && getdvarfloat( @"hash_a5f3589998da80ae", 0 ) || istrue( level.var_337628ae96a92ff2 );
}

