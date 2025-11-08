#using script_53651341190c5aab;
#using scripts\asm\asm_bb;
#using scripts\engine\utility;

#namespace namespace_3f720e0f50e8409f;

// Namespace namespace_3f720e0f50e8409f / namespace_3cab255db903647f
// Params 1
// Checksum 0x0, Offset: 0xcf
// Size: 0x75
function getfunction( funcid )
{
    switch ( funcid )
    {
        case #"hash_4d7ca12cb5ce1028":
            return &startcap;
        case #"hash_96053be986d24f88":
            return &OnDeleteUser;
        case #"hash_b74f6be2a082d8a4":
            return &function_c41ad0adbb33bbd7;
        case #"hash_9910be4166a4ce32":
            return &function_67556aff182e237a;
        case #"hash_ad4d7bc640ba9c5b":
            return &function_ca8028e5808a134b;
    }
    
    return namespace_f901a4f9d899be59::function_efcea5d26798e5b6( funcid );
}

// Namespace namespace_3f720e0f50e8409f / namespace_3cab255db903647f
// Params 2
// Checksum 0x0, Offset: 0x14d
// Size: 0x3d
function startcap( statename, params )
{
    walkspeed = 50;
    scripts\asm\asm_bb::bb_setcivilianstate( "casual" );
    scripts\asm\asm_bb::bb_civilianrequestspeed( walkspeed );
    namespace_f901a4f9d899be59::startcap( statename, params );
}

// Namespace namespace_3f720e0f50e8409f / namespace_3cab255db903647f
// Params 1
// Checksum 0x0, Offset: 0x192
// Size: 0x1a
function OnDeleteUser( interactionid )
{
    namespace_f901a4f9d899be59::function_25c933655d73066a( interactionid );
    return namespace_f901a4f9d899be59::OnDeleteUser( interactionid );
}

// Namespace namespace_3f720e0f50e8409f / namespace_3cab255db903647f
// Params 1
// Checksum 0x0, Offset: 0x1b5
// Size: 0x27
function function_c41ad0adbb33bbd7( params )
{
    id = self getinteractionid();
    return function_60d6151af81a343( id, "OverflowBypass" );
}

// Namespace namespace_3f720e0f50e8409f / namespace_3cab255db903647f
// Params 1
// Checksum 0x0, Offset: 0x1e5
// Size: 0x16
function function_67556aff182e237a( params )
{
    self.interactionholdingpattern = 1;
}

// Namespace namespace_3f720e0f50e8409f / namespace_3cab255db903647f
// Params 1
// Checksum 0x0, Offset: 0x203
// Size: 0x15
function function_ca8028e5808a134b( params )
{
    self.interactionholdingpattern = undefined;
}

