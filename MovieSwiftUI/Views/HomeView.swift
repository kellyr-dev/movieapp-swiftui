//
//  HomeView.swift
//  MovieSwiftUI
//
//  Created by Kelly Ruiz on 8/8/26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    let viewModel = MovieViewModel()
    @State private var titleDetailPath = NavigationPath()
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        
        NavigationStack(path: $titleDetailPath) {
            ScrollView {
                
                switch viewModel.homeStatus {
                case .notStarted:
                    Text("Empty")
                    
                case .fetching:
                    ProgressView()
                    
                case .sucess:
                    LazyVStack {
                        AsyncImage(url: URL(string: viewModel.heroTitle.posterPath ?? "")){ image in
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
                            //.padding(.top, 100)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }                        
                        
                        
                        HStack {
                            
                            Button {
                                titleDetailPath.append(viewModel.heroTitle)
                            } label: {
                                Text(Constants.playString)
                                    .foregroundColor(.white)
                                    .frame(width: 120, height: 40)
                                    .bold()
                                    .background(RoundedRectangle(cornerRadius: 20))
                            }
                            
                            
                            Button {
                                modelContext.insert(viewModel.heroTitle)
                                try? modelContext.save()
                                
                            } label: {
                                Text(Constants.downloadString)
                                    .foregroundColor(.white)
                                    .frame(width: 120, height: 40)
                                    .bold()
                                    .background(RoundedRectangle(cornerRadius: 20))
                            }
                                                        
                        }
                        
                        HorizontalListView(header: Constants.trendingMovieString, titles: viewModel.trendingMovies) { title in
                            titleDetailPath.append(title)
                        }
                        HorizontalListView(header: Constants.trendingTVString, titles: viewModel.trendingTV) { title in
                            titleDetailPath.append(title)
                        }
                        HorizontalListView(header: Constants.topRatedMovieString, titles: viewModel.topRatedMovies){ title in
                            titleDetailPath.append(title)
                        }
                        HorizontalListView(header: Constants.topRatedTVString, titles: viewModel.topRatedTV){ title in
                            titleDetailPath.append(title)
                        }
                    }
                    
                case .failed(let error):
                    Text("Error: \(error.localizedDescription)")
                        .foregroundStyle(.red)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                }
                
            }
            .navigationDestination(for: Title.self) { title in
                DetailView(title: title)
            }
        }
        .task {
            await viewModel.getTitles()
        }
        
        
    }
}

#Preview {
    HomeView()
}
