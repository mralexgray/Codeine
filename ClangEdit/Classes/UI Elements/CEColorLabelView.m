/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEColorLabelView.h"
#import "CEColorLabelView+Private.h"

@implementation CEColorLabelView

- ( id )initWithFrame: ( NSRect )frame
{
    if( ( self = [ super initWithFrame: frame ] ) )
    {
        [ self setup ];
        
        if( _colors.count != _labels.count )
        {
            [ self release ];
            
            return nil;
        }
    }
    
    return self;
}

- ( id )initWithCoder: ( NSCoder * )coder
{
    if( ( self = [ super initWithCoder: coder ] ) )
    {
        [ self setup ];
        
        if( _colors.count != _labels.count )
        {
            [ self release ];
            
            return nil;
        }
    }
    
    return self;
}

- ( void )dealloc
{
    RELEASE_IVAR( _colors );
    RELEASE_IVAR( _labels );
    
    [ super dealloc ];
}

- ( void )drawRect: ( NSRect )rect
{
    NSColor         * color;
    NSString        * label;
    NSUInteger        i;
    NSRect            colorRect;
    NSRect            dotRect;
    NSGradient      * gradient;
    NSBezierPath    * path;
    CGFloat           r;
    CGFloat           g;
    CGFloat           b;
    NSFont          * font;
    
    ( void )rect;
	
    font = [ NSFont menuFontOfSize: 14 ];
    
	[ L10N( "Label:" ) drawAtPoint: NSMakePoint( ( CGFloat )20, ( CGFloat )35 ) withAttributes: [ NSDictionary dictionaryWithObject: font forKey: NSFontAttributeName ] ];
    
    i = 0;
    
    for( color in _colors )
    {
        label = [ _labels objectAtIndex: i ];
        
        color = [ color colorUsingColorSpaceName: NSDeviceRGBColorSpace ];
        r     = ( CGFloat )0;
        g     = ( CGFloat )0;
        b     = ( CGFloat )0;
        
        [ color getHue: &r saturation: &g brightness: &b alpha: NULL ];
        
        colorRect.origin.x    = ( CGFloat )20 * ( CGFloat )( i + 1 );
        colorRect.origin.y    = ( CGFloat )10;
        colorRect.size.width  = ( CGFloat )16;
        colorRect.size.height = ( CGFloat )16;
        
        dotRect  = NSInsetRect( colorRect, ( CGFloat )2, ( CGFloat )2 );
        
        if( r > ( CGFloat )0 && b > ( CGFloat )0 && b > ( CGFloat )0 )
        {
            path     = [ NSBezierPath bezierPathWithOvalInRect: dotRect ];
            gradient = [ [ NSGradient alloc ] initWithColorsAndLocations:   [ NSColor whiteColor ], ( CGFloat )0.0,
                                                                            color,                  ( CGFloat )1.0,
                                                                            nil
                       ];
            
            [ gradient drawInBezierPath: path angle: ( CGFloat )-90 ];
            [ gradient release ];
        }
        
		path     = [ NSBezierPath bezierPathWithOvalInRect: dotRect ];
		gradient = [ [ NSGradient alloc ] initWithStartingColor:    [ NSColor colorWithCalibratedWhite: ( CGFloat )0 alpha: ( CGFloat )0.1 ]
                                          endingColor:              [ NSColor colorWithCalibratedWhite: ( CGFloat )0 alpha: ( CGFloat )0.5 ]
                   ];
                   
		[ path appendBezierPath: [ NSBezierPath bezierPathWithOvalInRect: NSInsetRect( dotRect, ( CGFloat )1, ( CGFloat )1 ) ] ];
		[ path setWindingRule: NSEvenOddWindingRule ];
        [ gradient drawInBezierPath: path angle: ( CGFloat )-90 ];
        [ gradient release ];
        
        i++;
    }
}

@end
