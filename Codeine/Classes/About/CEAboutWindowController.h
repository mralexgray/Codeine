/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEWindowController.h"

@class CEBackgroundView;

@interface CEAboutWindowController: CEWindowController
{
@protected
    
    CEBackgroundView * _backgroundView;
    NSTextField      * _versionTextField;
    NSImageView      * _iconView;
    
@private
    
    RESERVED_IVARS( CEAboutWindowController , 5 );
}

@property( nonatomic, readwrite, retain ) IBOutlet CEBackgroundView * backgroundView;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField      * versionTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSImageView      * iconView;

@end
