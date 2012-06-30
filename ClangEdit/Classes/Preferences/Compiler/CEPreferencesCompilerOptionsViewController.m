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
            NSMutableArray * frameworks;
            
            if( result != NSFileHandlingPanelOKButton )
            {
                return;
            }
            
            frameworks = [ [ [ CEPreferences sharedInstance ] objCFrameworks ] mutableCopy ];
            
            [ frameworks addObject: [ [ panel URL ] path ] ];
            [ [ CEPreferences sharedInstance ] setObjCFrameworks: [ NSArray arrayWithArray: frameworks ] ];
            
            [ frameworks release ];
            [ _objcFrameworksTableView reloadData ];
        }
    ];
}

- ( IBAction )removeFramework: ( id )sender
{
    NSMutableArray * frameworks;
    
    ( void )sender;
    
    if( [ _objcFrameworksTableView selectedRow ] == -1 )
    {
        return;
    }
    
    frameworks = [ [ [ CEPreferences sharedInstance ] objCFrameworks ] mutableCopy ];
    
    [ frameworks removeObjectAtIndex: ( NSUInteger )( [ _objcFrameworksTableView selectedRow ] ) ];
    [ [ CEPreferences sharedInstance ] setObjCFrameworks: [ NSArray arrayWithArray: frameworks ] ];
    
    [ frameworks release ];
    [ _objcFrameworksTableView reloadData ];
}

@end
