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
#import "CEFileDetailsViewController.h"
#import "CESourceFile.h"
#import "CETextEncoding.h"
#import "CEPreferences.h"
#import "CEQuickLookItem.h"
#import "CEWindowBadge.h"
#import "CEApplicationDelegate.h"
#import "CEHUDView.h"
#import "CEDocument.h"

NSString * const CEMainWindowControllerDocumentsArrayKey = @"documents";

@implementation CEMainWindowController

@synthesize leftView      = _leftView;
@synthesize mainView      = _mainView;
@synthesize bottomView    = _bottomView;
@synthesize encodingPopUp = _encodingPopUp;

- ( void )dealloc
{
    RELEASE_IVAR( _fileViewController );
    RELEASE_IVAR( _editorViewController );
    RELEASE_IVAR( _debugViewController );
    RELEASE_IVAR( _fileDetailsViewController );
    RELEASE_IVAR( _leftView );
    RELEASE_IVAR( _mainView );
    RELEASE_IVAR( _bottomView );
    RELEASE_IVAR( _languageWindowController );
    RELEASE_IVAR( _encodingPopUp );
    RELEASE_IVAR( _documents );
    RELEASE_IVAR( _activeDocument );
    
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
    
    _fileViewController.mainWindowController = self;
    
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

- ( CEDocument * )activeDocument
{
    @synchronized( self )
    {
        return _activeDocument;
    }
}

- ( void )setActiveDocument: ( CEDocument * )document
{
    CEDocument * d;
    BOOL         found;
    NSUInteger   i;
    
    @synchronized( self )
    {
        if( document != _activeDocument )
        {
            RELEASE_IVAR( _activeDocument );
            
            [ _editorViewController.view removeFromSuperview ];
            [ _debugViewController.view  removeFromSuperview ];
            
            _editorViewController.view.frame = _mainView.bounds;
            _debugViewController.view.frame  = _bottomView.bounds;
            _fileViewController.view.frame   = _leftView.bounds;
            
            [ _mainView   addSubview: _editorViewController.view ];
            [ _bottomView addSubview: _debugViewController.view ];
            
            found = NO;
            i     = 0;
            
            for( d in _documents )
            {
                if( [ document isEqual: d ] == YES && document.sourceFile.text != nil )
                {
                    found = YES;
                    
                    break;
                }
                
                i++;
            }
            
            if( document.sourceFile.text != nil )
            {
                _activeDocument = [ document retain ];
                
                if( _editorViewController.document != document )
                {
                    _editorViewController.document = document;
                }
                
                if
                (
                       _activeDocument.sourceFile.language != CESourceFileLanguageC
                    && _activeDocument.sourceFile.language != CESourceFileLanguageCPP
                    && _activeDocument.sourceFile.language != CESourceFileLanguageObjC
                    && _activeDocument.sourceFile.language != CESourceFileLanguageObjCPP
                )
                {
                    [ _debugViewController.view  removeFromSuperview ];
                }
                
                if( found == NO )
                {
                    [ [ self mutableArrayValueForKey: CEMainWindowControllerDocumentsArrayKey ] insertObject: document atIndex: 0 ];
                }
            }
            else
            {
                if( _fileDetailsViewController == nil )
                {
                    _fileDetailsViewController                       = [ CEFileDetailsViewController new ];
                    _fileDetailsViewController.view.frame            = _mainView.bounds;
                    _fileDetailsViewController.view.autoresizingMask = NSViewWidthSizable
                                                                     | NSViewHeightSizable
                                                                     | NSViewMinXMargin
                                                                     | NSViewMaxXMargin
                                                                     | NSViewMinYMargin
                                                                     | NSViewMaxYMargin;
                }
                
                _fileDetailsViewController.file = document.file;
                
                [ _editorViewController.view removeFromSuperview ];
                [ _debugViewController.view  removeFromSuperview ];
                
                [ _mainView addSubview: _fileDetailsViewController.view ];
            }
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
