/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "NSTextView+CE.h"

@implementation NSTextView( CE )

- ( NSUInteger )numberOfHardLines
{
    NSString * text;
    NSUInteger textLength;
    NSUInteger numberOfLines;
    NSUInteger i;
    
    text          = self.textStorage.string;
    textLength    = text.length;
    numberOfLines = 0;
    
    for( i = 0; i < textLength; numberOfLines++ )
    {
        i = NSMaxRange( [ text lineRangeForRange: NSMakeRange( i, 0 ) ] );
    }
    
    return numberOfLines;
}

- ( NSUInteger )numberOfSoftLines
{
    NSUInteger numberOfGlyphs;
    NSUInteger numberOfLines;
    NSUInteger i;
    NSRange    range;
    
    numberOfGlyphs = self.layoutManager.numberOfGlyphs;
    numberOfLines  = 0;
    range.location = 0;
    range.length   = 0;
    
    for( i = 0; i < numberOfGlyphs; numberOfLines++ )
    {
        [ self.layoutManager lineFragmentRectForGlyphAtIndex: i effectiveRange: &range ];
        
        i = NSMaxRange( range );
    }
    
    return numberOfLines;
}

- ( void )enableSoftWrap
{}

- ( void )disableSoftWrap
{
    [ self.textContainer setContainerSize:NSMakeSize( CGFLOAT_MAX, CGFLOAT_MAX ) ];
    [ self.textContainer setWidthTracksTextView: NO ];
    [ self setHorizontallyResizable: YES ];
}

- ( NSInteger )currentLine
{
            NSRange    range;
            NSRange    lineRange;
            NSString * text;
    __block BOOL       found;
    __block NSInteger  line;
    
    text  = self.textStorage.string;
    range = self.selectedRange;
    found = NO;
    line  = 0;
    
    if( range.length == 0 )
    {
        lineRange = [ text lineRangeForRange: range ];
        
        [ text  enumerateSubstringsInRange: NSMakeRange( 0, text.length )
                options:                    NSStringEnumerationByLines
                usingBlock:                 ^( NSString * substring, NSRange substringRange, NSRange enclosingRange, BOOL * stop )
                {
                    ( void )substring;
                    ( void )enclosingRange;
                    
                    if( substringRange.location == lineRange.location )
                    {
                        *( stop ) = YES;
                        found     = YES;
                    }
                    
                    line++;
                }
        ];
    }
    
    return ( found == YES ) ? line : NSNotFound;
}

- ( NSInteger )currentColumn
{
    NSRange    range;
    NSRange    lineRange;
    NSString * text;
    
    text  = self.textStorage.string;
    range = self.selectedRange;
    
    if( range.length == 0 )
    {
        lineRange = [ text lineRangeForRange: range ];
        
        return ( NSInteger )( ( range.location - lineRange.location ) + 1 );
    }
    
    return NSNotFound;
}

@end
