/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFilesViewController.h"
#import "CEFilesViewController+Private.h"
#import "CEFilesViewController+NSOutlineViewDelegate.h"
#import "CEFilesViewController+NSOutlineViewDataSource.h"
#import "CEFileViewItem.h"
#import "CEPreferences.h"

@implementation CEFilesViewController

@synthesize outlineView         = _outlineView;
@synthesize openDocumentMenu    = _openDocumentMenu;
@synthesize bookmarkMenu        = _bookmarkMenu;
@synthesize fsDirectoryMenu     = _fsDirectoryMenu;
@synthesize fsFileMenu          = _fsFileMenu;

- ( void )dealloc
{
    [ NOTIFICATION_CENTER removeObserver: self ];
    
    RELEASE_IVAR( _outlineView );
    RELEASE_IVAR( _rootItems );
    RELEASE_IVAR( _openDocumentMenu );
    RELEASE_IVAR( _bookmarkMenu );
    RELEASE_IVAR( _fsDirectoryMenu );
    RELEASE_IVAR( _fsFileMenu );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    [ NOTIFICATION_CENTER addObserver: self selector: @selector( reload ) name: CEPreferencesNotificationValueChanged object: CEPreferencesKeyShowHiddenFiles ];
    [ self reload ];
}

- ( IBAction )addBookmark: ( id )sender
{
    NSOpenPanel * panel;
    
    ( void )sender;
    
    panel                           = [ NSOpenPanel openPanel ];
    panel.allowsMultipleSelection   = NO;
    panel.canChooseDirectories      = YES;
    panel.canChooseFiles            = NO;
    panel.canCreateDirectories      = YES;
    panel.prompt                    = L10N( "AddBookmark" );
    
    [ panel beginSheetModalForWindow: self.view.window completionHandler: ^( NSInteger result )
        {
            NSString * path;
            
            if( result != NSFileHandlingPanelOKButton )
            {
                return;
            }
            
            path = [ panel.URL path ];
            
            [ [ CEPreferences sharedInstance ] addBookmark: path ];
            [ self reload ];
            [ _outlineView expandItem: [ CEFileViewItem bookmarksItems ] ];
        }
    ];
}

- ( IBAction )removeBookmark: ( id )sender
{
    NSInteger        row;
    CEFileViewItem * item;
    
    ( void )sender;
    
    row = _outlineView.selectedRow;
    
    if( row == -1 )
    {
        return;
    }
    
    item = [ _outlineView itemAtRow: row ];
    
    if( item == nil || item.type != CEFileViewItemTypeBookmark )
    {
        return;
    }
    
    [ [ CEPreferences sharedInstance ] removeBookmark: item.name ];
    [ self reload ];
}

- ( IBAction )menuActionOpen: ( id )sender
{
    NSMenuItem      * menuItem;
    CEFileViewItem  * item;
    
    if( [ sender isKindOfClass: [ NSMenuItem class ] ] == NO )
    {
        return;
    }
    
    menuItem = sender;
    
    if( [ menuItem.representedObject isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return;
    }
    
    item = menuItem.representedObject;
}

- ( IBAction )menuActionClose: ( id )sender
{
    NSMenuItem      * menuItem;
    CEFileViewItem  * item;
    
    if( [ sender isKindOfClass: [ NSMenuItem class ] ] == NO )
    {
        return;
    }
    
    menuItem = sender;
    
    if( [ menuItem.representedObject isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return;
    }
    
    item = menuItem.representedObject;
}

- ( IBAction )menuActionShowInFinder: ( id )sender
{
    NSMenuItem      * menuItem;
    CEFileViewItem  * item;
    
    if( [ sender isKindOfClass: [ NSMenuItem class ] ] == NO )
    {
        return;
    }
    
    menuItem = sender;
    
    if( [ menuItem.representedObject isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return;
    }
    
    item = menuItem.representedObject;
}

- ( IBAction )menuActionOpenInDefaultEditor: ( id )sender
{
    NSMenuItem      * menuItem;
    CEFileViewItem  * item;
    
    if( [ sender isKindOfClass: [ NSMenuItem class ] ] == NO )
    {
        return;
    }
    
    menuItem = sender;
    
    if( [ menuItem.representedObject isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return;
    }
    
    item = menuItem.representedObject;
}

- ( IBAction )menuActionDelete: ( id )sender
{
    NSMenuItem      * menuItem;
    CEFileViewItem  * item;
    
    if( [ sender isKindOfClass: [ NSMenuItem class ] ] == NO )
    {
        return;
    }
    
    menuItem = sender;
    
    if( [ menuItem.representedObject isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return;
    }
    
    item = menuItem.representedObject;
}

- ( IBAction )menuActionRemoveBookmark: ( id )sender
{
    NSMenuItem      * menuItem;
    CEFileViewItem  * item;
    
    if( [ sender isKindOfClass: [ NSMenuItem class ] ] == NO )
    {
        return;
    }
    
    menuItem = sender;
    
    if( [ menuItem.representedObject isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return;
    }
    
    item = menuItem.representedObject;
    
    [ [ CEPreferences sharedInstance ] removeBookmark: item.name ];
    [ self reload ];
}

- ( IBAction )menuActionGetInfo: ( id )sender
{
    NSMenuItem      * menuItem;
    CEFileViewItem  * item;
    
    if( [ sender isKindOfClass: [ NSMenuItem class ] ] == NO )
    {
        return;
    }
    
    menuItem = sender;
    
    if( [ menuItem.representedObject isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return;
    }
    
    item = menuItem.representedObject;
}

@end
