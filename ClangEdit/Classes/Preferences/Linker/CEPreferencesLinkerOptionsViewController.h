/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEViewController.h"

FOUNDATION_EXPORT NSString * const CEPreferencesLinkerOptionsViewControllerTableViewColumnIconIdentifier;
FOUNDATION_EXPORT NSString * const CEPreferencesLinkerOptionsViewControllerTableViewColumnNameIdentifier;
FOUNDATION_EXPORT NSString * const CEPreferencesLinkerOptionsViewControllerTableViewColumnPathIdentifier;
FOUNDATION_EXPORT NSString * const CEPreferencesLinkerOptionsViewControllerTableViewColumnLanguageIdentifier;

@interface CEPreferencesLinkerOptionsViewController: CEViewController
{
@protected
    
    NSTableView * _frameworksTableView;
    NSTableView * _sharedLibsTableView;
    NSTableView * _staticLibsTableView;
    
@private
    
    RESERVERD_IVARS( CEPreferencesLinkerOptionsViewController , 5 );
}

@property( nonatomic, readwrite, retain ) IBOutlet NSTableView * frameworksTableView;
@property( nonatomic, readwrite, retain ) IBOutlet NSTableView * sharedLibsTableView;
@property( nonatomic, readwrite, retain ) IBOutlet NSTableView * staticLibsTableView;

- ( IBAction )addFramework: ( id )sender;
- ( IBAction )removeFramework: ( id )sender;
- ( IBAction )addSharedLib: ( id )sender;
- ( IBAction )removeSharedLib: ( id )sender;
- ( IBAction )addStaticLib: ( id )sender;
- ( IBAction )removeStaticLib: ( id )sender;

@end
