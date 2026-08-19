//
//  VerticalList.swift
//  MovieSwiftUI
//
//  Created by Kelly Ruiz on 8/13/26.
//

import SwiftUI
import SwiftData

struct VerticalListView: View {
    
    var titles: [Title]
    let canDelete: Bool
    @Environment(\.modelContext) var modelContext
    @State private var navPath = NavigationPath()
    
    var body: some View {
        
        NavigationStack(path: $navPath) {
            
            List(titles) { title in
             
                AsyncImage(url: URL(string: title.posterPath ?? "")) { image in
                    
                    HStack {
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 10))
                            .padding(5)
                        
                        Text((title.name ?? title.title) ?? "")
                            .font(.system(size: 14))
                            .bold()
                    }
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 150)
                .swipeActions(edge: .trailing){
                    if canDelete {
                        Button {
                            modelContext.delete(title)
                        }label: {
                            Image(systemName: "trash")
                                .tint(.red)
                        }
                    }
                }
                .onTapGesture {
                    navPath.append(title)
                }
            }
            
            .navigationDestination(for: Title.self) { title in
                DetailView(title: title)
            }
        }
    }
}

#Preview {
    VerticalListView(titles: Title.previewTitles, canDelete: true)
}
