/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEEditorTextView+Private.h"
#import "CEPreferences.h"
#import "CEEditorLayoutManager.h"

@implementation CEEditorTextView( Private )

- ( void )drawPageGuideInRect: ( NSRect )rect
{
    CGFloat     margin;
    CGSize      size;
    NSRect      lineRect;
    NSColor   * backgroundColor;
    NSColor   * color;
    CGFloat     h;
    CGFloat     s;
    CGFloat     b;
    
    margin = [ ( CEEditorLayoutManager * )( self.layoutManager ) firstGlyphLeftMargin ];
    size   = [ ( CEEditorLayoutManager * )( self.layoutManager ) glyphSize ];
    
    h               = ( CGFloat )0;
    s               = ( CGFloat )0;
    b               = ( CGFloat )0;
    backgroundColor = [ [ [ CEPreferences sharedInstance ] backgroundColor ] colorUsingColorSpaceName: NSDeviceRGBColorSpace ];
    
    [ backgroundColor getHue: &h saturation: &s brightness: &b alpha: NULL ];
    
    if( b < ( CGFloat )0.5 )
    {
        color = [ NSColor colorWithDeviceHue: h saturation: s brightness: b + ( CGFloat )0.2 alpha: 1 ];
    }
    else
    {
        color = [ NSColor colorWithDeviceHue: h saturation: s brightness: b - ( CGFloat )0.2 alpha: 1 ];
    }
    
    lineRect            = rect;
    lineRect.origin.x   = margin + ( size.width * ( CGFloat )80 );
    lineRect.size.width = ( CGFloat )1;
    
    [ color setFill ];
    
    NSRectFill( lineRect );
    
    if( b < ( CGFloat )0.5 )
    {
        color = [ NSColor colorWithDeviceHue: h saturation: s brightness: b + ( CGFloat )0.015 alpha: 1 ];
    }
    else
    {
        color = [ NSColor colorWithDeviceHue: h saturation: s brightness: b - ( CGFloat )0.015 alpha: 1 ];
    }
    
    rect.origin.x    = lineRect.origin.x + lineRect.size.width;
    rect.size.width -= lineRect.origin.x + lineRect.size.width;
    
    [ color setFill ];
    
    NSRectFill( rect );
}

- ( void )drawTabStopsInRect: ( NSRect )rect
{
    CGFloat     margin;
    CGSize      size;
    CGFloat     h;
    CGFloat     s;
    CGFloat     b;
    NSUInteger  count;
    NSRect      tabRect;
    NSRect      lineRect;
    NSColor   * color;
    NSColor   * backgroundColor;
    
    margin = [ ( CEEditorLayoutManager * )( self.layoutManager ) firstGlyphLeftMargin ];
    size   = [ ( CEEditorLayoutManager * )( self.layoutManager ) glyphSize ];
    
    h               = ( CGFloat )0;
    s               = ( CGFloat )0;
    b               = ( CGFloat )0;
    backgroundColor = [ [ [ CEPreferences sharedInstance ] backgroundColor ] colorUsingColorSpaceName: NSDeviceRGBColorSpace ];
    
    [ backgroundColor getHue: &h saturation: &s brightness: &b alpha: NULL ];
    
    if( b < ( CGFloat )0.5 )
    {
        color = [ NSColor colorWithDeviceHue: h saturation: s brightness: b + ( CGFloat )0.035 alpha: 1 ];
    }
    else
    {
        color = [ NSColor colorWithDeviceHue: h saturation: s brightness: b - ( CGFloat )0.035 alpha: 1 ];
    }
    
    tabRect = NSMakeRect
    (
        margin,
        0,
        size.width * ( CGFloat )4,
        size.height
    );
    
    [ color setFill ];
    
    count = 0;
    
    while( tabRect.origin.x < rect.size.width )
    {
        if( count != 20 || [ [ CEPreferences sharedInstance ] showPageGuide ] == NO )
        {
            lineRect = NSMakeRect( tabRect.origin.x, rect.origin.y, ( CGFloat )1, rect.size.height );
            
            NSRectFill( lineRect );
        }
        
        tabRect.origin.x += tabRect.size.width;
        
        count++;
    }
}

- ( NSRect )drawRectForRange: ( NSRange )range
{
    NSString  * text;
    NSRange     startRange;
    NSRange     endRange;
    NSUInteger  end;
    NSRange     glyphRange;
    NSRect      boundingRect;
    CGFloat     y;
    CGFloat     w;
    CGFloat     h;
    
    text       = self.textStorage.string;
    startRange = [ text lineRangeForRange: NSMakeRange( range.location, 0 ) ];
    end        = NSMaxRange( range ) - 1;
    
    if( end >= text.length )
    {
        return NSZeroRect;
    }
    
    if( end < range.location )
    {
        end = range.location;
    }
    
    endRange     = [ text lineRangeForRange: NSMakeRange( end, 0 ) ];
    glyphRange   = [ self.layoutManager glyphRangeForCharacterRange: NSMakeRange( startRange.location, ( NSMaxRange( endRange ) - startRange.location ) - 1 ) actualCharacterRange: NULL ];
    boundingRect = [ self.layoutManager boundingRectForGlyphRange: glyphRange inTextContainer: self.textContainer ];
    y            = boundingRect.origin.y;
    w            = self.bounds.size.width;
    h            = boundingRect.size.height;
    
    return NSOffsetRect( NSMakeRect( ( CGFloat )0, y, w, h ), self.textContainerOrigin.x, self.textContainerOrigin.y );
}

- ( void )drawCurrentLineHighlight: ( NSRect )rect
{
    NSString * text;
    NSRange    selection;
    NSRange    lineRange;
    
    ( void )rect;
    
    selection = self.selectedRange;
    text      = self.textStorage.string;
    
    if( selection.length > 0 )
    {
        return;
    }
    
    if( selection.location <= text.length )
    {
        lineRange = [ text lineRangeForRange: NSMakeRange( selection.location, 0 ) ];
        
        [ [ [ CEPreferences sharedInstance ] currentLineColor ] setFill ];
        
        NSRectFill( [ self drawRectForRange: lineRange ] );
    }
}

- ( void )selectionDidChange: ( NSNotification * )notification
{
    ( void )notification;
    
    [ self setNeedsDisplay: YES ];
}

@end
