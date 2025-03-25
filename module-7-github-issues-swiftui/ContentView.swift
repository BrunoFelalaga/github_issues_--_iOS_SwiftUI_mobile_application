//
//  ContentView.swift
//  module-7-github-issues-swiftui
//
//  Created by Andrew Binkowski on 2/1/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var gitHubIssues: GitHubClient 
    @State private var selectedTab = 0 // var for tab selected. life cycle managed by contentview => @State var
    
    var body: some View {
        // Tab view for gauge, open and closed issues.
        TabView(selection: $selectedTab) { // selected tab for setting icon tint. this uses tags on tab items
            
            GeometryReader { geometry in
                VStack {
                    // Gauge to show count of open issues relative to total issues
                    Gauge(value: Double(gitHubIssues.openIssues.count), in: 0...Double(gitHubIssues.totalIssuesCount)) {
                        Text("Open Issues")
                    } currentValueLabel: {
                        Text("\(gitHubIssues.openIssues.count)")
                    }
                    .gaugeStyle(.accessoryCircularCapacity)
                    .scaleEffect(5.0)
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.6)
                    .padding()
                    
                    Text("Open: \(gitHubIssues.openIssues.count) | Closed: \(gitHubIssues.closedIssues.count)")
                        .font(.system(.headline, design: .rounded, weight: .bold))
                        .padding(.top, 10)
                }
            }
            .tabItem { // Gauge tab item
                Image(systemName: "chart.pie.fill")
                Text("Overview")
            }
            .tag(0) // tag for selected tab

            // Open issues tab view
            IssueTabView(state: "open", issues: gitHubIssues.openIssues)
                .tabItem  {
                    Image(systemName: "envelope.open.fill")
                    Text("OpenIssues")
                        
                }
                .tag(1)
            
            // Closed issues tab view
            IssueTabView(state: "closed", issues: gitHubIssues.closedIssues)
                .tabItem  {
                    Image(systemName: "envelope.badge.fill")
                    Text("ClosedIssues")
                }
                .tag(2)
            
        }
        .tint(selectedTab == 0 // set tabIcon tint to asset color that corresponds to selected tab
              ? Color.blue // Overview color
              : selectedTab == 1
                ? Color("OpenIssuesColor")
                : Color("ClosedIssuesColor"))
        
    }
}


#Preview { // light theme preview
    ContentView(gitHubIssues: GitHubClient.shared)
}

#Preview { // preview for dark theme
    ContentView(gitHubIssues: GitHubClient.shared)
        .environment(\.colorScheme, .dark)
}
