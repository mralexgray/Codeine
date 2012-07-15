/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFilesViewController+NSOutlineViewDataSource.h"
#import "CEFilesViewController+Private.h"
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

- ( void )outlineView: ( NSOutlineView * )outlineView setObjectValue: ( id )object forTableColumn: ( NSTableColumn * )tableColumn byItem: ( id )item
{
    CEFileViewItem  * fileViewItem;
    NSString        * path;
    NSString        * newPath;
    NSString        * newName;
    NSError         * error;
    NSRange           range;
    
    ( void )outlineView;
    ( void )tableColumn;
    
    if( [ object isKindOfClass: [ NSString class ] ] == NO )
    {
        return;
    }
    
    newName = object;
    
    if( [ item isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return;
    }
    
    fileViewItem = ( CEFileViewItem * )item;
    
    range = [ fileViewItem.name rangeOfString: @":" ];
    
    if( range.location == NSNotFound )
    {
        path = fileViewItem.name;
    }
    else
    {
        path = [ fileViewItem.name substringFromIndex: range.location + 1 ];
    }
    
    if( [ path.lastPathComponent isEqualToString: newName ] )
    {
        return;
    }
    
    newPath = [ [ path stringByDeletingLastPathComponent ] stringByAppendingPathComponent: newName ];
    error   = nil;
    
    if( [ FILE_MANAGER moveItemAtPath: path toPath: newPath error: &error ] == NO || error != nil )
    {
        NSBeep();
    }
    else
    {
        {
            id parent;
            
            if( [ fileViewItem.parent isKindOfClass: [ CEFileViewItem class ] ] == YES )
            {
                parent = fileViewItem.parent;
                
                [ parent reload ];
                
                [ _outlineView reloadItem: parent reloadChildren: YES ];
            }
        }
    }
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
        
        if( type == CEFileViewItemTypeSection && [ name isEqualToString: CEFileViewOpenDocumentsItemName ] )
        {
            item = [ CEFileViewItem openDocumentsItem ];
        }
        else if( type == CEFileViewItemTypeSection && [ name isEqualToString: CEFileViewPlacesItemName ] )
        {
            item = [ CEFileViewItem placesItem ];
        }
        else if( type == CEFileViewItemTypeSection && [ name isEqualToString: CEFileViewBookmarksItemName ] )
        {
            item = [ CEFileViewItem bookmarksItems ];
        }
        else if( type == CEFileViewItemTypeFS )
        {
            item = [ [ CEFileViewItem placesItem ] valueForKeyPath: name ];
        }
        else if( type == CEFileViewItemTypeBookmark )
        {
            item = [ [ CEFileViewItem bookmarksItems ] valueForKeyPath: name ];
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
