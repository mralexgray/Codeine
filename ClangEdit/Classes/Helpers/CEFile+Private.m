/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFile+Private.h"

@implementation CEFile( Private )

- ( void )getPropertiesFromAttributes: ( NSDictionary * )attributes
{
    NSRect            rect;
    CGImageRef        cgImage;
    NSUInteger        u;
    NSUInteger        g;
    NSUInteger        o;
    NSUInteger        i;
    NSUInteger        permissions;
    NSImage         * icon;
    NSDateFormatter * dateFormatter;
    NSString        * humanPermissions;
    
    _name       = [ [ FILE_MANAGER displayNameAtPath: _path ] retain ];
    _isPackage  = [ [ NSWorkspace sharedWorkspace ] isFilePackageAtPath: _path ];
    _kind       = [ [ [ NSWorkspace sharedWorkspace ] localizedDescriptionForType: [ [ NSWorkspace sharedWorkspace ] typeOfFile: _path error: NULL ] ] retain ];
    
    icon    = [ [ NSWorkspace sharedWorkspace ] iconForFile: _path ];
    rect    = NSMakeRect( ( CGFloat )0, ( CGFloat )0, ( CGFloat )512, ( CGFloat )512 );
    cgImage = [ icon CGImageForProposedRect: &rect context: nil hints: nil ];
    _icon   = [ [ NSImage alloc ] initWithCGImage: cgImage size: NSMakeSize( ( CGFloat )512, ( CGFloat )512 ) ];
    
    [ _url getResourceValue: &_labelColor forKey: NSURLLabelColorKey error: NULL ];
    
    _bytes = [ ( NSNumber * )[ attributes objectForKey: NSFileSize ] unsignedIntegerValue ];
    _size  = [ [ NSString stringForDataSizeWithBytes: _bytes ] retain ];
    
    _creationDate       = [ [ attributes objectForKey: NSFileCreationDate ] retain ];
    _modificationDate   = [ [ attributes objectForKey: NSFileModificationDate ] retain ];
    
    dateFormatter                               = [ NSDateFormatter new ];
    dateFormatter.doesRelativeDateFormatting    = YES;
    dateFormatter.dateStyle                     = NSDateFormatterLongStyle;
    dateFormatter.timeStyle                     = NSDateFormatterShortStyle;
    
    _creationTime       = [ [ dateFormatter stringFromDate: _creationDate ] retain ];
    _modificationTime   = [ [ dateFormatter stringFromDate: _modificationDate ] retain ];
    
    _owner      = [ [ attributes objectForKey: NSFileOwnerAccountName ] retain ];
    _group      = [ [ attributes objectForKey: NSFileGroupOwnerAccountName ] retain ];
    _ownerID    = [ ( NSNumber * )[ attributes objectForKey: NSFileOwnerAccountID ] unsignedIntegerValue ];
    _groupID    = [ ( NSNumber * )[ attributes objectForKey: NSFileGroupOwnerAccountID ] unsignedIntegerValue ];
    
    _permissions = [ ( NSNumber * )[ attributes objectForKey: NSFilePosixPermissions ] unsignedIntegerValue ];
    permissions  = _permissions;
    
    u = permissions / 64;
    g = ( permissions - ( 64 * u ) ) / 8;
    o = ( permissions - ( 64 * u ) ) - ( 8 * g );
    
    _octalPermissions   = ( u * 100 ) + ( g * 10 ) + o;
    humanPermissions    = @"";
    
    for( i = 0; i < 3; i++ )
    {
        humanPermissions    = [ [ NSString stringWithFormat: @"%@%@%@ ", ( permissions & 4 ) ? @"r" : @"-", ( permissions & 2 ) ? @"w" : @"-", ( permissions & 1 ) ? @"x" : @"-" ] stringByAppendingString: humanPermissions ];
        permissions         = permissions >> 3;
    }
    
    _humanPermissions = [ humanPermissions retain ];
    
    _readable   = [ FILE_MANAGER isReadableFileAtPath: _path ];
    _writable   = [ FILE_MANAGER isWritableFileAtPath: _path ];
}

@end
