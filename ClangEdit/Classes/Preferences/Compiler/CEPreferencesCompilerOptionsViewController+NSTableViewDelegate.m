/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesCompilerOptionsViewController+NSTableViewDelegate.h"
#import "CEPreferencesCompilerOptionsViewController+Private.h"
#import "CEPreferences.h"
#import "CEMutableOrderedDictionary.h"

@implementation CEPreferencesCompilerOptionsViewController( NSTableViewDelegate )

- ( void )tableView: ( NSTableView * )tableView willDisplayCell: ( id )cell forTableColumn: ( NSTableColumn * )tableColumn row: ( NSInteger )row
{
    ( void )row;
    
    if( [ cell isKindOfClass: [ NSCell class ] ] == NO )
    {
        return;
    }
    
    if( tableView == _flagsTableView )
    {
        if( [ [ tableColumn identifier ] isEqualToString: CEPreferencesCompilerOptionsViewControllerFlagsTableViewColumnFlagIdentifier ] )
        {
            [ ( NSCell * )cell setTitle: [ _warningFlags keyAtIndex: ( NSUInteger )row ] ];
            [ ( NSCell * )cell setTarget: self ];
            [ ( NSCell * )cell setAction: @selector( setFlag: ) ];
        }
    }
}

@end
