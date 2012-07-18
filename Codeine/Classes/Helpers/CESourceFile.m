/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CESourceFile.h"
#import "CEPreferences.h"

@implementation CESourceFile

@synthesize language = _language;
@synthesize text     = _text;

+ ( id )sourceFileWithLanguage: ( CESourceFileLanguage )language
{
    return [ [ [ self alloc ] initWithLanguage: language ] autorelease ];
}

+ ( id )sourceFileWithLanguage: ( CESourceFileLanguage )language fromFile: ( NSString * )path
{
    return [ [ [ self alloc ] initWithLanguage: language fromFile: path ] autorelease ];
}

- ( id )initWithLanguage: ( CESourceFileLanguage )language
{
    if( ( self = [ self initWithLanguage: language fromFile: nil ] ) )
    {}
    
    return self;
}

- ( id )initWithLanguage: ( CESourceFileLanguage )language fromFile: ( NSString * )path
{
    BOOL     isDir;
    NSData * data;
    
    if( ( self = [ self init ] ) )
    {
        isDir     = NO;
        _language = language;
        
        if( [ FILE_MANAGER fileExistsAtPath: path isDirectory: &isDir ] == YES && isDir == NO )
        {
            data = [ FILE_MANAGER contentsAtPath: path ];
            
            if( data != nil )
            {
                _text = [ [ NSString alloc ] initWithData: data encoding: [ [ CEPreferences sharedInstance ] textEncoding ] ];
            }
        }
    }
    
    return self;
}

- ( void )dealloc
{
    [ _text release ];
    
    [ super dealloc ];
}

@end
