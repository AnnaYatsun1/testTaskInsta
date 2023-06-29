//
//  Photo.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 27.06.2023.
//

import Foundation


struct Photo: Decodable {
    let id: String
    let createdAt: String
    let likes: Int
    let user: User?
    let urls: URLs?
    
    private enum CodingKeys: String, CodingKey {
        case id, user, urls, likes
        case createdAt = "created_at"
    }
}

struct User: Decodable {
    let id: String
    let username: String
    let portfolioURL: String?
    let totalLikes: Int
    let totalPhotos: Int
    let profileImage: ProfileImage
    
    private enum CodingKeys: String, CodingKey {
        case id, username 
        case portfolioURL = "portfolio_url"
        case profileImage = "profile_image"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
    }
}

struct ProfileImage: Decodable {
    let small: String
    let medium: String
    let large: String
}

struct UserLinks: Codable {
    let selfLink: String
    let html: String
    let photos: String
    let likes: String
    let portfolio: String
    
    private enum CodingKeys: String, CodingKey {
        case selfLink = "self", html, photos, likes, portfolio
    }
}

struct Collection: Decodable {
    let id: Int
    let title: String
    let publishedAt: String
    let lastCollectedAt: String
    let updatedAt: String
    let coverPhoto: String?
    let user: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, publishedAt = "published_at", lastCollectedAt = "last_collected_at", updatedAt = "updated_at", coverPhoto = "cover_photo", user
    }
}

struct URLs: Decodable {
    let raw: String
    let full: String// 'эту
    let regular: String
    let small: String
    let thumb: String
}

struct Links: Decodable {
    let selfLink: String
    let html: String
    let download: String
    let downloadLocation: String
    
    private enum CodingKeys: String, CodingKey {
        case selfLink = "self", html, download, downloadLocation = "download_location"
    }
}

