/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEEditorTextView+Private.h"
#import "CEPreferences.h"

@implementation CEEditorTextView( Private )

- ( void )drawPageGuideInRect: ( NSRect )rect
{
    NSUInteger  count;
    NSRectArray rectArray;
    NSRect      lineRect;
    NSColor   * backgroundColor;
    NSColor   * color;
    CGFloat     h;
    CGFloat     s;
    CGFloat     b;
    
    rectArray = [ self.layoutManager rectArrayForCharacterRange: NSMakeRange( 0, 80 ) withinSelectedCharacterRange: NSMakeRange( 0, 0 ) inTextContainer: self.textContainer rectCount: &count ];
    
    if( rectArray == NULL || count == 0 )
    {
        return;
    }
    
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
    lineRect.origin.x   = rectArray[ 0 ].size.width + rectArray[ 0 ].origin.x;
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
    NSUInteger  count;
    NSRectArray rectArray;
    NSRect      tabRect;
    NSRect      lineRect;
    CGFloat     textOrigin;
    CGFloat     tabWidth;
    NSColor   * backgroundColor;
    NSColor   * color;
    CGFloat     h;
    CGFloat     s;
    CGFloat     b;
    
    rectArray = [ self.layoutManager rectArrayForCharacterRange: NSMakeRange( 0, 4 ) withinSelectedCharacterRange: NSMakeRange( 0, 0 ) inTextContainer: self.textContainer rectCount: &count ];
    
    if( rectArray == NULL || count == 0 )
    {
        return;
    }
    
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
    
    tabRect     = rectArray[ 0 ];
    textOrigin  = tabRect.origin.x;
    tabWidth    = tabRect.size.width;
    
    [ color setFill ];
    
    count = 0;
    
    while( tabRect.origin.x < rect.size.width )
    {
        if( count != 20 )
        {
            lineRect = NSMakeRect( tabRect.origin.x, rect.origin.y, ( CGFloat )1, rect.size.height );
            
            NSRectFill( lineRect );
        }
        
        tabRect.origin.x += tabWidth;
        
        count++;
    }
}

@end
