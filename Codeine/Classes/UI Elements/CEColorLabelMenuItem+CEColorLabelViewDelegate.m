
/* $Id$ */

#import "CEColorLabelMenuItem+CEColorLabelViewDelegate.h"
#import "CEColorLabelView.h"

@implementation CEColorLabelMenuItem( CEColorLabelViewDelegate )

- ( void )colorLabelView: ( CEColorLabelView * )view didSelectColor: ( NSColor * )color
{

    
    self.selectedColor  = color;
    _view.selectedColor = color;
    
    [ self.menu performActionForItemAtIndex: [ self.menu indexOfItem: self ] ];
    [ self.menu cancelTracking ];
}

@end
