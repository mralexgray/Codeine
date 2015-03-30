
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
    _tableView.delegate    = self;
    _tableView.dataSource  = self;
    
    RELEASE_IVAR( _fileTypes );
    
}

- ( void )awakeFromNib
{
    _tableView.delegate   = self;
    _tableView.dataSource = self;
}

- ( IBAction )addFileType: ( id )sender
{

    
    if( _addNewController == nil )
    {
        _addNewController = [ CEPreferencesFileTypesAddNewViewController new ];
    }
    
    [ self.view.window beginSheet: _addNewController.window completionHandler: ^( NSModalResponse response )
        {
            if( response == NSModalResponseOK )
            {
                [ self didChooseFileType: nil ];
            }
        }
    ];
}

- ( IBAction )removeFileType: ( id )sender
{
    NSUInteger row;
    

    
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
