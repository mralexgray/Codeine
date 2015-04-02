
/* $Id$ */

@interface CEColorTheme : NSObject {
@protected

  NSString* _name;
  NSColor*_foregroundColor,
         *_backgroundColor,
         *_selectionColor,
         *_currentLineColor,
         *_invisibleColor,
         *_keywordColor,
         *_commentColor,
         *_stringColor,
         *_predefinedColor,
         *_projectColor,
         *_preprocessorColor,
         *_numberColor;
@private

  RESERVED_IVARS(CEColorTheme, 5);
}

@property (copy) NSString* name;
@property (copy) NSColor* foregroundColor,
                        * backgroundColor,
                        * selectionColor,
                        * currentLineColor,
                        * invisibleColor,
                        * keywordColor,
                        * commentColor,
                        * stringColor,
                        * predefinedColor,
                        * projectColor,
                        * preprocessorColor,
                        * numberColor;

+ (NSArray*)defaultColorThemes;
+ (CEColorTheme*)defaultColorThemeWithName:(NSString*)name;
+ (instancetype)colorThemeWithName:(NSString*)name;
- (instancetype)initWithName:(NSString*)name;

@end
