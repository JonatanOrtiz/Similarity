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
            if let originalImage = info[.originalImage] as? UIImage {
                let image = Image(uiImage: originalImage)
                parent.completion(image)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
