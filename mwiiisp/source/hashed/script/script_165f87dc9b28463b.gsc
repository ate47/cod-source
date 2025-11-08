#using scripts\common\utility;
#using scripts\cp\loadout;
#using scripts\cp\utility\player;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\operator;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;

#namespace namespace_f0ed5d732ece344b;

// Namespace namespace_f0ed5d732ece344b / namespace_8806fd8068aa0a0b
// Params 0
// Checksum 0x0, Offset: 0x118
// Size: 0x17
function function_1f763dfecfc35564()
{
    function_bf63fad4c7dc4e9f();
    level.post_customization_func = &function_c682e1f5eb7f451e;
}

// Namespace namespace_f0ed5d732ece344b / namespace_8806fd8068aa0a0b
// Params 0
// Checksum 0x0, Offset: 0x137
// Size: 0x5a
function function_bf63fad4c7dc4e9f()
{
    level.operator_indices = [];
    level.operator_indices[ level.operator_indices.size ] = "price_western_a";
    level.operator_indices[ level.operator_indices.size ] = "t10_usa_mogadishu_a";
    level.operator_indices[ level.operator_indices.size ] = "bravos_sas_d_western_basic";
}

// Namespace namespace_f0ed5d732ece344b / namespace_8806fd8068aa0a0b
// Params 0
// Checksum 0x0, Offset: 0x199
// Size: 0x7d
function function_c682e1f5eb7f451e()
{
    if ( isdefined( self.operatorcustomization ) && isdefined( self.operatorcustomization.execution ) )
    {
        scripts\cp_mp\execution::_giveexecution( self.operatorcustomization.execution );
        random_index = random( level.operator_indices );
        level.operator_indices = array_remove( level.operator_indices, random_index );
        function_51cef08d1c77da29( self, random_index );
    }
}

// Namespace namespace_f0ed5d732ece344b / namespace_8806fd8068aa0a0b
// Params 2
// Checksum 0x0, Offset: 0x21e
// Size: 0x245
function function_51cef08d1c77da29( player, skin )
{
    player.operatorcustomization.skinref = skin;
    body = scripts\cp_mp\operator::function_8eba78e65f4be793( skin );
    head = scripts\cp_mp\operator::function_223061772e2a61b9( skin );
    operator = scripts\cp_mp\operator::function_605079124463a67b( skin );
    suit = scripts\cp\loadout::function_ada9a2308a4046e2( operator );
    player.operatorcustomization.suit = suit;
    
    if ( body == "" || head == "" )
    {
        return;
    }
    
    viewmodelname = scripts\cp\loadout::getplayerviewmodelfrombody( body );
    player setcustomization( body, head );
    bodymodelname = player getcustomizationbody();
    headmodelname = player getcustomizationhead();
    viewmodelname = player getcustomizationviewmodel();
    
    if ( player.operatorcustomization.suit == "iw9_defaultsuit_mp" )
    {
        player.operatorcustomization.suit = "iw9_suit_cp";
    }
    
    player scripts\cp\utility\player::_setsuit( player.operatorcustomization.suit );
    player function_d114326cac6bada8( bodymodelname, headmodelname, viewmodelname );
    var_e89fd4c2e2e797b9 = player scripts\cp\loadout::getplayerfoleytype( skin );
    
    if ( var_e89fd4c2e2e797b9 == "" )
    {
        var_e89fd4c2e2e797b9 = "vestlight";
    }
    
    player setclothtype( getxhash( var_e89fd4c2e2e797b9 ) );
    
    if ( player.operatorcustomization.gender == "female" )
    {
        player function_555e2d32e2756625( "female" );
    }
    
    player.operatorcustomization.voice = scripts\cp\loadout::getoperatorvoice( operator );
    player.operatorcustomization.clothtype = scripts\cp\loadout::getoperatorclothtype( skin );
    player.operatorcustomization.superfaction = scripts\cp\loadout::getoperatorsuperfaction( operator );
    player.operatorcustomization.execution = scripts\cp\loadout::getoperatorexecution( operator );
    player.operatorcustomization.executionquip = scripts\cp\loadout::getoperatorexecutionquip( operator );
}

// Namespace namespace_f0ed5d732ece344b / namespace_8806fd8068aa0a0b
// Params 3
// Checksum 0x0, Offset: 0x46b
// Size: 0x87
function function_d114326cac6bada8( bodymodelname, headmodelname, viewmodelname )
{
    if ( isdefined( self.headmodel ) )
    {
        self detach( self.headmodel );
    }
    
    if ( !isagent( self ) )
    {
        bodymodelname = self getcustomizationbody();
        headmodelname = self getcustomizationhead();
        viewmodelname = self getcustomizationviewmodel();
    }
    
    self setmodel( bodymodelname );
    self setviewmodel( viewmodelname );
    
    if ( isdefined( headmodelname ) )
    {
        self attach( headmodelname, "", 1 );
        self.headmodel = headmodelname;
    }
}

