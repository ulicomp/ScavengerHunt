//
//  TaskListView.swift
//  ScavengerHunt
//
//  Created by Kiara Gonzlez Reyes on 9/13/26.
//

import SwiftUI

struct TaskListView: View {
    @Binding var tasks: [ScavengerTask]

    var body: some View {
        NavigationStack {
            List {
                ForEach($tasks) { $task in
                    NavigationLink {
                        TaskDetailView(task: $task)
                    } label: {
                        TaskRowView(task: task)
                    }
                }
            }
            .navigationTitle("Scavenger Hunt")
        }
    }
}

private struct TaskRowView: View {
    let task: ScavengerTask

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(task.isCompleted ? .green : .secondary)
                .imageScale(.large)

            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.headline)
                    .foregroundStyle(task.isCompleted ? .secondary : .primary)
                    .strikethrough(task.isCompleted)

                Text(task.isCompleted ? "Completed" : "Not Completed")
                    .font(.subheadline)
                    .foregroundStyle(task.isCompleted ? .green : .secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    @Previewable @State var tasks = ScavengerTask.sampleTasks

    TaskListView(tasks: $tasks)
}
