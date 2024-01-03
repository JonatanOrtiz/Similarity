//
//  String.swift
//  UI
//
//  Created by Jonatan Ortiz on 25/07/23.
//

import SwiftUI

public extension String {
    var firstLetterCapitalized: Self {
        guard let firstChar = first else { return String() }
        return String(firstChar).uppercased() + dropFirst()
    }

    var isNotEmpty: Bool {
        !self.isEmpty
    }

    var isNotEmptyBinding: Binding<Bool> {
        Binding<Bool>(
            get: { !self.isEmpty },
            set: { _ in }
        )
    }
}
