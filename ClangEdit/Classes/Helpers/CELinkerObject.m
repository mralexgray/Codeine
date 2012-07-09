/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CELinkerObject.h"

@implementation CELinkerObject

@synthesize type        = _type;
@synthesize language    = _language;
@synthesize path        = _path;

+ ( id )linkerObjectWithPath: ( NSString * )path type: ( CELinkerObjectType )type
{
    return [ self linkerObjectWithPath: path type: type language: CESourceFileLanguageNone ];
}

+ ( id )linkerObjectWithPath: ( NSString * )path type: ( CELinkerObjectType )type language: ( CESourceFileLanguage )language
{
    return [ [ [ self alloc ] initWithPath: path type: type language: language ] autorelease ];
}

- ( id )initWithPath: ( NSString * )path type: ( CELinkerObjectType )type
{
    return [ self initWithPath: path type: type language: CESourceFileLanguageNone ];
}

- ( id )initWithPath: ( NSString * )path type: ( CELinkerObjectType )type language: ( CESourceFileLanguage )language
{
    if( ( self = [ self init ] ) )
    {
        _path       = [ path copy ];
        _type       = type;
        _language   = language;
    }
    
    return self;
}

- ( void )dealloc
{
    RELEASE_IVAR( _path );
    
    [ super dealloc ];
}

- ( NSString * )name
{
    return [ FILE_MANAGER displayNameAtPath: _path ];
}

- ( NSImage * )icon
{
    return [ [ NSWorkspace sharedWorkspace ] iconForFile: _path ];
}

@end
