/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEEditorLayoutManager.h"
#import "CEEditorLayoutManager+Private.h"
#import "CEPreferences.h"

@implementation CEEditorLayoutManager

@synthesize showInvisibles          = _showInvisibles;

- ( id )init
{
    if( ( self = [ super init ] ) )
    {
        _textView = [ [ NSTextView alloc ] initWithFrame: CGRectMake( ( CGFloat )0, ( CGFloat )0, ( CGFloat )800, ( CGFloat )600 ) ];
    }
    
    return self;
}

- ( void )dealloc
{
    RELEASE_IVAR( _textView );
    
    [ super dealloc ];
}

- ( NSSize )glyphSize
{
    @synchronized( self )
    {
        [ self updateDummyTextView ];
        
        return _glyphSize;
    }
}

- ( CGFloat )firstGlyphLeftMargin
{
    @synchronized( self )
    {
        [ self updateDummyTextView ];
        
        return _firstGlyphLeftMargin;
    }
}

- ( void )drawGlyphsForGlyphRange: ( NSRange )range atPoint: ( NSPoint )origin
{
    NSString      * text;
    NSUInteger      length;
    NSUInteger      i;
    unichar         c;
    NSRect          rect;
    NSColor       * color;
    CGFloat         size;
    NSRect          glyphRect;
    
    if( _showInvisibles )
    {
        color = [ [ CEPreferences sharedInstance ] invisibleColor ];
        text  = [ [ self textStorage ] string ];
        
        if( text.length > 0 )
        {
            length = NSMaxRange( range );
            size   = ( CGFloat )0;
            
            for( i = range.location; i < length; i++ )
            {
                c = [ text characterAtIndex: i ];
                
                if( c == '\t' || c == '\n' || c == ' ' )
                {
                    rect = [ self boundingRectForGlyphRange: NSMakeRange( i, 1 ) inTextContainer: [ self.textContainers objectAtIndex: 0 ] ];
                    
                    if( c == '\n' && i != 0 )
                    {
                        {
                            unichar previousChar;
                            NSRect  previousGlyphRect;
                            
                            previousChar      = [ text characterAtIndex: i - 1 ];
                            previousGlyphRect = [ self boundingRectForGlyphRange: NSMakeRange( i - 1, 1 ) inTextContainer: [ self.textContainers objectAtIndex: 0 ] ];
                            
                            if( CGFLOAT_EQUAL( previousGlyphRect.origin.y, rect.origin.y ) )
                            {
                                rect.origin.x = previousGlyphRect.origin.x + self.glyphSize.width;
                            }
                            
                            if( previousChar == '\t' )
                            {
                                rect.origin.x += self.glyphSize.width * ( CGFloat )3;
                            }
                        }
                    }
                    
                    rect.size.width  = self.glyphSize.width;
                    rect.size.height = self.glyphSize.height;
                    
                    if( rect.origin.x < self.firstGlyphLeftMargin )
                    {
                        rect.origin.x = self.firstGlyphLeftMargin;
                    }
                    
                    if( rect.size.width > rect.size.height )
                    {
                        glyphRect = NSMakeRect
                        (
                            rect.origin.y + ( ( rect.size.width - rect.size.height ) / ( CGFloat )2 ),
                            rect.origin.y,
                            rect.size.height,
                            rect.size.height
                        );
                    }
                    else
                    {
                        glyphRect = NSMakeRect
                        (
                            rect.origin.x,
                            rect.origin.y + ( ( rect.size.height - rect.size.width ) / ( CGFloat )2 ),
                            rect.size.width,
                            rect.size.width
                        );
                    }
                    
                    glyphRect = NSInsetRect( glyphRect, ( CGFloat )1, ( CGFloat )1 );
                    
                    if( c == ' ' )
                    {
                        {
                            NSBezierPath  * path;
                            
                            path = [ NSBezierPath bezierPath ];
                            
                            [ path appendBezierPathWithOvalInRect: glyphRect ];
                            
                            [ color set ];
                            [ path stroke ];
                        }
                    }
                    else if( c == '\t' )
                    {
                        {
                            NSPoint         p1;
                            NSPoint         p2;
                            NSPoint         p3;
                            NSBezierPath  * path;
                            
                            p1 = NSMakePoint( glyphRect.origin.x, glyphRect.origin.y );
                            p2 = NSMakePoint( glyphRect.origin.x + glyphRect.size.width, glyphRect.origin.y + ( glyphRect.size.height / ( CGFloat )2 ) );
                            p3 = NSMakePoint( glyphRect.origin.x, glyphRect.origin.y + glyphRect.size.height );
                            
                            path = [ NSBezierPath bezierPath ];
                            
                            [ path moveToPoint: p1 ];
                            [ path lineToPoint: p2 ];
                            [ path lineToPoint: p3 ];
                            [ path closePath ];
                            
                            [ color set ];
                            [ path fill ];
                        }
                    }
                    else if( c == '\n' )
                    {
                        {
                            NSBezierPath  * path;
                            NSPoint         p1;
                            NSPoint         p2;
                            NSPoint         p3;
                            NSPoint         p4;
                            NSPoint         p5;
                            NSPoint         p6;
                            
                            path = [ NSBezierPath bezierPath ];
                            
                            p1 = NSMakePoint( glyphRect.origin.x, glyphRect.origin.y );
                            p2 = NSMakePoint( glyphRect.origin.x + glyphRect.size.width, glyphRect.origin.y );
                            p3 = NSMakePoint( glyphRect.origin.x + glyphRect.size.width, glyphRect.origin.y + glyphRect.size.height );
                            p4 = NSMakePoint( glyphRect.origin.x + ( glyphRect.size.width / ( CGFloat )2 ), glyphRect.origin.y + glyphRect.size.height );
                            p5 = NSMakePoint( glyphRect.origin.x + ( glyphRect.size.width / ( CGFloat )2 ), glyphRect.origin.y + ( glyphRect.size.height / ( CGFloat )2 ) );
                            p6 = NSMakePoint( glyphRect.origin.x, glyphRect.origin.y + ( glyphRect.size.height / ( CGFloat )2 ) );
                            
                            [ path moveToPoint: p1 ];
                            [ path lineToPoint: p2 ];
                            [ path lineToPoint: p3 ];
                            [ path lineToPoint: p4 ];
                            [ path lineToPoint: p5 ];
                            [ path lineToPoint: p6 ];
                            [ path closePath ];
                            
                            [ color set ];
                            [ path fill ];
                        }
                    }
                }
            }
        }
    }
    
    [ super drawGlyphsForGlyphRange: range atPoint: origin ];
}

@end
