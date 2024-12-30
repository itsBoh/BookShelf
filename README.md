# BookShelf

BookShelf is an iOS application for managing a library of books. It allows users to log in, view available books, borrow books, and manage their accounts. Admin users have additional functionalities to manage the library's inventory.

## Features

- User Authentication (Log In, Sign Up, Log Out)
- View available books
- Borrow books
- Admin functionalities to manage books (Add, Edit, Delete)
- View list of borrowers and their borrowed books

## Project Structure

```
BookShelf/
    Account/
        Model/
        View/
        ViewModel/
    Admin/
        Model/
        View/
        ViewModel/
    Assets.xcassets/
    BookShelfApp.swift
    BooksManagement/
    ContentView.swift
    Library/
    Loans/
    Preview Content/
BookShelf.xcodeproj/
BookShelfTests/
BookShelfUITests/
```

## Getting Started

### Prerequisites

- Xcode 12.0 or later
- Swift 5.3 or later

### Installation

1. Clone the repository:
    ```sh
   git clone https://github.com/yourusername/BookShelf.git
    ```
2. Open the project in Xcode:
    ```sh
    cd BookShelf
    open BookShelf.xcodeproj
    ```
3. Install dependencies using Swift Package Manager.

### Running the App

1. Select the BookShelf target.
2. Choose a simulator or a connected device.
3. Click the Run button or press `Cmd + R`.

## Usage

### User Authentication

- **Log In**: Users can log in using their username and password.
- **Sign Up**: New users can create an account by providing their details.
- **Log Out**: Users can log out from their account.

### Viewing Books

- **Library**: Users can view the list of available books in the library.
- **Loans**: Users can view their borrowed books.

### Admin Functionalities

- **Add Book**: Admin users can add new books to the library.
- **Edit Book**: Admin users can edit the details of existing books.
- **Delete Book**: Admin users can delete books from the library.
- **View Borrowers**: Admin users can view the list of borrowers and their borrowed books.



## License

This project does not currently have a license. All rights reserved.

## Acknowledgements

- [MySQLNIO](https://github.com/vapor/mysql-nio) for MySQL database connectivity.
- [SwiftUI](https://developer.apple.com/xcode/swiftui/) for building the user interface.

---



---
