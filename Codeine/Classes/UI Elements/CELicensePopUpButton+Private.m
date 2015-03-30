
/* $Id$ */

#import "CELicensePopUpButton+Private.h"
#import "CEPreferences.h"

@implementation CELicensePopUpButton( Private )

- ( void )fillItems
{
    NSString   * path;
    NSArray    * licenses;
    NSString   * license;
    NSString   * licenseName;
    NSString   * licenseFile;
    NSMenuItem * item;
    
    path     = [ [ FILE_MANAGER applicationSupportDirectory ] stringByAppendingPathComponent: @"Licenses" ];
    licenses = [ FILE_MANAGER contentsOfDirectoryAtPath: path error: NULL ];
    
    for( license in licenses )
    {
        if( [ license.pathExtension isEqualToString: @"txt" ] == NO )
        {
            continue;
        }
        
        licenseFile = [ path stringByAppendingPathComponent: license ];
        licenseName = [ license stringByDeletingPathExtension ];
        
        [ self addItemWithTitle: licenseName ];
        
        item                   = [ self itemWithTitle: licenseName ];
        item.representedObject = licenseFile;
        
        if( [ licenseName isEqualToString: [ [ CEPreferences sharedInstance ] defaultLicense ] ] )
        {
            [ self selectItem: item ];
        }
    }
}

@end
