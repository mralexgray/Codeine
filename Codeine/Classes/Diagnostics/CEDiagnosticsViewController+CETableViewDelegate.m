
/* $Id$ */

#import "CEDiagnosticsViewController+CETableViewDelegate.h"
#import "CEDiagnosticsViewController+Private.h"

@implementation CEDiagnosticsViewController( CETableViewDelegate )

- ( void )tableView: ( CETableView * )view didClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point event: ( NSEvent * )e
{




    
    [ _tableView selectRowIndexes: [ NSIndexSet indexSetWithIndex: ( NSUInteger )row ] byExtendingSelection: NO ];
    [ self showPopover ];
}

@end
