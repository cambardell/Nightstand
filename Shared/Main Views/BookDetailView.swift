//
//  BookDetailView.swift
//  Footnote+
//
//  Created by Cameron Bardell on 2020-12-27.
//

import SwiftUI
import CoreData

struct BookDetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var selectedBook: Book?
    
    @State var title: String
    @State var author: String = "Author"
    @State var status: BookState
    
    var body: some View {


            Form {
                Section {
                    TextField("Title", text: $title)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.title2)


                    TextField("Author", text: $author)
                        .font(.title3)
                        .textFieldStyle(PlainTextFieldStyle())

                    Picker(selection:
                            $status, label: Text(status.stringValue)) {
                        ForEach(BookState.allCases, id: \.rawValue) { type in
                            Text(type.stringValue)
                                .tag(type)
                        }
                    }.pickerStyle(.menu)
                }
                Section(header: Text("Quotes")) {
                    if let book = selectedBook {
                        QuoteListView(bookQuotes: book.quoteArray, book: book)
                    }
                }
                
            }

        }
    
}



struct BookDetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Title"
        book.dateCreated = Date()
        return Group {
            BookDetailView(selectedBook: .constant(book), title: book.title!, status: BookState(rawValue: 0)!)
        }
    }
}


