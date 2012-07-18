/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEViewController.h"

static NSString * const __classSuffix               = @"Controller";
       NSString * const CEViewControllerException   = @"CEViewControllerException";

@implementation CEViewController

- ( id )init
{
    NSString * className;
    NSString * nibName;
    
    className = NSStringFromClass( [ self class ] );
    
    if( [ className hasSuffix: __classSuffix ] == NO )
    {
        @throw [ NSException exceptionWithName: CEViewControllerException reason: @"Invalid view controller class name" userInfo: nil ];
    }
    
    nibName = [ className substringToIndex: className.length - __classSuffix.length ];
    
    if( ( self = [ super initWithNibName: nibName bundle: nil ] ) )
    {}
    
    return self;
}

@end
