/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFileViewCell.h"
#import "CEFileViewItem.h"

static CEFileViewCell * __prototypeCell = nil;

static void __exit( void ) __attribute__( ( destructor ) );
static void __exit( void )
{
    [ __prototypeCell release ];
}

@implementation CEFileViewCell

+ ( id )prototypeCell
{
    if( __prototypeCell == nil )
    {
        __prototypeCell = [ [ self alloc ] init ];
    }
    
    return __prototypeCell;
}

- ( id )copyWithZone: ( NSZone * )zone
{
    id cell;
    
    cell = [ super copyWithZone: zone ];
    
    return cell;
}

- ( void )drawWithFrame: ( NSRect )frame inView: ( NSView * )view
{
    NSString                * text;
    NSImage                 * icon;
    CEFileViewItem          * item;
    NSColor                 * color;
    NSFont                  * font;
    NSMutableParagraphStyle * paragraphStyle;
    NSDictionary            * attributes;
    CGRect                    textRect;
    
    ( void )frame;
    ( void )view;
    
    item = ( CEFileViewItem * )[ self objectValue ];
    
    if( [ item isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return;
    }
    
    text            = item.displayName;
    icon            = item.icon;
    color           = ( self.isHighlighted == YES ) ? [ NSColor alternateSelectedControlTextColor ] : [ NSColor textColor ];
    font            = [ NSFont systemFontOfSize: [ NSFont smallSystemFontSize ] ];
    paragraphStyle  = [ [ NSMutableParagraphStyle new ] autorelease ];
    
    [ paragraphStyle setLineBreakMode: NSLineBreakByTruncatingMiddle ];
    
    attributes = [ NSDictionary dictionaryWithObjectsAndKeys:   color,          NSForegroundColorAttributeName,
                                                                font,           NSFontAttributeName,
                                                                paragraphStyle, NSParagraphStyleAttributeName,
                                                                nil
                 ];
    
    textRect = CGRectMake
    (
        frame.origin.x + frame.size.height + 10,
        frame.origin.y + ( ( frame.size.height - [ NSFont smallSystemFontSize ] ) / 2 ),
        frame.size.width - ( frame.size.height + 10 ),
        frame.size.height
    );
    
    [ text drawInRect: textRect withAttributes: attributes ];
    
    {
        NSAffineTransform  * transform;
        NSImageInterpolation interpolation;
        CGFloat              yOffset;
        CGRect               drawRect;
        CGRect               fromRect;
        
        [ [ NSGraphicsContext currentContext ] saveGraphicsState ];
        
        interpolation   = [ [ NSGraphicsContext currentContext ] imageInterpolation ];
        yOffset         = frame.origin.y;
        
        if( view.isFlipped == YES )
        {
            transform = [ NSAffineTransform transform ];
            
            [ transform translateXBy: ( CGFloat )0 yBy: frame.size.height ];
            [ transform scaleXBy: ( CGFloat )1 yBy: ( CGFloat )-1 ];
            [ transform concat ];	
            
            yOffset = -( frame.origin.y );
        }		
        
        drawRect = NSMakeRect
        (
            frame.origin.x + ( CGFloat )5,
            yOffset,
            frame.size.height - 2,
            frame.size.height - 2
        );
        
        fromRect = NSMakeRect
        (
            ( CGFloat )0,
            ( CGFloat )0,
            icon.size.width,
            icon.size.height
        );
        
        [ [ NSGraphicsContext currentContext ] setImageInterpolation: NSImageInterpolationHigh ];	
        [ icon drawInRect: drawRect fromRect: fromRect operation: NSCompositeSourceOver fraction: ( CGFloat )1 ];
        [ [ NSGraphicsContext currentContext ] setImageInterpolation: interpolation ];
        [ [ NSGraphicsContext currentContext ] restoreGraphicsState ];
    }
}

@end
