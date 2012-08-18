/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEDiagnosticsViewController+NSTableViewDelegate.h"
#import "CEFixItViewController.h"

@implementation CEDiagnosticsViewController( NSTableViewDelegate )

- ( void )tableViewSelectionDidChange: ( NSNotification * )notification
{
    CKDiagnostic          * diagnostic;
    CEFixItViewController * controller;
    NSPopover             * popover;
    NSRect                  cellFrame;
    
    ( void )notification;
    
    if( _tableView.selectedRow == NSNotFound )
    {
        return;
    }
    
    @try
    {
        cellFrame           = [ _tableView frameOfCellAtColumn: 0 row: _tableView.selectedRow ];
        diagnostic          = [ _diagnostics objectAtIndex: ( NSUInteger )( _tableView.selectedRow ) ];
        controller          = [ [ CEFixItViewController alloc ] initWithDiagnostic: diagnostic ];
        popover             = [ NSPopover new ];
        popover.behavior    = NSPopoverBehaviorTransient;
        controller.textView = _textView;
        
        popover.contentViewController = controller;
        
        [ popover showRelativeToRect: cellFrame ofView: _tableView preferredEdge: NSMinYEdge ];
        
        [ popover    autorelease ];
        [ controller autorelease ];
    }
    @catch( NSException * e )
    {
        ( void )e;
    }
}

@end
