/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEColorLabelMenuItem+CEColorLabelViewDelegate.h"
#import "CEColorLabelView.h"

@implementation CEColorLabelMenuItem( CEColorLabelViewDelegate )

- ( void )colorLabelView: ( CEColorLabelView * )view didSelectColor: ( NSColor * )color
{
    ( void )view;
    
    self.selectedColor  = color;
    _view.selectedColor = color;
    
    [ self.menu performActionForItemAtIndex: [ self.menu indexOfItem: self ] ];
    [ self.menu cancelTracking ];
}

@end
