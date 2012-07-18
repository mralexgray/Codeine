/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CELanguageWindowController+NSTableViewDataSource.h"
#import "CESourceFile.h"

@implementation CELanguageWindowController( NSTableViewDataSource )

- ( NSInteger )numberOfRowsInTableView: ( NSTableView * )tableView
{
    if( tableView == _languagesTableView )
    {
        return 4;
    }
    else if( tableView == _recentFilesTableView )
    {
        return 0;
    }
    
    return 0;
}

- ( id )tableView: ( NSTableView * )tableView objectValueForTableColumn: ( NSTableColumn * )tableColumn row: ( NSInteger )row
{
    if( tableView == _languagesTableView )
    {
        if( [ tableColumn.identifier isEqualToString: CELanguageWindowControllerTableColumnIdentifierIcon ] )
        {
            switch( row )
            {
                case 0:
                    
                    return [ [ NSWorkspace sharedWorkspace ] iconForFileType: @"c" ];
                    
                case 1:
                    
                    return [ [ NSWorkspace sharedWorkspace ] iconForFileType: @"cpp" ];
                    
                case 2:
                    
                    return [ [ NSWorkspace sharedWorkspace ] iconForFileType: @"m" ];
                    
                case 3:
                    
                    return [ [ NSWorkspace sharedWorkspace ] iconForFileType: @"mm" ];
                    
                default:
                    
                    return nil;
            }
        }
        else if( [ tableColumn.identifier isEqualToString: CELanguageWindowControllerTableColumnIdentifierTitle ] )
        {
            switch( row )
            {
                case 0:
                    
                    return [ NSNumber numberWithInteger: CESourceFileLanguageC ];
                    
                case 1:
                    
                    return [ NSNumber numberWithInteger: CESourceFileLanguageCPP ];
                    
                case 2:
                    
                    return [ NSNumber numberWithInteger: CESourceFileLanguageObjC ];
                    
                case 3:
                    
                    return [ NSNumber numberWithInteger: CESourceFileLanguageObjCPP ];
                    
                default:
                    
                    return nil;
            }
        }
    }
    else if( tableView == _recentFilesTableView )
    {
        return nil;
    }
    
    return nil;
}

@end
