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

@implementation CEFilesViewController

@synthesize outlineView = _outlineView;

- ( void )dealloc
{
    RELEASE_IVAR( _outlineView );
    RELEASE_IVAR( _rootItems );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    _rootItems = [ [ NSMutableArray alloc ] initWithCapacity: 10 ];
    
    [ _rootItems addObject: [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeSection name: L10N( "Open documents" ) ] ];
    [ _rootItems addObject: [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeSection name: L10N( "Places" ) ] ];
    
    _outlineView.delegate   = self;
    _outlineView.dataSource = self;
}

@end
