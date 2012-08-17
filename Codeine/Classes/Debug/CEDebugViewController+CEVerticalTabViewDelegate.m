/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEDebugViewController+CEVerticalTabViewDelegate.h"
#import "CEPreferences.h"

@implementation CEDebugViewController( CEVerticalTabViewDelegate )

- ( void )verticalTabView: ( CEVerticalTabView * )view didSelectViewAtIndex: ( NSUInteger )index
{
    ( void )view;
    
    [ [ CEPreferences sharedInstance ] setDebugAreaSelectedIndex: index ];
}

@end
