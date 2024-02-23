//
//  ImagePicker.swift
//  UI
//
//  Created by Jonatan Ortiz on 22/02/24.
//

import SwiftUI

public struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var completion: (Image) -> Void

    public init(completion: @escaping (Image) -> Void) {
        self.completion = completion
    }

    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = context.coordinator
        return picker
    }

    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        public func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
        ) {
            if let editedImage = info[.editedImage] as? UIImage {
                let image = Image(uiImage: editedImage)
                parent.completion(image)
            } else if let originalImage = info[.originalImage] as? UIImage {
                let image = Image(uiImage: originalImage)
                parent.completion(image)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

public struct PhotoDropDelegate: DropDelegate {
    let currentPhoto: Photo
    @Binding var photos: [Photo]
    @Binding var activePhotoId: UUID?

    public init(currentPhoto: Photo, photos: Binding<[Photo]>, activePhotoId: Binding<UUID?>) {
        self.currentPhoto = currentPhoto
        self._photos = photos
        self._activePhotoId = activePhotoId
    }

    public func performDrop(info: DropInfo) -> Bool {
        guard let activePhotoId = activePhotoId,
              let sourceIndex = photos.firstIndex(where: { $0.id == activePhotoId }),
              let targetIndex = photos.firstIndex(where: { $0.id == currentPhoto.id })
        else {
            return false
        }

        if sourceIndex != targetIndex {
            withAnimation {
                photos.move(
                    fromOffsets: IndexSet(integer: sourceIndex),
                    toOffset: targetIndex > sourceIndex ? targetIndex + 1 : targetIndex
                )
            }
        }

        return true
    }
}

public struct Photo: Identifiable, Equatable {
    public let id: UUID
    public var image: Image

    public init(image: Image, id: UUID = UUID()) {
        self.id = id
        self.image = image
    }
}
