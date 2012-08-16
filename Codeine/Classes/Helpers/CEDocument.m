/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEDocument.h"
#import "CEDocument+Private.h"
#import "CEFile.h"
#import "CEPreferences.h"

@implementation CEDocument

@synthesize file        = _file;
@synthesize sourceFile  = _sourceFile;
@synthesize name        = _name;

+ ( id )documentWithPath: ( NSString * )path
{
    return [ [ [ self alloc ] initWithPath: path ] autorelease ];
}

+ ( id )documentWithURL: ( NSURL * )url
{
    return [ [ [ self alloc ] initWithURL: url ] autorelease ];
}

+ ( id )documentWithLanguage: ( CESourceFileLanguage )language
{
    return [ [ [ self alloc ] initWithLanguage: language ] autorelease ];
}

- ( id )initWithPath: ( NSString * )path
{
    if( ( self = [ self initWithURL: [ NSURL fileURLWithPath: path ] ] ) )
    {}
    
    return self;
}

- ( id )initWithURL: ( NSURL * )url
{
    NSDictionary        * types;
    NSString            * extension;
    NSNumber            * value;
    CESourceFileLanguage  language;
    
    if( ( self = [ self init ] ) )
    {
        _file = [ [ CEFile alloc ] initWithURL: url ];
    
        if( _file == nil )
        {
            [ self release ];
            
            return nil;
        }
        
        language = CESourceFileLanguageNone;
        types    = [ [ CEPreferences sharedInstance ] fileTypes ];
        
        for( extension in types )
        {
            if( [ extension.lowercaseString isEqualToString: url.path.pathExtension.lowercaseString ] )
            {
                value    = [ types objectForKey: extension ];
                language = ( CESourceFileLanguage )[ value integerValue ];
                
                break;
            }
        }
        
        _sourceFile = [ [ CESourceFile alloc ] initWithLanguage: language fromFile: _file.path ];
        
        if( _sourceFile == nil )
        {
            [ self release ];
            
            return nil;
        }
        
        _name = [ _file.name copy ];
    }
    
    return self;
}

- ( id )initWithLanguage: ( CESourceFileLanguage )language
{
    if( ( self = [ self init ] ) )
    {
        _sourceFile = [ [ CESourceFile alloc ] initWithLanguage: language ];
        
        if( _sourceFile == nil )
        {
            [ self release ];
            
            return nil;
        }
        
        _name = [ [ self nameForNewDocument ] copy ];
    }
    
    return self;
}

- ( void )dealloc
{
    RELEASE_IVAR( _file );
    RELEASE_IVAR( _sourceFile );
    RELEASE_IVAR( _name );
    
    [ super dealloc ];
}

- ( NSImage * )icon
{
    if( _file != nil )
    {
        return _file.icon;
    }
    
    if( _sourceFile != nil )
    {
        switch( _sourceFile.language )
        {
            case CESourceFileLanguageC:
                
                return [ WORKSPACE iconForFileType: @"c" ];
                
            case CESourceFileLanguageCPP:
                
                return [ WORKSPACE iconForFileType: @"cpp" ];
                
            case CESourceFileLanguageObjC:
                
                return [ WORKSPACE iconForFileType: @"m" ];
                
            case CESourceFileLanguageObjCPP:
                
                return [ WORKSPACE iconForFileType: @"mm" ];
                
            case CESourceFileLanguageHeader:
                
                return [ WORKSPACE iconForFileType: @"h" ];
                
            case CESourceFileLanguageNone:
            default:
                
                break;
        }
    }
    
    return [ WORKSPACE iconForFileType: @"" ];
}

- ( void )save
{
    [ self save: NULL ];
}

- ( BOOL )save: ( NSError ** )error
{
    ( void )error;
    
    return YES;
}

- ( BOOL )isEqual: ( id )object
{
    CEDocument * document;
    
    if( [ object isKindOfClass: [ self class ] ] == NO )
    {
        return NO;
    }
    
    document = object;
    
    if( self.file == nil || document.file == nil )
    {
        return [ self.name isEqualToString: document.name ];
    }
    
    return [ self.file.path isEqualToString: document.file.path ] && self.sourceFile.language == document.sourceFile.language;
}

@end
