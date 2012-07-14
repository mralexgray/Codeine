/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEInfoWindowController.h"
#import "CEInfoWindowController+Private.h"
#import "CEInfoWindowController+NSOutlineViewDataSource.h"
#import "CEInfoWindowController+NSOutlineViewDelegate.h"

@implementation CEInfoWindowController

@synthesize path                            = _path;
@synthesize outlineView                     = _outlineView;
@synthesize infoView                        = _infoView;
@synthesize generalLabelView                = _generalLabelView;
@synthesize iconLabelView                   = _iconLabelView;
@synthesize permissionsLabelView            = _permissionsLabelView;
@synthesize generalView                     = _generalView;
@synthesize iconView                        = _iconView;
@synthesize permissionsView                 = _permissionsView;
@synthesize smallIconView                   = _smallIconView;
@synthesize largeIconView                   = _largeIconView;
@synthesize infoNameTextField               = _infoNameTextField;
@synthesize infoSizeTextField               = _infoSizeTextField;
@synthesize infoDateTextField               = _infoDateTextField;
@synthesize generalKindTextField            = _generalKindTextField;
@synthesize generalSizeTextField            = _generalSizeTextField;
@synthesize generalPathTextField            = _generalPathTextField;
@synthesize generalCTimeTextField           = _generalCTimeTextField;
@synthesize generalMTimeTextField           = _generalMTimeTextField;
@synthesize permissionsReadableTextField    = _permissionsReadableTextField;
@synthesize permissionsWriteableTextField   = _permissionsWriteableTextField;
@synthesize permissionsOwnerTextField       = _permissionsOwnerTextField;
@synthesize permissionsGroupTextField       = _permissionsGroupTextField;
@synthesize permissionsOctalTextField       = _permissionsOctalTextField;
@synthesize permissionsHumanTextField       = _permissionsHumanTextField;

- ( id )initWithPath: ( NSString * )path
{
    NSError * error;
    
    if( ( self = [ self init ] ) )
    {
        if( [ FILE_MANAGER fileExistsAtPath: path isDirectory: &_isDirectory ] == NO )
        {
            [ self release ];
            
            return nil;
        }
        
        error       = nil;
        _path       = [ path copy ];
        _attributes = [ FILE_MANAGER attributesOfItemAtPath: _path error: &error ];
        
        if( _attributes == nil || error != nil )
        {
            [ self release ];
            
            return nil;
        }
        
        [ _attributes retain ];
    }
    
    return self;
}

- ( void )dealloc
{
    RELEASE_IVAR( _path );
    RELEASE_IVAR( _attributes );
    RELEASE_IVAR( _outlineView );
    RELEASE_IVAR( _infoView );
    RELEASE_IVAR( _generalLabelView );
    RELEASE_IVAR( _iconLabelView );
    RELEASE_IVAR( _permissionsLabelView );
    RELEASE_IVAR( _generalView );
    RELEASE_IVAR( _iconView );
    RELEASE_IVAR( _permissionsView );
    RELEASE_IVAR( _smallIconView );
    RELEASE_IVAR( _largeIconView );
    RELEASE_IVAR( _infoNameTextField );
    RELEASE_IVAR( _infoSizeTextField );
    RELEASE_IVAR( _infoDateTextField );
    RELEASE_IVAR( _generalKindTextField );
    RELEASE_IVAR( _generalSizeTextField );
    RELEASE_IVAR( _generalPathTextField );
    RELEASE_IVAR( _generalCTimeTextField );
    RELEASE_IVAR( _permissionsView );
    RELEASE_IVAR( _generalMTimeTextField );
    RELEASE_IVAR( _permissionsReadableTextField );
    RELEASE_IVAR( _permissionsWriteableTextField );
    RELEASE_IVAR( _permissionsOwnerTextField );
    RELEASE_IVAR( _permissionsGroupTextField );
    RELEASE_IVAR( _permissionsOctalTextField );
    RELEASE_IVAR( _permissionsHumanTextField );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    NSRect            rect;
    CGImageRef        cgImage;
    NSImage         * icon;
    NSDateFormatter * dateFormatter;
    NSString        * kind;
    uint64_t          bytes;
    NSUInteger        permissions;
    NSUInteger        u;
    NSUInteger        g;
    NSUInteger        o;
    NSUInteger        i;
    NSString        * humanPermissions;
    
    self.window.title = _path.lastPathComponent;
    
    _outlineView.delegate         = self;
    _outlineView.dataSource       = self;
    _outlineView.intercellSpacing = CGSizeMake( ( CGFloat )0, ( CGFloat )0 );
    
    [ self resizeWindow: NO ];
    
    icon    = [ [ NSWorkspace sharedWorkspace ] iconForFile: _path ];
    rect    = NSMakeRect( ( CGFloat )0, ( CGFloat )0, ( CGFloat )512, ( CGFloat )512 );
    cgImage = [ icon CGImageForProposedRect: &rect context: nil hints: nil ];
    icon    = [ [ [ NSImage alloc ] initWithCGImage: cgImage size: NSMakeSize( ( CGFloat )512, ( CGFloat )512 ) ] autorelease ];
    
    [ _smallIconView setImage: icon ];
    [ _largeIconView setImage: icon ];
    
    bytes = [ [ _attributes objectForKey: NSFileSize ] unsignedLongLongValue ];
    kind  = [ [ NSWorkspace sharedWorkspace ] localizedDescriptionForType: [ [ NSWorkspace sharedWorkspace ] typeOfFile: _path error: NULL ] ];
    
    [ _infoNameTextField    setStringValue: [ FILE_MANAGER displayNameAtPath: _path ] ];
    [ _generalKindTextField setStringValue: [ kind capitalizedString ] ];
    [ _generalPathTextField setStringValue: [ _path stringByDeletingLastPathComponent ] ];
    
    if( _isDirectory == YES )
    {
        [ _infoSizeTextField    setStringValue: @"--" ];
        [ _generalSizeTextField setStringValue: @"--" ];
    }
    else
    {
        [ _infoSizeTextField    setStringValue: [ NSString stringForDataSizeWithBytes: bytes ] ];
        
        if( bytes > 1000 )
        {
            [ _generalSizeTextField setStringValue: [ NSString stringWithFormat: @"%@ (%@)",
                                                        [ NSString stringForDataSizeWithBytes: bytes unit: CEStringDataSizeTypeBytes ],
                                                        [ NSString stringForDataSizeWithBytes: bytes ]
                                                    ]
            ];
        }
        else
        {
            [ _generalSizeTextField setStringValue: [ NSString stringForDataSizeWithBytes: bytes unit: CEStringDataSizeTypeBytes ] ];
        }
    }
    
    permissions         = [ ( NSNumber * )[ _attributes objectForKey: NSFilePosixPermissions ] unsignedIntegerValue ];
    u                   = permissions / 64;
    g                   = ( permissions - ( 64 * u ) ) / 8;
    o                   = ( permissions - ( 64 * u ) ) - ( 8 * g );
    humanPermissions    = @"";
    
    for( i = 0; i < 3; i++ )
    {
        humanPermissions    = [ [ NSString stringWithFormat: @"%@%@%@ ", ( permissions & 4 ) ? @"r" : @"-", ( permissions & 2 ) ? @"w" : @"-", ( permissions & 1 ) ? @"x" : @"-" ] stringByAppendingString: humanPermissions ];
        permissions         = permissions >> 3;
    }
    
    [ _permissionsHumanTextField setStringValue: humanPermissions ];
    [ _permissionsOctalTextField setStringValue: [ NSString stringWithFormat: @"%03lu", ( u * 100 ) + ( g * 10 ) + o ] ];
    [ _permissionsOwnerTextField setStringValue: [ _attributes objectForKey: NSFileOwnerAccountName ] ];
    [ _permissionsGroupTextField setStringValue: [ _attributes objectForKey: NSFileGroupOwnerAccountName ] ];
    
    dateFormatter                               = [ NSDateFormatter new ];
    dateFormatter.doesRelativeDateFormatting    = YES;
    dateFormatter.dateStyle                     = NSDateFormatterLongStyle;
    dateFormatter.timeStyle                     = NSDateFormatterShortStyle;
    
    [ _infoDateTextField        setStringValue: [ NSString stringWithFormat: L10N( "Modified" ), [ dateFormatter stringFromDate: [ _attributes objectForKey: NSFileModificationDate ] ] ] ];
    [ _generalCTimeTextField    setStringValue: [ dateFormatter stringFromDate: [ _attributes objectForKey: NSFileCreationDate ] ] ];
    [ _generalMTimeTextField    setStringValue: [ dateFormatter stringFromDate: [ _attributes objectForKey: NSFileModificationDate ] ] ];
    
    [ dateFormatter release ];
    
    [ _permissionsReadableTextField  setStringValue: ( [ FILE_MANAGER isReadableFileAtPath: _path ] ) ? L10N( "Yes" ) : L10N( "No" ) ];
    [ _permissionsWriteableTextField setStringValue: ( [ FILE_MANAGER isWritableFileAtPath: _path ] ) ? L10N( "Yes" ) : L10N( "No" ) ];
}

@end
