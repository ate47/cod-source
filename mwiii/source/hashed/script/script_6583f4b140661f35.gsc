#using script_2b85a88a1d543a;
#using script_713ccfa3a01d4d19;
#using scripts\common\callbacks;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_dev;

#namespace namespace_c79c976ae904fa16;

// Namespace namespace_c79c976ae904fa16 / namespace_26298812b4c5954b
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0xe5
// Size: 0x41
function autoexec main()
{
    /#
        iprintln( "<dev string:x1c>" + "<dev string:x33>" + "<dev string:x3b>" );
    #/
    
    registermission( "cash", &init, &function_42abf8c3f5614a65 );
    
    /#
        scripts\mp\gametypes\br_dev::registerhandlecommand( &function_3195d135ced85ef8 );
    #/
}

// Namespace namespace_c79c976ae904fa16 / namespace_26298812b4c5954b
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x12e
// Size: 0xdb
function private init( scriptbundle, maxcash, xpbonus )
{
    assert( scriptbundle.scriptid == "<dev string:x33>" );
    
    /#
        iprintln( "<dev string:x51>" + maxcash + "<dev string:x88>" + xpbonus + "<dev string:x91>" );
    #/
    
    level.secondaryvictory.var_f5eb9b1ad1613bca = &function_f5eb9b1ad1613bca;
    level.secondaryvictory.var_228bbb92952e5f9f = &function_228bbb92952e5f9f;
    level.secondaryvictory.onkioskpurchase = &onkioskpurchase;
    function_33bb17d027e6a631( level.secondaryvictory.var_5fc0bb331fcc1784 );
    function_7d3329c47fbe47f1( 1 );
    function_906084f03cbe16da( 1 );
    function_3b015b3d933c20ef( maxcash );
    level thread function_426b2a60c569a757();
}

// Namespace namespace_c79c976ae904fa16 / namespace_26298812b4c5954b
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x211
// Size: 0x19
function private function_426b2a60c569a757()
{
    level endon( "game_ended" );
    level waittill( "gulag_closed" );
    function_906084f03cbe16da( 0 );
}

// Namespace namespace_c79c976ae904fa16 / namespace_26298812b4c5954b
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x232
// Size: 0x17
function private function_f5eb9b1ad1613bca()
{
    function_d19de726f751683d( "cash", self.team );
}

// Namespace namespace_c79c976ae904fa16 / namespace_26298812b4c5954b
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x251
// Size: 0x1e
function private function_42abf8c3f5614a65()
{
    if ( isdefined( self.plundercount ) )
    {
        return self.plundercount;
    }
    
    return 0;
}

// Namespace namespace_c79c976ae904fa16 / namespace_26298812b4c5954b
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x277
// Size: 0x4c
function private function_33bb17d027e6a631( count )
{
    assert( isdefined( count ) && count > 0 );
    level.secondaryvictory.inventorycount = count;
    function_358c488f5ac3aff0( level.secondaryvictory.inventorycount );
}

// Namespace namespace_c79c976ae904fa16 / namespace_26298812b4c5954b
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2cb
// Size: 0x66
function private function_6914ed4b05188c76()
{
    assert( isdefined( level.secondaryvictory.inventorycount ) && level.secondaryvictory.inventorycount > 0 );
    level.secondaryvictory.inventorycount--;
    function_358c488f5ac3aff0( level.secondaryvictory.inventorycount );
}

// Namespace namespace_c79c976ae904fa16 / namespace_26298812b4c5954b
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x339
// Size: 0x73
function private function_228bbb92952e5f9f()
{
    response = namespace_3460310ddf4d9cfa::function_70ee001b7b3a1bd0();
    
    if ( isdefined( level.gulag ) && istrue( level.gulag.shutdown ) )
    {
        /#
            iprintln( "<dev string:x98>" + self.name + "<dev string:xb6>" );
        #/
        
        response = 0;
    }
    
    if ( response != 2 )
    {
        function_a9b4c3bb4abb4a01( response, self.origin );
    }
    
    return response;
}

// Namespace namespace_c79c976ae904fa16 / namespace_26298812b4c5954b
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3b5
// Size: 0x51
function private onkioskpurchase( cost )
{
    player = self;
    scripts\mp\gametypes\br_armory_kiosk::function_3cb66deb101988ce( "br_sv_exfil", 1 );
    player function_a10e1586d7ecf252( cost, level.secondaryvictory.inventorycount );
    function_6914ed4b05188c76();
    player function_2aa9a736450d87ce();
}

// Namespace namespace_c79c976ae904fa16 / namespace_26298812b4c5954b
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x40e
// Size: 0x20
function private function_3b015b3d933c20ef( cost )
{
    function_cae7fc3d806ab9ce( cost );
    scripts\mp\gametypes\br_armory_kiosk::function_6ce8d88dab67a185( "br_sv_exfil", cost );
}

/#

    // Namespace namespace_c79c976ae904fa16 / namespace_26298812b4c5954b
    // Params 2
    // Checksum 0x0, Offset: 0x436
    // Size: 0x97, Type: dev
    function function_3195d135ced85ef8( command, args )
    {
        switch ( command )
        {
            case #"hash_a9ea817c60179bbf":
                function_7d3329c47fbe47f1( int( args[ 0 ] ) );
                break;
            case #"hash_22f1a0a6299aa80":
                function_906084f03cbe16da( int( args[ 0 ] ) );
                break;
            case #"hash_b3134eabc9b4c82":
                function_3b015b3d933c20ef( int( args[ 0 ] ) );
                break;
            case #"hash_d14dd86d102e2aa":
                function_33bb17d027e6a631( int( args[ 0 ] ) );
                break;
        }
    }

#/
