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
    CEFileViewItem * placesItems;
    
    _outlineView.delegate   = nil;
    _outlineView.dataSource = nil;
    
    NSLog( @"reload" );
    
    RELEASE_IVAR( _rootItems );
    
    _rootItems = [ [ NSMutableArray alloc ] initWithCapacity: 10 ];
    
    openDocumentsItem   = [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeSection name: L10N( "Open documents" ) ];
    placesItems         = [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeSection name: L10N( "Places" ) ];
    
    [ _rootItems addObject: openDocumentsItem ];
    [ _rootItems addObject: placesItems ];
    
    desktopPath     = [ NSSearchPathForDirectoriesInDomains( NSDesktopDirectory, NSUserDomainMask, YES ) objectAtIndex: 0 ];
    documentsPath   = [ NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES ) objectAtIndex: 0 ];
    userPath        = NSHomeDirectory();
    rootPath        = @"/";
    
    if( desktopPath != nil )
    {
        [ placesItems addChild: [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeFS name: desktopPath ] ];
    }
    
    if( desktopPath != nil )
    {
        [ placesItems addChild: [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeFS name: documentsPath ] ];
    }
    
    if( desktopPath != nil )
    {
        [ placesItems addChild: [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeFS name: userPath ] ];
    }
    
    if( desktopPath != nil )
    {
        [ placesItems addChild: [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeFS name: rootPath ] ];
    }
    
    _outlineView.delegate   = self;
    _outlineView.dataSource = self;
}

@end
