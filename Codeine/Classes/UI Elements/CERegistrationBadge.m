/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CERegistrationBadge.h"

@implementation CERegistrationBadge

@synthesize target = _target;
@synthesize action = _action;

- ( id )initWithFrame: ( NSRect )frame
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
        _trackingArea = [ [ NSTrackingArea alloc ] initWithRect: trackingRect options: options owner: self userInfo: nil ];
        
        [ self addTrackingArea: _trackingArea ];
    }
    
    return self;
}

- ( void )dealloc
{
    [ self removeTrackingArea: _trackingArea ];
    
    RELEASE_IVAR( _trackingArea );
    RELEASE_IVAR( _target );
    
    [ super dealloc ];
}

- ( void )mouseEntered: ( NSEvent * )event
{
    ( void )event;
    
    _inTrackingArea = YES;
    
    [ self setNeedsDisplay: YES ];
}

- ( void )mouseExited: ( NSEvent * )event
{
    ( void )event;
    
    _inTrackingArea = NO;
    
    [ self setNeedsDisplay: YES ];
}

- ( void )mouseDown: ( NSEvent * )event
{
    ( void )event;
    
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
    
    if( _inTrackingArea == YES )
    {
        color1 = [ NSColor colorForControlTint: NSBlueControlTint ];
    }
    else
    {
        color1 = [ NSColor colorForControlTint: NSGraphiteControlTint ];
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
    
    gradient = [ [ NSGradient alloc ] initWithColorsAndLocations: color1, ( CGFloat )0, color2, ( CGFloat )1, nil ];
    
    [ gradient drawInBezierPath: path1 angle: ( CGFloat )-90 ];
    [ gradient release ];
    
    gradient = [ [ NSGradient alloc ] initWithStartingColor:    [ NSColor colorWithCalibratedWhite: ( CGFloat )0 alpha: ( CGFloat )0.25 ]
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
    [ gradient release ];
    
    {
        NSMutableDictionary     * attributes;
        NSMutableParagraphStyle * paragraphStyle;
        NSFont                  * font;
    
        attributes      = [ NSMutableDictionary dictionaryWithCapacity: 10 ];
        paragraphStyle  = [ [ [ NSParagraphStyle defaultParagraphStyle ] mutableCopy ] autorelease ];
        font            = [ NSFont systemFontOfSize: [ NSFont smallSystemFontSize ] ];
        
        [ paragraphStyle setLineBreakMode: NSLineBreakByTruncatingMiddle ];
        [ paragraphStyle setAlignment: NSCenterTextAlignment ];
        
        [ attributes setObject: [ NSColor whiteColor ] forKey: NSForegroundColorAttributeName ];
        [ attributes setObject: [ NSColor clearColor ] forKey: NSBackgroundColorAttributeName ];
        [ attributes setObject: paragraphStyle         forKey: NSParagraphStyleAttributeName ];
        [ attributes setObject: font                   forKey: NSFontAttributeName ];
        
        rect.size.height -= ( CGFloat )2.5;
        
        [ L10N( "NotRegistered" ) drawInRect: rect withAttributes: attributes ];
    }
}

@end
