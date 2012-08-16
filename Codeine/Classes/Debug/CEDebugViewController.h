/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEViewController.h"

@class CEVerticalTabView;

@interface CEDebugViewController: CEViewController
{
@protected
    
    CEVerticalTabView * _tabView;
    
@private
    
    RESERVED_IVARS( CEDebugViewController , 5 );
}

@property( nonatomic, readwrite, retain ) IBOutlet CEVerticalTabView * tabView;



@end
