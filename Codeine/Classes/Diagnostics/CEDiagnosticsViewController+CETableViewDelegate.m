/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEDiagnosticsViewController+CETableViewDelegate.h"
#import "CEDiagnosticsViewController+Private.h"

@implementation CEDiagnosticsViewController( CETableViewDelegate )

- ( void )tableView: ( CETableView * )view didClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point event: ( NSEvent * )e
{
    ( void )view;
    ( void )row;
    ( void )point;
    ( void )e;
    
    [ _tableView selectRowIndexes: [ NSIndexSet indexSetWithIndex: ( NSUInteger )row ] byExtendingSelection: NO ];
    [ self showPopover ];
}

@end
