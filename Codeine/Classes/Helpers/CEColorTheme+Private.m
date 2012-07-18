/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
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
    r           = ( CGFloat )( [ ( NSNumber * )[ colorValues objectForKey: @"R" ] doubleValue ] / ( CGFloat )256 );
    g           = ( CGFloat )( [ ( NSNumber * )[ colorValues objectForKey: @"G" ] doubleValue ] / ( CGFloat )256 );
    b           = ( CGFloat )( [ ( NSNumber * )[ colorValues objectForKey: @"B" ] doubleValue ] / ( CGFloat )256 );
    
    color = [ NSColor colorWithDeviceRed: r green: g blue: b alpha: ( CGFloat )1 ];
    
    [ self performSelector: selector withObject: color ];
}

@end
