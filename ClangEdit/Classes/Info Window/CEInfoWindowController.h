/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEWindowController.h"

@class CEInspectorView;

@interface CEInfoWindowController: CEWindowController
{
@protected
    
    NSString        * _path;
    NSDictionary    * _attributes;
    BOOL              _isDirectory;
    NSOutlineView   * _outlineView;
    NSView          * _infoView;
    NSView          * _generalLabelView;
    NSView          * _iconLabelView;
    NSView          * _permissionsLabelView;
    NSView          * _generalView;
    NSView          * _iconView;
    NSView          * _permissionsView;
    NSImageView     * _smallIconView;
    NSImageView     * _largeIconView;
    NSTextField     * _infoNameTextField;
    NSTextField     * _infoSizeTextField;
    NSTextField     * _infoDateTextField;
    NSTextField     * _generalKindTextField;
    NSTextField     * _generalSizeTextField;
    NSTextField     * _generalPathTextField;
    NSTextField     * _generalCTimeTextField;
    NSTextField     * _generalMTimeTextField;
    NSTextField     * _permissionsReadableTextField;
    NSTextField     * _permissionsWriteableTextField;
    NSTextField     * _permissionsOwnerTextField;
    NSTextField     * _permissionsGroupTextField;
    NSTextField     * _permissionsOctalTextField;
    NSTextField     * _permissionsHumanTextField;
    
@private
    
    RESERVERD_IVARS( CEInfoWindowController, 5 );
}

@property( atomic, readonly             )          NSString      * path;
@property( nonatomic, readwrite, retain ) IBOutlet NSOutlineView * outlineView;
@property( nonatomic, readwrite, retain ) IBOutlet NSView        * infoView;
@property( nonatomic, readwrite, retain ) IBOutlet NSView        * generalLabelView;
@property( nonatomic, readwrite, retain ) IBOutlet NSView        * iconLabelView;
@property( nonatomic, readwrite, retain ) IBOutlet NSView        * permissionsLabelView;
@property( nonatomic, readwrite, retain ) IBOutlet NSView        * generalView;
@property( nonatomic, readwrite, retain ) IBOutlet NSView        * iconView;
@property( nonatomic, readwrite, retain ) IBOutlet NSView        * permissionsView;
@property( nonatomic, readwrite, retain ) IBOutlet NSImageView   * smallIconView;
@property( nonatomic, readwrite, retain ) IBOutlet NSImageView   * largeIconView;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField   * infoNameTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField   * infoSizeTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField   * infoDateTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField   * generalKindTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField   * generalSizeTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField   * generalPathTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField   * generalCTimeTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField   * generalMTimeTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField   * permissionsReadableTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField   * permissionsWriteableTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField   * permissionsOwnerTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField   * permissionsGroupTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField   * permissionsOctalTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField   * permissionsHumanTextField;


- ( id )initWithPath: ( NSString * )path;

@end
