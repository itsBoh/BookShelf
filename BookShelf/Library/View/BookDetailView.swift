//
//  BookDetailView.swift
//  BookShelf
//
//  Created by Alvin Lionel on 29/12/24.
//

import SwiftUI

struct BookDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let book: Book
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack {
                    if let url = URL(string: book.coverImage ?? "") {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: bookWidth(), height: bookHeight())
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: bookWidth(), height: bookHeight())
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: bookWidth(), height: bookHeight())
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .padding(.bottom)
                    }
                    
                    
                    Text(book.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    
                    Text(book.author)
                        .font(.title3)
                    
                    Text("\(book.publisher), \(String(book.published ?? 0))")
                        .font(.caption)
                        .padding(.bottom)
                    
                    Button("Borrow") {}
                        .buttonStyle(.borderedProminent)
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.body)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                        .padding(.horizontal)
                    
                    Text(book.description ?? "No description available.")
                        .font(.caption)
                        .padding(.horizontal)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                }
            }
        }
    }
    
    func bookWidth() -> CGFloat {
        return UIScreen.main.bounds.width / 4
    }
    
    func bookHeight() -> CGFloat {
        return bookWidth() * 4 / 3
    }
}

