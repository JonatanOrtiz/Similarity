//
//  Chip.swift
//  UI
//
//  Created by Jonatan Ortiz on 06/02/24.
//

import SwiftUI

public struct Chip: View {
    public var backgroundColor: Color
    public var icon: AssetIcon
    public var text: String

    public init(backgroundColor: Color, icon: AssetIcon, text: String) {
        self.backgroundColor = backgroundColor
        self.icon = icon
        self.text = text
    }

    public var body: some View {
        HStack {
            Image.assetIcon(icon)
                .resizable()
                .frame(width: 16, height: 16)
            Text(text)
                .body(.appWhite)
                .lineLimit(1)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(backgroundColor)
        .cornerRadius(15)
    }

    public static func makeGrids(with chips: [ChipData], availableWidth: CGFloat) -> [[ChipData]] {
        var grids: [[ChipData]] = [[]]
        var currentWidth: CGFloat = 0

        for chip in chips {
            let chipWidth = chip.text.widthOfString(usingFont: .systemFont(ofSize: 17)) + 40
            if currentWidth + chipWidth > availableWidth {
                grids.append([chip])
                currentWidth = chipWidth
            } else {
                grids[grids.count - 1].append(chip)
                currentWidth += chipWidth
            }
        }
        return grids
    }
}

public struct ChipData: Identifiable, Hashable {
    public var id = UUID().uuidString
    public var backgroundColor: Color
    public var icon: AssetIcon
    public var text: String

    public init(
        backgroundColor: Color,
        icon: AssetIcon,
        text: String,
        id: String = UUID().uuidString
    ) {
        self.id = id
        self.backgroundColor = backgroundColor
        self.icon = icon
        self.text = text
    }
}
