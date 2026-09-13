//
//  TaskDetailView.swift
//  ScavengerHunt
//
//  Created by Kiara Gonzlez Reyes on 9/13/26.
//

import SwiftUI

struct TaskDetailView: View {
    @Binding var task: ScavengerTask

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

                    Text("Photo not added yet")
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .navigationTitle("Task Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    @Previewable @State var task = ScavengerTask.sampleTasks[0]

    NavigationStack {
        TaskDetailView(task: $task)
    }
}
