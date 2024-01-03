//
//  UnkeyedDecodingContainer.swift
//  CoreInterface
//
//  Created by Jonatan Ortiz on 16/10/23.
//

import Foundation

public extension UnkeyedDecodingContainer {
    mutating func decode(_ type: Array<Any>.Type) throws -> [Any] {
        var array: [Any] = []
        while isAtEnd == false {
            if try decodeNil() {
                continue
            } else if let value = try? decode(Bool.self) {
                array.append(value)
            } else if let value = try? decode(Double.self) {
                array.append(value)
            } else if let value = try? decode(String.self) {
                array.append(value)
            } else if let nestedDictionary = try? decode(Dictionary<String, Any>.self) {
                array.append(nestedDictionary)
            } else if let nestedArray = try? decode(nestedArray: Array<Any>.self) {
                array.append(nestedArray)
            }
        }
        return array
    }

    mutating func decode(_ type: [String: Any].Type) throws -> [String: Any] {
        let nestedContainer = try self.nestedContainer(keyedBy: JSONCodingKeys.self)
        return try nestedContainer.decode(type)
    }

    private mutating func decode(nestedArray type: [Any].Type) throws -> [Any] {
        var nestedContainer = try self.nestedUnkeyedContainer()
        return try nestedContainer.decode(type)
    }
}
