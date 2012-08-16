/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEViewController.h"

@class CEVerticalTabView;
@class CEConsoleViewController;
@class CEDiagnosticsViewController;

@interface CEDebugViewController: CEViewController
{
@protected
    
    CEVerticalTabView           * _tabView;
    CEConsoleViewController     * _consoleViewController;
    CEDiagnosticsViewController * _diagnosticsViewController;
    
@private
    
    RESERVED_IVARS( CEDebugViewController , 5 );
}

@property( nonatomic, readwrite, retain ) IBOutlet CEVerticalTabView * tabView;



@end
