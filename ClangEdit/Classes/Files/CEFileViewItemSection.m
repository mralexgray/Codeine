/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFileViewItemSection.h"

@implementation CEFileViewItemSection

- ( BOOL )expandable
{
    return ( BOOL )( _children.count > 0 );
}

@end
