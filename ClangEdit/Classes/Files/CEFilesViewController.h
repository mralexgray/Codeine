/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEViewController.h"

@class CEFileViewItem;

@interface CEFilesViewController: CEViewController
{
@protected
    
    NSOutlineView  * _outlineView;
    NSMutableArray * _rootItems;
    
@private
    
    RESERVERD_IVARS( CEFilesViewController , 5 );
}

@property( nonatomic, readwrite, retain ) IBOutlet NSOutlineView * outlineView;

@end
