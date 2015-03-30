
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
        path        = [ rawObject objectForKey: @"Path" ];
        type        = [ rawObject objectForKey: @"Type" ];
        language    = [ rawObject objectForKey: @"Language" ];
        
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
        if( [ FILE_MANAGER fileExistsAtPath: path ] == NO )
        {
            [ self release ];
            
            return nil;
        }
        
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
    return [ WORKSPACE iconForFile: _path ];
}

@end
