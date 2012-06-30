/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesCompilerOptionsViewController.h"
#import "CEPreferencesCompilerOptionsViewController+NSTableViewDelegate.h"
#import "CEPreferencesCompilerOptionsViewController+NSTableViewDataSource.h"
#import "CEPreferencesCompilerOptionsViewController+NSOpenSavePanelDelegate.h"
#import "CEPreferences.h"

NSString * const CEPreferencesCompilerOptionsViewControllerFlagsTableViewColumnFlagIdentifier               = @"Flag";
NSString * const CEPreferencesCompilerOptionsViewControllerFlagsTableViewColumnDescriptionIdentifier        = @"Description";
NSString * const CEPreferencesCompilerOptionsViewControllerObjCFrameworksTableViewColumnIconIdentifier      = @"Icon";
NSString * const CEPreferencesCompilerOptionsViewControllerObjCFrameworksTableViewColumnFrameworkIdentifier = @"Framework";
NSString * const CEPreferencesCompilerOptionsViewControllerObjCFrameworksTableViewColumnPathIdentifier      = @"Path";

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

- ( void )dealloc
{
    RELEASE_IVAR( _flagsTableView );
    RELEASE_IVAR( _objcFrameworksTableView );
    RELEASE_IVAR( _warningFlags );
    
    [ super dealloc ];
}

- ( IBAction )addFramework: ( id )sender
{
    NSOpenPanel * panel;
    
    ( void )sender;
    
    panel           = [ NSOpenPanel openPanel ];
    panel.delegate  = self;
    
    panel.allowsMultipleSelection   = NO;
    panel.canChooseDirectories      = YES;
    panel.canChooseFiles            = NO;
    panel.canCreateDirectories      = NO;
    
    [ panel beginSheetModalForWindow: self.view.window completionHandler: ^( NSInteger result )
        {
            if( result != NSFileHandlingPanelOKButton )
            {
                return;
            }
            
            [ [ CEPreferences sharedInstance ] addObjCFramework: [ [ panel URL ] path ] ];
            [ _objcFrameworksTableView reloadData ];
        }
    ];
}

- ( IBAction )removeFramework: ( id )sender
{
    NSArray  * frameworks;
    NSUInteger row;
    
    ( void )sender;
    
    if( [ _objcFrameworksTableView selectedRow ] == -1 )
    {
        return;
    }
    
    row        = ( NSUInteger )_objcFrameworksTableView.selectedRow;
    frameworks = [ [ CEPreferences sharedInstance ] objCFrameworks ];
    
    if( row >= frameworks.count )
    {
        return;
    }
    
    [ [ CEPreferences sharedInstance ] removeObjCFramework: [ frameworks objectAtIndex: row ] ];
    [ _objcFrameworksTableView reloadData ];
}

@end
