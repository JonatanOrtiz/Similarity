//
//  HTTPRequestConfiguration.swift
//  CoreInterface
//
//  Created by Jonatan Ortiz on 19/02/24.
//

public struct HTTPRequestConfiguration: DataServiceConfiguration {
    public var url: URL
    public var method: HttpMethod
    public var headers: [String: String]
    public var body: Data?

    public init(url: URL, method: HttpMethod, headers: [String: String], body: Data? = nil) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
    }
}

public enum HttpMethod: String {
    case get = "GET", post = "POST", put = "PUT", delete = "DELETE"
}
