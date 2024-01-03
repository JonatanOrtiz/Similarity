//
//  Text.swift
//  UI
//
//  Created by Jonatan Ortiz on 07/08/23.
//

import SwiftUI

public extension Text {
    func title(_ color: Color? = nil) -> Self {
        self.font(.title).foregroundColor(color != nil ? color : .primary) // 34pt
    }
    
    func titleBold(_ color: Color? = nil) -> Self {
        self.font(.title).bold().foregroundColor(color != nil ? color : .primary) // 34pt
    }
    
    func secondaryTitle(_ color: Color? = nil) -> Self {
        self.font(.title2).foregroundColor(color != nil ? color : .primary) // 28pt
    }
    
    func secondaryTitleBold(_ color: Color? = nil) -> Self {
        self.font(.title2).bold().foregroundColor(color != nil ? color : .primary) // 28pt
    }
    
    func tertiaryTitle(_ color: Color? = nil) -> Self {
        self.font(.title3).foregroundColor(color != nil ? color : .primary) // 22pt
    }
    
    func tertiaryTitleBold(_ color: Color? = nil) -> Self {
        self.font(.title3).bold().foregroundColor(color != nil ? color : .primary) // 22pt
    }
    
    func headline(_ color: Color? = nil) -> Self {
        self.font(.headline).foregroundColor(color != nil ? color : .primary) // 17pt
    }
    
    func headlineBold(_ color: Color? = nil) -> Self {
        self.font(.headline).bold().foregroundColor(color != nil ? color : .primary) // 17pt
    }
    
    func body(_ color: Color? = nil) -> Self {
        self.font(.body).foregroundColor(color != nil ? color : .primary) // 17pt
    }
    
    func bodyBold(_ color: Color? = nil) -> Self {
        self.font(.body).bold().foregroundColor(color != nil ? color : .primary) // 17pt
    }
    
    func callout(_ color: Color? = nil) -> Self {
        self.font(.callout).foregroundColor(color != nil ? color : .primary) // 16pt
    }
    
    func calloutBold(_ color: Color? = nil) -> Self {
        self.font(.callout).bold().foregroundColor(color != nil ? color : .primary) // 16pt
    }
    
    func subHeadline(_ color: Color? = nil) -> Self {
        self.font(.subheadline).foregroundColor(color != nil ? color : .primary) // 15pt
    }
    
    func subHeadlineBold(_ color: Color? = nil) -> Self {
        self.font(.subheadline).bold().foregroundColor(color != nil ? color : .primary) // 15pt
    }

    func footnote(_ color: Color? = nil) -> Self {
        self.font(.footnote).foregroundColor(color != nil ? color : .primary) // 13pt
    }
    
    func footnoteBold(_ color: Color? = nil) -> Self {
        self.font(.footnote).bold().foregroundColor(color != nil ? color : .primary) // 13pt
    }
    
    func caption(_ color: Color? = nil) -> Self {
        self.font(.caption).foregroundColor(color != nil ? color : .primary) // 12pt
    }
    
    func captionBold(_ color: Color? = nil) -> Self {
        self.font(.caption).bold().foregroundColor(color != nil ? color : .primary) // 12pt
    }
}
