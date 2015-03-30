
/* $Id$ */

#import "CEDiagnosticsCell.h"
#import "CEDiagnosticWrapper.h"

@implementation CEDiagnosticsCell

- ( NSColor  * )highlightColorWithFrame: ( NSRect )cellFrame inView: ( NSView * )controlView
{


    
    return nil;
}

- ( void )drawWithFrame: ( NSRect )frame inView: ( NSView * )controlView
{
    CGFloat        h;
    CGFloat        s;
    CGFloat        b;
    NSRect         iconRect;
    NSColor      * color;
    NSImage      * icon;
    NSGradient   * gradient;
    NSBezierPath * path;
    CKDiagnostic * diagnostic;
    
    if( [ self.objectValue isKindOfClass: [ CEDiagnosticWrapper class ] ] == NO )
    {
        return;
    }
    
    diagnostic = ( ( CEDiagnosticWrapper * )( self.objectValue ) ).diagnostic;
    
    if( diagnostic.severity == CKDiagnosticSeverityError || diagnostic.severity == CKDiagnosticSeverityFatal )
    {
        color = [ NSColor redColor ];
        icon  = [ NSImage imageNamed: @"Error" ];
    }
    else if( diagnostic.severity == CKDiagnosticSeverityWarning )
    {
        color = [ NSColor yellowColor ];
        icon  = [ NSImage imageNamed: @"Warning" ];
    }
    else
    {
        color = [ NSColor grayColor ];
        icon  = [ NSImage imageNamed: @"Notice" ];
    }
    
    if( self.isHighlighted == YES )
    {
        color = [ NSColor colorForControlTint: NSGraphiteControlTint ];
    }
    
    color = [ color colorUsingColorSpaceName: NSDeviceRGBColorSpace ];
    
    [ color getHue: &h saturation: &s brightness: &b alpha: NULL ];
    
    if( APPLICATION.isActive == YES )
    {
        color  = [ NSColor colorWithDeviceHue: h saturation: s brightness: b alpha: ( self.backgroundStyle == NSBackgroundStyleDark ) ? ( CGFloat )1 : ( CGFloat )0.5 ];
    }
    else
    {
        color  = [ NSColor colorWithDeviceHue: ( CGFloat )0 saturation: ( CGFloat )0 brightness: ( CGFloat )0.75 alpha: ( self.backgroundStyle == NSBackgroundStyleDark ) ? ( CGFloat )1 : ( CGFloat )0.5 ];
        icon   = [ icon grayscaleImage ];
    }
    
    path = [ NSBezierPath bezierPath ];
    
    if( self.isHighlighted == YES )
    {
        gradient = [ [ NSGradient alloc ] initWithColorsAndLocations:   color,  ( CGFloat )0.0,
                                                                        color,  ( CGFloat )1.0,
                                                                        nil
                   ];
    }
    else
    {
        gradient = [ [ NSGradient alloc ] initWithColorsAndLocations:   [ NSColor whiteColor ], ( CGFloat )0.0,
                                                                        color,                  ( CGFloat )1.0,
                                                                        nil
                   ];
    }
    
    [ path appendBezierPathWithRoundedRect: frame xRadius: ( CGFloat )10 yRadius: ( CGFloat )10 ];
    
    [ gradient drawInBezierPath: path angle: ( CGFloat )90 ];
    [ gradient release ];
    
    gradient = [ [ NSGradient alloc ] initWithStartingColor:    [ NSColor colorWithCalibratedWhite: ( CGFloat )0 alpha: ( CGFloat )0.25 ]
                                      endingColor:              [ NSColor colorWithCalibratedWhite: ( CGFloat )0 alpha: ( CGFloat )0.5 ]
               ];
    
    frame.origin.x    += ( CGFloat )0.25;
    frame.origin.y    += ( CGFloat )0.25;
    frame.size.width  -= ( CGFloat )0.5;
    frame.size.height -= ( CGFloat )0.5;
    
    [ path appendBezierPath: [ NSBezierPath bezierPathWithRoundedRect: frame xRadius: ( CGFloat )10 yRadius: ( CGFloat )10 ] ];
    [ path setWindingRule: NSEvenOddWindingRule ];
    [ gradient drawInBezierPath: path angle: ( CGFloat )90 ];
    [ gradient release ];
    
    iconRect = CGRectMake
    (
        frame.origin.x + ( CGFloat )5,
        frame.origin.y + ( CGFloat )2,
        frame.size.height - ( CGFloat )4,
        frame.size.height - ( CGFloat )4
    );
    
    [ icon drawInRect: iconRect fromRect: NSZeroRect operation: NSCompositeSourceOver fraction: ( CGFloat )1 respectFlipped: YES hints: nil ];
    
    frame.origin.y += ( CGFloat )6;
    frame.origin.x += iconRect.origin.x + iconRect.size.width + ( CGFloat )5;
    
    [ self drawInteriorWithFrame: frame inView: controlView ];
}

@end
