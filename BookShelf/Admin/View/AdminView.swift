//
//  AdminView.swift
//  BookShelf
//
//  Created by Alvin Lionel on 30/12/24.
//

import SwiftUI

struct AdminView: View {
    @StateObject private var viewModel = AdminViewModel()
    @State private var selectedBook: Book?
    
    @State private var isAddBookViewPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.filteredBooks) { book in
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                        Text("Author: \(book.author)")
                    }
                    .frame(height: UIScreen.main.bounds.height / 12)
                    .onTapGesture {
                        selectedBook = book
                    }
                }
            }
            .navigationTitle("Admin View")
            .searchable(text: $viewModel.searchQuery)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isAddBookViewPresented.toggle()
                    }) {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .onChange(of: viewModel.searchQuery){ oldValue, newValue in
                viewModel.filterBooks()
            }
            .onAppear {
                viewModel.fetchBooksAndLoans()
            }
            .alert(item: $viewModel.errorMessage) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
            .sheet(item: $selectedBook) { book in
                EditBookView(viewModel: viewModel, book: book)
            }
            .sheet(isPresented: $isAddBookViewPresented) {
                AddBookView(viewModel: viewModel)
            }
        }
    }
}
