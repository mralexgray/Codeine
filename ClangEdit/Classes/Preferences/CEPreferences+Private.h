/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferences.h"

@interface CEPreferences( Private )

- ( NSColor * )colorForKey: ( NSString * )key;
- ( NSColor * )colorForKey: ( NSString * )key inDictionary: ( NSDictionary * )dictionary;
- ( void )setColor: ( NSColor * )color forKey: ( NSString * )key;

@end
