
/* $Id$ */

@interface CEColorTheme : NSObject {
@protected

  NSString* _name;
  NSColor* _foregroundColor;
  NSColor* _backgroundColor;
  NSColor* _selectionColor;
  NSColor* _currentLineColor;
  NSColor* _invisibleColor;
  NSColor* _keywordColor;
  NSColor* _commentColor;
  NSColor* _stringColor;
  NSColor* _predefinedColor;
  NSColor* _projectColor;
  NSColor* _preprocessorColor;
  NSColor* _numberColor;

@private

  RESERVED_IVARS(CEColorTheme, 5);
}

@property (readwrite, copy) NSString* name;
@property (readwrite, copy) NSColor* foregroundColor;
@property (readwrite, copy) NSColor* backgroundColor;
@property (readwrite, copy) NSColor* selectionColor;
@property (readwrite, copy) NSColor* currentLineColor;
@property (readwrite, copy) NSColor* invisibleColor;
@property (readwrite, copy) NSColor* keywordColor;
@property (readwrite, copy) NSColor* commentColor;
@property (readwrite, copy) NSColor* stringColor;
@property (readwrite, copy) NSColor* predefinedColor;
@property (readwrite, copy) NSColor* projectColor;
@property (readwrite, copy) NSColor* preprocessorColor;
@property (readwrite, copy) NSColor* numberColor;

+ (NSArray*)defaultColorThemes;
+ (id)defaultColorThemeWithName:(NSString*)name;
+ (id)colorThemeWithName:(NSString*)name;
- (id)initWithName:(NSString*)name;

@end
