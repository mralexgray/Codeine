/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFilesViewController+NSOutlineViewDelegate.h"
#import "CEFilesViewItem.h"
#import "CEFilesViewCell.h"

@implementation CEFilesViewController( NSOutlineViewDelegate )

- ( BOOL )outlineView: ( NSOutlineView * )outlineView isGroupItem: ( id )item
{
    CEFilesViewItem * filesViewItem;
    
    ( void )outlineView;
    
    if( [ item isKindOfClass: [ CEFilesViewItem class ] ] == NO )
    {
        return NO;
    }
    
    filesViewItem = ( CEFilesViewItem * )item;
    
    return ( BOOL )( filesViewItem.type == CEFilesViewItemTypeSection );
}

- ( void )outlineView: ( NSOutlineView * )outlineView willDisplayCell: ( id )cell forTableColumn: ( NSTableColumn * )tableColumn item: ( id )item
{
    CEFilesViewItem * fileViewItem;
    NSString       * path;
    NSRange          range;
    
    ( void )outlineView;
    ( void )tableColumn;
    
    if( [ item isKindOfClass: [ CEFilesViewItem class ] ] == NO )
    {
        return;
    }
    
    fileViewItem = ( CEFilesViewItem * )item;
    
    [ ( NSCell * )cell setEditable: YES ];
    
    if( fileViewItem.parent.type == CEFilesViewItemTypeSection )
    {
        [ ( NSCell * )cell setEditable: NO ];
    }
    else if( fileViewItem.type == CEFilesViewItemTypeSection )
    {
        [ ( NSCell * )cell setEditable: NO ];
    }
    
    range = [ fileViewItem.name rangeOfString: @":" ];
    
    if( range.location == NSNotFound )
    {
        path = fileViewItem.name;
    }
    else
    {
        path = [ fileViewItem.name substringFromIndex: range.location + 1 ];
    }
    
    if( [ FILE_MANAGER isWritableFileAtPath: path ] == NO )
    {
        [ ( NSCell * )cell setEditable: NO ];
    }
}

- ( NSCell * )outlineView: ( NSOutlineView * )outlineView dataCellForTableColumn: ( NSTableColumn * )tableColumn item: ( id )item
{
    CEFilesViewItem * fileViewItem;
    
    ( void )outlineView;
    ( void )tableColumn;
    
    if( [ item isKindOfClass: [ CEFilesViewItem class ] ] == NO )
    {
        return nil;
    }
    
    fileViewItem = ( CEFilesViewItem * )item;
    
    if( fileViewItem.type != CEFilesViewItemTypeSection )
    {
        return [ CEFilesViewCell prototypeCell ];
    }
    
    return nil;
}

- ( BOOL )outlineView: ( NSOutlineView * )outlineView shouldSelectItem: ( id )item
{
    CEFilesViewItem * fileViewItem;
    
    ( void )outlineView;
    
    if( [ item isKindOfClass: [ CEFilesViewItem class ] ] == NO )
    {
        return NO;
    }
    
    fileViewItem = ( CEFilesViewItem * )item;
    
    if
    (
           fileViewItem.type == CEFilesViewItemTypeDocument
        || fileViewItem.type == CEFilesViewItemTypeFS
        || fileViewItem.type == CEFilesViewItemTypeBookmark
    )
    {
        return YES;
    }
    
    return NO;
}

- ( NSMenu * )outlineView: ( CEFilesOutlineView * )view menuForRow: ( NSInteger )row
{
    CEFilesViewItem * item;
    NSMenuItem     * menuItem;
    NSMenu         * menu;
    NSString       * path;
    NSRange          range;
    
    ( void )view;
    
    menu = nil;
    item = [ _outlineView itemAtRow: row ];
    
    if( item.type == CEFilesViewItemTypeDocument )
    {
        menu = _openDocumentMenu;
    }
    
    if( item.type == CEFilesViewItemTypeFS )
    {
        range = [ item.name rangeOfString: @":" ];
        
        if( range.location == NSNotFound )
        {
            path = item.name;
        }
        else
        {
            path = [ item.name substringFromIndex: range.location + 1 ];
        }
        
        if( item.isLeaf == YES )
        {
            menu = _fsFileMenu;
        }
        else
        {
            menu = _fsDirectoryMenu;
        }
        
        if( item.parent.type == CEFilesViewItemTypeSection )
        {
            [ [ menu itemAtIndex: menu.numberOfItems - 1 ] setEnabled: NO ];
        }
        else
        {
            [ [ menu itemAtIndex: menu.numberOfItems - 1 ] setEnabled: YES ];
        }
        
        if( [ FILE_MANAGER isWritableFileAtPath: path ] == NO )
        {
            [ [ menu itemAtIndex: menu.numberOfItems - 1 ] setEnabled: NO ];
        }
    }
    
    if( item.type == CEFilesViewItemTypeBookmark )
    {
        range = [ item.name rangeOfString: @":" ];
        
        if( range.location == NSNotFound )
        {
            path = item.name;
        }
        else
        {
            path = [ item.name substringFromIndex: range.location + 1 ];
        }
        
        if( item.parent.type == CEFilesViewItemTypeBookmark )
        {
            if( item.isLeaf == YES )
            {
                menu = _fsFileMenu;
            }
            else
            {
                menu = _fsDirectoryMenu;
            }
        }
        else
        {
            menu = _bookmarkMenu;
        }
        
        if( [ FILE_MANAGER isWritableFileAtPath: path ] == NO )
        {
            [ [ menu itemAtIndex: menu.numberOfItems - 1 ] setEnabled: NO ];
        }
    }
    
    for( menuItem in menu.itemArray )
    {
        menuItem.representedObject = item;
    }
    
    return menu;
}

- ( void )outlineView: ( CEFilesOutlineView * )view showQuickLookForItem: ( id )item
{
    CEFilesViewItem * fileViewItem;
    NSString       * path;
    NSRange          range;
    
    if( [ item isKindOfClass: [ CEFilesViewItem class ] ] == NO )
    {
        return;
    }
    
    fileViewItem = ( CEFilesViewItem * )item;
    range        = [ fileViewItem.name rangeOfString: @":" ];
    
    if( range.location == NSNotFound )
    {
        path = fileViewItem.name;
    }
    else
    {
        path = [ fileViewItem.name substringFromIndex: range.location + 1 ];
    }
    
    [ APPLICATION showQuickLookPanelForItemAtPath: path sender: view ];
}

/*
- ( BOOL )outlineView: ( CEFilesOutlineView * )view shouldClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point
{
    id item;
    
    ( void )view;
    ( void )row;
    ( void )point;
    
    item = [ _outlineView itemAtRow: row ];
    
    [ _outlineView selectRowIndexes: [ NSIndexSet indexSetWithIndex: ( NSUInteger )row ] byExtendingSelection: NO ];
    
    if( [ _outlineView isItemExpanded: item ] == YES )
    {
        [ _outlineView collapseItem: item ];
    }
    else
    {
        [ _outlineView expandItem: item ];
    }
    
    return NO;
}
*/

@end
