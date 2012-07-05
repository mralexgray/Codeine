/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesFileTypesOptionsViewController.h"
#import "CEPreferencesFileTypesOptionsViewController+NSTableViewDelegate.h"
#import "CEPreferencesFileTypesOptionsViewController+NSTableViewDataSource.h"
#import "CEPreferencesFileTypesOptionsViewController+Private.h"
#import "CEPreferencesFileTypesAddNewViewController.h"
#import "CEPreferences.h"
#import "CEMutableOrderedDictionary.h"

NSString * const CEPreferencesCompilerOptionsViewControllerColumnIconIdentifier         = @"Icon";
NSString * const CEPreferencesCompilerOptionsViewControllerColumnExtensionIdentifier    = @"Extension";
NSString * const CEPreferencesCompilerOptionsViewControllerColumnTypeIdentifier         = @"Type";

@implementation CEPreferencesFileTypesOptionsViewController

@synthesize tableView = _tableView;

- ( void )dealloc
{
    RELEASE_IVAR( _tableView );
    RELEASE_IVAR( _fileTypes );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    _tableView.delegate   = self;
    _tableView.dataSource = self;
}

- ( IBAction )addFileType: ( id )sender
{
    ( void )sender;
    
    if( _addNewController == nil )
    {
        _addNewController = [ CEPreferencesFileTypesAddNewViewController new ];
    }
    
    [ APPLICATION beginSheet: _addNewController.window modalForWindow: self.view.window modalDelegate: self didEndSelector: @selector( didChooseFileType: ) contextInfo: NULL ];
}

- ( IBAction )removeFileType: ( id )sender
{
    NSUInteger row;
    
    ( void )sender;
    
    if( [ _tableView selectedRow ] == -1 )
    {
        return;
    }
    
    row = ( NSUInteger )_tableView.selectedRow;
    
    if( row >= _fileTypes.count )
    {
        return;
    }
    
    [ [ CEPreferences sharedInstance ] removeFileTypeForExtension: [ _fileTypes keyAtIndex: row ] ];
    
    [ self getFileTypes ];
    [ _tableView reloadData ];
}

@end
