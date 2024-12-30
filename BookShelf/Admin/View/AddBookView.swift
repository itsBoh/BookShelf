//
//  AddBookView.swift
//  BookShelf
//
//  Created by Alvin Lionel on 30/12/24.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AdminViewModel
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var description: String = ""
    @State private var publisher: String = ""
    @State private var published: Int = 2023
    @State private var coverImage: String = ""
    @State private var availableCopies: Int = 1
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Author", text: $author)
                Section(header: Text("Description")) {
                    TextEditor(text: $description)
                        .frame(height: UIScreen.main.bounds.height / 10)
                        .multilineTextAlignment(.leading)
                }
                Section(header: Text("Published")) {
                    TextField("Publisher", text: $publisher)
                    Picker("Published Year", selection: $published) {
                        ForEach(1900...2024, id: \.self) { year in
                            Text("\(String(year))").tag(year)
                        }
                    }
                    .pickerStyle(.menu)
                }
                Section(header: Text("Cover Image URL")) {
                    TextEditor(text: $coverImage)
                        .frame(height: UIScreen.main.bounds.height / 10)
                        .multilineTextAlignment(.leading)
                }
                Section(header: Text("Available Copies")) {
                    Picker("Available Copies", selection: $availableCopies) {
                        ForEach(1...100, id: \.self) { count in
                            Text("\(String(count))").tag(count)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .navigationTitle("Add Book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        let newBook = Book(id: "", title: title, author: author, description: description, publisher: publisher, published: published, coverImage: coverImage, availableCopies: availableCopies)
                        viewModel.addBook(book: newBook)
                        dismiss()
                    } label: {
                        Text("Add")
                    }
                }
            }
        }
    }
}
