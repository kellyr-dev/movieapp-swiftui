//
//  ContentView.swift
//  MovieSwiftUI
//
//  Created by Kelly Ruiz on 8/8/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            
            Tab(Constants.homeString, systemImage: Constants.homeIconString){
                HomeView()
            }
            
            Tab(Constants.upcomingString, systemImage: Constants.upcomingIconString){
                UpcomingView()
            }
            
            Tab(Constants.searchString, systemImage: Constants.serchIconString){
               SearchView()
            }
            
            Tab(Constants.downloadString, systemImage: Constants.downloadIconString){
                DownloadView()
            }
            
        }
    }
}

#Preview {
    ContentView()
}
