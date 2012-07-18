/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CELanguageWindowTableView.h"

@implementation CELanguageWindowTableView

- ( id )initWithCoder: ( NSCoder * )coder
{
    if( ( self = [ super initWithCoder: coder ] ) )
    {
        [ self.enclosingScrollView setDrawsBackground: NO ];
    }
    
    return self;
}

- ( id )initWithFrame: ( NSRect )frame
{
    if( ( self = [ super initWithFrame: frame ] ) )
    {
        [ self.enclosingScrollView setDrawsBackground: NO ];
    }
    
    return self;
}

- ( void )awakeFromNib
{
    [ self.enclosingScrollView setDrawsBackground: NO ];
}

- ( void )drawBackgroundInClipRect: ( NSRect )rect
{
    ( void )rect;
}

- ( BOOL )isOpaque
{
    return NO;
}

- ( void )highlightSelectionInClipRect: ( NSRect )rect
{
    NSRange         rows;
    NSColor       * color;
    NSIndexSet    * selectedRows;
    NSUInteger      row;
    NSUInteger      endRow;
    NSRect          rowRect;
    CGFloat         h;
    CGFloat         s;
    CGFloat         b;
    NSGradient    * gradient;
    NSBezierPath  * path;
    
    h = ( CGFloat )0;
    s = ( CGFloat )0;
    b = ( CGFloat )0;
    
    color = [ NSColor selectedControlColor ];
    color = [ color colorUsingColorSpaceName: NSDeviceRGBColorSpace ];
    
    [ color getHue: &h saturation: &s brightness: &b alpha: NULL ];
    
    if( APPLICATION.isActive )
    {
        color = [ NSColor colorWithCalibratedHue: h saturation: s brightness: b alpha: ( CGFloat )0.5 ];
    }
    else
    {
        color = [ NSColor colorWithCalibratedHue: h saturation: ( CGFloat )0 brightness: b alpha: ( CGFloat )0.5 ];
    }
    
    rows            = [ self rowsInRect: rect ];
    selectedRows    = [self selectedRowIndexes];
    row             = rows.location;
    endRow          = row + rows.length;
    
    gradient = [ [NSGradient alloc ] initWithColorsAndLocations: color, ( CGFloat )0, nil ];
    
    for( ; row < endRow; row++ )
    {
        if( [ selectedRows containsIndex: row ] )
        {
            
            rowRect              = NSInsetRect( [ self rectOfRow: ( NSInteger )row ] , ( CGFloat )0, ( CGFloat )0 );
            rowRect.origin.x    += 5;
            rowRect.origin.y    += 5;
            rowRect.size.width  -= 10;
            rowRect.size.height -= 10;
            
            path = [ NSBezierPath bezierPathWithRoundedRect: rowRect xRadius: 10 yRadius: 10 ];
            
            [ gradient drawInBezierPath: path angle: 90 ];
        }
    }
    
    [ gradient release ];
}

@end
