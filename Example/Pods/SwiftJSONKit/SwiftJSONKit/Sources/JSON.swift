//
//  JSON.swift
//  SwiftJSONKit
//
//  Created by Patrick Montalto on 4/3/17.
//
//

/// JSON dictionary typealias.
///
/// Keys for dictionary must be Strings.
public typealias JSONDictionary = [String: Any]


/// Represents all things that can be deserializable as JSON.
public protocol JSONDeserializable {
    /// Initialize with a JSON representation
    ///
    /// - parameter jsonRepresentation: JSON representation
    /// - throws: JSONDeserializationError
    init(jsonRepresentation dictionary: JSONDictionary) throws
}


/// Represents an object that can be serialized into a JSON Dictionary.
public protocol JSONSerializable {
    /// JSON representation
    var jsonRepresentation: JSONDictionary { get }
}


/// JSON Representation Deserialization Errors
public enum JSONDeserializationError: Error {
    /// A required key was missing
    case missingKey(key: String)
    
    /// Invalid attribute type found
    case invalidAttributeType(key: String, expectedType: Any.Type, decodedValue: Any)
    
    /// A key was invalid
    case invalidKey(key: String)
}
