/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@interface CERegistrationBadge: NSView
{
@protected
    
    NSTrackingArea * _trackingArea;
    id               _target;
    SEL              _action;
    BOOL             _inTrackingArea;
    
@private
    
    RESERVERD_IVARS( CERegistrationBadge, 5 );
}

@property( atomic, readwrite, retain ) id  target;
@property( atomic, readwrite, assign ) SEL action;

@end
