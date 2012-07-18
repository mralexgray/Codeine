/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEApplicationDelegate.h"

@interface CEApplicationDelegate( Private )

- ( void )installApplicationSupportFiles;
- ( void )firstLaunch;
- ( void )windowDidClose: ( NSNotification * )notification;

@end
