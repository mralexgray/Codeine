/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import <Quartz/Quartz.h>

@interface CEQuickLookItem: NSObject < QLPreviewItem >
{
@protected
    
    NSString * _path;
    
@private
    
    RESERVED_IVARS( CEQuickLookItem, 5 );
}

+ ( id )quickLookItemWithPath: ( NSString * )path;
- ( id )initWithPath: ( NSString * )path;

@end
