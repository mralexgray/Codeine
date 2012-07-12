/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEEditorLayoutManager.h"

@implementation CEEditorLayoutManager

@synthesize showInvisibles = _showInvisibles;

- ( void )drawGlyphsForGlyphRange: ( NSRange )range atPoint: ( NSPoint )origin
{
    NSTextView * textView;
    NSFont     * font;
    NSGlyph      space;
    NSGlyph      tab;
    NSGlyph      lineBreak;
    NSUInteger   i;
    NSUInteger   charIndex;
    unichar      c;
    
    if( _showInvisibles == YES )
    {
        textView = [ self firstTextView ];
        font     = [ [ textView typingAttributes ] objectForKey:NSFontAttributeName ];
        
        space     = [ font glyphWithName: @"lozenge" ];
        tab       = [ font glyphWithName: @"Delta" ];
        lineBreak = [ font glyphWithName: @"logicalnot" ];
        
        for( i = range.location; i != range.location + range.length; i++ )
        {
            charIndex   = [ self characterIndexForGlyphAtIndex: i ];
            c           = [ self.textStorage.string characterAtIndex: charIndex ];
            
            switch( c )
            {
                case ' ':
                    
                    [ self replaceGlyphAtIndex: charIndex withGlyph: space ];
                    break;
                    
                case '\t':
                    
                    [ self replaceGlyphAtIndex: charIndex withGlyph: tab ];
                    break;
                    
                case '\r':
                case '\n':
                    
                    [ self replaceGlyphAtIndex: charIndex withGlyph: lineBreak ];
                    break;
                    
                default:
                    
                    break;
            }
        }
    }
    
    [ super drawGlyphsForGlyphRange: range atPoint: origin ];
}

@end
