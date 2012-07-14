/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEInfoWindowController+Private.h"

@implementation CEInfoWindowController( Private )

- ( void )resizeWindow: ( BOOL )animate
{
    void ( ^ resize )( void );
    
    resize = ^
    {
        NSRect  frame;
        NSRect  rect;
        CGFloat height;
        
        frame               = self.window.frame;
        rect                = [ _outlineView rectOfRow: ( [ _outlineView numberOfRows ] - 1 ) ];
        height              = rect.origin.y + rect.size.height + ( CGFloat )25;
        frame.origin.y      = frame.origin.y + ( frame.size.height - height );
        frame.size.height   = height;
        
        if( animate == NO )
        {
            [ self.window setFrame: frame display: NO animate: NO ];
        }
        else
        {
            {
                NSDictionary    * windowResize;
                NSViewAnimation * animation;
                
                windowResize = [ NSDictionary dictionaryWithObjectsAndKeys: self.window, NSViewAnimationTargetKey, [ NSValue valueWithRect: frame ], NSViewAnimationEndFrameKey, nil ];
                animation    = [ [ NSViewAnimation alloc ] initWithViewAnimations: [ NSArray arrayWithObjects: windowResize, nil ] ];
                
                [ animation setAnimationBlockingMode: NSAnimationBlocking ];
                [ animation setAnimationCurve: NSAnimationEaseIn ];
                [ animation setDuration: 0.2 ];
                [ animation startAnimation ];
                [ animation autorelease ];
            }
        }
    };
    
    if( animate == YES )
    {
        dispatch_after
        (
            dispatch_time( DISPATCH_TIME_NOW, 10 * NSEC_PER_MSEC ),
            dispatch_get_main_queue(),
            resize
        );
    }
    else
    {
        resize();
    }
}

@end
