/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesCompilerOptionsViewController+NSTableViewDelegate.h"
#import "CEPreferences.h"

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
        if( [ [ tableColumn identifier ] isEqualToString: CEPreferencesCompilerOptionsViewControllerFlagsTableViewColumnWarningIdentifier ] )
        {
            {
                NSArray        * flags;
                NSDictionary   * flagDict;
                NSString       * flag;
            
                flags    = [ [ CEPreferences sharedInstance ] warningFlags ];
                flagDict = ( NSDictionary * )[ flags objectAtIndex: ( NSUInteger )row ];
                flag     = [ flagDict objectForKey: @"flag" ];
                
                [ ( NSCell * )cell setTitle: L10N( [ flag cStringUsingEncoding: NSASCIIStringEncoding ] ) ];
            }
        }
    }
}

@end
