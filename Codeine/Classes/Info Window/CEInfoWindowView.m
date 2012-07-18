/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEInfoWindowView.h"

@implementation CEInfoWindowView

- ( void )drawRect: ( NSRect )rect
{
    [ self.window.backgroundColor setFill ];
    
    NSRectFill( rect );
}

@end
