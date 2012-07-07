/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEApplicationDelegate+Private.h"
#import "CEPreferences.h"
#import "CEColorTheme.h"

@implementation CEApplicationDelegate( Private )

- ( void )installApplicationSupportFiles
{
    NSString * path;
    NSString * templatesBundlePath;
    NSString * templatesPath;
    
    path = [ FILE_MANAGER applicationSupportDirectory ];
    
    if( path == nil )
    {
        return;
    }
    
    templatesBundlePath = [ BUNDLE pathForResource: @"Templates" ofType: nil ];
    templatesPath       = [ path stringByAppendingPathComponent: [ templatesBundlePath lastPathComponent ] ];
    
    if( [ FILE_MANAGER fileExistsAtPath: templatesPath ] == NO )
    {
        [ FILE_MANAGER copyItemAtPath: templatesBundlePath toPath: templatesPath error: NULL ];
    }
}

- ( void )firstLaunch
{
    if( [ [ CEPreferences sharedInstance ] firstLaunch ] == NO )
    {
        return;
    }
    
    [ [ CEPreferences sharedInstance ] setFirstLaunch: NO ];
    [ [ CEPreferences sharedInstance ] setTextEncoding: NSUTF8StringEncoding ];
    
    {
        NSDictionary * warningFlags;
        NSString     * warningFlag;
        NSNumber     * warningFlagValue;
        
        warningFlags = [ [ CEPreferences sharedInstance ] warningFlags ];
        
        if( warningFlags == nil || warningFlags.count == 0 )
        {
            warningFlags = [ [ CEPreferences sharedInstance ] warningFlagsPresetNormal ];
            
            for( warningFlag in warningFlags )
            {
                warningFlagValue = ( NSNumber * )[ warningFlags objectForKey: warningFlag ];
                
                if( [ warningFlagValue boolValue ] == YES )
                {
                    [ [ CEPreferences sharedInstance ] enableWarningFlag: warningFlag ];
                }
                else
                {
                    [ [ CEPreferences sharedInstance ] disableWarningFlag: warningFlag ];
                }
            }
        }
    }
    
    {
        NSDictionary * themes;
        CEColorTheme * theme;
        
        themes = [ [ CEPreferences sharedInstance ] colorThemes ];
        theme  = [ themes objectForKey: @"Xcode" ];
        
        [ [ CEPreferences sharedInstance ] setGeneralForegroundColor:   theme.generalForegroundColor ];
        [ [ CEPreferences sharedInstance ] setGeneralBackgroundColor:   theme.generalBackgroundColor ];
        [ [ CEPreferences sharedInstance ] setGeneralSelectionColor:    theme.generalSelectionColor ];
        [ [ CEPreferences sharedInstance ] setGeneralCurrentLineColor:  theme.generalCurrentLineColor ];
        [ [ CEPreferences sharedInstance ] setSourceKeywordColor:       theme.sourceKeywordColor ];
        [ [ CEPreferences sharedInstance ] setSourceCommentColor:       theme.sourceCommentColor ];
        [ [ CEPreferences sharedInstance ] setSourceStringColor:        theme.sourceStringColor ];
        [ [ CEPreferences sharedInstance ] setSourcePredefinedColor:    theme.sourcePredefinedColor ];
    }
}

@end
