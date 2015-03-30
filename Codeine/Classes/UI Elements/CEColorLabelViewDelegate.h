
/* $Id$ */

@class CEColorLabelView;

@protocol CEColorLabelViewDelegate<NSObject>

@optional

- (void)colorLabelView:(CEColorLabelView*)view didSelectColor:(NSColor*)color;

@end
