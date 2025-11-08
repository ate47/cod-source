#namespace mp_jup_waterfront_audio;

// Namespace mp_jup_waterfront_audio / scripts\mp\maps\mp_jup_waterfront\mp_jup_waterfront_audio
// Params 0
// Checksum 0x0, Offset: 0x1a0
// Size: 0x2
function main()
{
    
}

// Namespace mp_jup_waterfront_audio / scripts\mp\maps\mp_jup_waterfront\mp_jup_waterfront_audio
// Params 0
// Checksum 0x0, Offset: 0x1aa
// Size: 0xa4
function function_2a57309bc51d8f95()
{
    if ( !isdefined( level.var_f8c3a13c0bbd604d ) )
    {
        for ( i = 0; i < 4 ; i++ )
        {
            level.var_f8c3a13c0bbd604d[ i ] = spawn( "script_model", ( 0, 0, 0 ) );
        }
        
        level.var_db61486326588e27 = 0;
    }
    
    source = level.var_f8c3a13c0bbd604d[ level.var_db61486326588e27 ];
    
    if ( source islinked() )
    {
        source unlink();
    }
    
    level.var_db61486326588e27 = ( level.var_db61486326588e27 + 1 ) % level.var_f8c3a13c0bbd604d.size;
    return source;
}

// Namespace mp_jup_waterfront_audio / scripts\mp\maps\mp_jup_waterfront\mp_jup_waterfront_audio
// Params 2
// Checksum 0x0, Offset: 0x257
// Size: 0x104
function train_audio( train, var_7f853c287b0b8af8 )
{
    var_145ca77a53feef24 = ( -500, 100, 210 );
    headoffset = ( 50, 100, 210 );
    offset = ( 0, 0, 0 );
    alias = "";
    
    if ( var_7f853c287b0b8af8 == "train_1_head" )
    {
        alias = "amb_emt_ext_train_passby_1a";
        offset = headoffset;
    }
    else if ( var_7f853c287b0b8af8 == "train_1_tail" )
    {
        alias = "amb_emt_ext_train_passby_1b";
        offset = var_145ca77a53feef24;
    }
    else if ( var_7f853c287b0b8af8 == "train_2_head" )
    {
        alias = "amb_emt_ext_train_passby_2a";
        offset = headoffset;
    }
    else
    {
        alias = "amb_emt_ext_train_passby_2b";
        offset = var_145ca77a53feef24;
    }
    
    var_79d35a8fda1db848 = function_2a57309bc51d8f95();
    var_79d35a8fda1db848.origin = train.origin;
    var_79d35a8fda1db848 linkto( train, "tag_origin", offset, ( 0, 0, 0 ) );
    waitframe();
    var_79d35a8fda1db848 playsoundonmovingent( alias );
}

// Namespace mp_jup_waterfront_audio / scripts\mp\maps\mp_jup_waterfront\mp_jup_waterfront_audio
// Params 1
// Checksum 0x0, Offset: 0x363
// Size: 0x17
function bus_audio( bus )
{
    bus playsoundonmovingent( "amb_bus_passby_engine" );
}

// Namespace mp_jup_waterfront_audio / scripts\mp\maps\mp_jup_waterfront\mp_jup_waterfront_audio
// Params 1
// Checksum 0x0, Offset: 0x382
// Size: 0x17
function van_audio( van )
{
    van playsoundonmovingent( "amb_van_passby_engine" );
}

// Namespace mp_jup_waterfront_audio / scripts\mp\maps\mp_jup_waterfront\mp_jup_waterfront_audio
// Params 1
// Checksum 0x0, Offset: 0x3a1
// Size: 0x17
function car_audio( car )
{
    car playsoundonmovingent( "amb_car_passby_engine" );
}

