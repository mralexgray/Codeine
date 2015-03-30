
/* $Id$ */

#import "CEColorTheme+Private.h"

@implementation CEColorTheme( Private )

- ( void )setColorFromDictionary: ( NSDictionary * )dict name: ( NSString * )name selector: ( SEL )selector
{
    CGFloat        r;
    CGFloat        g;
    CGFloat        b;
    NSDictionary * colorValues;
    NSColor      * color;
    
    colorValues = [ dict objectForKey: name ];
    r           = ( CGFloat )( [ ( NSNumber * )[ colorValues objectForKey: @"R" ] doubleValue ] / ( CGFloat )255 );
    g           = ( CGFloat )( [ ( NSNumber * )[ colorValues objectForKey: @"G" ] doubleValue ] / ( CGFloat )255 );
    b           = ( CGFloat )( [ ( NSNumber * )[ colorValues objectForKey: @"B" ] doubleValue ] / ( CGFloat )255 );
    
    color = [ NSColor colorWithDeviceRed: r green: g blue: b alpha: ( CGFloat )1 ];
    
    [ self performSelector: selector withObject: color ];
}

@end
