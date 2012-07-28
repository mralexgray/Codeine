/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEViewController.h"

FOUNDATION_EXPORT NSString * const CEPreferencesCompilerOptionsViewControllerTableViewColumnFlagIdentifier;
FOUNDATION_EXPORT NSString * const CEPreferencesCompilerOptionsViewControllerTableViewColumnDescriptionIdentifier;

@class CEMutableOrderedDictionary;

@interface CEPreferencesCompilerOptionsViewController: CEViewController
{
@protected
    
    NSTableView                * _tableView;
    CEMutableOrderedDictionary * _flags;
    NSPopUpButton              * _warningsPresetPopUp;
    NSPopUpButton              * _optimizationLevelPopUp;
    
@private
    
    RESERVED_IVARS( CEPreferencesCompilerOptionsViewController , 5 );
}

@property( nonatomic, readwrite, retain ) IBOutlet NSTableView   * tableView;
@property( nonatomic, readwrite, retain ) IBOutlet NSPopUpButton * warningsPresetPopUp;
@property( nonatomic, readwrite, retain ) IBOutlet NSPopUpButton * optimizationLevelPopUp;

- ( IBAction )selectWarningsPreset: ( id )sender;
- ( IBAction )selectOptimizationLevel: ( id )sender;

@end
