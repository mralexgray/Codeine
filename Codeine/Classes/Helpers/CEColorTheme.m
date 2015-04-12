
/* $Id$ */

#import "CEColorTheme.h"

@implementation CEColorTheme

@synthesize name                = _name, foregroundColor     = _foregroundColor, backgroundColor     = _backgroundColor, selectionColor      = _selectionColor, currentLineColor    = _currentLineColor, invisibleColor      = _invisibleColor, keywordColor        = _keywordColor, commentColor        = _commentColor, stringColor         = _stringColor, predefinedColor     = _predefinedColor, projectColor        = _projectColor, preprocessorColor   = _preprocessorColor, numberColor         = _numberColor;

+ ( NSArray * )defaultColorThemes
{
    NSMutableArray        * themes;
    NSString              * applicationSupportPath;
    NSString              * themesDirectory;
    NSDirectoryEnumerator * enumerator;
    NSString              * path;
    NSString              * name;
    NSDictionary          * themeDict;
    CEColorTheme          * theme;
    BOOL                    isDir;
    
    themes                  = [ NSMutableArray arrayWithCapacity: 25 ];
    applicationSupportPath  = [ FILE_MANAGER applicationSupportDirectory ];
    
    if( applicationSupportPath == nil )
    {
        return [ NSArray arrayWithArray: themes ];
    }
    
    themesDirectory = [ applicationSupportPath stringByAppendingPathComponent: @"Themes" ];
    isDir           = NO;
    
    if( [ FILE_MANAGER fileExistsAtPath: themesDirectory isDirectory: &isDir ] == NO || isDir == NO )
    {
        return [ NSArray arrayWithArray: themes ];
    }
    
    enumerator = [ FILE_MANAGER enumeratorAtPath: themesDirectory ];
    
    while( ( path = [ enumerator nextObject ] ) )
    {
        [ enumerator skipDescendants ];
        
        if( [ [ path pathExtension ] isEqualToString: @"plist" ] == NO )
        {
            continue;
        }
        
        path        = [ themesDirectory stringByAppendingPathComponent: path ];
        themeDict   = [ NSDictionary dictionaryWithContentsOfFile: path ];
        name        = [ [ path lastPathComponent ] stringByDeletingPathExtension ];
        theme       = [ self colorThemeWithName: name ];
        
        [ theme _setColorFromDictionary: themeDict name: @"Foreground"   selector: @selector( setForegroundColor: ) ];
        [ theme _setColorFromDictionary: themeDict name: @"Background"   selector: @selector( setBackgroundColor: ) ];
        [ theme _setColorFromDictionary: themeDict name: @"Selection"    selector: @selector( setSelectionColor: ) ];
        [ theme _setColorFromDictionary: themeDict name: @"CurrentLine"  selector: @selector( setCurrentLineColor: ) ];
        [ theme _setColorFromDictionary: themeDict name: @"Invisible"    selector: @selector( setInvisibleColor: ) ];
        [ theme _setColorFromDictionary: themeDict name: @"Keyword"      selector: @selector( setKeywordColor: ) ];
        [ theme _setColorFromDictionary: themeDict name: @"Comment"      selector: @selector( setCommentColor: ) ];
        [ theme _setColorFromDictionary: themeDict name: @"String"       selector: @selector( setStringColor: ) ];
        [ theme _setColorFromDictionary: themeDict name: @"Predefined"   selector: @selector( setPredefinedColor: ) ];
        [ theme _setColorFromDictionary: themeDict name: @"Project"      selector: @selector( setProjectColor: ) ];
        [ theme _setColorFromDictionary: themeDict name: @"Preprocessor" selector: @selector( setPreprocessorColor: ) ];
        [ theme _setColorFromDictionary: themeDict name: @"Number"       selector: @selector( setNumberColor: ) ];
        
        [ themes addObject: theme ];
    }
    
    return [ NSArray arrayWithArray: themes ];
}

+ ( CEColorTheme* )defaultColorThemeWithName: ( NSString * )name
{
    NSArray      * themes;
    CEColorTheme * theme;
    
    themes = [ self defaultColorThemes ];
    
    for( theme in themes )
    {
        if( [ theme.name isEqualToString: name ] )
        {
            return theme;
        }
    }
    
    return nil;
}

+ ( instancetype )colorThemeWithName: ( NSString * )name
{
    return [ ( CEColorTheme * )[ self alloc ] initWithName: name ];
}

- ( instancetype )initWithName: ( NSString * )name
{
    if( ( self = [ self init ] ) )
    {
        _name = [ name copy ];
    }
    
    return self;
}


// Private

- (void)_setColorFromDictionary:(NSDictionary*)dict name:(NSString*)name selector:(SEL)selector {
  CGFloat r,g,b;

  NSDictionary* colorValues = dict[name];
  r = (CGFloat)([(NSNumber*)colorValues[@"R"] doubleValue] / (CGFloat)255);
  g = (CGFloat)([(NSNumber*)colorValues[@"G"] doubleValue] / (CGFloat)255);
  b = (CGFloat)([(NSNumber*)colorValues[@"B"] doubleValue] / (CGFloat)255);

  NSColor* color = [NSColor colorWithDeviceRed:r green:g blue:b alpha:(CGFloat)1];

  [self performSelector:selector withObject:color];
}


@end
