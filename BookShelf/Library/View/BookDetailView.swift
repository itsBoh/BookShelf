//
//  BookDetailView.swift
//  BookShelf
//
//  Created by Alvin Lionel on 29/12/24.
//

import SwiftUI

struct BookDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: bookWidth(), height: bookHeight())
                    
                    Text("Title")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Author")
                        .font(.title)
                    
                    Text("publisher, year")
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
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                        .font(.body)
                        .padding(.horizontal)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func bookWidth() -> CGFloat {
        return UIScreen.main.bounds.width / 2
    }
    
    func bookHeight() -> CGFloat {
        return bookWidth() * 4 / 3
    }
}

#Preview {
    BookDetailView()
}
