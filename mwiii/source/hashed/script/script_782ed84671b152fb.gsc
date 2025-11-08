#using script_254c2e2a2c8207f8;
#using script_44102c05f33e9b1e;
#using script_45e6947be98e16e3;
#using scripts\common\callbacks;
#using scripts\engine\utility;

#namespace namespace_b2de5662c522b9fa;

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0x1f0
// Size: 0x18a
function function_9fcc9920ba3dbe3()
{
    level.contextualtips = [];
    level.var_13036c7f57466667 = [];
    level.var_8205621341adedc4 = [];
    level.var_6edc807b8a61c73[ #"hash_b1604f3a47cda2b0" ] = &function_41cb8acb20b22194;
    function_3d5ff2f3949e29f3();
    function_47fd484462dfbcca();
    function_adb4ea72b138d5c8();
    function_5ea299130f7d9da7();
    function_5ef684945f2f60b9();
    function_c34534c2cc819005();
    function_391bda52095da908();
    function_d64048744bf807ce();
    function_902e0d9df7b54cff();
    function_280cf13c1d85d37a();
    function_f3cb638f47d342b7();
    function_b1f3edfa39895b7e();
    function_b488c8f3e7ae9e50();
    function_e98c9321202251f();
    function_228ee1dc8a21f4ac();
    function_2c218d5c8e40c4c();
    initializesprint();
    initializemovement();
    initializeswimming();
    function_9fe1db3bd8f90712();
    function_a96740e4856c038();
    initializecontrols();
    function_9399e094c1c4b1e9();
    function_e15ac3a5829a9bcf();
    function_68c858c6e63409f3( #"jumpmaster" );
    function_68c858c6e63409f3( #"biometricscan" );
    function_68c858c6e63409f3( #"mutationshadowskin" );
    function_68c858c6e63409f3( #"mutationbubbleshield" );
    function_68c858c6e63409f3( #"mutationdensitydive" );
    function_68c858c6e63409f3( #"mutationfrogleap" );
    function_68c858c6e63409f3( #"mutationmutantvision" );
    function_68c858c6e63409f3( #"mutationsludgesling" );
    function_68c858c6e63409f3( #"mutationtoxiccloud" );
    function_68c858c6e63409f3( #"mutationjuggernaut" );
    return level.contextualtips;
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 1
// Checksum 0x0, Offset: 0x383
// Size: 0x62
function function_33352cc5d4b4401( data )
{
    tipindex = level.contextualtips.size;
    keyhash = getxhash( data.key );
    level.contextualtips[ keyhash ] = data;
    level.var_13036c7f57466667[ tipindex ] = keyhash;
    level.var_8205621341adedc4[ keyhash ] = tipindex;
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0x3ed
// Size: 0x3, Type: bool
function function_41cb8acb20b22194()
{
    return false;
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0x3f9
// Size: 0x8e
function function_3d5ff2f3949e29f3()
{
    data = spawnstruct();
    data.key = "Prematch";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 40;
    data.inprematch = 1;
    data.condfunc = &namespace_d3289d7a0f087014::function_84e789c4db729df;
    data.execfunc = &namespace_d3289d7a0f087014::function_6cc0fad885fba316;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0x48f
// Size: 0xfb
function function_47fd484462dfbcca()
{
    data = spawnstruct();
    data.key = "ParachuteControls";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 40;
    data.condfunc = &namespace_d3289d7a0f087014::function_b81ffcc9f35975ea;
    data.execfunc = &namespace_d3289d7a0f087014::function_4f790be93cb37a59;
    data.endconditions = [];
    data.endconditions[ 0 ] = spawnstruct();
    data.endconditions[ 0 ].func = #"hash_2985d7fb1675a4c9";
    data.endconditions[ 0 ].action = #"hash_e175bca8011c1c15";
    level.var_6edc807b8a61c73[ #"hash_e175bca8011c1c15" ] = &namespace_d3289d7a0f087014::function_390588110ddad141;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0x592
// Size: 0x91
function function_adb4ea72b138d5c8()
{
    data = spawnstruct();
    data.key = "SupplyCache";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.condfunc = &namespace_d3289d7a0f087014::function_985d1992fa345d50;
    data.execfunc = &namespace_d3289d7a0f087014::function_d42c23c4731aed7;
    function_33352cc5d4b4401( data );
    scripts\common\callbacks::add( "cache_opened", &namespace_d3289d7a0f087014::function_6fb2d2cba92b8aaf );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0x62b
// Size: 0x78
function function_5ea299130f7d9da7()
{
    data = spawnstruct();
    data.key = "Inventory";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 20;
    data.execfunc = &namespace_d3289d7a0f087014::function_78836cda2eb475b4;
    function_33352cc5d4b4401( data );
    level thread namespace_d3289d7a0f087014::function_4d97fbd4a3f4901f();
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0x6ab
// Size: 0x80
function function_5ef684945f2f60b9()
{
    data = spawnstruct();
    data.key = "Map";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 20;
    data.condfunc = &namespace_d3289d7a0f087014::function_ed70f678fba22fc9;
    data.execfunc = &namespace_d3289d7a0f087014::function_57d935cb919f862a;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0x733
// Size: 0x80
function function_c34534c2cc819005()
{
    data = spawnstruct();
    data.key = "BuyStation";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.condfunc = &namespace_d3289d7a0f087014::function_eee8c0a14817d1fd;
    data.execfunc = &namespace_d3289d7a0f087014::function_c34995ac4640424c;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0x7bb
// Size: 0x80
function function_391bda52095da908()
{
    data = spawnstruct();
    data.key = "Armor";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.condfunc = &namespace_d3289d7a0f087014::function_17cebffd7c7c117c;
    data.execfunc = &namespace_d3289d7a0f087014::function_44487063b4b3727f;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0x843
// Size: 0x80
function function_d64048744bf807ce()
{
    data = spawnstruct();
    data.key = "LoadoutDrop";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 40;
    data.condfunc = &namespace_d3289d7a0f087014::function_d1d6119f9061fd66;
    data.execfunc = &namespace_d3289d7a0f087014::function_f7642b5100fab139;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0x8cb
// Size: 0x80
function function_902e0d9df7b54cff()
{
    data = spawnstruct();
    data.key = "Contract";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 40;
    data.condfunc = &namespace_d3289d7a0f087014::function_a524f2861ab5b873;
    data.execfunc = &namespace_d3289d7a0f087014::function_81dc1fbdd05cbfbe;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0x953
// Size: 0x80
function function_280cf13c1d85d37a()
{
    data = spawnstruct();
    data.key = "GasClose";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.condfunc = &namespace_d3289d7a0f087014::function_1c786072fea7ca5a;
    data.execfunc = &namespace_d3289d7a0f087014::function_bb7f060ccd476483;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0x9db
// Size: 0x6f
function function_f3cb638f47d342b7()
{
    data = spawnstruct();
    data.key = "GasAvoid";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 40;
    data.execfunc = &namespace_d3289d7a0f087014::function_555708e0d1167ada;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0xa52
// Size: 0x6f
function function_b1f3edfa39895b7e()
{
    data = spawnstruct();
    data.key = "GasMask";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.execfunc = &namespace_d3289d7a0f087014::function_2c4c7b5ddc885005;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0xac9
// Size: 0x8e
function function_b488c8f3e7ae9e50()
{
    data = spawnstruct();
    data.key = "BuyBack";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.condfunc = &namespace_d3289d7a0f087014::function_c640f7c92a1dcfb4;
    data.execfunc = &namespace_d3289d7a0f087014::function_af1b1e3822028b73;
    data.var_bce08f4be4261bc4 = 1;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0xb5f
// Size: 0x8e
function function_e98c9321202251f()
{
    data = spawnstruct();
    data.key = "Gulag";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 40;
    data.ingulag = 1;
    data.condfunc = &namespace_d3289d7a0f087014::function_30f3ffbf8846e773;
    data.execfunc = &namespace_d3289d7a0f087014::function_ab02c605e39f879c;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0xbf5
// Size: 0x8e
function function_228ee1dc8a21f4ac()
{
    data = spawnstruct();
    data.key = "EnemyDowned";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 40;
    data.condfunc = &namespace_d3289d7a0f087014::function_96012a932e9bf76a;
    data.execfunc = &namespace_d3289d7a0f087014::function_cf0f897f8dfbf0ad;
    data.var_c6228a01683251ae = 1;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0xc8b
// Size: 0x80
function function_2c218d5c8e40c4c()
{
    data = spawnstruct();
    data.key = "ReviveAlly";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 40;
    data.condfunc = &namespace_d3289d7a0f087014::function_8e58b2b46876536a;
    data.execfunc = &namespace_d3289d7a0f087014::function_5ccc381930eff1cb;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0xd13
// Size: 0x80
function initializesprint()
{
    data = spawnstruct();
    data.key = "Sprint";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 40;
    data.condfunc = &namespace_d3289d7a0f087014::function_600c2050e11fc551;
    data.execfunc = &namespace_d3289d7a0f087014::function_f8e3bba28792512c;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0xd9b
// Size: 0x80
function initializemovement()
{
    data = spawnstruct();
    data.key = "Movement";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.condfunc = &namespace_d3289d7a0f087014::function_667299d35d882a50;
    data.execfunc = &namespace_d3289d7a0f087014::function_1b9b4f723d9feac9;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0xe23
// Size: 0x80
function initializeswimming()
{
    data = spawnstruct();
    data.key = "Swimming";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 40;
    data.condfunc = &namespace_d3289d7a0f087014::function_517845029dff50a8;
    data.execfunc = &namespace_d3289d7a0f087014::function_dc7c24595cd45511;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0xeab
// Size: 0x6f
function function_9fe1db3bd8f90712()
{
    data = spawnstruct();
    data.key = "PerkPack";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.execfunc = &namespace_d3289d7a0f087014::function_80805c1c42953611;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0xf22
// Size: 0x6f
function function_a96740e4856c038()
{
    data = spawnstruct();
    data.key = "ArmorVest";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.execfunc = &namespace_d3289d7a0f087014::function_314529a28163a3b9;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0xf99
// Size: 0x80
function initializecontrols()
{
    data = spawnstruct();
    data.key = "Controls";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 60;
    data.condfunc = &namespace_d3289d7a0f087014::function_732b91978acfb157;
    data.execfunc = &namespace_d3289d7a0f087014::function_57e7ab31b49a7316;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0x1021
// Size: 0x80
function function_9399e094c1c4b1e9()
{
    data = spawnstruct();
    data.key = "TrainControls";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.condfunc = &namespace_d3289d7a0f087014::function_23cb9539b0097a63;
    data.execfunc = &namespace_d3289d7a0f087014::function_5f9daa57cf99f444;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0x10a9
// Size: 0x6f
function function_e15ac3a5829a9bcf()
{
    data = spawnstruct();
    data.key = "DrivingGas";
    data.var_2297e189e2eb2818 = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.execfunc = &namespace_d3289d7a0f087014::function_977607749534a65c;
    function_33352cc5d4b4401( data );
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 1
// Checksum 0x0, Offset: 0x1120
// Size: 0x44
function function_68c858c6e63409f3( var_4ac7b6bdde12a915 )
{
    if ( scripts\engine\utility::issharedfuncdefined( var_4ac7b6bdde12a915, #"hash_2e70af38af7a98db" ) )
    {
        data = [[ scripts\engine\utility::getsharedfunc( var_4ac7b6bdde12a915, #"hash_2e70af38af7a98db" ) ]]();
        function_33352cc5d4b4401( data );
    }
}

// Namespace namespace_b2de5662c522b9fa / namespace_a1922e5b976f9ad7
// Params 0
// Checksum 0x0, Offset: 0x116c
// Size: 0xa
function function_8d9c94a186b2f39a()
{
    thread namespace_d3289d7a0f087014::function_9a20a7c14d389880();
}

