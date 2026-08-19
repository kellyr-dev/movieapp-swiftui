//
//  HomeView.swift
//  MovieSwiftUI
//
//  Created by Kelly Ruiz on 8/8/26.
//

import SwiftUI

struct HomeView: View {
    
    var heroTestTitle = Constants.testTitleURL
        
    
    var body: some View {
        
        ScrollView {
            LazyVStack {
                AsyncImage(url: URL(string: heroTestTitle)){ image in
                    image
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(
                                stops: [Gradient.Stop(color: .clear, location: 0.8),
                                        Gradient.Stop(color: .gradient, location: 1)],
                                startPoint: .top,
                                endPoint: .bottom)
                        }
                    
                } placeholder: {
                    ProgressView()
                }
                
                HStack {
                    
                    Button {
                        
                    } label: {
                        Text(Constants.playString)
                            .foregroundColor(.white)
                            .frame(width: 120, height: 40)
                            .bold()
                            .background(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    
                    Button {
                        
                    } label: {
                        Text(Constants.downloadString)
                            .foregroundColor(.white)
                            .frame(width: 120, height: 40)
                            .bold()
                            .background(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    
                }
                
                HorizontalListView(header: Constants.trendingMovieString)
                HorizontalListView(header: Constants.trendingTVString)
                HorizontalListView(header: Constants.topRatedMovieString)
                HorizontalListView(header: Constants.topRatedTVString)
            }
        }
        
    }
}

#Preview {
    HomeView()
}
