
/* $Id$ */

#import "CEBackgroundView.h"

@implementation CEBackgroundView

@synthesize backgroundColor = _backgroundColor;
@synthesize borderColor     = _borderColor;


- ( void )drawRect: ( NSRect )rect
{
    if( _backgroundColor != nil )
    {
        [ _backgroundColor setFill ];
        
        NSRectFill( rect );
    }
    
    if( _borderColor != nil )
    {
        {
            NSBezierPath * path;
            NSGradient   * gradient;
            NSRect         subrect;
            
            subrect              = rect;
            subrect.origin.x    += 1;
            subrect.origin.y    += 1;
            subrect.size.width  -= 2;
            subrect.size.height -= 2;
            
            path = [ NSBezierPath bezierPathWithRect: rect ];
            
            [ path appendBezierPath: [ NSBezierPath bezierPathWithRect: subrect ] ];
            [ path setWindingRule: NSEvenOddWindingRule ];
            
            gradient =[NSGradient.alloc 
         initWithColorsAndLocations: _borderColor, ( CGFloat )0, nil ];
            
            [ gradient drawInBezierPath: path angle: ( CGFloat )0 ];
        }
    }
    
    [ super drawRect: rect ];
}

@end
