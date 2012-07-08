/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFilesViewController+NSOutlineViewDataSource.h"
#import "CEFileViewItem.h"

@implementation CEFilesViewController( NSOutlineViewDataSource )

- ( NSInteger )outlineView: ( NSOutlineView * )outlineView numberOfChildrenOfItem: ( id )item
{
    CEFileViewItem * fileViewItem;
    
    ( void )outlineView;
    
    if( item == nil )
    {
        return ( NSInteger )( _rootItems.count );
    }
    
    if( [ item isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return 0;
    }
    
    fileViewItem = ( CEFileViewItem * )item;
    
    return ( NSInteger )( fileViewItem.children.count );
}

- ( BOOL )outlineView: ( NSOutlineView * )outlineView isItemExpandable: ( id )item
{
    CEFileViewItem * fileViewItem;
    
    ( void )outlineView;
    
    if( [ item isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return NO;
    }
    
    fileViewItem = ( CEFileViewItem * )item;
    
    return fileViewItem.expandable;
}

- ( id )outlineView: ( NSOutlineView * )outlineView child: ( NSInteger )index ofItem: ( id )item
{
    CEFileViewItem * fileViewItem;
    
    ( void )outlineView;
    
    if( item == nil )
    {
        @try
        {
            return [ _rootItems objectAtIndex: ( NSUInteger )index ];
        }
        @catch( NSException * e )
        {
            ( void )e;
            
            return nil;
        }
    }
    
    if( [ item isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return nil;
    }
    
    fileViewItem = ( CEFileViewItem * )item;
    
    @try
    {
        return [ fileViewItem.children objectAtIndex: ( NSUInteger )index ];
    }
    @catch( NSException * e )
    {
        ( void )e;
    }
    
    return nil;
}

- ( id )outlineView: ( NSOutlineView * )outlineView objectValueForTableColumn: ( NSTableColumn * )tableColumn byItem: ( id )item
{
    CEFileViewItem * fileViewItem;
    
    ( void )outlineView;
    ( void )tableColumn;
    
    if( [ item isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return nil;
    }
    
    fileViewItem = ( CEFileViewItem * )item;
    
    return ( fileViewItem.type == CEFileViewItemTypeSection ) ? fileViewItem.displayName : fileViewItem;
}

- ( id )outlineView: ( NSOutlineView * )outlineView persistentObjectForItem: ( id )item
{
    CEFileViewItem * fileViewItem;
    NSDictionary   * dictionary;
    
    ( void )outlineView;
    
    if( [ item isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return nil;
    }
    
    fileViewItem = ( CEFileViewItem * )item;
    dictionary   = [ NSDictionary dictionaryWithObjectsAndKeys: [ NSNumber numberWithInteger: fileViewItem.type ],  @"Type",
                                                                fileViewItem.name,                                  @"Name",
                                                                nil
                   ];
    
    return dictionary;
}

- ( id )outlineView: ( NSOutlineView * )outlineView itemForPersistentObject: ( id )object
{
    CEFileViewItemType  type;
    NSString          * name;
    CEFileViewItem    * item;
    
    ( void )outlineView;
    
    if( [ object isKindOfClass: [ NSDictionary class ] ] )
    {
        type = ( CEFileViewItemType )[ ( NSNumber * )[ ( NSDictionary * )object objectForKey: @"Type" ] integerValue ];
        name = [ ( NSDictionary * )object objectForKey: @"Name" ];
        
        if( type == CEFileViewItemTypeSection && [ name isEqualToString: @"Places" ] )
        {
            item = [ CEFileViewItem placesItem ];
        }
        else if( type == CEFileViewItemTypeSection && [ name isEqualToString: @"OpenDocuments" ] )
        {
            item = [ CEFileViewItem placesItem ];
        }
        else if( type == CEFileViewItemTypeFS )
        {
            item = [ [ CEFileViewItem placesItem ] valueForKeyPath: name ];
        }
        else
        {
            item = nil;
        }
        
        return item;
    }
    
    return nil;
}

@end
