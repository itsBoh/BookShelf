//
//  BookDetailView.swift
//  BookShelf
//
//  Created by Alvin Lionel on 29/12/24.
//

import SwiftUI

struct BookDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var defaultsUserName: Bool = (UserDefaults.standard.string(forKey: "userName") == "reader_book" ? false : true)
    @State var emtpyUserName: Bool = (UserDefaults.standard.string(forKey: "userName") == "" ? true : false)
    
    let book: Book
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack {
                    if let url = URL(string: book.coverImage) {
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
                    
                    Text("\(book.publisher), \(String(book.published))")
                        .font(.caption)
                        .padding(.bottom)
                    
                    Button("Borrow") {}
                        .buttonStyle(.borderedProminent)
                        .disabled(defaultsUserName || emtpyUserName || book.availableCopies == 0)
                }
                .padding()
                
                HStack{
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.body)
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        
                        Text(book.description)
                            .font(.caption)
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width)
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
    
    private func checkCanBorrow() {
        
    }
}

