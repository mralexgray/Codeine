/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@class CEVerticalTabView;

@protocol CEVerticalTabViewDelegate < NSObject >

@optional

- ( void )verticalTabView: ( CEVerticalTabView * )view didSelectViewAtIndex: ( NSUInteger )index;

@end
