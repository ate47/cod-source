#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_c456b188bf9f0dc4;

// Namespace namespace_c456b188bf9f0dc4 / namespace_ea0f522eef874258
// Params 0
// Checksum 0x0, Offset: 0x112
// Size: 0x13
function function_1d4cf90e795ad643()
{
    callback::add( "zombie_melee", &function_b77a1c7cf3728429 );
}

// Namespace namespace_c456b188bf9f0dc4 / namespace_ea0f522eef874258
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x12d
// Size: 0x1d5
function private function_b77a1c7cf3728429( params )
{
    if ( isplayer( params.meleehitent ) )
    {
        player = params.meleehitent;
        var_4193765ddb4cdce7 = self asmgetcurrentstate( self.asmname ) == "tail_whip";
        
        if ( var_4193765ddb4cdce7 )
        {
            player knockback_flat( player.origin - self.origin, self.zombieaisettings.var_e58a65b7a8f5973c.var_fdef87a2422ca38a );
            return;
        }
        
        utility::function_3ab9164ef76940fd( "melee", "melee" );
        player utility::function_3ab9164ef76940fd( "abomBiteVFX", "vfx_start" );
        player knockback_flat( player.origin - self.origin, self.zombieaisettings.var_e58a65b7a8f5973c.var_3d9c1f087e495f34 );
        currtime = gettime();
        
        if ( !isdefined( self.var_9575be1f86f1154c ) || self.var_9575be1f86f1154c != player || !isdefined( self.var_1ff760e4506c1b1e ) || currtime - self.var_1ff760e4506c1b1e > 2000 )
        {
            self.biteentcount = 0;
        }
        
        self.biteentcount++;
        self.var_1ff760e4506c1b1e = currtime;
        self.var_9575be1f86f1154c = player;
        
        if ( self.biteentcount >= 3 || params.meleehitent.health <= 0 || istrue( params.meleehitent.inlaststand ) )
        {
            self.biteentcount = 0;
            self function_3e89eb3d8e3f1811( "roar_end_time", 1000 );
            self function_3e89eb3d8e3f1811( "multi_bite_roar_time", currtime + 3000 );
        }
    }
}

