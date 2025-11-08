#using scripts\anim\utility;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\engine\hud_management;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\utility;

#namespace hud_util;

// Namespace hud_util / scripts\sp\hud_util
// Params 1
// Checksum 0x0, Offset: 0x381
// Size: 0xa8
function setparent( element )
{
    if ( isdefined( self.parent ) && self.parent == element )
    {
        return;
    }
    
    if ( isdefined( self.parent ) )
    {
        self.parent removechild( self );
    }
    
    self.parent = element;
    self.parent addchild( self );
    
    if ( isdefined( self.point ) )
    {
        setpoint( self.point, self.relativepoint, self.xoffset, self.yoffset );
        return;
    }
    
    setpoint( "TOPLEFT" );
}

// Namespace hud_util / scripts\sp\hud_util
// Params 0
// Checksum 0x0, Offset: 0x431
// Size: 0xb
function getparent()
{
    return self.parent;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 0
// Checksum 0x0, Offset: 0x445
// Size: 0xac
function removedestroyedchildren()
{
    if ( isdefined( self.childchecktime ) && self.childchecktime == gettime() )
    {
        return;
    }
    
    self.childchecktime = gettime();
    newchildren = [];
    
    foreach ( child in self.children )
    {
        if ( !isdefined( child ) )
        {
            continue;
        }
        
        child.index = newchildren.size;
        newchildren[ newchildren.size ] = child;
    }
    
    self.children = newchildren;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 1
// Checksum 0x0, Offset: 0x4f9
// Size: 0x3e
function addchild( element )
{
    element.index = self.children.size;
    self.children[ self.children.size ] = element;
    removedestroyedchildren();
}

// Namespace hud_util / scripts\sp\hud_util
// Params 1
// Checksum 0x0, Offset: 0x53f
// Size: 0xac
function removechild( element )
{
    element.parent = undefined;
    
    if ( self.children[ self.children.size - 1 ] != element )
    {
        self.children[ element.index ] = self.children[ self.children.size - 1 ];
        self.children[ element.index ].index = element.index;
    }
    
    self.children[ self.children.size - 1 ] = undefined;
    element.index = undefined;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 5
// Checksum 0x0, Offset: 0x5f3
// Size: 0x3ed
function setpoint( point, relativepoint, xoffset, yoffset, movetime )
{
    if ( !isdefined( movetime ) )
    {
        movetime = 0;
    }
    
    element = getparent();
    
    if ( movetime )
    {
        self moveovertime( movetime );
    }
    
    if ( !isdefined( xoffset ) )
    {
        xoffset = 0;
    }
    
    self.xoffset = xoffset;
    
    if ( !isdefined( yoffset ) )
    {
        yoffset = 0;
    }
    
    self.yoffset = yoffset;
    self.point = point;
    self.alignx = "center";
    self.aligny = "middle";
    
    if ( issubstr( point, "TOP" ) )
    {
        self.aligny = "top";
    }
    
    if ( issubstr( point, "BOTTOM" ) )
    {
        self.aligny = "bottom";
    }
    
    if ( issubstr( point, "LEFT" ) )
    {
        self.alignx = "left";
    }
    
    if ( issubstr( point, "RIGHT" ) )
    {
        self.alignx = "right";
    }
    
    if ( !isdefined( relativepoint ) )
    {
        relativepoint = point;
    }
    
    self.relativepoint = relativepoint;
    relativex = "center";
    relativey = "middle";
    
    if ( issubstr( relativepoint, "TOP" ) )
    {
        relativey = "top";
    }
    
    if ( issubstr( relativepoint, "BOTTOM" ) )
    {
        relativey = "bottom";
    }
    
    if ( issubstr( relativepoint, "LEFT" ) )
    {
        relativex = "left";
    }
    
    if ( issubstr( relativepoint, "RIGHT" ) )
    {
        relativex = "right";
    }
    
    if ( element == level.uiparent )
    {
        self.horzalign = relativex;
        self.vertalign = relativey;
    }
    else
    {
        self.horzalign = element.horzalign;
        self.vertalign = element.vertalign;
    }
    
    if ( relativex == element.alignx )
    {
        offsetx = 0;
        xfactor = 0;
    }
    else if ( relativex == "center" || element.alignx == "center" )
    {
        offsetx = int( element.width / 2 );
        
        if ( relativex == "left" || element.alignx == "right" )
        {
            xfactor = -1;
        }
        else
        {
            xfactor = 1;
        }
    }
    else
    {
        offsetx = element.width;
        
        if ( relativex == "left" )
        {
            xfactor = -1;
        }
        else
        {
            xfactor = 1;
        }
    }
    
    self.x = element.x + offsetx * xfactor;
    
    if ( relativey == element.aligny )
    {
        offsety = 0;
        yfactor = 0;
    }
    else if ( relativey == "middle" || element.aligny == "middle" )
    {
        offsety = int( element.height / 2 );
        
        if ( relativey == "top" || element.aligny == "bottom" )
        {
            yfactor = -1;
        }
        else
        {
            yfactor = 1;
        }
    }
    else
    {
        offsety = element.height;
        
        if ( relativey == "top" )
        {
            yfactor = -1;
        }
        else
        {
            yfactor = 1;
        }
    }
    
    self.y = element.y + offsety * yfactor;
    self.x += self.xoffset;
    self.y += self.yoffset;
    
    switch ( self.elemtype )
    {
        case #"hash_2125856c1b2381fa":
            setpointbar( point, relativepoint, xoffset, yoffset );
            break;
    }
    
    updatechildren( movetime );
}

// Namespace hud_util / scripts\sp\hud_util
// Params 4
// Checksum 0x0, Offset: 0x9e8
// Size: 0x188
function setpointbar( point, relativepoint, xoffset, yoffset )
{
    self.bar.horzalign = self.horzalign;
    self.bar.vertalign = self.vertalign;
    self.bar.alignx = "left";
    self.bar.aligny = self.aligny;
    self.bar.y = self.y;
    
    if ( self.alignx == "left" )
    {
        self.bar.x = self.x + self.xpadding;
    }
    else if ( self.alignx == "right" )
    {
        self.bar.x = self.x - self.width - self.xpadding;
    }
    else
    {
        self.bar.x = self.x - int( ( self.width - self.xpadding * 2 ) / 2 );
    }
    
    updatebar( self.bar.frac );
}

// Namespace hud_util / scripts\sp\hud_util
// Params 1
// Checksum 0x0, Offset: 0xb78
// Size: 0x89
function updatebar( barfrac )
{
    barwidth = int( ( self.width - self.xpadding * 2 ) * barfrac );
    
    if ( !barwidth )
    {
        barwidth = 1;
    }
    
    self.bar.frac = barfrac;
    self.bar setshader( self.bar.shader, barwidth, self.height - self.ypadding * 2 );
}

// Namespace hud_util / scripts\sp\hud_util
// Params 1
// Checksum 0x0, Offset: 0xc09
// Size: 0xc4
function hidebar( bool )
{
    bool = ter_op( isdefined( bool ), bool, 1 );
    
    if ( bool || !isdefined( self.orig_alpha ) || !isdefined( self.bar.orig_alpha ) )
    {
        self.orig_alpha = self.alpha;
        self.bar.orig_alpha = self.bar.alpha;
    }
    
    self.alpha = ter_op( bool, 0, self.orig_alpha );
    self.bar.alpha = ter_op( bool, 0, self.bar.orig_alpha );
}

// Namespace hud_util / scripts\sp\hud_util
// Params 2
// Checksum 0x0, Offset: 0xcd5
// Size: 0xca
function createfontstring( font, fontscale )
{
    fontelem = newhudelem();
    fontelem.elemtype = "font";
    fontelem.font = font;
    fontelem.fontscale = fontscale;
    fontelem.x = 0;
    fontelem.y = 0;
    fontelem.width = 0;
    fontelem.height = int( level.fontheight * fontscale );
    fontelem.xoffset = 0;
    fontelem.yoffset = 0;
    fontelem.children = [];
    fontelem setparent( level.uiparent );
    return fontelem;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 2
// Checksum 0x0, Offset: 0xda8
// Size: 0xda
function createclientfontstring( font, fontscale )
{
    assert( isplayer( self ) );
    fontelem = newclienthudelem( self );
    fontelem.elemtype = "font";
    fontelem.font = font;
    fontelem.fontscale = fontscale;
    fontelem.x = 0;
    fontelem.y = 0;
    fontelem.width = 0;
    fontelem.height = int( level.fontheight * fontscale );
    fontelem.xoffset = 0;
    fontelem.yoffset = 0;
    fontelem.children = [];
    fontelem setparent( level.uiparent );
    return fontelem;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 2
// Checksum 0x0, Offset: 0xe8b
// Size: 0xda
function createclienttimer( font, fontscale )
{
    assert( isplayer( self ) );
    timerelem = newclienthudelem( self );
    timerelem.elemtype = "timer";
    timerelem.font = font;
    timerelem.fontscale = fontscale;
    timerelem.x = 0;
    timerelem.y = 0;
    timerelem.width = 0;
    timerelem.height = int( level.fontheight * fontscale );
    timerelem.xoffset = 0;
    timerelem.yoffset = 0;
    timerelem.children = [];
    timerelem setparent( level.uiparent );
    return timerelem;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 2
// Checksum 0x0, Offset: 0xf6e
// Size: 0xca
function createservertimer( font, fontscale )
{
    timerelem = newhudelem();
    timerelem.elemtype = "timer";
    timerelem.font = font;
    timerelem.fontscale = fontscale;
    timerelem.x = 0;
    timerelem.y = 0;
    timerelem.width = 0;
    timerelem.height = int( level.fontheight * fontscale );
    timerelem.xoffset = 0;
    timerelem.yoffset = 0;
    timerelem.children = [];
    timerelem setparent( level.uiparent );
    return timerelem;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 3
// Checksum 0x0, Offset: 0x1041
// Size: 0x35
function createicon( shader, width, height )
{
    iconelem = newhudelem();
    return createicon_hudelem( iconelem, shader, width, height );
}

// Namespace hud_util / scripts\sp\hud_util
// Params 3
// Checksum 0x0, Offset: 0x107f
// Size: 0x36
function createclienticon( shader, width, height )
{
    iconelem = newclienthudelem( self );
    return createicon_hudelem( iconelem, shader, width, height );
}

// Namespace hud_util / scripts\sp\hud_util
// Params 4
// Checksum 0x0, Offset: 0x10be
// Size: 0xb0
function createicon_hudelem( iconelem, shader, width, height )
{
    iconelem.elemtype = "icon";
    iconelem.x = 0;
    iconelem.y = 0;
    iconelem.width = width;
    iconelem.height = height;
    iconelem.xoffset = 0;
    iconelem.yoffset = 0;
    iconelem.children = [];
    iconelem setparent( level.uiparent );
    
    if ( isdefined( shader ) )
    {
        iconelem setshader( shader, width, height );
    }
    
    return iconelem;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 5
// Checksum 0x0, Offset: 0x1177
// Size: 0x1ad
function createbar( shader, bgshader, width, height, flashfrac )
{
    if ( !isdefined( shader ) )
    {
        shader = "white";
    }
    
    if ( !isdefined( bgshader ) )
    {
        bgshader = "black";
    }
    
    if ( !isdefined( width ) )
    {
        width = 100;
    }
    
    if ( !isdefined( height ) )
    {
        height = 9;
    }
    
    barelem = newhudelem();
    barelem.x = 2;
    barelem.y = 2;
    barelem.frac = 0.25;
    barelem.shader = shader;
    barelem.sort = -1;
    barelem setshader( shader, width - 2, height - 2 );
    
    if ( isdefined( flashfrac ) )
    {
        barelem.flashfrac = flashfrac;
        barelem thread flashthread();
    }
    
    barelembg = newhudelem();
    barelembg.elemtype = "bar";
    barelembg.x = 0;
    barelembg.y = 0;
    barelembg.width = width;
    barelembg.height = height;
    barelembg.xoffset = 0;
    barelembg.yoffset = 0;
    barelembg.bar = barelem;
    barelembg.children = [];
    barelembg.padding = 2;
    barelembg.sort = -2;
    barelembg.alpha = 0.5;
    barelembg setparent( level.uiparent );
    barelembg setshader( bgshader, width, height );
    return barelembg;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 8
// Checksum 0x0, Offset: 0x132d
// Size: 0xeb
function createclientprogressbar( player, y_offset, shader, bgshader, width, height, xpadding, ypadding )
{
    player = ter_op( isdefined( player ), player, level.player );
    y_offset = ter_op( isdefined( y_offset ), y_offset, 90 );
    shader = ter_op( isdefined( shader ), shader, "white" );
    bgshader = ter_op( isdefined( bgshader ), bgshader, "black" );
    width = ter_op( isdefined( width ), width, 100 );
    height = ter_op( isdefined( height ), height, 9 );
    xpadding = ter_op( isdefined( xpadding ), xpadding, 2 );
    ypadding = ter_op( isdefined( ypadding ), ypadding, 2 );
    bar = player createclientbar( shader, bgshader, width, height, undefined, xpadding, ypadding );
    bar setpoint( "CENTER", undefined, 0, y_offset );
    return bar;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 7
// Checksum 0x0, Offset: 0x1421
// Size: 0x1bf
function createclientbar( shader, bgshader, width, height, flashfrac, xpadding, ypadding )
{
    if ( !isdefined( xpadding ) )
    {
        xpadding = 2;
    }
    
    if ( !isdefined( ypadding ) )
    {
        ypadding = 2;
    }
    
    barelem = newclienthudelem( self );
    barelem.x = 0 - xpadding;
    barelem.y = 0 - ypadding;
    barelem.frac = 0.25;
    barelem.shader = shader;
    barelem.sort = -1;
    barelem setshader( shader, width - xpadding * 2, height - ypadding * 2 );
    
    if ( isdefined( flashfrac ) )
    {
        barelem.flashfrac = flashfrac;
        barelem thread flashthread();
    }
    
    barelembg = newclienthudelem( self );
    barelembg.elemtype = "bar";
    barelembg.x = 0;
    barelembg.y = 0;
    barelembg.width = width;
    barelembg.height = height;
    barelembg.xoffset = -1 * xpadding;
    barelembg.yoffset = 0;
    barelembg.bar = barelem;
    barelembg.children = [];
    barelembg.xpadding = xpadding;
    barelembg.ypadding = ypadding;
    barelembg.sort = -2;
    barelembg.alpha = 0.5;
    barelembg setparent( level.uiparent );
    barelembg setshader( bgshader, width, height );
    return barelembg;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 1
// Checksum 0x0, Offset: 0x15e9
// Size: 0x20
function setflashfrac( flashfrac )
{
    self.bar.flashfrac = flashfrac;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 2
// Checksum 0x0, Offset: 0x1611
// Size: 0x4f
function fade_over_time( target_alpha, fade_time )
{
    assertex( isdefined( target_alpha ), "fade_over_time must be passed a target_alpha." );
    
    if ( isdefined( fade_time ) && fade_time > 0 )
    {
        self fadeovertime( fade_time );
    }
    
    self.alpha = target_alpha;
    
    if ( isdefined( fade_time ) && fade_time > 0 )
    {
        wait fade_time;
    }
}

// Namespace hud_util / scripts\sp\hud_util
// Params 0
// Checksum 0x0, Offset: 0x1668
// Size: 0x83
function flashthread()
{
    self endon( "death" );
    self.alpha = 1;
    
    while ( true )
    {
        if ( self.frac >= self.flashfrac )
        {
            self fadeovertime( 0.3 );
            self.alpha = 0.2;
            wait 0.35;
            self fadeovertime( 0.3 );
            self.alpha = 1;
            wait 0.7;
            continue;
        }
        
        self.alpha = 1;
        wait 0.05;
    }
}

// Namespace hud_util / scripts\sp\hud_util
// Params 0
// Checksum 0x0, Offset: 0x16f3
// Size: 0xaf
function destroyelem()
{
    if ( isdefined( self.children ) && self.children.size )
    {
        tempchildren = [];
        
        for ( index = 0; index < self.children.size ; index++ )
        {
            tempchildren[ index ] = self.children[ index ];
        }
        
        for ( index = 0; index < tempchildren.size ; index++ )
        {
            tempchildren[ index ] setparent( getparent() );
        }
    }
    
    if ( isdefined( self.elemtype ) && self.elemtype == "bar" )
    {
        self.bar destroy();
    }
    
    self destroy();
}

// Namespace hud_util / scripts\sp\hud_util
// Params 1
// Checksum 0x0, Offset: 0x17aa
// Size: 0x25
function seticonshader( shader )
{
    self setshader( shader, self.width, self.height );
}

// Namespace hud_util / scripts\sp\hud_util
// Params 1
// Checksum 0x0, Offset: 0x17d7
// Size: 0x15
function setwidth( width )
{
    self.width = width;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 1
// Checksum 0x0, Offset: 0x17f4
// Size: 0x15
function setheight( height )
{
    self.height = height;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 2
// Checksum 0x0, Offset: 0x1811
// Size: 0x27
function setsize( width, height )
{
    self.width = width;
    self.height = height;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 1
// Checksum 0x0, Offset: 0x1840
// Size: 0x77
function updatechildren( movetime )
{
    for ( index = 0; index < self.children.size ; index++ )
    {
        child = self.children[ index ];
        child setpoint( child.point, child.relativepoint, child.xoffset, child.yoffset, movetime );
    }
}

// Namespace hud_util / scripts\sp\hud_util
// Params 1
// Checksum 0x0, Offset: 0x18bf
// Size: 0x17b
function stance_carry_icon_enable( bool )
{
    if ( isdefined( bool ) && bool == 0 )
    {
        stance_carry_icon_disable();
        return;
    }
    
    if ( isdefined( level.stance_carry ) )
    {
        level.stance_carry destroy();
    }
    
    setsaveddvar( @"hash_4e8225c28298a6ad", "0" );
    level.stance_carry = newhudelem();
    level.stance_carry.x = -75;
    
    if ( isplatformconsole() )
    {
        level.stance_carry.y = -20;
    }
    else
    {
        level.stance_carry.y = -10;
    }
    
    level.stance_carry setshader( "stance_carry", 64, 64 );
    level.stance_carry.alignx = "right";
    level.stance_carry.aligny = "bottom";
    level.stance_carry.horzalign = "right";
    level.stance_carry.vertalign = "bottom";
    level.stance_carry.foreground = 1;
    level.stance_carry.alpha = 0;
    level.stance_carry fadeovertime( 0.5 );
    level.stance_carry.alpha = 1;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 0
// Checksum 0x0, Offset: 0x1a42
// Size: 0x5b
function stance_carry_icon_disable()
{
    if ( isdefined( level.stance_carry ) )
    {
        level.stance_carry fadeovertime( 0.5 );
        level.stance_carry.alpha = 0;
        level.stance_carry destroy();
    }
    
    setsaveddvar( @"hash_4e8225c28298a6ad", "1" );
}

// Namespace hud_util / scripts\sp\hud_util
// Params 0
// Checksum 0x0, Offset: 0x1aa5
// Size: 0x3b
function create_mantle_hint()
{
    hud = createfontstring( "default", 1 );
    hud setpoint( "CENTER", undefined, 0, 80 );
    hud settext( &"PLATFORM/MANTLE" );
    return hud;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 4
// Checksum 0x0, Offset: 0x1ae9
// Size: 0x182
function get_countdown_hud( x, y, player, forcexpos )
{
    if ( !isdefined( forcexpos ) )
    {
        forcexpos = 0;
    }
    
    xpos = undefined;
    
    if ( !isplatformconsole() )
    {
        xpos = -250;
    }
    else if ( !isdefined( x ) )
    {
        xpos = -225;
    }
    else
    {
        xpos = x;
    }
    
    if ( forcexpos )
    {
        xpos = x;
    }
    
    if ( !isdefined( y ) )
    {
        ypos = 100;
    }
    else
    {
        ypos = y;
    }
    
    if ( isdefined( player ) )
    {
        hudelem = newclienthudelem( player );
    }
    else
    {
        hudelem = newhudelem();
    }
    
    hudelem.alignx = "left";
    hudelem.aligny = "middle";
    hudelem.horzalign = "right";
    hudelem.vertalign = "top";
    hudelem.x = xpos;
    hudelem.y = ypos;
    hudelem.fontscale = 1.6;
    hudelem.color = ( 0.8, 1, 0.8 );
    hudelem.font = "objective";
    hudelem.glowcolor = ( 0.3, 0.6, 0.3 );
    hudelem.glowalpha = 1;
    hudelem.foreground = 1;
    hudelem.hidewheninmenu = 1;
    hudelem.hidewhendead = 1;
    return hudelem;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 4
// Checksum 0x0, Offset: 0x1c74
// Size: 0x182
function get_download_state_hud( x, y, player, forcexpos )
{
    if ( !isdefined( forcexpos ) )
    {
        forcexpos = 0;
    }
    
    xpos = undefined;
    
    if ( !isplatformconsole() )
    {
        xpos = -250;
    }
    else if ( !isdefined( x ) )
    {
        xpos = -170;
    }
    else
    {
        xpos = x;
    }
    
    if ( forcexpos )
    {
        xpos = x;
    }
    
    if ( !isdefined( y ) )
    {
        ypos = 100;
    }
    else
    {
        ypos = y;
    }
    
    if ( isdefined( player ) )
    {
        hudelem = newclienthudelem( player );
    }
    else
    {
        hudelem = newhudelem();
    }
    
    hudelem.alignx = "right";
    hudelem.aligny = "middle";
    hudelem.horzalign = "right";
    hudelem.vertalign = "top";
    hudelem.x = xpos;
    hudelem.y = ypos;
    hudelem.fontscale = 1.6;
    hudelem.color = ( 0.8, 1, 0.8 );
    hudelem.font = "objective";
    hudelem.glowcolor = ( 0.3, 0.6, 0.3 );
    hudelem.glowalpha = 1;
    hudelem.foreground = 1;
    hudelem.hidewheninmenu = 1;
    hudelem.hidewhendead = 1;
    return hudelem;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 3
// Checksum 0x0, Offset: 0x1dff
// Size: 0xd1
function create_client_overlay( shader_name, start_alpha, player )
{
    if ( isdefined( player ) )
    {
        overlay = newclienthudelem( player );
    }
    else
    {
        overlay = newhudelem();
    }
    
    overlay.x = 0;
    overlay.y = 0;
    overlay setshader( shader_name, 640, 480 );
    overlay.alignx = "left";
    overlay.aligny = "top";
    overlay.sort = 1;
    overlay.horzalign = "fullscreen";
    overlay.vertalign = "fullscreen";
    overlay.alpha = start_alpha;
    overlay.foreground = 1;
    return overlay;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 3
// Checksum 0x0, Offset: 0x1ed9
// Size: 0xd5
function function_9478a061111af71f( fade_state, var_a1d797ec9d2d9038, callback_function )
{
    self endon( "death_or_disconnect" );
    assertex( function_a0ae4b54aa48ade2( "scripted_widget_hud_fade_overlay" ), "Attempting to use scripted_widget_hud_fade_overlay when it doesnt exist. Please make sure your level contains a scripted_widget_hud_fade_overlay asset reference inside of APE." );
    
    if ( !isdefined( fade_state ) )
    {
        fade_state = default_to( fade_state, "fade_in_normal" );
    }
    
    assertex( isdefined( function_daff24f3e11825ae( "scripted_widget_hud_fade_overlay", fade_state ) ), "fade_state is an invalid state. Please double check that fade_state is one of the valid states defined in hud_fade_overlay.gsh." );
    
    if ( !isdefined( var_a1d797ec9d2d9038 ) )
    {
        var_a1d797ec9d2d9038 = 1;
    }
    
    scripts\common\ui::lui_registercallback( "hud_fade_overlay_complete", &hud_fade_overlay_complete );
    
    if ( !function_ada0825249682644( "hud_fade_overlay" ) )
    {
        function_90de31b2cbef19f9( "hud_fade_overlay", "scripted_widget_hud_fade_overlay" );
        function_f4c37324750dc183( "hud_fade_overlay", 0, 0, 3, 3 );
    }
    
    function_d28fa5295a04d555( "hud_fade_overlay", fade_state );
    self.var_c77404ded14e0abf = callback_function;
    self.var_fff0a33228a51498 = var_a1d797ec9d2d9038;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 0
// Checksum 0x0, Offset: 0x1fb6
// Size: 0x1c
function function_44ee9d2850aafaf5()
{
    if ( function_ada0825249682644( "hud_fade_overlay" ) )
    {
        scripted_widget_destroy( "hud_fade_overlay" );
    }
}

// Namespace hud_util / scripts\sp\hud_util
// Params 1
// Checksum 0x0, Offset: 0x1fda
// Size: 0x5a
function hud_fade_overlay_complete( val )
{
    if ( isdefined( self.var_fff0a33228a51498 ) && self.var_fff0a33228a51498 )
    {
        function_44ee9d2850aafaf5();
    }
    
    if ( isdefined( self.var_c77404ded14e0abf ) )
    {
        thread [[ self.var_c77404ded14e0abf ]]();
    }
    
    self.var_c77404ded14e0abf = undefined;
    self.var_fff0a33228a51498 = undefined;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 5
// Checksum 0x0, Offset: 0x203c
// Size: 0x10b
function create_client_overlay_custom_size( shader_name, start_alpha, x, y, scale )
{
    player = get_player_from_self();
    overlay = newclienthudelem( player );
    
    if ( !isdefined( scale ) )
    {
        scale = 1;
    }
    
    if ( !isdefined( x ) )
    {
        x = 0;
    }
    
    if ( !isdefined( y ) )
    {
        y = 0;
    }
    
    overlay.x = x;
    overlay.y = y;
    overlay setshader( shader_name, int( 640 * scale ), int( 480 * scale ) );
    overlay.alignx = "center";
    overlay.aligny = "middle";
    overlay.sort = 1;
    overlay.horzalign = "center";
    overlay.vertalign = "middle";
    overlay.alpha = start_alpha;
    overlay.foreground = 1;
    return overlay;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 5
// Checksum 0x0, Offset: 0x2150
// Size: 0xfb
function create_client_overlay_fullscreen( shader, start_alpha, x, y, scale )
{
    player = get_player_from_self();
    overlay = newclienthudelem( player );
    
    if ( !isdefined( scale ) )
    {
        scale = 1;
    }
    
    overlay.x = x;
    overlay.y = y;
    overlay setshader( shader, int( 640 * scale ), int( 480 * scale ) );
    overlay.alignx = "center";
    overlay.aligny = "middle";
    overlay.sort = 1;
    overlay.horzalign = "fullscreen";
    overlay.vertalign = "fullscreen";
    overlay.alpha = start_alpha;
    overlay.foreground = 1;
    return overlay;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 2
// Checksum 0x0, Offset: 0x2254
// Size: 0xab
function fade_in( time, shader )
{
    if ( level.missionfailed )
    {
        return;
    }
    
    if ( getprojectname() == "T10" && ( !isdefined( shader ) || shader == "black" ) )
    {
        fadestate = function_c83baa57f3055403( time, 1 );
        level.player function_9478a061111af71f( fadestate, 1 );
        return;
    }
    
    if ( !isdefined( time ) )
    {
        time = 0.3;
    }
    
    overlay = get_optional_overlay( shader );
    
    if ( time > 0 )
    {
        overlay fadeovertime( time );
    }
    
    overlay.alpha = 0;
    
    if ( time > 0 )
    {
        wait time;
    }
}

// Namespace hud_util / scripts\sp\hud_util
// Params 1
// Checksum 0x0, Offset: 0x2307
// Size: 0x1e
function get_optional_overlay( shader )
{
    if ( !isdefined( shader ) )
    {
        shader = "black";
    }
    
    return get_overlay( shader );
}

// Namespace hud_util / scripts\sp\hud_util
// Params 2
// Checksum 0x0, Offset: 0x232e
// Size: 0x9d
function fade_out( time, shader )
{
    if ( getprojectname() == "T10" && ( !isdefined( shader ) || shader == "black" ) )
    {
        fadestate = function_c83baa57f3055403( time, 0 );
        level.player function_9478a061111af71f( fadestate, 0 );
        return;
    }
    
    if ( !isdefined( time ) )
    {
        time = 0.3;
    }
    
    overlay = get_optional_overlay( shader );
    
    if ( time > 0 )
    {
        overlay fadeovertime( time );
    }
    
    overlay.alpha = 1;
    
    if ( time > 0 )
    {
        wait time;
    }
}

// Namespace hud_util / scripts\sp\hud_util
// Params 1
// Checksum 0x0, Offset: 0x23d3
// Size: 0x2b
function start_overlay( shader )
{
    overlay = get_optional_overlay( shader );
    overlay.alpha = 1;
}

// Namespace hud_util / scripts\sp\hud_util
// Params 1
// Checksum 0x0, Offset: 0x2406
// Size: 0xb2
function get_overlay( shader )
{
    if ( isplayer( self ) )
    {
        guy = self;
    }
    else
    {
        guy = level.player;
    }
    
    if ( !isdefined( guy.overlay ) )
    {
        guy.overlay = [];
    }
    
    if ( !isdefined( guy.overlay[ shader ] ) )
    {
        guy.overlay[ shader ] = create_client_overlay( shader, 0, guy );
    }
    
    guy.overlay[ shader ].sort = 0;
    guy.overlay[ shader ].foreground = 1;
    return guy.overlay[ shader ];
}

// Namespace hud_util / scripts\sp\hud_util
// Params 0
// Checksum 0x0, Offset: 0x24c1
// Size: 0x3b
function screen_detailed_alpha()
{
    fade_in_time = 0.2;
    self.alpha = 0.7;
    self fadeovertime( fade_in_time );
    self.alpha = 0;
    wait fade_in_time;
    self destroy();
}

// Namespace hud_util / scripts\sp\hud_util
// Params 2
// Checksum 0x0, Offset: 0x2504
// Size: 0x90
function function_c83baa57f3055403( time, var_e5d303cebf3950fa )
{
    if ( var_e5d303cebf3950fa )
    {
        if ( time <= 0 )
        {
            return "fade_in_snap";
        }
        else if ( time <= 0.7 )
        {
            return "fade_in_short";
        }
        else if ( time <= 1.3 )
        {
            return "fade_in_normal";
        }
        else
        {
            return "fade_in_long";
        }
        
        return;
    }
    
    if ( time <= 0 )
    {
        return "fade_out_snap";
    }
    
    if ( time <= 0.7 )
    {
        return "fade_out_short";
    }
    
    if ( time <= 1.3 )
    {
        return "fade_out_normal";
    }
    
    return "fade_out_long";
}

