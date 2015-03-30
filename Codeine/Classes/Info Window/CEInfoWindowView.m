
/* $Id$ */

#import "CEInfoWindowView.h"

@implementation CEInfoWindowView

- ( void )drawRect: ( NSRect )rect
{
    [ self.window.backgroundColor setFill ];
    
    NSRectFill( rect );
}

@end
