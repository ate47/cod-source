#using scripts\anim\init;
#using scripts\anim\utility;
#using scripts\common\ai;
#using scripts\common\debug_graycard;
#using scripts\common\debug_reflection;
#using scripts\common\dof;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\sp\utility_code;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\colors;
#using scripts\sp\debug_spawnai;
#using scripts\sp\nvg\nvg_ai;
#using scripts\sp\utility;

#namespace debug;

/#

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x551
    // Size: 0x12e, Type: dev
    function maindebug()
    {
        setdvarifuninitialized( @"scr_debug", "<dev string:x1c>" );
        setdvarifuninitialized( @"hash_e88f0c15c278fb42", "<dev string:x1c>" );
        setdvarifuninitialized( @"hash_8496c6305e4b772", "<dev string:x1e>" );
        setdvarifuninitialized( @"hash_bdb86700db7d369e", "<dev string:x1c>" );
        setdvarifuninitialized( @"hash_c5a7cfaf6b0c9ac0", "<dev string:x1c>" );
        setdvarifuninitialized( @"hash_8beca11d7b55550e", 0 );
        
        if ( getdvarint( @"hash_a838875af4383ca1", 0 ) != 0 )
        {
            thread function_b1883f511d0dbba4();
        }
        
        if ( !isdefined( level.debug ) )
        {
            level.debug = spawnstruct();
        }
        
        create_func_ref( "<dev string:x20>", &draw_spawner );
        level.animsound_hudlimit = 14;
        thread lastsightposwatch();
        thread camera();
        setdvarifuninitialized( @"debug_corner", "<dev string:x2d>" );
        
        if ( getdvar( @"debug_corner" ) == "<dev string:x31>" )
        {
            debug_corner();
        }
        
        thread debugdvars();
        thread debugcolorfriendlies();
        thread scripts\common\dof::function_9030ff462f3daa1a();
        thread debugentityarray();
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x687
    // Size: 0xd, Type: dev
    function maindebugpostload()
    {
        thread debug_magic();
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x69c
    // Size: 0x1a0, Type: dev
    function debugentityarray()
    {
        wait 2;
        
        if ( getdvarint( @"hash_687bd77ca12d535c" ) != 0 )
        {
            entarray = getentarray();
            level.debug.script_origins = [];
            level.debug.script_models = [];
            level.debug.script_brushmodels = [];
            level.debug.trigger_multiple = [];
            
            foreach ( ent in entarray )
            {
                waitframe();
                
                if ( !isdefined( ent ) || !isdefined( ent.classname ) )
                {
                    continue;
                }
                
                if ( ent.classname == "<dev string:x34>" )
                {
                    level.debug.script_origins[ level.debug.script_origins.size ] = ent;
                    continue;
                }
                
                if ( ent.classname == "<dev string:x42>" )
                {
                    level.debug.script_models[ level.debug.script_models.size ] = ent;
                    continue;
                }
                
                if ( ent.classname == "<dev string:x4f>" )
                {
                    level.debug.script_brushmodels[ level.debug.script_brushmodels.size ] = ent;
                    continue;
                }
            }
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x844
    // Size: 0xa1, Type: dev
    function function_19592e71d7ad36e3()
    {
        while ( true )
        {
            if ( !getdvarint( @"hash_5bed111185579616" ) )
            {
                return;
            }
            
            num = 0;
            
            foreach ( m in getentarray( "<dev string:x42>", "<dev string:x61>" ) )
            {
                if ( m.model == "<dev string:x6b>" )
                {
                    num++;
                }
            }
            
            iprintln( num + "<dev string:x76>" );
            wait 1;
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x8ed
    // Size: 0x7c, Type: dev
    function function_aa98966edb7904e8()
    {
        array = [];
        
        foreach ( ent in getentarray( "<dev string:x42>", "<dev string:x61>" ) )
        {
            if ( ent.model == "<dev string:x6b>" )
            {
                array[ array.size ] = ent;
            }
        }
        
        return array;
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x971
    // Size: 0x160, Type: dev
    function function_615fd51c4e0fed90()
    {
        array = function_aa98966edb7904e8();
        println( "<dev string:x89>" );
        println( "<dev string:x9b>" );
        filtered_array = [];
        
        foreach ( ent in array )
        {
            if ( isdefined( ent.debugstring ) )
            {
                if ( !isdefined( filtered_array[ ent.debugstring ] ) )
                {
                    filtered_array[ ent.debugstring ] = 1;
                }
                else
                {
                    filtered_array[ ent.debugstring ]++;
                }
                
                continue;
            }
            
            if ( !isdefined( filtered_array[ "<dev string:xc1>" ] ) )
            {
                filtered_array[ "<dev string:xc1>" ] = 1;
                continue;
            }
            
            filtered_array[ "<dev string:xc1>" ]++;
        }
        
        foreach ( count in filtered_array )
        {
            println( key + "<dev string:xc9>" + count );
        }
        
        println( "<dev string:xcc>" + array.size );
        println( "<dev string:x9b>" );
        array = undefined;
        setdvar( @"hash_1427b6dfc4e0eaad", "<dev string:x1c>" );
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0xad9
    // Size: 0xd0, Type: dev
    function entity_count()
    {
        setdvar( @"hash_bc81c5010a46eadf", "<dev string:x1c>" );
        array = get_entity_count_list();
        println( "<dev string:xd4>" );
        println( "<dev string:xe1>" );
        total = 0;
        
        foreach ( item in array )
        {
            println( i + "<dev string:xc9>" + item );
            total += item;
        }
        
        println( "<dev string:xcc>" + total );
        println( "<dev string:xe1>" );
        array = undefined;
        setdvar( @"hash_bc81c5010a46eadf", "<dev string:x1c>" );
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0xbb1
    // Size: 0x46e, Type: dev
    function entity_count_hud()
    {
        if ( isdefined( level.debug.var_f640aaf21f027eaf ) )
        {
            return;
        }
        
        level.debug.var_f640aaf21f027eaf = [];
        level.debug.var_410d4e40656b5e26 = 20;
        hudcount = level.debug.var_f640aaf21f027eaf.size;
        totalhud = newhudelem();
        totalhud.x = 20;
        totalhud.fontscale = 0.4;
        totalhud.foreground = 1;
        totalhud.sort = 5;
        totalhud.label = "<dev string:x105>";
        totalhud.font = "<dev string:x10e>";
        totalhud.horzalign = "<dev string:x117>";
        dobjhud = newhudelem();
        dobjhud.x = 20;
        dobjhud.fontscale = 0.4;
        dobjhud.foreground = 1;
        dobjhud.sort = 5;
        dobjhud.label = "<dev string:x11c>";
        dobjhud.horzalign = "<dev string:x117>";
        dobjhud.font = "<dev string:x10e>";
        
        while ( getunarchiveddebugdvar( @"hash_e88f0c15c278fb42" ) != "<dev string:x1c>" )
        {
            array = get_entity_count_list( 1, 1 );
            
            if ( level.debug.var_f640aaf21f027eaf.size > hudcount )
            {
                adjust_entcounthud_pos();
                hudcount = level.debug.var_f640aaf21f027eaf.size;
            }
            
            remaining = getarraykeys( level.debug.var_f640aaf21f027eaf );
            num = 0;
            total = 0;
            
            foreach ( key, item in array )
            {
                foreach ( k in remaining )
                {
                    if ( k == key )
                    {
                        remaining = array_remove( remaining, k );
                    }
                }
                
                set_entity_count_hud( num, key, item );
                total += item;
                num++;
            }
            
            foreach ( key in remaining )
            {
                hud = level.debug.var_f640aaf21f027eaf[ key ];
                hud adjust_entity_count_hud_color( 0 );
                hud setvalue( 0 );
                hud.prevvalue = 0;
                
                if ( getunarchiveddebugdvar( @"hash_e88f0c15c278fb42" ) == "<dev string:x125>" )
                {
                    entity_count_delta( hud, 0 );
                }
            }
            
            totalhud.y = level.debug.var_410d4e40656b5e26 + 7;
            totalhud.color = get_total_count_color( total );
            totalhud setvalue( total );
            dobjhud.y = totalhud.y + 7;
            dobjhud.color = get_total_count_color( getdobjcount() );
            dobjhud setvalue( getdobjcount() );
            wait 0.05;
        }
        
        foreach ( hud in level.debug.var_f640aaf21f027eaf )
        {
            if ( isdefined( hud.avghud ) )
            {
                hud.avghud destroy();
            }
            
            hud destroy();
        }
        
        level.debug.var_f640aaf21f027eaf = undefined;
        level.debug.var_410d4e40656b5e26 = undefined;
        totalhud destroy();
    }

    // Namespace debug / scripts\sp\debug
    // Params 1
    // Checksum 0x0, Offset: 0x1027
    // Size: 0xa7, Type: dev
    function get_total_count_color( total )
    {
        if ( total <= 1500 )
        {
            color = ( 0, 0.8, 0 );
        }
        else if ( total <= 1700 )
        {
            color = ( 0, 0.8, 0 ) + ( ( 0.8, 0.8, 0 ) - ( 0, 0.8, 0 ) ) * ( total - 1500 ) / 200;
        }
        else
        {
            color = ( 0.8, 0.8, 0 ) + ( ( 0.8, 0, 0 ) - ( 0.8, 0.8, 0 ) ) * ( total - 1700 ) / 348;
        }
        
        return color;
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x10d6
    // Size: 0xd8, Type: dev
    function adjust_entcounthud_pos()
    {
        level.debug.var_f640aaf21f027eaf = sort_by_key( level.debug.var_f640aaf21f027eaf );
        num = 1;
        
        foreach ( hud in level.debug.var_f640aaf21f027eaf )
        {
            hud.y = 20 + num * 7;
            num++;
            
            if ( isdefined( hud.avghud ) )
            {
                hud.avghud.y = hud.y;
            }
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 3
    // Checksum 0x0, Offset: 0x11b6
    // Size: 0x1a4, Type: dev
    function set_entity_count_hud( num, key, val )
    {
        if ( !isdefined( level.debug.var_f640aaf21f027eaf[ key ] ) )
        {
            hud = newhudelem();
            hud.x = 20;
            hud.y = level.debug.var_410d4e40656b5e26 + 7;
            level.debug.var_410d4e40656b5e26 = hud.y;
            hud.fontscale = 0.4;
            hud.foreground = 1;
            hud.sort = 5;
            hud.label = key + "<dev string:x127>";
            hud.labeltext = key;
            hud.font = "<dev string:x10e>";
            hud.prevvalue = 0;
            hud.horzalign = "<dev string:x117>";
            level.debug.var_f640aaf21f027eaf[ key ] = hud;
        }
        else
        {
            hud = level.debug.var_f640aaf21f027eaf[ key ];
        }
        
        if ( getunarchiveddebugdvar( @"hash_e88f0c15c278fb42" ) == "<dev string:x125>" )
        {
            entity_count_delta( hud, val );
        }
        else if ( isdefined( hud.avghud ) )
        {
            hud.avghud destroy();
        }
        
        hud adjust_entity_count_hud_color( val );
        hud setvalue( val );
        hud.prevvalue = val;
    }

    // Namespace debug / scripts\sp\debug
    // Params 2
    // Checksum 0x0, Offset: 0x1362
    // Size: 0x171, Type: dev
    function entity_count_delta( parenthud, val )
    {
        if ( !isdefined( parenthud.avghud ) )
        {
            parenthud.avghud = newhudelem();
            parenthud.avghud.x = parenthud.x + -2;
            parenthud.avghud.y = parenthud.y;
            parenthud.avghud.fontscale = 0.4;
            parenthud.avghud.foreground = 1;
            parenthud.avghud.alignx = "<dev string:x12b>";
            parenthud.avghud.sort = 5;
            parenthud.avghud.font = "<dev string:x10e>";
            parenthud.avghud.time = gettime();
            parenthud.avghud.prevvalue = val;
        }
        
        parenthud.avghud.time = gettime();
        parenthud.avghud setvalue( val - parenthud.avghud.prevvalue );
    }

    // Namespace debug / scripts\sp\debug
    // Params 1
    // Checksum 0x0, Offset: 0x14db
    // Size: 0xc0, Type: dev
    function adjust_entity_count_hud_color( val )
    {
        if ( val > self.prevvalue )
        {
            self.color = ( 0.8, 0, 0 );
            return;
        }
        
        if ( val < self.prevvalue )
        {
            self.color = ( 0, 0.8, 0 );
            return;
        }
        
        color_diff = ( 1, 1, 1 ) - self.color;
        
        if ( length( color_diff ) > 0.346 )
        {
            self.color += color_diff * 0.05;
            return;
        }
        
        self.color = ( 1, 1, 1 );
    }

#/

// Namespace debug / scripts\sp\debug
// Params 2
// Checksum 0x0, Offset: 0x15a3
// Size: 0x259
function get_entity_count_list( dogrouping, skipsort )
{
    ents = getentarray();
    array = [];
    
    if ( !isdefined( dogrouping ) )
    {
        dogrouping = 0;
    }
    
    foreach ( ent in ents )
    {
        if ( !isdefined( ent.classname ) )
        {
            classname = "UNKNOWN?";
        }
        else
        {
            classname = ent.classname;
        }
        
        if ( dogrouping )
        {
            if ( isai( ent ) )
            {
                classname = "actors";
            }
            else if ( isspawner( ent ) )
            {
                prefix = getsubstr( classname, 0, 5 );
                
                if ( prefix == "actor" )
                {
                    classname = "AI_spawners";
                }
                else
                {
                    classname = "vehicle_spawners";
                }
            }
            else if ( isdefined( ent.createfx_ent ) )
            {
                classname = ent.classname + " CREATEFX";
            }
            else if ( !isdefined( ent.code_classname ) )
            {
            }
            else if ( ent.code_classname == "script_model" )
            {
                if ( ent.model == "tag_origin" )
                {
                    classname = "script_model TAG_ORIGIN";
                }
            }
            else if ( ent.code_classname == "trigger_multiple" )
            {
                prefix = getsubstr( classname, 0, 22 );
                
                if ( prefix == "trigger_multiple_bcs_" )
                {
                    classname = "trigger_multiple_bcs";
                }
                else
                {
                    classname = "trigger_multiple";
                }
            }
            else
            {
                prefix = getsubstr( ent.code_classname, 0, 10 );
                
                if ( prefix == "weapon_iw8" )
                {
                    classname = "weapons";
                }
                
                prefix = getsubstr( ent.code_classname, 0, 5 );
                
                if ( prefix == "actor" )
                {
                    classname = "drones";
                }
            }
        }
        else
        {
            if ( isdefined( ent.createfx_ent ) )
            {
                classname = "CREATEFX " + ent.classname;
            }
            
            if ( classname == "script_model" )
            {
                classname += " " + ent.model;
            }
        }
        
        if ( !isdefined( array[ classname ] ) )
        {
            array[ classname ] = 0;
        }
        
        array[ classname ]++;
    }
    
    if ( !isdefined( skipsort ) || !skipsort )
    {
        array = sort_by_key( array );
    }
    
    return array;
}

// Namespace debug / scripts\sp\debug
// Params 1
// Checksum 0x0, Offset: 0x1805
// Size: 0xa6
function sort_by_key( array )
{
    keys = getarraykeys( array );
    
    for ( i = 0; i < keys.size - 1 ; i++ )
    {
        for ( j = i + 1; j < keys.size ; j++ )
        {
            if ( stricmp( keys[ i ], keys[ j ] ) > 0 )
            {
                ref = keys[ j ];
                keys[ j ] = keys[ i ];
                keys[ i ] = ref;
            }
        }
    }
    
    new_array = [];
    
    for ( i = 0; i < keys.size ; i++ )
    {
        new_array[ keys[ i ] ] = array[ keys[ i ] ];
    }
    
    return new_array;
}

// Namespace debug / scripts\sp\debug
// Params 1
// Checksum 0x0, Offset: 0x18b4
// Size: 0x52
function debug_enemypos( num )
{
    ai = getaiarray();
    
    for ( i = 0; i < ai.size ; i++ )
    {
        if ( ai[ i ] getentitynumber() != num )
        {
            continue;
        }
        
        ai[ i ] thread debug_enemyposproc();
        break;
    }
}

// Namespace debug / scripts\sp\debug
// Params 1
// Checksum 0x0, Offset: 0x190e
// Size: 0x51
function debug_stopenemypos( num )
{
    ai = getaiarray();
    
    for ( i = 0; i < ai.size ; i++ )
    {
        if ( ai[ i ] getentitynumber() != num )
        {
            continue;
        }
        
        ai[ i ] notify( "stop_drawing_enemy_pos" );
        break;
    }
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x1967
// Size: 0xca
function debug_enemyposproc()
{
    /#
        self endon( "<dev string:x131>" );
        self endon( "<dev string:x137>" );
        
        for ( ;; )
        {
            wait 0.05;
            
            if ( isalive( self.enemy ) )
            {
                line( self.origin + ( 0, 0, 70 ), self.enemy.origin + ( 0, 0, 70 ), ( 0.8, 0.2, 0 ), 0.5 );
            }
            
            if ( !scripts\anim\utility::hasenemysightpos() )
            {
                continue;
            }
            
            pos = scripts\anim\utility::getenemysightpos();
            line( self.origin + ( 0, 0, 70 ), pos, ( 0.9, 0.5, 0.3 ), 0.5 );
        }
    #/
}

/#

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x1a39
    // Size: 0x3b3, Type: dev
    function debug_enemyposreplay()
    {
        ai = getaiarray();
        guy = undefined;
        
        for ( i = 0; i < ai.size ; i++ )
        {
            guy = ai[ i ];
            
            if ( !isalive( guy ) )
            {
                continue;
            }
            
            if ( isdefined( guy.lastenemysightpos ) )
            {
                line( guy.origin + ( 0, 0, 65 ), guy.lastenemysightpos, ( 1, 0, 1 ), 0.5 );
            }
            
            if ( isdefined( guy.goodshootpos ) )
            {
                if ( guy isbadguy() )
                {
                    color = ( 1, 0, 0 );
                }
                else
                {
                    color = ( 0, 0, 1 );
                }
                
                nodeoffset = guy.origin + ( 0, 0, 54 );
                
                if ( isdefined( guy.node ) )
                {
                    if ( guy.node.type == "<dev string:x14e>" )
                    {
                        cornernode = 1;
                        nodeoffset = anglestoright( guy.node.angles );
                        nodeoffset *= -32;
                        nodeoffset = ( nodeoffset[ 0 ], nodeoffset[ 1 ], 64 );
                        nodeoffset = guy.node.origin + nodeoffset;
                    }
                    else if ( guy.node.type == "<dev string:x159>" )
                    {
                        cornernode = 1;
                        nodeoffset = anglestoright( guy.node.angles );
                        nodeoffset *= 32;
                        nodeoffset = ( nodeoffset[ 0 ], nodeoffset[ 1 ], 64 );
                        nodeoffset = guy.node.origin + nodeoffset;
                    }
                }
                
                draw_arrow( nodeoffset, guy.goodshootpos, color );
            }
        }
        
        if ( true )
        {
            return;
        }
        
        if ( !isalive( guy ) )
        {
            return;
        }
        
        if ( isalive( guy.enemy ) )
        {
            line( guy.origin + ( 0, 0, 70 ), guy.enemy.origin + ( 0, 0, 70 ), ( 0.6, 0.2, 0.2 ), 0.5 );
        }
        
        if ( isdefined( guy.lastenemysightpos ) )
        {
            line( guy.origin + ( 0, 0, 65 ), guy.lastenemysightpos, ( 0, 0, 1 ), 0.5 );
        }
        
        if ( isalive( guy.goodenemy ) )
        {
            line( guy.origin + ( 0, 0, 50 ), guy.goodenemy.origin, ( 1, 0, 0 ), 0.5 );
        }
        
        if ( !guy scripts\anim\utility::hasenemysightpos() )
        {
            return;
        }
        
        pos = guy scripts\anim\utility::getenemysightpos();
        line( guy.origin + ( 0, 0, 55 ), pos, ( 0.2, 0.2, 0.6 ), 0.5 );
        
        if ( isdefined( guy.goodshootpos ) )
        {
            line( guy.origin + ( 0, 0, 45 ), guy.goodshootpos, ( 0.2, 0.6, 0.2 ), 0.5 );
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 1
    // Checksum 0x0, Offset: 0x1df4
    // Size: 0x74, Type: dev
    function drawenttag( num )
    {
        ai = getaiarray();
        
        for ( i = 0; i < ai.size ; i++ )
        {
            if ( ai[ i ] getentnum() != num )
            {
                continue;
            }
            
            ai[ i ] thread dragtaguntildeath( getdvar( @"debug_tag" ) );
        }
        
        setdvar( @"hash_b41009d51346ca25", "<dev string:x165>" );
    }

#/

// Namespace debug / scripts\sp\debug
// Params 3
// Checksum 0x0, Offset: 0x1e70
// Size: 0x6e
function drawtag( tag, opcolor, drawtime )
{
    /#
        if ( isdefined( self.model ) && hastag( self.model, tag ) )
        {
            org = self gettagorigin( tag );
            ang = self gettagangles( tag );
            drawarrow( org, ang, opcolor, drawtime );
        }
    #/
}

/#

    // Namespace debug / scripts\sp\debug
    // Params 4
    // Checksum 0x0, Offset: 0x1ee6
    // Size: 0x1a3, Type: dev
    function drawarrow( org, ang, opcolor, drawtime )
    {
        scale = 10;
        forward = anglestoforward( ang );
        forwardfar = forward * scale;
        forwardclose = forward * scale * 0.8;
        right = anglestoright( ang );
        leftdraw = right * scale * -0.2;
        rightdraw = right * scale * 0.2;
        up = anglestoup( ang );
        right *= scale;
        up *= scale;
        red = ( 0.9, 0.2, 0.2 );
        green = ( 0.2, 0.9, 0.2 );
        blue = ( 0.2, 0.2, 0.9 );
        
        if ( isdefined( opcolor ) )
        {
            red = opcolor;
            green = opcolor;
            blue = opcolor;
        }
        
        if ( !isdefined( drawtime ) )
        {
            drawtime = 1;
        }
        
        line( org, org + forwardfar, red, 0.9, 0, drawtime );
        line( org + forwardfar, org + forwardclose + rightdraw, red, 0.9, 0, drawtime );
        line( org + forwardfar, org + forwardclose + leftdraw, red, 0.9, 0, drawtime );
        line( org, org + right, blue, 0.9, 0, drawtime );
        line( org, org + up, green, 0.9, 0, drawtime );
    }

    // Namespace debug / scripts\sp\debug
    // Params 2
    // Checksum 0x0, Offset: 0x2091
    // Size: 0x2e, Type: dev
    function drawtagforever( tag, opcolor )
    {
        for ( ;; )
        {
            if ( !isdefined( self ) )
            {
                return;
            }
            
            drawtag( tag, opcolor );
            wait 0.05;
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 2
    // Checksum 0x0, Offset: 0x20c7
    // Size: 0x47, Type: dev
    function dragtaguntildeath( tag, opcolor )
    {
        self endon( "<dev string:x131>" );
        
        for ( ;; )
        {
            if ( !isdefined( self ) )
            {
                break;
            }
            
            if ( !isdefined( self.origin ) )
            {
                break;
            }
            
            drawtag( tag, opcolor );
            wait 0.05;
        }
    }

#/

// Namespace debug / scripts\sp\debug
// Params 2
// Checksum 0x0, Offset: 0x2116
// Size: 0x51
function viewtag( type, tag )
{
    if ( type == "ai" )
    {
        ai = getaiarray();
        
        for ( i = 0; i < ai.size ; i++ )
        {
            ai[ i ] drawtag( tag );
        }
    }
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x216f
// Size: 0x167
function debug_corner()
{
    level.player.ignoreme = 1;
    nodes = getallnodes();
    corners = [];
    
    for ( i = 0; i < nodes.size ; i++ )
    {
        if ( nodes[ i ].type == "Cover Left" )
        {
            corners[ corners.size ] = nodes[ i ];
        }
        
        if ( nodes[ i ].type == "Cover Right" )
        {
            corners[ corners.size ] = nodes[ i ];
        }
    }
    
    ai = getaiarray();
    
    for ( i = 0; i < ai.size ; i++ )
    {
        ai[ i ] delete();
    }
    
    level.debugspawners = getspawnerarray();
    level.activenodes = [];
    level.completednodes = [];
    
    for ( i = 0; i < level.debugspawners.size ; i++ )
    {
        level.debugspawners[ i ].targetname = "blah";
    }
    
    covered = 0;
    
    for ( i = 0; i < 30 ; i++ )
    {
        if ( i >= corners.size )
        {
            break;
        }
        
        corners[ i ] thread covertest();
        covered++;
    }
    
    if ( corners.size <= 30 )
    {
        return;
    }
    
    for ( ;; )
    {
        level waittill( "debug_next_corner" );
        
        if ( covered >= corners.size )
        {
            covered = 0;
        }
        
        corners[ covered ] thread covertest();
        covered++;
    }
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x22de
// Size: 0x9
function covertest()
{
    coversetupanim();
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x22ef
// Size: 0x1fd
function coversetupanim()
{
    spawn = undefined;
    spawner = undefined;
    
    for ( ;; )
    {
        for ( i = 0; i < level.debugspawners.size ; i++ )
        {
            wait 0.05;
            spawner = level.debugspawners[ i ];
            nearactive = 0;
            
            for ( p = 0; p < level.activenodes.size ; p++ )
            {
                if ( distance( level.activenodes[ p ].origin, self.origin ) > 250 )
                {
                    continue;
                }
                
                nearactive = 1;
                break;
            }
            
            if ( nearactive )
            {
                continue;
            }
            
            completed = 0;
            
            for ( p = 0; p < level.completednodes.size ; p++ )
            {
                if ( level.completednodes[ p ] != self )
                {
                    continue;
                }
                
                completed = 1;
                break;
            }
            
            if ( completed )
            {
                continue;
            }
            
            level.activenodes[ level.activenodes.size ] = self;
            spawner.origin = self.origin;
            spawner.angles = self.angles;
            spawner.count = 1;
            spawn = spawner stalingradspawn();
            
            if ( spawn_failed( spawn ) )
            {
                removeactivespawner( self );
                continue;
            }
            
            break;
        }
        
        if ( isalive( spawn ) )
        {
            break;
        }
    }
    
    wait 1;
    
    if ( isalive( spawn ) )
    {
        spawn.ignoreme = 1;
        spawn.team = "neutral";
        spawn setgoalpos( spawn.origin );
        thread createline( self.origin );
        spawn thread debugorigin();
        thread createlineconstantly( spawn );
        spawn waittill( "death" );
    }
    
    removeactivespawner( self );
    level.completednodes[ level.completednodes.size ] = self;
}

// Namespace debug / scripts\sp\debug
// Params 1
// Checksum 0x0, Offset: 0x24f4
// Size: 0x65
function removeactivespawner( spawner )
{
    newspawners = [];
    
    for ( p = 0; p < level.activenodes.size ; p++ )
    {
        if ( level.activenodes[ p ] == spawner )
        {
            continue;
        }
        
        newspawners[ newspawners.size ] = level.activenodes[ p ];
    }
    
    level.activenodes = newspawners;
}

// Namespace debug / scripts\sp\debug
// Params 1
// Checksum 0x0, Offset: 0x2561
// Size: 0x3f
function createline( org )
{
    /#
        for ( ;; )
        {
            line( org + ( 0, 0, 35 ), org, ( 0.2, 0.5, 0.8 ), 0.5 );
            wait 0.05;
        }
    #/
}

// Namespace debug / scripts\sp\debug
// Params 1
// Checksum 0x0, Offset: 0x25a8
// Size: 0x6a
function createlineconstantly( ent )
{
    /#
        org = undefined;
        
        while ( isalive( ent ) )
        {
            org = ent.origin;
            wait 0.05;
        }
        
        for ( ;; )
        {
            line( org + ( 0, 0, 35 ), org, ( 1, 0.2, 0.1 ), 0.5 );
            wait 0.05;
        }
    #/
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x261a
// Size: 0xa5
function debugmisstime()
{
    self notify( "stopdebugmisstime" );
    self endon( "stopdebugmisstime" );
    self endon( "death" );
    
    for ( ;; )
    {
        if ( self.misstime <= 0 )
        {
            /#
                print3d( self gettagorigin( "<dev string:x166>" ) + ( 0, 0, 15 ), "<dev string:x16e>", ( 0.3, 1, 1 ), 1 );
            #/
        }
        else
        {
            /#
                print3d( self gettagorigin( "<dev string:x166>" ) + ( 0, 0, 15 ), self.misstime / 20, ( 0.3, 1, 1 ), 1 );
            #/
        }
        
        wait 0.05;
    }
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x26c7
// Size: 0xa
function debugmisstimeoff()
{
    self notify( "stopdebugmisstime" );
}

/#

    // Namespace debug / scripts\sp\debug
    // Params 1
    // Checksum 0x0, Offset: 0x26d9
    // Size: 0x7b, Type: dev
    function debugjump( num )
    {
        ai = getaiarray();
        
        for ( i = 0; i < ai.size ; i++ )
        {
            if ( ai[ i ] getentnum() != num )
            {
                continue;
            }
            
            line( level.player.origin, ai[ i ].origin, ( 0.2, 0.3, 1 ) );
            return;
        }
    }

#/

// Namespace debug / scripts\sp\debug
// Params 4
// Checksum 0x0, Offset: 0x275c
// Size: 0xb3
function add_debugdvar_func( dvar, func, isthreaded, unarchived )
{
    if ( !isdefined( level.debug.dvarfuncs ) )
    {
        level.debug.dvarfuncs = [];
    }
    
    setdvarifuninitialized( dvar, "" );
    struct = spawnstruct();
    struct.func = func;
    
    if ( isdefined( isthreaded ) )
    {
        struct.threaded = isthreaded;
    }
    
    if ( isdefined( unarchived ) )
    {
        struct.unarchived = unarchived;
    }
    
    level.debug.dvarfuncs[ dvar ] = struct;
}

/#

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x2817
    // Size: 0xf70, Type: dev
    function debugdvars()
    {
        setdvarifuninitialized( @"chasecam", "<dev string:x1c>" );
        setdvarifuninitialized( @"viewfx", "<dev string:x165>" );
        setdvarifuninitialized( @"hash_37d76fdaaaf3cdc2", 5000 );
        setdvarifuninitialized( @"hash_2f6380dc3031a0fc", "<dev string:x165>" );
        setdvarifuninitialized( @"vehicle_info", 0 );
        setdvarifuninitialized( @"getdot", 0 );
        setdvarifuninitialized( @"hash_72b0388125bf2dc7", "<dev string:x2d>" );
        setdvarifuninitialized( @"hash_699fc1c7391fd205", "<dev string:x2d>" );
        setdvarifuninitialized( @"hash_5b7d7e85c162b396", "<dev string:x2d>" );
        waittillframeend();
        setdvarifuninitialized( @"hash_a97a14e158de2f29", "<dev string:x2d>" );
        setdvarifuninitialized( @"debug_lookangle", "<dev string:x2d>" );
        setdvarifuninitialized( @"hash_4f3a4c91fee3cc20", "<dev string:x2d>" );
        setdvarifuninitialized( @"debug_enemypos", "<dev string:x172>" );
        setdvarifuninitialized( @"hash_693e9933a3c8a920", "<dev string:x172>" );
        setdvarifuninitialized( @"debug_stopenemypos", "<dev string:x172>" );
        setdvarifuninitialized( @"hash_1ff4a87138925423", "<dev string:x172>" );
        setdvarifuninitialized( @"debug_tag", "<dev string:x165>" );
        setdvarifuninitialized( @"hash_59086e72bc73e827", "<dev string:x165>" );
        setdvarifuninitialized( @"debug_vehicletag", "<dev string:x165>" );
        setdvarifuninitialized( @"hash_10b43cfca1168946", 0 );
        setdvarifuninitialized( @"hash_34dab4f8f3a04f4a", "<dev string:x2d>" );
        setdvarifuninitialized( @"debug_hatmodel", "<dev string:x31>" );
        setdvarifuninitialized( @"debug_trace", "<dev string:x2d>" );
        setdvarifuninitialized( @"hash_4c2f239edafa91c9", 0 );
        level.debug_badpath = 0;
        setdvarifuninitialized( @"debug_badpath", "<dev string:x2d>" );
        setdvarifuninitialized( @"hash_1ce84125965029f3", "<dev string:x2d>" );
        setdvarifuninitialized( @"hash_6a1fee590f7dbc5c", "<dev string:x165>" );
        setdvarifuninitialized( @"debug_nuke", "<dev string:x2d>" );
        setdvarifuninitialized( @"hash_144cc37890335117", -1 );
        setdvarifuninitialized( @"debug_deathents", "<dev string:x2d>" );
        setdvarifuninitialized( @"debug_jump", "<dev string:x165>" );
        setdvarifuninitialized( @"debug_hurt", "<dev string:x165>" );
        setdvarifuninitialized( @"animsound", "<dev string:x2d>" );
        setdvarifuninitialized( @"tag", "<dev string:x165>" );
        setdvarifuninitialized( @"hash_4589562a903db3e0", 1 );
        
        for ( i = 1; i <= level.animsound_hudlimit ; i++ )
        {
            setdvarifuninitialized( hashcat( @"tag", i ), "<dev string:x165>" );
        }
        
        setdvarifuninitialized( @"animsound_save", "<dev string:x165>" );
        setdvarifuninitialized( @"debug_depth", "<dev string:x165>" );
        setdvarifuninitialized( @"debug_colornodes", 0 );
        setdvarifuninitialized( @"debug_fxlighting", "<dev string:x1c>" );
        scripts\common\debug_reflection::init_reflection_probe();
        scripts\common\debug_graycard::init_graycard();
        level.last_threat_debug = -23430;
        setdvarifuninitialized( @"debug_threat", "<dev string:x172>" );
        level._effect[ "<dev string:x175>" ] = loadfx( "<dev string:x187>" );
        setdvarifuninitialized( @"debug_battlechatter", "<dev string:x2d>" );
        add_debugdvar_func( @"hash_c6a78f9ed07155ad", &measure, 1, 1 );
        add_debugdvar_func( @"hash_e3cff398a5a53a72", &display_ai_group_info, 0, 1 );
        add_debugdvar_func( @"hash_90c35ec29eb76f0", &function_870394ae4c5e2029, 1 );
        add_debugdvar_func( @"hash_9948014b33a0e323", &function_6519fa80e1e5411e, 1 );
        add_debugdvar_func( @"hash_c5fc60671c328201", &function_eafac20b89f548a2, 1 );
        add_debugdvar_func( @"hash_965c4785698b6c50", &function_77863cf5d430f859, 1 );
        add_debugdvar_func( @"scr_giveweapon", &gui_giveweapon, 1 );
        add_debugdvar_func( @"scr_giveattachment", &gui_giveattachment, 1 );
        add_debugdvar_func( @"hash_3336a486aff69f38", &devlistinventory, 1 );
        add_debugdvar_func( @"hash_985a6eb7146ff86e", &function_c8ce49adbbdfe59b, 0 );
        setdvarifuninitialized( @"hash_c6a78f9ed07155ad", 0 );
        setdvarifuninitialized( @"hash_bc81c5010a46eadf", 0 );
        setdvarifuninitialized( @"hash_5bed111185579616", 0 );
        setdvarifuninitialized( @"hash_1427b6dfc4e0eaad", 0 );
        setdvarifuninitialized( @"hash_6efeeea168f0a561", 0 );
        setdvarifuninitialized( @"hash_f0511426fbbb4ffe", "<dev string:x1c>" );
        setdvarifuninitialized( @"hash_5d83147342337f0b", "<dev string:x1c>" );
        thread function_1e28b43313e9982c();
        red = ( 1, 0, 0 );
        blue = ( 0, 0, 1 );
        yellow = ( 1, 1, 0 );
        cyan = ( 0, 1, 1 );
        green = ( 0, 1, 0 );
        purple = ( 1, 0, 1 );
        orange = ( 1, 0.5, 0 );
        level.color_debug[ "<dev string:x1a6>" ] = red;
        level.color_debug[ "<dev string:x1a8>" ] = blue;
        level.color_debug[ "<dev string:x1aa>" ] = yellow;
        level.color_debug[ "<dev string:x1ac>" ] = cyan;
        level.color_debug[ "<dev string:x1ae>" ] = green;
        level.color_debug[ "<dev string:x1b0>" ] = purple;
        level.color_debug[ "<dev string:x1b2>" ] = orange;
        level.debug_fxlighting = 0;
        noanimscripts = getdvar( @"hash_993202a1929383dc" ) == "<dev string:x31>";
        
        for ( ;; )
        {
            if ( getdvarint( @"getdot" ) > 0 )
            {
                draw_dot_for_ent( getdvarint( @"getdot" ) );
            }
            
            if ( getdvarint( @"viewfx" ) )
            {
                viewfx();
                setdvar( @"viewfx", "<dev string:x165>" );
            }
            
            if ( getdvar( @"hash_2f6380dc3031a0fc" ) != "<dev string:x165>" )
            {
                if ( isdefined( level.bcs_hud ) )
                {
                    level.bcs_hud destroy();
                    level.bcs_hud = undefined;
                }
            }
            
            update_battlechatter_hud();
            
            if ( getdvar( @"debug_jump" ) != "<dev string:x165>" )
            {
                debugjump( getdvarint( @"debug_jump" ) );
            }
            
            if ( getdvarint( @"chasecam" ) )
            {
                chasecam( getdvarint( @"chasecam" ) );
            }
            
            if ( getdvar( @"debug_tag" ) != "<dev string:x165>" )
            {
                thread viewtag( "<dev string:x1b4>", getdvar( @"debug_tag" ) );
                
                if ( getdvarint( @"hash_b41009d51346ca25" ) > 0 )
                {
                    thread drawenttag( getdvarint( @"hash_b41009d51346ca25" ) );
                }
            }
            
            if ( getdvarint( @"debug_colornodes" ) )
            {
                thread debug_colornodes();
            }
            
            if ( getdvar( @"hash_1ff4a87138925423" ) == "<dev string:x31>" )
            {
                thread debug_enemyposreplay();
            }
            
            if ( getdvar( @"tag" ) != "<dev string:x165>" )
            {
                thread debug_animsoundtagselected();
            }
            
            for ( i = 1; i <= level.animsound_hudlimit ; i++ )
            {
                if ( getdvar( hashcat( @"tag", i ) ) != "<dev string:x165>" )
                {
                    thread debug_animsoundtag( i );
                }
            }
            
            if ( getdvar( @"debug_nuke" ) != "<dev string:x2d>" )
            {
                thread debug_nuke();
            }
            
            var_8322d82cc7703576 = getdvarint( @"hash_144cc37890335117", -1 );
            
            if ( var_8322d82cc7703576 >= 0 )
            {
                thread function_cbf037982d8b467c( var_8322d82cc7703576 );
                setdvar( @"hash_144cc37890335117", -1 );
            }
            
            if ( getdvar( @"debug_misstime" ) == "<dev string:x31>" )
            {
                setdvar( @"debug_misstime", "<dev string:x1b7>" );
                array_thread( getaiarray(), &debugmisstime );
            }
            else if ( getdvar( @"debug_misstime" ) == "<dev string:x2d>" )
            {
                setdvar( @"debug_misstime", "<dev string:x1b7>" );
                array_thread( getaiarray(), &debugmisstimeoff );
            }
            
            if ( getdvar( @"debug_deathents" ) == "<dev string:x31>" )
            {
                thread deathspawnerpreview();
            }
            
            if ( getdvar( @"debug_hurt" ) == "<dev string:x31>" )
            {
                setdvar( @"debug_hurt", "<dev string:x2d>" );
                level.player do_damage( 50, ( 324234, 3.42342e+06, 2323 ) );
            }
            
            if ( getdvar( @"debug_hurt" ) == "<dev string:x31>" )
            {
                setdvar( @"debug_hurt", "<dev string:x2d>" );
                level.player do_damage( 50, ( 324234, 3.42342e+06, 2323 ) );
            }
            
            if ( getdvarint( @"vehicle_info" ) )
            {
                random_noteworthy = randomint( 34234 ) + "<dev string:x1bd>" + randomint( 23423 );
                setdvar( @"vehicle_info", 0 );
                vehicles = getentarray( "<dev string:x1bf>", "<dev string:x1ce>" );
                
                foreach ( vehicle in vehicles )
                {
                    if ( !isdefined( vehicle ) )
                    {
                        continue;
                    }
                    
                    if ( isspawner( vehicle ) )
                    {
                        continue;
                    }
                    
                    vehicle print_vehicle_info( random_noteworthy );
                }
            }
            
            if ( getdvar( @"debug_threat" ) != "<dev string:x172>" )
            {
                debugthreat();
            }
            
            level.debug_badpath = getdvar( @"debug_badpath" ) == "<dev string:x31>";
            
            if ( getdvarint( @"debug_enemypos" ) != -1 )
            {
                thread debug_enemypos( getdvarint( @"debug_enemypos" ) );
                setdvar( @"debug_enemypos", "<dev string:x172>" );
            }
            
            if ( getdvarint( @"debug_stopenemypos" ) != -1 )
            {
                thread debug_stopenemypos( getdvarint( @"debug_stopenemypos" ) );
                setdvar( @"debug_stopenemypos", "<dev string:x172>" );
            }
            
            if ( !noanimscripts && getdvar( @"hash_993202a1929383dc" ) == "<dev string:x31>" )
            {
                anim.defaultexception = &scripts\anim\init::infiniteloop;
                noanimscripts = 1;
            }
            
            if ( noanimscripts && getdvar( @"hash_993202a1929383dc" ) == "<dev string:x2d>" )
            {
                anim.defaultexception = &scripts\anim\init::empty;
                anim notify( "<dev string:x1dd>" );
                noanimscripts = 0;
            }
            
            if ( getdvar( @"debug_trace" ) == "<dev string:x31>" )
            {
                if ( !isdefined( level.tracestart ) )
                {
                    thread showdebugtrace();
                }
                
                level.tracestart = level.player geteye();
                setdvar( @"debug_trace", "<dev string:x2d>" );
            }
            
            debug_fxlighting();
            
            if ( getunarchiveddebugdvar( @"hash_bc81c5010a46eadf" ) == "<dev string:x1e>" )
            {
                entity_count();
            }
            
            if ( getunarchiveddebugdvar( @"hash_e88f0c15c278fb42" ) != "<dev string:x1c>" )
            {
                thread entity_count_hud();
            }
            
            if ( getunarchiveddebugdvar( @"hash_1427b6dfc4e0eaad" ) == "<dev string:x1e>" )
            {
                function_615fd51c4e0fed90();
            }
            
            if ( getunarchiveddebugdvar( @"hash_5bed111185579616" ) == "<dev string:x1e>" )
            {
                thread function_19592e71d7ad36e3();
            }
            
            if ( getunarchiveddebugdvar( @"hash_f0511426fbbb4ffe" ) == "<dev string:x1e>" )
            {
                thread show_animnames();
            }
            
            var_bdec632f447f8404 = 0;
            
            if ( getdvarint( @"hash_6014f2652bf27fbd", 0 ) > 0 )
            {
                var_bdec632f447f8404 = 1;
                setdevdvar( @"hash_6014f2652bf27fbd", 0 );
            }
            
            var_572fa332ecd66179 = int( clamp( getdvarint( @"hash_a93048b4cc8944c6", 0 ), 0, 1 ) );
            var_45cb2e2a7eb65f4 = int( clamp( getdvarint( @"hash_da232dc1e09b442f", 0 ), 0, 1 ) );
            var_b5802d21c9afc19 = int( clamp( getdvarint( @"hash_64a0e98780e8314c", 0 ), 0, 1 ) );
            
            if ( var_572fa332ecd66179 + var_45cb2e2a7eb65f4 + var_b5802d21c9afc19 > 1 || var_bdec632f447f8404 )
            {
                if ( !var_bdec632f447f8404 )
                {
                    assertmsg( "<dev string:x1ec>" );
                }
                
                var_572fa332ecd66179 = 0;
                var_45cb2e2a7eb65f4 = 0;
                var_b5802d21c9afc19 = 0;
                setdevdvar( @"hash_a93048b4cc8944c6", 0 );
                setdevdvar( @"hash_da232dc1e09b442f", 0 );
                setdevdvar( @"hash_64a0e98780e8314c", 0 );
            }
            
            level.var_572fa332ecd66179 = var_572fa332ecd66179 > 0;
            level.var_45cb2e2a7eb65f4 = var_45cb2e2a7eb65f4 > 0;
            level.var_b5802d21c9afc19 = var_b5802d21c9afc19 > 0;
            dbgmoloflareuponly = int( clamp( getdvarint( @"hash_dd7a5bb1a9c26a79", 0 ), 0, 1 ) );
            dbgmoloburnlooponly = int( clamp( getdvarint( @"hash_6c48e28c41d5b37b", 0 ), 0, 1 ) );
            dbgmolodiedownonly = int( clamp( getdvarint( @"hash_817c6525fd061802", 0 ), 0, 1 ) );
            
            if ( dbgmoloflareuponly + dbgmoloburnlooponly + dbgmolodiedownonly > 1 || var_bdec632f447f8404 )
            {
                if ( !var_bdec632f447f8404 )
                {
                    assertmsg( "<dev string:x262>" );
                }
                
                dbgmoloflareuponly = 0;
                dbgmoloburnlooponly = 0;
                dbgmolodiedownonly = 0;
                setdevdvar( @"hash_dd7a5bb1a9c26a79", 0 );
                setdevdvar( @"hash_6c48e28c41d5b37b", 0 );
                setdevdvar( @"hash_817c6525fd061802", 0 );
            }
            
            level.dbgmoloflareuponly = dbgmoloflareuponly > 0;
            level.dbgmoloburnlooponly = dbgmoloburnlooponly > 0;
            level.dbgmolodiedownonly = dbgmolodiedownonly > 0;
            
            if ( !var_bdec632f447f8404 )
            {
                level.dbgmolodrawhits = getdvarint( @"hash_bdb86700db7d369e", 0 ) > 0;
                level.var_fe4aa861c408282f = getdvarint( @"hash_c5a7cfaf6b0c9ac0", 0 ) > 0;
            }
            else
            {
                setdevdvar( @"hash_bdb86700db7d369e", 0 );
                level.dbgmolodrawhits = 0;
                setdevdvar( @"hash_c5a7cfaf6b0c9ac0", 0 );
                level.var_fe4aa861c408282f = 0;
            }
            
            if ( getdvarint( @"hash_5d83147342337f0b" ) > 0 && getdvarint( @"hash_f6ac786807a5e9cb" ) < 1 )
            {
                thread scripts\sp\debug_spawnai::spawn_ai_mode();
            }
            
            if ( getdvarint( @"hash_b8b13c8ec5d6a4e4" ) > 0 )
            {
                show_arrivalexit_state();
            }
            
            process_dvarfuncs();
            waitframe();
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x378f
    // Size: 0x163, Type: dev
    function show_arrivalexit_state()
    {
        bg_entinfo = getdvar( @"bg_entinfo" );
        array = [];
        
        if ( bg_entinfo == "<dev string:x2d9>" )
        {
            array = getaiarray();
        }
        else if ( bg_entinfo == "<dev string:x2fb>" && getdvarint( @"ai_debugentindex" ) != -1 )
        {
            array[ 0 ] = getentbynum( getdvarint( @"ai_debugentindex" ) );
        }
        else
        {
            return;
        }
        
        foreach ( ai in array )
        {
            if ( isalive( ai ) )
            {
                if ( istrue( ai.disableexits ) )
                {
                    text_pos = ai.origin + ( 0, 0, 16 );
                    print3d( text_pos, "<dev string:x321>", ( 1, 0.2, 0.2 ), 1, 0.5, 1 );
                }
                
                if ( istrue( ai.disablearrivals ) )
                {
                    text_pos = ai.origin + ( 0, 0, 8 );
                    print3d( text_pos, "<dev string:x330>", ( 1, 0.2, 0.2 ), 1, 0.5, 1 );
                }
            }
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x38fa
    // Size: 0xd5, Type: dev
    function process_dvarfuncs()
    {
        foreach ( dvarstr, data in level.debug.dvarfuncs )
        {
            dvarval = undefined;
            
            if ( isdefined( data.unarchived ) )
            {
                dvarval = getunarchiveddebugdvar( dvarstr );
            }
            else
            {
                dvarval = getdvar( dvarstr );
            }
            
            if ( !isdefined( dvarval ) )
            {
                continue;
            }
            
            if ( dvarval == "<dev string:x1c>" || dvarval == "<dev string:x165>" )
            {
                continue;
            }
            
            if ( isdefined( data.threaded ) )
            {
                thread [[ data.func ]]();
                continue;
            }
            
            [[ data.func ]]();
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x39d7
    // Size: 0x23, Type: dev
    function remove_fxlighting_object()
    {
        if ( level.debug_fxlighting == 1 )
        {
            level.var_feb23dcf53fece34 delete();
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x3a02
    // Size: 0xc0, Type: dev
    function create_fxlighting_object()
    {
        level.var_feb23dcf53fece34 = spawn( "<dev string:x42>", level.player geteye() + anglestoforward( level.player.angles ) * 100 );
        level.var_feb23dcf53fece34 setmodel( "<dev string:x6b>" );
        level.var_feb23dcf53fece34.origin = level.player geteye() + anglestoforward( level.player getplayerangles() ) * 100;
        level.var_feb23dcf53fece34 linkto( level.player );
        level.var_feb23dcf53fece34 thread play_fxlighting_fx();
        thread debug_fxlighting_buttons();
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x3aca
    // Size: 0x31, Type: dev
    function play_fxlighting_fx()
    {
        self endon( "<dev string:x131>" );
        
        while ( true )
        {
            playfxontag( getfx( "<dev string:x175>" ), self, "<dev string:x6b>" );
            wait 0.1;
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x3b03
    // Size: 0x78, Type: dev
    function debug_fxlighting()
    {
        if ( getdvar( @"debug_fxlighting" ) == "<dev string:x1e>" && level.debug_fxlighting != 1 )
        {
            create_fxlighting_object();
            level.debug_fxlighting = 1;
            return;
        }
        
        if ( getdvar( @"debug_fxlighting" ) == "<dev string:x1c>" && level.debug_fxlighting != 0 )
        {
            remove_fxlighting_object();
            level.debug_fxlighting = 0;
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x3b83
    // Size: 0x113, Type: dev
    function debug_fxlighting_buttons()
    {
        offset = 100;
        lastoffset = offset;
        offsetinc = 50;
        
        while ( getdvar( @"debug_fxlighting" ) == "<dev string:x1e>" || getdvar( @"debug_fxlighting" ) == "<dev string:x342>" )
        {
            if ( level.player buttonpressed( "<dev string:x344>" ) )
            {
                offset += offsetinc;
            }
            
            if ( level.player buttonpressed( "<dev string:x34d>" ) )
            {
                offset -= offsetinc;
            }
            
            if ( offset > 1000 )
            {
                offset = 1000;
            }
            
            if ( offset < 64 )
            {
                offset = 64;
            }
            
            level.var_feb23dcf53fece34 unlink();
            level.var_feb23dcf53fece34.origin = level.player geteye() + anglestoforward( level.player getplayerangles() ) * offset;
            lastoffset = offset;
            level.var_feb23dcf53fece34 linkto( level.player );
            wait 0.05;
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x3c9e
    // Size: 0xca, Type: dev
    function showdebugtrace()
    {
        startoverride = undefined;
        endoverride = undefined;
        startoverride = ( 15.1859, -12.2822, 4.071 );
        endoverride = ( 947.2, -10918, 64.9514 );
        assert( !isdefined( level.traceend ) );
        
        for ( ;; )
        {
            wait 0.05;
            start = startoverride;
            end = endoverride;
            
            if ( !isdefined( startoverride ) )
            {
                start = level.tracestart;
            }
            
            if ( !isdefined( endoverride ) )
            {
                end = level.player geteye();
            }
            
            trace = scripts\engine\trace::_bullet_trace( start, end, 0, undefined );
            line( start, trace[ "<dev string:x356>" ], ( 0.9, 0.5, 0.8 ), 0.5 );
        }
    }

#/

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x3d70
// Size: 0x385
function debug_character_count()
{
    drones = newhudelem();
    drones.alignx = "left";
    drones.aligny = "middle";
    drones.x = 10;
    drones.y = 100;
    drones.label = &"DEBUG_DRONES";
    drones.alpha = 0;
    allies = newhudelem();
    allies.alignx = "left";
    allies.aligny = "middle";
    allies.x = 10;
    allies.y = 115;
    allies.label = &"DEBUG_ALLIES";
    allies.alpha = 0;
    axis = newhudelem();
    axis.alignx = "left";
    axis.aligny = "middle";
    axis.x = 10;
    axis.y = 130;
    axis.label = &"DEBUG_AXIS";
    axis.alpha = 0;
    vehicles = newhudelem();
    vehicles.alignx = "left";
    vehicles.aligny = "middle";
    vehicles.x = 10;
    vehicles.y = 145;
    vehicles.label = &"DEBUG_VEHICLES";
    vehicles.alpha = 0;
    total = newhudelem();
    total.alignx = "left";
    total.aligny = "middle";
    total.x = 10;
    total.y = 160;
    total.label = &"DEBUG_TOTAL";
    total.alpha = 0;
    var_a49101e1aa7c8055 = "off";
    
    for ( ;; )
    {
        dvar = getdvar( @"debug_character_count" );
        
        if ( dvar == "off" )
        {
            if ( dvar != var_a49101e1aa7c8055 )
            {
                drones.alpha = 0;
                allies.alpha = 0;
                axis.alpha = 0;
                vehicles.alpha = 0;
                total.alpha = 0;
                var_a49101e1aa7c8055 = dvar;
            }
            
            wait 0.25;
            continue;
        }
        else if ( dvar != var_a49101e1aa7c8055 )
        {
            drones.alpha = 1;
            allies.alpha = 1;
            axis.alpha = 1;
            vehicles.alpha = 1;
            total.alpha = 1;
            var_a49101e1aa7c8055 = dvar;
        }
        
        count_drones = getentarray( "drone", "targetname" ).size;
        drones setvalue( count_drones );
        count_allies = getaiarray( "allies" ).size;
        allies setvalue( count_allies );
        count_axis = getaiarray( "bad_guys" ).size;
        axis setvalue( count_axis );
        vehicles setvalue( getentarray( "script_vehicle", "classname" ).size );
        total setvalue( count_drones + count_allies + count_axis );
        wait 0.25;
    }
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x40fd
// Size: 0x74
function nuke()
{
    if ( !self.damageshield )
    {
        if ( isdefined( self.unittype ) && self.unittype == "c12" )
        {
            self kill( ( 0, 0, -500 ), level.player );
            return;
        }
        
        self kill( ( 0, 0, -500 ), level.player, level.player );
    }
}

/#

    // Namespace debug / scripts\sp\debug
    // Params 1
    // Checksum 0x0, Offset: 0x4179
    // Size: 0x58, Type: dev
    function function_cbf037982d8b467c( entnum )
    {
        ai = getaispeciesarray( "<dev string:x35f>", "<dev string:x368>" );
        
        for ( i = 0; i < ai.size ; i++ )
        {
            if ( ai[ i ] getentitynumber() != entnum )
            {
                ai[ i ] nuke();
            }
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x41d9
    // Size: 0x216, Type: dev
    function debug_nuke()
    {
        dvar = getdvar( @"debug_nuke" );
        
        if ( dvar == "<dev string:x31>" )
        {
            ai = getaispeciesarray( "<dev string:x35f>", "<dev string:x368>" );
            
            for ( i = 0; i < ai.size ; i++ )
            {
                ai[ i ] nuke();
            }
            
            if ( isdefined( level.bosses ) )
            {
                foreach ( boss in level.bosses )
                {
                    if ( !isdefined( boss.damageshield ) || !boss.damageshield )
                    {
                        boss kill( ( 0, 0, -500 ), level.player, level.player );
                    }
                }
            }
        }
        else if ( dvar == "<dev string:x1b4>" )
        {
            ai = getaiarray( "<dev string:x35f>" );
            
            for ( i = 0; i < ai.size ; i++ )
            {
                ai[ i ] nuke();
            }
        }
        else if ( dvar == "<dev string:x36c>" )
        {
            ai = getaispeciesarray( "<dev string:x35f>", "<dev string:x371>" );
            
            for ( i = 0; i < ai.size ; i++ )
            {
                ai[ i ] nuke();
            }
        }
        else if ( dvar == "<dev string:x375>" )
        {
            vehicles = vehicle_getarray();
            
            foreach ( vehicle in vehicles )
            {
                if ( vehicle.script_team == "<dev string:x37e>" && !isdefined( vehicle.godmode ) )
                {
                    vehicle kill();
                }
            }
        }
        
        setdvar( @"debug_nuke", "<dev string:x2d>" );
    }

#/

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x43f7
// Size: 0x347
function camera()
{
    wait 0.05;
    cameras = getentarray( "camera", "targetname" );
    
    for ( i = 0; i < cameras.size ; i++ )
    {
        ent = getent( cameras[ i ].target, "targetname" );
        cameras[ i ].origin2 = ent.origin;
        cameras[ i ].angles = vectortoangles( ent.origin - cameras[ i ].origin );
    }
    
    for ( ;; )
    {
        /#
            if ( getdvar( @"camera" ) != "<dev string:x31>" )
            {
                if ( getdvar( @"camera" ) != "<dev string:x2d>" )
                {
                    setdvar( @"camera", "<dev string:x2d>" );
                }
                
                wait 1;
                continue;
            }
        #/
        
        ai = getaiarray( "axis" );
        
        if ( !ai.size )
        {
            freeplayer();
            wait 0.5;
            continue;
        }
        
        var_c1519af15b8d8dfa = [];
        
        for ( i = 0; i < cameras.size ; i++ )
        {
            for ( p = 0; p < ai.size ; p++ )
            {
                if ( distance( cameras[ i ].origin, ai[ p ].origin ) > 256 )
                {
                    continue;
                }
                
                var_c1519af15b8d8dfa[ var_c1519af15b8d8dfa.size ] = cameras[ i ];
                break;
            }
        }
        
        if ( !var_c1519af15b8d8dfa.size )
        {
            freeplayer();
            wait 0.5;
            continue;
        }
        
        var_d1ff380d78ff106f = [];
        
        for ( i = 0; i < var_c1519af15b8d8dfa.size ; i++ )
        {
            camera = var_c1519af15b8d8dfa[ i ];
            start = camera.origin2;
            end = camera.origin;
            difference = vectortoangles( ( end[ 0 ], end[ 1 ], end[ 2 ] ) - ( start[ 0 ], start[ 1 ], start[ 2 ] ) );
            angles = ( 0, difference[ 1 ], 0 );
            forward = anglestoforward( angles );
            difference = vectornormalize( end - level.player.origin );
            dot = vectordot( forward, difference );
            
            if ( dot < 0.85 )
            {
                continue;
            }
            
            var_d1ff380d78ff106f[ var_d1ff380d78ff106f.size ] = camera;
        }
        
        if ( !var_d1ff380d78ff106f.size )
        {
            freeplayer();
            wait 0.5;
            continue;
        }
        
        dist = distance( level.player.origin, var_d1ff380d78ff106f[ 0 ].origin );
        newcam = var_d1ff380d78ff106f[ 0 ];
        
        for ( i = 1; i < var_d1ff380d78ff106f.size ; i++ )
        {
            newdist = distance( level.player.origin, var_d1ff380d78ff106f[ i ].origin );
            
            if ( newdist > dist )
            {
                continue;
            }
            
            newcam = var_d1ff380d78ff106f[ i ];
            dist = newdist;
        }
        
        setplayertocamera( newcam );
        wait 3;
    }
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x4746
// Size: 0x16
function freeplayer()
{
    setdvar( @"hash_f94addedc8e87b69", "0" );
}

// Namespace debug / scripts\sp\debug
// Params 1
// Checksum 0x0, Offset: 0x4764
// Size: 0x55
function setplayertocamera( camera )
{
    setdvar( @"hash_f94addedc8e87b69", "2" );
    
    /#
        setdebugangles( camera.angles );
    #/
    
    /#
        setdebugorigin( camera.origin + ( 0, 0, -60 ) );
    #/
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x47c1
// Size: 0xe3
function deathspawnerpreview()
{
    waittillframeend();
    
    for ( i = 0; i < 50 ; i++ )
    {
        if ( !isdefined( level.deathspawnerents[ i ] ) )
        {
            continue;
        }
        
        array = level.deathspawnerents[ i ];
        
        for ( p = 0; p < array.size ; p++ )
        {
            ent = array[ p ];
            
            if ( isdefined( ent.truecount ) )
            {
                /#
                    print3d( ent.origin, i + "<dev string:xc9>" + ent.truecount, ( 0, 0.8, 0.6 ), 5 );
                #/
                
                continue;
            }
            
            /#
                print3d( ent.origin, i + "<dev string:xc9>" + "<dev string:x383>", ( 0, 0.8, 0.6 ), 5 );
            #/
        }
    }
}

/#

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x48ac
    // Size: 0x17e, Type: dev
    function lastsightposwatch()
    {
        for ( ;; )
        {
            wait 0.05;
            num = getdvarint( @"lastsightpos" );
            
            if ( !num )
            {
                continue;
            }
            
            guy = undefined;
            ai = getaiarray();
            
            for ( i = 0; i < ai.size ; i++ )
            {
                if ( ai[ i ] getentnum() != num )
                {
                    continue;
                }
                
                guy = ai[ i ];
                break;
            }
            
            if ( !isalive( guy ) )
            {
                continue;
            }
            
            if ( guy scripts\anim\utility::hasenemysightpos() )
            {
                org = guy scripts\anim\utility::getenemysightpos();
            }
            else
            {
                org = undefined;
            }
            
            for ( ;; )
            {
                newnum = getdvarint( @"lastsightpos" );
                
                if ( num != newnum )
                {
                    break;
                }
                
                if ( isalive( guy ) && guy scripts\anim\utility::hasenemysightpos() )
                {
                    org = guy scripts\anim\utility::getenemysightpos();
                }
                
                if ( !isdefined( org ) )
                {
                    wait 0.05;
                    continue;
                }
                
                range = 10;
                color = ( 0.2, 0.9, 0.8 );
                line( org + ( 0, 0, range ), org + ( 0, 0, range * -1 ), color, 1 );
                line( org + ( range, 0, 0 ), org + ( range * -1, 0, 0 ), color, 1 );
                line( org + ( 0, range, 0 ), org + ( 0, range * -1, 0 ), color, 1 );
                wait 0.05;
            }
        }
    }

#/

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x4a32
// Size: 0x17
function watchminimap()
{
    while ( true )
    {
        updateminimapsetting();
        wait 0.25;
    }
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x4a51
// Size: 0x55f
function updateminimapsetting()
{
    requiredmapaspectratio = getdvarfloat( @"scr_requiredmapaspectratio", 1 );
    
    if ( !isdefined( level.minimapcornertargetname ) )
    {
        setdvar( @"hash_4ce073db68d6da5d", "minimap_corner" );
        level.minimapcornertargetname = "minimap_corner";
    }
    
    if ( !isdefined( level.minimapheight ) )
    {
        setdvar( @"scr_minimap_height", "0" );
        level.minimapheight = 0;
    }
    
    minimapheight = getdvarfloat( @"scr_minimap_height" );
    minimapcornertargetname = getdvar( @"hash_4ce073db68d6da5d" );
    
    if ( minimapheight != level.minimapheight || minimapcornertargetname != level.minimapcornertargetname )
    {
        if ( isdefined( level.minimaporigin ) )
        {
            level.minimapplayer unlink();
            level.minimaporigin delete();
            level notify( "end_draw_map_bounds" );
        }
        
        if ( minimapheight > 0 )
        {
            level.minimapheight = minimapheight;
            level.minimapcornertargetname = minimapcornertargetname;
            player = level.player;
            corners = getentarray( minimapcornertargetname, "targetname" );
            
            if ( corners.size == 2 )
            {
                viewpos = corners[ 0 ].origin + corners[ 1 ].origin;
                viewpos = ( viewpos[ 0 ] * 0.5, viewpos[ 1 ] * 0.5, viewpos[ 2 ] * 0.5 );
                maxcorner = ( corners[ 0 ].origin[ 0 ], corners[ 0 ].origin[ 1 ], viewpos[ 2 ] );
                mincorner = ( corners[ 0 ].origin[ 0 ], corners[ 0 ].origin[ 1 ], viewpos[ 2 ] );
                
                if ( corners[ 1 ].origin[ 0 ] > corners[ 0 ].origin[ 0 ] )
                {
                    maxcorner = ( corners[ 1 ].origin[ 0 ], maxcorner[ 1 ], maxcorner[ 2 ] );
                }
                else
                {
                    mincorner = ( corners[ 1 ].origin[ 0 ], mincorner[ 1 ], mincorner[ 2 ] );
                }
                
                if ( corners[ 1 ].origin[ 1 ] > corners[ 0 ].origin[ 1 ] )
                {
                    maxcorner = ( maxcorner[ 0 ], corners[ 1 ].origin[ 1 ], maxcorner[ 2 ] );
                }
                else
                {
                    mincorner = ( mincorner[ 0 ], corners[ 1 ].origin[ 1 ], mincorner[ 2 ] );
                }
                
                viewpostocorner = maxcorner - viewpos;
                viewpos = ( viewpos[ 0 ], viewpos[ 1 ], viewpos[ 2 ] + minimapheight );
                origin = spawn( "script_origin", player.origin );
                northvector = ( cos( getnorthyaw() ), sin( getnorthyaw() ), 0 );
                eastvector = ( northvector[ 1 ], 0 - northvector[ 0 ], 0 );
                disttotop = vectordot( northvector, viewpostocorner );
                
                if ( disttotop < 0 )
                {
                    disttotop = 0 - disttotop;
                }
                
                disttoside = vectordot( eastvector, viewpostocorner );
                
                if ( disttoside < 0 )
                {
                    disttoside = 0 - disttoside;
                }
                
                if ( requiredmapaspectratio > 0 )
                {
                    mapaspectratio = disttoside / disttotop;
                    
                    if ( mapaspectratio < requiredmapaspectratio )
                    {
                        incr = requiredmapaspectratio / mapaspectratio;
                        disttoside *= incr;
                        addvec = vecscale( eastvector, vectordot( eastvector, maxcorner - viewpos ) * ( incr - 1 ) );
                        mincorner -= addvec;
                        maxcorner += addvec;
                    }
                    else
                    {
                        incr = mapaspectratio / requiredmapaspectratio;
                        disttotop *= incr;
                        addvec = vecscale( northvector, vectordot( northvector, maxcorner - viewpos ) * ( incr - 1 ) );
                        mincorner -= addvec;
                        maxcorner += addvec;
                    }
                }
                
                if ( isplatformconsole() )
                {
                    aspectratioguess = 1.77778;
                    angleside = 2 * atan( disttoside * 0.8 / minimapheight );
                    angletop = 2 * atan( disttotop * aspectratioguess * 0.8 / minimapheight );
                }
                else
                {
                    aspectratioguess = 1.33333;
                    angleside = 2 * atan( disttoside * 1.05 / minimapheight );
                    angletop = 2 * atan( disttotop * aspectratioguess * 1.05 / minimapheight );
                }
                
                if ( angleside > angletop )
                {
                    angle = angleside;
                }
                else
                {
                    angle = angletop;
                }
                
                znear = minimapheight - 1000;
                
                if ( znear < 16 )
                {
                    znear = 16;
                }
                
                if ( znear > 10000 )
                {
                    znear = 10000;
                }
                
                player playerlinktoabsolute( origin );
                origin.origin = viewpos + ( 0, 0, -62 );
                origin.angles = ( 90, getnorthyaw(), 0 );
                player giveweapon( "defaultweapon" );
                setsaveddvar( @"cg_fov", angle );
                level.minimapplayer = player;
                level.minimaporigin = origin;
                thread drawminimapbounds( viewpos, mincorner, maxcorner );
                return;
            }
            
            println( "<dev string:x385>" );
        }
    }
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x4fb8
// Size: 0x52
function getchains()
{
    chainarray = [];
    chainarray = getentarray( "minimap_line", "script_noteworthy" );
    array = [];
    
    for ( i = 0; i < chainarray.size ; i++ )
    {
        array[ i ] = chainarray[ i ] getchain();
    }
    
    return array;
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x5013
// Size: 0xa6
function getchain()
{
    array = [];
    ent = self;
    
    while ( isdefined( ent ) )
    {
        array[ array.size ] = ent;
        
        if ( !isdefined( ent ) || !isdefined( ent.target ) )
        {
            break;
        }
        
        ent = getent( ent.target, "targetname" );
        
        if ( isdefined( ent ) && ent == array[ 0 ] )
        {
            array[ array.size ] = ent;
            break;
        }
    }
    
    originarray = [];
    
    for ( i = 0; i < array.size ; i++ )
    {
        originarray[ i ] = array[ i ].origin;
    }
    
    return originarray;
}

// Namespace debug / scripts\sp\debug
// Params 2
// Checksum 0x0, Offset: 0x50c2
// Size: 0x25
function vecscale( vec, scalar )
{
    return ( vec[ 0 ] * scalar, vec[ 1 ] * scalar, vec[ 2 ] * scalar );
}

// Namespace debug / scripts\sp\debug
// Params 3
// Checksum 0x0, Offset: 0x50f0
// Size: 0x217
function drawminimapbounds( viewpos, mincorner, maxcorner )
{
    level notify( "end_draw_map_bounds" );
    level endon( "end_draw_map_bounds" );
    viewheight = viewpos[ 2 ] - maxcorner[ 2 ];
    diaglen = length( mincorner - maxcorner );
    mincorneroffset = mincorner - viewpos;
    mincorneroffset = vectornormalize( ( mincorneroffset[ 0 ], mincorneroffset[ 1 ], 0 ) );
    mincorner += vecscale( mincorneroffset, diaglen * 1 / 800 * 0 );
    maxcorneroffset = maxcorner - viewpos;
    maxcorneroffset = vectornormalize( ( maxcorneroffset[ 0 ], maxcorneroffset[ 1 ], 0 ) );
    maxcorner += vecscale( maxcorneroffset, diaglen * 1 / 800 * 0 );
    north = ( cos( getnorthyaw() ), sin( getnorthyaw() ), 0 );
    diagonal = maxcorner - mincorner;
    side = vecscale( north, vectordot( diagonal, north ) );
    sidenorth = vecscale( north, abs( vectordot( diagonal, north ) ) );
    corner0 = mincorner;
    corner1 = mincorner + side;
    corner2 = maxcorner;
    corner3 = maxcorner - side;
    toppos = vecscale( mincorner + maxcorner, 0.5 ) + vecscale( sidenorth, 0.51 );
    textscale = diaglen * 0.003;
    chains = getchains();
    
    while ( true )
    {
        /#
            line( corner0, corner1 );
            line( corner1, corner2 );
            line( corner2, corner3 );
            line( corner3, corner0 );
        #/
        
        array_levelthread( chains, &plot_points );
        
        /#
            print3d( toppos, "<dev string:x3ce>", ( 1, 1, 1 ), 1, textscale );
        #/
        
        wait 0.05;
    }
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x530f
// Size: 0x13d
function debug_colornodes()
{
    wait 0.05;
    ai = getaiarray();
    array = [];
    array[ "axis" ] = [];
    array[ "allies" ] = [];
    array[ "neutral" ] = [];
    
    for ( i = 0; i < ai.size ; i++ )
    {
        guy = ai[ i ];
        
        if ( !isdefined( guy.currentcolorcode ) )
        {
            continue;
        }
        
        array[ guy.team ][ guy.currentcolorcode ] = 1;
        color = ( 1, 1, 1 );
        
        if ( isdefined( guy.script_forcecolor ) )
        {
            color = level.color_debug[ guy.script_forcecolor ];
        }
        
        /#
            print3d( guy.origin + ( 0, 0, 50 ), guy.currentcolorcode, color, 1, 1 );
        #/
        
        if ( guy.team == "axis" )
        {
            continue;
        }
        
        guy try_to_draw_line_to_node();
    }
    
    draw_colornodes( array, "allies" );
    draw_colornodes( array, "axis" );
}

// Namespace debug / scripts\sp\debug
// Params 2
// Checksum 0x0, Offset: 0x5454
// Size: 0x13c
function draw_colornodes( array, team )
{
    keys = getarraykeys( array[ team ] );
    
    for ( i = 0; i < keys.size ; i++ )
    {
        color = ( 1, 1, 1 );
        color = level.color_debug[ getsubstr( keys[ i ], 0, 1 ) ];
        
        if ( isdefined( level.colornodes_debug_array[ team ][ keys[ i ] ] ) )
        {
            teamarray = level.colornodes_debug_array[ team ][ keys[ i ] ];
            
            for ( p = 0; p < teamarray.size ; p++ )
            {
                /#
                    print3d( teamarray[ p ].origin, "<dev string:x3db>" + keys[ i ], color, 1, 1 );
                #/
            }
        }
        
        if ( isdefined( level.colorvolumes_debug_array[ team ][ keys[ i ] ] ) )
        {
            teamvolume = level.colorvolumes_debug_array[ team ][ keys[ i ] ];
            
            /#
                print3d( teamvolume.origin, "<dev string:x3de>" + keys[ i ], color, 1, 1 );
            #/
            
            thread scripts\engine\utility::draw_entity_bounds( teamvolume, 0.05, color, 0 );
        }
    }
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x5598
// Size: 0x7e
function get_team_substr()
{
    if ( self.team == "allies" )
    {
        if ( !isdefined( self.node.script_color_allies ) )
        {
            return;
        }
        
        return self.node.script_color_allies;
    }
    
    if ( self.team == "axis" )
    {
        if ( !isdefined( self.node.script_color_axis ) )
        {
            return;
        }
        
        return self.node.script_color_axis;
    }
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x561e
// Size: 0xfb
function try_to_draw_line_to_node()
{
    if ( !isdefined( self.node ) )
    {
        return;
    }
    
    if ( !isdefined( self.script_forcecolor ) )
    {
        return;
    }
    
    substr = get_team_substr();
    
    if ( !isdefined( substr ) )
    {
        /#
            volume = level.arrays_of_colorcoded_volumes[ scripts\sp\colors::get_team() ][ self.currentcolorcode ];
            
            if ( isdefined( volume ) )
            {
                line( self.origin + ( 0, 0, 64 ), volume.origin, level.color_debug[ self.script_forcecolor ], 0.5 );
            }
        #/
        
        return;
    }
    
    if ( !issubstr( substr, self.script_forcecolor ) )
    {
        return;
    }
    
    /#
        line( self.origin + ( 0, 0, 64 ), self.node.origin, level.color_debug[ self.script_forcecolor ] );
    #/
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x5721
// Size: 0x18
function debugthreat()
{
    level.last_threat_debug = gettime();
    thread debugthreatcalc();
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x5741
// Size: 0xbc
function debugthreatcalc()
{
    /#
        ai = getaiarray();
        entnum = getdvarint( @"debug_threat" );
        entity = undefined;
        
        if ( entnum == 0 )
        {
            entity = level.player;
        }
        else
        {
            for ( i = 0; i < ai.size ; i++ )
            {
                if ( entnum != ai[ i ] getentnum() )
                {
                    continue;
                }
                
                entity = ai[ i ];
                break;
            }
        }
        
        if ( !isalive( entity ) )
        {
            return;
        }
        
        entitygroup = entity getthreatbiasgroup();
        array_thread( ai, &displaythreat, entity, entitygroup );
        level.player thread displaythreat( entity, entitygroup );
    #/
}

// Namespace debug / scripts\sp\debug
// Params 2
// Checksum 0x0, Offset: 0x5805
// Size: 0x26f
function displaythreat( entity, entitygroup )
{
    if ( self.team == entity.team )
    {
        return;
    }
    
    selfthreat = 0;
    selfthreat += self.threatbias;
    threat = 0;
    threat += entity.threatbias;
    mygroup = undefined;
    
    if ( isdefined( entitygroup ) )
    {
        mygroup = self getthreatbiasgroup();
        
        if ( isdefined( mygroup ) )
        {
            threat += getthreatbias( entitygroup, mygroup );
            selfthreat += getthreatbias( mygroup, entitygroup );
        }
    }
    
    if ( entity.ignoreme || threat < -900000 )
    {
        threat = "Ignore";
    }
    
    if ( self.ignoreme || selfthreat < -900000 )
    {
        selfthreat = "Ignore";
    }
    
    timer = 20;
    col = ( 1, 0.5, 0.2 );
    col2 = ( 0.2, 0.5, 1 );
    pacifist = !isplayer( self ) && self.pacifist;
    
    for ( i = 0; i <= timer ; i++ )
    {
        /#
            print3d( self.origin + ( 0, 0, 65 ), "<dev string:x3e1>", col, 3 );
        #/
        
        /#
            print3d( self.origin + ( 0, 0, 50 ), threat, col, 5 );
        #/
        
        if ( isdefined( entitygroup ) )
        {
            /#
                print3d( self.origin + ( 0, 0, 35 ), entitygroup, col, 2 );
            #/
        }
        
        /#
            print3d( self.origin + ( 0, 0, 15 ), "<dev string:x3ec>", col2, 3 );
        #/
        
        /#
            print3d( self.origin + ( 0, 0, 0 ), selfthreat, col2, 5 );
        #/
        
        if ( isdefined( mygroup ) )
        {
            /#
                print3d( self.origin + ( 0, 0, -15 ), mygroup, col2, 2 );
            #/
        }
        
        if ( pacifist )
        {
            /#
                print3d( self.origin + ( 0, 0, 25 ), "<dev string:x3f7>", col2, 5 );
            #/
        }
        
        wait 0.05;
    }
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x5a7c
// Size: 0x28
function debugcolorfriendlies()
{
    level.debug_color_friendlies = [];
    level.debug_color_huds = [];
    
    for ( ;; )
    {
        level waittill( "updated_color_friendlies" );
        draw_color_friendlies();
    }
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x5aac
// Size: 0xa2
function get_script_palette()
{
    rgb = [];
    rgb[ "r" ] = ( 1, 0, 0 );
    rgb[ "o" ] = ( 1, 0.5, 0 );
    rgb[ "y" ] = ( 1, 1, 0 );
    rgb[ "g" ] = ( 0, 1, 0 );
    rgb[ "c" ] = ( 0, 1, 1 );
    rgb[ "b" ] = ( 0, 0, 1 );
    rgb[ "p" ] = ( 1, 0, 1 );
    return rgb;
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x5b57
// Size: 0x264
function draw_color_friendlies()
{
    level endon( "updated_color_friendlies" );
    keys = getarraykeys( level.debug_color_friendlies );
    colored_friendlies = [];
    colors = [];
    colors[ colors.size ] = "r";
    colors[ colors.size ] = "o";
    colors[ colors.size ] = "y";
    colors[ colors.size ] = "g";
    colors[ colors.size ] = "c";
    colors[ colors.size ] = "b";
    colors[ colors.size ] = "p";
    rgb = get_script_palette();
    
    for ( i = 0; i < colors.size ; i++ )
    {
        colored_friendlies[ colors[ i ] ] = 0;
    }
    
    for ( i = 0; i < keys.size ; i++ )
    {
        color = level.debug_color_friendlies[ keys[ i ] ];
        colored_friendlies[ color ]++;
    }
    
    for ( i = 0; i < level.debug_color_huds.size ; i++ )
    {
        level.debug_color_huds[ i ] destroy();
    }
    
    level.debug_color_huds = [];
    
    /#
        if ( !getdvarint( @"hash_10b43cfca1168946" ) )
        {
            return;
        }
    #/
    
    x = 15;
    y = 420;
    size = 8;
    buffer = size + 2;
    
    for ( i = 0; i < colors.size ; i++ )
    {
        if ( colored_friendlies[ colors[ i ] ] <= 0 )
        {
            continue;
        }
        
        for ( p = 0; p < colored_friendlies[ colors[ i ] ] ; p++ )
        {
            overlay = newhudelem();
            overlay.x = x + buffer * p;
            overlay.y = y;
            overlay setshader( "white", size, size );
            overlay.horzalign = "left";
            overlay.vertalign = "top";
            overlay.alignx = "left";
            overlay.aligny = "bottom";
            overlay.alpha = 1;
            overlay.color = rgb[ colors[ i ] ];
            level.debug_color_huds[ level.debug_color_huds.size ] = overlay;
        }
        
        y -= buffer;
    }
}

// Namespace debug / scripts\sp\debug
// Params 1
// Checksum 0x0, Offset: 0x5dc3
// Size: 0xb0
function get_alias_from_stored( animsound )
{
    if ( !isdefined( level.animsound_aliases[ animsound.animname ] ) )
    {
        return;
    }
    
    if ( !isdefined( level.animsound_aliases[ animsound.animname ][ animsound.anime ] ) )
    {
        return;
    }
    
    if ( !isdefined( level.animsound_aliases[ animsound.animname ][ animsound.anime ][ animsound.notetrack ] ) )
    {
        return;
    }
    
    return level.animsound_aliases[ animsound.animname ][ animsound.anime ][ animsound.notetrack ][ "soundalias" ];
}

// Namespace debug / scripts\sp\debug
// Params 3
// Checksum 0x0, Offset: 0x5e7c
// Size: 0x31, Type: bool
function is_from_animsound( animname, anime, notetrack )
{
    return isdefined( level.animsound_aliases[ animname ][ anime ][ notetrack ][ "created_by_animSound" ] );
}

/#

    // Namespace debug / scripts\sp\debug
    // Params 1
    // Checksum 0x0, Offset: 0x5eb6
    // Size: 0x69, Type: dev
    function debug_animsoundtag( tagnum )
    {
        tag = getdvar( hashcat( @"tag", tagnum ) );
        
        if ( tag == "<dev string:x165>" )
        {
            iprintlnbold( "<dev string:x404>" );
            return;
        }
        
        tag_sound( tag, tagnum - 1 );
        setdvar( hashcat( @"tag", tagnum ), "<dev string:x165>" );
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x5f27
    // Size: 0x59, Type: dev
    function debug_animsoundtagselected()
    {
        tag = getdvar( @"tag" );
        
        if ( tag == "<dev string:x165>" )
        {
            iprintlnbold( "<dev string:x42e>" );
            return;
        }
        
        tag_sound( tag, level.animsound_selected );
        setdvar( @"tag", "<dev string:x165>" );
    }

#/

// Namespace debug / scripts\sp\debug
// Params 2
// Checksum 0x0, Offset: 0x5f88
// Size: 0x109
function tag_sound( tag, tagnum )
{
    if ( !isdefined( level.animsound_tagged ) )
    {
        return;
    }
    
    if ( !isdefined( level.animsound_tagged.animsounds[ tagnum ] ) )
    {
        return;
    }
    
    animsound = level.animsound_tagged.animsounds[ tagnum ];
    soundalias = get_alias_from_stored( animsound );
    
    if ( !isdefined( soundalias ) || is_from_animsound( animsound.animname, animsound.anime, animsound.notetrack ) )
    {
        level.animsound_aliases[ animsound.animname ][ animsound.anime ][ animsound.notetrack ][ "soundalias" ] = tag;
        level.animsound_aliases[ animsound.animname ][ animsound.anime ][ animsound.notetrack ][ "created_by_animSound" ] = 1;
    }
}

// Namespace debug / scripts\sp\debug
// Params 1
// Checksum 0x0, Offset: 0x6099
// Size: 0xeb
function find_new_chase_target( ent_num )
{
    /#
        ai = getaiarray();
        
        foreach ( guy in ai )
        {
            if ( guy getentnum() == ent_num )
            {
                level.chase_cam_target = guy;
                return;
            }
        }
        
        vehicles = getentarray( "<dev string:x1bf>", "<dev string:x1ce>" );
        
        foreach ( vehicle in vehicles )
        {
            if ( vehicle getentnum() == ent_num )
            {
                level.chase_cam_target = vehicle;
                return;
            }
        }
    #/
}

// Namespace debug / scripts\sp\debug
// Params 1
// Checksum 0x0, Offset: 0x618c
// Size: 0x88
function chasecam( ent_num )
{
    if ( !isdefined( level.chase_cam_last_num ) )
    {
        level.chase_cam_last_num = -1;
    }
    
    if ( level.chase_cam_last_num == ent_num )
    {
        return;
    }
    
    find_new_chase_target( ent_num );
    
    if ( !isdefined( level.chase_cam_target ) )
    {
        return;
    }
    
    level.chase_cam_last_num = ent_num;
    
    if ( !isdefined( level.chase_cam_ent ) )
    {
        level.chase_cam_ent = level.chase_cam_target spawn_tag_origin();
    }
    
    thread chasecam_onent( level.chase_cam_target );
}

// Namespace debug / scripts\sp\debug
// Params 1
// Checksum 0x0, Offset: 0x621c
// Size: 0x127
function chasecam_onent( ent )
{
    level notify( "new_chasecam" );
    level endon( "new_chasecam" );
    ent endon( "death" );
    level.player unlink();
    level.player playerlinktoblend( level.chase_cam_ent, "tag_origin", 2, 0.5, 0.5 );
    wait 2;
    level.player playerlinktodelta( level.chase_cam_ent, "tag_origin", 1, 180, 180, 180, 180 );
    
    for ( ;; )
    {
        wait 0.2;
        
        if ( !isdefined( level.chase_cam_target ) )
        {
            return;
        }
        
        start = level.chase_cam_target.origin;
        angles = level.chase_cam_target.angles;
        forward = anglestoforward( angles );
        forward *= 200;
        start += forward;
        angles = level.player getplayerangles();
        forward = anglestoforward( angles );
        forward *= -200;
        level.chase_cam_ent moveto( start + forward, 0.2 );
    }
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x634b
// Size: 0x8f
function viewfx()
{
    foreach ( fx in level.createfxent )
    {
        if ( isdefined( fx.looper ) )
        {
            /#
                print3d( fx.v[ "<dev string:x457>" ], "<dev string:x383>", ( 1, 1, 0 ), 1, 1.5, 200 );
            #/
        }
    }
}

// Namespace debug / scripts\sp\debug
// Params 2
// Checksum 0x0, Offset: 0x63e2
// Size: 0x31
function add_key( key, val )
{
    println( "<dev string:x45e>" + key + "<dev string:x461>" + val + "<dev string:x465>" );
}

// Namespace debug / scripts\sp\debug
// Params 1
// Checksum 0x0, Offset: 0x641b
// Size: 0x16d
function print_vehicle_info( noteworthy )
{
    if ( !isdefined( level.vnum ) )
    {
        level.vnum = 9500;
    }
    
    level.vnum++;
    layer = "bridge_helpers";
    println( "<dev string:x467>" + level.vnum );
    println( "<dev string:x46f>" );
    add_key( "origin", self.origin[ 0 ] + " " + self.origin[ 1 ] + " " + self.origin[ 2 ] );
    add_key( "angles", self.angles[ 0 ] + " " + self.angles[ 1 ] + " " + self.angles[ 2 ] );
    add_key( "targetname", "helper_model" );
    add_key( "model", self.model );
    add_key( "classname", "script_model" );
    add_key( "spawnflags", "4" );
    add_key( "_color", "0.443137 0.443137 1.000000" );
    println( "<dev string:x471>" + layer + "<dev string:x465>" );
    
    if ( isdefined( noteworthy ) )
    {
        add_key( "script_noteworthy", noteworthy );
    }
    
    println( "<dev string:x47a>" );
}

/#

    // Namespace debug / scripts\sp\debug
    // Params 1
    // Checksum 0x0, Offset: 0x6590
    // Size: 0x75, Type: dev
    function draw_dot_for_ent( entnum )
    {
        ai = getaiarray();
        
        foreach ( guy in ai )
        {
            if ( guy getentnum() != entnum )
            {
                continue;
            }
            
            guy draw_dot_for_guy();
        }
    }

#/

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x660d
// Size: 0xa5
function draw_dot_for_guy()
{
    player_angles = level.player getplayerangles();
    player_forward = anglestoforward( player_angles );
    end = level.player geteye();
    start = self geteye();
    angles = vectortoangles( start - end );
    forward = anglestoforward( angles );
    dot = vectordot( forward, player_forward );
    
    /#
        print3d( start, dot, ( 1, 0.5, 0 ) );
    #/
}

/#

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x66ba
    // Size: 0x1db, Type: dev
    function function_90f1dceaf8276e36()
    {
        setdvarifuninitialized( @"weaponlist", "<dev string:x1c>" );
        
        if ( !getdvarint( @"weaponlist" ) )
        {
            return;
        }
        
        ents = getentarray();
        list = [];
        
        foreach ( ent in ents )
        {
            if ( !isdefined( ent.code_classname ) )
            {
                continue;
            }
            
            if ( issubstr( ent.code_classname, "<dev string:x47c>" ) )
            {
                list[ ent.classname ] = 1;
            }
        }
        
        println( "<dev string:x483>" );
        
        foreach ( _ in list )
        {
            println( weapon );
        }
        
        spawners = getspawnerarray();
        classes = [];
        
        foreach ( spawner in spawners )
        {
            classes[ spawner.code_classname ] = 1;
        }
        
        println( "<dev string:x165>" );
        println( "<dev string:x499>" );
        
        foreach ( _ in classes )
        {
            println( class );
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x689d
    // Size: 0x26e, Type: dev
    function measure()
    {
        dvar = @"hash_c6a78f9ed07155ad";
        
        if ( getdvarint( dvar ) == 2 )
        {
            return;
        }
        
        thread debug_cursor();
        setdvar( dvar, 2 );
        points = [];
        next_press = 0;
        
        while ( getdvarint( dvar ) )
        {
            if ( level.player usebuttonpressed() && gettime() > next_press )
            {
                if ( points.size == 2 )
                {
                    points = [];
                }
                else
                {
                    point = level.debug.cursor_pos;
                    points[ points.size ] = point;
                }
                
                next_press = gettime() + 500;
            }
            
            foreach ( i, point in points )
            {
                draw_debug_cross( point );
                
                if ( i > 0 )
                {
                    dist = distance( point, points[ i - 1 ] );
                    forward = vectornormalize( points[ i - 1 ] - point );
                    half = point + forward * dist * 0.5;
                    print3d( half, dist, ( 1, 1, 1 ), 1, 0.5 );
                    line( point, points[ i - 1 ], ( 1, 1, 1 ) );
                }
            }
            
            if ( points.size == 2 )
            {
                color = ( 1, 0, 0 );
                color = ( 0, 1, 0 );
                color = ( 0.2, 0.2, 1 );
                sorted = points;
                
                if ( points[ 1 ][ 2 ] > sorted[ 0 ][ 2 ] )
                {
                    sorted = [ points[ 1 ], points[ 0 ] ];
                }
                
                higher = sorted[ 0 ];
                lower = ( higher[ 0 ], higher[ 1 ], sorted[ 1 ][ 2 ] );
                dist = distance( higher, lower );
                forward = vectornormalize( lower - higher );
                printpos = higher + forward * dist * 0.6;
                print3d( printpos, dist, color, 1, 0.5 );
                line( higher, lower, color );
            }
            
            waitframe();
        }
        
        level notify( "<dev string:x4ae>" );
    }

    // Namespace debug / scripts\sp\debug
    // Params 1
    // Checksum 0x0, Offset: 0x6b13
    // Size: 0x7a, Type: dev
    function function_c972a6e1ce180be4( number )
    {
        nodes = getallnodes();
        
        foreach ( current_node in nodes )
        {
            this_number = current_node getnodenumber();
            
            if ( this_number == number )
            {
                return current_node;
            }
        }
        
        return undefined;
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x6b95
    // Size: 0x67, Type: dev
    function function_1e28b43313e9982c()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_42baf942957e2497", -1 ) != -1 )
            {
                node = function_c972a6e1ce180be4( getdvarint( @"hash_42baf942957e2497", 0 ) );
                setdvar( @"hash_42baf942957e2497", -1 );
                
                if ( isdefined( node ) )
                {
                    debug_traversal( node );
                }
            }
            
            wait 0.5;
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 1
    // Checksum 0x0, Offset: 0x6c04
    // Size: 0x23f, Type: dev
    function debug_traversal( begin_node )
    {
        spawners = getspawnerarray();
        assert( spawners.size > 0 );
        chosen_spawner = undefined;
        
        foreach ( spawner in spawners )
        {
            if ( issubstr( spawner.classname, "<dev string:x4c0>" ) )
            {
                chosen_spawner = spawner;
                break;
            }
        }
        
        old_count = chosen_spawner.count;
        chosen_spawner.count = 1;
        old_stealthgroup = chosen_spawner.script_stealthgroup;
        chosen_spawner.script_stealthgroup = undefined;
        var_7c9bdd8f6f6cf722 = chosen_spawner.spawn_functions;
        chosen_spawner.spawn_functions = [];
        ai = chosen_spawner spawn_ai( 1 );
        ai.ignoreall = 1;
        chosen_spawner.count = old_count;
        chosen_spawner.script_stealthgroup = old_stealthgroup;
        chosen_spawner.spawn_functions = var_7c9bdd8f6f6cf722;
        forward = anglestoforward( begin_node.angles );
        trace_results = navtrace( begin_node.origin, begin_node.origin + forward * -128, ai, 1 );
        startpos = trace_results[ "<dev string:x356>" ];
        ai forceteleport( startpos );
        end_node = getnode( begin_node.target, "<dev string:x4c7>" );
        ai.goalradius = 32;
        ai.goalheight = 50;
        trace_results = navtrace( end_node.origin, end_node.origin + forward * 128, ai, 1 );
        endpos = trace_results[ "<dev string:x356>" ];
        ai setgoalpos( endpos );
        ai waittill( "<dev string:x4d2>" );
        wait 2;
        ai die();
    }

#/

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x6e4b
// Size: 0xdb
function take_weapons_away()
{
    storedweapons = spawnstruct();
    storedweapons.weapons = level.player getweaponslistall();
    storedweapons.clip_ammo = [];
    storedweapons.stock_ammo = [];
    
    foreach ( index, weapon in storedweapons.weapons )
    {
        storedweapons.clip_ammo[ index ] = level.player getweaponammoclip( weapon );
        storedweapons.stock_ammo[ index ] = level.player getweaponammostock( weapon );
    }
    
    level.player takeallweapons();
    return storedweapons;
}

// Namespace debug / scripts\sp\debug
// Params 1
// Checksum 0x0, Offset: 0x6f2f
// Size: 0x115
function give_weapons_back( storedweapons )
{
    switchweaponindex = -1;
    
    foreach ( index, weapon in storedweapons.weapons )
    {
        level.player giveweapon( weapon );
        
        if ( weapon.ismelee )
        {
            level.player assignweaponmeleeslot( weapon );
            continue;
        }
        
        if ( switchweaponindex < 0 )
        {
            switchweaponindex = index;
        }
        
        if ( isdefined( storedweapons.clip_ammo[ index ] ) )
        {
            level.player setweaponammoclip( weapon, storedweapons.clip_ammo[ index ] );
        }
        
        if ( isdefined( storedweapons.stock_ammo[ index ] ) )
        {
            level.player setweaponammostock( weapon, storedweapons.stock_ammo[ index ] );
        }
    }
    
    level.player switchtoweapon( storedweapons.weapons[ switchweaponindex ] );
}

// Namespace debug / scripts\sp\debug
// Params 1
// Checksum 0x0, Offset: 0x704c
// Size: 0x136
function debug_cursor( usenavmesh )
{
    level.debug.cursor_pos = ( 0, 0, 0 );
    level notify( "stop_debug_cursor" );
    level endon( "stop_debug_cursor" );
    
    if ( !isdefined( usenavmesh ) )
    {
        usenavmesh = 0;
    }
    
    while ( true )
    {
        start = level.player geteye();
        forward = anglestoforward( level.player getplayerangles() );
        
        if ( usenavmesh )
        {
            end = start + forward * 1000;
        }
        else
        {
            end = start + forward * 10000;
        }
        
        trace = scripts\engine\trace::_bullet_trace( start, end, 0 );
        
        if ( usenavmesh )
        {
            level.debug.cursor_pos = getclosestpointonnavmesh( trace[ "position" ] ) + ( 0, 0, -2 );
        }
        else
        {
            level.debug.cursor_pos = trace[ "position" ];
        }
        
        /#
            debugaxis( level.debug.cursor_pos, ( 0, 0, 0 ), 4, 1 );
        #/
        
        waitframe();
    }
}

/#

    // Namespace debug / scripts\sp\debug
    // Params 1
    // Checksum 0x0, Offset: 0x718a
    // Size: 0x9c, Type: dev
    function draw_debug_cross( pos )
    {
        range = 4;
        color = ( 1, 1, 1 );
        alpha = 1;
        depth = 1;
        duration = 1;
        line( pos - ( 0, 0, range ), pos + ( 0, 0, range ), color, alpha, depth, duration );
        line( pos - ( 0, range, 0 ), pos + ( 0, range, 0 ), color, alpha, depth, duration );
        line( pos - ( range, 0, 0 ), pos + ( range, 0, 0 ), color, alpha, depth, duration );
    }

    // Namespace debug / scripts\sp\debug
    // Params 5
    // Checksum 0x0, Offset: 0x722e
    // Size: 0xca, Type: dev
    function draw_spawner( pos, angles, color, alpha, depthtest )
    {
        if ( !isdefined( angles ) )
        {
            angles = ( 0, 0, 0 );
        }
        
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( depthtest ) )
        {
            depthtest = 0;
        }
        
        up = anglestoup( angles );
        fwd = anglestoforward( angles );
        start = pos + up * 72 * 0.5;
        end = start + fwd * 32;
        draw_small_arrow( start, end, color, alpha, depthtest );
        draw_box( pos, color, angles, [ 32, 72 ], alpha, depthtest );
    }

    // Namespace debug / scripts\sp\debug
    // Params 6
    // Checksum 0x0, Offset: 0x7300
    // Size: 0xd1, Type: dev
    function draw_node( pos, angles, color, size, alpha, depthtest )
    {
        if ( !isdefined( angles ) )
        {
            angles = ( 0, 0, 0 );
        }
        
        if ( !isdefined( size ) )
        {
            size = 32;
        }
        
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( depthtest ) )
        {
            depthtest = 0;
        }
        
        up = anglestoup( angles );
        fwd = anglestoforward( angles );
        start = pos + up * size * 0.5;
        end = start + fwd * size;
        draw_small_arrow( start, end, color, alpha, depthtest );
        draw_box( pos, color, angles, size, alpha, depthtest );
    }

    // Namespace debug / scripts\sp\debug
    // Params 5
    // Checksum 0x0, Offset: 0x73d9
    // Size: 0x133, Type: dev
    function draw_small_arrow( start, end, color, alpha, depthtest )
    {
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( depthtest ) )
        {
            depthtest = 0;
        }
        
        angle = vectortoangles( end - start );
        dist = length( end - start );
        forward = anglestoforward( angle );
        forwardfar = forward * dist;
        arrow_size = 5;
        forwardclose = forward * ( dist - arrow_size );
        right = anglestoright( angle );
        leftdraw = right * arrow_size * -1;
        rightdraw = right * arrow_size;
        line( start, end, color, alpha, depthtest, 1 );
        line( start, start + forwardfar, color, alpha, depthtest, 1 );
        line( start + forwardfar, start + forwardclose + rightdraw, color, alpha, depthtest, 1 );
        line( start + forwardfar, start + forwardclose + leftdraw, color, alpha, depthtest, 1 );
    }

    // Namespace debug / scripts\sp\debug
    // Params 6
    // Checksum 0x0, Offset: 0x7514
    // Size: 0x1ea, Type: dev
    function draw_box( pos, color, angles, size, alpha, depthtest )
    {
        if ( !isdefined( size ) )
        {
            width = 32;
            height = 32;
        }
        else if ( !isarray( size ) )
        {
            width = size;
            height = size;
        }
        else
        {
            width = size[ 0 ];
            height = size[ 1 ];
        }
        
        if ( !isdefined( angles ) )
        {
            angles = ( 0, 0, 0 );
        }
        
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( depthtest ) )
        {
            depthtest = 0;
        }
        
        forward = anglestoforward( angles );
        right = anglestoright( angles );
        up = anglestoup( angles );
        start = pos + forward * width * 0.5;
        start += right * width * 0.5;
        points = [];
        points[ points.size ] = start;
        points[ points.size ] = points[ points.size - 1 ] + forward * width * -1;
        points[ points.size ] = points[ points.size - 1 ] + right * width * -1;
        points[ points.size ] = points[ points.size - 1 ] + forward * width;
        offset = height * up;
        
        for ( i = 0; i < points.size ; i++ )
        {
            line( points[ i ], points[ i ] + offset, color, alpha, depthtest );
            
            if ( i == points.size - 1 )
            {
                line( points[ i ], points[ 0 ], color, alpha, depthtest );
                line( points[ i ] + offset, points[ 0 ] + offset, color, alpha, depthtest );
                continue;
            }
            
            line( points[ i ], points[ i + 1 ], color, alpha, depthtest );
            line( points[ i ] + offset, points[ i + 1 ] + offset, color, alpha, depthtest );
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x7706
    // Size: 0xd1, Type: dev
    function gui_giveweapon()
    {
        weapnew = getdvar( @"scr_giveweapon" );
        
        if ( isdefined( weapnew ) )
        {
            weapnewbase = getweaponbasename( weapnew );
            transient_load( "<dev string:x4d7>" + weapnewbase + "<dev string:x4df>" );
            weap = level.player getcurrentweapon();
            level.player takeweapon( weap );
            level.player giveweapon( weapnew );
            level.player setweaponammoclip( weapnew, weaponclipsize( weapnew ) );
            level.player setweaponammostock( weapnew, weaponmaxammo( weapnew ) );
            level.player switchtoweaponimmediate( weapnew );
        }
        
        setdevdvar( @"scr_giveweapon", "<dev string:x165>" );
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x77df
    // Size: 0x298, Type: dev
    function gui_giveattachment()
    {
        attachment = getdvar( @"scr_giveattachment" );
        
        if ( isdefined( attachment ) )
        {
            weap = level.player getcurrentweapon();
            weapbase = getweaponbasename( weap );
            
            if ( weapbase == "<dev string:x4e3>" )
            {
                if ( attachment == "<dev string:x4ea>" )
                {
                    attachment = "<dev string:x4ef>";
                }
                else if ( attachment == "<dev string:x4f6>" )
                {
                    attachment = "<dev string:x4fe>";
                }
                else if ( attachment == "<dev string:x508>" )
                {
                    attachment = "<dev string:x50c>";
                }
            }
            else if ( weapbase == "<dev string:x512>" )
            {
                if ( attachment == "<dev string:x4ea>" )
                {
                    attachment = "<dev string:x51a>";
                }
                else if ( attachment == "<dev string:x4f6>" )
                {
                    attachment = "<dev string:x522>";
                }
                else if ( attachment == "<dev string:x508>" )
                {
                    attachment = "<dev string:x52d>";
                }
            }
            else if ( weapbase == "<dev string:x534>" )
            {
                if ( attachment == "<dev string:x53c>" )
                {
                    attachment = "<dev string:x545>";
                }
            }
            else if ( weapbase == "<dev string:x54e>" )
            {
                if ( attachment == "<dev string:x557>" )
                {
                    attachment = "<dev string:x55f>";
                }
                else if ( attachment == "<dev string:x56e>" && weap hasattachment( "<dev string:x557>" ) )
                {
                    attachment = "<dev string:x576>";
                }
                else if ( attachment == "<dev string:x583>" && weap hasattachment( "<dev string:x557>" ) )
                {
                    attachment = "<dev string:x58d>";
                }
            }
            else if ( weapbase == "<dev string:x59c>" )
            {
                if ( attachment == "<dev string:x5ab>" )
                {
                    attachment = "<dev string:x5b0>";
                }
            }
            else if ( weapbase == "<dev string:x5bf>" )
            {
                if ( attachment == "<dev string:x5ab>" )
                {
                    attachment = "<dev string:x5cd>";
                }
            }
            
            if ( attachment != "<dev string:x5db>" )
            {
                weapnew = weapbase;
                attachments = weap.attachments;
                attachments[ attachments.size ] = attachment;
                attachments = alphabetize( attachments );
                
                foreach ( attachment in attachments )
                {
                    weapnew += "<dev string:x5e1>" + attachment;
                }
            }
            else
            {
                weapnew = weapbase;
            }
            
            level.player takeweapon( weap );
            level.player giveweapon( weapnew );
            level.player setweaponammoclip( weapnew, weaponclipsize( weapnew ) );
            level.player setweaponammostock( weapnew, weaponmaxammo( weapnew ) );
            level.player switchtoweaponimmediate( weapnew );
        }
        
        setdevdvar( @"scr_giveattachment", "<dev string:x165>" );
    }

    // Namespace debug / scripts\sp\debug
    // Params 6
    // Checksum 0x0, Offset: 0x7a7f
    // Size: 0x56, Type: dev
    function drawdoublejumpbox( pos, color, angles, size, alpha, depthtest )
    {
        pos = ( pos[ 0 ], pos[ 1 ], pos[ 2 ] - size / 2 );
        draw_box( pos, color, angles, size, alpha, depthtest );
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x7add
    // Size: 0xce, Type: dev
    function drawdoublejumpbasics()
    {
        print3d( self.origin + ( 0, 0, 32 ), self.animscript, ( 1, 1, 1 ), 1 );
        drawdoublejumpbox( self.origin, ( 0, 1, 0 ), ( 0, 0, 0 ), 32, 1, 0 );
        
        if ( isdefined( self.var_2ec927a0b0085925 ) )
        {
            line( self.origin, self.var_2ec927a0b0085925, ( 0, 1, 0 ), 1, 0 );
            drawdoublejumpbox( self.var_2ec927a0b0085925, ( 0.5, 0.5, 0.5 ), ( 0, 0, 0 ), 32, 1, 1 );
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x7bb3
    // Size: 0x87, Type: dev
    function function_c0c1cbc0f4c82c48()
    {
        drawdoublejumpbasics();
        
        if ( !isdefined( self.doublejumpmantlepos ) )
        {
            println( "<dev string:x5e3>" + self.origin );
            return;
        }
        
        line( self.origin, self.doublejumpmantlepos, ( 0, 1, 0 ), 1, 0 );
        drawdoublejumpbox( self.doublejumpmantlepos, ( 0, 0, 1 ), ( 0, 0, 0 ), 16, 1, 1 );
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x7c42
    // Size: 0x88, Type: dev
    function drawdoublejump()
    {
        drawdoublejumpbasics();
        
        if ( isdefined( self.jump_over_ent_origin ) )
        {
            level.var_1ce210ec50d008eb++;
            line( self.origin, self.jump_over_ent_origin, ( 0, 1, 0 ), 1, 0 );
            drawdoublejumpbox( self.jump_over_ent_origin, ( 0, 0, 1 ), ( 0, 0, 0 ), 16, 1, 1 );
            return;
        }
        
        level.var_8b69cee69ed3c46f++;
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x7cd2
    // Size: 0x71, Type: dev
    function function_c27a500265d8c027()
    {
        drawdoublejumpbasics();
        
        if ( isdefined( self.var_5d8aff9e6ac666b5 ) )
        {
            line( self.origin, self.var_5d8aff9e6ac666b5, ( 0, 1, 0 ), 1, 0 );
            drawdoublejumpbox( self.var_5d8aff9e6ac666b5, ( 0, 0, 1 ), ( 0, 0, 0 ), 16, 1, 1 );
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 1
    // Checksum 0x0, Offset: 0x7d4b
    // Size: 0x12f, Type: dev
    function function_3712b895c39f7012( origin )
    {
        var_fb2fb6eb30927421 = getdvarint( @"hash_a838875af4383ca1" );
        
        foreach ( t in getnodearray( "<dev string:x61e>", "<dev string:x4c7>" ) )
        {
            if ( var_fb2fb6eb30927421 != 1 )
            {
                dist = distance( t.origin, origin );
                
                if ( dist > var_fb2fb6eb30927421 )
                {
                    continue;
                }
            }
            
            switch ( t.animscript )
            {
                case #"hash_6fc6878fd3fd1e7a":
                    level.drawnvault++;
                    t function_c0c1cbc0f4c82c48();
                    break;
                case #"hash_d14662a6eb371af5":
                    t function_c0c1cbc0f4c82c48();
                    level.drawnmantle++;
                    break;
                case #"hash_5f054fa72e77b8dd":
                    t drawdoublejump();
                    break;
                case #"hash_3083e73248cdb399":
                    t function_c27a500265d8c027();
                    level.var_f43148ca7c8056c6++;
                    break;
            }
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x7e82
    // Size: 0x142, Type: dev
    function function_b1883f511d0dbba4()
    {
        while ( true )
        {
            if ( isdefined( level.player ) && isdefined( level.getnodefunction ) )
            {
                level.drawnvault = 0;
                level.drawnmantle = 0;
                level.var_f43148ca7c8056c6 = 0;
                level.var_1ce210ec50d008eb = 0;
                level.var_8b69cee69ed3c46f = 0;
                function_3712b895c39f7012( level.player.origin );
                printtoscreen2d( 50, 50, "<dev string:x672>" + level.var_1ce210ec50d008eb, ( 1, 1, 1 ), 1 );
                printtoscreen2d( 50, 75, "<dev string:x68e>" + level.var_8b69cee69ed3c46f, ( 1, 1, 1 ), 1 );
                printtoscreen2d( 50, 100, "<dev string:x6ad>" + level.var_f43148ca7c8056c6, ( 1, 1, 1 ), 1 );
                printtoscreen2d( 50, 125, "<dev string:x6ba>" + level.drawnvault, ( 1, 1, 1 ), 1 );
                printtoscreen2d( 50, 150, "<dev string:x6c1>" + level.drawnmantle, ( 1, 1, 1 ), 1 );
            }
            
            wait 0.05;
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x7fcc
    // Size: 0xe3, Type: dev
    function devlistinventory()
    {
        dvarvalue = getdvar( @"hash_3336a486aff69f38", "<dev string:x165>" );
        
        if ( dvarvalue != "<dev string:x165>" )
        {
            list = undefined;
            msg = undefined;
            bold = 0;
            
            if ( dvarvalue == "<dev string:x368>" )
            {
                msg = "<dev string:x6c9>";
                list = level.player getweaponslistall();
            }
            else if ( dvarvalue == "<dev string:x6d5>" )
            {
                msg = "<dev string:x6e4>";
                bold = 1;
                list = [ level.player getcurrentweapon() ];
            }
            else
            {
                msg = dvarvalue + "<dev string:x6f3>";
                list = level.player getweaponslist( dvarvalue );
            }
            
            level.player devprintweaponlist( list, msg, bold );
            setdevdvar( @"hash_3336a486aff69f38", "<dev string:x165>" );
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 3
    // Checksum 0x0, Offset: 0x80b7
    // Size: 0x10d, Type: dev
    function devprintweaponlist( list, msg, printbold )
    {
        println( "<dev string:x6fe>" );
        println( "<dev string:x728>" + msg );
        println( "<dev string:x6fe>" );
        
        if ( isdefined( list ) && list.size > 0 )
        {
            foreach ( weapon in list )
            {
                clipammo = self getweaponammoclip( weapon );
                stockammo = self getweaponammostock( weapon );
                weapmsg = "<dev string:x739>" + getcompleteweaponname( weapon ) + "<dev string:x73c>" + clipammo + "<dev string:x73e>" + stockammo;
                
                if ( printbold )
                {
                    iprintlnbold( weapmsg );
                    continue;
                }
                
                println( weapmsg );
            }
        }
        else
        {
            println( "<dev string:x740>" );
        }
        
        println( "<dev string:x6fe>" );
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x81cc
    // Size: 0xd4, Type: dev
    function function_870394ae4c5e2029()
    {
        if ( !isdefined( level.placedweapons ) )
        {
            return;
        }
        
        if ( !getdvarint( @"hash_90c35ec29eb76f0", 0 ) )
        {
            return;
        }
        
        weapons = array_removeundefined( level.placedweapons );
        
        foreach ( weapon in weapons )
        {
            line( level.player.origin, weapon.origin, ( 0, 1, 0 ), 1, 0 );
            weapon thread debug_printweaponname( "<dev string:x749>", weapon, undefined, 2, ( 0, 1, 0 ) );
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x82a8
    // Size: 0x103, Type: dev
    function function_6519fa80e1e5411e()
    {
        if ( !getdvarint( @"hash_9948014b33a0e323", 0 ) )
        {
            return;
        }
        
        ais = getaiarray();
        ais = array_removeundefined( ais );
        ais = array_removedead_or_dying( ais, 1 );
        
        foreach ( ai in ais )
        {
            if ( istrue( ai.usescriptedweapon ) )
            {
                ai thread debug_printweaponname( "<dev string:x752>" + ai.weapon getentnum(), ai.weapon, undefined, 68, ( 1, 0, 0 ) );
                continue;
            }
            
            ai thread debug_printweaponname( "<dev string:x75a>" + ai.weapon getentnum(), ai.weapon, undefined, 68, ( 1, 0, 0 ) );
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x83b3
    // Size: 0xbc, Type: dev
    function function_eafac20b89f548a2()
    {
        if ( !getdvarint( @"hash_c5fc60671c328201", 0 ) )
        {
            return;
        }
        
        weapons = getweaponarray();
        
        foreach ( weapon in weapons )
        {
            line( level.player.origin, weapon.origin, ( 0.25, 0.25, 1 ), 1, 0 );
            weapon thread debug_printweaponname( "<dev string:x75d>", weapon, undefined, 2, ( 0.25, 0.25, 1 ) );
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x8477
    // Size: 0xad, Type: dev
    function function_77863cf5d430f859()
    {
        if ( !getdvarint( @"hash_965c4785698b6c50", 0 ) )
        {
            return;
        }
        
        weapons = level.player getweaponslistall();
        x_offset = 120;
        
        foreach ( weapon in weapons )
        {
            level.player thread debug_printweaponname( "<dev string:x165>", weapon, x_offset, 120, ( 0, 1, 1 ) );
            x_offset += 300;
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 5
    // Checksum 0x0, Offset: 0x852c
    // Size: 0x28c, Type: dev
    function debug_printweaponname( prefix, weapon, x_offset, z_offset, color )
    {
        anchor = undefined;
        
        if ( isdefined( self ) && level != self )
        {
            anchor = self.origin;
            
            if ( isai( self ) && isdefined( self.classname ) )
            {
                print3d( self.origin + ( 0, 0, 0 ), self.classname, ( 1, 1, 1 ), 1, 0.1, 1, 1 );
            }
        }
        else
        {
            anchor = weapon.origin;
        }
        
        if ( isweapon( weapon ) )
        {
            complete_name = getcompleteweaponname( weapon );
        }
        else
        {
            complete_name = weapon.classname;
        }
        
        toks = strtok( complete_name, "<dev string:x5e1>" );
        attach_height = z_offset;
        
        if ( isdefined( toks[ 0 ] ) )
        {
            if ( isplayer( self ) )
            {
                printtoscreen2d( x_offset, attach_height, toks[ 0 ], color, 1.5 );
            }
            
            if ( toks.size > 1 )
            {
                for ( i = toks.size - 1; i > 0 ; i-- )
                {
                    if ( isplayer( self ) )
                    {
                        attach_height += 20;
                        printtoscreen2d( x_offset, attach_height, "<dev string:x739>" + toks[ i ], ( 1, 1, 1 ), 1.5 );
                        continue;
                    }
                    
                    print3d( anchor + ( 0, 0, attach_height ), "<dev string:x739>" + toks[ i ], ( 1, 1, 1 ), 1, 0.1, 1 );
                    attach_height += 1.4;
                }
            }
            
            if ( isplayer( self ) )
            {
                return;
            }
            
            if ( !isai( self ) )
            {
                print3d( anchor + ( 0, 0, attach_height + 0.1 ), "<dev string:x767>" + weapon.origin, ( 1, 1, 1 ), 1, 0.125, 1 );
                print3d( anchor + ( 0, 0, attach_height + 1.9 ), prefix + "<dev string:x770>" + weapon getentnum() + "<dev string:x73c>" + toks[ 0 ], color, 1, 0.15, 1 );
                return;
            }
            
            print3d( anchor + ( 0, 0, attach_height + 0.1 ), prefix + "<dev string:x73c>" + toks[ 0 ], color, 1, 0.15, 1 );
            print3d( anchor + ( 0, 0, attach_height + 1.9 ), "<dev string:x773>" + self getentnum(), color, 1, 0.15, 1 );
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 1
    // Checksum 0x0, Offset: 0x87c0
    // Size: 0xf7, Type: dev
    function print_timer( label )
    {
        level notify( "<dev string:x77d>" );
        level endon( "<dev string:x77d>" );
        
        if ( isdefined( level.print_timer ) )
        {
            if ( isdefined( level.print_timer.labelhud ) )
            {
                level.print_timer.labelhud destroy();
            }
            
            level.print_timer destroy();
        }
        
        hud = newhudelem();
        hud.x = 320;
        hud.y = 350;
        
        if ( isdefined( label ) )
        {
            hud.label = label + "<dev string:x73c>";
        }
        
        level.print_timer = hud;
        start_time = gettime();
        
        while ( true )
        {
            wait 0.05;
            time = ( gettime() - start_time ) * 0.001;
            hud setvalue( time );
        }
    }

#/

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x88bf
// Size: 0x119
function display_ai_group_info()
{
    if ( !isdefined( level._ai_group ) )
    {
        return;
    }
    
    foreach ( struct in level._ai_group )
    {
        foreach ( guy in struct.ai )
        {
            if ( isalive( guy ) )
            {
                if ( guy.team == "axis" )
                {
                    color = ( 1, 0, 0 );
                }
                else
                {
                    color = ( 0, 1, 0 );
                }
                
                /#
                    print3d( guy.origin + ( 0, 0, 50 ), groupname, color, 1, 1.2, 1 );
                #/
            }
        }
    }
}

/#

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x89e0
    // Size: 0x95, Type: dev
    function show_animnames()
    {
        ais = getaiarray();
        
        foreach ( guy in ais )
        {
            if ( isdefined( guy.animname ) )
            {
                print3d( guy.origin, guy.animname, ( 1, 1, 1 ), 1, 0.75 );
            }
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 4
    // Checksum 0x0, Offset: 0x8a7d
    // Size: 0xe6, Type: dev
    function function_e31e954e5ae9ad1d( msg, offset, scale, color )
    {
        self endon( "<dev string:x131>" );
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        if ( !isdefined( offset ) )
        {
            offset = ( 0, 0, 0 );
        }
        
        if ( !isdefined( scale ) )
        {
            scale = 0.25;
        }
        
        steps = 3 * scale * 20;
        alpha = 1;
        alpha_lerp = 1 / steps;
        
        for ( i = 0; i < steps ; i++ )
        {
            wait 0.05;
            alpha -= alpha_lerp;
            alpha = min( alpha, 1 );
            print3d( self.origin + offset, msg, color, alpha, scale );
            offset += ( 0, 0, 1 );
        }
    }

    // Namespace debug / scripts\sp\debug
    // Params 0
    // Checksum 0x0, Offset: 0x8b6b
    // Size: 0x27f, Type: dev
    function function_c8ce49adbbdfe59b()
    {
        teams = [ "<dev string:x37e>", "<dev string:x78e>", "<dev string:x795>", "<dev string:x79b>", "<dev string:x7a3>", "<dev string:x7a9>", "<dev string:x7b5>" ];
        y = 70;
        
        foreach ( team in teams )
        {
            if ( team == "<dev string:x7a9>" )
            {
                count = getaicount( "<dev string:x368>", "<dev string:x368>", "<dev string:x7a9>" );
                color = function_a08c7d9bf42ca575( count, 10, 15 );
            }
            else
            {
                ai_array = getaiarray();
                
                if ( getdvarint( @"hash_8beca11d7b55550e" ) )
                {
                    line_colors[ "<dev string:x78e>" ] = ( 0, 1, 0 );
                    line_colors[ "<dev string:x37e>" ] = ( 1, 0, 0 );
                    line_colors[ "<dev string:x7bb>" ] = ( 0, 1, 1 );
                    
                    foreach ( guy in ai_array )
                    {
                        line_color = default_to( line_colors[ guy.team ], line_colors[ "<dev string:x7bb>" ] );
                        line( guy.origin, level.player.origin, line_color, 1, 0, 1 );
                    }
                }
                
                if ( team == "<dev string:x7b5>" )
                {
                    count = ai_array.size;
                    color = function_a08c7d9bf42ca575( count, 10, 25 );
                }
                else if ( team == "<dev string:x7a3>" )
                {
                    alive = array_removedead_or_dying( ai_array );
                    count = ai_array.size - alive.size;
                    color = function_a08c7d9bf42ca575( count, 5, 10 );
                }
                else
                {
                    ai_array = getaiarray( team );
                    ai_array = array_removedead_or_dying( ai_array );
                    count = ai_array.size;
                    color = function_a08c7d9bf42ca575( count, 10, 25 );
                }
            }
            
            printtoscreen2d( 1000, y, count + "<dev string:x73c>" + team, color, 1.2 );
            y += 15;
        }
    }

#/

// Namespace debug / scripts\sp\debug
// Params 3
// Checksum 0x0, Offset: 0x8df2
// Size: 0x64
function function_a08c7d9bf42ca575( count, green_count, yellow_count )
{
    if ( count <= green_count )
    {
        color = ( 0, 1, 0 );
    }
    else if ( count <= yellow_count )
    {
        color = ( 1, 1, 0 );
    }
    else
    {
        color = ( 1, 0, 0 );
    }
    
    return color;
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x8e5f
// Size: 0x579
function debug_magic()
{
    dvar_name = @"debug_magic";
    var_756353f0fc25fcd2 = @"hash_1fc275563e007fbb";
    setdvarifuninitialized( dvar_name, "0" );
    setdvarifuninitialized( var_756353f0fc25fcd2, "0" );
    thread function_ac2275eb6e8444f0();
    
    foreach ( spawner in getspawnerarray() )
    {
        spawner.spawner_targetname = spawner.targetname;
        spawner.orig_count = spawner.count;
        spawner add_spawn_function( &function_b64f3d4029e87e07 );
    }
    
    var_2052c03f81dcd487 = 0;
    
    for ( ;; )
    {
        if ( getdvar( dvar_name ) != "0" )
        {
            allies = getaiarray( "allies", "axis" );
            
            foreach ( ally in allies )
            {
                str = "";
                
                if ( isdefined( ally.script_noteworthy ) )
                {
                    str += "nw: " + ally.script_noteworthy + "\n";
                }
                
                if ( isdefined( ally.spawner_targetname ) )
                {
                    str += "stn: " + ally.spawner_targetname + "\n";
                }
                
                color = ( 1, 1, 1 );
                
                if ( isdefined( ally.script_forcecolor ) )
                {
                    color = get_script_palette()[ ally.script_forcecolor ];
                }
                
                if ( isdefined( ally.magic_bullet_shield ) )
                {
                    str += "magic\n";
                }
                
                if ( isdefined( ally.var_1c12c7a661085303 ) && isdefined( ally.orig_count ) && isdefined( ally.spawn_number ) && ally.orig_count > 1 )
                {
                    str += ally.spawn_number + " of " + ally.orig_count;
                }
                
                if ( isdefined( ally.script_parameters ) )
                {
                    str += "params: " + ally.script_parameters + "\n";
                }
                
                goalvolume = ally getgoalvolume();
                
                if ( isdefined( goalvolume ) && isdefined( goalvolume.targetname ) )
                {
                    str += "goalvolume: " + goalvolume.targetname + "\n";
                }
                
                ai_group = ally.script_aigroup;
                
                if ( isdefined( ai_group ) )
                {
                    str += "ai_group: " + ai_group + "\n";
                }
                
                if ( isdefined( ally.goalradius ) )
                {
                    str += "radius: " + ally.goalradius + "\n";
                }
                
                if ( isdefined( ally.fixednode ) )
                {
                    str += "fixednode: " + ally.fixednode + "\n";
                }
                
                if ( istrue( ally.ignoreall ) )
                {
                    str += "ignoreall: true\n";
                }
                else
                {
                    str += "ignoreall: false\n";
                }
                
                if ( istrue( ally.ignoreme ) )
                {
                    str += "ignoreme: true\n";
                }
                else
                {
                    str += "ignoreme: false\n";
                }
                
                if ( isdefined( ally.health ) )
                {
                    str += "health: " + ally.health + "\n";
                }
                
                if ( ally scripts\sp\nvg\nvg_ai::can_use_flashlight() )
                {
                    flashlight_str = "";
                    
                    if ( is_equal( ally.asmflashlight, 1 ) )
                    {
                        flashlight_str += "asm ";
                    }
                    
                    if ( isdefined( ally._blackboard ) && istrue( ally._blackboard.bflashlight ) )
                    {
                        flashlight_str += "bb ";
                    }
                    
                    if ( is_equal( ally.flashlight, 1 ) )
                    {
                        flashlight_str += "nav ";
                    }
                    
                    if ( isdefined( ally.flashlightmodel ) )
                    {
                        flashlight_str += "model ";
                    }
                    
                    if ( isdefined( ally.flashlightfx ) )
                    {
                        flashlight_str += "fx ";
                    }
                    
                    if ( isdefined( ally.var_da68f53643135f5 ) )
                    {
                        flashlight_str += "swap=" + ally.var_da68f53643135f5;
                    }
                    
                    if ( flashlight_str != "" )
                    {
                        str += "flashlight: " + flashlight_str + "\n";
                    }
                }
                
                lines = strtok( str, "\n" );
                line_height = 5;
                offset = 80 + line_height * lines.size;
                
                foreach ( threat_line in lines )
                {
                    /#
                        print3d( ally.origin + ( 0, 0, offset ), threat_line, color, 1, 0.25 );
                        offset -= line_height;
                    #/
                }
            }
        }
        else
        {
            wait 1;
        }
        
        waitframe();
    }
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x93e0
// Size: 0x6f
function function_b64f3d4029e87e07()
{
    if ( isdefined( self.spawner ) && isdefined( self.spawner.count ) && isdefined( self.spawner.orig_count ) )
    {
        self.spawn_number = self.spawner.orig_count - self.spawner.count;
    }
}

// Namespace debug / scripts\sp\debug
// Params 0
// Checksum 0x0, Offset: 0x9457
// Size: 0x1e2
function function_ac2275eb6e8444f0()
{
    level.player endon( "death" );
    dvar_name = @"debug_magic";
    var_756353f0fc25fcd2 = @"hash_1fc275563e007fbb";
    var_f84a18555d8a014a = 25;
    var_f84a19555d8a037d = 50;
    color_off = ( 1, 0, 0 );
    color_on = ( 0, 1, 0 );
    dt = 0.1;
    dt_frames = int( dt * 20 );
    
    while ( true )
    {
        if ( getdvar( dvar_name ) != "0" || getdvar( var_756353f0fc25fcd2 ) != "0" )
        {
            if ( level.player.ignoreme )
            {
                text = "Player Ignore Me : ON";
                color = color_on;
            }
            else
            {
                text = "Player Ignore Me : OFF";
                color = color_off;
            }
            
            /#
                printtoscreen2d( var_f84a18555d8a014a, var_f84a19555d8a037d, text, color, 2 );
            #/
            
            if ( level.player.notarget )
            {
                text = "Player No Target : ON";
                color = color_on;
            }
            else
            {
                text = "Player No Target : OFF";
                color = color_off;
            }
            
            /#
                printtoscreen2d( var_f84a18555d8a014a, var_f84a19555d8a037d + 25, text, color, 2 );
            #/
            
            if ( level.player isinvulnerable() || isgodmode( level.player ) )
            {
                text = "God Mode : ON";
                color = color_on;
            }
            else
            {
                text = "God Mode : OFF";
                color = color_off;
            }
            
            /#
                printtoscreen2d( var_f84a18555d8a014a, var_f84a19555d8a037d + 50, text, color, 2 );
            #/
            
            text = "Health : " + level.player.health;
            color = color_on;
            
            /#
                printtoscreen2d( var_f84a18555d8a014a, var_f84a19555d8a037d + 75, text, color, 2 );
            #/
        }
        
        waitframe();
    }
}

