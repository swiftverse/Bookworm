//
//  AddBookView.swift
//  Bookworm
//
//  Created by Amit Shrivastava on 15/12/21.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var bookTitle = ""
    @State private var rating = 0
    @State private var review = ""
    @State private var authorName = ""
    @State private var genre = ""
   
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var hasValidEntry: Bool {
        if(authorName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || bookTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || genre.isEmpty) {
            return false
        }
        return true
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Author Name", text: $authorName)
                    TextField("Book Title", text: $bookTitle)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id:\.self) { genre in
                            Text(genre)
                            
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
//                    Picker("Rating", selection: $rating) {
//                        ForEach(1 ..< 6) {
//                           Text(String($0))
//                        }
//                    }
                    RatingView(rating: $rating)
                }
            header: {
                Text("Write a review")
            }
                
                Section {
                    Button("Save") {
                        let books = Book(context: moc)
                        books.id = UUID()
                        books.author = authorName
                        books.title = bookTitle
                        books.genre = genre
                        books.rating = Int16(rating)
                        books.review = review
                        books.date = Date.now
                        
                        try? moc.save()
                        dismiss()
                    }
                }
                //here we need to equate it with false value to make it work 
                .disabled(hasValidEntry == false)
            }
            .navigationTitle("Add Book")
        }
       
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
