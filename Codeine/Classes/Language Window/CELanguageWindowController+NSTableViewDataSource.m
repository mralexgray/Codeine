
/* $Id$ */

#import "CELanguageWindowController+NSTableViewDataSource.h"
#import "CESourceFile.h"

@implementation CELanguageWindowController( NSTableViewDataSource )

- ( NSInteger )numberOfRowsInTableView: ( NSTableView * )tableView
{
    if( tableView == _languagesTableView )
    {
        return 5;
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
                    
                    return [ WORKSPACE iconForFileType: @"c" ];
                    
                case 1:
                    
                    return [ WORKSPACE iconForFileType: @"cpp" ];
                    
                case 2:
                    
                    return [ WORKSPACE iconForFileType: @"m" ];
                    
                case 3:
                    
                    return [ WORKSPACE iconForFileType: @"mm" ];
                    
                case 4:
                    
                    return [ WORKSPACE iconForFileType: @"h" ];
                    
                default:
                    
                    return nil;
            }
        }
        else if( [ tableColumn.identifier isEqualToString: CELanguageWindowControllerTableColumnIdentifierTitle ] )
        {
            switch( row )
            {
                case 0:
                    
                    return @(CESourceFileLanguageC);
                    
                case 1:
                    
                    return @(CESourceFileLanguageCPP);
                    
                case 2:
                    
                    return @(CESourceFileLanguageObjC);
                    
                case 3:
                    
                    return @(CESourceFileLanguageObjCPP);
                    
                case 4:
                    
                    return @(CESourceFileLanguageHeader);
                    
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
