//
//  IssueDetailView.swift
//  module-7-github-issues-swiftui
//
//  Created by Andrew Binkowski on 2/22/22.
//

import SwiftUI
import UIKit

// Detail view of issue shows issue title, user avatar, issue date and body
struct IssueDetailView: View {
    let issue: GitHubIssue
    
    @State private var avatarImage: UIImage?
    
    var body: some View {
        
            VStack (alignment: .leading) {
                Text(issue.title ?? "")
                    .font(.largeTitle)
                HStack { // Hstack for user avatar and login
                    UserAvatarView(avatarUrl: issue.user.avatarUrl)
                    
                    Text("User: ")
                    Text("@" + issue.user.login)
                }
                
                
                HStack { //
                    Text("Date: ")
                        .bold()
                    Text(issue.formattedDate)
                    
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.red)
                        .padding(.bottom, 20)
                }
                
                Text("Description")
                    .font(.largeTitle)
                ScrollView { /// display issue body description in in scrollable form
                    Text(issue.body ?? "No description available")
                }
                
                
            }
            .padding(20)
            /// .toolbar button that shows the safari icon to launch diretly to the issue in Safari
            .toolbar { /// add button so issue can be seen in safari
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if let urlString = issue.htmlUrl, let url = URL(string: urlString) {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Image(systemName: "safari")
                    }
                    
                }
            }
    }
}


#Preview {
    let gitHubClient = GitHubClient.shared.openIssues.first!
    return NavigationStack { /// navstack here so preview has navigation context needed to display the safari button correctly.
        IssueDetailView(issue: gitHubClient)
    }
}
