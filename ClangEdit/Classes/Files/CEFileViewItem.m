/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFileViewItem.h"
#import "CEFileViewItemSection.h"
#import "CEFileViewItemDocument.h"
#import "CEFileViewItemFS.h"

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
    id item;
    
    if( [ self class ] != [ CEFileViewItem class ] )
    {
        if( ( self = [ super init ] ) )
        {
            _type       = type;
            _name       = [ name copy ];
            _children   = [ [ NSMutableArray alloc ] initWithCapacity: 100 ];
        }
        
        return self;
    }
    
    switch( type )
    {
        case CEFileViewItemTypeSection:
            
            item = [ [ CEFileViewItemSection alloc ] initWithType: type name: name ];
            break;
            
        case CEFileViewItemTypeDocument:
            
            item = [ [ CEFileViewItemDocument alloc ] initWithType: type name: name ];
            break;
            
        case CEFileViewItemTypeFS:
            
            item = [ [ CEFileViewItemFS alloc ] initWithType: type name: name ];
            break;
            
        default:
            
            item = nil;
    }
    
    [ self release ];
    
    return item;
}

- ( void )dealloc
{
    RELEASE_IVAR( _name );
    RELEASE_IVAR( _representedObject );
    RELEASE_IVAR( _children );
    
    [ super dealloc ];
}

- ( NSArray * )children
{
    @synchronized( self )
    {
        return [ NSArray arrayWithArray: _children ];
    }
}

- ( void )addChild: ( CEFileViewItem * )child
{
    [ _children addObject: child ];
}

- ( void )removeChild: ( CEFileViewItem * )child
{
    [ _children removeObject: child ];
}

- ( BOOL )expandable
{
    return NO;
}

@end
