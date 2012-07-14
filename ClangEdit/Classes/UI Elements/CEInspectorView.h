/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@interface CEInspectorView: NSView
{
@protected
    
    NSBox           * _separator;
    NSButton        * _disclosureButton;
    NSTextField     * _titleTextField;
    NSView          * _detailView;
    CEInspectorView * _nextView;
    
@private
    
    RESERVERD_IVARS( CEInspectorView , 5 );
}

@property( nonatomic, readwrite, copy   )          NSString         * title;
@property( nonatomic, readwrite, retain ) IBOutlet NSView           * detailView;
@property( nonatomic, readwrite, retain ) IBOutlet CEInspectorView  * nextView;

@end
