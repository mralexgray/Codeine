/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFileViewItem.h"

@implementation CEFileViewItem

@synthesize type                = _type;
@synthesize representedObject   = _representedObject;
@synthesize name                = _name;

+ ( id )fileViewItemWithType: ( CEFileViewItemType )type name: ( NSString * )name
{
    return [ [ [ self alloc ] initWithType: type name: name ] autorelease ];
}

- ( id )initWithType: ( CEFileViewItemType )type name: ( NSString * )name
{
    if( ( self = [ self init ] ) )
    {
        _type = type;
        _name = [ name copy ];
    }
    
    return self;
}

- ( void )dealloc
{
    RELEASE_IVAR( _name );
    RELEASE_IVAR( _representedObject );
    
    [ super dealloc ];
}

- ( NSArray * )childrens
{
    @synchronized( self )
    {
        return [ NSArray arrayWithArray: _childrens ];
    }
}

@end
