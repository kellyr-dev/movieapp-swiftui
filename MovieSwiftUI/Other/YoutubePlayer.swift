//
//  YoutubePlayer.swift
//  MovieSwiftUI
//
//  Created by Kelly Ruiz on 8/13/26.
//

import Foundation
import SwiftUI
import WebKit


struct YoutubePlayer: UIViewRepresentable {
    let videoId: String
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        
        return WKWebView(frame: .zero, configuration: configuration)
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoId)") else {
            return
        }
        
        if uiView.url != youtubeURL {
            uiView.load(URLRequest(url: youtubeURL))
        }
    }
    
}
