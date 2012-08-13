/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEEditorViewController.h"
#import "CEEditorViewController+Private.h"
#import "CEEditorViewController+NSTextViewDelegate.h"
#import "CEPreferences.h"
#import "CEMainWindowController.h"
#import "CESourceFile.h"
#import "CEEditorLayoutManager.h"
#import "CEEditorRulerView.h"
#import "CEDocument.h"

@implementation CEEditorViewController

@synthesize textView = _textView;

- ( void )dealloc
{
    [ NOTIFICATION_CENTER removeObserver: self ];
    
    RELEASE_IVAR( _textView );
    RELEASE_IVAR( _layoutManager );
    RELEASE_IVAR( _rulerView );
    RELEASE_IVAR( _document );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    [ NOTIFICATION_CENTER addObserver: self selector: @selector( updateView ) name: CEPreferencesNotificationValueChanged object: nil ];
    [ NOTIFICATION_CENTER addObserver: self selector: @selector( textDidChange: ) name: NSTextDidChangeNotification object: _textView ];
    
    _textView.delegate  = self;
    _layoutManager      = [ CEEditorLayoutManager new ];
    
    [ _layoutManager setTextStorage: _textView.textStorage ];
    [ _textView.textContainer replaceLayoutManager: _layoutManager ];
    [ _layoutManager addTextContainer: _textView.textContainer ];
    [ _textView.textContainer setLayoutManager: _layoutManager ];
    
    [ self updateView ];
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
    CEMainWindowController * controller;
    
    @synchronized( self )
    {
        if( document != _document )
        {
            RELEASE_IVAR( _document );
            
            _document  = [ document retain ];
            controller = ( CEMainWindowController * )self.view.window.windowController;
            
            if( controller.activeDocument != document )
            {
                controller.activeDocument = document;
            }
            
            _textView.string = document.sourceFile.text;
            
            [ self highlightSyntax ];
        }
    }
}

@end
