//
//  View.swift
//  UI
//
//  Created by Jonatan Ortiz on 21/07/23.
//

import SwiftUI
import CoreInterface

// MARK: - Methods
public extension View {
    func innerShadow<S: Shape, SS: ShapeStyle>(
        shape: S,
        color: SS,
        lineWidth: CGFloat = 1,
        offsetX: CGFloat = 0,
        offsetY: CGFloat = 0,
        blur: CGFloat = 4,
        blendMode: BlendMode = .normal,
        opacity: Double = 1
    ) -> some View {
        self.overlay {
            shape
                .stroke(color, lineWidth: lineWidth)
                .blendMode(blendMode)
                .offset(x: offsetX, y: offsetY)
                .blur(radius: blur)
                .mask(shape)
                .opacity(opacity)
        }
    }
    
    func flatGlassCard(color: Color = .primaryReverse) -> some View {
        self
            .frame(maxWidth: .infinity)
            .background(color)
            .background(Blur(radius: 25, opaque: true))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .innerShadow(
                shape: RoundedRectangle(cornerRadius: 20),
                color: Color.white,
                lineWidth: 0.8,
                offsetX: 0.2,
                offsetY: 0.5,
                blur: 0,
                blendMode: .overlay,
                opacity: 0.4
            )
            .padding(0, 10, 0, 10)
    }
    
    func flatGlass() -> some View {
        self
            .background(Blur(radius: 25, opaque: true))
            .innerShadow(
                shape: RoundedRectangle(cornerRadius: 0),
                color: Color.white,
                lineWidth: 0.8,
                offsetX: 0.2,
                offsetY: 0.5,
                blur: 0,
                blendMode: .overlay,
                opacity: 0.4
            )
    }

    func cardStyle(background: Color = .appPurple) -> some View {
        self
            .frame(maxWidth: .infinity)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .innerShadow(
                shape: RoundedRectangle(cornerRadius: 20),
                color: .white,
                lineWidth: 2,
                offsetX: 0.2,
                offsetY: 0.5,
                blur: 0,
                blendMode: .overlay,
                opacity: 0.4
            )
            .padding(0, 10, 0, 10)
    }
    
    func backgroundBlur(radius: CGFloat, opaque: Bool) -> some View {
        self.background(Blur(radius: radius, opaque: opaque))
    }
    
    func backgroundImage(_ image: AssetImage? = nil) -> some View {
        self
            .background(
                Image.assetImage(image ?? .backgroundImage)
                    .resizable()
                    .ignoresSafeArea()
                    .aspectRatio(contentMode: .fill)
            )
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func cornerRadiusForIndex(_ index: Int, _ count: Int) -> some View {
        if count - 1 == 0 {
            return self.cornerRadius(20, corners: .allCorners)
        } else if index == count - 1 {
            return self.cornerRadius(20, corners: [.topRight, .bottomRight])
        } else if index == 0 {
            return self.cornerRadius(20, corners: [.topLeft, .bottomLeft])
        } else {
            return self.cornerRadius(0, corners: .allCorners)
        }
    }
    
    func readHeight(_ detentHeight: Binding<CGFloat>) -> some View {
        self
            .modifier(ReadHeightModifier())
            .onPreferenceChange(HeightPreferenceKey.self) { height in
                if let height = height {
                    detentHeight.wrappedValue = height
                }
            }
            .presentationDetents([.height(detentHeight.wrappedValue)])
    }
    
    func feedBackBottomSheet(
        isPresented: Binding<Bool>,
        image: AssetImage,
        title: String,
        message: String,
        primaryButton: FeedBackBottomSheetButton? = nil,
        secondaryButton: FeedBackBottomSheetButton? = nil
    ) -> some View {
        self.sheet(isPresented: isPresented) {
            FeedBackBottomSheet(
                image: image,
                title: title,
                message: message,
                primaryButton: primaryButton,
                secondaryButton: secondaryButton
            )
        }
    }

    func errorBottomSheet(
        customError: Binding<CustomError?>,
        primaryButton: FeedBackBottomSheetButton? = nil,
        secondaryButton: FeedBackBottomSheetButton? = nil
    ) -> some View {
        self.sheet(item: customError) { error in
            FeedBackBottomSheet(
                image: AssetImage(rawValue: customError.wrappedValue?.image ?? String()),
                title: error.title,
                message: error.message,
                primaryButton: primaryButton,
                secondaryButton: secondaryButton
            )
        }
    }

    func customBottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        background: Color? = nil,
        height: CGFloat? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.sheet(isPresented: isPresented) {
            CustomBottomSheet(customView: content(), background: background, height: height)
        }
    }

    @ViewBuilder
    func conditionalPresentationBackground(_ color: Color?) -> some View {
        if let color = color {
            self.presentationBackground(color)
        } else {
            self
        }
    }

    func padding(
        _ top: CGFloat,
        _ leading: CGFloat,
        _ bottom: CGFloat,
        _ trailing: CGFloat
    ) -> some View {
        self.padding(EdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing))
    }
    
    func cropImagePicker(
        show: Binding<Bool>,
        completion: @escaping (Image) -> Void
    ) -> some View {
        CropImagePicker(show: show, completion: completion) {
            self
        }
    }

    func frame(_ size: CGSize) -> some View {
        self.frame(width: size.width, height: size.height)
    }

    func haptics(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}

// MARK: - Properties
public extension View {
    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
}
