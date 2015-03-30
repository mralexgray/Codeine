
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

    
    [ self.window close ];
    [ APPLICATION stopModal ];
}

- ( IBAction )cancel: ( id )sender
{

    
    [ self.window close ];
    [ APPLICATION stopModal ];
}

- ( IBAction )buy: ( id )sender
{

    
    [ self.window close ];
    [ APPLICATION stopModal ];
}

@end
