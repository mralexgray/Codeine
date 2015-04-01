
/* $Id$ */

#import "CEColorChooserView.h"
#import "CEColorChooserView+Private.h"
#import "CEPreferences.h"

@implementation CEColorChooserView

@synthesize backgroundColor     = _backgroundColor;
@synthesize representedObject   = _representedObject;
@synthesize delegate            = _delegate;


- ( void )drawRect: ( NSRect )rect
{
    [ _backgroundColor setFill ];
    
    NSRectFill( rect );
}

- ( void )setFrame: ( NSRect )frame
{
    [ super setFrame: frame ];
    
    if( NSEqualRects( frame, NSZeroRect ) )
    {
        return;
    }
    
    if( _textField == nil )
    {
        {
            NSRect colorWellFrame;
            NSRect textFieldFrame;
            NSSize size;
            
            colorWellFrame = NSMakeRect
            (
                ( CGFloat )0,
                ( CGFloat )2,
                frame.size.height - ( CGFloat )4,
                frame.size.height - ( CGFloat )4
            );
            
            colorWellFrame.origin.x = ( frame.size.width - colorWellFrame.size.width ) - ( CGFloat )2;
            
            _colorWell =[NSColorWell.alloc 
         initWithFrame: colorWellFrame ];
            
            [ _colorWell setColor:  _color ];
            [ _colorWell setTarget: self ];
            [ _colorWell setAction: @selector( changeColor: ) ];
            
            size           = [ _title sizeWithAttributes: @{NSFontAttributeName: _font} ];
            textFieldFrame = NSMakeRect
            (
                ( frame.size.height - size.height ) / ( CGFloat )2,
                ( frame.size.height - size.height ) / ( CGFloat )2,
                frame.size.width - colorWellFrame.size.width - ( ( frame.size.height - size.height ) / ( CGFloat )2 ),
                size.height
            );
            
            _textField                  =[NSTextField.alloc 
         initWithFrame: textFieldFrame ];
            _textField.textColor        = _foregroundColor;
            _textField.backgroundColor  = [ NSColor clearColor ];
            _textField.stringValue      = _title;
            
            [ _textField setEditable:   NO ];
            [ _textField setSelectable: NO ];
            [ _textField setBezeled:    NO ];
            [ _textField setFont:       _font ];
            
            [ self addSubview: _textField ];
            [ self addSubview: _colorWell ];
        }
    }
}

- ( NSColor * )foregroundColor
{
    @synchronized( self )
    {
        return _foregroundColor;
    }
}

- ( NSColor * )color
{
    @synchronized( self )
    {
        return _color;
    }
}

- ( NSString * )title
{
    @synchronized( self )
    {
        return _title;
    }
}

- ( NSFont * )font
{
    @synchronized( self )
    {
        return _font;
    }
}

- ( void )setForegroundColor: ( NSColor * )foregroundColor
{
    @synchronized( self )
    {
        if( _foregroundColor != foregroundColor )
        {
            RELEASE_IVAR( _foregroundColor );
            
            _foregroundColor = foregroundColor;
            
            if( _textField != nil )
            {
                _textField.textColor = _foregroundColor;
            }
        }
    }
}

- ( void )setColor: ( NSColor * )color
{
    @synchronized( self )
    {
        if( _color != color )
        {
            RELEASE_IVAR( _color );
            
            _color = color;
            
            if( _colorWell != nil )
            {
                _colorWell.color = _color;
            }
        }
    }
}

- ( void )setTitle: ( NSString * )title
{
    @synchronized( self )
    {
        if( _title != title )
        {
            RELEASE_IVAR( _title );
            
            _title = [ title copy ];
            
            if( _textField != nil )
            {
                _textField.stringValue = _title;
            }
        }
    }
}

- ( void )setFont: ( NSFont * )font
{
    @synchronized( self )
    {
        if( _font != font )
        {
            RELEASE_IVAR( _font );
            
            _font = font;
            
            if( _textField != nil )
            {
                _textField.font = _font;
            }
        }
    }
}

@end
