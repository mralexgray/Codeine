/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CERegistrationWindowController.h"
#import "CEBackgroundView.h"

@implementation CERegistrationWindowController

- ( void )dealloc
{
    [ super dealloc ];
}

- ( void )awakeFromNib
{}

- ( IBAction )enterSerialNumber: ( id )sender
{
    ( void )sender;
    
    [ self.window close ];
    [ APPLICATION stopModal ];
}

- ( IBAction )cancel: ( id )sender
{
    ( void )sender;
    
    [ self.window close ];
    [ APPLICATION stopModal ];
}

- ( IBAction )buy: ( id )sender
{
    ( void )sender;
    
    [ self.window close ];
    [ APPLICATION stopModal ];
}

@end
