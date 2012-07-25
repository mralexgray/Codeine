/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEMainWindowController.h"
#import "CEMainWindowController+Private.h"
#import "CEEditorViewController.h"
#import "CEDebugViewController.h"
#import "CEFilesViewController.h"
#import "CESourceFile.h"
#import "CETextEncoding.h"
#import "CEPreferences.h"
#import "CEQuickLookItem.h"
#import "CEWindowBadge.h"
#import "CEApplicationDelegate.h"
#import "CEHUDView.h"

@implementation CEMainWindowController

@synthesize leftView      = _leftView;
@synthesize mainView      = _mainView;
@synthesize bottomView    = _bottomView;
@synthesize sourceFile    = _sourceFile;
@synthesize encodingPopUp = _encodingPopUp;

- ( void )dealloc
{
    RELEASE_IVAR( _fileViewController );
    RELEASE_IVAR( _editorViewController );
    RELEASE_IVAR( _debugViewController );
    RELEASE_IVAR( _leftView );
    RELEASE_IVAR( _mainView );
    RELEASE_IVAR( _bottomView );
    RELEASE_IVAR( _sourceFile );
    RELEASE_IVAR( _languageWindowController );
    RELEASE_IVAR( _encodingPopUp );
    RELEASE_IVAR( _documents );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    NSUInteger  resizingMask;
    CEHUDView * editorHUD;
    CEHUDView * consoleHUD;
    
    resizingMask = NSViewWidthSizable
                 | NSViewHeightSizable
                 | NSViewMinXMargin
                 | NSViewMaxXMargin
                 | NSViewMinYMargin
                 | NSViewMaxYMargin;
    
    _editorViewController = [ CEEditorViewController new ];
    _debugViewController  = [ CEDebugViewController  new ];
    _fileViewController   = [ CEFilesViewController  new ];
    
    _editorViewController.view.frame = _mainView.bounds;
    _debugViewController.view.frame  = _bottomView.bounds;
    _fileViewController.view.frame   = _leftView.bounds;
    
    _editorViewController.view.autoresizingMask = resizingMask;
    _debugViewController.view.autoresizingMask  = resizingMask;
    _fileViewController.view.autoresizingMask   = resizingMask;
    
    editorHUD  = [ [ [ CEHUDView alloc ] initWithFrame: NSMakeRect( 100, 100, 200, 50 ) ] autorelease ];
    consoleHUD = [ [ [ CEHUDView alloc ] initWithFrame: NSMakeRect( 100, 100, 200, 50 ) ] autorelease ];
    
    editorHUD.title  = L10N( "NoEditor" );
    consoleHUD.title = L10N( "NoConsole" );
    
    [ _mainView   addSubview: editorHUD ];
    [ _bottomView addSubview: consoleHUD ];
    
    [ editorHUD centerInSuperview ];
    [ consoleHUD centerInSuperview ];
    
    editorHUD.autoresizingMask  = NSViewMinXMargin
                                | NSViewMaxXMargin
                                | NSViewMinYMargin
                                | NSViewMaxYMargin;
    consoleHUD.autoresizingMask = NSViewMinXMargin
                                | NSViewMaxXMargin
                                | NSViewMinYMargin
                                | NSViewMaxYMargin;
    
    [ _leftView addSubview: _fileViewController.view ];
    
    _documents = [ [ NSMutableArray alloc ] initWithCapacity: 10 ];
    
    [ self.window setContentBorderThickness: ( CGFloat )29 forEdge: NSMinYEdge ];
    
    {
        NSRect          badgeRect;
        CEWindowBadge * badge;
        
        badgeRect              = NSMakeRect( self.window.frame.size.width - 230, self.window.frame.size.height - 20, 200, 20 );
        badge                  = [ [ CEWindowBadge alloc ] initWithFrame: badgeRect ];
        badge.autoresizingMask = NSViewMinXMargin | NSViewMinYMargin;
        
        [ badge setTitle: L10N( "NotRegistered" ) ];
        [ badge setTarget: [ CEApplicationDelegate sharedInstance ] ];
        [ badge setAction: @selector( showRegistrationWindow: ) ];
        
        [ ( ( NSView * )self.window.contentView ).superview addSubview: badge ];
        
        [ badge release ];
        
        badgeRect              = NSMakeRect( 70, self.window.frame.size.height - 20, 150, 20 );
        badge                  = [ [ CEWindowBadge alloc ] initWithFrame: badgeRect ];
        badge.autoresizingMask = NSViewMaxXMargin | NSViewMinYMargin;
        
        [ badge setTitle: [ NSString stringWithFormat: @"Beta version - %@", [ [ BUNDLE objectForInfoDictionaryKey: NSBundleInfoKeyCFBundleVersion ] uppercaseString ] ] ];
        
        [ ( ( NSView * )self.window.contentView ).superview addSubview: badge ];
        
        [ badge release ];
    }
}

- ( void )showWindow: ( id )sender
{
    [ super showWindow: sender ];
    
    if( _documents.count == 0 )
    {
        dispatch_after
        (
            dispatch_time( DISPATCH_TIME_NOW, 250 * NSEC_PER_MSEC ),
            dispatch_get_main_queue(),
            ^( void )
            {
                [ self newDocument: sender ];
            }
        );
    }
}

- ( CESourceFile * )sourceFile
{
    @synchronized( self )
    {
        return _sourceFile;
    }
}

- ( void )setSourceFile: ( CESourceFile * )sourceFile
{
    @synchronized( self )
    {
        if( sourceFile != _sourceFile )
        {
            RELEASE_IVAR( _sourceFile );
            
            _sourceFile = [ sourceFile retain ];
            
            if( _editorViewController.sourceFile != sourceFile )
            {
                _editorViewController.sourceFile = sourceFile;
            }
            
            [ _editorViewController.view removeFromSuperview ];
            [ _debugViewController.view  removeFromSuperview ];;
            
            [ _mainView   addSubview: _editorViewController.view ];
            [ _bottomView addSubview: _debugViewController.view ];
        }
    }
}

- ( IBAction )newDocument: ( id )sender
{
    ( void )sender;
    
    [ self showLanguageWindow ];
}

- ( IBAction )saveDocument: ( id )sender
{
    ( void )sender;
    
    NSLog( @"Save document..." );
}

- ( IBAction )addBookmark: ( id )sender
{
    [ _fileViewController addBookmark: sender ];
}

- ( IBAction )removeBookmark: ( id )sender
{
    [ _fileViewController removeBookmark: sender ];
}

- ( IBAction )clearConsole: ( id )sender
{
    ( void )sender;
    
    NSLog( @"Clear console..." );
}

- ( NSArray * )documents
{
    @synchronized( self )
    {
        return [ NSArray arrayWithArray: _documents ];
    }
}

@end
