
/* $Id$ */

#import "CEWindowBadge+Private.h"

@implementation CEWindowBadge( Private )

- ( void )applicationStateDidChange: ( NSNotification * )notification
{

    
    [ self setNeedsDisplay: YES ];
}

@end
