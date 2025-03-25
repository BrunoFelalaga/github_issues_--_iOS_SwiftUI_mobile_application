//
//  UserAvatarView.swift
//  module-7-github-issues-swiftui
//
//  Created by Bruno Felalaga  on 2/28/25.
//


import SwiftUI


// Using this view to show user avatar in GithubIssueRow and IssueDetailView
struct UserAvatarView: View {
    let avatarUrl: String?
    let size: CGFloat
    
    init(avatarUrl: String?, size: CGFloat = 40) {
        self.avatarUrl = avatarUrl
        self.size = size
    }
    
    var body: some View {
//        AsyncImage loads remote images asynchronously with built-in loading/error states, avoiding UI freezing during network operations.
        AsyncImage(url: URL(string: avatarUrl ?? "")) { phase in
            switch phase {
            case .empty:
                ProgressView() // Loading state
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size, height: size)
                    .clipShape(Circle()) // Circular crop for avatar
            case .failure:
                Image(systemName: "questionmark.circle") // Fallback for failed loads
                    .resizable()
                    .frame(width: size, height: size)
                    .foregroundColor(Color.red)
            @unknown default: // Handle all other cases
                Image(systemName: "questionmark.circle.fill")
                    .resizable()
                    .frame(width: size, height: size)
                    .foregroundColor(Color.red)
            }
        }
    }
}

#Preview {
    UserAvatarView(avatarUrl: "https://avatars.githubusercontent.com/u/5821159?v=4")
}
