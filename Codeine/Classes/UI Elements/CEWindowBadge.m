
/* $Id$ */

#import "CEWindowBadge.h"
#import "CEWindowBadge+Private.h"

@implementation CEWindowBadge

@synthesize title                   = _title;
@synthesize backgroundColor         = _backgroundColor;
@synthesize activeBackgroundColor   = _activeBackgroundColor;
@synthesize target                  = _target;
@synthesize action                  = _action;

- ( instancetype )initWithFrame: ( NSRect )frame
{
    NSTrackingAreaOptions options;
    NSRect                trackingRect;
    
    if( ( self = [ super initWithFrame: frame ] ) )
    {
        trackingRect  = NSMakeRect( ( CGFloat )0, ( CGFloat )0, frame.size.width, frame.size.height );
        options       = NSTrackingEnabledDuringMouseDrag
                      | NSTrackingMouseEnteredAndExited
                      | NSTrackingActiveInActiveApp
                      | NSTrackingActiveAlways;
        _trackingArea =[NSTrackingArea.alloc 
         initWithRect: trackingRect options: options owner: self userInfo: nil ];
        
        [ self addTrackingArea: _trackingArea ];
        
        self.backgroundColor        = [ NSColor colorForControlTint: NSGraphiteControlTint ];
        self.activeBackgroundColor  = [ NSColor colorForControlTint: NSBlueControlTint ];
        
        [ NOTIFICATION_CENTER addObserver: self selector: @selector( applicationStateDidChange: ) name: NSApplicationDidBecomeActiveNotification object: APPLICATION ];
        [ NOTIFICATION_CENTER addObserver: self selector: @selector( applicationStateDidChange: ) name: NSApplicationDidResignActiveNotification object: APPLICATION ];
    }
    
    return self;
}

- ( void )dealloc
{
    [ NOTIFICATION_CENTER removeObserver: self ];
    [ self removeTrackingArea: _trackingArea ];
    
    RELEASE_IVAR( _trackingArea );
    
}

- ( void )mouseEntered: ( NSEvent * )event
{

    
    _inTrackingArea = YES;
    
    [ self setNeedsDisplay: YES ];
}

- ( void )mouseExited: ( NSEvent * )event
{

    
    _inTrackingArea = NO;
    
    [ self setNeedsDisplay: YES ];
}

- ( void )mouseDown: ( NSEvent * )event
{

    
    if( _target != nil && _action != NULL )
    {
        [ _target performSelector: _action withObject: self ];
    }
}

- ( void )drawRect: ( NSRect )rect
{
    NSRect            innerRect;
    CGFloat           h;
    CGFloat           s;
    CGFloat           b;
    NSGradient      * gradient;
    NSBezierPath    * path1;
    NSBezierPath    * path2;
    NSColor         * color1;
    NSColor         * color2;
    
    innerRect = NSInsetRect( rect, ( CGFloat )7.5, ( CGFloat )7.5 );
    path1     = [ NSBezierPath bezierPath ];
    
    [ path1 appendBezierPathWithArcWithCenter: NSMakePoint( NSMinX( innerRect ), NSMinY( innerRect ) ) radius: ( CGFloat )7.5 startAngle: ( CGFloat )180 endAngle: ( CGFloat )270 ];
    [ path1 appendBezierPathWithArcWithCenter: NSMakePoint( NSMaxX( innerRect ), NSMinY( innerRect ) ) radius: ( CGFloat )7.5 startAngle: ( CGFloat )270 endAngle: ( CGFloat )360 ];
    [ path1 lineToPoint: NSMakePoint( NSMaxX( rect ), NSMaxY( rect ) ) ];
    [ path1 lineToPoint: NSMakePoint( NSMinX( rect ), NSMaxY( rect ) ) ];
    
    [ path1 closePath ];
    
    h = ( CGFloat )0;
    s = ( CGFloat )0;
    b = ( CGFloat )0;
    
    if( _inTrackingArea == YES && _target != nil && _action != NULL )
    {
        color1 = _activeBackgroundColor;
    }
    else
    {
        color1 = _backgroundColor;
    }
    
    color1 = [ color1 colorUsingColorSpaceName: NSDeviceRGBColorSpace ];
    
    [ color1 getHue: &h saturation: &s brightness: &b alpha: NULL ];
    
    if( APPLICATION.isActive )
    {
        color1 = [ NSColor colorWithCalibratedHue: h saturation: s brightness: b alpha: ( CGFloat )1 ];
        color2 = [ NSColor colorWithCalibratedHue: h saturation: s + ( CGFloat )0.15 brightness: b - ( CGFloat )0.15 alpha: ( CGFloat )1 ];
    }
    else
    {
        color1 = [ NSColor colorWithCalibratedHue: h saturation: ( CGFloat )0 brightness: b alpha: ( CGFloat )1 ];
        color2 = [ NSColor colorWithCalibratedHue: h saturation: ( CGFloat )0 brightness: b - ( CGFloat )0.25 alpha: ( CGFloat )1 ];
    }
    
    gradient =[NSGradient.alloc 
         initWithColorsAndLocations: color1, ( CGFloat )0, color2, ( CGFloat )1, nil ];
    
    [ gradient drawInBezierPath: path1 angle: ( CGFloat )-90 ];
    
    gradient =[NSGradient.alloc 
         initWithStartingColor:    [ NSColor colorWithCalibratedWhite: ( CGFloat )0 alpha: ( CGFloat )0.25 ]
                                      endingColor:              [ NSColor colorWithCalibratedWhite: ( CGFloat )0 alpha: ( CGFloat )0.5 ]
               ];
    
    rect.origin.x    += ( CGFloat )0.50;
    rect.origin.y    += ( CGFloat )0.50;
    rect.size.width  -= ( CGFloat )1.00;
    rect.size.height -= ( CGFloat )0.50;
    
    innerRect = NSInsetRect( rect, ( CGFloat )7.5, ( CGFloat )7.5 );
    path2     = [ NSBezierPath bezierPath ];
    
    [ path2 appendBezierPathWithArcWithCenter: NSMakePoint( NSMinX( innerRect ), NSMinY( innerRect ) ) radius: ( CGFloat )7.5 startAngle: ( CGFloat )180 endAngle: ( CGFloat )270 ];
    [ path2 appendBezierPathWithArcWithCenter: NSMakePoint( NSMaxX( innerRect ), NSMinY( innerRect ) ) radius: ( CGFloat )7.5 startAngle: ( CGFloat )270 endAngle: ( CGFloat )360 ];
    [ path2 lineToPoint: NSMakePoint( NSMaxX( rect ), NSMaxY( rect ) ) ];
    [ path2 lineToPoint: NSMakePoint( NSMinX( rect ), NSMaxY( rect ) ) ];
    
    [ path2 appendBezierPath: path1 ];
    [ path2 setWindingRule: NSEvenOddWindingRule ];
    [ path2 closePath ];
    
    [ gradient drawInBezierPath: path2 angle: ( CGFloat )90 ];
    
    {
        NSMutableDictionary     * attributes;
        NSMutableParagraphStyle * paragraphStyle;
        NSFont                  * font;
    
        attributes      = [ NSMutableDictionary dictionaryWithCapacity: 10 ];
        paragraphStyle  = [ [ NSParagraphStyle defaultParagraphStyle ] mutableCopy ];
        font            = [ NSFont systemFontOfSize: [ NSFont smallSystemFontSize ] ];
        
        [ paragraphStyle setLineBreakMode: NSLineBreakByTruncatingMiddle ];
        [ paragraphStyle setAlignment: NSCenterTextAlignment ];
        
        attributes[NSForegroundColorAttributeName] = [ NSColor whiteColor ];
        attributes[NSBackgroundColorAttributeName] = [ NSColor clearColor ];
        attributes[NSParagraphStyleAttributeName] = paragraphStyle;
        attributes[NSFontAttributeName] = font;
        
        rect.size.height -= ( CGFloat )2.5;
        
        [ _title drawInRect: rect withAttributes: attributes ];
    }
}

@end
