//
//  EditBookView.swift
//  BookShelf
//
//  Created by Alvin Lionel on 30/12/24.
//

import SwiftUI

import SwiftUI

struct EditBookView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AdminViewModel
    @State var book: Book
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $book.title)
                TextField("Author", text: $book.author)
                
                TextField("Publisher", text: $book.publisher)
                TextField("Published Year", value: $book.published, formatter: NumberFormatter())
                
                TextField("Available Copies", value: $book.availableCopies, formatter: NumberFormatter())
                
                Section(header: Text("Description")){
                    TextField("Description", text: $book.description)
                        .frame(minHeight: 100)
                }
                
                Section(header: Text("URL")){
                    TextField("Cover Image URL", text: $book.coverImage)
                        .frame(minHeight: 100)
                }
                
                Button(action: {
                    viewModel.softDeleteBook(bookId: $book.id)
                    dismiss()
                }) {
                    Text("Delete")
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Edit Book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        viewModel.updateBook(book: book)
                        dismiss()
                    }
                }
            }
        }
    }
}
