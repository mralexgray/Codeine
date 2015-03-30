
/* $Id$ */

#import "CEViewController.h"

@class CESourceFile;
@class CEEditorLayoutManager;
@class CEEditorRulerView;
@class CEDocument;
@class CESyntaxHighlighter;
@class CECodeCompletionViewController;

@interface CEEditorViewController : CEViewController {
@protected

  NSTextView* __unsafe_unretained _textView;
  CEDocument* _document;
  CEEditorLayoutManager* _layoutManager;
  CEEditorRulerView* _rulerView;
  CESyntaxHighlighter* _highlighter;
  CECodeCompletionViewController* _codeCompletionViewController;

@private

  RESERVED_IVARS(CEEditorViewController, 5);
}

@property (unsafe_unretained, nonatomic) IBOutlet NSTextView* textView;
@property (atomic, readwrite, strong) CEDocument* document;

@end
