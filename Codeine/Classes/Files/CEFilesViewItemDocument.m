/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFilesViewItemDocument.h"

@implementation CEFilesViewItemDocument

- ( BOOL )isLeaf
{
    return YES;
}

- ( NSString * )displayName
{
    return @"DOCUMENT_ITEM";
}

@end
