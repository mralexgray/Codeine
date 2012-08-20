/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEEditorViewController+Private.h"
#import "CEPreferences.h"
#import "CEEditorLayoutManager.h"
#import "CEEditorRulerView.h"
#import "CEDocument.h"
#import "CESourceFile.h"
#import "CESyntaxHighlighter.h"
#import "CECodeCompletionViewController.h"

@implementation CEEditorViewController( Private )

- ( void )updateView
{
    NSFont                  * font;
    NSDictionary            * selectionAttributes;
    NSMutableParagraphStyle * paragraphStyle;
    
    _layoutManager.showInvisibles = [ [ CEPreferences sharedInstance ] showInvisibles ];
    _layoutManager.showSpaces     = [ [ CEPreferences sharedInstance ] showSpaces ];
    
    font = [ NSFont fontWithName: [ [ CEPreferences sharedInstance ] fontName ] size: [ [ CEPreferences sharedInstance ] fontSize ] ];
    
    _textView.font                = font;
    _textView.backgroundColor     = [ [ CEPreferences sharedInstance ] backgroundColor ];
    _textView.textColor           = [ [ CEPreferences sharedInstance ] foregroundColor ];
    _textView.insertionPointColor = [ [ CEPreferences sharedInstance ] foregroundColor ];
    
    selectionAttributes = [ NSDictionary dictionaryWithObjectsAndKeys:  [ [ CEPreferences sharedInstance ] selectionColor ],  NSBackgroundColorAttributeName,
                                                                        [ [ CEPreferences sharedInstance ] foregroundColor ], NSForegroundColorAttributeName,
                                                                        nil
                          ];
    
    [ _textView setSelectedTextAttributes: selectionAttributes ];
    
    if( [ [ CEPreferences sharedInstance ] showLineNumbers ] == YES )
    {
        if( _rulerView == nil )
        {
            _rulerView          = [ CEEditorRulerView new ];
            _rulerView.document = _document;
        }
        
        [ [ _textView enclosingScrollView ] setVerticalRulerView: _rulerView ];
        [ [ _textView enclosingScrollView ] setHasHorizontalRuler: NO ];
        [ [ _textView enclosingScrollView ] setHasVerticalRuler: YES ];
        [ [ _textView enclosingScrollView ] setRulersVisible: YES ];
    
        [ _rulerView setScrollView: [ _textView enclosingScrollView ] ];
        [ _rulerView setClientView: _textView ];
    }
    else
    {
        [ [ _textView enclosingScrollView ] setVerticalRulerView: nil ];
        [ [ _textView enclosingScrollView ] setHasHorizontalRuler: NO ];
        [ [ _textView enclosingScrollView ] setHasVerticalRuler: NO ];
        [ [ _textView enclosingScrollView ] setRulersVisible: NO ];
    }
    
    paragraphStyle = [ [ [ NSParagraphStyle defaultParagraphStyle ] mutableCopy ] autorelease ];
    
    [ paragraphStyle setTabStops: [ NSArray array ] ];
    [ paragraphStyle setDefaultTabInterval: ( ( CEEditorLayoutManager * )( _textView.layoutManager ) ).glyphSize.width * ( CGFloat )[ [ CEPreferences sharedInstance ] tabWidth ] ];
    
    [ _textView setDefaultParagraphStyle: paragraphStyle ];
    
    [ _textView.textStorage enumerateAttributesInRange: NSMakeRange( 0, _textView.string.length )
                            options:                    NSAttributedStringEnumerationReverse
                            usingBlock:                 ^( NSDictionary * attributes, NSRange range, BOOL * stop )
                            {
                                NSMutableDictionary * newAttributes;
                                
                                ( void )stop;
                                
                                newAttributes = [ NSMutableDictionary dictionaryWithDictionary: attributes ];
                                
                                [ newAttributes setObject: paragraphStyle forKey: NSParagraphStyleAttributeName ];
                                [ _textView.textStorage setAttributes: newAttributes range: range ];
                            }
    ];
    
    [ _highlighter highlight ];
}

- ( void )selectionDidChange: ( NSNotification * )notification
{
    ( void )notification;
    
    [ self showAutoCompletionDelayed: YES ];
}

- ( void )showAutoCompletion
{
    [ self showAutoCompletionDelayed: NO ];
}

- ( void )showAutoCompletionDelayed: ( BOOL )delayed
{
    dispatch_async
    (
        dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0 ),
        ^( void )
        {
            @synchronized( self )
            {
                NSUInteger           line;
                NSUInteger           column;
                NSArray            * results;
                NSRect               rect;
                
                [ _codeCompletionViewController cancelOpening ];
                [ _codeCompletionViewController closePopover ];
                
                RELEASE_IVAR( _codeCompletionViewController );
                
                line   = ( NSUInteger )( _textView.currentLine );
                column = ( NSUInteger )( _textView.currentColumn );
                
                if( line == NSNotFound || column == NSNotFound )
                {
                    return;
                }
                
                results = [ _document.sourceFile.translationUnit completionResultsForLine: line column: column ];
                
                if( results.count > 0 || delayed == NO )
                {
                    _codeCompletionViewController = [ [ CECodeCompletionViewController alloc ] initWithCompletionResults: results ];
                    
                    rect            = [ _textView.layoutManager boundingRectForGlyphRange: _textView.selectedRange inTextContainer: _textView.textContainer ];
                    rect.size.width = ( CGFloat )1;
                    
                    dispatch_sync
                    (
                        dispatch_get_main_queue(),
                        ^( void )
                        {
                            [ _codeCompletionViewController openInPopoverRelativeToRect: rect ofView: _textView preferredEdge: NSMaxYEdge delay: delayed ];
                        }
                    );
                }
            }
        }
    );
}

@end
