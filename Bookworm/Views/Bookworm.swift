//
//  ContentView.swift
//  Bookworm
//
//  Created by Amit Shrivastava on 14/12/21.
//

import SwiftUI
import CoreData

struct Bookworm: View {
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>
    @State private var showAddBook = false
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        NavigationView {
            List {
                ForEach(books) {
                    book in
                    NavigationLink {
                        Text(book.title ?? "unknnown")
                    }
                    
                label: {
                    HStack {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                                            Text(book.title ?? "Unknown Title")
                                                .font(.headline)
                                            Text(book.author ?? "Unknown Author")
                                                .foregroundColor(.secondary)
                                        }
                        
                        
                    }
                }
                }
            }
            
            
            
            
            
            
            
                .navigationTitle("Book Worm")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddBook.toggle()
                }
            label: {
                Label("Add Book", systemImage: "plus")
            }
            }
            
        }
        .sheet(isPresented: $showAddBook, onDismiss: .none) {
            AddBookView()
        }
}
    }
    
}
    

struct Bookworm_Previews: PreviewProvider {
    static var previews: some View {
        Bookworm()
    }
}
