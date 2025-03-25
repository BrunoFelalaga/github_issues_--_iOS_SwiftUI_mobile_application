//
//  IssueTabView.swift
//  module-7-github-issues-swiftui
//
//  Created by Andrew Binkowski on 2/16/24.
//

import SwiftUI

struct IssueTabView: View {
    let state: String
    let issues: [GitHubIssue]
    @Environment(\.colorScheme) var colorScheme
    @State private var query = ""
    
    /// Store a filtered version of the GitHub issues that were returned from the server. If there are no search terms present, then show all the search results.
    var filteredIssues: [GitHubIssue] {
        // Filter issues with case insesitivity for title and body
        if query.isEmpty {
            return issues
        } else {
            print("🔎 Query: \(query)")
            let lowercasedQuery = query.lowercased()
            return issues.filter {
                ($0.title?.lowercased().contains(lowercasedQuery) ?? false) || ($0.body?.lowercased().contains(lowercasedQuery) ?? false)
            }
        }
    }
    
    var body: some View {
        NavigationStack { // Stack to navigate selected row into detailview
           
            List (filteredIssues) { item in  // List all issues in rows
                NavigationLink(value: item) {
                    GithubIssueRow(issue: item)
                }
            }
            .refreshable {
                Task { // task to aynchronously fetch issues in a synchronous modifier
                    do {
                        try await GitHubClient.shared.fetchIssues()
                    } catch {
                        print("Failed to refresh issues:", error)
                    }
                }
            }
            .navigationDestination(for: GitHubIssue.self) { item in
                IssueDetailView(issue: item)
            }
            .searchable(text: $query, // add a search bar for filtering issues
                        prompt: "Search issues")
            .navigationBarTitle(state == "open" ? "Open Issues" : "Closed Issues")
    
            // Set toolbar/navigation background based on type of issue. Also set to visiible
            .toolbarBackground(state == "open" ? Color("OpenIssuesColor") : Color("ClosedIssuesColor"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)

        }
    }
}

#Preview {
    // Create an instance of the client and pass into the preview view
    let issues = GitHubClient.shared
    
    // Can actually show both views for open and closed in preview. For testing of course
    IssueTabView(state: "open", issues: issues.openIssues)
    IssueTabView(state: "closed", issues: issues.openIssues)
}

#Preview {
    // Create an instance of the client and pass into the preview view
    let issues = GitHubClient.shared
    
    // Can actually show both views for open and closed in preview. For testing of course
    IssueTabView(state: "open", issues: issues.openIssues)
        .preferredColorScheme(.dark)
    IssueTabView(state: "closed", issues: issues.openIssues)
        .preferredColorScheme(.dark)
}
