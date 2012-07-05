/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEViewController.h"

FOUNDATION_EXPORT NSString * const CEPreferencesCompilerOptionsViewControllerColumnIconIdentifier;
FOUNDATION_EXPORT NSString * const CEPreferencesCompilerOptionsViewControllerColumnExtensionIdentifier;
FOUNDATION_EXPORT NSString * const CEPreferencesCompilerOptionsViewControllerColumnTypeIdentifier;

@class CEMutableOrderedDictionary;

@interface CEPreferencesFileTypesOptionsViewController: CEViewController
{
@protected
    
    NSTableView                * _tableView;
    CEMutableOrderedDictionary * _fileTypes;
    
@private
    
    RESERVERD_IVARS( CEPreferencesFileTypesOptionsViewController , 5 );
}

@property( nonatomic, readwrite, retain ) IBOutlet NSTableView * tableView;

- ( IBAction )addFileType: ( id )sender;
- ( IBAction )removeFileType: ( id )sender;

@end
