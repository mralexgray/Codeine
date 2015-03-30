
/* $Id$ */

#import "CEWindowController.h"

static NSString * const __classSuffix               = @"Controller";
       NSString * const CEWindowControllerException = @"CEWindowControllerException";

@implementation CEWindowController

- ( id )init
{
    NSString * className;
    NSString * nibName;
    
    className = NSStringFromClass( [ self class ] );
    
    if( [ className hasSuffix: __classSuffix ] == NO )
    {
        @throw [ NSException exceptionWithName: CEWindowControllerException reason: @"Invalid window controller class name" userInfo: nil ];
    }
    
    nibName = [ className substringToIndex: className.length - __classSuffix.length ];
    
    if( ( self = [ super initWithWindowNibName: nibName owner: self ] ) )
    {
        [ NOTIFICATION_CENTER addObserver: self selector: @selector( windowWillClose: ) name: NSWindowWillCloseNotification object: nil ];
    }
    
    return self;
}

- ( void )dealloc
{
    [ NOTIFICATION_CENTER removeObserver: self ];
    
    [ super dealloc ];
}

- ( BOOL )releaseOnWindowClose
{
    @synchronized( self )
    {
        return _releaseOnWindowClose;
    }
}

- ( void )setReleaseOnWindowClose: ( BOOL )release
{
    @synchronized( self )
    {
        if( release == YES && _releaseOnWindowClose == NO )
        {
            [ self retain ];
        }
        else if( release == NO &&  _releaseOnWindowClose == YES )
        {
            [ self release ];
        }
            
        _releaseOnWindowClose = release;
    }
}

@end
