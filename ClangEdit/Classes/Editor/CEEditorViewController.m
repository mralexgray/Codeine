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

@implementation CEEditorViewController

@synthesize textView = _textView;

- ( void )dealloc
{
    [ NOTIFICATION_CENTER removeObserver: self ];
    
    RELEASE_IVAR( _textView );
    RELEASE_IVAR( _sourceFile );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    [ NOTIFICATION_CENTER addObserver: self selector: @selector( updateView ) name: CEPreferencesNotificationValueChanged object: nil ];
    
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
