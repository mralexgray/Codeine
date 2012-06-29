/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesCompilerOptionsViewController.h"
#import "CEPreferencesCompilerOptionsViewController+NSTableViewDelegate.h"
#import "CEPreferencesCompilerOptionsViewController+NSTableViewDataSource.h"

NSString * const CEPreferencesCompilerOptionsViewControllerFlagsTableViewColumnWarningIdentifier    = @"Warning";
NSString * const CEPreferencesCompilerOptionsViewControllerFlagsTableViewColumnFlagIdentifier       = @"Flag";
NSString * const CEPreferencesCompilerOptionsViewControllerFlagsTableViewColumnIconIdentifier       = @"Icon";
NSString * const CEPreferencesCompilerOptionsViewControllerFlagsTableViewColumnFrameworkIdentifier  = @"Framework";

@implementation CEPreferencesCompilerOptionsViewController

@synthesize flagsTableView          = _flagsTableView;
@synthesize objcFrameworksTableView = _objcFrameworksTableView;

- ( void )awakeFromNib
{
    _flagsTableView.delegate    = self;
    _flagsTableView.dataSource  = self;
    
    _objcFrameworksTableView.delegate    = self;
    _objcFrameworksTableView.dataSource  = self;
}

@end
