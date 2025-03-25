//
//  Models.swift
//  module-7-github-issues-swiftui
//
//  Created by Andrew Binkowski on 2/22/22.
//

import Foundation

struct GitHubUser: Codable, Hashable {
    let login: String
    let avatarUrl: String?
}

struct GitHubIssue: Codable, Identifiable, Hashable {
    /// We can use GitHub id that is passed from the API to conform to `Identifiable`
    let id: UInt32? /// Unique identifier for the issue from GitHub API
    let title: String? /// The title/headline of the issue
    let createdAt: String? /// ISO8601 timestamp when the issue was created
    let body: String? /// Full description/content of the issue
    let state: String? /// Current status of the issue ("open" or "closed")
    let user: GitHubUser /// The GitHub user who created the issue
    let htmlUrl: String? /// We can use this to get the user avatar url associated with the issue
    
    /// Returns the creation date in a human-readable format (MMM dd, yyyy)
    var formattedDate: String { 
        guard let createdAtString = createdAt,
              let date = ISO8601DateFormatter().date(from: createdAtString) else {
            return "Date Unavailable"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: date)
        
        
    }
}

