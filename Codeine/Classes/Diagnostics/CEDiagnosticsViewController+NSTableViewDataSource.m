
/* $Id$ */

#import "CEDiagnosticsViewController+NSTableViewDataSource.h"
#import "CEDocument.h"
#import "CESourceFile.h"
#import "CEDiagnosticWrapper.h"
#import "CEHUDView.h"

@implementation CEDiagnosticsViewController( NSTableViewDataSource )

- ( NSInteger )numberOfRowsInTableView: ( NSTableView * )tableView
{
    NSInteger count;
    

    
    count = ( NSInteger )( _diagnostics.count );
    
    if( count == 0 )
    {
        [ _hud setAlphaValue: ( CGFloat )1 ];
    }
    else
    {
        [ _hud setAlphaValue: ( CGFloat )0 ];
    }
    
    return count;
}

- ( id )tableView: ( NSTableView * )tableView objectValueForTableColumn: ( NSTableColumn * )tableColumn row: ( NSInteger )row
{
    CKDiagnostic * diagnostic;
    



    
    @try
    {
        diagnostic = [ _diagnostics objectAtIndex: ( NSUInteger )row ];
    }
    @catch( NSException * e )
    {

        
        return nil;
    }
    
    return [ CEDiagnosticWrapper diagnosticWrapperWithDiagnostic: diagnostic ];
}

@end
