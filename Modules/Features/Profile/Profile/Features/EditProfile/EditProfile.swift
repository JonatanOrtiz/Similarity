//
//  EditProfile.swift
//  Profile
//
//  Created by Jonatan Ortiz on 22/02/24.
//

import SwiftUI
import UI

public struct EditProfile: View {
    public init() {}

    public var body: some View {
        PhotoGridView()
    }
}

#Preview {
    EditProfile()
}

struct PhotoGridView: View {
    @State private var photos: [Photo] = []
    @State private var showingImagePicker = false
    @State private var activePhotoId: UUID?
    @State private var replacementIndex: Int?

    private let maxPhotos = 6

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size.width / 3 - 10
            VStack {
                LazyVGrid(
                    columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())],
                    spacing: 10
                ) {
                    ForEach(0..<maxPhotos, id: \.self) { index in
                        if index < photos.count {
                            imageForPhoto(index, size)
                                .onDrag {
                                    self.activePhotoId = photos[index].id
                                    return NSItemProvider(object: String(photos[index].id.uuidString) as NSString)
                                }
                                .onDrop(
                                    of: [.text],
                                    delegate: PhotoDropDelegate(
                                        currentPhoto: photos[index],
                                        photos: $photos,
                                        activePhotoId: $activePhotoId
                                    )
                                )
                        }
                    }
                    ForEach(0..<(maxPhotos - photos.count), id: \.self) { _ in
                        addButtonOrPlaceholder(size)
                    }
                }
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker { selectedImage in
                        let newPhoto = Photo(image: selectedImage)
                        if let replacementIndex = replacementIndex, replacementIndex < photos.count {
                            photos[replacementIndex] = newPhoto
                        } else if photos.count < maxPhotos {
                            self.photos.append(newPhoto)
                        }
                    }
                }
                .animation(.default, value: photos)
                .padding()
            }
        }
    }

    private func imageForPhoto(_ index: Int, _ size: CGFloat) -> some View {
        photos[index].image
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .clipped()
            .cornerRadius(20)
            .onTapGesture {
                self.replacementIndex = index
                self.showingImagePicker = true
            }
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    withAnimation {
                        var newPhotos = photos
                        newPhotos.remove(at: index)
                        photos = newPhotos
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding(10)
                }
            }
    }

    private func addButtonOrPlaceholder(_ size: CGFloat) -> some View {
        Button(action: {
            self.replacementIndex = nil
            showingImagePicker = true
        }) {
            Image(systemName: "plus.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.gray)
        }
        .frame(width: 100, height: 100)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
    }
}
