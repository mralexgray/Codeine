
/* $Id$ */

#import "CEColorChooserView+Private.h"

@implementation CEColorChooserView( Private )

- ( void )changeColor: ( id )sender
{

    
    if( _delegate != nil && [ _delegate respondsToSelector: @selector( colorChooserView:didChooseColor: ) ] == YES )
    {
        [ _delegate colorChooserView: self didChooseColor: _colorWell.color ];
    }
}

@end
