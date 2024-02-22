//
//  Chip.swift
//  UI
//
//  Created by Jonatan Ortiz on 06/02/24.
//

import SwiftUI

public struct Chip: View {
    public var backgroundColor: Color
    public var text: String
    public var icon: AssetIcon?
    public var sfIcon: SFSymbol?

    public init(
        backgroundColor: Color,
        text: String,
        icon: AssetIcon? = nil,
        sfIcon: SFSymbol? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.text = text
        self.icon = icon
        self.sfIcon = sfIcon
    }

    public var body: some View {
        HStack(spacing: 5) {
            if let icon {
                Image.assetIcon(icon)
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            if let sfIcon {
                Image.assetSFSymbol(sfIcon)
            }
            Text(text)
                .body(.appWhite)
                .lineLimit(1)
        }
        .padding(.horizontal, 12)
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
    public var text: String
    public var icon: AssetIcon?
    public var sfIcon: SFSymbol?

    public init(
        backgroundColor: Color,
        text: String,
        id: String = UUID().uuidString,
        icon: AssetIcon? = nil,
        sfIcon: SFSymbol? = nil
    ) {
        self.id = id
        self.backgroundColor = backgroundColor
        self.text = text
        self.icon = icon
        self.sfIcon = sfIcon
    }
}
