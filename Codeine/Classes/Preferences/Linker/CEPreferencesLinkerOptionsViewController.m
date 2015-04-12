
/* $Id$ */

#import "CEPreferencesLinkerOptionsViewController.h"
#import "CEPreferencesLinkerOptionsViewController+NSTableViewDelegate.h"
#import "CEPreferencesLinkerOptionsViewController+NSTableViewDataSource.h"
#import "CEPreferencesLinkerOptionsViewController+Private.h"
#import "CEPreferencesLinkerOptionsViewController+NSOpenSavePanelDelegate.h"
#import "CEPreferences.h"

NSString * const CEPreferencesLinkerOptionsViewControllerTableViewColumnIconIdentifier      = @"Icon";
NSString * const CEPreferencesLinkerOptionsViewControllerTableViewColumnNameIdentifier      = @"Name";
NSString * const CEPreferencesLinkerOptionsViewControllerTableViewColumnPathIdentifier      = @"Path";
NSString * const CEPreferencesLinkerOptionsViewControllerTableViewColumnLanguageIdentifier  = @"Language";

@implementation CEPreferencesLinkerOptionsViewController

@synthesize frameworksTableView = _frameworksTableView, sharedLibsTableView = _sharedLibsTableView, staticLibsTableView = _staticLibsTableView;

- ( void )dealloc
{
    _frameworksTableView.delegate = nil;
    _sharedLibsTableView.delegate = nil;
    _staticLibsTableView.delegate = nil;
    
    _frameworksTableView.dataSource = nil;
    _sharedLibsTableView.dataSource = nil;
    _staticLibsTableView.dataSource = nil;
    
    
}

- ( void )awakeFromNib
{
    _frameworksTableView.delegate   = self;
    _frameworksTableView.dataSource = self;
    _sharedLibsTableView.delegate   = self;
    _sharedLibsTableView.dataSource = self;
    _staticLibsTableView.delegate   = self;
    _staticLibsTableView.dataSource = self;
}

- ( IBAction )addFramework: ( id )sender
{
    NSOpenPanel * panel;
    

    
    panel                           = [ NSOpenPanel openPanel ];
    panel.canChooseDirectories      = YES;
    panel.canChooseFiles            = NO;
    panel.canCreateDirectories      = NO;
    panel.prompt                    = L10N( "AddFramework" );
    panel.allowsMultipleSelection   = NO;
    panel.delegate                  = self;
    
    _openPanelAllowedType = CELinkerObjectTypeFramework;
    
    [ panel beginSheetModalForWindow: self.view.window completionHandler: ^( NSInteger result )
        {
            NSString        * path;
            CELinkerObject  * object;
            
            if( result != NSFileHandlingPanelOKButton )
            {
                return;
            }
            
            path    = [ panel.URL path ];
            object  = [ CELinkerObject linkerObjectWithPath: path type: CELinkerObjectTypeFramework ];
            
            [ [ CEPreferences sharedInstance ] addLinkerObject: object ];
            [ _frameworksTableView reloadData ];
        }
    ];
}

- ( IBAction )removeFramework: ( id )sender
{
    NSInteger row;
    NSArray * objects;
    

    
    objects = [ CELinkerObject linkerObjectsWithType: CELinkerObjectTypeFramework ];
    row     = [ _frameworksTableView selectedRow ];
    
    if( row < 0 || ( NSUInteger )row >= objects.count )
    {
        return;
    }
    
    [ [ CEPreferences sharedInstance ] removeLinkerObject: objects[( NSUInteger )row] ];
    [ _frameworksTableView reloadData ];
}

- ( IBAction )addSharedLib: ( id )sender
{
    NSOpenPanel * panel;
    

    
    panel                           = [ NSOpenPanel openPanel ];
    panel.canChooseDirectories      = NO;
    panel.canChooseFiles            = YES;
    panel.canCreateDirectories      = NO;
    panel.prompt                    = L10N( "AddSharedLibrary" );
    panel.allowsMultipleSelection   = NO;
    panel.delegate                  = self;
    panel.allowedFileTypes          = @[@"dylib"];
    
    _openPanelAllowedType = CELinkerObjectTypeSharedLibrary;
    
    [ panel beginSheetModalForWindow: self.view.window completionHandler: ^( NSInteger result )
        {
            NSString        * path;
            CELinkerObject  * object;
            
            if( result != NSFileHandlingPanelOKButton )
            {
                return;
            }
            
            path    = [ panel.URL path ];
            object  = [ CELinkerObject linkerObjectWithPath: path type: CELinkerObjectTypeSharedLibrary ];
            
            [ [ CEPreferences sharedInstance ] addLinkerObject: object ];
            [ _sharedLibsTableView reloadData ];
        }
    ];
}

- ( IBAction )removeSharedLib: ( id )sender
{
    NSInteger row;
    NSArray * objects;
    

    
    objects = [ CELinkerObject linkerObjectsWithType: CELinkerObjectTypeSharedLibrary ];
    row     = [ _sharedLibsTableView selectedRow ];
    
    if( row < 0 || ( NSUInteger )row >= objects.count )
    {
        return;
    }
    
    [ [ CEPreferences sharedInstance ] removeLinkerObject: objects[( NSUInteger )row] ];
    [ _sharedLibsTableView reloadData ];
}

- ( IBAction )addStaticLib: ( id )sender
{
    NSOpenPanel * panel;
    

    
    panel                           = [ NSOpenPanel openPanel ];
    panel.canChooseDirectories      = NO;
    panel.canChooseFiles            = YES;
    panel.canCreateDirectories      = NO;
    panel.prompt                    = L10N( "AddStaticLibrary" );
    panel.allowsMultipleSelection   = NO;
    panel.delegate                  = self;
    panel.allowedFileTypes          = @[@"a"];
    
    _openPanelAllowedType = CELinkerObjectTypeStaticLibrary;
    
    [ panel beginSheetModalForWindow: self.view.window completionHandler: ^( NSInteger result )
        {
            NSString        * path;
            CELinkerObject  * object;
            
            if( result != NSFileHandlingPanelOKButton )
            {
                return;
            }
            
            path    = [ panel.URL path ];
            object  = [ CELinkerObject linkerObjectWithPath: path type: CELinkerObjectTypeStaticLibrary ];
            
            [ [ CEPreferences sharedInstance ] addLinkerObject: object ];
            [ _staticLibsTableView reloadData ];
        }
    ];
}

- ( IBAction )removeStaticLib: ( id )sender
{
    NSInteger row;
    NSArray * objects;
    

    
    objects = [ CELinkerObject linkerObjectsWithType: CELinkerObjectTypeStaticLibrary ];
    row     = [ _staticLibsTableView selectedRow ];
    
    if( row < 0 || ( NSUInteger )row >= objects.count )
    {
        return;
    }
    
    [ [ CEPreferences sharedInstance ] removeLinkerObject: objects[( NSUInteger )row] ];
    [ _staticLibsTableView reloadData ];
}

@end
