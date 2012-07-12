/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
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

@synthesize frameworksTableView = _frameworksTableView;
@synthesize sharedLibsTableView = _sharedLibsTableView;
@synthesize staticLibsTableView = _staticLibsTableView;

- ( void )dealloc
{
    RELEASE_IVAR( _frameworksTableView );
    RELEASE_IVAR( _sharedLibsTableView );
    RELEASE_IVAR( _staticLibsTableView );
    
    [ super dealloc ];
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
    
    ( void )sender;
    
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
    ( void )sender;
}

- ( IBAction )addSharedLib: ( id )sender
{
    NSOpenPanel * panel;
    
    ( void )sender;
    
    panel                           = [ NSOpenPanel openPanel ];
    panel.canChooseDirectories      = NO;
    panel.canChooseFiles            = YES;
    panel.canCreateDirectories      = NO;
    panel.prompt                    = L10N( "AddSharedLibrary" );
    panel.allowsMultipleSelection   = NO;
    panel.delegate                  = self;
    panel.allowedFileTypes          = [ NSArray arrayWithObject: @"dylib" ];
    
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
    ( void )sender;
}

- ( IBAction )addStaticLib: ( id )sender
{
    NSOpenPanel * panel;
    
    ( void )sender;
    
    panel                           = [ NSOpenPanel openPanel ];
    panel.canChooseDirectories      = NO;
    panel.canChooseFiles            = YES;
    panel.canCreateDirectories      = NO;
    panel.prompt                    = L10N( "AddStaticLibrary" );
    panel.allowsMultipleSelection   = NO;
    panel.delegate                  = self;
    panel.allowedFileTypes          = [ NSArray arrayWithObject: @"a" ];
    
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
    ( void )sender;
}


@end
