# ``Closured``

New Way Of Working Around With Closures.

**Are you tired of old-school callback closures?**

**Are you always mess up with capturing refrences on async closures?**
 
**Then Using Closured Will Bring You New Style.**

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [SampleProjects](#Sample)
- [Usage](#Usage)
- [Contributors](#Contributors)
- [License](#license)

## Features

- [x] Use propertyWrapper To Wrap Closure
- [x] Captures Weak References Inside Closure
- [x] Perform Closure On Different Queues
- [x] Fully Error Handled On Performing Closure
- [x] Fully Documented With DocC
- [ ] Write UnitTest

## Requirements

| Platform | Minimum Swift Version | Installation | Status |
| --- | --- | --- | --- |
| iOS 9.0+ | 5.3 | [CocoaPods](#cocoapods) | Tested |

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate CocoAttributedStringBuilder into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'Closured'
```

## Sample

I have provided one sample project in the repository. To use it clone the repo, Source files for these are in the `ClosuredExamples` directory in project navigator. Have fun!

## Usage

Using Closured is so easy, It uses `PropertyWrapper` in swift.

You just need to annotate your closures with provided Wrappers.

```swift

import Closured

class Example {

    // provide queue or the default is main
    // all the method without queue will use this queue to perform
    @Closured(queue: .main) var voidCallBack: (() -> Void)?
    
    @Closured10(queue: .main) var intCallBack: ((Int) -> Void)?
    
    private func call() {
        try? voidCallBack.sync() // perform on Main Queue
        
        try? voidCallBack.sync(on: .global(.background)) // perform on global Queue
        
        try? voidCallBack.async() // perform on Main Queue
        
        try? voidCallBack.async(on: .global(.utility)) 
        
        
        try? intCallBack.sync(on: .global(.utility), 89) 
        
        try? intCallBack.async(10) // perform on Main Queue
    }
}

class Container {
    
    private let ref = Example()
    
    func bind() {
        ref.$voidCallBack.byWrapping(self) { strongSelf in
            // strongSelf is unwrapped reference to self
            // self is not retained
            // this closure won't be executed if self was dealocated
        }
        
        ref.$intCallBack.byWrapping(self) { strongSelf, integer in
            // strongSelf is unwrapped reference to self
            // self is not retained
            // this closure won't be executed if self was dealocated
            // this closure will be called twice in two different queue, and provide 2 numbers = 89 and 10 
        }
    }
}

```


## Contributors

Feel free to share your ideas or any other problems. Pull requests are welcomed.

## License

CocoAttributedStringBuilder is released under an MIT license. See [LICENSE](https://github.com/kiarashvosough1999/Closured/blob/master/LICENSE) for more information.
 
