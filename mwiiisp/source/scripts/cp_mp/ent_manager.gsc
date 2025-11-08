#using scripts\common\utility;
#using scripts\engine\utility;

#namespace ent_manager;

// Namespace ent_manager / scripts\cp_mp\ent_manager
// Params 0
// Checksum 0x0, Offset: 0x102
// Size: 0x2f
function init()
{
    level.entbudgetused = 0;
    level.entbudget = getdvarint( @"hash_3e029cf0de92274b", 200 );
    level.budgetedents = [];
}

// Namespace ent_manager / scripts\cp_mp\ent_manager
// Params 1
// Checksum 0x0, Offset: 0x139
// Size: 0x30
function registerspawncount( entcount )
{
    self.entcount = entcount;
    level.entbudgetused += entcount;
    updatebudget();
}

// Namespace ent_manager / scripts\cp_mp\ent_manager
// Params 0
// Checksum 0x0, Offset: 0x171
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
            assertmsg( "Error more spawns deregistered than registered!" );
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
// Checksum 0x0, Offset: 0x21d
// Size: 0x58
function registerspawn( entcount, deletefunc )
{
    self.entcount = entcount;
    self.entdeletefunc = deletefunc;
    level.entbudgetused += entcount;
    level.budgetedents[ level.budgetedents.size ] = self;
    updatebudget();
}

// Namespace ent_manager / scripts\cp_mp\ent_manager
// Params 0
// Checksum 0x0, Offset: 0x27d
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
            assertmsg( "Error undefined entry in level.budgetedEnts!  Did this get deleted before deregistration?" );
        }
        
        level.budgetedents = scripts\engine\utility::array_slice( level.budgetedents, 0, 1 );
    }
}

/#

    // Namespace ent_manager / scripts\cp_mp\ent_manager
    // Params 0
    // Checksum 0x0, Offset: 0x319
    // Size: 0x79, Type: dev
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
