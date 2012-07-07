/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesCompilerOptionsViewController.h"
#import "CEPreferencesCompilerOptionsViewController+NSTableViewDelegate.h"
#import "CEPreferencesCompilerOptionsViewController+NSTableViewDataSource.h"
#import "CEPreferencesCompilerOptionsViewController+NSOpenSavePanelDelegate.h"
#import "CEPreferencesCompilerOptionsViewController+Private.h"
#import "CEPreferences.h"

NSString * const CEPreferencesCompilerOptionsViewControllerFlagsTableViewColumnFlagIdentifier               = @"Flag";
NSString * const CEPreferencesCompilerOptionsViewControllerFlagsTableViewColumnDescriptionIdentifier        = @"Description";
NSString * const CEPreferencesCompilerOptionsViewControllerObjCFrameworksTableViewColumnIconIdentifier      = @"Icon";
NSString * const CEPreferencesCompilerOptionsViewControllerObjCFrameworksTableViewColumnFrameworkIdentifier = @"Framework";
NSString * const CEPreferencesCompilerOptionsViewControllerObjCFrameworksTableViewColumnPathIdentifier      = @"Path";

@implementation CEPreferencesCompilerOptionsViewController

@synthesize flagsTableView          = _flagsTableView;
@synthesize objcFrameworksTableView = _objcFrameworksTableView;
@synthesize warningsPresetPopUp     = _warningsPresetPopUp;

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
    RELEASE_IVAR( _warningsPresetPopUp );
    
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

- ( IBAction )selectWarningsPreset: ( id )sender
{
    BOOL           disableAll;
    NSInteger      tag;
    NSDictionary * flags;
    NSString     * flag;
    NSNumber     * value;
    
    ( void )sender;
    
    tag = [ [ _warningsPresetPopUp selectedItem ] tag ];
    
    flags       = nil;
    disableAll  = NO;
    
    switch( tag )
    {
        case 1:
            
            flags       = [ [ CEPreferences sharedInstance ] warningFlagsPresetStrict ];
            disableAll  = NO;
            break;
            
        case 2:
            
            flags       = [ [ CEPreferences sharedInstance ] warningFlagsPresetNormal ];
            disableAll  = NO;
            break;
            
        case 3:
            
            flags       = [ [ CEPreferences sharedInstance ] warningFlagsPresetStrict ];
            disableAll  = YES;
            break;
            
        default:
            
            return;
    }
    
    for( flag in flags )
    {
        value = ( disableAll == YES ) ? [ NSNumber numberWithBool: NO ] : [ flags objectForKey: flag ];
        
        if( [ value boolValue ] == YES )
        {
            [ [ CEPreferences sharedInstance ] enableWarningFlag: flag ];
        }
        else
        {
            [ [ CEPreferences sharedInstance ] disableWarningFlag: flag ];
        }
    }
    
    [ self getWarningFlags ];
    [ _flagsTableView reloadData ];
}

@end
