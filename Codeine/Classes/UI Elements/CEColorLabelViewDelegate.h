/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@class CEColorLabelView;

@protocol CEColorLabelViewDelegate< NSObject >

@optional

- ( void )colorLabelView: ( CEColorLabelView * )view didSelectColor: ( NSColor * )color;

@end
