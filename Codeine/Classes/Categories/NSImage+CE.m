/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "NSImage+CE.h"

typedef struct __grayscalePixelStruct
{
    unsigned char gray;
    unsigned char alpha; 
}
__grayscalePixel;

@implementation NSImage( CE )

- ( NSImage * )grayscaleImage
{
    NSSize              size;
    NSInteger           row;
    NSInteger           column;
    NSInteger           width;
    NSInteger           height;
    NSImage           * grayscaleImage;
    NSBitmapImageRep  * grayscaleImageRep;
    NSColor           * color;
    __grayscalePixel  * pixels;
    __grayscalePixel  * pixel;
    CGFloat             r;
    CGFloat             g;
    CGFloat             b;
    CGFloat             a;
    
    size              = self.size;
    grayscaleImage    = [ [ [ self class ] alloc ] initWithSize: size ];
    width             = ( NSInteger )size.width;
    height            = ( NSInteger )size.height;
    grayscaleImageRep = [ [ NSBitmapImageRep alloc ] initWithBitmapDataPlanes:  nil
                                                     pixelsWide:                width
                                                     pixelsHigh:                height
                                                     bitsPerSample:             8
                                                     samplesPerPixel:           2
                                                     hasAlpha:                  YES
                                                     isPlanar:                  NO
                                                     colorSpaceName:            NSCalibratedWhiteColorSpace
                                                     bytesPerRow:               0
                                                     bitsPerPixel:              16
                        ];
    
    pixels = ( __grayscalePixel * )[ grayscaleImageRep bitmapData ];
    
    [ self lockFocus ];
    
    for( row = 0; row < height; row++ )
    {
        for( column = 0; column < width; column++ )
        {
            pixel        = &( pixels[ ( ( width * row ) + column ) ] );
            color        = NSReadPixel( NSMakePoint( column, height - ( row + 1 ) ) );
            r            = [ color redComponent ];
            g            = [ color greenComponent ];
            b            = [ color blueComponent ];
            a            = [ color alphaComponent ];
            pixel->gray  = ( unsigned char )rint( ( ( r * 0.299 ) + ( g * 0.587 ) + ( b * 0.114 ) ) * 255 );
            pixel->alpha = ( unsigned char )( a * 255 );
        }
    }
    
    [ self unlockFocus ];
    
    [ grayscaleImage addRepresentation: grayscaleImageRep ];
    [ grayscaleImageRep release];

    return [ grayscaleImage autorelease ];
}

@end
