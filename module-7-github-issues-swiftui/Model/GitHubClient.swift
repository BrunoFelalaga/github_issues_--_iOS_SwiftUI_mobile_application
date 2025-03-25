//
//  GithubClient.swift
//  module-7-github-issues-swiftui
//
//  Created by Andrew Binkowski on 2/16/24.
//

import Foundation
import SwiftUI

@MainActor class GitHubClient: ObservableObject { // make client observable so other can get updates happening here

    /// URL of the GitHub API we are tracking issues for
    let url = "https://api.github.com/repos/apache/hadoop-ozone/issues?state=all"
    @Published var openIssues: [GitHubIssue] = [] // Store open issues from fetch
    @Published var closedIssues: [GitHubIssue] = [] // Store closed issues from fetch

    var totalIssuesCount: Int { // total count for gauge in contentview
        return openIssues.count + closedIssues.count
    }
    
    static let shared = GitHubClient() /// Singleton implementation for reuse
    
    // MARK: - Initialization
    fileprivate init() {
        Task {// `Task` allows async task to run in initializer `init()` function

            do {
                try await self.fetchIssues()
            } catch {
                print("Networking Error:", error)
            }
        }
    }
    
    // MARK: - Networking

    // Networking function for getting the issues
    // Debugging prints added
    func fetchIssues() async throws {
        print("Fetching Issues")
        guard let url = URL(string: url) else { // make sure url is valid
            print("Invalid URL")
            fatalError("Missing URL")
        }
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            print("Response received, status: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
            
            // Debugging closure
            if let responseString = String(data: data, encoding: .utf8) {
                print("First 100 chars of response: \(String(responseString.prefix(100)))")
            }
            
            // validate the response status code
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                print("Error status: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                fatalError("Error while fetching data")
            }
            
             // Parse the JSON
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let issues = try decoder.decode([GitHubIssue].self, from: data)
    
            // Split issues and put into appropriate collections
            DispatchQueue.main.async { // Make available on main via dispatch queue
                self.openIssues = issues.filter({ $0.state == "open" })
                self.closedIssues = issues.filter({ $0.state == "closed" })
                print("Processed issues - Open: \(self.openIssues.count), Closed: \(self.closedIssues.count)")
            }
        } catch {
            print("Network error: \(error)")
            throw error
        }
    }
    
    // Custom date formatting -- MMM dd,yyyy
    func formatDate(date: String) -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        if let curdate = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: curdate)
        } else {
            return nil
        }
    }

}
