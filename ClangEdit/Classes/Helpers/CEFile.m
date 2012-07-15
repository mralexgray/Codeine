/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFile.h"
#import "CEFile+Private.h"

@implementation CEFile

@synthesize path                = _path;
@synthesize url                 = _url;
@synthesize name                = _name;
@synthesize isDirectory         = _isDirectory;
@synthesize isPackage           = _isPackage;
@synthesize kind                = _kind;
@synthesize icon                = _icon;
@synthesize labelColor          = _labelColor;
@synthesize bytes               = _bytes;
@synthesize size                = _size;
@synthesize creationDate        = _creationDate;
@synthesize modificationDate    = _modificationDate;
@synthesize creationTime        = _creationTime;
@synthesize modificationTime    = _modificationTime;
@synthesize owner               = _owner;
@synthesize ownerID             = _ownerID;
@synthesize group               = _group;
@synthesize groupID             = _groupID;
@synthesize permissions         = _permissions;
@synthesize octalPermissions    = _octalPermissions;
@synthesize humanPermissions    = _humanPermissions;
@synthesize readable            = _readable;
@synthesize writable            = _writable;

+ ( id )fileWithPath: ( NSString * )path
{
    return [ [ [ self alloc ] initWithPath: path ] autorelease ];
}

+ ( id )fileWithURL: ( NSURL * )url
{
    return [ [ [ self alloc ] initWithURL: url ] autorelease ];
}

- ( id )initWithPath: ( NSString * )path
{
    if( ( self = [ self initWithURL: [ NSURL fileURLWithPath: path ] ] ) )
    {}
    
    return self;
}

- ( id )initWithURL: ( NSURL * )url
{
    NSDictionary * attributes;
    NSError      * error;
    
    if( ( self = [ self init ] ) )
    {
        _url    = [ url retain ];
        _path   = [ [ _url path ] retain ];
        
        if( [ FILE_MANAGER fileExistsAtPath: _path isDirectory: &_isDirectory ] == NO )
        {
            [ self release ];
            
            return nil;
        }
        
        error       = nil;
        attributes  = [ FILE_MANAGER attributesOfItemAtPath: _path error: &error ];
        
        if( attributes.count == 0 || error != nil )
        {
            [ self release ];
            
            return nil;
        }
        
        [ self getPropertiesFromAttributes: attributes ];
    }
    
    return self;
}

- ( void )dealloc
{
    RELEASE_IVAR( _path );
    RELEASE_IVAR( _url );
    RELEASE_IVAR( _name );
    RELEASE_IVAR( _kind );
    RELEASE_IVAR( _icon );
    RELEASE_IVAR( _labelColor );
    RELEASE_IVAR( _size );
    RELEASE_IVAR( _creationDate );
    RELEASE_IVAR( _modificationDate );
    RELEASE_IVAR( _creationTime );
    RELEASE_IVAR( _modificationTime );
    RELEASE_IVAR( _owner );
    RELEASE_IVAR( _group );
    RELEASE_IVAR( _humanPermissions );
    
    [ super dealloc ];
}

- ( void )refresh
{
    NSDictionary * attributes;
    NSError      * error;
    
    RELEASE_IVAR( _path );
    RELEASE_IVAR( _url );
    RELEASE_IVAR( _name );
    RELEASE_IVAR( _kind );
    RELEASE_IVAR( _icon );
    RELEASE_IVAR( _labelColor );
    RELEASE_IVAR( _size );
    RELEASE_IVAR( _creationDate );
    RELEASE_IVAR( _modificationDate );
    RELEASE_IVAR( _creationTime );
    RELEASE_IVAR( _modificationTime );
    RELEASE_IVAR( _owner );
    RELEASE_IVAR( _group );
    RELEASE_IVAR( _humanPermissions );
    
    error       = nil;
    attributes  = [ FILE_MANAGER attributesOfItemAtPath: _path error: &error ];
    
    if( attributes.count > 0 && error == nil )
    {
        [ self getPropertiesFromAttributes: attributes ];
    }
    
}

@end
