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
    CEFileViewItem * item;
    
    if( _rootItems != nil )
    {
        RELEASE_IVAR( _rootItems );
        
        for( item in [ [ CEFileViewItem placesItem ] children ] )
        {
            [ item removeAllChildren ];
        }
    }
    
    _rootItems = [ [ NSMutableArray alloc ] initWithCapacity: 10 ];
    
    [ _rootItems addObject: [ CEFileViewItem openDocumentsItem ] ];
    [ _rootItems addObject: [ CEFileViewItem placesItem ] ];
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
