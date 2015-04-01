
/* $Id$ */

#import "CEDiagnosticsViewController.h"
#import "CEDiagnosticsViewController+Private.h"
#import "CEDiagnosticsViewController+NSTableViewDataSource.h"
#import "CEDiagnosticsViewController+NSTableViewDelegate.h"
#import "CEDiagnosticsViewController+CETableViewDelegate.h"
#import "CEMainWindowController.h"
#import "CEDocument.h"
#import "CESourceFile.h"
#import "CEHUDView.h"

NSString * const CEDiagnosticsViewControllerTableColumnIdentifierIcon       = @"Icon";
NSString * const CEDiagnosticsViewControllerTableColumnIdentifierLine       = @"Line";
NSString * const CEDiagnosticsViewControllerTableColumnIdentifierColumn     = @"Column";
NSString * const CEDiagnosticsViewControllerTableColumnIdentifierMessage    = @"Message";

@implementation CEDiagnosticsViewController

@synthesize tableView = _tableView;

- ( void )dealloc
{
	[ NOTIFICATION_CENTER removeObserver: self ];
	
    _tableView.delegate   = nil;
    _tableView.dataSource = nil;
	
    [ _hud removeFromSuperview ];
    [ _document.sourceFile.translationUnit removeObserver: self forKeyPath: @"text" ];
    [ self.view removeObserver: self forKeyPath: @"frame" ];
    
    RELEASE_IVAR( _document );
    RELEASE_IVAR( _diagnostics );
    RELEASE_IVAR( _hud );
    
}

- ( void )awakeFromNib
{
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    
    [ NOTIFICATION_CENTER addObserver: self selector: @selector( applicationStateDidChange: ) name: NSApplicationDidBecomeActiveNotification object: APPLICATION ];
    [ NOTIFICATION_CENTER addObserver: self selector: @selector( applicationStateDidChange: ) name: NSApplicationDidResignActiveNotification object: APPLICATION ];
    
    _diagnostics =[NSMutableArray.alloc 
         initWithCapacity: 25 ];
    
    _hud                   =[CEHUDView.alloc 
         initWithFrame: NSMakeRect( 0, 0, 200, 50 ) ];
    _hud.title             = L10N( "NoError" );
    _hud.autoresizingMask  = NSViewMinXMargin
                           | NSViewMaxXMargin
                           | NSViewMinYMargin
                           | NSViewMaxYMargin;
    
    [ self.view addSubview: _hud ];
    [ _hud centerInSuperview ];
    
    [ self.view addObserver: self forKeyPath: @"frame" options: NSKeyValueObservingOptionNew context: nil ];
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
            [ _document.sourceFile.translationUnit removeObserver: self forKeyPath: @"text" ];
            
            RELEASE_IVAR( _document );
            
            _document = document;
            
            [ self getDiagnostics ];
            
            [ _document.sourceFile.translationUnit addObserver: self forKeyPath: @"text" options: NSKeyValueObservingOptionNew context: nil ];
            [ _tableView reloadData ];
        }
    }
}

- ( NSTextView * )textView
{
    @synchronized( self )
    {
        return _textView;
    }
}

- ( void )setTextView: ( NSTextView * )textView
{
    @synchronized( self )
    {
        if( _textView != textView )
        {
            [ NOTIFICATION_CENTER removeObserver: self name: NSTextViewDidChangeSelectionNotification object: _textView ];
            
            RELEASE_IVAR( _textView );
            
            _textView = textView;
            
            [ NOTIFICATION_CENTER addObserver: self selector: @selector( textViewSelectionDidChange: ) name: NSTextViewDidChangeSelectionNotification object: _textView ];
        }
    }
}

- ( void )observeValueForKeyPath: ( NSString * )keyPath ofObject: ( id )object change: ( NSDictionary * )change context: ( void * )context
{


    
    if( object == _document.sourceFile.translationUnit && [ keyPath isEqualToString: @"text" ] )
    {
        [ self getDiagnostics ];
        [ _tableView reloadData ];
    }
    else if( object == self.view && [ keyPath isEqualToString: @"frame" ] )
    {
        [ _hud centerInSuperview ];
    }
}

@end
