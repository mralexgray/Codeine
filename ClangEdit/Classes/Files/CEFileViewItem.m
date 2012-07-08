/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFileViewItem.h"
#import "CEFileViewItemSection.h"
#import "CEFileViewItemDocument.h"
#import "CEFileViewItemFS.h"

static CEFileViewItem * __placesItem        = nil;
static CEFileViewItem * __openDocumentsItem = nil;

static void __exit( void ) __attribute__( ( destructor ) );
static void __exit( void )
{
    [ __placesItem          release ];
    [ __openDocumentsItem   release ];
}

@implementation CEFileViewItem

@synthesize type                = _type;
@synthesize representedObject   = _representedObject;
@synthesize name                = _name;
@synthesize displayName         = _displayName;
@synthesize icon                = _icon;

+ ( id )placesItem
{
    NSString       * rootPath;
    NSString       * userPath;
    NSString       * desktopPath;
    NSString       * documentsPath;
    
    if( __placesItem == nil )
    {
        __placesItem    = [ [ self fileViewItemWithType: CEFileViewItemTypeSection name: @"Places" ] retain ];
        desktopPath     = [ NSSearchPathForDirectoriesInDomains( NSDesktopDirectory, NSUserDomainMask, YES ) objectAtIndex: 0 ];
        documentsPath   = [ NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES ) objectAtIndex: 0 ];
        userPath        = NSHomeDirectory();
        rootPath        = @"/";
        
        if( desktopPath != nil )
        {
            [ __placesItem addChild: [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeFS name: desktopPath ] ];
        }
        
        if( desktopPath != nil )
        {
            [ __placesItem addChild: [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeFS name: documentsPath ] ];
        }
        
        if( desktopPath != nil )
        {
            [ __placesItem addChild: [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeFS name: userPath ] ];
        }
        
        if( desktopPath != nil )
        {
            [ __placesItem addChild: [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeFS name: rootPath ] ];
        }
    }
    
    return __placesItem;
}

+ ( id )openDocumentsItem
{
    if( __openDocumentsItem == nil )
    {
        __openDocumentsItem = [ [ self fileViewItemWithType: CEFileViewItemTypeSection name: @"OpenDocuments" ] retain ];
    }
    
    return __openDocumentsItem;
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
    [ _children addObject: child ];
}

- ( void )removeChild: ( CEFileViewItem * )child
{
    [ _children removeObject: child ];
}

- ( void )removeAllChildren
{
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
    return [ [ super description ] stringByAppendingFormat: @" - %@", self.name ];
}

- ( id )valueForKeyPath: ( NSString * )keyPath
{
    ( void )keyPath;
    
    return nil;
}

@end
