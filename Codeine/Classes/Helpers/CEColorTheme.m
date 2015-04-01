
/* $Id$ */

#import "CEColorTheme.h"
#import "CEColorTheme+Private.h"

@implementation CEColorTheme

@synthesize name                = _name;
@synthesize foregroundColor     = _foregroundColor;
@synthesize backgroundColor     = _backgroundColor;
@synthesize selectionColor      = _selectionColor;
@synthesize currentLineColor    = _currentLineColor;
@synthesize invisibleColor      = _invisibleColor;
@synthesize keywordColor        = _keywordColor;
@synthesize commentColor        = _commentColor;
@synthesize stringColor         = _stringColor;
@synthesize predefinedColor     = _predefinedColor;
@synthesize projectColor        = _projectColor;
@synthesize preprocessorColor   = _preprocessorColor;
@synthesize numberColor         = _numberColor;

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
        
        [ theme setColorFromDictionary: themeDict name: @"Foreground"   selector: @selector( setForegroundColor: ) ];
        [ theme setColorFromDictionary: themeDict name: @"Background"   selector: @selector( setBackgroundColor: ) ];
        [ theme setColorFromDictionary: themeDict name: @"Selection"    selector: @selector( setSelectionColor: ) ];
        [ theme setColorFromDictionary: themeDict name: @"CurrentLine"  selector: @selector( setCurrentLineColor: ) ];
        [ theme setColorFromDictionary: themeDict name: @"Invisible"    selector: @selector( setInvisibleColor: ) ];
        [ theme setColorFromDictionary: themeDict name: @"Keyword"      selector: @selector( setKeywordColor: ) ];
        [ theme setColorFromDictionary: themeDict name: @"Comment"      selector: @selector( setCommentColor: ) ];
        [ theme setColorFromDictionary: themeDict name: @"String"       selector: @selector( setStringColor: ) ];
        [ theme setColorFromDictionary: themeDict name: @"Predefined"   selector: @selector( setPredefinedColor: ) ];
        [ theme setColorFromDictionary: themeDict name: @"Project"      selector: @selector( setProjectColor: ) ];
        [ theme setColorFromDictionary: themeDict name: @"Preprocessor" selector: @selector( setPreprocessorColor: ) ];
        [ theme setColorFromDictionary: themeDict name: @"Number"       selector: @selector( setNumberColor: ) ];
        
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


@end
