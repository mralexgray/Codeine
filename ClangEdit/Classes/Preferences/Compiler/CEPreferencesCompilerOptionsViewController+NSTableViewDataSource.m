/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesCompilerOptionsViewController+NSTableViewDataSource.h"
#import "CEPreferences.h"
#import "CESystemIconsHelper.h"

@implementation CEPreferencesCompilerOptionsViewController( NSTableViewDataSource )

- ( NSInteger )numberOfRowsInTableView: ( NSTableView * )tableView
{
    if( tableView == _flagsTableView )
    {
        return ( NSInteger )[ [ [ CEPreferences sharedInstance ] warningFlags ] count ];
    }
    else if( tableView == _objcFrameworksTableView )
    {
        return ( NSInteger )[ [ [ CEPreferences sharedInstance ] objCFrameworks ] count ];
    }
    
    return 0;
}

- ( id )tableView: ( NSTableView * )tableView objectValueForTableColumn: ( NSTableColumn * )tableColumn row: ( NSInteger )row
{
    if( tableView == _flagsTableView )
    {
        {
            NSArray        * flags;
            NSDictionary   * flagDict;
            NSString       * flag;
            NSCellStateValue state;
            
            flags    = [ [ CEPreferences sharedInstance ] warningFlags ];
            flagDict = ( NSDictionary * )[ flags objectAtIndex: ( NSUInteger )row ];
            flag     = [ flagDict objectForKey: @"flag" ];
            state    = ( [ ( NSNumber * )[ flagDict objectForKey: @"state" ] boolValue ] == YES ) ? NSOnState : NSOffState;
            
            if( [ [ tableColumn identifier ] isEqualToString: CEPreferencesCompilerOptionsViewControllerFlagsTableViewColumnWarningIdentifier ]  )
            {
                return [ NSNumber numberWithInteger: state ];
            }
            else if( [ [ tableColumn identifier ] isEqualToString: CEPreferencesCompilerOptionsViewControllerFlagsTableViewColumnFlagIdentifier ] )
            {
                return flag;
            }
        }
    }
    else if( tableView == _objcFrameworksTableView )
    {
        {
            NSArray  * frameworks;
            NSString * framework;
            
            frameworks = [ [ CEPreferences sharedInstance ] objCFrameworks ];
            framework  = [ frameworks objectAtIndex: ( NSUInteger )row ];
            
            if( [ [ tableColumn identifier ] isEqualToString: CEPreferencesCompilerOptionsViewControllerFlagsTableViewColumnFrameworkIdentifier ]  )
            {
                return [ framework stringByAppendingPathExtension: @"framework" ];
            }
            else if( [ [ tableColumn identifier ] isEqualToString: CEPreferencesCompilerOptionsViewControllerFlagsTableViewColumnIconIdentifier ]  )
            {
                return [ [ CESystemIconsHelper sharedInstance ] iconNamed: CESystemIconDeveloperFolderIcon ];
            }
        }
    }
    
    return nil;
}

@end
