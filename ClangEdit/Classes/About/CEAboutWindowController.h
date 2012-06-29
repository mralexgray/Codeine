/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEWindowController.h"

@interface CEAboutWindowController: CEWindowController
{
@protected
    
    NSTextField * _versionTextField;
    
@private
    
    RESERVERD_IVARS( CEAboutWindowController , 5 );
}

@property( nonatomic, readwrite, retain ) IBOutlet NSTextField * versionTextField;

@end
