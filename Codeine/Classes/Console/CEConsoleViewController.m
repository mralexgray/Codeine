
/* $Id$ */

#import "CEConsoleViewController.h"
#import "CEConsoleViewController+Private.h"
#import "CEPreferences.h"

@implementation CEConsoleViewController

@synthesize textView = _textView;

- ( void )dealloc
{
    [ NOTIFICATION_CENTER removeObserver: self ];
    
    
}

- ( void )awakeFromNib
{
    [ NOTIFICATION_CENTER addObserver: self selector: @selector( updateView ) name: CEPreferencesNotificationValueChanged object: nil ];
    [ self updateView ];
}

@end
