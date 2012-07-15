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

- ( void )selectWithFrame: ( NSRect )rect inView: ( NSView * )controlView editor: ( NSText * )editor delegate: ( id )delegate start: ( NSInteger )selStart length: ( NSInteger )selLength
{
    rect = NSMakeRect
    (
        rect.origin.x + rect.size.height + 10,
        rect.origin.y + 3,
        rect.size.width - ( rect.size.height + 4 ),
        rect.size.height - 6
    );
    
    [ super selectWithFrame: rect inView: controlView editor: editor delegate: delegate start: selStart length: selLength ];
    
    if( [ editor isKindOfClass: [ NSTextView class ] ] )
    {
        [ ( NSTextView * )editor setTextContainerInset: NSMakeSize( -2, 1 ) ];
    }
    
    [ editor setFont: [ NSFont systemFontOfSize: [ NSFont smallSystemFontSize ] ] ];
}

- ( NSText * )setUpFieldEditorAttributes: ( NSText * )editor
{   
    [ editor setDrawsBackground: NO ];
    
    return editor;
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
    
    if( item.type == CEFileViewItemTypeBookmark || item.type == CEFileViewItemTypeBookmark )
    {
        {
            CGRect         rect;
            NSBezierPath * path;
            NSString     * filePath;
            NSError      * error;
            NSColor      * labelColor;
            NSGradient   * gradient;
            NSRange        range;
            CGFloat        r;
            CGFloat        g;
            CGFloat        b;
            
            range = [ item.name rangeOfString: @":" ];
            
            if( range.location == NSNotFound )
            {
                filePath = item.name;
            }
            else
            {
                filePath = [ item.name substringFromIndex: range.location + 1 ];
            }
            
            if( [ FILE_MANAGER fileExistsAtPath: filePath ] == YES )
            {
                error       = nil;
                labelColor  = nil;
                
                [ [ NSURL fileURLWithPath: filePath ] getResourceValue: &labelColor forKey: NSURLLabelColorKey error: &error ];
                
                if( labelColor != nil )
                {
                    rect              = frame;
                    rect.origin.x    += frame.size.height + 5;
                    rect.origin.y    += 1;
                    rect.size.width  -= frame.size.height + 5;
                    rect.size.height -= 2;
                    path              = [ NSBezierPath bezierPath ];
                    
                    labelColor = [ labelColor colorUsingColorSpaceName: NSDeviceRGBColorSpace ];
                    
                    [ labelColor getRed: &r green: &g blue: &b alpha: NULL ];
                    
                    labelColor  = [ NSColor colorWithDeviceRed: r green: g blue: b alpha: ( CGFloat )0.5 ];
                    gradient    = [ [ NSGradient alloc ] initWithColorsAndLocations:    [ NSColor whiteColor ], ( CGFloat )0.0,
                                                                                        labelColor,             ( CGFloat )1.0,
                                                                                        nil
                                          ];
                    
                    [ path appendBezierPathWithRoundedRect: rect xRadius: ( CGFloat )8 yRadius: ( CGFloat )8 ];
                    
                    [ gradient drawInBezierPath: path angle: 90 ];
                    [ gradient release ];
                }
            }
        }
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
