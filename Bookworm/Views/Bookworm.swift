//
//  ContentView.swift
//  Bookworm
//
//  Created by Amit Shrivastava on 14/12/21.
//

import SwiftUI
import CoreData

struct Bookworm: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title), SortDescriptor(\.author)]) var books: FetchedResults<Book>
    @State private var showAddBook = false
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        NavigationView {
            List {
                ForEach(books) {
                    book in
                    NavigationLink {
                            DetailView(book: book)
                        
                    }
                    
                label: {
                    HStack {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            if(book.rating > 1){
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                            } else {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                    .foregroundColor(.red)
                            }
                                           
                                            Text(book.author ?? "Unknown Author")
                                                .foregroundColor(.secondary)
                                        }
                        
                        
                    }
                }
                }
                .onDelete(perform: removeBook)
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
            
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            
        }
        .sheet(isPresented: $showAddBook, onDismiss: .none) {
            AddBookView()
            }
        }
        
    }
    
    func removeBook(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
    
}
    

struct Bookworm_Previews: PreviewProvider {
    static var previews: some View {
        Bookworm()
    }
}
