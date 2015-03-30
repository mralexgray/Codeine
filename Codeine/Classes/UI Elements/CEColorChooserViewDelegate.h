
/* $Id$ */

@class CEColorChooserView;

@protocol CEColorChooserViewDelegate<NSObject>

- (void)colorChooserView:(CEColorChooserView*)view didChooseColor:(NSColor*)color;

@end
