/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFileViewItem.h"

@interface CEFileViewItemFS: CEFileViewItem
{
@protected
    
    NSString * _path;
    NSString * _prefix;
    BOOL       _isDirectory;
    
@private
    
    RESERVERD_IVARS( CEFileViewItemFS, 5 );
}

@end
