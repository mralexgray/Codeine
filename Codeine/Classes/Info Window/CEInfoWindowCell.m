
/* $Id$ */

#import "CEInfoWindowCell.h"

@implementation CEInfoWindowCell

@synthesize view = _view;

- ( void )dealloc
{
    RELEASE_IVAR( _view );
    
    [ super dealloc ];
}

- ( void )drawWithFrame: ( NSRect )cellFrame inView: ( NSView * )controlView
{

    
    if( [ ( NSOutlineView * )controlView isItemExpanded: _view ] == YES )
    {
        _view.frame = cellFrame;
        
        if( _view.superview == nil)
        {
            [ controlView addSubview: _view ];
        }
    }
    else
    {
        [ _view removeFromSuperview ];
    }
    
    [ super drawWithFrame: cellFrame inView: controlView ];
}

@end
