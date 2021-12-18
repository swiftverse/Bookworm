//
//  DetailView.swift
//  Bookworm
//
//  Created by Amit Shrivastava on 17/12/21.
//

import SwiftUI
import CoreData

struct DetailView: View {
    let book: Book
    @State var showDeletePop = false
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()

                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            .alert("Delete the book", isPresented: $showDeletePop) {
                Button("Cancel", role: .cancel) {
                  //  dismiss()
                }
                Button("Yes Delete", role: .destructive) {
                    moc.delete(book)
                    try? moc.save()
                    dismiss()
                }
            }
        message: {
            Text("are you sure?")
        }
            
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)

            Text(book.review ?? "No review")
                .padding()

            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
                .padding()
            
            Text("Date: \(dateFormatFunc(date: book.date ?? Date.now))")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {

                    self.showDeletePop = true
                }
            label: {
                Image(systemName: "trash")
            }
            }
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func dateFormatFunc(date: Date) -> String {
        
        return book.date?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
        
        }
        
    
}

struct DetailView_Previews: PreviewProvider {
 //   static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    @StateObject static var dataController = DataController()
    
    static var previews: some View {
    //    let book = Book(context: moc)
        let book = Book(context: dataController.container.viewContext)

        book.title = "Test Book"
        book.author = "Test Author"
        book.rating = 4
        book.review = "This was good book"
        book.genre = "Fantasy"
//        return NavigationView {
//            DetailView(book: book)
//        }
        
        return NavigationView { DetailView(book: book) }
         //   .environment(\.managedObjectContext, dataController.container.viewContext)
            
    }
}
