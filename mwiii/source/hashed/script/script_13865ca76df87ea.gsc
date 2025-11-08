#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_4f3742cd39063b9;

// Namespace namespace_4f3742cd39063b9 / namespace_eb369ce7be7f0198
// Params 2
// Checksum 0x0, Offset: 0xf6
// Size: 0x107
function genericblueprint_getweaponname( blueprintname, weaponkey )
{
    var_5a0f9e1af605f0f5 = function_98442f5bef361b2b( "genericblueprint", blueprintname );
    
    if ( !isdefined( var_5a0f9e1af605f0f5 ) )
    {
        /#
            errortext = "<dev string:x1c>" + getxhashsourcename( blueprintname ) + "<dev string:x45>";
            iprintln( errortext );
        #/
        
        return undefined;
    }
    
    foreach ( entry in var_5a0f9e1af605f0f5.weaponlist )
    {
        if ( entry.key == weaponkey )
        {
            if ( entry.weapon == "" )
            {
                return undefined;
            }
            
            return entry.weapon;
        }
    }
    
    /#
        errortext = "<dev string:x4a>" + getxhashsourcename( weaponkey ) + "<dev string:x6d>" + getxhashsourcename( blueprintname ) + "<dev string:x45>";
        iprintln( errortext );
    #/
    
    return undefined;
}

// Namespace namespace_4f3742cd39063b9 / namespace_eb369ce7be7f0198
// Params 2
// Checksum 0x0, Offset: 0x206
// Size: 0x107
function function_b9ff4b6230995332( blueprintname, weaponkey )
{
    var_5a0f9e1af605f0f5 = function_98442f5bef361b2b( "genericblueprint", blueprintname );
    
    if ( !isdefined( var_5a0f9e1af605f0f5 ) )
    {
        /#
            errortext = "<dev string:x1c>" + getxhashsourcename( blueprintname ) + "<dev string:x45>";
            iprintln( errortext );
        #/
        
        return undefined;
    }
    
    foreach ( entry in var_5a0f9e1af605f0f5.weaponlist )
    {
        if ( entry.key == weaponkey )
        {
            if ( entry.weaponblueprint == "" )
            {
                return undefined;
            }
            
            return entry.weaponblueprint;
        }
    }
    
    /#
        errortext = "<dev string:x4a>" + getxhashsourcename( weaponkey ) + "<dev string:x6d>" + getxhashsourcename( blueprintname ) + "<dev string:x45>";
        iprintln( errortext );
    #/
    
    return undefined;
}

// Namespace namespace_4f3742cd39063b9 / namespace_eb369ce7be7f0198
// Params 2
// Checksum 0x0, Offset: 0x316
// Size: 0xbd
function getassetlist( bundle, assettype )
{
    switch ( assettype )
    {
        case #"xmodel":
            return bundle.xmodellist;
        case #"vfx":
            return bundle.vfxlist;
        case #"string":
            return bundle.stringlist;
        case #"suit":
            return bundle.suitlist;
        case #"execution":
            return bundle.executionlist;
        default:
            /#
                errortext = "<dev string:x8d>";
                iprintln( errortext );
            #/
            
            return undefined;
    }
}

// Namespace namespace_4f3742cd39063b9 / namespace_eb369ce7be7f0198
// Params 3
// Checksum 0x0, Offset: 0x3db
// Size: 0x123
function function_29e16a88682086b2( blueprintname, assettype, key )
{
    var_5a0f9e1af605f0f5 = function_98442f5bef361b2b( "genericblueprint", blueprintname );
    
    if ( !isdefined( var_5a0f9e1af605f0f5 ) )
    {
        /#
            errortext = "<dev string:x1c>" + getxhashsourcename( blueprintname ) + "<dev string:x45>";
            iprintln( errortext );
        #/
        
        return undefined;
    }
    
    assetlist = getassetlist( var_5a0f9e1af605f0f5, assettype );
    
    foreach ( entry in assetlist )
    {
        if ( entry.key == key )
        {
            if ( entry.value == "" )
            {
                return undefined;
            }
            
            return entry.value;
        }
    }
    
    /#
        errortext = "<dev string:xb1>" + assettype + "<dev string:xd4>" + getxhashsourcename( key ) + "<dev string:xe8>" + getxhashsourcename( blueprintname ) + "<dev string:x45>";
        iprintln( errortext );
    #/
    
    return undefined;
}

// Namespace namespace_4f3742cd39063b9 / namespace_eb369ce7be7f0198
// Params 4
// Checksum 0x0, Offset: 0x507
// Size: 0x13e
function function_b9bd0a3d37510bfd( weaponname, weaponblueprintname, attachmentname, attachmentblueprintname )
{
    var_9be202c49cdf67ec = undefined;
    
    if ( isdefined( weaponblueprintname ) )
    {
        weaponblueprintnames = getweaponblueprintnames( weaponname );
        
        foreach ( name, index in weaponblueprintnames )
        {
            if ( name == weaponblueprintname )
            {
                var_9be202c49cdf67ec = index;
                break;
            }
        }
    }
    
    attachmentarray = [];
    
    if ( isdefined( attachmentname ) )
    {
        attachmentarray = [ attachmentname ];
    }
    
    var_e658498427cc5a29 = [];
    
    if ( isdefined( attachmentname ) && isdefined( attachmentblueprintname ) && isdefined( weaponblueprintname ) )
    {
        var_e658498427cc5a29 = [ 0 ];
        weaponblueprintattachmentnames = function_3211981142ec5aee( weaponname, weaponblueprintname );
        
        foreach ( name, index in weaponblueprintattachmentnames )
        {
            if ( name == attachmentname )
            {
                var_e658498427cc5a29 = [ index ];
                break;
            }
        }
    }
    
    return makeweapon( weaponname, attachmentarray, undefined, undefined, var_9be202c49cdf67ec, var_e658498427cc5a29 );
}

// Namespace namespace_4f3742cd39063b9 / namespace_eb369ce7be7f0198
// Params 2
// Checksum 0x0, Offset: 0x64e
// Size: 0xb6
function function_71efed8bf57f1d39( bundle, blueprintindex )
{
    genericblueprintname = undefined;
    
    if ( isdefined( bundle.genericblueprintlist.blueprints ) && bundle.genericblueprintlist.blueprints.size > 0 && blueprintindex > 0 )
    {
        genericblueprintname = bundle.genericblueprintlist.blueprints[ blueprintindex - 1 ].genericblueprint;
    }
    else if ( isdefined( bundle.genericblueprintlist.blueprint_default ) )
    {
        genericblueprintname = bundle.genericblueprintlist.blueprint_default;
    }
    
    return genericblueprintname;
}

// Namespace namespace_4f3742cd39063b9 / namespace_eb369ce7be7f0198
// Params 2
// Checksum 0x0, Offset: 0x70d
// Size: 0x1ad
function genericblueprint_makeweapon( blueprintname, weaponkey )
{
    if ( isdefined( blueprintname ) && isdefined( weaponkey ) )
    {
        var_5a0f9e1af605f0f5 = function_98442f5bef361b2b( "genericblueprint", blueprintname );
        weaponentry = undefined;
        
        foreach ( weaponlistentry in var_5a0f9e1af605f0f5.weaponlist )
        {
            if ( weaponlistentry.key == weaponkey )
            {
                weaponentry = weaponlistentry;
                break;
            }
        }
        
        if ( !isdefined( weaponentry ) )
        {
            /#
                error( "<dev string:x105>" + getxhashsourcename( blueprintname ) );
            #/
            
            return;
        }
        
        weaponname = ter_op( weaponentry.weapon != "", weaponentry.weapon, undefined );
        weaponblueprintname = ter_op( weaponentry.weaponblueprint != "", weaponentry.weaponblueprint, undefined );
        attachmentname = ter_op( weaponentry.attachment != "", weaponentry.attachment, undefined );
        attachmentblueprintname = ter_op( weaponentry.attachmentblueprint != "", weaponentry.attachmentblueprint, undefined );
        return function_b9bd0a3d37510bfd( weaponname, weaponblueprintname, attachmentname, attachmentblueprintname );
    }
    
    if ( !isdefined( blueprintname ) )
    {
        error( "blueprintName not specified" );
    }
    
    if ( !isdefined( blueprintname ) )
    {
        error( "weaponKey not specified" );
    }
    
    return undefined;
}

// Namespace namespace_4f3742cd39063b9 / namespace_eb369ce7be7f0198
// Params 1
// Checksum 0x0, Offset: 0x8c2
// Size: 0x9d
function function_a03b57f924bf9a77( genericblueprintname )
{
    genericblueprint = function_98442f5bef361b2b( "genericblueprint", genericblueprintname );
    
    foreach ( vfx in getassetlist( genericblueprint, #"vfx" ) )
    {
        utility::add_fx( getxhashhexname( genericblueprintname ) + ":" + vfx.key, vfx.value );
    }
}

// Namespace namespace_4f3742cd39063b9 / namespace_eb369ce7be7f0198
// Params 1
// Checksum 0x0, Offset: 0x967
// Size: 0x9c
function function_b68fa1978a63823a( bundle )
{
    defaultblueprintname = bundle.genericblueprintlist.blueprint_default;
    function_a03b57f924bf9a77( defaultblueprintname );
    
    foreach ( blueprint in bundle.genericblueprintlist.blueprints )
    {
        function_a03b57f924bf9a77( blueprint.genericblueprint );
    }
}

// Namespace namespace_4f3742cd39063b9 / namespace_eb369ce7be7f0198
// Params 4
// Checksum 0x0, Offset: 0xa0b
// Size: 0x52
function genericblueprint_playfx( bundle, blueprintindex, vfxkey, position )
{
    genericblueprintname = function_71efed8bf57f1d39( bundle, blueprintindex );
    playfx( utility::getfx( getxhashhexname( genericblueprintname ) + ":" + vfxkey ), position );
}

// Namespace namespace_4f3742cd39063b9 / namespace_eb369ce7be7f0198
// Params 2
// Checksum 0x0, Offset: 0xa65
// Size: 0x38
function function_696473ef4d75f1d3( bundle, blueprintindex )
{
    genericblueprintname = function_71efed8bf57f1d39( bundle, blueprintindex );
    blueprintdefindex = getgenericblueprintdefindex( genericblueprintname );
    return blueprintdefindex;
}

