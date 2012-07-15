/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEColorLabelView+Private.h"

@implementation CEColorLabelView( Private )

- ( void )setup
{
    _colors = [ [ [ NSWorkspace sharedWorkspace ] fileLabelColors ] retain ];
    _labels = [ [ [ NSWorkspace sharedWorkspace ] fileLabels      ] retain ];
}

@end
