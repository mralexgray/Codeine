/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferences+Private.h"

@implementation CEPreferences( Private )

- ( NSColor * )colorForKey: ( NSString * )key
{
    CGFloat        r;
    CGFloat        g;
    CGFloat        b;
    NSDictionary * colorValues;
    
    colorValues = [ DEFAULTS objectForKey: key ];
    r           = ( CGFloat )( [ ( NSNumber * )[ colorValues objectForKey: @"R" ] doubleValue ] / ( CGFloat )255 );
    g           = ( CGFloat )( [ ( NSNumber * )[ colorValues objectForKey: @"G" ] doubleValue ] / ( CGFloat )255 );
    b           = ( CGFloat )( [ ( NSNumber * )[ colorValues objectForKey: @"B" ] doubleValue ] / ( CGFloat )255 );
    
    return [ NSColor colorWithDeviceRed: r green: g blue: b alpha: ( CGFloat )1 ];
}

- ( NSColor * )colorForKey: ( NSString * )key inDictionary: ( NSDictionary * )dictionary
{
    CGFloat        r;
    CGFloat        g;
    CGFloat        b;
    NSDictionary * colorValues;
    
    colorValues = [ dictionary objectForKey: key ];
    r           = ( CGFloat )( [ ( NSNumber * )[ colorValues objectForKey: @"R" ] doubleValue ] / ( CGFloat )255 );
    g           = ( CGFloat )( [ ( NSNumber * )[ colorValues objectForKey: @"G" ] doubleValue ] / ( CGFloat )255 );
    b           = ( CGFloat )( [ ( NSNumber * )[ colorValues objectForKey: @"B" ] doubleValue ] / ( CGFloat )255 );
    
    return [ NSColor colorWithDeviceRed: r green: g blue: b alpha: ( CGFloat )1 ];
}

- ( void )setColor: ( NSColor * )color forKey: ( NSString * )key
{
    CGFloat        r;
    CGFloat        g;
    CGFloat        b;
    CGFloat        a;
    NSDictionary * colorValues;
    
    color = [ color colorUsingColorSpaceName: NSDeviceRGBColorSpace ];
    
    r = ( CGFloat )0;
    g = ( CGFloat )0;
    b = ( CGFloat )0;
    a = ( CGFloat )0;
    
    [ color getRed: &r green: &g blue: &b alpha: &a ];
    
    colorValues = [ NSDictionary dictionaryWithObjectsAndKeys:  [ NSNumber numberWithDouble: ( double )r * ( double )255 ], @"R",
                                                                [ NSNumber numberWithDouble: ( double )g * ( double )255 ], @"G",
                                                                [ NSNumber numberWithDouble: ( double )b * ( double )255 ], @"B",
                                                                nil
                  ];
    
    [ DEFAULTS setObject: colorValues forKey: key ];
    [ DEFAULTS synchronize ];
}

@end
