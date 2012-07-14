/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEWindowController.h"

@interface CEInfoWindowController: CEWindowController
{
@protected
    
    NSString * _path;
    
@private
    
    RESERVERD_IVARS( CEInfoWindowController, 5 );
}

@property( atomic, readonly ) NSString * path;

- ( id )initWithPath: ( NSString * )path;

@end
