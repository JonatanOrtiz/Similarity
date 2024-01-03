//
//  CustomError.swift
//  CoreInterface
//
//  Created by Jonatan Ortiz on 18/10/23.
//

public struct CustomError: Error, Identifiable {
    public let id = UUID()
    public var title: String?
    public var message: String?
    public var image: String?

    public init(title: String? = nil, message: String? = nil, image: String? = nil) {
        self.title = title
        self.message = message
        self.image = image
    }
}
