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

@end
