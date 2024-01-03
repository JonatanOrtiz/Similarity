//
//  SignInTests.swift
//  HomeTests
//
//  Created by Jonatan Ortiz on 16/10/23.
//

import XCTest
import CoreInterface
@testable import Home

final class SignInTests: XCTestCase {
    func testSignIn_whenSuccess_ShouldReceiveTheRightValues() {
        let (sut, doubles): (any SignInViewModeling, Doubles<User>) = makeSUT()
        let event = SignInAnalytics.buttonClicked(.signIn).equatableEvent()
        let user = User(uid: "789", email: "email@test.com")
        let email = "email@test.com"
        let password = "123"
        
        doubles.authMock.expectedResult = .success(user)
        
        sut.signIn(email: email, password: password)
        
        RunLoop.current.run(until: Date())
        
        XCTAssertEqual(doubles.analyticsSpy.events, [event])
        XCTAssertEqual(doubles.authMock.signInInvocations.count, 1)
        XCTAssertEqual(doubles.authMock.signInInvocations.first?.email, email)
        XCTAssertEqual(doubles.authMock.signInInvocations.first?.password, password)
        XCTAssertEqual(sut.user?.email,email)
        XCTAssertNil(sut.error)
    }
    
    func testSignIn_whenFailure_ShouldReceiveTheRightValues() {
        let (sut, doubles): (any SignInViewModeling, Doubles<User>) = makeSUT()
        let event = SignInAnalytics.buttonClicked(.signIn).equatableEvent()
        let email = "email@test.com"
        let password = "123"
        
        doubles.authMock.expectedResult = .failure(AuthenticationError.unknown)
        
        sut.signIn(email: email, password: password)
        
        RunLoop.current.run(until: Date())
        
        XCTAssertEqual(doubles.analyticsSpy.events, [event])
        XCTAssertEqual(doubles.authMock.signInInvocations.count, 1)
        XCTAssertEqual(doubles.authMock.signInInvocations.first?.email, email)
        XCTAssertEqual(doubles.authMock.signInInvocations.first?.password, password)
        XCTAssertNil(sut.user)
        XCTAssertNotEqual(sut.error?.message, String())
    }
    
    func testSignInWithGoogle_whenSuccess_ShouldReceiveTheRightValues() {
        let (sut, doubles): (any SignInViewModeling, Doubles<User>) = makeSUT()
        let event = SignInAnalytics.buttonClicked(.signInWithGoogle).equatableEvent()
        let user = User(uid: "789", email: "email@test.com")
        let email = "email@test.com"
        
        doubles.authMock.expectedResult = .success(user)
        
        sut.signInWithGoogle()
        
        RunLoop.current.run(until: Date())
        
        XCTAssertEqual(doubles.analyticsSpy.events, [event])
        XCTAssertEqual(doubles.authMock.signInWithGoogleCount, 1)
        XCTAssertEqual(sut.user?.email, email)
        XCTAssertNil(sut.error)
    }
    
    func testSignInWithGoogle_whenFailure_ShouldReceiveTheRightValues() {
        let (sut, doubles): (any SignInViewModeling, Doubles<User>) = makeSUT()
        let event = SignInAnalytics.buttonClicked(.signInWithGoogle).equatableEvent()
        
        doubles.authMock.expectedResult = .failure(AuthenticationError.unknown)
        
        sut.signInWithGoogle()
        
        RunLoop.current.run(until: Date())
        
        XCTAssertEqual(doubles.analyticsSpy.events, [event])
        XCTAssertEqual(doubles.authMock.signInWithGoogleCount, 1)
        XCTAssertNil(sut.user)
        XCTAssertNotEqual(sut.error?.message, String())
    }
}

// MARK: - MakeSut
extension SignInTests {
    typealias Doubles<T> = (
        analyticsSpy: AnalyticsSpy,
        authMock: AuthenticationMock<T>
    )
    
    func makeSUT<T>(file: StaticString = #filePath, line: UInt = #line) -> (sut: any SignInViewModeling, doubles: Doubles<T>) {
        let analyticsSpy = AnalyticsSpy()
        let authMock = AuthenticationMock<T>()
        let dependencies = DependencyContainerMock(authMock, analyticsSpy)
        let doubles = (analyticsSpy, authMock)
        var sut = SignInViewModel(dependencies: dependencies)
        
        assertDeallocated(&sut, analyticsSpy, authMock, file: file, line: line)
        
        return (sut, doubles)
    }
}
