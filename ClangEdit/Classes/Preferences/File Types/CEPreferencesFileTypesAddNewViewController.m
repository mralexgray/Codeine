/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesFileTypesAddNewViewController.h"

@implementation CEPreferencesFileTypesAddNewViewController

- ( IBAction )ok: ( id )sender
{
    ( void )sender;
    
    [ self.window orderOut: sender ];
    [ APPLICATION endSheet: self.window ];
}

- ( IBAction )cancel: ( id )sender
{
    ( void )sender;
    
    [ self.window orderOut: sender ];
    [ APPLICATION endSheet: self.window ];
}

@end
