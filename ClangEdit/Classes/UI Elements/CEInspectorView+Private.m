/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEInspectorView+Private.h"

@implementation CEInspectorView( Private )

- ( void )createAndSetSubviews
{
    NSRect rect1;
    NSRect rect2;
    
    rect1               = NSMakeRect( ( CGFloat )5, ( CGFloat )0, self.bounds.size.height, self.bounds.size.height - ( CGFloat )5 );
    rect2               = self.bounds;
    rect2.origin.x     += rect1.size.width + rect1.origin.x;
    rect2.size.width   -= rect1.size.width;
    rect2.size.height  -= ( CGFloat )5;
    
    _disclosureButton = [ [ NSButton alloc ] initWithFrame: rect1 ];
    
    [ _disclosureButton setBezelStyle:  NSDisclosureBezelStyle ];
    [ _disclosureButton setButtonType:  NSPushOnPushOffButton ];
    [ _disclosureButton setTitle:       nil ];
    [ _disclosureButton highlight:      NO ];
    
    [ _disclosureButton setTarget: self ];
    [ _disclosureButton setAction: @selector( toggleDetailView: ) ];
    
    _titleTextField         = [ [ NSTextField alloc ] initWithFrame: rect2 ];
    _titleTextField.font    = [ NSFont systemFontOfSize: [ NSFont smallSystemFontSize ] ];
    
    [ _titleTextField setBezeled:           NO ];
    [ _titleTextField setDrawsBackground:   NO ];
    [ _titleTextField setEditable:          NO ];
    [ _titleTextField setSelectable:        NO ];
           
    _detailView.frame = CGRectMake
    (
        ( CGFloat )0,
        ( CGFloat )0,
        self.frame.size.width,
        _detailView.frame.size.height
    );
    
    _separator              = [ [ NSBox alloc ] initWithFrame: NSMakeRect( ( CGFloat )0, ( CGFloat )self.bounds.size.height - ( CGFloat )1, self.bounds.size.width, ( CGFloat )1 ) ];
    _separator.boxType      = NSBoxSeparator;
    _separator.borderType   = NSLineBorder;
    
    _disclosureButton.autoresizingMask  = NSViewMinYMargin | NSViewMinXMargin;
    _separator.autoresizingMask         = NSViewMinYMargin | NSViewMinXMargin | NSViewMaxXMargin | NSViewWidthSizable;
    _titleTextField.autoresizingMask    = NSViewMinYMargin | NSViewMinXMargin | NSViewMaxXMargin | NSViewWidthSizable;
    
    [ self addSubview: _separator ];
    [ self addSubview: _disclosureButton ];
    [ self addSubview: _titleTextField ];
    [ self addSubview: _detailView ];
}

- ( void )toggleDetailView: ( id )sender
{
    dispatch_after
    (
        dispatch_time( DISPATCH_TIME_NOW, 1 * NSEC_PER_MSEC ),
        dispatch_get_main_queue(),
        ^( void )
        {
            CGRect            frame;
            CEInspectorView * nextView;
            
            ( void )sender;
            
            if( _disclosureButton.state == NSOnState )
            {
                self.frame = CGRectMake
                (
                    self.frame.origin.x,
                    self.frame.origin.y - _detailView.frame.size.height,
                    self.frame.size.width,
                    self.frame.size.height + _detailView.frame.size.height
                );
                
                frame              = self.window.frame;
                frame.origin.y    -= _detailView.frame.size.height;
                frame.size.height += _detailView.frame.size.height;
                
                nextView = self.nextView;
                
                while( nextView != nil )
                {
                    nextView.frame = NSMakeRect
                    (
                        nextView.frame.origin.x,
                        nextView.frame.origin.y - _detailView.frame.size.height,
                        nextView.frame.size.width,
                        nextView.frame.size.height
                    );
                    
                    nextView = nextView.nextView;
                }
                
                [ self addSubview: _detailView  ];
                [ self.window setFrame: frame display: YES animate: YES ];
            }
            else
            {
                self.frame = CGRectMake
                (
                    self.frame.origin.x,
                    self.frame.origin.y + _detailView.frame.size.height,
                    self.frame.size.width,
                    self.frame.size.height - _detailView.frame.size.height
                );
                
                frame              = self.window.frame;
                frame.origin.y    += _detailView.frame.size.height;
                frame.size.height -= _detailView.frame.size.height;
                
                nextView = self.nextView;
                
                while( nextView != nil )
                {
                    nextView.frame = NSMakeRect
                    (
                        nextView.frame.origin.x,
                        nextView.frame.origin.y + _detailView.frame.size.height,
                        nextView.frame.size.width,
                        nextView.frame.size.height
                    );
                    
                    nextView = nextView.nextView;
                }
                
                [ self.window setFrame: frame display: YES animate: YES ];
            }
        }
    );
}

@end
