
/* $Id$ */

#import "CEFilesViewController+NSOutlineViewDataSource.h"
#import "CEFilesViewController+Private.h"
#import "CEFilesViewItem.h"
#import "CEFile.h"

@implementation CEFilesViewController( NSOutlineViewDataSource )

- ( NSInteger )outlineView: ( NSOutlineView * )outlineView numberOfChildrenOfItem: ( id )item
{
    CEFilesViewItem * fileViewItem;
    

    
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
    

    
    if( item == nil )
    {
        @try
        {
            return _rootItems[( NSUInteger )index];
        }
        @catch( NSException * e )
        {

            
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
        return (fileViewItem.children)[( NSUInteger )index];
    }
    @catch( NSException * e )
    {

    }
    
    return nil;
}

- ( id )outlineView: ( NSOutlineView * )outlineView objectValueForTableColumn: ( NSTableColumn * )tableColumn byItem: ( id )item
{
    CEFilesViewItem * fileViewItem;
    


    
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
    

    
    if( [ item isKindOfClass: [ CEFilesViewItem class ] ] == NO )
    {
        return nil;
    }
    
    fileViewItem = ( CEFilesViewItem * )item;
    
    if( fileViewItem.type == CEFilesViewItemTypeDocument )
    {
        return nil;
    }
    
    dictionary = @{@"Type": @(fileViewItem.type),
                                                              @"Name": fileViewItem.name};
    
    return dictionary;
}

- ( id )outlineView: ( NSOutlineView * )outlineView itemForPersistentObject: ( id )object
{
    CEFilesViewItemType  type;
    NSString           * name;
    CEFilesViewItem    * item;
    

    
    if( [ object isKindOfClass: [ NSDictionary class ] ] )
    {
        type = ( CEFilesViewItemType )[ ( NSNumber * )(( NSDictionary * )object)[@"Type"] integerValue ];
        name = (( NSDictionary * )object)[@"Name"];
        
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
