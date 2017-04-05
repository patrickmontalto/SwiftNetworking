# SwiftJSONKit

[![CI Status](http://img.shields.io/travis/patrick.montalto@adnas.com/SwiftJSONKit.svg?style=flat)](https://travis-ci.org/patrick.montalto@adnas.com/SwiftJSONKit)
[![Version](https://img.shields.io/cocoapods/v/SwiftJSONKit.svg?style=flat)](http://cocoapods.org/pods/SwiftJSONKit)
[![License](https://img.shields.io/cocoapods/l/SwiftJSONKit.svg?style=flat)](http://cocoapods.org/pods/SwiftJSONKit)
[![Platform](https://img.shields.io/cocoapods/p/SwiftJSONKit.svg?style=flat)](http://cocoapods.org/pods/SwiftJSONKit)

## Overview

## Installation with Cocoapods
SwiftJSONKit is available through [Cocoapods](https://cocoapods.org). To install, simply add the following line to your Podfile:
```ruby
pod "SwiftJSONKit"
```

## Usage 
Take a plain old blog post struct:

```Swift
struct Post {
    let title: String
    let createdAt: Date
```

And now add JSON deserialization easily:

```Swift
import SwiftJSONKit

extension Post: JSONDeserializable {
    init(jsonRepresentation dictionary: JSONDictionary) throws {
        title = try decode(json, key: "title")
        createdAt = try decode(json, key: "created_at")
    }
}

```




## Author

Patrick Montalto

## License

SwiftJSONKit is available under the MIT license. See the LICENSE file for more info.
