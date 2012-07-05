/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesCompilerOptionsViewController+NSTableViewDataSource.h"
#import "CEPreferencesCompilerOptionsViewController+Private.h"
#import "CEPreferences.h"
#import "CESystemIconsHelper.h"
#import "CEMutableOrderedDictionary.h"

@implementation CEPreferencesCompilerOptionsViewController( NSTableViewDataSource )

- ( NSInteger )numberOfRowsInTableView: ( NSTableView * )tableView
{
    if( tableView == _flagsTableView )
    {
        if( _warningFlags == nil )
        {
            [ self getWarningFlags ];
        }
        
        return ( NSInteger )( _warningFlags.count );
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
        if( _warningFlags == nil )
        {
            [ self getWarningFlags ];
        }
        
        {
            NSString       * flag;
            NSCellStateValue state;
            
            flag  = [ _warningFlags keyAtIndex: ( NSUInteger )row ];
            state = ( [ ( NSNumber * )[ _warningFlags objectAtIndex: ( NSUInteger )row ] boolValue ] == YES ) ? NSOnState : NSOffState;
            
            if( [ [ tableColumn identifier ] isEqualToString: CEPreferencesCompilerOptionsViewControllerFlagsTableViewColumnFlagIdentifier ]  )
            {
                return [ NSNumber numberWithInteger: state ];
            }
            else if( [ [ tableColumn identifier ] isEqualToString: CEPreferencesCompilerOptionsViewControllerFlagsTableViewColumnDescriptionIdentifier ] )
            {
                return L10N( [ flag cStringUsingEncoding: NSUTF8StringEncoding ] );
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
            
            if( [ [ tableColumn identifier ] isEqualToString: CEPreferencesCompilerOptionsViewControllerObjCFrameworksTableViewColumnFrameworkIdentifier ]  )
            {
                return [ [ framework lastPathComponent ] stringByDeletingPathExtension ];
            }
            else if( [ [ tableColumn identifier ] isEqualToString: CEPreferencesCompilerOptionsViewControllerObjCFrameworksTableViewColumnIconIdentifier ]  )
            {
                return [ [ CESystemIconsHelper sharedInstance ] iconNamed: CESystemIconDeveloperFolderIcon ];
            }
            else if( [ [ tableColumn identifier ] isEqualToString: CEPreferencesCompilerOptionsViewControllerObjCFrameworksTableViewColumnPathIdentifier ]  )
            {
                return [ framework stringByDeletingLastPathComponent ];
            }
        }
    }
    
    return nil;
}

- ( void )tableView: ( NSTableView * )tableView setObjectValue: ( id )object forTableColumn: ( NSTableColumn * )column row: ( NSInteger )row
{
    NSString * flag;
    
    ( void )column;
    
    if( tableView != _flagsTableView )
    {
        return;
    }
    
    flag = [ _warningFlags keyAtIndex: ( NSUInteger )row ];
    
    if( [ ( NSNumber * )object boolValue ] == YES )
    {
        [ [ CEPreferences sharedInstance ] enableWarningFlag: flag ];
    }
    else
    {
        [ [ CEPreferences sharedInstance ] disableWarningFlag: flag ];
    }
    
    [ self getWarningFlags ];
    [ _flagsTableView reloadData ];
}

@end
