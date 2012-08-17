/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEDiagnosticsViewController+Private.h"

@implementation CEDiagnosticsViewController( Private )

- ( void )applicationStateDidChange: ( NSNotification * )notification
{
    ( void )notification;
    
    [ self.view setNeedsDisplay: YES ];
}

@end
