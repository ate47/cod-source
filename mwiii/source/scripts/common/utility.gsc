#using scripts\anim\shared;
#using scripts\asm\asm_bb;
#using scripts\common\anim;
#using scripts\common\devgui;
#using scripts\common\dof;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_paths;
#using scripts\engine\flags;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace utility;

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0xd85
// Size: 0x8d
function issp()
{
    if ( !isdefined( level.issp ) )
    {
        mapname = getdvar( @"g_mapname" );
        substring = "";
        
        for ( i = 0; i < min( mapname.size, 3 ) ; i++ )
        {
            substring += mapname[ i ];
        }
        
        level.issp = substring != "mp_" && substring != "cp_" && substring != "zm_";
    }
    
    return level.issp;
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0xe1b
// Size: 0x1a
function iscp()
{
    return isstartstr( getdvar( @"g_mapname" ), "cp_" );
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0xe3e
// Size: 0x3f, Type: bool
function ismp()
{
    return isstartstr( getdvar( @"mapname" ), "mp_" ) || isdefined( level.mapname ) && isstartstr( level.mapname, "mp_" );
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0xe86
// Size: 0x1b
function function_ccf98e6391dd38b9()
{
    return string_starts_with( getdvar( @"g_mapname" ), "cp_jup_" );
}

// Namespace utility / scripts\common\utility
// Params 4
// Checksum 0x0, Offset: 0xeaa
// Size: 0x2f1
function make_weapon_model( basename, attachments, viewmodel, precache )
{
    if ( !isdefined( attachments ) )
    {
        attachments = [];
    }
    
    if ( !isdefined( viewmodel ) )
    {
        viewmodel = 0;
    }
    
    if ( isdefined( level.fnbuildweaponspecial ) && isdefined( [[ level.fnbuildweaponspecial ]]( basename ) ) )
    {
        weapon = [[ level.fnbuildweaponspecial ]]( basename );
    }
    else
    {
        weapon = [[ level.fnbuildweapon ]]( basename, attachments );
    }
    
    if ( isent( self ) && !isdefined( precache ) )
    {
        self setmodel( getweaponmodel( weapon ) );
    }
    
    attachmentmodels = getweaponattachmentworldmodels( weapon );
    
    foreach ( model in attachmentmodels )
    {
        if ( istrue( viewmodel ) )
        {
            array = strtok( model, "_" );
            
            foreach ( i, tok in array )
            {
                if ( i == 0 )
                {
                    model = tok;
                    continue;
                }
                
                if ( tok == "wm" )
                {
                    model += "_vm";
                    continue;
                }
                
                model = model + "_" + tok;
            }
        }
        
        if ( istrue( precache ) )
        {
            precachemodel( model );
            continue;
        }
        
        self attach( model );
    }
    
    if ( !istrue( precache ) )
    {
        switch ( basename )
        {
            case #"hash_bf2d3ffce9ef56d1":
                self hidepart( "j_b_loader" );
                self hidepart( "j_b_loader_01" );
                self hidepart( "j_b_loader_02" );
                self hidepart( "j_b_loader_03" );
                self hidepart( "j_b_loader_04" );
                self hidepart( "j_b_loader_05" );
                self hidepart( "j_b_loader_06" );
                break;
            case #"hash_9703d13dcfc6b555":
                self hidepart( "j_shell" );
                self hidepart( "j_shell_fired" );
                break;
        }
        
        foreach ( model in attachmentmodels )
        {
            part = "tag_sight_on";
            
            if ( issubstr( model, "reflex" ) && has_part( model, part ) )
            {
                self hidepart( part );
                continue;
            }
            
            if ( issubstr( model, "holo" ) )
            {
                self hidepart( part );
                continue;
            }
            
            if ( issubstr( model, "acog" ) )
            {
                self hidepart( part );
                continue;
            }
            
            if ( issubstr( model, "scope" ) )
            {
                self hidepart( part );
            }
        }
    }
}

// Namespace utility / scripts\common\utility
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x11a3
// Size: 0x4c, Type: bool
function private has_part( model, part )
{
    numparts = getnumparts( model );
    
    for ( i = 0; i < numparts ; i++ )
    {
        if ( part == getpartname( model, i ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\common\utility
// Params 5
// Checksum 0x0, Offset: 0x11f8
// Size: 0x393
function make_weapon_and_attach( basename, attachments, tagname, viewmodel, precache )
{
    if ( !istrue( precache ) )
    {
        isvalid = 0;
        
        if ( isent( self ) || isai( self ) )
        {
            isvalid = 1;
        }
        
        assertex( isvalid, "<dev string:x1c>" );
    }
    
    if ( !isdefined( attachments ) )
    {
        attachments = [];
    }
    
    if ( !isdefined( viewmodel ) )
    {
        viewmodel = 0;
    }
    
    if ( isdefined( level.fnbuildweaponspecial ) && isdefined( [[ level.fnbuildweaponspecial ]]( basename ) ) )
    {
        weapon = [[ level.fnbuildweaponspecial ]]( basename );
    }
    else
    {
        weapon = [[ level.fnbuildweapon ]]( basename, attachments );
    }
    
    if ( !istrue( precache ) )
    {
        if ( isdefined( tagname ) )
        {
            self attach( getweaponmodel( basename ), tagname );
        }
        else
        {
            self attach( getweaponmodel( basename ) );
        }
    }
    
    self.attachedweaponmodels[ 0 ] = basename;
    attachmentmodels = getweaponattachmentworldmodels( weapon );
    lasermodelindex = undefined;
    var_ad93b928c004e7e9 = undefined;
    
    for ( i = 0; i < attachmentmodels.size ; i++ )
    {
        if ( istrue( var_ad93b928c004e7e9 ) )
        {
            model = attachmentmodels[ lasermodelindex ];
        }
        else
        {
            model = attachmentmodels[ i ];
        }
        
        if ( !isdefined( var_ad93b928c004e7e9 ) && isstartstr( model, "att_wm_laser" ) )
        {
            lasermodelindex = i;
            continue;
        }
        
        if ( istrue( viewmodel ) )
        {
            array = strtok( model, "_" );
            
            foreach ( i, tok in array )
            {
                if ( i == 0 )
                {
                    model = tok;
                    continue;
                }
                
                if ( tok == "wm" )
                {
                    model += "_vm";
                    continue;
                }
                
                model = model + "_" + tok;
            }
        }
        
        if ( istrue( precache ) )
        {
            precachemodel( model );
        }
        else
        {
            self attach( model );
            self.attachedweaponmodels = array_add( self.attachedweaponmodels, model );
        }
        
        if ( !isdefined( var_ad93b928c004e7e9 ) && isdefined( lasermodelindex ) && i == attachmentmodels.size - 1 )
        {
            i -= 1;
            var_ad93b928c004e7e9 = 1;
        }
    }
    
    if ( !istrue( precache ) )
    {
        switch ( basename )
        {
            case #"hash_bf2d3ffce9ef56d1":
                self hidepart( "j_b_loader" );
                self hidepart( "j_b_loader_01" );
                self hidepart( "j_b_loader_02" );
                self hidepart( "j_b_loader_03" );
                self hidepart( "j_b_loader_04" );
                self hidepart( "j_b_loader_05" );
                self hidepart( "j_b_loader_06" );
                break;
            case #"hash_9703d13dcfc6b555":
                self hidepart( "j_shell" );
                self hidepart( "j_shell_fired" );
                break;
        }
        
        foreach ( model in attachmentmodels )
        {
            part = "tag_sight_on";
            
            if ( has_part( model, part ) )
            {
                if ( issubstr( model, "reflex" ) )
                {
                    self hidepart( part );
                    continue;
                }
                
                if ( issubstr( model, "holo" ) )
                {
                    self hidepart( part );
                    continue;
                }
                
                if ( issubstr( model, "acog" ) )
                {
                    self hidepart( part );
                }
            }
        }
    }
}

// Namespace utility / scripts\common\utility
// Params 5
// Checksum 0x0, Offset: 0x1593
// Size: 0x409
function make_weapon_random( weaponname, var_e052c0161d3ef54, attachment_combos, camos, randomizereticle )
{
    attachments = get_random_attachments( var_e052c0161d3ef54, attachment_combos );
    weapon = [[ level.fnbuildweapon ]]( weaponname, attachments );
    
    /#
        if ( getdvarint( @"hash_45281f93550798" ) )
        {
            if ( !isdefined( weapon ) )
            {
                complete_weapon = weaponname;
                
                foreach ( attachment in attachments )
                {
                    complete_weapon += "<dev string:x5b>" + attachment;
                }
                
                iprintlnbold( complete_weapon + "<dev string:x60>" );
                return [[ level.fnbuildweapon ]]( weaponname );
            }
            
            var_84dc1762e26a54bb = undefined;
            attachment_models = getweaponattachmentworldmodels( weapon );
            
            foreach ( attachment_model in attachment_models )
            {
                part_num = getnumparts( attachment_model );
                
                for ( i = 0; i < part_num ; i++ )
                {
                    if ( getpartname( attachment_model, i ) == "<dev string:x74>" )
                    {
                        var_84dc1762e26a54bb = 1;
                        break;
                    }
                }
            }
            
            if ( !isdefined( var_84dc1762e26a54bb ) && !issubstr( weaponname, "<dev string:x80>" ) && !issubstr( weaponname, "<dev string:x88>" ) && !issubstr( weaponname, "<dev string:x90>" ) )
            {
                iprintlnbold( getcompleteweaponname( weapon ) + "<dev string:x98>" );
            }
            
            var_a1b938aeb3589f83 = 1;
            
            foreach ( possibility in var_e052c0161d3ef54 )
            {
                probability_100 = 0;
                
                if ( isint( possibility[ 0 ] ) && possibility[ 0 ] == 100 )
                {
                    probability_100 = -1;
                }
                
                var_a1b938aeb3589f83 *= possibility.size + probability_100;
            }
            
            println( "<dev string:xb3>" + weaponname + "<dev string:xc2>" + var_a1b938aeb3589f83 );
        }
    #/
    
    if ( isdefined( camos ) && camos.size > 0 && cointoss() )
    {
        weapon = weapon withcamo( camos[ randomint( camos.size ) ] );
    }
    
    if ( istrue( randomizereticle ) )
    {
        foreach ( attachment in attachments )
        {
            if ( isstartstr( attachment, "acog" ) )
            {
                weapon = weapon withreticle( randomint( 8 ) );
                continue;
            }
            
            if ( isstartstr( attachment, "hybrid_west" ) )
            {
                weapon = weapon withreticle( randomint( 8 ) );
                continue;
            }
            
            if ( isstartstr( attachment, "thermalsnpr" ) )
            {
                weapon = weapon withreticle( randomint( 8 ) );
                continue;
            }
            
            if ( isstartstr( attachment, "thermal" ) )
            {
                weapon = weapon withreticle( randomint( 8 ) );
                continue;
            }
            
            if ( isstartstr( attachment, "holo" ) )
            {
                weapon = weapon withreticle( randomint( 11 ) );
                continue;
            }
            
            if ( isstartstr( attachment, "reflex" ) )
            {
                weapon = weapon withreticle( randomint( 12 ) );
                continue;
            }
            
            if ( isstartstr( attachment, "minireddot" ) )
            {
                weapon = weapon withreticle( randomint( 10 ) );
                continue;
            }
            
            if ( isstartstr( attachment, "snprscope" ) )
            {
                weapon = weapon withreticle( randomint( 13 ) );
                continue;
            }
            
            if ( isstartstr( attachment, "vzscope" ) )
            {
                weapon = weapon withreticle( randomint( 13 ) );
            }
        }
    }
    
    return weapon;
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x19a5
// Size: 0x25b
function get_random_attachments( var_e052c0161d3ef54, attachment_combos )
{
    assertex( isdefined( var_e052c0161d3ef54 ), "<dev string:xd5>" );
    
    if ( isdefined( attachment_combos ) && attachment_combos.size > 0 )
    {
        if ( var_e052c0161d3ef54.size < 1 )
        {
            return attachment_combos[ randomint( attachment_combos.size ) ];
        }
        
        if ( randomint( 4 ) == 0 )
        {
            return attachment_combos[ randomint( attachment_combos.size ) ];
        }
    }
    
    attachments = [];
    
    if ( var_e052c0161d3ef54.size < 1 )
    {
        return attachments;
    }
    
    foreach ( i, type in var_e052c0161d3ef54 )
    {
        if ( isint( var_e052c0161d3ef54[ i ][ 0 ] ) )
        {
            if ( randomint( 100 ) < var_e052c0161d3ef54[ i ][ 0 ] )
            {
                if ( level.script == "nightwar" && i == "scopes" )
                {
                    newtype = [];
                    
                    foreach ( s, scope in type )
                    {
                        if ( !issubstr( type[ s ], "therm" ) && !issubstr( type[ s ], "nvg" ) )
                        {
                            newtype = array_add( newtype, scope );
                        }
                    }
                    
                    type = newtype;
                }
                
                if ( type.size > 1 )
                {
                    attachments = array_add( attachments, type[ randomint( type.size - 1 ) + 1 ] );
                }
            }
            
            continue;
        }
        
        return attachments;
    }
    
    ub_entry = undefined;
    grip_entry = undefined;
    
    foreach ( i, attachment in attachments )
    {
        if ( string_starts_with( attachment, "grip" ) )
        {
            grip_entry = i;
            continue;
        }
        
        if ( issubstr( attachment, "ub_" ) || issubstr( attachment, "glmini" ) )
        {
            ub_entry = i;
        }
    }
    
    if ( isdefined( ub_entry ) && isdefined( grip_entry ) )
    {
        if ( randomint( 3 ) == 0 )
        {
            attachments = array_remove_index( attachments, ub_entry );
        }
        else
        {
            attachments = array_remove_index( attachments, grip_entry );
        }
    }
    
    return attachments;
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x1c09
// Size: 0x266
function get_weapon_weighted( weapons, definedprobabilities )
{
    probabilities = [];
    keys = getarraykeys( definedprobabilities );
    
    foreach ( i, weapon in weapons )
    {
        index = array_find( keys, weapon );
        
        if ( isdefined( index ) )
        {
            probabilities[ probabilities.size ] = definedprobabilities[ keys[ index ] ];
            continue;
        }
        
        probabilities[ probabilities.size ] = 0;
    }
    
    probability_total = 0;
    
    foreach ( probability in probabilities )
    {
        probability_total += probability;
    }
    
    /#
        if ( probability_total > 100 )
        {
            println( "<dev string:x106>" + probability_total );
        }
    #/
    
    if ( probability_total < 100 )
    {
        remaining = 100 - probability_total;
        empty_entries = 0;
        
        foreach ( probability in probabilities )
        {
            if ( probability == 0 )
            {
                empty_entries += 1;
            }
        }
        
        if ( empty_entries > 0 )
        {
            split_probability = remaining / empty_entries;
            
            foreach ( i, probability in probabilities )
            {
                if ( probability == 0 )
                {
                    probabilities[ i ] = split_probability;
                }
            }
        }
    }
    
    diceroll = randomint( 100 );
    
    foreach ( i, probability in probabilities )
    {
        if ( i > 0 )
        {
            probabilities[ i ] = probability + probabilities[ i - 1 ];
        }
        
        if ( diceroll < probabilities[ i ] )
        {
            return weapons[ i ];
        }
    }
    
    /#
        if ( getdvarint( @"hash_45281f93550798" ) )
        {
            if ( weapons.size > 1 )
            {
                println( "<dev string:x141>" );
            }
        }
    #/
    
    return weapons[ 0 ];
}

// Namespace utility / scripts\common\utility
// Params 3
// Checksum 0x0, Offset: 0x1e78
// Size: 0x95e
function removeconflictingattachments( attachments, defaults, var_7e0e2d906d6a6287 )
{
    if ( issp() )
    {
        if ( isdefined( var_7e0e2d906d6a6287 ) )
        {
            if ( !issubstr( var_7e0e2d906d6a6287, "iw9_" ) || issubstr( var_7e0e2d906d6a6287, "iw9_" ) && !getdvarint( @"hash_23a1118f1a92bcdd", 0 ) )
            {
                return removeconflictingdefaultattachment_new( attachments, defaults, var_7e0e2d906d6a6287 );
            }
        }
        
        defaults = removeconflictingdefaultattachment( attachments, defaults );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "bar", "front_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "barlong", "slide_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "barcust", "guard_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "stock", "back_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "cal", "mag_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "drums", "mag_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "xmag", "mag_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "xmags", "mag_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "rack", "mag_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "mmags", "mag_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "box_", "mag_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "xmagslrg", "xmags_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "mag_", "xmags_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "rack", "ammo_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "thermal", "snprscope" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "acog", "snprscope" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "reflex", "snprscope" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "holo", "snprscope" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "hybrid", "snprscope" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "vzscope", "snprscope" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "minireddot", "snprscope" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "thermal", "ironsdefault_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "acog", "ironsdefault_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "reflex", "ironsdefault_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "holo", "ironsdefault_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "hybrid", "ironsdefault_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "vzscope", "ironsdefault_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "minireddot", "ironsdefault_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "scope", "ironsdefault_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "snprscope", "ironsdefault_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "irons", "ironsdefault_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "wounded_", "grip" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "grip", "gripcust_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "griprail", "grip_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "ironsdefault_", "snprscope" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "thermal", "iw8_ironsdefault_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "acog", "iw8_ironsdefault_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "reflex", "iw8_ironsdefault_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "holo", "iw8_ironsdefault_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "hybrid", "iw8_ironsdefault_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "vzscope", "iw8_ironsdefault_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "minireddot", "iw8_ironsdefault_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "scope", "iw8_ironsdefault_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "snprscope", "iw8_ironsdefault_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "irons", "iw8_ironsdefault_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "bar", "iw8_front_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "stock", "iw8_back_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "barlong", "iw8_slide_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "cal", "iw8_mag_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "drums", "iw8_mag_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "xmags", "iw8_mag_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "rack", "iw8_mag_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "mmags", "iw8_mag_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "box_", "iw8_mag_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "barsil", "bar_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "barbrake", "bar_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "barcomp", "bar_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "bartube", "bar_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "bar", "barsil_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "ub", "select" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "ub", "iw9_select" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "ub", "grip" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "glmini", "select" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "glmini", "iw9_select" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "stockno", "stock" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "stock", "stockr" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "stockr", "stock" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "stockp", "stockno_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "fourx", "ironsdefault" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "snscope", "ironsdefault" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "iw9_minireddot", "ironsdefault" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "pgolf1_scope", "ironsdefault" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "mike24_scope", "ironsdefault" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "shscope", "ironsdefault" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "arscope", "ironsdefault" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "dmscope", "ironsdefault" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "hybrid", "ironsdefault" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "fourx", "iw9_ironsdefault" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "holo", "iw9_ironsdefault" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "hybrid", "iw9_ironsdefault" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "reflex", "iw9_ironsdefault" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "thermal", "iw9_ironsdefault" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "arscope", "iw9_ironsdefault" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "iw9_minireddot", "iw9_ironsdefault" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "piscope", "iw9_ironsdefault" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "dmscope", "iw9_ironsdefault" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "vzscope", "iw9_ironsdefault" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "drum_", "mag_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "mag_", "mag_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "belt_", "mag_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "mag_", "belt_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "mag_", "drum_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "magheligrip_", "magheli_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "grip", "magheligrip_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "ballistics", "ammo_" );
    }
    else
    {
        if ( isdefined( var_7e0e2d906d6a6287 ) )
        {
            if ( !issubstr( var_7e0e2d906d6a6287, "iw9_" ) || issubstr( var_7e0e2d906d6a6287, "iw9_" ) && !getdvarint( @"hash_23a1118f1a92bcdd", 0 ) )
            {
                return removeconflictingdefaultattachment_new( attachments, defaults, var_7e0e2d906d6a6287 );
            }
        }
        
        defaults = removeconflictingdefaultattachment( attachments, defaults, "bar", "front_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "barlong", "slide_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "barcust", "guard_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "stock", "back_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "cal", "mag_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "drums", "mag_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "xmags", "mag_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "rack", "mag_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "rack", "ammo_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "thermal", "scope" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "acog", "scope" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "reflex", "scope" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "holo", "scope" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "grip", "grip_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "rec_", "rec_" );
        defaults = removeconflictingdefaultattachment( attachments, defaults, "toprail_", "toprail_" );
    }
    
    return defaults;
}

// Namespace utility / scripts\common\utility
// Params 4
// Checksum 0x0, Offset: 0x27df
// Size: 0x335
function removeconflictingdefaultattachment_new( attachment_array, default_array, var_7e0e2d906d6a6287, var_acfb0539c7ef722f )
{
    if ( !isdefined( var_acfb0539c7ef722f ) )
    {
        var_acfb0539c7ef722f = 1;
    }
    
    defaults_filtered = default_array;
    attach_1 = undefined;
    var_6ee19b287d4e26e5 = undefined;
    var_7422778828f0e845 = undefined;
    attach_2 = undefined;
    var_ad01292902899622 = undefined;
    var_426c9d4e0939620a = undefined;
    var_80d269ca7a15fe44 = undefined;
    var_41a82efc2c071928 = undefined;
    weap = makeweaponfromstring( var_7e0e2d906d6a6287 );
    
    if ( var_acfb0539c7ef722f )
    {
        for ( i = 0; i < default_array.size - 1 ; i++ )
        {
            attach_1 = default_array[ i ];
            var_6ee19b287d4e26e5 = getattachmentslot( weap, attach_1 );
            
            for ( j = i + 1; j < default_array.size ; j++ )
            {
                attach_2 = default_array[ j ];
                
                if ( attach_1 == attach_2 )
                {
                    continue;
                }
                
                var_ad01292902899622 = getattachmentslot( weap, attach_2 );
                
                if ( var_6ee19b287d4e26e5 == var_ad01292902899622 && var_6ee19b287d4e26e5 != "other" )
                {
                    var_7422778828f0e845 = getattachmentslotpriority( weap, attach_1 );
                    var_426c9d4e0939620a = getattachmentslotpriority( weap, attach_2 );
                    
                    if ( var_7422778828f0e845 >= var_426c9d4e0939620a )
                    {
                        final_attachments = array_remove( final_attachments, attach_2 );
                    }
                }
                
                var_80d269ca7a15fe44 = _attachmentblocks( weap, attach_1, attach_2 );
                var_41a82efc2c071928 = _attachmentblocks( weap, attach_2, attach_1 );
                
                if ( var_80d269ca7a15fe44 && var_41a82efc2c071928 )
                {
                    defaults_filtered = array_remove( defaults_filtered, attach_2 );
                    continue;
                }
                
                if ( var_80d269ca7a15fe44 )
                {
                    defaults_filtered = array_remove( defaults_filtered, attach_2 );
                    continue;
                }
                
                if ( var_41a82efc2c071928 )
                {
                    defaults_filtered = array_remove( defaults_filtered, attach_1 );
                }
            }
        }
    }
    
    attach_1 = undefined;
    var_6ee19b287d4e26e5 = undefined;
    var_7422778828f0e845 = undefined;
    attach_2 = undefined;
    var_ad01292902899622 = undefined;
    var_426c9d4e0939620a = undefined;
    var_80d269ca7a15fe44 = undefined;
    var_41a82efc2c071928 = undefined;
    final_attachments = defaults_filtered;
    
    foreach ( attach_1 in attachment_array )
    {
        if ( issubstr( attach_1, "|" ) )
        {
            [ attach_1 ] = strtok( attach_1, "|" );
        }
        
        var_6ee19b287d4e26e5 = getattachmentslot( weap, attach_1 );
        
        foreach ( attach_2 in defaults_filtered )
        {
            if ( issubstr( attach_2, "|" ) )
            {
                [ attach_2 ] = strtok( attach_2, "|" );
            }
            
            var_ad01292902899622 = getattachmentslot( weap, attach_2 );
            
            if ( var_6ee19b287d4e26e5 == var_ad01292902899622 && var_6ee19b287d4e26e5 != "other" )
            {
                var_7422778828f0e845 = getattachmentslotpriority( weap, attach_1 );
                var_426c9d4e0939620a = getattachmentslotpriority( weap, attach_2 );
                
                if ( var_7422778828f0e845 >= var_426c9d4e0939620a )
                {
                    final_attachments = array_remove( final_attachments, attach_2 );
                }
            }
            
            var_80d269ca7a15fe44 = _attachmentblocks( weap, attach_1, attach_2 );
            var_41a82efc2c071928 = _attachmentblocks( weap, attach_2, attach_1 );
            
            if ( var_80d269ca7a15fe44 && var_41a82efc2c071928 )
            {
                final_attachments = array_remove( final_attachments, attach_2 );
                continue;
            }
            
            if ( var_80d269ca7a15fe44 )
            {
                final_attachments = array_remove( final_attachments, attach_2 );
            }
        }
    }
    
    return final_attachments;
}

// Namespace utility / scripts\common\utility
// Params 4
// Checksum 0x0, Offset: 0x2b1d
// Size: 0x28f
function removeconflictingdefaultattachment( attachment_array, default_array, attachment_string, default_string )
{
    if ( !isdefined( attachment_string ) )
    {
        foreach ( attachment in attachment_array )
        {
            tok = strtok( attachment, "_" )[ 0 ];
            
            if ( tok == "iw8" || tok == "iw9" || tok == "jup" )
            {
                tok = strtok( attachment, "_" )[ 1 ];
                
                foreach ( def in default_array )
                {
                    if ( !isdefined( strtok( def, "_" )[ 1 ] ) )
                    {
                        continue;
                    }
                    
                    if ( tok == strtok( def, "_" )[ 1 ] )
                    {
                        default_array = array_remove( default_array, def );
                        continue;
                    }
                    
                    if ( issubstr( attachment, "scope" ) && issubstr( def, "scope" ) )
                    {
                        default_array = array_remove( default_array, def );
                    }
                }
                
                continue;
            }
            
            foreach ( def in default_array )
            {
                if ( tok == strtok( def, "_" )[ 0 ] )
                {
                    default_array = array_remove( default_array, def );
                    continue;
                }
                
                if ( issubstr( attachment, "scope" ) && issubstr( def, "scope" ) )
                {
                    default_array = array_remove( default_array, def );
                }
            }
        }
        
        return default_array;
    }
    
    var_58f169dc13811791 = undefined;
    
    foreach ( attachment in attachment_array )
    {
        if ( issubstr( attachment, default_string ) )
        {
            var_58f169dc13811791 = 1;
        }
        
        if ( isstartstr( attachment, attachment_string ) || istrue( var_58f169dc13811791 ) )
        {
            for ( i = 0; i < default_array.size ; i++ )
            {
                if ( issubstr( default_array[ i ], default_string ) )
                {
                    default_array = array_remove_index( default_array, i );
                    return default_array;
                }
            }
        }
    }
    
    return default_array;
}

// Namespace utility / scripts\common\utility
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x2db5
// Size: 0x18f, Type: bool
function private _attachmentblocks( weaponasset, attachment1, attachment2 )
{
    var_1fce8439ed13e7b3 = getattachmentbasetypesblocked( weaponasset, attachment1 );
    var_b28653df677fb727 = getattachmentbasetype( weaponasset, attachment2 );
    attachmentsblocked = getattachmentsblocked( weaponasset, attachment1 );
    
    foreach ( basetype in var_1fce8439ed13e7b3 )
    {
        if ( basetype == var_b28653df677fb727 )
        {
            return true;
        }
    }
    
    attachment1slot = getattachmentslot( weaponasset, attachment1 );
    attachment2slot = getattachmentslot( weaponasset, attachment2 );
    
    if ( attachment1slot == attachment2slot && attachment1slot != "other" )
    {
        return true;
    }
    
    slotsblocked = getattachmentslotsblocked( weaponasset, attachment1 );
    
    foreach ( slot in slotsblocked )
    {
        if ( slot == attachment2slot )
        {
            return true;
        }
    }
    
    foreach ( attachment in attachmentsblocked )
    {
        if ( attachment == attachment2 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\common\utility
// Params 6
// Checksum 0x0, Offset: 0x2f4d
// Size: 0x15a
function function_ec8a443fe8165fe4( weaponname, origin, weaponattachments, angles, spawnflags, camoid )
{
    assertex( isdefined( origin ), "<dev string:x16e>" );
    
    if ( getdvarint( @"hash_4589562a903db3e0" ) && isstartstr( weaponname, "iw8_" ) )
    {
        /#
            print( "<dev string:x1a0>" + weaponname );
        #/
    }
    
    defaults = getweapondefaultattachments( weaponname );
    defaults = removeconflictingattachments( weaponattachments, defaults, weaponname );
    weaponattachments = array_combine( defaults, weaponattachments );
    attachmentstring = "";
    
    foreach ( attachment in weaponattachments )
    {
        attachmentstring = attachmentstring + "+" + attachment;
    }
    
    if ( isdefined( camoid ) )
    {
        attachmentstring += "+camo|" + camoid;
    }
    
    if ( !isdefined( spawnflags ) )
    {
        spawnflags = 0;
    }
    
    if ( !isdefined( angles ) )
    {
        angles = ( 0, 0, 0 );
    }
    
    weapon = spawn( "weapon_" + weaponname + attachmentstring, origin, spawnflags );
    weapon.angles = angles;
    return weapon;
}

// Namespace utility / scripts\common\utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x30b0
// Size: 0xa1
function private function_5f9bef9bce1b6a4d( weapon )
{
    struct = spawnstruct();
    struct.origin = weapon.origin;
    struct.angles = weapon.angles;
    struct.targetname = weapon.targetname;
    struct.bulletweapon = function_2e84a570d6af300a( weapon.classname, "weapon_" );
    struct.spawnflags = weapon.spawnflags;
    addstruct( struct );
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x3159
// Size: 0x42c
function fixplacedweapons()
{
    /#
        level.placedweapons = [];
    #/
    
    weapons = [];
    entities = getentarray();
    
    foreach ( ent in entities )
    {
        if ( !isdefined( ent.classname ) )
        {
            continue;
        }
        
        if ( string_starts_with( ent.classname, "weapon_" ) )
        {
            weapons[ weapons.size ] = ent;
        }
    }
    
    foreach ( weapon in weapons )
    {
        if ( isent( weapon ) && weapon.spawnflags & 32 )
        {
            function_5f9bef9bce1b6a4d( weapon );
            weapon delete();
            continue;
        }
        
        weaponattachments = strtok( weapon.classname, "+" );
        weaponname = getsubstr( weaponattachments[ 0 ], 7, weaponattachments[ 0 ].size );
        weaponattachments = array_remove_index( weaponattachments, 0 );
        weaponcamoid = weapon.script_camo;
        
        if ( isdefined( level.var_8d5928a6024ffd1c ) )
        {
            weaponfixed = [[ level.var_8d5928a6024ffd1c ]]( weaponname, weapon.origin, weaponattachments, weapon.angles, weapon.spawnflags, weaponcamoid );
        }
        else
        {
            weaponfixed = function_ec8a443fe8165fe4( weaponname, weapon.origin, weaponattachments, weapon.angles, weapon.spawnflags, weaponcamoid );
        }
        
        if ( isdefined( weapon.targetname ) )
        {
            weaponfixed.targetname = weapon.targetname;
        }
        
        if ( isdefined( weapon.script_noteworthy ) )
        {
            weaponfixed.script_noteworthy = weapon.script_noteworthy;
        }
        
        if ( isdefined( weapon.script_namenumber ) )
        {
            weaponfixed.script_namenumber = weapon.script_namenumber;
        }
        
        if ( isdefined( weapon.script_parameters ) )
        {
            weaponfixed.script_parameters = weapon.script_parameters;
        }
        
        if ( isdefined( weapon.script_label ) )
        {
            weaponfixed.script_label = weapon.script_label;
        }
        
        if ( isdefined( weapon.script_ammo_alt_clip ) )
        {
            weaponfixed.script_ammo_alt_clip = weapon.script_ammo_alt_clip;
        }
        
        if ( isdefined( weapon.script_ammo_alt_extra ) )
        {
            weaponfixed.script_ammo_alt_extra = weapon.script_ammo_alt_extra;
        }
        
        if ( isdefined( weapon.script_ammo_clip ) )
        {
            weaponfixed.script_ammo_clip = weapon.script_ammo_clip;
        }
        
        if ( isdefined( weapon.script_ammo_extra ) )
        {
            weaponfixed.script_ammo_extra = weapon.script_ammo_extra;
        }
        else if ( isdefined( weapon.script_ammo_clip ) )
        {
            weaponfixed.script_ammo_extra = 0;
        }
        
        if ( isdefined( weapon.script_ammo_max ) )
        {
            weaponfixed.script_ammo_max = weapon.script_ammo_max;
        }
        
        hasub = undefined;
        attachmentstring = "";
        
        foreach ( attachment in weaponattachments )
        {
            attachmentstring = attachmentstring + "+" + attachment;
            
            if ( isstartstr( attachment, "ub_gl" ) )
            {
                hasub = 1;
            }
        }
        
        weaponfixed scripts\anim\shared::setscriptammo( weaponname, weapon, hasub );
        
        /#
            level.placedweapons = array_add( level.placedweapons, weaponfixed );
        #/
        
        weapon delete();
    }
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x358d
// Size: 0x60
function lookatentity( ent, intensity )
{
    actual_intensity = 1;
    
    if ( isdefined( intensity ) )
    {
        actual_intensity = intensity;
    }
    
    self.entitylookingat = ent;
    
    if ( isdefined( ent ) )
    {
        self.lookingatent = 1;
        self setlookatentity( ent, actual_intensity );
        return;
    }
    
    self.lookingatent = 0;
    self setlookatentity();
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x35f5
// Size: 0x2c
function lookatstateoverride( state )
{
    self.lookatstateoverride = state;
    
    if ( isdefined( state ) )
    {
        self setlookatstateoverride( state );
        return;
    }
    
    self setlookatstateoverride();
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x3629
// Size: 0x61
function civ_glancedownpath( duration )
{
    if ( !isdefined( self.pathgoalpos ) )
    {
        return;
    }
    
    self.internal_entitytolookat = self.entitylookingat;
    lookatentity();
    internal_civglancedownpath( gettime(), duration );
    lookatentity( self.internal_entitytolookat );
    self.internal_entitytolookat = undefined;
    self notify( "glance_finished" );
}

// Namespace utility / scripts\common\utility
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x3692
// Size: 0x9f
function private internal_civglancedownpath( starttime, duration )
{
    var_f3edcefbabc5a8f0 = 2500;
    lookdownpathdist = ter_op( isdefined( self.lookdownpathdist ), self.lookdownpathdist, 75 );
    
    while ( starttime + duration > gettime() )
    {
        glanceatpos = self getposonpath( lookdownpathdist );
        glanceatpos += ( 0, 0, 60 );
        
        if ( distancesquared( self.origin, glanceatpos ) < var_f3edcefbabc5a8f0 )
        {
            break;
        }
        
        self setlookat( glanceatpos );
        waitframe();
    }
    
    self stoplookat();
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x3739
// Size: 0x9
function glancestop()
{
    self stoplookat();
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x374a
// Size: 0x3c
function lookatpos( pos, intensity )
{
    self notify( "newLookAt" );
    
    if ( !isdefined( intensity ) )
    {
        intensity = 1;
    }
    
    if ( !isdefined( pos ) )
    {
        self stoplookat();
        return;
    }
    
    self setlookat( pos, intensity );
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x378e
// Size: 0x78, Type: bool
function isweaponepic( weapon )
{
    attachments = getweaponattachments( weapon );
    
    if ( !isdefined( attachments ) )
    {
        return false;
    }
    
    foreach ( attachment in attachments )
    {
        if ( issubstr( attachment, "epic" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x380f
// Size: 0x4b, Type: bool
function isdamageweapon( weapon )
{
    objweapon = self.damageweapon;
    
    if ( !isdefined( objweapon ) )
    {
        return false;
    }
    
    if ( isnullweapon( objweapon ) )
    {
        return false;
    }
    
    if ( objweapon.basename != getweaponbasename( weapon ) )
    {
        return false;
    }
    
    return true;
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x3863
// Size: 0x86, Type: bool
function meleegrab_ksweapon_used()
{
    assert( isplayer( self ) );
    killstreak_weaps = [ "mars_killstreak", "iw7_jackal_support_designator" ];
    currentweapon = self getcurrentweapon();
    
    if ( array_contains( killstreak_weaps, currentweapon.basename ) )
    {
        return true;
    }
    
    if ( self isdroppingweapon() )
    {
        return true;
    }
    
    if ( self israisingweapon() )
    {
        if ( array_contains( killstreak_weaps, currentweapon.basename ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x38f2
// Size: 0x59, Type: bool
function wasdamagedbyoffhandshield()
{
    if ( !isdefined( self.damagemod ) || self.damagemod != "MOD_MELEE" )
    {
        return false;
    }
    
    objweapon = self.damageweapon;
    
    if ( !isdefined( objweapon ) || objweapon.type != "shield" )
    {
        return false;
    }
    
    return true;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x3954
// Size: 0x37, Type: bool
function shouldburnfromdamage( damageweapon )
{
    if ( issubstr( damageweapon.basename, "molotov" ) || istrue( damageweapon.isdragonsbreath ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x3994
// Size: 0x143, Type: bool
function wasdamagedbyexplosive()
{
    if ( isdefined( self.damagemod ) )
    {
        if ( isexplosivedamagemod( self.damagemod ) )
        {
            return true;
        }
        
        if ( isdefined( self.damageweapon ) && shouldburnfromdamage( self.damageweapon ) )
        {
            return true;
        }
        
        if ( wasdamagedbyoffhandshield() )
        {
            return true;
        }
        
        if ( self.damagemod == "MOD_MELEE" && isdefined( self.attacker ) && isdefined( self.attacker.unittype ) && self.attacker.unittype == "c8" )
        {
            return true;
        }
    }
    
    if ( gettime() - anim.lastcarexplosiontime <= 50 )
    {
        rangesq = anim.lastcarexplosionrange * anim.lastcarexplosionrange * 1.2 * 1.2;
        
        if ( distancesquared( self.origin, anim.lastcarexplosiondamagelocation ) < rangesq )
        {
            var_bce0ae3dbe49ac18 = rangesq * 0.5 * 0.5;
            self.maydoupwardsdeath = distancesquared( self.origin, anim.lastcarexplosionlocation ) < var_bce0ae3dbe49ac18;
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x3ae0
// Size: 0x12f
function getdamagetype( type )
{
    if ( !isdefined( type ) )
    {
        return "unknown";
    }
    
    type = tolower( type );
    
    switch ( type )
    {
        case #"hash_2ef97462295cf6a3":
        case #"hash_40a94c5d9e4e265b":
        case #"hash_c483969920501d00":
            return "melee";
        case #"hash_85662cca994b567":
        case #"hash_cafa41dcb907577c":
        case #"hash_f43c177a8f2e82d9":
            return "bullet";
        case #"hash_1991ba0f6a8cd0a2":
        case #"hash_25d762139cbf755b":
        case #"hash_3734ba2dac7b82b0":
        case #"hash_95f4dd5cd9bac6c6":
        case #"hash_a3f023632a5a0ee4":
        case #"hash_e519b5a3caf0a103":
        case #"hash_fec6e5947c5a138b":
            return "splash";
        case #"hash_e786155101d29b06":
            return "impact";
        case #"hash_419ead14566f1872":
            return "unknown";
        case #"hash_614ca3158ee5c956":
            return "unknown";
        case #"hash_3c5a32d0363e4699":
            return "unknown";
        default:
            return "unknown";
    }
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x3c17
// Size: 0xb9, Type: bool
function isprotectedbyriotshield( enemy )
{
    if ( isdefined( enemy.hasriotshield ) && enemy.hasriotshield )
    {
        enemytome = self.origin - enemy.origin;
        metoenemy = vectornormalize( ( enemytome[ 0 ], enemytome[ 1 ], 0 ) );
        enemyfacing = anglestoforward( enemy.angles );
        angletome = vectordot( enemyfacing, enemytome );
        
        if ( enemy.hasriotshieldequipped )
        {
            if ( angletome > 0.766 )
            {
                return true;
            }
        }
        else if ( angletome < -0.766 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x3cd9
// Size: 0x139
function isprotectedbyaxeblock( source )
{
    enemy_blocked = 0;
    currentweapon = self getcurrentweapon();
    var_636d503b57782bcc = self adsbuttonpressed();
    var_4aabe1c26e2cccf7 = 0;
    var_e8398f912490ac89 = 0;
    var_a0f0c6714056aab = 0;
    playerforwardvector = anglestoforward( self.angles );
    playertoenemyvector = vectornormalize( source.origin - self.origin );
    dotproduct = vectordot( playertoenemyvector, playerforwardvector );
    
    if ( dotproduct > 0.5 )
    {
        var_4aabe1c26e2cccf7 = 1;
    }
    
    if ( currentweapon.basename == "iw6_axe_mp" || currentweapon.basename == "iw7_axe_zm" )
    {
        var_a0f0c6714056aab = self getcurrentweaponclipammo();
        var_e8398f912490ac89 = 1;
    }
    
    if ( var_e8398f912490ac89 && var_636d503b57782bcc && var_4aabe1c26e2cccf7 && var_a0f0c6714056aab > 0 )
    {
        self setweaponammoclip( currentweapon, var_a0f0c6714056aab - 1 );
        self playsound( "crate_impact" );
        earthquake( 0.75, 0.5, self.origin, 100 );
        enemy_blocked = 1;
    }
    
    return enemy_blocked;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x3e1b
// Size: 0x6d
function isairdropmarker( weaponname )
{
    switch ( weaponname )
    {
        case #"hash_2f9061ae7f4b0174":
        case #"hash_6b6ba32b55308fd1":
        case #"hash_73258c6de50c988a":
        case #"hash_abb7a2d7e9d5a6ff":
        case #"hash_e64f015026a52907":
        case #"hash_e861ccef0beefbbb":
            return 1;
        default:
            return 0;
    }
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x3e90
// Size: 0x5d, Type: bool
function isdestructibleweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x1e7>" );
        return false;
    }
    
    switch ( weapon )
    {
        case #"hash_5e7c026ffa426ef2":
        case #"hash_a2f8ba701e9cf4d4":
        case #"hash_b6aeb2ab5add627b":
        case #"hash_e06c18584a141cef":
            return true;
    }
    
    return false;
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x3ef6
// Size: 0xa
function enable_teamflashbangimmunity()
{
    thread enable_teamflashbangimmunity_proc();
}

// Namespace utility / scripts\common\utility
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3f08
// Size: 0x22
function private enable_teamflashbangimmunity_proc()
{
    self endon( "death" );
    
    while ( true )
    {
        self.teamflashbangimmunity = 1;
        wait 0.05;
    }
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x3f32
// Size: 0xc
function disable_teamflashbangimmunity()
{
    self.teamflashbangimmunity = undefined;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x3f46
// Size: 0x15
function setflashbangimmunity( immune )
{
    self.flashbangimmunity = immune;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x3f63
// Size: 0x5d
function getcamotablecolumnindex( columnname )
{
    switch ( columnname )
    {
        case #"hash_34b6339587dcb48b":
            return 0;
        case #"hash_1a71dd59b555167":
            return 1;
        case #"hash_f545dd6e3ce1266f":
            return 2;
        case #"hash_7398d228375ae0d1":
            return 3;
        default:
            return undefined;
    }
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x3fc8
// Size: 0x59
function getdifficulty()
{
    assert( isdefined( level.gameskill ) );
    
    if ( level.gameskill < 1 )
    {
        return "easy";
    }
    
    if ( level.gameskill < 2 )
    {
        return "medium";
    }
    
    if ( level.gameskill < 3 )
    {
        return "hard";
    }
    
    return "fu";
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x402a
// Size: 0x9
function clear_movement_speed()
{
    self aiclearscriptdesiredspeed();
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x403b
// Size: 0xc
function flashbangstop()
{
    self.flashendtime = undefined;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x404f
// Size: 0x48
function enable_cqbwalk( autoenabled )
{
    if ( self.type == "dog" )
    {
        return;
    }
    
    if ( !isdefined( autoenabled ) )
    {
        self.cqbenabled = 1;
    }
    
    self.turnrate = 0.2;
    demeanor_override( "cqb" );
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x409f
// Size: 0x5e
function disable_cqbwalk()
{
    if ( self.type == "dog" )
    {
        return;
    }
    
    self.cqbenabled = undefined;
    self.turnrate = 0.3;
    
    if ( isdefined( self.cqb_point_of_interest ) )
    {
        self.cqb_point_of_interest = undefined;
        self function_f7d83c92f61dcc31( 0 );
    }
    
    /#
        self notify( "<dev string:x226>" );
    #/
    
    clear_demeanor_override();
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x4105
// Size: 0x13
function demeanor_override( demeanor )
{
    self demeanoroverride( demeanor );
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x4120
// Size: 0x9
function clear_demeanor_override()
{
    self cleardemeanoroverride();
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x4131
// Size: 0x38, Type: bool
function isweaponinitialized( objweapon )
{
    assert( isweapon( objweapon ) );
    weaponname = getcompleteweaponname( objweapon );
    return isdefined( self.weaponinfo[ weaponname ] );
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x4172
// Size: 0x103
function initweapon( objweapon )
{
    assert( isweapon( objweapon ) );
    weaponname = getcompleteweaponname( objweapon );
    self.weaponinfo[ weaponname ] = spawnstruct();
    self.weaponinfo[ weaponname ].position = "none";
    self.weaponinfo[ weaponname ].hasclip = 1;
    
    if ( issp() )
    {
        clipmodel = getweaponclipmodel( objweapon );
        
        if ( isdefined( clipmodel ) && clipmodel != "" && ( issubstr( clipmodel, "drum" ) || issubstr( clipmodel, "mag" ) ) )
        {
            self.weaponinfo[ weaponname ].useclip = 1;
        }
        else
        {
            self.weaponinfo[ weaponname ].useclip = 0;
        }
        
        return;
    }
    
    self.weaponinfo[ weaponname ].useclip = 0;
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x427d
// Size: 0x20
function get_doublejumpenergy()
{
    if ( !isdefined( self.doublejumpenergy ) )
    {
        return self energy_getenergy( 0 );
    }
    
    return self.doublejumpenergy;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x42a6
// Size: 0x2e
function set_doublejumpenergy( value )
{
    if ( !isdefined( self.doublejumpenergy ) )
    {
        self energy_setenergy( 0, value );
        return;
    }
    
    self.doublejumpenergy = value;
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x42dc
// Size: 0x20
function get_doublejumpenergyrestorerate()
{
    if ( !isdefined( self.doublejumpenergyrestorerate ) )
    {
        return self energy_getrestorerate( 0 );
    }
    
    return self.doublejumpenergyrestorerate;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x4305
// Size: 0x2e
function set_doublejumpenergyrestorerate( value )
{
    if ( !isdefined( self.doublejumpenergyrestorerate ) )
    {
        self energy_setrestorerate( 0, value );
        return;
    }
    
    self.doublejumpenergyrestorerate = value;
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x433b
// Size: 0x10
function playerarmorenabled()
{
    return getdvarint( @"hash_bfa6bedc37206c58" );
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x4354
// Size: 0x10
function playerhelmetenabled()
{
    return getdvarint( @"hash_425e93b8de8f141c" );
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x436d
// Size: 0x21
function spawn_vehicle()
{
    /#
        vehicle = scripts\common\vehicle::vehicle_spawn( self );
        return vehicle;
    #/
    
    return scripts\common\vehicle::vehicle_spawn( self );
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x4397
// Size: 0x21
function groundpos( origin, up )
{
    return drop_to_ground( origin, 0, -100000, up );
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x43c1
// Size: 0x9
function vehicle_detachfrompath()
{
    scripts\common\vehicle_code::vehicle_pathdetach();
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x43d2
// Size: 0xa
function vehicle_resumepath()
{
    thread scripts\common\vehicle_paths::vehicle_resumepathvehicle();
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x43e4
// Size: 0x13
function vehicle_land( neargoaldist )
{
    scripts\common\vehicle_code::vehicle_landvehicle( neargoaldist );
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x43ff
// Size: 0x13
function vehicle_liftoff( height )
{
    scripts\common\vehicle_code::vehicle_liftoffvehicle( height );
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x441a
// Size: 0x1c
function vehicle_dynamicpath( node, var_162e61a6e56b7519 )
{
    scripts\common\vehicle::vehicle_paths( node, var_162e61a6e56b7519 );
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x443e
// Size: 0x38
function getvehiclespawner( value, key )
{
    spawners = getvehiclespawnerarray( value, key );
    assert( spawners.size == 1 );
    return spawners[ 0 ];
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x447f
// Size: 0x1b
function getvehiclespawnerarray( value, key )
{
    return scripts\common\vehicle_code::_getvehiclespawnerarray( value, key );
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x44a3
// Size: 0x35, Type: bool
function is_map_using_locales_only()
{
    mapname = getdvar( @"g_mapname" );
    
    if ( mapname == "mp_donesk" || mapname == "mp_locale_test" )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x44e1
// Size: 0x14, Type: bool
function iswegameplatform()
{
    return getdvarint( @"hash_4d1e25100e19b858", 0 ) == 1;
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x44fe
// Size: 0x38
function function_6c6d2a633d30b5af( source, target )
{
    distanceinches = distance( source, target );
    distancemeters = distanceinches * 0.0254;
    return distancemeters;
}

// Namespace utility / scripts\common\utility
// Params 3
// Checksum 0x0, Offset: 0x453f
// Size: 0x4f, Type: bool
function playerwithindistance( player, point, distance )
{
    actualdistancesquared = distancesquared( player.origin, point );
    maxdistancesquared = distance * distance;
    
    if ( actualdistancesquared <= maxdistancesquared )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\common\utility
// Params 3
// Checksum 0x0, Offset: 0x4597
// Size: 0x4f, Type: bool
function function_acb96530881571aa( player, point, distance )
{
    actualdistancesquared = distance2dsquared( player.origin, point );
    maxdistancesquared = distance * distance;
    
    if ( actualdistancesquared <= maxdistancesquared )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\common\utility
// Params 3
// Checksum 0x0, Offset: 0x45ef
// Size: 0x42, Type: bool
function function_4fbf8d536d792c25( player, point, distancesquared )
{
    actualdistancesquared = distancesquared( player.origin, point );
    
    if ( actualdistancesquared <= distancesquared )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x463a
// Size: 0x1d
function playersnear( point, distance )
{
    return charactersnear( point, distance, 1 );
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x4660
// Size: 0x1c
function agentsnear( point, distance )
{
    return charactersnear( point, distance, 0 );
}

// Namespace utility / scripts\common\utility
// Params 3
// Checksum 0x0, Offset: 0x4685
// Size: 0xe2
function charactersnear( point, distance, playersonly )
{
    playercontents = physics_createcontents( [ "physicscontents_characterproxy" ] );
    radiusvector = ( distance, distance, distance );
    aabbmin = point - radiusvector;
    aabbmax = point + radiusvector;
    hits = physics_aabbbroadphasequery( aabbmin, aabbmax, playercontents, [] );
    
    if ( !isdefined( playersonly ) )
    {
        return hits;
    }
    
    filteredhits = [];
    
    foreach ( hit in hits )
    {
        if ( isplayer( hit ) == playersonly )
        {
            filteredhits[ filteredhits.size ] = hit;
        }
    }
    
    return filteredhits;
}

// Namespace utility / scripts\common\utility
// Params 4
// Checksum 0x0, Offset: 0x4770
// Size: 0x2f
function playersincylinder( point, radius, var_213fdd3689d4b33e, heightoverride )
{
    return function_98a826b6b6d0d118( point, radius, var_213fdd3689d4b33e, heightoverride, 1 );
}

// Namespace utility / scripts\common\utility
// Params 5
// Checksum 0x0, Offset: 0x47a8
// Size: 0x146
function function_98a826b6b6d0d118( point, radius, var_73427010f72fa1d6, heightoverride, playersonly )
{
    playercontents = physics_createcontents( [ "physicscontents_characterproxy" ] );
    cylinderheight = 1000;
    
    if ( isdefined( heightoverride ) )
    {
        cylinderheight = heightoverride;
    }
    
    radiusvector = ( radius, radius, cylinderheight );
    aabbmin = point - radiusvector;
    aabbmax = point + radiusvector;
    
    if ( !isdefined( var_73427010f72fa1d6 ) )
    {
        var_73427010f72fa1d6 = [];
    }
    
    hits = physics_aabbbroadphasequery( aabbmin, aabbmax, playercontents, var_73427010f72fa1d6 );
    cylinderhits = [];
    radiussquared = radius * radius;
    
    foreach ( hit in hits )
    {
        if ( !isdefined( playersonly ) || playersonly == isplayer( hit ) )
        {
            dist2dsqr = distance2dsquared( hit.origin, point );
            
            if ( dist2dsqr < radiussquared )
            {
                cylinderhits[ cylinderhits.size ] = hit;
            }
        }
    }
    
    return cylinderhits;
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x48f7
// Size: 0x1d
function playersinsphere( point, radius )
{
    return function_2d7fd59d039fa69b( point, radius, 1 );
}

// Namespace utility / scripts\common\utility
// Params 3
// Checksum 0x0, Offset: 0x491d
// Size: 0xb9
function function_2d7fd59d039fa69b( point, radius, playersonly )
{
    characters = charactersnear( point, radius, playersonly );
    spherecharacters = [];
    radiussquared = radius * radius;
    
    foreach ( character in characters )
    {
        distsqr = distancesquared( character.origin, point );
        
        if ( distsqr < radiussquared )
        {
            spherecharacters[ spherecharacters.size ] = character;
        }
    }
    
    return spherecharacters;
}

// Namespace utility / scripts\common\utility
// Params 11
// Checksum 0x0, Offset: 0x49df
// Size: 0x146
function trycall( functionpointer, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10 )
{
    if ( !isdefined( functionpointer ) )
    {
        return;
    }
    
    if ( isdefined( param10 ) )
    {
        return [[ functionpointer ]]( param1, param2, param3, param4, param5, param6, param7, param8, param9, param10 );
    }
    
    if ( isdefined( param9 ) )
    {
        return [[ functionpointer ]]( param1, param2, param3, param4, param5, param6, param7, param8, param9 );
    }
    
    if ( isdefined( param8 ) )
    {
        return [[ functionpointer ]]( param1, param2, param3, param4, param5, param6, param7, param8 );
    }
    
    if ( isdefined( param7 ) )
    {
        return [[ functionpointer ]]( param1, param2, param3, param4, param5, param6, param7 );
    }
    
    if ( isdefined( param6 ) )
    {
        return [[ functionpointer ]]( param1, param2, param3, param4, param5, param6 );
    }
    
    if ( isdefined( param5 ) )
    {
        return [[ functionpointer ]]( param1, param2, param3, param4, param5 );
    }
    
    if ( isdefined( param4 ) )
    {
        return [[ functionpointer ]]( param1, param2, param3, param4 );
    }
    
    if ( isdefined( param3 ) )
    {
        return [[ functionpointer ]]( param1, param2, param3 );
    }
    
    if ( isdefined( param2 ) )
    {
        return [[ functionpointer ]]( param1, param2 );
    }
    
    if ( isdefined( param1 ) )
    {
        return [[ functionpointer ]]( param1 );
    }
    
    return [[ functionpointer ]]();
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x4b2d
// Size: 0x19d
function spawncorpsehider()
{
    if ( !iswegameplatform() )
    {
        return;
    }
    
    corpsetable_index = 0;
    corpsetable_mapname = 1;
    corpsetable_model = 2;
    corpsetable_loc = 3;
    corpsetable_rot = 4;
    corpsetable_collision = 5;
    corpsetablename = "sp/hideCorpseTable.csv";
    curmapname = tolower( getdvar( @"g_mapname" ) );
    var_84ae683600bf3b4c = tablelookupgetnumrows( corpsetablename );
    
    for ( i = 0; i < var_84ae683600bf3b4c ; i++ )
    {
        if ( curmapname == tolower( tablelookupbyrow( corpsetablename, i, corpsetable_mapname ) ) )
        {
            modelname = tablelookupbyrow( corpsetablename, i, corpsetable_model );
            arrloc = strtok( tablelookupbyrow( corpsetablename, i, corpsetable_loc ), "_" );
            arrrot = strtok( tablelookupbyrow( corpsetablename, i, corpsetable_rot ), "_" );
            icollision = int( tablelookupbyrow( corpsetablename, i, corpsetable_collision ) );
            model = spawn( "script_model", ( float( arrloc[ 0 ] ), float( arrloc[ 1 ] ), float( arrloc[ 2 ] ) ) );
            model setmodel( modelname );
            model.angles = ( float( arrrot[ 0 ] ), float( arrrot[ 1 ] ), float( arrrot[ 2 ] ) );
            
            if ( icollision > 0 )
            {
                model solid();
                continue;
            }
            
            model notsolid();
        }
    }
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x4cd2
// Size: 0x6f, Type: bool
function function_35c178c80fa19cbd( part, state )
{
    if ( isent( self ) && self isscriptable() || !isent( self ) && self isscriptableinstance() )
    {
        if ( self getscriptablehaspart( part ) )
        {
            if ( self getscriptableparthasstate( part, state ) )
            {
                curstate = self getscriptablepartstate( part, 1 );
                
                if ( curstate == state )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x4d4a
// Size: 0x5f, Type: bool
function function_3677f2be30fdd581( part, state )
{
    if ( isent( self ) && self isscriptable() || !isent( self ) && self isscriptableinstance() )
    {
        if ( self getscriptablehaspart( part ) )
        {
            if ( self getscriptableparthasstate( part, state ) )
            {
                self setscriptablepartstate( part, state, 1 );
                return true;
            }
        }
    }
    
    return false;
}

// Namespace utility / scripts\common\utility
// Params 3
// Checksum 0x0, Offset: 0x4db2
// Size: 0xe7
function scriptable_setparententity( parent, offset, angles )
{
    assertex( isdefined( self ) && self isscriptableinstance() );
    assertex( isdefined( parent ) && isent( parent ) );
    
    if ( isdefined( offset ) && isdefined( angles ) )
    {
        self scriptablesetparententity( parent, offset, angles );
    }
    else if ( isdefined( offset ) )
    {
        self scriptablesetparententity( parent, offset );
    }
    else
    {
        self scriptablesetparententity( parent );
    }
    
    self.linkedparent = parent;
    
    if ( !isdefined( parent.linkedchildren ) )
    {
        parent.linkedchildren = [];
    }
    
    parent.linkedchildren[ parent.linkedchildren.size ] = self;
    
    if ( parent.linkedchildren.size % 10 == 0 )
    {
        parent.linkedchildren = array_removeundefined( parent.linkedchildren );
    }
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x4ea1
// Size: 0x8e
function scriptable_clearparententity()
{
    assertex( isdefined( self ) && self isscriptableinstance() );
    self scriptableclearparententity();
    parent = self.linkedparent;
    
    if ( !isdefined( parent ) || !isdefined( parent.linkedchildren ) )
    {
        return;
    }
    
    parent.linkedchildren = array_remove( parent.linkedchildren, self );
    
    if ( parent.linkedchildren.size == 0 )
    {
        parent.linkedchildren = undefined;
    }
    
    self.linkedparent = undefined;
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x4f37
// Size: 0x6c, Type: bool
function function_3ab9164ef76940fd( part, state )
{
    if ( isent( self ) && self isscriptable() || !isent( self ) && self isscriptableinstance() )
    {
        if ( self getscriptablehaspart( part ) )
        {
            if ( self getscriptableparthasstate( part, state ) && self getscriptablepartstate( part ) != state )
            {
                self setscriptablepartstate( part, state, 1 );
                return true;
            }
        }
    }
    
    return false;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x4fac
// Size: 0x7a
function function_b6a59f7759a30482( bool )
{
    assertex( isdefined( bool ) );
    
    if ( bool && isdefined( level.scripted_melee.fnenable ) )
    {
        self [[ level.scripted_melee.fnenable ]]();
        return;
    }
    
    if ( isdefined( level.scripted_melee.fndisable ) )
    {
        self [[ level.scripted_melee.fndisable ]]();
    }
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x502e
// Size: 0x20
function function_1a479cad9c3adbb1( bool )
{
    assertex( isdefined( bool ) );
    self.var_1a479cad9c3adbb1 = bool;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x5056
// Size: 0x6b
function function_c4ec7d985422ce24( arms )
{
    assertex( isdefined( arms ) );
    self.scripted_melee_player_rig delete();
    level.scr_model[ "scripted_melee_player_rig" ] = arms;
    self [[ level.scripted_melee.var_2ec260ca66f2378 ]]();
    self.scripted_melee_player_rig notsolid();
    self.scripted_melee_player_rig hide();
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x50c9
// Size: 0x20
function function_aa54d0684bb8d0cf( weapon )
{
    assertex( isdefined( weapon ) );
    self.var_2cd5923c5934a055 = weapon;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x50f1
// Size: 0x34
function function_f0969c633b166f3e( usedefault )
{
    if ( !isdefined( usedefault ) )
    {
        usedefault = 1;
    }
    
    if ( istrue( usedefault ) )
    {
        self.var_2cd5923c5934a055 = "att_vm_p33_me_tac_knife01_v0";
        return;
    }
    
    self.var_2cd5923c5934a055 = undefined;
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x512d
// Size: 0x23
function function_6d2d330fc885914c()
{
    self endon( "death" );
    self waittill( "scripted_melee_anim_ended" );
    waittillframeend();
    
    while ( istrue( self.var_e5e956f3df0184ee ) )
    {
        waitframe();
    }
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x5158
// Size: 0x7
function function_a1260c3b5f229f69()
{
    return "scripted_melee_start";
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x5168
// Size: 0x7
function function_ae9fb94402a02d07()
{
    return "scripted_melee_anim_started";
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x5178
// Size: 0x7
function function_a73c26a3feb8ef0e()
{
    return "scripted_melee_anim_ended";
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x5188
// Size: 0x7
function function_835e274f31e87cf4()
{
    return "scripted_melee_anim_ended_longest";
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x5198
// Size: 0xb
function function_7e105b48ce221583()
{
    return self.var_a13eda80c7c29501;
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x51ac
// Size: 0x15
function function_d561019e2a68d6cf()
{
    return level.scripted_melee.anim_ent;
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x51ca
// Size: 0x7
function function_ea3248e9abe4700a()
{
    return "scripted_melee_player_rig";
}

// Namespace utility / scripts\common\utility
// Params 10
// Checksum 0x0, Offset: 0x51da
// Size: 0x1f9
function function_7a5a6498179656fc( animscene, direction, rules, victimlives, startstance, endstance, override, marina_hack, usepistol, boneoverride )
{
    assertex( isdefined( animscene ), "<dev string:x237>" );
    assertex( isdefined( direction ), "<dev string:x254>" );
    direction = tolower( direction );
    array = [];
    array[ direction ][ "animScene" ] = animscene;
    
    if ( isdefined( rules ) )
    {
        if ( isarray( rules ) )
        {
            array[ direction ][ "rules" ] = rules;
        }
        else
        {
            array[ direction ][ "rules" ] = [[ rules ]]();
        }
    }
    else
    {
        array[ direction ][ "rules" ] = [[ level.scripted_melee.var_2eda72772d041081 ]]();
    }
    
    if ( isdefined( victimlives ) )
    {
        array[ direction ][ "victimLives" ] = victimlives;
    }
    else
    {
        array[ direction ][ "victimLives" ] = 0;
    }
    
    if ( isdefined( startstance ) )
    {
        array[ direction ][ "startStance" ] = endstance;
    }
    else
    {
        array[ direction ][ "startStance" ] = undefined;
    }
    
    if ( isdefined( endstance ) )
    {
        array[ direction ][ "endStance" ] = endstance;
    }
    else
    {
        array[ direction ][ "endStance" ] = undefined;
    }
    
    if ( isdefined( marina_hack ) )
    {
        array[ direction ][ "marina_hack" ] = marina_hack;
    }
    else
    {
        array[ direction ][ "marina_hack" ] = undefined;
    }
    
    if ( isdefined( usepistol ) )
    {
        array[ direction ][ "usePistol" ] = usepistol;
    }
    else
    {
        array[ direction ][ "usePistol" ] = undefined;
    }
    
    if ( isdefined( boneoverride ) )
    {
        array[ direction ][ "boneOverride" ] = boneoverride;
    }
    else
    {
        array[ direction ][ "boneOverride" ] = "TAG_ACCESSORY_RIGHT";
    }
    
    if ( level == self )
    {
        function_5e7bde4c30450810( level.scripted_melee, animscene, direction, override, array );
        return;
    }
    
    if ( !isdefined( self.scripted_melee ) )
    {
        self.scripted_melee = spawnstruct();
    }
    
    function_5e7bde4c30450810( self.scripted_melee, animscene, direction, override, array );
}

// Namespace utility / scripts\common\utility
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x53db
// Size: 0x1c3
function private function_5e7bde4c30450810( struct, animscene, direction, override, array )
{
    if ( istrue( override ) )
    {
        if ( !isdefined( struct.anims_override ) )
        {
            struct.anims_override = [];
        }
        
        if ( !isdefined( struct.anims_override[ direction ] ) )
        {
            struct.anims_override[ direction ] = [];
        }
        
        if ( struct.anims_override[ direction ].size > 0 )
        {
            for ( i = 0; i < struct.anims_override[ direction ].size ; i++ )
            {
                if ( isdefined( struct.anims_override[ direction ][ i ][ "animScene" ] ) && struct.anims_override[ direction ][ i ][ "animScene" ] == animscene )
                {
                    println( "<dev string:x270>" + animscene + "<dev string:x2a3>" + direction + "<dev string:x2b7>" );
                    struct.anims_override[ direction ] = array_remove_index( struct.anims_override[ direction ], i );
                }
            }
        }
        
        assertex( struct.anims_override[ direction ].size < 4, "<dev string:x2bc>" + direction + "<dev string:x2eb>" );
        struct.anims_override[ direction ] = array_combine( struct.anims_override[ direction ], array );
        return;
    }
    
    if ( !isdefined( struct.anims ) )
    {
        struct.anims = [];
    }
    
    if ( !isdefined( struct.anims[ direction ] ) )
    {
        struct.anims[ direction ] = [];
    }
    
    struct.anims[ direction ] = array_combine( struct.anims[ direction ], array );
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x55a6
// Size: 0xbd
function function_41cb362e1d3b89b1( animscene, override )
{
    if ( istrue( override ) )
    {
        if ( isdefined( self.var_f145d382dca7f7ee ) && isdefined( self.scripted_melee ) && isdefined( self.scripted_melee.anims_override ) )
        {
            function_2bb6f41ffcbd4bea( self.scripted_melee, animscene, override );
        }
        else if ( isdefined( level.scripted_melee.anims_override ) && isdefined( self.var_f145d382dca7f7ee ) )
        {
            function_2bb6f41ffcbd4bea( level.scripted_melee, animscene, override );
        }
        else
        {
            /#
                iprintln( "<dev string:x306>" );
            #/
        }
        
        return;
    }
    
    function_2bb6f41ffcbd4bea( level.scripted_melee, animscene, override );
}

// Namespace utility / scripts\common\utility
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x566b
// Size: 0x24c
function private function_2bb6f41ffcbd4bea( struct, animscene, override )
{
    if ( istrue( override ) )
    {
        directions = getarraykeys( struct.anims_override );
        
        foreach ( direction in directions )
        {
            found = undefined;
            
            for ( i = 0; i < struct.anims_override[ direction ].size ; i++ )
            {
                if ( struct.anims_override[ direction ][ i ][ "animScene" ] == animscene )
                {
                    found = 1;
                }
                
                if ( istrue( found ) && struct.anims_override[ direction ].size > 1 )
                {
                    struct.anims_override[ direction ] = array_remove_index( struct.anims_override[ direction ], i );
                    continue;
                }
                
                if ( istrue( found ) )
                {
                    self.var_f145d382dca7f7ee = array_remove( self.var_f145d382dca7f7ee, direction );
                    struct.anims_override = array_remove_key( struct.anims_override, direction );
                    break;
                }
            }
        }
        
        return;
    }
    
    directions = getarraykeys( struct.anims );
    
    foreach ( direction in directions )
    {
        found = undefined;
        
        for ( i = 0; i < struct.anims[ direction ].size ; i++ )
        {
            if ( struct.anims[ direction ][ i ][ "animScene" ] == animscene )
            {
                found = 1;
            }
            
            if ( istrue( found ) && struct.anims[ direction ].size > 1 )
            {
                struct.anims[ direction ] = array_remove_index( struct.anims[ direction ], i );
                continue;
            }
            
            if ( istrue( found ) )
            {
                struct.anims = array_remove_key( struct.anims, direction );
                break;
            }
        }
    }
}

// Namespace utility / scripts\common\utility
// Params 12
// Checksum 0x0, Offset: 0x58bf
// Size: 0x366
function function_299b43ee3353dacc( animscene, direction, rules, victimlives, cleardirection, startstance, endstance, funcs, launch, marina_hack, usepistol, boneoverride )
{
    if ( !isdefined( direction ) )
    {
        direction = "all";
    }
    
    direction = tolower( direction );
    
    if ( !isdefined( cleardirection ) )
    {
        cleardirection = 1;
    }
    
    assertex( isdefined( animscene ), "<dev string:x326>" );
    assertex( isdefined( level.scr_anim[ function_ea3248e9abe4700a() ][ animscene ] ), "<dev string:x347>" + animscene );
    assertex( isdefined( level.scr_anim[ "<dev string:x38b>" ][ animscene ] ), "<dev string:x396>" + animscene );
    
    if ( istrue( cleardirection ) )
    {
        function_a072535b3f7182fe( direction );
    }
    
    if ( !isdefined( self.var_f145d382dca7f7ee ) )
    {
        self.var_f145d382dca7f7ee = [];
    }
    
    if ( !array_contains( self.var_f145d382dca7f7ee, direction ) )
    {
        self.var_f145d382dca7f7ee = array_add( self.var_f145d382dca7f7ee, direction );
    }
    
    if ( isdefined( rules ) && isarray( rules ) && array_contains( rules, "defaults" ) )
    {
        index = array_find( rules, "defaults" );
        rules = array_remove_index( rules, index );
        rules = function_33bea9fcd7e7d254( rules );
    }
    
    function_7a5a6498179656fc( animscene, direction, rules, victimlives, startstance, endstance, 1, marina_hack, usepistol, boneoverride );
    notetracks = [ "cm_death", "cm_ragdoll" ];
    functions[ 0 ] = &function_26e31291e7d65683;
    functions[ 1 ] = &function_6812bf6f8500b33a;
    
    foreach ( n, notetrack in notetracks )
    {
        if ( isdefined( level.scr_notetrack[ "generic" ] ) && isdefined( level.scr_notetrack[ "generic" ][ animscene ] ) && isdefined( level.scr_notetrack[ "generic" ][ animscene ][ notetrack ] ) && level.scr_notetrack[ "generic" ][ animscene ][ notetrack ].size > 0 )
        {
            for ( i = 0; i < level.scr_notetrack[ "generic" ][ animscene ][ notetrack ].size ; i++ )
            {
                if ( isdefined( level.scr_notetrack[ "generic" ][ animscene ][ notetrack ][ i ][ "function" ] ) )
                {
                    if ( level.scr_notetrack[ "generic" ][ animscene ][ notetrack ][ i ][ "function" ] == functions[ n ] )
                    {
                        println( "<dev string:x3c7>" + notetrack + "<dev string:x3fe>" + animscene + "<dev string:x413>" );
                        level.scr_notetrack[ "generic" ][ animscene ][ notetrack ][ i ][ "function" ] = undefined;
                    }
                }
            }
        }
    }
    
    scripts\common\anim::addnotetrack_customfunction( "generic", "cm_death", &function_26e31291e7d65683, animscene );
    scripts\common\anim::addnotetrack_customfunction( "generic", "cm_ragdoll", &function_6812bf6f8500b33a, animscene );
    scripts\common\anim::addnotetrack_customfunction( "generic", "cm_fx", &function_e24378166154fc99, animscene );
}

// Namespace utility / scripts\common\utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5c2d
// Size: 0x22
function private function_26e31291e7d65683( guy )
{
    [[ level.scripted_melee.fndeath ]]( guy );
}

// Namespace utility / scripts\common\utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5c57
// Size: 0x22
function private function_6812bf6f8500b33a( guy )
{
    [[ level.scripted_melee.fnragdoll ]]( guy );
}

// Namespace utility / scripts\common\utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5c81
// Size: 0x22
function private function_e24378166154fc99( guy )
{
    [[ level.scripted_melee.fnfx ]]( guy );
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x5cab
// Size: 0x25
function function_df3c0eba274a0121( animscene )
{
    assertex( isdefined( animscene ), "<dev string:x419>" );
    function_41cb362e1d3b89b1( animscene, 1 );
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x5cd8
// Size: 0xba
function function_a072535b3f7182fe( direction, global )
{
    assertex( isdefined( direction ), "<dev string:x43f>" );
    
    if ( isdefined( self.var_f145d382dca7f7ee ) && array_contains( self.var_f145d382dca7f7ee, direction ) )
    {
        self.var_f145d382dca7f7ee = array_remove( self.var_f145d382dca7f7ee, direction );
    }
    
    if ( !isdefined( global ) )
    {
        global = 1;
    }
    
    if ( istrue( global ) || self == level )
    {
        if ( isdefined( level.scripted_melee.anims_override ) && isdefined( level.scripted_melee.anims_override[ direction ] ) )
        {
            level.scripted_melee.anims_override[ direction ] = [];
        }
    }
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x5d9a
// Size: 0x15
function function_37e61c71bcc30cf9( parent )
{
    self.var_e3e345b123304389 = parent;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x5db7
// Size: 0x3b
function function_33bea9fcd7e7d254( rules )
{
    if ( !isarray( rules ) )
    {
        rules = [ rules ];
    }
    
    rules = array_combine( [[ level.scripted_melee.var_2eda72772d041081 ]](), rules );
    return rules;
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x5dfb
// Size: 0xc, Type: bool
function function_bbebfbddd1b77a34()
{
    return istrue( self.in_melee_death );
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x5e10
// Size: 0x15
function function_75b55c43bf528532()
{
    return level.scripted_melee.enabled;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x5e2e
// Size: 0x49
function function_b88f4e5baff057a9( enabletime )
{
    if ( enabletime <= 0.25 )
    {
        return 0;
    }
    else if ( enabletime <= 0.4 )
    {
        return 1;
    }
    else if ( enabletime <= 0.6 )
    {
        return 2;
    }
    else if ( enabletime <= 0.8 )
    {
        return 3;
    }
    
    return 4;
}

// Namespace utility / scripts\common\utility
// Params 1, eflags: 0x14
// Checksum 0x0, Offset: 0x5e80
// Size: 0x36
function private function_2fc4c8ff2a77c4e1( notifyname )
{
    level endon( string( notifyname ) );
    wait randomintrange( 10, 30 );
    println( "<dev string:x465>" + notifyname );
    sendctgstrace( 1 );
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x5ebe
// Size: 0xb6
function function_7f5f53871d3db00c()
{
    worldpoint = self.origin;
    
    if ( isdefined( self.code_classname ) && self.code_classname == "scriptable" || isdefined( self.classname ) && self.classname == "scriptable" )
    {
        worldpoint = self scriptablegetmidpoint();
    }
    else if ( isdefined( self.model ) && self.model != "" )
    {
        localpoint = function_29399a706e427afb( self.model );
        worldpoint = coordtransform( localpoint, self.origin, self.angles );
    }
    
    return worldpoint;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x5f7d
// Size: 0x114
function function_32fd8e6a43da67b8( seconds )
{
    if ( seconds == 0 )
    {
        retval = 50;
    }
    else if ( seconds < 0.25 )
    {
        retval = mapfloat( 0, 0.25, 50, 25, seconds );
    }
    else if ( seconds < 0.75 )
    {
        retval = mapfloat( 0.25, 0.75, 25, 10, seconds );
    }
    else if ( seconds < 1.4 )
    {
        retval = mapfloat( 0.75, 1.4, 10, 5, seconds );
    }
    else if ( seconds < 3.5 )
    {
        retval = mapfloat( 1.4, 3.5, 5, 2, seconds );
    }
    else if ( seconds < 7.5 )
    {
        retval = mapfloat( 3.5, 7.5, 2, 1, seconds );
    }
    else if ( seconds < 14 )
    {
        retval = mapfloat( 7.5, 14, 1, 0.5, seconds );
    }
    else
    {
        retval = mapfloat( 14, 3, 0.5, 0, seconds );
    }
    
    return retval;
}

// Namespace utility / scripts\common\utility
// Params 9
// Checksum 0x0, Offset: 0x609a
// Size: 0x5e
function dof_enable_autofocus( fstop, targetentity, var_965582b4f1f2f995, var_a73de14f2a32675f, angles, var_387062334ab0e50e, ignorelist, ignorecollision, var_4a0992ce3ff1d7ea )
{
    dyndof( fstop, targetentity, var_965582b4f1f2f995, var_a73de14f2a32675f, angles, var_387062334ab0e50e, ignorelist, ignorecollision, var_4a0992ce3ff1d7ea );
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x6100
// Size: 0x9
function dof_disable_autofocus()
{
    dyndof_disable();
}

// Namespace utility / scripts\common\utility
// Params 7
// Checksum 0x0, Offset: 0x6111
// Size: 0x26d
function dof_enable( fstop, focusdistance, targetentity, focusspeed, aperturespeed, focalpoint, focalbone )
{
    assertex( isdefined( fstop ), "<dev string:x48b>" );
    
    if ( !isdefined( focusdistance ) && isstruct( targetentity ) && targetentity == level )
    {
        assertmsg( "<dev string:x4a0>" );
    }
    else if ( !isdefined( focusdistance ) )
    {
        focusdistance = 1;
    }
    
    if ( !isdefined( focusspeed ) )
    {
        focusspeed = 1;
    }
    
    if ( !isdefined( aperturespeed ) )
    {
        aperturespeed = 2;
    }
    
    assertex( !isdefined( targetentity ) || isent( targetentity ), "<dev string:x4bd>" );
    player = self;
    player notify( "stop_dyndof" );
    player notify( "stop_dyndof_debug" );
    
    if ( issp() )
    {
        setsaveddvar( @"hash_62c917f9692eb820", 1 );
    }
    else
    {
        setdvar( @"hash_62c917f9692eb820", 1 );
    }
    
    player enablephysicaldepthoffieldscripting();
    
    if ( isdefined( targetentity ) )
    {
        if ( isdefined( focalbone ) )
        {
            focalpoint = targetentity gettagorigin( focalbone );
            
            /#
                if ( getdvarint( @"hash_93ca035fa3964d3d", 0 ) )
                {
                    print3d( focalpoint, "<dev string:x4ec>" + focalbone, ( 1, 1, 1 ), 1, 0.1, 100 );
                }
            #/
        }
        else
        {
            focalpoint = targetentity.origin;
            
            /#
                if ( getdvarint( @"hash_93ca035fa3964d3d", 0 ) )
                {
                    print3d( focalpoint, "<dev string:x50a>", ( 1, 1, 1 ), 1, 0.1, 100 );
                }
            #/
        }
    }
    else
    {
        /#
            if ( getdvarint( @"hash_93ca035fa3964d3d", 0 ) )
            {
                if ( isdefined( focalpoint ) )
                {
                    print3d( focalpoint, "<dev string:x528>", ( 1, 1, 1 ), 1, 0.1, 100 );
                }
                else
                {
                    point = player geteye() + anglestoforward( player getgunangles() ) * focusdistance;
                    print3d( point, "<dev string:x54c>" + focusdistance, ( 1, 1, 1 ), 1, 0.1, 100 );
                }
            }
        #/
    }
    
    if ( isdefined( focalpoint ) )
    {
        player setphysicaldepthoffield( fstop, focusdistance, focusspeed, aperturespeed, focalpoint );
        return;
    }
    
    if ( isdefined( aperturespeed ) )
    {
        player setphysicaldepthoffield( fstop, focusdistance, focusspeed, aperturespeed );
        return;
    }
    
    if ( isdefined( focusspeed ) )
    {
        player setphysicaldepthoffield( fstop, focusdistance, focusspeed );
        return;
    }
    
    player setphysicaldepthoffield( fstop, focusdistance );
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x6386
// Size: 0x19
function dof_disable()
{
    self notify( "stop_dyndof" );
    self notify( "stop_dyndof_debug" );
    self disablephysicaldepthoffieldscripting();
}

// Namespace utility / scripts\common\utility
// Params 3
// Checksum 0x0, Offset: 0x63a7
// Size: 0x25
function dyndofexp( fstop, focusspeed, aperturespeed )
{
    scripts\common\dof::dyndofexp_internal( fstop, focusspeed, aperturespeed );
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x63d4
// Size: 0x27
function dyndofexp_disable()
{
    assertex( flag_exist( "<dev string:x568>" ), "<dev string:x57d>" );
    flag_set( "dyndofexp_disable" );
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x6403
// Size: 0x27
function dyndofexp_enable()
{
    assertex( flag_exist( "<dev string:x568>" ), "<dev string:x57d>" );
    flag_clear( "dyndofexp_disable" );
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x6432
// Size: 0x23
function dyndofexp_stop()
{
    level notify( "stop_dyndof" );
    level.dyndof = undefined;
    level.player disablephysicaldepthoffieldscripting();
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x645d
// Size: 0x71, Type: bool
function is_trial( trialname )
{
    if ( isdefined( trialname ) )
    {
        if ( isdefined( level.trial ) && isdefined( level.trial[ "missionScript" ] ) && level.trial[ "missionScript" ] == trialname )
        {
            return true;
        }
    }
    else if ( isdefined( level.trial ) && isdefined( level.trial[ "missionScript" ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x64d7
// Size: 0x35, Type: bool
function function_a10967d736dc56e5()
{
    return issp() || iscp() || istrue( level.supportsai ) || getdvarint( @"scr_default_maxagents", 0 ) > 0;
}

// Namespace utility / scripts\common\utility
// Params 4
// Checksum 0x0, Offset: 0x6515
// Size: 0xd5
function spawn_model( model_name, origin, angles, n_spawnflags )
{
    origin = default_to( origin, ( 0, 0, 0 ) );
    angles = default_to( angles, ( 0, 0, 0 ) );
    n_spawnflags = default_to( n_spawnflags, 0 );
    
    while ( true )
    {
        model = spawn( "script_model", origin, n_spawnflags );
        
        if ( isdefined( model ) )
        {
            break;
        }
        else
        {
            println( "<dev string:x59a>" + model_name + "<dev string:x5c2>" + origin + "<dev string:x5d1>" + angles );
        }
        
        waitframe();
    }
    
    if ( isstring( model_name ) )
    {
        model setmodel( model_name );
    }
    else
    {
        assert( "<dev string:x5df>" );
    }
    
    model.angles = angles;
    return model;
}

// Namespace utility / scripts\common\utility
// Params 3
// Checksum 0x0, Offset: 0x65f3
// Size: 0x50
function function_fabdd936c0f438e2( inner_radius, outer_radius, angle )
{
    setdvar( @"hash_d2840794d9092eec", inner_radius );
    setdvar( @"hash_382ea3ba7840ced3", outer_radius );
    setdvar( @"hash_c59327ee5d4929c1", cos( angle ) );
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x664b
// Size: 0xa7
function string_is_single_digit_integer( str )
{
    if ( str.size > 1 )
    {
        return 0;
    }
    
    switch ( str )
    {
        case #"hash_31100bbc01bd3230":
        case #"hash_31100cbc01bd33c3":
        case #"hash_31100dbc01bd3556":
        case #"hash_31100ebc01bd36e9":
        case #"hash_31100fbc01bd387c":
        case #"hash_311010bc01bd3a0f":
        case #"hash_311011bc01bd3ba2":
        case #"hash_311012bc01bd3d35":
        case #"hash_311017bc01bd4514":
        case #"hash_311018bc01bd46a7":
            return 1;
        default:
            return 0;
    }
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x66fa
// Size: 0x75
function function_1fb1cb439aa1e23c( str )
{
    if ( str.size > 1 && getsubstr( str, 0, 1 ) == "-" )
    {
        str = getsubstr( str, 1, str.size );
    }
    
    isint = 1;
    
    for ( var_13f1dfb7040761d7 = 0; var_13f1dfb7040761d7 < str.size ; var_13f1dfb7040761d7++ )
    {
        isint &= string_is_single_digit_integer( getsubstr( str, var_13f1dfb7040761d7, var_13f1dfb7040761d7 + 1 ) );
        
        if ( !isint )
        {
            break;
        }
    }
    
    return isint;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x6778
// Size: 0x30
function function_d5ad0ebc9d8935b6( v )
{
    return "(" + v[ 0 ] + ", " + v[ 1 ] + ", " + v[ 2 ] + ")";
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x67b1
// Size: 0x5f
function set_battlechatter( state )
{
    if ( !isalive( self ) || !isdefined( level.battlechatter ) )
    {
        return;
    }
    
    if ( isdefined( self.script_bcdialog ) && !self.script_bcdialog )
    {
        state = 0;
    }
    
    if ( !isdefined( self.battlechatterallowed ) && !state )
    {
        return;
    }
    
    self.battlechatterallowed = state;
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x6818
// Size: 0xef
function register_area_swap( swapname, swapstates )
{
    if ( !isdefined( swapname ) || !isstring( swapname ) || !isdefined( swapstates ) || !isarray( swapstates ) || swapstates.size < 2 )
    {
        assertmsg( "<dev string:x603>" );
        return;
    }
    
    foreach ( state in swapstates )
    {
        if ( !isstring( state ) )
        {
            assertmsg( "<dev string:x632>" );
            return;
        }
    }
    
    if ( !hasareaswap( swapname ) )
    {
        assertmsg( level.mapname + "<dev string:x66f>" + swapname );
        return;
    }
    
    if ( !isdefined( level.areaswaps ) )
    {
        level.areaswaps = [];
    }
    
    level.areaswaps[ swapname ] = swapstates;
}

/#

    // Namespace utility / scripts\common\utility
    // Params 0
    // Checksum 0x0, Offset: 0x690f
    // Size: 0x11e, Type: dev
    function function_fbe5042fffaeeaf3()
    {
        if ( !isdefined( level.areaswaps ) )
        {
            foreach ( swapname, swapstates in level.areaswaps )
            {
                scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x69a>" + toupper( swapname ) + "<dev string:x6a8>" );
                
                foreach ( state in swapstates )
                {
                    scripts\common\devgui::add_devgui_command( "<dev string:x6ad>" + toupper( state ), "<dev string:x6b1>" + swapname + "<dev string:x6cb>" + state + "<dev string:x6d0>" );
                }
                
                scripts\common\devgui::function_fe953f000498048f();
            }
        }
        
        scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x69a>" );
        scripts\common\devgui::add_devgui_command( "<dev string:x6d6>", "<dev string:x6ee>" );
        scripts\common\devgui::function_fe953f000498048f();
        level thread function_e1bb615381fe4ac2();
        level thread function_f2823d6bcdb5b632();
    }

    // Namespace utility / scripts\common\utility
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x6a35
    // Size: 0xb2, Type: dev
    function private function_e1bb615381fe4ac2()
    {
        setdvar( @"hash_a88eeef4e8ac164", "<dev string:x6ad>" );
        
        while ( true )
        {
            while ( getdvar( @"hash_a88eeef4e8ac164", "<dev string:x6ad>" ) == "<dev string:x6ad>" )
            {
                wait 1;
            }
            
            [ swapname, swapstate ] = strtok( getdvar( @"hash_a88eeef4e8ac164", "<dev string:x6ad>" ), "<dev string:x6cb>" );
            iprintlnbold( "<dev string:x71c>" );
            function_195990d8affba85b( swapname, swapstate, 10 );
            setdvar( @"hash_a88eeef4e8ac164", "<dev string:x6ad>" );
        }
    }

    // Namespace utility / scripts\common\utility
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x6aef
    // Size: 0xad, Type: dev
    function private function_f2823d6bcdb5b632()
    {
        while ( true )
        {
            waitframe();
            
            if ( getdvarint( @"hash_a32934ef2bee6d49", 0 ) )
            {
                setdvar( @"hash_a32934ef2bee6d49", 0 );
                
                if ( isdefined( level.var_e51c254791a269b3 ) )
                {
                    foreach ( object in level.var_e51c254791a269b3 )
                    {
                        if ( isdefined( object ) && isdefined( object.var_e36446187560069 ) )
                        {
                            object [[ object.var_e36446187560069 ]]();
                        }
                    }
                }
            }
        }
    }

#/

// Namespace utility / scripts\common\utility
// Params 3
// Checksum 0x0, Offset: 0x6ba4
// Size: 0x1b2
function function_195990d8affba85b( swapname, swapstate, hintduration )
{
    if ( !isdefined( swapname ) || !isstring( swapname ) || !isdefined( swapstate ) || !isstring( swapstate ) || !isdefined( hintduration ) || !isnumber( hintduration ) )
    {
        assertmsg( "<dev string:x735>" );
        return;
    }
    
    if ( !isdefined( level.areaswaps ) || !isdefined( level.areaswaps[ swapname ] ) || !array_contains( level.areaswaps[ swapname ], swapstate ) )
    {
        assertmsg( "<dev string:x765>" );
        return;
    }
    
    startingstate = function_76d9f2b9ac5f8307( swapname );
    
    if ( startingstate == swapstate )
    {
        assertmsg( "<dev string:x79d>" );
        return;
    }
    
    if ( isdefined( level.areaswaphints ) && array_contains( level.areaswaphints, swapname ) )
    {
        assertmsg( "<dev string:x7d7>" );
        return;
    }
    
    if ( !isdefined( level.areaswaphints ) )
    {
        level.areaswaphints = [];
    }
    
    level.areaswaphints[ level.areaswaphints.size ] = swapname;
    script_func( "area_swap_begin", swapname, swapstate, hintduration );
    setareaswaphint( swapname, swapstate );
    wait hintduration;
    function_1c1e3d250d7d89e( swapname, swapstate );
    level.areaswaphints = array_remove( level.areaswaphints, swapname );
    
    if ( level.areaswaphints.size == 0 )
    {
        level.areaswaphints = undefined;
    }
    
    level.areaswaps[ swapname ] = array_insert( array_remove( level.areaswaps[ swapname ], swapstate ), swapstate, 0 );
    function_39698f30fd7e8a1e( swapname, startingstate );
    script_func( "area_swap_complete", swapname, swapstate );
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x6d5e
// Size: 0xe9
function function_39698f30fd7e8a1e( swapname, state )
{
    entities = function_366bf1e08b0bec30( swapname, state );
    scriptables = function_c24909a1554f8010( swapname, state );
    
    if ( isdefined( entities ) )
    {
        foreach ( entity in entities )
        {
            entity thread script_func( "delete_entity_in_swap" );
        }
    }
    
    if ( isdefined( scriptables ) )
    {
        foreach ( scriptable in scriptables )
        {
            scriptable thread script_func( "delete_scriptable_in_swap" );
        }
    }
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x6e4f
// Size: 0x64
function function_76d9f2b9ac5f8307( swapname )
{
    if ( !isdefined( swapname ) || !isstring( swapname ) )
    {
        assertmsg( "<dev string:x825>" );
        return;
    }
    
    if ( !isdefined( level.areaswaps ) || !isdefined( level.areaswaps[ swapname ] ) )
    {
        assertmsg( "<dev string:x855>" );
        return;
    }
    
    return level.areaswaps[ swapname ][ 0 ];
}

// Namespace utility / scripts\common\utility
// Params 3
// Checksum 0x0, Offset: 0x6ebc
// Size: 0x4c
function is_origin_in_area_swap( origin, swapname, swapstate )
{
    scriptorigin = spawn( "script_origin", origin );
    inareaswap = scriptorigin function_82a1b9668c3e9620( swapname, swapstate );
    scriptorigin delete();
    return inareaswap;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x6f11
// Size: 0x48
function function_16fddf294a1da917( swapname )
{
    if ( !isdefined( swapname ) || !isstring( swapname ) )
    {
        assertmsg( "<dev string:x88d>" );
        return;
    }
    
    return isdefined( level.areaswaphints ) && array_contains( level.areaswaphints, swapname );
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x6f62
// Size: 0x1c, Type: bool
function function_42f93a2901d58b66()
{
    return isdefined( level.areaswaphints ) && level.areaswaphints.size > 0;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x6f87
// Size: 0x24
function function_d6b99ccf87941a5a( callback )
{
    level.var_eea8e3772a56914c = function_6d6af8144a5131f1( level.var_eea8e3772a56914c, callback );
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x6fb3
// Size: 0x24
function function_9a36ce87b588749f( callback )
{
    level.var_eea8e3772a56914c = array_remove( level.var_eea8e3772a56914c, callback );
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x6fdf
// Size: 0x31
function function_57257d1ed9ce2f48( callback )
{
    self.var_e36446187560069 = callback;
    
    /#
        level.var_e51c254791a269b3 = function_6d6af8144a5131f1( level.var_e51c254791a269b3, self );
    #/
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x7018
// Size: 0x28
function function_307245f5e6c7a85()
{
    self.var_e36446187560069 = undefined;
    
    /#
        level.var_e51c254791a269b3 = array_remove( level.var_e51c254791a269b3, self );
    #/
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x7048
// Size: 0xdf
function use_turret( turret, pose )
{
    /#
        owner = turret getturretowner();
        assertex( !isdefined( owner ), "<dev string:x8c2>" );
    #/
    
    requestedturret = scripts\asm\asm_bb::bb_getrequestedturret();
    
    if ( !isdefined( requestedturret ) || requestedturret != turret )
    {
        scripts\asm\asm_bb::bb_requestturret( turret );
    }
    
    if ( !isdefined( pose ) && isdefined( requestedturret.vehicle ) )
    {
        pose = "stand";
    }
    
    scripts\asm\asm_bb::bb_requestturretpose( pose );
    origin = turret gettagorigin( "tag_gunner" );
    angles = turret gettagangles( "tag_gunner" );
    
    if ( self islinked() )
    {
        self unlink();
    }
    
    self forceteleport( origin, angles );
    self linktoblendtotag( turret, "tag_gunner", 0 );
    self.var_2c1a52b48212191b = 1;
}

// Namespace utility / scripts\common\utility
// Params 3
// Checksum 0x0, Offset: 0x712f
// Size: 0x31
function function_5a18f19c457e5d1a( origin, viewpos, baseline )
{
    dist = distance( viewpos, origin );
    return dist / baseline;
}

// Namespace utility / scripts\common\utility
// Params 3
// Checksum 0x0, Offset: 0x7169
// Size: 0x76, Type: bool
function isleft2d( startpos, startforward, otherpos )
{
    startpos2d = ( startpos[ 0 ], startpos[ 1 ], 0 );
    otherpos2d = ( otherpos[ 0 ], otherpos[ 1 ], 0 );
    tootherpos = otherpos2d - startpos2d;
    forward2d = ( startforward[ 0 ], startforward[ 1 ], 0 );
    return tootherpos[ 0 ] * forward2d[ 1 ] - tootherpos[ 1 ] * forward2d[ 0 ] < 0;
}

// Namespace utility / scripts\common\utility
// Params 3
// Checksum 0x0, Offset: 0x71e8
// Size: 0x61
function handlemeleedamage( objweapon, meansofdeath, damage )
{
    if ( meansofdeath != "MOD_MELEE" )
    {
        return damage;
    }
    
    if ( isdefined( self.gs ) )
    {
        return ( damage * default_to( self.gs.basehealthdamagemultiplier, 1 ) );
    }
    
    return self.maxhealth + 1;
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x7252
// Size: 0x3f
function hidehudenable()
{
    if ( !isdefined( self.ui_hudhidden ) )
    {
        self.hidehudenabled = 0;
    }
    
    if ( self.hidehudenabled == 0 )
    {
        self setclientomnvar( "ui_hide_hud", 1 );
    }
    
    self.hidehudenabled++;
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x7299
// Size: 0x4f
function hidehuddisable()
{
    assert( isdefined( self.hidehudenabled ) && self.hidehudenabled > 0, "<dev string:x8ec>" );
    
    if ( self.hidehudenabled == 1 )
    {
        self setclientomnvar( "ui_hide_hud", 0 );
    }
    
    self.hidehudenabled--;
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x72f0
// Size: 0x27
function setplayerstunned()
{
    if ( !isdefined( self.isstunned ) )
    {
        self.isstunned = 1;
        return;
    }
    
    self.isstunned++;
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x731f
// Size: 0x3d
function setplayerunstunned()
{
    assertex( isdefined( self.isstunned ), "<dev string:x91d>" );
    assertex( self.isstunned > 0, "<dev string:x96f>" );
    self.isstunned--;
}

/#

    // Namespace utility / scripts\common\utility
    // Params 2
    // Checksum 0x0, Offset: 0x7364
    // Size: 0x2b, Type: dev
    function scriptbundlewarning( missingscriptbundle, fallbackscriptbundle )
    {
        println( "<dev string:x9f8>" + missingscriptbundle + "<dev string:xa15>" + fallbackscriptbundle );
    }

#/

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x7397
// Size: 0x18, Type: bool
function is_demo()
{
    if ( getdvarint( @"scr_demo", 0 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x73b8
// Size: 0x46, Type: bool
function damageflag( flag )
{
    return isdefined( self.damage ) && isdefined( self.damage.flags ) && self.damage.flags & flag;
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x7407
// Size: 0x6d
function setdamageflag( flag, boolean )
{
    if ( boolean )
    {
        self.damage.flags |= flag;
        return;
    }
    
    self.damage.flags &= ~flag;
}

// Namespace utility / scripts\common\utility
// Params 8
// Checksum 0x0, Offset: 0x747c
// Size: 0xd6
function takecoverwarning( damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage )
{
    if ( shouldshowcoverwarning() )
    {
        if ( istrue( self isswimming() ) )
        {
            self setclientomnvar( "ui_gettocover_text", "game/get_to_cover_swim" );
        }
        else
        {
            self setclientomnvar( "ui_gettocover_text", "game/get_to_cover" );
        }
        
        setdamageflag( 8, 1 );
        reducetakecoverwarnings();
        
        for ( i = 1; i <= 5 ; i++ )
        {
            self setclientomnvar( "ui_gettocover_state", i );
            wait 1;
        }
        
        self setclientomnvar( "ui_gettocover_state", 0 );
        delaythread( 60, &setdamageflag, 8, 0 );
    }
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x755a
// Size: 0x105, Type: bool
function shouldshowcoverwarning()
{
    /#
        if ( getdvarint( @"hash_92e8732bb64279f1" ) == 1 )
        {
            return true;
        }
    #/
    
    if ( issharedfuncdefined( "player", "isUsingRemoteKillstreak" ) )
    {
        if ( self [[ getsharedfunc( "player", "isUsingRemoteKillstreak" ) ]]() )
        {
            return false;
        }
    }
    
    if ( self islinked() )
    {
        return false;
    }
    
    if ( is_demo() )
    {
        return false;
    }
    
    if ( level.gameskill >= 2 )
    {
        return false;
    }
    
    if ( self.ignoreme )
    {
        return false;
    }
    
    if ( isdefined( level ) && istrue( level.missionfailed ) )
    {
        return false;
    }
    
    if ( istrue( self.forcetakecoverwarning ) )
    {
        return true;
    }
    
    if ( isdefined( self.vehicle ) )
    {
        return false;
    }
    
    if ( self getclientomnvar( "ui_gettocover_state" ) )
    {
        return false;
    }
    
    if ( !damageflag( 1 ) )
    {
        return false;
    }
    
    if ( damageflag( 8 ) )
    {
        return false;
    }
    
    if ( self [[ getsharedfunc( "player", "getTakeCoverWarnings" ) ]]() <= 0 )
    {
        return false;
    }
    
    if ( istrue( self.disabletakecoverwarning ) )
    {
        return false;
    }
    
    return true;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x7668
// Size: 0x41
function setcoverwarningcount( count )
{
    if ( !isdefined( count ) )
    {
        count = 4;
    }
    
    if ( self [[ getsharedfunc( "player", "getTakeCoverWarnings" ) ]]() <= 0 )
    {
        self [[ getsharedfunc( "player", "setTakeCoverWarnings" ) ]]( count );
    }
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x76b1
// Size: 0x49
function reducetakecoverwarnings()
{
    takecoverwarnings = self [[ getsharedfunc( "player", "getTakeCoverWarnings" ) ]]();
    
    if ( takecoverwarnings > 0 )
    {
        takecoverwarnings--;
        self [[ getsharedfunc( "player", "setTakeCoverWarnings" ) ]]( takecoverwarnings );
        
        /#
            debugtakecoverwarnings();
        #/
    }
}

/#

    // Namespace utility / scripts\common\utility
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x7702
    // Size: 0x4e, Type: dev
    function private debugtakecoverwarnings()
    {
        setdvarifuninitialized( @"hash_9a9956816888eb6c", "<dev string:xa3a>" );
        
        if ( getdvar( @"hash_9a9956816888eb6c" ) == "<dev string:xa3f>" )
        {
            iprintlnbold( "<dev string:xa44>", self [[ getsharedfunc( "<dev string:xa5c>", "<dev string:xa66>" ) ]]() );
        }
    }

#/

// Namespace utility / scripts\common\utility
// Params 8
// Checksum 0x0, Offset: 0x7758
// Size: 0x177
function function_848b07e8d4887cc8( origin, var_6629242b98c34e65, height, outer_radius, inner_radius, return_offsets, use_throttle, b_expensive )
{
    level endon( "game_ended" );
    
    if ( !isdefined( origin ) )
    {
        return [];
    }
    
    return_offsets = istrue( return_offsets );
    use_throttle = istrue( use_throttle );
    b_expensive = istrue( b_expensive );
    throttle_index = 0;
    var_2e223c656878a815 = ter_op( b_expensive, 3, 1 );
    spawn_points = [];
    var_4eb7958850481ce0 = 5;
    
    for ( i = 0; i < var_6629242b98c34e65 ; i++ )
    {
        var_6376dfc7f5dedbd1 = 0;
        final_point = undefined;
        
        while ( !isdefined( final_point ) && var_6376dfc7f5dedbd1 < var_4eb7958850481ce0 )
        {
            point = function_716a86f14151ea4a( origin, height, outer_radius, inner_radius );
            final_point = function_357cc29bfd018225( origin, point, outer_radius, inner_radius, !b_expensive );
            
            if ( isdefined( final_point ) )
            {
                if ( return_offsets )
                {
                    spawn_points[ spawn_points.size ] = final_point - origin;
                }
                else
                {
                    angles = vectortoangles( origin - final_point );
                    point = spawnstruct();
                    point.origin = final_point;
                    point.angles = ( 0, angles[ 1 ], 0 );
                    spawn_points[ spawn_points.size ] = point;
                }
            }
            else
            {
                var_6376dfc7f5dedbd1++;
            }
            
            throttle_index++;
            
            if ( use_throttle && throttle_index % var_2e223c656878a815 == 0 )
            {
                waitframe();
            }
        }
    }
    
    return spawn_points;
}

// Namespace utility / scripts\common\utility
// Params 4
// Checksum 0x0, Offset: 0x78d8
// Size: 0xa0
function function_716a86f14151ea4a( origin, height, outer_radius, inner_radius )
{
    theta = randomfloatrange( 0, 360 );
    var_6516aecb1abaf793 = 0.2;
    
    if ( isdefined( inner_radius ) )
    {
        var_6516aecb1abaf793 = inner_radius / outer_radius;
    }
    
    x = sin( theta ) * outer_radius * randomfloatrange( var_6516aecb1abaf793, 1 );
    y = cos( theta ) * outer_radius * randomfloatrange( var_6516aecb1abaf793, 1 );
    z = height;
    return ( x, y, z );
}

// Namespace utility / scripts\common\utility
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x7981
// Size: 0x12b
function private function_357cc29bfd018225( origin, var_7ae73c554e061e99, outer_radius, inner_radius, var_6cc1b6301864b1b4 )
{
    point_start = ( origin[ 0 ] + var_7ae73c554e061e99[ 0 ], origin[ 1 ] + var_7ae73c554e061e99[ 1 ], origin[ 2 ] + var_7ae73c554e061e99[ 2 ] );
    point_end = ( origin[ 0 ] + var_7ae73c554e061e99[ 0 ], origin[ 1 ] + var_7ae73c554e061e99[ 1 ], origin[ 2 ] - var_7ae73c554e061e99[ 2 ] );
    traceresult = scripts\engine\trace::capsule_trace( point_start, point_end, 15, 72 );
    var_e594f77b6a33eb8b = traceresult[ "position" ];
    
    if ( istrue( var_6cc1b6301864b1b4 ) )
    {
        waitframe();
    }
    
    final_point = origin;
    var_6b81b7b2626279ec = undefined;
    
    if ( traceresult[ "fraction" ] > 0 && isdefined( var_e594f77b6a33eb8b ) )
    {
        var_6b81b7b2626279ec = getclosestpointonnavmesh( var_e594f77b6a33eb8b );
    }
    
    if ( isdefined( var_6b81b7b2626279ec ) && abs( var_e594f77b6a33eb8b[ 2 ] - var_6b81b7b2626279ec[ 2 ] ) < 32 )
    {
        if ( distance2d( var_6b81b7b2626279ec, origin ) <= outer_radius && ( !isdefined( inner_radius ) || distance2d( var_6b81b7b2626279ec, origin ) >= inner_radius ) )
        {
            final_point = ( var_6b81b7b2626279ec[ 0 ], var_6b81b7b2626279ec[ 1 ], max( var_e594f77b6a33eb8b[ 2 ], var_6b81b7b2626279ec[ 2 ] ) );
        }
    }
    
    return final_point;
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x7ab5
// Size: 0xc, Type: bool
function isusingremote()
{
    return isdefined( self.usingremote );
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x7aca
// Size: 0x157
function function_2e9e02e8bda61ef2()
{
    contents = trace::create_contents( 0, 1, 0, 0, 0, 1, 1, 0, 0 );
    ignorelist = [];
    caststart = self.origin + ( 0, 0, 50 );
    castend = caststart + ( 0, 0, -200 );
    traceresult = trace::ray_trace( caststart, castend, ignorelist, contents );
    
    if ( isdefined( traceresult[ "entity" ] ) )
    {
        groundent = traceresult[ "entity" ];
        
        if ( groundent ismovingplatform() )
        {
            movingplatforminfo = spawnstruct();
            worldorigin = traceresult[ "position" ] + ( 0, 0, 4 );
            localorigin = rotatevectorinverted( worldorigin - groundent.origin, groundent.angles );
            localangles = combineangles( invertangles( groundent.angles ), self.angles );
            movingplatforminfo.groundent = groundent;
            movingplatforminfo.worldorigin = worldorigin;
            movingplatforminfo.localorigin = localorigin;
            movingplatforminfo.localangles = localangles;
            return movingplatforminfo;
        }
    }
    
    return undefined;
}

// Namespace utility / scripts\common\utility
// Params 3
// Checksum 0x0, Offset: 0x7c2a
// Size: 0xb8
function navrepulsorremoveondeath( radius, team, timeout )
{
    if ( !isdefined( team ) )
    {
        team = "all";
    }
    
    assertex( isent( self ), "<dev string:xa7e>" );
    assertex( isnumber( radius ), "<dev string:xab5>" );
    
    if ( !isdefined( self.unique_id ) )
    {
        scripts\engine\flags::assign_unique_id();
    }
    
    repulsor_id = "repulsor_id_" + self.unique_id;
    createnavrepulsor( repulsor_id, 0, self.origin, radius, 1, team );
    
    if ( isdefined( timeout ) )
    {
        waittill_notify_or_timeout( "death", timeout );
    }
    else
    {
        self waittill( "death" );
    }
    
    destroynavrepulsor( repulsor_id );
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x7cea
// Size: 0x69
function function_cbd68bd4ed708086( origin, radius )
{
    r = sqrt( radius );
    theta = randomfloat( 360 );
    offset = ( r * cos( theta ), r * sin( theta ), 0 );
    randompoint = origin + offset;
    randompoint = getclosestpointonnavmesh( randompoint );
    return randompoint;
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x7d5c
// Size: 0x92
function function_c62375923163b86c( origin, radius )
{
    loopcount = 0;
    offset = ( randomfloatrange( radius * -1, radius ), randomfloatrange( radius * -1, radius ), 0 );
    randompoint = getclosestpointonnavmesh( origin + offset );
    
    while ( distance2dsquared( origin, randompoint ) > radius * radius )
    {
        loopcount++;
        offset = ( randomfloatrange( radius * -1, radius ), randomfloatrange( radius * -1, radius ), 0 );
        randompoint = getclosestpointonnavmesh( origin + offset );
        
        if ( loopcount > 10 )
        {
            return origin;
        }
    }
    
    return randompoint;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x7df7
// Size: 0xab
function igc_camera( bool )
{
    player = self;
    registered = "igc";
    
    if ( bool )
    {
        player setstance( "stand", 1, 1, 1 );
        player val::set( registered, "freezecontrols", 1 );
        player val::set( registered, "cinematic_motion", 0 );
        player val::set( registered, "weapon", 0 );
        player val::set( registered, "damage", 0 );
        player val::set( registered, "breath_system", 0 );
        player val::set( registered, "show_hud", 0 );
        player cleardamageindicators();
        return;
    }
    
    player val::reset_all( registered );
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x7eaa
// Size: 0xa6
function letterbox_enable( bool, time )
{
    player = self;
    time = default_to( time, 2 );
    wasenabled = player ent_flag_exist( "letterbox_enabled" ) && player ent_flag( "letterbox_enabled" );
    
    if ( bool && !wasenabled )
    {
        player ent_flag_set( "letterbox_enabled" );
        player lerpfovscalefactor( 0, time );
        showcinematicletterboxing( time, 0, player );
        return;
    }
    
    if ( !bool && wasenabled )
    {
        player ent_flag_clear( "letterbox_enabled" );
        player lerpfovscalefactor( 1, time );
        hidecinematicletterboxing( time, 0, player );
    }
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x7f58
// Size: 0x3d
function isweaponthrowingknife( weapon )
{
    if ( isdefined( weapon ) && isdefined( weapon.classname ) && weapon.classname == "throwingknife" )
    {
        return 1;
    }
    
    return 0;
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x7f9d
// Size: 0x3d
function giveachievement_wrapper( achievement, notused )
{
    if ( is_demo() )
    {
        return;
    }
    
    level.player giveachievement( achievement );
    println( "<dev string:xaff>" + achievement );
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x7fe2
// Size: 0xab
function knockback_flat( knockback_direction, knockback_magnitude )
{
    if ( !isdefined( self getgroundentity() ) )
    {
        knockback_magnitude *= 0.5;
        knockback_direction = ( knockback_direction[ 0 ], knockback_direction[ 1 ], 0 );
        
        if ( lengthsquared( knockback_direction ) > 0 )
        {
            knockback_direction = vectornormalize( knockback_direction );
            knockback_direction = ( knockback_direction[ 0 ], knockback_direction[ 1 ], 0.1 );
            self knockback( knockback_direction, knockback_magnitude );
        }
        
        return;
    }
    
    knockback_direction = ( knockback_direction[ 0 ], knockback_direction[ 1 ], max( knockback_direction[ 2 ], 0 ) );
    
    if ( lengthsquared( knockback_direction ) > 0 )
    {
        knockback_direction = vectornormalize( knockback_direction );
        
        if ( knockback_direction[ 2 ] < 0.1 )
        {
            knockback_direction = ( knockback_direction[ 0 ], knockback_direction[ 1 ], 0.1 );
        }
        
        self knockback( knockback_direction, knockback_magnitude );
    }
}

// Namespace utility / scripts\common\utility
// Params 2
// Checksum 0x0, Offset: 0x8095
// Size: 0x56, Type: bool
function function_ec40425fb125f6cf( equipment, attackerteam )
{
    if ( isdefined( self.team ) && isdefined( attackerteam ) && self.team == attackerteam )
    {
        if ( isdefined( self.var_2e2e7605fb14820a ) && istrue( self.var_2e2e7605fb14820a[ equipment ] ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\common\utility
// Params 0
// Checksum 0x0, Offset: 0x80f4
// Size: 0x51
function function_59c23b77bb630ee0()
{
    groundlocation = getgroundposition( self.origin, 1 );
    waterheight = getwaterheightatlocation( groundlocation );
    
    if ( isdefined( waterheight ) && groundlocation[ 2 ] < waterheight )
    {
        groundposition = ( groundlocation[ 0 ], groundlocation[ 1 ], waterheight );
    }
    
    return groundlocation;
}

// Namespace utility / scripts\common\utility
// Params 1
// Checksum 0x0, Offset: 0x814e
// Size: 0x83
function function_24b30e4d02b6d011( hdrcolor )
{
    var_5f8685f4f3135fd2 = strtok( hdrcolor, " " );
    assert( var_5f8685f4f3135fd2.size == 4 || var_5f8685f4f3135fd2.size == 3, "<dev string:xb10>" + hdrcolor + "<dev string:xb1e>" );
    rgbcolor = [];
    
    for ( i = 0; i < 3 ; i++ )
    {
        rgbcolor[ i ] = int( ceil( float( var_5f8685f4f3135fd2[ i ] ) * 255 ) );
    }
    
    return rgbcolor;
}

