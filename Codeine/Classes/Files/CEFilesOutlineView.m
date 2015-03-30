
/* $Id$ */

#import "CEFilesOutlineView.h"
#import "CEFilesViewItem.h"
#import "CEFilesOutlineView+Private.h"

#import "CEMainWindowController.h"
#import "CEDocument.h"

@implementation CEFilesOutlineView

- ( id )initWithCoder: ( NSCoder * )coder
{
    if( ( self = [ super initWithCoder: coder ] ) )
    {
        [ NOTIFICATION_CENTER addObserver: self selector: @selector( applicationStateDidChange: ) name: NSApplicationDidBecomeActiveNotification object: APPLICATION ];
        [ NOTIFICATION_CENTER addObserver: self selector: @selector( applicationStateDidChange: ) name: NSApplicationDidResignActiveNotification object: APPLICATION ];
    }
    
    return self;
}

- ( id )initWithFrame: ( NSRect )frame
{
    if( ( self = [ super initWithFrame: frame ] ) )
    {
        [ NOTIFICATION_CENTER addObserver: self selector: @selector( applicationStateDidChange: ) name: NSApplicationDidBecomeActiveNotification object: APPLICATION ];
        [ NOTIFICATION_CENTER addObserver: self selector: @selector( applicationStateDidChange: ) name: NSApplicationDidResignActiveNotification object: APPLICATION ];
    }
    
    return self;
}

- ( void )dealloc
{
    [ NOTIFICATION_CENTER removeObserver: self ];
    
}

- ( void )keyDown: ( NSEvent * )e
{
    id < CEFilesOutlineViewDelegate > delegate;
    
    delegate = nil;
    
    if( [ self.delegate conformsToProtocol: @protocol( CEFilesOutlineViewDelegate ) ] )
    {
        delegate = ( id < CEFilesOutlineViewDelegate > )( self.delegate );
    }
    
    if( self.selectedRow != -1 )
    {
        if( [ delegate respondsToSelector: @selector( outlineView:processKeyEvent:onRow:event: ) ] )
        {
            if( [ delegate outlineView: self processKeyEvent: e.keyCode onRow: self.selectedRow event: e ] == YES )
            {
                return;
            }
        }
    }
    
    [ super keyDown: e ];
}

- ( void )mouseDown: ( NSEvent * )e
{
    NSPoint                             point;
    NSInteger                           row;
    CGRect                              frame;
    id < CEFilesOutlineViewDelegate >   delegate;
    
    point       = [ self convertPoint: [ e locationInWindow ] fromView: nil ];
    row         = [ self rowAtPoint: point ];
    frame       = [ self frameOfOutlineCellAtRow: row ];
    delegate    = nil;
    
    point.x = point.x - frame.origin.x;
    point.y = point.y - frame.origin.y;
    
    if( [ self.delegate conformsToProtocol: @protocol( CEFilesOutlineViewDelegate ) ] )
    {
        delegate = ( id < CEFilesOutlineViewDelegate > )( self.delegate );
    }
    
    if( e.clickCount == 2 )
    {
        if( [ delegate respondsToSelector: @selector( outlineView:shouldDoubleClickOnRow:atPoint:event: ) ] )
        {
            if( [ delegate outlineView: self shouldDoubleClickOnRow: row atPoint: point event: e ] == NO )
            {
                return;
            }
        }
        
        if( [ delegate respondsToSelector: @selector( outlineView:willDoubleClickOnRow:atPoint:event: ) ] )
        {
            [ delegate outlineView: self willDoubleClickOnRow: row atPoint: point event: e ];
        }
        
        if( [ delegate respondsToSelector: @selector( outlineView:didDoubleClickOnRow:atPoint:event: ) ] )
        {
            [ delegate outlineView: self didDoubleClickOnRow: row atPoint: point event: e ];
        }
        else
        {
            [ super mouseDown: e ];
        }
    }
    else
    {
        if( [ delegate respondsToSelector: @selector( outlineView:shouldClickOnRow:atPoint:event: ) ] )
        {
            if( [ delegate outlineView: self shouldClickOnRow: row atPoint: point event: e ] == NO )
            {
                return;
            }
        }
        
        if( [ delegate respondsToSelector: @selector( outlineView:willClickOnRow:atPoint:event: ) ] )
        {
            [ delegate outlineView: self willClickOnRow: row atPoint: point event: e ];
        }
        
        if( [ delegate respondsToSelector: @selector( outlineView:didClickOnRow:atPoint:event: ) ] )
        {
            [ delegate outlineView: self didClickOnRow: row atPoint: point event: e ];
        }
        else
        {
            [ super mouseDown: e ];
        }
    }
}

- ( NSMenu * )menuForEvent: ( NSEvent * )e
{
    NSPoint                           point;
    NSInteger                         row;
    NSMenu                          * menu;
    id < CEFilesOutlineViewDelegate > delegate;
    
    point    = [ self convertPoint: [ e locationInWindow ] fromView: nil ];
    row      = [ self rowAtPoint: point ];
    menu     = nil;
    delegate = nil;
    
    if( [ self.delegate conformsToProtocol: @protocol( CEFilesOutlineViewDelegate ) ] )
    {
        delegate = ( id < CEFilesOutlineViewDelegate > )( self.delegate );
    }
    
    if( [ delegate respondsToSelector: @selector( outlineView:menuForRow: ) ] )
    {
        menu = [ delegate outlineView: self menuForRow: row ];
    }
    
    return menu;
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
            gradient = [ [NSGradient alloc ] initWithColorsAndLocations: color1, ( CGFloat )0, color2, ( CGFloat )1, nil ];
            
            rowRect = NSInsetRect( [ self rectOfRow: ( NSInteger )row ] , ( CGFloat )0, ( CGFloat )0 );
            path    = [ NSBezierPath bezierPath ];
            
            rowRect.origin.x   += ( CGFloat )5;
            rowRect.size.width += ( CGFloat )10;
            
            [ path appendBezierPathWithRoundedRect: rowRect xRadius: ( CGFloat )10 yRadius: ( CGFloat )10 ];
            [ gradient drawInBezierPath: path angle: 90 ];
            
            gradient = [ [ NSGradient alloc ] initWithStartingColor:    [ NSColor colorWithCalibratedWhite: ( CGFloat )0 alpha: ( CGFloat )0.15 ]
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
