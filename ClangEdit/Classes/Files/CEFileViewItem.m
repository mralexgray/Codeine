/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFileViewItem.h"
#import "CEFileViewItemSection.h"
#import "CEFileViewItemDocument.h"
#import "CEFileViewItemFS.h"
#import "CEFileViewItemBookmark.h"
#import "CEPreferences.h"

NSString * const CEFileViewOpenDocumentsItemName    = @"OpenDocuments";
NSString * const CEFileViewPlacesItemName           = @"Places";
NSString * const CEFileViewBookmarksItemName        = @"Bookmarks";

static CEFileViewItem * __placesItem        = nil;
static CEFileViewItem * __openDocumentsItem = nil;
static CEFileViewItem * __bookmarksItem     = nil;

static void __exit( void ) __attribute__( ( destructor ) );
static void __exit( void )
{
    [ __placesItem          release ];
    [ __openDocumentsItem   release ];
    [ __bookmarksItem       release ];
}

@implementation CEFileViewItem

@synthesize type                = _type;
@synthesize representedObject   = _representedObject;
@synthesize name                = _name;
@synthesize displayName         = _displayName;
@synthesize icon                = _icon;
@synthesize parent              = _parent;

+ ( id )openDocumentsItem
{
    if( __openDocumentsItem == nil )
    {
        __openDocumentsItem = [ [ self fileViewItemWithType: CEFileViewItemTypeSection name: CEFileViewOpenDocumentsItemName ] retain ];
    }
    
    return __openDocumentsItem;
}

+ ( id )placesItem
{
    if( __placesItem == nil )
    {
        __placesItem = [ [ self fileViewItemWithType: CEFileViewItemTypeSection name: CEFileViewPlacesItemName ] retain ];
        
        [ __placesItem reload ];
    }
    
    return __placesItem;
}

+ ( id )bookmarksItems
{
    if( __bookmarksItem == nil )
    {
        __bookmarksItem = [ [ self fileViewItemWithType: CEFileViewItemTypeSection name: CEFileViewBookmarksItemName ] retain ];
        
        [ __bookmarksItem reload ];
    }
    
    return __bookmarksItem;
}

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
            _type        = type;
            _name        = [ name copy ];
            _displayName = [ name copy ];
            _children    = [ [ NSMutableArray alloc ] initWithCapacity: 100 ];
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
            
        case CEFileViewItemTypeBookmark:
            
            item = [ [ CEFileViewItemBookmark alloc ] initWithType: type name: name ];
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
    RELEASE_IVAR( _displayName );
    RELEASE_IVAR( _representedObject );
    RELEASE_IVAR( _children );
    
    [ super dealloc ];
}

- ( id )copyWithZone: ( NSZone * )zone
{
    CEFileViewItem * item;
    
    item = [ [ [ self class ] allocWithZone: zone ] initWithType: _type name: _name ];
    
    [ item->_displayName        release ];
    [ item->_icon               release ];
    [ item->_representedObject  release ];
    [ item->_children           release ];
    
    item->_displayName          = [ _displayName copyWithZone: zone ];
    item->_icon                 = [ _icon copyWithZone: zone ];
    item->_representedObject    = [ _representedObject retain ];
    item->_children             = [ _children copyWithZone: zone ];
    item->_parent               = _parent;
    
    return item;
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
    child->_parent = self;
    
    [ _children addObject: child ];
}

- ( void )removeChild: ( CEFileViewItem * )child
{
    child->_parent = nil;
    
    [ _children removeObject: child ];
}

- ( void )removeAllChildren
{
    CEFileViewItem * child;
    
    for( child in _children )
    {
        child->_parent = nil;
    }
    
    [ _children removeAllObjects ];
}

- ( BOOL )expandable
{
    return NO;
}

- ( BOOL )isEqual: ( id )object
{
    CEFileViewItem * item;
    
    if( [ object isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return NO;
    }
    
    item = ( CEFileViewItem * )object;
    
    return ( BOOL )( self.type == item.type && [ self.name isEqualToString: item.name ] );
}

- ( NSString * )description
{
    return self.displayName;
}

- ( id )valueForKeyPath: ( NSString * )keyPath
{
    ( void )keyPath;
    
    return nil;
}

- ( void )reload
{
    RELEASE_IVAR( _children );
    
    _children = [ [ NSMutableArray alloc ] initWithCapacity: 100 ];
}

- ( BOOL )isLeaf
{
    return NO;
}

@end
