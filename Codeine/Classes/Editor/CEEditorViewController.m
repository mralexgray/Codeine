
/* $Id$ */

#import "CEEditorViewController.h"
#import "CEEditorViewController+Private.h"
#import "CEEditorViewController+NSTextViewDelegate.h"
#import "CEEditorViewController+CEEditorTextViewDelegate.h"
#import "CEPreferences.h"
#import "CEMainWindowController.h"
#import "CESourceFile.h"
#import "CEEditorLayoutManager.h"
#import "CEEditorRulerView.h"
#import "CEDocument.h"
#import "CESyntaxHighlighter.h"
#import "CECodeCompletionViewController.h"

@implementation CEEditorViewController

@synthesize textView = _textView;

- ( void )dealloc
{
    [ NOTIFICATION_CENTER removeObserver: self ];
    [ [ _textView enclosingScrollView ] setVerticalRulerView: nil ];
    
    RELEASE_IVAR( _layoutManager );
    RELEASE_IVAR( _document );
    RELEASE_IVAR( _highlighter );
    RELEASE_IVAR( _rulerView );
    RELEASE_IVAR( _codeCompletionViewController );
    
}

- ( void )awakeFromNib
{
    [ NOTIFICATION_CENTER addObserver: self selector: @selector( updateView ) name: CEPreferencesNotificationValueChanged object: nil ];
    
    _textView.delegate  = self;
    _layoutManager      = [ CEEditorLayoutManager new ];
    
    [ _layoutManager setTextStorage: _textView.textStorage ];
    [ _textView.textContainer replaceLayoutManager: _layoutManager ];
    [ _layoutManager addTextContainer: _textView.textContainer ];
    [ _textView.textContainer setLayoutManager: _layoutManager ];
    
    [ NOTIFICATION_CENTER addObserver: self selector: @selector( selectionDidChange: ) name: NSTextViewDidChangeSelectionNotification object: _textView ];
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
            RELEASE_IVAR( _highlighter );
            
            _document           = document;
            _rulerView.document = _document;
            controller          = ( CEMainWindowController * )self.view.window.windowController;
            
            if( controller.activeDocument != document )
            {
                controller.activeDocument = document;
            }
            
            _highlighter = [ [ CESyntaxHighlighter alloc ] initWithTextView: _textView sourceFile: document.sourceFile ];
            
            [ _highlighter startHighlighting ];
            
            _textView.string = document.sourceFile.text;
            
            [ _highlighter highlight ];
        }
    }
}

@end
