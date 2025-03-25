//
//  module_7_github_issues_swiftuiApp.swift
//  module-7-github--swiftui
//
//  Created by Andrew Binkowski on 2/22/22.
//

import SwiftUI

@main
struct module_7_github_issues_swiftuiApp: App {
    // Once instance of GithubClient to be used everywhere, instead of initiated everytime when neeeded
    private var sharedIssues = GitHubClient.shared
    
    // Set custom font to be used in entire app hierarchy, unless overriden
    init() {

        // Set default rounded font for navigation bars
        let roundedBoldTitle = UIFont.systemFont(ofSize: 17, weight: .bold)
        let roundedTitleDescriptor = roundedBoldTitle.fontDescriptor.withDesign(.rounded)!
        let roundedTitleFont = UIFont(descriptor: roundedTitleDescriptor, size: 17)
        
        // Apply rounded font to navigation bar titles
        UINavigationBar.appearance().titleTextAttributes = [.font: roundedTitleFont]
        
        // Apply to large titles
        let largeBold = UIFont.systemFont(ofSize: 34, weight: .bold)
        let largeRoundedDescriptor = largeBold.fontDescriptor.withDesign(.rounded)!
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(descriptor: largeRoundedDescriptor, size: 34)]
        
        // Apply to tab bar items
        let tabFont = UIFont.systemFont(ofSize: 12, weight: .medium)
        let tabRoundedDescriptor = tabFont.fontDescriptor.withDesign(.rounded)!
        UITabBar.appearance().standardAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.font: UIFont(descriptor: tabRoundedDescriptor, size: 12)]
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(gitHubIssues: sharedIssues)
                .environment(\.font, Font.system(size: 16, weight: .medium, design: .rounded)) // Custom environment font, unless overriden
        }
    }
}
