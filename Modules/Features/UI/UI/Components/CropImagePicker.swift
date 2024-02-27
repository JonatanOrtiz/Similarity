//
//  CropImagePicker.swift
//  UI
//
//  Created by Jonatan Ortiz on 27/02/24.
//

import SwiftUI

struct CropImagePicker<Content: View>: View {
    var content: Content
    var completion: (Image) -> Void

    @Binding var show: Bool

    init(
        show: Binding<Bool>,
        completion: @escaping (Image) -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content()
        self._show = show
        self.completion = completion
    }

    @State private var selectedImage: Image?
    @State private var showCropView = false

    var body: some View {
        content
            .sheet(isPresented: $show) {
                ImagePicker { image in
                    selectedImage = image
                }
            }
            .onChange(of: selectedImage) { _ in
                showCropView = selectedImage != nil
            }
            .fullScreenCover(isPresented: $showCropView) {
                CropView(image: selectedImage) { croppedImage, _ in
                    if let croppedImage {
                        self.completion(Image(uiImage: croppedImage))
                    }
                }
            }
    }
}

struct CropView: View {
    var image: Image?
    var onCrop: (UIImage?, Bool) -> Void

    let width = UIScreen.main.bounds.width - 50
    let height = (UIScreen.main.bounds.width - 50) * 1.5

    @Environment(\.dismiss) private var dismiss

    @State private var scale: CGFloat = 1
    @State private var lastScale: CGFloat = 0
    @State private var offset: CGSize = .zero
    @State private var lastStoredOffset: CGSize = .zero
    @GestureState private var isInteracting = false

    var body: some View {
        NavigationStack {
            ImageView()
                .navigationTitle("Crop Your Photo")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(Color.black, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    Color.black
                        .ignoresSafeArea()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            let renderer = ImageRenderer(content: ImageView(true))
                            renderer.proposedSize = .init(width: width, height: height)
                            if let image = renderer.uiImage {
                                onCrop(image, true)
                            } else {
                                onCrop(nil, false)
                            }
                            dismiss()
                        } label: {
                            Image(systemName: "checkmark")
                                .font(.callout)
                                .fontWeight(.semibold)
                        }
                    }

                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.callout)
                                .fontWeight(.semibold)
                        }
                    }
                }
        }
    }

    @ViewBuilder
    func ImageView(_ hideGrids: Bool = false) -> some View {
        let cropSize: CGSize = .init(width: width, height: height)
        GeometryReader {
            let size = $0.size

            if let image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(content: {
                        GeometryReader { proxy in
                            let rect = proxy.frame(in: .named("CROPVIEW"))

                            Color.clear
                                .onChange(of: isInteracting) { newValue in
                                    if !newValue {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            if rect.minX > 0 {
                                                /// - Resetting to Last Location
                                                haptics(.medium)
                                                offset.width = (offset.width - rect.minX)
                                            }
                                            if rect.minY > 0 {
                                                /// - Resetting to Last Location
                                                haptics(.medium)
                                                offset.height = (offset.height - rect.minY)
                                            }

                                            /// - Doing the Same for maxX,Y
                                            if rect.maxX < size.width {
                                                /// - Resetting to Last Location
                                                haptics(.medium)
                                                offset.width = (rect.minX - offset.width)
                                            }

                                            if rect.maxY < size.height {
                                                /// - Resetting to Last Location
                                                haptics(.medium)
                                                offset.height = (rect.minY - offset.height)
                                            }
                                        }

                                        /// - Storing Last Offset
                                        lastStoredOffset = offset
                                    }
                                }
                        }
                    })
                    .frame(size)
            }
        }
        .scaleEffect(scale)
        .offset(offset)
        .overlay(content: {
            if !hideGrids {
                Grids()
            }
        })
        .coordinateSpace(name: "CROPVIEW")
        .gesture(
            DragGesture()
                .updating($isInteracting, body: { _, out, _ in
                    out = true
                })
                .onChanged({ value in
                    let translation = value.translation
                    offset = CGSize(width: translation.width + lastStoredOffset.width, height: translation.height + lastStoredOffset.height)
                })
        )
        .gesture(
            MagnificationGesture()
                .updating($isInteracting, body: { _, out, _ in
                    out = true
                })
                .onChanged({ value in
                    let updatedScale = value + lastScale
                    /// - Limiting Beyond 1
                    scale = (updatedScale < 1 ? 1 : updatedScale)
                })
                .onEnded({ _ in
                    withAnimation(.easeInOut(duration: 0.2)) {
                        if scale < 1 {
                            scale = 1
                            lastScale = 0
                        } else {
                            lastScale = scale - 1
                        }
                    }
                })
        )
        .frame(cropSize)
        .cornerRadius(20)
    }

    @ViewBuilder
    func Grids() -> some View {
        ZStack {
            HStack {
                ForEach(1...5, id: \.self) { _ in
                    Rectangle()
                        .fill(.white.opacity(0.7))
                        .frame(width: 1)
                        .frame(maxWidth: .infinity)
                }
            }

            VStack {
                ForEach(1...8, id: \.self) { _ in
                    Rectangle()
                        .fill(.white.opacity(0.7))
                        .frame(height: 1)
                        .frame(maxHeight: .infinity)
                }
            }
        }
    }
}
