//
//  Blur.swift
//  Weather
//
//  Created by Dara To on 2022-06-17.
//

import SwiftUI

public struct Blur: View {
    var radius: CGFloat = 3
    var opaque: Bool = false
    
    public init(radius: CGFloat, opaque: Bool) {
        self.radius = radius
        self.opaque = opaque
    }
    
    public var body: some View {
        Backdrop()
            .blur(radius: radius, opaque: opaque)
    }
}
