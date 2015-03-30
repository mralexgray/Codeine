
/* $Id$ */

#import "CEColorLabelMenuItem.h"
#import "CEColorLabelMenuItem+CEColorLabelViewDelegate.h"
#import "CEColorLabelView.h"

@implementation CEColorLabelMenuItem

- ( id )initWithCoder: ( NSCoder * )coder
{
    if( ( self = [ super initWithCoder: coder ] ) )
    {
        _view           = [ CEColorLabelView new ];
        _view.delegate  = self;
        
        self.view = _view;
    }
    
    return self;
}

- ( id )initWithTitle: ( NSString * )title action: ( SEL )action keyEquivalent: ( NSString * )charCode
{
    if( ( self = [ super initWithTitle: title action: action keyEquivalent: charCode ] ) )
    {
        _view = [ CEColorLabelView new ];
        
        self.view = _view;
    }
    
    return self;
}

- ( void )dealloc
{
    if( _view.delegate == self )
    {
        _view.delegate = nil;
    }
    
    RELEASE_IVAR( _view );
    RELEASE_IVAR( _selectedColor );
    
    [ super dealloc ];
}

- ( NSColor * )selectedColor
{
    @synchronized( self )
    {
        return _selectedColor;
    }
}

- ( void )setSelectedColor: ( NSColor * )color
{
    @synchronized( self )
    {
        if( color != _selectedColor )
        {
            RELEASE_IVAR( _selectedColor );
            
            _selectedColor      = [ color retain ];
            _view.selectedColor = _selectedColor;
        }
    }
}

@end
