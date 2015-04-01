
/* $Id$ */

#import "CELanguageWindowTableView.h"

@implementation CELanguageWindowTableView

- ( instancetype )initWithCoder: ( NSCoder * )coder
{
    if( ( self = [ super initWithCoder: coder ] ) )
    {
        [ self.enclosingScrollView setDrawsBackground: NO ];
    }
    
    return self;
}

- ( instancetype )initWithFrame: ( NSRect )frame
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

}

- ( BOOL )isOpaque
{
    return NO;
}

- ( void )highlightSelectionInClipRect: ( NSRect )rect
{
    NSRange         rows;
    NSColor       * color1;
    NSColor       * color2;
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
    
    color1 = [ NSColor colorForControlTint: NSGraphiteControlTint ];
    color1 = [ color1 colorUsingColorSpaceName: NSDeviceRGBColorSpace ];
    
    [ color1 getHue: &h saturation: &s brightness: &b alpha: NULL ];
    
    if( APPLICATION.isActive )
    {
        color1 = [ NSColor colorWithCalibratedHue: h saturation: s brightness: b alpha: ( CGFloat )1 ];
        color2 = [ NSColor colorWithCalibratedHue: h saturation: s + ( CGFloat )0.1 brightness: b - ( CGFloat )0.1 alpha: ( CGFloat )1 ];
    }
    else
    {
        color1 = [ NSColor colorWithCalibratedHue: h saturation: ( CGFloat )0 brightness: b alpha: ( CGFloat )1 ];
        color2 = [ NSColor colorWithCalibratedHue: h saturation: ( CGFloat )0 brightness: b - ( CGFloat )0.1 alpha: ( CGFloat )1 ];
    }
    
    rows            = [ self rowsInRect: rect ];
    selectedRows    = [self selectedRowIndexes];
    row             = rows.location;
    endRow          = row + rows.length;
    
    for( ; row < endRow; row++ )
    {
        if( [ selectedRows containsIndex: row ] )
        {
            gradient =[NSGradient.alloc 
         initWithColorsAndLocations: color1, ( CGFloat )0, color2, ( CGFloat )1, nil ];
            
            rowRect = NSInsetRect( [ self rectOfRow: ( NSInteger )row ] , ( CGFloat )0, ( CGFloat )0 );
            path    = [ NSBezierPath bezierPath ];
            
            rowRect.origin.x    += ( CGFloat )5;
            rowRect.origin.y    += ( CGFloat )5;
            rowRect.size.width  -= ( CGFloat )10;
            rowRect.size.height -= ( CGFloat )10;
            
            [ path appendBezierPathWithRoundedRect: rowRect xRadius: ( CGFloat )10 yRadius: ( CGFloat )10 ];
            [ gradient drawInBezierPath: path angle: 90 ];
            
            gradient =[NSGradient.alloc 
         initWithStartingColor:    [ NSColor colorWithCalibratedWhite: ( CGFloat )0 alpha: ( CGFloat )0.15 ]
                                                      endingColor:      [ NSColor colorWithCalibratedWhite: ( CGFloat )0 alpha: ( CGFloat )0.30 ]
                       ];
                               
            rowRect.origin.x    += ( CGFloat )0.30;
            rowRect.origin.y    += ( CGFloat )0.30;
            rowRect.size.width  -= ( CGFloat )0.60;
            rowRect.size.height -= ( CGFloat )0.60;
            
            [ path appendBezierPath: [ NSBezierPath bezierPathWithRoundedRect: rowRect xRadius: ( CGFloat )10 yRadius: ( CGFloat )10 ] ];
            [ path setWindingRule: NSEvenOddWindingRule ];
            [ gradient drawInBezierPath: path angle: ( CGFloat )90 ];
        }
    }
}

@end
