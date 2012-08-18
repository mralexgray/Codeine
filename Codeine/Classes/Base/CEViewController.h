/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

FOUNDATION_EXPORT NSString * const CEViewControllerException;

@interface CEViewController: NSViewController
{
@protected
    
    NSView    * _currentView;
    NSPopover * _popover;
    
@private
    
    RESERVED_IVARS( CEViewController , 5 );
}

@property( atomic, readonly ) NSPopover * popover;

- ( void )openInPopoverRelativeToRect: ( NSRect )rect ofView: ( NSView * )view preferredEdge: ( NSRectEdge )edge;
- ( void )closePopover;

@end
