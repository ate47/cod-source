#using scripts\asm\asm;

#namespace bt_util;

// Namespace bt_util / scripts\aitypes\bt_util
// Params 0
// Checksum 0x0, Offset: 0x90
// Size: 0x50
function init()
{
    if ( isdefined( level._btactions ) )
    {
        return;
    }
    
    level._btactions = [];
    anim.failure = 0;
    anim.success = 1;
    anim.running = 2;
    anim.skip = 3;
    anim.invalid = 4;
}

// Namespace bt_util / scripts\aitypes\bt_util
// Params 0
// Checksum 0x0, Offset: 0xe8
// Size: 0x56
function bt_init()
{
    assert( !isdefined( self.bt ) );
    self.bt = spawnstruct();
    
    if ( isdefined( self.behaviortreeasset ) )
    {
        self btregistertreeinstance( self.behaviortreeasset );
    }
    
    self.bt.instancedata = [];
}

// Namespace bt_util / scripts\aitypes\bt_util
// Params 1
// Checksum 0x0, Offset: 0x146
// Size: 0x31
function bt_terminateandreplace( var_99252870276d5b3e )
{
    self btterminatetreeinstance();
    
    if ( isdefined( var_99252870276d5b3e ) )
    {
        self.behaviortreeasset = var_99252870276d5b3e;
        self btregistertreeinstance( self.behaviortreeasset );
    }
}

