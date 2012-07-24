/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEWindowBadge+Private.h"

@implementation CEWindowBadge( Private )

- ( void )applicationStateDidChange: ( NSNotification * )notification
{
    ( void )notification;
    
    [ self setNeedsDisplay: YES ];
}

@end
