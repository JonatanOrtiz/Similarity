//
//  SignInAnalytics.swift
//  Home
//
//  Created by Jonatan Ortiz on 16/10/23.
//

import Foundation
import CoreInterface

struct SignInAnalytics: AnalyticsKeyProtocol {
    let name: String
    let properties: [String: Any]

    static let screenName = "SIGN_IN"
    private static let businessContext = "HOME"

    static var screenViewed: Self {
        let keyProperties = [
            EventKeys.screenName: screenName,
            EventKeys.businessContext: businessContext
        ]
        return .init(
            name: EventName.screenViewed,
            properties: keyProperties
        )
    }

    static func buttonClicked(_ buttonName: ButtonName) -> Self {
        let keyProperties = [
            EventKeys.screenName: screenName,
            EventKeys.businessContext: businessContext,
            EventKeys.buttonName: buttonName.rawValue
        ]
        return .init(
            name: EventName.buttonClicked,
            properties: keyProperties
        )
    }

    static func textBoxClicked(_ textBoxName: TextBoxName) -> Self {
        let keyProperties = [
            EventKeys.screenName: screenName,
            EventKeys.businessContext: businessContext,
            EventKeys.textBoxName: textBoxName.rawValue
        ]
        return .init(
            name: EventName.textBoxClicked,
            properties: keyProperties
        )
    }

    static func textBoxFilled(_ textBoxName: TextBoxName) -> Self {
        let keyProperties = [
            EventKeys.screenName: screenName,
            EventKeys.businessContext: businessContext,
            EventKeys.textBoxName: textBoxName.rawValue
        ]
        return .init(
            name: EventName.textBoxFilled,
            properties: keyProperties
        )
    }

    static func errorMessageViewed(_ errorViewed: ErrorViewed, errorMessage: String) -> Self {
        let keyProperties = [
            EventKeys.screenName: screenName,
            EventKeys.businessContext: businessContext,
            EventKeys.errorName: errorViewed.rawValue,
            EventKeys.errorMessage: errorMessage
        ]
        return .init(
            name: EventName.errorMessageViewed,
            properties: keyProperties
        )
    }

    func event() -> AnalyticsEventProtocol {
        AnalyticsEvent(name, properties: properties)
    }
}

extension SignInAnalytics {
    enum ButtonName: String {
        case back = "BACK"
        case signIn = "SIGN_IN"
        case signInWithGoogle = "SIGN_IN_WITH_GOOGLE"
        case register = "REGISTER"
    }

    enum TextBoxName: String {
        case email = "EMAIL"
        case password = "PASSWORD"
    }

    enum ErrorViewed: String {
        case emailError = "INCORRECT_EMAIL"
        case passwordError = "INCORRECT_PASSWORD"
    }
}
