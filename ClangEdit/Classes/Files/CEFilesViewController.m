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
#import "CEInfoWindowController.h"

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
    NSString        * path;
    NSRange           range;
    
    if( [ sender isKindOfClass: [ NSMenuItem class ] ] == NO )
    {
        return;
    }
    
    menuItem = sender;
    
    if( [ menuItem.representedObject isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return;
    }
    
    item  = menuItem.representedObject;
    range = [ item.name rangeOfString: @":" ];
    
    if( range.location == NSNotFound )
    {
        path = item.name;
    }
    else
    {
        path = [ item.name substringFromIndex: range.location + 1 ];
    }
    
    [ [ NSWorkspace sharedWorkspace ] selectFile: path inFileViewerRootedAtPath: nil ];
}

- ( IBAction )menuActionOpenInDefaultEditor: ( id )sender
{
    NSMenuItem      * menuItem;
    CEFileViewItem  * item;
    NSString        * path;
    NSRange           range;
    
    if( [ sender isKindOfClass: [ NSMenuItem class ] ] == NO )
    {
        return;
    }
    
    menuItem = sender;
    
    if( [ menuItem.representedObject isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return;
    }
    
    item  = menuItem.representedObject;
    range = [ item.name rangeOfString: @":" ];
    
    if( range.location == NSNotFound )
    {
        path = item.name;
    }
    else
    {
        path = [ item.name substringFromIndex: range.location + 1 ];
    }
    
    [ [ NSWorkspace sharedWorkspace ] openFile: path ];
}

- ( IBAction )menuActionDelete: ( id )sender
{
    NSMenuItem      * menuItem;
    CEFileViewItem  * item;
    NSString        * path;
    NSRange           range;
    NSError         * error;
    
    if( [ sender isKindOfClass: [ NSMenuItem class ] ] == NO )
    {
        return;
    }
    
    menuItem = sender;
    
    if( [ menuItem.representedObject isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return;
    }
    
    item  = menuItem.representedObject;
    range = [ item.name rangeOfString: @":" ];
    
    if( range.location == NSNotFound )
    {
        path = item.name;
    }
    else
    {
        path = [ item.name substringFromIndex: range.location + 1 ];
    }
    
    error = nil;
    
    {
        NSAlert * alert;
        
        alert = [ NSAlert alertWithMessageText: [ NSString stringWithFormat: L10N( "DeleteAlertTitle" ), [ FILE_MANAGER displayNameAtPath: path ] ] defaultButton: L10N( "OK" ) alternateButton: L10N( "Cancel" ) otherButton: nil informativeTextWithFormat: L10N( "DeleteAlertText" ) ];
        
        if( [ alert runModal ] != NSAlertDefaultReturn )
        {
            return;
        }
    }
    
    if( [ FILE_MANAGER removeItemAtPath: path error: &error ] == NO || error != nil || 1 )
    {
        {
            NSAlert * alert;
            
            alert            = [ NSAlert alertWithMessageText: L10N( "DeleteErrorTitle" ) defaultButton: L10N( "OK" ) alternateButton: nil otherButton: nil informativeTextWithFormat: L10N( "DeleteErrorText" ) ];
            alert.alertStyle = NSWarningAlertStyle;
            
            NSBeep();
            
            [ alert runModal ];
        }
    }
    else
    {
        [ self reload ];
    }
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
    NSMenuItem              * menuItem;
    CEFileViewItem          * item;
    CEInfoWindowController  * controller;
    NSString                * path;
    NSRange                   range;
    
    if( [ sender isKindOfClass: [ NSMenuItem class ] ] == NO )
    {
        return;
    }
    
    menuItem = sender;
    
    if( [ menuItem.representedObject isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return;
    }
    
    item  = menuItem.representedObject;
    range = [ item.name rangeOfString: @":" ];
    
    if( range.location == NSNotFound )
    {
        path = item.name;
    }
    else
    {
        path = [ item.name substringFromIndex: range.location + 1 ];
    }
    
    controller = [ [ CEInfoWindowController alloc ] initWithPath: path ];
    
    if( controller != nil )
    {
        controller.releaseOnWindowClose = YES;
        
        [ controller.window center ];
        [ controller showWindow: sender ];
        [ controller.window makeKeyAndOrderFront: sender ];
        [ controller autorelease ];
    }
    else
    {
        NSBeep();
    }
}

@end
