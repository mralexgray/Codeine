/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFilesViewItem.h"

@interface CEFilesViewItemFS: CEFilesViewItem
{
@protected
    
    NSString * _path;
    NSString * _prefix;
    BOOL       _isDirectory;
    
@private
    
    RESERVED_IVARS( CEFileViewItemFS, 5 );
}

@end
