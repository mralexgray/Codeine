/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFilesViewItemDocument.h"
#import "CEDocument.h"

@implementation CEFilesViewItemDocument

- ( BOOL )isLeaf
{
    return YES;
}

- ( NSString * )displayName
{
    CEDocument * document;
    
    if( [ self.representedObject isKindOfClass: [ CEDocument class ] ] == NO )
    {
        return nil;
    }
    
    document = self.representedObject;
    
    return document.name;
}

- ( NSImage * )icon
{
    CEDocument * document;
    
    if( [ self.representedObject isKindOfClass: [ CEDocument class ] ] == NO )
    {
        return nil;
    }
    
    document = self.representedObject;
    
    return document.icon;
}

@end
