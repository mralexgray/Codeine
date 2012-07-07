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
            _type = type;
            _name = [ name copy ];
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
