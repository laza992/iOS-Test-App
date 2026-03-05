# iOS Test App

## Overview
The idea is to build a simple scalable application around the Github API. While the visuals were left open, the primary accent is on the application architecture, code readability, and maintainability. This project demonstrates a production-ready approach, focusing on a clear separation of concerns, modern concurrency, and robust dependency injection.

## Goals Achieved
* **Architecture, fit for large scale projects**: Implemented a highly decoupled, hybrid architecture (VIPER + MVVM).
* **Attention to details and thinking outside of the box**: Utilized programmatic UI for the base screen, transitioning fluidly to a modern SwiftUI implementation for the detail screen.
* **Simplicity**: Clean, readable code without over-engineering, utilizing modern Swift features to reduce boilerplate.

## Architecture: The Hybrid Approach
To demonstrate readiness for modern, large-scale iOS applications, this app utilizes a hybrid architectural pattern:
* **User Repos Screen (UIKit + VIPER):** The first screen is built entirely programmatically (no Storyboards or XIBs) using the VIPER architectural pattern. This ensures a strict separation of business logic, routing, and presentation.
* **Repo Details Screen (SwiftUI + MVVM):** The second screen transitions to SwiftUI wrapped in a `UIHostingController`. This demonstrates interoperability and the ability to seamlessly modernize specific flows within an existing UIKit application.

## Key Technical Highlights

### 1. Dependency Injection & Mocking
Architecture should be set up in such a way that we can easily mock REST API calls by just changing one layer with dependency injection.
* All network calls are abstracted behind the `GitHubServiceProtocol`.
* A `MockGitHubService` is included out-of-the-box, allowing UI and logic testing without live internet constraints. You can effortlessly switch to this mock service inside the `UserReposRouter`.

### 2. State Management
The state of API calls (error, success) should be properly delegated back to the controller/view.
* Using custom State enums, the View acts as a passive component. It only reacts to UI signals (`.loading`, `.success`, `.error`) emitted by the Presenter or ViewModel, keeping data processing strictly isolated in the business layer.

### 3. Modern Concurrency (`async/await`)
* The app leverages Swift's modern concurrency model to ensure thread safety and readable asynchronous code. 
* On the Repository Details screen, `async let` is used to fetch both repository details and tags in parallel, significantly reducing the loading time and optimizing the user experience.

### 4. UI Implementation
* **Programmatic Auto Layout:** Used for the initial screen to avoid Storyboard merge conflicts and ensure highly maintainable constraints.
* **SwiftUI Scrollable Layout:** The detail screen uses a unified `ScrollView` so that the header and the list of tags are smoothly scrollable together, perfectly fulfilling the UI specifications.

## Requirements Checklist
- [x] Fetch and display User Repositories (with open issues count).
- [x] Navigate to Repo Details.
- [x] Display repo header (avatar, name, forks, watchers).
- [x] Fetch and display Repo Tags (name and commit SHA).
- [x] Entire detail screen is scrollable as a single unit.
- [x] Easily mockable REST API via Dependency Injection.
- [x] Proper API state delegation.

## How to Run
1. Clone the repository.
2. Open the project in Xcode (No third-party dependencies or CocoaPods are required).
3. Build and run on any iOS Simulator or real device.
*(Note: To test the Mock data and see full offline functionality, simply swap `GitHubService()` with `MockGitHubService()` inside `UserReposRouter.swift`)*
