//
//  YoutubeResponse.swift
//  MovieSwiftUI
//
//  Created by Kelly Ruiz on 8/13/26.
//

import Foundation


struct YoutubeResponse: Codable {
    let items: [ItemProperties]?
}

struct ItemProperties: Codable {
    let id: IdProperties?
}

struct IdProperties: Codable {
    let videoId: String?
    
}
