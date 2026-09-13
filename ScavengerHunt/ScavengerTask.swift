//
//  ScavengerTask.swift
//  ScavengerHunt
//
//  Created by Kiara Gonzlez Reyes on 9/13/26.
//

import Foundation

struct ScavengerTask: Identifiable {
    let id: UUID
    var title: String
    var description: String
    var isCompleted: Bool
    var photoData: Data?
    var latitude: Double?
    var longitude: Double?

    init(
        id: UUID = UUID(),
        title: String,
        description: String,
        isCompleted: Bool = false,
        photoData: Data? = nil,
        latitude: Double? = nil,
        longitude: Double? = nil
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.photoData = photoData
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension ScavengerTask {
    static let sampleTasks: [ScavengerTask] = [
        ScavengerTask(
            title: "Find Something Blue",
            description: "Find something blue around you and take a photo of it."
        ),
        ScavengerTask(
            title: "Explore Outdoors",
            description: "Go outside and take a photo of something interesting outdoors."
        ),
        ScavengerTask(
            title: "Find a Campus Sign",
            description: "Find a campus or school sign and take a photo of it."
        ),
        ScavengerTask(
            title: "Favorite Snack",
            description: "Take a photo of your favorite snack."
        ),
        ScavengerTask(
            title: "School Spirit",
            description: "Find something with your school logo and take a photo of it."
        ),
        ScavengerTask(
            title: "Everyday Essential",
            description: "Take a photo of something you use every day."
        )
    ]
}
