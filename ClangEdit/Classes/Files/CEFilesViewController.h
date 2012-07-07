/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEViewController.h"

@interface CEFilesViewController: CEViewController
{
@protected
    
    NSOutlineView * _outlineView;
    
@private
    
    RESERVERD_IVARS( CEFilesViewController , 5 );
}

@property( nonatomic, readwrite, retain ) IBOutlet NSOutlineView * outlineView;

@end
