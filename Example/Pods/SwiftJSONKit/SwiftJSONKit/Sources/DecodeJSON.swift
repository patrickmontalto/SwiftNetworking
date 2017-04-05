//
//  DecodeJSON.swift
//  SwiftJSONKit
//
//  Created by Patrick Montalto on 4/3/17.
//
//

// MARK: - Generic Decoding
/// Decode a value from the provided JSON dictionary.
///
/// - parameter dictionary: JSON dictionary
/// - parameter key: key in the dictionary
/// - returns: xxpected value
/// - throws: JSONDeserializationError
public func decodeJSON<T>(_ dictionary: JSONDictionary, key: String) throws -> T {
    
    // Attempt to get value from dictionary
    guard let value = dictionary[key] else {
        throw JSONDeserializationError.missingKey(key: key)
    }
    
    // Attempt to retrieve attribute as specified type T
    guard let attribute = value as? T else {
        throw JSONDeserializationError.invalidAttributeType(key: key, expectedType: T.self, decodedValue: value)
    }
    
    return attribute
}


/// Decode a JSONDeserializable type from the provided JSON dictionary.
///
/// - parameter dictionary: JSON dictionary
/// - parameter key: key in the dictionary
/// - returns: expected JSONDeserializable value
/// - throws: JSONDeserializationError
public func decodeJSON<T: JSONDeserializable>(_ dictionary: JSONDictionary, key: String) throws -> T {
    // Attempt to get the JSONDictionary from the provided dictionary
    let value: JSONDictionary = try decodeJSON(dictionary, key: key)
    
    // Attempt to return the decoded JSONDictionary
    return try decodeJSON(value)
}


/// Decode an array of JSONDeserializable types from provided JSON dictionary.
///
/// - parameter dictionary: JSON dictionary
/// - parameter key: key in the dictionary
/// - returns: expected JSONDeserializable value
/// - throws: JSONDeserializationError
public func decodeJSON<T: JSONDeserializable>(_ dictionary: JSONDictionary, key: String) throws -> [T] {
    // Attempt to get an array of JSONDictionaries
    let values: [JSONDictionary] = try decodeJSON(dictionary, key: key)
    
    // Attempt to return an array of decoded JSONDictionaries
    return values.flatMap { try? decodeJSON($0) }
}


/// Decode a JSONDeserializable type.
///
/// - parameter dictionary: JSON dictionary
/// - returns: decoded type
/// - throws: JSONDeserializationError
public func decodeJSON<T: JSONDeserializable>(_ dictionary: JSONDictionary) throws -> T {
    // Attempt to create the JSONDeserialized object with a JSONDictionary
    return try T.init(jsonRepresentation: dictionary)
}


// MARK: - Decode URL
/// Decode URL from the provided JSON dictionary.
///
/// - parameter dictionary: JSON dictionary
/// - parameter key: key in the dictionary
/// - returns: expected value
/// - throws: JSONDeserializationError
public func decodeJSON(_ dictionary: JSONDictionary, key: String) throws -> URL {
    // Attempt to get the string for URL
    guard let urlString = dictionary[key] as? String else {
        throw JSONDeserializationError.missingKey(key: key)
    }
    
    // Attempt to create a URL from the url string
    guard let url = URL(string: urlString) else {
        throw JSONDeserializationError.invalidAttributeType(key: key, expectedType: URL.self, decodedValue: urlString)
    }
    
    return url
}

// MARK: - Decode Date
/// Decode Date from provided JSON Dictionary.
///
/// - parameter dictionary: JSON dictionary
/// - parameter key: key in the dictionary
/// - returns: expected value
/// - throws: JSONDeserializationError
public func decodeJSON(_ dictionary: JSONDictionary, key: String) throws -> Date {
    // Attempt to get value from dictionary
    guard let value = dictionary[key] else {
        throw JSONDeserializationError.missingKey(key: key)
    }
    
    // When the date is a String
    if #available(iOS 10.0, *) {
        if let dateString = value as? String {
            guard let date = ISO8601DateFormatter().date(from: dateString) else {
                throw JSONDeserializationError.invalidKey(key: key)
            }
            return date
        }
    }
    
    // When the date is a TimeInterval
    if let timeInterval = value as? TimeInterval {
        return Date(timeIntervalSince1970: timeInterval)
    }
    
    // When the date is an Integer
    if let timeInterval = value as? Int {
        return Date(timeIntervalSince1970: TimeInterval(timeInterval))
    }
    
    throw JSONDeserializationError.invalidAttributeType(key: key, expectedType: Date.self, decodedValue: value)
}
