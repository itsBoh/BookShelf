import Foundation
import Combine
import MySQLNIO
import NIO

class LoansTabViewModel: ObservableObject {
    @Published var loans: [LoanModel] = []
    @Published var borrowers: [IdentifiableString] = []
    @Published var errorMessage: IdentifiableError?

    private var cancellables = Set<AnyCancellable>()

    func fetchLoans(userId: String? = nil) {
        
        print(UserDefaults.standard.string(forKey: "userName") ?? "")
        
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        
        do {
            
            var tlsConfiguration = TLSConfiguration.makeClientConfiguration()
            tlsConfiguration.certificateVerification = .none
            
            let connection = try MySQLConnection.connect(
                to: .init(ipAddress: "127.0.0.1", port: 3306),
                username: UserDefaults.standard.string(forKey: "userName") ?? "",
                database: "bookshelf",
                password: UserDefaults.standard.string(forKey: "password") ?? "",
                tlsConfiguration: tlsConfiguration,
                on: eventLoopGroup.next()
            ).wait()
            
            print("notice")
            
            defer {
                try? connection.close().wait()
                try? eventLoopGroup.syncShutdownGracefully()
            }
            
            let query: String
            if let userId = userId {
                query = """
                SELECT loans.loanID, loans.bookID, loans.accountID, accounts.accountUserName, books.bookTitle, books.bookAuthor, books.bookPublisher, books.bookPublished, loans.loanDate, loans.loanDueDate, loans.loanReturnDate
                FROM loans
                JOIN accounts ON loans.accountID = accounts.accountID
                JOIN books ON loans.bookID = books.bookID
                WHERE accounts.accountUserName = '\(userId)'
                """
            } else {
                query = """
                SELECT loans.loanID, loans.bookID, loans.accountID, accounts.accountUserName, books.bookTitle, books.bookAuthor, books.bookPublisher, books.bookPublished, loans.loanDate, loans.loanDueDate, loans.loanReturnDate
                FROM loans
                JOIN accounts ON loans.accountID = accounts.accountID
                JOIN books ON loans.bookID = books.bookID
                WHERE loans.loanReturnDate IS NULL;
                """
            }
            
            print(query)
            let rows = try connection.query(query).wait()
            self.loans = rows.map { row in
                LoanModel(
                    id: row.column("loanID")?.string ?? "",
                    bookId: row.column("bookID")?.string ?? "",
                    userId: row.column("accountID")?.string ?? "",
                    userName: row.column("accountUserName")?.string ?? "",
                    bookTitle: row.column("bookTitle")?.string ?? "",
                    bookAuthor: row.column("bookAuthor")?.string ?? "",
                    bookPublisher: row.column("bookPublisher")?.string ?? "",
                    bookPublished: row.column("bookPublished")?.int ?? 0,
                    loanDate: row.column("loanDate")?.date ?? Date(),
                    loanDueDate: row.column("loanDueDate")?.date ?? Date(),
                    loanReturnDate: row.column("loanReturnDate")?.date
                )
            }
            
            if userId == nil {
                self.borrowers = Array(Set(self.loans.map { IdentifiableString(value: $0.userName) }))
            }
        } catch {
            self.errorMessage = IdentifiableError(message: error.localizedDescription)
        }
    }
    
    func updateLoanStatus(loanId: String, returnDate: Date) {
        print("updateLoanStatus called with loanId: \(loanId) and returnDate: \(returnDate)")
        
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        
        do {
            var tlsConfiguration = TLSConfiguration.makeClientConfiguration()
            tlsConfiguration.certificateVerification = .none
            
            let connection = try MySQLConnection.connect(
                to: .init(ipAddress: "127.0.0.1", port: 3306),
                username: UserDefaults.standard.string(forKey: "userName") ?? "",
                database: "bookshelf",
                password: UserDefaults.standard.string(forKey: "password") ?? "",
                tlsConfiguration: tlsConfiguration,
                on: eventLoopGroup.next()
            ).wait()
            
            defer {
                try? connection.close().wait()
                try? eventLoopGroup.syncShutdownGracefully()
            }
            
            let query = "UPDATE loans SET loanReturnDate = NOW() WHERE loanID = '\(loanId)'"
            print("Executing query: \(query)")
            
            _ = try connection.query(query).wait()
            
            fetchLoans()
            
            print("Query executed successfully")
            
            
            
        } catch {
            print("Error: \(error.localizedDescription)")
            self.errorMessage = IdentifiableError(message: error.localizedDescription)
        }
    }
}
