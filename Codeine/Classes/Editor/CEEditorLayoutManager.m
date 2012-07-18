/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEEditorLayoutManager.h"
#import "CEPreferences.h"

@implementation CEEditorLayoutManager

@synthesize showInvisibles = _showInvisibles;

- ( void )drawGlyphsForGlyphRange: ( NSRange )range atPoint: ( NSPoint )origin
{
    NSString      * text;
    NSUInteger      length;
    NSUInteger      i;
    unichar         c;
    NSPoint         point;
    NSRect          rect;
    NSRange         effectiveRange;
    NSColor       * color;
    CGFloat         size;
    
    if( _showInvisibles )
    {
        text = [ [ self textStorage ] string ];
        
        if( text.length > 0 )
        {
            length = NSMaxRange( range );
            size   = ( CGFloat )0;
            
            for( i = range.location; i < length; i++ )
            {
                c = [ text characterAtIndex: i ];
                
                if( c == '\t' || c == '\n' || c == ' ' )
                {
                    point  = [ self locationForGlyphAtIndex: i ];
                    rect   = [ self lineFragmentUsedRectForGlyphAtIndex: i effectiveRange: &effectiveRange ];
                    
                    rect.origin.x   = point.x;
                    rect.size.width = ( rect.size.width ) / effectiveRange.length;
                    
                    if( size == 0 )
                    {
                        size = MIN( rect.size.width - 2, rect.size.height - 2 );
                    }
                    
                    rect.origin.x   += ( rect.size.width  - size ) / 2;
                    rect.origin.y   += ( rect.size.height - size ) / 2;
                    rect.size.width  = size;
                    rect.size.height = size;
                    
                    color = [ [ CEPreferences sharedInstance ] invisibleColor ];
                    
                    if( c == '\t' )
                    {
                        {
                            NSPoint         p1;
                            NSPoint         p2;
                            NSPoint         p3;
                            NSBezierPath  * triangle;
                            
                            p1 = NSMakePoint( rect.origin.x, rect.origin.y + rect.size.height );
                            p2 = NSMakePoint( rect.origin.x + ( rect.size.width / ( CGFloat )2 ), rect.origin.y );
                            p3 = NSMakePoint( rect.origin.x + rect.size.width, rect.origin.y + rect.size.height );
                            
                            triangle = [ NSBezierPath bezierPath ];
                            
                            [ triangle moveToPoint: p1 ];
                            [ triangle lineToPoint: p2 ];
                            [ triangle lineToPoint: p3 ];
                            [ triangle lineToPoint: p1 ];
                            
                            [ color set ];
                            [ triangle stroke ];
                        }
                    }
                    else if( c == '\n' )
                    {
                        [ color setFill ];
                        
                        NSRectFill( rect );
                    }
                    else if( c == ' ' )
                    {
                        {
                            NSBezierPath  * path;
                            NSGradient    * gradient;
                            
                            gradient = [ [ NSGradient alloc ] initWithColorsAndLocations: color, ( CGFloat )0, nil ];
                            path     = [ NSBezierPath bezierPath ];
                            
                            [ path appendBezierPathWithOvalInRect: rect ];
                            [ path appendBezierPathWithOvalInRect: NSMakeRect( rect.origin.x + 1, rect.origin.y + 1, rect.size.width - 2, rect.size.height - 2 ) ];
                            [ path setWindingRule: NSEvenOddWindingRule ];
                            [ gradient drawInBezierPath: path angle: ( CGFloat )0 ];
                            [ gradient release ];
                        }
                    }
                }
            }
        }
    }
    
    [ super drawGlyphsForGlyphRange: range atPoint: origin ];
}

@end
