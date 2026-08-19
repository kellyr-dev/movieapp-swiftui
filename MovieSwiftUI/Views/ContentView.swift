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
                Text(Constants.upcomingString)
            }
            
            Tab(Constants.searchString, systemImage: Constants.serchIconString){
                Text(Constants.searchString)
            }
            
            Tab(Constants.downloadString, systemImage: Constants.downloadIconString){
                Text(Constants.downloadString)
            }
            
        }
    }
}

#Preview {
    ContentView()
}
