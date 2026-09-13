//
//  ContentView.swift
//  ScavengerHunt
//
//  Created by Kiara Gonzlez Reyes on 9/13/26.
//

import SwiftUI

struct ContentView: View {
    @State private var tasks = ScavengerTask.sampleTasks

    var body: some View {
        TaskListView(tasks: $tasks)
    }
}

#Preview {
    ContentView()
}
