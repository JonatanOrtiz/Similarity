//
//  Text.swift
//  UI
//
//  Created by Jonatan Ortiz on 07/08/23.
//

import SwiftUI

public extension Text {
    func title(_ color: Color? = nil) -> Self {
        self.font(.system(.title, design: .rounded)).foregroundColor(color != nil ? color : .primaryColor) // 34pt
    }
    
    func titleBold(_ color: Color? = nil) -> Self {
        self.font(.system(.title, design: .rounded)).bold().foregroundColor(color != nil ? color : .primaryColor) // 34pt
    }
    
    func secondaryTitle(_ color: Color? = nil) -> Self {
        self.font(.system(.title2, design: .rounded)).foregroundColor(color != nil ? color : .primaryColor) // 28pt
    }
    
    func secondaryTitleBold(_ color: Color? = nil) -> Self {
        self.font(.system(.title2, design: .rounded)).bold().foregroundColor(color != nil ? color : .primaryColor) // 28pt
    }
    
    func tertiaryTitle(_ color: Color? = nil) -> Self {
        self.font(.system(.title3, design: .rounded)).foregroundColor(color != nil ? color : .primaryColor) // 22pt
    }
    
    func tertiaryTitleBold(_ color: Color? = nil) -> Self {
        self.font(.system(.title3, design: .rounded)).bold().foregroundColor(color != nil ? color : .primaryColor) // 22pt
    }
    
    func headline(_ color: Color? = nil) -> Self {
        self.font(.system(.headline, design: .rounded)).foregroundColor(color != nil ? color : .primaryColor) // 17pt
    }
    
    func headlineBold(_ color: Color? = nil) -> Self {
        self.font(.system(.headline, design: .rounded)).bold().foregroundColor(color != nil ? color : .primaryColor) // 17pt
    }
    
    func body(_ color: Color? = nil) -> Self {
        self.font(.system(.body, design: .rounded)).foregroundColor(color != nil ? color : .primaryColor) // 17pt
    }
    
    func bodyBold(_ color: Color? = nil) -> Self {
        self.font(.system(.body, design: .rounded)).bold().foregroundColor(color != nil ? color : .primaryColor) // 17pt
    }
    
    func callout(_ color: Color? = nil) -> Self {
        self.font(.system(.callout, design: .rounded)).foregroundColor(color != nil ? color : .primaryColor) // 16pt
    }
    
    func calloutBold(_ color: Color? = nil) -> Self {
        self.font(.system(.callout, design: .rounded)).bold().foregroundColor(color != nil ? color : .primaryColor) // 16pt
    }
    
    func subHeadline(_ color: Color? = nil) -> Self {
        self.font(.system(.subheadline, design: .rounded)).foregroundColor(color != nil ? color : .primaryColor) // 15pt
    }
    
    func subHeadlineBold(_ color: Color? = nil) -> Self {
        self.font(.system(.subheadline, design: .rounded)).bold().foregroundColor(color != nil ? color : .primaryColor) // 15pt
    }

    func footnote(_ color: Color? = nil) -> Self {
        self.font(.system(.footnote, design: .rounded)).foregroundColor(color != nil ? color : .primaryColor) // 13pt
    }
    
    func footnoteBold(_ color: Color? = nil) -> Self {
        self.font(.system(.footnote, design: .rounded)).bold().foregroundColor(color != nil ? color : .primaryColor) // 13pt
    }
    
    func caption(_ color: Color? = nil) -> Self {
        self.font(.system(.caption, design: .rounded)).foregroundColor(color != nil ? color : .primaryColor) // 12pt
    }
    
    func captionBold(_ color: Color? = nil) -> Self {
        self.font(.system(.caption, design: .rounded)).bold().foregroundColor(color != nil ? color : .primaryColor) // 12pt
    }
}
