//
//  BooksManagementView.swift
//  BookShelf
//
//  Created by Alvin Lionel on 29/12/24.
//

import SwiftUI

struct BooksManagementView: View {
    @State var isAddNewBookViewPresented: Bool = false
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack {
                    
                }
            }
            .navigationTitle(Text("Books Management"))
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        isAddNewBookViewPresented.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $isAddNewBookViewPresented){
                AddNewBookView()
            }
        }
    }
}

#Preview {
    BooksManagementView()
}
