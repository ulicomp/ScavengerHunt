//
//  TaskDetailView.swift
//  ScavengerHunt
//
//  Created by Kiara Gonzlez Reyes on 9/13/26.
//

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
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
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
            }
        }
    }

    private var selectedImage: UIImage? {
        guard let photoData = task.photoData else {
            return nil
        }

        return UIImage(data: photoData)
    }
}

#Preview {
    @Previewable @State var task = ScavengerTask.sampleTasks[0]

    NavigationStack {
        TaskDetailView(task: $task)
    }
}
