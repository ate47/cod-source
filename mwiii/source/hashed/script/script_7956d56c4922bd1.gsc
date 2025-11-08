#using script_185660037b9236c1;
#using script_24f248b33b79e48d;
#using script_41387eecc35b88bf;
#using script_570f992e202c79b4;
#using script_5d8202968463a21d;
#using script_7956d56c4922bd1;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_3485b020a23acaae;

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x2e1
// Size: 0xe6
function function_98e66628b697874f( var_4a70855a7b924cd9 )
{
    activityvariantstructs = getstructarray( "activity_nexus_variant", "script_noteworthy" );
    
    foreach ( activityvariant in activityvariantstructs )
    {
        if ( isdefined( activityvariant.name ) && activityvariant.name != "" )
        {
            if ( isdefined( activityvariant.activity_bundle ) && activityvariant.activity_bundle != "" )
            {
                varianttag = activityvariant.name;
                var_eabcdb2306ff31c7 = isdefined( array_find( var_4a70855a7b924cd9, varianttag ) );
                
                if ( var_eabcdb2306ff31c7 )
                {
                    function_2aaac3f9c059969a( activityvariant );
                }
            }
        }
    }
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x3cf
// Size: 0xf7
function function_e33b0f9c9a020fc7( var_6654d5ec2459577f )
{
    var_6654d5ec2459577f = default_to( var_6654d5ec2459577f, [] );
    activityvariantstructs = getstructarray( "activity_nexus_variant", "script_noteworthy" );
    
    foreach ( activityvariant in activityvariantstructs )
    {
        if ( isdefined( activityvariant.name ) && activityvariant.name != "" )
        {
            if ( isdefined( activityvariant.activity_bundle ) && activityvariant.activity_bundle != "" )
            {
                varianttag = activityvariant.name;
                var_7ee59be08a4045f1 = isdefined( array_find( var_6654d5ec2459577f, varianttag ) );
                
                if ( var_7ee59be08a4045f1 )
                {
                    continue;
                }
                
                function_2aaac3f9c059969a( activityvariant );
            }
        }
    }
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x4ce
// Size: 0x1b4
function function_290cf2ed36c04f4e( activityinstance )
{
    function_3e40c76ee1767a06( activityinstance );
    varianttag = function_a4748b32a824c79c( activityinstance );
    activityvariantstructs = getstructarray( "activity_nexus_variant", "script_noteworthy" );
    
    foreach ( activityvariant in activityvariantstructs )
    {
        if ( isdefined( activityvariant.name ) && activityvariant.name != "" && activityvariant.name == varianttag )
        {
            if ( isdefined( activityvariant.origin ) )
            {
                function_51ad14107ca158fb( activityinstance, "Center_Spatial_Zone", activityvariant.origin );
            }
            
            linkedstructs = activityvariant scripts\engine\utility::get_linked_structs();
            
            foreach ( linkedstruct in linkedstructs )
            {
                var_38149816dd383643 = isdefined( linkedstruct.radius ) && isdefined( linkedstruct.origin ) && isstring( linkedstruct.script_noteworthy ) && linkedstruct.script_noteworthy != "";
                
                if ( var_38149816dd383643 )
                {
                    namespace_8480efeffcd6e233::function_51ad14107ca158fb( activityinstance, linkedstruct.script_noteworthy, linkedstruct.origin, linkedstruct.radius );
                }
            }
        }
    }
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x68a
// Size: 0x83
function private function_18be819626f488f5( scriptbundlename, var_abc1b128e7377653 )
{
    activitydefinitionbundle = level.activities.var_387cbfd0e4364cec function_c908ab3353601192( scriptbundlename );
    
    if ( !isdefined( activitydefinitionbundle ) )
    {
        var_70a471112924b726 = "activitydefinition:" + scriptbundlename;
        activitydefinitionbundle = getscriptbundle( var_70a471112924b726 );
        
        if ( isdefined( activitydefinitionbundle ) )
        {
            function_131ad6435766a89b( scriptbundlename, activitydefinitionbundle, var_abc1b128e7377653 );
            level.activities.var_387cbfd0e4364cec addtocache( scriptbundlename, activitydefinitionbundle );
        }
    }
    
    return activitydefinitionbundle;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x716
// Size: 0x3f
function getactivitydefinition( varianttag )
{
    activitydef = level.activities.definitions[ varianttag ];
    assertex( isdefined( activitydef ), "<dev string:x1c>" + varianttag );
    return activitydef;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x75e
// Size: 0x98
function function_8acb1afd4e715a06( activitytype )
{
    activitydefinitionlist = [];
    assertex( function_1a170460df34d5bf( activitytype ), "<dev string:x6b>" );
    
    foreach ( activitydefinition in level.activities.definitions )
    {
        if ( function_4b12212233972da6( activitydefinition ) == activitytype )
        {
            activitydefinitionlist = array_add( activitydefinitionlist, activitydefinition );
        }
    }
    
    return activitydefinitionlist;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x7ff
// Size: 0x3b
function function_4188e118731a30f4( activityinstance )
{
    activityinstance = default_to( activityinstance, self );
    assertex( isactivityinstance( activityinstance ), "<dev string:x99>" );
    return getactivitydefinition( activityinstance.varianttag );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x843
// Size: 0x29
function private function_4b12212233972da6( var_abc1b128e7377653 )
{
    customproperties = function_b9c4aa88ad97ee68( var_abc1b128e7377653 );
    return customproperties.activitytype;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x875
// Size: 0x52
function function_5caf0b462f4d7243( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    
    if ( isdefined( var_a6306814ebb7a58c.generalsettings.activitycategory ) )
    {
        return var_a6306814ebb7a58c.generalsettings.activitycategory;
    }
    
    return "None";
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 2
// Checksum 0x0, Offset: 0x8d0
// Size: 0x4f, Type: bool
function function_e3b085e9b8ddd75c( var_abc1b128e7377653, abandontriggertype )
{
    var_dba3df5630b47aff = function_2059fc94013292cc( var_abc1b128e7377653, abandontriggertype );
    
    if ( isdefined( var_dba3df5630b47aff ) && var_dba3df5630b47aff.size == 1 )
    {
        return istrue( var_dba3df5630b47aff[ 0 ].variant_object.var_298dc2e344249557 );
    }
    
    return false;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 2
// Checksum 0x0, Offset: 0x928
// Size: 0x4f, Type: bool
function function_1b0550352b65e18d( var_abc1b128e7377653, abandontriggertype )
{
    var_dba3df5630b47aff = function_2059fc94013292cc( var_abc1b128e7377653, abandontriggertype );
    
    if ( isdefined( var_dba3df5630b47aff ) && var_dba3df5630b47aff.size == 1 )
    {
        return istrue( var_dba3df5630b47aff[ 0 ].variant_object.var_d40ab9c653910a7d );
    }
    
    return false;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 2
// Checksum 0x0, Offset: 0x980
// Size: 0x18
function function_31c7eb34fa50cfb2( var_abc1b128e7377653, abandontriggertype )
{
    return 5;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 2
// Checksum 0x0, Offset: 0x9a1
// Size: 0x50, Type: bool
function function_b52d9bd121846fd6( var_abc1b128e7377653, abandontriggertype )
{
    var_dba3df5630b47aff = function_2059fc94013292cc( var_abc1b128e7377653, abandontriggertype );
    
    if ( isdefined( var_dba3df5630b47aff ) && var_dba3df5630b47aff.size == 1 )
    {
        return istrue( var_dba3df5630b47aff[ 0 ].variant_object.var_8e0601a3440a1b2f );
    }
    
    return true;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x9fa
// Size: 0x95
function function_b9c4aa88ad97ee68( var_abc1b128e7377653 )
{
    activitycustomproperties = function_aa7fc56dc8faec08( var_abc1b128e7377653 );
    
    if ( isdefined( activitycustomproperties ) && isdefined( activitycustomproperties.activitytypegroup ) && activitycustomproperties.activitytypegroup.size > 0 )
    {
        var_4adce313d7df60fd = activitycustomproperties.activitytypegroup[ 0 ].variant_object.var_4adce313d7df60fd;
        
        if ( isdefined( var_4adce313d7df60fd ) )
        {
            return var_4adce313d7df60fd[ 0 ].variant_object;
        }
    }
    
    assertmsg( "<dev string:x124>" );
    return undefined;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0xa98
// Size: 0x62
function getminplayercount( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    
    if ( !isdefined( var_a6306814ebb7a58c.var_c7450ec6fdf468e0.playerjoinsettings.minplayercount ) )
    {
        return 0;
    }
    
    return var_a6306814ebb7a58c.var_c7450ec6fdf468e0.playerjoinsettings.minplayercount;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0xb03
// Size: 0x70
function getmaxplayercount( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    
    if ( !isdefined( var_a6306814ebb7a58c.var_c7450ec6fdf468e0.playerjoinsettings.maxplayercount ) )
    {
        assertmsg( "<dev string:x171>" );
        return 0;
    }
    
    return var_a6306814ebb7a58c.var_c7450ec6fdf468e0.playerjoinsettings.maxplayercount;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 3
// Checksum 0x0, Offset: 0xb7c
// Size: 0x56, Type: bool
function function_59244b295f5978b9( var_abc1b128e7377653, startstate, endstate )
{
    var_5f7d555cbc9a478a = function_346b51aee749fbb3( var_abc1b128e7377653, startstate, endstate );
    return isdefined( var_5f7d555cbc9a478a.var_13606d4ae10a1dc9 ) && istrue( var_5f7d555cbc9a478a.var_13606d4ae10a1dc9.enablecondition );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 3
// Checksum 0x0, Offset: 0xbdb
// Size: 0x56, Type: bool
function function_94f74d26e2e01494( var_abc1b128e7377653, startstate, endstate )
{
    var_5f7d555cbc9a478a = function_346b51aee749fbb3( var_abc1b128e7377653, startstate, endstate );
    return isdefined( var_5f7d555cbc9a478a.var_1c781e768481f768 ) && istrue( var_5f7d555cbc9a478a.var_1c781e768481f768.enablecondition );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 3
// Checksum 0x0, Offset: 0xc3a
// Size: 0x56, Type: bool
function function_df5092441b879128( var_abc1b128e7377653, startstate, endstate )
{
    var_5f7d555cbc9a478a = function_346b51aee749fbb3( var_abc1b128e7377653, startstate, endstate );
    return isdefined( var_5f7d555cbc9a478a.var_615bb139e7f61285 ) && istrue( var_5f7d555cbc9a478a.var_615bb139e7f61285.enablecondition );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 3
// Checksum 0x0, Offset: 0xc99
// Size: 0x56, Type: bool
function function_64245919df413a31( var_abc1b128e7377653, startstate, endstate )
{
    var_5f7d555cbc9a478a = function_346b51aee749fbb3( var_abc1b128e7377653, startstate, endstate );
    return isdefined( var_5f7d555cbc9a478a.var_bc9339bf671c1022 ) && istrue( var_5f7d555cbc9a478a.var_bc9339bf671c1022.enablecondition );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 3
// Checksum 0x0, Offset: 0xcf8
// Size: 0x45
function function_c4f6cd7b881d2e90( var_abc1b128e7377653, startstate, endstate )
{
    var_5f7d555cbc9a478a = function_346b51aee749fbb3( var_abc1b128e7377653, startstate, endstate );
    return var_5f7d555cbc9a478a.var_bc9339bf671c1022.timedelay;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 3
// Checksum 0x0, Offset: 0xd46
// Size: 0xd5
function function_1acdcfcf43076114( activityinstance, startstate, endstate )
{
    var_5f7d555cbc9a478a = function_346b51aee749fbb3( activityinstance, startstate, endstate );
    assertex( isdefined( var_5f7d555cbc9a478a.var_13606d4ae10a1dc9.var_e2911d9ee3caa561 ), "<dev string:x1e9>" );
    assertex( var_5f7d555cbc9a478a.var_13606d4ae10a1dc9.var_e2911d9ee3caa561.size == 1, "<dev string:x1e9>" );
    var_c1dcf40ffeb01996 = "State Transition Within Spacial Zone: " + startstate + " : " + endstate;
    
    if ( !namespace_8480efeffcd6e233::function_1888d1b2aeeda25( activityinstance, var_c1dcf40ffeb01996 ) )
    {
        zoneinfostruct = var_5f7d555cbc9a478a.var_13606d4ae10a1dc9.var_e2911d9ee3caa561[ 0 ].variant_object;
        namespace_c8e2077fca5ac679::function_c3c41d6d385b5b81( activityinstance, var_c1dcf40ffeb01996, zoneinfostruct );
    }
    
    return var_c1dcf40ffeb01996;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 3
// Checksum 0x0, Offset: 0xe24
// Size: 0xd5
function function_1eb80c239023070b( activityinstance, startstate, endstate )
{
    var_5f7d555cbc9a478a = function_346b51aee749fbb3( activityinstance, startstate, endstate );
    assertex( isdefined( var_5f7d555cbc9a478a.var_1c781e768481f768.var_e2911d9ee3caa561 ), "<dev string:x1e9>" );
    assertex( var_5f7d555cbc9a478a.var_1c781e768481f768.var_e2911d9ee3caa561.size == 1, "<dev string:x1e9>" );
    var_c1dcf40ffeb01996 = "State Transition Not Within Spacial Zone: " + startstate + " : " + endstate;
    
    if ( !namespace_8480efeffcd6e233::function_1888d1b2aeeda25( activityinstance, var_c1dcf40ffeb01996 ) )
    {
        zoneinfostruct = var_5f7d555cbc9a478a.var_1c781e768481f768.var_e2911d9ee3caa561[ 0 ].variant_object;
        namespace_c8e2077fca5ac679::function_c3c41d6d385b5b81( activityinstance, var_c1dcf40ffeb01996, zoneinfostruct );
    }
    
    return var_c1dcf40ffeb01996;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0xf02
// Size: 0x3e, Type: bool
function function_108e464bb2e39da1( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    return istrue( var_a6306814ebb7a58c.var_c7450ec6fdf468e0.playerjoinsettings.var_9b4abf4a59450cc9 );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0xf49
// Size: 0x3e, Type: bool
function function_d4f841b62fb29144( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    return istrue( var_a6306814ebb7a58c.var_c7450ec6fdf468e0.playerjoinsettings.var_80ce033ee47849c );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0xf90
// Size: 0x3e, Type: bool
function function_d152999f66a33e7d( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    return istrue( var_a6306814ebb7a58c.var_c7450ec6fdf468e0.playerjoinsettings.var_17e7b341e0536f05 );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0xfd7
// Size: 0x5b, Type: bool
function function_ed550fddb5f694e1( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    activitycategory = function_5caf0b462f4d7243( var_abc1b128e7377653 );
    
    if ( activitycategory == "None" )
    {
        return false;
    }
    
    return istrue( var_a6306814ebb7a58c.var_c7450ec6fdf468e0.playerjoinsettings.var_1b86ff1591bed5ee );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x103b
// Size: 0x3f
function function_fa23b11703ca0c14( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    return var_a6306814ebb7a58c.var_ec0ae013bc9826dd[ 0 ].variant_object.var_98b3854d89c3149e;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1083
// Size: 0x81
function function_e2fcc8add20861a2( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    var_619645a162190c78 = var_a6306814ebb7a58c.var_ec0ae013bc9826dd[ 0 ].variant_object.var_619645a162190c78;
    
    if ( isdefined( var_619645a162190c78 ) && var_619645a162190c78.size > 0 )
    {
        return var_619645a162190c78[ 0 ].variant_object.activationmoment;
    }
    
    println( "<dev string:x253>" );
    return "ActivityBegin";
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x110d
// Size: 0x81
function function_cf98f968df6ba1ff( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    var_7b75944bb5322cfb = var_a6306814ebb7a58c.var_ec0ae013bc9826dd[ 0 ].variant_object.var_7b75944bb5322cfb;
    
    if ( isdefined( var_7b75944bb5322cfb ) && var_7b75944bb5322cfb.size > 0 )
    {
        return var_7b75944bb5322cfb[ 0 ].variant_object.activationmoment;
    }
    
    println( "<dev string:x2b1>" );
    return "InstanceEnd";
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1197
// Size: 0x6d, Type: bool
function function_1b2c7507c804109a( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    var_da98f3722099885c = isdefined( var_a6306814ebb7a58c.var_ec0ae013bc9826dd ) && var_a6306814ebb7a58c.var_ec0ae013bc9826dd.size > 0;
    return var_da98f3722099885c && istrue( var_a6306814ebb7a58c.var_ec0ae013bc9826dd[ 0 ].variant_object.var_8cd6a72620188912 );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x120d
// Size: 0x2a, Type: bool
function function_13d30c9eb7e77d36( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    return istrue( var_a6306814ebb7a58c.var_2d339ccf11a6db49 );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1240
// Size: 0x2a, Type: bool
function function_aa25447f55e47fd0( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    return istrue( var_a6306814ebb7a58c.var_9bd360ef40822493 );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1273
// Size: 0x15, Type: bool
function function_b5ec1b2b98c9a315( var_abc1b128e7377653 )
{
    return istrue( function_e3b085e9b8ddd75c( var_abc1b128e7377653, 1 ) );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1291
// Size: 0x2a, Type: bool
function function_11a119965a805599( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    return istrue( var_a6306814ebb7a58c.var_ea4ae1dc839713cc );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x12c4
// Size: 0x3a, Type: bool
function function_d9004f88db27af5e( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    return istrue( var_a6306814ebb7a58c.switchtoactivityloadout ) && isdefined( var_a6306814ebb7a58c.activityloadout );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1307
// Size: 0x29
function function_e8ef53cbeb6ab7e( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    return var_a6306814ebb7a58c.activityloadout;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1339
// Size: 0x70
function function_42a790b5e4c0dd36( var_abc1b128e7377653 )
{
    var_1789ef175a8ca697 = [];
    scriptbundlename = function_7763a30de3265573( var_abc1b128e7377653 );
    var_1789ef175a8ca697 = level.activities.var_57c2b110e4deb587 function_c908ab3353601192( scriptbundlename );
    
    if ( !isdefined( var_1789ef175a8ca697 ) )
    {
        function_3f771ba37043ddac( scriptbundlename, var_abc1b128e7377653 );
        var_1789ef175a8ca697 = level.activities.var_57c2b110e4deb587 function_c908ab3353601192( scriptbundlename );
    }
    
    return var_1789ef175a8ca697;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x13b2
// Size: 0x43
function function_30f6db0964bb1633( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    assertex( isdefined( var_a6306814ebb7a58c.var_c90b80e2759171b1 ), "<dev string:x311>" );
    return var_a6306814ebb7a58c.var_c90b80e2759171b1;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x13fe
// Size: 0x58
function function_33e6a5615b0d3148( var_abc1b128e7377653 )
{
    customproperties = function_aa7fc56dc8faec08( var_abc1b128e7377653 );
    
    if ( isdefined( customproperties.activitytypegroup ) && customproperties.activitytypegroup.size > 0 )
    {
        return customproperties.activitytypegroup[ 0 ].variant_object;
    }
    
    return undefined;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x145f
// Size: 0x9c
function function_4766b60677a139fd( radiantobjectidentifier )
{
    assertex( isdefined( radiantobjectidentifier.name ), "<dev string:x370>" );
    assertex( isdefined( radiantobjectidentifier.key ), "<dev string:x3aa>" );
    struct = getstruct( radiantobjectidentifier.name, radiantobjectidentifier.key );
    assertex( isdefined( struct ), "<dev string:x3e3>" + radiantobjectidentifier.key + "<dev string:x40b>" + radiantobjectidentifier.name + "<dev string:x41a>" );
    return struct;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 2
// Checksum 0x0, Offset: 0x1504
// Size: 0x1b
function function_cd2417904b1a0cf1( var_abc1b128e7377653, activityspatialzonename )
{
    return function_78dff8efbd88f34c( var_abc1b128e7377653, activityspatialzonename );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 3
// Checksum 0x0, Offset: 0x1528
// Size: 0xf5
function function_c3c41d6d385b5b81( spatialzonecontainer, spatialzonename, zoneinfostruct )
{
    if ( istrue( zoneinfostruct.usecustomdistance ) )
    {
        radius = function_3d2ba799dcec1eb9( zoneinfostruct.var_a7f2eefa4ba2d932 );
        ignoreheight = function_b3a183201cf67100( zoneinfostruct );
        function_51ad14107ca158fb( spatialzonecontainer, spatialzonename, undefined, radius, ignoreheight );
        
        if ( isactivityinstance( spatialzonecontainer ) )
        {
            activityinstance = spatialzonecontainer;
            function_79e69463947d9e86( activityinstance, spatialzonename, &function_8988a4c89289d7f4, [ activityinstance ] );
        }
        
        return;
    }
    
    if ( istrue( zoneinfostruct.var_833e6c27a2aac602 ) )
    {
        function_8288c27883885909( spatialzonecontainer, spatialzonename );
        return;
    }
    
    linkedspatialzonename = function_ef370453e463dc5c( zoneinfostruct );
    
    if ( isdefined( linkedspatialzonename ) )
    {
        var_9f2d4c2ade6c5663 = default_to( zoneinfostruct.var_c5dfa8891be65a7a, 100 ) / 100;
        function_c4fb45a11de2d13d( spatialzonecontainer, spatialzonename, linkedspatialzonename, var_9f2d4c2ade6c5663 );
    }
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1625
// Size: 0x45, Type: bool
function function_b066d006c79d07df( var_abc1b128e7377653 )
{
    var_df8d89bb0cdf5169 = function_d26ad5c964bcf946( var_abc1b128e7377653 );
    var_d32f76568743225c = var_df8d89bb0cdf5169.var_d32f76568743225c;
    
    if ( isdefined( var_d32f76568743225c ) && var_d32f76568743225c.size == 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1673
// Size: 0x77, Type: bool
function function_1f66cd7e1eadca9c( var_abc1b128e7377653 )
{
    if ( function_b066d006c79d07df( var_abc1b128e7377653 ) )
    {
        var_df8d89bb0cdf5169 = function_d26ad5c964bcf946( var_abc1b128e7377653 );
        var_d32f76568743225c = var_df8d89bb0cdf5169.var_d32f76568743225c;
        return istrue( var_d32f76568743225c[ 0 ].variant_type == "Types_SpawnInteractScriptablesOnScriptStructs" );
    }
    
    /#
        activitytype = function_d658014813684d5f( var_abc1b128e7377653 );
        assertex( "<dev string:x42d>" + activitytype );
    #/
    
    return false;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x16f3
// Size: 0xd0
function function_22a7bd9a3df1380d( var_abc1b128e7377653 )
{
    if ( function_b066d006c79d07df( var_abc1b128e7377653 ) )
    {
        var_df8d89bb0cdf5169 = function_d26ad5c964bcf946( var_abc1b128e7377653 );
        var_d32f76568743225c = var_df8d89bb0cdf5169.var_d32f76568743225c;
        
        if ( istrue( level.var_60af3227c0f55adf ) )
        {
            return ( var_d32f76568743225c[ 0 ].variant_object.interactscriptable + "_rift_run" );
        }
        
        if ( istrue( level.var_dbca431b3ea02d2e ) )
        {
            return ( var_d32f76568743225c[ 0 ].variant_object.interactscriptable + "_rift_run_s3" );
        }
        
        return var_d32f76568743225c[ 0 ].variant_object.interactscriptable;
    }
    
    /#
        activitytype = function_d658014813684d5f( var_abc1b128e7377653 );
        assertex( "<dev string:x42d>" + activitytype );
    #/
    
    return undefined;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x17cc
// Size: 0x57, Type: bool
function function_9edc3a4b955d5a6c( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    var_df8d89bb0cdf5169 = function_d26ad5c964bcf946( var_abc1b128e7377653 );
    var_f88b5f6a2e84d8ca = var_df8d89bb0cdf5169.var_f88b5f6a2e84d8ca;
    
    if ( isdefined( var_f88b5f6a2e84d8ca ) )
    {
        return istrue( var_f88b5f6a2e84d8ca.var_31c1baeca35c5d2c );
    }
    
    return false;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x182c
// Size: 0x6b
function function_e313cfc85da7065f( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    var_df8d89bb0cdf5169 = function_d26ad5c964bcf946( var_abc1b128e7377653 );
    joinsettings = var_df8d89bb0cdf5169.proximityjoinsettings;
    
    if ( isdefined( joinsettings ) && joinsettings.size == 1 )
    {
        return joinsettings[ 0 ].variant_object.var_6480efbc5c9c2ab7;
    }
    
    return 0;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x18a0
// Size: 0x96
function function_4c263c3baccae8b( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    
    if ( function_e313cfc85da7065f( var_abc1b128e7377653 ) )
    {
        var_df8d89bb0cdf5169 = function_d26ad5c964bcf946( var_abc1b128e7377653 );
        joinsettings = var_df8d89bb0cdf5169.proximityjoinsettings;
        var_d963f10b0da445e1 = joinsettings[ 0 ].variant_object.var_573491dc90bb0c41;
        
        if ( isdefined( var_d963f10b0da445e1 ) && var_d963f10b0da445e1.size == 1 )
        {
            return var_d963f10b0da445e1[ 0 ].variant_object.activitymoment;
        }
    }
    
    return undefined;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x193f
// Size: 0x96
function function_7e5077b9bfb018e2( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    
    if ( function_e313cfc85da7065f( var_abc1b128e7377653 ) )
    {
        var_df8d89bb0cdf5169 = function_d26ad5c964bcf946( var_abc1b128e7377653 );
        joinsettings = var_df8d89bb0cdf5169.proximityjoinsettings;
        var_4b98b7d6b6711bf = joinsettings[ 0 ].variant_object.var_ff80b34c40230a97;
        
        if ( isdefined( var_4b98b7d6b6711bf ) && var_4b98b7d6b6711bf.size == 1 )
        {
            return var_4b98b7d6b6711bf[ 0 ].variant_object.activitymoment;
        }
    }
    
    return undefined;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x19de
// Size: 0x41
function function_ede8352b065f482c( var_abc1b128e7377653 )
{
    playerfocussettings = function_ee6d368b1447961c( var_abc1b128e7377653 );
    
    if ( !isdefined( playerfocussettings ) || !isdefined( playerfocussettings.var_3d2178ddb0f118ab ) )
    {
        return 0;
    }
    
    return playerfocussettings.var_3d2178ddb0f118ab;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1a28
// Size: 0x3a
function function_98563fbd199892b0( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    
    if ( !isdefined( var_a6306814ebb7a58c.var_35136c1eb304de95 ) )
    {
        return 0;
    }
    
    return var_a6306814ebb7a58c.var_35136c1eb304de95;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1a6b
// Size: 0x64, Type: bool
function function_403cb24e07b176b0( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    
    if ( isdefined( var_a6306814ebb7a58c.var_a5b09a0116e05c6 ) && var_a6306814ebb7a58c.var_a5b09a0116e05c6.size == 1 )
    {
        return isdefined( var_a6306814ebb7a58c.var_a5b09a0116e05c6[ 0 ].variant_object.var_9062a4b6d1047da9 );
    }
    
    return false;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1ad8
// Size: 0x54
function function_c3f893aeddade548( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    assertex( function_403cb24e07b176b0( var_abc1b128e7377653 ), "<dev string:x4a1>" );
    return var_a6306814ebb7a58c.var_a5b09a0116e05c6[ 0 ].variant_object.var_9062a4b6d1047da9;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1b35
// Size: 0xb8
function function_aa0f1a318b382e70( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    assertex( function_403cb24e07b176b0( var_abc1b128e7377653 ), "<dev string:x50e>" );
    objectivemarkertype = function_c3f893aeddade548( var_abc1b128e7377653 );
    
    if ( objectivemarkertype == "Scriptable" )
    {
        return var_a6306814ebb7a58c.var_a5b09a0116e05c6[ 0 ].variant_object.objectivemarkerscriptable;
    }
    
    if ( objectivemarkertype == "GSCScript" )
    {
        return var_a6306814ebb7a58c.var_a5b09a0116e05c6[ 0 ].variant_object.objectivemarkerscriptbundle;
    }
    
    assertmsg( "<dev string:x57c>" + objectivemarkertype + "<dev string:x5a6>" );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1bf5
// Size: 0x97
function function_ec3073136fa5be4f( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    assertex( function_403cb24e07b176b0( var_abc1b128e7377653 ), "<dev string:x50e>" );
    var_56072b43f00f1b66 = var_a6306814ebb7a58c.var_a5b09a0116e05c6[ 0 ].variant_object.var_56072b43f00f1b66;
    
    if ( !isdefined( var_56072b43f00f1b66 ) || var_56072b43f00f1b66.size == 0 )
    {
        /#
            iprintln( "<dev string:x5ba>" );
        #/
        
        return "InstanceBegin";
    }
    
    return var_56072b43f00f1b66[ 0 ].variant_object.activitymoment;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1c95
// Size: 0x97
function function_77041690eb55db6e( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    assertex( function_403cb24e07b176b0( var_abc1b128e7377653 ), "<dev string:x50e>" );
    var_916b323710bc536d = var_a6306814ebb7a58c.var_a5b09a0116e05c6[ 0 ].variant_object.var_916b323710bc536d;
    
    if ( !isdefined( var_916b323710bc536d ) || var_916b323710bc536d.size == 0 )
    {
        /#
            iprintln( "<dev string:x659>" );
        #/
        
        return "ActivityEnd";
    }
    
    return var_916b323710bc536d[ 0 ].variant_object.activitymoment;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1d35
// Size: 0x55, Type: bool
function function_dff7dd2b4e3cf89e( var_abc1b128e7377653 )
{
    assertex( function_403cb24e07b176b0( var_abc1b128e7377653 ), "<dev string:x50e>" );
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    return istrue( var_a6306814ebb7a58c.var_a5b09a0116e05c6[ 0 ].variant_object.var_ebdf5a3ed212aec0 );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1d93
// Size: 0x55, Type: bool
function function_1574d7fd9a2d904a( var_abc1b128e7377653 )
{
    assertex( function_403cb24e07b176b0( var_abc1b128e7377653 ), "<dev string:x50e>" );
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    return istrue( var_a6306814ebb7a58c.var_a5b09a0116e05c6[ 0 ].variant_object.shouldpin );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1df1
// Size: 0x17, Type: bool
function function_b3a183201cf67100( zoneinfostruct )
{
    return istrue( zoneinfostruct.ignoreheightvalue );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1e11
// Size: 0x3e, Type: bool
function function_190ef47c1d23a8cb( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    return istrue( var_a6306814ebb7a58c.var_31c7dd90962b017c.var_a791fcd635a36786.var_38e3994d134283ce );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1e58
// Size: 0x3e, Type: bool
function function_32b26700c8790a55( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    return istrue( var_a6306814ebb7a58c.var_31c7dd90962b017c.var_a791fcd635a36786.var_b4d09cd10611c226 );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1e9f
// Size: 0x34, Type: bool
function function_602655b21cbe7767( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    return istrue( var_a6306814ebb7a58c.hibernationsettings.hibernationisenabled );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1edc
// Size: 0x35
function function_d8acbff3d0b7dd1a( var_abc1b128e7377653 )
{
    if ( isdefined( var_abc1b128e7377653 ) )
    {
        var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
        
        if ( isdefined( var_a6306814ebb7a58c ) )
        {
            return var_a6306814ebb7a58c.activityrewardcaches;
        }
    }
    
    return undefined;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1
// Checksum 0x0, Offset: 0x1f1a
// Size: 0x55
function function_f6fcb473df19105c( var_abc1b128e7377653 )
{
    associatedscriptbundlename = function_7763a30de3265573( var_abc1b128e7377653 );
    
    if ( isdefined( associatedscriptbundlename ) )
    {
        var_70a471112924b726 = "activitydefinition:" + associatedscriptbundlename;
        var_6433ab689201d22b = getscriptbundle( var_70a471112924b726 );
        return var_6433ab689201d22b;
    }
    
    assertmsg( "<dev string:x6fa>" );
    return undefined;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1f78
// Size: 0x6e
function private function_7763a30de3265573( var_abc1b128e7377653 )
{
    associatedscriptbundlename = undefined;
    
    if ( isactivityinstance( var_abc1b128e7377653 ) )
    {
        activitydefinition = function_4188e118731a30f4( var_abc1b128e7377653 );
        associatedscriptbundlename = activitydefinition.associatedscriptbundlename;
    }
    else if ( function_131cb78f2503defe( var_abc1b128e7377653 ) )
    {
        activitydefinition = var_abc1b128e7377653;
        associatedscriptbundlename = activitydefinition.associatedscriptbundlename;
    }
    
    assertex( isdefined( associatedscriptbundlename ), "<dev string:x6fa>" );
    return associatedscriptbundlename;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1fef
// Size: 0xc1
function private function_3e40c76ee1767a06( activityinstance )
{
    if ( function_29cccc2d0e600b4c( activityinstance, "Awareness_Zone" ) )
    {
        zoneinfostruct = function_78dff8efbd88f34c( activityinstance, "Awareness_Zone" );
        function_c3c41d6d385b5b81( activityinstance, "Awareness_Zone", zoneinfostruct );
    }
    
    if ( function_29cccc2d0e600b4c( activityinstance, "Proximity_Join_Zone" ) )
    {
        zoneinfostruct = function_78dff8efbd88f34c( activityinstance, "Proximity_Join_Zone" );
        function_c3c41d6d385b5b81( activityinstance, "Proximity_Join_Zone", zoneinfostruct );
    }
    
    if ( function_29cccc2d0e600b4c( activityinstance, "Ambient_AI_Exclusion_Zone" ) )
    {
        zoneinfostruct = function_78dff8efbd88f34c( activityinstance, "Ambient_AI_Exclusion_Zone" );
        function_c3c41d6d385b5b81( activityinstance, "Ambient_AI_Exclusion_Zone", zoneinfostruct );
    }
    
    if ( function_29cccc2d0e600b4c( activityinstance, "Hibernation_Zone" ) )
    {
        zoneinfostruct = function_78dff8efbd88f34c( activityinstance, "Hibernation_Zone" );
        function_c3c41d6d385b5b81( activityinstance, "Hibernation_Zone", zoneinfostruct );
    }
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x20b8
// Size: 0x16
function private function_ef370453e463dc5c( zoneinfostruct )
{
    return zoneinfostruct.linkedspatialzonename;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x20d7
// Size: 0x46
function private function_29cccc2d0e600b4c( var_abc1b128e7377653, activityspatialzone )
{
    zoneinfostruct = function_78dff8efbd88f34c( var_abc1b128e7377653, activityspatialzone );
    
    if ( isdefined( zoneinfostruct ) )
    {
        var_3afcfac81391026f = !isdefined( zoneinfostruct.var_a259142f43bb6c1d );
        return var_3afcfac81391026f;
    }
    
    return 0;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x2126
// Size: 0x76
function private function_78dff8efbd88f34c( var_abc1b128e7377653, activityspatialzone )
{
    zoneinfostruct = undefined;
    
    if ( activityspatialzone == "Awareness_Zone" )
    {
        zoneinfostruct = function_25170d9e35f3260c( var_abc1b128e7377653 );
    }
    else if ( activityspatialzone == "Proximity_Join_Zone" )
    {
        zoneinfostruct = function_cb6b954ccacafd94( var_abc1b128e7377653 );
    }
    else if ( activityspatialzone == "Ambient_AI_Exclusion_Zone" )
    {
        zoneinfostruct = function_9ce64ebf1019af11( var_abc1b128e7377653 );
    }
    else if ( activityspatialzone == "Hibernation_Zone" )
    {
        zoneinfostruct = function_2a8d6b549f158f76( var_abc1b128e7377653 );
    }
    
    return zoneinfostruct;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x21a5
// Size: 0x8d
function private function_2059fc94013292cc( var_abc1b128e7377653, abandontriggertype )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    
    if ( abandontriggertype == 0 )
    {
        return var_a6306814ebb7a58c.var_c7450ec6fdf468e0.var_f6ab1b86209a90bc.var_1286468d3f840de;
    }
    else if ( abandontriggertype == 1 )
    {
        return var_a6306814ebb7a58c.var_c7450ec6fdf468e0.var_f6ab1b86209a90bc.var_f0aedc3616a48e8e;
    }
    
    assertex( "<dev string:x760>" + abandontriggertype + "<dev string:x77a>" );
    return undefined;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x223b
// Size: 0x33
function private function_ee6d368b1447961c( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    return var_a6306814ebb7a58c.var_c7450ec6fdf468e0.playerfocussettings;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2277
// Size: 0xb2
function private function_5472e3b77074def0( associatedscriptbundle )
{
    var_a6306814ebb7a58c = associatedscriptbundle.var_a6306814ebb7a58c;
    var_eee5c77b99bbb93c = var_a6306814ebb7a58c.var_c90b80e2759171b1;
    
    if ( isdefined( var_eee5c77b99bbb93c ) && var_eee5c77b99bbb93c != "" )
    {
        var_99233b25d63517cc = strtok( var_eee5c77b99bbb93c, "." );
        bundlename = var_99233b25d63517cc[ 1 ] + ":" + var_99233b25d63517cc[ 0 ];
        var_398b16e96f6145ff = getscriptbundle( bundlename );
        
        if ( isdefined( var_398b16e96f6145ff ) )
        {
            var_a6306814ebb7a58c.var_c90b80e2759171b1 = var_398b16e96f6145ff;
            return;
        }
        
        assertmsg( "<dev string:x79d>" );
        var_a6306814ebb7a58c.var_c90b80e2759171b1 = undefined;
    }
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2331
// Size: 0xad
function private function_111e86a5fa46438e( var_abc1b128e7377653 )
{
    if ( isactivityinstance( var_abc1b128e7377653 ) )
    {
        activitydefinition = function_4188e118731a30f4( var_abc1b128e7377653 );
        associatedscriptbundle = function_18be819626f488f5( activitydefinition.associatedscriptbundlename, var_abc1b128e7377653 );
        return associatedscriptbundle.var_a6306814ebb7a58c;
    }
    else if ( function_131cb78f2503defe( var_abc1b128e7377653 ) )
    {
        activitydefinition = var_abc1b128e7377653;
        associatedscriptbundle = function_18be819626f488f5( activitydefinition.associatedscriptbundlename, var_abc1b128e7377653 );
        return associatedscriptbundle.var_a6306814ebb7a58c;
    }
    else if ( isdefined( var_abc1b128e7377653.var_a6306814ebb7a58c ) )
    {
        return var_abc1b128e7377653.var_a6306814ebb7a58c;
    }
    
    assertmsg( "<dev string:x6fa>" );
    return undefined;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x23e7
// Size: 0xa5
function private function_aa7fc56dc8faec08( var_abc1b128e7377653 )
{
    if ( isactivityinstance( var_abc1b128e7377653 ) )
    {
        activitydefinition = function_4188e118731a30f4( var_abc1b128e7377653 );
        return level.activities.var_5357362cdc826253[ activitydefinition.associatedscriptbundlename ];
    }
    else if ( function_131cb78f2503defe( var_abc1b128e7377653 ) )
    {
        activitydefinition = var_abc1b128e7377653;
        return level.activities.var_5357362cdc826253[ activitydefinition.associatedscriptbundlename ];
    }
    else if ( isdefined( var_abc1b128e7377653.var_a6306814ebb7a58c ) )
    {
        return var_abc1b128e7377653.customproperties;
    }
    
    assertmsg( "<dev string:x6fa>" );
    return undefined;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2495
// Size: 0x29
function private function_d658014813684d5f( var_abc1b128e7377653 )
{
    customproperties = function_b9c4aa88ad97ee68( var_abc1b128e7377653 );
    return customproperties.activitytype;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x24c7
// Size: 0x6f
function private function_2aaac3f9c059969a( var_f72639a587db1bdb )
{
    bundlename = var_f72639a587db1bdb.activity_bundle;
    varianttag = var_f72639a587db1bdb.name;
    
    if ( isstring( bundlename ) && bundlename != "" )
    {
        activitydefinition = function_86f446036c3c25a3( bundlename, varianttag );
        return activitydefinition;
    }
    
    assertex( "<dev string:x7e4>" + varianttag );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x253e
// Size: 0x5f
function private function_3d2ba799dcec1eb9( distancesettings )
{
    if ( distancesettings.distancecategory != "Custom" )
    {
        return function_9a6951feddd3cd17( distancesettings.distancecategory );
    }
    
    if ( !isdefined( distancesettings.customdistance ) )
    {
        assertmsg( "<dev string:x82f>" );
        return 0;
    }
    
    return distancesettings.customdistance;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x25a5
// Size: 0x21, Type: bool
function private function_1a170460df34d5bf( activitytype )
{
    return isdefined( level.activities.types[ activitytype ] );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x25cf
// Size: 0x35
function private function_af2950e1a1ce66ad( activitytype )
{
    assertex( function_1a170460df34d5bf( activitytype ), "<dev string:x89b>" );
    return level.activities.types[ activitytype ];
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x260d
// Size: 0x87
function private function_346b51aee749fbb3( var_abc1b128e7377653, startstate, endstate )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    
    if ( startstate == "IdleState" && endstate == "ActiveState" )
    {
        return var_a6306814ebb7a58c.var_31c7dd90962b017c.var_d8f39ba83edd5651;
    }
    
    if ( startstate == "EndedState" && endstate == "CleanupState" )
    {
        return var_a6306814ebb7a58c.var_31c7dd90962b017c.var_b37fbf02513dc214;
    }
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x269c
// Size: 0x82
function private function_131ad6435766a89b( scriptbundlename, scriptbundle, var_abc1b128e7377653 )
{
    var_19d7ff0acb1451b6 = level.activities.var_57c2b110e4deb587 function_c908ab3353601192( scriptbundlename );
    
    if ( !isdefined( var_19d7ff0acb1451b6 ) )
    {
        function_3f771ba37043ddac( scriptbundlename, var_abc1b128e7377653, scriptbundle );
    }
    
    scriptbundle.var_a6306814ebb7a58c.playerbroadcasts = undefined;
    scriptbundle.var_a6306814ebb7a58c.customproperties = undefined;
    function_5472e3b77074def0( scriptbundle );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x2726
// Size: 0xb7
function private function_3f771ba37043ddac( scriptbundlename, var_abc1b128e7377653, var_a33fc7ff96a9580a )
{
    if ( !isdefined( var_a33fc7ff96a9580a ) )
    {
        var_a33fc7ff96a9580a = function_f6fcb473df19105c( var_abc1b128e7377653 );
    }
    
    activitycategory = function_5caf0b462f4d7243( var_a33fc7ff96a9580a );
    var_80edf190b8a0abb8 = function_8ad3316a4c90145e();
    var_d98be68b4f07d81d = function_f96946a72c233e56( activitycategory );
    var_1789ef175a8ca697 = function_572fe6fc04592e85( var_a33fc7ff96a9580a );
    var_f565df3793c12460 = function_1e7b6190459c97f5();
    function_70dadbed22105e0c( var_f565df3793c12460, var_80edf190b8a0abb8 );
    function_70dadbed22105e0c( var_f565df3793c12460, var_d98be68b4f07d81d );
    function_70dadbed22105e0c( var_f565df3793c12460, var_1789ef175a8ca697 );
    level.activities.var_57c2b110e4deb587 addtocache( scriptbundlename, var_f565df3793c12460 );
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x27e5
// Size: 0x58
function private function_25170d9e35f3260c( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    
    if ( isdefined( var_a6306814ebb7a58c.var_24c4f7ba57a5f747 ) && var_a6306814ebb7a58c.var_24c4f7ba57a5f747.size > 0 )
    {
        return var_a6306814ebb7a58c.var_24c4f7ba57a5f747[ 0 ].variant_object;
    }
    
    return undefined;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2846
// Size: 0xac
function private function_cb6b954ccacafd94( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    
    if ( function_e313cfc85da7065f( var_abc1b128e7377653 ) )
    {
        var_df8d89bb0cdf5169 = function_d26ad5c964bcf946( var_abc1b128e7377653 );
        joinsettings = var_df8d89bb0cdf5169.proximityjoinsettings;
        
        if ( isdefined( joinsettings[ 0 ].variant_object.var_3f03c39ced02604c ) && joinsettings[ 0 ].variant_object.var_3f03c39ced02604c.size > 0 )
        {
            return joinsettings[ 0 ].variant_object.var_3f03c39ced02604c[ 0 ].variant_object;
        }
    }
    
    return undefined;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x28fb
// Size: 0xbb
function private function_9ce64ebf1019af11( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    
    if ( isdefined( var_a6306814ebb7a58c.var_ec0ae013bc9826dd ) && var_a6306814ebb7a58c.var_ec0ae013bc9826dd.size > 0 )
    {
        if ( isdefined( var_a6306814ebb7a58c.var_ec0ae013bc9826dd[ 0 ].variant_object.var_3add97a02bfc0b22 ) && var_a6306814ebb7a58c.var_ec0ae013bc9826dd[ 0 ].variant_object.var_3add97a02bfc0b22.size > 0 )
        {
            return var_a6306814ebb7a58c.var_ec0ae013bc9826dd[ 0 ].variant_object.var_3add97a02bfc0b22[ 0 ].variant_object;
        }
    }
    
    return undefined;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x29bf
// Size: 0x76
function private function_2a8d6b549f158f76( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    
    if ( isdefined( var_a6306814ebb7a58c.hibernationsettings.var_17e5ba260ba11271 ) && var_a6306814ebb7a58c.hibernationsettings.var_17e5ba260ba11271.size > 0 )
    {
        return var_a6306814ebb7a58c.hibernationsettings.var_17e5ba260ba11271[ 0 ].variant_object;
    }
    
    return undefined;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2a3e
// Size: 0x3d
function private function_d26ad5c964bcf946( var_abc1b128e7377653 )
{
    var_a6306814ebb7a58c = function_111e86a5fa46438e( var_abc1b128e7377653 );
    return var_a6306814ebb7a58c.var_c7450ec6fdf468e0.playerjoinsettings.var_df8d89bb0cdf5169;
}

// Namespace namespace_3485b020a23acaae / namespace_c8e2077fca5ac679
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2a84
// Size: 0x17, Type: bool
function private function_131cb78f2503defe( activitydefinition )
{
    return istrue( activitydefinition.isactivitydefinition );
}

