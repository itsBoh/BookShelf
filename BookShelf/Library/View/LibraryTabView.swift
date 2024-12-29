//
//  LibraryTab.swift
//  BookShelf
//
//  Created by Alvin Lionel on 29/12/24.
//

import SwiftUI

struct LibraryTabView: View {
    @StateObject private var viewModel = LibraryViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.books) { book in
                HStack{
                    if let url = URL(string: book.coverImage ?? "") {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: bookCoverWidth(), height: bookCoverHeight())
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: bookCoverWidth(), height: bookCoverHeight())
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: bookCoverWidth(), height: bookCoverHeight())
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                    
                    VStack(alignment: .leading){
                        Text(book.title)
                            .font(.title2)
                            .frame(maxHeight: UIScreen.main.bounds.height / 10)
                        Text(book.author)
                            .font(.title3)
                        Text("Publisher: \(book.publisher)")
                            .font(.footnote)
                        if let published = book.published {
                            Text("Published: \(String(published))")
                                .font(.footnote)
                        }
                        if let availableCopies = book.availableCopies {
                            Text("Available Copies: \(availableCopies)")
                                .font(.footnote)
                        }
                    }
                    .frame(maxHeight: UIScreen.main.bounds.height / 8)
                    .padding(.leading, 12)
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Library")
            .onAppear {
                viewModel.fetchBooks()
            }
        }
    }
    
    private func bookCoverWidth() -> CGFloat {
        return UIScreen.main.bounds.width / 6
    }
    
    private func bookCoverHeight() -> CGFloat {
        return bookCoverWidth() * 1.25
    }
}
