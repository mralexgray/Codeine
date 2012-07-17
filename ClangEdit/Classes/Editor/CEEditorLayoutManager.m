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
    NSString  * text;
    NSUInteger  length;
    NSUInteger  i;
    unichar     c;
    NSPoint     point;
    NSRect      rect;
    NSRange     effectiveRange;
    
    if( _showInvisibles )
    {
        text = [ [ self textStorage ] string ];
        
        if( text.length > 0 )
        {
            length = NSMaxRange( range );
            
            for( i = range.location; i < length; i++ )
            {
                c = [ text characterAtIndex: i ];
                
                if( c == '\t' || c == '\n' || c == ' ' )
                {
                    point  = [ self locationForGlyphAtIndex: i ];
                    rect   = [ self lineFragmentUsedRectForGlyphAtIndex: i effectiveRange: &effectiveRange ];
                    
                    rect.origin.x   = point.x;
                    rect.size.width = ( rect.size.width ) / effectiveRange.length;
                    
                    if( c == '\t' )
                    {
                        
                    }
                    else if( c == '\n' )
                    {
                        
                    }
                    else if( c == ' ' )
                    {
                        
                    }
                }
            }
        }
    }
    
    [ super drawGlyphsForGlyphRange: range atPoint: origin ];
}

@end
