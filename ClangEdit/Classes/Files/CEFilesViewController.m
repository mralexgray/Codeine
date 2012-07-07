/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFilesViewController.h"
#import "CEFilesViewController+Private.h"
#import "CEFilesViewController+NSOutlineViewDelegate.h"
#import "CEFilesViewController+NSOutlineViewDataSource.h"

@implementation CEFilesViewController

@synthesize outlineView = _outlineView;

- ( void )dealloc
{
    RELEASE_IVAR( _outlineView );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    _outlineView.delegate   = self;
    _outlineView.dataSource = self;
}

@end
