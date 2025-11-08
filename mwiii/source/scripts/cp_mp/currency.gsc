#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace currency;

// Namespace currency / scripts\cp_mp\currency
// Params 0
// Checksum 0x0, Offset: 0x206
// Size: 0x12
function init_currency()
{
    function_68a07bf45b0ba30a();
    level thread function_c1674a2bf8fcb89a();
}

// Namespace currency / scripts\cp_mp\currency
// Params 0
// Checksum 0x0, Offset: 0x220
// Size: 0x3
function function_c1674a2bf8fcb89a()
{
    waitframe();
}

// Namespace currency / scripts\cp_mp\currency
// Params 0
// Checksum 0x0, Offset: 0x22b
// Size: 0x265
function function_68a07bf45b0ba30a()
{
    if ( isdefined( level.gamemodebundle.pricelist ) && !isdefined( level.var_4ae3d29e068b4901 ) )
    {
        level.var_4ae3d29e068b4901 = getscriptbundle( "pricelist:" + level.gamemodebundle.pricelist );
        level.var_4ae3d29e068b4901.var_163ce105edf9e5de = [];
        level.var_4ae3d29e068b4901.var_1982789b1e12442b = [];
        assertex( isdefined( level.var_4ae3d29e068b4901.var_d5753c1d2046e1c4 ), "<dev string:x1c>" + level.gamemodebundle.pricelist + "<dev string:x3e>" );
        
        foreach ( var_98249fc6e5334ea1 in level.var_4ae3d29e068b4901.var_d5753c1d2046e1c4 )
        {
            if ( !isdefined( level.var_4ae3d29e068b4901.var_163ce105edf9e5de[ var_98249fc6e5334ea1.var_645b9579909be3f8 ] ) )
            {
                level.var_4ae3d29e068b4901.var_163ce105edf9e5de[ var_98249fc6e5334ea1.var_645b9579909be3f8 ] = getscriptbundle( "currency:" + var_98249fc6e5334ea1.var_645b9579909be3f8 );
            }
        }
        
        foreach ( var_be041469fc4704b in level.var_4ae3d29e068b4901.var_36a99886b712dcc3 )
        {
            if ( isdefined( var_be041469fc4704b.var_3fd8eff0621723c9 ) && isdefined( var_be041469fc4704b.var_af40863a32d7792b ) )
            {
                level.var_4ae3d29e068b4901.var_1982789b1e12442b[ var_be041469fc4704b.var_3fd8eff0621723c9 ] = spawnstruct();
                level.var_4ae3d29e068b4901.var_1982789b1e12442b[ var_be041469fc4704b.var_3fd8eff0621723c9 ].value = var_be041469fc4704b.var_af40863a32d7792b;
                level.var_4ae3d29e068b4901.var_1982789b1e12442b[ var_be041469fc4704b.var_3fd8eff0621723c9 ].currency = var_be041469fc4704b.var_38d055f24fe64e71;
            }
        }
    }
}

// Namespace currency / scripts\cp_mp\currency
// Params 0
// Checksum 0x0, Offset: 0x498
// Size: 0xb
function function_2e815a7b6d0bbcf6()
{
    return level.var_4ae3d29e068b4901;
}

// Namespace currency / scripts\cp_mp\currency
// Params 1
// Checksum 0x0, Offset: 0x4ac
// Size: 0x20
function function_7714028270738890( var_147708c583186e71 )
{
    return level.var_4ae3d29e068b4901.var_163ce105edf9e5de[ var_147708c583186e71 ];
}

// Namespace currency / scripts\cp_mp\currency
// Params 1
// Checksum 0x0, Offset: 0x4d5
// Size: 0xd7
function function_7dfe1b812431019f( str_currency )
{
    if ( isdefined( level.var_4ae3d29e068b4901 ) && isdefined( level.var_4ae3d29e068b4901.var_d5753c1d2046e1c4 ) )
    {
        foreach ( var_98249fc6e5334ea1 in level.var_4ae3d29e068b4901.var_d5753c1d2046e1c4 )
        {
            if ( isdefined( var_98249fc6e5334ea1.var_645b9579909be3f8 ) && level.var_4ae3d29e068b4901.var_163ce105edf9e5de[ var_98249fc6e5334ea1.var_645b9579909be3f8 ].currencyname == str_currency )
            {
                return default_to( var_98249fc6e5334ea1.var_9247b3a807fe55ec, 0 );
            }
        }
    }
}

// Namespace currency / scripts\cp_mp\currency
// Params 1
// Checksum 0x0, Offset: 0x5b4
// Size: 0x20
function function_3321003104b9507e( var_3719061529ddd848 )
{
    return level.var_4ae3d29e068b4901.var_1982789b1e12442b[ var_3719061529ddd848 ];
}

// Namespace currency / scripts\cp_mp\currency
// Params 1
// Checksum 0x0, Offset: 0x5dd
// Size: 0x2f
function get_perk_machine_cost( str_perk )
{
    var_2d823173121c345a = function_ea6ad508534fc509( str_perk );
    
    if ( !isdefined( var_2d823173121c345a ) )
    {
        return;
    }
    
    return var_2d823173121c345a.var_10d2cda4ce007c3b;
}

// Namespace currency / scripts\cp_mp\currency
// Params 1
// Checksum 0x0, Offset: 0x615
// Size: 0x9d
function function_bc4d94fa05ac7078( str_perk )
{
    var_2d823173121c345a = function_ea6ad508534fc509( str_perk );
    
    if ( !isdefined( var_2d823173121c345a ) )
    {
        return "essence";
    }
    else if ( isdefined( var_2d823173121c345a.var_3995211e6d9a4259 ) )
    {
        var_2de54af70b9cbe75 = function_7714028270738890( var_2d823173121c345a.var_3995211e6d9a4259 );
        return var_2de54af70b9cbe75.currencyname;
    }
    
    println( "<dev string:x85>" + level.gamemodebundle.pricelist + "<dev string:xc8>" + str_perk + "<dev string:xd1>" + "<dev string:xe5>" );
    return "essence";
}

// Namespace currency / scripts\cp_mp\currency
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x6bb
// Size: 0xca
function private function_ea6ad508534fc509( str_perk )
{
    var_c82bc608d1423259 = function_2e815a7b6d0bbcf6();
    
    if ( isdefined( var_c82bc608d1423259 ) && isdefined( var_c82bc608d1423259.var_fff87512f24a9908 ) )
    {
        foreach ( var_3cdbf17f49ef52e8 in var_c82bc608d1423259.var_fff87512f24a9908 )
        {
            if ( isdefined( var_3cdbf17f49ef52e8.var_cb1f5a302f01f831 ) && var_3cdbf17f49ef52e8.var_cb1f5a302f01f831 == str_perk )
            {
                return var_3cdbf17f49ef52e8;
            }
        }
        
        println( "<dev string:xf0>" + level.gamemodebundle.pricelist + "<dev string:xc8>" + str_perk );
    }
}

// Namespace currency / scripts\cp_mp\currency
// Params 0
// Checksum 0x0, Offset: 0x78d
// Size: 0x65
function function_51ff679cabccfcd0()
{
    if ( !isdefined( level.gamemodebundle.pricelist ) )
    {
        return;
    }
    
    var_c82bc608d1423259 = function_2e815a7b6d0bbcf6();
    assertex( isdefined( var_c82bc608d1423259.var_63f11055773fb7d6 ), "<dev string:x130>" + level.gamemodebundle.pricelist );
    return var_c82bc608d1423259.var_63f11055773fb7d6;
}

// Namespace currency / scripts\cp_mp\currency
// Params 0
// Checksum 0x0, Offset: 0x7fb
// Size: 0x65
function function_fd307a39427b77da()
{
    if ( !isdefined( level.gamemodebundle.pricelist ) )
    {
        return;
    }
    
    var_c82bc608d1423259 = function_2e815a7b6d0bbcf6();
    assertex( isdefined( var_c82bc608d1423259.var_f26b80cb6833eb9 ), "<dev string:x152>" + level.gamemodebundle.pricelist );
    return var_c82bc608d1423259.var_f26b80cb6833eb9;
}

// Namespace currency / scripts\cp_mp\currency
// Params 0
// Checksum 0x0, Offset: 0x869
// Size: 0x90
function function_86ff2975af8e08be()
{
    if ( !isdefined( level.gamemodebundle.pricelist ) )
    {
        return;
    }
    
    var_c82bc608d1423259 = function_2e815a7b6d0bbcf6();
    var_2de54af70b9cbe75 = function_7714028270738890( var_c82bc608d1423259.var_8e4ed0273dc8b664 );
    assertex( isdefined( var_c82bc608d1423259.var_8e4ed0273dc8b664 ) && isdefined( var_2de54af70b9cbe75.currencyname ), "<dev string:x17e>" + level.gamemodebundle.pricelist );
    return var_2de54af70b9cbe75.currencyname;
}

// Namespace currency / scripts\cp_mp\currency
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x902
// Size: 0xb8
function private function_a6b6cc77c4485d21( var_545dc2e67db04095 )
{
    if ( !isdefined( level.gamemodebundle.pricelist ) )
    {
        return;
    }
    
    var_c82bc608d1423259 = function_2e815a7b6d0bbcf6();
    
    if ( isdefined( var_c82bc608d1423259 ) && isdefined( var_c82bc608d1423259.var_1f851a428523f96b ) )
    {
        foreach ( var_7b9786d925211f8c in var_c82bc608d1423259.var_1f851a428523f96b )
        {
            if ( isdefined( var_7b9786d925211f8c.var_3a186553b8a52af5 ) && var_7b9786d925211f8c.var_3a186553b8a52af5 == var_545dc2e67db04095 )
            {
                return var_7b9786d925211f8c;
            }
        }
    }
}

// Namespace currency / scripts\cp_mp\currency
// Params 1
// Checksum 0x0, Offset: 0x9c2
// Size: 0x2f
function function_93cabb608eabdb7c( var_545dc2e67db04095 )
{
    var_7b9786d925211f8c = function_a6b6cc77c4485d21( var_545dc2e67db04095 );
    
    if ( !isdefined( var_7b9786d925211f8c ) )
    {
        return;
    }
    
    return var_7b9786d925211f8c.var_4e0e100f89227f67;
}

// Namespace currency / scripts\cp_mp\currency
// Params 1
// Checksum 0x0, Offset: 0x9fa
// Size: 0x2f
function function_57e6c79279b89596( var_545dc2e67db04095 )
{
    var_7b9786d925211f8c = function_a6b6cc77c4485d21( var_545dc2e67db04095 );
    
    if ( !isdefined( var_7b9786d925211f8c ) )
    {
        return;
    }
    
    return var_7b9786d925211f8c.var_e6e7b751029bb9dc;
}

// Namespace currency / scripts\cp_mp\currency
// Params 1
// Checksum 0x0, Offset: 0xa32
// Size: 0x90
function function_98aedb8cf660c612( var_545dc2e67db04095 )
{
    var_7b9786d925211f8c = function_a6b6cc77c4485d21( var_545dc2e67db04095 );
    
    if ( !isdefined( var_7b9786d925211f8c ) )
    {
        return;
    }
    
    var_2de54af70b9cbe75 = function_7714028270738890( var_7b9786d925211f8c.var_e7a5769148797e0d );
    assertex( isdefined( var_7b9786d925211f8c.var_e7a5769148797e0d ) && isdefined( var_2de54af70b9cbe75.currencyname ), "<dev string:x1a3>" + level.gamemodebundle.pricelist + "<dev string:xc8>" + var_545dc2e67db04095 );
    return var_2de54af70b9cbe75.currencyname;
}

// Namespace currency / scripts\cp_mp\currency
// Params 7
// Checksum 0x0, Offset: 0xacb
// Size: 0x164
function function_cca1bcebd7aa11cf( currencytype, getfunc, setfunc, addfunc, subfunc, buysound, denysound )
{
    if ( isdefined( level.currency ) && isdefined( level.currency[ currencytype ] ) )
    {
        assert( "<dev string:x1cd>" + currencytype + "<dev string:x1db>" );
        return;
    }
    else
    {
        level.currency = default_to( level.currency, [] );
    }
    
    currencystruct = spawnstruct();
    level.currency[ currencytype ] = currencystruct;
    level.currency[ currencytype ].currencytype = currencytype;
    level.currency[ currencytype ].getfunc = getfunc;
    level.currency[ currencytype ].setfunc = setfunc;
    level.currency[ currencytype ].addfunc = addfunc;
    level.currency[ currencytype ].subfunc = subfunc;
    level.currency[ currencytype ].buysound = buysound;
    level.currency[ currencytype ].denysound = denysound;
    
    /#
        level thread function_2e0cc380e14c340b( currencytype );
    #/
}

// Namespace currency / scripts\cp_mp\currency
// Params 2
// Checksum 0x0, Offset: 0xc37
// Size: 0x61
function function_adc47eed1b02ec05( currencytype, var_978799e2da3eab39 )
{
    if ( !isplayer( self ) )
    {
        assert( "<dev string:x1f2>" );
        return;
    }
    
    if ( !isdefined( var_978799e2da3eab39 ) )
    {
        var_978799e2da3eab39 = 0;
    }
    
    function_d0948454b7f94d18( currencytype, var_978799e2da3eab39 );
    
    if ( getdvarint( @"hash_bc19129b877ec86b", 0 ) )
    {
        thread function_d67d3f6e87682c71( self.currency.size, currencytype );
    }
}

// Namespace currency / scripts\cp_mp\currency
// Params 3
// Checksum 0x0, Offset: 0xca0
// Size: 0xb7
function function_3036cef61495210f( currencytype, amount, reason )
{
    var_65b4e89f87e61c2 = amount;
    
    if ( isdefined( level.currency[ currencytype ].addfunc ) )
    {
        self [[ level.currency[ currencytype ].addfunc ]]( amount );
    }
    else
    {
        function_8301d03eb828b5a5( amount, currencytype );
    }
    
    sparams = spawnstruct();
    sparams.var_65b4e89f87e61c2 = var_65b4e89f87e61c2;
    sparams.currencytype = currencytype;
    sparams.amount = amount;
    sparams.reason = reason;
    callback::callback( "currency_add", sparams );
}

// Namespace currency / scripts\cp_mp\currency
// Params 2
// Checksum 0x0, Offset: 0xd5f
// Size: 0x59
function function_8301d03eb828b5a5( amount, currencytype )
{
    currencyamount = function_15975e20bbd2c824( currencytype );
    newamount = currencyamount + amount;
    
    if ( amount > 0 && newamount < currencyamount )
    {
        newamount = 2147483647;
    }
    
    if ( newamount < 0 )
    {
        newamount = 0;
    }
    
    function_d0948454b7f94d18( currencytype, newamount );
}

// Namespace currency / scripts\cp_mp\currency
// Params 4
// Checksum 0x0, Offset: 0xdc0
// Size: 0xcc
function function_a06aa3b8c98e131e( currencytype, amount, reason, info )
{
    var_65b4e89f87e61c2 = amount;
    
    if ( isdefined( level.currency[ currencytype ].subfunc ) )
    {
        self [[ level.currency[ currencytype ].subfunc ]]( amount );
    }
    else
    {
        function_76906efe4e7c93fc( amount, currencytype );
    }
    
    sparams = spawnstruct();
    sparams.var_65b4e89f87e61c2 = var_65b4e89f87e61c2;
    sparams.currencytype = currencytype;
    sparams.amount = amount;
    sparams.reason = reason;
    sparams.info = info;
    callback::callback( "currency_sub", sparams );
}

// Namespace currency / scripts\cp_mp\currency
// Params 2
// Checksum 0x0, Offset: 0xe94
// Size: 0x59
function function_76906efe4e7c93fc( amount, currencytype )
{
    currencyamount = function_15975e20bbd2c824( currencytype );
    newamount = currencyamount - amount;
    
    if ( amount < 0 && newamount < currencyamount )
    {
        newamount = 2147483647;
    }
    
    if ( newamount < 0 )
    {
        newamount = 0;
    }
    
    function_d0948454b7f94d18( currencytype, newamount );
}

// Namespace currency / scripts\cp_mp\currency
// Params 3
// Checksum 0x0, Offset: 0xef5
// Size: 0xcd
function function_d0948454b7f94d18( currencytype, amount, reason )
{
    var_65b4e89f87e61c2 = amount;
    
    if ( isdefined( self.currency ) && isdefined( currencytype ) && isdefined( self.currency[ currencytype ] ) )
    {
        var_65b4e89f87e61c2 = self.currency[ currencytype ];
    }
    
    var_becfac3d1b3aa3dc = level.currency[ currencytype ].setfunc;
    
    if ( isdefined( var_becfac3d1b3aa3dc ) )
    {
        self [[ var_becfac3d1b3aa3dc ]]( amount );
    }
    else
    {
        function_c6f24e4d5f1dcba( amount, currencytype );
    }
    
    sparams = { #reason:reason, #amount:amount, #currencytype:currencytype, #var_65b4e89f87e61c2:var_65b4e89f87e61c2 };
    callback::callback( "currency_set", sparams );
}

// Namespace currency / scripts\cp_mp\currency
// Params 2
// Checksum 0x0, Offset: 0xfca
// Size: 0x20
function function_c6f24e4d5f1dcba( amount, currencytype )
{
    self.currency[ currencytype ] = amount;
}

// Namespace currency / scripts\cp_mp\currency
// Params 1
// Checksum 0x0, Offset: 0xff2
// Size: 0x47
function function_15975e20bbd2c824( currencytype )
{
    if ( isdefined( level.currency[ currencytype ].getfunc ) )
    {
        return [[ level.currency[ currencytype ].getfunc ]]();
    }
    
    return function_65e84417bc4c405e( currencytype );
}

// Namespace currency / scripts\cp_mp\currency
// Params 1
// Checksum 0x0, Offset: 0x1041
// Size: 0x16
function function_65e84417bc4c405e( currencytype )
{
    return self.currency[ currencytype ];
}

// Namespace currency / scripts\cp_mp\currency
// Params 2
// Checksum 0x0, Offset: 0x1060
// Size: 0x3c
function function_bcc79745d547a99c( currencytype, cost )
{
    var_7965af849f61fa07 = 1;
    var_dfe39d340d15cb99 = function_15975e20bbd2c824( currencytype );
    
    if ( cost > var_dfe39d340d15cb99 )
    {
        var_7965af849f61fa07 = 0;
    }
    
    return var_7965af849f61fa07;
}

// Namespace currency / scripts\cp_mp\currency
// Params 6
// Checksum 0x0, Offset: 0x10a5
// Size: 0x111
function attempt_purchase( currencytype, cost, var_92f8f0879c089e9, var_b138a0b1e1a62a04, reason, info )
{
    if ( function_bcc79745d547a99c( currencytype, cost ) )
    {
        function_a06aa3b8c98e131e( currencytype, cost, reason, info );
        
        if ( isdefined( level.currency[ currencytype ].buysound ) && !istrue( var_92f8f0879c089e9 ) )
        {
            self playsoundtoplayer( level.currency[ currencytype ].buysound, self );
        }
        
        if ( !isdefined( self.pers[ "currency_spent" ] ) )
        {
            self.pers[ "currency_spent" ] = cost;
        }
        else
        {
            self.pers[ "currency_spent" ] = self.pers[ "currency_spent" ] + cost;
        }
        
        return 1;
    }
    
    if ( isdefined( level.currency[ currencytype ].denysound ) && !istrue( var_b138a0b1e1a62a04 ) )
    {
        self playsoundtoplayer( level.currency[ currencytype ].denysound, self );
    }
    
    return 0;
}

// Namespace currency / scripts\cp_mp\currency
// Params 2
// Checksum 0x0, Offset: 0x11be
// Size: 0x2a
function function_fc06aafd52e1707b( currencytype, namestring )
{
    level.currency[ currencytype ].displayname = namestring;
}

// Namespace currency / scripts\cp_mp\currency
// Params 2
// Checksum 0x0, Offset: 0x11f0
// Size: 0x230
function function_d67d3f6e87682c71( var_f246314e1dbaefea, currencytype )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_5454163114cd6502 = newclienthudelem( self );
    var_5454163114cd6502.x = -20;
    var_5454163114cd6502.y = 380 - 15 * var_f246314e1dbaefea;
    var_5454163114cd6502.alignx = "center";
    var_5454163114cd6502.aligny = "top";
    var_5454163114cd6502.vertalign = "fullscreen";
    var_5454163114cd6502.horizalign = "fullscreen";
    var_5454163114cd6502.font = "smallfixed";
    var_5454163114cd6502.fontscale = 0.75;
    var_6dfa383229c11ead = newclienthudelem( self );
    var_6dfa383229c11ead.x = 60;
    var_6dfa383229c11ead.y = 380 - 15 * var_f246314e1dbaefea;
    var_6dfa383229c11ead.alignx = "center";
    var_6dfa383229c11ead.aligny = "top";
    var_6dfa383229c11ead.vertalign = "fullscreen";
    var_6dfa383229c11ead.horizalign = "fullscreen";
    var_6dfa383229c11ead.font = "smallfixed";
    var_6dfa383229c11ead.fontscale = 0.75;
    
    while ( true )
    {
        if ( currencytype == "essence" )
        {
            var_5454163114cd6502 settext( &"SHARED_HINTSTRINGS/CURRENCY_HUDELEM_ESSENCE" );
            var_6dfa383229c11ead setvalue( self.currency[ "essence" ] );
        }
        else if ( currencytype == "salvage" )
        {
            var_5454163114cd6502 settext( &"SHARED_HINTSTRINGS/CURRENCY_HUDELEM_SALVAGE" );
            var_6dfa383229c11ead setvalue( self.currency[ "salvage" ] );
        }
        else if ( currencytype == "rare_salvage" )
        {
            var_5454163114cd6502 settext( &"SHARED_HINTSTRINGS/CURRENCY_HUDELEM_RARE_SALVAGE" );
            var_6dfa383229c11ead setvalue( self.currency[ "rare_salvage" ] );
        }
        else if ( isdefined( level.currency[ currencytype ].displayname ) )
        {
            var_5454163114cd6502 settext( level.currency[ currencytype ].displayname );
            var_6dfa383229c11ead setvalue( self.currency[ currencytype ] );
        }
        
        waitframe();
    }
}

/#

    // Namespace currency / scripts\cp_mp\currency
    // Params 1
    // Checksum 0x0, Offset: 0x1428
    // Size: 0x3c, Type: dev
    function function_2e0cc380e14c340b( currency_type )
    {
        scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x207>" );
        scripts\common\devgui::function_b23a59dfb4ca49a1( "<dev string:x21a>" + currency_type, "<dev string:x227>" + currency_type, &function_382bfcbb2e043576, 0 );
        scripts\common\devgui::function_fe953f000498048f();
    }

    // Namespace currency / scripts\cp_mp\currency
    // Params 1
    // Checksum 0x0, Offset: 0x146c
    // Size: 0x92, Type: dev
    function function_382bfcbb2e043576( params )
    {
        currency_type = params[ 0 ];
        
        foreach ( player in level.players )
        {
            if ( isdefined( level.currency[ currency_type ] ) )
            {
                player function_3036cef61495210f( currency_type, 10000 );
                continue;
            }
            
            iprintln( currency_type + "<dev string:x23d>" );
        }
    }

#/
