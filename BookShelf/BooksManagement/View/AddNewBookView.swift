//
//  AddNewBookView.swift
//  BookShelf
//
//  Created by Alvin Lionel on 29/12/24.
//

import SwiftUI

struct AddNewBookView: View {
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var bookDescription: String = ""
    @State private var publisher: String = ""
    @State private var publishedYear: Int = Calendar.current.component(.year, from: Date())
    @State private var bookCoverImageURL: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section (header: Text("Details")) {
                    HStack {
                        Text("Title")
                        Spacer()
                        TextField("Enter book title", text: $title)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Author")
                        Spacer()
                        TextField("Enter book author", text: $author)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Publisher")
                        Spacer()
                        TextField("Enter book publisher", text: $publisher)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    Picker("Select Year Published", selection: $publishedYear) {
                        ForEach(1900...Calendar.current.component(.year, from: Date()), id: \.self) { year in
                            Text(String(year)).tag(year)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .foregroundStyle(.primary)
                }
                
                Section(header: Text("Book description")) {
                    TextEditor(text: $bookDescription)
                        .frame(height: 200)
                }
                
                Section(header: Text("Book Cover URL")){
                    TextField("Enter Book Cover Image URL", text: $bookCoverImageURL)
                }
            }
            .navigationTitle("Add New Book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        print("add button pressed")
                    }
                }
            }
        }
    }
}
//
//#Preview {
//    AddNewBookView()
//}
