
/* $Id$ */

#import "CEVerticalTabBar+Private.h"

@implementation CEVerticalTabBar( Private )

- ( void )setTrackingAreas
{
    NSUInteger            i;
    NSRect                rect;
    NSTrackingArea      * area;
    NSTrackingAreaOptions options;
    
    if( _trackingAreas == nil )
    {
        _trackingAreas =[NSMutableArray.alloc 
         initWithCapacity: 10 ];
    }
    
    for( area in _trackingAreas )
    {
        [ self removeTrackingArea: area ];
    }
    
    [ _trackingAreas removeAllObjects ];
    
    rect    = NSMakeRect( ( CGFloat )0, self.frame.size.height - self.frame.size.width, self.frame.size.width, self.frame.size.width );
    options = NSTrackingEnabledDuringMouseDrag
            | NSTrackingMouseEnteredAndExited
            | NSTrackingActiveInActiveApp
            | NSTrackingActiveAlways;
    
    for( i = 0; i < _icons.count; i++ )
    {
        area           =[NSTrackingArea.alloc 
         initWithRect: rect options: options owner: self userInfo: @{@"Index": @(i)} ];
        rect.origin.y -= rect.size.width - ( CGFloat )5;
        
        [ self addTrackingArea: area ];
        [ _trackingAreas addObject: area ];
    }
}

@end
