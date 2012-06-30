/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@interface CEOrderedDictionary: NSDictionary
{
@protected
    
    NSArray * _keys;
    NSArray * _objects;
    
@private
    
    RESERVERD_IVARS( CEOrderedDictionary , 5 );
}

- ( id )keyAtIndex: ( NSUInteger )index;
- ( id )objectAtIndex: ( NSUInteger )index;

@end
