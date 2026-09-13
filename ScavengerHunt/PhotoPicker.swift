//
//  PhotoPicker.swift
//  ScavengerHunt
//
//  Created by Kiara Gonzlez Reyes on 9/13/26.
//

import PhotosUI
import SwiftUI
import UniformTypeIdentifiers

struct PhotoPicker: UIViewControllerRepresentable {
    let onImagePicked: (Data?) -> Void

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.filter = .images
        configuration.selectionLimit = 1
        configuration.preferredAssetRepresentationMode = .current

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(onImagePicked: onImagePicked)
    }
}

extension PhotoPicker {
    final class Coordinator: NSObject, PHPickerViewControllerDelegate {
        private let onImagePicked: (Data?) -> Void

        init(onImagePicked: @escaping (Data?) -> Void) {
            self.onImagePicked = onImagePicked
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard
                let provider = results.first?.itemProvider,
                provider.hasItemConformingToTypeIdentifier(UTType.image.identifier)
            else {
                complete(with: nil)
                return
            }

            let typeIdentifier = provider.registeredTypeIdentifiers.first { identifier in
                UTType(identifier)?.conforms(to: .image) == true
            } ?? UTType.image.identifier

            provider.loadFileRepresentation(forTypeIdentifier: typeIdentifier) { [weak self] url, _ in
                guard let self else {
                    return
                }

                if let url, let data = try? Data(contentsOf: url) {
                    self.complete(with: data)
                    return
                }

                self.loadDataRepresentation(from: provider, typeIdentifier: typeIdentifier)
            }
        }

        private func loadDataRepresentation(from provider: NSItemProvider, typeIdentifier: String) {
            provider.loadDataRepresentation(forTypeIdentifier: typeIdentifier) { [weak self] data, _ in
                self?.complete(with: data)
            }
        }

        private func complete(with data: Data?) {
            DispatchQueue.main.async {
                self.onImagePicked(data)
            }
        }
    }
}
