
/* $Id$ */

#import "CEPreferencesCompilerOptionsViewController+NSTableViewDelegate.h"
#import "CEPreferencesCompilerOptionsViewController+Private.h"
#import "CEPreferences.h"
#import "CEMutableOrderedDictionary.h"

@implementation CEPreferencesCompilerOptionsViewController( NSTableViewDelegate )

- ( void )tableView: ( NSTableView * )tableView willDisplayCell: ( id )cell forTableColumn: ( NSTableColumn * )tableColumn row: ( NSInteger )row
{


    
    if( [ cell isKindOfClass: [ NSCell class ] ] == NO )
    {
        return;
    }
    
    if( [ [ tableColumn identifier ] isEqualToString: CEPreferencesCompilerOptionsViewControllerTableViewColumnFlagIdentifier ] )
    {
        [ ( NSCell * )cell setTitle: [ _flags keyAtIndex: ( NSUInteger )row ] ];
    }
}

@end
