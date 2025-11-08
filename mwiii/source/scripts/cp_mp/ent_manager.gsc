#using scripts\common\utility;
#using scripts\engine\utility;

#namespace ent_manager;

// Namespace ent_manager / scripts\cp_mp\ent_manager
// Params 0
// Checksum 0x0, Offset: 0x98
// Size: 0x2f
function init()
{
    level.entbudgetused = 0;
    level.entbudget = getdvarint( @"hash_3e029cf0de92274b", 200 );
    level.budgetedents = [];
}

// Namespace ent_manager / scripts\cp_mp\ent_manager
// Params 1
// Checksum 0x0, Offset: 0xcf
// Size: 0x30
function registerspawncount( entcount )
{
    self.entcount = entcount;
    level.entbudgetused += entcount;
    updatebudget();
}

// Namespace ent_manager / scripts\cp_mp\ent_manager
// Params 0
// Checksum 0x0, Offset: 0x107
// Size: 0xa4
function deregisterspawn()
{
    if ( isdefined( self.entcount ) && !isdefined( self.deregistered ) )
    {
        level.entbudgetused -= self.entcount;
        self.deregistered = 1;
        self.entcount = undefined;
        
        if ( level.entbudgetused < 0 )
        {
            level.entbudgetused = 0;
            assertmsg( "<dev string:x1c>" );
        }
    }
    
    if ( isdefined( self.entdeletefunc ) )
    {
        level.budgetedents = scripts\engine\utility::array_remove( level.budgetedents, self );
        self.entdeletefunc = undefined;
    }
}

// Namespace ent_manager / scripts\cp_mp\ent_manager
// Params 2
// Checksum 0x0, Offset: 0x1b3
// Size: 0x5e
function registerspawn( entcount, deletefunc )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.entcount = entcount;
    self.entdeletefunc = deletefunc;
    level.entbudgetused += entcount;
    level.budgetedents[ level.budgetedents.size ] = self;
    updatebudget();
}

// Namespace ent_manager / scripts\cp_mp\ent_manager
// Params 0
// Checksum 0x0, Offset: 0x219
// Size: 0x94
function updatebudget()
{
    if ( level.entbudgetused > level.entbudget )
    {
        if ( isdefined( level.budgetedents[ 0 ] ) )
        {
            level.entbudgetused -= level.budgetedents[ 0 ].entcount;
            self [[ level.budgetedents[ 0 ].entdeletefunc ]]();
        }
        else
        {
            assertmsg( "<dev string:x4f>" );
        }
        
        level.budgetedents = scripts\engine\utility::array_slice( level.budgetedents, 0, 1 );
    }
}

/#

    // Namespace ent_manager / scripts\cp_mp\ent_manager
    // Params 0
    // Checksum 0x0, Offset: 0x2b5
    // Size: 0x7c, Type: dev
    function function_a5aa9e07f21b879e()
    {
        if ( isdefined( level.budgetedents ) )
        {
            foreach ( ent in level.budgetedents )
            {
                if ( isdefined( ent.entdeletefunc ) )
                {
                    ent [[ ent.entdeletefunc ]]();
                }
            }
        }
    }

#/
