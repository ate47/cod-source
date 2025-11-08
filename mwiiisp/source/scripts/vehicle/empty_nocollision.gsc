#using scripts\common\vehicle_build;

#namespace empty_nocollision;

// Namespace empty_nocollision / scripts\vehicle\empty_nocollision
// Params 3
// Checksum 0x0, Offset: 0x79
// Size: 0x45
function main( model, type, classname )
{
    build_template( type, model, undefined, classname );
    build_localinit( &init_local );
    build_life( 90000 );
    build_is_airplane();
}

// Namespace empty_nocollision / scripts\vehicle\empty_nocollision
// Params 0
// Checksum 0x0, Offset: 0xc6
// Size: 0x14
function init_local()
{
    self.disable_wash = 1;
    self hideallparts();
}

