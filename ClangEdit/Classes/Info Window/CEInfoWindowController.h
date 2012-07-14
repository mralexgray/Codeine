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
    NSOutlineView   * _outlineView;
    NSView          * _infoView;
    NSView          * _generalLabelView;
    NSView          * _iconLabelView;
    NSView          * _permissionsLabelView;
    NSView          * _generalView;
    NSView          * _iconView;
    NSView          * _permissionsView;
    
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

- ( id )initWithPath: ( NSString * )path;

@end
