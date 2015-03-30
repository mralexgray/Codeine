
/* $Id$ */

#import "CEDebugViewController.h"
#import "CEDebugViewController+Private.h"
#import "CEDebugViewController+CEVerticalTabViewDelegate.h"
#import "CEPreferences.h"
#import "CEVerticalTabView.h"
#import "CEConsoleViewController.h"
#import "CEDiagnosticsViewController.h"
#import "CEDocument.h"

@implementation CEDebugViewController

@synthesize tabView                   = _tabView;
@synthesize consoleViewController     = _consoleViewController;
@synthesize diagnosticsViewController = _diagnosticsViewController;

- ( void )dealloc
{
    RELEASE_IVAR( _tabView );
    RELEASE_IVAR( _consoleViewController );
    RELEASE_IVAR( _diagnosticsViewController );
    RELEASE_IVAR( _document );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    _consoleViewController      = [ CEConsoleViewController     new ];
    _diagnosticsViewController  = [ CEDiagnosticsViewController new ];
    
    [ _tabView setTabBarWidth: ( CGFloat )48 ];
    
    [ _tabView addView: _consoleViewController.view icon: [ NSImage imageNamed: @"Console" ] ];
    [ _tabView addView: _diagnosticsViewController.view icon: [ NSImage imageNamed: @"Diagnostics" ] ];
    
    [ _tabView setTabBarPosition: CEVerticalTabBarPositionRight ];
    [ _tabView selectViewAtIndex: [ [ CEPreferences sharedInstance ] debugAreaSelectedIndex ] ];
    [ _tabView setDelegate: self ];
}

- ( CEDocument * )document
{
    @synchronized( self )
    {
        return _document;
    }
}

- ( void )setDocument: ( CEDocument * )document
{
    @synchronized( self )
    {
        if( document != _document )
        {
            RELEASE_IVAR( _document );
            
            _document                           = [ document retain ];
            _diagnosticsViewController.document = document;
        }
    }
}

@end
