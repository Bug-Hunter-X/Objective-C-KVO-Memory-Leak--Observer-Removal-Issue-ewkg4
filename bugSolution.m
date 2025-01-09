The solution involves ensuring that the observer is always removed when it is no longer needed using `removeObserver:forKeyPath:`.

```objectivec
@interface MyObject : NSObject
@property (nonatomic, strong) NSString *someString;
@end

@implementation MyObject
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    // ... observation logic ...
}

- (void)someMethod {
    [self addObserver:self forKeyPath:@"someString" options:NSKeyValueObservingOptionNew context:NULL];
    // ... some code ...
    [self removeObserver:self forKeyPath:@"someString"]; // Added observer removal
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"someString"]; //Added for safety
    [super dealloc];
}
@end
```
Additionally, it is good practice to remove observers within the `dealloc` method to guarantee removal even if `someMethod` encounters an error.  Always use `removeObserver:forKeyPath:` when you're finished observing a key path.