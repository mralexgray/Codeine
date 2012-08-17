/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEDiagnosticsViewController+NSTableViewDataSource.h"
#import "CEDocument.h"
#import "CESourceFile.h"
#import "CEDiagnosticWrapper.h"

@implementation CEDiagnosticsViewController( NSTableViewDataSource )

- ( NSInteger )numberOfRowsInTableView: ( NSTableView * )tableView
{
    ( void )tableView;
    
    return ( NSInteger )( _document.sourceFile.translationUnit.diagnostics.count );
}

- ( id )tableView: ( NSTableView * )tableView objectValueForTableColumn: ( NSTableColumn * )tableColumn row: ( NSInteger )row
{
    CKDiagnostic * diagnostic;
    
    ( void )tableView;
    ( void )tableColumn;
    ( void )row;
    
    @try
    {
        diagnostic = [ _document.sourceFile.translationUnit.diagnostics objectAtIndex: ( NSUInteger )row ];
    }
    @catch( NSException * e )
    {
        ( void )e;
        
        return nil;
    }
    
    return [ CEDiagnosticWrapper diagnosticWrapperWithDiagnostic: diagnostic ];
}

@end
