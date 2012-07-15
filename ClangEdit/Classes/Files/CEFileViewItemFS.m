/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFileViewItemFS.h"
#import "CEPreferences.h"

@implementation CEFileViewItemFS

- ( id )initWithType: ( CEFileViewItemType )type name: ( NSString * )name
{
    NSRange range;
    
    if( ( self = [ super initWithType: type name: name ] ) )
    {
        range = [ _name rangeOfString: @":" ];
        
        if( range.location == NSNotFound )
        {
            _path   = [ _name copy ];
            _prefix = nil;
        }
        else
        {
            _path   = [ [ _name substringFromIndex: range.location + 1 ] copy ];
            _prefix = [ [ _name substringToIndex: range.location ] copy ];
        }
        
        if( [ FILE_MANAGER fileExistsAtPath: _path isDirectory: &_isDirectory ] == NO )
        {
            [ self release ];
            
            return nil;
        }
    }
    
    return self;
}

- ( void )dealloc
{
    RELEASE_IVAR( _path );
    
    [ super dealloc ];
}

- ( id )copyWithZone: ( NSZone * )zone
{
    CEFileViewItemFS * item;
    
    item = [ super copyWithZone: zone ];
    
    if( item != nil )
    {
        [ item->_path   release ];
        [ item->_prefix release ];
        
        item->_path        = [ _path   copy ];
        item->_prefix      = [ _prefix copy ];
        item->_isDirectory = _isDirectory;
    }
    
    return item;
}

- ( NSString * )displayName
{
    return [ FILE_MANAGER displayNameAtPath: _path ];
}

- ( NSImage * )icon
{
    return [ [ NSWorkspace sharedWorkspace ] iconForFile: _path ];
}

- ( BOOL )expandable
{
    return _isDirectory && self.children.count > 0;
}

- ( NSArray * )children
{
    NSDirectoryEnumerator * enumerator;
    NSString              * file;
    NSString              * path;
    NSString              * name;
    CEFileViewItem        * item;
    CFURLRef                url;
    LSItemInfoRecord        info;
    BOOL                    invisible;
    BOOL                    showHidden;
    
    if( super.children.count > 0 )
    {
        return [ super children ];
    }
    
    showHidden = [ [ CEPreferences sharedInstance ] showHiddenFiles ];
    enumerator = [ FILE_MANAGER enumeratorAtPath: _path ];
    
    while( ( file = [ enumerator nextObject ] ) )
    {
        [ enumerator skipDescendants ];
        
        path = [ _path stringByAppendingPathComponent: file ];
        
        if( showHidden == NO )
        {
            if( [ path isEqualToString: @"/dev"  ] ) { continue; }
            if( [ path isEqualToString: @"/home" ] ) { continue; }
            if( [ path isEqualToString: @"/net"  ] ) { continue; }
        }
        
        if( _prefix == nil )
        {
            name = [ _path stringByAppendingFormat: @":%@", path ];
        }
        else
        {
            name = [ _prefix stringByAppendingFormat: @":%@", path ];
        }
        
        item = [ CEFileViewItem fileViewItemWithType: _type name: name ];
        url  = CFURLCreateWithFileSystemPath( kCFAllocatorDefault, ( CFStringRef )path, kCFURLPOSIXPathStyle, YES );
        
        LSCopyItemInfoForURL( url, kLSRequestAllFlags, &info );
        
        invisible = info.flags & kLSItemInfoIsInvisible;
        
        if( item != nil && ( invisible == NO || showHidden == YES ) )
        {
            [ self addChild: item ];
        }
        
        CFRelease( url );
    }
    
    return super.children;
}

- ( id )valueForKeyPath: ( NSString * )keyPath
{
    CEFileViewItem * item;
    
    [ self children ];
    
    for( item in self.children )
    {
        if( [ item.name isEqualToString: keyPath ] )
        {
            return item;
        }
        else if( [ keyPath hasPrefix: item.name ] )
        {
            return [ item valueForKeyPath: keyPath ];
        }
    }
    
    return nil;
}

- ( BOOL )isLeaf
{
    return ( _isDirectory == YES ) ? NO : YES;
}

@end
