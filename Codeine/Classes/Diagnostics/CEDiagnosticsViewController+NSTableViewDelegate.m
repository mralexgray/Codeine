
/* $Id$ */

#import "CEDiagnosticsViewController+NSTableViewDelegate.h"
#import "CEDiagnosticsViewController+Private.h"
#import "CEFixItViewController.h"

@implementation CEDiagnosticsViewController( NSTableViewDelegate )

- ( void )tableViewSelectionDidChange: ( NSNotification * )notification
{

    
    [ self showPopover ];
}

@end
