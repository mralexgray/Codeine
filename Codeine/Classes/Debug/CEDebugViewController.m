/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEDebugViewController.h"
#import "CEDebugViewController+Private.h"
#import "CEPreferences.h"
#import "CEVerticalTabView.h"
#import "CEConsoleViewController.h"
#import "CEDiagnosticsViewController.h"

@implementation CEDebugViewController

@synthesize tabView = _tabView;

- ( void )dealloc
{
    RELEASE_IVAR( _tabView );
    RELEASE_IVAR( _consoleViewController );
    RELEASE_IVAR( _diagnosticsViewController );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    _consoleViewController      = [ CEConsoleViewController     new ];
    _diagnosticsViewController  = [ CEDiagnosticsViewController new ];
    
    [ _tabView setTabBarWidth: ( CGFloat )64 ];
    
    [ _tabView addView: _consoleViewController.view icon: [ NSImage imageNamed: @"Console" ] ];
    [ _tabView addView: _diagnosticsViewController.view icon: [ NSImage imageNamed: @"Diagnostics" ] ];
}

@end
