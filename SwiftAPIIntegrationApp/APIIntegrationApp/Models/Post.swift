//
//  Post.swift
//  APIIntegrationApp
//
//  Created by Yuri Santiago
//

import Foundation

struct Post: Codable, Identifiable {
    let id: Int
    let title: String
    let body: String
}


