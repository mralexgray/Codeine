/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@class CEColorChooserView;

@protocol CEColorChooserViewDelegate < NSObject >

- ( void )colorChooserView: ( CEColorChooserView * )view didChooseColor: ( NSColor * )color;

@end
