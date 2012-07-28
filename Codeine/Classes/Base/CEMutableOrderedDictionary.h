/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@interface CEMutableOrderedDictionary: NSMutableDictionary
{
@protected
    
    NSMutableArray * _keys;
    NSMutableArray * _objects;
    
@private
    
    RESERVED_IVARS( CEMutableOrderedDictionary , 5 );
}

- ( id )keyAtIndex: ( NSUInteger )index;
- ( id )objectAtIndex: ( NSUInteger )index;

@end
