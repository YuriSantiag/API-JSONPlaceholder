//
//  PostViewModel.swift
//  APIIntegrationApp
//
//  Created by Yuri Santiago
//

import Foundation

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var comments: [Comment] = []
    @Published var isLoading: Bool = false

    func fetchPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        self.isLoading = true
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            if let error = error {
                print("Error fetching posts: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decodedPosts = try JSONDecoder().decode([Post].self, from: data)
                DispatchQueue.main.async {
                    self.posts = decodedPosts
                }
            } catch {
                print("Error decoding posts: \(error)")
            }
        }.resume()
    }

    func fetchComments() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments") else { return }
        
        self.isLoading = true
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            if let error = error {
                print("Error fetching comments: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decodedComments = try JSONDecoder().decode([Comment].self, from: data)
                DispatchQueue.main.async {
                    self.comments = decodedComments
                }
            } catch {
                print("Error decoding comments: \(error)")
            }
        }.resume()
    }
}


