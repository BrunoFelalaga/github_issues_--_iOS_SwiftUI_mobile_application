//
//  GithubIssueRow.swift
//  module-7-github-issues-swiftui
//
//  Created by Andrew Binkowski on 2/22/22.
//

import SwiftUI

// This view shows issue title, user avatar, and login
// This is displayed in the issue tabview and is the unit of the list of issues
struct GithubIssueRow: View {
    let issue: GitHubIssue
    
    var body: some View {
        HStack {
            /// Using this view to show user avatar in GithubIssueRow and IssueDetailView
            UserAvatarView(avatarUrl: issue.user.avatarUrl)
            
            Spacer()
            /// Show title and user login ini vstackl
            VStack (alignment: .leading)  {
                Text(issue.title ?? "")
                    .font(.headline)
                Text("@" + issue.user.login)
            }
            .padding(.leading, 10)
        }
        .padding(10)
    }
}

#Preview {    
    /// Display only first issue in preview
    let gclient = GitHubClient.shared
    
    if let issue = gclient.openIssues.first {
        return GithubIssueRow(issue: issue)
            .previewLayout(.fixed(width: 400, height: 80))
    } else {
        return Text("Loading first open issue...")
            .previewLayout(.fixed(width: 400, height: 80))
    }
}
