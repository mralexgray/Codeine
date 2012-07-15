/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFilesViewController+NSOutlineViewDelegate.h"
#import "CEFileViewItem.h"
#import "CEFileViewCell.h"

@implementation CEFilesViewController( NSOutlineViewDelegate )

- ( BOOL )outlineView: ( NSOutlineView * )outlineView isGroupItem: ( id )item
{
    CEFileViewItem * filesViewItem;
    
    ( void )outlineView;
    
    if( [ item isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return NO;
    }
    
    filesViewItem = ( CEFileViewItem * )item;
    
    return ( BOOL )( filesViewItem.type == CEFileViewItemTypeSection );
}

- ( void )outlineView: ( NSOutlineView * )outlineView willDisplayCell: ( id )cell forTableColumn: ( NSTableColumn * )tableColumn item: ( id )item
{
    CEFileViewItem * fileViewItem;
    NSString       * path;
    NSRange          range;
    
    ( void )outlineView;
    ( void )tableColumn;
    ( void )item;
    
    if( [ item isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return;
    }
    
    fileViewItem = ( CEFileViewItem * )item;
    
    [ ( NSCell * )cell setEditable: YES ];
    
    if( fileViewItem.parent.type == CEFileViewItemTypeSection )
    {
        [ ( NSCell * )cell setEditable: NO ];
    }
    else if( fileViewItem.type == CEFileViewItemTypeSection )
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
    CEFileViewItem * fileViewItem;
    
    ( void )outlineView;
    ( void )tableColumn;
    
    if( [ item isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return nil;
    }
    
    fileViewItem = ( CEFileViewItem * )item;
    
    if( fileViewItem.type != CEFileViewItemTypeSection )
    {
        return [ CEFileViewCell prototypeCell ];
    }
    
    return nil;
}

- ( BOOL )outlineView: ( NSOutlineView * )outlineView shouldSelectItem: ( id )item
{
    CEFileViewItem * fileViewItem;
    
    ( void )outlineView;
    
    if( [ item isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return NO;
    }
    
    fileViewItem = ( CEFileViewItem * )item;
    
    if
    (
           fileViewItem.type == CEFileViewItemTypeDocument
        || fileViewItem.type == CEFileViewItemTypeFS
        || fileViewItem.type == CEFileViewItemTypeBookmark
    )
    {
        return YES;
    }
    
    return NO;
}

- ( NSMenu * )outlineView: ( CEFilesOutlineView * )view menuForRow: ( NSInteger )row
{
    CEFileViewItem * item;
    NSMenuItem     * menuItem;
    NSMenu         * menu;
    NSString       * path;
    NSRange          range;
    
    ( void )view;
    
    menu = nil;
    item = [ _outlineView itemAtRow: row ];
    
    if( item.type == CEFileViewItemTypeDocument )
    {
        menu = _openDocumentMenu;
    }
    
    if( item.type == CEFileViewItemTypeFS )
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
        
        if( item.parent.type == CEFileViewItemTypeSection )
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
    
    if( item.type == CEFileViewItemTypeBookmark )
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
        
        if( item.parent.type == CEFileViewItemTypeBookmark )
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
