
/* $Id$ */

#import "CEInfoWindowOutlineView.h"

@implementation CEInfoWindowOutlineView

- ( instancetype )initWithFrame: ( NSRect )frame
{
    if( ( self = [ super initWithFrame: frame ] ) )
    {
        [ [ self enclosingScrollView ] setDrawsBackground: NO ];
    }
    
    return self;
}

- ( instancetype )initWithCoder: ( NSCoder * )coder
{
    if( ( self = [ super initWithCoder: coder ] ) )
    {
        [ [ self enclosingScrollView ] setDrawsBackground: NO ];
    }
    
    return self;
}

- ( BOOL )isOpaque
{
    return NO;
}

- ( void )drawBackgroundInClipRect: ( NSRect )rect
{

}

@end
