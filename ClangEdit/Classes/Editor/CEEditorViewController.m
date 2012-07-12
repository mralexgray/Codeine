/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEEditorViewController.h"
#import "CEEditorViewController+Private.h"
#import "CEPreferences.h"
#import "CEMainWindowController.h"
#import "CESourceFile.h"
#import "CEEditorLayoutManager.h"

@implementation CEEditorViewController

@synthesize textView = _textView;

- ( void )dealloc
{
    [ NOTIFICATION_CENTER removeObserver: self ];
    
    RELEASE_IVAR( _textView );
    RELEASE_IVAR( _sourceFile );
    RELEASE_IVAR( _layoutManager );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    [ NOTIFICATION_CENTER addObserver: self selector: @selector( updateView ) name: CEPreferencesNotificationValueChanged object: nil ];
    
    _layoutManager = [ CEEditorLayoutManager new ];
    
    [ _layoutManager setTextStorage: _textView.textStorage ];
    [ _textView.textContainer replaceLayoutManager: _layoutManager ];
    [ _layoutManager addTextContainer: _textView.textContainer ];
    [ _textView.textContainer setLayoutManager: _layoutManager ];
    
    [ self updateView ];
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
    CEMainWindowController * controller;
    
    @synchronized( self )
    {
        if( sourceFile != _sourceFile )
        {
            RELEASE_IVAR( _sourceFile );
            
            _sourceFile = [ sourceFile retain ];
            controller  = ( CEMainWindowController * )self.view.window.windowController;
            
            if( controller.sourceFile != sourceFile )
            {
                controller.sourceFile = sourceFile;
            }
            
            _textView.string = _sourceFile.text;
        }
    }
}

@end
