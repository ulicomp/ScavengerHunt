//
//  TaskDetailView.swift
//  ScavengerHunt
//
//  Created by Kiara Gonzlez Reyes on 9/13/26.
//

import MapKit
import SwiftUI
import UIKit

struct TaskDetailView: View {
    @Binding var task: ScavengerTask
    @State private var isPhotoPickerPresented = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(task.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text(task.description)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }

                HStack(spacing: 10) {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(task.isCompleted ? .green : .secondary)
                        .imageScale(.large)

                    Text(task.isCompleted ? "Completed" : "Not Completed")
                        .font(.headline)
                        .foregroundStyle(task.isCompleted ? .green : .secondary)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Photo")
                        .font(.headline)

                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 320)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    } else {
                        Text("No photo attached yet")
                            .foregroundStyle(.secondary)
                    }

                    Button(task.photoData == nil ? "Attach Photo" : "Change Photo") {
                        isPhotoPickerPresented = true
                    }
                    .buttonStyle(.borderedProminent)
                }

                if task.photoData != nil {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Location")
                            .font(.headline)

                        if let coordinate = photoCoordinate {
                            Map(position: .constant(mapPosition(for: coordinate))) {
                                Annotation("Photo Location", coordinate: coordinate) {
                                    Image(systemName: "mappin")
                                        .font(.title3)
                                        .foregroundStyle(.white)
                                        .padding(8)
                                        .background(.red, in: Circle())
                                }
                            }
                            .frame(height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        } else {
                            Text("Location unavailable for this photo.")
                                .foregroundStyle(.secondary)

                            Text("Choose a photo that contains location metadata.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .padding(.bottom, 32)
        }
        .navigationTitle("Task Details")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isPhotoPickerPresented) {
            PhotoPicker { data in
                guard let data else {
                    return
                }

                task.photoData = data
                task.isCompleted = true

                if let coordinate = PhotoMetadata.coordinate(from: data) {
                    task.latitude = coordinate.latitude
                    task.longitude = coordinate.longitude
                } else {
                    task.latitude = nil
                    task.longitude = nil
                }
            }
        }
    }

    private var selectedImage: UIImage? {
        guard let photoData = task.photoData else {
            return nil
        }

        return UIImage(data: photoData)
    }

    private var photoCoordinate: CLLocationCoordinate2D? {
        guard
            let latitude = task.latitude,
            let longitude = task.longitude
        else {
            return nil
        }

        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        guard CLLocationCoordinate2DIsValid(coordinate) else {
            return nil
        }

        return coordinate
    }

    private func mapPosition(for coordinate: CLLocationCoordinate2D) -> MapCameraPosition {
        MapCameraPosition.region(
            MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        )
    }
}

#Preview {
    @Previewable @State var task = ScavengerTask.sampleTasks[0]

    NavigationStack {
        TaskDetailView(task: $task)
    }
}
