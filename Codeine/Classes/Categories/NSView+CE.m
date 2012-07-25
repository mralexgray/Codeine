/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "NSView+CE.h"

@implementation NSView( CE )

- ( void )centerInSuperview
{
    NSRect bounds;
    NSRect frame;
    
    if( self.superview == nil )
    {
        return;
    }
    
    bounds = self.superview.bounds;
    frame  = self.frame;
    
    frame.origin.x = ( bounds.size.width  - frame.size.width  ) / ( CGFloat )2;
    frame.origin.y = ( bounds.size.height - frame.size.height ) / ( CGFloat )2;
    
    self.frame = frame;
}

@end
