/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@interface CEFile: NSObject
{
@protected
    
    NSString * _path;
    NSURL    * _url;
    NSString * _name;
    BOOL       _isDirectory;
    BOOL       _isPackage;
    NSString * _kind;
    NSImage  * _icon;
    NSColor  * _labelColor;
    NSUInteger _bytes;
    NSString * _size;
    NSDate   * _creationDate;
    NSDate   * _modificationDate;
    NSString * _creationTime;
    NSString * _modificationTime;
    NSString * _owner;
    NSString * _group;
    NSUInteger _ownerID;
    NSUInteger _groupID;
    NSUInteger _permissions;
    NSUInteger _octalPermissions;
    NSString * _humanPermissions;
    BOOL       _readable;
    BOOL       _writable;
    
@private
    
    RESERVERD_IVARS( CEFile, 5 );
}

@property( atomic, readonly ) NSString   * path;
@property( atomic, readonly ) NSURL      * url;
@property( atomic, readonly ) NSString   * name;
@property( atomic, readonly ) BOOL         isDirectory;
@property( atomic, readonly ) BOOL         isPackage;
@property( atomic, readonly ) NSString   * kind;
@property( atomic, readonly ) NSImage    * icon;
@property( atomic, readonly ) NSColor    * labelColor;
@property( atomic, readonly ) NSUInteger   bytes;
@property( atomic, readonly ) NSString   * size;
@property( atomic, readonly ) NSDate     * creationDate;
@property( atomic, readonly ) NSDate     * modificationDate;
@property( atomic, readonly ) NSString   * creationTime;
@property( atomic, readonly ) NSString   * modificationTime;
@property( atomic, readonly ) NSString   * owner;
@property( atomic, readonly ) NSString   * group;
@property( atomic, readonly ) NSUInteger   ownerID;
@property( atomic, readonly ) NSUInteger   groupID;
@property( atomic, readonly ) NSUInteger   permissions;
@property( atomic, readonly ) NSUInteger   octalPermissions;
@property( atomic, readonly ) NSString   * humanPermissions;
@property( atomic, readonly ) BOOL         readable;
@property( atomic, readonly ) BOOL         writable;

+ ( id )fileWithPath: ( NSString * )path;
+ ( id )fileWithURL: ( NSURL * )url;
- ( id )initWithPath: ( NSString * )path;
- ( id )initWithURL: ( NSURL * )url;
- ( void )refresh;

@end
