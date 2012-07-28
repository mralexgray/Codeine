/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@interface CETextEncoding: NSObject
{
@protected
    
    NSStringEncoding _value;
    NSString       * _name;
    
@private
    
    RESERVED_IVARS( CETextEncoding, 5 );
}

@property( atomic, readonly ) NSStringEncoding value;
@property( atomic, readonly ) NSString       * name;
@property( atomic, readonly ) NSString       * localizedName;

+ ( NSArray * )availableEncodings;

@end
