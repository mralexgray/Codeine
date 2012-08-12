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

@implementation CEEditorViewController( Private )

- ( void )updateView
{
    NSFont                  * font;
    NSDictionary            * selectionAttributes;
    NSMutableParagraphStyle * paragraphStyle;
    
    _layoutManager.showInvisibles = [ [ CEPreferences sharedInstance ] showInvisibles ];
    
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
            _rulerView = [ CEEditorRulerView new ];
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
    [ paragraphStyle setDefaultTabInterval: ( ( CEEditorLayoutManager * )( _textView.layoutManager ) ).glyphSize.width * ( CGFloat )4 ];
    
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
    
    [ self highlightSyntax ];
}

- ( void )textDidChange: ( NSNotification * )notification
{
    ( void )notification;
    
    _document.sourceFile.text = _textView.string;
    
    [ self highlightSyntax ];
}

- ( void )highlightSyntax
{
    NSArray * tokens;
    CKToken * token;
    NSColor * commentColor;
    NSColor * keywordColor;
    NSColor * numberColor;
    NSColor * stringColor;
    NSColor * predefinedColor;
    NSColor * foregroundColor;
    
    commentColor    = [ [ CEPreferences sharedInstance ] commentColor ];
    keywordColor    = [ [ CEPreferences sharedInstance ] keywordColor ];
    numberColor     = [ [ CEPreferences sharedInstance ] numberColor ];
    stringColor     = [ [ CEPreferences sharedInstance ] stringColor ];
    predefinedColor = [ [ CEPreferences sharedInstance ] predefinedColor ];
    foregroundColor = [ [ CEPreferences sharedInstance ] foregroundColor ];
    
    tokens = _document.sourceFile.translationUnit.tokens;
    
    for( token in tokens )
    {
        @try
        {
            if( token.kind == CKTokenKindComment )
            {
                [ _textView.textStorage addAttribute: NSForegroundColorAttributeName value: commentColor range: token.range ];
            }
            else if( token.kind == CKTokenKindIdentifier )
            {
                [ _textView.textStorage addAttribute: NSForegroundColorAttributeName value: predefinedColor range: token.range ];
            }
            else if( token.kind == CKTokenKindKeyword )
            {
                [ _textView.textStorage addAttribute: NSForegroundColorAttributeName value: keywordColor range: token.range ];
            }
            else if( token.kind == CKTokenKindLiteral )
            {
                [ _textView.textStorage addAttribute: NSForegroundColorAttributeName value: stringColor range: token.range ];
            }
            else
            {
                [ _textView.textStorage addAttribute: NSForegroundColorAttributeName value: foregroundColor range: token.range ];
            }
        }
        @catch( NSException * e )
        {
            ( void )e;
        }
    }
}

@end
