
/* $Id$ */

#import "CEFilesOutlineView+Private.h"

@implementation CEFilesOutlineView( Private )

- ( void )applicationStateDidChange: ( NSNotification * )notification
{

    
    [ self setNeedsDisplay: YES ];
}

@end
