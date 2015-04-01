
/* $Id$ */

#import "CELinkerObject.h"
#import "CEPreferences.h"

@implementation CELinkerObject

@synthesize type        = _type;
@synthesize language    = _language;
@synthesize path        = _path;

+ ( NSArray * )linkerObjects
{
    NSArray         * rawObjects;
    NSMutableArray  * objects;
    NSDictionary    * rawObject;
    NSString        * path;
    NSNumber        * type;
    NSNumber        * language;
    CELinkerObject  * object;
    
    objects     = [ NSMutableArray arrayWithCapacity: 25 ];
    rawObjects  = [ [  CEPreferences sharedInstance ] linkerObjects ];
    
    for( rawObject in rawObjects )
    {
        path        = rawObject[@"Path"];
        type        = rawObject[@"Type"];
        language    = rawObject[@"Language"];
        
        if( path == nil || type == nil || language == nil )
        {
            continue;
        }
        
        object = [ self linkerObjectWithPath: path type: ( CELinkerObjectType )[ type integerValue ] language: ( CESourceFileLanguage )[ language integerValue ] ];
        
        if( object == nil )
        {
            continue;
        }
        
        [ objects addObject: object ];
    }
    
    return [ NSArray arrayWithArray: objects ];
}

+ ( NSArray * )linkerObjectsWithType: ( CELinkerObjectType )type
{
    NSArray        * allobjects;
    NSMutableArray * objects;
    CELinkerObject * object;
    
    objects     = [ NSMutableArray arrayWithCapacity: 25 ];
    allobjects  = [ self linkerObjects ];
    
    for( object in allobjects )
    {
        if( object.type == type )
        {
            [ objects addObject: object ];
        }
    }
    
    return [ NSArray arrayWithArray: objects ];
}

+ ( instancetype )linkerObjectWithPath: ( NSString * )path type: ( CELinkerObjectType )type
{
    return [ self linkerObjectWithPath: path type: type language: CESourceFileLanguageNone ];
}

+ ( instancetype )linkerObjectWithPath: ( NSString * )path type: ( CELinkerObjectType )type language: ( CESourceFileLanguage )language
{
    return[self.alloc 
         initWithPath: path type: type language: language ];
}

- ( instancetype )initWithPath: ( NSString * )path type: ( CELinkerObjectType )type
{
    return [ self initWithPath: path type: type language: CESourceFileLanguageNone ];
}

- ( instancetype )initWithPath: ( NSString * )path type: ( CELinkerObjectType )type language: ( CESourceFileLanguage )language
{
    if( ( self = [ self init ] ) )
    {
        if( [ FILE_MANAGER fileExistsAtPath: path ] == NO )
        {
            
            return nil;
        }
        
        _path       = [ path copy ];
        _type       = type;
        _language   = language;
    }
    
    return self;
}


- ( NSString * )name
{
    return [ FILE_MANAGER displayNameAtPath: _path ];
}

- ( NSImage * )icon
{
    return [ WORKSPACE iconForFile: _path ];
}

@end
