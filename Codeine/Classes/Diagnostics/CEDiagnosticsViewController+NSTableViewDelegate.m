/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEDiagnosticsViewController+NSTableViewDelegate.h"
#import "CEDiagnosticsViewController+Private.h"
#import "CEFixItViewController.h"

@implementation CEDiagnosticsViewController( NSTableViewDelegate )

- ( void )tableViewSelectionDidChange: ( NSNotification * )notification
{
    ( void )notification;
    
    [ self showPopover ];
}

@end
