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

- ( void )updateText
{
    _document.sourceFile.text = _textView.string;
    
    [ self performSelectorOnMainThread: @selector( highlightSyntax ) withObject: nil waitUntilDone: NO ];
}

- ( void )textDidChange: ( NSNotification * )notification
{
    ( void )notification;
    
    [ NSThread detachNewThreadSelector: @selector( updateText ) toTarget: self withObject: nil ];
}

- ( void )highlightSyntax
{
    NSArray     * tokens;
    CKToken     * token;
    CETokenType   tokenType;
    NSColor     * commentColor;
    NSColor     * keywordColor;
    NSColor     * numberColor;
    NSColor     * stringColor;
    NSColor     * predefinedColor;
    NSColor     * projectColor;
    NSColor     * preprocessorColor;
    NSColor     * foregroundColor;
    
    commentColor        = [ [ CEPreferences sharedInstance ] commentColor ];
    keywordColor        = [ [ CEPreferences sharedInstance ] keywordColor ];
    numberColor         = [ [ CEPreferences sharedInstance ] numberColor ];
    stringColor         = [ [ CEPreferences sharedInstance ] stringColor ];
    predefinedColor     = [ [ CEPreferences sharedInstance ] predefinedColor ];
    projectColor        = [ [ CEPreferences sharedInstance ] projectColor ];
    preprocessorColor   = [ [ CEPreferences sharedInstance ] preprocessorColor ];
    foregroundColor     = [ [ CEPreferences sharedInstance ] foregroundColor ];
    
    if
    (
           _document.sourceFile.language != CESourceFileLanguageC
        && _document.sourceFile.language != CESourceFileLanguageCPP
        && _document.sourceFile.language != CESourceFileLanguageObjC
        && _document.sourceFile.language != CESourceFileLanguageObjCPP
        && _document.sourceFile.language != CESourceFileLanguageHeader
    )
    {
        [ _textView.textStorage addAttribute: NSForegroundColorAttributeName value: foregroundColor range: NSMakeRange( 0, _textView.textStorage.length ) ];
        
        return;
    }
    
    tokens = _document.sourceFile.translationUnit.tokens;
    
    [_textView.textStorage beginEditing ];
    
    for( token in tokens )
    {
        @try
        {
            tokenType = [ self tokenTypeForToken: token ];
            
            switch( tokenType )
            {
                case CETokenTypeComment:
                    
                    [ _textView.textStorage addAttribute: NSForegroundColorAttributeName value: commentColor range: token.range ];
                    break;
                    
                case CETokenTypeKeyword:
                    
                    [ _textView.textStorage addAttribute: NSForegroundColorAttributeName value: keywordColor range: token.range ];
                    break;
                    
                case CETokenTypeNumber:
                    
                    [ _textView.textStorage addAttribute: NSForegroundColorAttributeName value: numberColor range: token.range ];
                    break;
                    
                case CETokenTypePredefined:
                    
                    [ _textView.textStorage addAttribute: NSForegroundColorAttributeName value: predefinedColor range: token.range ];
                    break;
                    
                case CETokenTypePreprocessor:
                    
                    [ _textView.textStorage addAttribute: NSForegroundColorAttributeName value: preprocessorColor range: token.range ];
                    break;
                    
                case CETokenTypeProject:
                    
                    [ _textView.textStorage addAttribute: NSForegroundColorAttributeName value: projectColor range: token.range ];
                    break;
                    
                case CETokenTypeString:
                    
                    [ _textView.textStorage addAttribute: NSForegroundColorAttributeName value: stringColor range: token.range ];
                    break;
                    
                case CETokenTypeText:
                    
                    [ _textView.textStorage addAttribute: NSForegroundColorAttributeName value: foregroundColor range: token.range ];
                    break;
                    
                default:
                    
                    [ _textView.textStorage addAttribute: NSForegroundColorAttributeName value: foregroundColor range: token.range ];
                    break;
            }
        }
        @catch( NSException * e )
        {
            ( void )e;
            
            break;
        }
    }
    
    [ _textView.textStorage endEditing ];
}

- ( CETokenType )tokenTypeForToken: ( CKToken * )token
{
    CKCursor * cursor;
    
    cursor = token.cursor;
    
    if( token.kind == CKTokenKindPunctuation )
    {
        return CETokenTypeText;
    }
    if( token.kind == CKTokenKindComment )
    {
        return CETokenTypeComment;
    }
    else if( token.kind == CKTokenKindKeyword )
    {
        return CETokenTypeKeyword;
    }
    else if( token.kind == CKTokenKindLiteral )
    {
             if( cursor.kind == CKCursorKindIntegerLiteral   ) { return CETokenTypeNumber; }
        else if( cursor.kind == CKCursorKindFloatingLiteral  ) { return CETokenTypeNumber; }
        else if( cursor.kind == CKCursorKindImaginaryLiteral ) { return CETokenTypeNumber; }
        else if( cursor.kind == CKCursorKindStringLiteral    ) { return CETokenTypeString; }
        else if( cursor.kind == CKCursorKindCharacterLiteral ) { return CETokenTypeString; }
        
        return CETokenTypeNumber;
    }
    
    if( token.cursor.isDefinition == YES || token.cursor.isDeclaration == YES )
    {
        return CETokenTypeText;
    }
    else if( token.cursor.definition != nil )
    {
        return CETokenTypeProject;
    }
    else if( token.cursor.referenced != nil || token.cursor.isStatement )
    {
        return CETokenTypePredefined;
    }
    
    return CETokenTypeText;
}

@end
