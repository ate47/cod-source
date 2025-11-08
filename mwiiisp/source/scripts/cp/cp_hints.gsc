#using scripts\common\utility;
#using scripts\cp\cp_hud_message;
#using scripts\cp\utility;
#using scripts\cp_mp\armor;
#using scripts\engine\utility;

#namespace cp_hints;

// Namespace cp_hints / scripts\cp\cp_hints
// Params 2
// Checksum 0x0, Offset: 0x187
// Size: 0x2a
function function_53d7dda215345e9a( struct, func )
{
    if ( !isdefined( func ) )
    {
        struct thread function_5d7a5d368329104b();
        return;
    }
    
    struct thread [[ func ]]();
}

// Namespace cp_hints / scripts\cp\cp_hints
// Params 0
// Checksum 0x0, Offset: 0x1b9
// Size: 0xfb
function function_5d7a5d368329104b()
{
    while ( !isdefined( level.players ) || level.players.size == 0 )
    {
        wait 1;
    }
    
    dist_check = squared( self.radius );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( istrue( player.var_2825b40bc5d1ee90 ) )
            {
                continue;
            }
            
            if ( istrue( player.var_4d572a54ed8571c4 ) )
            {
                continue;
            }
            
            if ( distancesquared( player.origin, self.origin ) < dist_check )
            {
                if ( !player isnightvisionon() && !isdefined( player.var_b048ad4fdb04dd40 ) )
                {
                    player thread show_nvg_hint();
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace cp_hints / scripts\cp\cp_hints
// Params 0
// Checksum 0x0, Offset: 0x2bc
// Size: 0x8e
function show_third_person_hint()
{
    self endon( "disconnect" );
    self notify( "show_third_person_hint" );
    self endon( "show_third_person_hint" );
    self.var_59be4f978f28ae72 = 1;
    
    if ( self usinggamepad() )
    {
        self sethudtutorialmessage( &"COOP_GAME_PLAY/THIRD_PERSON_HINT", 1 );
    }
    else
    {
        self sethudtutorialmessage( &"COOP_GAME_PLAY/THIRD_PERSON_HINT_PC", 1 );
    }
    
    for ( time = 1; time < 7 && !self getcamerathirdperson() ; time++ )
    {
        wait 1;
    }
    
    self clearhudtutorialmessage();
    self.var_59be4f978f28ae72 = undefined;
    self.var_4a92fa61d642bc3c = 1;
}

// Namespace cp_hints / scripts\cp\cp_hints
// Params 0
// Checksum 0x0, Offset: 0x352
// Size: 0x8e
function show_nvg_hint()
{
    self endon( "disconnect" );
    self notify( "show_nvg_hint" );
    self endon( "show_nvg_hint" );
    self.var_b048ad4fdb04dd40 = 1;
    
    if ( self usinggamepad() )
    {
        self sethudtutorialmessage( &"COOP_GAME_PLAY/NVGS_HINT_GAMEPLAY", 1 );
    }
    else
    {
        self sethudtutorialmessage( &"COOP_GAME_PLAY/NVGS_HINT_GAMEPLAY", 1 );
    }
    
    for ( time = 1; time < 7 && !self isnightvisionon() ; time++ )
    {
        wait 1;
    }
    
    self clearhudtutorialmessage();
    self.var_b048ad4fdb04dd40 = undefined;
    self.var_2825b40bc5d1ee90 = 1;
}

// Namespace cp_hints / scripts\cp\cp_hints
// Params 0
// Checksum 0x0, Offset: 0x3e8
// Size: 0x82
function function_5f69c771abbec7b8()
{
    self endon( "disconnect" );
    self notify( "turn_nvgsOnOffDependingOnLight" );
    self endon( "turn_nvgsOnOffDependingOnLight" );
    
    while ( !isdefined( self.operatorcustomization ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        if ( self getplayerlightlevel() >= 0.15 || self isnightvisionon() )
        {
            wait 1;
            continue;
        }
        else
        {
            wait 2;
            
            if ( self getplayerlightlevel() >= 0.15 || self isnightvisionon() )
            {
                continue;
            }
            else
            {
                show_nvg_hint();
            }
        }
        
        wait 0.25;
    }
}

// Namespace cp_hints / scripts\cp\cp_hints
// Params 0
// Checksum 0x0, Offset: 0x472
// Size: 0x83
function nag_usearmor_handler()
{
    self notify( "nag_useArmor_handler" );
    self endon( "nag_useArmor_handler" );
    self endon( "disconnect" );
    var_1cd29382d1867470 = -1;
    var_d96be5d83de1f615 = 0;
    delay = 30;
    
    while ( true )
    {
        wait delay;
        
        if ( istrue( self.inlaststand ) )
        {
            continue;
        }
        
        var_1cd29382d1867470 = scripts\cp_mp\armor::function_600f6cf462e983f();
        
        if ( !scripts\cp_mp\armor::hasarmor() && var_1cd29382d1867470 > 0 && var_1cd29382d1867470 == var_d96be5d83de1f615 )
        {
            thread function_4da770fc0303e7cd();
        }
        
        var_d96be5d83de1f615 = var_1cd29382d1867470;
    }
}

// Namespace cp_hints / scripts\cp\cp_hints
// Params 0
// Checksum 0x0, Offset: 0x4fd
// Size: 0x72
function function_4da770fc0303e7cd()
{
    if ( isdefined( self.var_d4850c224fa2c6ad ) )
    {
        timesincelast = gettime() - self.var_d4850c224fa2c6ad;
    }
    else
    {
        timesincelast = 1000;
    }
    
    str = &"EQUIPMENT_HINTS/ARMOR_USE_HINT";
    sound = "text_box_new";
    self playlocalsound( sound );
    thread scripts\cp\cp_hud_message::tutorialprint( str, 20 );
    self.var_d4850c224fa2c6ad = gettime();
}

