
/* $Id$ */

#import "CEPreferencesCompilerOptionsViewController.h"
#import "CEPreferencesCompilerOptionsViewController+NSTableViewDelegate.h"
#import "CEPreferencesCompilerOptionsViewController+NSTableViewDataSource.h"
#import "CEPreferencesCompilerOptionsViewController+Private.h"
#import "CEPreferences.h"
#import "CEMutableOrderedDictionary.h"

NSString * const CEPreferencesCompilerOptionsViewControllerTableViewColumnFlagIdentifier               = @"Flag";
NSString * const CEPreferencesCompilerOptionsViewControllerTableViewColumnDescriptionIdentifier        = @"Description";

@implementation CEPreferencesCompilerOptionsViewController

@synthesize tableView               = _tableView;
@synthesize warningsPresetPopUp     = _warningsPresetPopUp;
@synthesize optimizationLevelPopUp  = _optimizationLevelPopUp;

- ( void )awakeFromNib
{
    _tableView.delegate    = self;
    _tableView.dataSource  = self;
    
    [ _optimizationLevelPopUp selectItemWithTag: [ [ CEPreferences sharedInstance ] optimizationLevel ] ];
}

- ( void )dealloc
{
    _tableView.delegate   = nil;
    _tableView.dataSource = nil;
    
    RELEASE_IVAR( _tableView );
    RELEASE_IVAR( _flags );
    RELEASE_IVAR( _warningsPresetPopUp );
    RELEASE_IVAR( _optimizationLevelPopUp );
    
    [ super dealloc ];
}

- ( IBAction )selectWarningsPreset: ( id )sender
{
    BOOL           disableAll;
    NSInteger      tag;
    NSDictionary * flags;
    NSString     * flag;
    NSNumber     * value;
    

    
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

- ( IBAction )selectOptimizationLevel: ( id )sender
{
    CEOptimizationLevel level;
    

    
    level = ( CEOptimizationLevel )[ _optimizationLevelPopUp selectedTag ];
    
    [ [ CEPreferences sharedInstance ] setOptimizationLevel: level ];
}

@end
