//
//  YouTubePlaylistViewModel.swift
//  CAREERCOMPASS2
//
//  Created by gregorikouk.dev on 27/5/25.
//


import Foundation
import Combine

class YouTubePlaylistViewModel: ObservableObject {
    @Published var videos: [YouTubeVideo] = []
    
    private var apiKey = "AIzaSyA2BCfn78SoywQoo4v6u1Ja8mS_Hgv4MnE"
    private var playlistId = "PL4xwp7W7PyJxLlBaIoascwnbJKe3KCgAi"
    
    func fetchVideos() {
        guard let url = URL(string:
          "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=25&playlistId=\(playlistId)&key=\(apiKey)") else {
            return
        }
        
       
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Fetch error: \(error)")
                return
            }
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(YouTubePlaylistResponse.self, from: data)
                DispatchQueue.main.async {
                    self.videos = response.items.map { item in
                        let thumbnailUrl = item.snippet.thumbnails.medium?.url ??
                                           item.snippet.thumbnails.high?.url ??
                                           item.snippet.thumbnails.defaultThumbnail?.url ?? ""
                        return YouTubeVideo(
                            id: item.snippet.resourceId.videoId,
                            title: item.snippet.title,
                            thumbnailUrl: thumbnailUrl
                        )
                    }
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
}

// Απαιτούμενα structs για το JSON

struct YouTubePlaylistResponse: Codable {
    let items: [PlaylistItem]
}

struct PlaylistItem: Codable {
    let snippet: Snippet
}

struct Snippet: Codable {
    let title: String
    let thumbnails: Thumbnails
    let resourceId: ResourceId
}

struct Thumbnails: Codable {
    let medium: Thumbnail?
    let high: Thumbnail?
    let defaultThumbnail: Thumbnail?

    enum CodingKeys: String, CodingKey {
        case medium
        case high
        case defaultThumbnail = "default"
    }
}

struct Thumbnail: Codable {
    let url: String
}

struct ResourceId: Codable {
    let videoId: String
}
