//
//  UpcomingView.swift
//  MovieSwiftUI
//
//  Created by Kelly Ruiz on 8/13/26.
//

import SwiftUI

struct UpcomingView: View {
    
    @State private var viewModel = MovieViewModel()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                switch viewModel.upcomingStatus {
                case .notStarted, .fetching:
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .sucess:
                    VerticalListView(titles: viewModel.upcomingMovies, canDelete: false)
                case .failed(let underlyingError):
                    Text(underlyingError.localizedDescription)
                        .foregroundStyle(.red)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                }
            }.task {
                await viewModel.getUpcomingMovies()
            }
            .navigationTitle("Upcoming Movies")
        }
        
    }
}

#Preview {
    UpcomingView()
}
