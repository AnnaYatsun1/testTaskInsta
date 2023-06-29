//
//  Comment.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 28.06.2023.
//

import Foundation

struct Comment: Codable {
    let id: String
    let createdAt: String
    let likes: Int
    let imageUser: String
    let comment: String
}
