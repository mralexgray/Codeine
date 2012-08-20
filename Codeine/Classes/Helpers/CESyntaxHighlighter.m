/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CESyntaxHighlighter.h"
#import "CESyntaxHighlighter+Private.h"
#import "CEPreferences.h"

@implementation CESyntaxHighlighter

- ( id )initWithTextView: ( NSTextView * )textView sourceFile: ( CESourceFile * )sourceFile
{
    if( ( self = [ self init ] ) )
    {
        _textView   = [ textView retain ];
        _sourceFile = [ sourceFile retain ];
        _lock       = [ NSLock new ];
    }
    
    return self;
}

- ( void )dealloc
{
    [ NOTIFICATION_CENTER removeObserver: self ];
    
    RELEASE_IVAR( _textView );
    RELEASE_IVAR( _sourceFile );
    RELEASE_IVAR( _lock );
    
    [ super dealloc ];
}

- ( void )startHighlighting
{
    [ NOTIFICATION_CENTER addObserver: self selector: @selector( textDidChange: ) name: NSTextDidChangeNotification object: _textView ];
}

- ( void )stopHighlighting
{
    [ NOTIFICATION_CENTER removeObserver: self name: NSTextDidChangeNotification object: _textView ];
}

- ( void )highlight
{
    NSArray     * tokens;
    CKToken     * token;
    CKCursor    * cursor;
    CKToken     * previousToken;
    CETokenType   tokenType;
    NSUInteger    i;
    BOOL          inInclude;
    NSUInteger    preprocessorLine;
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
           _sourceFile.language != CESourceFileLanguageC
        && _sourceFile.language != CESourceFileLanguageCPP
        && _sourceFile.language != CESourceFileLanguageObjC
        && _sourceFile.language != CESourceFileLanguageObjCPP
        && _sourceFile.language != CESourceFileLanguageHeader
    )
    {
        [ _textView.textStorage addAttribute: NSForegroundColorAttributeName value: foregroundColor range: NSMakeRange( 0, _textView.textStorage.length ) ];
        
        return;
    }
    
    tokens = [ _sourceFile.translationUnit.tokens retain ];
    
    i                = 0;
    preprocessorLine = 0;
    inInclude        = NO;
    
    for( token in tokens )
    {
        previousToken = ( i == 0 ) ? nil : [ tokens objectAtIndex: i - 1 ];
        cursor        = token.cursor;
        
        i++;
        
        if( preprocessorLine != token.line )
        {
            inInclude = NO;
        }
        
        if( token.kind == CKTokenKindComment )
        {
            tokenType = CETokenTypeComment;
        }
        else if( inInclude == YES )
        {
            if( [ token.spelling characterAtIndex: 0 ] == '"' || [ token.spelling characterAtIndex: 0 ] == '>'  )
            {
                inInclude = NO;
            }
            
            tokenType = CETokenTypeString;
        }
        else if( cursor.isPreprocessing && cursor.kind == CKCursorKindMacroExpansion && cursor.kind == CKCursorKindMacroInstantiation )
        {
            tokenType = CETokenTypePreprocessor;
        }
        else if( cursor.isPreprocessing || token.line == preprocessorLine )
        {
            preprocessorLine = token.line;
            
            if( previousToken.cursor.kind == CKCursorKindInclusionDirective && [ previousToken.spelling characterAtIndex: 0 ] != '#' )
            {
                tokenType = CETokenTypeString;
                inInclude = YES;
            }
            else
            {
                tokenType = CETokenTypePreprocessor;
            }
        }
        else if( token.kind == CKTokenKindPunctuation )
        {
            if( [ token.spelling characterAtIndex: 0 ] == '#' && token.line != previousToken.line )
            {
                preprocessorLine = token.line;
                tokenType        = CETokenTypePreprocessor;
            }
            else
            {
                tokenType = CETokenTypeText;
            }
        }
        else if( token.kind == CKTokenKindKeyword )
        {
            tokenType = CETokenTypeKeyword;
        }
        else if( token.kind == CKTokenKindLiteral )
        {
            if( cursor.kind == CKCursorKindIntegerLiteral )
            {
                tokenType = CETokenTypeNumber;
            }
            else if( cursor.kind == CKCursorKindFloatingLiteral )
            {
                tokenType = CETokenTypeNumber;
            }
            else if( cursor.kind == CKCursorKindImaginaryLiteral )
            {
                tokenType = CETokenTypeNumber;
            }
            else if( cursor.kind == CKCursorKindStringLiteral )
            {
                tokenType = CETokenTypeString;
            }
            else if( cursor.kind == CKCursorKindCharacterLiteral )
            {
                tokenType = CETokenTypeString;
            }
            else if( [ token.spelling characterAtIndex: 0 ] == '"' || [ token.spelling characterAtIndex: 0 ] == '\'' )
            {
                tokenType = CETokenTypeString;
            }
            else
            {
                tokenType = CETokenTypeNumber;
            }
        }
        else if( token.cursor.isDefinition == YES || token.cursor.isDeclaration == YES )
        {
            tokenType = CETokenTypeText;
        }
        else if( token.cursor.definition != nil )
        {
            tokenType = CETokenTypeProject;
        }
        else if( token.cursor.referenced != nil || token.cursor.isStatement )
        {
            tokenType = CETokenTypePredefined;
        }
        else
        {
            tokenType = CETokenTypeText;
        }
        
        switch( tokenType )
        {
            case CETokenTypeComment:
                
                [ _textView.layoutManager addTemporaryAttribute: NSForegroundColorAttributeName value: commentColor forCharacterRange: token.range ];
                break;
                
            case CETokenTypeKeyword:
                
                [ _textView.layoutManager addTemporaryAttribute: NSForegroundColorAttributeName value: keywordColor forCharacterRange: token.range ];
                break;
                
            case CETokenTypeNumber:
                
                [ _textView.layoutManager addTemporaryAttribute: NSForegroundColorAttributeName value: numberColor forCharacterRange: token.range ];
                break;
                
            case CETokenTypePredefined:
                
                [ _textView.layoutManager addTemporaryAttribute: NSForegroundColorAttributeName value: predefinedColor forCharacterRange: token.range ];
                break;
                
            case CETokenTypePreprocessor:
                
                [ _textView.layoutManager addTemporaryAttribute: NSForegroundColorAttributeName value: preprocessorColor forCharacterRange: token.range ];
                break;
                
            case CETokenTypeProject:
                
                [ _textView.layoutManager addTemporaryAttribute: NSForegroundColorAttributeName value: projectColor forCharacterRange: token.range ];
                break;
                
            case CETokenTypeString:
                
                [ _textView.layoutManager addTemporaryAttribute: NSForegroundColorAttributeName value: stringColor forCharacterRange: token.range ];
                break;
                
            case CETokenTypeText:
                
                [ _textView.layoutManager addTemporaryAttribute: NSForegroundColorAttributeName value: foregroundColor forCharacterRange: token.range ];
                break;
                
            default:
                
                [ _textView.layoutManager addTemporaryAttribute: NSForegroundColorAttributeName value: foregroundColor forCharacterRange: token.range ];
                break;
        }
    }
    
    [ tokens release ];
}

@end
