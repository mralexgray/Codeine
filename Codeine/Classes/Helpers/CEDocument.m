
/* $Id$ */

#import "CEDocument.h"
#import "CEDocument+Private.h"
#import "CEFile.h"
#import "CEPreferences.h"
#import "CEUUID.h"

@implementation CEDocument

@synthesize file        = _file;
@synthesize sourceFile  = _sourceFile;
@synthesize name        = _name;
@synthesize uuid        = _uuid;

+ ( id )documentWithPath: ( NSString * )path
{
    return [ [ self alloc ] initWithPath: path ];
}

+ ( id )documentWithURL: ( NSURL * )url
{
    return [ [ self alloc ] initWithURL: url ];
}

+ ( id )documentWithLanguage: ( CESourceFileLanguage )language
{
    return [ [ self alloc ] initWithLanguage: language ];
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
            
            return nil;
        }
        
        _name = [ _file.name copy ];
        _uuid = [ CEUUID new ];
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
            
            return nil;
        }
        
        _name = [ [ self nameForNewDocument ] copy ];
        _uuid = [ CEUUID new ];
    }
    
    return self;
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
