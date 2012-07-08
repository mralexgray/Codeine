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
    if( ( self = [ super initWithType: type name: name ] ) )
    {
        if( [ FILE_MANAGER fileExistsAtPath: name isDirectory: &_isDirectory ] == NO )
        {
            [ self release ];
            
            return nil;
        }
    }
    
    return self;
}

- ( NSString * )name
{
    return [ FILE_MANAGER displayNameAtPath: _name ];
}

- ( NSImage * )icon
{
    return [ [ NSWorkspace sharedWorkspace ] iconForFile: _name ];
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
    CEFileViewItem        * item;
    CFURLRef                url;
    LSItemInfoRecord        info;
    BOOL                    invisible;
    BOOL                    showHidden;
    
    if( _children.count > 0 )
    {
        return [ super children ];
    }
    
    showHidden = [ [ CEPreferences sharedInstance ] showHiddenFiles ];
    enumerator = [ FILE_MANAGER enumeratorAtPath: _name ];
    
    while( ( file = [ enumerator nextObject ] ) )
    {
        [ enumerator skipDescendants ];
        
        path = [ _name stringByAppendingPathComponent: file ];
        
        if( showHidden == NO )
        {
            if( [ path isEqualToString: @"/dev"  ] ) { continue; }
            if( [ path isEqualToString: @"/home" ] ) { continue; }
            if( [ path isEqualToString: @"/net"  ] ) { continue; }
        }
        
        item = [ CEFileViewItem fileViewItemWithType: _type name: path ];
        url  = CFURLCreateWithFileSystemPath( kCFAllocatorDefault, ( CFStringRef )path, kCFURLPOSIXPathStyle, YES );
        
        LSCopyItemInfoForURL( url, kLSRequestAllFlags, &info );
        
        invisible = info.flags & kLSItemInfoIsInvisible;
        
        if( item != nil && ( invisible == NO || showHidden == YES ) )
        {
            [ _children addObject: item ];
        }
    }
    
    return _children;
}

@end
