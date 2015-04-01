
/* $Id$ */

#import "CEFile.h"
#import "CEFile+Private.h"

@implementation CEFile

@synthesize path        = _path;
@synthesize url         = _url;
@synthesize isDirectory = _isDirectory;
@synthesize isPackage   = _isPackage;
@synthesize readable    = _readable;
@synthesize writable    = _writable;

+ ( instancetype )fileWithPath: ( NSString * )path
{
    return[self.alloc 
         initWithPath: path ];
}

+ ( instancetype )fileWithURL: ( NSURL * )url
{
    return[self.alloc 
         initWithURL: url ];
}

- ( instancetype )initWithPath: ( NSString * )path
{
    if( ( self = [ self initWithURL: [ NSURL fileURLWithPath: path ] ] ) )
    {}
    
    return self;
}

- ( instancetype )initWithURL: ( NSURL * )url
{
    NSDictionary * attributes;
    NSError      * error;
    
    if( ( self = [ self init ] ) )
    {
        _url    = url;
        _path   = [ _url path ];
        
        if( [ FILE_MANAGER fileExistsAtPath: _path isDirectory: &_isDirectory ] == NO )
        {
            
            return nil;
        }
        
        error       = nil;
        attributes  = [ FILE_MANAGER attributesOfItemAtPath: _path error: &error ];
        
        if( attributes.count == 0 || error != nil )
        {
            
            return nil;
        }
        
        _attributes = attributes;
        _isPackage  = [ WORKSPACE isFilePackageAtPath: _path ];
        _readable   = [ FILE_MANAGER isReadableFileAtPath: _path ];
        _writable   = [ FILE_MANAGER isWritableFileAtPath: _path ];
    }
    
    return self;
}

- ( void )dealloc
{
    RELEASE_IVAR( _attributes );
    RELEASE_IVAR( _name );
    RELEASE_IVAR( _kind );
    RELEASE_IVAR( _icon );
    RELEASE_IVAR( _labelColor );
    RELEASE_IVAR( _size );
    RELEASE_IVAR( _creationDate );
    RELEASE_IVAR( _modificationDate );
    RELEASE_IVAR( _lastOpenedDate );
    RELEASE_IVAR( _creationTime );
    RELEASE_IVAR( _modificationTime );
    RELEASE_IVAR( _lastOpenedTime );
    RELEASE_IVAR( _owner );
    RELEASE_IVAR( _group );
    RELEASE_IVAR( _humanPermissions );
    
}

- ( void )refresh
{
    NSDictionary * attributes;
    NSError      * error;
    
    RELEASE_IVAR( _attributes );
    RELEASE_IVAR( _name );
    RELEASE_IVAR( _kind );
    RELEASE_IVAR( _icon );
    RELEASE_IVAR( _labelColor );
    RELEASE_IVAR( _size );
    RELEASE_IVAR( _creationDate );
    RELEASE_IVAR( _modificationDate );
    RELEASE_IVAR( _lastOpenedDate );
    RELEASE_IVAR( _creationTime );
    RELEASE_IVAR( _modificationTime );
    RELEASE_IVAR( _lastOpenedTime );
    RELEASE_IVAR( _owner );
    RELEASE_IVAR( _group );
    RELEASE_IVAR( _humanPermissions );
    
    error       = nil;
    attributes  = [ FILE_MANAGER attributesOfItemAtPath: _path error: &error ];
    
    if( attributes.count > 0 && error == nil )
    {
        _attributes = attributes;
    }
}

- ( NSString * )name
{
    if( _name == nil )
    {
        _name = [ FILE_MANAGER displayNameAtPath: _path ];
    }
    
    return _name;
}

- ( NSString * )kind
{
    NSString * type;
    
    if( _kind == nil )
    {
        type  = [ WORKSPACE typeOfFile: _path error: NULL ];
        _kind = [ WORKSPACE localizedDescriptionForType: type ];
    }
    
    return _kind;
}

- ( NSColor * )labelColor
{
    if( _labelColor == nil )
    {
      NSColor *c = nil;
        [ _url getResourceValue: &c forKey: NSURLLabelColorKey error: NULL ];
        _labelColor = c;
    }
    
    return _labelColor;
}

- ( NSImage * )icon
{
    NSImage  * icon;
    CGImageRef cgImage;
    NSRect     rect;
    
    if( _icon == nil )
    {
        icon    = [ WORKSPACE iconForFile: _path ];
        rect    = NSMakeRect( ( CGFloat )0, ( CGFloat )0, ( CGFloat )512, ( CGFloat )512 );
        cgImage = [ icon CGImageForProposedRect: &rect context: nil hints: nil ];
        _icon   =[NSImage.alloc 
         initWithCGImage: cgImage size: NSMakeSize( ( CGFloat )512, ( CGFloat )512 ) ];
    }
    
    return _icon;
}

- ( NSUInteger )bytes
{
    if( _bytes == 0 )
    {
        _bytes = [ ( NSNumber * )_attributes[NSFileSize] unsignedIntegerValue ];
    }
    
    return _bytes;
}

- ( NSString * )size
{
    if( _size == nil )
    {
        _size = [ NSString stringForDataSizeWithBytes: self.bytes ];
    }
    
    return _size;
}

- ( NSDate * )creationDate
{
    if( _creationDate == nil )
    {
        _creationDate = _attributes[NSFileCreationDate];
    }
    
    return _creationDate;
}

- ( NSDate * )modificationDate
{
    if( _modificationDate == nil )
    {
        _modificationDate = _attributes[NSFileModificationDate];
    }
    
    return _modificationDate;
}

- ( NSDate * )lastOpenedDate
{
    if( _lastOpenedDate == nil )
    {
        NSDate *d = nil;
        [ self.url getResourceValue: &d forKey: NSURLContentAccessDateKey error: NULL ];
        _lastOpenedDate =d;
    }
    
    return _lastOpenedDate;
}

- ( NSString * )creationTime
{
    NSDateFormatter * dateFormatter;
    
    if( _creationTime == nil )
    {
        dateFormatter                               = [ NSDateFormatter new ];
        dateFormatter.doesRelativeDateFormatting    = YES;
        dateFormatter.dateStyle                     = NSDateFormatterLongStyle;
        dateFormatter.timeStyle                     = NSDateFormatterShortStyle;
        
        _creationTime = [ dateFormatter stringFromDate: self.creationDate ];
        
    }
    
    return _creationTime;
}

- ( NSString * )modificationTime
{
    NSDateFormatter * dateFormatter;
    
    if( _modificationTime == nil )
    {
        dateFormatter                               = [ NSDateFormatter new ];
        dateFormatter.doesRelativeDateFormatting    = YES;
        dateFormatter.dateStyle                     = NSDateFormatterLongStyle;
        dateFormatter.timeStyle                     = NSDateFormatterShortStyle;
        
        _modificationTime = [ dateFormatter stringFromDate: self.modificationDate ];
        
    }
    
    return _modificationTime;
}

- ( NSString * )lastOpenedTime
{
    NSDateFormatter * dateFormatter;
    
    if( _lastOpenedTime == nil )
    {
        dateFormatter                               = [ NSDateFormatter new ];
        dateFormatter.doesRelativeDateFormatting    = YES;
        dateFormatter.dateStyle                     = NSDateFormatterLongStyle;
        dateFormatter.timeStyle                     = NSDateFormatterShortStyle;
        
        _lastOpenedTime = [ dateFormatter stringFromDate: self.lastOpenedDate ];
        
    }
    
    return _lastOpenedTime;
}

- ( NSString * )owner
{
    if( _hasPermissions == NO )
    {
        [ self getPermissions ];
    }
    
    return _owner;
}

- ( NSString * )group
{
    if( _hasPermissions == NO )
    {
        [ self getPermissions ];
    }
    
    return _group;
}

- ( NSUInteger )ownerID
{
    if( _hasPermissions == NO )
    {
        [ self getPermissions ];
    }
    
    return _ownerID;
}

- ( NSUInteger )groupID
{
    if( _hasPermissions == NO )
    {
        [ self getPermissions ];
    }
    
    return _groupID;
}

- ( NSUInteger )permissions
{
    if( _hasPermissions == NO )
    {
        [ self getPermissions ];
    }
    
    return _permissions;
}

- ( NSUInteger )octalPermissions
{
    if( _hasPermissions == NO )
    {
        [ self getPermissions ];
    }
    
    return _octalPermissions;
}

- ( NSString * )humanPermissions
{
    if( _hasPermissions == NO )
    {
        [ self getPermissions ];
    }
    
    return _humanPermissions;
}

@end
