/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEVerticalTabBar.h"

@implementation CEVerticalTabBar

@synthesize delegate = _delegate;

- ( id )initWithFrame: ( NSRect )frame
{
    if( ( self = [ super initWithFrame: frame ] ) )
    {
        _titles = [ [ NSMutableArray alloc ] initWithCapacity: 10 ];
        _icons  = [ [ NSMutableArray alloc ] initWithCapacity: 10 ];
    }
    
    return self;
}

- ( void )dealloc
{
    RELEASE_IVAR( _titles );
    RELEASE_IVAR( _icons );
    
    [ super dealloc ];
}

- ( void )drawRect: ( NSRect )rect
{
    NSColor      * color1;
    NSColor      * color2;
    NSGradient   * gradient;
    
    [ [ NSColor windowFrameColor ] setFill ];
    
    NSRectFill( rect );
    
    rect.size.width -= ( CGFloat )1;
    
    color1   = [ NSColor colorWithDeviceWhite: ( CGFloat )0.85 alpha: ( CGFloat )1 ];
    color2   = [ NSColor colorWithDeviceWhite: ( CGFloat )0.75 alpha: ( CGFloat )1 ];
    color1   = [ color1 colorUsingColorSpaceName: NSDeviceRGBColorSpace ];
    color2   = [ color2 colorUsingColorSpaceName: NSDeviceRGBColorSpace ];
    gradient = [ [ NSGradient alloc ] initWithColorsAndLocations: color2, ( CGFloat )0, color1, ( CGFloat )0.05, color1, ( CGFloat )0.95, color2, ( CGFloat )1, nil ];
    
    [ gradient drawInRect: rect angle: ( CGFloat )0 ];
    [ gradient release ];
}

- ( void )addItemWithTitle: ( NSString * )title icon: ( NSImage * )icon
{
    [ _titles addObject: title ];
    [ _icons  addObject: icon ];
}

- ( void )removeItemAtIndex: ( NSUInteger )index
{
    @try
    {
        [ _titles removeObjectAtIndex: index ];
        [ _icons  removeObjectAtIndex: index ];
    }
    @catch( NSException * e )
    {
        ( void )e;
    }
}

- ( CEVerticalTabBarPosition )position
{
    @synchronized( self )
    {
        return _position;
    }
}

- ( void )setPosition: ( CEVerticalTabBarPosition )position
{
    @synchronized( self )
    {
        _position = position;
        
        [ self setNeedsDisplay: YES ];
    }
}

@end
