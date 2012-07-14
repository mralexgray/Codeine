/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFilesViewController+Private.h"
#import "CEFilesViewController+NSOutlineViewDelegate.h"
#import "CEFilesViewController+NSOutlineViewDataSource.h"
#import "CEFileViewItem.h"
#import "CEPreferences.h"

@implementation CEFilesViewController( Private )

- ( void )reload
{
    if( _rootItems != nil )
    {
        RELEASE_IVAR( _rootItems );
        
        [ [ CEFileViewItem openDocumentsItem ] reload ];
        [ [ CEFileViewItem placesItem        ] reload ];
        [ [ CEFileViewItem bookmarksItems    ] reload ];
    }
    
    _rootItems = [ [ NSMutableArray alloc ] initWithCapacity: 10 ];
    
    [ _rootItems addObject: [ CEFileViewItem openDocumentsItem ] ];
    
    #ifndef APPSTORE
        
        [ _rootItems addObject: [ CEFileViewItem placesItem ] ];
        
    #endif
    
    [ _rootItems addObject: [ CEFileViewItem bookmarksItems ] ];
    
    _outlineView.delegate              = self;
    _outlineView.dataSource            = self;
    _outlineView.autosaveExpandedItems = YES;
    _outlineView.autosaveName          = NSStringFromClass( [ self class ] );
    
    [ _outlineView reloadData ];
    [ _outlineView expandItem: [ CEFileViewItem openDocumentsItem ] expandChildren: NO ];
    
    if( [ [ CEPreferences sharedInstance ] firstLaunch ] == YES )
    {
        [ _outlineView expandItem: [ CEFileViewItem placesItem ] expandChildren: NO ];
        [ _outlineView expandItem: [ CEFileViewItem bookmarksItems ] expandChildren: NO ];
    }
}

@end
