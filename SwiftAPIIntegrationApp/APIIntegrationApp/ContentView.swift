//
//  ContentView.swift
//  APIIntegrationApp
//
//  Created by Yuri Santiago
//


import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PostViewModel()
    @Environment(\.colorScheme) var colorScheme
    @State private var isDarkMode: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .navigationTitle("Posts")
                } else {
                    List(viewModel.posts) { post in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(post.title)
                                .font(.headline)
                            Text(post.body)
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            CommentsView(post: post, comments: viewModel.comments)
                        }
                        .padding()
                    }
                    .navigationTitle("Posts & Comments")
                }

                // Theme toggle button
                Button(action: {
                    isDarkMode.toggle()
               
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        if let window = windowScene.windows.first {
                            window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
                        }
                    }
                }) {
                    
                    Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .clipShape(Circle())
                }
                .frame(maxWidth: .infinity, alignment: .trailing) 
                .padding(.trailing)
            }
        }
        .onAppear {
            viewModel.fetchPosts()
            viewModel.fetchComments()
        }
    }
}

struct CommentsView: View {
    var post: Post
    var comments: [Comment]

    var body: some View {
        let postComments = comments.filter { $0.postId == post.id }

        if !postComments.isEmpty {
            Divider()
            Text("Comments:")
                .font(.headline)
                .padding(.top, 5)

            ForEach(postComments) { comment in
                VStack(alignment: .leading) {
                    Text(comment.name)
                        .font(.subheadline)
                        .bold()
                    Text(comment.body)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)
                }
                .padding(.leading, 10)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
