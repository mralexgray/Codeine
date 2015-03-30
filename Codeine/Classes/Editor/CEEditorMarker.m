
/* $Id$ */

#import "CEEditorMarker.h"

@implementation CEEditorMarker

- ( void )drawRect: ( NSRect )rect
{
    NSColor      * color1;
    NSColor      * color2;
    NSGradient   * gradient;
    NSBezierPath * path;
    CGFloat        h;
    CGFloat        s;
    CGFloat        b;
    
    h = ( CGFloat )0;
    s = ( CGFloat )0;
    b = ( CGFloat )0;
    
    color1 = [ NSColor colorForControlTint: NSBlueControlTint ];
    color1 = [ color1 colorUsingColorSpaceName: NSDeviceRGBColorSpace ];
    
    [ color1 getHue: &h saturation: &s brightness: &b alpha: NULL ];
    
    if( APPLICATION.isActive == YES )
    {
        color1 = [ NSColor colorWithCalibratedHue: h saturation: s + ( CGFloat )0.2 brightness: b alpha: ( CGFloat )1 ];
        color2 = [ NSColor colorWithCalibratedHue: h saturation: s + ( CGFloat )0.4 brightness: b - ( CGFloat )0.4 alpha: ( CGFloat )1 ];
    }
    else
    {
        color1 = [ NSColor colorWithCalibratedHue: h saturation: ( CGFloat )0 brightness: b alpha: ( CGFloat )1 ];
        color2 = [ NSColor colorWithCalibratedHue: h saturation: ( CGFloat )0 brightness: b - ( CGFloat )0.4 alpha: ( CGFloat )1 ];
    }
    
    gradient = [ [NSGradient alloc ] initWithColorsAndLocations: color1, ( CGFloat )0, color2, ( CGFloat )1, nil ];
    path     = [ NSBezierPath bezierPath ];
    rect     = NSInsetRect( rect, ( CGFloat )1, ( CGFloat )0 );
    
    [ path appendBezierPathWithRoundedRect: rect xRadius: ( CGFloat )5 yRadius: ( CGFloat )5 ];
    [ gradient drawInBezierPath: path angle: ( CGFloat )90 ];
    [ gradient release ];
    
    rect.origin.x    += ( CGFloat )0.30;
    rect.origin.y    += ( CGFloat )0.30;
    rect.size.width  -= ( CGFloat )0.60;
    rect.size.height -= ( CGFloat )0.60;
    
    gradient = [ [ NSGradient alloc ] initWithStartingColor:    [ NSColor colorWithCalibratedWhite: ( CGFloat )0 alpha: ( CGFloat )0.50 ]
                                              endingColor:      [ NSColor colorWithCalibratedWhite: ( CGFloat )0 alpha: ( CGFloat )0.75 ]
               ];
    
    [ path appendBezierPath: [ NSBezierPath bezierPathWithRoundedRect: rect xRadius: ( CGFloat )5 yRadius: ( CGFloat )5 ] ];
    [ path setWindingRule: NSEvenOddWindingRule ];
    [ gradient drawInBezierPath: path angle: ( CGFloat )90 ];
    
    [ gradient release ];
}

@end
