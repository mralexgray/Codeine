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
        controller.textView = _textView;
        
        [ controller openInPopoverRelativeToRect: cellFrame ofView: _tableView preferredEdge: NSMinYEdge ];
        [ controller autorelease ];
    }
    @catch( NSException * e )
    {
        ( void )e;
    }
}

@end
