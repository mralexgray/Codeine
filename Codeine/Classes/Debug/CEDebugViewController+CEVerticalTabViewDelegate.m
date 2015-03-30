
/* $Id$ */

#import "CEDebugViewController+CEVerticalTabViewDelegate.h"
#import "CEPreferences.h"

@implementation CEDebugViewController( CEVerticalTabViewDelegate )

- ( void )verticalTabView: ( CEVerticalTabView * )view didSelectViewAtIndex: ( NSUInteger )index
{

    
    [ [ CEPreferences sharedInstance ] setDebugAreaSelectedIndex: index ];
}

@end
