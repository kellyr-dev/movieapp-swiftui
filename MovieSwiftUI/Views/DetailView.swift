//
//  DetailView.swift
//  MovieSwiftUI
//
//  Created by Kelly Ruiz on 8/13/26.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    let title: Title
    
    var titleName: String {
        return (title.name ?? title.title) ?? ""
    }
    
    @State private var viewModel = MovieViewModel()
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack {
            switch viewModel.videoIdStatus {
            case .notStarted, .fetching:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            case .sucess:
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        if let posterPath = title.posterPath,
                           let url = URL(string: posterPath) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                        }
                        
                        Text(titleName)
                            .bold()
                            .font(.title2)
                            .padding()
                        
                        Text(title.overview ?? "")
                            .padding()
                        
                        VStack(alignment: .leading) {
                            Text("Trailer")
                                .bold()
                                .font(.title3)
                                .padding()
                                .padding(.bottom, 5)
                                                        
                            YoutubePlayer(videoId: viewModel.videoId)
                                .aspectRatio(1.3, contentMode: .fit)
                        }
                        
                        HStack {
                            Spacer()
                            Button {
                                let auxTitle = title
                                auxTitle.title = titleName
                                modelContext.insert(auxTitle)
                                try? modelContext.save()
                                dismiss()
                                
                                
                            } label: {
                                Text(Constants.downloadString)
                                    .foregroundColor(.white)
                                    .frame(width: 120, height: 40)
                                    .bold()
                                    .background(RoundedRectangle(cornerRadius: 20))
                            }
                            Spacer()
                        }
                        .padding()
                        
                    }
                }
                
            case .failed(let underlyingError):
                Text(underlyingError.localizedDescription)
                    .foregroundStyle(.red)
                    .padding()
            }
        }
        .task {
            await viewModel.getVideoId(for: titleName)
        }
    }
}

#Preview {
    DetailView(title: Title.previewTitles[0])
}
