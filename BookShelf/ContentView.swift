//
//  ContentView.swift
//  BookShelf
//
//  Created by Alvin Lionel on 29/12/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State var user = UserDefaults.standard.string(forKey: "user") ?? "book_reader"
    @State var password = UserDefaults.standard.string(forKey: "password") ?? "password"
    
    @State var accountUserName = UserDefaults.standard.string(forKey: "accountUserName") ?? ""
    @State var sessionKey = UserDefaults.standard.string(forKey: "sessionKey") ?? ""
    
    var body: some View {
        TabView{
            LibraryTabView(user: $user, accountUserName: $accountUserName, sessionKey: $sessionKey)
                .tabItem {
                    Label("Library", systemImage: "books.vertical")
                }
            
            LoansTabView(user: $user, accountUserName: $accountUserName, sessionKey: $sessionKey)
                .tabItem {
                    Label("Loans", systemImage: "archivebox")
                }
            
            if(user == "Admin"){
                AdminView()
                    .tabItem {
                        Label("Admin", systemImage: "person")
                    }
            }
        }
    }
    
}
