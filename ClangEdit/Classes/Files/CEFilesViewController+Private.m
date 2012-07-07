/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFilesViewController+Private.h"
#import "CEFilesViewController+NSOutlineViewDelegate.h"
#import "CEFilesViewController+NSOutlineViewDataSource.h"
#import "CEFileViewItem.h"

@implementation CEFilesViewController( Private )

- ( void )reload
{
    NSString       * rootPath;
    NSString       * userPath;
    NSString       * desktopPath;
    NSString       * documentsPath;
    CEFileViewItem * openDocumentsItem;
    CEFileViewItem * placesItem;
    
    _outlineView.delegate   = nil;
    _outlineView.dataSource = nil;
    
    RELEASE_IVAR( _rootItems );
    
    _rootItems = [ [ NSMutableArray alloc ] initWithCapacity: 10 ];
    
    openDocumentsItem   = [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeSection name: L10N( "Open documents" ) ];
    placesItem          = [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeSection name: L10N( "Places" ) ];
    
    [ _rootItems addObject: openDocumentsItem ];
    [ _rootItems addObject: placesItem ];
    
    desktopPath     = [ NSSearchPathForDirectoriesInDomains( NSDesktopDirectory, NSUserDomainMask, YES ) objectAtIndex: 0 ];
    documentsPath   = [ NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES ) objectAtIndex: 0 ];
    userPath        = NSHomeDirectory();
    rootPath        = @"/";
    
    if( desktopPath != nil )
    {
        [ placesItem addChild: [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeFS name: desktopPath ] ];
    }
    
    if( desktopPath != nil )
    {
        [ placesItem addChild: [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeFS name: documentsPath ] ];
    }
    
    if( desktopPath != nil )
    {
        [ placesItem addChild: [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeFS name: userPath ] ];
    }
    
    if( desktopPath != nil )
    {
        [ placesItem addChild: [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeFS name: rootPath ] ];
    }
    
    _outlineView.delegate   = self;
    _outlineView.dataSource = self;
    
    [ _outlineView expandItem: placesItem expandChildren: NO ];
}

@end
