/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEEditorRulerView.h"
#import "CEEditorRulerView+Private.h"
#import "CEEditorMarker.h"
#import "CEPreferences.h"

NSString * const CEEditorRulerViewException = @"CEEditorRulerViewException";

@implementation CEEditorRulerView

- ( void )dealloc
{
    [ NOTIFICATION_CENTER removeObserver: self ];
    
    RELEASE_IVAR( _textView );
    RELEASE_IVAR( _linesRect );
    
    [ super dealloc ];
}

- ( void )setClientView: ( NSView * )view
{
    NSException * e;
    
    [ super setClientView: view ];
    [ NOTIFICATION_CENTER removeObserver: self name: NSTextStorageDidProcessEditingNotification object: _textView.textStorage ];
    
    if( view != nil && [ view isKindOfClass: [ NSTextView class ] ] == NO )
    {
        e = [ NSException exceptionWithName: CEEditorRulerViewException reason: @"Bad client view - Kind must be NSTextView" userInfo: nil ];
        
        @throw e;
    }
    
    _textView = ( NSTextView * )[ view retain ];
    
    [ NOTIFICATION_CENTER addObserver: self selector: @selector( textStorageDidProcessEditing: ) name: NSTextStorageDidProcessEditingNotification object: _textView.textStorage ];
}

- ( void )drawRect: ( NSRect )rect
{
    NSColor      * color1;
    NSColor      * color2;
    NSGradient   * gradient;
    
    if( _hasApplicationObserver == NO )
    {
        [ NOTIFICATION_CENTER addObserver: self selector: @selector( applicationStateDidChange: ) name: NSApplicationDidBecomeActiveNotification object: APPLICATION ];
        [ NOTIFICATION_CENTER addObserver: self selector: @selector( applicationStateDidChange: ) name: NSApplicationDidResignActiveNotification object: APPLICATION ];
        
        _hasApplicationObserver = YES;
    }
    
    [ [ NSColor windowFrameColor ] setFill ];
    
    NSRectFill( rect );
    
    rect.size.width -= ( CGFloat )1;
    
    color1   = [ NSColor colorWithDeviceWhite: ( CGFloat )0.95 alpha: ( CGFloat )1 ];
    color2   = [ NSColor colorWithDeviceWhite: ( CGFloat )0.80 alpha: ( CGFloat )1 ];
    color1   = [ color1 colorUsingColorSpaceName: NSDeviceRGBColorSpace ];
    color2   = [ color2 colorUsingColorSpaceName: NSDeviceRGBColorSpace ];
    gradient = [ [ NSGradient alloc ] initWithColorsAndLocations: color1, ( CGFloat )0, color2, ( CGFloat )1, nil ];
    
    [ gradient drawInRect: rect angle: ( CGFloat )0 ];
    [ gradient release ];
    
    [ self drawHashMarksAndLabelsInRect: rect ];
}

- ( void )drawHashMarksAndLabelsInRect: ( NSRect )rect
{
    NSString                * text;
    NSTextContainer         * textContainer;
    NSMutableDictionary     * attributes;
    NSMutableParagraphStyle * paragraphStyle;
    NSFont                  * font;
    NSRange                   range;
    NSUInteger                start;
    NSUInteger                end;
    NSUInteger                contentsEnd;
    NSRectArray               rectArray;
    NSUInteger                rectCount;
    NSRange                   selectedRange;
    NSRect                    lineRect;
    NSUInteger                line;
    NSRange                   glyphRange;
    NSRect                    visibleRect;
    NSRange                   lineRange;
    CEEditorMarker          * marker;
    
    if( _textView == nil )
    {
        return;
    }
    
    text = _textView.textStorage.string;
    
    range.location  = 0;
    range.length    = 1;
    start           = 0;
    end             = 0;
    contentsEnd     = 0;
    line            = 0;
    
    selectedRange   = NSMakeRange( NSNotFound, 0 );
    textContainer   = [ _textView.layoutManager.textContainers objectAtIndex: 0 ];
    attributes      = [ NSMutableDictionary dictionaryWithCapacity: 10 ];
    font            = [ NSFont systemFontOfSize: ( CGFloat )8 ];
    paragraphStyle  = [ [ [ NSParagraphStyle defaultParagraphStyle ] mutableCopy ] autorelease ];
    
    [ paragraphStyle setAlignment: NSRightTextAlignment ];
    
    [ attributes setObject: font                   forKey: NSFontAttributeName ];
    [ attributes setObject: [ NSColor grayColor ]  forKey: NSForegroundColorAttributeName ];
    [ attributes setObject: [ NSColor clearColor ] forKey: NSBackgroundColorAttributeName ];
    [ attributes setObject: paragraphStyle         forKey: NSParagraphStyleAttributeName ];
    
    visibleRect = [ [ [ self scrollView ] contentView ] bounds ];
    glyphRange  = [ _textView.layoutManager glyphRangeForBoundingRect: visibleRect inTextContainer: textContainer ];
    
    if( text.length == 0 )
    {
        return;
    }
    
    lineRange.location = 0;
    lineRange.length   = 1;
    
    while( lineRange.location < glyphRange.location )
    {
        lineRange = [ text lineRangeForRange: lineRange ];
        
        lineRange.location = lineRange.location + lineRange.length;
        lineRange.length   = 1;
        
        line++;
    }
    
    range.location = glyphRange.location;
    
    while( range.location + range.length <= text.length )
    {
        [ text getLineStart: &start end: &end contentsEnd: &contentsEnd forRange: range ];
        
        rectCount = 0;
        rectArray = [ _textView.layoutManager rectArrayForCharacterRange: range withinSelectedCharacterRange: selectedRange inTextContainer: textContainer rectCount: &rectCount ];
        
        if( rectCount == 0 )
        {
            continue;
        }
        
        lineRect = rectArray[ 0 ];
        
        lineRect.origin.y  -= visibleRect.origin.y;
        lineRect.origin.x   = ( CGFloat )0;
        lineRect.size.width = ( CGFloat )rect.size.width - ( CGFloat )5;
        
        marker = [ self markerForLine: line ];
        
        if( marker != nil )
        {
            [ marker drawRect: NSMakeRect( lineRect.origin.x, lineRect.origin.y, lineRect.size.width + ( CGFloat )5, lineRect.size.height ) ];
            [ attributes setObject: [ NSColor whiteColor ] forKey: NSForegroundColorAttributeName ];
        }
        else
        {
            [ attributes setObject: [ NSColor grayColor ] forKey: NSForegroundColorAttributeName ];
        }
        
        [ [ NSString stringWithFormat: @"%lu", line + 1 ] drawInRect: lineRect withAttributes: attributes ];
        [ self setRect: rectArray[ 0 ] forLine: line ];
        
        range.location = end;
        
        line++;
    }
}

- ( void )mouseDown: ( NSEvent * )e
{
	NSPoint    location;
    NSUInteger line;
	
	location = [ self convertPoint: e.locationInWindow fromView: nil ];
    line     = [ self lineForPoint: location ];
    
    if( line == NSNotFound )
    {
        return;
    }
    
    if( [ self markerForLine: line ] == nil )
    {
        [ self addMarkerForLine: line ];
    }
    else
    {
        [ self removeMarkerForLine: line ];
    }
}

@end
