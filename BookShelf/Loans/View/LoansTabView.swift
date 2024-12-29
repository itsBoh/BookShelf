//
//  LoansTab.swift
//  BookShelf
//
//  Created by Alvin Lionel on 29/12/24.
//

import SwiftUI

struct LoansTabView: View {
    
    @State var bookSheetView: Bool = false
    
    var body: some View {
        NavigationStack{
            
            List{
                Section(header: HStack {
                    Text("List of Books Loaned")
//                    Spacer()
//                    Button(action: {
//                        print("Filter tapped")
//                    }) {
//                        Image(systemName: "line.horizontal.3.decrease.circle")
//                            .imageScale(.large)
//                    }
                }){
                    ForEach(0..<3){ index in
                        Button{
                            bookSheetView.toggle()
                        } label: {
                            HStack{
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(width: booksCoverWidth() / 2, height: booksCoverHeight() / 2)
                                
                                VStack(alignment: .leading){
                                    Text("Title: Title")
                                        .font(.headline)
                                    Text("Author")
                                        .font(.subheadline)
                                    Text("publisher, year")
                                        .font(.caption)
                                }
                                .foregroundStyle(Color.primary)
                                
                            }
                        }
                    }
                }
                .headerProminence(.increased)
            }
        }
    }
    
    func booksCoverWidth() -> CGFloat {
        return UIScreen.main.bounds.width / 3
    }
    
    func booksCoverHeight() -> CGFloat {
        return booksCoverWidth() * 4 / 3
    }
}

#Preview {
    LoansTabView()
}
