/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesCompilerOptionsViewController.h"
#import "CEPreferencesCompilerOptionsViewController+NSTableViewDelegate.h"
#import "CEPreferencesCompilerOptionsViewController+NSTableViewDataSource.h"
#import "CEPreferencesCompilerOptionsViewController+Private.h"
#import "CEPreferences.h"

NSString * const CEPreferencesCompilerOptionsViewControllerTableViewColumnFlagIdentifier               = @"Flag";
NSString * const CEPreferencesCompilerOptionsViewControllerTableViewColumnDescriptionIdentifier        = @"Description";

@implementation CEPreferencesCompilerOptionsViewController

@synthesize tableView           = _tableView;
@synthesize warningsPresetPopUp = _warningsPresetPopUp;

- ( void )awakeFromNib
{
    _tableView.delegate    = self;
    _tableView.dataSource  = self;
}

- ( void )dealloc
{
    RELEASE_IVAR( _tableView );
    RELEASE_IVAR( _flags );
    RELEASE_IVAR( _warningsPresetPopUp );
    
    [ super dealloc ];
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
    [ _tableView reloadData ];
}

@end
