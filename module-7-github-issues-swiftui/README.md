//
//  README.md
//  module-7-github-issues-swiftui
//
//  Created by Bruno Felalaga  on 2/28/25.
//

# GitHub Issues: SwiftUI App

This project demonstrates a SwiftUI implementation of a GitHub Issues management and display application for any GitHub repository. The application is designed for iOS 17+ devices and can be developed/built in Xcode 15+.

## Features

- **Dashboard Overview**: Visual gauge showing open vs. closed issues ratio
- **Tab-Based Navigation**: Easy switching between overview, open issues, and closed issues
- **Dynamic Issue Lists**: Browse the issues with pull-to-refresh functionality
- **Search Functionality**: Filter the issues by title or description content
- **Detailed Issue View**: See comprehensive issue information with user avatars
- **Web Integration**: Open issues directly in Safari with one tap
- **Responsive Design**: Supports both light and dark mode with custom color theming

## Technologies

- **SwiftUI**
- **MVVM Architecture**: Clean separation of UI and business logic
- **Custom UI Components**: Including UserAvatarView, gauge visualization
- Networking
    - **Swift Concurrency**: Async/await pattern for network operations to fetch issues
    - **URL Session**: For API communication
    - **JSON Decoder**: For parsing GitHub API responses
    - **AsyncImage**: For efficiently loading remote user avatars


## Design

- **Custom Color Schemes**: Different colors for open and closed issues
- **Adaptive Design**: Support for both light and dark modes
- **System-Rounded Typography**: Consistent font styling throughout the app
- **Tabbed Interface**: Intuitive navigation between different views
- **Dynamic Gauge**: Visual indicator of issue status ratios

## Implementation Highlights

- **Singleton Pattern**: For managing shared state with `GitHubClient`
- **SwiftUI Navigation Stack**: Used for drill-down navigation
- **Computed Properties**: For efficient data transformations
- **Environment Values**: Adapting to system settings like color scheme
- **Property Wrappers**: Using `@State`, `@ObservedObject`, `@Environment` for state management

## Getting Started

1. Clone the repository
2. Open `module-7-github-issues-swiftui.xcodeproj` in Xcode 15+
3. Build and run on iOS 17+ simulator or device

## Architecture

The application follows the MVC architecture with:

- **Models**: Defining `GitHubIssue` and `GitHubUser` structures
- **Views**: Components for displaying issues in different contexts
- **Client**: `GitHubClient` managing API communication and data storage

## Future Enhancements

- Authentication for accessing private repositories
- Issue creation and editing capabilities
- Comment viewing and management
- Additional filtering options (labels, assignees)
- Offline mode with local caching
                                                                                                                

## Demo showing the Home, OpenIssues, ClosedIssues TabViews and the IssueDetailView
                                                                                                                
<div align="center">
  <img src="Demo/home.png" width="200" alt="Dashboard View">
  <img src="Demo/openIssues.png" width="200" alt="Open Issues">
  <img src="Demo/closedIssues.png" width="200" alt="Closed Issues">
  <img src="Demo/issueDetailView.png" width="200" alt="Issue Details">
</div>
