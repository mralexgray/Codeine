
/* $Id$ */

#import "CEDocument.h"
#import "CEFile.h"
#import "CEPreferences.h"

@interface CEDocument ()

@property (readonly, copy) NSString *nameForNewDocument;

@end

@implementation CEDocument

@synthesize file        = _file, sourceFile  = _sourceFile, name        = _name, uuid        = _uuid;

+ ( instancetype )documentWithPath: ( NSString * )path
{
    return[self.alloc 
         initWithPath: path ];
}

+ ( instancetype )documentWithURL: ( NSURL * )url
{
    return[self.alloc 
         initWithURL: url ];
}

+ ( instancetype )documentWithLanguage: ( CESourceFileLanguage )language
{
    return[self.alloc 
         initWithLanguage: language ];
}

- ( instancetype )initWithPath: ( NSString * )path
{
    if( ( self = [ self initWithURL: [ NSURL fileURLWithPath: path ] ] ) )
    {}
    
    return self;
}

- ( instancetype )initWithURL: ( NSURL * )url
{
    NSDictionary        * types;
    NSString            * extension;
    NSNumber            * value;
    CESourceFileLanguage  language;
    
    if( ( self = [ self init ] ) )
    {
        _file =[CEFile.alloc 
         initWithURL: url ];
    
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
                value    = types[extension];
                language = ( CESourceFileLanguage )[ value integerValue ];
                
                break;
            }
        }
        
        _sourceFile =[CESourceFile.alloc 
         initWithLanguage: language fromFile: _file.path ];
        
        if( _sourceFile == nil )
        {
            
            return nil;
        }
        
        _name = [ _file.name copy ];
        _uuid = [ NSUUID new ];
    }
    
    return self;
}

- ( instancetype )initWithLanguage: ( CESourceFileLanguage )language
{
    if( ( self = [ self init ] ) )
    {
        _sourceFile =[CESourceFile.alloc 
         initWithLanguage: language ];
        
        if( _sourceFile == nil )
        {
            
            return nil;
        }
        
        _name = [ [ self nameForNewDocument ] copy ];
        _uuid = [ NSUUID new ];
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


static NSUInteger       __newDocumentIndex = 0;
static NSString * const __newDocumentName  = @"Untitled";

// Private

- ( NSString * )nameForNewDocument
{
    NSString * name;
    
    if( __newDocumentIndex == 0 )
    {
        name = __newDocumentName;
    }
    else
    {
        name = [ NSString stringWithFormat: @"%@-%lu", __newDocumentName, __newDocumentIndex ];
    }
    
    __newDocumentIndex++;
    
    return name;
}

@end
