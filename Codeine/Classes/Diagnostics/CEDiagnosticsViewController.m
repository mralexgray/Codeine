/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEDiagnosticsViewController.h"
#import "CEDiagnosticsViewController+Private.h"
#import "CEDiagnosticsViewController+NSTableViewDataSource.h"
#import "CEDiagnosticsViewController+NSTableViewDelegate.h"
#import "CEMainWindowController.h"
#import "CEDocument.h"
#import "CESourceFile.h"

NSString * const CEDiagnosticsViewControllerTableColumnIdentifierIcon       = @"Icon";
NSString * const CEDiagnosticsViewControllerTableColumnIdentifierLine       = @"Line";
NSString * const CEDiagnosticsViewControllerTableColumnIdentifierColumn     = @"Column";
NSString * const CEDiagnosticsViewControllerTableColumnIdentifierMessage    = @"Message";

@implementation CEDiagnosticsViewController

@synthesize tableView = _tableView;

- ( void )dealloc
{
    [ _document.sourceFile.translationUnit removeObserver: self forKeyPath: @"text" ];
    
    RELEASE_IVAR( _tableView );
    RELEASE_IVAR( _document );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    
    [ NOTIFICATION_CENTER addObserver: self selector: @selector( applicationStateDidChange: ) name: NSApplicationDidBecomeActiveNotification object: APPLICATION ];
    [ NOTIFICATION_CENTER addObserver: self selector: @selector( applicationStateDidChange: ) name: NSApplicationDidResignActiveNotification object: APPLICATION ];
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
            
            _document = [ document retain ];
            
            [ _document.sourceFile.translationUnit addObserver: self forKeyPath: @"text" options: NSKeyValueObservingOptionNew context: nil ];
            [ _tableView reloadData ];
        }
    }
}

- ( void )observeValueForKeyPath: ( NSString * )keyPath ofObject: ( id )object change: ( NSDictionary * )change context: ( void * )context
{
    ( void )keyPath;
    ( void )object;
    ( void )change;
    ( void )context;
    
    if( object == _document.sourceFile.translationUnit && [ keyPath isEqualToString: @"text" ] )
    {
        [ _tableView reloadData ];
    }
}

@end
