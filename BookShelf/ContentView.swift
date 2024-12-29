//
//  ContentView.swift
//  BookShelf
//
//  Created by Alvin Lionel on 29/12/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        TabView{
            LibraryTabView()
                .tabItem {
                    Label("Library", systemImage: "books.vertical")
                }
            
            LoansTabView()
                .tabItem {
                    Label("Loans", systemImage: "bookmark")
                }
        }
    }
    
}

#Preview {
    ContentView()
}
