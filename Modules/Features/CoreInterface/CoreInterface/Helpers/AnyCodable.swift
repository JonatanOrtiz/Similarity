//
//  AnyCodable.swift
//  CoreInterface
//
//  Created by Jonatan Ortiz on 16/10/23.
//

public struct AnyCodable {
    public let value: Any?

    public init(value: Any) {
        self.value = value
    }
}

extension AnyCodable: Decodable {
    struct CodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?

        init?(intValue: Int) {
            self.stringValue = "\(intValue)"
            self.intValue = intValue
        }

        init?(stringValue: String) {
            self.stringValue = stringValue
        }
    }

    public init(from decoder: Decoder) throws {
        if let container = try? decoder.container(keyedBy: CodingKeys.self) {
            var result = [String: Any]()
            try container.allKeys.forEach { (key) throws in
                result[key.stringValue] = try container.decode(AnyCodable.self, forKey: key).value
            }
            value = result
            return
        }

        if var container = try? decoder.unkeyedContainer() {
            var result = [Any]()
            while !container.isAtEnd {
                guard let element = try container.decode(AnyCodable.self).value else {
                    continue
                }
                result.append(element)
            }
            value = result
            return
        }

        if let container = try? decoder.singleValueContainer() {
            if let intValue = try? container.decode(Int.self) {
                value = intValue
                return
            }

            if let doubleValue = try? container.decode(Double.self) {
                value = doubleValue
                return
            }

            if let decimalValue = try? container.decode(Decimal.self) {
                value = decimalValue
                return
            }

            if let boolValue = try? container.decode(Bool.self) {
                value = boolValue
                return
            }

            if let stringValue = try? container.decode(String.self) {
                value = stringValue
                return
            }

            value = nil
            return
        }

        value = nil
    }
}

extension AnyCodable: Encodable {
    public func encode(to encoder: Encoder) throws {
        if let array = value as? [Any] {
            var container = encoder.unkeyedContainer()
            for value in array {
                let decodable = AnyCodable(value: value)
                try container.encode(decodable)
            }
            return
        }

        if let dictionary = value as? [String: Any] {
            var container = encoder.container(keyedBy: CodingKeys.self)
            for (key, value) in dictionary {
                guard let codingKey = CodingKeys(stringValue: key) else {
                    continue
                }
                let decodable = AnyCodable(value: value)
                try container.encode(decodable, forKey: codingKey)
            }
            return
        }

        var container = encoder.singleValueContainer()

        if let intVal = value as? Int {
            try container.encode(intVal)
            return
        }

        if let doubleVal = value as? Double {
            try container.encode(doubleVal)
            return
        }

        if let decimalVal = value as? Decimal {
            try container.encode(decimalVal)
            return
        }

        if let boolVal = value as? Bool {
            try container.encode(boolVal)
            return
        }

        if let stringVal = value as? String {
            try container.encode(stringVal)
            return
        }
    }
}
