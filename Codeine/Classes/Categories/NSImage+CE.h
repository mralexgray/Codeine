
/* $Id$ */


@interface NSImage (CE)

- (NSImage*)imageWithSize:(CGFloat)size;
@property (readonly, copy) NSImage *grayscaleImage;

@end
