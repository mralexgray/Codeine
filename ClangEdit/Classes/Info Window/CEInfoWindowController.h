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
    CEInspectorView * _generalView;
    CEInspectorView * _iconView;
    CEInspectorView * _permissionsView;
    NSImageView     * _smallIconView;
    NSImageView     * _largeIconView;
    
@private
    
    RESERVERD_IVARS( CEInfoWindowController, 5 );
}

@property( atomic, readonly             )          NSString         * path;
@property( nonatomic, readwrite, retain ) IBOutlet CEInspectorView  * generalView;
@property( nonatomic, readwrite, retain ) IBOutlet CEInspectorView  * iconView;
@property( nonatomic, readwrite, retain ) IBOutlet CEInspectorView  * permissionsView;
@property( nonatomic, readwrite, retain ) IBOutlet NSImageView      * smallIconView;
@property( nonatomic, readwrite, retain ) IBOutlet NSImageView      * largeIconView;

- ( id )initWithPath: ( NSString * )path;

@end
