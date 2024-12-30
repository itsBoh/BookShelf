//
//  LoansTab.swift
//  BookShelf
//
//  Created by Alvin Lionel on 29/12/24.
//
import Foundation
import SwiftUI

struct LoansTabView: View {
    
    @State var bookSheetView: Bool = false
    
    @State var isLogInPresented: Bool = false
    
    @Binding var user: String
    @Binding var accountUserName: String
    @Binding var sessionKey: String
    
    @StateObject private var viewModel = LoansTabViewModel()
    @State private var selectedBorrower: IdentifiableString?
    
    var body: some View {
        NavigationStack{
            if(accountUserName.isEmpty || user == "book_reader"){
                Button("Log In"){
                    print("log :\(accountUserName)")
                    isLogInPresented.toggle()
                }
            } else {
                Button("Log Out"){
                    logOut()
                }
            }
            
            if user == "Admin" {
                List(viewModel.borrowers) { borrower in
                    Text(borrower.value)
                        .onTapGesture {
                            selectedBorrower = borrower
                        }
                }
                .navigationTitle("Borrowers")
                .onAppear {
                    viewModel.fetchLoans()
                }
                .sheet(item: $selectedBorrower) { borrower in
                    BorrowedBooksView(borrower: borrower.value, userType: $user)
                }
                .onChange(of: viewModel.borrowers){ oldValue, newValue in
                    viewModel.fetchLoans()
                }
            } else if user == "User" {
                List(viewModel.loans) { loan in
                    
                    VStack(alignment: .leading) {
                        Text(loan.bookTitle)
                            .font(.headline)
                        Text("Author: \(loan.bookAuthor)")
                        Text("Due in \(daysUntilDueDate(loan.loanDueDate)) days")
                        
                    }
                }
                .navigationTitle("My Loans")
                .onAppear {
                    print("hei \(accountUserName)")
                    viewModel.fetchLoans(userId: String(accountUserName))
                }
            }
        }
        .sheet(isPresented: $isLogInPresented){
            LogInView(user: $user, accountUserName: $accountUserName, sessionKey: $sessionKey)
        }
    }
    
    func booksCoverWidth() -> CGFloat {
        return UIScreen.main.bounds.width / 3
    }
    
    func booksCoverHeight() -> CGFloat {
        return booksCoverWidth() * 4 / 3
    }
    
    func logOut() {
        user = "book_reader"
        accountUserName = ""
        sessionKey = ""
        viewModel.loans = []
    }
    func daysUntilDueDate(_ dueDate: Date) -> Int {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.day], from: currentDate, to: dueDate)
        return components.day ?? 0
    }
}

struct IdentifiableString: Identifiable, Hashable {
    let id = UUID()
    let value: String
    
    static func == (lhs: IdentifiableString, rhs: IdentifiableString) -> Bool {
        return lhs.value == rhs.value
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}
