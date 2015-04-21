
/* $Id$ */

#import <ClangKit/ClangKit.h>

@implementation NSView(CE)

- (void)centerInSuperview {

    if(!self.superview) return;
    
    NSRect bounds = self.superview.bounds,
            frame = self.frame;
    
    frame.origin.x = (bounds.size.width  - frame.size.width ) / (CGFloat)2;
    frame.origin.y = (bounds.size.height - frame.size.height) / (CGFloat)2;
    
    self.frame = frame;
}

@end
