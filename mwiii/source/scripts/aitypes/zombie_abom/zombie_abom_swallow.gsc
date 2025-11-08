#using script_7edf952f8921aa6b;
#using scripts\aitypes\zombie_abom\zombie_abom_heads;
#using scripts\aitypes\zombie_abom\zombie_abom_metabones;
#using scripts\asm\asm;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\utility;

#namespace zombie_abom_swallow;

// Namespace zombie_abom_swallow / scripts\aitypes\zombie_abom\zombie_abom_swallow
// Params 0
// Checksum 0x0, Offset: 0x1da
// Size: 0x22
function function_e21b71f0f396bb06()
{
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_3b8499d83d52380e );
}

// Namespace zombie_abom_swallow / scripts\aitypes\zombie_abom\zombie_abom_swallow
// Params 0
// Checksum 0x0, Offset: 0x204
// Size: 0x22
function function_688e6bf6742914c0()
{
    function_b5e57408c7878df7( &function_fc8dd3d00ebca77b );
    self.var_ebd8439d96ec5a19 = 0;
    
    /#
        function_14b998b3a980d6fe();
    #/
}

// Namespace zombie_abom_swallow / scripts\aitypes\zombie_abom\zombie_abom_swallow
// Params 0
// Checksum 0x0, Offset: 0x22e
// Size: 0x41, Type: bool
function function_f042d86bacba063b()
{
    if ( isdefined( self.var_ebd8439d96ec5a19 ) )
    {
        var_179bf7d9d8c893b1 = gettime() - self.var_ebd8439d96ec5a19;
        swallow_cooldown = 5000;
        
        if ( var_179bf7d9d8c893b1 < swallow_cooldown )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_abom_swallow / scripts\aitypes\zombie_abom\zombie_abom_swallow
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x278
// Size: 0x13
function private function_3b8499d83d52380e( dmg_struct )
{
    function_f9f0c202070afb63( dmg_struct );
}

// Namespace zombie_abom_swallow / scripts\aitypes\zombie_abom\zombie_abom_swallow
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x293
// Size: 0x10c
function private function_f9f0c202070afb63( dmg_struct )
{
    meansofdeath = dmg_struct.smeansofdeath;
    
    if ( meansofdeath != "MOD_IMPACT" )
    {
        return;
    }
    
    weapon_obj = dmg_struct.sweapon;
    
    if ( !isdefined( weapon_obj ) || weapon_obj.classname != "grenade" )
    {
        /#
            swallow_print( "<dev string:x1c>" );
        #/
        
        return;
    }
    
    metabone_hit = dmg_struct.metabonename;
    
    if ( !isdefined( metabone_hit ) )
    {
        /#
            swallow_print( "<dev string:x2d>" );
        #/
        
        return;
    }
    
    head_index = scripts\aitypes\zombie_abom\zombie_abom_metabones::function_e5db29e6fd6f6a88( metabone_hit );
    
    if ( !isdefined( head_index ) )
    {
        /#
            swallow_print( "<dev string:x40>" + metabone_hit );
        #/
        
        return;
    }
    
    head_state = scripts\aitypes\zombie_abom\zombie_abom_heads::function_2945ff43fceb0fc8( self, head_index );
    
    if ( head_state != 2 )
    {
        /#
            swallow_print( "<dev string:x5b>" + head_state );
        #/
        
        return;
    }
    
    if ( function_f042d86bacba063b() )
    {
        /#
            swallow_print( "<dev string:x78>" );
        #/
        
        return;
    }
    
    abom_swallow( dmg_struct, head_index );
}

// Namespace zombie_abom_swallow / scripts\aitypes\zombie_abom\zombie_abom_swallow
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x3a7
// Size: 0x175
function private abom_swallow( dmg_struct, head_index )
{
    grenade = dmg_struct.einflictor;
    
    if ( !isdefined( grenade ) )
    {
        /#
            swallow_print( "<dev string:x9a>" );
        #/
        
        return;
    }
    
    assert( isdefined( head_index ) );
    self.var_ebd8439d96ec5a19 = gettime();
    var_8fa538a1d4db452c = "swallow_in";
    
    if ( isdefined( grenade.equipmentref ) )
    {
        if ( grenade.equipmentref == "equip_monkey_bomb" )
        {
            self setscriptablepartstate( "audio_monkeybomb_swallow", "on" );
        }
    }
    
    scripts\asm\asm::asm_setstate( var_8fa538a1d4db452c );
    tag = "j_" + level.var_28e4ea2998e3439b[ head_index ];
    grenade linkto( self, tag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    grenade ent_flag_set( "abom_swallowed" );
    grenade.var_59d004d14d13b52b = head_index;
    grenade notify( "missile_stuck" );
    self.var_739e0470ae2ed359 = spawnstruct();
    self.var_739e0470ae2ed359.head_index = head_index;
    self.var_739e0470ae2ed359.eattacker = dmg_struct.eattacker;
    self.var_739e0470ae2ed359.time = gettime();
    wait 2;
    
    if ( isdefined( self ) && isdefined( grenade ) )
    {
        grenade notify( "detonateExplosive", self );
    }
}

// Namespace zombie_abom_swallow / scripts\aitypes\zombie_abom\zombie_abom_swallow
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x524
// Size: 0x355
function private function_fc8dd3d00ebca77b( dmg_struct )
{
    metabone_name = undefined;
    
    if ( isdefined( dmg_struct.einflictor ) )
    {
        if ( !isdefined( dmg_struct.einflictor.var_59d004d14d13b52b ) || !dmg_struct.einflictor ent_flag( "abom_swallowed" ) )
        {
            return -1;
        }
        
        /#
            swallow_print( "<dev string:xbf>" );
        #/
        
        metabone_name = level.var_28e4ea2998e3439b[ dmg_struct.einflictor.var_59d004d14d13b52b ];
    }
    else
    {
        if ( !isdefined( self.var_739e0470ae2ed359 ) )
        {
            return -1;
        }
        
        var_179bf7d9d8c893b1 = gettime() - self.var_739e0470ae2ed359.time;
        
        if ( var_179bf7d9d8c893b1 > 3500 )
        {
            /#
                swallow_print( "<dev string:xe8>" + var_179bf7d9d8c893b1 );
            #/
            
            self.var_739e0470ae2ed359 = undefined;
            return -1;
        }
        
        if ( self.var_739e0470ae2ed359.eattacker != dmg_struct.eattacker || dmg_struct.sweapon.classname != "grenade" || dmg_struct.smeansofdeath != "MOD_GRENADE_SPLASH" && dmg_struct.smeansofdeath != "MOD_EXPLOSIVE" )
        {
            /#
                if ( self.var_739e0470ae2ed359.eattacker != dmg_struct.eattacker )
                {
                    swallow_print( "<dev string:x101>" );
                }
                else
                {
                    swallow_print( "<dev string:x12f>" + dmg_struct.sweapon.classname + "<dev string:x150>" + dmg_struct.smeansofdeath );
                }
            #/
            
            return -1;
        }
        
        metabone_name = level.var_28e4ea2998e3439b[ self.var_739e0470ae2ed359.head_index ];
        
        if ( !isdefined( dmg_struct.metabonename ) || dmg_struct.metabonename != metabone_name )
        {
            tag = "j_" + metabone_name;
            TAG_ORIGIN = self gettagorigin( tag );
            var_35391e999d5450b1 = lengthsquared( TAG_ORIGIN - dmg_struct.vpoint );
            
            if ( var_35391e999d5450b1 > 100 )
            {
                /#
                    swallow_print( "<dev string:x15a>" + metabone_name + "<dev string:x187>" + sqrt( var_35391e999d5450b1 ) );
                #/
                
                return -1;
            }
        }
    }
    
    self.var_739e0470ae2ed359 = undefined;
    
    if ( !isdefined( metabone_name ) )
    {
        return -1;
    }
    
    increased_damage = dmg_struct.idamage * 20;
    head_health = function_8c1f2f897dfe5982( metabone_name, "open" );
    
    if ( head_health <= 0 )
    {
        return -1;
    }
    
    new_damage = max( increased_damage, dmg_struct.idamage );
    new_damage = min( new_damage, head_health );
    dmg_struct.damagemaxhealthcap = max( dmg_struct.damagemaxhealthcap, 1 );
    dmg_struct.biscritical = 1;
    function_dfd6d030978a7650( metabone_name, new_damage, "open", dmg_struct.eattacker, dmg_struct.einflictor );
    params = spawnstruct();
    params.incomingdamage = new_damage;
    callback::callback( "abomination_swallow_grenade" );
    return new_damage;
}

/#

    // Namespace zombie_abom_swallow / scripts\aitypes\zombie_abom\zombie_abom_swallow
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x882
    // Size: 0x2e, Type: dev
    function private function_14b998b3a980d6fe()
    {
        function_6e7290c8ee4f558b( "<dev string:x192>" );
        function_a9a864379a098ad6( "<dev string:x1b2>", "<dev string:x1c3>", &function_dce8d747fc906ca1 );
        function_fe953f000498048f();
    }

    // Namespace zombie_abom_swallow / scripts\aitypes\zombie_abom\zombie_abom_swallow
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x8b8
    // Size: 0x1a, Type: dev
    function private function_dce8d747fc906ca1()
    {
        function_2fb888667001fc39( "<dev string:x1c3>", @"hash_e6612e812211addd" );
    }

    // Namespace zombie_abom_swallow / scripts\aitypes\zombie_abom\zombie_abom_swallow
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x8da
    // Size: 0x17, Type: dev
    function private debug_swallow()
    {
        return getdvarint( @"hash_e6612e812211addd", 0 ) > 0;
    }

    // Namespace zombie_abom_swallow / scripts\aitypes\zombie_abom\zombie_abom_swallow
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0x8f9
    // Size: 0x5a, Type: dev
    function private swallow_print( text, pos )
    {
        if ( debug_swallow() )
        {
            pos = default_to( pos, self.origin + ( 0, 0, 70 ) );
            print3d( pos, "<dev string:x1d9>" + text, ( 1, 0, 0 ) );
        }
    }

#/
