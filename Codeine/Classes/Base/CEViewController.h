/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

FOUNDATION_EXPORT NSString * const CEViewControllerException;

@interface CEViewController: NSViewController
{
@protected
    
    NSView * _currentView;
    
@private
    
    RESERVERD_IVARS( CEViewController , 5 );
}

@end
