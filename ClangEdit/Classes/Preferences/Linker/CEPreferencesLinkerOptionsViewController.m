/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesLinkerOptionsViewController.h"
#import "CEPreferencesLinkerOptionsViewController+NSTableViewDelegate.h"
#import "CEPreferencesLinkerOptionsViewController+NSTableViewDataSource.h"
#import "CEPreferencesLinkerOptionsViewController+Private.h"

NSString * const CEPreferencesLinkerOptionsViewControllerTableViewColumnIconIdentifier      = @"Icon";
NSString * const CEPreferencesLinkerOptionsViewControllerTableViewColumnNameIdentifier      = @"Name";
NSString * const CEPreferencesLinkerOptionsViewControllerTableViewColumnPathIdentifier      = @"Path";
NSString * const CEPreferencesLinkerOptionsViewControllerTableViewColumnLanguageIdentifier  = @"Language";

@implementation CEPreferencesLinkerOptionsViewController

@synthesize frameworksTableView = _frameworksTableView;
@synthesize sharedLibsTableView = _sharedLibsTableView;
@synthesize staticLibsTableView = _staticLibsTableView;

- ( void )dealloc
{
    RELEASE_IVAR( _frameworksTableView );
    RELEASE_IVAR( _sharedLibsTableView );
    RELEASE_IVAR( _staticLibsTableView );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    _frameworksTableView.delegate   = self;
    _frameworksTableView.dataSource = self;
    _sharedLibsTableView.delegate   = self;
    _sharedLibsTableView.dataSource = self;
    _staticLibsTableView.delegate   = self;
    _staticLibsTableView.dataSource = self;
}

- ( IBAction )addFramework: ( id )sender
{
    ( void )sender;
}

- ( IBAction )removeFramework: ( id )sender
{
    ( void )sender;
}

- ( IBAction )addSharedLib: ( id )sender
{
    ( void )sender;
}

- ( IBAction )removeSharedLib: ( id )sender
{
    ( void )sender;
}

- ( IBAction )addStaticLib: ( id )sender
{
    ( void )sender;
}

- ( IBAction )removeStaticLib: ( id )sender
{
    ( void )sender;
}


@end
