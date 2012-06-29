/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEViewController.h"

FOUNDATION_EXPORT NSString * const CEPreferencesCompilerOptionsViewControllerFlagsTableViewColumnWarningIdentifier;
FOUNDATION_EXPORT NSString * const CEPreferencesCompilerOptionsViewControllerFlagsTableViewColumnFlagIdentifier;
FOUNDATION_EXPORT NSString * const CEPreferencesCompilerOptionsViewControllerObjCFrameworksTableViewColumnIconIdentifier;
FOUNDATION_EXPORT NSString * const CEPreferencesCompilerOptionsViewControllerObjCFrameworksTableViewColumnFrameworkIdentifier;
FOUNDATION_EXPORT NSString * const CEPreferencesCompilerOptionsViewControllerObjCFrameworksTableViewColumnPathIdentifier;

@interface CEPreferencesCompilerOptionsViewController: CEViewController
{
@protected
    
    NSTableView * _flagsTableView;
    NSTableView * _objcFrameworksTableView;
    
@private
    
    RESERVERD_IVARS( CEPreferencesCompilerOptionsViewController , 5 );
}

@property( nonatomic, readwrite, retain ) IBOutlet NSTableView * flagsTableView;
@property( nonatomic, readwrite, retain ) IBOutlet NSTableView * objcFrameworksTableView;

- ( IBAction )addFramework: ( id )sender;
- ( IBAction )removeFramework: ( id )sender;

@end
