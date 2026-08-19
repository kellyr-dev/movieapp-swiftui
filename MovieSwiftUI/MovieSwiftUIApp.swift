//
//  MovieSwiftUIApp.swift
//  MovieSwiftUI
//
//  Created by Kelly Ruiz on 8/8/26.
//

import SwiftUI
import SwiftData

@main
struct MovieSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Title.self)
    }
}
