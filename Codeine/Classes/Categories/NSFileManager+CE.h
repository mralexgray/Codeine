/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@interface NSFileManager( CE )

- ( NSString * )pathOfDirectory:    ( NSSearchPathDirectory  )directory
                inDomain:           ( NSSearchPathDomainMask )domain
                byAppendingPath:    ( NSString * )appendPath
                createIfNecessary:  ( BOOL )create;
- ( NSString * )applicationSupportDirectory;

@end
