
/* $Id$ */

#import "CEPreferencesWindowController+Private.h"

@implementation CEPreferencesWindowController( Private )

- ( void )showView: ( NSView * )view
{
    CGRect   frame;
    NSSize   size;
    NSView * subView;
    CGFloat  width;
    CGFloat  height;
    
    view.frame = CGRectMake
    (
        0,
        0,
        view.frame.size.width,
        view.frame.size.height
    );
    
    for( subView in [ self.window.contentView subviews ] )
    {
        [ subView removeFromSuperview ];
    }
    
    frame               = self.window.frame;
    size                = [ ( NSView * )( self.window.contentView ) frame ].size;
    width               = ( frame.size.width  - size.width );
    height              = ( frame.size.height - size.height );
    frame.size.width    = width  + view.frame.size.width;
    frame.size.height   = height + view.frame.size.height;
    frame.origin.x     += ( size.width  - view.frame.size.width ) / ( CGFloat )2;
    frame.origin.y     += size.height   - view.frame.size.height;
    
    [ self.window setFrame: frame display: YES animate: YES ];
    [ self.window.contentView addSubview: view ];
    [ view becomeFirstResponder ];
}

- ( void )windowDidClose: ( NSNotification * )notification
{

    
    [ APPLICATION stopModal ];
}

@end
