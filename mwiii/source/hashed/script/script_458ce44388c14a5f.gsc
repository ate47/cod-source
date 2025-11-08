#using scripts\mp\gametypes\br;

#namespace ftue_inventory;

// Namespace ftue_inventory / namespace_80da074a96524381
// Params 1
// Checksum 0x0, Offset: 0x116
// Size: 0x14
function function_59ded31f4834f8de( callback )
{
    function_38202445901a52d4( callback, 0 );
}

// Namespace ftue_inventory / namespace_80da074a96524381
// Params 1
// Checksum 0x0, Offset: 0x132
// Size: 0x15
function function_7d664ce89c1009ca( callback )
{
    function_38202445901a52d4( callback, 1 );
}

// Namespace ftue_inventory / namespace_80da074a96524381
// Params 2
// Checksum 0x0, Offset: 0x14f
// Size: 0x1c
function function_85ddcac5eded3985( itemindex, callback )
{
    function_6c2a61aa8ec80c16( itemindex, callback );
}

// Namespace ftue_inventory / namespace_80da074a96524381
// Params 2
// Checksum 0x0, Offset: 0x173
// Size: 0x1c
function function_bd09b7d6832880c4( callback, itemtype )
{
    function_13aee3d35bd71f6b( callback, itemtype );
}

// Namespace ftue_inventory / namespace_80da074a96524381
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x197
// Size: 0x5e
function private function_38202445901a52d4( callback, typeaction )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    
    while ( true )
    {
        self waittill( "luinotifyserver", channel, action );
        
        if ( channel == "inventory_action" )
        {
            if ( action == typeaction )
            {
                self [[ callback ]]();
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace ftue_inventory / namespace_80da074a96524381
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1fd
// Size: 0x6a
function private function_6c2a61aa8ec80c16( item, callback )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    assert( isdefined( item ) );
    
    while ( true )
    {
        self waittill( "luinotifyserver", channel, itemindex );
        
        if ( channel == "inventory_select_option" )
        {
            if ( item == itemindex )
            {
                self [[ callback ]]( itemindex );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace ftue_inventory / namespace_80da074a96524381
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x26f
// Size: 0xb3
function private function_13aee3d35bd71f6b( callback, itemtype )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    
    while ( true )
    {
        self waittill( "luinotifyserver", channel, id );
        
        if ( channel != "drop_all_items" && channel != "drop_item" )
        {
            continue;
        }
        
        dropall = channel == "drop_all_items";
        itemtypedropped = function_86081f65c04e8ebe( id );
        itemindexdropped = function_ab41acc7ac2f6642( id );
        
        if ( isdefined( itemtype ) )
        {
            if ( itemtypedropped == itemtype )
            {
                self [[ callback ]]( id, itemtypedropped, itemindexdropped, dropall );
            }
            
            return;
        }
        
        self [[ callback ]]( id, itemtypedropped, itemindexdropped, dropall );
        return;
    }
}

