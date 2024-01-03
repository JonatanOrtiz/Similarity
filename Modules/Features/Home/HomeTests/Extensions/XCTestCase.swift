//
//  XCTestCase.swift
//  HomeTests
//
//  Created by Jonatan Ortiz on 17/10/23.
//
import XCTest

public extension XCTestCase {
    func assertDeallocated<T>(_ sut: inout T,
                              _ testDoubles: AnyObject...,
                              file: StaticString = #filePath,
                              line: UInt = #line) where T: AnyObject {
        XCTAssertTrue(isKnownUniquelyReferenced(&sut),
                      "Object has more than one strong reference.",
                      file: file,
                      line: line)

        testDoubles.forEach { trackForMemoryLeaks($0, file: file, line: line) }
    }

    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "Instance should have been deallocated. Potential memory leak.",
                file: file,
                line: line
            )
        }
    }
}
