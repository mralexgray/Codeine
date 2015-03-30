
/* $Id$ */

@interface CEMutableOrderedDictionary : NSMutableDictionary {
@protected

  NSMutableArray* _keys;
  NSMutableArray* _objects;

@private

  RESERVED_IVARS(CEMutableOrderedDictionary, 5);
}

- (id)keyAtIndex:(NSUInteger)index;
- (id)objectAtIndex:(NSUInteger)index;

@end
