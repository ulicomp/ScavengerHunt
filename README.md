# Project 1 - Scavenger Hunt

Submitted by: **Ulises Alberto Cheong Borges**

**Scavenger Hunt** is an iOS app that allows users to complete a list of scavenger hunt tasks by attaching photos. When a photo is selected, the task is marked as complete. If the photo contains GPS metadata, the app extracts the photo's location and displays it on a MapKit map with a custom annotation.

Time spent: **2.5** hours spent in total

## Required Features

The following **required** functionality is completed:

- [x] App displays list of hard-coded tasks
- [x] When a task is tapped it navigates the user to a task detail view
- [x] When user adds photo to complete the tasks, it marks the task as complete
- [x] When adding photo of task, the location is added
- [x] User returns to home page (list of tasks) and the status of your task is updated to complete

The following **optional** features are implemented:

- [ ] User can launch camera to snap a picture

The following **additional** features are implemented:

- [x] Selected task photo is displayed on the task detail screen
- [x] Completed tasks have distinct visual styling in both the detail screen and task list
- [x] App extracts GPS metadata directly from selected photo data
- [x] Photo location is displayed using MapKit with a custom map annotation
- [x] Photos without GPS metadata are handled gracefully with a location-unavailable message
- [x] Changing a task photo updates its location and clears stale coordinates when the new photo has no GPS metadata
- [x] Task detail screen is scrollable so photos, completion status, and the full map can be viewed on smaller screens
- [x] Canceling the photo picker safely leaves the task unchanged

## Video Walkthrough

Here's a walkthrough of implemented user stories:

[Video Walkthrough - Scavenger Hunt](https://youtube.com/shorts/wRAT6Qs4PGY)

The walkthrough demonstrates:

- Viewing the scavenger hunt task list
- Opening a task detail screen
- Viewing the task title and description
- Attaching a photo using the photo picker
- Viewing the selected photo
- Seeing the task update to completed
- Viewing the photo's GPS location on the map
- Viewing the custom map annotation
- Returning to the task list and seeing the completed status

## Notes

Some challenges encountered while building the app included:

- Preserving the selected photo's original data so its GPS metadata could be extracted.
- Reading latitude, longitude, and their N/S/E/W references from image metadata using ImageIO.
- Handling photos that do not contain GPS metadata without crashing or displaying an incorrect location.
- Making sure task completion changes made on the detail screen automatically update the task list using SwiftUI bindings.
- Clearing previously stored coordinates when a completed task's photo is replaced with a photo that does not contain location metadata.
- Adjusting the task detail layout so the entire MapKit map remains accessible and scrollable on smaller iPhone screens.

## License

    Copyright 2026 Ulises Alberto Cheong Borges

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
