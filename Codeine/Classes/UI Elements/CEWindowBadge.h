/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@interface CEWindowBadge: NSView
{
@protected
    
    NSString       * _title;
    NSColor        * _backgroundColor;
    NSColor        * _activeBackgroundColor;
    NSTrackingArea * _trackingArea;
    id               _target;
    SEL              _action;
    BOOL             _inTrackingArea;
    
@private
    
    RESERVERD_IVARS( CEWindowBadge, 5 );
}

@property( atomic, readwrite, copy   ) NSString * title;
@property( atomic, readwrite, retain ) NSColor  * backgroundColor;
@property( atomic, readwrite, retain ) NSColor  * activeBackgroundColor;
@property( atomic, readwrite, retain ) id         target;
@property( atomic, readwrite, assign ) SEL        action;

@end
