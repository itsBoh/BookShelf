//
//  BorrowedBooksView.swift
//  BookShelf
//
//  Created by Alvin Lionel on 30/12/24.
//
import SwiftUI

struct BorrowedBooksView: View {
    let borrower: String
    @StateObject private var viewModel = LoansTabViewModel()
    
    @Binding var userType: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List(viewModel.loans) { loan in
                VStack(alignment: .leading) {
                    Text(loan.bookTitle)
                        .font(.headline)
                    Text("Author: \(loan.bookAuthor)")
                    Text("Publisher: \(loan.bookPublisher)")
                    Text("Published: \(String(loan.bookPublished))")
                    Text("Loan Date: \(loan.loanDate, formatter: dateFormatter)")
                    Text("Due Date: \(loan.loanDueDate, formatter: dateFormatter)")
                    
                    
                    if userType == "Admin" {
                        Button("Mark as Returned") {
                            print("tapped")
                            print("\(loan.id)")
                            viewModel.updateLoanStatus(loanId: loan.id, returnDate: Date())
                            viewModel.fetchLoans()
                            
                            dismiss()
                        }
                        .foregroundColor(.blue)
                    }
                }
                
                
            }
        }
        .navigationTitle("\(borrower)'s Loans")
        .onAppear {
            viewModel.fetchLoans(userId: borrower)
        }
        .onDisappear() {
            viewModel.fetchLoans()
        }
    }
    
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
