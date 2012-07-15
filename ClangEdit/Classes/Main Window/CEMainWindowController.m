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
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    NSUInteger resizingMask;
    
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
    
    [ _mainView   addSubview: _editorViewController.view ];
    [ _bottomView addSubview: _debugViewController.view ];
    [ _leftView   addSubview: _fileViewController.view ];
    
    [ self.window setContentBorderThickness: ( CGFloat )29 forEdge: NSMinYEdge ];
}

- ( void )showWindow: ( id )sender
{
    [ super showWindow: sender ];
    
    if( _sourceFile == nil )
    {
        dispatch_after
        (
            dispatch_time( DISPATCH_TIME_NOW, 250 * NSEC_PER_MSEC ),
            dispatch_get_main_queue(),
            ^( void )
            {
                [ self showLanguageWindow ];
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
        }
    }
}

- ( IBAction )newDocument: ( id )sender
{
    ( void )sender;
    
    NSLog( @"New document..." );
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

@end
