/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFilesViewController+NSOutlineViewDataSource.h"
#import "CEFilesViewController+Private.h"
#import "CEFilesViewItem.h"
#import "CEFile.h"

@implementation CEFilesViewController( NSOutlineViewDataSource )

- ( NSInteger )outlineView: ( NSOutlineView * )outlineView numberOfChildrenOfItem: ( id )item
{
    CEFilesViewItem * fileViewItem;
    
    ( void )outlineView;
    
    if( item == nil )
    {
        return ( NSInteger )( _rootItems.count );
    }
    
    if( [ item isKindOfClass: [ CEFilesViewItem class ] ] == NO )
    {
        return 0;
    }
    
    fileViewItem = ( CEFilesViewItem * )item;
    
    return ( NSInteger )( fileViewItem.children.count );
}

- ( BOOL )outlineView: ( NSOutlineView * )outlineView isItemExpandable: ( id )item
{
    CEFilesViewItem * fileViewItem;
    
    ( void )outlineView;
    
    if( [ item isKindOfClass: [ CEFilesViewItem class ] ] == NO )
    {
        return NO;
    }
    
    fileViewItem = ( CEFilesViewItem * )item;
    
    return fileViewItem.expandable;
}

- ( id )outlineView: ( NSOutlineView * )outlineView child: ( NSInteger )index ofItem: ( id )item
{
    CEFilesViewItem * fileViewItem;
    
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
    
    if( [ item isKindOfClass: [ CEFilesViewItem class ] ] == NO )
    {
        return nil;
    }
    
    fileViewItem = ( CEFilesViewItem * )item;
    
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
    CEFilesViewItem * fileViewItem;
    
    ( void )outlineView;
    ( void )tableColumn;
    
    if( [ item isKindOfClass: [ CEFilesViewItem class ] ] == NO )
    {
        return nil;
    }
    
    fileViewItem = ( CEFilesViewItem * )item;
    
    return ( fileViewItem.type == CEFilesViewItemTypeSection ) ? fileViewItem.displayName : fileViewItem;
}

- ( void )outlineView: ( NSOutlineView * )outlineView setObjectValue: ( id )object forTableColumn: ( NSTableColumn * )tableColumn byItem: ( id )item
{
    CEFilesViewItem  * fileViewItem;
    NSString        * path;
    NSString        * newPath;
    NSString        * newName;
    NSError         * error;
    
    ( void )outlineView;
    ( void )tableColumn;
    
    if( [ object isKindOfClass: [ NSString class ] ] == NO )
    {
        return;
    }
    
    newName = object;
    
    if( [ item isKindOfClass: [ CEFilesViewItem class ] ] == NO )
    {
        return;
    }
    
    fileViewItem = ( CEFilesViewItem * )item;
    path         = fileViewItem.file.path;
    
    if( path.length == 0 || [ path.lastPathComponent isEqualToString: newName ] )
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
            
            if( [ fileViewItem.parent isKindOfClass: [ CEFilesViewItem class ] ] == YES )
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
    CEFilesViewItem * fileViewItem;
    NSDictionary   * dictionary;
    
    ( void )outlineView;
    
    if( [ item isKindOfClass: [ CEFilesViewItem class ] ] == NO )
    {
        return nil;
    }
    
    fileViewItem = ( CEFilesViewItem * )item;
    
    if( fileViewItem.type == CEFilesViewItemTypeDocument )
    {
        return nil;
    }
    
    dictionary = [ NSDictionary dictionaryWithObjectsAndKeys: [ NSNumber numberWithInteger: fileViewItem.type ],  @"Type",
                                                              fileViewItem.name,                                  @"Name",
                                                              nil
                 ];
    
    return dictionary;
}

- ( id )outlineView: ( NSOutlineView * )outlineView itemForPersistentObject: ( id )object
{
    CEFilesViewItemType  type;
    NSString           * name;
    CEFilesViewItem    * item;
    
    ( void )outlineView;
    
    if( [ object isKindOfClass: [ NSDictionary class ] ] )
    {
        type = ( CEFilesViewItemType )[ ( NSNumber * )[ ( NSDictionary * )object objectForKey: @"Type" ] integerValue ];
        name = [ ( NSDictionary * )object objectForKey: @"Name" ];
        
        if( type == CEFilesViewItemTypeSection && [ name isEqualToString: CEFilesViewPlacesItemName ] )
        {
            item = [ CEFilesViewItem placesItem ];
        }
        else if( type == CEFilesViewItemTypeSection && [ name isEqualToString: CEFilesViewBookmarksItemName ] )
        {
            item = [ CEFilesViewItem bookmarksItems ];
        }
        else if( type == CEFilesViewItemTypeFS )
        {
            item = [ [ CEFilesViewItem placesItem ] valueForKeyPath: name ];
        }
        else if( type == CEFilesViewItemTypeBookmark )
        {
            item = [ [ CEFilesViewItem bookmarksItems ] valueForKeyPath: name ];
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
