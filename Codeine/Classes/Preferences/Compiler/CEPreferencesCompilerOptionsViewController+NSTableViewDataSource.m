
/* $Id$ */

#import "CEPreferencesCompilerOptionsViewController+NSTableViewDataSource.h"
#import "CEPreferencesCompilerOptionsViewController+Private.h"
#import "CEPreferences.h"
#import "CESystemIconsHelper.h"
#import "CEMutableOrderedDictionary.h"

@implementation CEPreferencesCompilerOptionsViewController( NSTableViewDataSource )

- ( NSInteger )numberOfRowsInTableView: ( NSTableView * )tableView
{

    
    if( _flags == nil )
    {
        [ self getWarningFlags ];
    }
    
    return ( NSInteger )( _flags.count );
}

- ( id )tableView: ( NSTableView * )tableView objectValueForTableColumn: ( NSTableColumn * )tableColumn row: ( NSInteger )row
{
    NSString       * flag;
    NSCellStateValue state;
    

    
    if( _flags == nil )
    {
        [ self getWarningFlags ];
    }
    
    flag  = [ _flags keyAtIndex: ( NSUInteger )row ];
    state = ( [ ( NSNumber * )[ _flags objectAtIndex: ( NSUInteger )row ] boolValue ] == YES ) ? NSOnState : NSOffState;
    
    if( [ [ tableColumn identifier ] isEqualToString: CEPreferencesCompilerOptionsViewControllerTableViewColumnFlagIdentifier ]  )
    {
        return @(state);
    }
    else if( [ [ tableColumn identifier ] isEqualToString: CEPreferencesCompilerOptionsViewControllerTableViewColumnDescriptionIdentifier ] )
    {
        return L10N( [ flag cStringUsingEncoding: NSUTF8StringEncoding ] );
    }
    
    return nil;
}

- ( void )tableView: ( NSTableView * )tableView setObjectValue: ( id )object forTableColumn: ( NSTableColumn * )column row: ( NSInteger )row
{
    NSString * flag;
    


    
    flag = [ _flags keyAtIndex: ( NSUInteger )row ];
    
    if( [ ( NSNumber * )object boolValue ] == YES )
    {
        [ [ CEPreferences sharedInstance ] enableWarningFlag: flag ];
    }
    else
    {
        [ [ CEPreferences sharedInstance ] disableWarningFlag: flag ];
    }
    
    [ self getWarningFlags ];
    [ _tableView reloadData ];
}

@end
