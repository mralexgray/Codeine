
/* $Id$ */

#import "CEFilesViewController+NSOutlineViewDelegate.h"
#import "CEFilesViewItem.h"
#import "CEFilesViewCell.h"
#import "CEFile.h"
#import "CEColorLabelMenuItem.h"
#import "CEFilesOutlineView.h"
#import "CEMainWindowController.h"
#import "CEDocument.h"

@implementation CEFilesViewController( NSOutlineViewDelegate )

- ( CGFloat )outlineView: ( NSOutlineView * )outlineView heightOfRowByItem: ( id )item
{


    
    return ( CGFloat )20;
}

- ( BOOL )outlineView: ( NSOutlineView * )outlineView isGroupItem: ( id )item
{
    CEFilesViewItem * filesViewItem;
    

    
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
    
    if( fileViewItem.file.writable == NO )
    {
        [ ( NSCell * )cell setEditable: NO ];
    }
}

- ( NSCell * )outlineView: ( NSOutlineView * )outlineView dataCellForTableColumn: ( NSTableColumn * )tableColumn item: ( id )item
{
    CEFilesViewItem * fileViewItem;
    


    
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

- ( void )outlineViewSelectionDidChange: ( NSNotification * )notification
{
    CEFilesViewItem * item;
    CEDocument      * document;
    

    
    if( _outlineView.selectedRow == NSNotFound )
    {
        return;
    }
    
    item = [ _outlineView itemAtRow: _outlineView.selectedRow ];
    
    if( [ item isKindOfClass: [ CEFilesViewItem class ] ] == NO )
    {
        return;
    }
    
    if( item.type == CEFilesViewItemTypeDocument )
    {
        [ self outlineView: ( CEFilesOutlineView * )_outlineView didDoubleClickOnRow: _outlineView.selectedRow atPoint: NSZeroPoint event: nil ];
    }
    else
    {
        document      = [ CEDocument documentWithLanguage: CESourceFileLanguageNone ];
        document.file = item.file;
        
        [ ( CEMainWindowController * )( self.view.window.windowController ) setActiveDocument: document ];
    }
}

- ( NSMenu * )outlineView: ( CEFilesOutlineView * )view menuForRow: ( NSInteger )row
{
    CEFilesViewItem * item;
    NSMenuItem      * menuItem;
    NSMenu          * menu; 
    

    
    menu = nil;
    item = [ _outlineView itemAtRow: row ];
    
    if( item.type == CEFilesViewItemTypeDocument )
    {
        menu = _openDocumentMenu;
    }
    
    if( item.type == CEFilesViewItemTypeFS )
    {
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
        
        if( item.file.writable == NO )
        {
            [ [ menu itemAtIndex: menu.numberOfItems - 1 ] setEnabled: NO ];
        }
    }
    
    if( item.type == CEFilesViewItemTypeBookmark )
    {
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
        
        if( item.file.writable == NO )
        {
            [ [ menu itemAtIndex: menu.numberOfItems - 1 ] setEnabled: NO ];
        }
    }
    
    for( menuItem in menu.itemArray )
    {
        if( [ menuItem isKindOfClass: [ CEColorLabelMenuItem class ] ] )
        {
            [ item.file refresh ];
            
            ( ( CEColorLabelMenuItem * )menuItem ).selectedColor = item.file.labelColor;
        }
        
        menuItem.representedObject = item;
    }
    
    return menu;
}

- ( BOOL )outlineView: ( CEFilesOutlineView * )view processKeyEvent: ( CEVirtualKey )key onRow: ( NSInteger )row event: ( NSEvent * )e
{
    CEFilesViewItem * item;
    

    
    item = [ view itemAtRow: row ];
    
    if( [ item isKindOfClass: [ CEFilesViewItem class ] ] == NO )
    {
        return NO;
    }
    
    if( key == CEVirtualKeySpace )
    {
        [ APPLICATION showQuickLookPanelForItemAtPath: item.file.path sender: view ];
        
        return YES;
    }
    else if( key == CEVirtualKeyReturn )
    {
        [ self outlineView: view didDoubleClickOnRow: row atPoint: NSZeroPoint event: nil ];
        
        return YES;
    }
    
    return NO;
}

- ( void )outlineView: ( CEFilesOutlineView * )view didDoubleClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point event: ( NSEvent * )e
{
    CEFilesViewItem * item;
    


    
    item = [ view itemAtRow: row ];
    
    if( [ item isKindOfClass: [ CEFilesViewItem class ] ] == NO )
    {
        return;
    }
    
    if( item.expandable == YES )
    {
        if( [ view isItemExpanded: item ] )
        {
            [ view collapseItem: item ];
        }
        else
        {
            [ view expandItem: item ];
        }
    }
    else
    {
        if( item.type == CEFilesViewItemTypeDocument )
        {
            [ ( CEMainWindowController * )( self.view.window.windowController ) setActiveDocument: item.representedObject ];
        }
        else
        {
            [ ( CEMainWindowController * )( self.view.window.windowController ) setActiveDocument: [ CEDocument documentWithPath: item.file.path ] ];
        }
    }
}

@end
