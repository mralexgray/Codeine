/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

FOUNDATION_EXPORT NSString * const CEWindowControllerException;

@interface CEWindowController: NSWindowController
{
@protected
    
    BOOL _releaseOnWindowClose;
    
@private
    
    RESERVERD_IVARS( CEWindowController , 5 );
}

@property( atomic, readwrite, assign ) BOOL releaseOnWindowClose;

@end
